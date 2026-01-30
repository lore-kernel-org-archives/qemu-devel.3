Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3DDE6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppP-0004j3-2w; Fri, 30 Jan 2026 09:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppM-0004hL-95
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:28 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppI-00036y-Ir
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:27 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C728B7A0141;
 Fri, 30 Jan 2026 09:50:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 09:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784623; x=
 1769871023; bh=93m5K3mwe7rX9UqBEPwE1rQTynd+jGhfDku81BoETLE=; b=J
 0yZbhV196w6EA8T9wmnCKuxir/zUBiJEUDKFhteY6WzCCfjBCoe2lbRzBdQDXkoQ
 of89nbo1D5p3PRAUN9wXQU+F0Io2vn7woqIkO4ygEC6XTNm8owVRXk9hmcgvQH/F
 jVG5p2DgSitiAKlOR5ptg7N79HOlquuttqBoIK2hQJPPONoKS63IgGDaKDXMGiQM
 L13p0/IhF8L6PoC0qct7CHdzkA+jAfIBl/uAonJ6RVrVrvQnhRj23HUGVwxUPlsS
 YAXIzXzKoxeY4vTl/t4ob2s/akng9xhuYO2auXImq2jDA75WfMCXabaiR8h0lZQ/
 tZVzFBG/mVGye9yAkR+4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784623; x=1769871023; bh=9
 3m5K3mwe7rX9UqBEPwE1rQTynd+jGhfDku81BoETLE=; b=lr5PB0khwcEfFKhe0
 rTASL2ikayZBxzqgqzlHbZtTYocOjeNI0PSNGAEKCUyy4cOl3rlJSZE59BQdZWU9
 KynRmItumyC08ecBaIO5Cw4aGdaRFkaaIPCaIIIOHQVEfyqKapsadQKs6ff2p0VJ
 2icp0xBbJ3CaE20BpUztt1lZgB/yLTPOxJTFb7ZSz0h22k5eCMajQKzSTInCKhDN
 cQGwu1U5xcTfyv6LQVOavK1/ZAgQU7iYiMS0ENKW+biO7JW7INLLTZm+uyzpp3l0
 RBiCTKyGuX/5GwM6mW2ltFDpcM2LHFc3XQw7ijMnwgtl8kRWdYWEr7Clq/iSqkPj
 bdDvQ==
X-ME-Sender: <xms:L8V8aX2CUWZYUEz1I1M20fgXjvL2jYFT2xmpzz1XfJP7slhRRtQuXw>
 <xme:L8V8adjU_i7iPak__bVHJCesJlspCXaMVKUZ2-wQ3TsF1vCkNMJ7t7Nr45Mu0CyS1
 ok5qCgB1yry7DSRAM6ztFHH-RrgDuaWdDM73Xv2QUYsg1344JtmXfFG>
X-ME-Received: <xmr:L8V8aVS4WLEBBmSsMP2z2X4IaeC8o6jLlNTfaUApsVty7_MazA5tdujLObmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:L8V8aWh3nOaAq22KG_YaxkP2zIsAUB-TqMCd1QhRdIScTLrlom8Vfg>
 <xmx:L8V8ad7CJ3IgFlcjgVF8YyixgsdGzyHlXJ9dLlFyVk5n3MthLJ0XWQ>
 <xmx:L8V8abDtOocQJwXSn9r8od02OkrhbswsYhzAp8g_fnHMkt061-FtiA>
 <xmx:L8V8acZdtrGif-z6kBEPXzzGftPgY1Vp-9UReYCsCE3j32ylUlYQjA>
 <xmx:L8V8adMpyyUU33ZiojnPIYyWyERVJ0Cj7mGv4SGbfECpYc8I2RGjsTER>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:23 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id dfac4bde;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 07/20] ati-vga: Remove dst_x/y updates after blit
Date: Fri, 30 Jan 2026 09:49:52 -0500
Message-ID: <20260130145005.731129-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
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


