Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85842D767F6
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNv-0005mC-78; Thu, 31 Oct 2024 13:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZN0-00031u-LB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMz-0007UJ-27
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0YNaMgrK6T8XHe5FTddjNKEZY5EX0fxm0EqQLnMbu4=;
 b=Xfkc0gwjzN+dLdhEQ0qjuXsRA2tmwEP3qWX2baqP8Bvu0kyp3C/D15msliVhUAAem1nB78
 1mxSu1+CGua/ownmltbJx6cyCHUGfVmH+rOFHT6A2sDaAROvAnlrkB76Gn0ZpvUcZfHcB0
 mR/bJxm54vz3ktD9xQpb5q+UkOKG8rA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-slbGntrQMGWhfoYPfHDTXg-1; Thu, 31 Oct 2024 13:54:02 -0400
X-MC-Unique: slbGntrQMGWhfoYPfHDTXg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315dd8fe7fso9848585e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397241; x=1731002041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0YNaMgrK6T8XHe5FTddjNKEZY5EX0fxm0EqQLnMbu4=;
 b=o0I6VfQ9hRYHnjt/XTYKbO1oOBzbXuVLbCzGRLT3Hj+gzQ6KHNnCG28+U2g3zKpHN6
 nk7ITmVyXg7gm2L8HnCAHnXQsW4hec6fwzf/WN3ycPM1BvQuhQz+aD9/wOzmI+IiRA0d
 5HelfobqEeNeSeRcANrCwPy1Swp1ASGE8iXQG/L7/SKRyBiwZIRLNaPHvhj3PbsksR1v
 o0ls37KaA3FYhPbO5FuJKRYzugfGgSe+r80bF1EGbpF0Nf3je0d7s2yf+JYu/quVKC4Q
 JARaqpAaytQl1ZM9o/IlCLcAkOzORMe8MPQ7XUHT9CtwlL+1stcoJ84a0KrO3QRUr7AY
 Jpsw==
X-Gm-Message-State: AOJu0YxjMbuaBqgIIb+XwXupezK+a31h+lKB9SDjy4c7ivcUOai63tGR
 S77A2IQ2V2QGBiaVUT5QdS0ucKdmukOSnZrjvtyvqzI2Tf4D1iCa2khM6EbU4mlQ7VBmpjnJeks
 XwWg2hmym8LUZVEVzftEncREJq3oEixbwcmGfmhN0dBfB/6dHeM+dHB6U+f7GQnMcs7b6M019VD
 G99iWSe/7fUeEsMXYHY1EmrJR/nRgIWkv6To8euZ4=
X-Received: by 2002:a7b:c459:0:b0:431:5f8c:ccb9 with SMTP id
 5b1f17b1804b1-43283255a2cmr8938755e9.17.1730397240725; 
 Thu, 31 Oct 2024 10:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsV7zqMOs6TNX+8XYyZLj3BHogW7DgG4pz9J7MyjboCtb8dGdxKphEDaYmiwleLZvO+JNAag==
X-Received: by 2002:a7b:c459:0:b0:431:5f8c:ccb9 with SMTP id
 5b1f17b1804b1-43283255a2cmr8938515e9.17.1730397240263; 
 Thu, 31 Oct 2024 10:54:00 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9aa611sm64164425e9.34.2024.10.31.10.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>, Xuelian Guo <xuelian.guo@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 47/49] target/i386: Add feature dependencies for AVX10
Date: Thu, 31 Oct 2024 18:52:11 +0100
Message-ID: <20241031175214.214455-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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
Link: https://lore.kernel.org/r/20241031085233.425388-7-tao1.su@linux.intel.com
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
index 3731155c2d5..d056285a034 100644
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


