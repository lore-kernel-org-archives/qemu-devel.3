Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3837DE9D40D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1S-0007BA-IT; Wed, 04 Feb 2026 11:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1F-00071z-25
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:22 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1A-0004YI-5N
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:20 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4DB0F7A0114;
 Wed,  4 Feb 2026 11:46:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 04 Feb 2026 11:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223575; x=
 1770309975; bh=yF27HNX02Ru9Co1eGRAH4G56t9l9sU85B21tcUxK7cQ=; b=o
 fA18ff30Xs9kRE8iOBVjER20V9bw0oyLBF9cAtpjFSLKzPVxvxo+L5FlczMc4Ibj
 gnyFG0m6xxjukTxHc6F62NFW8OtJXGGOBr6rf80JJoK5Rmtb3p4uQuFsaoS4ZThL
 LMM/ViZClAuaoU+5NbDNzRF+lUbOKNUkw65QpvJSFM4cXn56cBREAnl8/5S1BZPf
 cyxDkjwq9Fd6c9NjUlV6eHAz9oepDDv4X4LT5AiP3A1poMnmcMTzSLkYx9+3+P3c
 w59Uc5KT8u9qI1ubHdgGcv3f+JRjC8Kujk9z2gnH2m/xaQnYSqmG/Jx/7t2WZYZy
 6yX2XEOEAFw9mADT1VeJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223575; x=1770309975; bh=y
 F27HNX02Ru9Co1eGRAH4G56t9l9sU85B21tcUxK7cQ=; b=vWXVUlP8li0vjsnVY
 Qeeo/wbsOPBM79oup0x+5/uN1WWwrNE1Rw37UqMH1M8LwagAkyUU1WSAfFU8SC7t
 heox3Aw+eRwdLWgjFm/8bC+eBabUEwtOlF3z1cutKsk24hS4dWvABcNLaQ+YNZO4
 k/COkmGyPIem+qTdE8f3GOwdUQf5th5QuH5W4tikH0pcylCZuk33H7JlV5BvRt2L
 ch1h8dNHxxNfv3AH6WSqhZ6XRR5sf7OL5kKqXZd7+OIvB0uW0H9PW//ZTCtknQ6Z
 OjvKL658ONTgX3Ae9JRfDW/zqg1/e496PYjBBvH2oKP2lJJRHPKJiNMjuM3FAzxz
 wW8mw==
X-ME-Sender: <xms:13eDaWYs_xmryopEYKKHeC-9P4uK9x8NyLJKyjr_Nb3GPDhaTV6ETw>
 <xme:13eDaQ2DY2cx0-DmtogY8-uNJYvOALnbHWPdkAi2ICpWOyWuHxyvVqW5xAp6MEyd5
 DzZLKXkj6QQDGr0L42AQkiEw2WHjkCpC7fEEPiDb5a_5cg7_qCt>
X-ME-Received: <xmr:13eDaeWClrcvfpX2yv_E1FOtnNLFNUICRdv61XWhIM2LZW6WTru6rlJTFRe->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 gthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:13eDaSX9lY5hTl1Xi6JZvsuNyTMAFC8jQ71edrEkk1CSIijCjijv9w>
 <xmx:13eDaVeCyVXXtzo35_oLcDPFFkpKoWSKRhAZ1TO7hOtI8RlzrdA2XA>
 <xmx:13eDaTUqrDbdvoMbq6mk39d4VL7oIrXpFgVb1lJ_5-gdJQ1ma9eA4g>
 <xmx:13eDaWeg6EHh2zKqeNRf7PcJ0kXYF-p-DKO2Gyf3bz8Ep7A7PZOicg>
 <xmx:13eDaeB44Lm34-IUO4SiUoPw9yhE-OtVKdRot2dJYyMIg8p10RkpkO8_>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:14 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 1872e1e3;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 17/18] ati-vga: Implement HOST_DATA register writes
Date: Wed,  4 Feb 2026 11:46:05 -0500
Message-ID: <20260204164606.3425246-18-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
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
index 6cf243bcf9..fd717044b0 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -561,6 +561,13 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
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
@@ -836,6 +843,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case DST_WIDTH:
         s->regs.dst_width = data & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DST_HEIGHT:
@@ -886,6 +894,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_HEIGHT_WIDTH:
         s->regs.dst_width = data & 0x3fff;
         s->regs.dst_height = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DP_GUI_MASTER_CNTL:
@@ -916,6 +925,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case SRC_X_Y:
@@ -929,6 +939,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_WIDTH_HEIGHT:
         s->regs.dst_height = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DST_HEIGHT_Y:
@@ -1024,6 +1035,25 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
@@ -1129,6 +1159,8 @@ static void ati_vga_reset(DeviceState *dev)
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
index 98f57ca5fa..ef474e366e 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -95,6 +95,13 @@ typedef struct ATIVGARegs {
     uint32_t default_tile;
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
@@ -112,6 +119,7 @@ struct ATIVGAState {
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
2.52.0


