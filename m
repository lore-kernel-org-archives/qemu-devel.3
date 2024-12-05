Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36842E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI26-0002wE-W3; Thu, 05 Dec 2024 15:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZwZSZwgKCvw0lirhvmoksskpi.gsquiqy-hiziprsrkry.svk@flex--whendrik.bounces.google.com>)
 id 1tJI1l-0002sa-Hd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:47 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZwZSZwgKCvw0lirhvmoksskpi.gsquiqy-hiziprsrkry.svk@flex--whendrik.bounces.google.com>)
 id 1tJI1j-0001eO-EJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:44 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-434a6483514so9134535e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428840; x=1734033640; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=7qkRo9GTsyKbClSjG0dkX08UrT2dSZJ8wMtYShWt/zI=;
 b=Z+uG5nOzNN+/zBPbSnwsF3mpP2D5A1AlJ+9QGG5pTjCU/Ow25p1CslCVdk7f/nltjs
 HyCFoUyiYUpmwV4nlBmUaaEDMuTU1KhUjujji13q/W8ehhBTveX/xaPFkIjMBrOSUYQB
 egJbGED9RaPmJu7gdqk8ZNzYo+B2Y351X8oU0vZIiZji4VXdV5PdDZdUwKHnHUVhKCni
 7M9L22k7/Fwp2OLbYDxXhsOXW8AIw/jDzkZU1X9UOVGfo+bqCZsEJiAa1JRYTtvOM1PS
 II1qMdMVRDuP30FJuNl9eMe3TUaeMVpbu/Vf6TyIdvsGpBs7AlwA1eW7zNzEQCdtTIE1
 iSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428840; x=1734033640;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7qkRo9GTsyKbClSjG0dkX08UrT2dSZJ8wMtYShWt/zI=;
 b=e7+6qt8W1qw4FJiVp31VfDhQ/EvMfq9GRVN/9EMpyfCbxh3SXGXJeTtWffNgUAiYty
 wooh2M5zpSf4QnQERdPqhBUZK9dqnQThcuhJchfIWTkt3Z+7k/XS1SOZtX3I2j+WwQeh
 8jbE41gqcpUB2qApyokDCmmLmvmVR7wU5BZkup1heOdTnBn8vGVZmzy2KgB3VHRqYwf1
 FrX++R+A4E5ILg1HaH25xeBN8WbeunTUobYOJ8Zp94L+atc1vUSeKSg8ENGyuEkJcNsI
 RNB5IcZ/mjk832xEXNTuGuZhSO+eiQfPCM5V7IONlkLQFLy9rmBEDOc9hftR4LTMW5Ew
 mBNw==
X-Gm-Message-State: AOJu0YwwMijm9QCkiBDjs7gROPiY+HPyl1YutBpOFAgHHdNnK5TpV2C/
 OyKLXHfnMeh8W75VcR54C9J269gqrefKzKZQFcBnu96+HyTmksNiJZRkqbTIAUofu6GbowNFf9h
 nmF0WxK+oiTvFyXinP6XNFtcLR9UW4D6yqQsnXHTLNzDpOx876fCNlsaz0owMigdQ8REcgoyWiK
 ZlAt+REpP8rusdQUVFa7aACEKdp+Uy93fgTkkprSK/Pg==
X-Google-Smtp-Source: AGHT+IE2ePZrmIof0uuVPjsnXH1WzZRn75B4xay2aMef0yXetZrYOWfHuqL9OeAVX09Fm3Y/VtEKKOi61ifxCQ==
X-Received: from wmjy25.prod.google.com ([2002:a7b:cd99:0:b0:431:1c66:db91])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a41:b0:434:9e1d:7629 with SMTP id
 5b1f17b1804b1-434ddedbb2cmr4266825e9.33.1733428839839; 
 Thu, 05 Dec 2024 12:00:39 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:23 +0000
In-Reply-To: <20241205200025.2081863-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241205200025.2081863-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-7-whendrik@google.com>
Subject: [PATCH v4 6/8] i386: Add RDT feature flags.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3ZwZSZwgKCvw0lirhvmoksskpi.gsquiqy-hiziprsrkry.svk@flex--whendrik.bounces.google.com;
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
index bbe2da8ebb..5e29bf341c 100644
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
+#define TCG_RDT_15_0_EDX_FEATURES CPUID_15_0_EDX_L3
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
index 98407c8e18..37dc451e39 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -678,7 +678,9 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=3D7,ECX=3D1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=3D7,ECX=3D2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=3D0x24,ECX=3D0].EBX */
+    FEAT_RDT_15_0_EBX,  /* CPUID[EAX=3D0xf,ECX=3D0].EBX (RDT CMT/MBM) */
     FEAT_RDT_15_0_EDX,  /* CPUID[EAX=3D0xf,ECX=3D0].EDX (RDT CMT/MBM) */
+    FEAT_RDT_10_0_EBX,  /* CPUID[EAX=3D0x10,ECX=3D0].EBX (RDT CAT/MBA) */
     FEATURE_WORDS,
 } FeatureWord;
=20
--=20
2.47.0.338.g60cca15819-goog


