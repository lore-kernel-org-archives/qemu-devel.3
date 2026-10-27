Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BB606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m5wkq31O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn4y-0006oc-OG; Tue, 27 Oct 2026 15:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4r-0006mm-4G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:22 -0400
Received: from mail-dy2-x0a.google.com ([2607:f8b0:4864:36::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4p-0003sp-Gx
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:20 -0400
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-33e48934fa8so62492eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130198; x=1793734998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zILaURUC9gi1c0UUUvY3rQWxg5TmKzPKSbRxjgbExNQ=;
 b=m5wkq31OfpzQ/4OVf3aI+n96fPdAEEwhSmi+tw/qLpxLuVxJq523jADphBQyo6dsA+
 VukoqgZfxsw5T1lUaZb/9oDCIl3y94uHE/s34sjLQQ0mlqJc1W1I6wF2S5GfASK0JIol
 O8RYPy2mCKuwHt4TpaHcV3OpP3cQxSuNlTnKIdrRKDiIluj4E+s1TkpVAUOa8R5FBqly
 L4lbBVtEj2MV/fzaHgc+jzs3FmLk+aD4bSXmmvc2BMyB9VGw8HTsT9fq8lkhWc0tJqnT
 TWyMINa2HYSfKzkK/S9dFTREE3EPoF1urjr+qMrVeBcYnGKLKU5AodtZUxA0fpjFk/TJ
 EfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130198; x=1793734998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zILaURUC9gi1c0UUUvY3rQWxg5TmKzPKSbRxjgbExNQ=;
 b=P52kMmOegiUBJIBzgJhGXMAxDqd41ytM2IdR1MTiLGpTra+Wd9P89P9cDf6amKGfFW
 reMav5n0H0MNTA0w1tLkhVIh6/Op0bOS51gbnnW39G4IacQr6AF8HkVLNVgmB+rwsF5P
 k/F6B/0esni8k0tICEmjAm9LoAjQU88IjmGkR3sDz8xHVmfZTi/tYlF4TI6Crg9BoIGz
 GFp6oFwbqHMT51h/bDqrq/MPt8tNs/wcuA66MA5t/4/vLVjQsPJT6U/QBtQY767u4ssB
 sc0IHPElGwsqavdi2VNKOLzy0kLx7vhiHPEpogrjQ440L0ytiHnji+pyqG6V+ITr4xH9
 p9nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOvzYa10K7FWaY54P0xScGBVwCCiB4BL3EGsajfWuDfLaJNYBaMk38Bt0QiPyIf1NdK6QqoENagABy@nongnu.org
X-Gm-Message-State: AFq9FYJLALx1+s2NOl/n5LkrNH5I7z+hLQ+m1QC6nTavh8teomhqDcx7
 HvYWL6gjr+4O93J+JX4AYr4axewkdp8MVscgAd3kqf9B6XTtfbe5reXT
X-Gm-Gg: AYBFou236h2upFKrno3twjdwsJTgXGqona7+aob/6l4qrxR/LGQ8vPDMQAIErTQOYJW
 fnWlsmpLiZVN+c2HzcrT6NUB2HVFfpyTZ+SgK6S/ZO8VtryZkRf3UjDpJPrd8zO8VbcGN4MR8g6
 affOb655UHPHIBWqs/ims91v4k3ALiMtr6Dl+R+j0Djkjq8Lu5+6iQhqVNWtvQHUViiXUwlWn3u
 7aOuQCfi5TrpF8ToCXzy4UoB34xYrfPVgLnxou9AMiTduNTztEdhYsvDvYj75Z6suI2BbtFueX3
 tB5TCrsMnkhJvx/0Yjdwg7EyL8RJbijLhlMtvY/Q8TRTkxv7WgAuuYXyjoOGKGuWZfujlqQIzeg
 CwZHpzdUV0TG9QVltOcXHhwKNZTP8/o4R/2xJWWiK+M9OfMAWFQi4gD03Phct8v6GIIxInNmqvz
 4ZWjThEgZRXISH4YVRp6MwV58eOQJWCtccpIaaQdI56C5yf+5jEKzIxF0Yl+jJcmJnT6Jbf0xdX
 2wtQ59pkHWzubOsVE01rm2uwWtqHP0xj7f2EngfnIKFPvEMZETukyLM+p4KWw003ACWWdRNpTx9
 9Rsy3qOgVcA1gG153C9ccz0nm2OmmlvEsAZ/CxN7MqrAR48f3yQ5p+zTsuIk/n/x/0oaQ1qDqLC
 qli+7NLKqP2oN1XUbn8JHvWiBsTZtcPSsaPCznAD1jGqS5mSfoteZo4A5wlNOCb9lnpTpJOL3
X-Received: by 2002:a05:693c:894b:10b0:36a:1b23:a1cd with SMTP id
 5a478bee46e88-36a20112454mr533988eec.9.1793130197546; 
 Tue, 27 Oct 2026 12:43:17 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:16 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v2 3/8] ui/sdl2: forward precise wheel deltas as
 high-resolution scroll events
Date: Wed, 28 Oct 2026 01:12:51 +0530
Message-ID: <20261027194256.76031-4-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::a;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x0a.google.com
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
scrolling became one detent and the horizontal axis was dropped
whenever there was vertical movement.

SDL 2.0.18 added preciseX and preciseY, which carry the wheel movement
in fractions of a detent. When building against SDL 2.0.18 or newer,
convert them into 1/120 detent units and send them as scroll events on
both axes, carrying fractions over to the next event. The direction
follows SDL's convention (positive x scrolls right, positive y scrolls
up) and honours SDL_MOUSEWHEEL_FLIPPED. Older SDL versions keep the
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


