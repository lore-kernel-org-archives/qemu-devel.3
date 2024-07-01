Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC2BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOErM-0005MH-PI; Mon, 01 Jul 2024 07:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CY2CZggKCmgYSUYZGLGMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--smostafa.bounces.google.com>)
 id 1sOEpP-0002MT-BL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:18 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CY2CZggKCmgYSUYZGLGMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--smostafa.bounces.google.com>)
 id 1sOEpE-0005S0-Ke
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:05 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6479d38bdfaso57896207b3.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831817; x=1720436617; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=5LSDXnoSPQ2MeCK2bUawg9m+cInschyHMnQt6fM6A24=;
 b=ySxY7d3zoki/GmhVQHprquIfD7wH56LG258pkp5Fk0y2kNGQuCYSxF6CfjMBZjE/Oy
 js8bBBJTZeCIpzWq/3XaZm4WZBA9jNgyWkifZu2nBnTCDbtL+FO0C9Lclew+XBWjU+9m
 D+fw+eQfME69ITbD07yzQxLh+tvrGqPwTAZDLSzYm5DNZ6/FV+sMiluOEyZVSazol8QJ
 HfD3D5yHvdJUo2vlWiR4tCj8kmtmuwe5tDZnLexFVhztQwxYgKqMumj4gvl0bUSsXepL
 NfbHTedaL1s8rqN35yYF3gf3GKRJR0NUWquR7mV4/HpYUNS0GuUTyIcdPKRQLeg2rj6a
 ypIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831817; x=1720436617;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5LSDXnoSPQ2MeCK2bUawg9m+cInschyHMnQt6fM6A24=;
 b=ZAmC84pXRu/7gINDkiC+tCnz54YCrWxX0B7EGLhg3E0Gl8ovsmwfqC7Iyn4TTtHhHY
 qIcoSj9mMU93a3mQuaHjVQKYYDycm6GcUWwbR6LCpeAc3KpiTL4UUDiD1KO0QMoHvoKO
 7HZKg9Bzl9L1qdMscc+F87McsfsZ0bDVW/kz97eWl/pwCv2W+2Qg0IXcIiQZGb2qjohE
 OPVz12vndQheRhmtyGp+WleQZA8Cx/qxdRnp2AKMCtRYZ+jWcMAXkiKtbMbuZyjt76Qh
 gRFsi9ypfNPOGvmKDV+kjE2ZGpUhTMTTbqZJ9rDEcHEF7NVssGjRPGdgxQMCM+NZc7j1
 fSzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU9D2VSXzBtA+tX87ojzlb2JowtEOVKXUT2oFBPKxpH8aZ4Z6w9ZIOKiLNVjQqliiTPBxbVaS7CjkPRKx5oM557kJaHas=
X-Gm-Message-State: AOJu0YxtDWHGhkrZoLGI4y3CUWD7dDbDU1iEg5uIIGYnP9gsApXeVllt
 OEt6uFcwKlFOnTmXAMK+nWTjEn2+2gWcFhr6EOEMs6mkWTOiyyKOEL9RsTPOri9kU5k4AWT0lnf
 b+6+ErHhQ2Q==
X-Google-Smtp-Source: AGHT+IG7I4C3dt0U1Z5kYgElyEilH4iD8Mt5db6kKuV8FdnmOnPAFKQ80uePpfbG/YpN+i9hI0/PQSLc1zCeaQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a0d:eb84:0:b0:61b:e8a2:6f4a with SMTP id
 00721157ae682-64c7258b7a2mr205927b3.0.1719831817139; Mon, 01 Jul 2024
 04:03:37 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:35 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-14-smostafa@google.com>
Subject: [PATCH v4 13/19] hw/arm/smmu: Introduce smmu_iotlb_inv_asid_vmid
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3CY2CZggKCmgYSUYZGLGMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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
which is a stage-1 command, so passing VMID = -1 keeps the original
behaviour.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 20 +++++++++++++-------
 hw/arm/smmuv3.c              |  2 +-
 include/hw/arm/smmu-common.h |  2 +-
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 5bf9eadeff..d0309a95b2 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -159,13 +159,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
     g_hash_table_remove_all(s->iotlb);
 }
 
-static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
-                                         gpointer user_data)
+static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
+                                              gpointer user_data)
 {
-    int asid = *(int *)user_data;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
-    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
+    return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
+           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
 }
 
 static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
@@ -270,10 +271,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                                 &info);
 }
 
-void smmu_iotlb_inv_asid(SMMUState *s, int asid)
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
 {
-    trace_smmu_iotlb_inv_asid(asid);
-    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
+    SMMUIOTLBPageInvInfo info = {
+        .asid = asid,
+        .vmid = vmid,
+    };
+
+    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
 }
 
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e5ecd93258..928f125523 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1329,7 +1329,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
-            smmu_iotlb_inv_asid(bs, asid);
+            smmu_iotlb_inv_asid_vmid(bs, asid, -1);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index de032fdfd1..2bc9a03d47 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -212,7 +212,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
-void smmu_iotlb_inv_asid(SMMUState *s, int asid);
+void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
-- 
2.45.2.803.g4e1b14247a-goog


