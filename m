Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A400E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9cy-0007G7-MZ; Thu, 19 Feb 2026 14:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cF-000410-9m
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:11 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cA-0008Op-HK
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-480706554beso14648385e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528984; x=1772133784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k52l1iuTyjEZQshbfB9VEBDKVYNj2bKYlVKvVpKBO0Q=;
 b=MZu3eg1aogj95bE/c9ykYXBhIaN3E/9zecepqAFYT5Ll4blNtCDHGZG/zXK6dmXEur
 Y0NfTFCDsuJiI4DAEU/9oDvFDr7OllZRWK3Qd4jCESM5kGB6O85NvNyEZgBYGNOJfstC
 hP3C8wWs9jljj0PwaaZKg6h65qJJ8E19UvK3bmghQn8LVPj31ozpP/Kfun5ybre4CkpV
 kaeOMHy/SlVtUXYBqL6iWM/hhu0CimVYEO5Z1qOmnvMJ6kHfLgoxSCXbx/tBZ07p34fz
 QXZ5Igo3T4fTlH5KDmseb7jZDHV04E8y9ZlgyCOaDIV5pzki3k/eYzL72vO2T7B+6CBA
 aMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528984; x=1772133784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k52l1iuTyjEZQshbfB9VEBDKVYNj2bKYlVKvVpKBO0Q=;
 b=vfjKTPaVxM7A6Pa1kTNSSWCANY89ri1IaUwON0llbMKUJRqlOsxxZBEJHNMfLm6FGY
 htHEd35LBvAj+9PnXxuXv5R87/aEBg/UvOqDFQ3sdYRvGOlo/iiH1k6CV2fBweTeuAiK
 memeNe5T+sokBWXpz0X8mBj1jwNua6gkVKgUHrpG6hlE7N0cYbmUojciZX0Mh6/zoLc2
 HPipXccLILgD3tAlWkHMsZOOgoSvWeFDXy74jZPS2WP2t2k626j712Ts7RBFHXGfvSSQ
 +AI6lGXlMMhPwmooKnVZQEOiK5lDy+7zNVwOwaz4faPwMy0qzarZsOxcD0apFH8ojnRd
 M/7g==
X-Gm-Message-State: AOJu0Yw4c33ufkdqY6UBrXJ2eQkXcF0D1sHfwc8Jj/VNBgko/ZrjDQrx
 WAS6eUnsjPZNGkL9HO8sN5uvuCwO1rf6TK17qm7t1XWOgM857tf5SrToHDodeuuQ9xt/4qSeGhP
 8fbLa9sK09g==
X-Gm-Gg: AZuq6aILRcwRdf4g36yvYsqNweqDHtQzYMdzXN2tXlwD3rhyEB/+U6noh8VwsIerxvs
 ikPVOuVtdwvZ3rjdVML+Q6u1ow0H+FokWLZU4eYQwGiehOl7QSsH0BsHg8ClSV8AOQL0w0lj8Q8
 vONydDUN+8hPACsgMyEH4FpwSFolzNJWi/JO55wQqCYpI70Z9iKLxe6FgidqfCRdKucu87Lmaqs
 YGxO13GY3Je6lk848tvUX4sUqn3Yyv0P/+GU10MWdoPJN//wfqHc38KmH/yoZDFBybpSnosr6wD
 6YQk6mDJbnFsDs6uVDNmzgvVhXffDhwBDRfS89G5cWoFi4rJSwY1FXiEwIYuLDNVDC1aZC6bJi0
 HAxFyBpcdqUUkShkP+85+124AdJAYj3Tu+g9XJDC7LW69wIzoK1HVsAaMAU+NqEWpfTTEsmqVJa
 8HgywQTexjaYeJ7WYHCYbpt4GANO9jfiQQHTnksNsdd6YhKrXUcPP6mI1SPRwJ4BT3ambA3l6x
X-Received: by 2002:a05:600c:3483:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-48379c0fa40mr359362005e9.35.1771528983940; 
 Thu, 19 Feb 2026 11:23:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31ba9easm19580215e9.4.2026.02.19.11.23.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:23:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v2 26/50] target/mips: Replace ldtul_p() -> ldn_p()
Date: Thu, 19 Feb 2026 20:19:28 +0100
Message-ID: <20260219191955.83815-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prefer ldn_p(target_long_bits/8) over target-specific ldtul_p().

Use deposit64() in gdb_write_register(), allowing to remove
'target_ulong' type uses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/gdbstub.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 169d47416a6..8e0b08a096c 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "cpu.h"
 #include "internal.h"
 #include "gdbstub/helpers.h"
@@ -77,14 +78,15 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    const unsigned regsz = target_long_bits() / 8;
     CPUMIPSState *env = cpu_env(cs);
-    target_ulong tmp;
+    uint64_t tmp;
 
-    tmp = ldtul_p(mem_buf);
+    tmp = ldn_p(mem_buf, regsz);
 
     if (n < 32) {
         env->active_tc.gpr[n] = tmp;
-        return sizeof(target_ulong);
+        return regsz;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP) && n >= 38 && n < 72) {
         switch (n) {
@@ -104,7 +106,7 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             }
             break;
         }
-        return sizeof(target_ulong);
+        return regsz;
     }
     switch (n) {
     case 32:
@@ -127,7 +129,7 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #endif
         break;
     case 37:
-        env->active_tc.PC = tmp & ~(target_ulong)1;
+        env->active_tc.PC = deposit64(tmp, 63, 1, 0);
         if (tmp & 1) {
             env->hflags |= MIPS_HFLAG_M16;
         } else {
@@ -144,5 +146,5 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         break;
     }
 
-    return sizeof(target_ulong);
+    return regsz;
 }
-- 
2.52.0


