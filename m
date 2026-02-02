Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD1DE7FDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0qB-0007OP-EB; Mon, 02 Feb 2026 15:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q1-0007Gm-Th
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:02 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0py-0001oA-KP
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:01 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id ED36F1D00099;
 Mon,  2 Feb 2026 15:47:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 02 Feb 2026 15:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065277; x=
 1770151677; bh=t09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=P
 gu53xuMOkUcgNGFc+Doyy0MNHDM/TuvumJmuikDV5d/FZUXWYKacQqFAFcG4Iieb
 JjMKDQlKvV/mRffUdMgavjXOXJkwxOkyyZc9NatWHxE68AaqPKUcic/EwNqZXZAb
 1PFUUoHTJbC/u9V8FheDkaXv7goVScN68EX5TpN9tVRzq5hTQhUsYx2Twx9oE70B
 5XOmxUvURMHK/OnjZA6LzlbZucRIrikAohCoYdpL9XgdhJ51H8tLgkjyE/rHaZZF
 DDxIkRqZGHPd2IOk9X1glydc/jpHxAnozdoKTC10WkwGlsi7rD7A9Qex8oZhZFPl
 GIcF30FFbhKW519EIM4Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065277; x=1770151677; bh=t
 09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=ngCnX/A4mOGLlCenu
 vT5VMHQhydCcSsacFjhyyDzTyLVn6fKhATExW3WBVKNzEkRqjpnNTVhIP1xeoieK
 C6WuV0QFXIIQ6+LpJK91h1cYPD0MoTIcPSUASuJGWP0+I4QUu3YtJOG/DSouq0v6
 L3DUip4dybk0Mvf7HBLq0ht+jITthCmtGhZQmOTWys8d3Mu/2rnaizZDOYIAbHQt
 byB/Esr7mRoKu6MDOBsFqoaSz0fYTnmQVS3WUVZrpVPiPJZAlMm1nL3aNrq8XcgW
 637GP9QNg4rTXfLlw9hYeOFTaR7y67Z7+lwSabHp55R4moER7DqyrrFjbZpxnXj8
 HmRIw==
X-ME-Sender: <xms:fQ2BaZ_w7rOouT4L_-PlKWJgH3WfK-AwdGJsk3syewDW4AkItVhZBw>
 <xme:fQ2BaVJFUa-Xj7-aimTD8T8HahEcscsqzTMok_z9zdxIyGDd32tfGdmuxwJ4vnHXC
 94_S74YCGYnHfZLmYr0jIzOvf6LplDx2WRYPa_mhlbXXbfcEnbAtg>
X-ME-Received: <xmr:fQ2BaUY4-OEGBIYJbSV-XhEn6MNsJzn6ftu0dxpQepRcGpkevJfSOTBEeafT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:fQ2BaXJdkbapSEzALpfqky09ippWakQ2V_WjgP9lNyPRJCt68cAYcw>
 <xmx:fQ2BaSCxUsGIHfEXiNc59ck7R8EyPZWuSWrWBxlyidYHkuBPo2fifw>
 <xmx:fQ2Bacqraa_2WCv4uL2UQOoyJVtsNJ42kP1ePlV4tfyi1bc4usyjrQ>
 <xmx:fQ2BadiqYJilf0Y7PVIEI4tgwRQw1Ew5dS0J9bXlXhzMI4SB9WT8zA>
 <xmx:fQ2Bad7OwJCBkpvEc_e2ZC5KKkXWbptqBRfsFZjc_CpLOH6xWrB9MR4D>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:47:57 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 91aae1be;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 05/19] ati-vga: Implement foreground and background color
 register writes
Date: Mon,  2 Feb 2026 15:47:23 -0500
Message-ID: <20260202204738.3080092-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
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


