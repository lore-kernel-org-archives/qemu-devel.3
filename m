Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D7BC47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXuL-0003Wm-2b; Wed, 24 Jan 2024 02:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXuJ-0003SQ-Lx
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXuI-00036k-6s
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:47 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40ebf373130so14050255e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082164; x=1706686964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+CzCtL3SwjCr5p6pkrscLd3wUMqqdx6mKYfPlktWfVc=;
 b=Dw9EBgOxjeWp9+7sEtEm0Nmzo5Ytw/pvrLR5W2xeZekYEnqOhTGSYxG4QtNHVJM3a/
 kTfPnbfd1P8LHlxs+j4mpUkD5cbI2wRo1wVERejzluKOgpLAw04hxeDafJdixD8B4o7b
 yXc4hppOB5kIHjS9puAmI8KdYrNG764vmLbMaaIhrW4Fq5RwgCRJL3gptL4Cd0Cv/Ssr
 AQNr2vB8+5pXx0FaFv6Iuutr/2ZdwvPkTdFv8ZcEoNXw4PIzGtgRv7YYCQlMNRoOZMXB
 eE5veuqk9tNeoejZ8wvQsMUtfwVnIf4mddEaQvi9cGsjTlwS6txoTgIGpdfoxJOV7fDI
 UWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082164; x=1706686964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+CzCtL3SwjCr5p6pkrscLd3wUMqqdx6mKYfPlktWfVc=;
 b=WP3g8wawFB4hGWPShl+czE0FaS9y9eA6dCqULrdshhcb6G6cinmA6ARwNzuxTSKFkj
 EQCUdf7ZfpgyK+ASfUWKxOInNa6tG8s7VcHkFOhYbUQsA11a98GDHMT3TlXxcYwg1gIC
 w6Ysy+kpjtjQX2FZdI1SekrLVO0PqzqCg0zynkt0JckTcgK0Ngl0t2lmTR+wjupPdJil
 ZH8EJXvktu4vWTJMrcWPzXd6dPL15LjEIyZ9hgWSigx+xswWfmFL4GazH9do4MUp5C9Q
 sm8pA4XRs0RAsf8/wsr4VDRBZH1BMh9I/W5NCDmGdPUoRZqGp6aQYIQGQpS2QJ2/PKN+
 MTAA==
X-Gm-Message-State: AOJu0Yz+deo1tMsMhEREdF+d0zyVo+63yohwkwGlt9q1BNppUTscGFYo
 AmXrnPB1AwvomfocRarmjy1u7oP8enpbLr7H/CipGJSBW0gTcjDnCeKFs0FcuTJpGw0bDxHEApM
 V
X-Google-Smtp-Source: AGHT+IHkxW/G4EA4Q/7i1YEwCr7CWDRc2y3STXDIKEXI+Lfm+5v3LDHNMJTPr1SL4F9fLMydWiKBEw==
X-Received: by 2002:a05:600c:214:b0:40e:52ca:3043 with SMTP id
 20-20020a05600c021400b0040e52ca3043mr1154125wmi.131.1706082164453; 
 Tue, 23 Jan 2024 23:42:44 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 fl21-20020a05600c0b9500b0040e9d507424sm18572088wmb.5.2024.01.23.23.42.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:42:44 -0800 (PST)
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
Subject: [PATCH 6/6] hw/virtio/vhost: Use RCU_READ macro
Date: Wed, 24 Jan 2024 08:42:01 +0100
Message-ID: <20240124074201.8239-7-philmd@linaro.org>
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
 hw/virtio/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac79468..1f5ecb843e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -186,12 +186,12 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
             hwaddr phys, s, offset;
 
             while (used_size) {
-                rcu_read_lock();
-                iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
+                WITH_RCU_READ_LOCK_GUARD() {
+                    iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
                                                       used_phys,
                                                       true,
                                                       MEMTXATTRS_UNSPECIFIED);
-                rcu_read_unlock();
+                }
 
                 if (!iotlb.target_as) {
                     qemu_log_mask(LOG_GUEST_ERROR, "translation "
-- 
2.41.0


