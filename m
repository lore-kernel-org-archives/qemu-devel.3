Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF0CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtg7-000666-3t; Sat, 09 May 2026 22:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg5-00065V-17
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:57 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg3-0002uY-D0
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:56 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dcd89701acso2951572a34.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379232; x=1778984032; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=nU2Hs1Xsa4U6BRqtpRAfQQbs0a7rs84jYsMDbJk6EKIw6sSE92ucIFS5r5dPtybsXp
 7BZn/S0yQ93LOLI+1V0dCj6V5iS54pAJ34K1KF1zt3dAsqDJtddk2J+dru1YK19TGtzO
 NMH1xZ6/Rp8bpQwGzmpRrP5YbWfNfOOprHQ2iN97XjwckJOu7RXeXZbhUp603EkcYB/H
 w2bWPUue2dwexNfDVKeidVkSTsSHI4WnAJBg+d/0998bkucg54f65zS6CoF4153H4TC2
 dMySQPze8/5pcJ5wt/tlW9F/1IUewPSAqSSyfiFiN483qf9dKD03vCRq5a3f7uKD2VbF
 PkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379232; x=1778984032;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=l/hbPik9q5qYOkJyBiOoB6fMPFJSDffQW77rfTf3IzY6QGkIn02uQGeESYuxjF+tmg
 6OzLMWh/xma+7/P3cFy6tY31yQoeJSFVoPr68//AVNbUWMwZwo0mS/uWLcEnqnizFgYG
 y+XmwKfN8G8MLfd0jjJapLE2oDqPOTmNW4xuRTNRB4BeUrOkk4Lgxr5LknlzMx1D7lkk
 fKIGzWWGYYi6Pjxco3+uf/YaVbtvMOpKAK6Otim+7aTXywk018qtFQE+emU5GVgCyoEm
 sq1carGFQwWQXcu2RbtQnbxv3L5BnEs+3S84Q7FLKxKIv0DG2ZteZ8FFJknq6tcbTweq
 cW7w==
X-Gm-Message-State: AOJu0Yxh05/wF1w5j1gEc+DpxqQ0zZ8oWcM078tvvXOg7z9na4Y5Xtsi
 LMh/Z0T0uFhu5XXrXvMxtLq4zkeUFQMvihRYPerk1X5nNbF6qdnPqdFlGKuX/usb
X-Gm-Gg: Acq92OH59CMlJDFTnLYIb1Jd0l7Uvfb4vM3wpwiQDXRb6KUFrPP3huWtflimbpWHhbY
 3+V7Kc1BxJK2MGEgcYZwgqunxvsbeGmQQvuuXH5CspwA4G8pfa8BKnKAFXfYr2UZ3wumX68OgQS
 mcg0JbVg7uJJDOKB3gzUSG2l7JJIkptAF89dGj5JBmHq7iC9UIu/Ge/A0n3JxRCf3/6qacPB4rg
 QZSVUfegUwQZyvLnz0sE81vF3HTiOtutWJfhoQhskRkzcCcahEws01Ippz0dFaBSRQeM2wtjpGO
 qUfEWeFrwi14DJQlGzXss8t1p5oQcar8zvjJoxRxRfBvUOM4Lec+GW6Z0xrJtcjhuoR95AuSdKL
 pIyDlNSK6EOxcza9xrZH+odJVeRTXguS3wMzlBHLkD3pLLM4rnzbr6Cv8VfVAz2dKezJsMI93fC
 aO9GQ8TEPjA5prTtzslO6bGkzBo1DiY0LVqevyNj8UoLtBZH2qO0xRKHpNpO1FDJbIAWDxilwhH
 pTwjN7FJFEi6yHBeLTHubOQ9nLoE1hu5A1o28jOTFlnaIev0Bl3d4IPzGonOrYREPpa
X-Received: by 2002:a05:6820:1898:b0:696:8b09:6c99 with SMTP id
 006d021491bc7-69998c8f43dmr11165164eaf.5.1778379231744; 
 Sat, 09 May 2026 19:13:51 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:13:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:25 -0600
Subject: [PATCH v4 02/32] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-2-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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


