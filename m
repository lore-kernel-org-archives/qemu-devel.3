Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3566606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UKxB08O5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VKRS5hM9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP0Gl-00048G-4O; Thu, 05 Nov 2026 11:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xP0Gk-000485-2c
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xP0Gi-0000GA-HT
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793895890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CoVikxobLQhL7AYHyfGbcULeCbfoUu2OCPXJLr/SHEI=;
 b=UKxB08O5DfYKRq5L0Qk2Fy6kAmgHDmjK/ZWhsqkBrfJ5Ann7B4ztSpkWIjO5+jxyFaL7U9
 +SiuNeHsb9Wy/BFKFHBVf3RdN9qsG/6qqPQci332wUYO4jVW5j08sKMvMQYiDJu+egRWtd
 fWpX4EwzsI6NbOkvCdWJXYDrrMZGlT0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-aL3cAUmDMXGr2nQNnElelg-1; Thu, 05 Nov 2026 11:24:47 -0500
X-MC-Unique: aL3cAUmDMXGr2nQNnElelg-1
X-Mimecast-MFC-AGG-ID: aL3cAUmDMXGr2nQNnElelg_1793895886
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48fbcf023dcso1215130f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793895886; x=1794500686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CoVikxobLQhL7AYHyfGbcULeCbfoUu2OCPXJLr/SHEI=;
 b=VKRS5hM9aR3c0Q75oZ17HCvaJcKuwNXB6incgKnXr450gy2P34+ESLxw3OqXt7JRUI
 3pxsp3ik/FNbgIahnAmrwbcZeCcWyIApxuSjaJzxxPEz3tye6FGYvxceN7DAfqx9rVfq
 0+53Ji05wDQnAe8EBdYun79eQ4Eb61b1VdvnmiWrch9PQ2BAIA+y6LICgSgAnvtEp2sj
 uVRiMOJBTEjyIEcxOpoqYu51W5F2Q9Rm1mV2+rfIqLTn4dPz1WBl2OP31JyhtTmAdqgP
 PVy62kmc/BWEGk7oWWq1fv1c6xt6WORgvVoPEhN76orWl4V4BMb4RJI/nhQDEMCtsQB0
 FnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793895886; x=1794500686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CoVikxobLQhL7AYHyfGbcULeCbfoUu2OCPXJLr/SHEI=;
 b=1J4WnyfdMJ1lnQh4bCOYWuvT1z17gj/N5kG+n6fFtHbYmZjpKZOydmaPGI+semJxiQ
 KrnW2/lJxt6JRo1uIaP6ESnN3659KrvGlVSUh7dDfUbW+7nIVDJsAtjsOTZGFQGjqMiA
 5xTg75dGinYb6e/SPf0MTdrHpu3PAg59UdlaLnLFh4615tPCryRSrWs838T0U/V6MnEJ
 e1Rb6J7iVdzVaE3yxGCxmgs/fHBCkBqkU/opgsfiwf7A3KZ7ezN3Ugl1539pFRLTLyAs
 Rmf/iiArNSJZdrraEwjHSXkQxQQTEwDDhC47MNugV3ovLVVzYGmAvnC9DO4S5vA6WbLR
 np4Q==
X-Gm-Message-State: APuU4Z9KI/hWL2GtJBORLuicx/QtT9RBgHZZWj3R7QiBr2diErwr4aga
 DoPrdizOa81xxp4Z52h9frULMPbFuZngZ3VrbtIuCo8TZ72AA9V8n4FRGTk9lUR3g4+cJL/sLtq
 Q4dRo6YZN6Lwt3EutYz8HVI0Gfy5r5ZBSL7r3OjPiiIWhsqig5VCVWHFYbIK94mvEmZ4Xo9mbEd
 BQSIHAOo34n40LWhaZsafQ856IJM/1dSl9ewc7yjb8
X-Gm-Gg: AYBFou3f7+ubZHbi06k7k/uYlJfEGDMdFdROAuBY3qgC6oy8VGcrkFiM7EfDYVICqj4
 +aR7AHssgEunMrUSMrrgs3pqsPYQ1A0OGrq34xZZT4W8H1lcrzdMGc25cHYXAowV8AX3yBD3r/R
 dpyCoe/kmyhLv6P7+0Wi3AVdP0mMnLDBqmq+8Q158BDh7MU+zT6FlD/zyZeoNF/GK+dzi1wjy1Y
 0HdoNMZQYQ3IXmvamawh6+E0WCaav2QfsBYjdEY5keZX8yqmvNiD6ug25UL8z5t1uSWA5BH66xa
 BvYYX5p5vnfPX1m2BEilZJIAAHVJG3FlTMbMowM/jL35iaW6pZi+HJKyLWqjBvJjDMMMyg47nz1
 HldK6xjNYhysTixcTzDpVrZ0N+jKRz6BDc6kIOky8s7MLAzC03CDT
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4ac17470f97mr439427335e9.10.1793895885915; 
 Thu, 05 Nov 2026 08:24:45 -0800 (PST)
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4ac17470f97mr439426645e9.10.1793895885229; 
 Thu, 05 Nov 2026 08:24:45 -0800 (PST)
Received: from stex1.redhat.corp ([5.77.70.210])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4532916f2sm154736435e9.5.2026.11.05.08.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:24:44 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] backends/vhost-user: fix memory leak when vhost_dev_init()
 fails
Date: Thu,  5 Nov 2026 17:24:43 +0100
Message-ID: <20261105162443.232929-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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
---
 backends/vhost-user.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index de6b1ba267..a3cd15a57e 100644
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
2.56.0


