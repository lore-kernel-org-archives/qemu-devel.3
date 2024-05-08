Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC80EC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h0i-000817-O6; Wed, 08 May 2024 09:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0X-0007rZ-LQ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:54 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0T-0006OZ-J4
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 6CD74138039D;
 Wed,  8 May 2024 09:06:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 08 May 2024 09:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715173607; x=1715260007; bh=jn
 GnVyVaSX82w74g6koZ59nwTqEKZcESW9WuE/D2ggI=; b=nFiBLxpvyseDsowuMg
 UoDaa18pk1m5e6C0fLDYmbYyIbQp2EbdCiIQaAxYumH9y5OVCkme2+s2i0NjZNrL
 XgRxmxjfS3So3Rhq/jGr4A/RHSoMoPukGCvRvBaBWn+5K7+1TIteHq8WP4HPD9Ta
 i39ZorN5IK1JJt2ucgK2k7XwOdvCeanuvAqGyCmTE/JobP6LXOmaMTr/SoFTJLnS
 /6+yYUTnXuxWMQduyWYtSNp9CpW9HBpmYN6isSgc+DMu1OeX6MUfPIK8OElQihk0
 ni9FcJmT08EhPzcpTIKKqciSh42yqN/7+PzizEGzfA/9I81PUjvFAZsahfu1HDSS
 FOhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715173607; x=1715260007; bh=jnGnVyVaSX82w
 74g6koZ59nwTqEKZcESW9WuE/D2ggI=; b=EOkUK31E2TP59Jla/HvRand+226kE
 JFphZ5sY3kjGP2ta5B1ibQJBpXx3OwBfzGSgDLJ+fuve984+xSHJ7uR9iYg94hCl
 YlsaWbmCkrMayjObiwyQWWN6x18Ism7aS6nHGdE40rqeeMtWz/h78f86TNEKrR2+
 TQn5zNANe3/enANO2OARiZ3fwZlnvXQHt8ZUbR/FK9zAZoEkXoUm7+6WZqjuTDWu
 VNDQLTOYxdLd6iX6gT5VnPHruTaR2PQWvVcSER4w3WJ0cCY3GIQvDg1TFr7rv5Cw
 ZkkgkuOvtQvtrmJ6hX2NMfcik/mDG3iPfcS6JsuU2CqT6pU/Ft2R8GXHg==
X-ME-Sender: <xms:5ng7Zvd1MVDI2AzKFZ7kXxpewTzO57AOygrdnV9ZCYMLomCrFARYDQ>
 <xme:5ng7ZlNAtc7hrQWwBtxtgIwImocmz-rXl1WfJU7ybaTJ2c3K6gjIXN_qnYAe8umXs
 qAnR3a5-cE1sGIabqw>
X-ME-Received: <xmr:5ng7ZohN2xj_uJkTc3oWb49T2O_VKqgJjeTU0YBWuEaTiiiycUyDygc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
 kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:5ng7Zg-fS0v_OUPS8hDh2zY2tBboGGvKo8rUEn9zqQbPqJGQRTqluQ>
 <xmx:5ng7Zrv3MeAUJOIgZ3aX0WX4N8eNd5NHijeaFZx6fgDrM0mJ_Z4BWA>
 <xmx:5ng7ZvEYI2WRhd45v5eDllIZiWaLIvamaSbGSwOluMnzywHJsmWYVg>
 <xmx:5ng7ZiO2IwcmGmJq_v7-zglFfp7o-E_q8wGyNvoyk2jWvV_dOqBR_w>
 <xmx:53g7ZhUTledTonjVKrpVdb4GcBKSff61_NkSVbWuK9mNCsxwWPj6ILwg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:06:45 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/5] hw/mips/loongson3_virt: Implement IPI support
Date: Wed, 08 May 2024 14:06:45 +0100
Message-Id: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOV4O2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwML3Zz8/Lz04vw8Y93MgkxdM9NUS8skE/NkEwMDJaCegqLUtMwKsHn
 RsbW1AJBj2iNfAAAA
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=RNpManGZDaFKesf/J/X1tS8+Fj/80EvRr5E7vS3L70U=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTriufp056Ype4yO18dHiTKlnk3qf9vSuNsWccSd5+r6
 7/Nd6zvKGVhEONgkBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIn4rWP4pzxVftrPNraFXueK
 //RfndsbGzvzPtfEkgv7LE82HJDhOcDwT2dNeNa29nnxM1L+F7PM+C0y133e+eibBWJz+D7Nfj0
 nhREA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout1-smtp.messagingengine.com
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
Jiaxun Yang (5):
      hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
      hw/intc/loongarch_ipi: Rename as loongson_ipi
      hw/intc/loongson_ipi: Implement IOCSR address space for MIPS
      hw/intc/loongson_ipi: Provide per core MMIO address spaces
      hw/mips/loongson3_virt: Wire up loongson_ipi device

 MAINTAINERS                                        |   4 +
 hw/intc/Kconfig                                    |   2 +-
 hw/intc/loongarch_ipi.c                            |  19 +-
 hw/intc/loongson_ipi.c                             | 411 +++++++++++++++++++++
 hw/intc/meson.build                                |   2 +-
 hw/intc/trace-events                               |   8 +-
 hw/loongarch/Kconfig                               |   2 +-
 hw/loongarch/virt.c                                |   4 +-
 hw/mips/Kconfig                                    |   1 +
 hw/mips/loongson3_bootp.c                          |   2 -
 hw/mips/loongson3_bootp.h                          |   3 +
 hw/mips/loongson3_virt.c                           |  39 +-
 .../hw/intc/{loongarch_ipi.h => loongson_ipi.h}    |  14 +-
 include/hw/loongarch/virt.h                        |   2 +-
 14 files changed, 475 insertions(+), 38 deletions(-)
---
base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
change-id: 20240508-loongson3-ipi-65e99b47c400

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


