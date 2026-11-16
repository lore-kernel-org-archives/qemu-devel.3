Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86483606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=BOmzibJo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KNMBEWkl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4bn-0000vI-O1; Mon, 16 Nov 2026 16:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b7-0000EZ-2L
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:48 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b4-0005IS-UJ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:44 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 6779B1D00197
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:50:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 16 Nov 2026 16:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1794865841; x=
 1794952241; bh=oEqkib72sjhPC5GFYQiR2iBx56ILw+FxCEZzrf+veUo=; b=B
 OmzibJotoL/V+dbtTnJUFsrbxkTO1w4hmGd1Xil0eBCdRBnZpg8TMC+gBUmU1bwI
 3uzk4XFKo/zoJVaARdf90GH60piH1vNEl+sPhtzmtFwXd7WFbsxwR3jKtHeyZXC1
 JwjCvv5uKwy+LgkFtfOz9rUN6OaQkwsXw1+cYD/aZ9SGX5U3HPmuN/GO7PdHh997
 WMys4hA7cv0mkYbLsdwXjW3GCDC7Rys369vaSRjExa7jEA/8kTA9fIvJkBNBsuWe
 aLdIVi2SUGjjrWqonAOrZsmIexNS6LaRpUs0ZwLym7L0ZwRe8BxUkvg+WZpFTEF0
 wl1NyKOOJ0GSe+b0OrIfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794865841; x=1794952241; bh=o
 Eqkib72sjhPC5GFYQiR2iBx56ILw+FxCEZzrf+veUo=; b=KNMBEWklhhJNTGx6d
 EYDHAKy0EPgMQxndQCAbWjmORTK+8zOCdkGRb389vch2y5S2/3CpdYwkPoMok4KJ
 Eh93pK4T3kCOs+hOvXtVucKiNCqkAniMRYYe9OCoTd+JmENsqQVNh6pQShCPo1Fw
 V6qn2N8ZNqWOYOc4POHYYfpDiOtpcULiv9K/n++X3VT9zG6pXvgegWa1G5BNzmEz
 p8BcwEp70WUM7r+32ZyaYDfBx3oLvdY6b/jjQWxIeOnTDfZ00KISIRfV3C631Jx/
 A7p0q59s3FESuaRNP2uBEqGKzyXOwjcvklsKkY7jkVCk0pdQjRSqJTsNejrZFufd
 OVxxQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794865841; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:KdonB8Iudo8eU6lOW+waEgDYseQRt25UNlE/sbjGGeYCCyp
 llECmLcsoyo27mjHHkVV8P+QYH6HZI5mdlnvJaDRuMPZ1YolZzc2XbPvw/lzDNQQ
 +09GYkDoDz6fBXzxQ/B9dQpcdDL42AS/YOVM3nFQQ8QIjjf57jwK2ui4YknupQmu
 ZLPgeI1SS05wUTuMGUTqrsZA//Gk0oaIGqgoIf+ypa3DL1NqNeGeW1Wxw+W6cVAH
 TlkiEtXmKlMeo2ArPM+SzhnEgMhCN01iCdrzGcKRPzDoa45VDSKZE8uDtxjCeaOr
 p2wg+9djuVQ9mffxwVAz1xo0B5ZUZ35nB20AdDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:wr4bG780Yjyv1CKQyQEeF4ra7jiUZNpRxD+2U1Qf9kY=:sJ5h0slQm4dCO2tETh+R5gynS4+hjbYrDAOTwMErI6k=;
X-ME-Sender: <xms:sXr7aieSYR8mq5deZuGQQGPhJ30lTTZQiWdgoAMOIRSTw-cwOB--rQ>
 <xme:sXr7amSkG-ZA8IMKhYjO1sbQbcTIK2T7qAhvVJz6VTNnzvfMGYLc0A_4kgbiP3SyR
 iJav-XczSrFcu5j9XdgW_IrCQV3jboXq82LUwJA0fEgOqYxIBdztFf1>
X-ME-Received: <xmr:sXr7ajYygYeoRVpos6tMivbfoaGh8htu9Nsifq9AYGSXEvmp4ELu1UzyypccB5NiebHqJGKoF8h_5Xr77UoT_sGTHjth5nHEF1FWnm7O-LSsN11sIwTPaMm-nQ>
X-ME-Proxy-Cause: dmFkZTFy7iejwYF8R6pgM2a3CpNbLlro9fsD75g2yzrFNAd5PmdgvTYh1/eRSWnWpwbXu1
 HzGlgFWb5Mc6khiKfSe7BRN1Rj81GuJmBIFaiJAv6qgLhDJOFNTaISsau+71zNjhLftcQR
 tThKXPYRHDJ35YKr3GgpMxILGNcR1vRrtfuHeGzUEToUAjhCNcu/qY/WvVgUXTuPP3AQzG
 e8V3jTOnoARdVPR7ZO8iksdh0c8kdXA61/Jr4sCiGjOaEF2cz7wMg1s+Fb7Uqht3Mxjd8h
 HBjB3X5kUK3mVGVZ+b2KkYuP0BfX+FzDNfFBKEGW7jRm0nZ9iVo92bw3Ck+ZgKSAyLFErP
 8/88BjDV4owb06A6JyLZwKa9fNMlzeIC5W30K9iAMs1qWdA+082EgB+EOcjSBYotVMEWqL
 UnJNRmVv4nSRbH193lgrJUSOJvxPx9YuS5P0NGIBwXfpcoJYkOrLLRpiNv0Ru4FcJARsuz
 Dl/y9XlVXhBxtUstS5T622wIat6Tx4nn227HwXWRHrSCMgNIO8gX2CcN9BIQJqPq4VE+Tq
 5ISXtIJS3q0Ep77Dfh2O0EhebCo5gE/OOeLf/nb3Cv8g1cMdcpdF9ssE1sqRbVyKixZMgi
 koPUklv//om/mA9yx4UXI8YR/nigHQQOB3Q9UxMDUb/Gj0beXOpmjav8sHdg
X-ME-Proxy: <xmx:sXr7ahfgT3FAww-GLIb1Y2KJ4RAF4-NeR2G_DPcGFLRQwB8kk3XlGw>
 <xmx:sXr7asLRFx2sbFnkijsNppjJONh_eebSOMOVGmwTVyveNasmknEVIA>
 <xmx:sXr7amK5WdnmZA2EyS3wQXGnvNUMcDbuJ1ngk_zbnnyXREZvaWgIGQ>
 <xmx:sXr7ajWJWDIvt8lYXkbpAm4-gv5z7n8jBDvUFL99FNUof0XjaifNMQ>
 <xmx:sXr7aggQ-qVv5GSOc8oL6EN506okYSWGeTK9i7vq7mNUQ1l8AFYQCHPI>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 16:50:39 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 4/7] hw/nvme: verify source and destination lba size for copy
Date: Mon, 16 Nov 2026 22:50:10 +0100
Message-ID: <20261116215014.59993-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116215014.59993-1-its@irrelevant.dk>
References: <20261116215014.59993-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Cross-namespace copy requires the source and destination namespace to
have the same logical block size. This is not verified, causing a heap
out-of-bounds write.

Fix by correctly identifying the invalid operation.

Cc: qemu-stable@nongnu.org
Reported-by: Feng Xue and XGPT of ThreatBook
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4173
Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4a626203cad8..685cbc2f340c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3278,6 +3278,11 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         status = NVME_INVALID_FIELD | NVME_DNR;
         goto invalid;
     } else if (snsid != dnsid) {
+        if (sns->lbaf.ds != dns->lbaf.ds) {
+            status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+            goto invalid;
+        }
+
         if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
             !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
             if (!nvme_copy_matching_ns_format(sns, dns, false)) {
-- 
2.53.0


