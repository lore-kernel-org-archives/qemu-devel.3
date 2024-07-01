Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B456AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEqQ-00043f-20; Mon, 01 Jul 2024 07:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_4yCZggKCl4OIKOP6B6CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--smostafa.bounces.google.com>)
 id 1sOEp7-0002EU-54
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:58 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_4yCZggKCl4OIKOP6B6CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--smostafa.bounces.google.com>)
 id 1sOEok-0005Nz-GI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:34 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-64a6cda8ba1so50531787b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831808; x=1720436608; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nf/BuvdXrYHKSrwR11B4FhLzHkeE3jRvv0ulnFc6ImY=;
 b=TB/p4P8TKRxwjXR2sZ5DdXodysF87km8NFIdXO0mCQ7JWWRhVxGiTgtMV2CcHkDRJ4
 TNxEJ2puVoXqA9xQLB2bu4kErrRfWlqWXBby/jENxZC4w68rXUV5uLW/tSs9BT8Xg2ub
 hGAFtidMSXZyzG45Fp24pfjVnBrQN1Sqhb2TsBxmgqg9BcA4udIO78YI7Xx4/TfueZk+
 EBXi14Af7yLmHY1SNwtekkjv8kHPfczIRH3ZMS1uw2tcBaDrzi4GMlFJebae/YlOqDEY
 bpctguiaIiiWt2hMTC/Yy1QqEsAzHSzkStbOYTxDmsC/VhZJ7LpjIMz26dLDoeUiiYd8
 XFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831808; x=1720436608;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nf/BuvdXrYHKSrwR11B4FhLzHkeE3jRvv0ulnFc6ImY=;
 b=VctGmwJSRepXESGXc+IXsVp/r4UzyjNc75BY5/IUVTcBFf355waWeB/qli+uswok7B
 hCfzNMHdbosndk5VS+/1CfclvLwJHTF0x1V43DkBgcFOrA9MUO80inwi24vQUI11V4yC
 1w73gbdt0sIaX00NOmVsbBpCEBh6UNeQtU/PZMlO1FMsGmoOE62jLP428YiDZuhepmoW
 s9b6LhLNYJXcOaEq+zFeNtIfvEnlv8PIEYB/ZLlcReaRALT4X6xE2b1AIU406c4gQUS0
 kTtRt9O13duOGl94HBcLz09F17Oww9hXB0CxX4ruSj8DoUomq6d9x+9guf70HDU11YS1
 LKeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw2/2ZHSbvKxNEzemc/sK4VSMWEy51fsOtlTOFwudaaaMcueKQbriUoDYyKBx2U2s7EtcaYwkndQEyYm+rA1cMRQsIqcM=
X-Gm-Message-State: AOJu0YzkiQ2CAvRpgQwxqg6lujNfEvup0u56GZ1X5IDW7PpFOf3WgTLP
 rTA/02Yyjn8jugZzz+/HRnvfLYnt55d6GnGqTWahK5pUlsALbmwmb+K2e95ZnXg3WQwPrEymZtw
 pNxAl/b3uhA==
X-Google-Smtp-Source: AGHT+IGDP9hkCJFJKAVw6gMnE6v6ROuUsQJDsyBLTRsGJ2mcTLzpD4HgzU/VuXFiqdQuCaHKE1BiDV3gzj8TPA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:1542:b0:e03:4bf0:b21e with SMTP
 id 3f1490d57ef6-e036eae0fecmr455790276.1.1719831807602; Mon, 01 Jul 2024
 04:03:27 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:31 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-10-smostafa@google.com>
Subject: [PATCH v4 09/19] hw/arm/smmu-common: Rework TLB lookup for nesting
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3_4yCZggKCl4OIKOP6B6CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

In the next patch, combine_tlb() will be added which combines 2 TLB
entries into one for nested translations, which chooses the granule
and level from the smallest entry.

This means that with nested translation, an entry can be cached with
the granule of stage-2 and not stage-1.

However, currently, the lookup for an IOVA is done with input stage
granule, which is stage-1 for nested configuration, which will not
work with the above logic.
This patch reworks lookup in that case, so it falls back to stage-2
granule if no entry is found using stage-1 granule.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 21982621c0..0840b5cffd 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
     return key;
 }
 
-SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                SMMUTransTableInfo *tt, hwaddr iova)
+static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
+                                                  SMMUTransCfg *cfg,
+                                                  SMMUTransTableInfo *tt,
+                                                  hwaddr iova)
 {
     uint8_t tg = (tt->granule_sz - 10) / 2;
     uint8_t inputsize = 64 - tt->tsz;
@@ -88,6 +90,36 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
         }
         level++;
     }
+    return entry;
+}
+
+/**
+ * smmu_iotlb_lookup - Look up for a TLB entry.
+ * @bs: SMMU state which includes the TLB instance
+ * @cfg: Configuration of the translation
+ * @tt: Translation table info (granule and tsz)
+ * @iova: IOVA address to lookup
+ *
+ * returns a valid entry on success, otherwise NULL.
+ * In case of nested translation, tt can be updated to include
+ * the granule of the found entry as it might different from
+ * the IOVA granule.
+ */
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+                                SMMUTransTableInfo *tt, hwaddr iova)
+{
+    SMMUTLBEntry *entry = NULL;
+
+    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
+    /*
+     * For nested translation also try the s2 granule, as the TLB will insert
+     * it if the size of s2 tlb entry was smaller.
+     */
+    if (!entry && (cfg->stage == SMMU_NESTED) &&
+        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
+        tt->granule_sz = cfg->s2cfg.granule_sz;
+        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
+    }
 
     if (entry) {
         cfg->iotlb_hits++;
-- 
2.45.2.803.g4e1b14247a-goog


