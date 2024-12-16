Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8AFE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAcD-0006e0-67; Mon, 16 Dec 2024 07:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbu-0006bO-H1; Mon, 16 Dec 2024 07:54:06 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbr-0004rb-Bp; Mon, 16 Dec 2024 07:54:06 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2CE77254016E;
 Mon, 16 Dec 2024 07:54:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 16 Dec 2024 07:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353642; x=1734440042; bh=ZHtfnLASmiYdJIRuZCbPNkbdoTgJuXJs
 /ORYsFEuEyM=; b=ExZnlqvzvfD2oxlwz5+LJAexpfmGtMnyxWgqgzNxfFcBLgS0
 d4CvLchYi4jcNCkHzJtdp0UDJe+P8GyY+RpnOw96HOhdBit+1FVBKyepWk1A77Lw
 yRK/RWUXjCHD4JK50dlBv3oyjKAqlaqUQF7CGGfxUtyR4Mgskjw6LPFMxkOBY5Oe
 Rh2qRRFLmF64ecJYU5OzkC8YdfiAYgmPVh8lNNEECKgbOs42aB24xHs+Ybw5x68N
 IrXH5L11Vm2CbNNCWbsqALCgMlbMNrVWGVZhKMjsB+W2bvjxgO9UVcZOg1V8Tpfh
 ZzwbYcTiShRQbWJPCMXxWrK3H05oOJBgBLKeqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353642; x=
 1734440042; bh=ZHtfnLASmiYdJIRuZCbPNkbdoTgJuXJs/ORYsFEuEyM=; b=x
 YNAV/stibF/477pDn8/bMbv0RQTvTZrXRXPAZUMjPjykaUCaQmePO86gqQblCS00
 vzxImvSbZUprE3QyCirAoSFVBdSgYysUKmi27Cy84WdqfJESqjzoB878NANeHbTi
 4M7skcocr2IT1cWQHLYHVbQSmXUoNEMOXA543USsyRvQHJ1r8IE8adbV24ibSGU+
 KgFcRbg1KD8R4jwc9RHj10X4i/yy4OqXJWVFMZSz/xWNginRA0Dmuz8pSNT5u0CB
 P/MJFTyVleBnyJrgf8eDaDGv86rmdj0t8rufV7Q49iIe/uvTxfgB+ZJ1FTnurJdo
 aZlU6XOHfY/36yllQWDRg==
X-ME-Sender: <xms:6SJgZ-LKXhh7__3lsWZSQSnAUJfgszzu4FUKpJOEouoYOsYHsuN0ig>
 <xme:6SJgZ2KK8dbCQhcuWbn7CT9zDd-Mk8ISJVHiv9Py3zNvxJmgM16e_Jxtvf4qTxN7Z
 MvEE2TjEWWKnTWKI-w>
X-ME-Received: <xmr:6SJgZ-tP5AzsztmT8zRfEzaBpNloSeU6CoyBwYdvR_-b1ACV4burpWFGkB-sVKf0fNdzualXTOTt5--Zm9h1Fr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdegiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:6SJgZzaVili771-l93-8Xgy9EFLyWG8hECMpKdLYIIeR_vQOpqDWsQ>
 <xmx:6SJgZ1bQG9MY8M8dw1I7FZuyWyeVbB7etvO0CiRcaGkBe0_e44Js5g>
 <xmx:6SJgZ_CUMwQ90NpqbA3Kzp-QihYqAYXqsij132qV4sDPOsLulameCw>
 <xmx:6SJgZ7abowHonaDIgaPu9f9BKmHR5OeqL3tXQhduJxZmMEt92hQg1w>
 <xmx:6iJgZ6OsfEeaOV1O22PRlgf1V4YJU6ul606aSsYQ4g8LjHEENoh8o3CC>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:54:00 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:07 +0100
Subject: [PATCH 6/9] hw/nvme: rework csi handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-6-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16728; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=kV5qmUe71f7pUk/qBMS3ROdqAD10Vs40tBcwf1Qf++I=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXRwKy9CUnhsUmEzdVVSWWpGZWgwRVZrCnM4U0wvUmUwejN6WTRhdnp2
 UUZmL0lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTGF
 BQW9KRUUzaHJ6RnRUdzNwUkhrSUFKQ1ZLVjErenRydVpzTmdaU2JiVUI3VFh2elhwbnpLT1Yzcw
 pHQVU3SEpkN0NWbWN3V3lxc0hiNlVtanp3RkwxK3NJZ2IvYityRkhyRXFySWROVG5lZmpFcC9FU
 GNXZDUvNi91CkdKNHpiUGd3d3hhaW9qZS9tbjhIbVFvTXhwd0UyMHBrQndCM3krVlp0SUZhN2s0
 UHZLRUZ6Rkg0WFd2OUtENGsKekRMUUZiN0tIMkpNSHcxRHpEbkZoZURTdWNCbW9EYUxOeElPZjN
 BcHJsRnUwNTFlZVMvV3JvVFFyWkE5S3VpQwpPUlRYaXEvRlIyVGdSOU5SL2h4ZzIxN1Fsam5nUF
 lJWkswd0FKK2czTk1XS2U2dm9kWll6eFp5U1hWdXA5TVBQCmdGKzVLTWdzWEVYTkRnUTBRU2NwT
 Uh3WE1GQjlPdzJSZWhud0VuUEhDMFhCZlhjQ3IzOHo4NmlqCj11dUw5Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
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

From: Klaus Jensen <k.jensen@samsung.com>

The controller incorrectly allows a zoned namespace to be attached even
if CS.CSS is configured to only support the NVM command set for I/O
queues.

Rework handling of namespace command sets in general by attaching
supported namespaces when the controller is started instead of, like
now, statically when realized.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 242 ++++++++++++++++++++++++++++-----------------------
 hw/nvme/ns.c         |  14 ---
 hw/nvme/nvme.h       |   5 +-
 include/block/nvme.h |  10 ++-
 4 files changed, 142 insertions(+), 129 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 22a8c400bae332285d015e8b590de159fd7d1b7a..8d3f62c40ac14fdc4bdc650e272023558cbbae0f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -277,36 +277,32 @@ static const uint32_t nvme_cse_acs_default[256] = {
     [NVME_ADM_CMD_SET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
-    [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
+    [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC |
+                                      NVME_CMD_EFF_CCC,
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
 };
 
-static const uint32_t nvme_cse_iocs_none[256];
-
-static const uint32_t nvme_cse_iocs_nvm[256] = {
-    [NVME_CMD_FLUSH]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_WRITE_ZEROES]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_WRITE]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_READ]                 = NVME_CMD_EFF_CSUPP,
-    [NVME_CMD_DSM]                  = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_VERIFY]               = NVME_CMD_EFF_CSUPP,
-    [NVME_CMD_COPY]                 = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_COMPARE]              = NVME_CMD_EFF_CSUPP,
-    [NVME_CMD_IO_MGMT_RECV]         = NVME_CMD_EFF_CSUPP,
-    [NVME_CMD_IO_MGMT_SEND]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+#define NVME_CSE_IOCS_NVM_DEFAULT \
+    [NVME_CMD_FLUSH]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC, \
+    [NVME_CMD_WRITE_ZEROES]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC, \
+    [NVME_CMD_WRITE]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC, \
+    [NVME_CMD_READ]                 = NVME_CMD_EFF_CSUPP,                     \
+    [NVME_CMD_DSM]                  = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC, \
+    [NVME_CMD_VERIFY]               = NVME_CMD_EFF_CSUPP,                     \
+    [NVME_CMD_COPY]                 = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC, \
+    [NVME_CMD_COMPARE]              = NVME_CMD_EFF_CSUPP,                     \
+    [NVME_CMD_IO_MGMT_RECV]         = NVME_CMD_EFF_CSUPP,                     \
+    [NVME_CMD_IO_MGMT_SEND]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC
+
+static const uint32_t nvme_cse_iocs_nvm_default[256] = {
+    NVME_CSE_IOCS_NVM_DEFAULT,
 };
 
-static const uint32_t nvme_cse_iocs_zoned[256] = {
-    [NVME_CMD_FLUSH]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_WRITE_ZEROES]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_WRITE]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_READ]                 = NVME_CMD_EFF_CSUPP,
-    [NVME_CMD_DSM]                  = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_VERIFY]               = NVME_CMD_EFF_CSUPP,
-    [NVME_CMD_COPY]                 = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
-    [NVME_CMD_COMPARE]              = NVME_CMD_EFF_CSUPP,
+static const uint32_t nvme_cse_iocs_zoned_default[256] = {
+    NVME_CSE_IOCS_NVM_DEFAULT,
+
     [NVME_CMD_ZONE_APPEND]          = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_ZONE_MGMT_SEND]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_ZONE_MGMT_RECV]       = NVME_CMD_EFF_CSUPP,
@@ -4603,6 +4599,61 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     };
 }
 
+static uint16_t __nvme_io_cmd_nvm(NvmeCtrl *n, NvmeRequest *req)
+{
+    switch (req->cmd.opcode) {
+    case NVME_CMD_WRITE:
+        return nvme_write(n, req);
+    case NVME_CMD_READ:
+        return nvme_read(n, req);
+    case NVME_CMD_COMPARE:
+        return nvme_compare(n, req);
+    case NVME_CMD_WRITE_ZEROES:
+        return nvme_write_zeroes(n, req);
+    case NVME_CMD_DSM:
+        return nvme_dsm(n, req);
+    case NVME_CMD_VERIFY:
+        return nvme_verify(n, req);
+    case NVME_CMD_COPY:
+        return nvme_copy(n, req);
+    case NVME_CMD_IO_MGMT_RECV:
+        return nvme_io_mgmt_recv(n, req);
+    case NVME_CMD_IO_MGMT_SEND:
+        return nvme_io_mgmt_send(n, req);
+    }
+
+    g_assert_not_reached();
+}
+
+static uint16_t nvme_io_cmd_nvm(NvmeCtrl *n, NvmeRequest *req)
+{
+    if (!(n->cse.iocs.nvm[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
+        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    return __nvme_io_cmd_nvm(n, req);
+}
+
+static uint16_t nvme_io_cmd_zoned(NvmeCtrl *n, NvmeRequest *req)
+{
+    if (!(n->cse.iocs.zoned[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
+        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    switch (req->cmd.opcode) {
+    case NVME_CMD_ZONE_APPEND:
+        return nvme_zone_append(n, req);
+    case NVME_CMD_ZONE_MGMT_SEND:
+        return nvme_zone_mgmt_send(n, req);
+    case NVME_CMD_ZONE_MGMT_RECV:
+        return nvme_zone_mgmt_recv(n, req);
+    }
+
+    return __nvme_io_cmd_nvm(n, req);
+}
+
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -4644,11 +4695,6 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (!(ns->iocs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
-        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
-        return NVME_INVALID_OPCODE | NVME_DNR;
-    }
-
     if (ns->status) {
         return ns->status;
     }
@@ -4659,36 +4705,14 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 
     req->ns = ns;
 
-    switch (req->cmd.opcode) {
-    case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, req);
-    case NVME_CMD_ZONE_APPEND:
-        return nvme_zone_append(n, req);
-    case NVME_CMD_WRITE:
-        return nvme_write(n, req);
-    case NVME_CMD_READ:
-        return nvme_read(n, req);
-    case NVME_CMD_COMPARE:
-        return nvme_compare(n, req);
-    case NVME_CMD_DSM:
-        return nvme_dsm(n, req);
-    case NVME_CMD_VERIFY:
-        return nvme_verify(n, req);
-    case NVME_CMD_COPY:
-        return nvme_copy(n, req);
-    case NVME_CMD_ZONE_MGMT_SEND:
-        return nvme_zone_mgmt_send(n, req);
-    case NVME_CMD_ZONE_MGMT_RECV:
-        return nvme_zone_mgmt_recv(n, req);
-    case NVME_CMD_IO_MGMT_RECV:
-        return nvme_io_mgmt_recv(n, req);
-    case NVME_CMD_IO_MGMT_SEND:
-        return nvme_io_mgmt_send(n, req);
-    default:
-        g_assert_not_reached();
+    switch (ns->csi) {
+    case NVME_CSI_NVM:
+        return nvme_io_cmd_nvm(n, req);
+    case NVME_CSI_ZONED:
+        return nvme_io_cmd_zoned(n, req);
     }
 
-    return NVME_INVALID_OPCODE | NVME_DNR;
+    g_assert_not_reached();
 }
 
 static void nvme_cq_notifier(EventNotifier *e)
@@ -5108,7 +5132,7 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
                                  uint64_t off, NvmeRequest *req)
 {
     NvmeEffectsLog log = {};
-    const uint32_t *src_iocs = NULL;
+    const uint32_t *iocs = NULL;
     uint32_t trans_len;
 
     if (off >= sizeof(log)) {
@@ -5118,25 +5142,26 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
 
     switch (NVME_CC_CSS(ldl_le_p(&n->bar.cc))) {
     case NVME_CC_CSS_NVM:
-        src_iocs = nvme_cse_iocs_nvm;
-        /* fall through */
-    case NVME_CC_CSS_ADMIN_ONLY:
+        iocs = n->cse.iocs.nvm;
         break;
-    case NVME_CC_CSS_CSI:
+
+    case NVME_CC_CSS_ALL:
         switch (csi) {
         case NVME_CSI_NVM:
-            src_iocs = nvme_cse_iocs_nvm;
+            iocs = n->cse.iocs.nvm;
             break;
         case NVME_CSI_ZONED:
-            src_iocs = nvme_cse_iocs_zoned;
+            iocs = n->cse.iocs.zoned;
             break;
         }
+
+        break;
     }
 
     memcpy(log.acs, n->cse.acs, sizeof(log.acs));
 
-    if (src_iocs) {
-        memcpy(log.iocs, src_iocs, sizeof(log.iocs));
+    if (iocs) {
+        memcpy(log.iocs, iocs, sizeof(log.iocs));
     }
 
     trans_len = MIN(sizeof(log) - off, buf_len);
@@ -6660,25 +6685,29 @@ static void nvme_update_dsm_limits(NvmeCtrl *n, NvmeNamespace *ns)
     }
 }
 
-static void nvme_select_iocs_ns(NvmeCtrl *n, NvmeNamespace *ns)
+static bool nvme_csi_supported(NvmeCtrl *n, uint8_t csi)
 {
-    uint32_t cc = ldl_le_p(&n->bar.cc);
+    uint32_t cc;
 
-    ns->iocs = nvme_cse_iocs_none;
-    switch (ns->csi) {
+    switch (csi) {
     case NVME_CSI_NVM:
-        if (NVME_CC_CSS(cc) != NVME_CC_CSS_ADMIN_ONLY) {
-            ns->iocs = nvme_cse_iocs_nvm;
-        }
-        break;
+        return true;
+
     case NVME_CSI_ZONED:
-        if (NVME_CC_CSS(cc) == NVME_CC_CSS_CSI) {
-            ns->iocs = nvme_cse_iocs_zoned;
-        } else if (NVME_CC_CSS(cc) == NVME_CC_CSS_NVM) {
-            ns->iocs = nvme_cse_iocs_nvm;
-        }
-        break;
+        cc = ldl_le_p(&n->bar.cc);
+
+        return NVME_CC_CSS(cc) == NVME_CC_CSS_ALL;
     }
+
+    g_assert_not_reached();
+}
+
+static void nvme_detach_ns(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    assert(ns->attached > 0);
+
+    n->namespaces[ns->params.nsid] = NULL;
+    ns->attached--;
 }
 
 static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
@@ -6723,7 +6752,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
 
         switch (sel) {
         case NVME_NS_ATTACHMENT_ATTACH:
-            if (nvme_ns(ctrl, nsid)) {
+            if (nvme_ns(n, nsid)) {
                 return NVME_NS_ALREADY_ATTACHED | NVME_DNR;
             }
 
@@ -6731,19 +6760,17 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
                 return NVME_NS_PRIVATE | NVME_DNR;
             }
 
+            if (!nvme_csi_supported(n, ns->csi)) {
+                return NVME_IOCS_NOT_SUPPORTED | NVME_DNR;
+            }
+
             nvme_attach_ns(ctrl, ns);
-            nvme_select_iocs_ns(ctrl, ns);
+            nvme_update_dsm_limits(ctrl, ns);
 
             break;
 
         case NVME_NS_ATTACHMENT_DETACH:
-            if (!nvme_ns(ctrl, nsid)) {
-                return NVME_NS_NOT_ATTACHED | NVME_DNR;
-            }
-
-            ctrl->namespaces[nsid] = NULL;
-            ns->attached--;
-
+            nvme_detach_ns(ctrl, ns);
             nvme_update_dsm_limits(ctrl, NULL);
 
             break;
@@ -7594,21 +7621,6 @@ static void nvme_ctrl_shutdown(NvmeCtrl *n)
     }
 }
 
-static void nvme_select_iocs(NvmeCtrl *n)
-{
-    NvmeNamespace *ns;
-    int i;
-
-    for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-        ns = nvme_ns(n, i);
-        if (!ns) {
-            continue;
-        }
-
-        nvme_select_iocs_ns(n, ns);
-    }
-}
-
 static int nvme_start_ctrl(NvmeCtrl *n)
 {
     uint64_t cap = ldq_le_p(&n->bar.cap);
@@ -7675,7 +7687,18 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 
     nvme_set_timestamp(n, 0ULL);
 
-    nvme_select_iocs(n);
+    /* verify that the command sets of attached namespaces are supported */
+    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+
+        if (ns && nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
+            if (!ns->attached || ns->params.shared) {
+                nvme_attach_ns(n, ns);
+            }
+        }
+    }
+
+    nvme_update_dsm_limits(n, NULL);
 
     return 0;
 }
@@ -8684,6 +8707,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint16_t oacs;
 
     memcpy(n->cse.acs, nvme_cse_acs_default, sizeof(n->cse.acs));
+    memcpy(n->cse.iocs.nvm, nvme_cse_iocs_nvm_default, sizeof(n->cse.iocs.nvm));
+    memcpy(n->cse.iocs.zoned, nvme_cse_iocs_zoned_default, sizeof(n->cse.iocs.zoned));
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
@@ -8795,9 +8820,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_MQES(cap, n->params.mqes);
     NVME_CAP_SET_CQR(cap, 1);
     NVME_CAP_SET_TO(cap, 0xf);
-    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_NVM);
-    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_CSI_SUPP);
-    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_ADMIN_ONLY);
+    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_NCSS);
+    NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_IOCSS);
     NVME_CAP_SET_MPSMAX(cap, 4);
     NVME_CAP_SET_CMBS(cap, n->params.cmb_size_mb ? 1 : 0);
     NVME_CAP_SET_PMRS(cap, n->pmr.dev ? 1 : 0);
@@ -8844,8 +8868,6 @@ void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns)
 
     n->namespaces[nsid] = ns;
     ns->attached++;
-
-    nvme_update_dsm_limits(n, ns);
 }
 
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
@@ -8901,7 +8923,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
             return;
         }
 
-        nvme_attach_ns(n, ns);
+        n->subsys->namespaces[ns->params.nsid] = ns;
     }
 }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 3be43503c50798db0ab528fe30ad901bb6aa9db3..2ac8544f1f6561076813c500af4210f8a99d6cb8 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -763,20 +763,6 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
     ns->id_ns.endgid = cpu_to_le16(0x1);
     ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
-
-    if (ns->params.detached) {
-        return;
-    }
-
-    if (ns->params.shared) {
-        for (i = 0; i < ARRAY_SIZE(subsys->ctrls); i++) {
-            NvmeCtrl *ctrl = subsys->ctrls[i];
-
-            if (ctrl && ctrl != SUBSYS_SLOT_RSVD) {
-                nvme_attach_ns(ctrl, ns);
-            }
-        }
-    }
 }
 
 static Property nvme_ns_props[] = {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index cb314e91af32a20f47e0a393e2458b7d4bdd03d9..f1b048c30dc90d8c3c18267d19d52e454a95fde9 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -237,7 +237,6 @@ typedef struct NvmeNamespace {
     NvmeLBAF     lbaf;
     unsigned int nlbaf;
     size_t       lbasz;
-    const uint32_t *iocs;
     uint8_t      csi;
     uint16_t     status;
     int          attached;
@@ -586,6 +585,10 @@ typedef struct NvmeCtrl {
 
     struct {
         uint32_t acs[256];
+        struct {
+            uint32_t nvm[256];
+            uint32_t zoned[256];
+        } iocs;
     } cse;
 
     struct {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index f3f0317524d129f518698c6797ed37a7ac0ac847..66d49b641aa1e89c12103e548320d89995fbbfae 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -142,9 +142,9 @@ enum NvmeCapMask {
     ((cap) |= (uint64_t)((val) & CAP_CMBS_MASK)   << CAP_CMBS_SHIFT)
 
 enum NvmeCapCss {
-    NVME_CAP_CSS_NVM        = 1 << 0,
-    NVME_CAP_CSS_CSI_SUPP   = 1 << 6,
-    NVME_CAP_CSS_ADMIN_ONLY = 1 << 7,
+    NVME_CAP_CSS_NCSS    = 1 << 0,
+    NVME_CAP_CSS_IOCSS   = 1 << 6,
+    NVME_CAP_CSS_NOIOCSS = 1 << 7,
 };
 
 enum NvmeCcShift {
@@ -177,7 +177,7 @@ enum NvmeCcMask {
 
 enum NvmeCcCss {
     NVME_CC_CSS_NVM        = 0x0,
-    NVME_CC_CSS_CSI        = 0x6,
+    NVME_CC_CSS_ALL        = 0x6,
     NVME_CC_CSS_ADMIN_ONLY = 0x7,
 };
 
@@ -938,6 +938,8 @@ enum NvmeStatusCodes {
     NVME_INVALID_SEC_CTRL_STATE = 0x0120,
     NVME_INVALID_NUM_RESOURCES  = 0x0121,
     NVME_INVALID_RESOURCE_ID    = 0x0122,
+    NVME_IOCS_NOT_SUPPORTED     = 0x0129,
+    NVME_IOCS_NOT_ENABLED       = 0x012a,
     NVME_IOCS_COMBINATION_REJECTED = 0x012b,
     NVME_INVALID_IOCS           = 0x012c,
     NVME_CONFLICTING_ATTRS      = 0x0180,

-- 
2.45.2


