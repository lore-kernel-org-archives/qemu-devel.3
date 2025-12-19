Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51B2D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfOD-00037w-O9; Fri, 19 Dec 2025 13:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.7y973yjxt9vaj54=ojo2vl5wbcu2=mt6ctf7hbuk69a@em483429.getutm.app>)
 id 1vWfOC-00037L-4i
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:44 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.7y973yjxt9vaj54=ojo2vl5wbcu2=mt6ctf7hbuk69a@em483429.getutm.app>)
 id 1vWfOA-0007uj-2V
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766170468; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=Exyga1XH2pziYXA4g4safN4qhvFjcBWV8WaUqK8gP+E=; b=nookgJPqM4oYUEC513A4vcAz8R
 askyZEWv0eliUKd66g3tGiqZYUzRW0xAkUQt2o5gJAD87R7DB6L+LvKdVXYvoPwlJR4DZpwfv2JrZ
 /UPX1VpYPRwz56gJaFXvnQlddEMaRKUAPTzwhoH60FZOhxEoqOnVwsdti+XATfW8cXtRIgy1Iffvf
 +2SMV2kLLcG3d5gTYTqjELIOMYzslrxWGu5wEtAjsMaTnTDuOFDUhVb7Gr7ndze9gf1yLbH8eJGOm
 JlMainwOkQsamKxjzrguvSGUqg4FRJFPo2FJSoYY9P4wcw6PliM5jEsCeMW6dna7orcMyH0/fC7jd
 Brvr8oTA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766169568; h=from : subject :
 to : message-id : date;
 bh=Exyga1XH2pziYXA4g4safN4qhvFjcBWV8WaUqK8gP+E=;
 b=ihhHcGpowKBVPKR3yaVAb4fL5hFIbu61GrkkejYA+LRKDo/fMQFz8ANhq2KFJknqMalTv
 82WxOA7OXmyFivQJC5QeXvNzhPTUKVkQj96NmRdtUw8nJpX0QC6W/1wsT5ZVFwYHN0RxEK7
 FQA8Tc0QQ2+AAktzzJR2qCJTDg2sMpaWIHOGIe30EQZlZ49pnMp1F0Tq7sf7sdpBoq4Hndf
 GFOlqEI4HosTtxQQmtS8zq2USpgliRa6JCCOfqTx7tIWC0qzAg5jW8wbqdcTDUVNfSJRvDC
 1q6XgifJNr8J/6rC9POtslObpwY54ncjOkzhUqTZLIDGQwk5CynKV4I4AgyQ==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNv-pH9Rbw-4v; Fri, 19 Dec 2025 18:39:27 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNt-AIkwcC8uKAK-G71O; Fri, 19 Dec 2025 18:39:26 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH RFC v2 3/6] virtio-gpu-virgl: update virglrenderer defines
Date: Fri, 19 Dec 2025 10:38:49 -0800
Message-ID: <20251219183853.4426-4-j@getutm.app>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251219183853.4426-1-j@getutm.app>
References: <20251219183853.4426-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: StbVbhJRfkbc.0BxjxMCfATCV.mMuJ4ABXwjJ
Feedback-ID: 483429m:483429abrvJvs:483429sB2ewKjTKe
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.7y973yjxt9vaj54=ojo2vl5wbcu2=mt6ctf7hbuk69a@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

In order to support additional native texture types, we need to update the
defines in virglrenderer. The changes are backwards compatible and so
builds should work with either the new version or the old version.

https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1583

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f24437163fb..9fcc01b6f46 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -24,6 +24,8 @@
 
 #include <virglrenderer.h>
 
+#define NATIVE_HANDLE_SUPPORT_VERSION (1)
+
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
     MemoryRegion *mr;
@@ -427,12 +429,30 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
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
+#if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >= NATIVE_HANDLE_SUPPORT_VERSION
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
@@ -1155,11 +1175,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
2.50.1 (Apple Git-155)


