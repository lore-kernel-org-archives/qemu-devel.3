Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9531C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 15:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpb6-0000vt-8g; Tue, 30 Jan 2024 10:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUpb0-0000sF-Sk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:00:20 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUpaq-0008Tw-O2
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:00:11 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e9101b5f9so44750995e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706626806; x=1707231606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rjZNbSKagVpk27PIGKUkuf1AY4K8nKgFwbZ9fsBYzs=;
 b=qwqcktDw9qKwgOTz/NiSwclvKsZbbF6xj8uYaPXwasvad15p2hx1zxan0maSade8dN
 rswW1SLdbySswpKIFTJ923ufpMnEGdW8Mi/C+9bRFu2z5akwY/OBJZAgCmANJTyJdejC
 mFgiIAXa57empY3jnd1OnX+OZsWN4p5VQVfajMqCAl8DoUriY6e7+H2j5Yr8cC6ZVt3Y
 MN/i7FXoy7F7D8HX3zuxo42QM+QQrhTujEIHfusC1SuZGtUix8jQyTpwOwIX0f1EPumb
 INfzQEE2bTSWGZZHYU7mfb3rUtqTiS4Owq2BfzMaya0bpohP4Xii607jhx8b8XRvJmF0
 QiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706626806; x=1707231606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rjZNbSKagVpk27PIGKUkuf1AY4K8nKgFwbZ9fsBYzs=;
 b=PZcReZFFMEWyVL9ZBKV02Xp0qO3JuM89phaSIHCsLlokPY86+yn56ep9BHjSho54CF
 qjhrixjjcgeBCfinYX49APa4RPBU7DsyQ/Cl7Q+LWAPLyOdUCYuT/DKeqfkEf09Vc/Q+
 rb6NOfANepNEkeTvGAg0O1NuH8/iQbMpJXVaiL6u0ort/pHGPbrt+FiXIXrUov4fWCP7
 UfKC37mKofD+PvA+eWA0W+bU9EhUG4XcJgSV0wbgVCR/BIEcUjHhNgKsDKtrbW22oYvx
 qhBNRA4rnMpbRwQwiIf6WaF7giaVqk7YkoBB1Yf8euAJKWZJB9+negyIT//Icklh1sl/
 OqCA==
X-Gm-Message-State: AOJu0YzM5auU8pctEVapgSpB7njJjY87PAGSQqaQX2PAw/NKlsAec4D3
 IVz8rycXhuqwYNUhcrgTQvhRzu0vC7a7jFbXOC6IX3T5CnQW/0Qjo1mlyXc7/3SlNkx/4n8W1Ry
 BHV8=
X-Google-Smtp-Source: AGHT+IFTJ2neJwlX9DIn8CcretI9x4KupMnOBvM0FhKqxYhPxm2S8EOdP+D6NDikNNMuEIoxOHBB8Q==
X-Received: by 2002:a05:600c:1396:b0:40e:d425:85a with SMTP id
 u22-20020a05600c139600b0040ed425085amr7978785wmf.17.1706626806620; 
 Tue, 30 Jan 2024 07:00:06 -0800 (PST)
Received: from localhost.localdomain (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 fa7-20020a05600c518700b0040ec6d7420csm17078648wmb.14.2024.01.30.07.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 07:00:06 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 3/3] virtio-gpu-rutabaga.c: override resource_destroy method
Date: Tue, 30 Jan 2024 16:59:21 +0200
Message-Id: <e3778e44c98a35839de2f4938e5355449fa3aa14.1706626470.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706626470.git.manos.pitsidianakis@linaro.org>
References: <cover.1706626470.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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
 hw/display/virtio-gpu-rutabaga.c | 47 ++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 9e67f9bd51..17bf701a21 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -148,14 +148,38 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
 }
 
 static void
+virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
+                                   struct virtio_gpu_simple_resource *res,
+                                   Error **errp)
+{
+    int32_t result;
+    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
+
+    result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
+    if (result) {
+        error_setg_errno(errp,
+                        (int)result,
+                        "%s: rutabaga_resource_unref returned %"PRIi32
+                        " for resource_id = %"PRIu32, __func__, result,
+                        res->resource_id);
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
 
@@ -164,15 +188,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
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
@@ -1099,7 +1122,7 @@ static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
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


