Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BAECEE32F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNyW-0007HA-6S; Tue, 18 Nov 2025 10:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwu-0004zq-3K
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:58 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwn-0001we-0s
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:54 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 993081D00251;
 Tue, 18 Nov 2025 10:48:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 10:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480915; x=
 1763567315; bh=tQp67q5sgOzzLystrbHSfTO9r8/JxJBC9DhfWgkhB/0=; b=n
 9H+lEuWqCHzrBVzi7xJfNRMacnrNgnrOTQxNFjvlXj0LxFogQUrRAlYNfnhY40i6
 NRhr5J1JTQeWl+UpMiaQDbXLM0xbUUhzPr8+KhJDWaHxbOXPkdJOkwe7Q86GNSFR
 zK1azlqprPqnhuMK6XNtRodnAK7rHIw+yhlXxgrbv5cJIYaPQfOuEovjq3WtLjsS
 AAx291GEF+aP7+oarfRm+gG9ZEEHy7zNcIE2XlYe7x81O+JSZurM1raaE0S01dnU
 FlwgZ4i+3M//1S7woT8k7BPiP3AmSORbZtYzEDeUA22FC93k8ztCNdapBPL0mRDT
 dvxn7r9uSTIID8nlSKB+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480915; x=1763567315; bh=t
 Qp67q5sgOzzLystrbHSfTO9r8/JxJBC9DhfWgkhB/0=; b=KAnS2Sc9+8r9717iu
 UKpgZn2En9bI/a2hZkz41R0kYct9b7aZEpHZfE46tT7l37mke2QAGJOGP7i2KS2f
 qJt1vHR5xyMToNK11GnRYWmhSItz13WU1NmOBmEytDQI19PBAFj4KxU+284V4O1d
 Gfr0oMvlQI7/CIjFLwSFA/Mk/wN78ANNujXcDLppB5LIhwrglGbZ5cueh16Ycl1I
 N80JzZeIqxswiE83AQbHe6sK2IXYfdN+aKUk9qloHPP/sMzQ5JgNKwjm+PcHP5/6
 3S4NHV7nIBpCTiTb2wV6n/nzbaUC0JtvjKOS3IizdoTOPm6XbrDpuG8hYtYnpBQx
 CQC0A==
X-ME-Sender: <xms:U5UcaYWSbvoV3X0jRAhstG-0BeQwWDbRDEXhyuJX2_rpAQ9qxqRpbQ>
 <xme:U5UcaUDYJRNBnSn1onT8PmfB-pYsDWy-Hf-ZGuyU9oI6kbXohl2wnKqqcdbgtSJl7
 XXY6XUiWojnMbJzVdJx8yUUmvwN5IwyfRAWw_yIlhTwM3qB4W4Q>
X-ME-Received: <xmr:U5UcaZyb5DYbl3Z3dzunJkvoGeZD3nW-K5I6ptZeLZ3NxwHa9iHNLHj1_U3B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:U5UcaRDtvmeQ9b1P0Of0x0qMh6y34dLZfh8GQmxDDcKCITyM9gd7Lg>
 <xmx:U5UcaWbLaIpXO0tmUZvE_AVYpsymEP_h3ycySLx-vdEEMduAY4kunA>
 <xmx:U5UcaZi_9RXR94hQ8PibIgXACPDQL3LLhe8IfKXI9qoeBRi4nLpieA>
 <xmx:U5UcaY4tuAF-dLk5Q20XEMaNmsNJ72npPoF7-qeDbnghe6yVNKpT5w>
 <xmx:U5UcafuFXfnapfOhQaPNmKxSqyd2W8r4mTMAxXjzGFsSf9tqmnv9Fqaq>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:34 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a03257e3;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 05/11] ati-vga: Fix DP_GUI_MASTER_CNTL register mask
Date: Tue, 18 Nov 2025 10:48:06 -0500
Message-ID: <20251118154812.57861-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=chad@jablonski.xyz;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Remove the register mask on DP_GUI_MASTER_CNTL writes. Masking on writes
is usually used to exclude reserved fields. This register contains no
reserved fields. All of the fields are important, even if not yet fully
implemented.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index d0fa51f773..cfb5dc2fb8 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -883,7 +883,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         ati_2d_blt(s);
         break;
     case DP_GUI_MASTER_CNTL:
-        s->regs.dp_gui_master_cntl = data & 0xf800000f;
+        s->regs.dp_gui_master_cntl = data;
         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
                               (data & 0x4000) << 16;
         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
-- 
2.51.0


