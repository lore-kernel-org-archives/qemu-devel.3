Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4DDD4A5E2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoU-0005zI-1t; Thu, 15 Jan 2026 21:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo0-0005qW-OG
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:22 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnt-0002QM-VF
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:17 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id EA7BE1D0007A;
 Thu, 15 Jan 2026 21:43:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 15 Jan 2026 21:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531390; x=
 1768617790; bh=xXARdxSoThdAoSgU0MiSr+42Qqr3VDhiqVj+t/lO+Og=; b=I
 3atU2UJ9lJIyyGXC9f2RzKvSTlJyIwMQXyPUgJct6qPHZWWyJBuhUyzUhGYEx5n2
 HiZt2lnPL15iwhTUQLqqMbNuoVJ8frwdw29fy0DBRb9hNyvMyOKou5S4sAk+/35Z
 CjNnd/cLlp0LgnieFcPcmu9KCtltgWtBuhJAqWA1+J3khT2tHfmzwzzizujIlD6P
 0e5XyLNssMDdS2C+pExcZ1mNTGR1Y4yno4djnJh5mLvvp4O2jk4nnKeuc++HPUV2
 +0z4NLd5OQJ6dYhyROmm0mrI384X3YS8F97ThB5SqleArdXodtpSzYoF9yIbuoSU
 3FrpMwRxjUzEeLf9WJDRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531390; x=1768617790; bh=x
 XARdxSoThdAoSgU0MiSr+42Qqr3VDhiqVj+t/lO+Og=; b=pkG3eoagc6qpNbzEf
 FdizzNpy3n6NP5ZbKWAMWIi/5G2sL3slFQiVDsmY72qa4PYl3YfpVKSHBaofkNFQ
 uQ0u8irEA1n0vRc6EphzgMtRQLjVt2+Z/05OfD/QzPM63bpWHYKSoykp1OMlvkES
 srGbbDN524Jq1RBpLbDbQGLPg6sNh9v+GzU8uParr2z2FJSrc7Ev3BGuZpss5xjV
 y7e/g9Ha93zkq+UEisJLoXCkGgM3C5PsSOOWVO/KDZw28Mf6EJ/IpXUwgTH/KneU
 hMGum8jgSBXQ64ie/SjezDVTIn3hVUzSwhRw+O/Um67zsp/IKVs04QQLlqC3Gjny
 z21Wg==
X-ME-Sender: <xms:vqVpaclcXj_i9NP8A3pnTTqJRdHECarhq1qVcjVoV48ZFsuSLjUeGg>
 <xme:vqVpaTQPqEtapA1ZZMQLFO_NnGOZ70dbKdAk3jIAtDpoYqMZRBmlojXHAPu_vF-4R
 OM0AxYF2-3j8Vc_YKxWGiUQnXmxevPrc4bZGZYnnNG-cdN8Sm3Atpc>
X-ME-Received: <xmr:vqVpaYA5pYS6ZiNUWQ3_oxy4xHMWPpicQhxtZAQ21Fhjqo5IBdYPt4e4D1y6>
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
X-ME-Proxy: <xmx:vqVpaST_zNaNuxwpNqkC4D3fZ0jQKadIUzVY7E4j6zOgb7XpSYRXoA>
 <xmx:vqVpaep1FHoGyGvOmigvpm97W4_E2Ft_5xJSs2FMhZQQcxqUzSn4HQ>
 <xmx:vqVpaczx7wb89BybAKLHFkdp13TwkVe_pmXHBNd1cDc3tLemewhmmQ>
 <xmx:vqVpabJFSsXZNeTqvBMBkT1qJ6eg724yvwgfY17xohu-esgM4QNtlQ>
 <xmx:vqVpaU9f-GiIS8V-JjwIzAk2eVWI55nbOohL4ygJSzzak7MQmeeMB2vA>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 4f7071b3;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 02/12] ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
Date: Thu, 15 Jan 2026 21:42:48 -0500
Message-ID: <20260116024258.1487173-3-chad@jablonski.xyz>
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

DP_GUI_MASTER_CNTL aliases several fields from DP_DATATYPE and DP_MIX.
These were being written correctly but not returned on a read of
GP_GUI_MASTER_CNTL.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 17 +++++++++++++++--
 hw/display/ati_regs.h |  5 +++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 6967cc0ad9..b0c87f9f80 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -459,9 +459,22 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DST_Y:
         val = s->regs.dst_y;
         break;
-    case DP_GUI_MASTER_CNTL:
-        val = s->regs.dp_gui_master_cntl;
+    case DP_GUI_MASTER_CNTL: {
+        /* DP_GUI_MASTER_CNTL aliases fields from DP_MIX and DP_DATATYPE */
+        uint32_t dst_datatype = s->regs.dp_datatype & DP_DST_DATATYPE;
+        uint32_t brush_datatype = (s->regs.dp_datatype &
+                                  DP_BRUSH_DATATYPE) >> 8;
+        uint32_t src_datatype = (s->regs.dp_datatype & DP_SRC_DATATYPE) >> 16;
+        uint32_t src_source = (s->regs.dp_mix & DP_SRC_SOURCE) >> 8;
+        uint32_t rop3 = (s->regs.dp_mix & DP_ROP3) >> 16;
+        val = s->regs.dp_gui_master_cntl |
+              (brush_datatype << 4) |
+              (dst_datatype << 8) |
+              (src_datatype << 12) |
+              (rop3 << 16) |
+              (src_source << 24);
         break;
+    }
     case SRC_OFFSET:
         val = s->regs.src_offset;
         break;
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
2.51.2


