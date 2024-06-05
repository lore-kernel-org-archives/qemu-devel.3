Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148BCC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEg0u-0007Oq-LY; Tue, 04 Jun 2024 22:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEg0t-0007OM-5v
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:04:31 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEg0q-00076L-Ae
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:04:30 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 390EB11401D3;
 Tue,  4 Jun 2024 22:04:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 04 Jun 2024 22:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1717553067; x=1717639467; bh=9J
 y4d2U9vHoG6NJ+h3kJCPVfwr4w7I0ujBENill8wxk=; b=HmA58jHivnFAPUg9Nq
 fX797bQpTJrnHYsg6td3s9auSI9lBhtyrOcqliVzaO/WYTf+xj7e4Vlx+YSYJgVF
 DlbyLYOBshXrYzGJXQx4y+j8fy7k8j5hp3xR1zC/0EKMOGyoI7JnZ61Q8bNSjiKO
 QTpnPA513wDOqpk2trUVtb9YqoJI/l3hLP7pvwNY1TJ8QebnZOoH34E9GFsjMmuC
 BKJX4JgpMeq5Trqe0CEmvytoPssmJ1mnOjpI38vqoIFd8gJ1fHKSBot+wNqyUc5C
 OEyAFHV0Y3eDRuRmUQInh7KOuq+HLmiPa/sKmj93Okrw4oC+B0rDS0wZRtXTfThP
 5TUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1717553067; x=1717639467; bh=9Jy4d2U9vHoG6
 NJ+h3kJCPVfwr4w7I0ujBENill8wxk=; b=AvVZ8llkoNXR85rSxiP/qF0tOaIb0
 BVNWuQHS/3HSg9bS0fRqzdGxX9p4oOuWBOJjCWubXJPvJI6sHlo24YsDq80pTNZ4
 eb8gR9HSQtDLeB0oriqe2sTKbpYopFQZmBP1r9hJFTwIINeop1fTSiwfDjNFSIAs
 J+15aArZwJ1HZuZsU2gQWKty3ykWS9Gw1RZKY78f3/fWLLTZoV0wdaJNnyzuW2GU
 NBglFuJdajCeZFn0GLJxhnLsfsuXbR88qtFKg6RWswG7/rbbe6Xxe8Faajze9c9T
 qiRsI4Oo0hAuvamsO7YncnkTWzAWYt2ZTBPkaaOeIAm7B0EExg/e9ZpXQ==
X-ME-Sender: <xms:qsdfZl5OcTeg3Rr4kzGyQa-NbjQHQdgTEcrKC_Qp8dRidEdoUEiGCw>
 <xme:qsdfZi7uRHK7wKkb54kkUpJIQBFZQLXSn0ZHbQLVdOKW3ys15it9Jdn0LGVnauW07
 0748ISrcioWS1ONLRE>
X-ME-Received: <xmr:qsdfZscVHwMznIK-3q5AJDUEVBuvsU2UY0AXUZeLO7IeGCxLJ5DCLjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
 kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:qsdfZuJ7JCxo_MRfrxsYFgNuElJlEEsSgEEnZmQ7QP6X3-vzrAOkSg>
 <xmx:qsdfZpKPcf8Hy6iU82lbidVAQH9hcuFkaxbsVCMJMVw6j5r0PH2-Kg>
 <xmx:qsdfZnzp1UHmT0301yn6sHsW4P7zpoMivHxOT1zyi_yt88nbZQqOXQ>
 <xmx:qsdfZlJjx3ACutEu3kyug19506nV0Ut54BpnqXl-xCMmyjWr4ZqMig>
 <xmx:q8dfZnjHqpp1ybpBWhaMRwIepGo2kNrUuGdxVRdg7bROeTgJS38_7w-r>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:04:26 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/4] hw/mips/loongson3_virt: Implement IPI support
Date: Wed, 05 Jun 2024 03:04:23 +0100
Message-Id: <20240605-loongson3-ipi-v2-0-da26282e03a5@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfHX2YC/3XMQQ6CMBCF4auQWVsz1NIKK+9hWEAtMAl2SEsaC
 eHuVvYu/5e8b4foArkITbFDcIkisc8hLwXYqfOjE/TKDRKlwgrvYmb2Y2R/E7SQ0JWr614ZqxA
 hf5bgBvqc3rPNPVFcOWwnn8rf+k9KpUBRdqbXxqDSWj2GeRu5W6+W39Aex/EFBPxkO6wAAAA=
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=bRzoJxzFTfKJ3QGDH4Un6FjF8NKS3LzS1VyD0iJD2ZA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT44ysvPNl/nI/LZ7GycVLfg7hEngu5K0t9Fswy/n+sg
 vnqvXDxjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjInmSGvwISEo90Q9a1uHf3
 M7O7OS38u37rumeHFfYWH5z8qC1MppKR4eXKwwwmzbpqjR9TF87dt7vsZNepxtylKesnLJxcd2X
 fejYA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


