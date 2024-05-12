Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F231C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 11:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s67AG-0008Ch-Dv; Sun, 12 May 2024 07:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s67AE-0008C0-Mx
 for qemu-devel@nongnu.org; Sun, 12 May 2024 07:14:46 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s67AD-0003jf-B6
 for qemu-devel@nongnu.org; Sun, 12 May 2024 07:14:46 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so2643951a12.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hikalium-com.20230601.gappssmtp.com; s=20230601; t=1715512484; x=1716117284;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3bZmJpvge7F0RjIF+WyHg4jjK08IiARCF7Cz5tQXBE=;
 b=MwOOvMX2RtAwwMl4TOHgD3DA/HLlzGID52OBJIkOC2OLTczEBUAkuVroLQ91wJFcMl
 8unznFaP8lgK7ZX+DDnpYjITmVadQvyIc6NNZtuX585qc/Sp+P8dgIwxf+fvBeopC6fD
 vEL4FMX4dIF98h/tmzxcVHo1hXV0rqZTX5IGCcSk9PpgvpXDVR8tCyFrBL9oCAqwpTyQ
 TtGlqSLa5PjABk3/Q+pRgqjbp6efUpNRQ1uAYztzpB3WH4sMYGZB6oIvE/YVWt8Qkmgx
 3liU7Z60dWBlIod0QzjTUxC5raYRImde7WL+enkNYQbEb7QAq34bdSupaPL5GIug2Uu/
 Bzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715512484; x=1716117284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3bZmJpvge7F0RjIF+WyHg4jjK08IiARCF7Cz5tQXBE=;
 b=rsZ0xG1Rpmscej0kjkZvqrogiz28h1nHXzv71f7S5YuctK+YP3qSnukr+ohxTM3FKj
 oA3DNis83NHWXbP3AX0jHilip5dsrpmxq/IqgvQhdQk4FblNO1Z0ey8AMrye25YaICnn
 KmGyCle/0KOmT5ZuZDnpCffv1OBUBfdZFcCTfLDo2y+M9PGBlgckh7vY6R+VFmCuHZ2X
 V2LkDn4Fh03t31XK5fhb+OdvJsL1tBrzCNR7kiL4DxwKZYgabGpNXHoA7nLVL/BhHcjD
 XDdsXfpf18mlRZ3gylInN08aTrATxSHm4CNsDigpKT0gCYL6tK9Iwpn/CXkD9zD/5wmd
 FWlQ==
X-Gm-Message-State: AOJu0Yx6a/jVNSt8ouTD/HvrS/RkenShZBJTvgF8N0DkpBcYOARsLioQ
 h0oRbcso+alHQ/DYvYtxbWx7AjyfcvAiuFxLmHQ63+yk3OK6Z9nSAEmPQ85OeaMrHnP0jGyd4RS
 MgP4=
X-Google-Smtp-Source: AGHT+IHIpo9aJ1zZZ5Q8Ml0/9aCNa+HK57lJr5lx1JwdWEB0n2i2ltXolPhCzIIK7E6VQ/CjGOeZEA==
X-Received: by 2002:a05:6a20:3c94:b0:1af:cd4a:1e0c with SMTP id
 adf61e73a8af0-1afde0a8d6amr7596315637.9.1715512483851; 
 Sun, 12 May 2024 04:14:43 -0700 (PDT)
Received: from penguin.lxd (113x36x63x49.ap113.ftth.ucom.ne.jp. [113.36.63.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf30cbasm60399375ad.126.2024.05.12.04.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 04:14:43 -0700 (PDT)
From: hikalium <hikalium@hikalium.com>
To: qemu-devel@nongnu.org
Cc: hikalium <hikalium@hikalium.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 1/2] ui/gtk: Add gd_motion_event trace event
Date: Sun, 12 May 2024 20:14:34 +0900
Message-Id: <20240512111435.30121-2-hikalium@hikalium.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512111435.30121-1-hikalium@hikalium.com>
References: <20240512090429.29123-1-hikalium@hikalium.com>
 <20240512111435.30121-1-hikalium@hikalium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=hikalium@hikalium.com; helo=mail-pg1-x534.google.com
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


