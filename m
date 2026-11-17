Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789A606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=V3mwOKV1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sonjQQMs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTHTN-0003VM-4F; Tue, 17 Nov 2026 06:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTHTK-0003Ui-BV
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:35:34 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTHTG-0007Qx-Py
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:35:34 -0500
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 6F63B1D0023C
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 06:35:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 17 Nov 2026 06:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1794915327; x=
 1795001727; bh=UKp0fi02vQkrP4lZQIhQbFfmMjdHCev5rm3AQRl9n4c=; b=V
 3mwOKV1Hq2wkIf7CJrBdnmf6PKP9lNZpH70qI2PNAJOjkl6HuTAUbbvkXlHjq+/S
 4nDY9RV3IzrWRQOOXBzTWFzWF60ynvnT2qJ5IVEtIqjhkOi+8enZvsnJ6BkN27UK
 liPkmJyM82nAfxaU2VLpchSXd8DHKMZ/9qy7OSBi4/GFb1NeJeGGJ3gq9eUbxNQB
 TRHFapvxCFIC0NwYzunAOG/SN/QINQdxK/v4Zq/PN9V6gxBALDy16+Gv7Mva0eDu
 i8DbgSChybdkKLGBULF/Qqevle+Sgob5oWbp4gezocpWn5LXKyoR14lMg4AyiUQD
 ywazsGaAufbiJ9HegDGfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1794915327; x=1795001727; bh=UKp0fi02vQkrP4lZQIhQbFfmMjdH
 Cev5rm3AQRl9n4c=; b=sonjQQMsIdtf3iPNWMrIYL9WUSROposE0ar/VV01UIEU
 2G/OqmUOVT8jGzdHB629DQppP5bkH1pKuguhh0E16uiIYm0fONqy+aM3p771/ZzO
 x1ASVeArW3kYaxswRzNWSUAoBb5ow2EcDDhF5xgLLSu2JhOnYN91ez8zBvqTR9Ky
 5gmq8hRhPrjqUpBxBd5c0uBz7JOaEdonh9UCq239CWLhH3RzD3fQCVNPVyt9eI+J
 wx1EHUwzJR7Sw2W4WL5sPqVHNJgHnDkkbkxUz2FFufubymUurRKJNmDO/jAnPd1V
 aFdCoO1u3jsXv1Ufm1d7JikPDloJtuOEgMvz8olSrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794915327; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:BNMcEeKpqR9KPpqdX50q0LzCrue1HOSKJnLkb0VDHoVDGsm
 VsMxjdct/pJ4mN+YDmX1Krz5R1qNHVzOsnYBF9mf04GZzTTCSn5Sbiqok3pu2HR9
 8Hv1qi2aUgyXTsU4GWBtnGmxVCwMlCZAR1r6SN/EtC8UZXYBZ0wDANr693+HTjLP
 BWoA5nVDH3TVYLFC9P42SjWaGkImmmH+vfJNXeCEiBmDN78eAHzEqnPTmM/l8KAz
 O2/rRKEA5q5O9dGCyqJrA2gUE+HYGKs+LCT1inqg73+cRJb4Rf7BZ7Aekr3ftpwm
 a3c3Q/fIrTCnx8/vkvnh08qmkfHjqQlkCy1H80g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:sxiKbn70DDVdAoCIH0IR3c851G2Sy0iGF48mICV9l5w=:HIWvYczCfO3yHB5OkZT6Cfytlm+c78Po/M+4ai0mroA=;
X-ME-Sender: <xms:_jv8akMjVpnsByN9rtaaG_7zMAggw1Fk7abkKD6eRiw7dwE_M3JDvQ>
 <xme:_jv8al5UT9gV4ZoKq6QaYJIZdWD3r6B2RSnYV_lpr6tP5gPz2n7c8XHKBkw2MwcUm
 ZE9T93XiOD_QrCeLGvozhDaVvg32a0ZtotdBSyTQH_Z-6Uhc9SsVQCT>
X-ME-Received: <xmr:_jv8aqTWQ7jP1THr5L9kvfzn5ESmOh81Cg5bdRfV-ttzTtT0SYF9ur8yu5pcPHB-ljQLkFHDrrRH1_IfNfsiBuP0pbPXqSMGVyNY1jKp6R5CDd-rnSfYlPzAaw>
X-ME-Proxy-Cause: dmFkZTEdhPe7PBsbJKXz9v6F1ROD4NkaTZJL4CCHaJwyiqywEGOjYVKny2wFpT5VRP37DF
 RA4uI9homwoeqTyvfB4NlMg0GeApOrw2qoCAhfbQyOomVJYX+S7C32W8aEuQfNEqVPC6HM
 pYgyhYVellccUAuYqFbTcVDY4dcbFpOtHksgZXJ2/14fv5aqwC7M3CqXN8JJJWPUxPXzlC
 kRBzXYHZyzPp8mhUDi4NYbrbvyJswtTAkky0f0elZ1akHibbDW4VzqGtITfjrm6ZkpQT2P
 eZjzvxU6tOgvxSPYdH/nT56A5OPebAteR0UeGQT68nb0mA2oPuKcqLtY/AfHGZb86mOYqg
 mup2w2V3DSjYhcrMwqdLn33gRlfksgu7XI2gI/X6LV33CRocviSJuhuvg3bt8VrksrxizZ
 kQKtukpIoRy8uEDLMf3Q92JaHgzf6I0ui+jlrQonpH3bYFhoev4giBKg3ssMJsXfCsE6/3
 9QMZSCSz13yPSI5ryNniwSGKfqTlhXxuAzFVHqP0KzPcwaXt+UmE5l6fPqYbc1wm0jJGFw
 B9bSAIR0u4Us5cSWD+zWcY3hX0VB4VOXvilcxS07cZhNvItB5NcTp4O5kSzJZ1oQZjUTp4
 DJt+nRjk1REypHbszNXMDu5+Q+XB+wW5K/wPUdWnX7c02uQZBZfZU44vMGAg
X-ME-Proxy: <xmx:_jv8aiDAt31hUqBUySuE3D300lBPjqGtvM9iTnay8DQse7NJPse9wg>
 <xmx:_zv8aqFpnWZTEXpWsB0EVZzS9E6nwod3idiQKOOl9mjelDH21J4_JA>
 <xmx:_zv8asANCKvhBQ62lxwxmXgxnVGJC3FYxo9XXGhOnJZ-x-sOzDUCOg>
 <xmx:_zv8aiUvfYM1Vp8-Pe4ar7--b07Gdahl3NXGyOQoPIJfOCskD8IVQQ>
 <xmx:_zv8aqZOAHr9sLr0obVzXOmSbVAYDs1_RExS5nsRsDmPdRox3I_tztU_>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 06:35:25 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 17 Nov 2026 12:35:21 +0100
Subject: [PATCH] hw/nvme: report data transfer error on failed dma
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-fix-4700-v1-1-eaf8920b66cb@samsung.com>
X-B4-Tracking: v=1; b=H4sIAPg7/GoC/yXMSw5AMBAG4KvIrE3SeoariEXVYCyQFpE07m6w/
 PI/AnhyTB7qKICjkz2vi0DHEdjJLCMh92JIVFJorUsc+MKsVApFNq/61BRqAKlvjiT7rpr2tz+
 6mez+7uG+H0QORlZsAAAA
X-Change-ID: 20261117-fix-4700-111c59d3a60f
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=WPcGabfNyQNGLzBua2/oXW9rhTA/Ha/41hp/La3BGds=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3I4Ty8xMmdpWG5IK3pVTkZoTzd6TVZIWmlaCmdrY1d5ekFCb1dnb295UHlS
 UzZUeUlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcS9Edjl
 BQW9KRUUzaHJ6RnRUdzNwMlBJSUFJbEtuOGtCRFMzNWp3d3NwR1A1R2tyT01DV0syVGFWWkJNQg
 ovM3drb0wvZmVZbnNxN2Y2QmFNc3JNRnZNWkxna3Raa2w3dkdkYmZleUY3MDVsVDN5d2tCS21ic
 VdWZGF6WWU0CmtPcXpKaUFsUDNJRk5OTzYrZ2NRbFdSN0g1d2NoODZNQ1ZsVGhSajN1V1NFQVcv
 eUpqNzMzQkRxa3BPT0tUMjMKenJtMFoydERaeXZZTTQ3Q1YvbDU5c3lYcEdCN0NmSk1PNU1nVnB
 zR2g5bW8zT0RmZmFOcjBmaFZCTk9MSjJEcQpoM082QUlLZFJoV2U3eGducmZjQXN6WU1Gbmc0R3
 ZoUUVJcUVVNUQzc3dmVTk1M0duUDNGSUxDQ1F6Qzk5Q2ZMCmo1V1RIMnVPQjkvZnJ3NWxHNDEyV
 HlYdVNRKzhCK2hqR2ZkTm9NZHVUZXRvZkczdDdWSGIrNm9QCj01c3dDCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

nvme_tx discards the MemTxResult returned by dma_buf_read/write and only
inspects the residual. dma_buf_rw already accounts failed transactions
against the residual, so a full-length transfer to or from unmapped
memory results in a zero residual and an apparently successful transfer.

Check the memory transaction result instead and complete the command
with a Data Transfer Error on error and add a new trace event that
actually describe the event correctly.

Cc: qemu-stable@nongnu.org
Fixes: f02b664aad8f ("hw/dma: Let dma_buf_read() / dma_buf_write() propagate MemTxResult")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4700
Reported-by: Karl Mehltretter
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
The residual check is effectively dead code. Both nvme_map_prp and
nvme_map_sgl map exactly the requested length, so the residual is always
zero. Keep the check there instead of asserting it, keeping the fix
minimal.
---
 hw/nvme/ctrl.c       | 10 ++++++++--
 hw/nvme/trace-events |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 71c24dc02b67..5e8788a257da 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1380,11 +1380,17 @@ static uint16_t nvme_tx(NvmeCtrl *n, NvmeSg *sg, void *ptr, uint32_t len,
     if (sg->flags & NVME_SG_DMA) {
         const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
         dma_addr_t residual;
+        MemTxResult res;
 
         if (dir == NVME_TX_DIRECTION_TO_DEVICE) {
-            dma_buf_write(ptr, len, &residual, &sg->qsg, attrs);
+            res = dma_buf_write(ptr, len, &residual, &sg->qsg, attrs);
         } else {
-            dma_buf_read(ptr, len, &residual, &sg->qsg, attrs);
+            res = dma_buf_read(ptr, len, &residual, &sg->qsg, attrs);
+        }
+
+        if (unlikely(res != MEMTX_OK)) {
+            trace_pci_nvme_err_data_transfer(res);
+            return NVME_DATA_TRAS_ERROR;
         }
 
         if (unlikely(residual)) {
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index f97a6a11f360..7cc4d1975afb 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -139,6 +139,7 @@ pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_cfs(void) "controller fatal status"
 pci_nvme_err_aio(uint16_t cid, const char *errname, uint16_t status) "cid %"PRIu16" err '%s' status 0x%"PRIx16""
 pci_nvme_err_copy_invalid_format(uint8_t format) "format 0x%"PRIx8""
+pci_nvme_err_data_transfer(int result) "result %d"
 pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_sgl_excess_length(uint32_t residual) "residual %"PRIu32""

---
base-commit: 97c88c61d45dee6e1f9bc160a338048189846d28
change-id: 20261117-fix-4700-111c59d3a60f

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


