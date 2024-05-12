Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7CAC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 11:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s67AI-0008Cx-1G; Sun, 12 May 2024 07:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s67AG-0008Cl-Ph
 for qemu-devel@nongnu.org; Sun, 12 May 2024 07:14:48 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s67AF-0003js-8w
 for qemu-devel@nongnu.org; Sun, 12 May 2024 07:14:48 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ec41d82b8bso32973655ad.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hikalium-com.20230601.gappssmtp.com; s=20230601; t=1715512486; x=1716117286;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybklGZsQ5B6bwbft1vxCvRI45enWgIukMcnmLJbokgY=;
 b=ZKk/8r8WAzgEKWfgamIaycNBDQQiAa5Mj626/F78klOU6lnDroLMxeskxC3dkBCnZd
 bmlJYV1IfjNyadWiFFsmM9Bd7759fHOOp0gmxEvVryNS+oix1ndR/LN6EHGEBKlD7dyS
 7/R8nRB7HsHThHaEEsDUCpgxmxZMjfeIF0XQ0a3Fm9XAKeINFVa3X2z48MDTX0/L4+Pd
 o9P1IO1qIQamN3ETMiL8OT4McZICEXJLZ9vN1qvFqzQkBykWEfF54NhkmQ7z6YG7dkl8
 DCva/gdhIMorXA006tO3oRkY7wEaFy4unnT1XjlnbAWv3tc+ehBQSr3zKPJaIf2CJtE8
 H09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715512486; x=1716117286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybklGZsQ5B6bwbft1vxCvRI45enWgIukMcnmLJbokgY=;
 b=QU4khksc22NHa/wUz7Zlshb9Mvbqbssf8wY7hu9/SeIynIC48IUAMio4THxis13Gkb
 SNbBvzH29tuDFaglrrg1tvexY94lvfe1mqxi7/NkxoJ6H055J29JA5c3vVkNx3gMQPa8
 W0VdpayFQhgsn9X0aWzof0cEnG1DLoQs/IwALbKLJBqGatmccXSnXBi9vYwKmJlzr3RA
 iQaloivsjBeaukKoKLp3SnK5hFZTTdToaUIYr3/w9JieV2xScyUXhm/5M49geO1VicYZ
 RGMoOriNXG7zPj5tngvzKtxnucmAhtUvjwvl1Fqeah12/8dLJT7dfMKWvMlLlmMIucrP
 k+pA==
X-Gm-Message-State: AOJu0YzM39DFWI1ISwo+O6EoB1/JbcyoVdytAcm0rIJVy8BWD+OTbMPJ
 K9KHKY+mI2BBFVwOi4iUhRKVq0nEqIJDKn8e/FHbnfEIUTLCNoucw3/0hbv0rsFqjS0CwTDQkEw
 7jHc=
X-Google-Smtp-Source: AGHT+IHux31aL/ZAZycvpAmP5MGoZma9lT2/RpkMb7FMfbxsDfLkFs6DVIKeWKWxit+u9+XbexDqeQ==
X-Received: by 2002:a17:902:d2c9:b0:1e3:f4f1:a2c4 with SMTP id
 d9443c01a7336-1ef44050d4bmr95859245ad.64.1715512485694; 
 Sun, 12 May 2024 04:14:45 -0700 (PDT)
Received: from penguin.lxd (113x36x63x49.ap113.ftth.ucom.ne.jp. [113.36.63.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf30cbasm60399375ad.126.2024.05.12.04.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 04:14:45 -0700 (PDT)
From: hikalium <hikalium@hikalium.com>
To: qemu-devel@nongnu.org
Cc: hikalium <hikalium@hikalium.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 2/2] ui/gtk: Fix mouse/motion event scaling issue with GTK
 display backend
Date: Sun, 12 May 2024 20:14:35 +0900
Message-Id: <20240512111435.30121-3-hikalium@hikalium.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512111435.30121-1-hikalium@hikalium.com>
References: <20240512090429.29123-1-hikalium@hikalium.com>
 <20240512111435.30121-1-hikalium@hikalium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=hikalium@hikalium.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Remove gtk_widget_get_scale_factor() usage from the calculation of
the motion events in the GTK backend to make it work correctly on
environments that have `gtk_widget_get_scale_factor() != 1`.

This scale factor usage had been introduced in the commit f14aab420c and
at that time the window size was used for calculating the things and it
was working correctly. However, in the commit 2f31663ed4 the logic
switched to use the widget size instead of window size and because of
the change the usage of scale factor becomes invalid (since widgets use
`vc->gfx.scale_{x, y}` for scaling).

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


