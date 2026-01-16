Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AC0D4A5EA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoQ-0005xA-8I; Thu, 15 Jan 2026 21:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnx-0005qA-2T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:22 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnt-0002QI-Uq
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:16 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id C80ED1D0007E;
 Thu, 15 Jan 2026 21:43:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 15 Jan 2026 21:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531390; x=
 1768617790; bh=u7rZ6j9Txp/nW85uLyC9G5+YxXS6fGPWCPNR4E53FU8=; b=b
 Oz+OiirSpRZvZzR7ZYlTZpcYip/RzhEWd8k8Ysa3HN/TWHPYgVncotESfvWsMA4t
 E2XVqxhnZUE1tIiH8H4CNhMBN9oVIiRX5UThE2lYb/j5TJa0m9q0R24ZZugUYtdQ
 Q+3L+ndbs6cf5XVM49NVNZQpFGtWxzAe4R59kM6xdWLu+eZxc3k5IrMW1WdcMRIK
 3lyBkBBWwSMsDpYq3zVlysBnCbMbHOKwIqDwJBQaBQc2cSG4/oB2EyCrDGQENglD
 KgufUrQrpx1agv1jMR+GgnkfQw0W65sfJ1dz+XSueu0OAsw0XFveXkEzragi08/8
 xT0ZOdGQwoMy//rkQ7NaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531390; x=1768617790; bh=u
 7rZ6j9Txp/nW85uLyC9G5+YxXS6fGPWCPNR4E53FU8=; b=ftPdNk2liy0oXo81j
 bxAvgyCLDzupO5NtZQ9zHkJmDSLWYaGXf9rTYGNVj/KkM57suIa7hq2MRJALDOpf
 sMWCmLVFdA8US3lj71/N/1JQ3YDY4ZPU7ojDtVwphDE0eVrWdIXRD2XncKPd8d8D
 t4XA24bHwRbVpllqzW5bhzxxTrGvkZDuWb4tOd2bWeDptEF+ICd/lrAyN+BwpJGU
 EeFNymq3aMIgVxL2g1Dl29jfF9qPk3YY8GPOGlB+YRJOW7CDOBkL4LzlaBiPflnd
 6ibg0aZeV8H3ox1w/FXiw6Cawnoa2TkUOKHJYo42XDz6I2hADglSpVOXaAAo8cde
 i2aqw==
X-ME-Sender: <xms:vqVpaVFMu6jxdf4GgI278coJabfoYh10iPR_umgjY9t_ZjikcIg4DQ>
 <xme:vqVpaRw8zmhJNYSWmgzcowwj8pUFR0ksspgCl0OP8wIqNlnPfrNNupMMXBpLkhjEh
 PQ36UaSS9hO7C02x4N8c7OYGcgi4Miqbzs2bmb39px56XX5xgrktzY>
X-ME-Received: <xmr:vqVpaUjIHtDwgST9wGbKjSseoQMZ_EfEzDpTRJTwhY8BkTUJWwvIyGon2LYN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:vqVpaUx6NkB-WiVaYkUTNHcyszSgkeshLfoUjmGt4wLQ4wvdomlwVA>
 <xmx:vqVpafLVg1ne0hzTH1RIBC32hZKoS3eeHNGuQilyQBVi6b6LBcW9ww>
 <xmx:vqVpaTQFA7Et0OSFfTj9bR97JDZqB3ECGM1Jv5OvU4tWlqTELYZX8A>
 <xmx:vqVpafr4uGZlB6IBGAMvZ4LXYHHS8gXVdcUFNlfYEDx4ZPEDucaUlA>
 <xmx:vqVpafdYCYwoyYvekuGkmtySy0VE3vb_AaShhco1hWdhWUvv7PHjDpLQ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 0b85a8ea;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 01/12] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Thu, 15 Jan 2026 21:42:47 -0500
Message-ID: <20260116024258.1487173-2-chad@jablonski.xyz>
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
index e9c3ad2cd1..6967cc0ad9 100644
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
2.51.2


