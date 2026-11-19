Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A4606A32C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BjrV4bMl;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bQBGDDqI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyk9-0005yW-Ah; Thu, 19 Nov 2026 04:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyji-0005gN-FM
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyje-0006Lk-FR
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vgfKtdMBH3P2c6NDPVAHcVP8Qnfb1ZqNyAJzNmTN5ws=;
 b=BjrV4bMlv/xS5fS+ysTZYneRO+dVI9PnJXQ0tMBUMZ2SqIcSQ35dBB1j6Mc4PezN2BdzvA
 PF/s9yDLQJd2ap/NxnghebINOHWT5pdNQeN5jZRw/ohX4cf1oabX5jm6mcSd/lZexp8cdE
 hqJ01WZf2Py4D+wAupTNxtka5cbLj3Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-7GNXfGD3MpO8kdsKim9WKA-1; Thu, 19 Nov 2026 04:47:16 -0500
X-MC-Unique: 7GNXfGD3MpO8kdsKim9WKA-1
X-Mimecast-MFC-AGG-ID: 7GNXfGD3MpO8kdsKim9WKA_1795081635
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4a370217dcfso1445544f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081635; x=1795686435; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vgfKtdMBH3P2c6NDPVAHcVP8Qnfb1ZqNyAJzNmTN5ws=;
 b=bQBGDDqIRnTRXQK0zRa91vN6nUDLtUf9wljlq9c/Q4Xs8moXSJSxxQ2lngaDPfDVVq
 lecOurWlL3AYEStiv2YSzaykKrSnDydxufEtKH2oNkvO8XPJsYGFjnXVkwbYIUyckKTT
 DKNDPQNStDA1bsvLDaETX0toRnUF6MGqY30JkTT0JNzmWauX1qezkjRL3BtP/tKLzhAU
 7YTlHzgSuwgHDAWhN2FB3EKZg4aC8K9MaRxd/Ms4H/nMtQoIafdd86FF0tzjlr+RT8ju
 KEgzgjiUMOzrj9R7Gbdk5/GneMUcfW8ykmZrW/Y9cKvEdI4CURHSxwC5t/WTqBnJtuWY
 rRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081635; x=1795686435;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vgfKtdMBH3P2c6NDPVAHcVP8Qnfb1ZqNyAJzNmTN5ws=;
 b=0GOJXBW3dfl8UE1sD+LadyzRI9//1v6Uqkzx4VEQcm1lEZwJr8U3vSrqYvRuJF8N0n
 DwVwiIwpV5DK25WgMU/9WG99YVTGDXFKOnCuC/IdAaX44LaviUks7Tj0OD4zLG87z/JX
 samJyOxFCNsyHH1TeRjSAvFegM3THs6zOKUhz9Mi+nReDh1MrQd/ZzN1mAGxuN9ce8Mc
 7LG7SYwGNeePzUWYSvCGwnoVJ0wVjVIIxS+pfBOZTmjBPwCytNV1qNbsTGXAbqeesi9x
 S8f/SXnHRJU9oKACNy9DWdhgNVC+bYIAyBKJmpLuiYmh1I2aaGuteZUX9dhLv8B7h2Y3
 pyzg==
X-Gm-Message-State: APuU4Z/1BlnY+N4Nlge2URSFHsUly5qhpFNfzEpC/i2JXzNyXKagwfNv
 QyR3yFfW4UdcBrFaQy2vvZTR9S5H956uVxXxslieR/fIyp+4FwS8GCEentTZI6O8Kb527Qownzy
 3/xo7rGKBAMaHnPsUFCsbYq5pBb3cblM8r3a8C+1hPKZfLZwo9wSFSPmwZ52HtB/ydWz70IzpyP
 7mu+V9cKewXkFqP0OJb4DxR0CZb6nPd9cFtw==
X-Gm-Gg: AZFdTZdJ3b1CMM/lHvnIkjOOhH/XP6+Ig269dS+CVTHLQFu1i4CXuvTEniP+/bs+NAK
 2hw2FGyK/WSaEVt0bBK7Rzwz/nN1+iAoF+g1ba3nExT+u443MwsVoVtHEEJVw0h6BoPYo2icyUx
 wKsem4PvkGQxxCLO1LTmBA684p4bDkkMei/B/UW6gS5NdgYvhmrTUXaA7sOwmeblfUrABLVspNP
 YuwDuHWWu9UIjYMaA51JsPP0/iwtmM0/kAUwjSMeZ3t8Bw+XghOYhCSjCvougBx9iYc/EWJ77aa
 qNJ7lqXPt7N9cbTzigEUJay+yKPNOoiVfjJPHUzHBBnpjtxykfru477NqUyD9glFFyBvwKQQson
 aMQVCuEzVLqZJWsikE0TWgu4F56rBss1yaKAbAlJD28I=
X-Received: by 2002:a05:6000:c4c:b0:4a2:6542:989a with SMTP id
 ffacd0b85a97d-4a63d3c5600mr7996586f8f.52.1795081634595; 
 Thu, 19 Nov 2026 01:47:14 -0800 (PST)
X-Received: by 2002:a05:6000:c4c:b0:4a2:6542:989a with SMTP id
 ffacd0b85a97d-4a63d3c5600mr7996529f8f.52.1795081633937; 
 Thu, 19 Nov 2026 01:47:13 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65683d5a2sm9979555f8f.43.2026.11.19.01.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:13 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PULL 3/8] backends/vhost-user: fix memory leak when
 vhost_dev_init() fails
Message-ID: <27c730492d3babbd9a1f16626e5729ffecc4f2bd.1795081539.git.mst@redhat.com>
References: <cover.1795081539.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795081539.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefano Garzarella <sgarzare@redhat.com>

vhost_dev_init() clears the struct vhost_dev in the error path calling
vhost_dev_cleanup(). So, to prevent memory leaks, we need to keep a
local reference to the vhost_virtqueue array and deallocate it in case
of failure, just as most other callers of vhost_dev_init() do.

Discovered while reviewing a patch by Alexandr Moshkov fixing the
same issue in vhost-user-fs.

Fixes: f24bb7287ddb ("Add vhost-user-backend")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261105162443.232929-1-sgarzare@redhat.com>
---
 backends/vhost-user.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index de6b1ba2676..a3cd15a57ed 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -24,6 +24,7 @@ int
 vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
                             unsigned nvqs, Error **errp)
 {
+    struct vhost_virtqueue *vqs;
     int ret;
 
     assert(!b->vdev && vdev);
@@ -32,13 +33,16 @@ vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
         return -1;
     }
 
+    vqs = g_new0(struct vhost_virtqueue, nvqs);
+
     b->vdev = vdev;
     b->dev.nvqs = nvqs;
-    b->dev.vqs = g_new0(struct vhost_virtqueue, nvqs);
+    b->dev.vqs = vqs;
 
     ret = vhost_dev_init(&b->dev, &b->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
     if (ret < 0) {
+        g_free(vqs);
         return -1;
     }
 
-- 
MST


