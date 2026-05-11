Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79EFCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHT-0004i4-T3; Mon, 11 May 2026 14:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHO-0004gl-69
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:58 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHL-0002fH-Ks
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:56 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso3854735a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523772; x=1779128572; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=LOpswAWheLxSQlCveCN1xCfeoWRsZuPAc3M31h9D7wF34g4blrKvDmgM3tbsZWYaLL
 pNU45Q07bv+VV1L9qsI/0Y4BsttBDrax5DbcKM1jdaZYIpUYrTHCNh1pBdxWqg1aLC4K
 mZFql4xohhKATijpPRdsfR3eDi5LdUZBGdT/kP52XwgoyQSraWXrdEFXymEMNtixYv/Z
 bXwa4N8ZKel+6QccFPGOAkfWGK8tXOkm6nlyieDSIdB0oCk/QgW2sHrkiohxGzrZaX0I
 gh5cIMgbHP6QOtPDEnl8/zX0luSoE6gZXjsBJWxzzlEA5oa11OtvMzTWG20zkECXxCGn
 aETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523772; x=1779128572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=nbuzGc9jhE3POj3QUZfHAcuiiWQAIOiSVu8WkR2dCn2ACLrHoZaNUjecEjKf6qazdg
 623FpVCpgy98kxRbzQMH1jnqxyFY1ReRXliPTzmbB76ppoB280ECTDUqk3WrHq6sT7nm
 4MJ1UZpk8hTjwFwMYvgM5uv41cY8vJ6YGEY9A5gygrq3dGbG2/Kqlu6FEf9Q3YOfrW8q
 3dRsTkl3zXEKJlJcMymqCHh7xxMSWbxnwqjJJLQUKzD0/6UwkNuI4JixGT+pm+dIkMQT
 49duiLGrYVheAE4Id4+aN74pxMnr+tTJkJJTjTb5janQBMlGLwQiJ098MKSiZDS1esld
 6YZQ==
X-Gm-Message-State: AOJu0Yz6c+UQiKdHPSB8SQOdRtlP+IeRHF7qgnL6V4zAny7whIk8iDxU
 0h8QlEwlc5330BIYSAhbP6OsG6tQoT/w5s1g480PM/4SYMlQ6i04hOeB
X-Gm-Gg: Acq92OHfUhlXvH6YQ5UVdmWa0mU+Tt3uNIBBD5v5u3i2eU0uj5Jn2jw9pSAIy2j761N
 lEFYvJ/0PuVCYtEY0vgoMMAvBrqzih94xUYq52wRgqMx9fXgyc8cGLSyXhvcdmHzKEJcUys25t6
 CXwlXucSPQ/NCZ9TLNphvzEDe4LcW/FXz0aH/gR+FZhSaHVDsaSUZD5xHSC9Q0qN5EQJPI/2UW9
 l7w4oM7OiKKXctvHud3oifAItF+SBCcoBJ+daLudJKbriK86e/vtYUUXIpKVOUsDGLIFYi/Oc8L
 HAugwDfZGgsEuUab4bqsgkCkeAnxlXLpxaSauiuLomft9EF5B5gs/v3Bhn+RG26EzRlwrYWXnq7
 EefV+2R4MkPzDiM1nQ/kbueZGdXIxHkoHJ8ZJh95b8k4Hm9EHPzSpqxyJgM1crLF7bGNVCj19eB
 3r57adhVAd7Oiv9RDQgLfGeNL5oM3gkLOrChyCuvAnTFOOiKPc96jmssagSzKe3NwXeZxgjhXB1
 QI/d5uHfI1JsskdvAoZtVqFqwoTx+ZPXuv+8xg0FzNJ5dVXzaYiGvScn3dnKKE6ETzg
X-Received: by 2002:a05:6830:3114:b0:7d7:e57a:bcd with SMTP id
 46e09a7af769-7e36682669fmr9202823a34.20.1778523772345; 
 Mon, 11 May 2026 11:22:52 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:32 -0600
Subject: [PATCH v6 01/35] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-1-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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

Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
successful no-op for linux-user.

Self-modifying code is handled by QEMU's normal user-mode translation
invalidation machinery, so the target ABI only needs the syscall command
to be accepted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MIPS_FLUSH_CACHE out of the combined sysmips/MIPS_FIXADE patch.
    (suggested by Richard Henderson)
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index dfcdf320b7..3f36c1695a 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b..20ea7c6ab9 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d3d9fffb54..73f09bb775 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6630,6 +6630,19 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
     }
 }
 
+#ifdef TARGET_NR_sysmips
+static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
+                           abi_long arg2)
+{
+    switch (cmd) {
+    case TARGET_SYSMIPS_FLUSH_CACHE:
+        return 0;
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+#endif
+
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -12102,6 +12115,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_prctl:
         return do_prctl(cpu_env, arg1, arg2, arg3, arg4, arg5);
         break;
+#ifdef TARGET_NR_sysmips
+    case TARGET_NR_sysmips:
+        return do_sysmips(cpu_env, arg1, arg2, arg3);
+#endif
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
         return do_arch_prctl(cpu_env, arg1, arg2);

-- 
2.54.0


