Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9F3C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLY-0006MG-Q8; Mon, 15 Jul 2024 04:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xeGUZggKChgGACGHy3y4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--smostafa.bounces.google.com>)
 id 1sTHLN-0005ah-Tc
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:02 -0400
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xeGUZggKChgGACGHy3y4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--smostafa.bounces.google.com>)
 id 1sTHLM-00047D-4A
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:01 -0400
Received: by mail-ej1-x649.google.com with SMTP id
 a640c23a62f3a-a77f5dd71a4so363112566b.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033158; x=1721637958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=kSLLJA+MylhZD+tmsfMTBjMJxnWvKaFxAJzvA+CCiPM=;
 b=r9/xWSWiNxa+oUV5JfFV/tpFeSPYI6jD5gTPohoS5o/A/WPZ59w46qHfIcRi4vL8el
 TM7HfxdEplJBA9xM8iA1vRSp1mt+1uJPo5ppkC3AfmcV/Rg1yrmvD7ws9yCkqDTHdQJf
 W/+DGVGNtYMrR4L/DttKgyE9Eb/BPjVM1R1jWSk0ZJsmUHEw58k7h5IOXAdL+3ifkixQ
 Op869ofLCki4BopFJgpXF0w7PnWGGKyXZ/6IeArVk98z55d5bqYjG9kS77JxHDjiV2dU
 8LOqQ/jqF955yX9MCuVPk+qEGxDhUjkIvnS8Z7mWX1c8WLzWAAdncFd8rffGY46OofWp
 +p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033158; x=1721637958;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kSLLJA+MylhZD+tmsfMTBjMJxnWvKaFxAJzvA+CCiPM=;
 b=GRvZZZLLciAfEsMM7/qiIu72VDqXJp53rKSj4sUwag46OK4QKo7abEA/IH2AUdS17p
 BG2Rv9VGcO5kjX6tMjMiJWXXF5bDd6C1kfsbO2ubCRTnCKj/GSJ7JhNFhoZNy0Izeon/
 6EUXSosi7S9J9iZkkPkw0enj0sm7RaiKj5M/fOvt1E7TFuAoySRT1i/XSssDpxTsO3sm
 w+V+mGtYmgcDqiYL58JffJseCB4FsFdOWzbXZr9RX8GQKRYbbgj1eGyB6/r2l5uC84hF
 1wNbtPTx8HFHR5N3KW+GEdVqFhPrAA+Sqz/KJNje7+73cfhrj5qfrC9m5OI8zwS1I13D
 E2ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLQaapD/ThXra+SlH4WN8tBbBSUfomiAVDy8g0B5lb6fxO6Jsmt/fDK+yLeCSiExaYrWJP0i1GcvUStIKesziEMLJG3BU=
X-Gm-Message-State: AOJu0Yz2ZzgqM8SA3tfIwKjP6wq4ZovW1YMy7FjxBloFL8JNUUXhtAiQ
 Jgp6hPgSQXvKPeeKpBT+I8qzawRExzkqZhENZWVQHdgwUg5iJbjxJ8wmb/cjC8arGtONn0+z23s
 Z86RaNwOeCg==
X-Google-Smtp-Source: AGHT+IHeMCtt0rWhGRuIPi5vXqatFPsYEtvybGVAoR4/mvSBPex2Tm6Oe8iUbb/K7laB2fPI3lfeFUqVFwF6Cw==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a17:907:6d07:b0:a77:eaf1:87c0 with SMTP
 id a640c23a62f3a-a780b505758mr1377166b.0.1721033157964; Mon, 15 Jul 2024
 01:45:57 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:13 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-14-smostafa@google.com>
Subject: [PATCH v5 13/18] hw/arm/smmu: Introduce smmu_iotlb_inv_asid_vmid
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::649;
 envelope-from=3xeGUZggKChgGACGHy3y4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--smostafa.bounces.google.com;
 helo=mail-ej1-x649.google.com
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

Soon, Instead of doing TLB invalidation by ASID only, VMID will be
also required.
Add smmu_iotlb_inv_asid_vmid() which invalidates by both ASID and VMID.

However, at the moment this function is only used in SMMU_CMD_TLBI_NH_ASID
which is a stage-1 command, so passing VMID =3D -1 keeps the original
behaviour.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 20 +++++++++++++-------
 hw/arm/smmuv3.c              |  2 +-
 hw/arm/trace-events          |  2 +-
 include/hw/arm/smmu-common.h |  2 +-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index a100700497..bf35806b02 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -159,13 +159,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
     g_hash_table_remove_all(s->iotlb);
 }
=20
-static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
-                                         gpointer user_data)
+static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value=
,
+                                              gpointer user_data)
 {
-    int asid =3D *(int *)user_data;
+    SMMUIOTLBPageInvInfo *info =3D (SMMUIOTLBPageInvInfo *)user_data;
     SMMUIOTLBKey *iotlb_key =3D (SMMUIOTLBKey *)key;
=20
-    return SMMU_IOTLB_ASID(*iotlb_key) =3D=3D asid;
+    return (SMMU_IOTLB_ASID(*iotlb_key) =3D=3D info->asid) &&
+           (SMMU_IOTLB_VMID(*iotlb_key) =3D=3D info->vmid);
 }
=20
 static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
@@ -270,10 +271,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_a=
ddr_t ipa, uint8_t tg,
                                 &info);
 }
=20
-void smmu_iotlb_inv_asid(SMMUState *s, int asid)
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
 {
-    trace_smmu_iotlb_inv_asid(asid);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid)=
;
+    SMMUIOTLBPageInvInfo info =3D {
+        .asid =3D asid,
+        .vmid =3D vmid,
+    };
+
+    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &=
info);
 }
=20
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a0979f15a0..cfee42add4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1361,7 +1361,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
=20
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_asid(bs, asid);
+            smmu_iotlb_inv_asid_vmid(bs, asid, -1);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7d9c1703da..4aa71b1b19 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -11,7 +11,7 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, u=
int64_t baseaddr, uint6
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t ptead=
dr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=3D%d le=
vel=3D%d base@=3D0x%"PRIx64" pte@=3D0x%"PRIx64" pte=3D0x%"PRIx64" iova=3D0x=
%"PRIx64" block address =3D 0x%"PRIx64" block size =3D %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte)=
 "baseaddr=3D0x%"PRIx64" index=3D0x%x, pteaddr=3D0x%"PRIx64", pte=3D0x%"PRI=
x64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
-smmu_iotlb_inv_asid(int asid) "IOTLB invalidate asid=3D%d"
+smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=3D%d v=
mid=3D%d"
 smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=3D%d"
 smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=3D%d a=
ddr=3D0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=3D%s"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index f9c8b00c9d..b3a937190b 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -213,7 +213,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg=
, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
-void smmu_iotlb_inv_asid(SMMUState *s, int asid);
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova=
,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
--=20
2.45.2.993.g49e7a77208-goog


