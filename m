Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D03EF900B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR3-0003t2-EV; Wed, 04 Mar 2026 11:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR0-0003qu-P5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:54 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQz-0002QX-8k
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:54 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-660ea6ceb5aso1280551a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643051; x=1773247851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhaySwZ2sfnt3X/6sKY9hea4XoP3N+AuPAHONsS0p10=;
 b=El6jTeRtuI/CLNfSwCDZV2XkNk9Sy82plR842jZa99GSrp6S90jKwj+8HA+lBfU+H6
 GciO15vWzyvCePRGK/2I2E/KEbip26jODnE9uy7zLfDxfLTC1ikaCvBoX9BtmLxcqA6p
 oPb8mGULho7XVlwu2Mq4EvRg9TY1dtD+wIzvR5tD9idWL404yFRCIMeXmECBu5gPnr7w
 VQIyuFqfD+O4vmoLW6eml7PuCgx+J3kk0f7Fj8J9CzqqZ4ufzhSWh+K8oTpjKFFqd++k
 xoHuvux9dyPqPegqfTnwvOref7ygAPsUzxxr+P/KwNyICaSyJl0rsjPzdhVPUuErQggD
 2Kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643051; x=1773247851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yhaySwZ2sfnt3X/6sKY9hea4XoP3N+AuPAHONsS0p10=;
 b=YLQIJHIWleNA69GL5YjBA/sIbpgq+kS/JbRkz/SKydYmKIyulqV7nVYpKiU/piPeL7
 BcYVERX87AJ4OTbm0n2CbsoTK7YUs/wepscoNlWMVnGHjcKjSd4QvMgTth8GE0IQaK7r
 pOCBLbnGlOYzPhMGC2glSutXqBXxF6gbf++hUhSLDRMXNZsE3orNZxO3/rTSl3BGCF51
 lwzMr4qVp/TNxTG8sNSWpb96OOkpUGlcIyU8QSdQyifGCoPXsxelQWjYbBNB36DzysFz
 48xIADZSvlTadx591XIs4b4lkTipLSrssYIcrPD1Ry/nHwpBy7qeonbLmMJNeu/tRWf8
 BhaQ==
X-Gm-Message-State: AOJu0YzXcPGb/fPBpephAxVoIyxFsAGs6wxNqPcV2MB7l2jLhvjHTo5n
 9Gv4PFScKuVhaQj3iCalMEs+9SmgCN2t0FI96bOMZIp9ZTDfVvALkVlcgblaxUatQFM=
X-Gm-Gg: ATEYQzyz8rq6cpefkQv1glbcLCAPtWvfs/jywR/HDrFeogwZ28KeTVMsdghcvXE8hJl
 Zvmiqlwx0hCXG3HlmQ4xritwJ7N6x8GKIIEX0KlupsrBwo38nm7EhOwGsoVF6/aEmBvZ8lJtu9q
 jn7A4m6GsJ8Rr8pYsL3SPAoKqQsCNkOK19DQRCRaeaTNjO6QLpZIAiwnq08KZ3Lri792UF1lcWz
 BCvumsfZr+zeKLINIDFmXGINkHQzFZUIj2KKRclVEDPIMthoKTwOeP+q3WNhduGAeAHBFWBBl0Z
 j/w//8JvZcAaYtzbRbDoFvQTyED7M3I36iEHJZGD6DAxoJ8XbJZZkhfYYscLaFFUeIbDAgdCnSq
 vfH7K1H8QliuQarO2yBtG+0G31c3Aljo3/XfBJhAZdlpNUEWbmfSbuq3ZxEOk3RDq4L9gz00gMh
 3firslJLxTuyaEng+yv5UwoFE=
X-Received: by 2002:a17:906:c151:b0:b90:b959:4c72 with SMTP id
 a640c23a62f3a-b93ef735016mr183997766b.6.1772643051542; 
 Wed, 04 Mar 2026 08:50:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ac51431sm767064366b.17.2026.03.04.08.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CF6662D69;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH 10/20] virtio-gpu: Handle virgl fence creation errors
Date: Wed,  4 Mar 2026 16:50:32 +0000
Message-ID: <20260304165043.1437519-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Print out error messages when virgl fence creation fails to aid debugging
of the fence-related bugs.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-9-dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 10c4b5160f4..f00c666f61f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -900,6 +900,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
     bool cmd_suspended = false;
+    int ret;
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
@@ -1000,14 +1001,30 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
 #if VIRGL_VERSION_MAJOR >= 1
     if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
-        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
-                                            VIRGL_RENDERER_FENCE_FLAG_MERGEABLE,
-                                            cmd->cmd_hdr.ring_idx,
-                                            cmd->cmd_hdr.fence_id);
+        const uint32_t flags = VIRGL_RENDERER_FENCE_FLAG_MERGEABLE;
+
+        ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
+                                                  cmd->cmd_hdr.ring_idx,
+                                                  cmd->cmd_hdr.fence_id);
+        if (ret) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: virgl_renderer_context_create_fence error: %s",
+                          __func__, strerror(-ret));
+        }
         return;
     }
 #endif
-    virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
+
+    /*
+     * Unlike other virglrenderer functions, this one returns a positive
+     * error code.
+     */
+    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: virgl_renderer_create_fence error: %s",
+                      __func__, strerror(ret));
+    }
 }
 
 static void virgl_write_fence(void *opaque, uint32_t fence)
-- 
2.47.3


