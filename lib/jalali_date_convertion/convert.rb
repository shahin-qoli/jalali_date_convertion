module JalaliDateConvertion
    def gregorian_to_jalali(gy, gm, gd)
        g_d_m = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
        (gm > 2) ? gy2 = gy + 1 : gy2 = gy
        days = 355666 + (365 * gy) + Integer((gy2 + 3) / 4) - Integer((gy2 + 99) / 100) + Integer((gy2 + 399) / 400) + gd + g_d_m[gm - 1]
        jy = -1595 + (33 * Integer(days / 12053))
        days %= 12053
        jy += 4 * Integer(days / 1461)
        days %= 1461
        if days > 365
          jy += Integer((days - 1) / 365)
          days = (days - 1) % 365
        end
        if days < 186
          jm = 1 + Integer(days / 31)
          jd = 1 + (days % 31)
        else
          jm = 7 + Integer((days - 186) / 30)
          jd = 1 + ((days - 186) % 30)
        end
        [jy, jm, jd]
    end
     
     
     # @param [Integer] jy
     # @param [Integer] jm
     # @param [Integer] jd
     # @return [Array Integer] [gy,gm,gd]
    def jalali_to_gregorian(jy, jm, jd)
        jy += 1595
        days = -355668 + (365 * jy) + (Integer(jy / 33) * 8) + Integer(((jy % 33) + 3) / 4) + jd + ((jm < 7) ? (jm - 1) * 31 : ((jm - 7) * 30) + 186)
        gy = 400 * Integer(days / 146097)
        days %= 146097
        if days > 36524
          days -= 1
          gy += 100 * Integer(days / 36524)
          days %= 36524
          days += 1 if days >= 365
        end
        gy += 4 * Integer(days / 1461)
        days %= 1461
        if days > 365
          gy += Integer((days - 1) / 365)
          days = (days - 1) % 365
        end
        gd = days + 1
        sal_a = [0, 31, ((gy % 4 == 0 and gy % 100 != 0) or (gy % 400 == 0)) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        gm = 0
        while gm < 13 and gd > sal_a[gm]
          gd -= sal_a[gm]
          gm += 1
        end
        [gy, gm, gd]
    end
end