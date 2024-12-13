Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3786E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xo-0007zF-9h; Fri, 13 Dec 2024 12:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wr-0006s8-Lk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wo-0001Rj-VZ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:40 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso20454645e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111155; x=1734715955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NYjZ2eKKmjmDMASfvcBpHWyNreYgkDcdayCJjG42kxI=;
 b=t2ZbE9TmK0jT7zAn8oMiDmypB0ocWT273SwHxHsazlPRrY6z02LAls4VpLazRg22oG
 h33c9EUkJRNbxM+7Eb3XVN73n4Hql+8rvOSi6hA5oxHj/zE7lAT7nPYOYBL6Kr+qfKO/
 GPEgi5RPhllaxkGwpsQkoUn+kOd8qMB0qKyvQFRs5YJMnkataoULREN1TAtlBqImsueE
 8RgcxhWKqSwb6T0GC7kCxnBqeOyFC/RkGAPhGHDh/KUjt/SuiXaGgnJAcSd+BsP+EXkx
 FWILuMP8QIaVPvCgxhcsTtkPU0epCQ5mygFdxqqZsCphX8wCFisknYilJuGkjFJCcdjN
 RFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111155; x=1734715955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYjZ2eKKmjmDMASfvcBpHWyNreYgkDcdayCJjG42kxI=;
 b=S8aos3505x7pjXZvTbJIa5hp/M+wPn2+bHO1Ks2Yglv2lCCNaiRnYGRA6GtcgJviWK
 9/1BTHUsBvybulVtB5gEw/6bzBfO7+F2wWFEOWHI9R5aigAunsr9n0Lm5fTA/Rl0wE0L
 7oAH1EqexPBLlean523p+qXsEBO0WG/nwtiL2SyW2YY6iNxFWRUgJxD+3mOyHSxIVMLN
 onKuvXFTHec940cJEY+Z62H523DVQ9HbZ4L2SimfN3R0V1/DfkoL38B8W+3TteefGmAI
 AXJMBTCuUUxI2zzDkAhSJgiAXRcfryZcnQGbKJXEQgOJ0mnHMAcO1tWMh+6nLxYALtny
 4PMA==
X-Gm-Message-State: AOJu0YwtEdvId7GmJrr/CE2n60XycGZ13JSl8gmSjoP01wnaLBXZZrZi
 qQWRMU1z+cDKhHCKcUjJBNy8LAQG9b3+kDbF9GhuBVIaSy3mSeOh9ps9qqcGldoWQ/853JuuEkG
 P
X-Gm-Gg: ASbGnct9jt4dRrzRtbS62KsedtjIzoltS0EGh6lspqV9vn/Kp8xUkOCxBjB0mGd7mz+
 Yp9JFRetINx0zT8UfsK6fm7fkK6VE0e7KVCLO4QHtNYVHyuw2dP70Img7pu6GDYMY7jX4qHbWlg
 snYo7+xYsOdRuDKRLLxEgSRUuXV1ohydOb3Kl+5oU+D2jFCQ5eZtK3PdMq70uh9tK+wk0zHQSYZ
 +lMUNzU//klEo7Ikk7oSDAxFzc3hZ6m0CkRbZ8oWgtxmk3GqTZqT++FF5NElg==
X-Google-Smtp-Source: AGHT+IHNX/ydjDppPkZjxt9sGiG4pLxheMMHSYoTgZfsMXW6J9YmK4jEo3F9TuRobUbGX3NKlvip9w==
X-Received: by 2002:a05:6000:4b12:b0:385:fc70:7eb with SMTP id
 ffacd0b85a97d-38880ac252bmr3099003f8f.12.1734111155303; 
 Fri, 13 Dec 2024 09:32:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/85] target/arm: Convert LSLV, LSRV, ASRV, RORV to decodetree
Date: Fri, 13 Dec 2024 17:31:07 +0000
Message-Id: <20241213173229.3308926-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 +++
 target/arm/tcg/translate-a64.c | 46 ++++++++++++++++------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c218f6afbcc..3db55b78a65 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -658,6 +658,10 @@ CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 
 UDIV            . 00 11010110 ..... 00001 0 ..... ..... @rrr_sf
 SDIV            . 00 11010110 ..... 00001 1 ..... ..... @rrr_sf
+LSLV            . 00 11010110 ..... 00100 0 ..... ..... @rrr_sf
+LSRV            . 00 11010110 ..... 00100 1 ..... ..... @rrr_sf
+ASRV            . 00 11010110 ..... 00101 0 ..... ..... @rrr_sf
+RORV            . 00 11010110 ..... 00101 1 ..... ..... @rrr_sf
 
 # Data Processing (1-source)
 # Logical (shifted reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9f687ba840a..8b7ca2c68ad 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7575,6 +7575,23 @@ static void shift_reg_imm(TCGv_i64 dst, TCGv_i64 src, int sf,
     }
 }
 
+static bool do_shift_reg(DisasContext *s, arg_rrr_sf *a,
+                         enum a64_shift_type shift_type)
+{
+    TCGv_i64 tcg_shift = tcg_temp_new_i64();
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_rn = read_cpu_reg(s, a->rn, a->sf);
+
+    tcg_gen_andi_i64(tcg_shift, cpu_reg(s, a->rm), a->sf ? 63 : 31);
+    shift_reg(tcg_rd, tcg_rn, a->sf, shift_type, tcg_shift);
+    return true;
+}
+
+TRANS(LSLV, do_shift_reg, a, A64_SHIFT_TYPE_LSL)
+TRANS(LSRV, do_shift_reg, a, A64_SHIFT_TYPE_LSR)
+TRANS(ASRV, do_shift_reg, a, A64_SHIFT_TYPE_ASR)
+TRANS(RORV, do_shift_reg, a, A64_SHIFT_TYPE_ROR)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8456,19 +8473,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 }
 
 
-/* LSLV, LSRV, ASRV, RORV */
-static void handle_shift_reg(DisasContext *s,
-                             enum a64_shift_type shift_type, unsigned int sf,
-                             unsigned int rm, unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_shift = tcg_temp_new_i64();
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
-
-    tcg_gen_andi_i64(tcg_shift, cpu_reg(s, rm), sf ? 63 : 31);
-    shift_reg(tcg_rd, tcg_rn, sf, shift_type, tcg_shift);
-}
-
 /* CRC32[BHWX], CRC32C[BHWX] */
 static void handle_crc32(DisasContext *s,
                          unsigned int sf, unsigned int sz, bool crc32c,
@@ -8579,18 +8583,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
             tcg_gen_or_i64(cpu_reg(s, rd), cpu_reg(s, rm), t);
         }
         break;
-    case 8: /* LSLV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
-        break;
-    case 9: /* LSRV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_LSR, sf, rm, rn, rd);
-        break;
-    case 10: /* ASRV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_ASR, sf, rm, rn, rd);
-        break;
-    case 11: /* RORV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_ROR, sf, rm, rn, rd);
-        break;
     case 12: /* PACGA */
         if (sf == 0 || !dc_isar_feature(aa64_pauth, s)) {
             goto do_unallocated;
@@ -8616,6 +8608,10 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     do_unallocated:
     case 2: /* UDIV */
     case 3: /* SDIV */
+    case 8: /* LSLV */
+    case 9: /* LSRV */
+    case 10: /* ASRV */
+    case 11: /* RORV */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


