Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A7DEB3658
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFna-00082B-Ib; Mon, 02 Mar 2026 21:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnT-0007pK-Kc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:43 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnQ-0002qy-OW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:43 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 51247EC02EA;
 Mon,  2 Mar 2026 21:47:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 21:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506060; x=
 1772592460; bh=moIemkxzO52ufwY3uoVnk1ywy/WIbJMWBe10qUmFuJs=; b=P
 EVrNMtcfmFFmhAEEIgdJqnuYirEJlxiy7tDFTmKKNDkW5C1BkAE2z81QqzrchhyZ
 IcHcoU+Aw2ieKgkK+qWMFpcp57ZdaTrPXS9pv1HckAi6cBsm4RUfr8BCwhj+L2K/
 g0Ql2UNx+0D8fD+FhwnArGVwiMFbM35dnAI2gjfa+8+sfa6G9GoplwOjKksu7FvH
 iU9QSvd2zQuq6puqe5EPCfPBQYgjYJruRiiFnzIakH4fZ5cZJvts30m/tJTzthsq
 bO1AcVagKIWGaX6QtHNxEOIi3/Z0PKnYL+45WzonXX2aq0nTfwrrDGYCGiL6P+gi
 pRt84Ude2M3NZMqCxrIRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506060; x=1772592460; bh=m
 oIemkxzO52ufwY3uoVnk1ywy/WIbJMWBe10qUmFuJs=; b=rB3NlPOmCjGAVrWcE
 5xMKfZyfdrfrv0GHcfcmbs/Eam6YI+v5UYKZipNTzFotJ1yIbCiLE+2mNldntMDc
 YjLfevtbexMWFCc46rQNAl4YthfqHiYpklIwYuizvidphZYurLNcq5dgIUJNwh+G
 FZdkwquC04T+YuKj751xZQCPRg1cOak6PD6Ubu4FFSMawtMOyeaJhomodo5DVSLk
 rcEwtRC4z9xf+qFlFoS7lnjW9TgtIi9jhwnFkkjKwWLiE3WmPeQaxLrC+jpRTuNF
 PmZitDRYo6QTLTewZM9Dr8IY+E5T95gpjDy6gGvru+JMDa3pPXkKo0nCHQzmW4Co
 ch3tg==
X-ME-Sender: <xms:zEumaYgFVh4sbGJZf5a7WtbIigx1X5MHvuX9qj4At9BYBS72jXlKqQ>
 <xme:zEumaSi1mcLr3mi3DCiKPlLqohM4AXO233Of1Qe1VcDKqnb3KQDolXfaP5NbOQbIA
 No9MEOoPCb-FAyiSuBxTUDCmB30WCve5n6_5sMYferANGSw0mQuvPo>
X-ME-Received: <xmr:zEumaQLPKdormihhjK7AOfj1i7jSt72ezHUQY34P5R-Cv0xcI2W1G93g4Rqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtg
 hpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:zEumaZFJnQmOd9j7FwBotrOkVuTljWw9n_q_DWNiZr8VsNKS-yqotA>
 <xmx:zEumacTg9U37vSwr-0J-weNTS8_IRxHDNuzWPGqUNj1h7v8QPdoRqA>
 <xmx:zEumadcMwj2bpXRZQGez2IOqLIcZgka25Lua5vbQPqdDUJfXT71nIw>
 <xmx:zEumaTr8HzS8fPTnNjwTXL3hFBoZN_cBaYU0WYcuYq4aIPNfEbo6jA>
 <xmx:zEumaZo2edCJwflGk6olJzR2cC6hOsn9d-HChAl_woNOCF2hM1bGeWCT>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:39 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 5a1be193;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 14/17] ati-vga: Remove ATIVGAState param from ati_2d_do_blt
Date: Mon,  2 Mar 2026 21:47:27 -0500
Message-ID: <20260303024730.1489136-15-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
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


