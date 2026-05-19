Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6976CCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDg-0006hv-LZ; Tue, 19 May 2026 12:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDT-0006cb-1z
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:48 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDM-0000dT-1T
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:46 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-439bdb1d75bso2455115fac.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207757; x=1779812557; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=kMTGlQnh5XzJJxq5Fj6WHcLcmNZfGhhanANk3rmRP+RylSCFltHE8w4CgbOqpZBlw7
 av+FHT0eeUyNdSDya9K+BDAz8vW1U8YZ+ZbaEkI+FmmWWDG59Z0gqtTDRjCjtHJyvBfp
 5yuSMtnbFtO+NToqKm9UaEKobs8TqFguSUM4Ghvc5lHqZkbiCUkWQ22mLF156w5ptIf1
 V37KCprz1CEe4ieHrgsyczJqGOVEjqsr43+0ARLL+h5hH+u9gGBmLpHgsOOZdpcU2ByT
 GctOrSeYvz+odD3o8k5GWNbpk0Q8DJP95UgPR7IZe3sB+0cg5Fax2GsjPXFl2BI1S+N4
 RHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207757; x=1779812557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=lLj6Lfhl3eZ66mUDiAkN4/HU0T13aIm/3gTknm4/DEuLFU37PSInon6dfroEGrVCv0
 TlIaYp1mMtVHQgJGwwC88yo/cWHgvodiVf1i5nyUSDIFQM4G6UofkNeoLzI2pmuMajPg
 e1nk81vgqJfHELGsNLC+UaTxFORhHN3G5NjEIyvBsoane1voEe3sNzj1blW/43pUsa+n
 8MrAGo9/GoWcEarZxJTzm6qFmVzTgvtknSiaTJUKi8XFHuFZJq9wf2rfL+xJChLhapTx
 QDOZnLzmmHABfY5wjttdF+3aq/IIAIPieTtNOkzQbPxQrUlJAwyNajjc1OppAU6hwx21
 ln2w==
X-Gm-Message-State: AOJu0YycOzO0dewbWpa7vwHs3pJN0Ik9O2ygWJRuIfgc9TlsfFLCxgTb
 HGTpGC7cWfdBvwKKwzvj7ozWYCbpLbKLR8wRzs7rmW2oJvsVfc1yzyBK
X-Gm-Gg: Acq92OHIqfKP05ZI2bZ9g9uPmjaTuQKvtv6/5WlQzVD2e0LslwBrBD9KanOGVnIDAxR
 +cILU91Pgpwx6RicOL95LNHm2yC33xBA3OtWpiFObEzMZb8cUb7HTeh7EnRc8YdeWGeFAg6jdj2
 BY6PlXriqEfS6UMZ/0BzM5L5wEIUkrmfcpiBXMIq6foQZXyU4/MmqaJW9La6bapW1U++rOlHUuF
 gmRl0/BnA/s9ppyiSYQkAM9gjhXv2OgjzoYYk1aQTq9tv0R/YG9ZsZnfPcJHlLkA3GQjBy/VWwR
 4sQaaQzDQtxCIJb2ShwRfShzjVd5vXFPkN8eH8s/zArZMb2H6xMPcn2nqy1iN/26f/0xaA2+QVo
 ZAehQUM29r7nJZZ3xjHn/+B92DVtkW0MDrLp+MUxTPM7GuBk0a55S3gQy1gG+CfvaWEznnL+sjU
 8rQGYKaCDbXfr6sLIIWtwsVpT+mheT4V5E1qbO7/XGTYJZ8IXLPY2BSAOJMdVpL5BV+vwteIXSs
 62SM7kCOCSbCeOMHbScsq9WJb7st3IY8oadPy3wm70AjyhBTJ9fb3cHEC/tn6LG/Pt2
X-Received: by 2002:a05:687c:408c:b0:42c:1e4a:8e28 with SMTP id
 586e51a60fabf-43a2da2a5e5mr13510313fac.12.1779207756866; 
 Tue, 19 May 2026 09:22:36 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:04 -0600
Subject: [PATCH v9 02/40] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-2-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x32.google.com
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


