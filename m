Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D342BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HdN-0000Og-5i; Sun, 28 Apr 2024 23:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_hIvZggKChkHBDHIz4z5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--smostafa.bounces.google.com>)
 id 1s1HdL-0000NZ-0L
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:51 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_hIvZggKChkHBDHIz4z5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--smostafa.bounces.google.com>)
 id 1s1HdI-0003xe-Vj
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:50 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-34c86c20b12so803654f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361086; x=1714965886; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=jzuUWu6bG8mAJ09DQsMaSkbyaQKWQKRU5BzKtgEAL9w=;
 b=q+gBxsPOPmgn7L3cvvk0GmrEi46AFq6nhJT5zT7tc+Wy3la805OKkXE8P7icsgKiMG
 S8CzdkBTpC0ghKOIApG583ycU8Z/bH0QLqQOtRZ5Pc/EGNIvSV3MwUZ5CJWilufTRu0E
 8zJwI28LMPJIZlOPtlMSnQgNYUjXaHnzXMySveFghYnHPwGUOdCdzpdrDJ48nVPtDbE/
 ibw9y5gZiDn4TmGdS4I6o9CX8W8JuSbkE/DR6Vv/nTLTFuA8CfIFUw1izt/vy4Hpn4sS
 VeXeAOsLYisgRedn1S6tGAGBSYkkYhxDDGl4KB5LBsOembcKaynuHAQ9rbQ9wfV8haHy
 J79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361086; x=1714965886;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jzuUWu6bG8mAJ09DQsMaSkbyaQKWQKRU5BzKtgEAL9w=;
 b=SJownE1vkjr7/KQhtjF8Lm+zVvcaHeKFdc/QM69IeZp/wQPK5SzLkmQov085cfG/Hv
 recnngB9dh7ktrHymkUB0A+TWzZv3yt+MlAZlkvSzmDwhOP+BC/Cdh4jZgDL1WI842lU
 GLq7YvXNtt0GAznUbztczFvK8bA1QRx/zRyyQSKYYI6iq7h6qeRmW0ZLXoD5/qnnLL/g
 AbDu5/B9kGcgi5w1861QXL0ojtoM6FmyBT7bi1Xrhu0evMqCHQybz3dtMGz/1a4qxSvN
 NjfRT2av7rjDDKWKCF4a+kV7lPKCP7gbf3Xm7JYOduIaIG4FEhFkxb98tfkNfAgIeC4e
 KWqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT19NV0R69PRWvp91VTyuj8CRkIXBkfovbl+LsmkAyR8opUHdHspZ7JOwt5LFZ3ogWaAkCh9IwhoLjrQSWZP5xb21Ymhg=
X-Gm-Message-State: AOJu0Yzkk/sIwjFIfvF4Rt1vha5BtmA2pUkWEDL7//QsWfvW2bkDG+nR
 Bvf05XG3tpKzRlizbqCh3xWcBIkccCHIKPuGyVNWPQiIenGeglZXoq1w4mWnNzO1QilkoWctjUd
 wavR5wjDalQ==
X-Google-Smtp-Source: AGHT+IHJ19W+FMAKMMdJREfN54SoZxHnKc1lgTqptp/y4HLWsEeiuyaMZkuXSYa5Z826UhbvRTmpPQV3h17i4g==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:adf:f7d2:0:b0:34c:65a6:14c8 with SMTP id
 a18-20020adff7d2000000b0034c65a614c8mr16143wrq.4.1714361086443; Sun, 28 Apr
 2024 20:24:46 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:50 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-7-smostafa@google.com>
Subject: [RFC PATCH v3 06/18] hw/arm/smmu: Consolidate ASID and VMID types
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3_hIvZggKChkHBDHIz4z5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x44a.google.com
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

ASID and VMID used to be uint16_t in the translation config, however,
in other contexts they can be int as -1 in case of TLB invalidation,
to represent all(don=E2=80=99t care).
When stage-2 was added asid was set to -1 in stage-2 and vmid to -1
in stage-1 configs. However, that meant they were set as (65536),
this was not an issue as nesting was not supported and no
commands/lookup targets both.

With nesting, it=E2=80=99s critical to get this right as translation must b=
e
tagged correctly with ASID/VMID, and with ASID=3D-1 meaning stage-2.
Represent ASID/VMID everywhere as int.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 10 +++++-----
 hw/arm/smmuv3.c              |  4 ++--
 hw/arm/trace-events          | 18 +++++++++---------
 include/hw/arm/smmu-common.h | 14 +++++++-------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index d94db6b34f..21982621c0 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -57,7 +57,7 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gc=
onstpointer v2)
            (k1->vmid =3D=3D k2->vmid);
 }
=20
-SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iov=
a,
+SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level)
 {
     SMMUIOTLBKey key =3D {.asid =3D asid, .vmid =3D vmid, .iova =3D iova,
@@ -130,7 +130,7 @@ void smmu_iotlb_inv_all(SMMUState *s)
 static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
                                          gpointer user_data)
 {
-    uint16_t asid =3D *(uint16_t *)user_data;
+    int asid =3D *(int *)user_data;
     SMMUIOTLBKey *iotlb_key =3D (SMMUIOTLBKey *)key;
=20
     return SMMU_IOTLB_ASID(*iotlb_key) =3D=3D asid;
@@ -139,7 +139,7 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, =
gpointer value,
 static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
                                          gpointer user_data)
 {
-    uint16_t vmid =3D *(uint16_t *)user_data;
+    int vmid =3D *(int *)user_data;
     SMMUIOTLBKey *iotlb_key =3D (SMMUIOTLBKey *)key;
=20
     return SMMU_IOTLB_VMID(*iotlb_key) =3D=3D vmid;
@@ -191,13 +191,13 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int =
vmid, dma_addr_t iova,
                                 &info);
 }
=20
-void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
+void smmu_iotlb_inv_asid(SMMUState *s, int asid)
 {
     trace_smmu_iotlb_inv_asid(asid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid)=
;
 }
=20
-void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
+void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
 {
     trace_smmu_iotlb_inv_vmid(vmid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid)=
;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f98c157221..cc61708160 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1243,7 +1243,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         }
         case SMMU_CMD_TLBI_NH_ASID:
         {
-            uint16_t asid =3D CMD_ASID(&cmd);
+            int asid =3D CMD_ASID(&cmd);
=20
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error =3D SMMU_CERROR_ILL;
@@ -1276,7 +1276,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
-            uint16_t vmid =3D CMD_VMID(&cmd);
+            int vmid =3D CMD_VMID(&cmd);
=20
             if (!STAGE2_SUPPORTED(s)) {
                 cmd_error =3D SMMU_CERROR_ILL;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cc12924a84..09ccd39548 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -11,13 +11,13 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova,=
 uint64_t baseaddr, uint6
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t ptead=
dr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=3D%d le=
vel=3D%d base@=3D0x%"PRIx64" pte@=3D0x%"PRIx64" pte=3D0x%"PRIx64" iova=3D0x=
%"PRIx64" block address =3D 0x%"PRIx64" block size =3D %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte)=
 "baseaddr=3D0x%"PRIx64" index=3D0x%x, pteaddr=3D0x%"PRIx64", pte=3D0x%"PRI=
x64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
-smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=3D%d"
-smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=3D%d"
-smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=
=3D%d addr=3D0x%"PRIx64
+smmu_iotlb_inv_asid(int asid) "IOTLB invalidate asid=3D%d"
+smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=3D%d"
+smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=3D%d a=
ddr=3D0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=3D%s"
-smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_=
t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=3D%d vmid=3D%d addr=
=3D0x%"PRIx64" hit=3D%d miss=3D%d hit rate=3D%d"
-smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32=
_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=3D%d vmid=3D%d ad=
dr=3D0x%"PRIx64" hit=3D%d miss=3D%d hit rate=3D%d"
-smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg,=
 uint8_t level) "IOTLB ++ asid=3D%d vmid=3D%d addr=3D0x%"PRIx64" tg=3D%d le=
vel=3D%d"
+smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uin=
t32_t miss, uint32_t p) "IOTLB cache HIT asid=3D%d vmid=3D%d addr=3D0x%"PRI=
x64" hit=3D%d miss=3D%d hit rate=3D%d"
+smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, ui=
nt32_t miss, uint32_t p) "IOTLB cache MISS asid=3D%d vmid=3D%d addr=3D0x%"P=
RIx64" hit=3D%d miss=3D%d hit rate=3D%d"
+smmu_iotlb_insert(int asid, int vmid, uint64_t addr, uint8_t tg, uint8_t l=
evel) "IOTLB ++ asid=3D%d vmid=3D%d addr=3D0x%"PRIx64" tg=3D%d level=3D%d"
=20
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "=
addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
@@ -48,12 +48,12 @@ smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, ui=
nt32_t misses, uint32_t p
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uin=
t32_t perc) "Config cache MISS for sid=3D0x%x (hits=3D%d, misses=3D%d, hit =
rate=3D%d)"
 smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t=
 num_pages, uint8_t ttl, bool leaf) "vmid=3D%d asid=3D%d addr=3D0x%"PRIx64"=
 tg=3D%d num_pages=3D0x%"PRIx64" ttl=3D%d leaf=3D%d"
 smmuv3_cmdq_tlbi_nh(void) ""
-smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=3D%d"
-smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=3D%d"
+smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=3D%d"
+smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=3D%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=3D0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu=
 mr=3D%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu=
 mr=3D%s"
-smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, =
uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=3D%s asid=3D%d vmi=
d=3D%d iova=3D0x%"PRIx64" tg=3D%d num_pages=3D0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t i=
ova, uint8_t tg, uint64_t num_pages) "iommu mr=3D%s asid=3D%d vmid=3D%d iov=
a=3D0x%"PRIx64" tg=3D%d num_pages=3D0x%"PRIx64
=20
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity=
, int data_bits, int stop_bits) "%s speed=3D%d parity=3D%c data=3D%d stop=
=3D%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5944735632..96eb017e50 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -84,7 +84,7 @@ typedef struct SMMUS2Cfg {
     bool record_faults;     /* Record fault events (S2R) */
     uint8_t granule_sz;     /* Granule page shift (based on S2TG) */
     uint8_t eff_ps;         /* Effective PA output range (based on S2PS) *=
/
-    uint16_t vmid;          /* Virtual Machine ID (S2VMID) */
+    int vmid;               /* Virtual Machine ID (S2VMID) */
     uint64_t vttb;          /* Address of translation table base (S2TTB) *=
/
 } SMMUS2Cfg;
=20
@@ -108,7 +108,7 @@ typedef struct SMMUTransCfg {
     uint64_t ttb;              /* TT base address */
     uint8_t oas;               /* output address width */
     uint8_t tbi;               /* Top Byte Ignore */
-    uint16_t asid;
+    int asid;
     SMMUTransTableInfo tt[2];
     /* Used by stage-2 only. */
     struct SMMUS2Cfg s2cfg;
@@ -132,8 +132,8 @@ typedef struct SMMUPciBus {
=20
 typedef struct SMMUIOTLBKey {
     uint64_t iova;
-    uint16_t asid;
-    uint16_t vmid;
+    int asid;
+    int vmid;
     uint8_t tg;
     uint8_t level;
 } SMMUIOTLBKey;
@@ -205,11 +205,11 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32=
_t sid);
 SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                 SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *ent=
ry);
-SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iov=
a,
+SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
-void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
-void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
+void smmu_iotlb_inv_asid(SMMUState *s, int asid);
+void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova=
,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
=20
--=20
2.44.0.769.g3c40516874-goog


