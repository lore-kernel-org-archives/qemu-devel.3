Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2CEC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOErT-0006OI-VS; Mon, 01 Jul 2024 07:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3C42CZggKCmoaUWabINIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--smostafa.bounces.google.com>)
 id 1sOEpa-0002XC-ER
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:29 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3C42CZggKCmoaUWabINIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--smostafa.bounces.google.com>)
 id 1sOEpR-0005SH-3J
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:19 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e0359e198ceso5628642276.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831820; x=1720436620; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=4Wsn10Q6EcfYP0+RS/ssBzezQ7yjVM+COl7mrZq27cw=;
 b=Gh57l+fYotUmMs/dyO66STgXNpoekT4jKvOioTZFaFPa0arOgqj3vN10s7hxCLQVod
 pDi2DtYNBdMaAxEtuGS08pBPptsFIMhBwP2kgbHxXum6TWItTlJSj7le8xFgy6OUUPo7
 FzFOFzxZOoKsbrBFeP+Hr/AUBYheKG+GVpUkgeqrT5DaNN7x6D/o19TeHAMJgnnSsJ2Z
 +PvrUv4wdWJBnr9vChSFvO6f4Rp+8nwkIzqYGaBqfZsLdO0LBmzzagDF0B3/GsE8lPMv
 sCQzhRyX5a5Q7v51DQmkj8xs2jLCBNczKESYDGZzfYCnYJsEp+Lw0dtrOd3lJjLXeq/4
 b3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831820; x=1720436620;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4Wsn10Q6EcfYP0+RS/ssBzezQ7yjVM+COl7mrZq27cw=;
 b=gjzyMYGPx6JTi66uh0l4Dyo9XCqlsW1v5HNv6vWu/mPPY1jdrSwi/P7KBxpKeNm17F
 0XubctXwlOJiSp6k/ocR/0ONcBZQtHEgSsJlJbGG0NQjdvl1fiQGMbId1Z74ztL9wT2i
 vSQTztMHXZloVvGMnj/HpWb/IHdlK0IPHUMSYxtfq0pj4JhonN5SCS+TgDxd+YcKMfMf
 e4OM0bB56VH/S74uoHV8/qup25RH0y9ta0kB3haZJpwo3zn07Nmz8mrkodlWQdEXJPXv
 eWVY6muzZaChOIW43nHfk0Wvkgi3KW0NxcvrwOW5CtX9L3MsnQfhm+YvzkwmuUi8XDwC
 jYGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/D9DlkAHCYj1WOiqQZvZbqA7W241ybzVKGj/xArHOqniHgDtMJtlq2PJUalJ26LWRVyPWy9ZuPQ5B3e43ZqRRUAwaUJk=
X-Gm-Message-State: AOJu0Ywj+WdsgFvw09M96YeObVWUV7ncHLiuRSBCNZKu/ziTc/17ti5/
 BOyQ/yZr8TYjZWr+2+RSk1XgNRfFI2iGgIUnU8y3EUIqNvUGgqqtBIgqVVa00TQ9NkIvuXmXhkE
 jln2FOKY77Q==
X-Google-Smtp-Source: AGHT+IEYjf+9fn+Q4Y5oniRwCoBNICkeU9ZQcpyTmJESFf5hSnorHgzAIbuFpsrAwqgsKMoffc6z9JuBqJw4ig==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:dbd3:0:b0:e03:60b4:b7a with SMTP id
 3f1490d57ef6-e036eb22e40mr249364276.6.1719831819774; Mon, 01 Jul 2024
 04:03:39 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:36 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-15-smostafa@google.com>
Subject: [PATCH v4 14/19] hw/arm/smmu: Support nesting in the rest of commands
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3C42CZggKCmoaUWabINIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--smostafa.bounces.google.com;
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
 hw/arm/smmu-common.c         | 16 ++++++++++++++++
 hw/arm/smmuv3.c              | 28 ++++++++++++++++++++++++++--
 hw/arm/trace-events          |  6 ++++--
 include/hw/arm/smmu-common.h |  1 +
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index d0309a95b2..faba4adc49 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -178,6 +178,16 @@ static gboolean smmu_hash_remove_by_vmid(gpointer key,=
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
@@ -288,6 +298,12 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
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
index 928f125523..e9007af3cd 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1321,25 +1321,49 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
+             * VMID is only matched when stage 2 is supported, otherwise s=
et it
+             * to -1 as the value used for stage-1 only VMIDs.
+             */
+            if (STAGE2_SUPPORTED(s)) {
+                vmid =3D CMD_VMID(&cmd);
+            }
+
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_asid_vmid(bs, asid, -1);
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
+             * invalidate the whole thing.
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
index 2bc9a03d47..361e639630 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -214,6 +214,7 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uin=
t64_t iova,
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
+void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova=
,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg=
,
--=20
2.45.2.803.g4e1b14247a-goog


