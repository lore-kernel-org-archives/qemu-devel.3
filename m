Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B390CC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugufR-00051r-4G; Tue, 29 Jul 2025 20:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMd-0006sQ-CP
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:13 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMb-00059M-Go
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:10 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-313910f392dso4832530a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834088; x=1754438888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WC9oUvRCMrCYnYBvur63Dpq5l4F1AQCsSeMzT7kqFfI=;
 b=pfaAybSwLIuJUDrreVNNfwHjsFZbuFYkOV3XyrsxnTKUZZ5Aq+nrCG12xAoaEzUkDv
 voAcdS28L0iigpBna+t27UeJXsx7FP5rGR0u7SN1EEHXz8nnFcrEMHTcOTjoQYIZm+TE
 z57+gFi9VSyw0dg7HJyMYpMbn/isZ1JgqtO3R8o2gFV5g9DFY5s0s5T4TI1whfH6ibbk
 soAzDHKzixkAeYJVR4nHv/CM4c7CDnyhgt0/meFORukJfOUrxaKg3rSSXaXYqQ1CbpdP
 F9MNwm8uDkqp7kZwE3ieKsH5gUYDF3LOPSpNNL3n6SWMVlvoaJ1741v+R+8osjEKwULE
 VN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834088; x=1754438888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WC9oUvRCMrCYnYBvur63Dpq5l4F1AQCsSeMzT7kqFfI=;
 b=XP0Etz0nDDIkQOWKdURvhraCBGXfaa9PuXg698dQU++GFmHn60jhvxrKFOOs4FpC/z
 uJuExxnCKFFuSbfosfTOcqwu7DVq5IcPIHcFQlou/wIQYoyE+NqFsHTKAFH34Sr3bG0o
 T0nNRZzK4gX1nVcrx44olNZjoB+h1mQuxFSh/QJTqbA/RSPSlBgs6YSHemDwQCK3oQAD
 CvYYhIpGbbDdZSYeSnVYLE6atIYQqGYMj7XzmlXFwpmq80uKvsTp5XBhiVM/JDh0DFQU
 9nX/mPwbk3yQJhMeb3AKUO5MU1jj8ppZYb5ESzbRRJxrZhH28CuLyO0fVcvZPuwTP3XQ
 MEXg==
X-Gm-Message-State: AOJu0YyEQQSYhNO/zv3Ok2dnhcsBg60Iu3PFq9DNKe2gvPffVHpV/ZI+
 hdAo5nlp0roFH6QCqsdehoXUICsw9El0OyT4OPOiNOMEKsLmFq8fv05FM5Y9KpI0i1h4DsmfS+h
 xKrF5
X-Gm-Gg: ASbGncvCr1tglwtTq5kbS6qnu9DQRX/LS8kX5f4leLuIoTPSNdy7C9BA9ZTvEcELixZ
 0A6gs0fEim3oYxvfe8L1hsDPBeXk6StUPAime/G6GpvRvbNpCc40hX+vUBKKTJqzL/d672I6ZzM
 c4MpGgYerF/Yuc7uTUbxTnXJiJh/HX/3gVEeLRDn4EfZPcVkTIew89RusKN4TXBh6Nork8ZyHJw
 sqL6rq534q33SKZT3YW+8mbl+Qc3PdJg3jqROLVuyp5ViG/vxD5/vwXQjUSivCZ/+dW4F9hM6aq
 t34uxDVlljrq7e8ImhqNAuSglIQdke8EAo3ZS2EJ7FZb2o3qtFZWoWSWQ4m7A4PTsBQtu2KprPM
 7fx/8Ip9sqwfUvwwAu89J6jjUbyTrIDQWATAWxYi0e5uGNYTHTAJ8QG/NOwv7U0rv63F+J1U7Mc
 DVk+hVIhPn3A==
X-Google-Smtp-Source: AGHT+IGuETlA2k53lsfGSFZ6Li8Q4289Af3Tv1b/ddRDXruXJ91Sy1a6EknS+WomYwfe7Gf7npiKJA==
X-Received: by 2002:a17:90b:250a:b0:313:dcf4:37bc with SMTP id
 98e67ed59e1d1-31f5de59cf0mr1117712a91.34.1753834087825; 
 Tue, 29 Jul 2025 17:08:07 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.08.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:08:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 88/89] linux-user/s390x: Move target_psw_t to signal.c
Date: Tue, 29 Jul 2025 14:00:01 -1000
Message-ID: <20250730000003.599084-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Remove struct target_pt_regs as unused.
Move target_psw_t to signal.c, as it is used there.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/target_syscall.h | 22 ----------------------
 linux-user/s390x/signal.c         |  5 +++++
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/linux-user/s390x/target_syscall.h b/linux-user/s390x/target_syscall.h
index 4018988a25..f01f9a0baa 100644
--- a/linux-user/s390x/target_syscall.h
+++ b/linux-user/s390x/target_syscall.h
@@ -1,28 +1,6 @@
 #ifndef S390X_TARGET_SYSCALL_H
 #define S390X_TARGET_SYSCALL_H
 
-/* this typedef defines how a Program Status Word looks like */
-typedef struct {
-    abi_ulong mask;
-    abi_ulong addr;
-} __attribute__ ((aligned(8))) target_psw_t;
-
-/*
- * The pt_regs struct defines the way the registers are stored on
- * the stack during a system call.
- */
-
-#define TARGET_NUM_GPRS        16
-
-struct target_pt_regs {
-    abi_ulong args[1];
-    target_psw_t psw;
-    abi_ulong gprs[TARGET_NUM_GPRS];
-    abi_ulong orig_gpr2;
-    unsigned short ilen;
-    unsigned short trap;
-};
-
 #define UNAME_MACHINE "s390x"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index df49c24708..e964876123 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -33,6 +33,11 @@
 #define _SIGMASK_COPY_SIZE    (sizeof(unsigned long)*_SIGCONTEXT_NSIG_WORDS)
 #define S390_SYSCALL_OPCODE ((uint16_t)0x0a00)
 
+typedef struct {
+    abi_ulong mask;
+    abi_ulong addr;
+} __attribute__ ((aligned(8))) target_psw_t;
+
 typedef struct {
     target_psw_t psw;
     abi_ulong gprs[__NUM_GPRS];
-- 
2.43.0


