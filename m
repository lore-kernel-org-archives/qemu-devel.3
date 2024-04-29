Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4A3C19F4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HdY-0000UO-H7; Sun, 28 Apr 2024 23:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DBMvZggKCicVPRVWDIDJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--smostafa.bounces.google.com>)
 id 1s1HdX-0000Tu-AU
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:03 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DBMvZggKCicVPRVWDIDJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--smostafa.bounces.google.com>)
 id 1s1HdV-00041m-ES
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:03 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-de468af2b73so8092481276.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361100; x=1714965900; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=oW2D69loP/x98JCkLEbfxO2gw4J5/AFJUayqA/n1rU8=;
 b=3gZNCAC24RxBVfSKnQknn2E4RdHezB2dKIq85G7dV8w16tlVn6r0sq8fm+b+h7Pw4I
 18lWC31N/GtiW6t6IeNyofeIWrVymi/tvtpPZKcUWf/mwMi2eURfToLTwy0S97MxwsYl
 9QRQknpOf794y+MX/KsQ+MDnvtdRKo3mJYdKl1VgiRXmaHjNOV+KzDmxAWZygNcrhdfU
 hSyxX52jY4don86s2ldVi6p1NEElDOKzGJh052prqCSiOVfMq0WPk9moU21IIIag3fgw
 EbUOOUtUoajrpCftEXNAYUV2WXp13vLJav2DyeslreO1jKU9RYKcyj8SR48JCbIlHF47
 oe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361100; x=1714965900;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oW2D69loP/x98JCkLEbfxO2gw4J5/AFJUayqA/n1rU8=;
 b=pmqn9WySZgOp9vGEwbW7si/ywmp3ehzi56Jjl6SrsHuQ+fsHxX1he8iMFMUJHkglic
 ECWqcQlUY9VAi0ZW9IIShGdx9iaapeOoeKmGbFgLwvgppvJWZ+rVnCyoFICDMUukLn0L
 aR13VPisdHRzFwBmor4z5xTE3KnA4jYkZrsIC9K81gVhSE9AmM3mUasVwgOPVOb0g6aO
 E8AjqljqQyohmWPnLndfOJ7EgeJy6k6sVhIUq9DDNTH+rGPZfnho2I3YoI+fNTIzpgYl
 R8nMPwbZuHpzWAFcVJfzAI+fmA6eGaueCR8BRjsWJYgWS7Y0P6p0im+ZZBP3rYrUD3yc
 iGrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+dWU97FRfjNHeStm+4vvJ/sw6OoNFa9dOI+Hxf1xKUcVv9z6Kddf6xR0Ne+WEIPlJhoWDaVG6B+rnIdWt1OUJS8Yk8f0=
X-Gm-Message-State: AOJu0YxRxTZ1PT+xRxtNs733z6pEBbG+AgiAl2sCDoMON6OoFwV3vXjA
 2+9pEcEKXXXrEAlYuxI6NlQzwR7Rt/xgs7aqQW13Teo+f9BMwgC3jFsjipdxJ9QHRaTdeXlE/J4
 09cU3upRPig==
X-Google-Smtp-Source: AGHT+IFr2eXpjPPCfdsJ2BE21RpPzH2hLgspKqU74n+07aHXcmmqZyx1+cPGbsJvdg8T+rM7KLUKix+CFsMPCQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:1002:b0:dd9:1db5:8348 with SMTP
 id w2-20020a056902100200b00dd91db58348mr3290722ybt.8.1714361100182; Sun, 28
 Apr 2024 20:25:00 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:56 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-13-smostafa@google.com>
Subject: [RFC PATCH v3 12/18] hw/arm/smmu: Support nesting in the rest of
 commands
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3DBMvZggKCicVPRVWDIDJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Some commands need rework for nesting, as they used to assume S1
and S2 are mutually exclusive:

- CMD_TLBI_NH_ASID: Consider VMID if stage-2 is supported
- CMD_TLBI_NH_ALL: Consider VMID if stage-2 is supported, otherwise
  invalidate everything, this required a new vmid invalidation
  function for stage-1 only (ASID >=3D 0)

Also, rework trace events to reflect the new implementation.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 36 +++++++++++++++++++++++++++++-------
 hw/arm/smmuv3.c              | 31 +++++++++++++++++++++++++++++--
 hw/arm/trace-events          |  6 ++++--
 include/hw/arm/smmu-common.h |  3 ++-
 4 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index fa2460cf64..3ed0be05ef 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -147,13 +147,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
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
@@ -165,6 +166,16 @@ static gboolean smmu_hash_remove_by_vmid(gpointer key,=
 gpointer value,
     return SMMU_IOTLB_VMID(*iotlb_key) =3D=3D vmid;
 }
=20
+static gboolean smmu_hash_remove_by_vmid_s1(gpointer key, gpointer value,
+                                            gpointer user_data)
+{
+    int vmid =3D *(int *)user_data;
+    SMMUIOTLBKey *iotlb_key =3D (SMMUIOTLBKey *)key;
+
+    return (SMMU_IOTLB_VMID(*iotlb_key) =3D=3D vmid) &&
+           (SMMU_IOTLB_ASID(*iotlb_key) >=3D 0);
+}
+
 static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer =
value,
                                               gpointer user_data)
 {
@@ -258,10 +269,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_a=
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
@@ -270,6 +286,12 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid)=
;
 }
=20
+inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
+{
+    trace_smmu_iotlb_inv_vmid_s1(vmid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vm=
id);
+}
+
 /* VMSAv8-64 Translation */
=20
 /**
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 82d918d9b5..e0fd494646 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1303,25 +1303,52 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_TLBI_NH_ASID:
         {
             int asid =3D CMD_ASID(&cmd);
+            int vmid =3D -1;
=20
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error =3D SMMU_CERROR_ILL;
                 break;
             }
=20
+            /*
+             * VMID is only matched when stage 2 is supported for the Secu=
rity
+             * state corresponding to the command queue that the command w=
as
+             * issued in.
+             * QEMU ignores the field by setting to -1, similarly to what =
STE
+             * decoding does. And invalidation commands ignore VMID < 0.
+             */
+            if (STAGE2_SUPPORTED(s)) {
+                vmid =3D CMD_VMID(&cmd);
+            }
+
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_asid(bs, asid);
+            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
+        {
+            int vmid =3D -1;
+
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error =3D SMMU_CERROR_ILL;
                 break;
             }
+
+            /*
+             * If stage-2 is supported, invalidate for this VMID only, oth=
erwise
+             * invalidate the whole thing, see SMMU_CMD_TLBI_NH_ASID()
+             */
+            if (STAGE2_SUPPORTED(s)) {
+                vmid =3D CMD_VMID(&cmd);
+                trace_smmuv3_cmdq_tlbi_nh(vmid);
+                smmu_iotlb_inv_vmid_s1(bs, vmid);
+                break;
+            }
             QEMU_FALLTHROUGH;
+        }
         case SMMU_CMD_TLBI_NSNH_ALL:
-            trace_smmuv3_cmdq_tlbi_nh();
+            trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
             break;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7d9c1703da..593cc571da 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -11,8 +11,9 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, u=
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
+smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=3D%d"
 smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=3D%d a=
ddr=3D0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=3D%s"
 smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uin=
t32_t miss, uint32_t p) "IOTLB cache HIT asid=3D%d vmid=3D%d addr=3D0x%"PRI=
x64" hit=3D%d miss=3D%d hit rate=3D%d"
@@ -47,7 +48,8 @@ smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=3D0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint=
32_t perc) "Config cache HIT for sid=3D0x%x (hits=3D%d, misses=3D%d, hit ra=
te=3D%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uin=
t32_t perc) "Config cache MISS for sid=3D0x%x (hits=3D%d, misses=3D%d, hit =
rate=3D%d)"
 smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t=
 num_pages, uint8_t ttl, bool leaf, int stage) "vmid=3D%d asid=3D%d addr=3D=
0x%"PRIx64" tg=3D%d num_pages=3D0x%"PRIx64" ttl=3D%d leaf=3D%d stage=3D%d"
-smmuv3_cmdq_tlbi_nh(void) ""
+smmuv3_cmdq_tlbi_nh(int vmid) "vmid=3D%d"
+smmuv3_cmdq_tlbi_nsnh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=3D%d"
 smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=3D%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=3D0x%x"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index de032fdfd1..361e639630 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -212,8 +212,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg=
, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
-void smmu_iotlb_inv_asid(SMMUState *s, int asid);
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
+void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova=
,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg=
,
--=20
2.44.0.769.g3c40516874-goog


