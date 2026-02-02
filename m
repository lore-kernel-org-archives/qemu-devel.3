Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4DEE7FDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0qC-0007WH-KV; Mon, 02 Feb 2026 15:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q3-0007IT-8k
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:03 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0pz-0001oN-Bj
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:02 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id A74311D00094;
 Mon,  2 Feb 2026 15:47:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 15:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065278; x=
 1770151678; bh=jEmCW2CJeKwiBoliiD/nWnWhBy0/mPCAScNKxecv+dg=; b=R
 XYnXAIVWRxmBwewuAUVMTQru3DQCGzw9Dm6wSdsMmecxjremGlHtUbr/G1+cHZEg
 UaRuHRH1uvppMXb/zvZUpH8ExYDFf79hyRbnWYbJFuCYY0gGPkeLRynhENapXyt9
 /dOjLi1ORPWIHOU7ZMlXruTPBnvEt6Y/nhosVoh6X/QC1nKUjL01bJFXYZgTxyIe
 8tXP0HcM/bkn2mha6apKKEwZwDolYeweWhsMbGuJ0vHWUmTBEMEpP6o6/EqLUZTz
 W3O8Wdg6ECVr9TUMVdXMcI6eLyktQH95WAxc3ElpoaWsdYbm8kZa+RKlQjcaf7NU
 ApNj3pEaJlOLsvD40fBKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065278; x=1770151678; bh=j
 EmCW2CJeKwiBoliiD/nWnWhBy0/mPCAScNKxecv+dg=; b=K90OzCCvPU8T9JCLh
 jMx9kL/ZWrTwg/4y0cWVZnrFACMWfQR2iGx109L5l5wLvp0qeMj+3vinEA9EGLbl
 AV/xEJb39IT4VG53h3x6D/GlD9kpZVkwFO0Ih8DIIGl04Bva5sIaB9r3Ibpoq+tI
 I3ucVzapi8RQ8Mp09FZNHWfKZEx5zIbmaFLDLuX1532gduYVF08Fry0XhXVpiNpB
 5Xc0rUNij7xb58zWnQg4rQC7hr4q0sfhvyTT3vHdhYVPebqEgOfGc0k42o5+tta7
 maeND/ZCuaSIzX2XHc7KnKjT1qu8fNfSf+cpsfSnNEv5i3izR2a/iltRiqOf5fJY
 5P3EA==
X-ME-Sender: <xms:fg2BaW4CMK_adW932pfAJZyB374YMl4ZwXaSeBioRcToKXVps6616w>
 <xme:fg2BaXXU2Qwf3uvIgJnLkZzQdlG-qKngIOTIt6KOg6Ci2i9lcxd289dHqStTws0_n
 J75eFwEK_6WW6EVPlAUYdWWqUkeYee739w_jehTdxiJZFdIE-qQCp0>
X-ME-Received: <xmr:fg2BaS2c-rNtH3Kwshij0dvSfU6gVh2MDH31xHMOqzY_xBNSdyp_ILavpk9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:fg2Bac1wS7IP0r0Euakyhs-MPZQ-45tPu4vF8xrVipLyq_ZSGGTrvw>
 <xmx:fg2Bad-w1N7uoqUt7wsKXiE0RLB6vsNGaW5lt95Lp7RheQcbflcayQ>
 <xmx:fg2BaR0qnXFkzXcw0mDxU-mUMn_b_kPN_R7BxS9dXO349TD4Mvd3tg>
 <xmx:fg2BaS8GUPqfuPU3u6Riw08VNg935xNt-YRR8LQ_nRXi2mdHbbZNYg>
 <xmx:fg2BaQizPnduKD7a8P2HKfFUCPsXLGjxBz8AHjDCGhMfv-f_obLbfnr7>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:47:58 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c7ba76d2;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 07/19] ati-vga: Remove dst_x/y updates after blit
Date: Mon,  2 Feb 2026 15:47:25 -0500
Message-ID: <20260202204738.3080092-8-chad@jablonski.xyz>
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


