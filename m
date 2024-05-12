Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BEBC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 13:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s699h-0005a8-M9; Sun, 12 May 2024 09:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s659m-00061W-Dj
 for qemu-devel@nongnu.org; Sun, 12 May 2024 05:06:10 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s659k-00027Q-NC
 for qemu-devel@nongnu.org; Sun, 12 May 2024 05:06:10 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso2308718a12.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hikalium-com.20230601.gappssmtp.com; s=20230601; t=1715504767; x=1716109567;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdI1fpsD0kqTy3hmKUodHG+ojwqTaKIz+PipLhkc9ks=;
 b=nsdNJ0rPO9GNeAij8kDscLTd3BpdDuAqvZ83YimpRXO2whK3AZ4bqFj9zP2VqPtHVt
 vkWuXwIT8cyNc2JweIUphM4MN8hWfXf8uGPHA7/b/P7XhKLrqdy6DrL/LNxe0ftpB/T0
 UopXteQDfkXioGwtWpMTqlVxFJQ/1v8Tv1IemzIBWKy0Eyj0P/qe3/kKaB+JqaXNhqfq
 95N9GmlrGWGqhsS+BtjXiY2/mPF8RtkTIIuXxUiK5iuKfjtZ9vhNEJh+oQBNgKSlxQ9+
 vCudle3ln4RHdAJp8h5HxOlICij2ithYiz8Ez8hx99nli0R6ju29HdF7odcKdpDeUfci
 vwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715504767; x=1716109567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VdI1fpsD0kqTy3hmKUodHG+ojwqTaKIz+PipLhkc9ks=;
 b=FfKEuIhiIeCAu2YXeFRBPwT5EIQHtRUIFu5wdNhl+lk2BchWpRTeOpFzDbteDPnQEi
 q20kQM76lx1pLEADLAO+aNMOP1iU7rnKHDICG5svdGNsCs4HSG5HvESaSTj9AhFHmWcJ
 jBRLO/PPcqnKr96i0Jo6J1xphxwLEwYNIe9Os0TqmPBr9jNvPGR/rD04h08vkXQQ4LHb
 1lHfr/O+WjC5dDlD85SFhUzjTHZahnm3A4+NxYwFuXosyJDOoP3n9SQd/yai+NMwXnw1
 moLeQpC1zYGrRzgJRjk9ofZ8wrQsRyuD55pZsVsG0hMd4hNXWvw6++K5BRpCxQpBEd1h
 TsQg==
X-Gm-Message-State: AOJu0YwPhDiT2KWN9hRQVfJa8OkEe3F5Oayn+U5AghIffhRKkoYRjSJ6
 DHTIvOLrChNZdlda49VJExKDMk7huKHwSJ1Yn3/JBDY4G5r+vkcz5FGakb1KepFSW2qBQOJ1j/B
 4F40=
X-Google-Smtp-Source: AGHT+IHzaFaWA0ORhyEAuRUc8VZzBf6c2Pe2AYrUfroo7+Gpt4JvsGC5vZT4R5BdEpeVBCQsCWYvYg==
X-Received: by 2002:a05:6a20:d42f:b0:1af:b89c:a8df with SMTP id
 adf61e73a8af0-1afde1b7194mr7473508637.43.1715504766826; 
 Sun, 12 May 2024 02:06:06 -0700 (PDT)
Received: from penguin.lxd (113x36x63x49.ap113.ftth.ucom.ne.jp. [113.36.63.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ade232sm5466466b3a.104.2024.05.12.02.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 02:06:06 -0700 (PDT)
From: hikalium <hikalium@hikalium.com>
To: qemu-devel@nongnu.org
Cc: hikalium <hikalium@hikalium.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/2] Fix mouse/motion event scaling issue with GTK display
 backend
Date: Sun, 12 May 2024 18:04:29 +0900
Message-Id: <20240512090429.29123-2-hikalium@hikalium.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512090429.29123-1-hikalium@hikalium.com>
References: <20240512090429.29123-1-hikalium@hikalium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=hikalium@hikalium.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 12 May 2024 09:22:18 -0400
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

Remove gtk_widget_get_scale_factor() usage from the calculation of
the motion events in the GTK backend to make it work correctly on
environments that have `gtk_widget_get_scale_factor() != 1`.

This scale factor usage had been introduced in the commit f14aab420c and
at that time the window size was used for calculating the things and it
was working correctly. However, in the commit 2f31663ed4 the logic
switched to use the widget size instead of window size and because of
the change the usage of scale factor becomes invalid (since widgets use
`vc->gfx.scale_{x, y}` for scaling).o

Tested on Crostini on ChromeOS (15823.51.0) with an external display.

Fixes: 2f31663ed4 ("ui/gtk: use widget size for cursor motion event")
Fixes: f14aab420c ("ui: fix incorrect pointer position on highdpi with
gtk")

Signed-off-by: hikalium <hikalium@hikalium.com>
---
 ui/gtk.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index ebae888d4f..4386198c95 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -887,7 +887,7 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
     int x, y;
     int mx, my;
     int fbh, fbw;
-    int ww, wh, ws;
+    int ww, wh;
 
     if (!vc->gfx.ds) {
         return TRUE;
@@ -895,11 +895,15 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
 
     fbw = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
     fbh = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
-
     ww = gtk_widget_get_allocated_width(widget);
     wh = gtk_widget_get_allocated_height(widget);
-    ws = gtk_widget_get_scale_factor(widget);
 
+    /*
+     * `widget` may not have the same size with the frame buffer.
+     * In such cases, some paddings are needed around the `vc`.
+     * To achieve that, `vc` will be displayed at (mx, my)
+     * so that it is displayed at the center of the widget.
+     */
     mx = my = 0;
     if (ww > fbw) {
         mx = (ww - fbw) / 2;
@@ -908,8 +912,12 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
         my = (wh - fbh) / 2;
     }
 
-    x = (motion->x - mx) / vc->gfx.scale_x * ws;
-    y = (motion->y - my) / vc->gfx.scale_y * ws;
+    /*
+     * `motion` is reported in `widget` coordinates
+     * so translating it to the coordinates in `vc`.
+     */
+    x = (motion->x - mx) / vc->gfx.scale_x;
+    y = (motion->y - my) / vc->gfx.scale_y;
 
     trace_gd_motion_event(ww, wh, gtk_widget_get_scale_factor(widget), x, y);
 
-- 
2.39.2


