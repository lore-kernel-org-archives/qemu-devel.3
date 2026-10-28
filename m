Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6243606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjT9tBG6;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uJzEtVLi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Ia-0007Ny-HF; Wed, 28 Oct 2026 13:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fz-00081P-Jz
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fw-0003qv-Cn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBWKgfobmEcqgD+9yoV91HmhMCEslSgbSj5OOY42Dm4=;
 b=cjT9tBG6KF1Fx589kYUivyQ5XHE/uT3E4tKYfqlsiOKFeFI6xUpwV3LsKEHSqvnxDuYbmR
 hTV34R9Btu8fzSWNgCkq1N7cmKTEva46WvbIIsGrkt3fgoK71U8SB8+VfBf24twWCi3h91
 nhrDlYYonB4YSlGVkWt+WCrR0nF+hYg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-7e_3Mt2dPMSDNCHcKhSd8A-1; Wed, 28 Oct 2026 13:16:00 -0400
X-MC-Unique: 7e_3Mt2dPMSDNCHcKhSd8A-1
X-Mimecast-MFC-AGG-ID: 7e_3Mt2dPMSDNCHcKhSd8A_1793207759
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6b3f6d9827eso1105391a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207759; x=1793812559; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xBWKgfobmEcqgD+9yoV91HmhMCEslSgbSj5OOY42Dm4=;
 b=uJzEtVLiqXqP/nXllpJQSWPSAjvEgkLWPZ2FUqnLhnFbyRE+xXWfwGmgvS3kLaCavp
 ACoav2qcwdf+J3HYwc0cMh0dOUzZl9coYDIqUweiMBYApAI848KXDe+PeiwzWRnMNJbs
 wVGWJ1v9xJkP1N2Eb8eqIvIUtcsb9egWX9zDol88dlvZktDpUnVXv43M8181+G7Z40/P
 ckuGHRrKSeBOtwhJf7kNhaKHFRPQr+MtqyWt1FN/WYDvhKzu0bKVwR/6Ql+5NMGD0wIE
 +q22nAd9+oFG4WwcNQeeA+uGVb9wNQVdjNjKxsXfkD7tX0aopEKPmbjNJSU7jskNZbkz
 hRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207759; x=1793812559;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xBWKgfobmEcqgD+9yoV91HmhMCEslSgbSj5OOY42Dm4=;
 b=U46R12U1bD3UaFoe/SPKHiUycfCMkMO0zZPPTToEivOfpW3Hcg6MqLtfAsAnC7JUwr
 4DTzvn4VD7WYB6BF9DzbfbYuBGYcRJl1JEujwyUemU2jVjPG31lFPdRZZZrzhK2zFnIw
 cadUkNsXZiKIpZEcsGlrh5n1dPb3tnDvzmlRM09FFHJjhi6DgXghIuZtt12UbLTJgH/7
 RD3/nJTKlWkhLxjj4+NT5+OqtxpE2MLhJ133VtXPMcjsrPi2rtm2KiyTv923TqB2Xs4E
 MdBdO+/DNC2NzQxwT2PDF61dG5e1j3B7HCjtBaIWXG7KNKrLx0WeBiF8XcitV/2tBPK0
 +j/g==
X-Gm-Message-State: AFq9FYKlsD0iE5UIX5fNSipGNN0xXFbRu1gnYfSsTmlbXT3lPsezS5tB
 em4bMQ5TJXLuoxC5UTE7gLp99RxwQQ9XdDiOpS66ltAhM32OsFBi/TIF+xv0jSoxEQA6/4x3jVd
 j1ntQAj/bR8eegX2YwP/vtzGkHC1T00pu98n35szSSiyX3D48Z6Yzlu5MtDFJVn76Ccm1APL76d
 mTVZEk/d89zX44z44mV5BSOUZHNyQYgbOb6g==
X-Gm-Gg: AYBFou0KaHynUsWYpDtPZk4GnNBWLzfzVGk6pCdIj4u5g7O1uQHhkXn2MQTsMLUiVCj
 pDXJ8IOSocMaOh8gwCSC5kzEzGfdwt+w6o6oaCDicD+/OrbyJFnzCTcT1KjOvjaD8x5Spi3gu8j
 8pI97VvfPXjhxKqZrG41MVhAbV9rDCxdF/dV6QZNT4mWMcACWolRgOakHSnvDE6keTEmPCxfnIZ
 Wc01lJEimwkwv0l5ofTVAt84gRtlRiGv1xt1A1cHudASduW/a0q4yhSmO1udIr/nQLy7aN4cRzI
 +5UnFQdeRuVPRQ6ZhfUwXy5YRgF7pzpdJ+xsL5FObQG3CmM7IBfjBaIV5l4LG9VhMoL6LFf9P7c
 rDZn9GGwYJh6wXZlCC6VDMRR4HNIM9qtViF2kzgFG
X-Received: by 2002:a05:6402:2353:b0:6b4:5fe3:11a2 with SMTP id
 4fb4d7f45d1cf-6b49caba2fbmr2228366a12.0.1793207758869; 
 Wed, 28 Oct 2026 10:15:58 -0700 (PDT)
X-Received: by 2002:a05:6402:2353:b0:6b4:5fe3:11a2 with SMTP id
 4fb4d7f45d1cf-6b49caba2fbmr2228319a12.0.1793207758089; 
 Wed, 28 Oct 2026 10:15:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece14a1sm30736345f8f.57.2026.10.28.10.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:57 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhaoxin <lizhaoxin04@baidu.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 45/78] vdpa-dev: implement guest_notifier_mask/pending
Message-ID: <3cacd08dccf2cdefb23cb75b182fa653bcd66323.1793207602.git.mst@redhat.com>
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

From: Li Zhaoxin <lizhaoxin04@baidu.com>

Forward guest notifier masking to the vhost layer via
VHOST_SET_VRING_CALL, so the KVM irqfd stays installed across
MSI-X mask/unmask cycles instead of being torn down and re-added
each time.

Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260909155042.34186-1-lizhaoxin04@baidu.com>
---
 hw/virtio/vdpa-dev.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 7e5cc040e9..cd7ce2e381 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -267,11 +267,7 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
     }
     s->started = true;
 
-    /*
-     * guest_notifier_mask/pending not used yet, so just unmask
-     * everything here. virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
+    /* Point every vring call fd at its guest notifier. */
     for (i = 0; i < s->dev.nvqs; i++) {
         vhost_virtqueue_mask(&s->dev, vdev, i, false);
     }
@@ -285,6 +281,28 @@ err_host_notifiers:
     return ret;
 }
 
+static void vhost_vdpa_device_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                                   bool mask)
+{
+    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return;
+    }
+    vhost_virtqueue_mask(&s->dev, vdev, idx, mask);
+}
+
+static bool vhost_vdpa_device_guest_notifier_pending(VirtIODevice *vdev,
+                                                    int idx)
+{
+    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return false;
+    }
+    return vhost_virtqueue_pending(&s->dev, idx);
+}
+
 static void vhost_vdpa_device_stop(VirtIODevice *vdev)
 {
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
@@ -376,6 +394,8 @@ static void vhost_vdpa_device_class_init(ObjectClass *klass, const void *data)
     vdc->get_features = vhost_vdpa_device_get_features;
     vdc->set_status = vhost_vdpa_device_set_status;
     vdc->get_vhost = vhost_vdpa_device_get_vhost;
+    vdc->guest_notifier_mask = vhost_vdpa_device_guest_notifier_mask;
+    vdc->guest_notifier_pending = vhost_vdpa_device_guest_notifier_pending;
 }
 
 static void vhost_vdpa_device_instance_init(Object *obj)
-- 
MST


