Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070A6E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl48-0000GK-Ct; Wed, 04 Dec 2024 03:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dxdQZwgKCigaLIRHVMOKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--whendrik.bounces.google.com>)
 id 1tIl46-0000Dr-AY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:58 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dxdQZwgKCigaLIRHVMOKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--whendrik.bounces.google.com>)
 id 1tIl44-00011p-O3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:58 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-434941aa9c2so36880235e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302135; x=1733906935; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=g/43FrCAIP7tilQQ4ftObjxWWc8+9Zv1Klu0cOiIC/o=;
 b=H48f93johlmib/bSicqjm0IWnsKuYskvohoCPdRmwYVC6/2QDhOxq24V5N4LDNyHkY
 aYzLMBRitJLhnYwX3FjBJUZG5Wrsrj0J3iQOxOWERA9rEORIDuX1L0xR0Is2Byp9qqgS
 MOoo+eBiMt46BFrs+yskgOENlPj7hVUXJXmx49gglDhSp7Zg980nzr2N7jaFY9BKU36H
 6UNnfElVFMwVIfS5VXK1yhQOUrW1/imIK16GotObPas+EI8SxYejn7jHhGFIjauPONzS
 1/9qxpBA3BYjOlLNvObx+yF2Lnaw9wOK2Wz2Rxd3/zCfw7V8nJklDtkr042GmuF5BnsP
 yWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302135; x=1733906935;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g/43FrCAIP7tilQQ4ftObjxWWc8+9Zv1Klu0cOiIC/o=;
 b=mDz2Qg2oIC5ybycz3Ed3r4cX2eTtHWx721EV9oatqWL9rDL4ayTBb3lR6x5uYf1VDg
 XB4BEAsjmBHYDG8x/jAU9VOXRCPnNrWxjpDL61UhjuBlL5GePJBgmbVZk131nbbZ+hHZ
 GoHZSeweLPU5+7wMZ5hHfA0Axv35n+H2Vw0bqhHXaVMDI+xO1SuKEGvAX4AxPViHt9A9
 nik9eRcBMrmefPWVSe8rsBQR/pBLPFAtoA9NgFgExa4o0kzj3HolC4KuOeebxFgfFk9h
 kFekdEw6ZoU3xSmCBWPyz8teF0z9jV62s5n5hasiS7L8Z5MxUtT8RpnnanLl9pbMnhAJ
 wmHw==
X-Gm-Message-State: AOJu0YwKK0NsQmtj2SaVhteifRprQ7SWZId1tguNZsxImaub2dNtdxp1
 YVYLyRlBGDGBk8ml46l1nVAK4EPY4PSLVSm8MNA2ZXbfluzFS6n8v/5nkJDLy4lPfhXYvNedmZL
 1Sr2GyryNR9aQdz+7mnvXpsP9vQYiD6HRK/zTRCDN71Mbt+V/oPuUOhdhTh2orBZfF1GM5S2E1o
 jI7RjIwdWLG6DhczCfqzOqzuN2YXmBRzj9aKi2ta1bnA==
X-Google-Smtp-Source: AGHT+IEoNa5lbp+yB1lR8X3nOxTj/60abWf03MIdC0rAKhGdBI8uy3ygNFy9BrLG0Xh97u9Okc/IA3p8QvoNRA==
X-Received: from wmjy25.prod.google.com ([2002:a7b:cd99:0:b0:431:1c66:db91])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed0:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-434d3fae263mr30023885e9.18.1733302135205; 
 Wed, 04 Dec 2024 00:48:55 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:35 +0000
In-Reply-To: <20241204084837.517299-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241204084837.517299-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-7-whendrik@google.com>
Subject: [PATCH v3 6/8] i386: Add RDT feature flags.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3dxdQZwgKCigaLIRHVMOKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
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
index a8198fe5a7..af1da35985 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -864,7 +864,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
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
@@ -900,6 +901,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,
 #define TCG_SGX_12_0_EAX_FEATURES 0
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
+#define TCG_RDT_15_0_EDX_FEATURES CPUID_15_0_EDX_L3
=20
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1057,7 +1059,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =3D =
{
             "fsgsbase", "tsc-adjust", "sgx", "bmi1",
             "hle", "avx2", NULL, "smep",
             "bmi2", "erms", "invpcid", "rtm",
-            NULL, NULL, "mpx", NULL,
+            "rdt-m", NULL, "mpx", "rdt-a",
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
             "clwb", "intel-pt", "avx512pf", "avx512er",
@@ -1607,6 +1609,30 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =3D=
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
+    [FEAT_RDT_15_0_EDX] =3D {
+        .type =3D CPUID_FEATURE_WORD,
+        .feat_names =3D {
+            [1] =3D "l3-cmt"
+        },
+        .cpuid =3D {
+            .eax =3D 0xf,
+            .needs_ecx =3D true, .ecx =3D 0,
+            .reg =3D R_EDX,
+        },
+        .tcg_features =3D TCG_RDT_15_0_EDX_FEATURES,
+    },
 };
=20
 typedef struct FeatureMask {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1520a93927..b9d78f4d4e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -673,7 +673,9 @@ typedef enum FeatureWord {
     FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=3D0xd,ECX=3D1].EDX */
     FEAT_7_1_EDX,       /* CPUID[EAX=3D7,ECX=3D1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=3D7,ECX=3D2].EDX */
+    FEAT_RDT_15_0_EBX,  /* CPUID[EAX=3D0xf,ECX=3D0].EBX (RDT CMT/MBM) */
     FEAT_RDT_15_0_EDX,  /* CPUID[EAX=3D0xf,ECX=3D0].EDX (RDT CMT/MBM) */
+    FEAT_RDT_10_0_EBX,  /* CPUID[EAX=3D0x10,ECX=3D0].EBX (RDT CAT/MBA) */
     FEATURE_WORDS,
 } FeatureWord;
=20
--=20
2.47.0.338.g60cca15819-goog


