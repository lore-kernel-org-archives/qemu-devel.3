Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79FEC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 13:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s699i-0005aI-Fp; Sun, 12 May 2024 09:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s659n-00061i-T4
 for qemu-devel@nongnu.org; Sun, 12 May 2024 05:06:11 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s659k-00027D-Mh
 for qemu-devel@nongnu.org; Sun, 12 May 2024 05:06:11 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b27e8ad4b6so1441312eaf.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hikalium-com.20230601.gappssmtp.com; s=20230601; t=1715504765; x=1716109565;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j3bZmJpvge7F0RjIF+WyHg4jjK08IiARCF7Cz5tQXBE=;
 b=RNfOQe1A8XEiCHT73rsopBmzEx5m+1ElsTISwLyH0Nk8vjpb/1DjqIyGDdZhUua9VN
 McB/hNdKJlFp6ejrwGHCHZSWWpE4h1o+yVggnsF63ywIzm+QgAVOtBvpMW3eMIIZMPsh
 n+4knzY7wlL7O+Tc2Kk0kLQ4fqTBvNL2g7JDbL3OlFK9T1j0K3E8+TP3cwkcLJd1NISF
 7UVLAtUyUJ2CweLp1k4ozelrvDM/TsFP9xLIsBgkAR3c0oDG4si0ktvKqXXumby1UUpB
 uDs//asqeflWTsadVfeRxFajmxbYXPN0CqkQH1RK8EYnnNo6Ipak6O0lmSfgD/TWGSk/
 OIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715504765; x=1716109565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3bZmJpvge7F0RjIF+WyHg4jjK08IiARCF7Cz5tQXBE=;
 b=SKtYDe/pk5twgREUDQeQzs0cNzHeZuTLs99JfRKk2Lf93RUaDbBCi7Rrz01sI2E1at
 FIrCVpNalEuZsIMIGQbXMC5bJb4cD2l+dNUErXNNtjsjdT4J75yK73+bUIKlGuMUFBzD
 PohTzlsYKbXIjA1AmK/B5MaIxsnueTkjRv3FInk8CVb6EqUIJW0Heu0JoZe06Hxu0E7+
 s8iWLdbRls1YnvCWwngK1KRWwNlkDwg2u6pP/jTgjjRRPuGQGXtGseFGiEWw0gm6h78y
 6GCpC0QOLmCV4QojKBzHTsyCi93W9ObpIFlkLy1FjvXIu47Y5aDw6FW7SOidPLdi/F/f
 wTQQ==
X-Gm-Message-State: AOJu0Yx2LKL0IG/Fe1zVpNbme+tEZqNx6+dt/W5YWgbodD52zMMyk3Ey
 o9x63nubtbpv5bb02jow3uZaFbsyKaf/soM0if+YBGrwKwdJKRoRceDZm5rpy50KBSH1xrnlLGo
 XTvM=
X-Google-Smtp-Source: AGHT+IErm3ONbsEgq3G9OJrYr9VkxApN/7R2s+F1L6lesl1SjhXJf38BToauKzqSLwO0Z8kyHmmXbg==
X-Received: by 2002:a05:6870:7a10:b0:23d:4123:606e with SMTP id
 586e51a60fabf-24172a70aa1mr8352527fac.20.1715504764861; 
 Sun, 12 May 2024 02:06:04 -0700 (PDT)
Received: from penguin.lxd (113x36x63x49.ap113.ftth.ucom.ne.jp. [113.36.63.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ade232sm5466466b3a.104.2024.05.12.02.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 02:06:04 -0700 (PDT)
From: hikalium <hikalium@hikalium.com>
To: qemu-devel@nongnu.org
Cc: hikalium <hikalium@hikalium.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/2] Add gd_motion_event trace event
Date: Sun, 12 May 2024 18:04:28 +0900
Message-Id: <20240512090429.29123-1-hikalium@hikalium.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=hikalium@hikalium.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 12 May 2024 09:22:19 -0400
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

Add gd_motion_event trace event for making it easy to debug
gd_motion_event related issues.

Signed-off-by: hikalium <hikalium@hikalium.com>
---
 ui/gtk.c        | 2 ++
 ui/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..ebae888d4f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -911,6 +911,8 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
     x = (motion->x - mx) / vc->gfx.scale_x * ws;
     y = (motion->y - my) / vc->gfx.scale_y * ws;
 
+    trace_gd_motion_event(ww, wh, gtk_widget_get_scale_factor(widget), x, y);
+
     if (qemu_input_is_absolute(vc->gfx.dcl.con)) {
         if (x < 0 || y < 0 ||
             x >= surface_width(vc->gfx.ds) ||
diff --git a/ui/trace-events b/ui/trace-events
index e6a2894303..69ff22955d 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -28,6 +28,7 @@ gd_ungrab(const char *tab, const char *device) "tab=%s, dev=%s"
 gd_keymap_windowing(const char *name) "backend=%s"
 gd_gl_area_create_context(void *ctx, int major, int minor) "ctx=%p, major=%d, minor=%d"
 gd_gl_area_destroy_context(void *ctx, void *current_ctx) "ctx=%p, current_ctx=%p"
+gd_motion_event(int ww, int wh, int ws, int x, int y) "ww=%d, wh=%d, ws=%d, x=%d, y=%d"
 
 # vnc-auth-sasl.c
 # vnc-auth-vencrypt.c
-- 
2.39.2


