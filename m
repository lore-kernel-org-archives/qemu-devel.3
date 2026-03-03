Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE68EB365A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFnY-0007vF-TQ; Mon, 02 Mar 2026 21:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnS-0007od-69
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:42 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnP-0002qG-KK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:41 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 26C02EC0579;
 Mon,  2 Mar 2026 21:47:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 21:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506059; x=
 1772592459; bh=jEmCW2CJeKwiBoliiD/nWnWhBy0/mPCAScNKxecv+dg=; b=m
 aicwhQBMxgLK2yziK/Qfro5+QqeZ41UIvrodNVn07vIvya5PATDR5wyVa/ORnAyt
 JDFIlCBvEKJ9cSZMASEdP2v/K674e+FLjcEwRex7bltBpMynV1poyIcx3VfHER0x
 8ExBmv5jS2/5qMdlTbmQMB/NC5NV2U+GMC3yRa8BQO6dmM5ThMMe+u5OJkreDudQ
 igIPMp6nXgwt+MDZ7G+MXBNQDxiFOuIL8UA4VPg4VA6BjxVFUizKpk6BPMqpDHcn
 92edXOR0fyY2Ki2M2qWC/ypH27m2nvxU3D0WUjKVaXRChphlN7Ax1MOHHvrbxrZg
 T0UMBy6HyIEYSMYaXkRAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506059; x=1772592459; bh=j
 EmCW2CJeKwiBoliiD/nWnWhBy0/mPCAScNKxecv+dg=; b=Jb/VIxSPa0XEuwV/W
 La8v8KZdfOn3L8XIsr3MGT5Lj77YVQXjkZDYsu9aqAwb3PQ4ZS9NnVtWuXpV0KGY
 7EIJEjhFjrhghcUzJEJIJyrm0shzexbVjmGj5kjq1QjB97UwI1vTtIoamvcm0IkE
 FES571adrkFt7e1wd5fQhw7wITRkUageLYiuolUiOHbJvpwY+u6oWJeFqiOizJ2m
 q4S8m5S3oHPTV7PirCIxgjSYVWssvYiRZpYSu0zWQj9F9GooY30sdm7l1zePrdCH
 KFoKuiMnWyCNRTwtvATjG+h25VFSHVet6pHz9phL/FK7Xuteh6/E2T7dsIBeGRAk
 J/NMg==
X-ME-Sender: <xms:ykumaeDeo_5ooxpqFRjqJiMuNHvtFljrvEaHTgO4bHf1D4_a71wHMg>
 <xme:ykumafYLsHeOdRjivNYouQ0CoBa9QqWiiYkgBErxHf1FFCbQQnh-WZa_iHoYTIgzD
 f4Jo4yGAr95LSR-DFXY8pnv90ISpWklUCZZbwCA3lUwQUCvJHPB5zs>
X-ME-Received: <xmr:ykumaZ6ujh5db376mfPXyGCPxwQK0YkqP6qBaPdtM0lhlmRItlbHa5ifD-L8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehkrhgrgigvlhesrhgvughhrghtrdgt
 ohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtph
 htthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:ykumaYZ367Zj3YKUvF-eedDWFyymuOVQWCcHzZb1xSLdCK-s8EoxDg>
 <xmx:ykumaQgFQggiudmn2XI6xIhzbuN__C_pB-KUbtOYHdy-FsgZlIpBtg>
 <xmx:ykumaR-u_WsBRrdRnq2VKBiax7pm9l0yYSIJ3GS5D6J-kmAxWlvkFw>
 <xmx:ykumaTpFQKLgpsPtno7o3paj1KvL6hWHAhqFQBk5yBTN0FiShlEtjg>
 <xmx:y0umaa0gVTYgRUqU-c0XShlpAuJUHJpxomFkdXaoKgnkuXMQCJIp8DnW>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:38 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 7c9365a8;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 07/17] ati-vga: Remove dst_x/y updates after blit
Date: Mon,  2 Mar 2026 21:47:20 -0500
Message-ID: <20260303024730.1489136-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
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


