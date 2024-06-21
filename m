Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04032C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdqy-0000o5-0E; Fri, 21 Jun 2024 08:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKdqw-0000np-Df
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:58:54 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKdqu-0000xk-Fl
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:58:54 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id 9546013801CA;
 Fri, 21 Jun 2024 08:58:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 21 Jun 2024 08:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1718974731; x=1719061131; bh=4S
 LyMxhz7plYrPfPBJgzVFI76T/wlnyp2pwLLAy9oNo=; b=D9upWGXwbpGZBhEcz5
 E/ICVIhYdZcvSV81CwQAzmodTeiuySM+suCb4M/dVGhRA45oa3BGOkcjaQ8FsNAW
 rNf6hjB8vaBtCkFDgDBHO9ixo3c9obatF5sZrCcTN4rTkmmgmcFBIGUpSs+qZFed
 XJsOxXjGABIhvZGsJoNCHna/gs0IHjUUY8CjWQzXxDIPQBY/iOy1RpfksLC5YElH
 AP/scUvZHduNgqf0LuTROb97qBiSm79im0Yxu7XkgT2Ipo1tf4K6O93uIRHSMwbM
 QLXs+AeHCdB1Iz/639ssFLyo63No94P/2GxiFxfNudJw3TrxXvjkYLOYwWxZAD6K
 k7YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1718974731; x=1719061131; bh=4SLyMxhz7plYr
 PfPBJgzVFI76T/wlnyp2pwLLAy9oNo=; b=QF1ss8VxH0P5w7Kk5pNUe9zvjFN2x
 malfnc2tgVO+PWY7u9Xr06gsCTl2VfeePQE45xlNC+vUF92/TVyKRrOaQAMd9hRy
 EPn/lsanrddF0d0wDuO5ub6Ulel1RrOE/YtTDGCVUx3B3fS16eRKmSBS5xPICvzW
 XstOf4yZ242nc0ikQXXQ8XMj9QfKtJE9/JhatDOgaqiu0cRPtB7SNdouowQhPeIS
 zRz5mt7pbHYVGop2GaFOpbYkGYvkEP+2tBjkudrzHsGYrXaJMnHhT6Nb40WOmIwL
 hq8889/VSMssh+uATFcoQG6I0oiQ9IDPFow83EbNQq3Nm5E8q8fwIx2Ug==
X-ME-Sender: <xms:Cnl1ZoBD3f-BviZ_0lD8RjAZ45neSBvZKijrAzEMf4oqLQ6VTK3v_w>
 <xme:Cnl1ZqjZ0D3tGBBafkGJK_UAwVW2GkHOujch7ZsFQy_NiIjruyJ4tm_IJoguLbApb
 8tEa74TrleE6O8V5fA>
X-ME-Received: <xmr:Cnl1Zrn0uUPGPib_53f23dS_TrgoP8BXYtsCNsfvm4nalOsMjRxO0vM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgheekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeetfeegieeijeehfeekheek
 veduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:C3l1ZuzUejWvVgCM-xYxbhNRzvZ8UTMYNFM-ZVxc5RyVVnh5nPACTA>
 <xmx:C3l1ZtR0bE4v5jEOaN9nECVF_VlMOrmCQG6FxH6yQWPm-q0APm2inw>
 <xmx:C3l1ZpbSeuFAbXFPtbNLzMZg9oSYMMnx-ipYE_FZB5fNDn8-Iuj0eQ>
 <xmx:C3l1ZmT_YwPz8FQ5_ocGXZoNlaE2zIi8A5R7WTlxTEWolyWyXefrbQ>
 <xmx:C3l1ZsGIIvNL6eq6Q6KX6nFVgimKIKy3f7EA6YsWG4WCWhHut6LL5VNu>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 08:58:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] MIPS misc patches
Date: Fri, 21 Jun 2024 13:58:40 +0100
Message-Id: <20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAB5dWYC/x2MQQqAIBAAvxJ7bkEtwvpKdIhabUHcUKgg/HvSc
 RhmXsiUmDJMzQuJLs4ssYJuG9iONXpC3iuDUaZXg9EYRKLPEjvkk9FJCHKjdv2ox6qtNVDTM5H
 j59/OSykfT8sYKmYAAAA=
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=600;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=hL+9adEfuSq3Edujq1XN2Ap29z4ZNpFoqZTthuhoy88=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTSSq7G00cmOzx5b9Zi1XpepVD3BXPdsmj3poKn7pO1B
 VSU+V52lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwETE8hn+Ci+sM955PFx6+txX
 T+QFEjZqpoUIr3187fYPySs2p1VMLzEyfOeXZuduSZnWvPzIyln3qjRWvbEMM2BfLP7T4ZZQw4R
 kNgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout6-smtp.messagingengine.com
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

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
      hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection
      linux-user/mips64: Use MIPS64R2-generic as default CPU type

 hw/mips/loongson3_virt.c       | 6 +++++-
 linux-user/mips64/target_elf.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 02d9c38236cf8c9826e5c5be61780c4444cb4ae0
change-id: 20240621-loongson3-ipi-follow-1f4919621882

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


