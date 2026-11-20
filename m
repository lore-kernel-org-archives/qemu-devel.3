Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2B606A33B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=GuakKjyA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nLdMmGnO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNkz-0001e9-Jc; Fri, 20 Nov 2026 07:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkp-0001PW-I4
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:15 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkm-00080s-Gf
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:11 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A31097A0336
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:30:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 20 Nov 2026 07:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795177807; x=
 1795264207; bh=1c97hYxdhOYXLuOy1KHqYITIXvLzwXNiCVdPWIamVeo=; b=G
 uakKjyA+gm6bb81BXnmLRCzipcOIr3AUfzn0KjdGUZ7GP4ilQdNOY0LTnX+wogk9
 +pCFcNAEag6p1ksXsLuR5PDYLy9c1kt2G2/Wbj8xNNkBuH9kogaZRNTX5I+VfMWB
 bPYf5jx/7QtmZNkNxXQ+QTklgOw9cR4gGlnA+Iu7wFyeXTvsD4qyvA5Ycr9pu7VW
 iGo3craMfoCBDP+sKlUNbO4zg4t76bSouTIaqSFjGmClqXb9xx4TFa4SiABLpjJn
 v+FgtxNevNuXN/aFLmbZQGxJz1vCfzhd/eMQesz+zEeKRqi449nXt5DriooiKpf6
 z0bJ78UMc8BhHEpASqX2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1795177807; x=1795264207; bh=1
 c97hYxdhOYXLuOy1KHqYITIXvLzwXNiCVdPWIamVeo=; b=nLdMmGnOWFyeU6CL+
 N15mbLKvV51gHc5kaWViztlvWj8NAC8gZAv6iRZaWG1lg+WAJHO5nN4pe6N9kRw9
 SiXT1uj9XQvGA92PPqXjidNi7T0FXxua1CcGLk49aMYrh5vnG9YFOwYh2Fni3BKS
 5QRti3ZRxeWpmGimCEB/8Dv4hSFTZvvGS0nt35O5I1hjeQSPMjTOdAnGRJD+Vqo2
 hQvcdeCjcQebVlLbiK6UN5RQAF9hIWCRwyggKGOeYduIce+NesjSXY8oJ/5n1VV7
 +fNeMeiIaLSbGNzu4yYvPZ6zlWSAkPXm4YXbJf3TgxgMqJYws/i9vjS7ER37OC42
 VS4TQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177807; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:KW0MEyOo4jsOy/9v7NpxI+puzIB1Zg+aALHnYuS+pxkeMVw
 lmcyDiWGL8DoeAQ7/YYEmqTb7obY/QSaeretAoAX/pclWf4bNJC6W/95dtGi6yfP
 UX1OdIK8PkGZi4e6PsLynYz6Mk13SWxKHx74O1OqcDFnaeMdVX0apk5/h3PubdlG
 wIsndiwme9lPEtlrYOiGUEm2J1b4hq202epoRC3grKMimtIlScf/qIJ3RMQkW9k4
 RlAXoOpRi0ORSvCtCQ5xpfFf8nslPti7gwTKzlDY6SMvL9mlTgOei2W+evhdCs63
 cNuKJYiEhPVxwFycy4z/agddOTyd4nt2dMK7H2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:yNuP6OV2n2ISdxkUfIKDBONJsNxvhk8P4OKWILT4SfA=:SLtrphgYes40hEy0H3YM8HGCrrf5bYUhF0f/9STIlzs=;
X-ME-Sender: <xms:Tz0Aa3T5QwOU_1Bqj0fUeg7bYSwZV5Y0z_A33le7IaJqp-nSNClwiA>
 <xme:Tz0Aay3OTFfP35bfCJPAcohZpGWeN7Lq9MYeBQZ7X5TlxH8pOkuzlEJkqSVV3ypkw
 85bMkWgE2h-McaAqVNACs0C1dtca1F50LIgqYRNQJVArlR41tpP7h8>
X-ME-Received: <xmr:Tz0Aa8uSRrhEu8uv4lWMSVzpVWh_1tGh0mNrbfk2N9jcuIEfDVEyrZB0ybaPTki1mp6QuxNSp-HIngTTD__AenK1LijDtxIDWwkvCC1jo5sId7Qb7tOFD41fIg>
X-ME-Proxy-Cause: dmFkZTFExTPYgg8rgO42EmNi083fhhkydGLyZE921u8lzGuruqpOi7Ge9E8B6a/id363MM
 M8BuWLLMO4fVvHkeGeOvWlpeoA6GU35EKJN3DgbiBVzuwXF8r2cHQLJg8fU0rGl2E0dOeO
 s+Nw2MlKxrILceBWhs3BK1ffPSR4HqonM4K29WT+QrvPJ096TStn1G84JjDR/oel6TQubk
 pyaFkaRhqF5OW/axUdI48bq8biSN19b82iagHYFTHVCw0Gkg9xAKDwvCK7KO0j7WxrJBUI
 ZB+43jhea1ublyYSN1UTeSHfOMWuASCGqIz4XcJ9chfm7jLNIur7l8entiBUQTObBo0Pre
 V4EGFlO8wqOLJBCX08rbU7YwQpWf5q+/HxWh+FoA6/Ie15s0aIwtIQwT/gj5Ln8px3RHSI
 ExJStqlS5dL6BGhZ4dQ1Jjov+Zpq3WMun0LfFInJa444dua/5+VQU8uKYr6P+5BDkVmMXG
 K/g3CYw+gN1dJ9OyNzoEB+qT7sngltgyZEGwExTpJyxRDtL0DxOafgj4NNM/hR4tYcVGIT
 K3Mr4/aRZowdwahwK4LpprcyEn43F6d5NJlzV1NOh5/WN/Li7QpXk0dTI9xVtsimBxsVpw
 BJvyC41Puuf6WqoEDDChhUs15gvC5VQH+cTYjI1LRlBsf0rggWFwiLK6muXA
X-ME-Proxy: <xmx:Tz0Aa4jde8ko4YP6D0AKUD3Yn1jycRFMHF2ko3wl1ekfbfdcsA6Mew>
 <xmx:Tz0Aa99Ass8DGDBgSEK64ZWx3sSpbvI9dx1TnzHUjBL5dlEJoN18OA>
 <xmx:Tz0Aa7sWqzkjjX3EudMRqEqm12QnPsEIv10SApNle_hFnq7pYei34w>
 <xmx:Tz0Aaxo-54pTGTqxH2Z1XCNnmmRX8GDmCykEHzLgrxWRg0QZKlhsSA>
 <xmx:Tz0Aa8Yk4LVtNB4lDG8tUIxH0I_vIfvQGe9CKjdILLSEXdVlvDMYdvam>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:30:06 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 4/5] hw/nvme: bound zrwa flush by the write area and zone write
 boundary
Date: Fri, 20 Nov 2026 13:29:48 +0100
Message-ID: <20261120122949.1044-5-its@irrelevant.dk>
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

nvme_zone_mgmt_send_zrwa_flush incorrectly accepts a flush up to and
including one LBA past the zone random write area. Fix the comparison.

Additionally, there is no check that the last LBA to be flushed falls
within the zone boundary (i.e., the *capacity* of the zone). That is, if
a zone has a small capacity than size, the write pointer can be pushed
past it. Fix with a check on the zone write boundary.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: e321b4cdc2dd ("hw/nvme: add support for zoned random write area")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 16860ccd9520..35e2c57851ae 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4279,7 +4279,8 @@ static uint16_t nvme_zone_mgmt_send_zrwa_flush(NvmeCtrl *n, NvmeZone *zone,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (elba < wp || elba > wp + ns->zns.zrwas) {
+    if (elba < wp || elba >= wp + ns->zns.zrwas ||
+        elba >= nvme_zone_wr_boundary(zone)) {
         return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
     }
 
-- 
2.53.0


