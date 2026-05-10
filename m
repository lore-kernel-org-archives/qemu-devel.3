Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E28CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwY-0004rr-9g; Sun, 10 May 2026 16:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwX-0004q6-4F
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:05 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwV-0003km-K6
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:04 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47cbd444fd0so2392353b6e.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445602; x=1779050402; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=kirQ6XYlzX3+Wyz4U3yTJz/oLePKCDhVX4rOmiVA6cv6ZPebAVJSujy2sqcFzJ4ki4
 dXcv/wK+mbpyD8q8fRQ4Qyyo1QtGZ6Y66OS4aT/mM3V3Kq2a+LPLTbkXL8LCXujR6w3s
 ZpXn5w87LSzny0izWC8W2XJqlv9CIt76Fqen9KwFUKuMth4xTKeRsvxWTZma0fpUN8jq
 FsJrCg8n7vDiKWLEqKgebFPvAUtTjTIzYEKfz2bwWj+nA82ULBE1kcwU7ncROnkkP/zc
 S5pN82XgDFJX71BRfvqAMsYv1HE9XFqZ+CNKGJrOqXjAH5r96cHcZDEoMRWQjI9XmOm2
 FmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445602; x=1779050402;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=su6+rAFrg9YVapyLtQuqYJiz7HrKmxTXgyydRi45ehJip0OVzuxSOIsHfB8d4IQnSc
 u4GtXZAllrGHC6sM2INOJwAfMKDZuRYbJM/+sIxeRFzX+Y8+yvHzFVheTgHBaf2bDEAM
 ZokJWweysz1EtIcpPoDjwwa7EopLZ01mGi9H64M81QhbCQiCcMX/KDq558CBiQeM2UQM
 +3+ztzGpXD4Goui3hAyO2hH3nW1uMcmOEqctlKHRUq0FLfS+JYpcJBTnH0mTvTUuzj7P
 7EIw2ynqS6ewOOpdmAdhr/WPftEI+SLwGJZgkUeoNLP3MRb6200xjLVfLarqyLfazPwp
 QyTQ==
X-Gm-Message-State: AOJu0Yy2wdpDmYWpP8DVpbGj9kZ6xplhxCWt5QvNlnv2uiRC7hSz/gej
 CzkUYJFAizLQRD1IXB7KzhspCBrm38ZAyGmWexV577jAYnEhTHMCt8CP
X-Gm-Gg: Acq92OHCx/130eGZuj4f0qz1bCQ1y+qkrFT70+jTc9nBrhtblQ2F3prpqq9K3DKdwTo
 LeKiPpQBf6k4fgaDicZaew8KsVn9RRifVnM5ZhSlHRuYUx9Jg4jfLpfffAI6ymqIILs/fl1qrVu
 xf81iB6HNa6KubFDA2bX+8m8a4cxSvWXK8VLye4ScVTaLL71rLXoPPKgjDO3I9mBMLm14UlxnRt
 ROeR0daU+9SzivC1M02qzoH0IPSp29AQMsNOANYhJrYp3nlrS8wRjIUSAclOCPYH9sJeFj7BbKa
 Q29Pak88uqOzDDGtWsV1tDiOfsdWHSqh/Sw4Z/ES/YDcDVKK0Hgf00gNxC5VQURX4TPhJZztOlr
 B+u82KLsMDky0PseDQTIpGZg0VBi5RDLggsanLQDjfmAOACTfTcLFEwyF1NxIsU+MSMT7X8i23n
 hts3UVPwHfsApHcjYKHrYtKttVhB78hyNmGLyFdsXyMWf+aTSXarfbXNcRZce93cfE7Z10qBZBz
 IzxCEaZOtV0ZkcAPb5DIlYr71sSaytERr3sMxy92h8=
X-Received: by 2002:a05:6808:1999:b0:455:f0e4:4f89 with SMTP id
 5614622812f47-480420bc1b4mr13036240b6e.3.1778445601914; 
 Sun, 10 May 2026 13:40:01 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:31 -0600
Subject: [PATCH v5 01/32] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-1-d5d2668d15ab@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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


