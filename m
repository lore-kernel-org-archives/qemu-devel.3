Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E587AEB3622
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7e0-0006RU-O1; Mon, 02 Mar 2026 13:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dq-0006MG-B2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:15 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dm-0006Yl-8y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:14 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E43FF1400214;
 Mon,  2 Mar 2026 13:05:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 13:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474706; x=
 1772561106; bh=72VUUxOENriIzrtXiRCo7Wc9F3V5hP7hlc6LYWMNsPs=; b=A
 Nm1YqCB87Nwspg/B+q+RQJRxziXnSL5C/XrNopx/3VCWFBjlPfI95ZYOu6ehGzwl
 MTxSUi5epZChSYjZ4ebguxi9iqcDGz8TYMuzh3o/KtiNZy5M9BhuQmT0a4KdBMbN
 Hrs9k1RokEHaHL12jftD8rmHK6kg+wduvkl0GWbWJXQCjIBXiWWvJJdmrbtc/zq7
 g/ZUOtK1ju05VSOUWElnRs7gcZ1ir7AjKek/reDgP47UYYN8NkUmPPLV8CvJwEsR
 hB96tvoFpADKb79JVQHhTcXl5IVrKFJAhLoRNwbVAwF8xE5RwgwhzFJsIm+hlNrZ
 yTVDgNcw6yE1EAaXItxLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474706; x=1772561106; bh=7
 2VUUxOENriIzrtXiRCo7Wc9F3V5hP7hlc6LYWMNsPs=; b=o12G8mHuLJRvbuWvt
 JAmCvCjOk3JsJQoCQqOAIOZpjKQImbX6TCArLXft5kowlti0DOyluCZ0OT9XBxKZ
 kyfnbm++ud0KxlWMr4CkWTHwFf2FGJyTbC0sq0WyZTJSFevgS4ST8z5Ia9We1WT5
 s7Lv7LFL/rbR8oB5WkJXzPvDjVZ1uMELgBfiT7erd2/Pnz9MUXKRtBF942ipyIS2
 NHLFQKr1ocKwqmyz0eDunjCHe7e25VG4mAdya2JDK2WFPqd8J+zYrSFdbUG7OkAr
 99J26YpxbT1JJTnjLCoLlxSdoE6pYc2YG79M57Zml/lBnmHq6DeaXomt2mostjk1
 kYkNQ==
X-ME-Sender: <xms:UtGlaYevDXmRHdHx0G47bTmneBiO5uFBq7ZzhUD2s8h4671BnHn8iw>
 <xme:UtGlaRHtJ9SUDkj26tbzLMCYY_NUqCHcBSTOzOWV6jDSXQ5dpxc58GEjGMY_NuCVk
 2FlncuiMJ0VznvFtL1GGMHBl7QflpJxks8kTe-X8X2QiYBY1_tIYlI9>
X-ME-Received: <xmr:UtGlaR3JuyD0UveowmA8Ila5qRds9sORDtBT7lnGBUV-jLiJjj0HkE04pX0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepvdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgr
 thdrtghomhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtph
 htthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:UtGlaZnZAbl6i1fpU9Gcc6jP1qfyOFPJ6dgWb7kr3ZKY9UJzVihl_Q>
 <xmx:UtGlaR_ZautqvZEUugG5evbYoISTzL7ArHINlchfLJMT6nOygniXwA>
 <xmx:UtGlaeqlIErGuSkutNhIEMiTuphNeY0ZvM3ahuQzITVs1c0Ka4DKzQ>
 <xmx:UtGlaako6BrKFgBO2Vz7_DCWdZ7F-x1ydFvKadiUMpYuDz3MuCUCSw>
 <xmx:UtGlabjCG1paqNgL0UZZyCQv71hQdCVUm8XjKI72CiaRHRH1NomThEvA>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:06 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 97ebfa01;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 16/17] ati-vga: Implement HOST_DATA register writes
Date: Mon,  2 Mar 2026 13:04:46 -0500
Message-ID: <20260302180447.1078098-17-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
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

Writing to any of the HOST_DATA0-7 registers pushes the written data
into a 128-bit accumulator. When the accumulator is full a flush is
triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
will also initiate a flush. The flush itself is left for the next patch.

Unaligned HOST_DATA* writes result in, from what I can tell, undefined
behavior on real hardware. A well-behaved driver shouldn't be doing this
anyway. For that reason they are not handled here at all.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 30 ++++++++++++++++++++++++++++++
 hw/display/ati_dbg.c  |  9 +++++++++
 hw/display/ati_int.h  |  9 +++++++++
 hw/display/ati_regs.h |  9 +++++++++
 4 files changed, 57 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 6cf243bcf9..965110c13a 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1024,6 +1024,31 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
+        s->host_data.acc[s->host_data.next++] = data;
+        if (s->host_data.next >= 4) {
+            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            s->host_data.next = 0;
+        }
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
@@ -1129,6 +1154,11 @@ static void ati_vga_reset(DeviceState *dev)
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
index 98f57ca5fa..baa264215c 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -95,6 +95,14 @@ typedef struct ATIVGARegs {
     uint32_t default_tile;
 } ATIVGARegs;
 
+typedef struct ATIHostDataState {
+    bool active;
+    uint32_t row;
+    uint32_t col;
+    uint32_t next;
+    uint32_t acc[4];
+} ATIHostDataState;
+
 struct ATIVGAState {
     PCIDevice dev;
     VGACommonState vga;
@@ -112,6 +120,7 @@ struct ATIVGAState {
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


