Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C251CEACC9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdcH-0000A0-6m; Tue, 01 Oct 2024 10:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbg-0007UN-5n; Tue, 01 Oct 2024 10:12:04 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbc-00034M-UU; Tue, 01 Oct 2024 10:12:03 -0400
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 74BB111412E9;
 Tue,  1 Oct 2024 03:04:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 03:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727766285; x=
 1727852685; bh=4x4njllrpEgg+I2ho9IlMJ6gfQVOYi2Scy0o+rUGnN0=; b=V
 zQk0g6ugK0Ih/p28IuksV9ErVKlV7+tjSOsCJUvzK12nWDpxLR3badiN2mMqDjkH
 EyGMr60psosQ5HZqZMWik2+w34O59TfmVLlkgTIGb3YLsyBh6JQNiaqxPO4ITGSs
 /U3EkXVgFlNQxJHVlQ6/oRY69NDgPCFtoX/ac8OuX2CkxKAcDxbb55z8QcA6B/rv
 YbnxJhyvwrCzjSQaFRpC8yZ2HbLsyhBb0o5wPYYeNyUqTYDdhnF+QuZDvvuXAway
 v61uckmZlFUVkvSP04j+IlZELbXGBVWSdwLFPDy2f6JOeL2uh3UiGPqcUsYcVXg+
 f56Ug8iLLW0Z7+09hFzbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727766285; x=
 1727852685; bh=4x4njllrpEgg+I2ho9IlMJ6gfQVOYi2Scy0o+rUGnN0=; b=b
 BQgzypilKB7BEDWR3EgQps9A7QidUWNKNcvhAW3rgc+5s/htJjIPJ/BlcmyX0nyw
 TbMmGmim2cVwzyrkadogc1hFdja8LdhN4N7cSLdb73nrzyGEMPGRofkHGqMq70CV
 6oYZ5kBFKl3pk+tJo93Pk5dtFVXfc+AHvBd9BXLlphvRLhGU/vVXWU9UH7gLpA/w
 DjWNhmeUIaaneJ32AsAE+ZdSYy3rfT1xS2iVOTD6BU9k3sDDokhqm3KprU2GghQG
 IXOkvTtCDMj1QJPeE5w5qyWdLiAdU5myLS886UF4eIUNkEAr8PBXQvbbY4tGr22B
 LHgHKMvT7uBp9+dIugglQ==
X-ME-Sender: <xms:DZ_7ZkopeKkAeL96Nwpub-LsnzJwgX7IYzEflsouM2B1RsgaX49FYw>
 <xme:DZ_7ZqoscKFMFSSud-4fAIO5tpRPekMv3vJ14hZWBhRcbm7KYx_c5x_OHMzUI7Kie
 _X1sEzna3bcifvfVjo>
X-ME-Received: <xmr:DZ_7ZpMY_BRSWaT3O7poyhVi7sLR9KY2p8y7pplndj7q-C10zaTAXNAueXqTkGnHLPj7Ocpk2jf_XPuCNnNdZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgudduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhi
 nhgrrhhordhorhhgpdhrtghpthhtoheprghlrghnrdgruggrmhhsohhnsehorhgrtghlvg
 drtghomhdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgt
 phhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesih
 hrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhi
 thdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:DZ_7Zr700dPD4l97xGOsKGjcqhj3GDJO9y-2oN04wSf4hDLg6gtQfw>
 <xmx:DZ_7Zj6ts3F_2jEuxk1tfhxbvpM9Hir2CDIDV34w8p1KIJpLEiyFCw>
 <xmx:DZ_7ZrgTNdHnbuN8SNyMXFPEXQsUxOouy8YroJGFmwuo78BX21I0hw>
 <xmx:DZ_7Zt5GjvPID8_4H9_R9Dm5LTPxpj4zF9mxhhpTtqbPaVleybu7uA>
 <xmx:DZ_7ZttLfsZ-uvXcgCj9i6g9wdCsg-7TKmzjd6AR4vEVpuKDXIoBhTjn>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 03:04:43 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alan Adamson <alan.adamson@oracle.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 5/5] hw/nvme: add atomic write support
Date: Tue,  1 Oct 2024 09:04:17 +0200
Message-ID: <20241001070418.28737-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001070418.28737-1-its@irrelevant.dk>
References: <20241001070418.28737-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
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

From: Alan Adamson <alan.adamson@oracle.com>

Adds support for the controller atomic parameters: AWUN and AWUPF. Atomic
Compare and Write Unit (ACWU) is not currently supported.

Writes that adhere to the ACWU and AWUPF parameters are guaranteed to be atomic.

New NVMe QEMU Parameters (See NVMe Specification for details):
       atomic.dn (default off) - Set the value of Disable Normal.
       atomic.awun=UINT16 (default: 0)
       atomic.awupf=UINT16 (default: 0)

By default (Disable Normal set to zero), the maximum atomic write size is
set to the AWUN value.  If Disable Normal is set, the maximum atomic write
size is set to AWUPF.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  12 ++++
 2 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 119adec31274..f4e89203c1a6 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -40,6 +40,9 @@
  *              sriov_vi_flexible=<N[optional]> \
  *              sriov_max_vi_per_vf=<N[optional]> \
  *              sriov_max_vq_per_vf=<N[optional]> \
+ *              atomic.dn=<on|off[optional]>, \
+ *              atomic.awun<N[optional]>, \
+ *              atomic.awupf<N[optional]>, \
  *              subsys=<subsys_id>
  *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
  *              zoned=<true|false[optional]>, \
@@ -254,6 +257,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
     [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
+    [NVME_WRITE_ATOMICITY]          = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
     [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
     [NVME_HOST_BEHAVIOR_SUPPORT]    = NVME_FEAT_CAP_CHANGE,
@@ -6309,8 +6313,10 @@ defaults:
         if (ret) {
             return ret;
         }
-        goto out;
+        break;
 
+    case NVME_WRITE_ATOMICITY:
+        result = n->dn;
         break;
     default:
         result = nvme_feature_default[fid];
@@ -6394,6 +6400,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t save = NVME_SETFEAT_SAVE(dw10);
     uint16_t status;
     int i;
+    NvmeIdCtrl *id = &n->id_ctrl;
+    NvmeAtomic *atomic = &n->atomic;
 
     trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
 
@@ -6546,6 +6554,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         return NVME_CMD_SEQ_ERROR | NVME_DNR;
     case NVME_FDP_EVENTS:
         return nvme_set_feature_fdp_events(n, ns, req);
+    case NVME_WRITE_ATOMICITY:
+
+        n->dn = 0x1 & dw11;
+
+        if (n->dn) {
+            atomic->atomic_max_write_size = le16_to_cpu(id->awupf) + 1;
+        } else {
+            atomic->atomic_max_write_size = le16_to_cpu(id->awun) + 1;
+        }
+
+        if (atomic->atomic_max_write_size == 1) {
+            atomic->atomic_writes = 0;
+        } else {
+            atomic->atomic_writes = 1;
+        }
+        break;
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -7243,6 +7267,81 @@ static void nvme_update_sq_tail(NvmeSQueue *sq)
     trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
 }
 
+#define NVME_ATOMIC_NO_START        0
+#define NVME_ATOMIC_START_ATOMIC    1
+#define NVME_ATOMIC_START_NONATOMIC 2
+
+static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
+    NvmeAtomic *atomic)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    uint64_t slba = le64_to_cpu(rw->slba);
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb);
+    uint64_t elba = slba + nlb;
+    bool cmd_atomic_wr = true;
+    int i;
+
+    if ((cmd->opcode == NVME_CMD_READ) || ((cmd->opcode == NVME_CMD_WRITE) &&
+        ((rw->nlb + 1) > atomic->atomic_max_write_size))) {
+        cmd_atomic_wr = false;
+    }
+
+    /*
+     * Walk the queues to see if there are any atomic conflicts.
+     */
+    for (i = 1; i < n->params.max_ioqpairs + 1; i++) {
+        NvmeSQueue *sq;
+        NvmeRequest *req;
+        NvmeRwCmd *req_rw;
+        uint64_t req_slba;
+        uint32_t req_nlb;
+        uint64_t req_elba;
+
+        sq = n->sq[i];
+        if (!sq) {
+            continue;
+        }
+
+        /*
+         * Walk all the requests on a given queue.
+         */
+        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
+            req_rw = (NvmeRwCmd *)&req->cmd;
+
+            if (((req_rw->opcode == NVME_CMD_WRITE) ||
+                 (req_rw->opcode == NVME_CMD_READ)) &&
+                (cmd->nsid == req->ns->params.nsid)) {
+                req_slba = le64_to_cpu(req_rw->slba);
+                req_nlb = (uint32_t)le16_to_cpu(req_rw->nlb);
+                req_elba = req_slba + req_nlb;
+
+                if (cmd_atomic_wr) {
+                    if ((elba >= req_slba) && (slba <= req_elba)) {
+                        return NVME_ATOMIC_NO_START;
+                    }
+                } else {
+                    if (req->atomic_write && ((elba >= req_slba) &&
+                        (slba <= req_elba))) {
+                        return NVME_ATOMIC_NO_START;
+                    }
+                }
+            }
+        }
+    }
+    if (cmd_atomic_wr) {
+        return NVME_ATOMIC_START_ATOMIC;
+    }
+    return NVME_ATOMIC_START_NONATOMIC;
+}
+
+static NvmeAtomic *nvme_get_atomic(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    if (n->atomic.atomic_writes) {
+        return &n->atomic;
+    }
+    return NULL;
+}
+
 static void nvme_process_sq(void *opaque)
 {
     NvmeSQueue *sq = opaque;
@@ -7259,6 +7358,9 @@ static void nvme_process_sq(void *opaque)
     }
 
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
+        NvmeAtomic *atomic;
+        bool cmd_is_atomic;
+
         addr = sq->dma_addr + (sq->head << NVME_SQES);
         if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
             trace_pci_nvme_err_addr_read(addr);
@@ -7266,6 +7368,26 @@ static void nvme_process_sq(void *opaque)
             stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
             break;
         }
+
+        atomic = nvme_get_atomic(n, &cmd);
+
+        cmd_is_atomic = false;
+        if (sq->sqid && atomic) {
+            int ret;
+
+            ret = nvme_atomic_write_check(n, &cmd, atomic);
+            switch (ret) {
+            case NVME_ATOMIC_NO_START:
+                qemu_bh_schedule(sq->bh);
+                return;
+            case NVME_ATOMIC_START_ATOMIC:
+                cmd_is_atomic = true;
+                break;
+            case NVME_ATOMIC_START_NONATOMIC:
+            default:
+                break;
+            }
+        }
         nvme_inc_sq_head(sq);
 
         req = QTAILQ_FIRST(&sq->req_list);
@@ -7275,6 +7397,10 @@ static void nvme_process_sq(void *opaque)
         req->cqe.cid = cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
+        if (sq->sqid && atomic) {
+            req->atomic_write = cmd_is_atomic;
+        }
+
         status = sq->sqid ? nvme_io_cmd(n, req) :
             nvme_admin_cmd(n, req);
         if (status != NVME_NO_COMPLETE) {
@@ -7378,6 +7504,8 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
     n->outstanding_aers = 0;
     n->qs_created = false;
 
+    n->dn = n->params.atomic_dn; /* Set Disable Normal */
+
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
     if (pci_is_vf(pci_dev)) {
@@ -8154,6 +8282,8 @@ static void nvme_init_state(NvmeCtrl *n)
     NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
+    NvmeAtomic *atomic = &n->atomic;
+    NvmeIdCtrl *id = &n->id_ctrl;
     uint8_t max_vfs;
     int i;
 
@@ -8211,6 +8341,29 @@ static void nvme_init_state(NvmeCtrl *n)
                         cpu_to_le16(n->params.sriov_max_vi_per_vf) :
                         cap->vifrt / MAX(max_vfs, 1);
     }
+
+    /* Atomic Write */
+    id->awun = cpu_to_le16(n->params.atomic_awun);
+    id->awupf = cpu_to_le16(n->params.atomic_awupf);
+    n->dn = n->params.atomic_dn;
+
+    if (id->awun || id->awupf) {
+        if (id->awupf > id->awun) {
+            id->awupf = 0;
+        }
+
+        if (n->dn) {
+            atomic->atomic_max_write_size = id->awupf + 1;
+        } else {
+            atomic->atomic_max_write_size = id->awun + 1;
+        }
+
+        if (atomic->atomic_max_write_size == 1) {
+            atomic->atomic_writes = 0;
+        } else {
+            atomic->atomic_writes = 1;
+        }
+    }
 }
 
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -8756,6 +8909,9 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
     DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
+    DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
+    DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
+    DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bd3c6ba33a67..7566b316d12d 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -220,6 +220,11 @@ typedef struct NvmeNamespaceParams {
     } fdp;
 } NvmeNamespaceParams;
 
+typedef struct NvmeAtomic {
+    uint32_t    atomic_max_write_size;
+    bool        atomic_writes;
+} NvmeAtomic;
+
 typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
@@ -421,6 +426,7 @@ typedef struct NvmeRequest {
     NvmeCmd                 cmd;
     BlockAcctCookie         acct;
     NvmeSg                  sg;
+    bool                    atomic_write;
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
@@ -542,6 +548,10 @@ typedef struct NvmeParams {
     struct {
         bool mem;
     } ctratt;
+
+    uint16_t atomic_awun;
+    uint16_t atomic_awupf;
+    bool     atomic_dn;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
@@ -623,6 +633,8 @@ typedef struct NvmeCtrl {
         uint16_t    vqrfap;
         uint16_t    virfap;
     } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset */
+    uint32_t    dn; /* Disable Normal */
+    NvmeAtomic  atomic;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
-- 
2.45.2


