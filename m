Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED15AE6BF18
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppN-0004hl-0T; Fri, 30 Jan 2026 09:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppK-0004gP-VB
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:26 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppI-00036A-3i
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:26 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 131AB1D0012B;
 Fri, 30 Jan 2026 09:50:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 30 Jan 2026 09:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784621; x=
 1769871021; bh=ABtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=b
 VVTvuXOUXUnYVPKejFB/c5dj3zdDz5gHdL3NZFYQujstvyHkSJlscdISrFWV9RWq
 a4doi8hR3Mh2niEV+9FUdMNDKc1+TcnT5duUew/ZE2HLn9mUljMjCdmgPSN7Jrp+
 0PT6keKMMZDrtJ6pKR8SdpVKM56xgif8MdUst8UhjxjTiE3ixoLwaKpJHgmtUxTC
 AuiTGGtTU9btQJCcTbYZcqacOTnK468ycG8k0dUjNfE8aF8bFQhPaY2kmE+JkLVJ
 Gt4E9vOLGLzPY1qm/lTHIwNpPejIgxL8iLmmlDeK0i9QMDE0Nl/UMg+x4T5zowN5
 W6J1LZj6rv888IlPNfpLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784621; x=1769871021; bh=A
 BtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=Yr/zfXvuBIBQH/uVo
 /i+V9Lto3lYW3/WG47n7x4uHe/UztvAoIpPoV+9QTKTNCC18kLG5r6gRUK2x0IxR
 xpqRp9YIMx+lVDTbyhp0VUMtHIX6zPNl31BhAt00QKt8YAguy9eJQmEp6S5y8z2g
 LhnCBv1yAzCV28ZGW3eRmew3iCHHuMPDXNbwcwmo7eLRDIbVhM5z5PEA1v7iD8ex
 YEahy6o2LvDbKEBtCKkHVPO9VQKrqxn8b27MrGj4N0pT6U0tWFVGC7PxS4hUGWHb
 zyUrNIJvb7wZa6e8e3trF0wGAqxjCEtBMPbchZVCW4FoN9/426jh4AtWxH1524cH
 evr/w==
X-ME-Sender: <xms:LcV8ad5Vv7dZoTfA_4hpp1gMjJ3qR0WLXCsXepdRZKev7kwDn_PR8Q>
 <xme:LcV8aSX7FoJAGV_PUUQy4isS_w5Mp50x0xUdhurgJWnf0Yvs-kdpy_edscNNG8w3O
 rpdJobFLzI4rLWkB6rnxwWPq1iUGyBRthj2p62oNEtbl-l9EFovzPk>
X-ME-Received: <xmr:LcV8aR01BtoD8rEjQdoc3zQCFz1vX3BM_GRt6Q3k6EM1zY6chM0hb2F0295g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:LcV8af0u422V53r4zMFAn2HD9DpfJeinIZbxbs44N28hw9ARB5V3TA>
 <xmx:LcV8aU_Ljwcm1NfCcaNY3JXph0i7YosXZAVopQivD9skMT6nUcGOKw>
 <xmx:LcV8ac0LSGI046f_aTpmeYc4FxpmvenNyyoRYmRp5dLXLT4xhpLa_A>
 <xmx:LcV8aR8-FqgT1zMfJHCWwbVLtaqdxuGiYaxIUWmvbIJgHsWyqJK00w>
 <xmx:LcV8aTh8Jm7gD0DdekSByg4a_5Un_PlUsvoJPXf-JD8lavG6qSZUdYe1>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:21 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id cef9835d;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 02/20] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Fri, 30 Jan 2026 09:49:47 -0500
Message-ID: <20260130145005.731129-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
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

Reading DST_PITCH and SRC_PITCH on the Rage 128 is broken. The read
handlers attempt to construct the value from pitch and tile bits in
the register state but mistakenly AND them instead of ORing them. This
means the pitch is always zero on read.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8438a77de0..777a6b0a2e 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -438,7 +438,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DST_PITCH:
         val = s->regs.dst_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.dst_tile << 16;
+            val |= s->regs.dst_tile << 16;
         }
         break;
     case DST_WIDTH:
@@ -468,7 +468,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case SRC_PITCH:
         val = s->regs.src_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.src_tile << 16;
+            val |= s->regs.src_tile << 16;
         }
         break;
     case DP_BRUSH_BKGD_CLR:
-- 
2.52.0


