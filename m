Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F64C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6bz-0005NK-DF; Fri, 28 Feb 2025 15:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39BbCZwgKCm8jURaQeVXTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--whendrik.bounces.google.com>)
 id 1to6bi-000580-Tg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:19 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39BbCZwgKCm8jURaQeVXTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--whendrik.bounces.google.com>)
 id 1to6bh-0001AC-7d
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:14 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-43ab5baf62cso18738865e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 12:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740773109; x=1741377909; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=kmLVEYOHqmSuKqtrlHj7xi68jyrF2grY357sctURLPY=;
 b=n79mVFztausugPlMC8wNXlE61uyMOuNv3nAb96W0doBJj+OTBIJmSStnpzjiTEqIjW
 pTmHiP4V7G7864vEcHhDn1JOW0yTKosMbIZPqqNdU8+mG7XAkNwFSSe1w2h+HaO/jIku
 6gqUYMQJg/oPSwNZq0mRJZt+yTlhxmpm3Q7vRo1eUn1ieR+flTy7NtOHb1VXyTvOmT9d
 QeExA0FUd6R9I7hbbXxKg6H2DpMuoA0ttlQJ0bocHqs6qDGbjf+tJ2EBY18W/g3XZB3O
 6RDnMskDzzR4Gy+niWN+uAcv0ZWRHIFsMTEnAvs9UoDU4B2TlGSJO3IaBPiowa55WOdc
 E6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740773109; x=1741377909;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kmLVEYOHqmSuKqtrlHj7xi68jyrF2grY357sctURLPY=;
 b=RgdDhsvUpZEDk/ADkgnQojEmelj5dnE0jST+2/GC4I3WerdEyXhO60RDrbTk6YHPbq
 yvcpTDHFHNsmiQ9kZTx1xVQNs5mha+Q4N7eINgWMgHwtTonOmdWX9vpdAE88El2lgCMi
 RsFlmI+TtUGCkNVRXVKP8WrmkzPOKKKl5NcistpesxBsZF0LW0VTQTKLijnxnULmAq3t
 V7Q5ZQc9OtBpsSJYIbAmTEoX1pfVZ+/ztDVawAwsz0LZRQMiXLecuDM/vXECEAHnO2uD
 LSFO05UUm319GSNSClTfKvsLp/pRwjbK2AeswMTILGI4cWz6icVtwWNu9FRDeIM7Y9ir
 ovRg==
X-Gm-Message-State: AOJu0YzEtwXAYIb7RzRucwMlSLjTip5Rx9G6fChoClrJeZG3DpSndJrb
 nsqoU3sGo3aJ4FDs7Y2IoevMVQnE/EVydEzEO9Pb123xyejemgyUI+TgQ+XM+91V0KTaTFE7x7K
 a5zrHd5Lj3ogAX1Jq2fLILgmVej0rlDAlpFcQdpR5olMAF3du/mqTk8ZtMM5JVD+aDgKqkxD9gR
 CObDbG0SUUNCOw1GaHFC2xAjX8Cb8VUeiprUpXv3O68w==
X-Google-Smtp-Source: AGHT+IEXDnmtHdvCU6FYxqx7SwZPQUpPbr18UkYC5JLrNcO3k2UfFjffj812/9T2Ik/o7OjQ3e5tDnnKh17anA==
X-Received: from wmbfm10.prod.google.com ([2002:a05:600c:c0a:b0:439:81e4:9ca6])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1392:b0:439:6ab6:5d45 with SMTP id
 5b1f17b1804b1-43ba6747775mr34648115e9.28.1740773108969; 
 Fri, 28 Feb 2025 12:05:08 -0800 (PST)
Date: Fri, 28 Feb 2025 20:04:51 +0000
In-Reply-To: <20250228200453.45173-1-whendrik@google.com>
Mime-Version: 1.0
References: <20250228200453.45173-1-whendrik@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228200453.45173-6-whendrik@google.com>
Subject: [PATCH v6 6/8] i386: Add RDT feature flags.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, Jonathan.Cameron@huawei.com, 
 v6-0000-cover-letter.patch@google.com
Cc: peternewman@google.com, Hendrik Wuethrich <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=39BbCZwgKCm8jURaQeVXTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
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

Add RDT features to feature word / TCG.

Signed-off-by: Hendrik Wuethrich <whendrik@google.com>
---
 target/i386/cpu.c | 33 +++++++++++++++++++++++++++++++--
 target/i386/cpu.h |  2 ++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cd06744451..6262665294 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -868,7 +868,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_EBX_CLFLUSHOPT |            \
           CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
           CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED | \
-          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES)
+          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES | \
+          CPUID_7_0_EBX_PQM | CPUID_7_0_EBX_PQE)
           /* missing:
           CPUID_7_0_EBX_HLE
           CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
@@ -905,6 +906,9 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
+#define TCG_RDT_F_0_EDX_FEATURES CPUID_F_0_EDX_L3
+#define TCG_RDT_10_0_EDX_FEATURES (CPUID_10_0_EBX_L3_CAT | \
+          CPUID_10_0_EBX_L2_CAT | CPUID_10_0_EBX_MBA)
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1062,7 +1066,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsgsbase", "tsc-adjust", "sgx", "bmi1",
             "hle", "avx2", "fdp-excptn-only", "smep",
             "bmi2", "erms", "invpcid", "rtm",
-            NULL, "zero-fcs-fds", "mpx", NULL,
+            "rdt-m", "zero-fcs-fds", "mpx", "rdt-a",
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
             "clwb", "intel-pt", "avx512pf", "avx512er",
@@ -1650,6 +1654,31 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_SGX_12_1_EAX_FEATURES,
     },
+
+    [FEAT_RDT_10_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, "l3-cat", "l2-cat", "mba"
+        },
+        .cpuid = {
+            .eax = 0x10,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX,
+        },
+        .tcg_features = TCG_RDT_10_0_EDX_FEATURES,
+    },
+    [FEAT_RDT_F_0_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            [1] = "l3-cmt"
+        },
+        .cpuid = {
+            .eax = 0xf,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EDX,
+        },
+        .tcg_features = TCG_RDT_F_0_EDX_FEATURES,
+    },
 };
 
 typedef struct FeatureMask {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6f5a3ecbd4..488126378d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -679,7 +679,9 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
+    FEAT_RDT_F_0_EBX,  /* CPUID[EAX=0xf,ECX=0].EBX (RDT CMT/MBM) */
     FEAT_RDT_F_0_EDX,  /* CPUID[EAX=0xf,ECX=0].EDX (RDT CMT/MBM) */
+    FEAT_RDT_10_0_EBX,  /* CPUID[EAX=0x10,ECX=0].EBX (RDT CAT/MBA) */
     FEATURE_WORDS,
 } FeatureWord;
 
-- 
2.48.1.711.g2feabab25a-goog


