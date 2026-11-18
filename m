Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A91606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=AFAQJN9l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Xr06Pvff
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTf2r-0007FC-1W; Wed, 18 Nov 2026 07:45:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTf2p-0007Dj-Ec
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:45:47 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTf2n-0000kz-OS
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:45:47 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 15BA67A029E
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:45:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 07:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1795005944; x=1795092344; bh=A0Q/x+g7goTyZiF+2HIgqoYCAqJdyFlX
 5DSXrD268pw=; b=AFAQJN9l0hCYG1slqHhVStr1JoYEtD3JwQMQHcC60ox+DzLm
 HDtmojShVDL8CtrC9Z3nXrmbsWfGMbSmc/GN4zKDi62kgdlyN1ChpWNAzsKjDvrd
 sdm93TpvtVVweP9wMYSWU0p4JD/QWAtZuz0pod0BFlSCZn/WyrEpUlTs9LhBy3s7
 fzxtZFHi3MAFxdyV6RMXnZaOeRSmmpLceBqSHWXyjsRf2A/oCzhzfc8XEW31lMdL
 6yOYT/ijUsDqoYiOPhoQ8AqCcN/vd473wZa74uxYsf2I2qrPoquCxONL3+sPuGyj
 hOcxURaEp441AngpK2sp5iW7gJR0pFU6mYdh1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795005944; x=
 1795092344; bh=A0Q/x+g7goTyZiF+2HIgqoYCAqJdyFlX5DSXrD268pw=; b=X
 r06PvffqYkNF38y7xAz9xONG/oBaNJRnfq1ZfWlv2PCq/qu+Gyg4qVspP23a9X2h
 fBgzK3+IFw6mKrPMDaAirAE9StdkVjPUWKAafJFOfYkIDb7u7ocivP8oFmH9THKA
 kIGi6hhEkDRcRh0CcQSgHj6tMlj7jlW65TqWiLzTTLYi83eJR6qbDB+NA0/X3U4z
 ajQbL6xKlM+MKD7BB6sOz12nIsl7KulAKhwo2vD8f/eFn8A8ugZ7H7kLFYzy39tx
 /FVwdK4+9u0ixeg18s4FbNAvDEeR/wVV6Q27s95pdNE744hBNAQYDouczNjVcYdy
 iaPYCRmr3dwWk/0MNmy4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795005944; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:ev1mZu95avCfrhXqb25Mx1kYTaBpSKZJWtpcmdHMKATmJeV
 8N+DiO3MYwYOD3V/1hQ7enUfE6qg/CioD1e6cL1ocsPGLPvBdkXOavPhtzjlWXil
 uq+mA1YjGUaIQglh/O8QC3Mfk1Y8PYfS+cwwe0Ch1o+kWN0W3QeJC+SnPlwdNNmN
 u9ax1ABNPSfqQYqm2GB4qoNwtM+fnhy2ao9AwbLC9QNOYwiVE424HA65y1toE1aS
 Ywb4lESimK0gciTNlxpn6tM288F69GE7SHRWqmXqYOkCSHbNQYhWsM8r0Arh2tR6
 0wrZmIJ2LzchPMnLLWrEGswFmWvOk1z6pF+QaXw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:F4iVhOLfEozuQjMnMFbxPf095HJtJ+wKw0Wa7/HVQik=:mKUHMgR5a4yahYKRbfpkRqbSqcQtAjp0rggHAQdzuKw=;
X-ME-Sender: <xms:-J39ar6TjJkACtSZcMKYZaNt36Eq3Ej_MjI70sUFXvShay3OJBpR0w>
 <xme:-J39ar267zOSv0v80UegWf4EcoIkalaIGoXbDKM1lxupp07NBZeJKTD6LE_pjrXGz
 zd_ydJkXUXbtzXVQYPgd1VsalY9t7QpLxUOum8i_dG8e7a-HzPPGrht>
X-ME-Received: <xmr:-J39ahfHHJk3kZuv09ZEj0l7eLYrj_-4IqSe8a8EKuCSy5lA0zNTX8bWFtVJ58COXbNiOmsP0lU0hMEpma6o30Y>
X-ME-Proxy-Cause: dmFkZTFnDJe21PRI6Xs75AC38/DjFn+5fOrthYoLCb03HxsZVGRS3+pKouurG+YGXJVDIW
 TYJiJUNKP4lpBYx6gZSIVxDfdlTUmjvkGOyTWTitaQqudiaLsACbc8YZpoNyR54G4yehQS
 rdgFamNKSZnxTvhxSPwEZQ6ge9gOBs6WoSebH9sgoX+t/c4Oc8n8ww0P3kGuVjqRCHWwrs
 0A8r3aPfe29k8Xjh3Xcvl0UmsPej3aJV1ApLS9jF15nIoZlfChImZzWnPnj4bOo5xTQpuL
 oaRB30ENB9o/WiW2cloepAImpytqOuWGrQRoXOouJqpXk/R4046EJG9p65HiUNPstyxmIO
 JUUUcocqCMhok7wgyhk2N2Wd7CcRwgzy2QgA4vtRS7EamqtHQCIavFJTa50fnYBrtauuaL
 k/Q5yX7J8557Y6ATttNMObQAQpLzLguKzSMyT3/m8A7EPBws88cQzMmSqdqKsYF4u4+Lai
 8gas36m6Los0g3pa5e1d3rcY/XNFBlS6AVO4MQ1U6UYftvbgIkQ8g/ZJNyPJdsNm2rpPCw
 B6XHlJh115idzXJWOCXWyWM1GTkbvSM9b3ekCV7M1JT8AAXGy5jM+KyKgslpiTWNp/YGH7
 fFAdccuuveoeWucv5KW8xvPoIIFpM5MVt46vMRY19h5WwQqeXx/jSUwFyyvQ
X-ME-Proxy: <xmx:-J39ahdzIYaBJLD9qprij-Ogo8eWlrItCRceABa1eDxbXW-qFW-Mwg>
 <xmx:-J39asyGHCBPeAMPMOu9U6B72Jutcv029lkL0zUgWqY7hzu3p1HtkQ>
 <xmx:-J39ag8bAAhmHWott7FCYX7BggGcm1vVMEpvcEFXvpT2BbRhQ6bNLQ>
 <xmx:-J39asjT47uMVT-HpLjieQ5LVeKZ9g3orbkMseocWmtYUgjrfodOaQ>
 <xmx:-J39ar1EGehraPc0Qeaa1Fuxa4wmh4G5WVHu0cVK3slA703YFJlAClLj>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:45:43 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 18 Nov 2026 13:45:35 +0100
Subject: [PATCH 2/3] hw/nvme: bound zrwa flush by the write area and zone
 write boundary
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-fix-4520-v1-2-dfa182213376@samsung.com>
References: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
In-Reply-To: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=auzEyvuvaCvNNMsBjZ4YbqVBWIIn/KszLKhYo81x11M=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3I5bmZDOUZEN3BXSWg5TUltTWxURVNtVnV3ClpOV0QrTUhPSndBcTloL3ZL
 Qkpmb1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcS9aM3d
 BQW9KRUUzaHJ6RnRUdzNwNXNvSUFMZmVFZFJSMm1nTklmMDZyY3hPRlNMU0hLdEJOc2VkeEh6OQ
 p0ajJTZGNZd3dnZkM4YWZ2cUdrRiswVEZnRkhqc1lCUGFpczlyRGJJOVkzaStKd1Q2Lzd0a0RiZ
 1lZMmh0L0taCkN4aUxtS2JyV0FqM01jMUI2UnE5L0Vqb1I0VDNGalREb1F0aTdqMGJVMW1SRGNF
 RFB3MU13UjJoNVdkNTJvakUKQ2FzVHluQWRMby9SMTcyS2dNTlJ0TXg1Z2Z2YlZoRXppc2VVN3d
 ZMTR0b2hIWnNpeU03YmJMbmhva0IxcG5VRgpoME9IY0JwVGltZUFyc1RadW8vc3NEcjRMc2hnYT
 J1cUxBa01qSHVZbGJtbU9RTzNPVTBYWEx2cmFmV1pCd2I4CnZvN3Fjb2IxM3E2dGJOdEVvekl3b
 C9PVXRTc1dHYU80eVpTWlc2K3Fid1NZcHlqOUdOc0VvTENICj1mb1JhCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
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


