Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805F5CEFCF1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFR-0004VM-U5; Tue, 06 Jan 2026 13:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEz-0004GJ-M7
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:17 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEx-0001wm-Dr
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:12 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9E47B7A0119;
 Tue,  6 Jan 2026 13:57:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 13:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725830; x=
 1767812230; bh=XzcloEx4suAvbayAGcs/lKC5IRMyfGFpLSKmtIsKdzI=; b=m
 xRYVRlKnPuRph1G4TGXsWEq2251waxIwcEW3rqceEE2QOAvjDD67MFXYe0c5+O4t
 fFmLF5ZV3q9rewln0KiquaZPK20Rr8sBFBfZpxwBPRWx2Tcow6d5LNQGEfhOiDi7
 fcdqH1xlYkk5DxnGiQvdNl11JiIxKcepklGSO7OCj3TCkd9TXKXx0IV5ZT+//BId
 MVY3VPaDPaRCYGgFdc0+ZWgdZq+cQLe42N3Y/Rq1qS0PDnnyzaY2b5zgV3f7alvG
 I3XhbOZLm0rAVC0kBQd3a24SqNiZfPBE2GGlKTskBZpwzg1nXmSTj9+d45aLCrNW
 hP5LpGFpXq5jPJMR1nOKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725830; x=1767812230; bh=X
 zcloEx4suAvbayAGcs/lKC5IRMyfGFpLSKmtIsKdzI=; b=zpyMqRSsqmEQ33rqQ
 vifwLguwmMjLzuDwKb+eJJxpfD5f9THTVuXA5JgQnGuYSeJE1hmEAkFWQJvipwdR
 ulWD0kdxbpDxAQe1nM30zTnalxZGFjB6cKTm6KmA5lNCSiU8bJEBrsfJPKJdglCd
 g1zpp9w4maAWwQG/lBArDRKMtlDI61VGzH5e77JMHdsVkg1uTBRzBmLIZBX2NSso
 7SRrk+EU25kNcx5ysRnRSAFc7GwXn7BXCiQm5TqT4NyWouQn2lNBlaQGutEPsGOP
 4K0qH/wLyAnTt0J9tN+MUIrRY+tioEGmUlrtM1B8kodj8Yi/pny/QQJ5ixPVaIX2
 7wH3A==
X-ME-Sender: <xms:BltdaQF9-BRHaupdZ93AiUN58iAHEK5miaaEN4vL62dTQ_OLdlYmKQ>
 <xme:BltdaQwX2vopY4VSXAkOj-aZxYRzyf8mAmBbBxt2K34fDz-9nvxhzfe5bjFbdrUS_
 PJO-XERv_27DBfO4g6MiLw_QuAoq-ojtouM1imXgz8TPEvg6r81ow>
X-ME-Received: <xmr:BltdaXigHpsCxvE-8b1ytuJCsy6pP4boZoKKf9Q2b9iRB5ABbkllzGYqsofZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:BltdabymoHeDEx4gXljJGL-mOOEOsczgCzR_ia_hMFvNMQFsoULCwg>
 <xmx:BltdaaJh5WzjbiYHs5E8ebHJWnzzMZDJyy1zFZR1V3F_62QMiGWOHQ>
 <xmx:BltdaSSfS_vqAS-WKvCb0P61kTGK_tVSCaUZe1nQmVRAg4ODwRyITw>
 <xmx:BltdaSokMEshIKMVvVNUPMOuN4fdcbticpURT-pgXZcVxLglUJVc4g>
 <xmx:BltdaWdUChp3FTaWF8BPtSfzbaokyMBGfLIZf7C8FnNqI_3-LCPnhJab>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 019e273d;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 2/9] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Tue,  6 Jan 2026 13:56:53 -0500
Message-ID: <20260106185700.2102742-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260106185700.2102742-1-chad@jablonski.xyz>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0bbe8915f1..2f919bcd22 100644
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
@@ -475,7 +475,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case SRC_PITCH:
         val = s->regs.src_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.src_tile << 16;
+            val |= s->regs.src_tile << 16;
         }
         break;
     case DP_BRUSH_BKGD_CLR:
-- 
2.51.2


