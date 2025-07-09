Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1F2C83F0F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZBr-0001TM-2L; Wed, 09 Jul 2025 14:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZBE-00018x-Ta
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:06:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZBB-0004Ao-O1
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:06:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2349f096605so2116335ad.3
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752084360; x=1752689160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSgpCCNCeg+W2zo7Uq4pSJ5onka4R108XVyFa7HdUAM=;
 b=Cow+RNaFLp42VoSGz4PpHLlOC/ruChSmq1PgBLtWSS1Pb/vXqrXichWvikcdCzxezn
 NRFs17NIBWZOpKxR18nKdE4CUAWpM+2s8hRVKmS0Vb4xlKo8SBMrq6PAEiE/JaRRZpuE
 Rl68Zin0i1kZpfWwCiduoMk3jO5lX2D4iY+xO98e8/aW3ZP1Jy42iThizlNvVOaCqYzB
 rbj6BwoVKaMlfcCyYeI5enpUOkAE93r8RR1RGVBvK2OPpku1t9JixM8ew0SHNVvM6IPP
 8nBv4oLkb5tyxUY7MuTgo9J1AsV/4tTr05lNf95N3VVnaKgiyvCXZMeIf19q29YSYkAm
 SBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752084360; x=1752689160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSgpCCNCeg+W2zo7Uq4pSJ5onka4R108XVyFa7HdUAM=;
 b=wsrdaYoRXQYHVsZTHCJQzhChil5nlhBED0o/7P37AQ7X82AujgcWln+2t+V0/HN/QF
 PceGKnXPCrYBJMae+H0YJRW4utTiz/A7hbDu+i4HEckutYxu74hH75xHbQwDVm8/b65S
 UcVrmdV7KYg4up2Sgfyzu6t6ZMVd+OI1f5Xhs/w6mn5VLZvqbLxFOUBFldy9rusRQGpk
 o0NiDUglOMOrio+7LV9XhSajdd0U9AOt0kXt2QSVsYQqrL09y9zI04ztCmrENwgRBQT5
 2PlZY1gcZwVdnGkVwS4SvdL+0L0YSsxQQLDkYvbUPfuzcqKvpqxoGKZTChKmEO837SWb
 t+4g==
X-Gm-Message-State: AOJu0YwU0viI6PtsHetb9s+AjWKzWJu9H3RqlzCp/JcLfxNXERooZCOB
 2Jd+tc/zkM1FC0nQLc09+GZGl/S47C2fUm2JuHT7GbDUC0AzD2dd5ehEPCBKT7/DhV1yUFQW9pa
 V20BBgDk=
X-Gm-Gg: ASbGncuxXCHvbDvj+aP3ZaRC4YDMAy1r4oMXpwpjuskPgr5VMxGobmjhJSHApPDcdBC
 2oC6F7AcMiC1zKbq1A9/fNXOGgMVl5PODFa/GVZJ8rAE3dBUbSHP/xTVL8Uc8eEdLptiEI1gLVN
 VcNV7XcPFOLFYreQ8knU5+xzMWlf9o7x3ztQOGYazEsB5mMeFAlEv7310SQEr5G3Xie9gNhGWGG
 LWcQoG6Ik/0twhEnLOZ2xRZoolqBP+voiYl+h1kynfFeQWkFq+rMQAxENJWuu0o/6UOXiLAdR5N
 5fddt00Q/hh4szF1ZZmW43pNTVqwzV92cYugJeakBnNtZ5CwcLbxb9X0pTtvXi0ssj8=
X-Google-Smtp-Source: AGHT+IEAWiI3PsRLNGL8y55qUafpAsfqinwEcLFBlGMKoONIcrUmC+KHPLthkQ97+n/GULfhgpAkwA==
X-Received: by 2002:a17:902:ef49:b0:23a:bc47:381f with SMTP id
 d9443c01a7336-23ddb36832dmr51466815ad.36.1752084360073; 
 Wed, 09 Jul 2025 11:06:00 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c84599f07sm153380175ad.218.2025.07.09.11.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 11:05:59 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 6/6] target/arm: Advertise FEAT_MEC in cpu max
Date: Wed,  9 Jul 2025 18:03:26 +0000
Message-Id: <20250709180326.1079826-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709180326.1079826-1-gustavo.romero@linaro.org>
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

At this point, no real memory encryption is supported, but most software
stacks that rely on FEAT_MEC to run should work properly.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/arm/emulation.rst | 3 +++
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1c597d8673..d207a9f266 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,9 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
+
+  * This is a register-only implementation without encryption.
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 173528175a..2c63940878 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1249,6 +1249,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     FIELD_DP64_IDREG(isar, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    FIELD_DP64_IDREG(isar, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     FIELD_DP64_IDREG(isar, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-- 
2.34.1


