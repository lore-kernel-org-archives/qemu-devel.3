Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDD8EB362A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7e2-0006Sb-Me; Mon, 02 Mar 2026 13:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7do-0006LP-Bj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:13 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dj-0006YO-HW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:11 -0500
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 4BEB4EC0620;
 Mon,  2 Mar 2026 13:05:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 13:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474706; x=
 1772561106; bh=moIemkxzO52ufwY3uoVnk1ywy/WIbJMWBe10qUmFuJs=; b=c
 bwGGVRDU9Y8ERPo6/9jPusKTW478fWB9mkg5SpubFsh2sUcgNg6RWCdqW1UhVTJf
 OUFfgTSsdfW+d1HqOGl2ZQ2xgTmFxTtVNeWqTLsDzCcVU0Jc46cisCXLIy6P3SLo
 OzkgPsuj4RWWkRwZ2hTLgKyFGd3fvdkL/pRdouB5VKcO9LoBmwezfgmJzByl5ZFL
 rcBcfG6F4vH3IMXhRgrjvIKrVfxVTJAxNSYl6dch/zqEKVKeb0TqE4KD0G4eXAtj
 nie9oZ/mzCwCHvnmvmtDRTFSf43WG0CxrsFoeQmYkYh4KTSSM28o65Jj6JCCf4fH
 9oEZ92uWXPibfHeAYXDIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474706; x=1772561106; bh=m
 oIemkxzO52ufwY3uoVnk1ywy/WIbJMWBe10qUmFuJs=; b=G0Pa3/AnxXN6c5+D9
 ttuxSSSgRgmP5vyWcSKdudd0gNLF/0OrcL+hNj91QlQcXqWspLvMsdTxxYLdSzTp
 giccYhjnGJ04BLWek9atlCJ+t6/45sq9SMa64SKyj9CFlidWRjC8p50R0XhIhT+g
 Y1X0+UjVnDjkn6UQraoNdi11Nl2xnzyVSUaLUQreKgX1JBrSTXuWS78N20ygdkxm
 XDBi/Qtt69hO9+YqyEwKxFFt0iROGvELplWWYHNWoiVQMAlaS6LRBqM8cI/c8ETw
 KEXfoDSbVKaKjbx6kduhgDdT8+xy7lL8IC2d3tZIB9LTLrJtqoJWUUhYoZvVX0rb
 Ud4GQ==
X-ME-Sender: <xms:UtGlaaGMFNEi4hEE2I9o4VsF-GzHUqjAa2TLbBjrRF6VJIFEzO0-cA>
 <xme:UtGlaSNtsdlj9gRnzFGDDPh6nW4j_LolADXvsEnvv24AC_80lP9D-RIeaZc_AkFdF
 rhNoBzBy_qkYie0r35G7DQpiLs4vmmnp2cg8k7yqeq9igAov5tUCZoR>
X-ME-Received: <xmr:UtGlacd877EcV4lZWTGJVCKjmzTySqC_fOnXGU28gQ7hPRoGPY58cExtwdeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggr
 uhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:UtGlafsUKAxCMgeCg4dyLImfQvvAlcWZo6lIin4cX7k443aXCme9cQ>
 <xmx:UtGladktZGa2h1Es4henQ1tGWgd68_8g0RwabXJUVZMHGa6LSQ7h-g>
 <xmx:UtGlaRzV4A_XELEwY8L5jINOPSdfJOpy24bGSElcNMvjV1JATuPpMA>
 <xmx:UtGlafMsO9ZtYTFM_xAI_kYcKWGiUc93akrZO_oEGQ8LV0pJmnWCOQ>
 <xmx:UtGlaWrjYRcQZQdd4kyAUkMJcKC1T-_R4uFJqesKnjC67Y4Qe2FnH2IK>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:05 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8b10d850;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 14/17] ati-vga: Remove ATIVGAState param from ati_2d_do_blt
Date: Mon,  2 Mar 2026 13:04:44 -0500
Message-ID: <20260302180447.1078098-15-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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
index df8975d9d7..4fa28f7beb 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,10 +123,10 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-static bool ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
+static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
-    bool use_pixman_fill = s->use_pixman & BIT(0);
-    bool use_pixman_blt = s->use_pixman & BIT(1);
+    bool use_pixman_fill = use_pixman & BIT(0);
+    bool use_pixman_blt = use_pixman & BIT(1);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return false;
@@ -269,7 +269,7 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
-    if (ati_2d_do_blt(s, &ctx)) {
+    if (ati_2d_do_blt(&ctx, s->use_pixman)) {
         ati_set_dirty(&s->vga, &ctx);
     }
 }
-- 
2.52.0


