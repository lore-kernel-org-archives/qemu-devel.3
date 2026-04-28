Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAA6FF886C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdZV-0005ux-E9; Tue, 28 Apr 2026 04:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdZT-0005ub-VT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdZS-0005op-Fr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcHo94HuD0MwG1Lrycu+X8H89uP+8uG3alrwsl0qpx8=;
 b=UAdXOi0bPq7MGq71bFykMQExjjD6IN+q+A9OEMamC20YKene3e9AHBSRa8+YGcmqytk8pt
 Cpn2MgUYNO6aI9+/1i0FhFR1GsrbvAplxIzbGLDmb2tp1k/L/TCrFxMoqKLLVrG8qYv9io
 uiix3GeLc9qFkVLpFJMFw0xzVwgFtoc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-7NBnKe7uOn6hTuzQb1DDfg-1; Tue,
 28 Apr 2026 04:13:28 -0400
X-MC-Unique: 7NBnKe7uOn6hTuzQb1DDfg-1
X-Mimecast-MFC-AGG-ID: 7NBnKe7uOn6hTuzQb1DDfg_1777364007
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 307B919560B7; Tue, 28 Apr 2026 08:13:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D08BA1800352; Tue, 28 Apr 2026 08:13:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 03/15] ui: make qemu_default_pixelformat() static inline
Date: Tue, 28 Apr 2026 12:12:50 +0400
Message-ID: <20260428081303.990973-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The function is a trivial wrapper around qemu_default_pixman_format()
and qemu_pixelformat_from_pixman(), so make it static inline in
qemu-pixman.h instead of a standalone function in console.c, allowing to
be easily reused.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/qemu-pixman.h | 8 ++++++++
 include/ui/surface.h     | 2 --
 ui/console.c             | 7 -------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 2ca0ed7029c..4bc7a59698e 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -73,6 +73,14 @@ typedef struct PixelFormat {
 
 PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format);
 pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian);
+
+static inline PixelFormat qemu_default_pixelformat(int bpp)
+{
+    pixman_format_code_t fmt = qemu_default_pixman_format(bpp, true);
+    PixelFormat pf = qemu_pixelformat_from_pixman(fmt);
+    return pf;
+}
+
 pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format);
 uint32_t qemu_pixman_to_drm_format(pixman_format_code_t pixman);
 int qemu_pixman_get_type(int rshift, int gshift, int bshift, int endian);
diff --git a/include/ui/surface.h b/include/ui/surface.h
index d2542d3ace5..8e5f3e35e8c 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -24,8 +24,6 @@ typedef struct DisplaySurface {
     uint32_t share_handle_offset;
 } DisplaySurface;
 
-PixelFormat qemu_default_pixelformat(int bpp);
-
 DisplaySurface *qemu_create_displaysurface_from(int width, int height,
                                                 pixman_format_code_t format,
                                                 int linesize, uint8_t *data);
diff --git a/ui/console.c b/ui/console.c
index 475a72aa08f..ff561617657 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1390,13 +1390,6 @@ DisplaySurface *qemu_console_surface(QemuConsole *console)
     }
 }
 
-PixelFormat qemu_default_pixelformat(int bpp)
-{
-    pixman_format_code_t fmt = qemu_default_pixman_format(bpp, true);
-    PixelFormat pf = qemu_pixelformat_from_pixman(fmt);
-    return pf;
-}
-
 static QemuDisplay *dpys[DISPLAY_TYPE__MAX];
 
 void qemu_display_register(QemuDisplay *ui)
-- 
2.53.0


