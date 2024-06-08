Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C1DC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYF-0002yo-1X; Sat, 08 Jun 2024 04:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYC-0002wN-TW
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYB-0000Hb-4u
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1SSoXnODbA0T267ExP4EpxDHUPMe33TEy/vs7sS7iM=;
 b=fDAJ5TH1WePVMIxispbhOatDSJncNYQCmeUJFEFq1HwcyOh6MhXQjM/zuw84VzVMiBPVAj
 zIpapQfNCF6hVZiHK3kJ0gpFypbWiom24ZxYxbnOhVPRqVBHZSaWPBVWF7xvTOENRUt4rr
 huhL4s9BHBR1p/4XtYQNK/1xZ7osyfI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-PASeM3s4PFyHLv1Pzc_vQg-1; Sat, 08 Jun 2024 04:35:42 -0400
X-MC-Unique: PASeM3s4PFyHLv1Pzc_vQg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68e85d466dso181937666b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835740; x=1718440540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1SSoXnODbA0T267ExP4EpxDHUPMe33TEy/vs7sS7iM=;
 b=n5xkVu0INcHqqGaISz9R+xyUL9CWnoXFmfKpN3WzBRtKfY2JxpKyUIuEKqTC4d0VhU
 Ff37FC5Lh4pQ6S0Ln7eEOYwJ2lVV6hRUH55Id8aZjGmvI4becyKqQi0CSwT9ejV49B1K
 7sjnhmkcHJfmPep3qMeR3AINqobfm59GG4y8eFjSexwSvlIZzEQ1XuJjvjQsPtyHJ6sX
 82v9gHtbTqnUw1HY5y1CB+Y0WJgPokci9JromKKh4xVD4bVL8Y6EIVYtNc1ODuR61ld4
 YEho8FRoV5CMAmG//RAAfSRqgxNMwTtS3/iLcQSJ9ZOpAUvWnLBdDEnU08bZD/3bXO6K
 v5sg==
X-Gm-Message-State: AOJu0YyF9Wyx6O/japlIbCGXcQL8s/wQPw0jJvoR5TC5uBtkbpU72Cuk
 3IT2dOMhG2bhBjxWrtl2zkkn7fii4xm03xXaE7p8d33ijC/DbbD2IN7py5LK/cFvLKGjCh59Hvx
 1wd+kUdfNm4WfIqP1s7+K/G0rLr/Q8YMlzOdzauH9TkUdDvlWoYSsDo3135+rpUGQxjxMEUqRdJ
 YFKBoCmz/y1hTFxn78MiCg5Gk/7St8RtCBWutc
X-Received: by 2002:a17:906:6a29:b0:a6e:a97c:fc97 with SMTP id
 a640c23a62f3a-a6ea97cfd15mr247901266b.7.1717835740355; 
 Sat, 08 Jun 2024 01:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG77+T0UOs7vENqNuYG26yUrIvmXn/Ba7V2fvC3E7zGyEBUsO5o6jwEAf4oC4PGCr+GtNs04A==
X-Received: by 2002:a17:906:6a29:b0:a6e:a97c:fc97 with SMTP id
 a640c23a62f3a-a6ea97cfd15mr247899666b.7.1717835739976; 
 Sat, 08 Jun 2024 01:35:39 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806eaa4dsm354422166b.110.2024.06.08.01.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xin Li <xin3.li@intel.com>,
	Shan Kang <shan.kang@intel.com>
Subject: [PULL 32/42] target/i386: add support for FRED in CPUID enumeration
Date: Sat,  8 Jun 2024 10:34:05 +0200
Message-ID: <20240608083415.2769160-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Xin Li <xin3.li@intel.com>

FRED, i.e., the Intel flexible return and event delivery architecture,
defines simple new transitions that change privilege level (ring
transitions).

The new transitions defined by the FRED architecture are FRED event
delivery and, for returning from events, two FRED return instructions.
FRED event delivery can effect a transition from ring 3 to ring 0, but
it is used also to deliver events incident to ring 0.  One FRED
instruction (ERETU) effects a return from ring 0 to ring 3, while the
other (ERETS) returns while remaining in ring 0.  Collectively, FRED
event delivery and the FRED return instructions are FRED transitions.

In addition to these transitions, the FRED architecture defines a new
instruction (LKGS) for managing the state of the GS segment register.
The LKGS instruction can be used by 64-bit operating systems that do
not use the new FRED transitions.

WRMSRNS is an instruction that behaves exactly like WRMSR, with the
only difference being that it is not a serializing instruction by
default.  Under certain conditions, WRMSRNS may replace WRMSR to improve
performance.  FRED uses it to switch RSP0 in a faster manner.

Search for the latest FRED spec in most search engines with this search
pattern:

  site:intel.com FRED (flexible return and event delivery) specification

The CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[17] enumerates FRED, and
the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[18] enumerates LKGS, and
the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[19] enumerates WRMSRNS.

Add CPUID definitions for FRED/LKGS/WRMSRNS, and expose them to KVM guests.

Because FRED relies on LKGS and WRMSRNS, add that to feature dependency
map.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Message-ID: <20231109072012.8078-2-xin3.li@intel.com>
[Fix order of dependencies, add dependencies from LM to FRED. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  6 ++++++
 target/i386/cpu.c | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c64ef0c1a28..ad3577056da 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -941,6 +941,12 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
+/* Flexible return and event delivery (FRED) */
+#define CPUID_7_1_EAX_FRED              (1U << 17)
+/* Load into IA32_KERNEL_GS_BASE (LKGS) */
+#define CPUID_7_1_EAX_LKGS              (1U << 18)
+/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
+#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
 
 /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
 #define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 914bef442c7..bfb5a25e596 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1114,7 +1114,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
             NULL, NULL, "fzrm", "fsrs",
             "fsrc", NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "fred", "lkgs", "wrmsrns",
             NULL, "amx-fp16", NULL, "avx-ifma",
             NULL, NULL, "lam", NULL,
             NULL, NULL, NULL, NULL,
@@ -1701,6 +1701,18 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_ECX,             CPUID_7_0_ECX_WAITPKG },
         .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
     },
+    {
+        .from = { FEAT_8000_0001_EDX,       CPUID_EXT2_LM },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
-- 
2.45.1


