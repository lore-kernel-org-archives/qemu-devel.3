Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925E71039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4e4-0001mL-Ef; Fri, 27 Feb 2026 15:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e2-0001bV-Q8
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:06 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dz-0007Qk-Q7
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:06 -0500
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 32E78140021E;
 Fri, 27 Feb 2026 15:41:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 27 Feb 2026 15:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224862; x=
 1772311262; bh=KjHEB8cmWHa2uUjg4kmJyfG0LpAhVZnYiRB4AQrz5hA=; b=E
 SxYhtSL8MF/7DHSryIVr/OYCVM2YnmAtCJP7wxUZ84BuD1vcm+IzjSNqCxxRVN3p
 zV/k0l6ijRa5WibUsOK6m9gaRtjdMBWSn39klzFm7zAtCgCF7ymZPSGCtPhMdCvN
 F2W7plX6BLFq1Peiq2YOScBYWyjx1GvfILo2Q1bM4d1vD3dj7nvtVPJ8P85N34GJ
 gIrl1/IhV8UtN9gFmZSg4Jy6Pq/ne7oIuHbO9bYt2vBdwQsyOsVcMWEticKhxVqb
 ywr07R1bCB/67OXfQTKDWi6MHhbIE0ZmDR0mDNGtTj+QTSdMTPMMlMYU/d4ZFWYK
 Hk8xCDMi92mKb1RWV+waA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224862; x=1772311262; bh=K
 jHEB8cmWHa2uUjg4kmJyfG0LpAhVZnYiRB4AQrz5hA=; b=mTug60T8f+W0CF3gB
 tchR9F4KamnY4ZHdPXEHzMvbTYMXChXLzW6QQLy1C0Vz62x9chJ4EeWBXQvEBmw9
 aVJ+ZFg1oCiXgamUI3szEWG+LPpe3lf0uLXRkb/nfOD6+kKIKnCX3GCLlpiJfic5
 d4FtrJ1Xf308HnJ/1JAWtgI2695jkSKFL1jzvfsvz1enaiiW5IHoMSIKQ6hglKIj
 dmzMwbMLFI3pIzRB4JVKeLWozCR63AXv/CYwvo3xPjxwCIsNdPk10f09iHtb8wZd
 tjyuYEjtwH/HVKw9YhYe/66FYxeW5TuxmfPsAbHgDPKD15ib/0PNpKAKNDohQlil
 zdnZA==
X-ME-Sender: <xms:XgGiacKpVWiuwRJArKjZCeOasvsL3o3Qgjtnd28RVmKyT4nlKRsKiQ>
 <xme:XgGiaTB6AjnwQrbF0MkH90A-QGqdLtvtByXlp0RJbstNn5bDGfMOLaAOebMzaw1LT
 ZhpyLCBRkpSeatfEGRGQmcFWh2ejaYtxRUWb0xgVW9GJTiuzRz2rkk>
X-ME-Received: <xmr:XgGiaVC5J2e2XFsmK_A0XFmd-jfkOWc0oa_JuGz3k-yxZsLGHC8pMmyS4VUj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhh
 grthdrtghomhdprhgtphhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:XgGiaVDxyFcdMvvseA5t1OsPQj5AfZ2XtNVLdCHMPg4h41ELI7ql_g>
 <xmx:XgGiaQpcMvTR0cVjysNWlLPKtGkIqDLIKwBt7XXbDiZUTlp1VpU6EA>
 <xmx:XgGiafmFVsEwH7EsQLpDrQujza5pIgFiJiJQxo-ri29l1ToAB-PfhQ>
 <xmx:XgGiaQwJ-tOifYhotGwM1YoFkmgh3LWM-xTdohYfDkIEnEfWSma-CA>
 <xmx:XgGiaQfYHVlaYXmaoiWyroxQML5cZPEeiMvvBl_xS6pM2WUPj3FuANSC>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:01 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 63ba524a;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 17/18] ati-vga: Implement HOST_DATA register writes
Date: Fri, 27 Feb 2026 15:39:43 -0500
Message-ID: <20260227203944.746471-18-chad@jablonski.xyz>
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

Writing to any of the HOST_DATA0-7 registers pushes the written data
into a 128-bit accumulator. When the accumulator is full a flush is
triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
will also initiate a flush. The flush itself is left for the next patch.

Unaligned HOST_DATA* writes result in, from what I can tell, undefined
behavior on real hardware. A well-behaved driver shouldn't be doing this
anyway. For that reason they are not handled here at all.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 32 ++++++++++++++++++++++++++++++++
 hw/display/ati_dbg.c  |  9 +++++++++
 hw/display/ati_int.h  | 11 +++++++++++
 hw/display/ati_regs.h |  9 +++++++++
 4 files changed, 61 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 6cf243bcf9..3757b8426e 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1024,6 +1024,33 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
+        if (!s->host_data.active) {
+            break;
+        }
+        s->host_data.acc[s->host_data.next] = data;
+        if (s->host_data.next % ATI_HOST_DATA_FLUSH_WORDS ==
+                ATI_HOST_DATA_FLUSH_WORDS - 1) {
+            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+        }
+        s->host_data.next = (s->host_data.next + 1) %
+                ARRAY_SIZE(s->host_data.acc);
+        break;
+    case HOST_DATA_LAST:
+        if (!s->host_data.active) {
+            break;
+        }
+        s->host_data.acc[s->host_data.next] = data;
+        qemu_log_mask(LOG_UNIMP,
+                      "HOST_DATA finish flush not yet implemented\n");
+        break;
     default:
         break;
     }
@@ -1129,6 +1156,11 @@ static void ati_vga_reset(DeviceState *dev)
     /* reset vga */
     vga_common_reset(&s->vga);
     s->mode = VGA_MODE;
+
+    s->host_data.active = false;
+    s->host_data.next = 0;
+    s->host_data.row = 0;
+    s->host_data.col = 0;
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
index 98f57ca5fa..b285b6eba5 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -32,6 +32,8 @@
 
 #define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
 #define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
+#define ATI_HOST_DATA_FLUSH_BITS 128
+#define ATI_HOST_DATA_FLUSH_WORDS (ATI_HOST_DATA_FLUSH_BITS / 32)
 
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
@@ -95,6 +97,14 @@ typedef struct ATIVGARegs {
     uint32_t default_tile;
 } ATIVGARegs;
 
+typedef struct ATIHostDataState {
+    bool active;
+    uint32_t row;
+    uint32_t col;
+    uint32_t next;
+    uint32_t acc[ATI_HOST_DATA_FLUSH_WORDS * 2];
+} ATIHostDataState;
+
 struct ATIVGAState {
     PCIDevice dev;
     VGACommonState vga;
@@ -112,6 +122,7 @@ struct ATIVGAState {
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


