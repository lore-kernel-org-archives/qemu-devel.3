Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=lY9Q1ouf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ojHH6euK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRVb-0007Y7-Cm; Thu, 12 Nov 2026 04:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRRV6-0006qr-Nr
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:53:52 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRRV3-0003Vh-SB
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:53:48 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 192951D00154
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:53:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 12 Nov 2026 04:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794477224; x=1794563624; bh=fJtdIj9Kf/JVEVjNID2ETGsuRDVoRoNV
 vLIXZP4oXhw=; b=lY9Q1ouf/O+sb47mKV5PBOgBeXlE7EQt0q4uFxhM5+0MvN8c
 r5T4FtobDaoBh/TjOJxP+EHldMDi1kZORNUi1wHxTckc9enVz/7xgsCfeLzqgpQA
 KBE8BfVwwGKvGNEk9QTDP8jEI/hEcRvlkVTjeFblKYRd9dsUlTpiztQHZGDak1tX
 NHIzJt4IjBw0lVKgPB9gKpE9uxgCkTX6ksQv5wxT3f5yqr5LAlTuvVyRkqzniYR7
 ERiCqS/V4+PhYpqGRUaBRpWIbKsOqN9zwHK8K3gsSp4IcKcz1mTfhYKlKd+qigwO
 xnNV44tuXIFzk2atxBnpW2j+LAepDYZN6YY/mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794477224; x=
 1794563624; bh=fJtdIj9Kf/JVEVjNID2ETGsuRDVoRoNVvLIXZP4oXhw=; b=o
 jHH6euKXPXlaf6qqA7LVQr1Y3GHcRmPJITr5OEylkg3q26S6qv6CzBVtlrcuMuct
 s7FUe7rFT+AlfRBinySLIcasxZ0VSe5zailevHE8fWK/KKW3h7U9ZsLi8OGaRh7Q
 44VTvgWDtpb4ByqcOCPlj6ElJnqrdhyu5fOuE6FFDl2P5PuikZZ+4ys9m+12BDMV
 N4sbCGELPiMoalR12PwB5uIe8wjwDwfCbqP+fyihcsx5tRxKFm5Rgw+tfmp0fz/u
 Len8hG9FXb2m7hEfgrTYWuS0fJNezfCKYgKoehJ3NpULBZutZZOKNaplgCAXZ3f9
 UJg1CB7Zm/iWpl2yjIkNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794477224; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:jB5OQxl0TRN0weTOuiCvzt8KM5LmHG1MxZhRvxKZ0DE2rlY
 MpFHP/VOWKysQ3CBiwuAV+ALTNcZRwUIohCDuF2luHARvwIyNjiamJJZ1PbDQZni
 sgCIOSIvy0+AAzOWhyorZMy3WK3ccHoX7j39COGJ7G/3LrU/vjRh2cd5XJkoWhvD
 mADZBpzlsD/2pu5TjkrSRpK03+lVzQhSdaNfEkE4M+thJa/bx9V1Frg8sAcir1j5
 V8Vs3V0ewvraa+0gIA7kMF7V6MxwBCj90RIGVVoOoS2hrg0z5Qipg8lLfTK4a4pF
 kXKpTTSi97cZq6xvUtkPqBkI9qvnxtvHr22fOgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:YDv/k+7uYkxHRGlMmg1t9hsnfbayEGBOLcPPjjQuVJY=:8slmTa5VQeBTSG3iPQRdE99G4bwgshXUSaXmbc02Wxk=;
X-ME-Sender: <xms:qIz1anKZJqREac96Yh9nRv6f8IYxv35f8QicPHtJdqzbDmuni6ooGA>
 <xme:qIz1akEbYOedYYyiB9lQEgY-2uJ-p0BTh4-G45FjudgQcldQJldadmuG05ItG8SBX
 Zd6SKRvwhZibroY5GeMsDdYTKamF0cqsXZhUylOUnnhxPMeXA15v8-u>
X-ME-Received: <xmr:qIz1arRIjbA0Zb5JnWb5MPDjhd5q9VcfzugsR3-e-Aj0RZvj5qE3G0zOVb-0XBVtNVyrQezPOB3aHmrZbdLgoMQ>
X-ME-Proxy-Cause: dmFkZTE3CeDfcMEXDb1AO2Xbz4IACaczEsb3qSa1Q4Hq5FTVjJhj8Y9VBn1iru9ytSDqxQ
 bByCi1g0aPAEi6RAPMvZkKxXxE7pNoJV4kjOfetVk0p1fi9yf5MiEfmJDXIkWqWpm4bMv+
 OO4uSBDdldzUmUdepBUrUTe/Pm9mrxzO59S7KEYcSCiERlbP62OHVr2R5oBFtQdgNK67es
 D7xA9UI/auWEs87gNotTXn2pOSq4iVvixuW7Lhf4Ty2KIfCWpsglAzX7TFY5jWcQ6JSbSf
 5zwu33zGik0HGziQiq+8BQO1n6f+ZvaWgrckkCdqZSEvFcJkXakLUbk45KFNb96z+N9ETu
 jGdh3nL4FBUb8k2ekuo30L3SuQpojhoKe3+OrOrsXGj8e79R8JHt+EIv4BOkG8fF2El7wa
 bC2VRx/S3psIaZxij5qGOow2KehVKyoicG3f04LnL+vRAx+bB2klVC5h1D3wgzQgRLwnQu
 5auLD1LUHjf13LQRQcoFyDkFc0CwYBhkzL667bqs/tJvhyfPHDZPOqaMzfTDIH33OCvdOr
 r1R1II7UpiPboRSm1MBLBrRXTqqCLy0RUooA76eKf2xeFeFGCtaQkxfg6C1toqk2Rcjhww
 puP5JcHKzSFhJcCXfqkxO6BanWknd0fo4Fw2tmb77KtHJNC43HtYsRz2Ek4g
X-ME-Proxy: <xmx:qIz1agfu2jDSfxJpN1NfnE6kXkv64uAd-ZOip8jrLhlUzRlhPgEjHQ>
 <xmx:qIz1aqr9SEiAIjTuDZeCI45dMvNdvIltQ2rccciYev-uj4orUcIP6A>
 <xmx:qIz1ah8toIOGVZsjn3nYU08SWzhJSkCDvhPMbrc29g6KMdxAq60TaQ>
 <xmx:qIz1amffxtSs0ZqneItkHvd20tDp8RHBjsliXLYH0-X4bZDXCGi0gg>
 <xmx:qIz1ajtCmTT_a2phHdANjP7omHXajD8Oz8DmCDgAZHAh0e6rVxgdq2ZJ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 04:53:43 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 12 Nov 2026 10:53:29 +0100
Subject: [PATCH 2/3] hw/nvme: fix fdp reclaim unit accounting
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-nvme-for-rc-v1-2-69b3e5dcd5c8@samsung.com>
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
In-Reply-To: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=LSIutmp1GQoo2uZyYgGz5H8ScL0vI4G4gN22iL/D85k=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3IxaktMc3NreUVCUkg2M3ZZa1FjalZtM2JwCjJZa3QyZzlWZkxlSVRUOEQw
 dStOU1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcTlZeWl
 BQW9KRUUzaHJ6RnRUdzNwR1RrSUFKRFNKNXJRejI3allmbEZqL0RjZU02SkdXZnpucWJVcGYyMg
 pseWJJQWhPZ0N1VDRIYk4rUU5lNEUybmFlSkVGeHJ6SlYrRDlFbzlTVFRhUDhtcERFd0tKMEFBL
 2I4bllqMDFUCm95RzQvK1IxUW54a1NLQmhhaHJmWHRrWEJWU2pER1JoK1pVSURvU2VKZW9KS2p1
 L1NjZGRLSVEvVnZONEN1cEgKTlFyVy9qN0dDZzExS1VzME5QTHJ3c3BwY29tZzgxc09paEk4S1B
 EWHpqVWZDUzlkQmZ0cEoxOWZ4UFNzRGdDbApjWFIrVS9zTUxHVFh0amczSCtIMWJ0a21QQzdpN2
 p1NmhjdHhsTTBkR3dEejZBcXVxVTd5eVJKWGptU1dNMVoxCkY1SEx1Z2hXOERpWFN1c05YOCtlb
 Gd5VHY0RUN3Z1lWdXIxM2k5M0t6MDlqak8rZmlrclJPS2ZOCj1HbnhaCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
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

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
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


