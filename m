Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE897D1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 04:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQeAK-0002Gk-7m; Tue, 02 Dec 2025 23:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.35jm618ccjcdvl1=wd6m3wilz0s8=b87kiyyvfflxev@em483429.getutm.app>)
 id 1vQeAH-0002FI-K3
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:30 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.35jm618ccjcdvl1=wd6m3wilz0s8=b87kiyyvfflxev@em483429.getutm.app>)
 id 1vQeAG-0000Wc-6s
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764734895; h=from : subject :
 to : message-id : date;
 bh=RKFSYaD5mWEuabGiWe4mUZY3p0G6tvHa9VipptsJ6dE=;
 b=WznVN0YgBBfFHLUwPEP+LR6xu5u8qSkRHr82ogai3VbzcOyjTbO4kpph2OSnRit+LJsOI
 O4SZaeiPz1qwdf89qsKhEtuHuDzoCAeqZbJPgYh+En14/zqlSS1cyS0Iqv/RzPR7EZ0Iy3c
 4pCPXQLIG43U1fPufXtN2o/z6WQHBhDTCiAaAdh60Mi0Gp4iNqyvPUhNeUu3UaTCrDf29d5
 1UlZj4wwwltFuWLqTvfyuRRY2q5XOuqlndO3L20RSbrN5mdRwGW6eaUv2O+xWYOhAHDXGhi
 6p5+vfTJGkr9fsRLy7n6M/40syjhS0zLTq7iL/Va+FZ/X5W6wBBNSQpiNpNA==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vQe9y-FnQW0hPv7oK-Wgtd; Wed, 03 Dec 2025 04:08:11 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH RFC 4/7] virtio-gpu-virgl: update virglrenderer defines
Date: Tue,  2 Dec 2025 20:07:51 -0800
Message-ID: <20251203040754.94487-5-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20251203040754.94487-1-j@getutm.app>
References: <20251203040754.94487-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sXHaL01GIg
X-smtpcorp-track: BB1kipmajpGZ.yIYh3lvklgbJ.4yKDEQpS5l-
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.35jm618ccjcdvl1=wd6m3wilz0s8=b87kiyyvfflxev@em483429.getutm.app;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In order to support additional native texture types, we need to update the
defines in virglrenderer. The changes are backwards compatible and so
builds should work with either the new version or the old version.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index d0e6ad4b17..36c670f988 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -24,6 +24,8 @@
 
 #include <virglrenderer.h>
 
+#define SUPPORTED_VIRGL_INFO_EXT_VERSION (1)
+
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
     MemoryRegion *mr;
@@ -441,12 +443,30 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
         memset(&ext, 0, sizeof(ext));
         ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
         info = ext.base;
+        /* fallback to older version */
         native = (ScanoutTextureNative){
             .type = ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D :
                                     SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
             .u.d3d_tex2d = ext.d3d_tex2d,
         };
-#else
+#if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >= SUPPORTED_VIRGL_INFO_EXT_VERSION
+        if (ext.version >= VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION) {
+            switch (ext.native_type) {
+            case VIRGL_NATIVE_HANDLE_NONE:
+            case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
+                /* already handled above */
+                break;
+            }
+            default: {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                            "%s: unsupported native texture type %d\n",
+                            __func__, ext.native_type);
+                break;
+            }
+            }
+        }
+#endif
+#else /* VIRGL_VERSION_MAJOR < 1 */
         memset(&info, 0, sizeof(info));
         ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
 #endif
@@ -1169,11 +1189,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
     }
 #endif
-#ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
     if (qemu_egl_angle_native_device) {
+#if defined(VIRGL_RENDERER_NATIVE_SHARE_TEXTURE)
+        flags |= VIRGL_RENDERER_NATIVE_SHARE_TEXTURE;
+#elif defined(VIRGL_RENDERER_D3D11_SHARE_TEXTURE) && defined(WIN32)
         flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
-    }
 #endif
+    }
 #if VIRGL_VERSION_MAJOR >= 1
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
-- 
2.41.0


