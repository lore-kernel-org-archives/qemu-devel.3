Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F63CEFCF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFN-0004P2-DS; Tue, 06 Jan 2026 13:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF1-0004Gd-LW
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:15 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEy-0001x0-Hs
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:14 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 4F0511D0010D;
 Tue,  6 Jan 2026 13:57:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 13:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725831; x=
 1767812231; bh=gjdHE6O4FDZjVsD4gTZEYz0jwiq/fcmeDgdMr216o5A=; b=s
 1BgbNiNK84l9sDBirRwXMEFsP34dBg9fuPy5cq8pbLNDa5HOdL4YwQYsCB3+e3pc
 /PNxvTEwXb4b/xdP/7hqdHx0Nriu18TbdLz8oK5kxrWzd6H7hyRh1I54HWYDwWyf
 q+9cPyBI5/UyQwN3JVf2umcGCst/0KPId9rBHSJ/hkRgQVZkzCl0wfXbOQzRb7lG
 tFc3WIIzL0NFglneg9Cyg0gRpEbQ4Ktix696GYrEjTTxt5lTrkZdaL/6P6fQ0C6k
 xd1j8ukcyRQbORObYAu7bCRE3hatqbkvBtPAGJxWQdc+F0Y4GbLqTBV4G+suKVns
 TofuYOFBpAhapHQZl3juQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725831; x=1767812231; bh=g
 jdHE6O4FDZjVsD4gTZEYz0jwiq/fcmeDgdMr216o5A=; b=ybrjzBqHuw6RQ8Hop
 l51yu40jroLF43JqlxrmL8H4z+VDu4wJlgdLsUHp+OydkzPz6vE/qY9fP5tj1zOa
 cKberAeuGF/3b3rkSJcZaLurR2ta9P6CplukPDz83HLI12T1OIwhFNXj/FzX6VyG
 brxuMnxOnxFgY2WVptZic5ezr2IS0E63IOjUrEMoHcjWlQdU4u3AY/k4Smfi3b20
 CeNEaoHICdTZd40Orgs/u9BYu2E3wbQEOmWWV2B31VON9btkpysuF8pmQejWdEF8
 hDNpYHk7OIYq7zRKa0/R3sqoMfqfCLQtF2Z5koKy2r5JHCSIskb88kHQ5GRL0PvB
 75nFQ==
X-ME-Sender: <xms:B1tdabFL3xv8wi1EWxh327O0gVCCX8sFM-xMxbHk-LEDwmuXNfKlNw>
 <xme:B1tdafw3EnOTXbcLRaIYr2SMM9dyisaSMPvWsPi3neupB-NZmKgTu6zErILRLaP00
 22MNjLbGi04b8qVPixueCEnIcoYvrX7v52TDRPY0pPvJ0dlqaqqSg>
X-ME-Received: <xmr:B1tdaahG3LW2VFLu1OnGJQCRGO_NqENKCL9kR3qolH9g1H1YIDymiXPgL4qe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:B1tdaSyJ7xETcr5h4ac9XS-L4e34ClkQuSB_h3JHD-xwOewhIn59zQ>
 <xmx:B1tdaVJrLN-sIspXfqavq8CvNybA17EhlqElT5sFP2KkAuI3XcOcJA>
 <xmx:B1tdaRTffgSgJ_BTdcME14VJ4w3Z4Ojrsd0Dn5C5N9591xXDj5xbyg>
 <xmx:B1tdaVr9s1KMmhRcsLYIDKgeQGvdwHqKVtEyi2zPu30OQ8LJ3Z4Q7g>
 <xmx:B1tdaddliKWe_NY0WV5VLpFVU5IfYDXrlBiCLMJOH4kOpaIsL-U-9wHT>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id db3f8d23;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 4/9] ati-vga: Implement foreground and background color
 register writes
Date: Tue,  6 Jan 2026 13:56:55 -0500
Message-ID: <20260106185700.2102742-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260106185700.2102742-1-chad@jablonski.xyz>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=chad@jablonski.xyz;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

These are straightforward 32-bit register write handlers. They're
necessary for a future patch which will use them for color expansion
from monochrome host data transfers.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index bbae5455d0..9a2c1260f7 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -964,6 +964,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
         s->regs.dp_dst_datatype = (data & DP_DATATYPE_DST_DATATYPE_MASK);
         s->regs.dp_brush_datatype = (data & DP_DATATYPE_BRUSH_DATATYPE_MASK) >> 8;
-- 
2.51.2


