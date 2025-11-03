Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16CDCCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlMz-0005iq-LH; Sun, 02 Nov 2025 22:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMw-0005hH-7g
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:35 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMq-00080O-Vh
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:32 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 848151400100;
 Sun,  2 Nov 2025 22:36:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 02 Nov 2025 22:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1762140987; x=
 1762227387; bh=YlyWBdnfOsCvUMA5G3xXi4mdNN70nToWOgum6MiROdg=; b=D
 4Gx9/dR+bYiCGtQUSGhFG5a4tSdJWPSVWRe7+2Nys8x7368e1PY7vMONGgejxEkz
 HwqPzv3CkqB25y39No1S1QqBQDIvW9vqQS2EQRXM4De6mzVr33fbLihnnYYgtKIo
 A4nq0MglcS5qTrNcjpwZQqWfXBtznMq7+YaTnMrSToFhcD60JVL9I9iRRk2z8pFl
 2koth3uz90lk4EomzJDFQ3YrlXNx3H89UqNjBY9iMEjGXBG0hr5y3VVL68dCRAzK
 6tspoWOaLk/CZp4mEM/W7feQ/2gnLVobmu1b/AmzKQaNU6ys8kAbk9yWtZfMJBJv
 jOwazL6788pAfAwKL3HoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762140987; x=1762227387; bh=Y
 lyWBdnfOsCvUMA5G3xXi4mdNN70nToWOgum6MiROdg=; b=ZsO2/xcDSjSoLl34+
 QnKzZebVoEL6a9wIziv77Znzm1vF7grUXZPUANmjU1+eTHAcjnnJ4Q6vK4pTLDeh
 Bllq0cuqbnlCbb87Zeye6SIWOpVAleIakFaYLxq3ySSsw3uFebISu4CAbPfiBWAg
 Jdf4sKHS7Hpgbpkqj431jcSOHMnl67bb8inuH00g4tuBcCX3sDOJl6Ev81QIAVMZ
 e3wTw/8PILR3xCpUZjuUgw/+QjsCpZryNiJHTFkC0+qdAmhBWJfP4JJPeyYE5yZ/
 yAbKiTWfn8uQgjJQMI3uiKS4H3xL+lp9nKLd2XxD4ANZLmZHItkxcz99au8H88Pz
 8FitQ==
X-ME-Sender: <xms:OyMIaegxSZlzTPUQ24oRJpaWCPrm6hlDAziDkIZ0MEU2Z5YMB09iLw>
 <xme:OyMIaWensuorzvcrp1xarTlvFhf9rIcEzGxrIzHY9-bBXTVJuWTFxa6E6TvUUGIEi
 7SNSgK7Nd85Iy4hdI30iNRkcqvJSGwkhH7K5hpEKmAaU9Sj1V1WH6E>
X-ME-Received: <xmr:OyMIaTfZ6Uk9mlfhcMEg67yl4x4MZrQ60B1feDHjRm9moq8HEjNd35jss8eL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OyMIaQ9qN2sxi4W2zHwu7OKMEFErYS0-YOOkJ5L8GZ9qDwAvKHPw2w>
 <xmx:OyMIafkdF6I-eC2LxXNNae02nb1yRL6UJ0uB1O9uMN8IVUI-fWEzJg>
 <xmx:OyMIaS_64mLuhGSIXxCbj-QsS9EA6k2VcxFq6tu7jz6WKkdXokcmkw>
 <xmx:OyMIadnJkdp6En8SE_aKu-s75s2RzzqXZFrAGJV4kY37L1_b9xtRXg>
 <xmx:OyMIaWoX5TEm5cIRc7WdIYcVuqEqZL24MagusV3C5Q6q0NIl17HnCme1>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 22:36:26 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 68dcea4f;
 Mon, 3 Nov 2025 03:36:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 5/7] ati-vga: Implement HOST_DATA register writes
Date: Sun,  2 Nov 2025 22:36:06 -0500
Message-ID: <20251103033608.120908-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103033608.120908-1-chad@jablonski.xyz>
References: <20251103033608.120908-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
into a buffer. A final write to HOST_DATA_LAST writes data to the
buffer and triggers the pending blit operation.

The buffer for now is a static 4MiB and overflows are checked. This
seems like a large enough value given what I've seen in testing. Future
work could dynamically size the buffer based on the destination dimensions if
needed.

This sets things up for implementation of HOST_DATA as a blit operation
source in a future patch.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 15 +++++++++++++++
 hw/display/ati_dbg.c  |  9 +++++++++
 hw/display/ati_int.h  |  3 +++
 hw/display/ati_regs.h |  9 +++++++++
 4 files changed, 36 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 4ff17209c4..0a686750ae 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -969,6 +969,20 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case SRC_SC_BOTTOM_RIGHT:
         s->regs.src_sc_bottom_right = data;
         break;
+    case HOST_DATA0 ... HOST_DATA7:
+    case HOST_DATA_LAST:
+        if (s->host_data_pos + 4 > sizeof(s->host_data_buffer)) {
+            qemu_log_mask(LOG_UNIMP, "HOST_DATA buffer overflow "
+                         "(buffer size: %zu bytes)\n",
+                          sizeof(s->host_data_buffer));
+            return;
+        }
+        stn_he_p(&s->host_data_buffer[s->host_data_pos], 4, data);
+        s->host_data_pos += 4;
+        if (addr == HOST_DATA_LAST) {
+            ati_2d_blt(s);
+        }
+        break;
     default:
         break;
     }
@@ -1074,6 +1088,7 @@ static void ati_vga_reset(DeviceState *dev)
     /* reset vga */
     vga_common_reset(&s->vga);
     s->mode = VGA_MODE;
+    s->host_data_pos = 0;
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
index aab3cbf81a..16e5d29a5a 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -15,6 +15,7 @@
 #include "hw/i2c/bitbang_i2c.h"
 #include "vga_int.h"
 #include "qom/object.h"
+#include "qemu/units.h"
 
 /*#define DEBUG_ATI*/
 
@@ -108,6 +109,8 @@ struct ATIVGAState {
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
+    uint32_t host_data_pos;
+    uint8_t host_data_buffer[4 * MiB];
 };
 
 const char *ati_reg_name(int num);
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 2b56b9fb66..9b52b61dcb 100644
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
2.51.0


