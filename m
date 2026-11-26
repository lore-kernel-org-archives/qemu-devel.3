Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A516606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=WS3x4s6v;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NsjxvL75
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUaa-0007AZ-IS; Thu, 26 Nov 2026 03:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xWUaY-0007AE-5t
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:12:18 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xWUaV-0007RB-Pj
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:12:17 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id AECFC7A0534
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 03:12:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 26 Nov 2026 03:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1795680733; x=
 1795767133; bh=IOb17MjVeaOskAaTIZgL66dvLFIwz4YyStIOAtZV164=; b=W
 S3x4s6vNwvC+MaDpueK3bq0U1cXtgLJEay7HSRdml6SxKbfBDeDEhNCtl9eBC4gZ
 4WJwCXhpFh0BgbT8r4+HKpUEOERJxQ/+XksOWRI9VtgINxYe4LRhBOX2qAv7F4FE
 tWsyneBGHr8AlZRMWgvgybJxsaWwk8g0pJNlPtUqWlxhdQXF/JhuAtO9NerGlT8S
 FVHTVJWZUuXDhNFjWMy7SEpyTSdFAC+72lP2J4k9jP5Px7BLGf41K6k1TZOtXFiw
 u2b3/vgwF7siN9d/Sno7qAZZn537roD28MtNnGdjihahsPJB4BnsBur4jsQO0hyQ
 Dq6O+QNRrr9CvdgatEzzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1795680733; x=1795767133; bh=IOb17MjVeaOskAaTIZgL66dvLFIw
 z4YyStIOAtZV164=; b=NsjxvL75Gc5/x1tjcNWe+K96se7nQO3eBbbVzYAMU5/p
 mN/0DFvxNf5A8aecp3pnRIomxj8Z2wATv5IR5+hmLCzaddrmWBwBXk26Q4vB0Nmk
 3a5yXEKjF1L1y/Buzbt5Slz5y6NGIknN8HDmrvhxBfuN04ZurbAd9aWkmDb+I1+X
 RMPd+YdRtToxL9HdWAe5mFVFUfrm+DKapyUHFrUuaRrUnpcjMsR7Hprn7tDHgMLZ
 6atuY+EDYBeEnKblZVa7S1Jhq542JmO4g6afybRjdc/8yZYz/DKeK7TkCEY9DHky
 mgaq+24b89F3IDa8DiX8CBqsOEl5BfQVHQHyIubdsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795680733; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:akG1AiSzZNdv6YYMMxn1DHxG6v3RYyWZ05Lk1rIV+q6WXop
 xX9Ov6ESGJFMp/H9mvAdAV6YHtdKFuYyGihOLx410ByofdJe53fc55j21pj1UhkN
 EqIvfwGAcOQt0NdaX1bxfpqbrltCZVYAiW0I3x/Og3sp5AIuvFU0lEWAlVXcWj2X
 1+NKiv88XxomLeTNXf7vYD6hopVRRhJL1qz66zwH7mA41gn1UY60IsK7v/tDtMeB
 DB1ORegRZQuTOcjR2j4wLonwzPsuQJ9nG/sRsbuNPcyAppwmXH67Ug8OXnsVAvfZ
 xYcljHfvZ250x2TTODA/MK3/WAZ9CgPFCh3WdaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:FwM4zh91sOQYk4Rxu2T0G5zmAk3zl2ZYadcC8Eyr2Qw=:T8ATiAu0WYV6bA007EzrdBoLr5Cf4w6IC9YEDRJSTo4=;
X-ME-Sender: <xms:2-kHaxWsfJoJg_BthkQolDuMAgPHopGZtCRcZrHyW41nbv-k-DfIyw>
 <xme:2-kHa6h8CKeluLhbwWUweVFtJi84zl5XwsXkiWg633Lf04fDSXPYrQo_K6DQQL4f4
 j5HoBvtff2BT5MjtwKj6Hq3_5n3t5x3KKytyDMz4waiif_uGvJjWOLK>
X-ME-Received: <xmr:2-kHa49Lta-h1rqtx7agPbP--xpZ67CilcZpiyMKk2YmEc3AU5r44BS0V4jPWOpvBfUpWPnXNR-SVOFDTHKalt_mCp3ZBOrbFxnGrU2abzXD8sORQq23XySLJg>
X-ME-Proxy-Cause: dmFkZTF8wADIwnIQNwgHW1ph2TC1SYzZCvRaKHnYzgRdDoVgV+jgEAcUFoTycof9sjTmLw
 WZ+iBGpn1aIuoXUps+0IZfRhHe9ddhBp+0ip0qsmlZk3HYFCeIRSA5NCDZz9jBp0hyns7Y
 9Gk3NLrGNClJU5peI3jj+Jz5ahBador36YcNGMOKdYLe2m7rHgakEAp0cx9hYCxJhQAz/U
 QfW+zRn9/cWDVwz5KStUtNXHDkDSw1UlfNkvSMbbHfG7KtOPZlJD4RWrZQBkepLW0ZBfjw
 p3PjkTAuKM1nM+yR0j0NnyhusJceYo9RBGlfoumpTti23U1xGfsD1FqBCuiSaNSiHgdSJL
 vPy3bepSz/a94k3mc7eDXpCK0IC5HdPLWUZv5KmyWdYBvXiVFl4/oKeFTnh7MRmCKd3P6O
 rGt23R0vNEeJ7J1jO+KJl7xtKvHjvKq3v7gexa7jPVt2oSxhYzkd9+e59tdkh+PjZ1fMtH
 TqUaedQLtxKhCSQv/tbGBq9R5aE7VZbLM8Y8StevLxP+JpJzceR2lo80qgiSHYt/NBiGeP
 gBt9nzIdT7hppta0UF+jIUK9OVtdfuMbbpFLZ+rOkfCqHrJwc+s4gBkjkGXgujOKAreuhH
 HK+mvKGj5Bcb6enamnrI1hHVTil6Ooe+iESTBbEVO/QHVCVq4N/KiPBSv9uA
X-ME-Proxy: <xmx:2-kHa0bnWFMuI5di09ZK8lQ-cMWibG2sgHGBeK0f09k3b3kOILmUdA>
 <xmx:2-kHa3237o3gPPnrtx5BQ-wz42jofkeBNXyLQ2mDpUj3ZMGk7vzmrA>
 <xmx:2-kHa_bdp1jQUiJTQYN27IiKwoHlPbPm7Vo4vdlJo8FrAweMYhSkJA>
 <xmx:2-kHa_JUIupvUPs9Uj5MhtCPIp72GSI4aRNfFCA8vlJPUM7LqqRH2g>
 <xmx:3ekHa7aD3N7GsSlAK8ssodFwnhZdyE3sqrNHM8C07KNwBZE73CufTQw0>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 03:12:10 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 26 Nov 2026 09:11:56 +0100
Subject: [PATCH] hw/nvme: fix interleaved transfers through host memory buffers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-fix-4520-v1-1-ce4dfd39d38f@samsung.com>
X-B4-Tracking: v=1; b=H4sIAMvpB2sC/yXMTQ5AMBAG0KvIrDXRyVTCVcSiajAWJS0iEXdXL
 F++nwsiB+EIdXZB4EOiLD5B5xm4yfqRlfTJgAWWWqNRg5yKDBaqQm2IS0vGEaT6Gjhl31XT/o5
 7N7Pb3j3c9wNgCBsIbAAAAA==
X-Change-ID: 20261125-fix-4520-92154e6a45c4
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2807; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=B0bjPTAKu3aFBPlA6gBphrfwZra/gcQR/8JrH+8A6JM=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3NINmRlcHNGSTI3OEJWYUx0N3M5WTdRU0t0CnpFdnEzWGRieUJqVklBbzBV
 ZVNxMVlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKckIrblh
 BQW9KRUUzaHJ6RnRUdzNwUnFrSUFLOXZVOWFza2ZrWFh5ZGNDeTBNQ2l6MzMxUVZPNWIxTEhZUw
 p1VGJVRjhNSXBrd1ArT0ErRSthVkxISGx6Wndsd1A4RXR0dm5lNVIya1dPUjJyMHFLUngwa1Nta
 TYyQnlwbk0rCjRZVjc0bTBUb1VUenBvTEtXUzlGQmNYUTRLclRuVTdkejRVeDF1SzVZK3VpQ29R
 YklmYzlYMytseDhIeGF3RkkKQVZmZmUxN1N0WlZIUjhPdEhyV3kwTEMyWHZKY2kzZWt5Mmt6QVd
 2UDNJeGxRdDBqTUFud3gxQ1VVaUxvc0pRbQpIaC9PY2NyVUQvcWN3ckJUZUE2NEdPbDFnTkZHRG
 1KWnJ4eitlMk5GM3pIcjNCQlVZSDVkU2ZmNTB5Z1laV3JxCmdINU9iaU1acHVGTW1FZm1vckZpY
 3ZrVlk3UXBoYXo5TGdPRUZlaG9MR0VkRnovNHZLN0ozNnJECj1rWkZ3Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-b6-smtp.messagingengine.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_tx_interleaved is used in the bounce path for interleaved metadata
(extended LBAs). It does not consider that the scatter list may cover
host memory instead of guest addresses (for example, CMB mappings). On
such non-dma transactions the host pointer is fed to nvme_addr_rw, which
treats it as a guest address. For a controller with a CMB, I/O on an
extended-LBA namespace with protection information fails with a Data
Transfer Error or, worse, ends up corrupting guest memory.

Move the data directly for the host memory case as intended.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: bc3a65e99254 ("hw/block/nvme: add metadata support")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5755aad1fa72..a698b553bab9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1315,7 +1315,6 @@ static uint16_t nvme_tx_interleaved(NvmeCtrl *n, NvmeSg *sg, uint8_t *ptr,
                                     int32_t skip_bytes, int64_t offset,
                                     NvmeTxDirection dir)
 {
-    hwaddr addr;
     uint32_t trans_len, count = bytes;
     bool dma = sg->flags & NVME_SG_DMA;
     int64_t sge_len;
@@ -1343,19 +1342,25 @@ static uint16_t nvme_tx_interleaved(NvmeCtrl *n, NvmeSg *sg, uint8_t *ptr,
         trans_len = MIN(trans_len, sge_len - offset);
 
         if (dma) {
-            addr = sg->qsg.sg[sg_idx].base + offset;
-        } else {
-            addr = (hwaddr)(uintptr_t)sg->iov.iov[sg_idx].iov_base + offset;
-        }
+            hwaddr addr = sg->qsg.sg[sg_idx].base + offset;
 
-        if (dir == NVME_TX_DIRECTION_TO_DEVICE) {
-            ret = nvme_addr_read(n, addr, ptr, trans_len);
+            if (dir == NVME_TX_DIRECTION_TO_DEVICE) {
+                ret = nvme_addr_read(n, addr, ptr, trans_len);
+            } else {
+                ret = nvme_addr_write(n, addr, ptr, trans_len);
+            }
+
+            if (ret) {
+                return NVME_DATA_TRAS_ERROR;
+            }
         } else {
-            ret = nvme_addr_write(n, addr, ptr, trans_len);
-        }
+            uint8_t *seg = (uint8_t *)sg->iov.iov[sg_idx].iov_base + offset;
 
-        if (ret) {
-            return NVME_DATA_TRAS_ERROR;
+            if (dir == NVME_TX_DIRECTION_TO_DEVICE) {
+                memcpy(ptr, seg, trans_len);
+            } else {
+                memcpy(seg, ptr, trans_len);
+            }
         }
 
         ptr += trans_len;

---
base-commit: 9751c62358073580cbf330a4df22077a7c6a407c
change-id: 20261125-fix-4520-92154e6a45c4

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


