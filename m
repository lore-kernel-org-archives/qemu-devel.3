Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51076C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSM-0006jl-Sb; Thu, 20 Mar 2025 18:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPm-0002ai-GD
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPO-0007As-DD
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223fb0f619dso27817535ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509830; x=1743114630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwN1XbujsuD3V7J/Bz3fRu7KgVCb0BPWWPB+rJlSEhI=;
 b=OEiMvc7IrWRWrSY0f04OAh7n6KzBKET3jTcw8R7/fcDHywVLqmZ8ZrnRVNYTr5q7rB
 4gZOs14E3X4+5Ni+8KiuQ6NEMsyCWFYnzSVyRTAUNJW986vZD6rnG5RbrBkqP1nfLyWd
 kdVNIOPrc7cjq2n4t96vQP5x+jNUbJ2bxZtLOlMLaEnqLzJvcX2g/+wfMsuVMSES1+N6
 X4ZglLtVxBNxVIb+/g+Hi9NUhpH+ZKRr9d334udXMXS0nRYpJsLube8OEyYXCmeiQLux
 fX0u75zlqq5IfXdvwXYEx6bC0hDgTD1XyCCZKXCl2JJmkPQCKQZamLaNvJ197t6RZlYi
 aXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509830; x=1743114630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwN1XbujsuD3V7J/Bz3fRu7KgVCb0BPWWPB+rJlSEhI=;
 b=tNKpgnMj9sMEgbof91BqleowsnWSEtFWf4L8G94IHRSyiYnhl0BN6nD7rgs2QsZsB1
 zEHVqzm8DsFJvTYqiPkgmJAUyeNxyuKrVL/DuHA9LeWy5pt0/pnM2kBbLi1pC839teo9
 +2P+10EYfZdMjCVpuDxnhaUVroCXh+HBLpn03YVJPRBp6jCoR0OpYErJnwtEreVVN2Qw
 I//FHzFEpj5XYXj0rE7BuoK2uIeP51rBr9nKbgZXYpFB4eJ/RYaViUhy7Ma2jTqhbZPk
 j6QcMXcjSUsN+Dcp82APzLO9uLNwLmKrwNt3xRs8XswgcTVcGdL48XCpH5Wi84rDm4LT
 45gw==
X-Gm-Message-State: AOJu0YzL+0ziE0traE+AuLI7E/+3JEybjGX8m9orspelMSQu9GYwxBnP
 BOFHPiByiTcTIK4UdL1htzcs+9A7VFq7ag/aCyEiAKCVu91CbgDO3dnvdLGD+wjLj1M6MpA8qAk
 x
X-Gm-Gg: ASbGncv7OHTqxefguFNj6vDiXsZokE+NKYru0liipmqVc9HhdkiUysEZ5utuZY2Edzg
 F0qQoC0AQIuyGtLo2Hdueub4ZmoDCuCfWJGCN4zeHaJlq2L2ELvhiGUuG34N4fmcMlbHRYTElOi
 E5WqLJYasT0OIazhmahRamceG/Qzwv2JH+lDrWOmZm/w2TKYeWfLGIkVXWiQ4TPjR4jTrdcR8gl
 dAEFpRCM7fHo+4ThqLCK3tCkSLM6Kp4o1BfTyaGr6BVBUR0oKnfyBjILfZJrfWnDAzeqIFGQomT
 XmWtz74r68MyGykADkxLj+VbO3NkJb3NXnHvcB+Sgh6u
X-Google-Smtp-Source: AGHT+IFPlM9uNBTWNlrUQZHTXtzAV3hq70Es3JgASaflDsGAiltKwjCQjn1OTnh83OLfKZfNwL1qmw==
X-Received: by 2002:a17:902:f687:b0:216:3466:7414 with SMTP id
 d9443c01a7336-22780e25bd4mr13499905ad.44.1742509830242; 
 Thu, 20 Mar 2025 15:30:30 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 18/30] accel/kvm: move KVM_HAVE_MCE_INJECTION define to
 kvm-all.c
Date: Thu, 20 Mar 2025 15:29:50 -0700
Message-Id: <20250320223002.2915728-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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


