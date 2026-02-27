Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9821039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4e4-0001jU-0O; Fri, 27 Feb 2026 15:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e0-0001Pt-0T
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dx-0007Ph-6R
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:03 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 128C214001DD;
 Fri, 27 Feb 2026 15:41:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Fri, 27 Feb 2026 15:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224860; x=
 1772311260; bh=jEmCW2CJeKwiBoliiD/nWnWhBy0/mPCAScNKxecv+dg=; b=e
 hH6Eu9NRpui14eWRqkGPxAiwRSsh61OvB1I9VsR3GUKhSJ1KzG491pItRoPOTchG
 RMXm2tEcOEwr999kA2celFK2SvxQz6T2UGzYHJydBL/wBDvJ5VdiakCb5g207R+c
 8qucVwGjgVClO6sa5GJnYiWTKAJVoimSnvreXs5Pq61CbpfWvGkLccOeq30Cz9sr
 3UM3BYKXZugrGlB529eMnVV4g8VAaCKPXW4tWUQR7nmZNpH02v5FZKDUHbkZwUw6
 c7ZIWg3AZeJJWlHyy95yKJaLeQQME3OULG9Ml6iI0QgG10hb/bjKSQkUK6Ic421w
 LAJ1dNPkV+lScaLq7Ysjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224860; x=1772311260; bh=j
 EmCW2CJeKwiBoliiD/nWnWhBy0/mPCAScNKxecv+dg=; b=M9NwLFpERbG4qyNIQ
 pviZNFw7pgGEMarIHzcyg0hBSK36E5o9BAnmADUthysO76DSTzKV82Fw59HCZDkT
 IN0t5JEWL5qDwApEKfK7HwpJCTxgFhi8Djs1z2zkwuCj/ZiJRcDZurr3lvpcUoQX
 l/rGjoux+2omOvtpBzL9zm6e0QDU2l2Ot1T05qPcEEmyRJVphD0MfbxWMaoMODJi
 LZIc30HmAK6XdGdAg95PJLFVHiEIV2ZOFL8+h64zV5VENEwaFwvfzS+4nyNGeZKx
 ocqeZQ8pCEEQ6YFISTTQG5v8Bre6gGyfaoWUEZ9kO5u6nE+T0Z06VlhjfZF9qceD
 iOkKw==
X-ME-Sender: <xms:WwGiaTmQ4i4FngBfO43UMPqH5QL1eGZlA0DE81ZG7v70XAoQXw8ggA>
 <xme:WwGiaduEwwHddPQxD1dE5yvJm54_GNDYiblzRuWBD-zoY6ZMGeqAE7Ht_C7_8YyzC
 L-gYVZ_VmoCGOyjgRQJMTICEnQ8Nq_sz8EyOOZPr3Gp73PxdzsiiMI>
X-ME-Received: <xmr:WwGiaR_mknA4VUGAULhH_E7i93wuHXCXQtUT3ZGph8uwCEaAUM731IYpXQsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhgrgigvlh
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhn
 uhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtph
 htthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehmrghrtggr
 nhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:WwGiaXP_gHUEeVH-D1Cosjo6gua0fGduYD3t8blgkRI6aNzYsBMNbw>
 <xmx:WwGiafHSh1rNk6Jc--unMgJlBshbDc-fSEcRbmQGNZuWlqDoMGsxAQ>
 <xmx:WwGiaVSwgQtKP9zl1OHC3Ijdn4am-N0L49xT_L-4-dH2jA-6nLMwbw>
 <xmx:WwGiacvTTCZc4NAQRD-Afx74S04vryNmBf3UhFuktODSzSVuOOXFnQ>
 <xmx:XAGiaaL4LCxrpdbUYpTgODSYIcAYvBBX98yng9WqMwLPgMaS1bbv2SMw>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:40:59 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id aea6f75c;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 07/18] ati-vga: Remove dst_x/y updates after blit
Date: Fri, 27 Feb 2026 15:39:33 -0500
Message-ID: <20260227203944.746471-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
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


