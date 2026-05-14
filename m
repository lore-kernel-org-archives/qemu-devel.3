Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D015CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa0z-0000pu-Lx; Thu, 14 May 2026 13:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0h-0000of-VF
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:15 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0S-0003nJ-S0
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:37:59 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso6518647fac.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780275; x=1779385075; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=M2+ujcpbmKcSGJFmvLicJYdvtFzkjQ2BojZ6Nls0VDneYXpdaJ/jUl5WlTUu/ogR1s
 fLqh0pP2xrMVbht16O+7FfPkJid898yKA7uiEZJzKEV8Fwn2ll0/nq15CuHgAEPMKN8m
 vaL99sUK3V7yej8YIFt6lqXCSxG1QtqJrnhpKwZ+nrLisC2zceaHMh8gmMxMs1GQ3XnT
 /55PVE+NjmDxp07gy3cO8vvpA1AjFwbMGJAn89mbrgfUDuRdCMJwpQsAx/Y1eFQnnD1M
 RHoB6dpKVxi+mF90I2ixp74BBTnUq5KpBF5HPdTd/1U4Q7w/X83FgLeqd/1peZL4TZyP
 z4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780275; x=1779385075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=GFaOaKEUpAn9KRudd9vHc5rbua8By/q36VAmHRvaYUDmQ3rZlGfcNHFbVKkf8sEoyI
 b4xpkBArwPMWUCW1qkW6ea1GUjKExS19N8V7gzJP7Idbz0S3482XKOvuDpttdUQvf8SH
 wzln8jpZ7J5PktmActOLVqAkThpHVglKvqrHVciRQ/Q6EW5nwoOVh2MMX+UOxqf4wYky
 yKarj26eaUYyA7Q5NwaQ10//iKNi98i8zOsn7EnuZnsFFB5HCR2cmrnxUU3jKKmV1tDf
 8b8vgVJpUDFH0pm7tfn2AJt0sg3yeiMKV9AVjzA/nv39U/UTFR7aMhXe0LfqAmbHR7ca
 /vRA==
X-Gm-Message-State: AOJu0Yxo19ghUJOlXBwcMms3Bt76XQ2Lfw/DOZMSzVy+modcOyoXjm6d
 yzR+7Qud+6/8eFFgKyVFnLo9tAEejYrNGKtqy8/PophcVKilqXUvrP7J
X-Gm-Gg: Acq92OFW0IiUny/daVod8CIMNEe/NjGz0AvLUOoPB6zk9pKgDxpSiu+8CArjFx6TKZT
 yuQGVi+KDt/WdEF0Ol/XTEJySHnmaWnPPoDtvNAoK9FMV3Tzpqy9jTDABlrpD7/OuFGVtjBkfVt
 rzLd5HYq48+Xa06je9loX1gAGSRBTWhlNRfXHEwwxSu/GHw+UEZXL+ott+wtgOz3w2k7y+ArMsk
 RLWh5Wiie6hNdw9+Gih7tKIPOpaDVuD5q5iBlQTsIqscFy3jCKDTw0dsWUPgC+j1ES9oSH44T8T
 RT47Z3V7ybfMt+wv4OvrS2zXUYbPvevAk3Y2C68JN21MXNPgc+fpQK4qBtGNKWme8HQ1QBLPSq6
 YC1SCmacfh3WMcGMPtsMHplAVxYcJ/4frodZGEYNv0pfYWufuzeCMNEPfUjK0pLZui9YTXXC9AI
 PjAGvxycR+UZva4tmRQJ3L8kOXd8ro9g/oMC7g9SnTS7ZrLQhwZ+XGNQLp9Z5fkcgEpG2JFymiC
 TdbeH2VjPv76mkN69osj+9ZY5zG0inCshD8htQHzcxVcRBuRaRc9+fR7haRz2CSq3f7uG6FGJ9j
 3iE=
X-Received: by 2002:a05:6820:829:b0:694:96b2:9947 with SMTP id
 006d021491bc7-69c942d27d0mr319772eaf.13.1778780274667; 
 Thu, 14 May 2026 10:37:54 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:37:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:36:51 -0600
Subject: [PATCH v7 02/35] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-2-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2a.google.com
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


