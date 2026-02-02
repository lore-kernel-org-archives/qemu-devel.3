Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49C5E7FDCD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0qZ-00082K-98; Mon, 02 Feb 2026 15:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q7-0007MO-BM
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:09 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q3-0001p8-0j
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:05 -0500
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5A16C7A011C;
 Mon,  2 Feb 2026 15:48:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Mon, 02 Feb 2026 15:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065280; x=
 1770151680; bh=qSHmLXKNfNg2sdIpTDz+KjNqOgrCDOYvimFhzR98RCM=; b=R
 48OosDU4hoFLiJGN69GPjQ/td9LG6nBGtV+lShguNaus8AvRXK++qPHi60hNlwY+
 SLRRtIyk1QKjkppZUBd2vsp3Lkw0P2nbd6euAH+jskW8Ge1YBGAHiCGiIxsOclhI
 RsEh3xJp3CzXny78tDB7OrHT5kVcKPKfOb9jUzhQxCp/VXYPcLy5Hk4g8Ki0zVGD
 EdM4oyPeEXj7GceJeyuXTs8Y1HOQs+osq51umkX4Ci5GeH/BhPRFOACRJju/rbp2
 //6Rm6wOcnjLcfwKYWccqikFOhcMV3s8+Uldggl1yR4Y7doOBTgUZMsC3r2qkKsg
 0g4KpfxQEM0MO1MbwTXag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065280; x=1770151680; bh=q
 SHmLXKNfNg2sdIpTDz+KjNqOgrCDOYvimFhzR98RCM=; b=PhiY1BHVoYn+N2hgu
 RC2wIrkbOWcIjyzUwpj3I04mAPBAIF0vodq72CjtVOdzb2Yuu88N74m71cChxNU7
 ikNX7x0q1q0B04YwdnprcCTy/Ci3qzj4feDuI3kz8Ixc+6wDR5ABZ/hCN5WyxQ0o
 pHMcMhWhOAnFMr/ChH/vdjsan1/NlE0MQapYwqNAw3liUD914Og5yyU6C+aF+rhT
 LSzO+XaUExP89+lJL53Fh4uwL95rmk4gXBlYL3vpePZxjTgZ4WlSDd3F9FqM7Kj7
 IEuIYFP0lTbMy6H5Gk6y2QQsNc34K2PTD8u2fMEHExOIpR6e20IRGc0jl9SmIOvZ
 E9RJw==
X-ME-Sender: <xms:gA2BaVa_nErJ1g5MMZ8i1vuplpirMilaa63vRx1dpQGrpOaTvXRq4w>
 <xme:gA2BaT2zvkEOAMVuCRIAZj9xIxDMT9YNJQKEfeGboAx2h-fvRBkSlNFq2-0ZyaIKz
 PAmElHfv1MdTpXx4ruwdiMj1QZ_zpoM7EHW4OQiHUnIMBF1OytLQftn>
X-ME-Received: <xmr:gA2BaVUn9anfmAfJPPxBjTcN5qjMXehGB8S68WdPEI-FcEYFlSe_yrBE-43z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:gA2BadWg3n_93Xxj7WOqR9ws363zGUv5UTjtZZ3c4yvYK-i7F5HGrQ>
 <xmx:gA2BaUdUB9tVUXxY708aRWhYnhYUBFbczv30GPsN9_ZDObwOr7fCAg>
 <xmx:gA2BaWUt3CWaKjnGDtXtqWGdRyBAobVt36H73OzA2LBVFZe6Z4WgLw>
 <xmx:gA2Badcbd8zbLnV7CuM-u4jMJ-PUezci10onFAXqjUV3MFdw9CQdtw>
 <xmx:gA2BaZC_3n8WBCXvyXfq3lYmq97mJYYSTNTia5iPl8t2VrOFs2zGd1Kn>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:47:59 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 6ccf3d9a;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 14/19] ati-vga: Pass use_pixman to ati_2d_do_blt
Date: Mon,  2 Feb 2026 15:47:32 -0500
Message-ID: <20260202204738.3080092-15-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
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

This is done in preparation for the removal of the ATIVGAState *s
parameter.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 4216986b6a..8397a4d1bb 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -121,12 +121,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
+static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
-    bool use_pixman_fill = s->use_pixman & BIT(0);
-    bool use_pixman_blt = s->use_pixman & BIT(1);
+    bool use_pixman_fill = use_pixman & BIT(0);
+    bool use_pixman_blt = use_pixman & BIT(1);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -277,5 +277,5 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
-    ati_2d_do_blt(s, &ctx);
+    ati_2d_do_blt(s, &ctx, s->use_pixman);
 }
-- 
2.52.0


