Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63E2C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsZY-0000e8-DF; Wed, 05 Jun 2024 11:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sEsZW-0000dJ-8e
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:29:06 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sEsZR-0007Wq-KI
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:29:06 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c19bba897bso11206a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717601339; x=1718206139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uSdqS9y8pZdwZwhzYtQ3lJ2peW+WDx3Tf5rEC64RwM=;
 b=eUOggr49y5OqexxReIto7Nx16Dh2Awy6Qam8X+i9ZyTXYMX+tQV0fyt7h9R73bVGfI
 3oAjXdNyfj6BG5WFEhADlsfsJFO7KSLWMDUb9i4Pq69wOKm51/Po6Dk/cIjYg0zEsTuk
 LOio3rMr4x1J9m9wzlTNZ+nkU5KXZw1g+cmJWUPVanwoQiO2OZAc0PcvvvS2cae/oSYO
 jIF0wri2Qihf8enZeib0o6DFaZTos5xyC5QKipNidesn/grE0+gXY9qg01xMC/T9K9wI
 2mpbdBriewB/A2wSsWfNajIl8WfBu464FA6GWCKqaLUTkt3SebO3hLq5+TbYEfJWnEN9
 gflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717601339; x=1718206139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uSdqS9y8pZdwZwhzYtQ3lJ2peW+WDx3Tf5rEC64RwM=;
 b=Qp/Vl5rHeEVVfm731dJ4WeUxhofWHlKXq0NlLTVK3S8iLmOPJJsuoA432f2Ku36GKA
 qcbXw656ibZxS0jYZJxmC9ZEqloSHG+3H8PSbiL30XhReH6iSiDEtzTYy/LqXcXRdS44
 /1flx665tRbfEzlzflLKwXB6zcIIPIlylDgWNRDC+kA32W7BlyjJ12j/SwXyT6Ei5rVl
 xCwYLBgkRDqwOfTMXgPUU1bA5VuAhk7Wp+zTr2k3FZ/6EKonpZxcQt/2gHqQnsGf4lFG
 i8fjSsHcrw4YiYfe+hoM6zuyLH8N4IvIKm6eE9NAKv7TUd+oqIL3zfgfR7PZJBo/YrxJ
 /LTQ==
X-Gm-Message-State: AOJu0YyCcNR72xdhP7Iu42A0MqROkG4cDomltC6Q8OmHSOOSxGrfVcA4
 nn+GT/mTsaW86tSKUMb5AwssJcJqIt9ovlsM+pcm3qpaqoT2icVDwk/4opZvevM=
X-Google-Smtp-Source: AGHT+IGimj//pRmrNZ48SI3fMsWEwh0xWZG0frDs34EZYEwcvCLgKdeD0hmVbeaD6yLOjxOx1umKuw==
X-Received: by 2002:a17:90a:5410:b0:2bd:fa57:b361 with SMTP id
 98e67ed59e1d1-2c27db10aecmr2914768a91.11.1717601339276; 
 Wed, 05 Jun 2024 08:28:59 -0700 (PDT)
Received: from localhost ([103.192.227.74]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c284aa3161sm1518335a91.27.2024.06.05.08.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 08:28:58 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/3] virtio-gpu: rutabaga: Properly set stride when copying
 resources
Date: Wed,  5 Jun 2024 23:28:28 +0800
Message-ID: <20240605152832.11618-2-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
References: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The stride is not correctly assigned when copying pixel data, causing
images being displayed incomplete when using 2d component of rutabaga.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 hw/display/virtio-gpu-rutabaga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 17bf701a21..2ba6869606 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -53,6 +53,7 @@ virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanout *s,
     transfer.z = 0;
     transfer.w = res->width;
     transfer.h = res->height;
+    transfer.stride = res->width * 4;
     transfer.d = 1;
 
     transfer_iovec.iov_base = s->current_cursor->data;
@@ -273,6 +274,7 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     transfer.z = 0;
     transfer.w = res->width;
     transfer.h = res->height;
+    transfer.stride = pixman_image_get_stride(res->image);
     transfer.d = 1;
 
     transfer_iovec.iov_base = pixman_image_get_data(res->image);
@@ -382,6 +384,7 @@ rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
     transfer.z = 0;
     transfer.w = t2d.r.width;
     transfer.h = t2d.r.height;
+    transfer.stride = t2d.r.width * 4;
     transfer.d = 1;
 
     result = rutabaga_resource_transfer_write(vr->rutabaga, 0, t2d.resource_id,
-- 
2.45.0


