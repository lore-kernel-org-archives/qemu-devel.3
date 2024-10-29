Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AA8D3A66C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o0c-00071W-ST; Tue, 29 Oct 2024 11:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o0B-0005p5-3B
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o08-0000R2-OJ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCtUFyK+kuTAMXmk4mVAgW2xN+DwNT3py4Wk7BWJKOA=;
 b=OPL52i+cuZdN+5BcnzyIg/vyJPkxoT/FZKworIGtbclOyIBOQiNFCpNtDlIoGkaglJFdDr
 EJ//mztxX3AQ2TOpcKR2aU0FP4dykHocWrL1MAVswQWVbPjteqgNcN21hBu4rRRMjUHE9k
 2DYhxx6E/Vq7tSNAMqfQAp5uCrQEEXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-8hwoI_RYOpCt6wDpN8iJ6A-1; Tue, 29 Oct 2024 11:19:18 -0400
X-MC-Unique: 8hwoI_RYOpCt6wDpN8iJ6A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so36383025e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215156; x=1730819956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCtUFyK+kuTAMXmk4mVAgW2xN+DwNT3py4Wk7BWJKOA=;
 b=d/+mgRLMdlaHdqrh7B8wZz7WIfsNDZ3tPOcAAERWGwgvB5ig2p1mDWLO3oXKDXV1ab
 YrLIfbCyKrq4umuHaySWGAkQH8GV0MJFJ1fOz/Za9fsOs+6WAOTKMT8VJWap2nn+Ijmr
 lXDjzdmFdyPA+A1AeU9/WJTH8QZrulERd9WSPTtJV+uqxfeOgivKnC0T3ZJs0+fBC8uS
 Igmb1OgLzX4KmISHCT1+oR0iEU0rlaSficZKpPLL1ZgvVQGW4/cgZvtCATe1DM2nP/vi
 1Mr9I34klOZ8DhwsPx/+joxjY6pb8l27CYwykY9yiOJKL1AWAKYqu75vMSopz2yx6rdg
 1kHA==
X-Gm-Message-State: AOJu0YxjUTLQLKNYOMBtBfm9bydl5zwto5Ds3VrMskRCCAsBNA2/th29
 8hWrptEOb2JnWOhiwvpq3HFKIeIrqLwjHHsA1FsIk1xSUZA+K57r548sq3SdorHkyogXUvDghE7
 99QStKvm8yczxVJVUJTO8+NKMQvxzhq0NEHUH9pgW/ChdikW+btADJ+35Aqrd+T/AWfjzFUQ9PY
 J4yvWdcRrqC8McMVBRwKCu6LMxDULzsQkh4vFY8PI=
X-Received: by 2002:a05:600c:3ba3:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-4319aca2cfemr107067325e9.8.1730215155911; 
 Tue, 29 Oct 2024 08:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfjRYtjIbTJ3xK4do98iY+2IIN5B9ujMq3I3QBP42ZHBFQvo/RcwMmi0K7gxPMooVXaxky8w==
X-Received: by 2002:a05:600c:3ba3:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-4319aca2cfemr107067035e9.8.1730215155411; 
 Tue, 29 Oct 2024 08:19:15 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319357291bsm150316025e9.2.2024.10.29.08.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:19:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com, zhao1.liu@intel.com, xiaoyao.li@intel.com,
 Xuelian Guo <xuelian.guo@intel.com>
Subject: [PATCH 6/8] target/i386: Add feature dependencies for AVX10
Date: Tue, 29 Oct 2024 16:18:56 +0100
Message-ID: <20241029151858.550269-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029151858.550269-1-pbonzini@redhat.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tao Su <tao1.su@linux.intel.com>

Since the highest supported vector length for a processor implies that
all lesser vector lengths are also supported, add the dependencies of
the supported vector lengths. If all vector lengths aren't supported,
clear AVX10 enable bit as well.

Note that the order of AVX10 related dependencies should be kept as:
        CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
        CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
        CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,
        CPUID_7_1_EDX_AVX10          -> CPUID_24_0_EBX,
so that prevent user from setting weird CPUID combinations, e.g. 256-bits
and 512-bits are supported but 128-bits is not, no vector lengths are
supported but AVX10 enable bit is still set.

Since AVX10_128 will be reserved as 1, adding these dependencies has the
bonus that when user sets -cpu host,-avx10-128, CPUID_7_1_EDX_AVX10 and
CPUID_24_0_EBX will be disabled automatically.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-5-tao1.su@linux.intel.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  4 ++++
 target/i386/cpu.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f8f97fe9330..59959b8b7a4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1000,6 +1000,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_24_0_EBX_AVX10_256        (1U << 17)
 /* AVX10 512-bit vector support is present */
 #define CPUID_24_0_EBX_AVX10_512        (1U << 18)
+/* AVX10 vector length support mask */
+#define CPUID_24_0_EBX_AVX10_VL_MASK    (CPUID_24_0_EBX_AVX10_128 | \
+                                         CPUID_24_0_EBX_AVX10_256 | \
+                                         CPUID_24_0_EBX_AVX10_512)
 
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3f7fed8e485..4c86a49ad05 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1787,6 +1787,22 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_SGX_12_1_EAX,          ~0ull },
     },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_128 },
+        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_256 },
+    },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_256 },
+        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_512 },
+    },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_VL_MASK },
+        .to = { FEAT_7_1_EDX,               CPUID_7_1_EDX_AVX10 },
+    },
+    {
+        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
+        .to = { FEAT_24_0_EBX,              ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
-- 
2.47.0


