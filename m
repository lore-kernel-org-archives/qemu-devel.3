Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AFCC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZU-0004S8-88; Tue, 12 Mar 2024 18:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZI-0004Pz-A0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZE-0004DS-QC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN4YswExUhrgK7Cwoxr2sBU+v3bHPhBMUx7Ts5pHAAo=;
 b=fUifkuJlyztYJSDNwpLeqFf2cnsh2OFRyNDDWo/Hiz1BtwPFdSokJ/ImbJUDLA6aV1FEi7
 s32wOJS1nxgDTKCNKDyF7aVX7D8A0WPN+lZ4yCBFEwdsatCVxlTUKPWyWNacQ6xEiPnAh6
 NmLYSsxAGT+Wx2tc/dEIMbiEV7jW95c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-raDGrAxFOuiJmC4SoNYpeg-1; Tue, 12 Mar 2024 18:25:50 -0400
X-MC-Unique: raDGrAxFOuiJmC4SoNYpeg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3fb52f121eso28236766b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282348; x=1710887148;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eN4YswExUhrgK7Cwoxr2sBU+v3bHPhBMUx7Ts5pHAAo=;
 b=t/QBMlDYjqLf4GXzVcUuVTJn9+mWO0aaFOtFwvpix9fevVDXZmaXapMzKZGQPKPlVk
 x3GYBDB7jJ0llovTpo1jIU1mmefbpESo8AmEkqIVqDOVBXjfHk1ZY2X8Gp2diVtiQs1h
 QwsktVCeHtYIr+/rK8gKr9dyfcj4sPj4v4cWrOS+v/WXOys0BzIF5R6gVYe/GEBlGK+i
 FGb0xSSfiMEnOA3CJR/QQEywyheet5PADy3N7Yj33hICSD9KSzOjP6MAC3Vj/2zpsj08
 0YTac5YlVmqyoR6zJRwkOrdzhjhnSVLH2T+DJPmvPPk7LBSIDcLBsjYU7KvQSvd6d6WO
 b50A==
X-Gm-Message-State: AOJu0YzIyjWrok8eRn/rDLJUNUNABmMTq09hmkGwoZhDjlPw9J2lq1a9
 boO8dzCLzrsjXXVY+u6JeFacsolh8UuVtI38JxSuQbLGNftpSKwmSu0r0Q7DsL04Cnlau4UUT7g
 n3HsdEBnxLvKvCtuiTsLWGwfjHdd0ud/l5MTgUA2lkJ56jpnlGRSeiJvozWeJ3i2C2xjEvrjGZK
 UVnVq+bMFjYY9y88Rjh/XQvkjnX6VjsqRW
X-Received: by 2002:a17:906:408e:b0:a46:28c2:49b2 with SMTP id
 u14-20020a170906408e00b00a4628c249b2mr3350514ejj.24.1710282348070; 
 Tue, 12 Mar 2024 15:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0+Vp8iKRH1juUxUdy8yXrVoSqXyA6MXfDW7JoolubekoJ98wAyS09nR8Rlj8QEdKQtUjEnw==
X-Received: by 2002:a17:906:408e:b0:a46:28c2:49b2 with SMTP id
 u14-20020a170906408e00b00a4628c249b2mr3350499ejj.24.1710282347659; 
 Tue, 12 Mar 2024 15:25:47 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 jx24-20020a170907761800b00a45fefe57d5sm4190850ejc.96.2024.03.12.15.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:47 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/68] vdpa: add vhost_vdpa_get_vring_base trace for svq mode
Message-ID: <6ec0a7467828f228e00ec83978fb5267f81079e0.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

For better debuggability and observability.

Message-Id: <1707910082-10243-7-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 3 ++-
 hw/virtio/trace-events | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 8bd62e8dd2..c7271093dd 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1412,6 +1412,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
 
     if (v->shadow_vqs_enabled) {
         ring->num = virtio_queue_get_last_avail_idx(dev->vdev, ring->index);
+        trace_vhost_vdpa_get_vring_base(dev, ring->index, ring->num, true);
         return 0;
     }
 
@@ -1424,7 +1425,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
     }
 
     ret = vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
-    trace_vhost_vdpa_get_vring_base(dev, ring->index, ring->num);
+    trace_vhost_vdpa_get_vring_base(dev, ring->index, ring->num, false);
     return ret;
 }
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 77905d1994..28d6d78380 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -58,7 +58,7 @@ vhost_vdpa_set_log_base(void *dev, uint64_t base, unsigned long long size, int r
 vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int flags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t avail_user_addr, uint64_t log_guest_addr) "dev: %p index: %u flags: 0x%x desc_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" log_guest_addr: 0x%"PRIx64
 vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
 vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
-vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
+vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int num, bool svq) "dev: %p index: %u num: %u svq: %d"
 vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
 vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
 vhost_vdpa_get_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRIx64
-- 
MST


