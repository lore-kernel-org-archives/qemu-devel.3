Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455E606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=l8MXO5SW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bwiFQqH+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4bD-0000GU-W7; Mon, 16 Nov 2026 16:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4ay-00006B-Al
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:37 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4av-0004YX-J2
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:36 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 4803C1D00147
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:50:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 16:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1794865829; x=
 1794952229; bh=/VCVNlicp/qsiZtPhJ2t+Y7bflupiFpucmyrK6BZl8A=; b=l
 8MXO5SWizga8hoIZOjmu9CSYQod7Fbdb4Ccnii0YM7Nm+AJmKCedL+G83D81QKyO
 YaQaH3nhmTOG1c2RpDLVatAFBnAsKCtbliBU7dCHKpQoxPTYxMobe/XINrQjUWo5
 h6b64fvhpuMlvmL0B06b3VtRahxwVMP74iG6H3D7qKqAyACRSqxVA5nte9b7lyyM
 8FsMk40wS377BIQf89tC+B9XKGmSrFN1+oHgVlp2LhLeJAfmTiwmBYYPeaCTD0AW
 7I559IOfujkheMbjgX5MbuLA7zaaSa2xORRvw+/VC3gsCooJVgT1xg69yRvAinrd
 f/ZDqpthsGaALIksmOMAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1794865829; x=1794952229; bh=/VCVNlicp/qsiZtPhJ2t+Y7bflup
 iFpucmyrK6BZl8A=; b=bwiFQqH+4eaGJMZLgpaGPtsPEEY3Ey7Rn6s9Kl0WjgyX
 kJEPlNpJxq/aAs6ik/Wrgy2jQsum7MePVVQ7JCgOqTrO+96yrjX4mFRm9Il68sYP
 l2pp1ZOLW1qUykTi4/fxqh8DRZJWvM0BQLgutlGQATRshBJL0NOsSNV/CnLQBIfX
 Sl60I9StHIuRNyoNS+zc4xKlg1cKYpUzM6jNBy3up7UrAH4pUGJOty2J9v4bp5Ph
 2F9+auhr5az8JSj1mbIe4Y0EKhhyK49IRyfULY4BVCp5HKwUHPo1Hf7kqXBQMW6Z
 ZQKeKEa9DtzTnQiCp7OVIS/aKoC78YjK11ZL/m2lxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794865829; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:T5vckCxgJIuD1DgvTb8R8sI6gjWwHbf8huygQr8O/22AmTQ
 2GvM9kDtkaQts3FulKK+XLvPzjEba08NMnZLuOXdKoXcLDJ9hT+6PnJz9SnhXPC1
 ijJi422QvH0e9r4OufnRIHKRtDaGAYdR8vNOWhydJGdoVD0ugIW+iy0+OAgDBPXX
 OtAB/veg7ANfUjzZmIYFU8//172CeMzfdcNYRYEnm/TkViMJARTqkErj4qiLKhLB
 E4GOVZF2+avqiJRfS7/bWWLSHL9+duRNkKDIe3Xshvi7EeJ2Agf6WdXhQCramtmn
 q+S9x9rKKLYAQ53G5NKln2s712jzu3mwmIhnWwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:QwtoOK/a5fVEgKeG04zR300H9woqTrI2CqPcAgfZBg0=:D/at9NL5crMo7uBFFpKXwxdxbpwZay9XXWbo3809VtY=;
X-ME-Sender: <xms:pHr7am3LEJM5sIXWdklC7wE24tM8__j8kWS0sD-0oCwOiYS2twFvgQ>
 <xme:pHr7atZ2_mCEhUxCl4ee-MtJM8Rlc-ygS-wTsT0Vqni8Gi_oge2NtT1xa37d7k1Kx
 O3BWjVVK0y6U_-wkXNOJctbXCvvXaVs-TDTts6c2mM3NA-CYSnxB5iK>
X-ME-Received: <xmr:pHr7auCP-eeQ282ttyld_GiwNUXs5LLpF85rwyQVe_6v44texh3d175icHyBMt0Md0P1Nlzqm3XOvJQzpDUh2YOHvwG27cbeYdkLIGjAGkId0dOqqjxoizMU6Q>
X-ME-Proxy-Cause: dmFkZTES8D8xSt0srsgoFMWwIbV8R6jWfsmXgno/I711FmPtBCJAndVyZGwfjwErKV/Hj0
 XCpRm0Dt9B8n+YucMWDdenSzfQ8YTNMCG5F9ret7bAuTkgU7yzglczNXVofCTxheKEsyn9
 ZS4g6E9Z0vHM9mlUqCKWIO7LvXBSmFv35Ijx8kcyLvz+V8LN54Rhnv5TKQjoJHWP/SRCnI
 RnrWtshHm2CdRL7iGy+FwgQKc0tAGKKg9aKoRjJOVvDPd4J/KaLRFea5EynZsZBGI/JDfD
 gMO/COVIRu5wVDOXIz3+YSbKfo3fWxSDy6OHpNJoNxvKRKdXG/yvak5jNZ1+lr6pMn9VHt
 6fobhD00EGyQAloNnz77Tt+co4yJWvIpRr88AF5fAm+h1V1Lmeba5kngTJho+s0z/6GduN
 DkJGga1c+l5zHGX+R2YWJZAdt8xIcOIWWVfNKnG2XcyAl7XtL4M8QdY1FMjRpSirKFALF0
 8Ib+qbCf3tNMNAd+OPuSBbHSLeVk/4utII9t3mKChlvMJ+b5aQl4U9sPAEnPCIKt6aQiLN
 NWHSbBCD2WImPR/H7pmn1OSgv8xG4co2uk3yHt8qsvvjmawFBdEMWo3dhLi8/SVnz3/LJn
 4H7A23aEOP9hfr6l75+8Ga8idc+pS/ztjsDrR/lW/rtZNTdnMsYcWu+6sdRQ
X-ME-Proxy: <xmx:pHr7av9515BM5lVh6DvqERvYl6acZk7WiktaNPQ_bbLfQqmHP3k3Lw>
 <xmx:pHr7au8T7BBdEVV1tlfM81SzvDHDUmR21LUo6Szf7gB1mMe7uJkEIQ>
 <xmx:pHr7ame6i9kL0tJZEiJ8lMpFaFRhbXbma2BrYHq_lLazkb5n-txF-g>
 <xmx:pHr7anFjTL2ff5oRcyoAU6e_SVAKPFIycnIiB_BwuZEVrJ7Or5OiNQ>
 <xmx:pXr7aro7epH4itb8yhUfCmUtNjRmuKVRHjokcy1Ak2w1VrKYSt2lIF5Y>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 16:50:27 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/7] hw/nvme fixes
Date: Mon, 16 Nov 2026 22:50:06 +0100
Message-ID: <20261116215014.59993-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit 573577bff0138681ddd4ee2410c51bead7b53e74:

  Merge tag 'pull-target-arm-20261116' of https://gitlab.com/pm215/qemu into staging (2026-11-16 12:09:43 -0800)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20261116

for you to fetch changes up to c0080f56036249df4a3f56e07e90cb0e56b3fd34:

  hw/nvme: fix broadcast fdp events handling (2026-11-16 22:41:27 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Klaus Jensen (4):
      hw/nvme: verify source and destination lba size for copy
      hw/nvme: reject fdp.runs smaller than the lba data size
      hw/nvme: fix fdp reclaim unit accounting
      hw/nvme: fix broadcast fdp events handling

Markku Ahvenjärvi (3):
      hw/nvme: prevent cq_pending underflow
      hw/nvme: fix missed CQ updates
      hw/nvme: clear interrupts on controller reset

 hw/nvme/ctrl.c | 24 +++++++++++++++++++++---
 hw/nvme/ns.c   |  6 ++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

