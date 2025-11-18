Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E64ACEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNwz-00058j-3s; Tue, 18 Nov 2025 10:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwi-0004wC-U1
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:56 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwV-0001wG-Fe
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:32 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B3E4A7A01D6;
 Tue, 18 Nov 2025 10:48:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 10:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480910; x=
 1763567310; bh=1fLrmY2vCPzkZe32NVi8wGZ+nMLr2lsCR9EzsVwOet0=; b=A
 /uE7xw/OZ4qwYYggG/MY0EHiFFQ40oHWBEDpHBly+rj58+pgfizd9HiEK9dKo31Z
 S3zfa3cWGZIdRoDDXalS9dOm7lx8TmUyMurQMqIpczcxoTIwC5YiPwguGCKeuiNQ
 7EeeaUmCp/v6uyfjh63D5t2F/Ufz1Lb2uwZ8ffspWa/RDgSQbtdoP58WnMg7HvOS
 gGfnMqTnU/VtLPGiUyrgzaJNhHncaRqSmAjxA6cRzf8jbSQm42D3JVpn/DX8DBiz
 3lkNw38AbpzIQ6BY5Zr0up98fPIIEXBdnrNphOWm1hIZx0vZvPYCqJr97AfLWikh
 BnNjTJvlpDJFpXpGQOF6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480910; x=1763567310; bh=1
 fLrmY2vCPzkZe32NVi8wGZ+nMLr2lsCR9EzsVwOet0=; b=0WeUnrDVpy8Pe0YRh
 yqakDTVemKQa2+NxOVur/ADuY1OHiDfpMqSUbvYVo+WMT4zUlNTr8HGTkdKd2Ft4
 fUzy4gEP09qhSpI2QE0LNWWlBe2ofI8kh6GxVLGmeUs1Yam3mLRiCX2p5m7HcmRW
 brOEVCZTvE32a9Bakm+22XkaYrefOEaVkD661fImEKfnkjiuqugEEPW0SUB1rvW+
 SDaZ1YO2ack+4nYyWkFFExBVGQAgUWJ1UmzgFe0whs+2GJjB9pj+83THgHAQ1gIx
 RA/r6k9mUV8up+5dcvOqa9XbNZDSoMc72nzc1Y45icyIvYD2td9CbSXiLs9tCiAt
 nVFqw==
X-ME-Sender: <xms:TpUcaQMqy1osJSAlRacZcEk62SUY-Cgc4Thu71i_26ZT46D2aGIzNg>
 <xme:TpUcaeaM1TaGCsjfoHaGGgJdgH1126eX3ayWwRBsqKRzEjUoZFNf3FMu_SB0Mlk-d
 NX-VHpt1IPLpYQAwBWzcAxRWfG8jQS0D1gxOpXq6CnPYeok_Ka3>
X-ME-Received: <xmr:TpUcaUqqCcIL9KaCVUZyEwr4V_UiZmGnYgT_neBx9M6L8S8c_q_KSkBZB5NT>
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
X-ME-Proxy: <xmx:TpUcaSaBHl4RyLqoC8ml4jadXhHA0YLr5U3Vp7P8BF6uuymHA1Chew>
 <xmx:TpUcacScbuid7987_2T3lm8rRIxBnHVRYEiMIPn80nfX3SdlQo10hA>
 <xmx:TpUcaZ5YMt-cUn5txm97NAS_CE6XWAXnnS8o8H2AcfJS2_cl9WKggQ>
 <xmx:TpUcaRy5iGf8RqGbEl8ZoqBp4khHMSVjVfcHhqNsbSBsBic-eFP-dg>
 <xmx:TpUcaXF4JcaFMUfzZEjjshGJI8p57Nh12H1o9-vwtb4Q86stb8uSLfB2>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:29 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id fabf9173;
 Tue, 18 Nov 2025 15:48:29 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 01/11] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Tue, 18 Nov 2025 10:48:02 -0500
Message-ID: <20251118154812.57861-2-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
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

Reading DST_PITCH and SRC_PITCH on the Rage 128 is broken. The read
handlers attempt to construct the value from pitch and tile bits in
the register state but mistakenly AND them instead of ORing them. This
means the pitch is always zero on read.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0b4298d078..66fad6459a 100644
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
2.51.0


