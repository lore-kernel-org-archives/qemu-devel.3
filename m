Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CF9E9D411
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1J-00073b-B6; Wed, 04 Feb 2026 11:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng19-00070I-NB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:16 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng16-0004WP-G5
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:15 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 252657A0063;
 Wed,  4 Feb 2026 11:46:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 11:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223571; x=
 1770309971; bh=UFSgWoKS6dct4PEaVxUuYg6ee7pN7SwnivHZWSj1kps=; b=f
 TKCywWJ6EAUEFniNexmPEmmbOEV68HkAoqChy+lZspo3fj5GaGKTLrzHc1CfJphB
 edBRhkQ1NJBsY2K8QDlmzH1i8zYdpvFqueDw21bt8qUCHMKIYkFUYLO/MNlt/NRu
 OHIBDD6NWtRBu2hKUcN4n79fpmvgehB1Zuuz7bvB+UVILDmr+iA6L1GOsyE8X/AN
 5u1ARegUVO6ARfGa/meUG+VuKw/dX+7X4mQRridrqIub5QhnM3jDap33WqVCdgBi
 7+hsgkF6xyCAS82dgIJT7zDbAHX/Aeivd70gkwYoUFPo77wz1gZz59cCkMWNvxVi
 zpNFWa7A/AST/WYk1tDLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223571; x=1770309971; bh=U
 FSgWoKS6dct4PEaVxUuYg6ee7pN7SwnivHZWSj1kps=; b=g9HnkM+DA0/lfxm9Q
 Mq9oitJ4dgexLpEhxgXvOXQkSSOG56VhTHaAK06lHWdq0M++fIBBRDThBhXKdY7w
 d7HY3yRFLw6ziVt6fPIDKJw0z2YzT0Pfx5e9WtenKM2/rAa7AgMUBw4I3eG+jTzD
 Bl8i3JLnsPtf3CI6NICOsAAskJfTIfkGp1Q9cRlwHrDjM9Uj1r4cqaXQh71jTSxL
 3cqySZ1oxue8W7Px6kamRZNXsyV3fBq92vVQju9a2garyA/UIH4NihHC5+fiA3wb
 C6a5wCCqeMwxtLhc4MQSe3xcbgiD53wv4fDgl2assv+ltnoTtz8G2SXCk6Ia01yL
 u8A1Q==
X-ME-Sender: <xms:0neDaW5ld4QLCTNlHCtCD1oGpMLxKvAEjUk6mh1CFyzj8ZQBdVEN3w>
 <xme:0neDaXX7MEP0C-4qApWWcGLfgpvzwTO2JPQvLTshIBVGEgTvHizdN2hwcwCB5JL7_
 tmXpL_M-OgSxuGf1xDM7bjz0eqUwp9nOJO8-zm1MfFc0rHh2lHY1g>
X-ME-Received: <xmr:0neDaS03IBjjQXuSDR1ypl49vrVdzVLmZ24vAswTIHr-n307u72Jc_xDP596>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:0neDac1vkAPiVkO9sfdxf29IHkY9GlMNoERe21FVinZuxyPZc3Hykw>
 <xmx:0neDad9DT4pG1L0n5e_aYUErfXzzg3hHSoS7LzxZ9Omuv11dRWy5pw>
 <xmx:0neDaR3B3xhmyHBMFvWlpqo92C_frR5TLV1PPcu6eBzOfXPsJtuAMA>
 <xmx:0neDaS9RVDnhFrD_5AbO0vecMd_z9ewZU0NYsAxynXh1AZH2Un8jqw>
 <xmx:03eDaQgiGODlBsPE1y0qTLtOgnLtw8Fkutht0wM8G0gcvZmT2MwN7mjb>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2dcdd128;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 03/18] ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
Date: Wed,  4 Feb 2026 11:45:51 -0500
Message-ID: <20260204164606.3425246-4-chad@jablonski.xyz>
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


