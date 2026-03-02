Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960E6EB3622
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7dv-0006Nb-St; Mon, 02 Mar 2026 13:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7df-0006CS-C4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:03 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dc-0006LY-Lt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:03 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 300111400209;
 Mon,  2 Mar 2026 13:05:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 13:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474700; x=
 1772561100; bh=ABtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=O
 BgOKgzlRQsSBDW6xWo1B2ITb0VVKmB8lRpWjhC/wKQRUw/heNMltnJFVlUAey2ja
 hSLmBV+NSZWqOSLoYkj+qzgoaiYx/GSbR8H83pHEFuvoLKQeN/igz50PrZ6pAYpQ
 O6GoRBjw3/0e5QSZKZauzbFHwN9Rl12maLq2g/rCEUSnct1lylLKPdMzLpW45cS/
 gRraP11YVHZ/8BN91KA+ZJUMGayD7xzTXgv3O+haADAjfqCIi3RgWQQZDk78++7W
 7EP2oWcT/vk1nsgWsGYPGtH5YtFpNo3gSx4fxYLNiE03qqHcQXorgUdXY3ZEwbOG
 BodnOC7ZgdgeB7PidvDPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474700; x=1772561100; bh=A
 BtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=PWvLxaL8fht3DWYN1
 72RNzoIzRUh0iLhKFo7E4ND3nCWPKRvJKogxS68yjE1i9bW4ZiyMZXaOIPH5GMVJ
 l2hzL/BvqcwQPudTe10cVaaxbdYw4fQnO3DE3YlyK6hMR/mDX5QmQ1ryafVaD+tJ
 b3uvopxaFMINlOOFSMcbV9V+b0vX0a2EFH4qSTAHukvaJ5mqD4wjqx4wGVE1k9nv
 yxr02BhleOLEJ9DJrHFn1xlBFrGz9WPS5b/4WCw0joyDMzxkbwylX1HOh/rCRjN8
 0nqCkeOpSpL4d6+04VFjafQtAUs7b1AZpsA3wd26TyVcW/XPQqtDH4lK7s04a69S
 Y3liQ==
X-ME-Sender: <xms:S9GlaW1QeUREACqhqRe9yp5t_PjgxPqJQKgdWdZO5w8RAnjsAq-Umw>
 <xme:S9Glaf8SkutxSSTlg4I_mbAKJ93Rckg_AhmSH7KpllnQP2R7XztyZGtgNiLPHhj8Y
 zJ-LSb7wwEA0YuVSbGzT99WthArlCTtQzAJeD_SqXQv-o-Hpz9-vms>
X-ME-Received: <xmr:S9GlaXPDadIBL6wTf5F_bgsNcbb4GLv3KQCOJH_0nJxXgTzc7aRm050lz9d7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgv
 rdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:TNGlaTe0Rgovz-NSUc24hzH8Pb607iMjoyTJ0fTBcezHshVFQZrezw>
 <xmx:TNGlaWXize8X8cgt0_8gWtUvO7W53m17JNyXOaC3yHFbZjyl_6vtKw>
 <xmx:TNGlabh8KGP7HX_030XXSjAfpVelX7FWTvAJereqmO_EQb_PneTS-A>
 <xmx:TNGlaV-yI3jQeFXpNptdZMdK4ddWtRjtBl7bCEKCTH0y-uPCB6W9Ng>
 <xmx:TNGlaQYo5pyZt7TB8TZWsWk4efc-NsE5SYuhe-RJ6gfsdYxmqkfQ2emd>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:04:59 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 23e4a6e7;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 02/17] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Mon,  2 Mar 2026 13:04:32 -0500
Message-ID: <20260302180447.1078098-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
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


