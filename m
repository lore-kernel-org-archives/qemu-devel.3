Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2A7C19F4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HdT-0000Rr-5T; Sun, 28 Apr 2024 23:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BRMvZggKCiAOIKOP6B6CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--smostafa.bounces.google.com>)
 id 1s1HdR-0000Qg-4G
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:57 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BRMvZggKCiAOIKOP6B6CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--smostafa.bounces.google.com>)
 id 1s1HdP-00040F-HZ
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:56 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-41bd87bb458so9899685e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361093; x=1714965893; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=K2K10o4HrVEMQyB0nTzL395RaCFWkr722hs0qYO5Pu4=;
 b=y9FABDCw/iSx2BNKB/8N/q9GbeJzTDTBmd3rhRMBm+v1IwH4HGfBhwvX2BEJy5YDKM
 XIlRgdSYSXbOIphCVdXSME5e7m3OaC3Qct1ZdJB1ujjADjacZidOxStJfCXQv1OdFq0m
 IOMTvTqdJVUVU6ZEa9bBrSFn86NKiN6q4uIpA/WPn9xU8FyVg9JfyrC2JXrE7tYI3MPD
 0XStaCMnpqMnnoLoc/+U1b7+P+q4We4Apl6USIUA+w9dl8RKcO5M8QpyakrK4N3NoLoA
 9HRUDT657ow3TyxC67MeT3/T7a5oXsr9TP0MMfBgs3KIldurbEOiUH/mdKnTfutC88nV
 LWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361093; x=1714965893;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K2K10o4HrVEMQyB0nTzL395RaCFWkr722hs0qYO5Pu4=;
 b=RBNdGYrYTcK2xidO6mN2kPOqNktc3pZxIbhcJG+NwCMQkt2jqrn3PlZv6Roa8HrYHO
 G7Ruax94JGBWLgvqq7CGgAsNh5uwoqAZg8hfTKkNZtthN9cxACcbb5rxzoJMhi/aYjcQ
 60/R4NOjZB3kgo5YyLhvdbO817D9jSo8FKmKJ5X/kvkSz/YcnAOEauV2Q6tgY83TrUEh
 KwuhuJ0rmzTF/qjUIR8vXT5dcz1954cLPkYQMO0dR00l2KY+E4SnmINOS1jMdRsJuPAM
 7VyE7LGvIOeDuFgVF40LDPTPX1p2f+h7juHu1akJuHejr66Ud2REnlpFrYrKAI7wyP/Q
 GxBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0F68884Yk0i/gpp6WxD8ahLzNufBtfWStMZfJabDYSfaf+rjVNFMJkVkGHsNftRLUG5F184U306xUzUWISmHO5ezGiY8=
X-Gm-Message-State: AOJu0YzCBAzRqXjWiiB4jrmPwUtwllmRXG7ZYoUjX0dZ4oBt1nIGWPn+
 zIus1RBkoJ6xvqcTWRdwwlqE2elHf3OkUOBuF3B1EtF7aLg2O+i/YTFmyMI9g9lM1NBPM468ozb
 vAdk/Nf/TxQ==
X-Google-Smtp-Source: AGHT+IEAioScIgyQYW1iT+3RIFGdD9MYHPHvp2XBiqEQ5PSeCrxbZKuYDnWsqLoHMsyqf6oHY1wlXaQ7UYnUbQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:5801:b0:419:d7:1cc7 with SMTP id
 jz1-20020a05600c580100b0041900d71cc7mr32662wmb.7.1714361093088; Sun, 28 Apr
 2024 20:24:53 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:53 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-10-smostafa@google.com>
Subject: [RFC PATCH v3 09/18] hw/arm/smmu-common: Rework TLB lookup for nesting
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3BRMvZggKCiAOIKOP6B6CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--smostafa.bounces.google.com;
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

In the previous patch, comine_tlb() was added which combines 2 TLB
entries into one, which chooses the granule and level from the
smallest entry.

This means that a nested translation, an entry can be cached with the
granule of stage-2 and not stage-1.

However, the lookup for an IOVA in nested configuration is done with
stage-1 granule, this patch reworks lookup in that case, so it falls
back to stage-2 granule if no entry is found using stage-1 granule.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 0d6945fa54..c67af3bc6d 100644
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
@@ -88,6 +90,24 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
         }
         level++;
     }
+    return entry;
+}
+
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
2.44.0.769.g3c40516874-goog


