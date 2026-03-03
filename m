Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFBEEB365A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFnU-0007pr-Qw; Mon, 02 Mar 2026 21:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnR-0007nr-1c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:41 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnO-0002q7-Vx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:40 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8455E14001B9;
 Mon,  2 Mar 2026 21:47:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 21:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506058; x=
 1772592458; bh=UFSgWoKS6dct4PEaVxUuYg6ee7pN7SwnivHZWSj1kps=; b=g
 SamIpd1qEFbxVugGK9JVOs4LrztGL3bkw/5Rrp/KwpCMpHxKDoPsXXSgSM5EXT/Y
 5N5/1H2VMr9KImBWl8z6roeutf8rwJn7icUMzwexXe/1I8soFTB8GPVI2M0WhqDR
 nL037NXSGQe/F0+sfmWn9gyjcNHBv7REa6TIJrUHkvstKbtHr5Or6v7RLR8WrhMf
 Tndj9noxMBPonKUk3gwBUD8AH9snCreTP3QZjVdh77udcel6z9fmvaaP1mFB5/Pd
 kQKzS5mUPU7cmxttlUIr9seW74btZMZlDr6Amq6Lw7R5BYuMSfhAKuKR2Z9ymV5m
 44Jg13WZC2cb0uzJUS6NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506058; x=1772592458; bh=U
 FSgWoKS6dct4PEaVxUuYg6ee7pN7SwnivHZWSj1kps=; b=Mrea8i8AOoo+zN3Rs
 Z0wo7y0z3RvjsgCqO3301MxHqPZB2k9j1iB2tDJ9Xu6IF4S4hcb4I6HvH6F2034l
 H1ny1vxKlGb5Z4ohdHsrRavmBD359cJRF00YVzEXmF1dMT0Iw0/zZ3GkRHnlmDzn
 EcNO9gMim92KHZBKyjBrrNtMl2XOcMWF6gY80b3qRCwkyOPrBHARmt9Rm3/RNt8m
 cyzjszhAx/qQ4UfIuOMu2O0654BVUKoagEfaMJ9aVpIMgNiVlVztq2MmuLDZuE+q
 +ExQVhmrWiPp6fxmktpskSZt6jbvWC3XaKqDKxv9XGqaHeYQMdCSuCO9WssY/ynZ
 RMG1A==
X-ME-Sender: <xms:yUumaUQGuTv4jFg932E9F3-bdXODVkgmjeN_ZUtsnYg-IIfjhH7DJg>
 <xme:yUumaYqpRYPuNdtlctClh4TdiLcDMYiPn1yI1KRFBTarqpVuSz_nUuloeUFKas4d9
 xj7iu2Zv59EJ7eEdkXlcIvxmJ3NLndfl5vNnZCqRu95svVP_xtytaDt>
X-ME-Received: <xmr:yUumaaK-RRVQI2pFAzjn7SRq5yivDJQeMG5if4LNsxf1NUCPxwCkDUrSIkBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhs
 khhirdighiiipdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhh
 grthdrtghomhdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:yUumaTrh8HZBByB8KchhykEg5jOaLHSFb0XVMH5VV-1d_thQXxXW3A>
 <xmx:yUumaay-dzFqpx_XSdgb2osJIsE_JbZ0RMbRdFbqIBqUsT4MwAAlNQ>
 <xmx:yUumafMQ15fVve196PhF6cpdFVxUWEmE63AOLMT083pYX1xlAM0qYg>
 <xmx:yUumaX7RCZC8XoBZE41IR4ObQgjs46QMAuaI18_y0qRmV1S0eTwQig>
 <xmx:ykumaZYacJdfpDK6IbKIUhApQyWNTQyG7G7c1t-hftMz6zh-lcryTbnw>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:37 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 0844e296;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 03/17] ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
Date: Mon,  2 Mar 2026 21:47:16 -0500
Message-ID: <20260303024730.1489136-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
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

DP_GUI_MASTER_CNTL aliases several fields from DP_DATATYPE and DP_MIX.
These were being written correctly but not returned on a read of
DP_GUI_MASTER_CNTL.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 8 +++++++-
 hw/display/ati_regs.h | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 777a6b0a2e..028efd13e1 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -460,7 +460,13 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val = s->regs.dst_y;
         break;
     case DP_GUI_MASTER_CNTL:
-        val = s->regs.dp_gui_master_cntl;
+        /* DP_GUI_MASTER_CNTL aliases fields from DP_MIX and DP_DATATYPE */
+        val = s->regs.dp_gui_master_cntl |
+              ((s->regs.dp_datatype & DP_BRUSH_DATATYPE) >> 4) |
+              ((s->regs.dp_datatype & DP_DST_DATATYPE) << 8) |
+              ((s->regs.dp_datatype & DP_SRC_DATATYPE) >> 4) |
+              (s->regs.dp_mix & DP_ROP3) |
+              ((s->regs.dp_mix & DP_SRC_SOURCE) << 16);
         break;
     case SRC_OFFSET:
         val = s->regs.src_offset;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d7127748ff..0a0825db04 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -386,6 +386,9 @@
 #define DST_16BPP                               0x00000004
 #define DST_24BPP                               0x00000005
 #define DST_32BPP                               0x00000006
+#define DP_DST_DATATYPE                         0x0000000f
+#define DP_BRUSH_DATATYPE                       0x00000f00
+#define DP_SRC_DATATYPE                         0x00030000
 
 #define BRUSH_SOLIDCOLOR                        0x00000d00
 
@@ -437,6 +440,8 @@
 #define DP_SRC_RECT                             0x00000200
 #define DP_SRC_HOST                             0x00000300
 #define DP_SRC_HOST_BYTEALIGN                   0x00000400
+#define DP_SRC_SOURCE                           0x00000700
+#define DP_ROP3                                 0x00ff0000
 
 /* LVDS_GEN_CNTL constants */
 #define LVDS_BL_MOD_LEVEL_MASK                  0x0000ff00
-- 
2.52.0


