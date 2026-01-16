Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7F9D4A5E2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoR-0005xO-Hl; Thu, 15 Jan 2026 21:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZoK-0005wS-D3
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:42 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZoA-0002SQ-IT
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:40 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id C83FD1D0009A;
 Thu, 15 Jan 2026 21:43:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 15 Jan 2026 21:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531393; x=
 1768617793; bh=Giln19+GMzGW7pT7qiuYF/kVzM9612KAuacwxQUBTcc=; b=T
 qevX60al9i2LXhLG8JV8cyhX/x59cK0efwBM493Q39P/dC0G93S01fzVsC6hhV3z
 3WOUGWIrpPG7DDQxz3VUhjgVywpiM6j6yqBhiy80uPt20OnI3JLYkUZ/wkEOryIE
 Mu4GjQyYmMc6CR43vMu7SkPERgecOOK5am4dMU8ai+x7FnkRE/Ai1EOhqErqdK4W
 xwIWSqnICpFj5jegHQ2ShLBXzGwXlx+vYBrfH0e3yFyCLnRXt0nUyDN9D9SRLb0F
 umCqfldGduzsDu9dZAKXU0RU985L1zkKGhuhHcn1kAN8XMGwe841+rsDz3+P0nVZ
 jGmB0biUVLWD43hCwRiRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531393; x=1768617793; bh=G
 iln19+GMzGW7pT7qiuYF/kVzM9612KAuacwxQUBTcc=; b=icPchWDTzi6dgHsOp
 /qe9qX9CUJF2FzDwww6Mt0pXuFjsJ0F3XwmjXOx98KmrIxadvWsaC4cxJmtc7Xo6
 rAx8gWKcAhIYvvcSyhldKxm8JpFhM7pIfsr9VfpWrHXpc7pg6oVpLx0kpVXPPNjq
 KZTzUm7FXaMt/waQKfoHUW6xbRKkJG1n7d2dxgQMoxITFXuih6C4Ad6rEqtiYOjA
 q8x6rrstpQL/LGOLyvTavwiu7ODfnRNAyzxTjlF/VURvbaTHf8HP+X31ef0g8RWm
 CwtjV/tJXgOzqMTMEBNHM6o+m/NxDE1TP3gPdbXS08wN2hZxcmkpg4goCo8dw+Wn
 iCb1A==
X-ME-Sender: <xms:waVpaX7i6kPEMCHLpnDTJJkYgHI_qdkroX2XyyUxF2v_eJAeHVNkmw>
 <xme:waVpaUWbebQVxq77yabEkc3SK9K7yW7mCoPj08b0ZJwUoqnnmhpPk6cOjn4uWt7mR
 WZ08f6LNv_0v2T42J2UotRe-5Xd806Hxe1Ypj4pREYi2Iuw0PVeNvvX>
X-ME-Received: <xmr:waVpab0iYUeHBpzY2klfXdfgyg9AnnHCqUpXraLPsbsMhtaqugXALhZkDmny>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:waVpaR0cmH7fhHEUJQsRf0Nk4iyWc3GSuxv2ijCoVLOAqtH5I4mnQA>
 <xmx:waVpae-BIwtMo-zEjrLUuAvfPZ6aPZVc6vDYaKI8WIBOaGjjT3h8Gg>
 <xmx:waVpae2NwLljbbpX7r2p7fMCiKI933i0tyrf2ulxFlMGe__HtQ7XUA>
 <xmx:waVpab9lzuD7Tea-SQt7W5kwJeL0_l42NQQX1FW0rN0jGXYD0hO3mA>
 <xmx:waVpaVgrB9Y-PZt-SN_6_WbvIqhmN89SS609Xa_4I-az6A5L1D9O9O-F>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:13 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 40158071;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 11/12] ati-vga: Implement HOST_DATA register writes
Date: Thu, 15 Jan 2026 21:42:57 -0500
Message-ID: <20260116024258.1487173-12-chad@jablonski.xyz>
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

Writing to any of the HOST_DATA0-7 registers pushes the written data
into a 128-bit accumulator. When the accumulator is full a flush is
triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
will also initiate a flush. The flush itself is left for the next patch.

Unaligned HOST_DATA* writes result in, from what I can tell, undefined
behavior on real hardware. A well-behaved driver shouldn't be doing this
anyway. For that reason they are not handled here at all.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 32 ++++++++++++++++++++++++++++++++
 hw/display/ati_dbg.c  |  9 +++++++++
 hw/display/ati_int.h  |  8 ++++++++
 hw/display/ati_regs.h |  9 +++++++++
 4 files changed, 58 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 21339d7e26..e6868ddb8b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -568,6 +568,13 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
     }
 }
 
+static void ati_host_data_reset(ATIHostDataState *hd)
+{
+    hd->next = 0;
+    hd->row = 0;
+    hd->col = 0;
+}
+
 static void ati_mm_write(void *opaque, hwaddr addr,
                            uint64_t data, unsigned int size)
 {
@@ -843,6 +850,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case DST_WIDTH:
         s->regs.dst_width = data & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DST_HEIGHT:
@@ -893,6 +901,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_HEIGHT_WIDTH:
         s->regs.dst_width = data & 0x3fff;
         s->regs.dst_height = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DP_GUI_MASTER_CNTL:
@@ -923,6 +932,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case SRC_X_Y:
@@ -936,6 +946,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_WIDTH_HEIGHT:
         s->regs.dst_height = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DST_HEIGHT_Y:
@@ -1031,6 +1042,25 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case SRC_SC_BOTTOM:
         s->regs.src_sc_bottom = data & 0x3fff;
         break;
+    case HOST_DATA0:
+    case HOST_DATA1:
+    case HOST_DATA2:
+    case HOST_DATA3:
+    case HOST_DATA4:
+    case HOST_DATA5:
+    case HOST_DATA6:
+    case HOST_DATA7:
+        s->host_data.acc[s->host_data.next++] = data;
+        if (s->host_data.next >= 4) {
+            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            s->host_data.next = 0;
+        }
+        break;
+    case HOST_DATA_LAST:
+        s->host_data.acc[s->host_data.next] = data;
+        qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+        ati_host_data_reset(&s->host_data);
+        break;
     default:
         break;
     }
@@ -1124,6 +1154,8 @@ static void ati_vga_reset(DeviceState *dev)
     /* reset vga */
     vga_common_reset(&s->vga);
     s->mode = VGA_MODE;
+
+    ati_host_data_reset(&s->host_data);
 }
 
 static void ati_vga_exit(PCIDevice *dev)
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 3ffa7f35df..5c799d540a 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -252,6 +252,15 @@ static struct ati_regdesc ati_reg_names[] = {
     {"MC_SRC1_CNTL", 0x19D8},
     {"TEX_CNTL", 0x1800},
     {"RAGE128_MPP_TB_CONFIG", 0x01c0},
+    {"HOST_DATA0", 0x17c0},
+    {"HOST_DATA1", 0x17c4},
+    {"HOST_DATA2", 0x17c8},
+    {"HOST_DATA3", 0x17cc},
+    {"HOST_DATA4", 0x17d0},
+    {"HOST_DATA5", 0x17d4},
+    {"HOST_DATA6", 0x17d8},
+    {"HOST_DATA7", 0x17dc},
+    {"HOST_DATA_LAST", 0x17e0},
     {NULL, -1}
 };
 
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 7cf0933fa1..38725c57fa 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -91,6 +91,13 @@ typedef struct ATIVGARegs {
     uint16_t src_sc_right;
 } ATIVGARegs;
 
+typedef struct ATIHostDataState {
+    uint32_t row;
+    uint32_t col;
+    uint32_t next;
+    uint32_t acc[4];
+} ATIHostDataState;
+
 struct ATIVGAState {
     PCIDevice dev;
     VGACommonState vga;
@@ -107,6 +114,7 @@ struct ATIVGAState {
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
+    ATIHostDataState host_data;
 };
 
 const char *ati_reg_name(int num);
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 3999edb9b7..48f15e9b1d 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -252,6 +252,15 @@
 #define DP_T12_CNTL                             0x178c
 #define DST_BRES_T1_LNTH                        0x1790
 #define DST_BRES_T2_LNTH                        0x1794
+#define HOST_DATA0                              0x17c0
+#define HOST_DATA1                              0x17c4
+#define HOST_DATA2                              0x17c8
+#define HOST_DATA3                              0x17cc
+#define HOST_DATA4                              0x17d0
+#define HOST_DATA5                              0x17d4
+#define HOST_DATA6                              0x17d8
+#define HOST_DATA7                              0x17dc
+#define HOST_DATA_LAST                          0x17e0
 #define SCALE_SRC_HEIGHT_WIDTH                  0x1994
 #define SCALE_OFFSET_0                          0x1998
 #define SCALE_PITCH                             0x199c
-- 
2.51.2


