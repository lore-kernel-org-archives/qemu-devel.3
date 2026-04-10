Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E99F45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHR9-0004tk-Bm; Fri, 10 Apr 2026 15:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHR7-0004rK-MK
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHR6-0001xT-92
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jg06xNsDHiAjS1cpxEPhGzH0lDWKplTKePp+SKWf2pw=;
 b=L3gIto1y+V+6zxX6WVpIMDWUr7VjeGSENIOWErgUzfNG+M4EUq9qNHXT7zuWJVBVdcjRzH
 V14Q0n0igULqHmDuFmIeSwG/qy5v+RVyU54PvbOp9LxEwtudpy+VoQptLm8V0uYFhDMfll
 dL/1ZaMKP5OGS06Bxv9woquYWJy02q4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-Qtbiv3tpN82m0euDqHH_Pg-1; Fri,
 10 Apr 2026 15:22:34 -0400
X-MC-Unique: Qtbiv3tpN82m0euDqHH_Pg-1
X-Mimecast-MFC-AGG-ID: Qtbiv3tpN82m0euDqHH_Pg_1775848953
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F3831955DAE
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:22:33 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CA2F1955E84; Fri, 10 Apr 2026 19:22:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:58 +0400
Subject: [PATCH v2 36/67] ui: make qemu_default_pixelformat() static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-36-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=J76FKl9tH/d0oVk3sn0TrxBVo9ODvG49qjWGz2g7+78=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VfTC5N7taSyNlI89/Sk+QwR7eAG/Tf1qkA
 vIYYWiWUTWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5cjBD/wMYMeeHtOhi3CyRSANX9bi8iS8ZvSuUWK/eCHsIzud3RMzfJDaJUwF/5EnqvMFgs358pS
 MDJGSok9bpi53p2/ePptl0qUGzdFDLRe2ygEp+5rBjmA2XJSpOn5AWa683DF9qvSIo4x7FJaJvf
 74qM955QfPHQdTzQPqGz2J3H3VZiCZkoBTCZFnGLSIcMQZVD+eC71SSYG6aMwFaOIo6LX/LLjHv
 OdO/MZAi1nZrz0xDc3faSpwlukeeoPHzm9V526SkOvkKxWnJFrERRsMGkliKwfOJYkFhVBEf+Jf
 eAh+mLqnktkb/cQr3IL6oeCL7PSjOd7Q8MB2Vz/0oa2oiE8Mxc2zCBK0SNpm6qFf82JYhspG7w7
 Ybdeio8k5/uylVKyKrUyy/zREmG4CjuoCK37HH4NR7x0Gomy+zicRYze9h9TRYRkl9Iw30ts+nC
 tBqJx3+TqiaLHgPJmQA3QiagTe8LqCfozzmST0R0UwkGgK/m0vp5veSLRIqhbFxg5I0K0LTKFbb
 r6vqz0BzNrIBvSXouD8n/ogx7Qt60IvKAipaXfnXVyXO0Hdf7WGtpXnnApOCYuYe1AWiuAzRACQ
 NryS5xNThCuNtaRLuW2N1Qw3fYx8sKl+4PKkzPX0BVrP4r8Z9PW/e1qeBCROu1BDnwff9Aas/63
 eDZmKIMRS/Ohaxw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 24794e5a9dc..78b0ac27827 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1392,13 +1392,6 @@ DisplaySurface *qemu_console_surface(QemuConsole *console)
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


