Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0711ACEE327
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNxE-0005WF-Mt; Tue, 18 Nov 2025 10:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwr-0004xM-Sp
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:57 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwl-0001wm-R3
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:51 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 3F91B1D00225;
 Tue, 18 Nov 2025 10:48:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 18 Nov 2025 10:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480916; x=
 1763567316; bh=3HiKTWbbX3nGBGCA1/ulpIz7A57sFOKCiV+MHceVi9A=; b=H
 hhAw2L7Ne9R1NKY7na//E9rP3KA5IoF6o0FZmTzILnKdE4pz25krU5RNFu6Yv7vr
 GbuG2nGsWcpivm6NicA54lukJ3FJ3/1Y8b7UXoMXihSiGQb0ODEpcVEGo3LH/E40
 cQNuNs3atiQlOTr81Npbv5Zbyotvh0VWxoNgSgpM5GZUgAdDJm1PBCjyFIKqxFl2
 UtgtEEzJM/839Jaq1CVApjqOH6NHu5Dlouqj8FkKr/+3vszZ0PpfZPPt+unKAglz
 Scsms52FffyjWIatwwwV/+Zz04aBsaFTXA88eMlFB0DB+S8ty2XKqo2I8jkcDyAS
 7d0uNQxkq056+XwFfzbeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480916; x=1763567316; bh=3
 HiKTWbbX3nGBGCA1/ulpIz7A57sFOKCiV+MHceVi9A=; b=Abq4FlGUeNhcBy0Ov
 twi0N4eTLs59DYCwno4l41F7brFKX4llOjm+BW/vKIPm+//UN3VvgMM7jGsChxbD
 bTYkmYOXr5QTM3R8rclWR/M2BvpuMarlRNi6Na6Go0JZf02nmSC8ZsZxrITS03Su
 CFKYd5OmV0M3/oHHV3deMO2C+/a9Ki5V9cEArJx6mG8sxk9qXWR0e5stH4fAR3dv
 HoMfjlv5jknVbpvwsbyp1vkEhoIV/QBAcpxWZNIDBCQoRQ+STixX6ngVf2/NkKl+
 iN2OG1xDqVbl6lDPvDkaRnWDyshlQhEG95nzAYB5LmCcsq+0q8ZKQZPBALgRSPRb
 30BGA==
X-ME-Sender: <xms:U5UcaQArPqdlJJ2ZHvIR9l0FpYC6nHYjgtZrNCLliGi4hQmH9STaSw>
 <xme:U5UcaZ9G7GV2phaecfEP-hJK28OPuASP96MrC8_OuZ-UNd64JGuLcbnx1r8OTEjic
 n88_aLRqmKhNVpQeQb5v1T6DXPWrea1_J8DD_-lo4BG8ZpsH1N6JSM>
X-ME-Received: <xmr:U5UcaQ_0Ht5rvJdeG1NfpUf4H9WFz2Q9YikGRRFu0YYFlpBPeMPC87kw26pJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:U5UcaQfoEUuaW0pQt_wegMVLxaxaZHrAuiOI5sD4lYVDsHprwFOxIQ>
 <xmx:U5UcaZGQ628r4VAegYqgryui-YSqO1EEml1y8DFmR4abVdJlx3jU-A>
 <xmx:U5UcaedUbFk4YYPeWRtw5SR2ev31uF2nnT0pdbTz5aVXt3SiOFQK1g>
 <xmx:U5UcaTG6LmyPq73A6guAk_fRILJiKZxM1hOz7IU14ehUmQHFenyWtA>
 <xmx:VJUcaeKYfr8uYysMP4H8KaVHbbLiMaA5qb76YJSt-1u7z3u6ujwnBVF2>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:35 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2a057767;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 06/11] ati-vga: Create dst and sc rectangle helpers
Date: Tue, 18 Nov 2025 10:48:07 -0500
Message-ID: <20251118154812.57861-7-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=chad@jablonski.xyz;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

This creates helper functions for building QemuRects using the dst and
sc registers. These are useful during blit setup and the next patch in
this series will make use of them.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a8c4c534b9..0695c26b3b 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -13,6 +13,7 @@
 #include "qemu/log.h"
 #include "ui/pixel_ops.h"
 #include "ui/console.h"
+#include "ui/rect.h"
 
 /*
  * NOTE:
@@ -43,6 +44,29 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
+static QemuRect dst_rect(ATIVGAState *s)
+{
+    QemuRect dst;
+    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                     s->regs.dst_x :
+                     s->regs.dst_x + 1 - s->regs.dst_width);
+    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                     s->regs.dst_y :
+                     s->regs.dst_y + 1 - s->regs.dst_height);
+    qemu_rect_init(&dst, dst_x, dst_y, s->regs.dst_width, s->regs.dst_height);
+    return dst;
+}
+
+static QemuRect sc_rect(ATIVGAState *s)
+{
+    QemuRect sc;
+    qemu_rect_init(&sc,
+                   s->regs.sc_left, s->regs.sc_top,
+                   s->regs.sc_right - s->regs.sc_left + 1,
+                   s->regs.sc_bottom - s->regs.sc_top + 1);
+    return sc;
+}
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
-- 
2.51.0


