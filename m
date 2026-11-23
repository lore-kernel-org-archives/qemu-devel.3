Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6DC606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=vjqu99+0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YZPLJpMq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVe6-0003Bl-LD; Mon, 23 Nov 2026 10:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVc9-0001nH-KM
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:58 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbt-0003mV-0r
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:53 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 30447EC0BF0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 10:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446317;
 x=1795532717; bh=j77jfxnaZTUuFALczu5nKXx/X2QmT327aqyq8WHqD20=; b=
 vjqu99+0PPj8lFOsDtZ/OgsfJLVbcSM399PIOm0uSGod9rwMZB17uzD4jc/+BIu+
 llOpRWRrZVhYwNVV8mWkLlqtbkreCAEySSgV/M153E1D2Zekb3UGyzgYSOJNWZ/M
 FNAO8KDo/Gi08hBIMu0b0wTYk4txRZiRTagdGvz7JkrD4aAncK6VMUKhXYPLadic
 NjxHtHH5jDlRq0AA6hARVmkeDTb971O21+LxUhbUABvYReevjIx7dGV63pCXWXZt
 cigtIGE+qWI4Jj1DAqxqYf+kITerZKbtn+NgBSdAOskq532i+LlVJj+Z+m/GIhoG
 LWgsQkGMdUXg2s6tMmsA7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446317; x=
 1795532717; bh=j77jfxnaZTUuFALczu5nKXx/X2QmT327aqyq8WHqD20=; b=Y
 ZPLJpMqsrPeMSM4bU0hLyOxg2zZtI0hO1MHBCGx9NiylGTu4N26Y5le3ZY7928ME
 +5opmaV1jVnN/zc4gBhTYgXFPpRPd04tYUoxykWFBcIH8htkKpLPxckku/NSX5cs
 NUVqjs1brmvkfFMPrurXGLpFaNZj83AWN+Btjv/V1/ee9pNy7NhXSPXS5lz95OQn
 26vewe010RVgX9R+cGDU9T4D8s8GRd4C8+esBdZl/r60LBRLunNBIttGqzjcVNng
 HLcQSzyBEkLWO0EHklOA3aibhsO8ahIT1rD1VEdcXydVjZRPZwLFgxQVgxdThlNu
 obkRBW2KZoaHcpjJm5R3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446317; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:Oav73pCfAeR6Jem7D7G/eYiaSXFQ2DurgLBv14dlkxMlQte
 12TONS9KipFo6dBI/ntZK8pDantwi7hJgDrGtih41zKjC4FeDLa8bCM/ksfik8kl
 bSKmmf92soIMmh52MN1nURhkLFIe3ABVgLIRzEXwOYaCILaXFLYT8AeYXLhHz6yH
 Zfx28HkODTvrTdgAHneskE9ZnKJyovYPVkdq2qXJ0csRrPiU6Lvxw2bf1QD9hEup
 1q8hIlEIpmQ5jjK+vftUgKRllhAr0gS5PmfK9DG7/u392a+UJ5IYK725E/FGlYpV
 f9zpUKn6p8M8wGdzo3RmKmzpPPJDDK2ENIWSB0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:pgqF1pcf3nAFxObiFWLyF3uTbtvfL/4OzVlNs8G4bik=:/x/QzdEd7LlSKTkeJxuLRYmz1PDYVK/yjUEHL341vcE=;
X-ME-Sender: <xms:LFYEa-ZAOCs7B4qmdY1wcXY7NEk9grf8z6YkxiHyewNja1WUu5gDgw>
 <xme:LFYEax3860q59bN5gYLkbKXfMVx9Jmw6oxtFD-z6jesbs9D6w5Felc-W6f0rfOw5U
 r2wb7-dFt0CeI0xF2tNTYGpgLtLibTAnSFZopFD8mtVhx3_UKk23jTS>
X-ME-Received: <xmr:LFYEa5piv0R_NwaRYymclKCTz1CoLucmIUXnSxkiimzntwr3ruMHTAc0m69WoSkAwMFS3aiD51mSjttDAWxOFmSmXl8rWQFd02M9>
X-ME-Proxy-Cause: dmFkZTELLur8BXTN+Pfu/vGrhGNx5NTYKgvNmQj/nShp3B6DTtxFX72jeofaltKsU0cYld
 iSyGQaH3mC2zZHDHJlagGBsTKvIrboYWAWOyaxfDngys6rowGd31F7/VG8HBpBMOajopZH
 bVIlKrzAYjLC8cHAfFZ2xcns3oNYLS0YQMgKDLqkpspJtjNWXp+pLuylPVebUtfF/M9E/2
 1A5y7C4mCix1LBNeVagOHEZnprcx2xTN/HNQvO76skdiTfZ/LtkdHP9k9gDOdayK7Eh3u3
 We4XIv+Y/STEQ1sKu4GQbxWOvO41ubCP22E/m/FCgfjaEK0aOHmTlee58476Qb3E9RqsZ8
 akCqzPJEORYABCzkvapVTWAVH9l1I7kHoaxmrquiIbBmIjQv2AYYfiHyf6EELKflg6KIuY
 LrkKc3jePLqFPQiyxZX7r9nv9wS3uWUn+GvbW7/xKwHVxDpAB1QRdV5cE/iRW5zPsXBMKQ
 6iv4nVmIoTdjcSF5SNt/2wcV7rGERb2nYe1+u7cIQNryaoF+guLWJqnkneobObS0OH3JXK
 oI8z2w2xXe0GGaO+ErZjnwtSY30iVKRAlHkHK2cuhOyDD5TqTyqhYEXqmz/y461ZbbJ+R0
 szh+US72YMA7Gb3Lt//BKGiqiE/FFGEhzrQNdC7lA1rvMALvenJSxXRaP5nA
X-ME-Proxy: <xmx:LFYEa4M-1yGicStKiik8ZfFIpf7W7IqnkmY-u34ddnWEaJ01rMKgIQ>
 <xmx:LVYEa6qIOXlkpZtGjE5dSiy0LLJS_RWzqeb_3Y2XChsGDuOlJrut7g>
 <xmx:LVYEa7vtdOcQMHxce_1fiG5RIvlm9tVjb2yMYaQFjj4hc-JRaUKiZQ>
 <xmx:LVYEa50S4UhSy6wOefZL9Vmcc2uLyJZprZnBehqevfSHPRTN9F_z9Q>
 <xmx:LVYEa9ibJcW4zyg7Pto2Fe_bpF0A-i7YPNOTbcbrVJ0gXNSMVvSgVndB>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:05:15 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:59 +0100
Subject: [PATCH v2 12/12] hw/nvme: get log page - fix offset checks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-12-4c9893537cd1@samsung.com>
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

NVMe Base Specification 2.4, figure 206, the definition of LPOL
when OT (offset-type) is 0 (dword-aligned, byte-offset), case C:

  If the host specifies an offset ... that is greater than the size of
  the log page requested ... the controller shall abort ... with a
  status of Invalid Field in command.

Figure 204 covers a requested transfer size larger than the log page:

  If the host specifies a size larger than the log page requested, the
  controller returns the complete log page with undefined results for
  dwords beyond the end of the log page, unless otherwise specified.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 2532b23b4f7..78b13490212 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5389,7 +5389,7 @@ static uint16_t nvme_fdp_confs(NvmeCtrl *n, uint32_t endgrpid, uint32_t buf_len,
     fdp_descr_size = sizeof_fdp_conf_descr(nruh, FDPVSS);
     log_size = sizeof(NvmeFdpConfsHdr) + fdp_descr_size;
 
-    if (off >= log_size) {
+    if (off > log_size) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -5457,7 +5457,7 @@ static uint16_t nvme_fdp_ruh_usage(NvmeCtrl *n, uint32_t endgrpid,
 
     log_size = sizeof(NvmeRuhuLog) + endgrp->fdp.nruh * sizeof(NvmeRuhuDescr);
 
-    if (off >= log_size) {
+    if (off > log_size) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -5484,7 +5484,7 @@ static uint16_t nvme_fdp_stats(NvmeCtrl *n, uint32_t endgrpid, uint32_t buf_len,
     NvmeFdpStatsLog log = {};
     uint32_t trans_len;
 
-    if (off >= sizeof(NvmeFdpStatsLog)) {
+    if (off > sizeof(NvmeFdpStatsLog)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -5545,7 +5545,7 @@ static uint16_t nvme_fdp_events(NvmeCtrl *n, uint32_t endgrpid,
 
     log_size = NVME_FDP_EVENTS_LOG_SIZE;
 
-    if (off >= log_size) {
+    if (off > log_size) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 

-- 
2.51.2


