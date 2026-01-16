Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13639D4A5EA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoG-0005r6-9c; Thu, 15 Jan 2026 21:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnv-0005q1-MC
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:15 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnu-0002Qd-18
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:15 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id A6AB71D00084;
 Thu, 15 Jan 2026 21:43:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 21:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531391; x=
 1768617791; bh=MPTvvi/Y+YfuFgg85NWsFyUoSSdQMTrv3ot/dXj9/yw=; b=H
 gQPX/ch+xrJG4CundJGYjwCevVkcck9hhQI0fkTC7Z9nPuAbKACm4j2KnIX1wIST
 YnTIyAip8jf3OVuFu08p7aCLKj4lDsEqVdgxZICeWdRM+KBP8J0WXY4/fW/7UZ4P
 hD3Ff9nND8EIzwSbRE5+ObCnLh/VW2TfdyKc0dihBGsDrLRCc4pRAZZQLEpjjE32
 ZtAhlK9fEuu66CZc7aheM4w3aeOkS0khBFZcuQ0Qq2jcP29uRzGCCuoqcewSC3Cz
 cVaK5VT2hVs8Its0vCQKrdb7AGbC2XAaNzP4dfDhI9CNAQE+6M9r/AdKySXdheS+
 OQQvvhqS6awhDBnA0HZmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531391; x=1768617791; bh=M
 PTvvi/Y+YfuFgg85NWsFyUoSSdQMTrv3ot/dXj9/yw=; b=UsrC1pKZGiC+2b5TS
 8MBl13nAjryt4LLwyiOBiEg5JurqjSnH0h0ZKe3ozw2wofmbOfGrm2GNeYAswL7s
 bQK0Cicv2DhYEYSlSyymzRMBBWoZj0W/WZwtfGpmZVdeg5eL7kpxl8bHm2vJLBZT
 QqP1DjvcOayGB81KJ2aYuUV0TWCF62FlYhvkc3XmYGlsD+OlK67VYvkM8etG+rXZ
 21DAB4CGcAA2+OOe4gyVx15QoUeZyByKUxGVzishzspcXybvcdQxhJgzmHAQoiuQ
 +6J9o36BwT5QqbOQfJymNAORHLzMIAGVyi9pioLrXqehOzEdkHCB/NrQcYKy3iNv
 9EftA==
X-ME-Sender: <xms:v6Vpabxb6rxDXVmw4yAfScX_65Gwl0usIKOqy3ODptMbFBkYXVxk5A>
 <xme:v6VpaavuVUlIOzBp_xefcFeZFKeY-POAUDDVOt83hJh3_l79j7qPDflDXYTtfPe2T
 vzyfH0olLEspIs6m7j3ymXwUJVkZ_I5K8zYreMSIDVUIZshnsL5L6Y>
X-ME-Received: <xmr:v6VpaStJJvLJkDUroOEvMtQVkQ80AhG7Bqp4g598l_v2n5RR6YAFvaXAzdKK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 gthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:v6VpafNMeCYGifiCe2aBUpDKR76jwRniwROeNRSM0PRCoiSObtnGWA>
 <xmx:v6VpaQ2RwIrzX05T_6nD4Qw3Da3C3d-7ilwjoLUXROhaQqcM6iA2Hg>
 <xmx:v6VpabPx3B4pPo1KAPhMZSH46mWIjeYPgDKAhbkdhHWADUG_leENyA>
 <xmx:v6VpaQ3FEB72UeGszftC2HKaggMuxrDY_8SbEgPEVJy5ci_G8ZQqGw>
 <xmx:v6VpaY4mSJ0r0h-rA2kZA-XgfyrG86dqQl58lVfu61IlO_Utaq7RzbFa>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:11 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a0904409;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 04/12] ati-vga: Implement foreground and background color
 register writes
Date: Thu, 15 Jan 2026 21:42:50 -0500
Message-ID: <20260116024258.1487173-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260116024258.1487173-1-chad@jablonski.xyz>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
index bd48b0db49..968ee4efca 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -931,6 +931,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
2.51.2


