Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F913C48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTqI-0000P5-Tj; Mon, 29 Jan 2024 10:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUTqH-0000Oe-6l
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:46:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUTqF-0005Fj-Ge
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:46:36 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40ef3f351d2so7373495e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706543193; x=1707147993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNVaeUpKkteNL3rGYKpxiJd02hUkBiHBGooaL89rDcI=;
 b=VVsUlifc3DhYZQj0u5zKX9hikD3kMVA82DdELQYVZtmIRMMC3+vcUuVnipxZ7B+G5n
 8xSTivNF4HEn242Egy+AzO65d/fry1xj0bdKYaNRvckOxBM/Tdpk11smlYh76JUNRjvD
 OsRk4hg8ARzkK/t4BDGMaGQeavXqd7v6W2GL7TWWczuEdLL+4vOJjHPVIq1P1wXdk8F0
 yFcuSoAN6Q/qPlTl+Q+sOg07zZbwx97/3rAbMT2zTB+u+sLG5WN+KuoOmu1OCZULgCbW
 Ovqo6oNUjEfC0YeHRs2xlt+BSQNYRrWd9n1DdUrdPHCxZvHZ+g6mHK8j77rdqxgcLKOn
 fx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706543193; x=1707147993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNVaeUpKkteNL3rGYKpxiJd02hUkBiHBGooaL89rDcI=;
 b=u1rNUVeZPTw09cOcPx5IbT8hxKQyqfW62D+RVF8ZcRSBMXSxBwHENtsWOXU/F16Wo8
 TlmhA4qcyQrtRlBXIFvvuonLAndyX/XXsTryIYS9f5ZUxxV6SHK5RZlzjdgO+IsubEz0
 FCzjxhAT4a99pSTOKZ4vN1hKObvDvuaGn4LF9K18zIeaJgYy2n2/xJydqP/UYs5XlKSj
 StChxh/RxR/TIcAk1xhKzdp+Q301BhW+h6AOIdmcClusz96XUg5RraxKQk+Yesl6aefq
 WfJe/0+7fnRavX+v1whqM+Jk0UwLY2cAi+iCpt3XiE+x8nl3BKBK4XcreOK7OpMNBppL
 Y74w==
X-Gm-Message-State: AOJu0YzXOc5y4I6WMdY9J1YhTNpR6kCEQKlwyzXFbpjluFheXWn8FlyL
 YV2PUjslbg4939bPSkRguKGugQvTSFFuSwD/cfoqXF2TSsdCzxY4VhxsDCk/6NUxKHlwAvQWywX
 4W9Y=
X-Google-Smtp-Source: AGHT+IFA3b71JMcdaOcgc9COsG1PPXZGyeRNYW91RHTbUBk9D10soDBAbTCirplbbzwQF5SeTo/LKg==
X-Received: by 2002:adf:fc84:0:b0:337:d84c:1d6 with SMTP id
 g4-20020adffc84000000b00337d84c01d6mr5262303wrr.18.1706543193612; 
 Mon, 29 Jan 2024 07:46:33 -0800 (PST)
Received: from localhost.localdomain (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600016cf00b0033aedfc5581sm2852608wrf.32.2024.01.29.07.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 07:46:33 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH v2 3/3] virtio-gpu-rutabaga.c: override resource_destroy method
Date: Mon, 29 Jan 2024 17:45:25 +0200
Message-Id: <926db899bebc1f9ca575bfd29d140f7658050a82.1706542958.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When the Rutabaga GPU device frees resources, it calls
rutabaga_resource_unref for that resource_id. However, when the generic
VirtIOGPU functions destroys resources, it only removes the
virtio_gpu_simple_resource from the device's VirtIOGPU->reslist list.
The rutabaga resource associated with that resource_id is then leaked.

This commit overrides the resource_destroy class method introduced in
the previous commit to fix this.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu-rutabaga.c | 51 ++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 9e67f9bd51..6ac0776005 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -148,14 +148,42 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
 }
 
 static void
+virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
+                                   struct virtio_gpu_simple_resource *res,
+                                   Error **errp)
+{
+    int32_t result;
+    const char *strerror = NULL;
+    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
+
+    result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
+    if (result) {
+        error_setg(errp, "%s: rutabaga_resource_unref returned %"PRIi32
+                   " for resource_id = %"PRIu32, __func__, result,
+                   res->resource_id);
+        strerror = strerrorname_np((int)result);
+        if (strerror != NULL) {
+            error_append_hint(errp, "%s: %s\n",
+                              strerror, strerrordesc_np((int)result) ? : "");
+        }
+    }
+
+    if (res->image) {
+        pixman_image_unref(res->image);
+    }
+
+    QTAILQ_REMOVE(&g->reslist, res, next);
+    g_free(res);
+}
+
+static void
 rutabaga_cmd_resource_unref(VirtIOGPU *g,
                             struct virtio_gpu_ctrl_command *cmd)
 {
-    int32_t result;
+    int32_t result = 0;
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_unref unref;
-
-    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
+    Error *local_err = NULL;
 
     VIRTIO_GPU_FILL_CMD(unref);
 
@@ -164,15 +192,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
     res = virtio_gpu_find_resource(g, unref.resource_id);
     CHECK(res, cmd);
 
-    result = rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
-    CHECK(!result, cmd);
-
-    if (res->image) {
-        pixman_image_unref(res->image);
+    virtio_gpu_rutabaga_resource_unref(g, res, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        /* local_err was freed, do not reuse it. */
+        local_err = NULL;
+        result = 1;
     }
-
-    QTAILQ_REMOVE(&g->reslist, res, next);
-    g_free(res);
+    CHECK(!result, cmd);
 }
 
 static void
@@ -1099,7 +1126,7 @@ static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
     vgc->handle_ctrl = virtio_gpu_rutabaga_handle_ctrl;
     vgc->process_cmd = virtio_gpu_rutabaga_process_cmd;
     vgc->update_cursor_data = virtio_gpu_rutabaga_update_cursor;
-
+    vgc->resource_destroy = virtio_gpu_rutabaga_resource_unref;
     vdc->realize = virtio_gpu_rutabaga_realize;
     device_class_set_props(dc, virtio_gpu_rutabaga_properties);
 }
-- 
γαῖα πυρί μιχθήτω


