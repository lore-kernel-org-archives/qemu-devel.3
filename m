Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724D6D6100B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQJH-0002WI-0U; Thu, 29 Jan 2026 06:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIp-0002Cp-47
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:14 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIk-0007wo-A2
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so14126415e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769686505; x=1770291305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pC4vaBaGdBGxacndhuoO+54POr05bZJYxNH0VvqZF6E=;
 b=aDKnjwHNhkY0mqb7mMHCh0yKU5cOevz4VuqJ/P/5WbG4uFEbdemY5uX6sjo5kOV7xF
 BVLkzrhbGmUtwRCROsE11fKM907WlphTTmLXGv4ollhmAAPuTrtG1pGbze85C023WsQb
 MzV124bTIGzeZkcR+smApGNBnu1OcWOIxlB8TaJi7NJuVvAM3jX2YDB9ki8FB2zVo6un
 MlWT1Uer2/Pn2dnkFc4L/QYlAQ+qL1gV1eEY4Q7u4Gl5XE3mqzcV9sPW3EzmQtbHNpku
 XiGuj5ksNb5hO92egSb0MEmcid7qdeZLYui22QwRIEF1vjaWeQFmfzuuARCn5Nu8+1QA
 2M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686505; x=1770291305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pC4vaBaGdBGxacndhuoO+54POr05bZJYxNH0VvqZF6E=;
 b=X99FJfBdhx2ioYZXAcRDBUtOb7yJcvLVN1CDT9X9yYQ/MTN4SByNRFMaTFvnqqynFs
 k/0yjArrcRmtqfW5AmTTLySvgbjmpWQkAb6Q7xqzytRsdEVFrmPdVpP4O1Zxdl12S6N8
 iPxwVqesYEAIjXzROPCd/5A3ZlppwgufUclZQ7cY+k2Xpf/TYgwElHl6wEcGlolp3U5v
 SBsztDevkLbCjKCmXdeK1Z9NK56VjPUvs24StMLuQoz3o55pcXl6hBOjQmcbhGORLEnF
 oMdhYhtqJKtVzfYEzKGAzq5jUM4dc078vZGbHa+uSVN40VylM1D+5/Ulkak+BSF16wIO
 C5SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWHBLvdbjPdQheU0RgzYqXifOhBgtYMSkL8yxnByq2/MY8PPwUB1ntqF6LQSIcIqBG0uIUiGAVyTgs@nongnu.org
X-Gm-Message-State: AOJu0Yzm+v9DDwfyP178RNyb/WhOz555jeqrgMd2Y/Mqvdnf2T9x38nF
 IsaOPwrycNxG/3BODmcQgYEcnmRpBSx62HS8Re8Kv0KuQakst9C9SV7aWeekPtLB/10=
X-Gm-Gg: AZuq6aI/y/R2Ye9jPRSzynb0p0kgtP9qNrDkyE5zzexMfkX6IBTTt/ApON4Ibb6W9e3
 EYIzVpxzvz5MFqPbTG8cjLHf0iQdykaCivWS+rjTDy9JVfq9GWAnyxPMe6GcRPzP1ubGZomzFnB
 YpH+reOQuJdrHLwZlvHU+M3AqpSPIfnp9Ngb80fiJ/FKmMSTNOaYKb+ig/5BFRz3kTgErpE37vs
 9O48pbopU/5NMLV0Hu/+IJtCGg3XuwOIDzrP8lnQapEdGUOmH3YYU4GVtIrYBqtxbt9XoRXK7Iq
 Dw27b5IOXgg289ofJuYoBGGDlwj8iJt7RhCTkbvdx2SuI4tGSrqPtuM4RCixzFC60tVFPUxIg5l
 MbEuFr5S03fRnXd6W99j5fafRwi/yjO8B+h6WywXIaaK/0tIRjJ9MP4+2YRUNhm2XkcnZSVPgTM
 IoxGzXq4CcGZ1jCAtF5QkDAjicm71MZw==
X-Received: by 2002:a05:600c:3143:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-480829b1c51mr37657985e9.14.1769686504640; 
 Thu, 29 Jan 2026 03:35:04 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm196311075e9.14.2026.01.29.03.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:35:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 6/6] target/arm: Permit configurations with SME but not SVE
Date: Thu, 29 Jan 2026 11:34:55 +0000
Message-ID: <20260129113455.1283266-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129113455.1283266-1-peter.maydell@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In commit f7767ca30179 ("target/arm: Disable SME if SVE is disabled")
we added code that forces SME to be disabled if SVE is disabled.
This was something we did in the run-up to a release to avoid an
assertion failure in smcr_write() if the user disabled SVE on the
'max' CPU without disabling SME also.

Now that we have corrected the code so that it doesn't assert
in an SME-without-SVE setup, we can let users select it.

This effectively reverts f7767ca30179.

Note that this now means that command lines like "-cpu max,sve=off"
which used to turn off SME and SVE will now give you a CPU with SME
but not SVE.  This is permitted by our loose "max can always give you
extra stuff" rules, but may be unexpected to users.  Mention this in
the CPU property documentation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst | 10 ++++++++--
 target/arm/cpu.c                 | 10 ----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 37d5dfd15b..9d0c5731cc 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -318,12 +318,18 @@ SVE CPU Property Parsing Semantics
      provided an error will be generated.  To avoid this error, one must
      enable at least one vector length prior to enabling SVE.
 
+  10) Disabling SVE does not automatically disable SME. If you want to
+      disable both you must use ``sve=off,sme=off``. In particular,
+      for the ``max`` CPU, ``sve=off`` alone will give you a CPU with
+      SME only (and which therefore still has the SVE vector registers).
+      Most users will want to disable both at once.
+
 SVE CPU Property Examples
 -------------------------
 
-  1) Disable SVE::
+  1) Disable SVE and SME::
 
-     $ qemu-system-aarch64 -M virt -cpu max,sve=off
+     $ qemu-system-aarch64 -M virt -cpu max,sve=off,sme=off
 
   2) Implicitly enable all vector lengths for the ``max`` CPU type::
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6e1cbf3d61..1cb30076ad 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1571,16 +1571,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
 
-        /*
-         * FEAT_SME is not architecturally dependent on FEAT_SVE (unless
-         * FEAT_SME_FA64 is present). However our implementation currently
-         * assumes it, so if the user asked for sve=off then turn off SME also.
-         * (KVM doesn't currently support SME at all.)
-         */
-        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
-            object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
-        }
-
         arm_cpu_sme_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.43.0


