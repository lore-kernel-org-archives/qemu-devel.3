Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B98C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr1Ou-00056W-Nm; Mon, 03 Aug 2026 18:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wr1Ot-00056O-I6
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 18:44:51 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wr1Or-00056E-Ek
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 18:44:51 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id C9A9AEC0198;
 Mon,  3 Aug 2026 18:44:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 03 Aug 2026 18:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1785797087; x=1785883487; bh=T0OXPcKTHt
 XIlM1YislenNZve9HHS3s70OdpUTe/Y3M=; b=6xEbVgVBLoWPn8135C249IbsYS
 rcsP3J2qsTH3DHVq80SJvm5IXeGu7usdTK778dYD6THDNtJ+x+0XE557XPEzKKQp
 zKPery3VplM4PQlKiK2IbhnBcDCV+0PfEv0g6zmoeW9KIoQKNnkVLi0BCNXFcKMy
 m1pcQ4QIc5sgbEDFYCivllp1bbk4MCI0vxWxK6Kv5anrlIsLjh8w7TOQz1RO+R5N
 phoJVlBXplihy/69+pGg/pWuT9v92vDkn72/vKMAC3oBBvko95T5kt/6rG+Q+om1
 xjyIRGJbSAitP8oOSN7fQaAjB+8eiZBAMMZ4CXHZQv4blBREtk1Kyw6afexg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1785797087; x=1785883487; bh=T0OXPcKTHtXIlM1YislenNZve9HHS3s70Od
 pUTe/Y3M=; b=RovHvyWPP6r42+nVTDGXudRsYjK5+MFAb20hJRSrYlJeyAym/ZA
 0dZI2dm/WZzTipZN4M5ooa0WOK00NHsd5pfKwgPYm6HP4dsN4yWCn651SxGUD5bV
 F2s+JaAUx5Pw0q9LT38XNbvB2pWn0FBX0EO6ETlUtB9JsuzEFiFrUvb3Zovj778N
 td52OcKgV1RWIKFNeiE0PpBlP/dKEZrymE7xTicv1p+rv9BjbmJUu6qkR48ykSGC
 M5frxfRVw3S7E+trYkx5yD8T0SWEsTK+eThr5K5vCO4Vqt5XSOdWw1lbwipPzezo
 NSKQ6hPEFOgeMkp8OYmyeKJgw1ZfAKlY7pQ==
X-ME-Sender: <xms:3xlxaie0OydlQv_-i-MDIZhYPvIeZMLPMbVy9vkYyuYriItcANxeIg>
 <xme:3xlxagiq0tvS9khD1vY9ugdoppzx645ybHiYGVZAredDB2lpSI5umeew6adTfON48
 TECkJ5znAiHJJFoGZYs88x_XdulPzd1foWo9ZmxJIud4BDS_02JLXY>
X-ME-Received: <xmr:3xlxaipIamiYdk_UXw7kodI-RH2KaffKHGZ-lZJmoWUD1kj7sLvmsdUS97gIQ-3f3RfthKjApdoS3aFMwCwBSR-DdwENkWjQQ9LPCugpbgyyfw>
X-ME-Proxy-Cause: dmFkZTFBJJ8ptpckixU4FgGD5uUi21Ve97eYwbtSUoMzdnYuBqVoF8kYPkdxu+xO8rTb9g
 +74x3WSIyxKhQ5pyYYOmA3/tUhpW+vGDwRbhBMsqcnxCSBIEEM3GQQeNVFXKobh8zTQtR1
 hF5ab/qwcxi//UaDMXggZXaffGcwpZ3Uom8MYnwLgpyZQfSG9VVdvEanpdJfQRgQ46OZJc
 5GNWQgBt28uvhdf5BvtPUs4zH63KdXE9H9DGM90mm7Rv6MPxv2uLOuSGXudmUrArOrlCdI
 /I8BGVCGFKOEFASwaw91XW1mBkV0hVT4sva+Znawa69Q5yCqGiZ0VfVaFdkvLQ1i6kHQYp
 haPdALvVK/uyCU1HX10g5eVNGJ2slEwMijanirZYOHMG2f1I/imH1FMX7bGTK9+IXdusVY
 soHZ2l7v+mMdeYj+u0sNo6HHQQiTyEtp28qlJel2w2n/rnDtFAehGrN2qfizLGDBdNQMlM
 nbNWGHJI0AsjROe28C07x0ZzRc6MGDXdmABxXHuffjxs+HH+XjjutTdDC6sCaxfm6yKwxW
 v+3Yy2Hce2zvfl4i5VkqHQH3iFDLLyhgfciA9QidbAjgj8pZbmTxgxTsTox52l++AFj5Eq
 BEjiaez5BTVu4E6jm84/QBLTVNlB5QEvaRMpkPbaYARGQwStRlNwv+LldyMA
X-ME-Proxy: <xmx:3xlxaoFtoJbweq2SJEeLK0eHIBZoEOSmuNuPWmlNuqH6WAYB4qwbmQ>
 <xmx:3xlxakmOGkqMADVYt-djHV9lcvetvO2bgnj8ZpKHvYzffR14ysxi8w>
 <xmx:3xlxarmuOsu1limBiCU3PeLPgLtaNKHzE8vf2SEsSIvvgAyqXLFRbQ>
 <xmx:3xlxalsW5CvVcRHDOt2eV61HJBDTrUMlFES_W2BcKK4GzQnm_77cfg>
 <xmx:3xlxakyKBKtbXypGtPA65BRFx0DCseiKcn58P0F304_b9R9cubnGsY0->
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 18:44:44 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/4] hw/nvme queue
Date: Mon,  3 Aug 2026 15:44:31 -0700
Message-ID: <20260803224436.38768-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit b428fe036233cbd15d37e3c027ab6ca4d3661a80:

  Merge tag 'pull-target-arm-20260731' of https://gitlab.com/pm215/qemu into staging (2026-07-31 16:19:04 -0400)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20260803

for you to fetch changes up to 7a34f7b8794b29cd1bd4dfa45f7d8e8daba7cff5:

  hw/nvme: fix leak on copy ranges (2026-08-03 15:35:20 -0700)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Klaus Jensen (1):
      hw/nvme: fix leak on copy ranges

Minwoo Im (3):
      hw/nvme: drop AER requests without aiocb in nvme_del_sq()
      hw/nvme: factor out nvme_sq_cancel_inflight()
      hw/nvme: cancel inflight requests on controller reset

 hw/nvme/ctrl.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

