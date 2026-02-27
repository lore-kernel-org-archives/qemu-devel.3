Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF94FEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4e5-0001tj-N4; Fri, 27 Feb 2026 15:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e1-0001Sp-Gr
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dx-0007Pc-5c
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:04 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id E67C2EC063D;
 Fri, 27 Feb 2026 15:40:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 15:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224859; x=
 1772311259; bh=t0OpkvKmgs3r3p5IFcwqLrOzfIoWRJB1S+bWvMool0c=; b=C
 eV/gHxuXv9p570wMLN3NRTeP4GeuYVUefZBeSNKTtF4GjOSvd6erlvNv4o8i3Xd2
 fY5dwkrCDiHZuqYRiJBCPDTVdHmHz65XO5+LRnKjuiH0KLGTNQffIWksnMb/6+E4
 sYQBVxIVLSpyou729dN+H/5vMGQPnSP8/uZoClgUE7bHQL+S2aTA00kZ2vpDvtoQ
 /vbJ0wada2Zlj7UXGmj8+wO0wMm4eBdzL5a0cUo32ntSHn8Mezu6soX9QozivqPE
 qNs6JDZbpKDDobk4Z1CkdHBu0aiZ93TsETJtjMQuDUzdrLSYPeZy7x4z3Lsku6+3
 uS5iUNkONLYW4escleKyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224859; x=1772311259; bh=t
 0OpkvKmgs3r3p5IFcwqLrOzfIoWRJB1S+bWvMool0c=; b=lrW2RDvhN/U0CmhI7
 JYRDPzLYkPEl4mFHBduQihFTI+/LTOoz/xZcvokejgCZxagQW7W1U8wf8b4iflAZ
 MK3f7egIcNY7trRZGMhtTs7exH7RLDPoXmNu2bgvZz0CzFdp2Q1IwOf1Ynb7FjOo
 HABuRFGMLNGOAwF+LEnbKqxk5GqSpZcsNfW+lUsLpy/10/m/jKEesuWNibqoikBY
 A7wzIxBgO/3RqoU+q0BnShUBjxVNpU+HpxjvAdRoSRxNGSgRBqgOQBR6lhtPD+0z
 V2x4COxKzIHRE5zH4xmEeHnhRyQi5XbtzP1uDJDEe87TwHdXjovA3KXCPQP0Mkcj
 R0DFg==
X-ME-Sender: <xms:WwGiaY5TCqsByxfXh55svCup0CJMGVaoDUl6Zg9V-1yvRTiwTXrqYQ>
 <xme:WwGiaQwOjGDGWmYAU9LZqyUz4sTM1RDa7zCNgT7ju2Df_a8NGSwNbL0sEc5ihqgqk
 4OkMhWdl5vlYJkBWACnMWw_ao5aC_j7JydRoxZFgy5BaI1XDuF9iHo>
X-ME-Received: <xmr:WwGiafxVY-7R9rjdYszb-Ma27GNsVcIwQQv7qzjKCqkfL33Faea9TfGidBbD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgv
 rdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtthho
 pehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:WwGiaYwufRGKwrKsaPOsK2GtS4WV3vmEijDFST5x8B33Tbf6aVvAEg>
 <xmx:WwGiaZZWRHCTVS8_ZczbOjWy8BiEj5Nzz0GhxSAMbzV7D5FdFHqjcQ>
 <xmx:WwGiaZX7Jx3y8RZ1w0PoJtu71sVds97b_t-WwgqRhSXIufV5Q2-pmg>
 <xmx:WwGiaXhEo8-_Xt2lpqW2L7IzYCaE5HCBgo5aPinQ5cMhNfXhJmJmrQ>
 <xmx:WwGiaaNq-vFXSQWwXWp8t_ZM0W2oPTf2D-Qr4sis3WqwGiDXs_TniJxf>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:40:59 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c45cbb91;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 06/18] ati-vga: Add scissor clipping register support
Date: Fri, 27 Feb 2026 15:39:32 -0500
Message-ID: <20260227203944.746471-7-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
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

Implement read and write operations on SC_TOP_LEFT, SC_BOTTOM_RIGHT,
and SRC_SC_BOTTOM_RIGHT registers. These registers are also updated
when the src and/or dst clipping fields on DP_GUI_MASTER_CNTL are set
to default clipping.

Scissor clipping is used when rendering text in X.org. The r128 driver
sends host data much wider than is necessary to draw a glyph and cuts it
down to size using clipping before rendering. The actual clipping
implementation follows in a future patch.

This also includes a very minor refactor of the combined
default_sc_bottom_right field in the registers struct to
default_sc_bottom and default_sc_right. This was done to
stay consistent with the other scissor registers and prevent repeated
masking and extraction.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

---

v5: Removed unused default_sc_bottom_right field
---
 hw/display/ati.c      | 70 +++++++++++++++++++++++++++++++++++++++++--
 hw/display/ati_int.h  |  9 +++++-
 hw/display/ati_regs.h |  2 ++
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 26fc74b19b..6cf243bcf9 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -514,7 +514,32 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val |= s->regs.default_tile << 16;
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        val = s->regs.default_sc_bottom_right;
+        val = (s->regs.default_sc_bottom << 16) |
+              s->regs.default_sc_right;
+        break;
+    case SC_TOP:
+        val = s->regs.sc_top;
+        break;
+    case SC_LEFT:
+        val = s->regs.sc_left;
+        break;
+    case SC_BOTTOM:
+        val = s->regs.sc_bottom;
+        break;
+    case SC_RIGHT:
+        val = s->regs.sc_right;
+        break;
+    case SRC_SC_BOTTOM:
+        val = s->regs.src_sc_bottom;
+        break;
+    case SRC_SC_RIGHT:
+        val = s->regs.src_sc_right;
+        break;
+    case SC_TOP_LEFT:
+    case SC_BOTTOM_RIGHT:
+    case SRC_SC_BOTTOM_RIGHT:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Read from write-only register 0x%x\n", (unsigned)addr);
         break;
     default:
         break;
@@ -877,6 +902,16 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             s->regs.dst_offset = s->regs.default_offset;
             s->regs.dst_pitch = s->regs.default_pitch;
         }
+        if (!(data & GMC_SRC_CLIPPING)) {
+            s->regs.src_sc_right = s->regs.default_sc_right;
+            s->regs.src_sc_bottom = s->regs.default_sc_bottom;
+        }
+        if (!(data & GMC_DST_CLIPPING)) {
+            s->regs.sc_top = 0;
+            s->regs.sc_left = 0;
+            s->regs.sc_right = s->regs.default_sc_right;
+            s->regs.sc_bottom = s->regs.default_sc_bottom;
+        }
         break;
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
@@ -956,7 +991,38 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        s->regs.default_sc_bottom_right = data & 0x3fff3fff;
+        s->regs.default_sc_right = data & 0x3fff;
+        s->regs.default_sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SC_TOP_LEFT:
+        s->regs.sc_left = data & 0x3fff;
+        s->regs.sc_top = (data >> 16) & 0x3fff;
+        break;
+    case SC_LEFT:
+        s->regs.sc_left = data & 0x3fff;
+        break;
+    case SC_TOP:
+        s->regs.sc_top = data & 0x3fff;
+        break;
+    case SC_BOTTOM_RIGHT:
+        s->regs.sc_right = data & 0x3fff;
+        s->regs.sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SC_RIGHT:
+        s->regs.sc_right = data & 0x3fff;
+        break;
+    case SC_BOTTOM:
+        s->regs.sc_bottom = data & 0x3fff;
+        break;
+    case SRC_SC_BOTTOM_RIGHT:
+        s->regs.src_sc_right = data & 0x3fff;
+        s->regs.src_sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SRC_SC_RIGHT:
+        s->regs.src_sc_right = data & 0x3fff;
+        break;
+    case SRC_SC_BOTTOM:
+        s->regs.src_sc_bottom = data & 0x3fff;
         break;
     default:
         break;
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 708cc1dd3a..98f57ca5fa 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -78,14 +78,21 @@ typedef struct ATIVGARegs {
     uint32_t dp_brush_frgd_clr;
     uint32_t dp_src_frgd_clr;
     uint32_t dp_src_bkgd_clr;
+    uint16_t sc_top;
+    uint16_t sc_left;
+    uint16_t sc_bottom;
+    uint16_t sc_right;
+    uint16_t src_sc_bottom;
+    uint16_t src_sc_right;
     uint32_t dp_cntl;
     uint32_t dp_datatype;
     uint32_t dp_mix;
     uint32_t dp_write_mask;
     uint32_t default_offset;
     uint32_t default_pitch;
+    uint16_t default_sc_bottom;
+    uint16_t default_sc_right;
     uint32_t default_tile;
-    uint32_t default_sc_bottom_right;
 } ATIVGARegs;
 
 struct ATIVGAState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 0a0825db04..3999edb9b7 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -397,6 +397,8 @@
 #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
 #define GMC_SRC_CLIP_DEFAULT                    0x00000000
 #define GMC_DST_CLIP_DEFAULT                    0x00000000
+#define GMC_SRC_CLIPPING                        0x00000004
+#define GMC_DST_CLIPPING                        0x00000008
 #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
 #define GMC_SRC_DSTCOLOR                        0x00003000
 #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
-- 
2.52.0


