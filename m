Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A892CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 11:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSCfZ-0005L3-Q8; Wed, 27 May 2026 07:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSCfY-0005JI-1C
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:43:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSCfU-0008Uc-TI
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:43:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so77041875e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779882203; x=1780487003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vr/dCWZqkxecamIVH5FjFCNfp5PazmhoCWjfR1OvVNg=;
 b=SogYB00knIA9Uql+I2ujVkTkelh37FDKuyP++dNS4ZzoUX5jpuiarx8fODIbVQwMgG
 lDQGWRSIftyE05pG7oPtq3nEEHo46tWLhI8CnPsLZY8u0l8U3K5Pm0N/YZ4C+5GqJs/U
 Sa5nvGurWY6AXw/c1FDNZgp0a7/NAwVresaq07GnxzHrCobaID2VbojXVtZ9PC2lz9pU
 Nkl6AP2Ie5TQEHI9vViZh8Qe+4quUuD6j2LBJ0KOaF8tOjg8p7hMYSaz/CbuNBfw3vFG
 6ULP/zdE5aiiy8dv0gmEHHOPelBswZ0jn/vpzfrgYDXzVTEKZs/OjNaagECuYqa2Ys3w
 hxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779882203; x=1780487003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vr/dCWZqkxecamIVH5FjFCNfp5PazmhoCWjfR1OvVNg=;
 b=n19ArKbmcE7isUQC7JInefszrH8Gc9IIsDl3UWUcYnifbc4KgQckcLx0QkK9c41Ltk
 DwPoV2jewUSW785zlLSBsNr9PdTmIyGHAvNrT0tkMvyDvj7x37WIPkfuQ3JwI3lpFmFy
 SIFc5PKhMz1AQNc10QRk9OyqrAujXrGSzR1qmxahNb81YD5DjCtaaBwelmBc8bbwoxtn
 tFAH5qDJXi7YsjjmMlN4oZsqSLwZ4Gmt1voZYBXFcNC2K07VARzN6bW5N1Q4fuEH3Bhg
 9079Whes4WzuOM3wW6a/zm2mYnuaicBwpFuPldzGgnKn7Aj6IBSYX5RJQqUFD45auGCM
 viyw==
X-Gm-Message-State: AOJu0YzG9N5Pb/IjcVbL/ncjHjbBVmDQ4Q3Y8ufW3wZEBJ2uJ2LYXXch
 fOikj0cL4BQ+bfOu0jLQkzoOtdA7uZfx+Q87hXS9ahstcPJQnNnK2ExfLX4gM0uFksw=
X-Gm-Gg: Acq92OGv8K+7Pjs69i8Fgq1VJRwizK640uoGrW5FP0kRJBXvWn9K6j3J04cSXBBYE9J
 8qC8H69VOZInk8H6IzeRwmjWR6tuwR+FxhHDMcz75PXgRqZtEkTE+Tvva39O82MWM0ol/KkfiIl
 iVhtiZUcdbhh1jfDHYGGfBCU7Fbsn0dSwKb6V2dIbgTRscfv4qAsnn8eLA0G9+hX3ILNzlEhpTn
 klp2SKPZhBzrJ11+yhE0Oq1dCzWcFsSsVeXungVzEjVskXhu9xToKz2AqLx/Q7CjmtwGnuTPXq2
 RUsR2k4L2uhv3O40L0fHBV/owGiXtPVnYZ7Tkp080R6xERMII376ShXa303xrEG0YSVSGIMMrAf
 WMAmJynRMFw0burVI/3SEZS4+fD3JkF+SZVmlfh52cIZrFCUD7JSh1fpsv5wiOZZ943t1iojHw/
 V36c7tV1MwHXAtzIORsA4H0Qs+k/p6XGy0Yw==
X-Received: by 2002:a05:600c:6992:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-49050000ae6mr310718185e9.1.1779882203368; 
 Wed, 27 May 2026 04:43:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c600esm383473175e9.3.2026.05.27.04.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 04:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24CF75FB96;
 Wed, 27 May 2026 12:43:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 3/8] target/arm: redefine event stream fields
Date: Wed, 27 May 2026 12:43:15 +0100
Message-ID: <20260527114320.1581552-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527114320.1581552-1-alex.bennee@linaro.org>
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

The event stream control bits are the same for both CNTHCTL and
CNTKCTL so rather than duplicating the definitions rename them to be
useful in both cases.

We will need these in a later commit when we start implementing event
streams.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h | 11 +++++++----
 target/arm/helper.c    |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 7deaf1ab6de..0c22781919b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -269,14 +269,17 @@ FIELD(VSTCR, SA, 30, 1)
  * have different bit definitions, and EL1PCTEN might be
  * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
  * disambiguate if necessary.
+ *
+ * The event stream bits (EVN*) are in the same position for
+ * CNTKCTL_EL1/CTNKCTL.
  */
 FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
 FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
 FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
-FIELD(CNTHCTL, EVNTEN, 2, 1)
-FIELD(CNTHCTL, EVNTDIR, 3, 1)
-FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTxCTL, EVNTEN, 2, 1)
+FIELD(CNTxCTL, EVNTDIR, 3, 1)
+FIELD(CNTxCTL, EVNTI, 4, 4)
 FIELD(CNTHCTL, EL0VTEN, 8, 1)
 FIELD(CNTHCTL, EL0PTEN, 9, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
@@ -286,7 +289,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8240f1b3848..3b06bd80a01 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1766,9 +1766,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t valid_mask =
         R_CNTHCTL_EL0PCTEN_E2H1_MASK |
         R_CNTHCTL_EL0VCTEN_E2H1_MASK |
-        R_CNTHCTL_EVNTEN_MASK |
-        R_CNTHCTL_EVNTDIR_MASK |
-        R_CNTHCTL_EVNTI_MASK |
+        R_CNTxCTL_EVNTEN_MASK |
+        R_CNTxCTL_EVNTDIR_MASK |
+        R_CNTxCTL_EVNTI_MASK |
         R_CNTHCTL_EL0VTEN_MASK |
         R_CNTHCTL_EL0PTEN_MASK |
         R_CNTHCTL_EL1PCTEN_E2H1_MASK |
@@ -1783,7 +1783,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1TVCT_MASK |
             R_CNTHCTL_EL1NVPCT_MASK |
             R_CNTHCTL_EL1NVVCT_MASK |
-            R_CNTHCTL_EVNTIS_MASK;
+            R_CNTxCTL_EVNTIS_MASK;
     }
     if (cpu_isar_feature(aa64_ecv, cpu)) {
         valid_mask |= R_CNTHCTL_ECV_MASK;
-- 
2.47.3


