Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECB9C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viclv-0002OV-Qm; Wed, 21 Jan 2026 13:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1viclq-0002CC-Dp; Wed, 21 Jan 2026 13:17:34 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1viclo-0003Jk-GP; Wed, 21 Jan 2026 13:17:34 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id D026EEC00A2;
 Wed, 21 Jan 2026 13:17:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 13:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1769019447;
 x=1769105847; bh=hyKU/nzPKi18SdSxCcqbGHCC6zAhLnYL9X5JvFMi5vA=; b=
 umTEsr3+S46Wui+JXKteDj0nP8XrimJRRQuAweZO8R7Upoipq+glqUHzEF24AHxz
 zISxPJ3h6Ckh6pJLKTk1v1EVKTATjeMTXbjxqsRwz1105Nc96gkhk5CGyFh2AP+i
 tzVSAmdBo84gcoPth0WEKsbMlloPRV6biNmEHRK6XBvbD1AoUQslqQdH2IwP6tpB
 QO++7Ym+PyfNiX5Vj5pqqVH/o2+KQ5aZ8yzgOVQiNdKurt0nRHcSmzWFNjMVVgrl
 BRQWnSLZaZLrbh991w7rQlAWWb9k1AnoV2x6zzygECt3frsGkywP2cPxYE6FPt3I
 4/ig/Ymj6DdLdImHBw5iGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769019447; x=
 1769105847; bh=hyKU/nzPKi18SdSxCcqbGHCC6zAhLnYL9X5JvFMi5vA=; b=W
 L9yLZKXah2F8A7qXWnNKvRIkHhWb8DjDr6IFtTFw2ji0ta86rr9mFMYe1cFcq74z
 SBgfL0JYQzCMeGgXuYZiKTzphh4PRSf5qclpl/L4Wn6OxN3xRykrsABjyDbjQ03X
 /+y8BrlFt7NFlEW/qwm/2m+W5vAAD0/01BMzbYfiAs2yMNVcJ/0O2jaK3APy+JSi
 e8dwkFZFoCESwLizPBGHTPX9myDxwnXtohxKzV0vgBZK8Zv1OKVz9g38gq+nRBom
 Y2l1RLZgc2GiNbjgT2DYc7JE253UetnpfiGVoyb8KVvrz6drgxSwYgCPYFHj075n
 z9zqgJj19gFZ0ILCBufjg==
X-ME-Sender: <xms:NxhxaQeFhnbCAiGTW6FVsvQ0STB9CGGqUtC1mUV2GIB53h9bW8X_1A>
 <xme:NxhxaaW_PTLTcopNFMb5MTD4a4XnJ-WyFD7AKHCBqbSfUoImbnYbW5gGJF7SfY55T
 QtJHA2kledrl8y_RSTUpe-rfKHthAVSSaAt166AoSwc7g5AqCJBSg>
X-ME-Received: <xmr:NxhxaRDlLWofrbWzu1F3hD_xkLKttaV55Ps0LH27kexaj8A2RoliBrtPjtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
 htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepheejjefhkeettdeutdfggeejkedv
 jefgheevleehtdffhfduveejieekhefgledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihiidpnhgs
 pghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvggvth
 hrohihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhgvmhhuqdhpphgtsehnohhnghhn
 uhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdroh
 hrghdprhgtphhtthhopehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtohepmhhilhgvshhgsehlihhnuh
 igrdhisghmrdgtohhmpdhrtghpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhu
 tghtrdgtohhmrdgruhdprhgtphhtthhopehprghtrhhitghksehsthiftgigrdighiiipd
 hrtghpthhtohepshhtvghvvghnpghlvggvsegrshhpvggvughtvggthhdrtghomh
X-ME-Proxy: <xmx:NxhxaV5mgc54fZeUjTTBT5yOOm4XIMZg02tWxfavfY1gNif8yc8knA>
 <xmx:NxhxaY0rqY6LnA79ZtD0wO8AkCP-eYIa8JaRmzMoHt76mOhFRCKLZw>
 <xmx:NxhxaZnYkYwxkSnLzeSWx6GAEdSsqaw75ZaKhSp4kpHQtlMVrLoOhA>
 <xmx:Nxhxae65qNZQ9j-rJr2CCDE1efJcbL_Tl01H0GXdG5Y6nr3aVHq1OQ>
 <xmx:NxhxaZJIWCIVKbphqVBACZaZmTpujdi3-c8X3Ajz8eUGcjYRJhMDcPPY>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:17:27 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 21 Jan 2026 13:17:06 -0500
Subject: [PATCH 2/2] hw/arm/aspeed: catalina: use pca9535
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pca9535-v1-2-164640e622ff@stwcx.xyz>
References: <20260121-pca9535-v1-0-164640e622ff@stwcx.xyz>
In-Reply-To: <20260121-pca9535-v1-0-164640e622ff@stwcx.xyz>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=MLT6OB2X8S5dkaMqs+SY/xPIl09Y2hCJfnP/u4HCPJY=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpcRgyUuNBTf6s52zLCxmM8omLdXWOc11AUD4pT
 4BaGmntt/KJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaXEYMgAKCRCrA0fMLQDB
 GVQ7D/9EVWpzU47eFwfYCg66+14OFseA9jHn0PG5UQUoaSlF1+IGl17V6F43bdxIHdKYFGVfL9m
 9GxsYHUULWsdoN8XhLxhEIUAC4xIn0mKktbRFAFmYBeV93CmItWOWkzPNDiuGUToMT4lo5KCds1
 nz8zCFBVfnoltdIwXWM9wD7V1KQu2YBUIOwl6frcWS5dphufEoPqtlmsDwijTapb+ssUEPtl9ih
 cF3umM6HBR59s5N2AEWmOWrqKP96y5iUzn+uiNcC3h4xTol99e0Ds6aJnXzVpNNrnS6tukX5tM3
 Gd/wjbnixiKLVZxsvEjqy683yxlx+D+QPFFrsQ7vtlFvq2yjTTbuVAs5jrV8QrUQiInpbX9Ma1+
 ZHLE/PJWr7Kyqq9XOaZu9vtGwSSWkLM1ZJy8EA+/3QM5p9vQsY2Q/NrNuLKUrPJ07394AvMYYgI
 xp50qAjYpqRXF22aIxlhtiJTaCc5zpZp2TFGTKYqoLSfVF2IAm7JgimN6FFNQc5qDuuaA370vHO
 00xl1jBhpNe33KclQBWbxKqyJTbDYaDHFfbNWTExQviboqNNMCOiUqMXjfmr7RhJmMizU52t7XS
 B2gj0yKsE9OWkUGMrMvnYkolS0OsDuiy9nIglbAd051FwW3kMdbRfDY3ZJiPmkoNfP39kGHSnGR
 KHpowPuE3yDC7Ug==
X-Developer-Key: i=patrick@stwcx.xyz; a=openpgp;
 fpr=0460FD8A2E0B13D70D6EA241AB0347CC2D00C119
Received-SPF: pass client-ip=103.168.172.145; envelope-from=patrick@stwcx.xyz;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A few entries in the catalina model were using the PCA9552 chip
because it was "close enough" in function.  Since there is a PCA9535
model now, switch to use it.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 4edb30bb16..65495a524e 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -480,7 +480,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* i2c0mux1ch1 */
     /* io_expander7 - pca9535@20 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
-                            TYPE_PCA9552, 0x20);
+                            TYPE_PCA9535, 0x20);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);
@@ -497,7 +497,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* i2c0mux4ch1 */
     /* io_expander8 - pca9535@21 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
-                            TYPE_PCA9552, 0x21);
+                            TYPE_PCA9535, 0x21);
     /* eeprom@50 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
                           gb200io_eeprom, gb200io_eeprom_len);

-- 
2.51.2


