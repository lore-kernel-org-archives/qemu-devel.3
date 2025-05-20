Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AE6C54799
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKmy-0006Z9-SH; Tue, 20 May 2025 07:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKmw-0006Xo-T1
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKmu-0002yf-VB
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEPKkKRJjj2lmXwVNX0YwsAiiOP8WMc3UNx5qDidAh8=;
 b=jAdgAGPtjCRCm8LMaCKXR2QLTJLYKfXxsoBT+RkzkemdQXKnBigpWy0aoChMo3+OgUVrFK
 wFt1v4AqSr2yC3B+SJGSo2owUroEEYsRI/94lr68DL7+17nE9W9wLOOLoGu0X2OQ8Zvhsy
 q+ZZgimeXrkFju5M7tc7S8T8ONQmkNM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-GyrXv32wO_STS4ed0F0O8Q-1; Tue, 20 May 2025 07:05:35 -0400
X-MC-Unique: GyrXv32wO_STS4ed0F0O8Q-1
X-Mimecast-MFC-AGG-ID: GyrXv32wO_STS4ed0F0O8Q_1747739134
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6002ac84dddso4161144a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739133; x=1748343933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEPKkKRJjj2lmXwVNX0YwsAiiOP8WMc3UNx5qDidAh8=;
 b=SFmEvvszFxO2GPVKXEivrRtf0lkwV9EyXAheosDJdQulUwF4R2G5zUtRNup7wJpbUj
 XP93PvFkrw4I4uW6qmhNYLLNrhfO02T9CLgqOL/BVGp19tSaSjigJHVkIq+SzMrUEbbk
 NHVQbvIRKRsbCU9lkdwQhBQCHt6uCjbvFyPkH8r3BLYdghxP0/mRCJzZg+glal5WJ4Hc
 NItZCe87e/CUXG2CSedDMPpeEzSV4/wy6ms40byFNadmCGjT45PvQqTeQ5cs62Y2NsFA
 c1466emoQsLX/oCCP5tpiPGJxVIkAyPhjTR3auPc6ccfwTGw5At5XoodU9oOqiP45+Fg
 3Szw==
X-Gm-Message-State: AOJu0YxgkwkOCj5B8CJPO/xjhJcZr8DcRY5Rb9jZE1xFHqP9X7fSqAiF
 84RINPbv/5BDnyaKRMwzV5Mn7xTpxzhx05fql5pevEzuGedLuLLNetAWLZSvUr9nKYV91kG51CJ
 f31D4aCpzjg7ikMUEvktb2CetNxIvgYXyuu+xdxBSyf0Qi6dWb/vC4zrUDoBoWC4NdmRD+geXzU
 OiIsYFkCrVvoB3iysUQwclp5K1j6NQ4h+PTkgySygb
X-Gm-Gg: ASbGncsPrlJSIch988E0jaqiIw1f5Vmi+CfGauRF+ZNB9xVtG6LhvnUVcJSebWS4+ZA
 xip05FFwc6R4NKqt+DJ4UyzjNpjMyQLOPIumxBLumXU3MqxQk6CY0hva7U0SsS/6rRayOOGfm1s
 wSxOqfZJr8V+axIxkcAOYtm7dOSrYXUkCMUvg4YpVLANHA5KdkYtR6XxHS5Wsk4+g3Tht+Ssv3Z
 w8kTXk2smdcgpznEFY2B48TMWJyU5G7VPJEiOdURG8EUR5Eozgi3ZjSIOSWaQAM/+jKt3lDJivJ
 ChnJ1uDBtuk6aw==
X-Received: by 2002:a17:907:7f08:b0:ad2:549b:4c8d with SMTP id
 a640c23a62f3a-ad52d604c1cmr1335556866b.51.1747739133388; 
 Tue, 20 May 2025 04:05:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjxXsIo/cAWS+nwnkY0amfX5EwHFCf6Yuhq9jjSmUnF99BWM0V1UEBOi5G2J861EF/sTdQNg==
X-Received: by 2002:a17:907:7f08:b0:ad2:549b:4c8d with SMTP id
 a640c23a62f3a-ad52d604c1cmr1335553066b.51.1747739132855; 
 Tue, 20 May 2025 04:05:32 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4382f8sm723576666b.94.2025.05.20.04.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: [PULL 01/35] i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG supported
Date: Tue, 20 May 2025 13:04:56 +0200
Message-ID: <20250520110530.366202-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Since commit c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in
x86_cpu_expand_features() instead of cpu_x86_cpuid()") and
commit 99a637a86f55 ("i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
env->features[FEAT_8000_0001_ECX]"), it gets warnings when booting the
VM with vcpus >= 2 and with tcg:

  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.cmp-legacy [bit 1]

This is because, after the two commits, CPUID_HT and CPUID_EXT3_CMP_LEG
are set in env->features[] when vcpus >=2 (in x86_cpu_expand_features())
later in x86_cpu_filter_features() it will check against the TCG supported
bits. However, current TCG doesn't mark the two bits as supported, hence
the warnings.

Fix it by adding the two bits to the supported bits of TCG since multiple
vcpus are supported by TCG.

Fixes: c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of cpu_x86_cpuid()")
Fixes: 99a637a86f55 ("i386/cpu: Set and track CPUID_EXT3_CMP_LEG in env->features[FEAT_8000_0001_ECX]")
Reported-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250514031652.838763-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ec908d7d360..9689f6374e6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -776,11 +776,12 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
           CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
           CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
-          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
+          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE | \
+          CPUID_HT)
           /* partly implemented:
           CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
           /* missing:
-          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
+          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_TM, CPUID_PBE */
 
 /*
  * Kernel-only features that can be shown to usermode programs even if
@@ -848,7 +849,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
           CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
-          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES)
+          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES | \
+          CPUID_EXT3_CMP_LEG)
 
 #define TCG_EXT4_FEATURES 0
 
-- 
2.49.0


