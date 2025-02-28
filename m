Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF215C282D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6c2-0005Td-Dq; Fri, 28 Feb 2025 15:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38xbCZwgKCm4iTQZPdUWSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--whendrik.bounces.google.com>)
 id 1to6bf-0004xh-HF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:15 -0500
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38xbCZwgKCm4iTQZPdUWSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--whendrik.bounces.google.com>)
 id 1to6bd-00019r-5M
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:10 -0500
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-38f39352f1dso1126431f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740773107; x=1741377907; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=f5nUlFdo6zTGVeedUX76LpqnWI9Z721CKkwnHkSKwH0=;
 b=1SW4aDSFz6KYmi29H7tzRqJpJvvCkM6X2zBNw6PufowcQ1BW/2yLzDGOwD5ZqKeAtD
 dxxqN3tjprcrPfEj6uAHnbpzlhY6idpo0+tQJwUDpBy+/qkH7/ADjXlzwtlvCp6pyMnr
 OsWHlOnEVHkvIjq/DIvEmF3aZ0nYMaThxpiICW7DR18H845+3EAv61JPnT68y8kQLVGL
 Pr96cHenIcewnLNmePFPJkxAJlJwdD9AVNHPY9kdndMEeic2wtBPGfZSIBXW5sNC0aYo
 SeZnyCxx5iKPcJWx8O7C/G0U1fnG9Ta+duH9SCU6gvZaJ3TAnxWxVxj4v7Yvxe86cZXR
 nZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740773107; x=1741377907;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5nUlFdo6zTGVeedUX76LpqnWI9Z721CKkwnHkSKwH0=;
 b=vf7GZ9TtPO2i57wml5hAlDDEQraHDXz7XWZj2+Q9YfTT0KWnSxh4v2fMxQZ2UibcU6
 2eLaKjWEPH49BtJUH+G0eRbGQ7dfbZLw/u8hFUf7m0+CBHtNzOf3qy7O3+VP0GffR4dJ
 zobPV8aqmyQ31FDqhjzSAKDQWyrpOOzQ/vZaeOCS2ec0QaefJWCfVwHS2QMmVyga4ZQB
 hzdL4uIfFQe1Ty1wKsKP3H1CHHr8QDhimwmSnvvieBJolAwyZA15tOjVxHLFOUMxNM86
 ao7IuvG+fsRNw6sDX4WKU7W+lclwsGGDzXUmfn9TTbwgXRxFUI4HUosD2eGifzhVOlaO
 XDvA==
X-Gm-Message-State: AOJu0YysyJUqnTfQvLp8yKj/x5Pw6AVkaajduC5nbGjYa5N6Zg00gYAz
 5O6TZQ7SADBD+RUAJlFP+AhfyL2eTOtHmKRjXmDLBv5sGkqNnvYR2QfwQKqlrd64e7qd6BbD3p1
 qUJ7nmd1+0eXqRaEpo5g0/An8Ka7tae6tc+gRN7kEkz/oP7qBcnePHF1kCmAC2vCwG+2czPngcZ
 WTRPjVP9KQz0ejP1nDrp0SjCal8zjCrzzAHDaWdOVLkA==
X-Google-Smtp-Source: AGHT+IFoScdELt4ZkGKuM3Hubf3ZyhyYmMXataSvwKxnYp/L4zc4epF8Q0VereIOZs7Rm6sQwDf8vHAKG17lFQ==
X-Received: from wrbgx23.prod.google.com
 ([2002:a05:6000:4717:b0:38f:59c8:7f19])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1866:b0:390:e9ea:588 with SMTP id
 ffacd0b85a97d-390eca3bd17mr4657127f8f.55.1740773107123; 
 Fri, 28 Feb 2025 12:05:07 -0800 (PST)
Date: Fri, 28 Feb 2025 20:04:50 +0000
In-Reply-To: <20250228200453.45173-1-whendrik@google.com>
Mime-Version: 1.0
References: <20250228200453.45173-1-whendrik@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228200453.45173-5-whendrik@google.com>
Subject: [PATCH v6 5/8] i386: Add CPUID enumeration for RDT
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, Jonathan.Cameron@huawei.com, 
 v6-0000-cover-letter.patch@google.com
Cc: peternewman@google.com, Hendrik Wuethrich <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=38xbCZwgKCm4iTQZPdUWSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add CPUID enumeration for intel RDT monitoring and allocation, as well
as the flags used in the enumeration code.

Signed-off-by: Hendrik Wuethrich <whendrik@google.com>
---
 include/hw/i386/rdt.h | 23 +++++++++++++
 target/i386/cpu.c     | 75 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h     |  5 +++
 3 files changed, 103 insertions(+)

diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index b63b433eef..a21bf804a6 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -29,8 +29,31 @@
 #define RDT_MAX_L2_MASK_COUNT      63
 #define RDT_MAX_MBA_THRTL_COUNT    63
 
+/* RDT L3 Cache Monitoring Technology */
+#define CPUID_F_0_EDX_L3               (1U << 1)
+#define CPUID_F_1_EDX_L3_OCCUPANCY     (1U << 0)
+#define CPUID_F_1_EDX_L3_TOTAL_BW      (1U << 1)
+#define CPUID_F_1_EDX_L3_LOCAL_BW      (1U << 2)
+
+/* RDT Cache Allocation Technology */
+#define CPUID_10_0_EBX_L3_CAT           (1U << 1)
+#define CPUID_10_0_EBX_L2_CAT           (1U << 2)
+#define CPUID_10_0_EBX_MBA              (1U << 3)
+
+/* RDT L3 Allocation features */
+#define CPUID_10_1_EAX_CBM_LENGTH       0xf
+#define CPUID_10_1_EBX_CBM              0x0
+#define CPUID_10_1_ECX_CDP              0x0 /* to enable, it would be (1U << 2) */
 #define CPUID_10_1_EDX_COS_MAX          RDT_MAX_L3_MASK_COUNT
+
+/* RDT L2 Allocation features*/
+#define CPUID_10_2_EAX_CBM_LENGTH       0xf
+#define CPUID_10_2_EBX_CBM              0x0
 #define CPUID_10_2_EDX_COS_MAX          RDT_MAX_L2_MASK_COUNT
+
+/* RDT MBA features */
+#define CPUID_10_3_EAX_THRTL_MAX        89
+#define CPUID_10_3_ECX_LINEAR_RESPONSE (1U << 2)
 #define CPUID_10_3_EDX_COS_MAX          RDT_MAX_MBA_THRTL_COUNT
 
 typedef struct RDTState RDTState;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 72ab147e85..cd06744451 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -42,6 +42,7 @@
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
+#include "hw/i386/rdt.h"
 
 #include "disas/capstone.h"
 #include "cpu-internal.h"
@@ -6869,6 +6870,80 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
         break;
+#ifndef CONFIG_USER_ONLY
+    case 0xF:
+        /* Shared Resource Monitoring Enumeration Leaf */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+#ifdef CONFIG_RDT
+        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQM))
+            break;
+        if (!(cpu->rdtStatePerL3Cache)) {
+            warn_report("Intel RDT features enabled in commandline, "
+                        "but rdt device not used");
+            break;
+        }
+        /* Non-zero count is ResId */
+        switch (count) {
+            /* Monitoring Resource Type Enumeration */
+        case 0:
+            *edx = env->features[FEAT_RDT_F_0_EDX];
+            *ebx = rdt_max_rmid(cpu->rdtStatePerL3Cache);
+            break;
+        case 1:
+            *ebx = 1;
+            *ecx = rdt_max_rmid(cpu->rdtStatePerL3Cache);
+            *edx =  CPUID_F_1_EDX_L3_OCCUPANCY  |
+                    CPUID_F_1_EDX_L3_TOTAL_BW   |
+                    CPUID_F_1_EDX_L3_LOCAL_BW;
+            break;
+        }
+#endif
+        break;
+    case 0x10:
+        /* Shared Resource Director Technology Allocation Enumeration Leaf */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+#ifdef CONFIG_RDT
+        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQE))
+            break;
+        if (!(cpu->rdtPerCore)) {
+            warn_report("Intel RDT features enabled in commandline, "
+                        "but rdt device not used");
+            break;
+        }
+        /* Non-zero count is ResId */
+        switch (count) {
+            /* Cache Allocation Technology Available Resource Types */
+        case 0:
+            *ebx =  CPUID_10_0_EBX_L3_CAT |
+                    CPUID_10_0_EBX_L2_CAT |
+                    CPUID_10_0_EBX_MBA;
+            break;
+        case 1:
+            *eax = CPUID_10_1_EAX_CBM_LENGTH;
+            *ebx = CPUID_10_1_EBX_CBM;
+            *ecx = CPUID_10_1_ECX_CDP;
+            *edx = CPUID_10_1_EDX_COS_MAX;
+            break;
+        case 2:
+            *eax = CPUID_10_2_EAX_CBM_LENGTH;
+            *ebx = CPUID_10_2_EBX_CBM;
+            *edx = CPUID_10_2_EDX_COS_MAX;
+            break;
+        case 3:
+            *eax = CPUID_10_3_EAX_THRTL_MAX;
+            *ecx = CPUID_10_3_ECX_LINEAR_RESPONSE;
+            *edx = CPUID_10_3_EDX_COS_MAX;
+            break;
+        }
+#endif
+        break;
+#endif
     case 0x1C:
         if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
             x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 08089ce6c2..6f5a3ecbd4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -679,6 +679,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
+    FEAT_RDT_F_0_EDX,  /* CPUID[EAX=0xf,ECX=0].EDX (RDT CMT/MBM) */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -853,8 +854,12 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EBX_RTM               (1U << 11)
 /* Zero out FPU CS and FPU DS */
 #define CPUID_7_0_EBX_ZERO_FCS_FDS      (1U << 13)
+/* Resource Director Technology Monitoring */
+#define CPUID_7_0_EBX_PQM               (1U << 12)
 /* Memory Protection Extension */
 #define CPUID_7_0_EBX_MPX               (1U << 14)
+/* Resource Director Technology Allocation */
+#define CPUID_7_0_EBX_PQE               (1U << 15)
 /* AVX-512 Foundation */
 #define CPUID_7_0_EBX_AVX512F           (1U << 16)
 /* AVX-512 Doubleword & Quadword Instruction */
-- 
2.48.1.711.g2feabab25a-goog


