Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87638CD5BA9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAZt-0000D1-L2; Thu, 05 Sep 2024 07:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3kZTZZggKCl4SDAJ9NEGCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--whendrik.bounces.google.com>)
 id 1smAZq-0008Qx-D2
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:02 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3kZTZZggKCl4SDAJ9NEGCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--whendrik.bounces.google.com>)
 id 1smAZn-0002zM-N1
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:02 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e03623b24ddso1851150276.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725535378; x=1726140178; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ObfI1qjsjD3CazvP1CUjFiKi6o6xv4BVYTjj0LflWMA=;
 b=vWJ48TdY1OjyE9YKcSAcu38SswQf9ya2kPHbRtAQ/6S7L6vqi7nWhn43bpgZVrELp/
 a9/iEQCzcSsn18vBOe4DXXaaT7nM3Znbj3p2xk3m4Y1FMWdOiovPvirlE0mU5z+3yEW8
 JX6IMBsmh0yBJ+J1AnJHnNcTSu1yPmn9jczhrL6G6Kmp2EBCWOG1G3LLagdwTXol0YiW
 NraRzJFQLWiDgEqwJGZtCmsrs6x9s4tcI5Pp10IDhm1j2I1opHZPIZFu14xbpO2r4zXo
 cL7MbTq9iTR5KJOj8/QgB4Jeo9wpHGgoVRnsBBSgrJlj4mSCR1Cv1vLIALnaUnOVm3O4
 DwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725535378; x=1726140178;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ObfI1qjsjD3CazvP1CUjFiKi6o6xv4BVYTjj0LflWMA=;
 b=RnJj+o+ygFJIf3kk7s5qbZF0ZwiDTHUHnei6EYVFZE1HEkLK0APlNFk2QOc5uR7E8s
 wrOm8BRQbjeo9XIMTDFJgc2Sjab8via7JzmmCkUetkn5IAQEfLIBxeUdE/BbOGzreZgo
 bXOZe4DdQUjD4w5gndXGrYnu2Irt5JdT3TNnA8VThIJCoyqtWd9TWKWnROIonpOytDr8
 9m5ItPT4B3tw0dzIaah2+myL1bJTGYtPlJZQZh89JZFAMgDdfGJKroeyjAJlLRMwiGbz
 l1IE/OOtWQ2JYMcx8sUq+GmKEDtyDAiXTagewzvNE7yL/7P7O/8NyJNo3NdFF1VMzhyR
 SS/w==
X-Gm-Message-State: AOJu0YyeaPSw5eG8udJbQrU1s02fYD8TEg5b7iWbqoU3C727EwRHvDp0
 CkXHm+iDrCmUzHgHJAdqqTQDfHX7HyL08zQpXm16XLz4ZXCvlGYMbXEpoSJ33q+EG8YVzZSDuCU
 jtbxefkctM3MaHmiosCh3CUc5HKZwtF2Nj5d2uEbHP5eO5qWb48uDVk49SKQSzLG3d+58sgs19E
 HOhq+beao4n4YQPTeXUfTSwt2COS7HkYNhIJR35+vThg==
X-Google-Smtp-Source: AGHT+IFCDzMleyBHegtwLc/Sjf0wVNg6dVmQOx3JGgoGiKLObTOLdyrqPdxxbG0xvKHxjJudBH+fR3dgthXW7A==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:130:7cd9:ac11:98f1]) (user=whendrik job=sendgmr) by
 2002:a25:c4c2:0:b0:e1a:6eac:3d0f with SMTP id
 3f1490d57ef6-e1a7a1b67e6mr99025276.8.1725535377649; 
 Thu, 05 Sep 2024 04:22:57 -0700 (PDT)
Date: Thu,  5 Sep 2024 11:22:35 +0000
In-Reply-To: <20240905112237.3586972-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240905112237.3586972-1-whendrik@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905112237.3586972-7-whendrik@google.com>
Subject: [PATCH v2 6/8] i386: Add RDT feature flags.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3kZTZZggKCl4SDAJ9NEGCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--whendrik.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
index a5c4e3c463..36e19bfa8c 100644
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
index 14c1d7d66b..99a5288061 100644
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
2.46.0.469.g59c65b2a67-goog


