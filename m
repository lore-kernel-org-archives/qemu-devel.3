Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6F7C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwPN-0004wP-6H; Tue, 25 Mar 2025 01:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO5-0003ys-Kw
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO3-0005vM-OF
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:41 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2243803b776so28232315ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878778; x=1743483578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS3gEZRMWOaWak1qsS38oc8ZE/M7wQ+w6QdzWBH2Aio=;
 b=pJT0Cn3GcOQjBJcfNXqq8dZaHUNzt2eWdx8i2HefCFVACg8MHGwls2cYDz0ChVVJZ7
 S7jEscajIhYiPc+iUxhSCDZR6w8AnHTobEMPHaLv02iBcYy4IRPEUafJjtcytd8v+bTA
 mHMiek7xHtmyFmG991H/JuwP+FFbOKXC7HkyVQKpyMBfSm2EWT7FrcR/rsmPVrR5z7Sx
 oTsE008ZnzZyrkX698wbfk0z05UnDg1uG6ttVpBMICFWUqW4vm75KOJIvoPT0srk9qwg
 znzTErjLOLll3xIeIqWSf+Zj+fNCF4Z9CZwZo92ovsVoadQ1BCrzMYkrZH3twqY2q1ih
 0IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878778; x=1743483578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pS3gEZRMWOaWak1qsS38oc8ZE/M7wQ+w6QdzWBH2Aio=;
 b=EwPDePBYOKygF0Ja27lGhX5H5VqPpzC5vEZZNN8AUko2m2H7pyQbnJwjjvSSkkOFYl
 Facbn9Kv7GyAih1V2ekc/gBL3UDxm6GY/wWXQWAuL2bVd4NC5YFwZrSrzPwiYXIqODrN
 /Z6fRxp2JtqIfgh5kWfHthzBnClAenMwLiNdQcjK5Xf7Xkk+j1/i3lmUcblU0jhxPJOI
 P0aJMv5czv8Omi11d668EmfadR/sJCvzJySoJshGvDLE4v8Bn2Nz7poQUulLirmFDDzB
 xVTSdLkxeqzOHcJJ57fRgKnkmKjVVjyB73RpCKTxCCMOxNoNF98/S7dEqtamyQ2viV44
 zLMQ==
X-Gm-Message-State: AOJu0YyO2NNNpasrqcfoACSACWfuX2wcARlZsyCQ5v9U7tLfEtwiDN3W
 h3L7d80LJ5FdB1BZFibSbKhV2w1Ba+UT20NzAilL+4CWoXL/5spQgTMUmjTEwjEErekTRG8w7MN
 c
X-Gm-Gg: ASbGncvvkM26AkTdpct2xvHEnBwp/cE3GX2agjg71DJLpiCcRE69AZTsBSrreQ4+lCw
 vY5KTJOvhPdVD7j8fv6dkHjLU4c5TRyARjewnARgmjSDFY7+bndXPGhYDxRItlsVq7PyLBaedIR
 tQ3CRbkpyyCgCQniy/oaQbL+r3XX5WOp8rdTcQuEhvRPKNOzetPXxOQN+fkrzev5bPH/WG9Wjm5
 yqROl74V/KAIzb/+IEEXn6WW8kDJ5V6PLQMZpkwXh8CeDVUzjW3WEb9wDcCSOrY9L8m5tCVnOvN
 0FRZCrYdFQ/AimBMFAnZPMGiOc3bj2F9INfjx0whupEQ
X-Google-Smtp-Source: AGHT+IFSJ7fSgpYAHJW7th72zltx6rj97RlW4Khdsq0ywa9MEQR0n3b7F9efClc0LuL5kNihOGXTUg==
X-Received: by 2002:a17:902:f64e:b0:220:c067:7be0 with SMTP id
 d9443c01a7336-22780c50a94mr237157895ad.6.1742878777836; 
 Mon, 24 Mar 2025 21:59:37 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 17/29] accel/kvm: move KVM_HAVE_MCE_INJECTION define to
 kvm-all.c
Date: Mon, 24 Mar 2025 21:59:02 -0700
Message-Id: <20250325045915.994760-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

This define is used only in accel/kvm/kvm-all.c, so we push directly the
definition there. Add more visibility to kvm_arch_on_sigbus_vcpu() to
allow removing this define from any header.

The architectures defining KVM_HAVE_MCE_INJECTION are i386, x86_64 and
aarch64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/kvm.h | 2 --
 target/arm/cpu.h     | 4 ----
 target/i386/cpu.h    | 2 --
 accel/kvm/kvm-all.c  | 5 +++++
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 716c7dcdf6b..b690dda1370 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -392,9 +392,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#ifdef KVM_HAVE_MCE_INJECTION
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
-#endif
 
 void kvm_arch_init_irq_routing(KVMState *s);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ea9956395ca..a8a1a8faf6b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -33,10 +33,6 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 
-#ifdef TARGET_AARCH64
-#define KVM_HAVE_MCE_INJECTION 1
-#endif
-
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
 #define EXCP_PREFETCH_ABORT  3
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 049bdd1a893..44ee263d8f1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -35,8 +35,6 @@
 
 #define XEN_NR_VIRQS 24
 
-#define KVM_HAVE_MCE_INJECTION 1
-
 /* support for self modifying code even if the modified instruction is
    close to the modifying instruction */
 #define TARGET_HAS_PRECISE_SMC
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0723a3933bb..7c5d1a98bc4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -57,6 +57,11 @@
 #include <sys/eventfd.h>
 #endif
 
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+# define KVM_HAVE_MCE_INJECTION 1
+#endif
+
+
 /* KVM uses PAGE_SIZE in its definition of KVM_COALESCED_MMIO_MAX. We
  * need to use the real host PAGE_SIZE, as that's what KVM will use.
  */
-- 
2.39.5


