Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6E9C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKe36-0003xo-4o; Fri, 21 Jun 2024 09:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKe34-0003wu-9a
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:11:26 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKe32-0003lp-HP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:11:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id A10E713800E0;
 Fri, 21 Jun 2024 09:11:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 21 Jun 2024 09:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718975483;
 x=1719061883; bh=azHgz7+++vTiiiPExoXJLbgUkrY8ugJohOMXmiSCtC4=; b=
 F3249s9xGr4J3A/WzoyX3p6cF9fHdFbka1uQj7S/qOypqwQwfMd6XLj3PR4vpF7a
 7wnaD4enmisAqcHQWVy8uQuVFpXIW7vXiK6GLQjghbPZepsbLcj89enIiN/wD7K/
 EtvpRYBPNDXK74xEzk0uhqlSKZOswSJOQ5VKZBUXMkkmMn74oT6PFHTaVufNTJeE
 Sr54Um6AnugITX1bM1idloqX6VCEuTd0etwT+dVVModTp7nh/d5dFxCMipTMRseR
 9piFOhiwKOn5GdP0uCzWrC21sAe3hIZf8OCktXNJIBZ15Gq4ZrHb2MUyBN6yBW15
 EPwykjMjr/t3pFm5gY/Izw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718975483; x=
 1719061883; bh=azHgz7+++vTiiiPExoXJLbgUkrY8ugJohOMXmiSCtC4=; b=c
 hXrzKdwZ9NV5U2TXouRMwj6Q4u1Byybzn96Ht9FHBTjW689D/KQJDH+wuh6Z8V9C
 u2Hqv2PGS/euHSMUA0J6m4aHNyM872RpZ9YsHXP/Lf6pLeUB59wrZXxCp+FFXFrO
 62dLNOifgO5HaThZw0rOnhpSwEvWBG/BKcjxmAJ1wnwwi4IwV4qa9LSX8s93Jjn8
 bFPDFVRwlZZhniQRtc5c2EpyrjKQco7t5iz8PD0CGf6L2Sqr5pSUnefWyCzyXXqC
 t4dxtGNUZgMn3NTlmmdUDyBZEQDQnDbrXXUCFGy8S6GWqhAYR0iqHlpUvvgf2CJ0
 WHQdQCMEAgz2e1BGDSa+w==
X-ME-Sender: <xms:-3t1Zr7SnFdgPv8ociHLw5P8TK6vVNUN7bHbIjVebtWzmHjEkxSrPQ>
 <xme:-3t1Zg6LOoY7R0c4b28NLbtNBwaFFXmhY-wc1zrh5xh77Z9GcR1fmq8cPlj9lqXvI
 Sk5FJmWF7hjAsqzY-Q>
X-ME-Received: <xmr:-3t1ZichJAwYy_zbgDHCp5de9TuRTqUSUHtXH6zJdy9XwEsuZca9OMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgieduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvedujefhfffhveekhfffkeetvefgteejkeeutdduieehieeg
 feejtdelveejtedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
 sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:-3t1ZsKTAkjrOqBhd-eA-QnK2PWKurDNxsTnAMtdaglpjbbkaJS5zg>
 <xmx:-3t1ZvL59KivugmIIHGwpHc4G3c4vMSzQpmuVc3SkX3SvW3F7iv7Xw>
 <xmx:-3t1Zlx03NDnczzHElEqw3XIONOCo382f6EpXAeFMYgWrnFPqsYJ8Q>
 <xmx:-3t1ZrLE1X3NFSijHaTcNfnPr7qli3Tz74fDadbdSKaS1Kx0LOEm-Q>
 <xmx:-3t1ZlhZk5ygzS1q_YGeB9C68LY49eH--I4qBxCCM7PaM635HAc5op3U>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 09:11:22 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 21 Jun 2024 14:11:14 +0100
Subject: [PATCH v2 2/3] hw/mips/loongson3_virt: Fix condition of IPI IOCSR
 connection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-loongson3-ipi-follow-v2-2-848eafcbb67e@flygoat.com>
References: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
In-Reply-To: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=k6GUbxEIll8axzNkKFOXUWMVONiN/aabEPRYpHrLCwk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTS6p+ZXwOeSXQc1Wk1Zo8y9uN4fCzKe+GMzaxNmsfEF
 /5nlanqKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIkk7GFkOHFyV+fs5/uCVDZc
 utpUylr7YqP122jrH8+7OtxO8P2fMYWRob1+t+ykVMdjOsfcPm97e+P+uurbLwqm5rnE+bnMO7/
 rBAcA
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
index 69c1f2275838..24aa4dd04b18 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -574,7 +574,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
 
-        if (ipi) {
+        if (!kvm_enabled()) {
             hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
             base += core * 0x100;
             qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);

-- 
2.43.0


