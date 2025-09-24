Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4370CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jqm-0003fs-Kv; Wed, 24 Sep 2025 03:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v1JqU-0003Wi-LD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1v1JqA-0003vp-LY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758698578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rj3RQ4GXp5AjX5PkH/P7r4/EWTQrzqL0qIzlzX+1qL0=;
 b=Y+mJY5LEEjDY0bSJvnjD3UKNOXRN7Z6Lz+aMBHBQ7jQdJB54+L51UrTTdYUGIA3sWoTo8k
 Jl68J+jqum37UFhzSx7Ce2Wn30e1C4IgdPTFUInkQ348IDO5v3VFz/7npVTD9+2sfSD2XR
 yikAVSYc8dn3THNBUkjR8KNcrG5Y+Z8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-bgCGd124NM6_dEC5D2jEqg-1; Wed, 24 Sep 2025 03:22:57 -0400
X-MC-Unique: bgCGd124NM6_dEC5D2jEqg-1
X-Mimecast-MFC-AGG-ID: bgCGd124NM6_dEC5D2jEqg_1758698576
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46c84b3b27bso22127975e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 00:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758698575; x=1759303375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rj3RQ4GXp5AjX5PkH/P7r4/EWTQrzqL0qIzlzX+1qL0=;
 b=v4gwLmAWuDAzT8VVgNqPnaLLmsh4HmryBuBmveKcm/XqiNrmmFVb9bhqa28q66MJTT
 KaibKzpl4ZVFynGP/2IsaVFiqJPm8fsR8RoX8aXSMA06IM/LclqZWPITMqguhYBHM3ah
 uNx6gXhFsvN+aINkGZ5h8cyMxcU+ydwJkK/qTRLBezkLR1J9n1sbLCEcJAkNdcKMAq8c
 a3Y4M/ZqJRIxgiYwAMhvBLO6eoo5DAuLKZEuB7hm9e3/IS/MMhNr8z0GtXnjCjGQPUh2
 e0KKodgCLKB4z+ud4zNm54dPgLl1d0BPZYCnG8Ild+rMSvBPl1B5Xz9XWSK4DSP3JdRv
 0URw==
X-Gm-Message-State: AOJu0YxtFMZltZBcY/gLIBgyS2slsJFg1DQH+bO127+wADYpWJ3dQbFM
 VtJZy+jWtx8QLx2KbEz6GcNAGPOSJ9Q7UiVhR9YRl39E591NQ1PqwAMbZcm3PsHlKqjt18NOo+T
 k2k5BF2xEpz4JkBl7wb/VNgCdn+iy384d0gsc6eFFO232N54SZuTrk/IQ1ocBTHJ+
X-Gm-Gg: ASbGncsWzRLCt4MIJnKgNx2WdLxbwXi0x27groAgHeBVE38aNH7L4h/TITXC75B8lCl
 Wb7FrkS23nvw9Z4PEGWdASXKparb3TrJ2/QIEljg+v8+4yzEM6uUK5CIIySl+qSYDolyd46xtDV
 UZiAcQfnN5i5eaQQmOi9nBjBpLB653/lxk7D9RKnWF33ej9Kv+2U9fkXKVfa74LMiZ3fiXxC84U
 CAcWPtmYAB80/QAm0ESYcDaOdhxdlmzPKh7MMrwfOtFSTufR50drp/4Bvw81cDYSGzll2uC1Wlr
 DLhQEqMDQgGtnzLIkCUabXiN5odjBRUbpc3tkQjPUFY=
X-Received: by 2002:a05:600c:c04b:10b0:46e:1eaf:2564 with SMTP id
 5b1f17b1804b1-46e1eaf29femr34543285e9.29.1758698575290; 
 Wed, 24 Sep 2025 00:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGzJEWAI4D1F69jZufVQMJVr/24juD8nmCY08MX7KVV/ISHu4zCaYuSPhOjJQePyJez3MDnA==
X-Received: by 2002:a05:600c:c04b:10b0:46e:1eaf:2564 with SMTP id
 5b1f17b1804b1-46e1eaf29femr34543135e9.29.1758698574901; 
 Wed, 24 Sep 2025 00:22:54 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.110.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2aacfc3dsm19268265e9.16.2025.09.24.00.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 00:22:54 -0700 (PDT)
Date: Wed, 24 Sep 2025 09:22:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Li Zhaoxin <lizhaoxin04@baidu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Miao Kezhan <miaokezhan@baidu.com>
Subject: Re: [PATCH] vdpa-dev: add get_vhost() callback for vhost-vdpa device
Message-ID: <lh5yr3s3xej3mejfkoz5q6m5jf62b6ox2mvaspu5t3niuhv3qx@gdwzsqquroei>
References: <bf9c6885d0d425248a5765951a817ea518d92e8a.1758635007.git.lizhaoxin04@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bf9c6885d0d425248a5765951a817ea518d92e8a.1758635007.git.lizhaoxin04@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 23, 2025 at 09:51:10PM +0800, Li Zhaoxin wrote:
>Commit c255488d67 "virtio: add vhost support for virtio devices"
>added the get_vhost() function, but it did not include vhost-vdpa devices.
>Now we add it.

Again, could you please explain what problem you had and how this patch 
solves it?

This information must always be included in a commit message, so please 
pay attention to this.

Thanks,
Stefano

>
>Co-developed-by: Miao Kezhan <miaokezhan@baidu.com>
>Signed-off-by: Miao Kezhan <miaokezhan@baidu.com>
>Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
>---
> hw/virtio/vdpa-dev.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
>index d1da40afc8..4a7b970976 100644
>--- a/hw/virtio/vdpa-dev.c
>+++ b/hw/virtio/vdpa-dev.c
>@@ -338,6 +338,12 @@ static int vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
>     return 0;
> }
>
>+static struct vhost_dev *vhost_vdpa_device_get_vhost(VirtIODevice *vdev)
>+{
>+    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
>+    return &s->dev;
>+}
>+
> static const Property vhost_vdpa_device_properties[] = {
>     DEFINE_PROP_STRING("vhostdev", VhostVdpaDevice, vhostdev),
>     DEFINE_PROP_UINT16("queue-size", VhostVdpaDevice, queue_size, 0),
>@@ -369,6 +375,7 @@ static void vhost_vdpa_device_class_init(ObjectClass *klass, const void *data)
>     vdc->set_config = vhost_vdpa_device_set_config;
>     vdc->get_features = vhost_vdpa_device_get_features;
>     vdc->set_status = vhost_vdpa_device_set_status;
>+    vdc->get_vhost = vhost_vdpa_device_get_vhost;
> }
>
> static void vhost_vdpa_device_instance_init(Object *obj)
>-- 
>2.34.1
>


