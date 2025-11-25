Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DA9CFD37A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNoiE-00088D-Gi; Tue, 25 Nov 2025 03:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vNoiD-00087D-2n; Tue, 25 Nov 2025 03:47:49 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vNoiA-0008Bz-RG; Tue, 25 Nov 2025 03:47:48 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 4DA191D00234;
 Tue, 25 Nov 2025 03:47:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 25 Nov 2025 03:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1764060465; x=
 1764146865; bh=U1dP0nMMkej6FkoKDYCmZzMg0wuFTFgueJv1PwHiHLs=; b=j
 B++LrCVy7ijtwDVhzum9NCRFiOZMMZCw1pWseGnP/v7HEhzvIdGslSEWtZt3I9N/
 phBotEeZfGZ56wiC5KXPvcfDIjsTlkJLURqohwWQ18rLMikUtH23P2ZJzNLMUTp/
 vRfudemqxb0EqYD8oKFXMgH73XrLzL64EdJAkGTJqV7CbaAatUENQmr4kjT1R4tm
 t0LLTlRxBrlUfdLv/USCgBPL3UQhWmymINfKsv/oKAO4uRX8lTF3BQTq8y82laDr
 5kRGXT7p2qgBTHfTJoAynd/YFRmhBsXB7a/bFRi8yLbmKhQ2QDvBgKcCyZW/bm+d
 sh1HNA2Gz3H/EpYwhfSbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1764060465; x=1764146865; bh=U
 1dP0nMMkej6FkoKDYCmZzMg0wuFTFgueJv1PwHiHLs=; b=ietzRB2UlpU6ZE+fD
 Kl2n4phs95NhicRgISOMMkXINPmCLHjVUs/reyUrSPX1/TZWQ2qy+l0pioDGIOYE
 bayqrExS576stfn9E6YoIiQUL6LEnVkLHkZN0pbufAaMrWsMwEObSnUOgfg1ZsK8
 nQfTNOK6fzo2Nn0bjM9/cQH7fzKiM9OYwj1PQS1rMLbQPP5oCy5Dk65eYfdiTuTM
 iBmi1S/wVvLO6LPBqvXFDkiHZ7aUPd09lKzmFUiBJwHKwZ8UzQSk1vmDyAlQlOfa
 e4/qaC8VSuG9sW8ZGYmIS83Ffc7pw5u/qK9NWwImLnrbb9bHSjlOvay69fhRtHsO
 c4IMw==
X-ME-Sender: <xms:MG0laZToQo_HNfoJFyNVcI4LDk85pUqVwhhM49Zv9QiCB5KSXd1xRA>
 <xme:MG0laerRxtM60t2Qlma1pxJSKp5Ueeirm82raHQgJlpMClFO9R0BGgKlpI29DWa7i
 4D1jURaNms1Xq5_qyH9OZWsJyEHuPORQnaGXfbAUflCD7diJlO_rQ>
X-ME-Received: <xmr:MG0lab23wguZnHUUPZ62y6CGLCr4pFe8npsyXKO8D0A7jjq18HfbEbEzl4YveRkZtEP219yR83ZqgDe-72ZSBNHy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedutddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpd
 hrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghp
 thhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepfhhosh
 hsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdr
 ohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtoh
 epshhtvghfrghnhhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehfrghmsegvuhhp
 hhhonhdrnhgvthdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:MG0laV50afgoJFp4FrZb10g7zsjA5YmaJWT68co_8kjFxJ-eekAEPg>
 <xmx:MG0laXQ5bBbdVGgyTbtZDW-ve5eE9TBMXaWe42BKAr4gRIS1P-kNvg>
 <xmx:MG0laaXrUInzGGeRZc99Ma6zvFuJuQpGDz3G0PFnGY1PWTDXQbJo2w>
 <xmx:MG0lacEp0cMfa0z3lJ0sf3UxfFbpWVA-cizBr1E5KamANvPTWsOvZg>
 <xmx:MW0lac4ppZ-dFDqeDEeT8rQKsahCH8xxwvMq2SWqCTVKNwtBb1IhP0Jm>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 03:47:42 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 1/3] hw/nvme: fix namespace atomic parameter setup
Date: Tue, 25 Nov 2025 09:47:23 +0100
Message-ID: <20251125084725.4632-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125084725.4632-1-its@irrelevant.dk>
References: <20251125084725.4632-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.148; envelope-from=its@irrelevant.dk;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

Coverity complains about a possible copy-paste error in the verification
of the namespace atomic parameters (CID 1642811). While the check is
correct, the code (and the intention) is unclear.

Fix this by reworking how the parameters are verified. Peter also
identified that the realize function was not correctly erroring out if
parameters were misconfigured, so fix that too.

Lastly, change the error messages to be more describing.

Coverity: CID 1642811
Fixes: bce51b83709b ("hw/nvme: add atomic boundary support")
Fixes: 3b41acc96299 ("hw/nvme: enable ns atomic writes")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 115 +++++++++++++-------------
 hw/nvme/ns.c         | 189 ++++++++++++++++++++++++++-----------------
 hw/nvme/nvme.h       |  25 +++---
 include/block/nvme.h |   2 +-
 4 files changed, 185 insertions(+), 146 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4d150c7206ad..901d4d863355 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6524,6 +6524,53 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
+                                          uint16_t awupf, NvmeAtomic *atomic)
+{
+    atomic->atomic_max_write_size = (dn ? awupf : awun) + 1;
+
+    if (atomic->atomic_max_write_size > 1) {
+        atomic->atomic_writes = 1;
+    }
+}
+
+static uint16_t nvme_set_feature_write_atomicity(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeCmd *cmd = &req->cmd;
+
+    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
+
+    uint16_t awun = le16_to_cpu(n->id_ctrl.awun);
+    uint16_t awupf = le16_to_cpu(n->id_ctrl.awupf);
+
+    n->dn = dw11 & 0x1;
+
+    nvme_atomic_configure_max_write_size(n->dn, awun, awupf, &n->atomic);
+
+    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        uint16_t nawun, nawupf, nabsn, nabspf;
+
+        NvmeNamespace *ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        nawun = le16_to_cpu(ns->id_ns.nawun);
+        nawupf = le16_to_cpu(ns->id_ns.nawupf);
+
+        nvme_atomic_configure_max_write_size(n->dn, nawun, nawupf,
+                                             &ns->atomic);
+
+        nabsn = le16_to_cpu(ns->id_ns.nabsn);
+        nabspf = le16_to_cpu(ns->id_ns.nabspf);
+
+        nvme_ns_atomic_configure_boundary(n->dn, nabsn, nabspf,
+                                          &ns->atomic);
+    }
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns = NULL;
@@ -6536,8 +6583,6 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t save = NVME_SETFEAT_SAVE(dw10);
     uint16_t status;
     int i;
-    NvmeIdCtrl *id = &n->id_ctrl;
-    NvmeAtomic *atomic = &n->atomic;
 
     trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
 
@@ -6691,50 +6736,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     case NVME_FDP_EVENTS:
         return nvme_set_feature_fdp_events(n, ns, req);
     case NVME_WRITE_ATOMICITY:
-
-        n->dn = 0x1 & dw11;
-
-        if (n->dn) {
-            atomic->atomic_max_write_size = le16_to_cpu(id->awupf) + 1;
-        } else {
-            atomic->atomic_max_write_size = le16_to_cpu(id->awun) + 1;
-        }
-
-        if (atomic->atomic_max_write_size == 1) {
-            atomic->atomic_writes = 0;
-        } else {
-            atomic->atomic_writes = 1;
-        }
-        for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-            ns = nvme_ns(n, i);
-            if (ns && ns->atomic.atomic_writes) {
-                if (n->dn) {
-                    ns->atomic.atomic_max_write_size =
-                        le16_to_cpu(ns->id_ns.nawupf) + 1;
-                    if (ns->id_ns.nabspf) {
-                        ns->atomic.atomic_boundary =
-                            le16_to_cpu(ns->id_ns.nabspf) + 1;
-                    } else {
-                        ns->atomic.atomic_boundary = 0;
-                    }
-                } else {
-                    ns->atomic.atomic_max_write_size =
-                        le16_to_cpu(ns->id_ns.nawun) + 1;
-                    if (ns->id_ns.nabsn) {
-                        ns->atomic.atomic_boundary =
-                            le16_to_cpu(ns->id_ns.nabsn) + 1;
-                    } else {
-                        ns->atomic.atomic_boundary = 0;
-                    }
-                }
-                if (ns->atomic.atomic_max_write_size == 1) {
-                    ns->atomic.atomic_writes = 0;
-                } else {
-                    ns->atomic.atomic_writes = 1;
-                }
-            }
-        }
-        break;
+        return nvme_set_feature_write_atomicity(n, req);
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -7669,6 +7671,10 @@ static int nvme_atomic_boundary_check(NvmeCtrl *n, NvmeCmd *cmd,
 
         imask = ~(atomic->atomic_boundary - 1);
         if ((slba & imask) != (elba & imask)) {
+            /*
+             * The write crosses an atomic boundary and the controller provides
+             * no atomicity guarantees unless AWUN/AWUPF are non-zero.
+             */
             if (n->atomic.atomic_max_write_size &&
                 ((nlb + 1) <= n->atomic.atomic_max_write_size)) {
                 return 1;
@@ -8709,7 +8715,6 @@ static void nvme_init_state(NvmeCtrl *n)
     NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
-    NvmeAtomic *atomic = &n->atomic;
     NvmeIdCtrl *id = &n->id_ctrl;
     uint8_t max_vfs;
     int i;
@@ -8781,19 +8786,9 @@ static void nvme_init_state(NvmeCtrl *n)
             id->awupf = 0;
         }
 
-        if (n->dn) {
-            atomic->atomic_max_write_size = id->awupf + 1;
-        } else {
-            atomic->atomic_max_write_size = id->awun + 1;
-        }
-
-        if (atomic->atomic_max_write_size == 1) {
-            atomic->atomic_writes = 0;
-        } else {
-            atomic->atomic_writes = 1;
-        }
-        atomic->atomic_boundary = 0;
-        atomic->atomic_nabo = 0;
+        nvme_atomic_configure_max_write_size(n->dn, n->params.atomic_awun,
+                                             n->params.atomic_awupf,
+                                             &n->atomic);
     }
 }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 86f5ab0a7572..253e7b406b4e 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -718,85 +718,119 @@ static void nvme_ns_unrealize(DeviceState *dev)
     nvme_ns_cleanup(ns);
 }
 
+void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
+                                       uint16_t nabspf, NvmeAtomic *atomic)
+{
+    atomic->atomic_boundary = dn ? nabspf : nabsn;
+
+    if (atomic->atomic_boundary > 0) {
+        atomic->atomic_boundary += 1;
+    }
+}
+
+static bool nvme_ns_set_nab(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdCtrl *id_ctrl = &n->id_ctrl;
+
+    uint16_t nabsn = ns->params.atomic.nabsn;
+    uint16_t nabspf = ns->params.atomic.nabspf;
+    uint16_t nabo = ns->params.atomic.nabo;
+
+    if (nabsn && nabsn < le16_to_cpu(id_ctrl->awun)) {
+        error_setg(errp, "nabsn must be greater than or equal to awun");
+        return false;
+    }
+
+    if (nabspf && nabspf < le16_to_cpu(id_ctrl->awupf)) {
+        error_setg(errp, "nabspf must be greater than or equal to awupf");
+        return false;
+    }
+
+    if (id_ns->nsfeat & NVME_ID_NS_NSFEAT_NSABP) {
+        if (nabsn && nabsn < le16_to_cpu(id_ns->nawun)) {
+            error_setg(errp, "nabsn must be greater than or equal to nawun");
+            return false;
+        }
+
+        if (nabspf && nabspf < le16_to_cpu(id_ns->nawupf)) {
+            error_setg(errp, "nabspf must be great than or equal to nawupf");
+            return false;
+        }
+    }
+
+    if (nabo && (nabo > nabsn || nabo > nabspf)) {
+        error_setg(errp, "nabo must be less than or equal to nabsn and nabspf");
+        return false;
+    }
+
+    id_ns->nabsn = cpu_to_le16(nabsn);
+    id_ns->nabspf = cpu_to_le16(nabspf);
+    id_ns->nabo = cpu_to_le16(nabo);
+
+    ns->atomic.atomic_nabo = nabo;
+
+    nvme_ns_atomic_configure_boundary(n->dn, nabsn, nabspf, &ns->atomic);
+
+    return true;
+}
+
+static bool nvme_ns_set_nsabp(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdCtrl *id_ctrl = &n->id_ctrl;
+
+    uint16_t awun = le16_to_cpu(id_ctrl->awun);
+    uint16_t awupf = le16_to_cpu(id_ctrl->awupf);
+
+    uint16_t nawun = ns->params.atomic.nawun;
+    uint16_t nawupf = ns->params.atomic.nawupf;
+
+    if (nawupf > nawun) {
+        if (nawun == 0) {
+            nawun = nawupf;
+        } else {
+            error_setg(errp, "nawupf must be less than or equal to nawun");
+            return false;
+        }
+    }
+
+    /* neither nawun or nawupf is set */
+    if (nawun == 0) {
+        return true;
+    }
+
+    if (nawun < awun) {
+        error_setg(errp, "nawun must be greater than or equal to awun");
+        return false;
+    }
+
+    if (nawupf < awupf) {
+        error_setg(errp, "nawupf must be greater than or equal to awupf");
+        return false;
+    }
+
+    id_ns->nsfeat |= NVME_ID_NS_NSFEAT_NSABP;
+
+    id_ns->nawun = cpu_to_le16(nawun);
+    id_ns->nawupf = cpu_to_le16(nawupf);
+
+    nvme_atomic_configure_max_write_size(n->dn, nawun, nawupf, &ns->atomic);
+
+    return true;
+}
+
 static void nvme_ns_realize(DeviceState *dev, Error **errp)
 {
     NvmeNamespace *ns = NVME_NS(dev);
     BusState *s = qdev_get_parent_bus(dev);
     NvmeCtrl *n = NVME(s->parent);
     NvmeSubsystem *subsys = n->subsys;
-    NvmeIdCtrl *id = &n->id_ctrl;
-    NvmeIdNs *id_ns = &ns->id_ns;
     uint32_t nsid = ns->params.nsid;
     int i;
 
     assert(subsys);
 
-    /* Set atomic write parameters */
-    if (ns->params.atomic_nsfeat) {
-        id_ns->nsfeat |= NVME_ID_NS_NSFEAT_NSABPNS;
-        id_ns->nawun = cpu_to_le16(ns->params.atomic_nawun);
-        if (!id->awupf || (id_ns->nawun && (id_ns->nawun < id->awun))) {
-            error_report("Invalid NAWUN: %x AWUN=%x", id_ns->nawun, id->awun);
-        }
-        id_ns->nawupf = cpu_to_le16(ns->params.atomic_nawupf);
-        if (!id->awupf || (id_ns->nawupf && (id_ns->nawupf < id->awupf))) {
-            error_report("Invalid NAWUPF: %x AWUPF=%x",
-                id_ns->nawupf, id->awupf);
-        }
-        if (id_ns->nawupf > id_ns->nawun) {
-            error_report("Invalid: NAWUN=%x NAWUPF=%x",
-                id_ns->nawun, id_ns->nawupf);
-        }
-        id_ns->nabsn = cpu_to_le16(ns->params.atomic_nabsn);
-        id_ns->nabspf = cpu_to_le16(ns->params.atomic_nabspf);
-        id_ns->nabo = cpu_to_le16(ns->params.atomic_nabo);
-        if (!id->awun || (id_ns->nabsn && ((id_ns->nabsn < id_ns->nawun) ||
-            (id_ns->nabsn < id->awun)))) {
-            error_report("Invalid NABSN: %x NAWUN=%x AWUN=%x",
-                id_ns->nabsn, id_ns->nawun, id->awun);
-        }
-        if (!id->awupf || (id_ns->nabspf && ((id_ns->nabspf < id_ns->nawupf) ||
-            (id_ns->nawupf < id->awupf)))) {
-            error_report("Invalid NABSPF: %x NAWUPF=%x AWUPF=%x",
-                id_ns->nabspf, id_ns->nawupf, id->awupf);
-        }
-        if (id_ns->nabo && ((id_ns->nabo > id_ns->nabsn) ||
-            (id_ns->nabo > id_ns->nabspf))) {
-            error_report("Invalid NABO: %x NABSN=%x NABSPF=%x",
-                id_ns->nabo, id_ns->nabsn, id_ns->nabspf);
-        }
-        if (id_ns->nawupf > id_ns->nawun) {
-            error_report("Invalid: NAWUN=%x NAWUPF=%x", id_ns->nawun,
-                id_ns->nawupf);
-        }
-    }
-
-    if (id_ns->nawun || id_ns->nawupf) {
-        NvmeAtomic *atomic = &ns->atomic;
-
-        if (n->dn) {
-            atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawupf) + 1;
-            if (id_ns->nabspf) {
-                atomic->atomic_boundary = cpu_to_le16(id_ns->nabspf) + 1;
-            } else {
-                atomic->atomic_boundary = 0;
-            }
-        } else {
-            atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawun) + 1;
-            if (id_ns->nabsn) {
-                atomic->atomic_boundary = cpu_to_le16(id_ns->nabsn) + 1;
-            } else {
-                atomic->atomic_boundary = 0;
-            }
-        }
-        if (atomic->atomic_max_write_size == 1) {
-            atomic->atomic_writes = 0;
-        } else {
-            atomic->atomic_writes = 1;
-        }
-        atomic->atomic_nabo = cpu_to_le16(id_ns->nabo);
-    }
-
     /* reparent to subsystem bus */
     if (!qdev_set_parent_bus(dev, &subsys->bus.parent_bus, errp)) {
         return;
@@ -804,6 +838,14 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     ns->subsys = subsys;
     ns->endgrp = &subsys->endgrp;
 
+    if (!nvme_ns_set_nsabp(n, ns, errp)) {
+        return;
+    }
+
+    if (!nvme_ns_set_nab(n, ns, errp)) {
+        return;
+    }
+
     if (nvme_ns_setup(ns, errp)) {
         return;
     }
@@ -872,12 +914,11 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_BOOL("eui64-default", NvmeNamespace, params.eui64_default,
                      false),
     DEFINE_PROP_STRING("fdp.ruhs", NvmeNamespace, params.fdp.ruhs),
-    DEFINE_PROP_UINT16("atomic.nawun", NvmeNamespace, params.atomic_nawun, 0),
-    DEFINE_PROP_UINT16("atomic.nawupf", NvmeNamespace, params.atomic_nawupf, 0),
-    DEFINE_PROP_UINT16("atomic.nabspf", NvmeNamespace, params.atomic_nabspf, 0),
-    DEFINE_PROP_UINT16("atomic.nabsn", NvmeNamespace, params.atomic_nabsn, 0),
-    DEFINE_PROP_UINT16("atomic.nabo", NvmeNamespace, params.atomic_nabo, 0),
-    DEFINE_PROP_BOOL("atomic.nsfeat", NvmeNamespace, params.atomic_nsfeat, 0),
+    DEFINE_PROP_UINT16("atomic.nawun", NvmeNamespace, params.atomic.nawun, 0),
+    DEFINE_PROP_UINT16("atomic.nawupf", NvmeNamespace, params.atomic.nawupf, 0),
+    DEFINE_PROP_UINT16("atomic.nabsn", NvmeNamespace, params.atomic.nabsn, 0),
+    DEFINE_PROP_UINT16("atomic.nabspf", NvmeNamespace, params.atomic.nabspf, 0),
+    DEFINE_PROP_UINT16("atomic.nabo", NvmeNamespace, params.atomic.nabo, 0),
 };
 
 static void nvme_ns_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index a7d225d2d80b..8f8c78c85036 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -218,12 +218,14 @@ typedef struct NvmeNamespaceParams {
     struct {
         char *ruhs;
     } fdp;
-    uint16_t atomic_nawun;
-    uint16_t atomic_nawupf;
-    uint16_t atomic_nabsn;
-    uint16_t atomic_nabspf;
-    uint16_t atomic_nabo;
-    bool     atomic_nsfeat;
+
+    struct {
+        uint16_t nawun;
+        uint16_t nawupf;
+        uint16_t nabsn;
+        uint16_t nabspf;
+        uint16_t nabo;
+    } atomic;
 } NvmeNamespaceParams;
 
 typedef struct NvmeAtomic {
@@ -288,11 +290,7 @@ typedef struct NvmeNamespace {
         /* reclaim unit handle identifiers indexed by placement handle */
         uint16_t *phs;
     } fdp;
-    uint16_t  atomic_nawun;
-    uint16_t  atomic_nawupf;
-    uint16_t  atomic_nabsn;
-    uint16_t  atomic_nabspf;
-    uint16_t  atomic_nabo;
+
     NvmeAtomic  atomic;
 } NvmeNamespace;
 
@@ -742,4 +740,9 @@ void nvme_rw_complete_cb(void *opaque, int ret);
 uint16_t nvme_map_dptr(NvmeCtrl *n, NvmeSg *sg, size_t len,
                        NvmeCmd *cmd);
 
+void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
+                                          uint16_t awupf, NvmeAtomic *atomic);
+void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
+                                       uint16_t nabspf, NvmeAtomic *atomic);
+
 #endif /* HW_NVME_NVME_H */
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9fa2ecaf281c..8640dfa8269f 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1589,7 +1589,7 @@ enum NvmeIdNsMc {
 
 enum NvmeIdNsNsfeat {
     NVME_ID_NS_NSFEAT_THINP         = 1 << 0,
-    NVME_ID_NS_NSFEAT_NSABPNS       = 1 << 1,
+    NVME_ID_NS_NSFEAT_NSABP         = 1 << 1,
     NVME_ID_NS_NSFEAT_DAE           = 1 << 2,
     NVME_ID_NS_NSFEAT_UIDREUSE      = 1 << 3,
     NVME_ID_NS_NSFEAT_OPTPERF_ALL   = 3 << 4,
-- 
2.51.0


