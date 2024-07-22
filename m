Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97212C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0qY-0007GY-Ry; Mon, 22 Jul 2024 17:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0q4-0005H6-NU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:45:00 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0q2-0004Mh-OL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:45:00 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8036ce66164so177241339f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721684697; x=1722289497;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCvhmJN00xwcYiXq7RTqO6TEMMCZZhNjKEbh12HQDEc=;
 b=VyhdupqQ+cX4VSbfik4e9CVQFKVpteszoRJsDLtLNWdE/Qq/0s6NAkBuC8ccnItcWU
 beFhKn7kPDyedFkafzklwjDY3YWfCtB1ElTVQdsVRCjog5EprzsMQWApPqHzLCNHq/5f
 Ouoc8f7b3c4cQUUZt9m0YNDlqNyc6VKbfuwbCr6Wwl6r7jDsCGZlSNCtneIcPH4+L5aW
 hoHjmVHIYjELWN6rFc3NuHXudIkcDh4c9YIW9OMWcJ+Y2o0ls4uokAn5DeYnYvT3aho8
 kEe7auZhbfSXXY1HrRXZwSLdIhXITAYuoktirxQRxA13ZBHR3d8QvA/qO8knAjCj2vfZ
 FAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684697; x=1722289497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCvhmJN00xwcYiXq7RTqO6TEMMCZZhNjKEbh12HQDEc=;
 b=AOFgDodNGWnwB0w6bhCcv4YX3s+InCtLgMrfcQ3qYRaVKNPrMHkmBsO2OWc8AVH+dQ
 rEfRkv4qsfhNdoKZSzZgU6HqwR9Ol2THZJ154Ka60H87lhjak2PUXUfgnL1khjB2211E
 X9/frVW26dsv7lNVMT32pp8ilY/lzUueFUlGp/jLAr6P/BtU4jyRmIrMcyuSV2++aUDq
 XiWSL+lnp0KE9K36wPCuvK3uYW7q/eKO5RWZqWkidYBivT+aD43Qzzta3R63W1SqtGHU
 +o0K9mUgFQ/a9WaV1zNuIY6GU8JX9GjuoMi9CESWT1tkXF1MQmvMSswU3P44us7ly3JL
 cTjQ==
X-Gm-Message-State: AOJu0Ywv26f/MIzSrf588BDqALIvl1ktflFOQ1vcltvMW3urNME6tuB9
 kr7AfUjTe5KiuDhDvTvuN59sEIRyoE1fvrWrowm+nIKdFRCro42eG4lZBoKsiRdVPHLNs0kyXm7
 1eN4=
X-Google-Smtp-Source: AGHT+IGpEuG4vRJSOCX1daB2CYFJ3JOfGGyPjkmnyZCnupN+q+vnODLcM9N0VLZhvatfvWXw/ghR4w==
X-Received: by 2002:a05:6602:2cd5:b0:804:8a79:2c77 with SMTP id
 ca18e2360f4ac-81b3372d7bemr1015322739f.8.1721684696087; 
 Mon, 22 Jul 2024 14:44:56 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c2343d2ff3sm1816830173.128.2024.07.22.14.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:44:55 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 12/14] bsd-user: Define TARGET_SIGSTACK_ALIGN and use it to
 round stack
Date: Mon, 22 Jul 2024 15:43:11 -0600
Message-ID: <20240722214313.89503-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240722214313.89503-1-imp@bsdimp.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d29;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd29.google.com
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


