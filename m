Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A563E9D40D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1C-00070a-BD; Wed, 04 Feb 2026 11:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng18-0006zt-Gz
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:14 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng16-0004WI-Fr
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:14 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 0357F1D0013D;
 Wed,  4 Feb 2026 11:46:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 04 Feb 2026 11:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223570; x=
 1770309970; bh=ABtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=j
 cW46JnSqWNAwbjgxYS7txM/hmb/Rh/BGm+OgVKfSgrYlsKDGxnclpVCNfUc5UN/i
 X0G6PVej1I1++ab+VXZIGEgXMj8XsCg8SPuzBNO/uf0KmcErDWGOJB+awlwNVrPv
 cFAAGndZdR6xcScFJmN/np7UsrvnsbgrYKHyAv2PqCdiaK2+uskrhc1curcRBnJC
 dxw/iuT9R/zEfjUhVi5PIuUAa8Nyp4T0vdJxI+dZdHautHyfcLLF7d/NzbSITaM7
 WHIG7pKBg5e8WcjfnBjWZllI2j6vhZMGyXzp13mZFoqWaX/UH8PO+w2uNIpZxJlG
 JaXbSyTFgIQEDYH6DD5yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223570; x=1770309970; bh=A
 BtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=cycvuWXSEJFrhi8jH
 0dwLmzTBsoGV3Zrhbag850NzdxycSwApDpn9sfFgI0jlupCSXS/BznFpx1oWX8Vs
 xBNi8hRMAmWzW3qTZqJATFo5oj8ZqkzxTD1f4qJsMygvCwMyt1Qu8NblEgwDTdQZ
 M4kmXSLmQVDCk+L7W3bTGGDDnKCXTkqBc1d48eLpPkYesRLsshkzxzKViBOSRWB1
 MYC0lRuzRnIMej+naoREpaeb/j25p621tsaTGr22IwDMGecR5PCVsHbT28zQfpQd
 n21meXZjgPY2glkN9+ypskn51fbCj1Dnhj8XS7O0RBk0OE6e4xzK3WKAvpJSVDYw
 YQORA==
X-ME-Sender: <xms:0neDaeOvTcZluYB0_ELpy8w1XFYQ_cpmG6Uyx5ZLylgRoNq_hNzD3A>
 <xme:0neDaUbNL-wBic_PS0Hi2Ul7sJe82NsN0Vbim_SJYJMddGVUmpwwAccTuh3bh8fxx
 n13SgRU2UuWx1mSwfRVznXR2a3OPRitqJ0Jq3zgM_L3R8ZZQJiG_A>
X-ME-Received: <xmr:0neDaSpTzac2tg7uMjw8PHK49TMMcf_Oj5qjLUy3-MygY8nBqfbNBnZd7yX5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:0neDaYaopurMxrfJN6mMUuaRVCvFW7-FN2qdBByLHYvwpZVSTTC7dw>
 <xmx:0neDaaSgR56paqwVy5bH-Io-ovSF6SBlhbS9FtgkN-OiO-jmmuCvAw>
 <xmx:0neDaf4-lBhWXKW5tWHJoBv354ee0HM_S9fAOlrC1VxoYITd6GwiHQ>
 <xmx:0neDafwPsmulwttAea7pcEQOQoaiaRZsyO76bSMC6p6IIrjNTpUz-A>
 <xmx:0neDadHllrxs_DuG9zZT0ybUdr87D_kyFncxT7sOldd_qw1cBjqc5uMH>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 7ec644b7;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 02/18] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Wed,  4 Feb 2026 11:45:50 -0500
Message-ID: <20260204164606.3425246-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
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


