Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB29010398AD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4eA-0002UB-TG; Fri, 27 Feb 2026 15:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dz-0001Pl-Q5
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dw-0007Ou-00
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:02 -0500
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id B5DDAEC0633;
 Fri, 27 Feb 2026 15:40:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 27 Feb 2026 15:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224858; x=
 1772311258; bh=ABtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=g
 hTsCywnugsCpoiwV+587HAeQThacyykacXsfbWifdCwPKV2b2MoL6DLfjefA4X2b
 n1ZTZBwduZ7DlffMvzYKLnU7jlf5Y0EizHQovImMz+bQCKmkfp1igKGyFTZb3YlD
 25E8MyR40Ch9E9WBHF91J4gGCJgt+UeEQOckdi9Lj+myOQhI0fS3e5aRDmbH/twQ
 bGMrcYstRtHuYiBOels5/huUvVXbeFVoVMDCI/57o3/DIVlXw3stKHv4dzMgqHra
 OY2/AdkYXuYrUXncCqd0sVaI7WwA74H5f4wsICoyucMpI3lhuuy+YM8iUuTYe13z
 0NN022ddm9QwKWn8xgqkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224858; x=1772311258; bh=A
 BtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=VtIFlPbntc+XuBDGA
 HgyIG+rk2l22vRdCTUdAONUZh0k7rPcIbmQ0A2OBdI15mViEUKGsQ8zLNLR0/x8+
 gdJZxZoEZZALon1RVPUcRFFSm+YOfo8h2qtWiGQo5I4QkMyj8Qjlq6Se5gQpp3RQ
 gDtZWbg9lxo9nztI1bGdePwi2bNwJjrgJEExB627U8l6NYcKnNl2TNdYMV97gX+v
 htFg33TSaegKspuUwQqNLZktn52yuSFHiXjLP4MMx0s5jiGLJPLAUhMFJPTBUXms
 JAEOLW/QX6HuaMkpeHHPO197wHN/L5uFRN9yz/JZOMAexUDlfVzVBv9RXU2NVWDF
 7BDjQ==
X-ME-Sender: <xms:WgGiachRg6bJPlnHyYVd69Zd3F6yGVifEo6JCcfo_NP7M-9O1q3J3Q>
 <xme:WgGiab5o8NCUoVw84ty1Is45XhzvkVK4DC8Vmc4VjiwP5FGFuJYOOkM80iAe9QcGK
 6DAGnOMgdGxUusCSm7Pp9FSGk07oqr9Vsy5MSWZp7DyabYZKCpRt4vu>
X-ME-Received: <xmr:WgGiacbfseoLLV2gvXLtFVNRa9tg7gGl8W_E9i76e--6yLbddKi5XQshxB_9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhu
 rhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiidprhgtphhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:WgGiaY5V8UDgbNBN6Sa9mt3aAfNMrd2ZAE13kZ5XN6e3MwTYmErQZg>
 <xmx:WgGiaXC-nLFJGOG68JpOQrrlcaTPIigxAedqJMCrK7RjI_LeR9ozAA>
 <xmx:WgGiaWcPEiZ14s-eloV5g4jBtwIX8NrAc_-6brcdOEMvUJRV8yxVZQ>
 <xmx:WgGiaeJgtEp-Y5bRCk-14kks_QujUfZmcvLzCX6irJI3_Q8tepfmSQ>
 <xmx:WgGiaVGEOqeO0OPSxj4sxbuIDVFcHRorXmqrHfoPGfKISqRe6jhchQq0>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:40:58 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 7c776d26;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 02/18] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Fri, 27 Feb 2026 15:39:28 -0500
Message-ID: <20260227203944.746471-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

Reading DST_PITCH and SRC_PITCH on the Rage 128 is broken. The read
handlers attempt to construct the value from pitch and tile bits in
the register state but mistakenly AND them instead of ORing them. This
means the pitch is always zero on read.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8438a77de0..777a6b0a2e 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -438,7 +438,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DST_PITCH:
         val = s->regs.dst_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.dst_tile << 16;
+            val |= s->regs.dst_tile << 16;
         }
         break;
     case DST_WIDTH:
@@ -468,7 +468,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case SRC_PITCH:
         val = s->regs.src_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.src_tile << 16;
+            val |= s->regs.src_tile << 16;
         }
         break;
     case DP_BRUSH_BKGD_CLR:
-- 
2.52.0


