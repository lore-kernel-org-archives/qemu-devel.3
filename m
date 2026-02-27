Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4FFFEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4eW-00035B-8V; Fri, 27 Feb 2026 15:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e2-0001be-Q8
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:06 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dz-0007Qi-S1
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:06 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9D04914001D1;
 Fri, 27 Feb 2026 15:41:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 27 Feb 2026 15:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224861; x=
 1772311261; bh=RONghVL5qfFab4fHWCH3aq+qD8Ikth6my46Lk/Xt2dI=; b=E
 /l0l9jENmMJ9E9t9u5VnJo5eD1IYYRU0G6PUkiNGntlt7sbPcSXT6oz/+r5NfVVI
 OLBwlR2CmqBmqt9nPkhE7QGITrDR+H62Hz6IcJDsIbUo8oHN4IIhjuZ3lzqddUou
 XskTkFiRv+GoDyIpLBh7o76lrCOi/n8GrfcA6vJq+guD75PW0ZX3USg9TTjzFx50
 kWkhttX5RYN0lGkqBl3LdQrWIMIqwz9wjimf+YeZTAcvxYtWl8qs1KDOXg9lkJc3
 Sxx+BfgGsREVmHcj1jZrEzQxAcjoPO2QVWdnemkCTto9l+o/rRdTKx9lf/ulVBj0
 H6TL4na75pgqrfrY5H6+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224861; x=1772311261; bh=R
 ONghVL5qfFab4fHWCH3aq+qD8Ikth6my46Lk/Xt2dI=; b=CXdfBL256Qd4GkHH6
 bHED6V183lx4YgZfMQX+KNs9/4h+SPdSlnNuai9c1QqAeItkcol2SOmSzMNnsydM
 QTONZiLsJlTrgZ0v6+p+LCNLYlRkCpavLZwdpY37Ock0vpk2bsIrxkBHWWtYO3QT
 cda6NMTtjIy1eQIx/njkKfKRs1I39ft/XWq6xZPlg48QPvVbig7RaGvu8L7BUZZj
 SqHQUpu59bf5/A+YfTcPsGABMqdLRkOvPKFCZhZbgsnIijy8dOkz3Vf1ddO2i+hv
 VvCvLrHJNukhLCpWXNi4eBOFLPrkK3jjftLFs756CkSc25CT3jNzxF6FRrIHLInZ
 Io29A==
X-ME-Sender: <xms:XQGiaYk3e4EXwI_NUa1wIy059nF6KUJLKB0tSj01R-mgZmuAvmtyIQ>
 <xme:XQGiaeuh1PAgloZlVwqfNWoPaQYufEPCrKla7rnooOl5AXVAeNcuZ14-DBUVfotmY
 -E5JtDCi_ywlGFAS5X8ecLj8vGrTJFArAX-JwHVZBxKI9mJW-9oC28>
X-ME-Received: <xmr:XQGiae-luEX2BilbYk7cKC0j6drVNWPy5TeWYAHQ_BynpMaGTIV_J35Nmagt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgv
 rdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtg
 hpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:XQGiaQOLqFSv5_XuL1OSvgI4WKCSf2HEUTH7yPtVqv-XTAQojQrSvw>
 <xmx:XQGiaUGfgW5aPTsA9XJoLLNB_0tyW-o7j4nVOfxDFRnBYKET8YYwpw>
 <xmx:XQGiaWSOLbSwcoZF3tJ5Gmu9AJBlwVoM_4lie3JIG6wBcIMaeLwHAA>
 <xmx:XQGiaZvAvPd87PtIa2ZRKwQ_vpb9Wug63bERMFKdIeNpEzHHa4LTLw>
 <xmx:XQGiabLChsXqxOWuxNMZOTaDit2gYNKgwMyNqdpvCImGmXrYaPuZTw-u>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:01 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 07c0fadb;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 14/18] ati-vga: Remove ATIVGAState param from ati_2d_do_blt
Date: Fri, 27 Feb 2026 15:39:40 -0500
Message-ID: <20260227203944.746471-15-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

This completes the decoupling from the ATIVGAState struct.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a93a267465..440c1d159a 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,12 +123,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
+static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
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
@@ -268,6 +268,6 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
-    ati_2d_do_blt(s, &ctx);
+    ati_2d_do_blt(&ctx, s->use_pixman);
     ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0


