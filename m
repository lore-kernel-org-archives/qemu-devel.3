Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4496E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Rb-0008UI-0C; Fri, 13 Dec 2024 12:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3am5cZwgKCvkxifoesjlhpphmf.dpnrfnv-efwfmopohov.psh@flex--whendrik.bounces.google.com>)
 id 1tM9RY-0008T3-5Q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:12 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3am5cZwgKCvkxifoesjlhpphmf.dpnrfnv-efwfmopohov.psh@flex--whendrik.bounces.google.com>)
 id 1tM9RU-0007qy-QK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:11 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so4807785e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734110827; x=1734715627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=yrlaSRZ8054fQhMNBYWcK8NfFEF1eZz8tbpXey1V4pI=;
 b=Lf+e2c979bY9R5Ft8UicjZqLS80RbJnP7BODBNImlKZO/rGXEHoQrirkOcHx5r8cMr
 4c0fqI4603KBiyN9iprZJQ9FkBhbrgX8o/V9Lwu+hJT/rGbx7iJKDTIhEp+q7CR3qELd
 SFMA4XBuy8Y5DRCh92rCcm8sy3dbRzv8wTV/QurGsdj/Yq+QTLJA9CfRjOdKiIw5gZJ4
 xXRbAx+RI27hZgYojSm7VB6ockVv/YJiu4+2BY/lZ0O1EQM8Sks3mEVXbwwDG7a+bpmw
 Mqgi1tLyKXkksI7RxXqjG25qIAkstkHh98ZNco7KTw09iz0/YNCz950W/dLEM5Zfp/r2
 e1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110827; x=1734715627;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yrlaSRZ8054fQhMNBYWcK8NfFEF1eZz8tbpXey1V4pI=;
 b=izmpDpfnGmKPs+3cjvh///A9JkbAl+cFUCBklJKegbOEZvei73mJVSGFB3nWq3ibQl
 RsIOaVVcdv3qnTWssbJPEB/nxld/D6DfHaJC3YAtBijO7GFmGatl4+fJsKarpJ89Rqfa
 GIqfUNsoteO85wZnHM7zLpcWnMMsWSat63vL6oAZp041P5pwYKoMh9wd+p0W3zt2epv0
 rm2lxnn8McwUG4AjiK2RwqrnvCblISUl3ewlYxqeNaU2HLfIhMrKqRTiba3H6BnLxJWd
 0zhJ9bdtxHti3Zws07Fx7ajE55SgPLPVK7Nvi62jmo4lNOqn1JkydbqJ4D6bgRsJnOiT
 SlDA==
X-Gm-Message-State: AOJu0YzYn60XKsPPXGGSBtfeBu8Ne6KUbPC949sUlY9WUi/fUjEdutIQ
 KLmhW2gLZwIo/ri2AS0EoV/rmwLK7b/O4pig6k68A0iOxtAa6dik7Qemf72Jdrnd5HwHX8Y18Er
 i2akk5NuvagiGZxi8JaxB+BTixKFX7oWKuGA+jEvVbO0j083xnTHmJ6AJqxmlgZNfoFC7I0wkdg
 nRsY1N3KeuMiiIvfsydo3kd5mObgTynp7YIdNNzH561Q==
X-Google-Smtp-Source: AGHT+IF1uhcvW9S0LazRXQZHbdrAITOaDVFpxoz+PguqWxBwML68Z6leHlztMWP9/O+shy9MpFS0Upj179NJMw==
X-Received: from wmot11.prod.google.com ([2002:a05:600c:450b:b0:434:fc6f:e8c3])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f4f:b0:436:346a:fa9b with SMTP id
 5b1f17b1804b1-436346afda1mr11215495e9.20.1734110826981; 
 Fri, 13 Dec 2024 09:27:06 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:43 +0000
In-Reply-To: <20241213172645.2751696-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172645.2751696-7-whendrik@google.com>
Subject: [PATCH v5 6/8] i386: Add RDT feature flags.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3am5cZwgKCvkxifoesjlhpphmf.dpnrfnv-efwfmopohov.psh@flex--whendrik.bounces.google.com;
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Add RDT features to feature word / TCG.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 30 ++++++++++++++++++++++++++++--
 target/i386/cpu.h |  2 ++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6e6cff19d..6f14d6fc62 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -869,7 +869,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,
           CPUID_7_0_EBX_CLFLUSHOPT |            \
           CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE =
| \
           CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED |=
 \
-          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES)
+          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES | \
+          CPUID_7_0_EBX_PQM | CPUID_7_0_EBX_PQE)
           /* missing:
           CPUID_7_0_EBX_HLE
           CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
@@ -906,6 +907,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
+#define TCG_RDT_F_0_EDX_FEATURES CPUID_F_0_EDX_L3
=20
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1063,7 +1065,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =3D =
{
             "fsgsbase", "tsc-adjust", "sgx", "bmi1",
             "hle", "avx2", "fdp-excptn-only", "smep",
             "bmi2", "erms", "invpcid", "rtm",
-            NULL, "zero-fcs-fds", "mpx", NULL,
+            "rdt-m", "zero-fcs-fds", "mpx", "rdt-a",
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
             "clwb", "intel-pt", "avx512pf", "avx512er",
@@ -1651,6 +1653,30 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =3D=
 {
         },
         .tcg_features =3D TCG_SGX_12_1_EAX_FEATURES,
     },
+
+    [FEAT_RDT_10_0_EBX] =3D {
+        .type =3D CPUID_FEATURE_WORD,
+        .feat_names =3D {
+            NULL, "l3-cat", "l2-cat", "mba"
+        },
+        .cpuid =3D {
+            .eax =3D 0x10,
+            .needs_ecx =3D true, .ecx =3D 0,
+            .reg =3D R_EBX,
+        }
+    },
+    [FEAT_RDT_F_0_EDX] =3D {
+        .type =3D CPUID_FEATURE_WORD,
+        .feat_names =3D {
+            [1] =3D "l3-cmt"
+        },
+        .cpuid =3D {
+            .eax =3D 0xf,
+            .needs_ecx =3D true, .ecx =3D 0,
+            .reg =3D R_EDX,
+        },
+        .tcg_features =3D TCG_RDT_F_0_EDX_FEATURES,
+    },
 };
=20
 typedef struct FeatureMask {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a1ec2d5dde..2b5a5986de 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -678,7 +678,9 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=3D7,ECX=3D1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=3D7,ECX=3D2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=3D0x24,ECX=3D0].EBX */
+    FEAT_RDT_F_0_EBX,  /* CPUID[EAX=3D0xf,ECX=3D0].EBX (RDT CMT/MBM) */
     FEAT_RDT_F_0_EDX,  /* CPUID[EAX=3D0xf,ECX=3D0].EDX (RDT CMT/MBM) */
+    FEAT_RDT_10_0_EBX,  /* CPUID[EAX=3D0x10,ECX=3D0].EBX (RDT CAT/MBA) */
     FEATURE_WORDS,
 } FeatureWord;
=20
--=20
2.47.1.613.gc27f4b7a9f-goog


