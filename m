Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88813E9D411
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1J-00073a-BZ; Wed, 04 Feb 2026 11:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1A-000711-NH
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:17 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng17-0004Wu-A0
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:16 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 8D6001D00161;
 Wed,  4 Feb 2026 11:46:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 11:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223572; x=
 1770309972; bh=jEmCW2CJeKwiBoliiD/nWnWhBy0/mPCAScNKxecv+dg=; b=S
 dXZ9DM4uYqWzFhEzAxr3iFIKL1/ZXy1Nzbi0Zp+Iz/qEeg9u+QDdkvPNuG+FqFBA
 j8WKvXa9YHoB/yQLc5/PImVNhJu0+V5jl3uP89qArh2lDjV89Ul15AZGz9HxIX15
 0PKJ8CVQNJwYJurMXaPjoUGZd9yzu60u2BCo8rmTiGUIzGiUFVK+oxxY/0p96dm3
 dTYZGPTOKSeixQwPC5XLsxYhv4c1wSnvDviLAwURw8SEq+8sUwmm/hyJiu8+qigv
 j1tg6OABXEfHodRQFyDXtObsozoO6IRWxshXG768Z9MKV2GwE8gZmHhcGdMfPCNP
 +SxBdhsc6j+B1FVDuHQiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223572; x=1770309972; bh=j
 EmCW2CJeKwiBoliiD/nWnWhBy0/mPCAScNKxecv+dg=; b=PlwKeqdTa90T/V23v
 x/S4WC1++Tq3lJ3PLt17zGy2JrOTUdYnLWITvYkCXx1LMOSUp6iOAlaFbW0loweP
 zm6vwWy3PXYOFNEwgVWfgv4U603ovUvQX/17SnCiGkVK4jjMHGNMl/Oi2vvLuRfN
 IDJWb7IrT6CDOW3DnV/4foVnlfNYR4bL1lHMkm1/aID2mnakgaqIDmtOxAQL2nrN
 X/xWNQJLNDb4gxFsokTQKxZ62V50phqSgyYxU/+fvWDAgj/rJuWZl1beD9jDzi8S
 ToBE4L7HMRTpoYLa+hjXkrSShLgfVRCmCShFlL8oxGqJG/FKddJayZizMAG1Z1GV
 PcSbw==
X-ME-Sender: <xms:1HeDae7a-NDkHr5CtFONlMa1OkmhaAVd-0edgZTfbmwpI1w7PyKuyQ>
 <xme:1HeDafUC4XeRhOGJDYS-fRfum0KMCjrDbh9mfjuzMKaVnCx1V5b_a5jwI-n7-_4EO
 RGC2xSBQ5FS_va-2zEfY2MOh4oQLoT2Q9qypLg4pgxRFjSNRq6KbIc>
X-ME-Received: <xmr:1HeDaa1o0JeUnw2RHx5W-v5_Jz0c40L774kxBVnmRkxytz2ecvN3hUSVqZj6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:1HeDaU2DDlA3Mj65DPilBVw5q04cOaoHgMSN6HcFwxHIGajoOQ2xWA>
 <xmx:1HeDaV-Rglt-fI7qCsOicFg5AzpRIwk_Rbcn14mpCC8wm6uBDlcf7A>
 <xmx:1HeDaZ3AWLX0mQMkCVSJS6CbUVF7MBw7P4d4-NnGqz5fuemNuEnX4g>
 <xmx:1HeDaa8aZhi8nE__aS7Lyc6VZWB-WmUxeqcc5v_T0B38pCdA2CMPcg>
 <xmx:1HeDaYit__aXMrVEec7g18fXmIncIM6V3DbGqQe9lpeVMEhM78zkM2TG>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:12 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 293bb1cd;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 07/18] ati-vga: Remove dst_x/y updates after blit
Date: Wed,  4 Feb 2026 11:45:55 -0500
Message-ID: <20260204164606.3425246-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
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

The Mobility M6 register reference (DST_HEIGHT_WIDTH) states that dst_y is
updated after a blit but this appears to not be the case.

Hardware testing revealed that both the R128 and R100 do not update
dst_x or dst_y after a blit, regardless of the source. This removes
the update.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a8c4c534b9..cfc7bf9789 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -174,10 +174,6 @@ void ati_2d_blt(ATIVGAState *s)
                                     dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(ds));
         }
-        s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         dst_x + s->regs.dst_width : dst_x);
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
         break;
     }
     case ROP3_PATCOPY:
@@ -228,8 +224,6 @@ void ati_2d_blt(ATIVGAState *s)
                                     dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(ds));
         }
-        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         dst_y + s->regs.dst_height : dst_y);
         break;
     }
     default:
-- 
2.52.0


