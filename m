Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650D1D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o0i-0007ct-W5; Tue, 29 Oct 2024 11:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o08-0005l8-6t
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o05-0000Ql-Gq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iqwu/d/vVs0Cnefe08Zu3g6DyPdDcSfsVDU4s2l0BtY=;
 b=eWLC2UPagQIpftiHtIxK5shMco5nIWpqPxBGNrgPqQlmwgWhJRU2fmRv6F71GPXf5R25Zt
 HWMJe3d7RyBdlQbt4wPxm/+ILbAS3m4xwxRmqNNvyOLLVtLH2gdovHiCKOqfTOvUkuOy3M
 5sz9dVADVYZb3QDmR8p8HmUU/ILCZ7I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-p1Nrhv3PNeykDaP9DZ3K6w-1; Tue, 29 Oct 2024 11:19:14 -0400
X-MC-Unique: p1Nrhv3PNeykDaP9DZ3K6w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d52ca258eso2984244f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215153; x=1730819953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iqwu/d/vVs0Cnefe08Zu3g6DyPdDcSfsVDU4s2l0BtY=;
 b=vxZy3wo1xa5lCMyt3Vvr/Ig2aFPZVK3ePdLBUtRV6pDRxf+Xxn7d38YxCIAE5oL+Lp
 10bOHt526xIHh0lVPg6GpvtKqhpQQ3fyd+sWpj/UYTert4lcS9nFqhkkFj7rgvPmFeKw
 DLDO8UHP86BlvOj9O//nJLUcR8EXbbeAaQZP/3vBIvSgteBHgXr1j1akDiVTFfyac7Z6
 Y7hKhdJ3j7PlJGvmo7TCmNN/c9PGDxbJwl2KkYwzfH43wS4HhoKS1jXTQipR6x8nQTeM
 uGEKkUzjiM0o0917V1eBFYRomTZVrB2fCAxah8ZpKflAJEYAG6wo0ODik8HY8OL3tKz/
 txvA==
X-Gm-Message-State: AOJu0Yz0u6RBOvvduZmldRcUu1U7Y0xCOrFIa4PKbql5s2X7daWz0Tkc
 QMzT5sKyidv/ocv9HsMmcJo6/fUoocFutm/aNZGo8T1as3Pq/1OnXj2D24Ob5A1sKoxSbA0I/G5
 SUGwqjgbqHdyADVPIMWQY/K0PabJelaAPP/HrK27jfSZW5uvd3xYLmiTkeAecCZXB3NaNNpSKTc
 rt7V2BrNIihB9JN8w1EdLoydjpGno+H7S3LrCn0Pw=
X-Received: by 2002:a05:6000:ac1:b0:37d:3280:203a with SMTP id
 ffacd0b85a97d-381b7057644mr33351f8f.10.1730215152842; 
 Tue, 29 Oct 2024 08:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyRkkN3T57Xw3R83w57A719dOnWaF70XOz5sMw1ShQMcHHQ/15AinK0icAmoal8xCmkPUdJA==
X-Received: by 2002:a05:6000:ac1:b0:37d:3280:203a with SMTP id
 ffacd0b85a97d-381b7057644mr33331f8f.10.1730215152425; 
 Tue, 29 Oct 2024 08:19:12 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b4ad08sm12792202f8f.64.2024.10.29.08.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:19:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com,
	zhao1.liu@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH 5/8] target/i386: add CPUID.24 features for AVX10
Date: Tue, 29 Oct 2024 16:18:55 +0100
Message-ID: <20241029151858.550269-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029151858.550269-1-pbonzini@redhat.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Introduce features for the supported vector bit lengths.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-3-tao1.su@linux.intel.com
Link: https://lore.kernel.org/r/20241028024512.156724-4-tao1.su@linux.intel.com
---
 target/i386/cpu.h |  8 ++++++++
 target/i386/cpu.c | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 72e98b25114..f8f97fe9330 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -665,6 +665,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
+    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -993,6 +994,13 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* AVX10 128-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_128        (1U << 16)
+/* AVX10 256-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_256        (1U << 17)
+/* AVX10 512-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_512        (1U << 18)
+
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fdbfcc59da4..3f7fed8e485 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -901,6 +901,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EAX_FEATURES 0
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
+#define TCG_24_0_EBX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1166,6 +1167,20 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
     },
+    [FEAT_24_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            [16] = "avx10-128",
+            [17] = "avx10-256",
+            [18] = "avx10-512",
+        },
+        .cpuid = {
+            .eax = 0x24,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX,
+        },
+        .tcg_features = TCG_24_0_EBX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-- 
2.47.0


