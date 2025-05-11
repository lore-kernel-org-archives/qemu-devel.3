Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE878C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1D8-0003yT-C3; Sun, 11 May 2025 03:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1D2-0003s8-Rf
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1D1-0003ff-A8
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so47507645ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948889; x=1747553689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8/qrbN8SL3D7304Ebsbfdho9U8Wr6YNdQY2YgeEWjw=;
 b=LdPQNJujfrRv3jUmvKieRXHXCvP2+1+Q1nrurOX4MSmyz2npkevhjvUQl/E5RYUszF
 i2m4WtlLEETfWgAT8I5zv/cpPaAKKwbDK7rIgqvceU1uj1JfMTBCT5I/hUSvAtv5K6OZ
 7NcZKi8N5CCtCPc7o6AvWdYX0J1NGkxMmhlmQYiQZo01xhVvHWiv5maEkyWaAnkAIRxK
 Y7vH7GsETkpVIuJlhnrxkN84rOy06rzp0vH7rpXw3Hxb2kBwGabo+xVNr2aTpS7IX7Rq
 vbXuoFpL8Tfi+3ASN7yZT8use0Fl27ADSMv1oche6IUpmfhkHTVavtKnnka6mobHLdDC
 EKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948889; x=1747553689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8/qrbN8SL3D7304Ebsbfdho9U8Wr6YNdQY2YgeEWjw=;
 b=opzerny8BndsniOIGEkAI/rbfW28HngaWGSu+CW88N17qVNUJueSz32JsbKJFSVVlb
 I5iZMkDgre54/3gA0PcQR8EgMxMSsOEXMJ5rnCxUNrg3kcGtAnqSAh9RC6CAnlIdzLxS
 9697ZIRBE40JQiGK/8O6ZM6HGWG1+NTZq70FAsUJxMuKFE9sg41GWy0DWILPEoOiMmQo
 muK1CytqwekgltFYumWpncbOr8kDRkBHdM0ZzBubEpv+QS3FlMglCLqBtYpNatxjd5Ly
 1cMEsGwq6jgRZCqdrWr16jZsn7TaP7unt0VR03qo8HnvjwQ7oPvmXfd1UKOzM1iorg1y
 ZCbw==
X-Gm-Message-State: AOJu0YyCs4ENut+gUDPl8YA9NTXrYTRtwFwRXPGxOabnGLXBQDbt+ncr
 seVDumC7OicJ9VRaC8UVQY9MjZNsHUeQfQHKpBA9vQUGttm1k6d1PFGpbdQO
X-Gm-Gg: ASbGncssx8y6Vai57URVP/yPt2saLrkceixHQ4QQkF3W6f18/ZLDhytZplZ51OO0HHV
 Ad55fDY+huKDgVB9cINJyWM2hN2DJSEeRKTtzRcSJSTANfO6k7jZZgb9Cf3o4wGoBKYRLs9T53n
 mpu6bgiC6nqbVvcODaQZGMgFtE34pR7fPdQdwjwqjWlvrupi5Lg0CyutoWLJFBJscQNuMsqA91h
 V0uh4/EnZjon9FegPhhS06ekAwdKrOxWfdChrtYpP0sPCTI4s8XP2fDOkZRoIZNpbVW/4l1nraE
 xvH++7dGgdkIXLQHIAz+LBV9AQj9VvbnRIDHKhVjzQys1APrW4i1Lng=
X-Google-Smtp-Source: AGHT+IFPfyFaq+GzSPb1tTf3XZql8JcfUh5W6+WHNZynBDt6ScBKYP8BH1bBec401PDsV0NryiE6AA==
X-Received: by 2002:a17:902:e84c:b0:215:58be:3349 with SMTP id
 d9443c01a7336-22fc937b1f5mr160639745ad.14.1746948889480; 
 Sun, 11 May 2025 00:34:49 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc75498b2sm42483605ad.13.2025.05.11.00.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:48 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PATCH 6/9] ui/gtk: Don't update scale in fixed scale mode in
 gtk-egl.c
Date: Sun, 11 May 2025 15:33:16 +0800
Message-ID: <20250511073337.876650-7-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Scale shouldn't be changed until user explicitly requests it in fixed
scale mode (full-screen=false and free-scale=false). Use function
gd_update_scale to complete scale updating instead.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 ui/gtk-egl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 947c99334b..f8e4f4bc70 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -95,8 +95,9 @@ void gd_egl_draw(VirtualConsole *vc)
 #endif
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
 
-        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
-        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
+        gd_update_scale(vc, ww, wh,
+                        surface_width(vc->gfx.ds),
+                        surface_height(vc->gfx.ds));
 
         glFlush();
 #ifdef CONFIG_GBM
@@ -122,8 +123,9 @@ void gd_egl_draw(VirtualConsole *vc)
 
         eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
 
-        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
-        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
+        gd_update_scale(vc, ww, wh,
+                        surface_width(vc->gfx.ds),
+                        surface_height(vc->gfx.ds));
 
         glFlush();
     }
-- 
2.49.0


