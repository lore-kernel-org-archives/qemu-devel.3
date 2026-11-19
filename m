Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A1606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ab3CYzDk;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hAAJHjyj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTykC-00065l-Tr; Thu, 19 Nov 2026 04:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjb-0005dB-2z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjY-0006LL-Rs
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bSw9Cu1D3RRJVIZEDBUr19w2JOISov7AfYOr0AAonQ=;
 b=Ab3CYzDkptw/lBPVNItHAZBAzmVzWf0/s83Oe1fGY81om05+uT459dFu5tgGF1S2QgK/1G
 l/8TvhrWo6i3ujzbc+Uhb8ua3fmGa2OxvEhSXat78bH5ZIis38OXqm4iFVM0TlYET2J7GI
 t85vuHj2fu+rkmuzHQzu7Q2OmO+bklk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-X3qa1jYmNU6hxTqnYWZIrA-1; Thu, 19 Nov 2026 04:47:09 -0500
X-MC-Unique: X3qa1jYmNU6hxTqnYWZIrA-1
X-Mimecast-MFC-AGG-ID: X3qa1jYmNU6hxTqnYWZIrA_1795081629
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4aa0500c979so193583f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081629; x=1795686429; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1bSw9Cu1D3RRJVIZEDBUr19w2JOISov7AfYOr0AAonQ=;
 b=hAAJHjyjTBQ4gW9EMk0ioBb29dT47oJNlnfULwxb1VjUsTaqZ9my6i9CWk/NaadNYW
 ibMtL2KfftK8TF8NDWyel0ZLNbGWiKrwucXruYw6zdBEngiUlftmyZWqrIrqOzHq6vN6
 mC559T40c/ubyR51Y/zRuxkmi4Xv9kSg3zdGbDp8Ya/Ld7pN7os8W5adeTPcpaIgRql5
 wbPloooxWlIS7E+Rx9eU9ulhffyHAiZhT7Xp+3ePkWYvJM297D3+NhWh+28/JS5dyY2X
 NLmJguE3VoruOz+J2BeSqW5PA27ufXN6awVj5eFdgODI1T+vYqg3mDqZhMUdIROu//tc
 psjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081629; x=1795686429;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1bSw9Cu1D3RRJVIZEDBUr19w2JOISov7AfYOr0AAonQ=;
 b=tVrpZAJI4i5a281/aiMNwmUDoSk2G0RMiAu667murYi56Z9RT34QleddCsn8j0ixaC
 Cn5XnYHZDSnD9wUyWYk7vstep9F65fuMaqQkrDS/GkyqQU9ILGYR/pABFoRosArr7b/b
 2OIPmxf6h+DNuC+CUclmKroraZqZ5oO5zut3tU0IKw/s8Jpz68a/GRPrLrgsKGC5S3AB
 V/nzJbeRL4oB6HynR+oN60Y/+nWmscJCz2jfXVwFwAbrg8OJYnPS8Qwr7xuauLn4639L
 BZPhTD0PBpGqS4ocib4AOJbMT0Un4mfNvZIGc5b7WDauZCxqAz5Limg05PM3bOJ8XS0J
 RYZg==
X-Gm-Message-State: APuU4Z9AZQ9uYn4GV4Mj/jPQFvaYV5brNdCPcqDjheZBUs6dzRmxONLi
 UtZQ2q/m6DsxqDEmwSZpiAJ9wm3sddXJG1dIXosfEiSj5y/JmJ2eOFtsIn8+0Wj8gKQIuwGp5dQ
 dryEPXsm6uwXHP48m8K5uQw2UWIW3IFOkIGGLasD/J53flRXTu8bqs7UQWKqkQtnhPafs/rAeKy
 5ew9IOXtGA39hy8h2gtip1IAKpvAvuTcGuvQ==
X-Gm-Gg: AYBFou2wErC8YKfj0D91rl61S9Rb75MI2yBQih+emKOSWWRcS7qkJqjwUjD4JXDTfUe
 kLZrkuDPCXZkpN2LTDsZt0jvccTg31wPHlzpiHmM9DeiIWrdeJzlKkDqcIQDX5GfJnuBejKzZvn
 IdwI8TUXzJMGC69BA2CaLobWvrzw7AfwrKMVBtxrUKyw6Qk0i704MQHGbt3FKZVMtYPFSrP73oo
 gGUe2CAYZZ5pxBvE5L4CWl4RQE9I7gPKOjS7Xgqa+G2ES4XISwHM/awVonDWhwVAfia3CHniP6Z
 6sxQvUf9Kb8rxLMo6in1tAaTUS1AYS1DTYvBv+fS59/1cDadbS6330Ki0bhs/43vUPpebj1j/T0
 zmsgpnQHSNhEgkpQMqGapoUMUc47uQInj1SYw3MG+oaw=
X-Received: by 2002:a05:600c:468b:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4bb7d6cc2f4mr103910345e9.4.1795081628591; 
 Thu, 19 Nov 2026 01:47:08 -0800 (PST)
X-Received: by 2002:a05:600c:468b:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4bb7d6cc2f4mr103909635e9.4.1795081627912; 
 Thu, 19 Nov 2026 01:47:07 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3c6sm8817597f8f.19.2026.11.19.01.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:07 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li RongQing <lirongqing@baidu.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 1/8] virtio: Reset free_head on shadow virtqueue start
Message-ID: <1d0777c4b64ed0a94e0fce8165d8e080753306fc.1795081539.git.mst@redhat.com>
References: <cover.1795081539.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Li RongQing <lirongqing@baidu.com>

free_head tracks the index of the next free descriptor in the SVQ
descriptor ring.  It is used by vhost_svq_vring_write_descs() to
choose where to place new descriptors, and is updated as descriptors
are allocated and recycled.

free_head is zero-initialized when the SVQ is created through
vhost_svq_new() (g_new0), but it is not reset in vhost_svq_start().
The start function already resets the rest of the ring state
(shadow_avail_idx, shadow_used_idx, last_used, last_used_idx and
num_free), yet free_head is left untouched.

Since an SVQ can be stopped and restarted on the same object, for
example across vDPA device migration or control virtqueue processing,
a stale free_head from the previous run survives into the new one.
This causes new descriptors to be written at the wrong position of
the SVQ descriptor ring, corrupting it.

Reset free_head to 0 in vhost_svq_start() so that descriptor
allocation always begins from the head of a fresh ring.

Fixes: 100890f7cad5 ("vhost: Shadow virtqueue buffers forwarding")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261104020053.2548-1-lirongqing@baidu.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index c97bd9f93f1..462c86dc1e2 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -857,6 +857,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->shadow_used_idx = 0;
     memset(&svq->batch_last, 0, sizeof(svq->batch_last));
     svq->last_used = 0;
+    svq->free_head = 0;
     svq->last_used_idx = 0;
     svq->vdev = vdev;
     svq->vq = vq;
-- 
MST


