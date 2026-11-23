Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA34606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=B/R/VYF0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=P6hLvDpo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVcY-0002Jl-2z; Mon, 23 Nov 2026 10:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbX-0001QQ-IX
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:17 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbV-0003kV-Au
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:14 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 8E73FEC0BD1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 23 Nov 2026 10:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446311;
 x=1795532711; bh=HLZlD8qPxdr+itYDmdngApgdMKGmQUViC3n/adKQlig=; b=
 B/R/VYF0usCheic8OQujQSOXHmvb5iIBaYANj5kic3VZD9sOuKsu70DjBj3Byq0V
 xIHn2KF/KZOgg/YXDVB55CSLgVc7QUSuvedQjqEUVsYxXgpYhQn7pLAWEXevIvmj
 HerXAH9Z/lwqmyamdBNXtcNPeq5YgK8mpC4uoD9KV/GCEEspdnhGpT22BNWJ5QE0
 lfE68OGSFIBs9C48H8owj8SVmr3UG95mi0FZIGXQWHfwtKw1k46pO7+5F6A7/1az
 GhwP+VL1SlE6Rhi1/UEtQXvETwaKLLCks/vpu24H/fkBM9fNBCiOn9Sz7sYrJnIj
 HEtmhwbOP/lWkXPiTFsfjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446311; x=
 1795532711; bh=HLZlD8qPxdr+itYDmdngApgdMKGmQUViC3n/adKQlig=; b=P
 6hLvDpoF0JIJhTaLFD7xJ9HMxm+cP7npmMUF7QVqx/f4cVJ4BfVJ2blyHpaW1PoM
 sYC1vZXpoVQFOz/f2Yee7QXiUTXgN3wx0c7/jo5l7ruRgNkTuQHj20vVIJ+eKlHH
 dc6+J9KVdVsQr8s+fQ6S93t9r6wQ3JqWFU4mfGfbL8fx4v3sJd6NNjIlKQnQryo9
 M58oN7LWptIRnkmZunonHhMfzejtqRWDkDp2A6Nh7TYPAmyft65l4n8Z3e+eOirU
 5DckbFIrQpep5opbQukBMFRWdKADDmCwJlocRgwaEuqP28GZRkkYSl6eJXtpm8Fd
 smBnFqL4WpLLmbLGjAL6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446311; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:abZkbzmstGNoJQzSY73nPLFdyMi7XupglT+JAvtHtSOomfr
 Qq3vkHdW0OI32IWjpOyf0peobyKGU4EdQDHjpbETuAc3dS/rHR8fwErOtpTgArF0
 jdJwb4NQNAZqsjVJx0pggxGyS2wYdyXx0qBMMpA2h2icMNQrxFWaGbJ9qBNFtSZO
 tXdYQ6wEkZhpusHPr7mgzxUf+woXdjuZclvn9Q9QVyZfPD2Mp6Htgv8YanGz2NBL
 ENSACzCZ0Lg/lpJx5ujQoDYU2e0I86jygLDtQ1D2gI1yBj/MaLhknQjAdwKsltwt
 TDfoaf42/ViaCoSpXunMbhPLFyHLf7U7W/06oPw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:HOgn8VYXgbnwJ07axuJTtuZE4ZwQXTM5Bb3nHhA2BrA=:YxVbbFKljH7iNxAbK1fVQldVdiexjVeHZIDUn+/d/kg=;
X-ME-Sender: <xms:J1YEa6qZzjsVoaVUEqABmefwU12-crGfdt5QgbEjLuYBtDcnXtBIxw>
 <xme:J1YEa5HfXzsbS4Dv_vk7rWAFyMutofVMqod41OCnd8L6P3ViGM1ylVDMbNwb2mMXx
 XiX8EoBEkdXtiGUPYvkHKGDx-H4vqQUz4DrdVVMXKncYLHRyAKEFuQ->
X-ME-Received: <xmr:J1YEa_5yYQt-GElq5dYQCtZDS5kJ6lcxgVIp8Ds1KR0YPmq_PxidhWvhcosXZg9O3ySzAm_RvGylBbRqKLKlnSFaqeSv8_iNQ45P>
X-ME-Proxy-Cause: dmFkZTGpN1rBJTFZcUspkdSSqlrg1IfSnpVMDRVyTBWv9kgTmg8tHFw26b1+BcowUMWGRJ
 t9TYy9ClKuqpekAm7MzxXjHqjwuDlynFQvsJt5wBH3CCmbPGBrWGcYd8Mh4m/7tckYUMkP
 ZCxqTV3lXQWcoGiFjzn2AwpVt6k1R4P8ub4H84/VYAI00dspKZI6Cr643BwsJJA+TXii8Z
 Xm2neNXilO0fNMIWbOz/s6crele0aNSAcG4R7sp0ic5OlDJg9SjXLXUI8iL2e9bnSKeLqE
 M8uKGNVfIp0DDdlj2tKwmtcaJKqAKqaVpLc+pQy+3eExsJoWauZpPmMK6Uu9t2dN20/5hp
 UK/Bxrt5yi/GpAc3rt7Rkx9J80Y1DCrxphX0lKqohTHhlSvXLXM1gVZbWs7uOf4B1po/T3
 oVVWtj6RmkKsy0+x2d6tl0QNxIJEDMIhlm7ZXR/ArgTdF/zjpM36B6yHakK29zbJyeCm2x
 cm6+wUcnTYUo44L58XZFM0g+LnzCkkTatgfLTV0oXwGYQ8wvEQgxAm0XV9seWg5sdFQ0w6
 fkJRoghSjPGhUR8LlO7UVN3fpoBUbMu6egVZjX5Xk4pg4B9QyWmnKxmeA5Rg8o+tTd9QeR
 Jm6fMLd8bky3ntA1NKknrjgbNGzDTEhcm4nN5bR3ulWbuY+BsD7IS2nANdrw
X-ME-Proxy: <xmx:J1YEaxcRwiNeba2y8wakdyU90BhyB8-qoV_MH2jcB01BFw2AdiKT0Q>
 <xmx:J1YEa64p1ruoOk6_SITafZi4xU5Hp_txmqNiziGciwX5KJFTfBwIqQ>
 <xmx:J1YEa28Uf-TUUFKdC5FJYcASjeQWErzjvYVz2q7kWDlpoGbpZpmU5w>
 <xmx:J1YEa0FF6erPYrkfVtnVD01YE9Kc-ZGEyvITHx928yXGw6-4UfML1w>
 <xmx:J1YEa1xmCkweMymsLIKuVKAgnhAuSXPoTeBIGayfnXpK6HT5oEuQMniz>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:05:10 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:56 +0100
Subject: [PATCH v2 09/12] hw/nvme: correct MAXPIDS value
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-9-4c9893537cd1@samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jesper Wendel Devantier <j.devantier@samsung.com>

MAXPIDS determines the maximum value of NPIDS (number of placement
identifiers) for the I/O management send command for RUH update
operation.

MAXPIDS shall be less than (NRG * NRUH) and is a 0-based number.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cbdb5cf6981..4caa4a2912f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -390,6 +390,17 @@ static inline bool nvme_fdp_enabled(NvmeCtrl *n)
     return n->subsys && n->subsys->endgrp.fdp.enabled;
 }
 
+/*
+ * MAXPIDS shall be less than the product of NRG * NRUH, also bounded
+ * by NVME_FDP_MAXPIDS. Value is zero-indexed
+ */
+static inline uint16_t nvme_fdp_maxpids(uint16_t nrg, uint16_t nruh)
+{
+    uint32_t product = (uint32_t)nrg * nruh;
+
+    return MIN(NVME_FDP_MAXPIDS, product) - 1;
+}
+
 static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
                                    NvmeZoneState state)
 {
@@ -4629,15 +4640,17 @@ static uint16_t nvme_io_mgmt_send_ruh_update(NvmeCtrl *n, NvmeRequest *req)
     uint32_t npid = (cdw10 >> 16) + 1;
     unsigned int i = 0;
     g_autofree uint16_t *pids = NULL;
-    uint32_t maxnpid;
+    uint16_t maxpids;
 
     if (!ns->endgrp || !ns->endgrp->fdp.enabled) {
         return NVME_FDP_DISABLED | NVME_DNR;
     }
 
-    maxnpid = n->subsys->endgrp.fdp.nrg * n->subsys->endgrp.fdp.nruh;
+    maxpids = nvme_fdp_maxpids(ns->endgrp->fdp.nrg,
+                               ns->endgrp->fdp.nruh);
 
-    if (unlikely(npid >= MIN(NVME_FDP_MAXPIDS, maxnpid))) {
+    /* maxpid is zero-based, adjust npid for comparison */
+    if (unlikely((npid - 1) > maxpids)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -5396,7 +5409,8 @@ static uint16_t nvme_fdp_confs(NvmeCtrl *n, uint32_t endgrpid, uint32_t buf_len,
         hdr->fdpa = FIELD_DP8(hdr->fdpa, FDPA, RGIF, endgrp->fdp.rgif);
         hdr->nrg = cpu_to_le16(endgrp->fdp.nrg);
         hdr->nruh = cpu_to_le16(endgrp->fdp.nruh);
-        hdr->maxpids = cpu_to_le16(NVME_FDP_MAXPIDS - 1);
+        hdr->maxpids = cpu_to_le16(nvme_fdp_maxpids(endgrp->fdp.nrg,
+                                                    endgrp->fdp.nruh));
         hdr->nnss = cpu_to_le32(NVME_MAX_NAMESPACES);
         hdr->runs = cpu_to_le64(endgrp->fdp.runs);
 
@@ -5408,7 +5422,7 @@ static uint16_t nvme_fdp_confs(NvmeCtrl *n, uint32_t endgrpid, uint32_t buf_len,
         /* 1 bit for RUH in PIF -> 2 RUHs max. */
         hdr->nrg = cpu_to_le16(1);
         hdr->nruh = cpu_to_le16(1);
-        hdr->maxpids = cpu_to_le16(NVME_FDP_MAXPIDS - 1);
+        hdr->maxpids = cpu_to_le16(nvme_fdp_maxpids(1, 1));
         hdr->nnss = cpu_to_le32(1);
         hdr->runs = cpu_to_le64(96 * MiB);
 

-- 
2.51.2


