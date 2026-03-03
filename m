Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF617EB365A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFnd-0008A3-H9; Mon, 02 Mar 2026 21:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnR-0007nw-4J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:41 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnO-0002q3-OD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:40 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 481DAEC0574;
 Mon,  2 Mar 2026 21:47:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 02 Mar 2026 21:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506058; x=
 1772592458; bh=t09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=T
 Gqi0bnUD++Oc7oHWZ8ukCljneSMAEobRnA5K8A0qfWL9kVpgTEMXET6L/iW2rGC8
 x9cs3hLAner6TAzrrnD4HhcbX/GghBVwLZyeu9iemZkR6nqv6QY6gIitMbhFjYMI
 CVs4f5hBHwsC7vhR51AGU/SE11pkooovp/Unks79ocDE6+JuYpN7TpnnLBQVEE0f
 WiOU5vgHjLgNiWXNKUsNkljgi6FVwUJXP9tqGC6b4VM+Enjaz6HmzknvhdX7PR63
 7nueRo/yZf4196VnDO601kYn1ImrrKXdJrNYVHmRrN1Ac+Z/oUG9RXbABZ+6SYMb
 iwmW66MM+BsarY/Cmh0IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506058; x=1772592458; bh=t
 09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=XJfO8H9/YxXG9JtIQ
 GPLqLgzsN3BtGIS9royIuN1xS1nQeY47PElpk/D5Dnz0ht26dnWB2UP8wVVD2pa0
 BCEnfOEsdhlp3IZjTrEY78lTPm2e31p8d2n6t6Z90wBtmZkKcE+b8OlYlVxwfFhT
 /0Ev9f3R0pPUvNWYUeme+0dQSwdVoBAkcH0SJLLT5Z/WgOhkOOlED5jAqRremReR
 LIlF13wjHfmP4sNW9EIhVwlYe1uGda5/hXxhevSWwcVpEurg+RjZRGTTIjAohWv0
 kSa+m17MGzNW1MYA3J+fR2+lMs94KT15zKqW63eEUffgEYP4YLDmJx03q5u4TVJx
 Fm1ZA==
X-ME-Sender: <xms:ykumacSMk097SM8Z17F6nr0RkMWLEB7AgBatAP0_FBwd2FCPw8stcA>
 <xme:ykumaQruJ0q_CTuzqPKXhTs7B1-t-yYbYdYGxjnD7Ah3fZ7kq-mdT2PcaI25nuAC8
 oLPZmrIOHIMouI7UW04ptoz7HYuyZdyKOQ5AG4TOfpLl7V6IEhpftU>
X-ME-Received: <xmr:ykumaSLpJzMjDTTl7O0tKS223xhydW-ix38lxUbdCF3wlxHPoVTzKs31pd20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggrnh
 gurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhird
 ighiiipdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtthho
 pehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:ykumabr5a5Dljk5roHeXi0C8Yb1EgSSp8juB14H3GX5dHNbXUcSb1A>
 <xmx:ykumaSwt5Dgy70u5eyASI6IMGZKiz5HhbV6Qpcmyhkt3dLxRGlKSew>
 <xmx:ykumaXMdSQquC_s_k8nNAX9EMS8fflV2jQiR6DPajVElFlr8Lv2c9w>
 <xmx:ykumaf4j1Ef-rExR2n53x0TqxLeI1HQn35ZvvAeXUKSMf3zXNA5SHg>
 <xmx:ykumaQHHm8OpFVQhFN-nCF2y3zW4wO-6XBpmypEakaDuOXDeDUfc8Vzb>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:37 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 141764d3;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 05/17] ati-vga: Implement foreground and background color
 register writes
Date: Mon,  2 Mar 2026 21:47:18 -0500
Message-ID: <20260303024730.1489136-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These are straightforward 32-bit register write handlers. They're
necessary for a future patch which will use them for color expansion
from monochrome host data transfers.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index ce23e5e48b..26fc74b19b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -924,6 +924,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DP_CNTL:
         s->regs.dp_cntl = data;
         break;
+    case DP_SRC_FRGD_CLR:
+        s->regs.dp_src_frgd_clr = data;
+        break;
+    case DP_SRC_BKGD_CLR:
+        s->regs.dp_src_bkgd_clr = data;
+        break;
     case DP_DATATYPE:
         s->regs.dp_datatype = data & 0xe0070f0f;
         break;
-- 
2.52.0


