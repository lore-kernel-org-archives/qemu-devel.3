Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC45DEB362A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7dt-0006M3-Ba; Mon, 02 Mar 2026 13:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7df-0006Ca-G9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:04 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dd-0006Lc-6s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:03 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 7F140EC0608;
 Mon,  2 Mar 2026 13:05:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 13:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474700; x=
 1772561100; bh=UFSgWoKS6dct4PEaVxUuYg6ee7pN7SwnivHZWSj1kps=; b=K
 I+huPwyR0VyecmIU80JQXyQE5QrOMPOe8FrjW+BoicxlBAVj2cZEfe6SdCxvKWmj
 Rv10/PKD270x13px2+55GiQuqWUaeQ0PUQGaT969/NnfNqORGwV8ofy8S1fPK0nt
 npSW6EpK2IWgLgEQ/IEjjFP9ydl9yg8bL0M/Wp0r2T5mh3tzw2PagQIWi/3JvzCW
 tmqLnRFScHQlyxTsYDNv7KmPaYyK40jLWaRTqq8pGZ7KvfNp4ksOPIjVelo6jKu2
 7+PJmDgJKxTYpvai85UAPAbZKkz+mp1bGtIV+hq4XGMA8OadGihglqsIeIPG0sx9
 PMjizom/s5XrDTLM35o6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474700; x=1772561100; bh=U
 FSgWoKS6dct4PEaVxUuYg6ee7pN7SwnivHZWSj1kps=; b=ZUocROgMjHpUJp2+N
 ry+6cYw8BNrhtDpJgngoePhXvdRNnmoiCXqDEXFKPBsOONnnEjrx4K0JuLL/lXCB
 Nfi9d2v1Ch+FR8QKVkM+GgAQAY2RY4bonOHmhy4rNsGI+3/5tl2bDOLEq4ikcrj4
 L0MbrBzKkSx0CkvyclnCzjA7RlD2WicMndZPVuq+6A5/87cD8DefsaIkaid9ybQ6
 mKIaxMKOwpqjwqCbL+u4elHvA3xFP82XSKT4ok42cqNykzHdLCwQcVOetzUOBn5b
 b4ptDexMLy3NnlPi6LOmwz7vdaT32dhVLx00V2rT5Vkpk3xixyLsPrfntpeor7W4
 mEPIw==
X-ME-Sender: <xms:TNGlaTNjX-Sz08ob8HewkSMplWcCJWSOvPlvxxmDjqOhfBr0pnhC4w>
 <xme:TNGlaU317bfl_9wJ9Ht19sWy-WRasyP1D7IqhXasbyMoi-W0B8ocFPLZfQRS0t4ZI
 MG1BB0XSnk-ODNGb_8eoU47mSHFbddmzlKK89gN8X2paJCW_wLPdX8>
X-ME-Received: <xmr:TNGlaakyw6a5znA7DtycAzxKMY5MAad780mf493S-d8NMa9lbyG0TlMW6l6G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhgrgigvlh
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghu
 sehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnh
 hurdhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghp
 thhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:TNGlaTWSDSgNDRgZe6Xzl6c7h05RplxhBSt6hQlW8Rwd8ijYjJN30w>
 <xmx:TNGlaYubFDPyqz9YEJvP-n71-RU5FL1y4yzQMmYpGHTBvhiDW1Yhmg>
 <xmx:TNGlaeZ1pTVrrqng8MphNyCvaYRp1yVHttf7ZSkI8thfEmSOMqdwEA>
 <xmx:TNGlafUeofkFuIIfzVWyr6jOhrBTyZTs4mpXHlfMpwbSyDdhSBQIJg>
 <xmx:TNGlabS33_EeLFDWIi9tXy1ECL-ZoJVjbDPJSTzeraLjGpG2aTCpavQl>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 52d87b14;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 03/17] ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
Date: Mon,  2 Mar 2026 13:04:33 -0500
Message-ID: <20260302180447.1078098-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
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


