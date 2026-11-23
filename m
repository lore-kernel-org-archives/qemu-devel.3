Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FA606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=gqKycCrl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fSAynNIC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVdY-0002qr-Hc; Mon, 23 Nov 2026 10:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbn-0001aY-Ns
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:34 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbl-0003lW-1c
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:31 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 4D391EC0BE8
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 10:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446315;
 x=1795532715; bh=Dp/fpvYh/QulJWKPlywyIYtdiHxPcpCDRWSTTAtO7bw=; b=
 gqKycCrlXbCimQZql4xShYRT6gUax/Gb5vtR5yuGJsuYpTT5tfH/RMSMJ0Fcz1v6
 +2w08gNycoIwso6Rf09syE9/uEI5Gf/aGHdO2FuGCPUzlho+KCDGtqfs0NadjP04
 1YrhWIdJQx/BjFppw+1IyumeWxj2eTaWcHwy0OK1o9EF0xz4vmmMbIQHiagetIuR
 hhm1lZ+w7cwXZJr9H8d6QNOlFzTd2QnOiCVceHS8uJDF3jld1zDQ5jJH0JfaCDOb
 zF/t2v7IadAJhzNFyZNRrtyH+KVdMAQ8WmdUlDUlSJPCL1E5wCqJbNFM3O82hwju
 wdWh8RXE1TLQgl6hrFHjLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446315; x=
 1795532715; bh=Dp/fpvYh/QulJWKPlywyIYtdiHxPcpCDRWSTTAtO7bw=; b=f
 SAynNICW/dKY7cF1MC2Dhya6gJ2aigXiw9puaveSuCaAcj1fRCtcEOvWjpGT6qu3
 TJeBYf5qa/SOAcX9haoiIB1SBJ4h9Y5akT67OWCmlbUzKrbaRvQtT/Pwxt6mGOUP
 6rChXL1wGyCX+Hqo+H2khGVCNzXMYEVzsmBap843WC7VwzY42qSfOo9k5DCO0QOz
 iimZCDVpR7svySBWd1PgFLNQ5DZpMl0Z5ZN3eplfoAxTJnlTpgMo7agTyjuIxx29
 bDg0dNZg7JvIkOSvVnKfbFL51wHwJ6WaxtT4KfZ0lVmwHBszmhGJY+LBhjob+VWr
 uqmwRNKgLV/EISkPUADcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446315; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:OkPoelukERyJ60d04VQCJNiPQFKyoG0EzwQsaXkAFAJNn2u
 6jlsYjpgqMX5kgJpvbYi+DsqmW3YJ6Qpp1KBhQ3h6jRfSSbefmDW+XHjMJexlo2k
 5SiPcX7Pinx4Vd10GeyHDU+Uf2SUCPaW3faQi7By7nmWlGtUUQyxtIE4b+u+rt4W
 xrpCj5GdOah+Wa9+2l/qeZrPV0+KSvBAG0o07JAVn1GYLWIBgLiRAfbJlA/BducA
 1EXIUit8v5EKmTf8cdqN09yVrXldnIrcN8b41316PGMSzVUwQCZrKkLfJTcQMH1/
 uds2M/dKldfz/tVTrzRsZegkSJ0nsoIh5gVLbcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:e5OpKeoVs3XB4hLZa+zxatj201pyVRy2Z3tXDjPSYzA=:4frmWGtXtod/4m6IqvT67hKkyBj6yjzTtNSAXBIVQds=;
X-ME-Sender: <xms:K1YEa9f8u8EVQ4wNxAPvHqemX_XWqzKL5csUC-tqJORTdaXrj89HVA>
 <xme:K1YEa7qHCfwoFW8PhRuxXlwlMMxDLLvffz1JXv98yiJCbl8Gm1dMxA_LeOJWLfVhD
 qZe5eYy8g2fhxXIqVul3PFrv-QMvERo-tvf9pANT53xJU6mxXso_f7->
X-ME-Received: <xmr:K1YEa3PifhQVHNV4ezjfd6e8Vy0WGWbmhRRvlRboQfCm0T-5jYRGvlykzYoPylncFi9-si0BY-fl5AmmWvl0oMbd0Zy8jVMkjc39>
X-ME-Proxy-Cause: dmFkZTELLur8BXTN+Pfu/vGrhGNx5NTYKgvNmQj/nShp3B6DTtxFX72jeofaltKsU0cYld
 iSyGQaH3mC2zZHDHJlagGBsTKvIrboYWAWOyaxfDngys6rowGd31F7/VG8HBpBMOajopZH
 bVIlKrzAYjLC8cHAfFZ2xcns3oNYLS0YQMgKDLqkpspJtjNWXp+pLuylPVebUtfF/M9E/2
 1A5y7C4mCix1LBNeVagOHEZnprcx2xTN/HNQvO76skdiTfZ/LtkdHP9k9gDOdayK7Eh3u3
 We4XIv+Y/STEQ1sKu4GQbxWOvO41ubCP22E/m/FCgfjaEK0aOHmTlee58476Qb3E9RqsFc
 gNNuqQC2XcVDxETj+7v2Z0bOgZo4JwqNc/xJl8tVxGyMPW+2b9YBh764fFJ+rQlmzAJTQx
 fDQy9D05dJ34+0GogIm0oNZL487YFMB2XLqdyKeWmdSrwvbswJ+hgzvXd1Z0EO0c+V2CUy
 7sKKwSpORn2TAzlU4pDvDABMDSHyF6U6eSTx3OfBwXBfiN2TRKJ+iyE1yZqbBgeGoH5I6M
 Hm3/+GH3/APWMEs2BL2qLyFCkD+U92zkhvhDFackJPyDH4H3rF841Cci19u3Qc8SLd5kgx
 qbq5IrY7Fu5Qb5y1CNSD7J9C7YSi2RiFqWTgcFN6gpGKM4ssi3mv1Ngq9Udg
X-ME-Proxy: <xmx:K1YEa-ijSa0MGspj33iDncA-APaZ811vwZEJ0biYL4KiiDT5cm4cnA>
 <xmx:K1YEa6tyI6_IJ_LWHBpXbGPmHCWhArvEzRRC3230EPitB4F43pUqbw>
 <xmx:K1YEayh2NptttzQly7--NaqEwskx6DIGc6zJj752QEcW56wheopdSQ>
 <xmx:K1YEawYXVv2TvK8bF5rwLF3iYrM7_cyYSNs1UakQIFmyoIX-S0TjQg>
 <xmx:K1YEazm48W2APvqbGfba03hEzSlTDnsaM63_sG9yZvwD2g7FahJ6N8ST>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:05:13 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:58 +0100
Subject: [PATCH v2 11/12] hw/nvme: log 23h - FDP events, page is 4 KiB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-11-4c9893537cd1@samsung.com>
References: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
In-Reply-To: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.150; envelope-from=foss@defmacro.it;
 helo=fout-a7-smtp.messagingengine.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jesper Wendel Devantier <j.devantier@samsung.com>

NVMe Base 2.4 spec, 5.2.13.1.32 defines the log page as 4KiB,
with NUMFDPE defining the number of FDP events in the FDP events
list and "the values of the bytes in this log page which follow the
FDP Event List is implementation specific.".

This change ensures that requests can be made within the 4KiB range
even when the FDP Event List is shorter than that.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 36e9bb3beea..2532b23b4f7 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5536,7 +5536,14 @@ static uint16_t nvme_fdp_events(NvmeCtrl *n, uint32_t endgrpid,
         ebuf = &endgrp->fdp.ctrl_events;
     }
 
-    log_size = sizeof(NvmeFdpEventsLog) + ebuf->nelems * sizeof(NvmeFdpEvent);
+    /* Base 2.4, 5.2.13.1.32: log page is defined as 4KiB */
+    enum { NVME_FDP_EVENTS_LOG_SIZE = 4096 };
+
+    QEMU_BUILD_BUG_ON(sizeof(NvmeFdpEventsLog) +
+                      NVME_FDP_MAX_EVENTS * sizeof(NvmeFdpEvent) >
+                      NVME_FDP_EVENTS_LOG_SIZE);
+
+    log_size = NVME_FDP_EVENTS_LOG_SIZE;
 
     if (off >= log_size) {
         return NVME_INVALID_FIELD | NVME_DNR;

-- 
2.51.2


