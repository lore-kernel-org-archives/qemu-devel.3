Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DB6D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZOJ-0006yp-GN; Thu, 31 Oct 2024 13:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMy-0002pt-4K
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMw-0007U3-Es
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwsAwXnW7rGmyJj9TrexgSkiOGAvONt/ljWV1qqucIE=;
 b=VBpMJzuECyOJzb0PGpfrh3uGHjHOPRMjoZi2CHlqj/e1sJHSwDgIpSeK5zLGA9FFDsoUFq
 Pz4Q/8qOCYcYn9MSWLJa94DBj1Gh54TQLqXBgsPe8O3bO4a+9u6uap/dtpvhHN5fL/HxII
 vfIn/tqXQFAQbKLtvPNXbg6k/vkkxqw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-V3MSxaaJP1qxaa6XAFK79Q-1; Thu, 31 Oct 2024 13:54:00 -0400
X-MC-Unique: V3MSxaaJP1qxaa6XAFK79Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso7621795e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397238; x=1731002038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwsAwXnW7rGmyJj9TrexgSkiOGAvONt/ljWV1qqucIE=;
 b=F9xBptIrPCXmSWOIhiKUg6plNqM3/goHSJCga4R5b8yGJ0mHjuhsRTfM+u4qqoMiZ0
 tuPxjv0B0egEL5E1nPjI1cuz1mvInhABT85cC4LmsKmMBaTcKg3QYUtB9YZk/aoZmaSC
 rpnyZ688PCOxEz4Brhmzt2V1gi8INTJ6a/anMYUkYYTqjBaZtwzSpsIFIhL7Jp/v+4IG
 Y+0MNB8pVIb/q9YsBRBZcUKP4fGDP2abeC7TIOFB8DLx5/BGr7x6KiS3G5P4IG96sD9l
 w+8ZUv3P+shOzHkRIXD0rv21zpjL3LlMREZHfPmlvKmQrokAlamCDh6POdq5sL/TmjHi
 bhOQ==
X-Gm-Message-State: AOJu0Yy1qZLEPGJ9PypG+MwIisaukRbIgv3MCpGMC1cW8DRP/E4ltqjt
 NQdvyq9s0rWrKa7QcCDU2zisVNGz1I/SjhX4pm2giDqujlhrP9D3fQC1je521uf/DzBGbh8Hpcm
 KK428to/4q9wNG10YRkU6BVTvEiac9ytVM+oY8hX599AzM2W2yuiaz1OWDw+F5XuWKPDGIjdUj4
 s86YVQvS+4+fDG6zaeUdZy9rarSlDUvCnpgiebVew=
X-Received: by 2002:a05:600c:1d27:b0:431:52a3:d9ea with SMTP id
 5b1f17b1804b1-432831c1ff1mr6595595e9.0.1730397238618; 
 Thu, 31 Oct 2024 10:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsrl8CLcWcj/3x2QO7jM7GiR7+4rw0KJ3maDYjA9xzBhZfIIhh3J7dR7+bayCpw7EmDrblFw==
X-Received: by 2002:a05:600c:1d27:b0:431:52a3:d9ea with SMTP id
 5b1f17b1804b1-432831c1ff1mr6595435e9.0.1730397238183; 
 Thu, 31 Oct 2024 10:53:58 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9faesm64524515e9.35.2024.10.31.10.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Xuelian Guo <xuelian.guo@intel.com>
Subject: [PULL 46/49] target/i386: add CPUID.24 features for AVX10
Date: Thu, 31 Oct 2024 18:52:10 +0100
Message-ID: <20241031175214.214455-47-pbonzini@redhat.com>
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

Introduce features for the supported vector bit lengths.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-3-tao1.su@linux.intel.com
Link: https://lore.kernel.org/r/20241028024512.156724-4-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Link: https://lore.kernel.org/r/20241031085233.425388-6-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 681c04e056e..3731155c2d5 100644
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


