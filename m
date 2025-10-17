Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F02DCCD19F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ln6-0006HD-Fo; Fri, 17 Oct 2025 10:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9ln4-0006GJ-77
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:50:46 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9lmv-0003Nu-96
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:50:44 -0400
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id C8C731D00176;
 Fri, 17 Oct 2025 10:50:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Fri, 17 Oct 2025 10:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1760712631; x=1760799031; bh=mhO6H9RRlJ
 wuX6vzu7spB8MO2HWQbwavivCot5bFUGA=; b=VzV9CGflJvzdiJ/uNHUE19gdgT
 syFZ+I885+0EZKqJdQ6dqBtFQErEJnCGAtCIT0A+ajYXemXZ6StXjqc2eEdyJq3o
 jCFsAIjfHG1dbARwHcsz5WNdmtkhUc5Aldcw0mriwhyAOt/qlYwmvlpQpSnFoCWM
 WHcCuwC2ULYUoVDE0m5gLlya79houzwkOk/k9zSsXIok88ElqfDWuFLNZxumuwBc
 v773VQ4omNvI4syQZFCCANp7nykhSg5nzUCEeQD2AKOC1i+quv465X5jnEI9lTwI
 lc3vC+o2QRnemKIkKoA89u7uwdZbKzkIkn6QAuyI5klSiOqxLDV4OQIlyj7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1760712631; x=1760799031; bh=mhO6H9RRlJwuX6vzu7spB8MO2HWQbwavivC
 ot5bFUGA=; b=N8OSkrhO/oumM5GvsvB22k9RoR5c/wkgRiV+qPJcXcyQhW8hR8g
 D5IrsfmK7b7mrXrvAVETRppQ9blH7FmCbuxZbDD2Gb+/KrWM7DpeW8IxBb8bLf+e
 gVtQXJpjBAaUfx5qqQMdusOjhGuR2BfZzTcN8nYh8WifJz0y3iAzCvxO9afa9oVn
 tLpnvjWTCPkt/VFBKS3wX18Ghggp0oUjcB8H/HQkyl9wgMn/dagMpzoyIC1RTT9W
 8I3MAEG7K0yrJG5dn9PN01p5zcVu8oWOTZDW7IxcTWxy4cZbSmZAr/yxjshq8t18
 V2+lW7gvoiySqaW3XWsgrcB6qlV8B/3LC0A==
X-ME-Sender: <xms:tlfyaEvyHjRmjZjNpaozYuEfn9OZTJZLghusd-Dra_WFP7_APq3O7w>
 <xme:tlfyaIVyLYGchLI81k2i8_ws23o8p2CRmL2vaVmmDKTqzZv0Y-0x78tr9oqo0V2A-
 H-bnZzNNyhPBi2-bXRivROPDXZfdtO81fmZY3wfEIP84H0DRL-NU4c>
X-ME-Received: <xmr:tlfyaIHT62Dj_HCduuuyF65feS-3JPOMkG5mL7uVaftZVeH6Aj7yB2Y38IV5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelgeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfetue
 fgueejleetgefgieegveejleeggedugfeuvdehgefhffduffeludekieevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslh
 honhhskhhirdighiiipdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpd
 hrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthho
 pegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehkrhgrgigvlhesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:t1fyaC0e_IIZfxNw8JFa_EN2kp-K_Z0Svx6PuEMaqptP36nVposm1w>
 <xmx:t1fyaCMEB1XNfrY_W0jI6rEku0SzTM4YzAcj-ewnlsS67WkZPtFfkg>
 <xmx:t1fyaJ6O9K_kJZ4gBxPaBsI9IBpivhSXIhvs3TeN3KM-FgDLcKJqIw>
 <xmx:t1fyaE31I3dBSNHECDlYRUqWNO0dlmuG6mQmhz_s96_v4T-1D2E3Eg>
 <xmx:t1fyaGwqgAPUNRBppLqfU6LoMH08Lel2xxNTP76KRAVNCpftqnUbULfD>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 10:50:30 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 7d7a9068;
 Fri, 17 Oct 2025 14:50:29 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, kraxel@redhat.com, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 0/1] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
Date: Fri, 17 Oct 2025 10:50:11 -0400
Message-ID: <20251017145012.1948363-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.148; envelope-from=chad@jablonski.xyz;
 helo=fout-b5-smtp.messagingengine.com
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

 hw/display/ati.c     | 17 +++++++++++++++--
 hw/display/ati_int.h |  5 +++++
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.51.0


