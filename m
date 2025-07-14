Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11E6C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSG4-0002us-H4; Mon, 14 Jul 2025 19:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFy-0002d8-Mg
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFw-0005O9-TE
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+UAUxfm7ZZjTGEuMkx1MXZIZiceR06VrUrTJFA1Ndo0=;
 b=gG3gdj8Lk6SwUFBb4qptt5bqOU2IvrQ9EhpSH1cPzlhKH47c61O20otuabb/tB83Jd7+Aj
 YBoyhHkRKtg1g/0jDUpoICrzpNmV3SCzBh3UfvRucP2mFoKNoKhdEX92+wSLLcoIl5EqjE
 J6rrfLvf3ENQoVw94koSpFTsGGwM8Rc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-cE9b8KFWOyWsRU2HegzBpg-1; Mon, 14 Jul 2025 19:06:43 -0400
X-MC-Unique: cE9b8KFWOyWsRU2HegzBpg-1
X-Mimecast-MFC-AGG-ID: cE9b8KFWOyWsRU2HegzBpg_1752534402
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso30875725e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534401; x=1753139201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UAUxfm7ZZjTGEuMkx1MXZIZiceR06VrUrTJFA1Ndo0=;
 b=JzzX75GiVBqkGM6k2V2ciSOXNUybv0I/vJptvHqt1q2xCxvu6gZ7GFuXDU+niGcKfx
 CXEvb2bsR5NOMm6YkuU+IH2ZkaN3gUCAbH3Hkkr7ww0AwoVuN74oAsCcRy6MLt/WpHhS
 Zl4rNSFLLEU69JvHvd13QBxQaLObe0fRVXDXgIsyWryLYF1v3bCvAczYwCLOfPf3pbx4
 1ReFV3P0J6GeNujWTaoDWjQAEpJu4aPHtYJJkf9SIuVioPToD/tlf+j6jTkslZ+3V+yx
 E0vEjHnAUYcyP2cPq7TulZcZgQ7u3DUdrlwwEHHHJQcnpa+MQo7SzuywByZYiPPE/0Wc
 vx+w==
X-Gm-Message-State: AOJu0YxgsIXvi7AUZVVGoFvd6jldNzXduldMsDSmKfqiDzOZ4x3aK+HS
 YwJKBSLf93Xngo3TwekcWMkc6dJq/qUA0n7Ld34eiYiRf7H7CUq1mPaltVcGk3l1gGSz11Zpz1/
 HdOdiv96MAHNSMmIEYx22tLv/VtrYNEMkC+k9Fc2WBr3Iw55ZcEANfMV5ZJ6QS7NywMmyZI8ajN
 Yt1mLimP9XtPHCfkrl+W4dmvbQpXshd6MMLA==
X-Gm-Gg: ASbGncs3ffvpF7vLsEfRFYGrtSa/aCvs1Jboli/wnz94lvwqd2rreBcz31k6vsKWiGZ
 F2mAVnD6uVXx14kBWgCG4gZU4NHwXhMPMyIzmHnjQTzoVK4cQAFX2AEvZ4IlQWFYGuH0RUfUy+5
 Z6BUgI4uF7PZC9FYUkjQMiTsGaA/wREUda0rn3lLP5p0G99x5gr5A9xO9+FIuevcTJ9EJLQ+8eG
 2yY6jBDjIUUH2OVLOKffEyWSdj4ZWaEumnWjmcpxbjumV1WOV5coP8spoCHtoxIGNN3em6NM1wR
 jyBxVTZMCEH3IL8/uk33VUzu4AgyROd7
X-Received: by 2002:a05:600c:4e54:b0:456:43d:118d with SMTP id
 5b1f17b1804b1-456043d13bbmr112229085e9.17.1752534401406; 
 Mon, 14 Jul 2025 16:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe28pTxY70ufHHhSwpNiT9fKZKxgxvkHsnFoY3BXvolLfI93WchNoM6NVdMVKc8neh9COEJA==
X-Received: by 2002:a05:600c:4e54:b0:456:43d:118d with SMTP id
 5b1f17b1804b1-456043d13bbmr112228795e9.17.1752534400893; 
 Mon, 14 Jul 2025 16:06:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e1a5sm13316857f8f.74.2025.07.14.16.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:39 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 10/97] vhost-user-blk: add an option to skip GET_VRING_BASE
 for force shutdown
Message-ID: <07fde5901b5254d3b9706df22dbb16cfacf966d5.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

If we have a server running disk requests that is for whatever reason
hanging or not able to process any more IO requests but still has some
in-flight requests previously issued by the guest OS, QEMU will still
try to drain the vring before shutting down even if it was explicitly
asked to do a "force shutdown" via SIGTERM or QMP quit. This is not
useful since the guest is no longer running at this point since it was
killed by QEMU earlier in the process. At this point, we don't care
about whatever in-flight IO it might have pending, we just want QEMU
to shut down.

Add an option called "skip-get-vring-base-on-force-shutdown" to allow
SIGTERM/QMP quit() to actually act like a "force shutdown" at least
for vhost-user-blk devices since those require the drain operation
to shut down gracefully unlike, for example, network devices.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Message-Id: <20250609212547.2859224-4-d-tatianin@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael@enfabrica.net>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h | 2 ++
 hw/block/vhost-user-blk.c          | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index ea085ee1ed..a10f785672 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -50,6 +50,8 @@ struct VHostUserBlk {
     bool connected;
     /* vhost_user_blk_start/vhost_user_blk_stop */
     bool started_vu;
+
+    bool skip_get_vring_base_on_force_shutdown;
 };
 
 #endif
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 0eebbcd80d..c0cc5f6942 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -210,6 +210,7 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
+    bool force_stop = false;
 
     if (!s->started_vu) {
         return 0;
@@ -220,7 +221,11 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(&s->dev, vdev, true);
+    force_stop = s->skip_get_vring_base_on_force_shutdown &&
+                 qemu_force_shutdown_requested();
+
+    ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
+                       vhost_dev_stop(&s->dev, vdev, true);
 
     if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
@@ -584,6 +589,8 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_DISCARD, true),
     DEFINE_PROP_BIT64("write-zeroes", VHostUserBlk, parent_obj.host_features,
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
+    DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
+                     skip_get_vring_base_on_force_shutdown, false),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
-- 
MST


