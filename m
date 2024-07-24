Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EA1C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk8F-0001aJ-Cb; Wed, 24 Jul 2024 18:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk8D-0001SW-O5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:45 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk8C-0006eZ-3o
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:45 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7fd3dbc01deso9752639f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858802; x=1722463602;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NVVykiWpqYjvD45AibIwwzA8pM6gZ3sTQWN+WDs9eM=;
 b=UgaBxm7xfBrT9rLRsodW5s4wENgQq3hnN0FaR+DxkLnOxvdIT7GwcCqBFiNXHKVrQr
 0TXvQyIE44Y0MxCA1KM00KlF4jKVoBtR2+DPqAa4my+vPiArl6wGdmpGYofNIuBTd78v
 GG756b4BmYF/2dppfQyzdJKOlZxt0M3Sgm4WmProaGpq5U6WpoLUiZPNCPW2uO4BEfYK
 OCV1duMBkCMdR1TE+BTC2HZ8OKXuvk/dkRTyL3+WSNlHXoigCXprPmewJr8GMTgtge4z
 saDetJmB1N0+e0uq1+yzeyFxHDVsQnZCg85goxbNgFDPo6ELYHNrINPAWV2SgAfKDRQj
 VkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858802; x=1722463602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NVVykiWpqYjvD45AibIwwzA8pM6gZ3sTQWN+WDs9eM=;
 b=mY0T/pTs2XQtl0diyXvuxi2JAIZVc2zPVIuJyts2XJMo2WSXHzERPODtgA22s3/NFa
 BAQAKYR6gD6NiNB3RSn9CopUbZ77DkW2XyMco5s8lnqeDIo06+JJ7Ol7w0uYDOUy4qWO
 u7AMee0HO2ZHYpw/83c4VXCk+eboXNCdP64CZsEzViZiCWUXvKl5yMl2NgEyDD+yP056
 xEPDy6X8CxF4SdC3SnjOtwg1gl3GcBCCP6rlLMDX4ciPxHixrVu0/uhFynyffAtD/Yx5
 ICZGvknc29XWkQobWmHMhfvswwNWrmiTiDdxQT5KI0j3XwvWCYStxSp+KUb/aeXk8wKm
 XZWg==
X-Gm-Message-State: AOJu0Yzs/xgptLtEQhWICSRQO0k9ds7osgI+cLdExX7gNQgxHJLJvmPs
 juhF7gq3rkaJL3liDsiNSO8EFOY1GlSK37UI1aRIOKixH8vjP1lr6/Sfh66DACgTOvSb0mJi2v1
 htxc=
X-Google-Smtp-Source: AGHT+IEGTqyknQYn8B0a6aM0Z8KoR1fsMcQ0b04o1D0B4PRSfkn1SlFqsm0Zb9Lp7UJwh5PBUhBU5Q==
X-Received: by 2002:a05:6602:1349:b0:7f9:b435:4f5 with SMTP id
 ca18e2360f4ac-81f7e49b051mr14971039f.11.1721858790321; 
 Wed, 24 Jul 2024 15:06:30 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/15] bsd-user: Define TARGET_SIGSTACK_ALIGN and use it to
 round stack
Date: Wed, 24 Jul 2024 16:04:45 -0600
Message-ID: <20240724220449.10398-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d34;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Most (all?) targets require stacks to be properly aligned. Rather than a
series of ifdefs in bsd-user/signal.h, instead use a manditory #define
for all architectures.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_signal.h | 2 ++
 bsd-user/arm/target_arch_signal.h     | 2 ++
 bsd-user/i386/target_arch_signal.h    | 2 ++
 bsd-user/signal.c                     | 9 +--------
 bsd-user/x86_64/target_arch_signal.h  | 2 ++
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
index bff752a67ab..b72ba7aa504 100644
--- a/bsd-user/aarch64/target_arch_signal.h
+++ b/bsd-user/aarch64/target_arch_signal.h
@@ -77,4 +77,6 @@ struct target_sigframe {
     target_ucontext_t   sf_uc;  /* saved ucontext */
 };
 
+#define TARGET_SIGSTACK_ALIGN 16
+
 #endif /* TARGET_ARCH_SIGNAL_H */
diff --git a/bsd-user/arm/target_arch_signal.h b/bsd-user/arm/target_arch_signal.h
index 02b2b33e07a..10f96b8bfc9 100644
--- a/bsd-user/arm/target_arch_signal.h
+++ b/bsd-user/arm/target_arch_signal.h
@@ -86,4 +86,6 @@ struct target_sigframe {
     target_mcontext_vfp_t sf_vfp; /* actual saved VFP context */
 };
 
+#define TARGET_SIGSTACK_ALIGN 8
+
 #endif /* TARGET_ARCH_SIGNAL_H */
diff --git a/bsd-user/i386/target_arch_signal.h b/bsd-user/i386/target_arch_signal.h
index 279dadc22c7..2c14153ab6b 100644
--- a/bsd-user/i386/target_arch_signal.h
+++ b/bsd-user/i386/target_arch_signal.h
@@ -88,4 +88,6 @@ struct target_sigframe {
     uint32_t    __spare__[2];
 };
 
+#define TARGET_SIGSTACK_ALIGN 8
+
 #endif /* TARGET_ARCH_SIGNAL_H */
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index 8b6654b91da..da49b9bffc1 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -728,14 +728,7 @@ static inline abi_ulong get_sigframe(struct target_sigaction *ka,
         sp = ts->sigaltstack_used.ss_sp + ts->sigaltstack_used.ss_size;
     }
 
-/* TODO: make this a target_arch function / define */
-#if defined(TARGET_ARM)
-    return (sp - frame_size) & ~7;
-#elif defined(TARGET_AARCH64)
-    return (sp - frame_size) & ~15;
-#else
-    return sp - frame_size;
-#endif
+    return ROUND_DOWN(sp - frame_size, TARGET_SIGSTACK_ALIGN);
 }
 
 /* compare to $M/$M/exec_machdep.c sendsig and sys/kern/kern_sig.c sigexit */
diff --git a/bsd-user/x86_64/target_arch_signal.h b/bsd-user/x86_64/target_arch_signal.h
index ca24bf1e7f7..f833ee66cef 100644
--- a/bsd-user/x86_64/target_arch_signal.h
+++ b/bsd-user/x86_64/target_arch_signal.h
@@ -97,4 +97,6 @@ struct target_sigframe {
     uint32_t    __spare__[2];
 };
 
+#define TARGET_SIGSTACK_ALIGN 16
+
 #endif /* TARGET_ARCH_SIGNAL_H */
-- 
2.45.1


