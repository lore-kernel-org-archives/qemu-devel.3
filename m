Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD191CCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEN7o-0003Gx-Al; Thu, 30 Oct 2025 03:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vEN7G-0002rW-Um; Thu, 30 Oct 2025 03:30:49 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vEN77-00053T-1b; Thu, 30 Oct 2025 03:30:36 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 0A6F0EC01B4;
 Thu, 30 Oct 2025 03:30:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 30 Oct 2025 03:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761809424; x=
 1761895824; bh=YSmhy8uvp1IebovAkUeKiP0mQVZdssdt+4rnnGSCCiM=; b=T
 tA8I9XdPU9GU2YV5h3XpVN/xVs8KuVfxsrOkWtSX6UX57lA8BUp0mUilCThydSMu
 Oa1FnKnTrVMFeKfHNz3+UqRaEue6q+4+Uyovjk3/vI/cF04FBKnOOG1lI7Gom6kc
 5XleA3EBD3n5uaJoVlRrgLADwsTe5BmHZ4YVNNHr75Ak3Lt5INmGZI8T70OHbpGA
 naNifJctXnMkUU8elEp94HEcVStZ+HBmnKRDZUoaP56n8nnxBTJNEpeKZq97bT3s
 qDhTGfKQ9cWXeh9nDEO+D/P2//VHdbOIt3gjaOwcnZ1EnzqkkHIGf+EYosYzYhLS
 A3DfcK3ltaFio+4y/Kgww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1761809424; x=1761895824; bh=Y
 Smhy8uvp1IebovAkUeKiP0mQVZdssdt+4rnnGSCCiM=; b=L3tNLFa6s5L4knnBU
 YBvMKkdoQuegKx7Wu0K6e7mP+BILKpcTSk0dyt1zFPT4Y6c0EPtcZFRZI8Sgc54j
 Hcog4z16R3aZ+kJsLC0UDqckA4/LirK63ZVyihvrtcp9Z78XRb9rXoIeVMHHkWfr
 ukdzWNJclpYnNSzKscGp4qwCnsGCBP5TNFCChcFDX/qG134IJ7pef9lXYLJVnrtN
 q4m6SMkXHpuZlNn71mZYndsPJaR1BHhqLSwN/Efohj1PuXeY2KvjA1KX0cCwzOQc
 g8GFSyG4rC+SM6YuUwAzXUW84bGnsA1G5V5qRNc+Y7ewxNLSsZJx1tK6zTjtZL3S
 NdMnA==
X-ME-Sender: <xms:DhQDaY2CKdOri1oy1oo8WBULphhuEBlZs5CZ0gRVc0nVWHwHVTf9oQ>
 <xme:DhQDaXrXbrYPtbc1LPCNeAwa5JBpxoyiK0bJH6m118xZdPbhJ4AyrjmaLWsFjQzqv
 xZ5TbCgg0YJyZQa1S943L87rtZ5pFx0BGiFPjfyGalAK9KvFFzmyAo>
X-ME-Received: <xmr:DhQDaeDaIfRTCN4j1pQo06a5npwC0yTpF7hOKQFEW-tFWqYoXGtO6E9F7sdHrhuZOncY5zLwA0Cz562HIEDYUJXcvXcY2SRF_zddzS1OEIEHKYtliSK4WO0T6ZDdRm6CfVT1de4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpd
 hrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghp
 thhtohepfihilhhfrhgvugdrmhgrlhhlrgifrgesfigutgdrtghomhdprhgtphhtthhope
 hsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghn
 rdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehkrdhjvghnshgvnh
 esshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghi
 shesfigutgdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpd
 hrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:DhQDaYoCS6Zow_mSTvCFbpwhhwsOWZ-cfRLZZe0v1SzcLOqxQCZ3gg>
 <xmx:DhQDaZAlpbxeKvVLnYunyUI-ejeIcl271DmsvYVoPNtMndOkaP9LJg>
 <xmx:DhQDaTX-lt_wZ89cF6ABdERxfuvpnUTkpvvX7ACOok0vc1je0KC5HQ>
 <xmx:DhQDabD-8EUG5_0Uk2Y3rdGMGhCDaCN0k-K06N2wc-jwF_EKR64XHA>
 <xmx:EBQDaeW2Yc8xj3BFsccIbDrTL0fzgUhk8O5eFb56F6vAHnVTjDvEK7Op>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:30:20 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 3/7] hw/nvme: add NVMe Admin Security SPDM support
Date: Thu, 30 Oct 2025 08:29:51 +0100
Message-ID: <20251030072956.1194-4-its@irrelevant.dk>
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Adds the NVMe Admin Security Send/Receive command support with support
for DMTFs SPDM. The transport binding for SPDM is defined in the
DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c               | 212 ++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 +++
 include/system/spdm-socket.h |   2 +
 4 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cd81f7399754..e450e785ea10 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] = {
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_SECURITY_SEND]    = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_SECURITY_RECV]    = NVME_CMD_EFF_CSUPP,
 };
 
 static const uint32_t nvme_cse_iocs_nvm_default[256] = {
@@ -7282,6 +7284,207 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    StorageSpdmTransportHeader hdr = {0};
+    g_autofree uint8_t *sec_buf = NULL;
+    uint32_t transfer_len = le32_to_cpu(req->cmd.cdw11);
+    uint32_t transport_transfer_len = transfer_len;
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint32_t recvd;
+    uint16_t nvme_cmd_status, ret;
+    uint8_t secp = extract32(dw10, 24, 8);
+    uint16_t spsp = extract32(dw10, 8, 16);
+    bool spdm_res;
+
+    if (transport_transfer_len > UINT32_MAX - sizeof(hdr)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    transport_transfer_len += sizeof(hdr);
+    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    ret = nvme_check_mdts(n, transport_transfer_len);
+    if (ret != NVME_SUCCESS) {
+        return ret;
+    }
+
+    /* Generate the NVMe transport header */
+    hdr.security_protocol = secp;
+    hdr.security_protocol_specific = cpu_to_le16(spsp);
+    hdr.length = cpu_to_le32(transfer_len);
+
+    sec_buf = g_try_malloc0(transport_transfer_len);
+    if (!sec_buf) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    /* Attach the transport header */
+    memcpy(sec_buf, &hdr, sizeof(hdr));
+    ret = nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
+    if (ret) {
+        return ret;
+    }
+
+    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_SEND,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf,
+                                transport_transfer_len);
+    if (!spdm_res) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    /* The responder shall ack with message status */
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                &nvme_cmd_status,
+                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
+
+    nvme_cmd_status = be16_to_cpu(nvme_cmd_status);
+
+    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    return nvme_cmd_status;
+}
+
+/* From host to controller */
+static uint16_t nvme_security_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t secp = extract32(dw10, 24, 8);
+
+    switch (secp) {
+    case NVME_SEC_PROT_DMTF_SPDM:
+        if (n->spdm_socket < 0) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        return nvme_sec_prot_spdm_send(n, req);
+    default:
+        /* Unsupported Security Protocol Type */
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
+static uint16_t nvme_sec_prot_spdm_receive(NvmeCtrl *n, NvmeRequest *req)
+{
+    StorageSpdmTransportHeader hdr;
+    g_autofree uint8_t *rsp_spdm_buf = NULL;
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
+    uint32_t recvd, spdm_res;
+    uint16_t nvme_cmd_status, ret;
+    uint8_t secp = extract32(dw10, 24, 8);
+    uint8_t spsp = extract32(dw10, 8, 16);
+    if (!alloc_len) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* Generate the NVMe transport header */
+    hdr = (StorageSpdmTransportHeader) {
+        .security_protocol = secp,
+        .security_protocol_specific = cpu_to_le16(spsp),
+        .length = cpu_to_le32(alloc_len),
+    };
+
+    /* Forward if_recv to the SPDM Server with SPSP0 */
+    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_RECV,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                &hdr, sizeof(hdr));
+    if (!spdm_res) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    /* The responder shall ack with message status */
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                &nvme_cmd_status,
+                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
+    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    nvme_cmd_status = be16_to_cpu(nvme_cmd_status);
+    /* An error here implies the prior if_recv from requester was spurious */
+    if (nvme_cmd_status != NVME_SUCCESS) {
+        return nvme_cmd_status;
+    }
+
+    /* Clear to start receiving data from the server */
+    rsp_spdm_buf = g_try_malloc0(alloc_len);
+    if (!rsp_spdm_buf) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    recvd = spdm_socket_receive(n->spdm_socket,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                rsp_spdm_buf, alloc_len);
+    if (!recvd) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    ret = nvme_c2h(n, rsp_spdm_buf, MIN(recvd, alloc_len), req);
+    if (ret) {
+        return ret;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_get_sec_prot_info(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
+    uint8_t resp[10] = {
+        /* Support Security Protol List Length */
+        [6] = 0, /* MSB */
+        [7] = 2, /* LSB */
+        /* Support Security Protocol List */
+        [8] = SFSC_SECURITY_PROT_INFO,
+        [9] = 0,
+    };
+
+    if (n->spdm_socket >= 0) {
+        resp[9] = NVME_SEC_PROT_DMTF_SPDM;
+    }
+
+    if (alloc_len < 10) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return nvme_c2h(n, resp, sizeof(resp), req);
+}
+
+/* From controller to host */
+static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint16_t spsp = extract32(dw10, 8, 16);
+    uint8_t secp = extract32(dw10, 24, 8);
+
+    switch (secp) {
+    case SFSC_SECURITY_PROT_INFO:
+        switch (spsp) {
+        case 0:
+            /* Supported security protocol list */
+            return nvme_get_sec_prot_info(n, req);
+        case 1:
+            /* Certificate data */
+            /* fallthrough */
+        default:
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+    case NVME_SEC_PROT_DMTF_SPDM:
+        if (n->spdm_socket < 0) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        return nvme_sec_prot_spdm_receive(n, req);
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
 static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
 {
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -7389,6 +7592,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_directive_send(n, req);
     case NVME_ADM_CMD_DIRECTIVE_RECV:
         return nvme_directive_receive(n, req);
+    case NVME_ADM_CMD_SECURITY_SEND:
+        return nvme_security_send(n, req);
+    case NVME_ADM_CMD_SECURITY_RECV:
+        return nvme_security_receive(n, req);
     default:
         g_assert_not_reached();
     }
@@ -8459,6 +8666,8 @@ static void nvme_init_state(NvmeCtrl *n)
         sctrl->vfn = cpu_to_le16(i + 1);
     }
 
+    n->spdm_socket = -1;
+
     cap->cntlid = cpu_to_le16(n->cntlid);
     cap->crt = NVME_CRT_VQ | NVME_CRT_VI;
 
@@ -8820,7 +9029,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
 
-    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES;
+    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES |
+           NVME_OACS_SECURITY;
 
     if (n->params.dbcs) {
         oacs |= NVME_OACS_DBCS;
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index b5c9378ea4e5..67ed562e0086 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -461,6 +461,8 @@ static inline const char *nvme_adm_opc_str(uint8_t opc)
     case NVME_ADM_CMD_DIRECTIVE_RECV:   return "NVME_ADM_CMD_DIRECTIVE_RECV";
     case NVME_ADM_CMD_DBBUF_CONFIG:     return "NVME_ADM_CMD_DBBUF_CONFIG";
     case NVME_ADM_CMD_FORMAT_NVM:       return "NVME_ADM_CMD_FORMAT_NVM";
+    case NVME_ADM_CMD_SECURITY_SEND:    return "NVME_ADM_CMD_SECURITY_SEND";
+    case NVME_ADM_CMD_SECURITY_RECV:    return "NVME_ADM_CMD_SECURITY_RECV";
     default:                            return "NVME_ADM_CMD_UNKNOWN";
     }
 }
@@ -648,6 +650,9 @@ typedef struct NvmeCtrl {
     } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset */
     uint32_t    dn; /* Disable Normal */
     NvmeAtomic  atomic;
+
+    /* Socket mapping to SPDM over NVMe Security In/Out commands */
+    int spdm_socket;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 358e516e38b0..9fa2ecaf281c 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1779,6 +1779,21 @@ enum NvmeDirectiveOperations {
     NVME_DIRECTIVE_RETURN_PARAMS = 0x1,
 };
 
+typedef enum SfscSecurityProtocol {
+    SFSC_SECURITY_PROT_INFO = 0x00,
+} SfscSecurityProtocol;
+
+typedef enum NvmeSecurityProtocols {
+    NVME_SEC_PROT_DMTF_SPDM    = 0xE8,
+} NvmeSecurityProtocols;
+
+typedef enum SpdmOperationCodes {
+    SPDM_STORAGE_DISCOVERY      = 0x1, /* Mandatory */
+    SPDM_STORAGE_PENDING_INFO   = 0x2, /* Optional */
+    SPDM_STORAGE_MSG            = 0x5, /* Mandatory */
+    SPDM_STORAGE_SEC_MSG        = 0x6, /* Optional */
+} SpdmOperationCodes;
+
 typedef struct QEMU_PACKED NvmeFdpConfsHdr {
     uint16_t num_confs;
     uint8_t  version;
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 8c07dc12d283..e61163381251 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -114,7 +114,9 @@ typedef struct {
 
 #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
 #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
+#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
 
 #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
+#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
 
 #endif
-- 
2.51.0


