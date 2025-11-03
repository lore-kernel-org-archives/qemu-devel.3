Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61777CCFA08
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlN0-0005iv-OK; Sun, 02 Nov 2025 22:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMt-0005gl-PV
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:32 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMq-000807-6M
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:31 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id BF384EC023F;
 Sun,  2 Nov 2025 22:36:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Sun, 02 Nov 2025 22:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1762140986; x=
 1762227386; bh=v7NL1eLeuw9MyCVGFnXUdXEFkMix1/iq08tw9mGSZRI=; b=c
 y3WhyYuLrn+/iwHoiW/fE5JEKOC55PYwEOEOP5R7YVE9v93CeXyQ0quiujP6bc+s
 pu85wmBwcPOXGxt24+MQ5qHv/aHcDBBC/Ojx8emff1Kglq/m+5zdLcdY1DbnHUnB
 hULh+clbbcBl1ms6uXUysg2PqgnXG+AbN+TqOhjcoINLrx4nqpCUXdoqGsaGbxfR
 vn8Fu93WM8dUf0pT1uvdKcohcyUJ8beG43Fjsst/Mo9iffsqiUKZjtX3K4lzVXlA
 Y698GmFcLU0WBHfI5Uban7AQIyeTojF1jkGkJvRg0Aefm4MByJYYcGj7v9LoOf5C
 qOwrtuIGXENNATLf1euPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762140986; x=1762227386; bh=v
 7NL1eLeuw9MyCVGFnXUdXEFkMix1/iq08tw9mGSZRI=; b=oLVev9AekYvSRN81H
 DBIWI9w2BOCnk5FrkaGQpbAMdGiTRwLI7UXAkAJ0D2Knd2s5jxBd9PmyAoUBjPW7
 tqQsH9YMS+apuaFnABGmt1gajwJsfBvQGS1ar87MsH2ePUDRN29qR9qFP/wJoCKU
 0C1CTI+RQeYD75Gayqb+M2YV+PTnGgmC01QdHjmjAg+LnWYzvVtrFsvQaggP7I3o
 zjC3TlQBz7cGnNi7Yn4ISlyrm5TK5XDf+yohpVo9Kleq2wND5upRxH2DLkeWx4x8
 oHdNqqE8y1yqI9j2Bly4vxCe4+OsFNrjEKxQJOzagTI+bx1QhomTDzmm65zC43H/
 VTDdA==
X-ME-Sender: <xms:OiMIaT5gEOw4lGJoS2zWU5NhZ0Al3C4JqAseKKmydVmHqs0CXM4WDA>
 <xme:OiMIaQWmamitTFXdTWLO0nosurYPscFMgVK9sC1-7bN0E8fXVHgaIRB69Uj5EMbM6
 ijRxaDvEdK_q-mLyOxt_2jO7-gTq5LqQkOFCcz40GqC26226T1ovjmN>
X-ME-Received: <xmr:OiMIaX02q90Ua1YHrFV8ZiewYAOM6ZYFDRmDJyNpOJ3_PZYaMLiWMMk0StFj>
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
X-ME-Proxy: <xmx:OiMIad0E4b7o9M6vgi4TDNcJWRVFCLptbQs663XvY8-0ZdWJO2yuxw>
 <xmx:OiMIaa8bS_xt4nMzomFHh4FuuHcIiWfrueUEXMs6xF4vkiB3MY3KJw>
 <xmx:OiMIaa2EvzjYItWxgMIu3uxBIPqT-rzT-sdHb58MSkhHXmMmnXsnDA>
 <xmx:OiMIaX_1Df5yw9BWX_AqPUT7K7BFwEixNSHoWiMs3Q5gxJ1Y2XRuUg>
 <xmx:OiMIaRhAd6FNoFEv_AVNSC-MM_aCmbE6t6ywd-YBLpeKtaFnnfnDLLjn>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 22:36:26 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id e5c42f81;
 Mon, 3 Nov 2025 03:36:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 3/7] ati-vga: Implement foreground and background color
 register writes
Date: Sun,  2 Nov 2025 22:36:04 -0500
Message-ID: <20251103033608.120908-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103033608.120908-1-chad@jablonski.xyz>
References: <20251103033608.120908-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.150; envelope-from=chad@jablonski.xyz;
 helo=fout-a7-smtp.messagingengine.com
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

These are straightforward 32-bit register write handlers. They're
necessary for a future patch which will use them for color expansion
from monochrome host data transfers.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index eb9b30672f..bf7a037e64 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -926,6 +926,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DP_CNTL:
         s->regs.dp_cntl = data;
         break;
+    case DP_SRC_FRGD_CLR:
+        s->regs.dp_src_frgd_clr = data;
+        break;
+    case DP_SRC_BKGD_CLR:
+        s->regs.dp_src_bkgd_clr = data;
+        break;
     case DP_DATATYPE:
         s->regs.dp_datatype = data & 0xe0070f0f;
         break;
-- 
2.51.0


