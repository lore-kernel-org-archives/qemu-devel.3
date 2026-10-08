Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24589CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEpDu-0001ni-PM; Thu, 08 Oct 2026 10:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xEpDs-0001nF-GP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 10:35:52 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xEpDp-000243-Ko
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 10:35:51 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 200541400090
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2026 10:35:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 10:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1791470146; x=1791556546; bh=n6
 Wn4D3mzo4oYk7NQN/ID+j+joyxzsVXeARZWy/L05M=; b=qYmeV1vZvu1kFPWwSf
 l1AdsR2BUOfGeP4mMLo9NLrZI3gyklodMM9mA9/stHHH3QCY1urNR8z5p74LcRwd
 DLcnsxP2/xrYxTTqs84lvof3rHNMBB/2OPBVmEL4+ajmEli/f7z49dw8xDPpUNXq
 QeDCyn7IXP+EcoJCXmTrkn6BJs/9sPISXw114pI38B/ESq+vcuytvCZXD6t8S8m+
 nCxHMqfuT0ja6jKDT146qoxNu6u9zf2ajgn5wMLgHFMyEa6VZ4wz+PDJhxVF7pyI
 OUmE+s5hlD/qGgJubd8lJP3wJ/NagNy7/YKMjkoXbqt2UYs8KVcsjscvgZneTmFV
 RcqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1791470146; x=1791556546; bh=n6Wn4D3mzo4oYk7NQN/ID+j+joyx
 zsVXeARZWy/L05M=; b=SiEMlkFdOUUCb1OBV0G9nNTlMzJ7nkvEEpisuAMVR0VG
 3QmmduZGY0uaeBNdlzm88RcNNnDiGcOoW5HM6n5KeeOcHbO0o0onk1FGLyvfTsMK
 qo4Z+01JbqFXD2IZQXkqvsKOOABQ2lrKShcMWTRs4FlmFtpET/ffMPPIZ+pKPtkD
 +L2omlLezZBa7CXJc/Dk12P6rBdcONXj08+WDbrYlg8ner76wbAvopi6i2OdwBP0
 daAy3ceGhkUGd9TjgoCHWlfmxAN06vHQDwnux6QjyMRVuZ2ey6OnmAETqWc3VVo2
 GLLAVye91On1YnvjeS3cpf2N4xX4FZ5ZcR73cGdi/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791470146; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:aKV+Clb4A9JML48PDemUY5AcfS8YsPrfa/5QJcmqJaa5XCB
 eMv3MkwdTaXHT+3qouDBuZ3RkODLKCdXQ1Z9D7artWXHl8Vn2fXJ358b5XwgCN8s
 ADMG4fkFKSbrMZ/Eznx4RGL3qUhkj1xtWsxbkP0a4uQOwcedCFOCHXId4kINbkle
 fNlGtDTPlHXIp0bi83KTAHM7Hs8sEJ8MRLYfou5KSmODxwvM1k+l3k4bMJAfRBHg
 E7l4lrECvhDKanev87ZPMjZzXjPGdmFeBOOva0fJ/UV/8a9wgBM02tVe6V0KT1A7
 ED1wl4ihGCc+Lxy33lQFEGQiBbp2xuCAlMVipLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:5omnnN/AowpticViCXsksZmK3Wqommz0Tn16dtZYjZk=:mpnn2COmg3tpEiEj168ofxeSyF/obTN9b3x+12nYw/w=;
X-ME-Sender: <xms:QarHarQ17BTVKGDNsT7S5IW9wi2J8cEJ9gCfyAD_JZ8FIACg8ChpAA>
 <xme:QarHalvvvr48-43oVAr7L5QX5f6i2b-L6dYKMONH9fb7RegO0QFpaekctkzEv2A8L
 wOmros1ysTYgQlFvsJH--RE9UB-sR5N0fGoczwZrYSBUcDEjEjyN-myJQ>
X-ME-Received: <xmr:QarHasbzdKp8QnHZ0pD5b9XMpofeW6eSjreNXFj-D_DJH7LfRJC3tiY1CidNh6nNOg_Pc4MChGmo7BqwC7DFJrHCfUC89vmIXvbO>
X-ME-Proxy-Cause: dmFkZTE+ctGgTnKvqBh2k/JVq6ZfE25a/Ap/llxMgKjGEIWDU8uOaqyLe6cdbrw9mgDsWC
 4qhsXEJXVxxOTCKhpShhOcC7+JJEfWlosbQV5kDz+g/egwNDLAEHAPRhbk2m+shLfFKH/M
 x8dYXBLGBMbiVmOPTwX8/fmb77VwrQ+UHgTLf9YJhbcc+7CCUp1NuHAiWq04mmkp8/icFP
 zf/yPnU19vywwgl7bUx9Qk+0AC7aSi49XW6bT65DogNK/4UyzNZvbr+fW6jQYoAZqi9Zof
 20dEfTzhWs+RJ6JeliS68K7/4io1hDr1mWgC0FiG7YcPc7mZkfMLP2TyL66MV0VZDX4DXM
 wkFWBWeh/LXrf2mqieYWE1BmrsdnU0/WeMdS2q4zgLBeQIAjqveZtY3u/vlnsQCZ7lRdEq
 tPHu1A5ROw3DgaaYTzn1jk1MoRKefHT6XaxWTv00NzG+t50Br1TnMHUsBlCiYyipa+pI+Q
 Ys2o5RPy8/7jWYsdBo/x+WLRmlLyiPJ+U3R1wtHTtffXBflrpW4Wf0cvEc7nv/xiYbr4+k
 yeg/rNrdQVNvUoFc5s/yTbpS445/te41uUbD2R80oQc02wOldpZi1+4uXqZogKzVsxu0WV
 m5FwZeqLmS/fLVaQGNazJDcDGTFz58AK8LoamRyol57wogL3ZZUDrhrcB1Og
X-ME-Proxy: <xmx:QarHarHwyAzHrdqslYnSokY6agyQRQ8auGTylvtsk5bwOWYL0CM34Q>
 <xmx:QarHagzcvKNsq1lTHo7OUhlkruZQrSil0zYqjiFz4RXm_DNh3-6rEg>
 <xmx:QarHatnoGYzl5u5q2GTvaF_iXPPmtkyk_K3gu4Ocq_EY_qXsEjaIcg>
 <xmx:QarHapnpvCooM9aqZYE8OOlblmGc3-F8UKhomqaRe1dNR2VxWkIB8g>
 <xmx:QqrHag1HjlEQ-iGS8MExjOH_0-P-wFxeyIVaAqyF_PwibfPyy1dRSlHN>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 10:35:44 -0400 (EDT)
From: Jesper Devantier <foss@defmacro.it>
Date: Thu, 08 Oct 2026 16:35:07 +0200
Subject: [PATCH] hw/nvme: generate deterministic NS UUID if unspecified
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-patch-review-20261008160517-b70-v1-1-05b7be840392@samsung.com>
X-B4-Tracking: v=1; b=H4sIABqqx2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwML3YLEkuQMXZDS1HJdmKihmYGpoblukrmBbqKZeaKBYXJSarJlohL
 QlIKi1LTMCrAN0bG1tQC+LdY8cQAAAA==
X-Change-ID: 20261008-patch-review-20261008160517-b70-a67a01cbec9a
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.153; envelope-from=foss@defmacro.it;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Jesper Wendel Devantier <j.devantier@samsung.com>

The base specification, from 1.4c to 2.4 states in the figure
"Namespace Identification Descriptor", that a NS for which EUI64
and NGUID are cleared, a descriptor of NIDT 3h containing the
namespace UUID must be returned.

docs/system/devices/nvme.rst, under "Additional Namespaces", says
that `uuid` defaults to an autogenerated value.

This commit derives a deterministic UUID from controller
VID/MN/SN fields and the Namespace's ID - provided the UUID was
not explicitly provided.
This change also ensures this UUID is returned in the NS
descriptor list.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c |  6 ++--
 hw/nvme/ns.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 hw/nvme/nvme.h |  5 +++-
 3 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 578421c217..0033d09e07 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6145,10 +6145,10 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (!qemu_uuid_is_null(&ns->params.uuid)) {
+    if (!qemu_uuid_is_null(&ns->uuid)) {
         uuid.hdr.nidt = NVME_NIDT_UUID;
         uuid.hdr.nidl = NVME_NIDL_UUID;
-        memcpy(uuid.v, ns->params.uuid.data, NVME_NIDL_UUID);
+        memcpy(uuid.v, ns->uuid.data, NVME_NIDL_UUID);
         memcpy(pos, &uuid, sizeof(uuid));
         pos += sizeof(uuid);
     }
@@ -9705,7 +9705,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         ns->ctrl = n;
         ns->subsys = n->subsys;
 
-        if (nvme_ns_setup(ns, errp)) {
+        if (nvme_ns_setup(ns, n, errp)) {
             return;
         }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 2ae26a9acb..e25191468f 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
+#include "qemu/xxhash.h"
 #include "system/system.h"
 #include "system/block-backend.h"
 #include "migration/vmstate.h"
@@ -63,6 +64,66 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     id_ns_nvm->npdgl = npdg;
 }
 
+static uint64_t nvme_ns_hash_field(const uint8_t *field, size_t len)
+{
+    uint64_t h = QEMU_XXHASH_SEED;
+
+    /* fold `field` of `len` bytes into a 64bit hash value */
+    while (len >= 8) {
+        h = qemu_xxhash64_4(h, ldq_le_p(field), 0, 0);
+        field += 8;
+        len -= 8;
+    }
+
+    while (len >= 4) {
+        h = qemu_xxhash64_4(h, ldl_le_p(field), 0, 0);
+        field += 4;
+        len -= 4;
+    }
+
+    while (len) {
+        h = qemu_xxhash64_4(h, *field++, 0, 0);
+        len--;
+    }
+
+    return h;
+}
+
+void nvme_ns_uuid_init(NvmeNamespace *ns, NvmeCtrl *n)
+{
+    uint64_t sn_hash, mn_hash, lo, hi;
+    uint32_t tmp[4];
+
+    /* user-provided value is preferred */
+    if (!qemu_uuid_is_null(&ns->params.uuid)) {
+        ns->uuid = ns->params.uuid;
+        return;
+    }
+
+    /*
+     * No uuid= given: derive one from the controller identity (VID/SN/MN)
+     * and the namespace id.  This is deterministic, so an OS can use it
+     * as a persistent disk identity across power cycles and resets.
+     */
+    sn_hash = nvme_ns_hash_field(n->id_ctrl.sn, sizeof(n->id_ctrl.sn));
+    mn_hash = nvme_ns_hash_field(n->id_ctrl.mn, sizeof(n->id_ctrl.mn));
+
+    lo = qemu_xxhash64_4(le16_to_cpu(n->id_ctrl.vid), ns->params.nsid,
+                         sn_hash, mn_hash);
+    hi = qemu_xxhash64_4(ns->params.nsid, le16_to_cpu(n->id_ctrl.vid),
+                         mn_hash, sn_hash);
+
+    tmp[0] = (uint32_t)(lo >> 32);
+    tmp[1] = (uint32_t)lo;
+    tmp[2] = (uint32_t)(hi >> 32);
+    tmp[3] = (uint32_t)hi;
+    memcpy(&ns->uuid, tmp, sizeof(tmp));
+
+    ns->uuid.data[8] = (ns->uuid.data[8] & 0x3f) | 0x80;
+    /* RFC 9562 - version 8 UUID (custom) */
+    ns->uuid.data[6] = (ns->uuid.data[6] & 0xf) | 0x80;
+}
+
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 {
     static uint64_t ns_count;
@@ -727,7 +788,7 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
     return 0;
 }
 
-int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
+int nvme_ns_setup(NvmeNamespace *ns, NvmeCtrl *n, Error **errp)
 {
     if (nvme_ns_check_constraints(ns, errp)) {
         return -1;
@@ -753,6 +814,8 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
         }
     }
 
+    nvme_ns_uuid_init(ns, n);
+
     return 0;
 }
 
@@ -922,18 +985,10 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     ns->subsys = subsys;
     ns->endgrp = &subsys->endgrp;
 
-    if (!nvme_ns_set_nsabp(n, ns, errp)) {
-        return;
-    }
-
-    if (!nvme_ns_set_nab(n, ns, errp)) {
-        return;
-    }
-
-    if (nvme_ns_setup(ns, errp)) {
-        return;
-    }
-
+    /*
+     * Resolve the namespace id before nvme_ns_setup(): the namespace UUID is
+     * derived from it, so it has to be final by then.
+     */
     if (!nsid) {
         for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
             if (nvme_subsys_ns(subsys, i)) {
@@ -953,6 +1008,18 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!nvme_ns_set_nsabp(n, ns, errp)) {
+        return;
+    }
+
+    if (!nvme_ns_set_nab(n, ns, errp)) {
+        return;
+    }
+
+    if (nvme_ns_setup(ns, n, errp)) {
+        return;
+    }
+
     subsys->namespaces[nsid] = ns;
 
     ns->id_ns.endgid = cpu_to_le16(0x1);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index a4b2c01a2c..477f7eeb4f 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -260,6 +260,8 @@ typedef struct NvmeNamespace {
     int          attached;
     uint8_t      pif;
 
+    QemuUUID     uuid;
+
     struct {
         uint16_t zrwas;
         uint16_t zrwafg;
@@ -410,7 +412,8 @@ static inline void nvme_fdp_stat_inc(uint64_t *a, uint64_t b)
 }
 
 void nvme_ns_init_format(NvmeNamespace *ns);
-int nvme_ns_setup(NvmeNamespace *ns, Error **errp);
+int nvme_ns_setup(NvmeNamespace *ns, NvmeCtrl *n, Error **errp);
+void nvme_ns_uuid_init(NvmeNamespace *ns, NvmeCtrl *n);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_shutdown(NvmeNamespace *ns);
 void nvme_ns_cleanup(NvmeNamespace *ns);

---
base-commit: f6c0588fd7c22caefc5b31f485c8bb3ee994a58b
change-id: 20261008-patch-review-20261008160517-b70-a67a01cbec9a

Best regards,
-- 
Jesper Wendel Devantier <j.devantier@samsung.com>


