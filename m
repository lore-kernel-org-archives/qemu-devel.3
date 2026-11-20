Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4F606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=iBYthhDT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vaRoCgaB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNkw-0001UB-Ju; Fri, 20 Nov 2026 07:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkg-0001H3-He
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:07 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkd-0007l4-SC
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:02 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5150E7A0365
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:29:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 20 Nov 2026 07:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795177798; x=
 1795264198; bh=FXRJmom8K6TWR6KAdXgSpPjurVQUxxFH+KBFJBa4VhY=; b=i
 BYthhDTB8ckvAPEl5GisPKE3byaBMVa0QSYWNbiDBx1aYQn9v8JZ5L+40iRWiUzf
 BzGvF6l3Ov8CZ6/MrmL5Be32Iv9WPoxvLUVNO6Zq76slCUANHaixSAIN/pLIXzD9
 n/klvOxwJm2yLAwLbyZ/QFoQSx0KJl24xTEGTKsgC+7fMoO3b6/Ad+p+fZTxM0ZQ
 G3B+k2zcg83nKQGpBFzAfH3/BqUnVMSkI+lC1tng60GmMdYL0j/0h2eDN3MWGoNz
 znwiGrUes3f4rV/dMiC32Rf0o/Qq77+LTFoqyEP+Z8LcYgzEtZqiPNA1XNM5yEJL
 Aej/gZtxzvTlxitH7Q5ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1795177798; x=1795264198; bh=F
 XRJmom8K6TWR6KAdXgSpPjurVQUxxFH+KBFJBa4VhY=; b=vaRoCgaBgxuMcOVCC
 TO5yH9S76QOpRfzu1LxsIJxHNzYSqkQTzfELmzL3LFofSMggJMJUCceP+mVSVomF
 5g/mssQTkUkzbbBD0aClEI5bccUJeTwhBocSGAcm0ZUIy6QBY0ywEm/QJqUUeBmo
 CPFi9eLDFit6ymlMjyTdo834X6cNHk03oVL/ogdhZymoMIc/a9oQXmpUgS0tGGW+
 iAvS0yXuRlRxjGPnbsWKJGbACND01/McgR89BOUN4Xyzx1C/JoL9Jz4Wt1m4wY1F
 4geKE/8ExfFxzodu65b1+Gml0Lh3yhuTnnpcHrwVk6ykyqmCiugz5TyqUHsGXwGH
 IZagQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177798; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:XoDBkwtFNOM3IFxOTwz1KFJI7umVdLySsQZKO1fFofXrJtq
 G1fU41KvW/yJjFAr8eDZRp7bIJDtUgyb49gQ+8On0Fc8+06lERcw4fJ8ER9UOjnR
 Mpfi6oBDtwlsZ8qQRXft8SYGipXm30uYaeQCLA5jVOxx8yKIwx24iNzPHzICf/gG
 +fwoOW8B20YuiepD0VeDERtDf9LtO759OjTOrgAuHuCwhfrsUzTXn87+N4G4HpXA
 /cbDaJussuWCmLAcxMflJlqGlgHqR5/QeyM8Tm4O779KiczsOL6E3PNjgQ2tdDx5
 W+9aj9PDwis2QtsCGVN4vC3CQGuiIK3jxf/pCqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:hBvo/765hCmMWjCftLyUTYURkYLmR6RIVLcPLPpAstY=:x07MF7HArIhc8ez/MzVyXE/TUspx10vTLAuyYWJ7/no=;
X-ME-Sender: <xms:RT0Aa-f3lTxa7DY08SOxg9R1UfrUJgz6zZUw6MXA-CRWr-z6pLF58g>
 <xme:RT0AayR31bXx5ST-Vhg2Ssi7WNyWpPs40H_dQl9R6XqfPuP6w30qEcucMjSf-DYR_
 JS6DH4nfGf5HdXjyCXvGTl-8En9mqiF3S4bhr5RXmVtiCqs-UcjU_nG>
X-ME-Received: <xmr:RT0Aa_Zt-LWkc7KNzBMgMTjsj4VO5JPC5_yi9_j8bccoyvztSx7etFCEd8Oah_K1gT_HrbqpNGYPdvJLYLkoowWG3B-LzOH0oVd-kYC217TcuRaQN7gyLr7znQ>
X-ME-Proxy-Cause: dmFkZTFExTPYgg8rgO42EmNi083fhhkydGLyZE921u8lzGuruqpOi7Ge9E8B6a/id363MM
 M8BuWLLMO4fVvHkeGeOvWlpeoA6GU35EKJN3DgbiBVzuwXF8r2cHQLJg8fU0rGl2E0dOeO
 s+Nw2MlKxrILceBWhs3BK1ffPSR4HqonM4K29WT+QrvPJ096TStn1G84JjDR/oel6TQubk
 pyaFkaRhqF5OW/axUdI48bq8biSN19b82iagHYFTHVCw0Gkg9xAKDwvCK7KO0j7WxrJBUI
 ZB+43jhea1ublyYSN1UTeSHfOMWuASCGqIz4XcJ9chfm7jLNIur7l8entiBUQTObBo0PbO
 i0ouOdFK+vdwuuSYJ96nR1v4tiFG8lej7Oeap6zdLDK9WSeFACKeNd0UoP4NAZOMZrQhYq
 jG56ZVhS/qDcXk8OF6lwn49iQCd1nqnDCcTnCQdv3+icxVKYbW2iqrcFotzRd3fDteqigZ
 gL61KHXmAcioieUyhazeDYqpmu03GRGVimei4hSTZktaC8oBzYGSfZwEn6N1f1uWTxVuly
 9lsgwhacJ/KV9QcNyegkmFB+EdRLfx3sl5wXVs7CLC8sh1H3hyKqXG41MeZVWOwcsYQs1N
 ogO6KJU0GWeV18tYL1gKDfvXWDar2VdeSKaM/CEVKQt1lX/UKa+QkjZ6etPQ
X-ME-Proxy: <xmx:RT0Aa9fQwu6Q9Ot_1cm-eAMLkiItlV0pps6ddJHN-V0gquX4gF9uFQ>
 <xmx:RT0Aa4LTVDxKhIR34OzI9D2jtNGiMjEqIZ5ctE2_R7GENfP0S7LVVw>
 <xmx:RT0AayL45RKonrDYsomLlbSZOqUrIyWEsqv-NSEBvxX_wkj53ZWPPg>
 <xmx:RT0Aa_XAbwwSVvvU9M77fiYXdvx_FGwkteeBnrq7BZPGBoMGRYg_DQ>
 <xmx:Rj0Aa8gyx8sUH6LQVcnKabCbuqmZhUv6hbGZETn2E0o0RbYpueQYV4bJ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:29:56 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 1/5] hw/nvme: report data transfer error on failed dma
Date: Fri, 20 Nov 2026 13:29:45 +0100
Message-ID: <20261120122949.1044-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120122949.1044-1-its@irrelevant.dk>
References: <20261120122949.1044-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.154; envelope-from=its@irrelevant.dk;
 helo=fhigh-b3-smtp.messagingengine.com
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
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
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
-- 
2.53.0


