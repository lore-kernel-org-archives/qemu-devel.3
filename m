Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB817606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjNXCCLn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dlB5CQ6h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7F9-00065S-Dh; Wed, 28 Oct 2026 13:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Es-0005MG-9o
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Eq-0003WR-NT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o78OIafkaiQNT8PZdADeGiaPZTwakOgbS7DgIUyUXro=;
 b=cjNXCCLnAuruP2XQZr1MJScca99xgV40GrRiT0AAynMAmYQ/HVR8LbTduetRHqgL/OYbYr
 Vp30MTawpMCDK/UlIWMpDIcBdJoz7yBBbz51xf/bJR0fEnnPIDnLt86xxkEwcLlEjyXfSc
 jCZs5n3XlPfepMBcq/9bXlHakuxRlRU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711--K2vNHr5NyGz4VuUw5Kb2A-1; Wed, 28 Oct 2026 13:14:58 -0400
X-MC-Unique: -K2vNHr5NyGz4VuUw5Kb2A-1
X-Mimecast-MFC-AGG-ID: -K2vNHr5NyGz4VuUw5Kb2A_1793207697
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso7343045e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207697; x=1793812497; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o78OIafkaiQNT8PZdADeGiaPZTwakOgbS7DgIUyUXro=;
 b=dlB5CQ6h+quy3DIcxblThkemLFCQzvWqFtoOfjVL7luIUjrBoKAZ1oUmFPqqNVS6jp
 /7Oj/o4cfpR9xPY6vYgdO3qRsFCpLmZuA6DSYjaSGAgM+W9zXIxhnPot5/p2025bEJmw
 TOiEUH9XHvjSz1LMHlrEY6wHH+RjDdL9D/n4krSTpgdckXzqvSeeIKpvvWTGvL07N4GK
 2fXeVhjkkgouprHY0n1Uc42LXp1LJIfKvtzoUBvaKR4gi7tate9pQZ0OJjGKjNNYvrV5
 kCiIXElplzZfr1NSl7KqbIEtFvJTI07M9WRWS94B1DalTKVQylb2vr6PshDv4UYF4OLB
 3PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207697; x=1793812497;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o78OIafkaiQNT8PZdADeGiaPZTwakOgbS7DgIUyUXro=;
 b=flw+i9RoFh9mfGmIHNqC0kuoNwLTvY4rCIf3SWys6CO8GUSTxPSEGLG98HyAm0qD7t
 qHNAvaMf2mcQ6HY2CSvRQG4rSfkmAFJYGBQiHFG288ZqRGfq1ebutxC5K4FhGW/Zo7om
 N5KFNEpTs9MpI2gAoSm9rcSbHMx3HrxWJJmwChJ4cg+d5YcZmzKHdI4ULKquPTBges0O
 Yx3ZiTiFyAait0t07YlQ+nNV5DhpX6937f/OvjjAs1TC+hs+X+5nqpUdE73Cy+WBTgz7
 5qN4+fqau7XyNlYSm73cCLQTpvEh4noC9dUkhPA7ziULEfh9rqdns1wvONTz7VAGpnRD
 7rGg==
X-Gm-Message-State: AFq9FYKndq6qF6tF+HmeqQjBldVtS3Mp1lyWThBrzUIf7FczwU1+ZZel
 K4sFamv4SPycX029GVNtI268OZFgV1f9urj76+8BrhCfHAxgqWi1AiDDMYqlUy0Zd/lt1f1DMqF
 CZX1H6OvzbVykTNExXPP1VAQvIu56Aj1+P+YEaAGSonOu8s65xymx74rqa2L1sLD2MJLTT2IvC9
 TUTYQtRle7YNzoBxlZZnDQJRZmM8Viog+z+A==
X-Gm-Gg: AYBFou3zzY/EzSqcuCIniKHqNjIQF9UvlX1FPC5Bu1XWVQjby4ZCa3emfDPrwu134DH
 U/6YUJpYvZcL/2pkyey0jxZSIpRwA7QohHT6XGjunVb+lytCEDf+nVNO4CW8RCJAfoJUS/3iLx0
 ZF++Vdd7/Hh21ZncKrN+DTSHCc3oy6hL+CX4ftDJVhLqvsGiFjNhESH8OqJr5/fKLBBgzWShFUL
 zR/RdpLqQ1DtnFBJxFiXAv9DY0KfVgpE1q3BBDL0KFIdFHH7DrKFNAB3x8LfBx6OQ44Ypr/p7aj
 41Fzhf0+XuVcu8y7fEnv5oWD92RsE3Psjlhuy5xT7n2skCrelAcSx4OukIxUwDWVzaz5JtGLSH1
 QxnSrXBSDgdrHNK9dymmRVXoTynSCLDqqU2tYp5n1
X-Received: by 2002:a05:600c:8589:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4a966e2b90fmr49282555e9.23.1793207697011; 
 Wed, 28 Oct 2026 10:14:57 -0700 (PDT)
X-Received: by 2002:a05:600c:8589:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4a966e2b90fmr49281445e9.23.1793207696255; 
 Wed, 28 Oct 2026 10:14:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f322c46sm6022085e9.2.2026.10.28.10.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:54 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 21/78] vhost: make vhost_dev_cleanup() safe on a partially
 initialized device
Message-ID: <ca9dafcef36ba44115097111fa581ea92d55dbe0.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

A device which only went through vhost_dev_init_backend() has its VQs
not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
would crash dereferencing it.  Check vq->dev before use, so that
vhost_dev_cleanup() can be called to release a device whose full
vhost_dev_init() never ran or failed along the way.

As of now, there's no way for the cleanup path to be reached with
vq->dev uninitialized.  However after a subsequent patch adding CPR
support for vhost-vsock this'll become a possibility, so let's prevent
such a crash beforehand.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-12-36c38bd15ffc@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 99561ac586..dfdfd49da3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1661,7 +1661,7 @@ fail_call:
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
     event_notifier_cleanup(&vq->masked_notifier);
-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
         event_notifier_cleanup(&vq->error_notifier);
     }
-- 
MST


