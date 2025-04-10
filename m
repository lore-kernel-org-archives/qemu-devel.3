Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEA2C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qzi-0008OC-2v; Thu, 10 Apr 2025 08:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u2qzc-0008Hf-UP
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:26:53 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u2qzb-0000cH-AP
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:26:52 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac34257295dso152882266b.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744288009; x=1744892809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftCtUt1wCvnmyqMw25U33WH4HwFTYT545yQfYplCULc=;
 b=TLOOmga0nniB9cgjdWwWnV1GM7XAU/qev5WwmUA9+U0D4cuK8xG05gBVgIhu5Tb7Kj
 RKUslUnBFcGqhRTnSzf7SztyAwBJcNuJUktR7MMmp7DuEm5x3niv8qiSt8hfWxzdP5o2
 ZCgyHGWO4XMFNb20KZZu4k/G42qIeLbkMVrUr44m7/IoaiH+jqHCAUyVOQR+nOcvhBeA
 clM95Q8pGhftXa0vaTK7i9si6agWZ2kr+H4WJGvlsGKdg1xR0CpKg/WE5Tyhu2fR3tLV
 rbemvnAr8t2m9Dqy1MHJBVQkXklHHyxpUptzR2MH0cvQs3AD4p+kjJW8Hasj/MYE/8eA
 +vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744288009; x=1744892809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftCtUt1wCvnmyqMw25U33WH4HwFTYT545yQfYplCULc=;
 b=PtYwEPRAULKz6NO0XG3DAj5h2nj+SLm/ZSZFHYkr64AirzC6/ygZa4yiDI85ai7m/A
 R74vcuv9GwviyNid7Q3tqD7pj9Eb5k8X09C5ztbpXx+KoTTJdibqZbBXnUc4vonQAmBu
 AkMQYclxNf9Ygj+8mUFI9pLJJ7ezWmXgF3JVG7PhzY/6pVzv7XOAdh2y8gAyLeVmPZrD
 yd2PE4FvvRjzBwgXh0HsSWXqCKZJmNV0Z9Kun62CegG/5NvRd3xQ9yXQLbyzPamO3dKU
 JOnCDaqa1aLvAxFjskcR/DRk75K0cFz8nPazeuR2pwtVNaUmFjYKuEb4MJe0mvR3tp3z
 LbYA==
X-Gm-Message-State: AOJu0YyvRDVyGiQDtQXo5HzZodMw92zCpzZ00eYg7YyZ9W9nucXxoMpo
 c1XPRWwIs+tSlJHHSe4AzT2aY0h61f9JgP+SZfAeiMzfHc3hrCMpldmPriHxsHUe04MMzI8TUIu
 P8Vg=
X-Gm-Gg: ASbGncvIr33mWOLRi+M2Fiv62CPLfTGnOpmRtHZLQ489CAZfAumtSKo0AJs74YAXWqC
 QD9UrrtyxxA0J6Cligu0Y7BJ/+z+Hxwx+6YRvnTY/M6n2AqlPetsdGramHbXesjTfckgt+Ie0Ug
 bsYpV76JNHp7gJ1TIZU6/nlaTWoE/WI+kXIGhinVyDWcEKSeWAfaAImXcJbmdJPlpfVATIuJ6yo
 OfH3iFMD4FlL1ULAl4T7eob5fWXYulZgt2ElZCdLZ59fgLKz7ZemsReegA9wBRyIyTFlx7jfE9+
 UJ7xvOp8e1ILZKNasNq75wgOuJsQXL4F3CZEHdVMMVBnXHSguTT4P+l9T3ldoHNViOS5G8+aF4G
 SPv23+V7yTZvW1tyC+GUmnaA=
X-Google-Smtp-Source: AGHT+IGFjwq9jI7WER0Hx+152+JJI9LZ0+hRNUsXn88cVFDrD/l3Jtc088pVv4dthafChAQT4xLS4Q==
X-Received: by 2002:a17:906:c14e:b0:ac7:cfd4:76c6 with SMTP id
 a640c23a62f3a-acac0064410mr189145666b.3.1744288009515; 
 Thu, 10 Apr 2025 05:26:49 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.109.242.94.tellas.gr.
 [109.242.94.194]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1be98c9sm271794866b.65.2025.04.10.05.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:26:49 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 3/3] virtio-gpu: refactor async blob unmapping
Date: Thu, 10 Apr 2025 15:26:38 +0300
Message-ID: <20250410122643.1747913-4-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Change the 3 part async cleanup of a blob memory mapping to check if the
unmapping has finished already after deleting the subregion; this
condition allows us to skip suspending the command and responding to the
guest right away.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu-virgl.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8fbe4e70cc..32a32879f7 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -155,7 +155,32 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
      *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
      * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
      */
+
+    /* 1. Check if we should start unmapping now */
+    if (!vmr->finish_unmapping) {
+        /* begin async unmapping. render will be unblocked once MR is freed */
+        b->renderer_blocked++;
+
+        memory_region_set_enabled(mr, false);
+        memory_region_del_subregion(&b->hostmem, mr);
+        object_unparent(OBJECT(mr));
+        /*
+         * The unmapping might have already finished at this point if no one
+         * else held a reference to the MR; if yes, we can skip suspending the
+         * command and unmap the resource right away.
+         */
+        *cmd_suspended = !vmr->finish_unmapping;
+    }
+
+    /*
+     * 2. if virtio_gpu_virgl_hostmem_region_free hasn't been executed yet, we
+     * have marked the command to be re-processed later by setting
+     * cmd_suspended to true. The freeing callback will be called from RCU
+     * context later.
+     */
+
     if (vmr->finish_unmapping) {
+        /* 3. MemoryRegion has been freed, so finish unmapping */
         res->mr = NULL;
         g_free(vmr);
 
@@ -166,16 +191,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
                           __func__, strerror(-ret));
             return ret;
         }
-    } else {
-        *cmd_suspended = true;
-
-        /* render will be unblocked once MR is freed */
-        b->renderer_blocked++;
-
-        /* memory region owns self res->mr object and frees it by itself */
-        memory_region_set_enabled(mr, false);
-        memory_region_del_subregion(&b->hostmem, mr);
-        object_unparent(OBJECT(mr));
     }
 
     return 0;
-- 
γαῖα πυρί μιχθήτω


