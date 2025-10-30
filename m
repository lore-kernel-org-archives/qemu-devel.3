Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BFBCCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEN7j-0003A6-9F; Thu, 30 Oct 2025 03:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vEN7M-0002s9-PM; Thu, 30 Oct 2025 03:30:49 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vEN7H-000554-TO; Thu, 30 Oct 2025 03:30:44 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id D9861EC01BC;
 Thu, 30 Oct 2025 03:30:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 03:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761809431; x=
 1761895831; bh=Fe5bhLuyG5WOblCIlnczmwsx9+pG/Wxr2BLnDKiVnbY=; b=m
 k5votI4OdSQPp2PaJMZMYx+wDSHYOyAxN7kZ42He0kyLge9VxLNg8kGo+9WiHrS8
 I1bdNQmW648q14d1ejyXFKTs3zUBKF2atgj2rvMvgOHeONQ/nFXNgc6mvjgV5Ie6
 xnmK0WSkuIZ3wyHHuPUasTpOCaTRSuE/D3yD5/yjcJdMVYluv3A3UbGvMMV0trY1
 LXPhAFeFNWCUxrMGSsdhaWWIUrHJljUnMkf2055mOkJa1CRVhSMO8UkbkzqIu5m3
 nbv/YlUlFX8cdTnzozLvk1vpspuR07chs7BKWZA/SOzqN85w+JH+9toa2QpAFjIr
 Elfu2TN/zbrOB8bdZKrTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1761809431; x=1761895831; bh=F
 e5bhLuyG5WOblCIlnczmwsx9+pG/Wxr2BLnDKiVnbY=; b=RMRxdEqf9fuE+ihJM
 TKrUrQehtnB4+dRgdhI0pQn+D8SRkNmXABuZOFZDulVFKqzddO33bg4VN87pnWLW
 WKQu31dYPHRuiBbxqloIHoRAxPnElYoR6sso5RREAnaL5CPwt/KTqVtOtUvLIflC
 2Dnbz/NS5PsbiKuYwem2Ko0Gl5sjBQtg65nM6pWjKArmgASDGtc94URXYY1EQeSJ
 sdJt0Ra06ID3mj5EavgCwJC08KN7JqMZ/5oEa3pgMISjgh+GuRxvMzdk1f5lumWs
 O9O9v4UnytetONxoTQTsoaruCHQIyGNn5FDp2FdVzH5wSU9VlzW9/mfv0iY4thuR
 /A5bQ==
X-ME-Sender: <xms:FxQDaa9J0Q6tKGVb1-nFw3JbSeFMd27y335EqburTNvs9eNjEdtlsA>
 <xme:FxQDaUz58Fjiad7V6jKRuQtseE-haVvPEFUuozj0BCvCMrHI8e-avy8G4TKVxL76B
 cLo5qtCiS1ylS_PKnbqqq_syYInWrHAHbNUi63zlgXx7Hcz28MRxxY>
X-ME-Received: <xmr:FxQDaf7IfowvcMqt9G22Cw1M-HYxJGay_RxMlrFd9SZccljwWe4rVnDqAiL4QUkVCZlJou5wEcM1J0I6wmO9izLkk1x3RITUCEPAk2y-RxeKPXTXJ7uE6PsPEt64YIeM7r28GlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphht
 thhopegrlhgrnhdrrggurghmshhonhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepfh
 hoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghm
 shhunhhgrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprh
 gtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhu
 qdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:FxQDaT_DINfgrPhM82iNvsmQ4-RiFWdCjytdpG4CIJA3_T6Zi8oJlw>
 <xmx:FxQDacp5_jteX5x2EFO-7wJr9FVGR0e8ODG6ET04W3asfgRlqMrTWg>
 <xmx:FxQDacp05hNPkFgo4ylVsJHX71NEnkUBLsNDVczUz3IUoLKX-shQew>
 <xmx:FxQDaX3Eg4TvvpX_pU1bLtOF0-bVsNyxkLc41C3d8yu6DulzwFMOSA>
 <xmx:FxQDaZp353aWhC_t1-L1c9e1b6rt_9ulyYBsdGHuj0vyqwpUI1DXUyXk>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:30:30 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alan Adamson <alan.adamson@oracle.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Subject: [PULL 7/7] hw/nvme: add atomic boundary support
Date: Thu, 30 Oct 2025 08:29:55 +0100
Message-ID: <20251030072956.1194-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030072956.1194-1-its@irrelevant.dk>
References: <20251030072956.1194-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Alan Adamson <alan.adamson@oracle.com>

Add support for the namespace atomic boundary paramters: NABO, NABSN, and NABSPF.

Writes that cross an atomic boundary whose size is less than or equal to values
reported by AWUN/AWUPF are guaranteed to be atomic. If AWUN/AWUPF is set to zero,
writes that cross an atomic boundary are not guaranteed to be atomic.

The value reported by NABO field indicates the LBA on this namespace where the
first atomic boundary starts.

New NVMe QEMU Paramters (See NVMe Specification for details):
        atomic.nabo=UINT16 (default: 0)
        atomic.nabsn=UINT16 (default: 0)
        atomic.nabspf=UINT16 (default: 0)

See the NVMe Specification for more information.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c   | 36 ++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h |  8 ++++++++
 3 files changed, 97 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 121a95b2e373..4d150c7206ad 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6711,9 +6711,21 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                 if (n->dn) {
                     ns->atomic.atomic_max_write_size =
                         le16_to_cpu(ns->id_ns.nawupf) + 1;
+                    if (ns->id_ns.nabspf) {
+                        ns->atomic.atomic_boundary =
+                            le16_to_cpu(ns->id_ns.nabspf) + 1;
+                    } else {
+                        ns->atomic.atomic_boundary = 0;
+                    }
                 } else {
                     ns->atomic.atomic_max_write_size =
                         le16_to_cpu(ns->id_ns.nawun) + 1;
+                    if (ns->id_ns.nabsn) {
+                        ns->atomic.atomic_boundary =
+                            le16_to_cpu(ns->id_ns.nabsn) + 1;
+                    } else {
+                        ns->atomic.atomic_boundary = 0;
+                    }
                 }
                 if (ns->atomic.atomic_max_write_size == 1) {
                     ns->atomic.atomic_writes = 0;
@@ -7636,6 +7648,36 @@ static void nvme_update_sq_tail(NvmeSQueue *sq)
     trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
 }
 
+static int nvme_atomic_boundary_check(NvmeCtrl *n, NvmeCmd *cmd,
+    NvmeAtomic *atomic)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+
+    if (atomic->atomic_boundary) {
+        uint64_t slba = le64_to_cpu(rw->slba);
+        uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb);
+        uint64_t elba = slba + nlb;
+        uint64_t imask;
+
+        if ((slba < atomic->atomic_nabo) || (elba < atomic->atomic_nabo)) {
+            return 0;
+        }
+
+        /* Update slba/elba based on boundary offset */
+        slba = slba - atomic->atomic_nabo;
+        elba = slba + nlb;
+
+        imask = ~(atomic->atomic_boundary - 1);
+        if ((slba & imask) != (elba & imask)) {
+            if (n->atomic.atomic_max_write_size &&
+                ((nlb + 1) <= n->atomic.atomic_max_write_size)) {
+                return 1;
+            }
+            return 0;
+        }
+    }
+    return 1;
+}
 #define NVME_ATOMIC_NO_START        0
 #define NVME_ATOMIC_START_ATOMIC    1
 #define NVME_ATOMIC_START_NONATOMIC 2
@@ -7655,6 +7697,15 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
         cmd_atomic_wr = false;
     }
 
+    /*
+     * Check if a write crosses an atomic boundary.
+     */
+    if (cmd->opcode == NVME_CMD_WRITE) {
+        if (!nvme_atomic_boundary_check(n, cmd, atomic)) {
+            cmd_atomic_wr = false;
+        }
+    }
+
     /*
      * Walk the queues to see if there are any atomic conflicts.
      */
@@ -8741,6 +8792,8 @@ static void nvme_init_state(NvmeCtrl *n)
         } else {
             atomic->atomic_writes = 1;
         }
+        atomic->atomic_boundary = 0;
+        atomic->atomic_nabo = 0;
     }
 }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 28aacb8db59a..86f5ab0a7572 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -747,6 +747,28 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
             error_report("Invalid: NAWUN=%x NAWUPF=%x",
                 id_ns->nawun, id_ns->nawupf);
         }
+        id_ns->nabsn = cpu_to_le16(ns->params.atomic_nabsn);
+        id_ns->nabspf = cpu_to_le16(ns->params.atomic_nabspf);
+        id_ns->nabo = cpu_to_le16(ns->params.atomic_nabo);
+        if (!id->awun || (id_ns->nabsn && ((id_ns->nabsn < id_ns->nawun) ||
+            (id_ns->nabsn < id->awun)))) {
+            error_report("Invalid NABSN: %x NAWUN=%x AWUN=%x",
+                id_ns->nabsn, id_ns->nawun, id->awun);
+        }
+        if (!id->awupf || (id_ns->nabspf && ((id_ns->nabspf < id_ns->nawupf) ||
+            (id_ns->nawupf < id->awupf)))) {
+            error_report("Invalid NABSPF: %x NAWUPF=%x AWUPF=%x",
+                id_ns->nabspf, id_ns->nawupf, id->awupf);
+        }
+        if (id_ns->nabo && ((id_ns->nabo > id_ns->nabsn) ||
+            (id_ns->nabo > id_ns->nabspf))) {
+            error_report("Invalid NABO: %x NABSN=%x NABSPF=%x",
+                id_ns->nabo, id_ns->nabsn, id_ns->nabspf);
+        }
+        if (id_ns->nawupf > id_ns->nawun) {
+            error_report("Invalid: NAWUN=%x NAWUPF=%x", id_ns->nawun,
+                id_ns->nawupf);
+        }
     }
 
     if (id_ns->nawun || id_ns->nawupf) {
@@ -754,14 +776,25 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
         if (n->dn) {
             atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawupf) + 1;
+            if (id_ns->nabspf) {
+                atomic->atomic_boundary = cpu_to_le16(id_ns->nabspf) + 1;
+            } else {
+                atomic->atomic_boundary = 0;
+            }
         } else {
             atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawun) + 1;
+            if (id_ns->nabsn) {
+                atomic->atomic_boundary = cpu_to_le16(id_ns->nabsn) + 1;
+            } else {
+                atomic->atomic_boundary = 0;
+            }
         }
         if (atomic->atomic_max_write_size == 1) {
             atomic->atomic_writes = 0;
         } else {
             atomic->atomic_writes = 1;
         }
+        atomic->atomic_nabo = cpu_to_le16(id_ns->nabo);
     }
 
     /* reparent to subsystem bus */
@@ -841,6 +874,9 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_STRING("fdp.ruhs", NvmeNamespace, params.fdp.ruhs),
     DEFINE_PROP_UINT16("atomic.nawun", NvmeNamespace, params.atomic_nawun, 0),
     DEFINE_PROP_UINT16("atomic.nawupf", NvmeNamespace, params.atomic_nawupf, 0),
+    DEFINE_PROP_UINT16("atomic.nabspf", NvmeNamespace, params.atomic_nabspf, 0),
+    DEFINE_PROP_UINT16("atomic.nabsn", NvmeNamespace, params.atomic_nabsn, 0),
+    DEFINE_PROP_UINT16("atomic.nabo", NvmeNamespace, params.atomic_nabo, 0),
     DEFINE_PROP_BOOL("atomic.nsfeat", NvmeNamespace, params.atomic_nsfeat, 0),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 7d01080fc1f9..a7d225d2d80b 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -220,11 +220,16 @@ typedef struct NvmeNamespaceParams {
     } fdp;
     uint16_t atomic_nawun;
     uint16_t atomic_nawupf;
+    uint16_t atomic_nabsn;
+    uint16_t atomic_nabspf;
+    uint16_t atomic_nabo;
     bool     atomic_nsfeat;
 } NvmeNamespaceParams;
 
 typedef struct NvmeAtomic {
     uint32_t    atomic_max_write_size;
+    uint64_t    atomic_boundary;
+    uint64_t    atomic_nabo;
     bool        atomic_writes;
 } NvmeAtomic;
 
@@ -285,6 +290,9 @@ typedef struct NvmeNamespace {
     } fdp;
     uint16_t  atomic_nawun;
     uint16_t  atomic_nawupf;
+    uint16_t  atomic_nabsn;
+    uint16_t  atomic_nabspf;
+    uint16_t  atomic_nabo;
     NvmeAtomic  atomic;
 } NvmeNamespace;
 
-- 
2.51.0


