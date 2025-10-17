Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7B4CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mjv-0000VK-Bi; Fri, 17 Oct 2025 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9mju-0000VB-1k
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:51:34 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9mjq-0003qY-56
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:51:33 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 742AA7A0059;
 Fri, 17 Oct 2025 11:51:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 17 Oct 2025 11:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1760716288; x=1760802688; bh=d8ThCOKp1E
 NoLhh2RPhLk5d/WrRU9XTiBmUe4WE/eC8=; b=OTa/U7KUDGLkicEBWn1WCzA1ul
 EuC6IXweUJMXS74U/eINkSDFR+e8GsAZE60REFTZyI99wsBZSe+yhuurGvKmOgWM
 rX+YF/8LGGQ6h0C+jn5MVHSxSZOAtgZOvq4ec086tW7Bt6yfKR+yqo50u7xyyIVZ
 znTHUKbkSN1LBA6j7VWj89rZqbKf+dyM4D+yIZpcZaPj58c/kfuIwUDitSSJuLZ5
 HWpllokwm+dFXTHO7FFEuvtXmmTN/98cCMXgZRlsjC7fr0cqBvxnlMTnrbEjzRhG
 osGQVrbqubwrzg4EbzKRXDZA5mu0Hsag3vUigQg1ZSrUd6MU9FQgNonrZbZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1760716288; x=1760802688; bh=d8ThCOKp1ENoLhh2RPhLk5d/WrRU9XTiBmU
 e4WE/eC8=; b=w/FLH0DaQUGvNek6TkOQHLdUF8BJXWGj8cTEELw+be+LOjwFB+9
 fnRQfdDWj0sP/NNwX2HgYoPSiSS0IHXH6/HD8ThX5zVFiZadDvtqsY5AFHKN3BdC
 wx3/zLtFRrhzLjZbdrprWTtqZt7g4ZsZVUxQaeTBojUW86SzugSCnm36LSiVIsTp
 PbgcvaSbDtBq1NTyQw3EjPXlL1Uj3CETK7lSp/RC14ZZ/MmyRHhlOAfXka6ui+no
 SZFkjx4Gn8uzUO7KR/3rmaOE3gpekfOrAKGGqRQB987ldKA6BAXFrWfVSFp0rgKO
 ganC+EfRogEJt0JVufBProXHvmOXeeTZXQA==
X-ME-Sender: <xms:AGbyaEK8nY0IDEckta_3H4gEqCbcx5I7kUgckh0cWOMgdcX_pmy25g>
 <xme:AGbyaLBaUecnz3pw-Q01ZzA_EdeQhstb7gKG1wvjjbTAEFbyiv-UC_ZDlg5MrX0dr
 QsjQFltDwdI6pqkxqQ0lEGDCIA-TreLteOhQPhHPv2AHtHpHI0UM_g>
X-ME-Received: <xmr:AGbyaNBPcHLK4Dje3CefAO0WuffgMeGVLlw2gBhf1orAf5od3E-uF_jVQGd5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfetue
 fgueejleetgefgieegveejleeggedugfeuvdehgefhffduffeludekieevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslh
 honhhskhhirdighiiipdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpd
 hrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghm
 uhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvg
 hikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:AGbyaNAF6BpVhdynCvnHQtfSNDitjvzRCAYI4H1dGoVw857rv7KCYQ>
 <xmx:AGbyaIoW2do_kkqiv7PK1dVaAn2MnZHEVcs0gOTeSqa-EG6eYA5Pkg>
 <xmx:AGbyaHnu4q8iQOuA9vnhLku0cktc4IQUW9T_7lMo0FcvXBMZD_2Irg>
 <xmx:AGbyaIyHpeGkpM2DP_AzFsA511Bk1jFu5vCjJAteT00QsKyNYRePMA>
 <xmx:AGbyaIegg04bH0eu1kIRdCsv7-0wNaffYgP6AmWCL2bMTbN0UXrpqMFj>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 11:51:27 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2ee752b6;
 Fri, 17 Oct 2025 15:51:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, kraxel@redhat.com, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 0/1] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
Date: Fri, 17 Oct 2025 11:51:16 -0400
Message-ID: <20251017155117.1953708-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=2, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v4:
- Simplified CONFIG_APER_SIZE to use memory_region_size() per BALATON

v3:
- Additional style and comment changes per BALATON
- Moved #include "qemu/units.h" to ati_int.h
- Added data to commit message for additional 32MB RV100 card
- Fixed CONFIG_APER_SIZE for R100 to return half of BAR0 (as confirmed
  by testing of the 32MB Radeon card)

v2:
- Fixed CONFIG_APER_SIZE to return half of BAR0 for Rage 128
- Left CONFIG_APER_SIZE unchanged for R100 (half of vram_size)
- Improved commit message and minor style changes

Chad Jablonski (1):
  ati-vga: Fix framebuffer mapping by using hardware-correct aperture
    sizes

 hw/display/ati.c     | 16 ++++++++++++++--
 hw/display/ati_int.h |  5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.51.0


