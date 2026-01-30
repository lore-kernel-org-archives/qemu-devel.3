Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1D1E6BF18
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppM-0004hd-QX; Fri, 30 Jan 2026 09:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppL-0004gR-2h
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:27 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppI-00036k-1K
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:26 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 1202A1D00067;
 Fri, 30 Jan 2026 09:50:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Fri, 30 Jan 2026 09:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784622; x=
 1769871022; bh=t09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=j
 WcNRSa3FmOOkBZFNZZC13NCBWk36pP1o0YCd5dkFM2deS2ObNjPCaGp8KECQppM5
 h5geBU7y3Iz7gEHJYL4zi2/NL4gRMEhPU92L9Oqa1YgJnGkdwrqSkXDqyo5U3HPE
 C1wxJ83LuH+afqpoomBDEsnuw/ZTPE5PUipjI5BEzOQtYTQV+hFpJusdpjAJhXQI
 kQD/SNJln3RC9n73ZlVAtgJYjYqy6ccOLX6IubY2Vuu5uPwfUXDgDATAl0oeDCGb
 9AuxaVCuzHB/pjYgGEiMTTTcqJpDXJu3ZLdTQ5EIEUPFFuUJDw6D/fb43H8vS8VK
 AXwNP0pNTTT54mbFxaF5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784622; x=1769871022; bh=t
 09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=NJa8WJsf5JsDdNi9k
 WHAEx9YfkKTLFjIPuwDl4SJEVQ+5FUeaoJlx0HQBUMZlZ6hv9OUO396LaF6eltlL
 /N5WWqfD2qC0KsuW7640egwsZhVXwRA+2jYdmGsBjiK0MbhPGOWQqq50VUlNxmMO
 K97zXvSEfTd+gPGaYvEzds6/BiBLmrrifY8zxYGFLDuJHOUtQbPyzdMsd2/MnGvt
 nQ19BanmdPHnZKsT62sdI69F7bNt1BpfXnY7b0mn+cqiXJ3A7c4wlae/E7fUTRcy
 oRSw6uKbICHHYZOgemJLvrlu8HLL/bBKAOA0FdSm4O4akCBQyRR/GhUFgx9WeF82
 s91Dw==
X-ME-Sender: <xms:LsV8aaSyK0GhlKWEVwf5Nh3QK1pBGrZLEucwb1GY0X7L6w7AhCaECQ>
 <xme:LsV8aXNfHJszb7cDPBzygWmGckG4KjJPo7Z8VGJ4X6R_9H6a1Sb_CLfupylKLje5c
 nm5CUh_v2LVVFneQ68OFdJ54UO85Q7L_PfGyy8ZeZPPAHGiCVV6SJo>
X-ME-Received: <xmr:LsV8aVP-V3UQ_Hl19CYVP1ad0j1M646UAfgOwK6qGBtRKcPlz59SHoXmuAoW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:LsV8afteRFwHuz0tzsJbq_NZyudUvHXpejpsZChUkLkn-qdqGginyQ>
 <xmx:LsV8aXVuN1p1MjFXIN10VR7cwPw4ZP4BiJS17eSgh5q1XL9F5Wa-vw>
 <xmx:LsV8afumRIsOFGvKvH3K8jZsPXhxOn_gQudE-RWv1EV4MAZtKmzn2w>
 <xmx:LsV8abWkdwH4IE7YEOKrJ2h-mDIa-j2767WNvvrLd3EoQq8YLYiQzg>
 <xmx:LsV8aRY1NhbNe1dFPFT3q-Vjk_Ic4MrkloVJmxR15uoOEF6HsPk4_AjE>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:22 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 4e74fcbd;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 05/20] ati-vga: Implement foreground and background color
 register writes
Date: Fri, 30 Jan 2026 09:49:50 -0500
Message-ID: <20260130145005.731129-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


