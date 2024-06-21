Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602E1C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdr0-0000p0-6S; Fri, 21 Jun 2024 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKdqy-0000oR-7q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:58:56 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKdqw-0000y7-Gm
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:58:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id E120313801AE;
 Fri, 21 Jun 2024 08:58:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 21 Jun 2024 08:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718974733;
 x=1719061133; bh=qJmSM1/+QGx4fJmM9mp+Dx7mU1S35gUOBnlt8xJMvx8=; b=
 bhm/ZD+6xfmp1P+uWvpDIuU19W6GER7CcEplKybyfBSjE1mS59rZsfqDOGj6x/6v
 sLs+cA49+0vJ6gjgmvEeGqxfEvGGx2yZccbn3metNd5kCUtBFpZrdP3bp5w5bx7j
 hMO42ql/fj89EYuumoFeDLglbm7wCP0YXo4lBPv3aoS/HrJULUIBQQQcxfFDf6Fw
 hjkgN0xwolOKuySc0tsptd9L74K4k35+19uMJHnsK8q1wFuBWY680oWmYGtA/qgG
 cbJ45uUlYk4W7SwCY5N0bYd6aZFOdHwa2zY72OgM4BxEJCK7H+fkgAVSh2Nr2blh
 OcVMDjLtoIH6gMvnwf8NcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718974733; x=
 1719061133; bh=qJmSM1/+QGx4fJmM9mp+Dx7mU1S35gUOBnlt8xJMvx8=; b=O
 TNOecKMoEHJYxkuTFqN22SZqGZP21QsnRK8T/jESh/FXPhZNxI38qFIHZ+4cW+LY
 5gjkVCIS2ezx/M6SkQae7KenEyHE2d5UfpVVUjuoN0zWlQCq8ltkKifFMvlm7AnF
 dADrrfpo5ZH/VepMWdrmqIGqsuAkNUGTBhhnJP/w7RMjsceLOVIzq6vUyFOZ5OfK
 ERTDd9z4rtKC5kFxfbAuD4fR4Q+JyJQhAus8449BiwjwUjAtqUUP7wl6ayKZVYvE
 8xPlIWL/7lTuCL7NO5l9EFr+pwnJ0Ir58d7DC0qcSSRuOfncN7ksfaqP5P858HKf
 nbGST0Z0R7cL1R9LKe0Rg==
X-ME-Sender: <xms:DXl1Ztgnvbed47o55_NNMW3cvc9wmL9V1sg8qTXWVgVJrw9_lJ5dHA>
 <xme:DXl1ZiAjbIAtyOV3aXhDv30y-KKiTdz0CVXo9rV4MjGxCF-btD37N3CaLNseCIH1E
 SF4jvrHkQ7fXBce_40>
X-ME-Received: <xmr:DXl1ZtEMeu43Axd6FvkRmRVB6qcKk6FeBtyLah-hnsO64oAQAK2Issk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgheekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvedujefhfffhveekhfffkeetvefgteejkeeutdduieehieeg
 feejtdelveejtedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
 sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:DXl1ZiSnCoUFo1_1vVFGNtRpCo0YXAVBbVMjJLGmXdg9EeOv1dp4ng>
 <xmx:DXl1ZqxGJ8GpYVTj58Nia2iUWzqZmCFub6G47eco1Mc1Tejvq6z5oQ>
 <xmx:DXl1Zo47rlZ8qYqXGICYkcuL6rU6sQBB6Y9nyaEUmLSCKfu5QK_ipg>
 <xmx:DXl1ZvyANu_iH4-Wkf2Z_qG3HwIkERgmXQre7u00YcbmTiR1_iwJgg>
 <xmx:DXl1ZhqvTog-u-aZnHOUyFu_HNenf0ElSawtVBuT0pkicaQqrCabcxgJ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 08:58:52 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 21 Jun 2024 13:58:42 +0100
Subject: [PATCH 2/3] hw/mips/loongson3_virt: Fix condition of IPI IOCSR
 connection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-loongson3-ipi-follow-v1-2-c6e73f2b2844@flygoat.com>
References: <20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com>
In-Reply-To: <20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=cofTbte/00M4qpTM7HECtdZQ9j7Dm2Dzsyya+FjtljI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTSSi6/yNUdVzZ9nv4p4s1d4Y3eM7Im3dZdd+xdVvMuo
 bs9exeZdZSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEWnkZ/hc1sH2b4nBEZQFr
 dtnf9dcqlt9s1J3WE/rC7M4ie8adJusYGQ6f4jb/tTJI3WDbygYBH1nx4C1ZR96ply6U3e9+dl7
 HcUYA
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

This fixes Coverity CID-1547264.

Link: https://lore.kernel.org/qemu-devel/752417ad-ab72-4fed-8d1f-af41f15bc225@app.fastmail.com/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/loongson3_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 528be84bf970..80e953512a85 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -575,7 +575,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
 
-        if (ipi) {
+        if (!kvm_enabled()) {
             hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
             base += core * 0x100;
             qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);

-- 
2.43.0


