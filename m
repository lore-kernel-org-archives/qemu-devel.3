Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42871FCA193
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 21:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzi3L-00038u-2x; Mon, 09 Mar 2026 17:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vzi3J-00037e-1L
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:22:13 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vzi3H-0006V7-0i
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:22:12 -0400
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id 788021D0003E;
 Mon,  9 Mar 2026 17:22:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Mon, 09 Mar 2026 17:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1773091329; x=1773177729; bh=TDmxJd1n0l
 VxalC7XobRChArboi79ijwwEcsy0giF4o=; b=OttroM4hE6VljeaxhMVg61Romf
 rFW6CAPgmYawVemZh7nqfGZ2M+50YIeF6LHJYQlBzcRS3+QguxHhi6VhI5hZbhDo
 /G+VdDJByH6SrMdGxfueOrEJsJmHSsaJ+Ae7ApJwwoQ6HifGMA1ft/Wv9/Jt/Lh4
 ay/+5+wxUsTEcCSZZQC2nvr2AAmEZvNppLUGpEm0jxRA/wdnmGZfX+3DMUTC7QJq
 edb8lRTqnJ+5QMTR4medYnUg1IR5EmYCIoyVV9ffDwEQAQHaYq/wpfesVv2UkLWW
 x/d/EUG6zBB92uSMEXyNxxnQamWXQhZnrBIrJpZiv9Lj3z1jOX9dfGBKzB8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1773091329; x=1773177729; bh=TDmxJd1n0lVxalC7XobRChArboi79ijwwEc
 sy0giF4o=; b=o+UaMM0oAE86lfyu+mkWXUuHiYlatqeeozFYO+wNMm5T0M7v7Uk
 UPQRjf9JhrAzd32moaOjlC4xD0BE2psMJ09gX1Ql3MzRZbVm7UnQz3klg0L796We
 jY20guKNna11+SXKQIZ2LwCT9matinKpcJZMyIYLyj4ZdBOH2RFEwV8wu0CgIYGA
 TEhCWsxK4HjseE9i9CdID0QfCX+ao1rrjd26DLyNgxTGKzJFn2jq1Sc7pyLM1nO0
 rOe1T6qkQKkzpSvDLM2tSrCmyvGToiVu64W0pFgU7MxSXMwAOTN12cDlGMcbGXCz
 2hFwkHG2NSZnLpPLSlDV4b+cfin5ysqyEWQ==
X-ME-Sender: <xms:ADqvaU70LyzjHYV1WT17wQOPUeVwBHweiF3bVVRMbpnx-Y9vR4Kzew>
 <xme:ADqvac7Z_ySgk0RcSGDbH9FxzAdei99KCjUX5f_6zzaMH02qXK1YiL73AbLnJ1ruF
 ntvR1-zG-EFS6do5DUf13Blb-sHEBi-S5WUmludy7LNzI6sQ_3woWFx>
X-ME-Received: <xmr:ADqvaYfecHovspzPv08HzAdri8W5Orh0y_6rqQPJwmd3DyT_qYtK8gSGKGd3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeludelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
 hfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnshhkih
 drgiihiieqnecuggftrfgrthhtvghrnhephfetuefgueejleetgefgieegveejleeggedu
 gfeuvdehgefhffduffeludekieevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggprhgt
 phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtohhnse
 gvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhg
 pdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtth
 hopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:ADqvaYAXkJlDYqsZTeKs7Hx5_j8YpyABSRhn_LUj2XGGbMnXQZW4ow>
 <xmx:ADqvaT83uC4IdIiBzv5Tm0b0hekEMzrYnvfTyMaZAHJmSmo9yUa1Bg>
 <xmx:ADqvabJtvERKwsJW0_rbhl7wNGiicxPue1qx2xvnEtPchxfTWNsAKg>
 <xmx:ADqvaUi0y5JRFr3lXDKT9uaJQIusGQqfU6HlRB0ZhmrB-7IaC3Borg>
 <xmx:ATqvafrO0_bG8HKK3Doba_HdpASV_ZW8eiCAFTRY3NrbtT7IrsMeNjwC>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 17:22:08 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id b52f5627;
 Mon, 9 Mar 2026 21:22:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT read
Date: Mon,  9 Mar 2026 17:22:06 -0400
Message-ID: <20260309212206.2457691-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: 34
X-Spam_score: 3.4
X-Spam_bar: +++
X-Spam_report: (3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Cast default_sc_bottom to uint32_t before shifting left to prevent
sign extension when assigning to uint64_t.

Fixes: CID 1645615
Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 6cf243bcf9..f9773e1154 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -514,7 +514,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val |= s->regs.default_tile << 16;
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        val = (s->regs.default_sc_bottom << 16) |
+        val = ((uint32_t)s->regs.default_sc_bottom << 16) |
               s->regs.default_sc_right;
         break;
     case SC_TOP:
-- 
2.52.0


