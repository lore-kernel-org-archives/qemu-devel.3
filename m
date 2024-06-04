Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DA5C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUE-0005Yq-Bv; Tue, 04 Jun 2024 15:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUC-0005PY-LE
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUA-0000im-1w
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMYpex8C2s46cF0GfMcoGvUcCxmqXFvGY/Nt+8TTLHo=;
 b=huibwigyarAOcnqRZY9U2tDhRYPRITk/YBopXc56wEHHoZB8khT3hiwY4zyGPV2/QP9bRL
 k7WnC1YaScnFqGwVfUok/Sninas4OFJctDdcTlKxqjRx7O2o4D/liSTgAJVfEH0LRv+f7p
 p1ZxaVN4HceK3N0pz/KDJSsR+wW7d/E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-0NRGOMprOlm5Utu7VIXHhA-1; Tue, 04 Jun 2024 15:06:14 -0400
X-MC-Unique: 0NRGOMprOlm5Utu7VIXHhA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42135f6012fso26193135e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527973; x=1718132773;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMYpex8C2s46cF0GfMcoGvUcCxmqXFvGY/Nt+8TTLHo=;
 b=YYdRVlbH3Rs8QZTxM6/QRnotCTLKuWWEYG+qP8usNjZmuTu/CbAAR623GY1kE6D/M0
 mEr/TnK0EHVtPAA1TJLRCCVCO67nM2Jd0Wd4useq6Y/wMeaUxc75r9k3Sz4WCO3ZhdDk
 Mj6rOGNBqDEjwqalNSvaxBvVaEMj3aOxWT133SnNgKby0uV89/t5dAe+605pTjzrrMg1
 TSGAa2TSc8OCbOg7ey2nZOHBLSspyCPoRiK9cbSyHImwhIZGeLTCadW7xQi55MOmOnPy
 cUJuBQmlEGnFAuPK+pr1w19nHWIGEwHx2iNkkOmoyPYcD31TIGISjoSDrZnRFdPKDGz6
 4DXQ==
X-Gm-Message-State: AOJu0YxEf0xT5svcenPTelNsXTVRvvQznAaHO5mbRAVRnm4nTwECR16D
 w9HUZbvV/QBN90tILG9txsrOaHuMcr9RofqhUiWCVyA2zAdn4sL2AZU6tuGW2C1duaccQLzGU9A
 K9Xl/F9EIDwKtyU/olFEsYqvYvlXtGgO5WM66PLNxX3FALTXkmG1frsMTW9ShfJBiRcgFejFLJL
 n++MXL9VGpDl0KRCLnoR3lx6o5xxIqFw==
X-Received: by 2002:a7b:cd85:0:b0:420:ed93:bca0 with SMTP id
 5b1f17b1804b1-421562e9366mr3550055e9.20.1717527972750; 
 Tue, 04 Jun 2024 12:06:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4VzW6OR+uKxY3UrzoPpk1qfCMov4uHjG7C23bOqVItncYMFhOCI4rDhAVCXwerrB74gWJiA==
X-Received: by 2002:a7b:cd85:0:b0:420:ed93:bca0 with SMTP id
 5b1f17b1804b1-421562e9366mr3549915e9.20.1717527972251; 
 Tue, 04 Jun 2024 12:06:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214186ccdcsm55364295e9.16.2024.06.04.12.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:11 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/46] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
Message-ID: <982ae85fe81e3849e27d9eacad85c2ffc131d7e3.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

vhost_vdpa_set_vring_ready() could already fail, but if Linux's
patch [1] will be merged, it may fail with more chance if
userspace does not activate virtqueues before DRIVER_OK when
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.

So better check its return value anyway.

[1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240322092315.31885-1-sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 85e73dd6a7..eda714d1a4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -399,7 +399,10 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->nvqs; ++i) {
-        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        if (ret < 0) {
+            return ret;
+        }
     }
     return 0;
 }
@@ -1238,7 +1241,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    r = vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    if (unlikely(r < 0)) {
+        return r;
+    }
 
     if (v->shadow_vqs_enabled) {
         n = VIRTIO_NET(v->dev->vdev);
@@ -1277,7 +1283,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->vq_index; ++i) {
-        vhost_vdpa_set_vring_ready(v, i);
+        r = vhost_vdpa_set_vring_ready(v, i);
+        if (unlikely(r < 0)) {
+            return r;
+        }
     }
 
     return 0;
-- 
MST


