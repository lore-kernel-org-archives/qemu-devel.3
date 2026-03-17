Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D056AF3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QCw-0003RY-Bi; Tue, 17 Mar 2026 04:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QC6-0001SA-Vf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QC1-0006S0-7j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOx64XRhujGSH8IrhEedHMjtXZ46UUG6Jko0MMU5Z3M=;
 b=REEwu8V5diodb2+zsmRYD9Ho8R+NBx21YbW3wwTriG3cxNvnsmKO9h7ib4vx8wbzbRnUPe
 7ISQcKUtYE/5OIYa20ya3sHcdblKCXs63DhdlMMgak1eXbFsN2BXAFGZs9cTHIMe2cWDTU
 thcRW3Aa3qET/8p90O2joDE/4s2dVHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-UOKP6dDSNxufmyMceYY8JQ-1; Tue,
 17 Mar 2026 04:54:22 -0400
X-MC-Unique: UOKP6dDSNxufmyMceYY8JQ-1
X-Mimecast-MFC-AGG-ID: UOKP6dDSNxufmyMceYY8JQ_1773737661
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4A53195604F
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEB01180075C
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:52 +0400
Subject: [PATCH 38/60] ui: make qemu_default_pixelformat() static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-38-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2361;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4KE36+894DGb/k8lJOSMKo0Z5AGMIZ1lzcBmMhSASHI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbhjX+MYhBQW51gunIJxZzc8TQvzIHk7+zT
 eJbyfvlIPeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5ZDED/9P4JUm6mjo5oJ32Y2j3aBuYEV/LmCPyXzzq/ImzlG5O/dTQJz5hy3sugs4LY33suaNfVY
 MIFq35p376MTocDI4A5P6uFtZ5A3SxToU5sioY1cGBrSOZn70bQVAEp2S0wR0gPt+gGxFXzfqS4
 oak9mrIZDPrOh+FWUtkoluey1TnRIyvhiH1oXrE7o2s6E1jRxbFB90L4otO51mkn20UV6QsZKUV
 ytVETNsbkdzajSBPFS95McwywkLr3hhVvjdCMc3YiphR+TTOOiQiiSJicNBv+m8Z3cBeehv+moX
 yavntt8BYl3yEEnD0irsFT798c7H2RnuigdHuCWMhsCsPWrCC6FWo2Vq8Gcj37jm5nGaRao/FIY
 UqI5GJMhXD3EGTTnQaFdZF579YatNWBA/cX34n0b16VbyTUAN6KzhRuJxNdqdTEksxLefAWddgG
 ER+nPQH/1v1VWiyfypg83dzF8WbxDMqLMmryiBmYfWTTdn2hGNl5YDR4tmFrxVzAx3nmM/Q2rPi
 sfD/2+nlXoeWfo4zRikhxmApakzbM9EXfxcxVP/D+g2jAaUpGWDk2/cYW5UYZHfIQomJXZRIE8v
 2GSkyJY40c1Rudn2rFbAMN23nQErXVdsHEze8Up9Fh7hG5E1fcz1bKvuuuy4SQJxzeosX6vWeoy
 XIEb23LY6lGGMog==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
index 006b1986bb9..3d71010c758 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -28,8 +28,6 @@ typedef struct DisplaySurface {
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


