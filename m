Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ECC10398AD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4eF-0002gb-12; Fri, 27 Feb 2026 15:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4e1-0001TH-I0
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dz-0007QL-3g
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 67F0EEC0644;
 Fri, 27 Feb 2026 15:41:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 15:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224861; x=
 1772311261; bh=Bem76XaBuWb9Xot1enKa+abtbFpjdjVizWhFW+ejJlI=; b=H
 CcfibrYFtnKh5Eb3htuLO4IlpckUwW+YcQZOFYyK3y3oV2QHlowGRmTT57Jwm5Tz
 i1LhfknP+vsgw8MzmWr7pIjgcSod2tV3LMKLPFSfUEG9SDrpy7/GqkF2WIglQ71g
 z4UTvEtrRixpt8U0lqQaLuoAU51GPFrKnAlvLpd4sB1BOVztQym152cjcD8IENQQ
 lAkAt1mycljn7zTfM8L4jm0ICl8bqypHVloXmrF2fufPFa8pprFuOdxW9Fv2Yhwx
 +V6CnCoWcwneTVgOSsxouRRSL6+k7vpe7jK3u5WTOqP3Le9jyCiD8ud+vDzXVQqd
 pdIBuW4J8WwM2M7Yxwvxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224861; x=1772311261; bh=B
 em76XaBuWb9Xot1enKa+abtbFpjdjVizWhFW+ejJlI=; b=ZjjHhiWkPVUwnTXse
 Ne4PMvx8weZ7gf3gxsLhBY5GVYkVinaNqW2FZY8/wZCie15K/S5pp8wDWPBsADp+
 IDVUcq6+eUOlUIcxD5qyP1vN1qOojJI7j6Y+87OCANyFSSGp8ZPIwFOdYzJDXByk
 UI/wXDUd76zPk9JOUQB+Pq2prJIF6uL8RB2zZs8s4qNiOOifZ6+8zcZrc33MP1ax
 0GY20Ta0krgwRa1hp6E+20BFrx4pAlAynopKl41gObwUq56mzzN6rsRcG2WeN/4C
 xtR118S/fjW6J/c1UXgxJlLJ9fRw/GbHhQcVsPoGFtmWVAmZdy8HM3nmdwqBnW+5
 PjOdA==
X-ME-Sender: <xms:XQGiaWUSEKyqKWiZL9tkjPAf_ixzmdIAq3pralbRVvrVyzC4UWaiMg>
 <xme:XQGiaZd5p1m5mKxGAI71iSVO0ouhQ3_i_SDMzz6ZSN0A0Qx7E51en4ot4o5wUqWyU
 Q2fx8TXsC2dl4jk_ssuYP0Ek7su8M1wZPDv9g6PYzw0sT9yf7UHobU>
X-ME-Received: <xmr:XQGiaSsC00_iLu3yueJ9UoZFOl6SQBMQCtzIaDFf-w_2OCigFxxoSP8JusOK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhgrgigvlh
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhn
 uhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtph
 htthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehmrghrtggr
 nhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:XQGiaY-4D2BZBlVJHIRir-NYAOQEyAoDM_xY9anQom0uRDp7rwK15A>
 <xmx:XQGiad3La2HEXKPqry0RCscSHolb0n05JwF6fla_lL4ClnqEjaPsOA>
 <xmx:XQGiadC0xu05fkYkrt1pMZ0HV2l_UhQPXd7v7KwfAWLKXxIzglhNwQ>
 <xmx:XQGiaZckByqgM4kkTbSZdQM5_Vd_W1FngUWX_PM8WgKIsiG_2_7ZTw>
 <xmx:XQGiaR6Ca8l3LUKS9KLSL2Cnh6UOwIwr4GH5bByl0yO89es7DJ1UM5kz>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ab8e299d;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 13/18] ati-vga: Split ati_2d_do_blt from ati_2d_blt
Date: Fri, 27 Feb 2026 15:39:39 -0500
Message-ID: <20260227203944.746471-14-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
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

ati_2d_blt remains the public interface to the blitter but the bulk of
the implementation is moved down into ati_2d_do_blt which is passed an
ATI2DCtx.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index ebcec07334..a93a267465 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,15 +123,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     bool use_pixman_fill = s->use_pixman & BIT(0);
     bool use_pixman_blt = s->use_pixman & BIT(1);
-    ATI2DCtx ctx_;
-    ATI2DCtx *ctx = &ctx_;
-    setup_2d_blt_ctx(s, ctx);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -264,8 +261,13 @@ void ati_2d_blt(ATIVGAState *s)
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
                       ctx->rop3 >> 16);
-        return;
     }
+}
 
-    ati_set_dirty(&s->vga, ctx);
+void ati_2d_blt(ATIVGAState *s)
+{
+    ATI2DCtx ctx;
+    setup_2d_blt_ctx(s, &ctx);
+    ati_2d_do_blt(s, &ctx);
+    ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0


