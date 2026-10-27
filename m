Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E635606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z30tXUT+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmJh-0001Vl-1D; Tue, 27 Oct 2026 14:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLmJe-0001VW-N4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:54:34 -0400
Received: from mail-dl2-x07.google.com ([2607:f8b0:4864:38::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLmJc-0007Zq-U1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:54:34 -0400
Received: by mail-dl2-x07.google.com with SMTP id
 a92af1059eb24-14345ae29c5so64510c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793127271; x=1793732071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0wCYLhKryG/4/AaPqQtdkrnFAySv28kkddCUrL3HNzI=;
 b=Z30tXUT+koh6vzK7qWJ7W0mLP26EoS1EZX7EoogXL2xdQZd+SFiNRngnTdPTDZlT7M
 QPsuu9AUNyEzF0s0zDED9PSfBkth1ny3kq5ahpeFz64sqyZnQc5elGU2+WxBvLVWZ68J
 JsDNeIeFiwzcv2LPN6YpuSAlaNEx0Fa+5A9cJj/3yCIpQH8Ah7T3uV4jWP7RZhtch1Lz
 ktjgE5Ju2Rikfwy0ZFZVFpIRTlkcUgbtWi2qlt87hJuFT5+RpdppfHThnQLO72oT/WYp
 hfiLIEw6kRKWEiuc6hQ7AH7hkq520Vv+HUsogj0GK5cOHn2h8E9Q25MlPrlIt1piCdRQ
 GlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127271; x=1793732071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0wCYLhKryG/4/AaPqQtdkrnFAySv28kkddCUrL3HNzI=;
 b=m4PhTyTGVYsFpa2APjql3BbYZkwzLHJaHsijp77LHEUbYBnBdAzRq1KCGPZC5yDiif
 CnkrW0mool67xrUG12n+kogOwhWyAL60w47WCPDLdNPFNTr2f9YiRjIxKytFRbcXjgyt
 4vlFN+YImniZMJjS83lELsJ338IEvW/AzW4Hv4LbUuhVDPT4wu8V/60QQ9Dk0XE+fnwG
 1/6DSEGo4u6BuF2xUcbXZIKdMbuiu8ra6Mo8ZQrJgWkdfeChQFmMmr/Pn6HRy5t1ewXZ
 ESenb8o+/0Hy03ZEsOwiOm+SnJtRNAdHJlmD9NVn+596UVgSc01pTsjo0w8YFGuK0bk7
 5VJw==
X-Gm-Message-State: AFq9FYIRyHumGZtBGr5nxAwjhnD8k4SWGvC60/vRFVUDijbhYAzKyYY2
 fGpdjntApSKiNUxJA38e4CSL32SvicBmtjPxuiaUnYSSKOttEWke+UhYFXdMpPuUN/Y=
X-Gm-Gg: AYBFou3zWvgz9xh0cerL8ykG+KNGSTscPbqfW2pQGD50Ej58ws1PeXx6TsSy8hhLjyh
 t+lWTJ7LdPj79JYBZ64BVPi0p7RLeWgo7OpflVupXn04M+tGnoMbdqrOa6SQr9Ys0bbOY4ej7Jh
 HUzhPXfrGKRiyRdHmLm4uzpZmekCN3JztvhoSwvUrROHNGTPZm9tfPCwLkMp/R1FGl9+dCvUs/5
 HKxmpKdNipWpehuXulMuQiza6+LFv0EkP44sP0hWhjOS5l4gaekR4HbHJY8m1DiF4iydPrtpELS
 CRZaL0y75ZjKzS6C5hZ4wajAbtFNcMFd5F3pfGkmeMCHCtWuNysjC0dFihsoguJ7r9sEfxMIBXv
 oj7KmSPdSB/m7TM2emVtFt1u3NFGmnbXI+J/Dg26AGgRjr5GWIEb+Yobdg1mYRZ5vIVSIcUetsx
 M1K7sfYNsVNmmMVtzXk6HIYgDUeuNzVfzSJxQpEX1rHM1ntlYS5emVSQo1L8u6IqGrgeOq5cxux
 tHEiBKEgsvEIN+lPg4cLbH/h1l2ZaSCpgCFLLJEZ435m8qhtKkpc74Ou9ucUQ6S7/7VriiFh6uG
 8ex0eMoRESh797ZEhUHB37IvKxI8JvahzEf6NfF78aqq4LvTM8CMlPLDVLm4x1FRMbticosOVS6
 Ahjo1+G8jpAacicEN6KnQXOspDZQWLJbDpLU2kZmhv4Pa4wARkQ==
X-Received: by 2002:a05:701b:4349:b0:196:82a:b80f with SMTP id
 a92af1059eb24-1a6ceba5c32mr131171c88.45.1793127271114; 
 Tue, 27 Oct 2026 11:54:31 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a6da44c132sm75324c88.18.2026.10.27.11.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:54:30 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: qemu-devel@nongnu.org,
	sarkarsoumyajyoti23@gmail.com
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 3/8] ui/sdl2: forward precise wheel deltas as high-resolution
 scroll events
Date: Wed, 28 Oct 2026 00:18:52 +0530
Message-ID: <20261027184857.60775-4-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027184857.60775-1-soumyajyotisarkar23@gmail.com>
References: <20261027184857.60775-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::7;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dl2-x07.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

handle_mousewheel() only looked at the sign of the integer wheel
deltas and sent a single wheel button click, so any amount of
scrolling became one detent, and the horizontal axis was dropped
whenever there was vertical movement.

SDL 2.0.18 added preciseX and preciseY, which carry the wheel movement
in fractions of a detent.  When building against SDL 2.0.18 or newer,
convert them into 1/120 detent units and send them as scroll events on
both axes, carrying fractions over to the next event.  The direction
follows SDL's convention (positive x scrolls right, positive y scrolls
up) and honours SDL_MOUSEWHEEL_FLIPPED.  Older SDL versions keep the
existing button behaviour.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 ui/sdl2.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 1c97d23a47..0a052a8f2d 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -566,12 +566,39 @@ static void handle_mousewheel(SDL_Event *ev)
 {
     struct sdl2_console *scon = get_scon_from_window(ev->wheel.windowID);
     SDL_MouseWheelEvent *wev = &ev->wheel;
+#if SDL_VERSION_ATLEAST(2, 0, 18)
+    static float residual_x, residual_y;
+    float flip;
+    int units;
+#else
     InputButton btn;
+#endif
 
     if (!scon || !qemu_console_is_graphic(scon->dcl.con)) {
         return;
     }
 
+#if SDL_VERSION_ATLEAST(2, 0, 18)
+    flip = wev->direction == SDL_MOUSEWHEEL_FLIPPED ? -1.0f : 1.0f;
+
+    residual_y -= flip * wev->preciseY * INPUT_EVENT_SCROLL_DETENT;
+    units = (int)residual_y;
+    residual_y -= units;
+    if (units) {
+        qemu_input_queue_scroll(scon->dcl.con,
+                                INPUT_SCROLL_AXIS_VERTICAL, units);
+    }
+
+    residual_x += flip * wev->preciseX * INPUT_EVENT_SCROLL_DETENT;
+    units = (int)residual_x;
+    residual_x -= units;
+    if (units) {
+        qemu_input_queue_scroll(scon->dcl.con,
+                                INPUT_SCROLL_AXIS_HORIZONTAL, units);
+    }
+
+    qemu_input_event_sync();
+#else
     if (wev->y > 0) {
         btn = INPUT_BUTTON_WHEEL_UP;
     } else if (wev->y < 0) {
@@ -588,6 +615,7 @@ static void handle_mousewheel(SDL_Event *ev)
     qemu_input_event_sync();
     qemu_input_queue_btn(scon->dcl.con, btn, false);
     qemu_input_event_sync();
+#endif
 }
 
 static void handle_windowevent(SDL_Event *ev)
-- 
2.56.0


