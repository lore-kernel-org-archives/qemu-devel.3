Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAF4CCFA07
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlMz-0005iN-1y; Sun, 02 Nov 2025 22:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMw-0005hK-7x
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:35 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMp-0007zO-B8
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:32 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id E250BEC023B;
 Sun,  2 Nov 2025 22:36:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 22:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1762140984; x=1762227384; bh=rmvKMmdMMS
 /ilaQBMTlr3wNRIeSmPUkgT6FcHbPq3Lg=; b=YpNVK2ETc6E0iZEu5n7N8sxsO9
 5QaRUfWCfUMJjG36ip2u3w8HKhpyvMeO0X3+Jq/JacqGvG5WmomLRnI4NMUJrGTk
 d24WWfHWsW5Pjel8VTS+LBWDOkV/nTQAz5bRLkwi5muEn6fFxxqB1t92fKgULJcp
 ptQGqtANAI3n2ShXHYAciddSKLQkxz84tHCwrr2jnWCFAETsiv1LX2wjQ2cQNCri
 lPisr/PidLL+FtWniuMpFFrYIUKd7yHCrB8e0NuPw6evD5Qq4HB02HXxylOmvqil
 cTbghA9R8KsvcHkO920ZdSZ9dWf5ycqxlLobOPzP11VZDfq9R6SmJKvZqaTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1762140984; x=1762227384; bh=rmvKMmdMMS/ilaQBMTlr3wNRIeSmPUkgT6F
 cHbPq3Lg=; b=UyqQP05IP531KvSbNj/rAUvICQ06rHpA5wTt1e9eVZzVLAv7Pcr
 77VF+P4gIp9wHfE14eHOeAoW5lcMAslixj4Hoidvc3lVe7ueJSJe5Vl8InWjPIZy
 N0r+Qb+Z62ocV/6nfHZbs95sPNXfAvBCJrmojiiFgVwI8H3YsNlZPNqdiSi+vr13
 7aoVM6/2qi185DVfPUKu71mlmAXV/XHQ15zH6Wya7xlQK6+WajRSFvjMnuNyrm2R
 o6eFj2kIH7Hc8uWqnlrs/0xzdjsYoV+e0T3fm7AE1ED0FpPGaGQFQLUKl0jZ6Zr6
 cV83WH1RAN9tRveVrEc/XPmnUnq50rwHnBw==
X-ME-Sender: <xms:OCMIabJskrdCazS-lFsAhY7OE4Ymr8FCtHwOBZla0_7ErCPKhJ324g>
 <xme:OCMIaWkr6vglmc1cCi2PdRa-Z3dx8eOZZ8p2rQAQCnR3tKSJT6iQdbSw0-LTazlr3
 jw_q7gHUOFKofmMI4_WtePAEPUs6PigwuA_g2V2ejJz4SRFlNoarKE>
X-ME-Received: <xmr:OCMIaRHa_qUNyX6aTvdBdxkkMF7xTAlJ2kQ03iXwHjXNypMN1zOX_T-FrjGr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfetue
 fgueejleetgefgieegveejleeggedugfeuvdehgefhffduffeludekieevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslh
 honhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoh
 eptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthhonhes
 vghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:OCMIaeGi5FNE77fPKQRzBGp_KuaAd42ZtZpKpoH9TCFqvBrYSufwCg>
 <xmx:OCMIaWP7fNLBUN_Hk8PXhkIOb8rmKK8ciEnvAIubN4kcfG48I8UWlw>
 <xmx:OCMIaVF854zGNUNsUSsP6VABdRLnPRYiAcdiNE0dpUyxutjYjTTg-A>
 <xmx:OCMIaVO-vz6eRuRt5AQn0HUnlnyiV8q-OZhvFCGQI-Ne8z8JWCOIWA>
 <xmx:OCMIaVysBljB_drY0e0I2qh-4HUcszaxDvfzDGH9M9IEU4jwZX2_uZtf>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 22:36:24 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 69b9ac7e;
 Mon, 3 Nov 2025 03:36:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 0/7] ati-vga: Implement HOST_DATA transfers to enable X.org
 text rendering
Date: Sun,  2 Nov 2025 22:36:01 -0500
Message-ID: <20251103033608.120908-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.150; envelope-from=chad@jablonski.xyz;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, FROM_SUSPICIOUS_NTLD_FP=1.999,
 PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

This series implements HOST_DATA as a blit source enabling text rendering in
xterm under X.org with 2D acceleration.

The series builds up functionality incrementally:

* Patches 1-2: Scissor rectangle clipping registers and implementation
* Patches 3-4: Additional register support needed for HOST_DATA
* Patches 5-7: HOST_DATA register writes, color expansion, and final blit
               implementation

Tested with xterm on X.org using the r128 driver built with
--disable-dri (MMIO mode).

Changes from v1:

- Split monolithic patch into 7 logical patches as requested
- Integrate HOST_DATA blit into existing ati_2d_blt()
- Add fallback implementation for non-pixman builds
- Remove unnecessary initialization in realize (kept in reset only)
- Fixed DP_GUI_MASTER_CNTL mask to preserve GMC_SRC_SOURCE field
- Implement scissor clipping


Chad Jablonski (7):
  ati-vga: Add scissor clipping register support
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Implement foreground and background color register writes
  ati-vga: Fix DP_GUI_MASTER_CNTL register mask
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Add expand_colors() helper for monochrome color expansion
  ati-vga: Implement HOST_DATA blit source with color expansion

 hw/display/ati.c      |  77 ++++++++++++-
 hw/display/ati_2d.c   | 257 +++++++++++++++++++++++++++++++++---------
 hw/display/ati_dbg.c  |   9 ++
 hw/display/ati_int.h  |   6 +
 hw/display/ati_regs.h |  34 +++++-
 5 files changed, 320 insertions(+), 63 deletions(-)

-- 
2.51.0


