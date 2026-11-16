Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45043606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=WLHGgjSu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4eo9XQrI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4bU-0000d4-SL; Mon, 16 Nov 2026 16:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4bB-0000JY-B4
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:50 -0500
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b9-0005VK-JW
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:49 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E02FF7A00C6
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:50:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 16 Nov 2026 16:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1794865846; x=
 1794952246; bh=GR+2Z8h+Z+1r/kq9mJOlKht8zfauaNEtNO2ZgNthRtI=; b=W
 LHGgjSuGJN5IlGxGB2lNFTiS+pPNKsY7lxhYLbXai8wyEJyDPiBm4g7B60DDR93s
 l+Gappt3itusYfAa6/Iuq4QWfhYPteTfCfzssFmekaSIu5rgWwVldtYHW9PvuZa+
 Vh+z4oU40pY2Qgac7sRt+8eMAWBpAa78EJpJZS0vOGZmowON/XlKTFd/JmPaEXBE
 fg5HIwVGgHyW0TrurjcZBmtoIuuehgDi2kL0smmuxE8WVOtG24qVoElF9eqi/sYN
 7L1Js0F3xpd9tfji+eD0+fKzfQ9vdd9vMwQcBJewut+QWLUSLEnHAr72MhFM1nG9
 IqnqfHwgHQ/avCgcRMD5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794865846; x=1794952246; bh=G
 R+2Z8h+Z+1r/kq9mJOlKht8zfauaNEtNO2ZgNthRtI=; b=4eo9XQrIAAA5KD1zU
 myEB3AzFGw1Qts1NAlsRZtfBt5xeZuysu66RFIn5soptRo79S57kHH0aOOzpld4E
 iEtZvi4vS574Yw3SV83GFD7dFI++jC00gbPRF+3Cka33pBAEaQiTGLYYYBtFOge1
 hByDo/UbzgAVHvMR1dO0/3BmKmZksmEG8DdywzhMozw15QfLKzjrzxTxD5HP3740
 OIa+0hy4Wb+e62Nrnr7vkMjjfXnzabdsyPViFTrC/w9PbLpdDF7QpwSSfl15VUcC
 v98JljqB5rJwwY/vG/AQwdN1mdYKFprt6WbU/Tq4VaQ9y/wRO0WEkXU1aFPwILoa
 AM5Hg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794865846; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:cVlUvGrpLlJ1jvlf6IiiMe9KRaw7J6BzybLWEuMzOPqhfb5
 PtCq4L48W76e1gNOXIzhRkt13v4yMnHcCt12ASUkavX2isWa624fmV7epiXB4obi
 YhjGjajoYafzvARsw76gBjqAnaYGoi5kJwH8KGO/Wir4z1dlzCvc7z7/AecDaQwV
 +MIUOMBw+fAWTNDfqI+/PKn/ilCKIQpiQDEjxMQxDwYD+QPoZVQGkZsEWR1+S9iW
 Dv8ITRzfT7zLdkS1CqrSx268aun7ICjHusyhluW2hrKIsIJ5Swwq+rZ0zeK10JQZ
 NSQEElI1NMT6ULX3ICuvVxgwF8pJ7wS0P/a24BQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:xiHJkfxaYKSvZhII7P2dVACOl3EFEbKYhmiirGBD9Mk=:xjBBUMoXQEEgcNBAIKdjrVhEnGK6P0kn8UOPQSdxu6A=;
X-ME-Sender: <xms:tnr7ataNgBB-062RyA1gge7-wG5PtOLunaX5mX2P1VLJ5MGyINMWFw>
 <xme:tnr7aucHwC1y0ob8NxtNym-4Mzlq6Qh-UXCX7w14IRkICgo91OmPmhjV6eYjCh6K5
 tdf_gL73KjahqFszpF_NktJdfrmjjXHUQAQ81gqZzisbUUxlXToUsg>
X-ME-Received: <xmr:tnr7av1CqxBZztrXMyQRtkx-543b96k3N0Oo5mA5gS25kvIEQlTnRiWcJRHH_ui7Jp02jBsdW4E8wCJSZ_r473WjybKLseXwzRPWoby3UL2SReJpjoiZ8LMCJA>
X-ME-Proxy-Cause: dmFkZTFy7iejwYF8R6pgM2a3CpNbLlro9fsD75g2yzrFNAd5PmdgvTYh1/eRSWnWpwbXu1
 HzGlgFWb5Mc6khiKfSe7BRN1Rj81GuJmBIFaiJAv6qgLhDJOFNTaISsau+71zNjhLftcQR
 tThKXPYRHDJ35YKr3GgpMxILGNcR1vRrtfuHeGzUEToUAjhCNcu/qY/WvVgUXTuPP3AQzG
 e8V3jTOnoARdVPR7ZO8iksdh0c8kdXA61/Jr4sCiGjOaEF2cz7wMg1s+Fb7Uqht3Mxjd8h
 HBjB3X5kUK3mVGVZ+b2KkYuP0BfX+FzDNfFBKEGW7jRm0nZ9iVo92bw3Ck+ZgKSAyLFEUZ
 HZTke19gezI3MtcRL40zeHXt/Ze92Lp4XIq3bwvWVWl88Av5wBX9YWvb1yyZdUguLSArHm
 ICmaRw6lYArb2YFpwWfikeMPDTFlJZuTu0et3yCk58h+sLDz/OaEZ5ANfA+dlby5XkYveH
 I6hCDf4yrTrchxbiF2aYgDGOwKH+zZlkmJ+j5Mt201ZDfO9lCXJ8pqfBogM0d50tf8AGwu
 oHgSzzXbJ8iB+uqmMQSod9mV1tZgodRNhUvOKkkXIlLFAHXG6ky+2c9ULPpUFQIBcy9ZfQ
 TLWPFReSXlD6QDqbUiG1xOK+Or69MX531nkdavnSJLWzaMGt/M5fgopna8yw
X-ME-Proxy: <xmx:tnr7atLOv6xWz_ZqiQeHsa0I8IsbjEMaP-2s0qcsdl5VV4JGFWAeFg>
 <xmx:tnr7amF5oDquzzseIOolrqFgdGOS6Q9q-P9SX1FL9XwcWc47XxRPKQ>
 <xmx:tnr7ahXytZuOrED-mGzfvs0FXEOxqppq0Qm8w_wbHiqw6CYKRFLjXg>
 <xmx:tnr7amx_kU18ndrttDi00Y81VlTedeEIJY8IcOKvrYj2if_U_gyrnw>
 <xmx:tnr7aqhg4BqERPomWdf4sc3ex5GECoU-IBz5mRSnxx3nOP1aOYOI_xKB>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 16:50:45 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 6/7] hw/nvme: fix fdp reclaim unit accounting
Date: Mon, 16 Nov 2026 22:50:12 +0100
Message-ID: <20261116215014.59993-7-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116215014.59993-1-its@irrelevant.dk>
References: <20261116215014.59993-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
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

nvme_do_write_fdp falls back to placement handle zero for a write that
has no Data Placement directive or where the placement identifier is
invalid. However, it then passes the invalid placement identifier to
nvme_update_ruh which results in no update to RUAMW for placement handle
zero.

Reset the placement identifier along with the handle in the fallback.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 685cbc2f340c..a0d22dacedfa 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3754,6 +3754,7 @@ static void nvme_do_write_fdp(NvmeCtrl *n, NvmeRequest *req, uint64_t slba,
         !nvme_parse_pid(ns, pid, &ph, &rg)) {
         ph = 0;
         rg = 0;
+        pid = 0;
     }
 
     ruhid = ns->fdp.phs[ph];
-- 
2.53.0


