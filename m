Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCCBE6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppK-0004g9-HD; Fri, 30 Jan 2026 09:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppJ-0004fm-BX
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:25 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppH-00036W-Cp
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:25 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 524D57A014B;
 Fri, 30 Jan 2026 09:50:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 30 Jan 2026 09:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784622; x=
 1769871022; bh=hSEk2iGOLV/2XodZAt4X8Rq6Iw7hTyX9keo3LAU43b0=; b=R
 IPg8YQ7iJfkC3+PJWtBU9KrMaDHdC+EmHnQvRHSbrCFyNLnGsr2PdBtK4BMW071L
 MKHLRSi6EiULa0jdvQRUZldBUS8QibetRGx+dENqC70+oG4zGdmI3s1zptdg1Qsu
 Qhn+prPt3WQ24+Fz3XlwQA/FqL1fqLIR+8n+SEwFYIcHeZ5faiMcyJxxWtNnTLW5
 yVzjJHQf5bjiavHr7j+3gvDZqy8lvZXZxZqe95vpVLILFTat1viqLoQ2LUkssFhP
 rCS4PGGyEv8DSHWWkSx8jZYgHvWYbnOwZZzSZsb8S/supxEI+IZ4WKHSO3zLCTjQ
 3iRuziva/Z5B1tyHRLyuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784622; x=1769871022; bh=h
 SEk2iGOLV/2XodZAt4X8Rq6Iw7hTyX9keo3LAU43b0=; b=ujnb2lE729pHegyDi
 aDfo/QoaLJfJYsmmHR05rjAHeH9w5uOD3VknH9vacn9Jtzu0Q/SjwYP+3OhXfv2+
 5juaCyvXDgqwo0aBF+GDJvoOgrzwhoKdQidM659EAef8HvFyz1EuzRz/WnXWlXCl
 /XWpbFe8HJnUokk3iNumm1322owt849XzkuAdLppHsW6OjRxd4ofY7FNWb7oYyeA
 Wtg3yXR+FbfY0ecHYRxpzT9uwzZ5uoVFl1+cC/d/RQl8u0QJAIEvbln5Ze1+mHGF
 a3V74tbKsHe0IMXhg6Sbc0XV2xxTKwB3HJ3V0DYL2z7V+7Yk0REc12ZIg8JTfavd
 3La6w==
X-ME-Sender: <xms:LsV8aSSc4NslnX-8eBjMhbT5ylYMjiSt1sCJ76TN7mo2yiM1jPmWSA>
 <xme:LsV8afPK7EUvpewpllh11rpPUBMVug5LZIbm2RHlCNfWhMJ4CT30ELGybnsIQCBmJ
 5jZlJ3PM_hbPHq2VE4b65zvJCTE1Stk9em94TVooNjYb4amMcsLYxA>
X-ME-Received: <xmr:LsV8adPDqorX-G93vCzwrWONd52CwBo3UONqQDUX5AvzPCcB9Hb783tvW-dq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:LsV8aXt289-CB0d5IFqQTeQa3Z1AhExCwfhkTu68YEcFC5bpLTJIrg>
 <xmx:LsV8afVv4WTPxc1ba4Wi0b5VQXU8epfbBTtpvssEANJUJWu6XXf3yw>
 <xmx:LsV8aXtKADXqo86eDcG91Mb3f_ktQTgfJZq24_aFQlP2VHd0zg_x6Q>
 <xmx:LsV8aTVCQZXLumTPIaTozhdWFmYogheObuTZ3VVGpfbBXWAlxS8xkg>
 <xmx:LsV8aZYEzdOGXWWwS6RCCRq6P3etECE4ZaaAg1cWJJsL2xUL-zNdKnKc>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:21 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 98613107;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 03/20] ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
Date: Fri, 30 Jan 2026 09:49:48 -0500
Message-ID: <20260130145005.731129-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
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

DP_GUI_MASTER_CNTL aliases several fields from DP_DATATYPE and DP_MIX.
These were being written correctly but not returned on a read of
DP_GUI_MASTER_CNTL.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
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


