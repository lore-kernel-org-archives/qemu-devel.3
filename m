Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC52C47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXu3-00037C-61; Wed, 24 Jan 2024 02:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXu0-00036h-8R
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXty-00034d-O3
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e9ef9853bso29047405e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082145; x=1706686945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xe9EVqe3HoOq4iJwVgfVPRIkfHdkquxwlkFh/k/6XWI=;
 b=Gr41fZg3M8Rv268VdenzTOMkaYSpiriAqoIGYj9wFbdv8b94XwnxVmsUeM4qbC7nql
 3xs8n+he7DGGQDh2ufjN9t4e+LX+HQieT+8g6sHDCFzgizMFyS1PkxTTishW73GwB+f0
 whUKTYxcUixsVEhCIhCCN/xuagPEbGSg1XjBllbgVu80KzjBCeFj6Bw0nGIBt7y7vN49
 800wY+mcU1VoNGRKyeAngUN2m35C5pBJqKzh9Kh4+QtkJudEM3vOqhuss32zPT17uiLy
 9unnlz4W/8OgScs5ZiN2Xf9ARIaM2kp81AC6LecEmBcs/ImaY1gKjZqFyNuUhllWNOu0
 5rmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082145; x=1706686945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xe9EVqe3HoOq4iJwVgfVPRIkfHdkquxwlkFh/k/6XWI=;
 b=LFfTo39GiF28xTdFTgEUGUPGMO5AXiA3m51UaIYOYRB1W2fy457rh3gbVX4WADwp1V
 /v23/Yz+e5GQCa5Qn+8N26ZtIH4VFYCZf402kwPZDyLjoWs4qBibsd+Ry/w7USPYA3kD
 KJK95vinmbAiulTkXtRhSYj0w4W3HBXoXRGIlO9U7BhniT5c1S/y5l78RaL+G+0Apc52
 GM63pvtbKVIjQBZxAnGjiMkYzynbr8vBau5cqyNIGnjL6UGeaF/V1zKZ2nO3gEK6HKJ4
 xr3dZuzEZSNL2mZgLDnEBbShMSCHuJ65hqXQRRjWjffu/U5gIyQehh+qQ+m2y6WDjjNr
 iKlQ==
X-Gm-Message-State: AOJu0YwJO2lxKeh8jLXEq0eIzU5zMfyKhUc3mVGEbsnB1yfcy477RAoT
 xgCkRB1sAwEkGLpeGVF9ddGs980Lq8Blb5Kmw1tohLAYdbG6PUpfAqaL9JdZakYtSN8UXAAyJ04
 9
X-Google-Smtp-Source: AGHT+IGGRj80QbWDBmXKjCCZF8opK53O7z3kjrwFwKXacLUegi1ar1ZwwKFBs+9jfWrsnPriUcmvhw==
X-Received: by 2002:a05:600c:6a90:b0:40e:666e:4a0d with SMTP id
 jl16-20020a05600c6a9000b0040e666e4a0dmr430558wmb.126.1706082145077; 
 Tue, 23 Jan 2024 23:42:25 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 r17-20020a05600c459100b0040e88fbe051sm24940216wmo.48.2024.01.23.23.42.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:42:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] hw/display/virtio-gpu-udmabuf: Use RCU_READ macro
Date: Wed, 24 Jan 2024 08:41:58 +0100
Message-ID: <20240124074201.8239-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124074201.8239-1-philmd@linaro.org>
References: <20240124074201.8239-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Replace the manual rcu_read_(un)lock calls by the
WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
"docs/style: call out the use of GUARD macros").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/virtio-gpu-udmabuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d51184d658..0ee6685803 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -42,9 +42,9 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
                      sizeof(struct udmabuf_create_item) * res->iov_cnt);
 
     for (i = 0; i < res->iov_cnt; i++) {
-        rcu_read_lock();
-        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
-        rcu_read_unlock();
+        WITH_RCU_READ_LOCK_GUARD() {
+            rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
+        }
 
         if (!rb || rb->fd < 0) {
             g_free(list);
-- 
2.41.0


