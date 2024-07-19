Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944E1C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVW-0004R1-It; Fri, 19 Jul 2024 13:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fZSaZggKCkwAvs1r5wyu22uzs.q204s08-rs9sz121u18.25u@flex--whendrik.bounces.google.com>)
 id 1sUqUd-0003RB-7x
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:30:03 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fZSaZggKCkwAvs1r5wyu22uzs.q204s08-rs9sz121u18.25u@flex--whendrik.bounces.google.com>)
 id 1sUqUX-0004ZV-R3
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:30:00 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-42725d3ae3eso13917935e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406590; x=1722011390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=IoNUsPYmgHKzmPR7JWJUwxpa2sExJSFmT0g3Tjq5GOc=;
 b=ztoUa8lBCPaV01bKW3MHNVZ7DO/eLfpXaf9MW0JaorvjoJOOWuoqypakuB5Ik3h6JZ
 /liQjGIkO5Dz1jgK+2KKO7vyHPfaHzYPrPB4AE3Hfbo6ePkkM/VlWvs2X+aCgVU6MSiv
 euzg0FfDlqCPIPUiTeLWVzoccPyqJ+F2EEkejjSmkxc6mXHkREyIRMUr2r1aPjqa8wGc
 Te67LrsgloBbQfM+v//vgV82fShBtRil79+c4kkwGKOuJ6ND/PtW5z3GnECbAWqiUg8b
 sST3X37AxaXAjp5AfivMCmy7d/Srtxa6m+WJHeuYgFmFU+QO+S4OVM16CV76iJkagDX8
 6Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406590; x=1722011390;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IoNUsPYmgHKzmPR7JWJUwxpa2sExJSFmT0g3Tjq5GOc=;
 b=f2/8/+cqmBRPqqphVIERSDNJ6y2fifgoTUJZ42y+bu3IdXE98bwBZcK0nxCHmHcIPM
 3nGxzEwm1jDWk2T4eIRQZXYVGOnM/n5juLZpsLKRSWlKvAgVRy0hu/mDve0i37Dr22lE
 AtiwPfyIb3h7m8SuzrSvfUFyoxVqnIbbihtX/L744mh8XsCV1SSjGzIZsFtfVC7p8438
 UG2GLyj+S5Y0MX/azzjFQyx5jv9F2idII4+sYIZ6QtjI4OEIuqCBSNcu6HRpxVz5tzx8
 BqMvpRCXzrA/1I/Yd7W/BEXcLmZUEWmZCwRfryU1nb123iCGm90+z09dQekdsv+ffHfW
 w7ug==
X-Gm-Message-State: AOJu0Yw+OBBGzrE3ocMtRB9k+CkGlu/FtBeQDScHcwi5+MP99IK1sbb9
 dEikti3WWrB99pC0edO2cKCZ4DIsWb75/g+gqfISz812OK8lPh7cd2msZR/71ZO5RNMGRSeLpfb
 NveITVMFih5vpKb0eZkoXoSU2X/jI5FSsYlGxnw+oYnCoChKMMKmHORwhL4ym8Dm7BjVjHG83aD
 omfKOa3jamQoIXwNKeWJ0g8ZoL1nqhSblCdUOyfnhqlw==
X-Google-Smtp-Source: AGHT+IEcAWmxhWNNuP9Js5a/LU2TuakOKOVQv2oo0CgQUIQ4sbrPFZLKWsEQnzZLpJM665bSO8N8UwnBV2FMQw==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a05:600c:1592:b0:427:d8f1:e29e with SMTP id
 5b1f17b1804b1-427daa67d64mr335e9.8.1721406589675; 
 Fri, 19 Jul 2024 09:29:49 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:27 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-8-whendrik@google.com>
Subject: [PATCH v1 7/9] Add RDT feature flags.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3fZSaZggKCkwAvs1r5wyu22uzs.q204s08-rs9sz121u18.25u@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:50 -0400
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
index c61981bf82..1cf5e5d5ff 100644
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
index 12a4b989af..bf2f3c07a7 100644
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
2.45.2.1089.g2a221341d9-goog


