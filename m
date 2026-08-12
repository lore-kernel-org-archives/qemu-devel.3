Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C73C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8ea-0000Uh-6I; Wed, 12 Aug 2026 09:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dk-0007kD-FL; Wed, 12 Aug 2026 09:05:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8di-0004dc-Fi; Wed, 12 Aug 2026 09:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=k+ptSRqfUPGV3dZbGp7xKQS9GrD6FhHhaPcfBlgw5Z4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lzhDhVHLndptapw86qvOChaQeXeNv1AQOaeYAtwMovY2NxzV/n6uwkq3BAAxDBqMA
 Ocd70NHDZhrIqqOsKi7f9vTMwe0rOw+5i4TIHBplne8kTQZXEngLqTwJHpHfsSDVj5
 It3YSdnEMRJAZsW3zdHuLjplCm3RLh2zVwf70GjmppqPBaGfVHufJb68jeJfR9Yaqi
 N52vEacszxNXxR7dXeNZSH4KATwjtnUHxDQAk2k1+Eb4EagnLe2SS9bz1YeaUjCPro
 0iUmlDMutv7AJLJAJthW7RR4qit40su0WspFbAVp1uuYJ52AfpICEjf3wsIfIJKBOA
 8sd6pMSR35uGQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8132A1CA498;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6197409B7B;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0D7EA2F8C6; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 025/102] hw/display/virtio-gpu: Remove the bytes_pp
 field
Date: Wed, 12 Aug 2026 16:01:00 +0300
Message-ID: <20260812130233.621965-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

virtio_gpu_do_set_scanout() validates the stride field of struct
virtio_gpu_framebuffer against the bytes_pp field, but bytes_pp in the
migration stream may be inconsistent with the format field, which
pixman_image_create_bits() uses when it accesses the framebuffer.
That validation is therefore incomplete.

To avoid the trouble of synchronizing the two fields, remove bytes_pp,
and always derive its value from format. Removing bytes_pp is safe
because no released version of QEMU uses its migrated value.

Fixes: 7b5574225429 ("hw/display: check frame buffer can hold blob")
Cc: qemu-stable@nongnu.org
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
[ Marc-André - fix rebase conflict ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit 76dcc0832c5caac25ac887f235b547ed947b5734)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 071abab24ff..67ccc81e50c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -613,6 +613,11 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
     scanout->fb = *fb;
 }
 
+static uint32_t virtio_gpu_format_bytes_pp(pixman_format_code_t format)
+{
+    return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
+}
+
 static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
                                       uint32_t scanout_id,
                                       struct virtio_gpu_framebuffer *fb,
@@ -621,6 +626,7 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
                                       uint32_t *error)
 {
     struct virtio_gpu_scanout *scanout;
+    uint32_t bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
     uint8_t *data;
 
     scanout = &g->parent_obj.scanout[scanout_id];
@@ -642,10 +648,10 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         return false;
     }
 
-    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
+    if (fb->stride < (uint64_t)fb->width * bytes_pp) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: stride %u too small for width %u at %u bpp\n",
-                      __func__, fb->stride, fb->width, fb->bytes_pp);
+                      __func__, fb->stride, fb->width, bytes_pp);
         *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return false;
     }
@@ -716,6 +722,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_framebuffer fb = { 0 };
     struct virtio_gpu_set_scanout ss;
+    uint32_t bytes_pp;
 
     VIRTIO_GPU_FILL_CMD(ss);
     virtio_gpu_bswap_32(&ss, sizeof(ss));
@@ -741,11 +748,11 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     }
 
     fb.format = pixman_image_get_format(res->image);
-    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
+    bytes_pp = virtio_gpu_format_bytes_pp(fb.format);
     fb.width  = pixman_image_get_width(res->image);
     fb.height = pixman_image_get_height(res->image);
     fb.stride = pixman_image_get_stride(res->image);
-    fb.offset = ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
+    fb.offset = ss.r.x * bytes_pp + ss.r.y * fb.stride;
 
     virtio_gpu_do_set_scanout(g, ss.scanout_id,
                               &fb, res, &ss.r, &cmd->error);
@@ -756,6 +763,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    uint64_t blob_size)
 {
     uint64_t fbend;
+    uint32_t bytes_pp;
 
     fb->format = virtio_gpu_get_pixman_format(ss->format);
     if (!fb->format) {
@@ -765,15 +773,15 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
-    fb->bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb->format), 8);
+    bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
     fb->width = ss->width;
     fb->height = ss->height;
     fb->stride = ss->strides[0];
 
-    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
+    if (fb->stride < (uint64_t)fb->width * bytes_pp) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: stride %u too small for width %u at %u bpp\n",
-                      __func__, fb->stride, fb->width, fb->bytes_pp);
+                      __func__, fb->stride, fb->width, bytes_pp);
         return false;
     }
 
@@ -784,7 +792,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
-    fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
+    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;
     fbend += (uint64_t) fb->stride * ss->r.height;
@@ -1234,8 +1242,7 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
         VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,
                             scanout_vmstate_after_v2),
-        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,
-                            scanout_vmstate_after_v2),
+        VMSTATE_UNUSED_TEST(scanout_vmstate_after_v2, 4),
         VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,
                             scanout_vmstate_after_v2),
         VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 156c7457e17..9ee0737d9df 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -65,7 +65,6 @@ struct virtio_gpu_simple_resource {
 
 struct virtio_gpu_framebuffer {
     pixman_format_code_t format;
-    uint32_t bytes_pp;
     uint32_t width, height;
     uint32_t stride;
     uint32_t offset;
-- 
2.47.3


