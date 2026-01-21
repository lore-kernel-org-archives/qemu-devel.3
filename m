Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D6C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viclv-0002Og-TM; Wed, 21 Jan 2026 13:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1viclq-0002C6-BI; Wed, 21 Jan 2026 13:17:34 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1viclo-0003JQ-GU; Wed, 21 Jan 2026 13:17:34 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 826B7EC0080;
 Wed, 21 Jan 2026 13:17:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 13:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1769019445; x=1769105845; bh=hf
 LoFcpr+1EXhaEg+WidTQFxVNkMO6iIO4arXOFwG8E=; b=IQ/tty1XVxi62ky23r
 2VQR5x7eABBo4u1l/fg8TcaYo2QZ2fnR1/tHD4a6RjU5s02oAa322ipDUraIfYj4
 QckH/Hf1ZkzPOKGRjafm5DbkyF8KYnb3wLElaeD+G7R/O0fx7f+7iQ2cRgYDgtla
 YkbHW2J/JJESiXM96S6ICgrefUId6RlyQajuV72ZdzeDyXKXeFSwa4bX9xByufq7
 Fe1jvmN3ymamXgnjzMbQZwwGJdmt9FY5Tbl/53oS21e37JD2inJCwFHUL0Ev/JrJ
 2uKhBk8BQS3efZ8qaHLupaPC+FtKrOHzABBCaX7v7hB72RXp7MG9OxM6T9i+B1C6
 XYjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1769019445; x=1769105845; bh=hfLoFcpr+1EXhaEg+WidTQFxVNkM
 O6iIO4arXOFwG8E=; b=zUmlz1zJVuVR9yaJN4Q6qAd3EMEXBxY9tKcWZ21w+GJG
 xZSomcMa1aqyEM4t0YvgGb5bTSB8Qz7uY3LyRJZu60XbvLS/aaw8Po4Tmc0OedGi
 N5OE2g8tIcr2j2ilk/s8j6gwWN/zB/BlZXPzcGwzQzf6ZSjPT+iyO0A0HqYe6F0P
 nzTu4utT1tIvv3yrJryEr4OlJJnTi38jAofGmN1wcjp7q/0shtygZjMEL8cjfF5I
 +tXY4x5BKtn/Eh1WpXHYQxm7eulsRgEKZwj1HKAulyCB5IUUsBq7vtbuNkFfQP6c
 82J6HkF5sgTG0gxSWJC+bOPzG+IJEcdmCe3rLX2tfw==
X-ME-Sender: <xms:NBhxaVOQL8BI8sGrG4j39LEPdEY3WxU93o74ev1Bwb2dHXwZxNEQBg>
 <xme:NBhxaQHXbcGApqbzxKE_7KIxDcKQBcF18raWW9aicktTwDuu3NLg-e_XK0nIJNP8T
 3LbvKWX7w9EFk7UuWjttbYyGOz2u6f6bosVgLenUwIrn1LJA6w45Xk>
X-ME-Received: <xmr:NBhxaTx_dOfdooJH_wHy1JRKh1mD1tjqSO3IywvGMLa1q4q1rEL262pEbDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
 ucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhesshhtfi
 gtgidrgiihiieqnecuggftrfgrthhtvghrnhepfeduvdefhefhgfevleehjeehfedvhfdt
 teeilefgheettdegkeeljefhffefvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihiidpnhgspghr
 tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvggvthhroh
 ihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhgvmhhuqdhpphgtsehnohhnghhnuhdr
 ohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgh
 dprhgtphhtthhopehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohep
 jhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtohepmhhilhgvshhgsehlihhnuhigrd
 hisghmrdgtohhmpdhrtghpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutght
 rdgtohhmrdgruhdprhgtphhtthhopehprghtrhhitghksehsthiftgigrdighiiipdhrtg
 hpthhtohepshhtvghvvghnpghlvggvsegrshhpvggvughtvggthhdrtghomh
X-ME-Proxy: <xmx:NBhxaRqTpNy3tcp8vFi5EZt_B8cRvbPWD_zBXcCDKKrxuo2DmIkukA>
 <xmx:NBhxaZkfJHOrEWfq3C1aezOWxd-l6FkwkIJTmHHOXAGAtuW6Q6YaCw>
 <xmx:NBhxabWJPq8IL_u1cq3wHxU8bIMTR6ZLXi9ud-Z2DjideSiCXOM6-g>
 <xmx:NBhxadpKH0-1qesFD4XAfCnx6Ea_yIBwa0Kf29-gDo92gfrE0DzJHQ>
 <xmx:NRhxaZXvR9yLA8JFv8_CiA_aTMupq-wBQl38r_u3FIBiGBBJXOnEQrI5>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:17:23 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Subject: [PATCH 0/2] hw/gpio/pca9552: add pca9535 support
Date: Wed, 21 Jan 2026 13:17:04 -0500
Message-Id: <20260121-pca9535-v1-0-164640e622ff@stwcx.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAYcWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyND3YLkREtTY1NdYwsDS3NzcwsjsyQzJaDqgqLUtMwKsEnRsbW1AMR
 yp1dZAAAA
X-Change-ID: 20260121-pca9535-3809777826b6
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=fAF6jvPN5a0yQcBrpyqUh0i6VvRkx3lyUdcxl9D5a2g=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpcRgySDDINlDuooglKaVeA11GqSV+1PDd3PT4L
 yfVJTFk9SGJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaXEYMgAKCRCrA0fMLQDB
 GZTFD/46CkjXZiFcKfxNoPA1YJH8DmvMD2F6NXWGOr9woh317sFm1z8yNgsEOkjypEA3dDBbKez
 NWb7SzlQb3z8aMomHkTUxc3aAVEzqfv0EuhmkcTc3gdAVu/fzozB2EuuKC95U57ECMwlMBgidrw
 NwPjJHf+Sqp37KSadeXeoFEtVBTSmnlC2VW0DTMcsQm5uWFpBzuoYVShtiHKEP8FOiTicsRFC2j
 dnQCemqGhmp71D1LKzApvQDWU2n5XRl4qxUN0rN+gjf3U7aP3nmpWJQYSopYKuWjD2VLfEAo2qw
 OmhgAEYRIxxlW4O2j+Ccmugu4DHYXI44Naw026jCuazxj+rAeRQ5VOXM8sBZX98ZceWa4q9LLyJ
 h9ZEPIyB/e8rBGl9XY8P64icX+RlXYoTac7RVUtggKh12rIZXCpdDXorfSi8OQpXXA/yZjB4UGW
 G+QkTG9uh1ZsHPR/AHgGbs2qHUZj8QbJzFaPtetFJqFlBdd6sAqb+KW4E3i7U0pYOrOizPcXJca
 fZpK/LdScFvkJJr1Z9S4AFURdt2rHS0VGeKmtul5AGc7apE016IHGQvNuZbyI+D7KuLYQwsmdUM
 tQEyXO7WegfYS4PEt9h1B7JnU90CcCHuMKd2JgwITkNmcqCoFG/XvNrUGpLVtsSPJbY2SWG5Zot
 ekrph5zrHM/v5jw==
X-Developer-Key: i=patrick@stwcx.xyz; a=openpgp;
 fpr=0460FD8A2E0B13D70D6EA241AB0347CC2D00C119
Received-SPF: pass client-ip=103.168.172.145; envelope-from=patrick@stwcx.xyz;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add support in the PCA9552 model for the PCA9535 and leverage it in
the catalina system model, which has a PCA9535 rather than a PCA9552.

We presently have two PCA95xx chips modelled:
    - PCA9552: A 16-bit LED + GPIO controller.
    - PCA9554: An 8-bit GPIO controller.

PCA9535 is a 16-bit GPIO controller.  I considered creating a new model,
extending PCA9552, or extending PCA9554.  The least code change seemed
to be extending PCA9552 but I could take another approach if desired.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
Patrick Williams (2):
      hw/gpio/pca9552: add pca9535 support
      hw/arm/aspeed: catalina: use pca9535

 hw/arm/aspeed_ast2600_catalina.c |   4 +-
 hw/gpio/pca9552.c                | 176 +++++++++++++++++++++++++++------------
 include/hw/gpio/pca9552.h        |   1 +
 include/hw/gpio/pca9552_regs.h   |  10 +++
 4 files changed, 135 insertions(+), 56 deletions(-)
---
base-commit: 2339d0a1cfac6ecc667e6e062a593865c1541c35
change-id: 20260121-pca9535-3809777826b6

Best regards,
-- 
Patrick Williams


