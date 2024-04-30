Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AAEC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1rMu-0002Y9-NQ; Tue, 30 Apr 2024 13:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s1rMs-0002Xg-EL
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:34:14 -0400
Received: from wfout6-smtp.messagingengine.com ([64.147.123.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s1rMq-0007vt-CT
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:34:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 9D9FB1C00143;
 Tue, 30 Apr 2024 13:34:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 30 Apr 2024 13:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
 t=1714498448; x=1714584848; bh=WeGqWSH3Ql0/UUTBACI5OChTrfYb4YhZ
 sRvfkZTj+GY=; b=3mxz6f6jog5W03cvLHlsE62OdCF6yTK7DnZsWlz4oiBYheIC
 BGiNKTMAeATtTaWcqI5M0xLm4n3U4FkOqXRx5EQDwMu/XGMI3kAbfE6xSUKzZdBd
 KJ438xgkvEE2DJ5SDWUKb0i8A56Xshqdql0QY3yPj5YvmWuzTdzjOnyMbJnnkTTE
 aehk4RzU1zdAwACd6UGfYZwQWYHixFT8h2IX85wv9vyh6kiGk9yiMSMrQjWk2zzl
 +51jtbFOPVU3psNoXqC7H/IciRHXS0c5czKd86OcvhFyvzIge5n8oARyNz07j4eD
 3mismrEkMKu6FYyq30//02PbcotovbpvBG3ifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1714498448; x=1714584848; bh=WeGqWSH3Ql0/U
 UTBACI5OChTrfYb4YhZsRvfkZTj+GY=; b=BlAGQGxPcVAIqPrAY7EpvB5jgY+pT
 NApxQ2P16DZm3WVJQUZDwi0tfB5DKtwNlSk99SSOW/pQHchkGHAM2oB5QRqsc2+3
 YVEOQTtTDL2w8CI+K4NvwqxhJ0s/1Tc1bCODmUX2NPDwGHsEj/8/vREUWMjX+CTS
 +npZHNk5bCpqL0z+/0QY0V949nIgMs8X/S9HXfdFaiofq68u1piJBt7Yzdw7utRl
 aqLHcsNLreGOX+/Xo8F45NlVpqDrCgZqlXUPO/V89zPNGhO7Tvw15nZqq4V4enUk
 92d8kUdNeXAeK6DDBzVI5vfcCXW3Jo6eCh4Hiu4/dIQzvcvaNL/5/7VZQ==
X-ME-Sender: <xms:jysxZh_iXHNCNw-YZ_178xJCRxqRMw0CfkQKZ2NqSl3RMtXPTUFY8A>
 <xme:jysxZls9PjCLW77qf-tAkihNH3MZbZSxAdw3EJj3WYr0edZOfDGlsZ_nXlnTYIrO9
 c6o1n0yLuKkOQ>
X-ME-Received: <xmr:jysxZvA55OYHasHAIBOAjn6YAOWBk5gXkiVlyoRuxbY6D5vC7MWIUATfFIgOTHtlUtxfG1BO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedguddufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtke
 ertdertdejnecuhfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgv
 tghkihcuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeelkefhudelteelleelteetveeffeetffekteetjeeh
 lefggeekleeghefhtdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggs
 rdgtohhm
X-ME-Proxy: <xmx:jysxZle3XSnMXMNlz8AIbf-k_UyJDQHpOT7nmf03YRpTpyj9jaU1qg>
 <xmx:kCsxZmP-FoKIO7KJgKiCh0H8Ue097ceU_wQstF7mdodvUmAM0FVs6Q>
 <xmx:kCsxZnnegerD3GUl1oACQ8WVRvOPc1imIkG80drZdAqL2CqSGobLOA>
 <xmx:kCsxZgsBVv9F1WUQT6vOxC88qyRDRhQhapig1l5tWiN-khb7cOEqog>
 <xmx:kCsxZo223S0O567oFT374yn4_bTr5U-fKiiLzRESKPLg_UIoTbtSEXPh>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 13:34:07 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: [PATCH v2 0/3] Fix MSI-X handling for Xen HVM
Date: Tue, 30 Apr 2024 19:33:08 +0200
Message-ID: <cover.ea761e8c87cc41550b01d6fbc1cd1116af55e288.1714498385.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.149;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfout6-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

This series fixes handling MSI-X when device model is running in a stubdomain.
The main part is to avoid accessing /dev/mem, which also fixes running dom0
with lockdown enabled.

It depends on a behavior change of Xen that was just comitted, and signaled
with a feature flag. If Xen is too old (and XENFEAT_dm_msix_all_writes flag is
not set), fallback to the old behavior.

The other part is a fix to enforce read-only registers in the config space.
This fixes MSI-X setup for iwlwifi Linux driver, as it happen to write to MSI-X
capability id reg (as a workaround for some older device which has another
register there). It should be no-op, but due to a bug in xen_pt code,
it broke MSI-X detection.

All those patches have been shipped in Qubes OS 4.2 already, and prove to fix
the issue.

See individual commit messages for details.

Marek Marczykowski-Górecki (3):
  hw/xen/xen_pt: Save back data only for declared registers
  Update Xen's features.h header
  Do not access /dev/mem in MSI-X PCI passthrough on Xen

 hw/xen/xen_pt.c                     | 24 +++++++-
 hw/xen/xen_pt_msi.c                 | 94 ++++++++++++++++++------------
 include/hw/xen/interface/features.h | 17 +++++-
 3 files changed, 99 insertions(+), 36 deletions(-)

base-commit: 2358f1b60f73287fe606c7ff48043b4f9e1c2d0f
-- 
git-series 0.9.1

