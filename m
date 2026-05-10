Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5165CD37B5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwZ-0004vA-Py; Sun, 10 May 2026 16:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwX-0004rC-OG
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:05 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwW-0003ps-5g
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:05 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-479d9b155deso1272093b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445603; x=1779050403; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=Qfsf3d64yarLaFBW4cnH4RzSNHxAD+rvuy505NWlv1EPiFuXcufGtXskkg6vYtpgs7
 k1hl7KAbM4jYPQ1Zt5wO9AUGn+UobGtB3uBU9bGl9eA3NXMj+p0hAibsXWeBHioBZ4l4
 RqAQidscf04P6bwt5fn+acJsJ79tZlKnZerfBtipQ3e1tBBSwilFvP2WO9pbYdEpLMyd
 1KlZy1eiaXGq6y6Y4qaHTb1eIo35H824ZMQJ8icj2oTw0FmW0IlMi6RUMCj6yU+HuthD
 CjKTUo20KvnYNnux/K9qtCrZp0E5NE6+tGw63ezMpvpfNYHXxcwEyD4hwSQ7hm0SLeOo
 CPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445603; x=1779050403;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=rvGcaPXgvuJqJC4qS01tN+pT6ZziI7pULT1QKEXC5RXW2o8NYKdcyNXSZNLTjoxJK7
 U5dlBZFL/OAGRHvquy+QjihZiRedb8NIIZfxyhd4GwxLX6hn8dzKDhFNqyCz1jRb7tSk
 4UAyTF9ou4cUsXxD170DHrSpb5J/xWTM37AB2GfG4qtvjNVyAYJFpOKzR48/2K3xfgIL
 7qiR+lntFWGFR92FvO8QCtfgOSdtDrEqA0ssTBHCQ8gowGNQqybrZDUFMD0UQqwwyawW
 rn1aBUASExCjKwR4W8Rjf9X4CpK3cDnvFcuUlaFYcoVbWrfYYBMYnHom9S3Hum08GXtH
 e/RA==
X-Gm-Message-State: AOJu0YyLJ6qzPt2QOIeTI+rjLTISZv0gCgxrl9Sxy/PmDAZKVjukAJG3
 SDM6TbrlOu95OJlK7UthyrCRdqOsyIIuaJ8hHT6GGNzhcsBz6ghDhq/7
X-Gm-Gg: Acq92OHjRNZxSTKF22EfW4bQopUOlY5tIvPW5VnNM9yecrsVjdR6yybVwVvN3MksA6n
 GAVM7gU0xercH01Icop97mr89iK0Xdjz7XKgn/+C8U5xJHPB1enykIPWQLdZRUgv3Njs5yAWuRR
 iLzORVFA+pFwovuru9/hLhVc0psL5uW+ghReTZuJmcWN7eUC2ge4l37LObjHlJ9KN/IQtjwQc9E
 ummXxo8DjD4zJIa0SdxXJz+Vv6Be7Y54D7DH51QKp5X/VU9ejqocdOeI0UL5pFlRsj/1uk0DQ83
 pvFkfvuEt9NC1M2Q6OtyAC5uS459MERMxCKavnfnnTRLMZisTsS3lRfNP58AI5F3YV28Ww9i1Dc
 KoC0zPl4RYkdvtPGJAI23lUU0mUWXeUXWuq4bdztWkhwuit75YCf1gcD/htSvlt9vSs/Tai9ORG
 m6WO5I4MFiENtcsVtm5dMQVjjDOwBRHeE9ZkGHwmDDX/rB4Z8MdYCN1YP6l1jMOl7/MvR1fqtHS
 O1W1rEKn2ghyNAoP6zgGaLlsWdzyXh526pE7jLezg0=
X-Received: by 2002:a05:6808:222a:b0:467:26e4:728f with SMTP id
 5614622812f47-48042218ecbmr11854773b6e.12.1778445603005; 
 Sun, 10 May 2026 13:40:03 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:32 -0600
Subject: [PATCH v5 02/32] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-2-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement the MIPS_ATOMIC_SET sysmips command as an aligned 32-bit atomic
exchange in target memory.

MIPS reports syscall errors through a separate register, so successful old
values can overlap the errno range.  Write the return value and error flag
directly and return -QEMU_ESIGRETURN so the common syscall path leaves the
registers unchanged.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MIPS_ATOMIC_SET out of the combined sysmips/MIPS_FIXADE patch.
    (suggested by Richard Henderson)
  - Always use the explicit MIPS return-register path for successful
    atomic_set results.  (suggested by Richard Henderson)
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 3f36c1695a..9206694f4f 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 20ea7c6ab9..e07687f8ac 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 73f09bb775..3786a34041 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6631,10 +6631,41 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
 }
 
 #ifdef TARGET_NR_sysmips
+static abi_long do_sysmips_atomic_set(CPUArchState *env, abi_ulong addr,
+                                      abi_long value)
+{
+    uint32_t *ptr;
+    abi_long old;
+
+    if (addr & 3) {
+        return -TARGET_EINVAL;
+    }
+
+    ptr = lock_user(VERIFY_WRITE, addr, sizeof(*ptr), true);
+    if (!ptr) {
+        return -TARGET_EINVAL;
+    }
+
+    old = tswap32(qatomic_xchg(ptr, tswap32((uint32_t)value)));
+    unlock_user(ptr, addr, sizeof(*ptr));
+
+    /*
+     * MIPS uses a separate error flag, but the common linux-user syscall
+     * path infers that flag from the return value.  Successful atomic_set
+     * results can overlap the target errno range, so write the result
+     * registers here and ask the CPU loop to leave them alone.
+     */
+    env->active_tc.gpr[2] = old;
+    env->active_tc.gpr[7] = 0;
+    return -QEMU_ESIGRETURN;
+}
+
 static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
                            abi_long arg2)
 {
     switch (cmd) {
+    case TARGET_SYSMIPS_ATOMIC_SET:
+        return do_sysmips_atomic_set(env, arg1, arg2);
     case TARGET_SYSMIPS_FLUSH_CACHE:
         return 0;
     default:

-- 
2.54.0


