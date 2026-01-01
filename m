Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3CAEEB56F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 03:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb9oe-0002JQ-Pn; Wed, 31 Dec 2025 22:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oa-0002FW-Ft
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:32 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oZ-0003iU-3M
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:32 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 50CE11D00095;
 Wed, 31 Dec 2025 22:57:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 31 Dec 2025 22:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767239850; x=
 1767326250; bh=hhCxBBfxOrYOITzX/tlTroKcI6UtxO3/vBGN1IhYhP4=; b=X
 WmQ/Z6b1uTBkL2SZEh8shrcVwOtWdvQad/C1DMqXDgY7DHUNalfyVmgwbrzWLuCC
 pMxvgUpWhN0QG1NKRnsTazBU6nzileGVsC4vtMeKnsofFPynrM4gCbtBiMMUCLtV
 ZAtcUEH38VqF23ostCMA5W5GGL7fchpbEErOiWHIvKDRlhPrM1F0XbB3z6gm7WHk
 jRaDcf430z0ElxFF0XLlItJe16iyQWiW4HAwHdJX8SUsuj8bhL/RUbkFXSPTYjHD
 DtRANcRQa2JaE+jJ1TotzwPN09fyUPyWckS/+thz2825difE01VqIEM5kPv9mH4K
 QDcr3zQ546kgZMGEUtLrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767239850; x=1767326250; bh=h
 hCxBBfxOrYOITzX/tlTroKcI6UtxO3/vBGN1IhYhP4=; b=njFJrYRMU2GP5fuLP
 7Ox84IdbwgIJIj4RgkkL/E/p0d57sEO0DiRy6yiblWgKyrJnvYGRHJF0bOQYK4D6
 b8gFnKHA5wuqOTlU4ajMRHRpK3mSCanf6sSoA5wh1+GtxZNSdpIwIoUaiPWOLK7Y
 yZFxM/1wFt+3TxE8ZIcjA4BzvsoE9fJNwt9oUj5DYReO/eTMXfTXmr7lrZ0znire
 mqZUzdGz/tXgEnVoeSeVkJHQKsoCURiztQMMCRQU10kgQrc0E2c66HOOr1uXsD4/
 6kfgNVzQEgwbfxEV6i0L5YRGKQGv/r5EeEyUfqgZrDu+AIVxoD8A3pQEvGANJlW6
 LjJ6Q==
X-ME-Sender: <xms:qfBVad7MtNUs0YQXJSB-WFxOhN9NLaWY-ciO3Ke6Ef-uv5XGmBLZXw>
 <xme:qfBVaSWmhIDSSMSfBTRIm31-IXDxQvfdt_pXucjm4NNTEZU1Iv42UGAQ4cYwKuFXf
 RGbW9FQnZoh-upzh4Hu25Z2iC6fvx_FUJiaFt276V-x_QAEk3-2KPPj>
X-ME-Received: <xmr:qfBVaR0EWlqCwFwclxGChJgYQO7OYCHEvqu1IcuVeeSMzNUz7Ri5SoVlnX-N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeejhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsg
 grlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghl
 sehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:qfBVaf1RjDHgarXubrkSwPjIudDhFwz75aHi0n8V0xAcdD4XpKZi_w>
 <xmx:qvBVaU-yBZBQugAS2q-FlMFY0acnXrQWmORhOJtSZG-k-ifwfrmn4Q>
 <xmx:qvBVac1mBV6_Q-xHNOOldQ6dZajiWcwYSPmau9S_r-xrQsZOEFgFkA>
 <xmx:qvBVaR_9d9t3eITonEPkSFRBuArM0J04wHa2wRkaOnisiyRA7BLPAw>
 <xmx:qvBVaThPBI6vePNgVMHtVaaOKv8E6KuHI0hw9RTMcwg4YeYdoPJav4Hn>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 22:57:29 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c49f72b4;
 Thu, 1 Jan 2026 03:57:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 5/7] ati-vga: Disable GUI engine MMIO writes when CCE
 enabled
Date: Wed, 31 Dec 2025 22:55:53 -0500
Message-ID: <20260101035555.1300511-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260101035555.1300511-1-chad@jablonski.xyz>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When the CCE engine is enabled, real hardware ignores any MMIO writes to
GUI registers (0x1400-0x1fff range). Writes made by the CCE engine are
not affected by this.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 5f52739d33..29a89b3f80 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1011,6 +1011,13 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
         trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
     }
+    if (addr >= 0x1400 && addr <= 0x1fff && s->cce.buffer_mode != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "ati_mm_write: wrote 0x%lx to gui register 0x%lx while cce engine enabled, ignored.\n",
+            data, addr);
+        return;
+    }
+
     ati_reg_write(s, addr, data, size);
 }
 
-- 
2.51.2


