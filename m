Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD09C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEgBP-00036C-Vv; Tue, 04 Jun 2024 22:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBO-00035p-L2
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:22 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBE-0001g2-Hl
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:22 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 768BF11401FE;
 Tue,  4 Jun 2024 22:15:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 04 Jun 2024 22:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1717553710; x=1717640110; bh=SN
 KXhbiUVAnz0ErwxbQb/8TfryExTJRdos1qriS0Yc0=; b=tNTmreWsM5c/Jf6oOT
 tvZ5Lb5loxd8vN+ONEjYm7JfNzCMocube76pO2H3i9SIVL5nQClIfzKrINK8uvH9
 swzQ4v+JSWLYxi1T/r30/oD4tMZagrDLhqxJ0sCrKCJfUrLYzawGkvkKlMj/dpMe
 BaDr08iCoEGHb8heO9Ug8qoDgGdxJJc7tJ0O+3TsvhQz6IOTG8lofRwqVcqE0HiZ
 TFnCI9RMr32MsYoq7Gsd7E48QH81Wy/O9bQFjcmq3ryROIyJ1vlbRX/ppVEkBnp/
 9l2fIry9VWS3aOPqFfyi8MEOOLNz4et/XQ7ZRK5ilUWMEdHK/aB1VdVYZSmbvX2u
 go+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1717553710; x=1717640110; bh=SNKXhbiUVAnz0
 ErwxbQb/8TfryExTJRdos1qriS0Yc0=; b=T90R81Qm3f2QI4m0WtPvfmhxEL1fz
 jFWZfg6eMbVtG/SMA07RyS6WZD4vKggcH1AoJkfFO9dHaS/p/+vInhuzTUprX1Qb
 p8lsOfVcB4MNLJASRFfgWqSA6NEF80dWLMhQc+2LxU3B/vk2OEIDLoBQRd7H3yHS
 2U4TXsQDEhBWAPod4RUWOQtCRxaqFCBAOAv4qtRIyp+Aol0K0C1pG0gDBNvFh3UL
 mK1Mt1Es17OODq1YESFMlNjZYiok1EXM50R2EwXnHDCAdOdkFILJzkDIgkOdO7GJ
 L31+6d1hUvsr8PO6vt3beFpnjTsPDdjEU7XASV/xBhbqoWzkk1ZvnO0Qg==
X-ME-Sender: <xms:LspfZjd-Cu4RtVlbaYBc-pKb4F6P5NrqRpxglJuchy_ILFjS5BdKwQ>
 <xme:LspfZpNDhxxi38X8a5xAkCrKh6sNEjM2POjGuxe9gBi1i4IBi_SL3RwgwejLDRLGn
 MD3KxUSZzMdGcoHIY8>
X-ME-Received: <xmr:LspfZsgvMmkXSk8w5ISRyIKA7BxAATI-cNX-XkTWiGfOS5asEXxvnRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
 kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:LspfZk90j6IhrKM4vPxKctS4GXfYQuxqDMka4ooD9vUpX_JI1sEvQQ>
 <xmx:LspfZvtDqxCaGzMObuEeZM_A_2BUzTIP6ytwegINH5wYkoqrRG6qmA>
 <xmx:LspfZjEQSs6w7LsVw_rUYpFE48lR-v3oUGl0F9qgR5RdSmOt2Y4VIw>
 <xmx:LspfZmN83j2mAhqVBRrFEu5zW0zmRDfTn34ZKbyp93GrzTIDFadDYg>
 <xmx:LspfZlXk1F6fs-re0Zg1NQ8u7Z5fjSzuhgTyRGjr45lJUOJst9aCsbH_>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:15:09 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 0/4] hw/mips/loongson3_virt: Implement IPI support
Date: Wed, 05 Jun 2024 03:15:01 +0100
Message-Id: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXKX2YC/3XMSwqDMBSF4a1Ixk25xjzUUfdROoga9YJNJJFQE
 ffe6KS00OE58P0bCcajCaTONuJNxIDOplFcMtKO2g6GYpc2YcA4CCjp5JwdgrMFxRmpFKaqGq5
 aDkCSmb3p8XX27o+0RwyL8+uZj/nx/ivFnALNtWqkUsCl5Ld+Wgenl2vrnuRoRfbxEsSvZ8l3m
 klWMgOFFt9+3/c3hQ7GE+wAAAA=
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=y1/h26XzpLaULM4DsJoGNXkkuCWva1PEViGeaeF/HnQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT4U3oakQ83eDEKR2fc73LcIfVEd/q+Lj4uywnFW+fvn
 5rFNKWxo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACby/CnDf0d1zk01xyPYlizk
 ki53vLilkOv9j6B90y4cKmxceK00tpaR4brHARe7vz8LU6TTcj9zXTGfHWrn6ly59Mbl+1WrD7y
 y4AYA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all,

This series enabled IPI support for loongson3 virt board, loosely
based on my previous work[1].
It generalized loongarch_ipi device to share among both loongarch
and MIPS machines. 

Thanks

[1]: https://lore.kernel.org/all/20230521102307.87081-1-jiaxun.yang@flygoat.com/

To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v3:
- Fix up sign off lines.
- Link to v2: https://lore.kernel.org/r/20240605-loongson3-ipi-v2-0-da26282e03a5@flygoat.com

Changes in v2:
- Add a patch to remove loongarch_ipi.c (Gao)
- Change iocsr alias owner to CPU (philmd)
- New patch to remove ipi_getcpu
- Link to v1: https://lore.kernel.org/r/20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com

---
Jiaxun Yang (4):
      hw/intc: Remove loongarch_ipi.c
      hw/intc/loongson_ipi: Provide per core MMIO address spaces
      hw/mips/loongson3_virt: Wire up loongson_ipi device
      hw/intc/loongson_ipi: Replace ipi_getcpu with cpu_by_arch_id

 hw/intc/loongarch_ipi.c        | 347 -----------------------------------------
 hw/intc/loongson_ipi.c         | 120 +++++++-------
 hw/mips/Kconfig                |   1 +
 hw/mips/loongson3_bootp.c      |   2 -
 hw/mips/loongson3_bootp.h      |   3 +
 hw/mips/loongson3_virt.c       |  39 ++++-
 include/hw/intc/loongson_ipi.h |   2 +
 7 files changed, 108 insertions(+), 406 deletions(-)
---
base-commit: d67a6e054b92e5e1cbb7b0bd5782a670cc7f0df7
change-id: 20240508-loongson3-ipi-65e99b47c400

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


