Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEAFCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlN1-0005jM-7G; Sun, 02 Nov 2025 22:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMw-0005hI-7x
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:35 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMq-00080P-Vd
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:32 -0500
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 7B244EC023C;
 Sun,  2 Nov 2025 22:36:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 02 Nov 2025 22:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1762140987; x=
 1762227387; bh=Qp4IVbmKfSgtZtD+5ckCm3MWYAYmz+gEAZuguXtKgnI=; b=T
 fU1GSGO28PKIVaqaDmSXKGDzZEBuVDb7i1ZhAC9ZiB42/pWKbk9Zix1dNQmGwCLf
 HMi8kHstodCkWECTEXIJoeXeAXxbXFF0U3afGne6ENgtdnP3w8pXTFJ7Ts5T5rBZ
 M2nYi/flIccNxOIr4TBbepV8cV4vpO5cBkst7hoPM+xylj7FqfRRtXop3ntZgLmq
 js9z+DUHkb2DJ50OBP2EeecWfVZ1cQn7xNxseU0d/KWiwigOsZFYZ7iD9Bp3Z4j1
 re56o9MdlHQw+p0OWuDUEHYiYzeqCDaqCIUoKo39aqQSIivMuB6Rdkp0XmcVNef8
 ZmcUd38LWOJClarT3byhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762140987; x=1762227387; bh=Q
 p4IVbmKfSgtZtD+5ckCm3MWYAYmz+gEAZuguXtKgnI=; b=nASaV90XeRYeCcgtc
 Gk/MVrAOAuP4tCDKlt6Ke5wnQ+xEUXaNxPbMqNGJCNsidyfW2bqnwew8/SeR4u4W
 NaD9at/UYr4LCayiiEP+8LitlcyWkoqLC333pPMG8HbDiwGYxlKFoqfJif7n6x3r
 DWkybOcWCzEOLB5fspEAwHd1+x/uc/H4L35SqQEbyp6uXEB5l+MoyvKcW8o1wOk6
 Jgeb3NMrAFsCjGXdKudSDVti38namES+R2PsASPujLL50Xubw5Emd5E0kARsp1Ux
 ODsZ70JOtl6qJpDKYVAnzAxKC4WI64xi2Ga1sU999geADQymrPO2eocYJExyz/OU
 KqLiw==
X-ME-Sender: <xms:OyMIaUSkcCwC9OkdCHwYI9Xwn30x_8HcmTx-4fG_PrXe1qMX6ugkhg>
 <xme:OyMIaZMADTjiIUy8clJJOf75FilkIxK99sqNuKdMMBv1nP5RI-98C2I8g8ssGKvQC
 KgJNrnPd55JM_fqXlq8f6UMfSY1-1G0aVnSvmpNZ9YJqqPPLWZsbtdr>
X-ME-Received: <xmr:OyMIafNYD8IkMWYoBOUlNk0795vUcMSWymnmxv4D65fC4fVjFqVkOaoP6qLv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OyMIaRu1QQ0J9Dm1eW8Lh9D7rdhftsxZPfVpuHELKFDheWMyA791LA>
 <xmx:OyMIaRXa9XamuvH2oi2iXYOtkhAEzT8-fBpqiQOCwIuqxAEjzHHXHw>
 <xmx:OyMIaRs6itR3bdMlLcJ6uNuDz_JROmAv7Ew2X8XVteDuQHW5CUyfYQ>
 <xmx:OyMIaVUJxhc_2HzJ_3L6FrOimkFXUeKSi-6jyDKLrK0mZYT0TrIc4w>
 <xmx:OyMIaTZdTe2QRd1ZIKijn6-C6OUYyQbkPo_nzzfLSh7niFi7sekocOja>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 22:36:26 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c430d697;
 Mon, 3 Nov 2025 03:36:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 4/7] ati-vga: Fix DP_GUI_MASTER_CNTL register mask
Date: Sun,  2 Nov 2025 22:36:05 -0500
Message-ID: <20251103033608.120908-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103033608.120908-1-chad@jablonski.xyz>
References: <20251103033608.120908-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.150; envelope-from=chad@jablonski.xyz;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Change the register mask from 0xf800000f to 0xff00000f to preserve bits
24-26. This is the GMC_SRC_SOURCE field which is needed to determine
the type of source for the blit operation.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index bf7a037e64..4ff17209c4 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -867,7 +867,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         ati_2d_blt(s);
         break;
     case DP_GUI_MASTER_CNTL:
-        s->regs.dp_gui_master_cntl = data & 0xf800000f;
+        s->regs.dp_gui_master_cntl = data & 0xff00000f;
         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
                               (data & 0x4000) << 16;
         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
-- 
2.51.0


