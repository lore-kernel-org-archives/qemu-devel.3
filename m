Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B905AC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twil1-0002XC-Og; Mon, 24 Mar 2025 10:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1twika-0002VJ-Ar
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1twikW-0007tC-0F
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742826354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=294Nf+Tp26IjS90P1CkM2MLZKiUd4XIqznZsd+lJmTY=;
 b=SkYOmKMiedbYg/o82iuGgOhEBeHZxvCynZdHUeC9r94o35lzWfEuPobomYylMS36+euKoG
 e1qqgp79gJ4BfeAq/zIg2X2jfvu1hsj5FAfaqLctpmjmKJPb220iS8AzJ927zT0R9vOosk
 ZStHwbVYabtXFu53mZnequ7rIHKB1aQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-WaTctKkrNUGrxzfILx8Wjw-1; Mon, 24 Mar 2025 10:25:53 -0400
X-MC-Unique: WaTctKkrNUGrxzfILx8Wjw-1
X-Mimecast-MFC-AGG-ID: WaTctKkrNUGrxzfILx8Wjw_1742826352
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-391425471ddso2639379f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742826352; x=1743431152;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=294Nf+Tp26IjS90P1CkM2MLZKiUd4XIqznZsd+lJmTY=;
 b=HcJ4piD7GY7Oq2n8yTYXeHKU7XN4D+9TJAS6jzlrYsaIWndrQcca/0DtyhoV0ba0so
 tbTbCQ59sO73TiKZdEllhJBKciBpeKiNDsUkIiXAIZ4gxwbGfnyscrRCC/MrhTR3tbfL
 Qz89pTn/pPMQKwp4H52PZxIwHPJa+3ugXZ5laCq82nSwJ6+JNRJSvle6NHl/X6QolNpS
 b4ftziGamcSEckGWzkZjLVlV7BnolpTa9/v/YuTMPat/IlI9vcxyuT9E+lqrYCecS6AO
 tYmvW6hFtbcTN0uRRIkZtvVPtpTZEsx7dHpl/oP7VF/T5VY3MMIgvkOAU4q7/uFrSm6O
 3Srg==
X-Gm-Message-State: AOJu0Yzd4J5XaucOgn+rNOu8J1w4zxeOVlLFW5PwGQGMLjbrneWWkKB/
 gdbCLnal2xg5GmrpSF9COVz+BI4R5HEchy2aClArOL3ALXUBmBmOKHGOuXDVUXCs43ICIJ+8O4d
 9mZ+48u7FdKmAmu9UCY9y8cewlPlTGb4EZyB/B+BFwW90KSNT6IZJ
X-Gm-Gg: ASbGncuyno66AAbRUZDMXYw9gcjlAES73Xv7X9jyQrNIWM61GgKY0nixJuY8nxgexeM
 4yDB1uTQnP6xcAlLx86AhPbtfTiz7aG6Rxh1iJ6AVs2ibclzcEOegvHTxaaZWPrBosaxf7NJK5Q
 Iz1mDxG6B2JgNFnefmenbMtL/N1cq3Dt306y5vrt+7uz5KRXGyIZtTSK4L92EnsLzFy++j1iGWl
 PMO8TUGOZKEt/t3FWMdyMZ4lAQ0n8cJ63dnMujVcGgPKa0Csyc1NuE3ylO/y5UphMN7Qmyehdw1
 rkCvqHnkuG48BZeN6Q/n2qXkjRtDIdIlkBc0yUiBd5bId0ypUeR6pYvNeMi0nqr2
X-Received: by 2002:a05:6000:1faf:b0:38f:577f:2f6d with SMTP id
 ffacd0b85a97d-3997f8f8bf3mr11522824f8f.2.1742826351918; 
 Mon, 24 Mar 2025 07:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOELz1LcsJY29iu2J3pEz4BiS0dbwQm82//LKleV7MVI89EpXkkTlhbD5NgNGZ9UyQqC/NYw==
X-Received: by 2002:a05:6000:1faf:b0:38f:577f:2f6d with SMTP id
 ffacd0b85a97d-3997f8f8bf3mr11522782f8f.2.1742826351299; 
 Mon, 24 Mar 2025 07:25:51 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it.
 [87.12.25.55]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3b83sm11310819f8f.33.2025.03.24.07.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:25:50 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:25:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, Li Feng <fengli@smartx.com>, yuhua@smartx.com, 
 Raphael Norwitz <raphael@enfabrica.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/3] vhost: return failure if stop virtqueue failed in
 vhost_dev_stop
Message-ID: <y57skxgavl6g2j6syekaefkgyyfwodj2u7execoo4meky6k2x2@u4gmzfu4cth2>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-3-haoqian.he@smartx.com>
 <ho2s47wmeqgeh6otsx4ttqdy3zudgehkokth2ccubsoywzvqhp@mv45e5do5rj7>
 <780BAD55-0C1E-4DE6-92F8-C6203F6CC350@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <780BAD55-0C1E-4DE6-92F8-C6203F6CC350@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 20, 2025 at 08:21:25PM +0800, Haoqian He wrote:
>
>> 2025年3月19日 23:11，Stefano Garzarella <sgarzare@redhat.com> 写道：
>>
>> On Fri, Mar 14, 2025 at 06:15:33AM -0400, Haoqian He wrote:
>>> The backend maybe crash when vhost_dev_stop and GET_VRING_BASE
>>> would fail, we can return failure to indicate the connection
>>> with the backend is broken.
>>>
>>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>>> ---
>>> hw/virtio/vhost.c         | 27 +++++++++++++++------------
>>> include/hw/virtio/vhost.h |  8 +++++---
>>> 2 files changed, 20 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 6aa72fd434..c82bbbe4cc 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -1368,23 +1368,23 @@ fail_alloc_desc:
>>>    return r;
>>> }
>>>
>>> -void vhost_virtqueue_stop(struct vhost_dev *dev,
>>> -                          struct VirtIODevice *vdev,
>>> -                          struct vhost_virtqueue *vq,
>>> -                          unsigned idx)
>>> +int vhost_virtqueue_stop(struct vhost_dev *dev,
>>> +                         struct VirtIODevice *vdev,
>>> +                         struct vhost_virtqueue *vq,
>>> +                         unsigned idx)
>>> {
>>>    int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
>>>    struct vhost_vring_state state = {
>>>        .index = vhost_vq_index,
>>>    };
>>> -    int r;
>>> +    int r = 0;
>>>
>>>    if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
>>>        /* Don't stop the virtqueue which might have not been started */
>>> -        return;
>>> +        return 0;
>>>    }
>>>
>>> -    r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>>> +    r |= dev->vhost_ops->vhost_get_vring_base(dev, &state);
>>
>> We can avoid this and also initialize r to 0.
>
>Here we need to do `vhost_virtqueue_stop` for each vq.

Sorry, my question is what's the point of initializing r to 0 and then 
putting it in or here with the result of vhost_get_vring_base?
Can't we leave it as before and initialize it directly here?

>
>>
>>>    if (r < 0) {
>>>        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
>>>        /* Connection to the backend is broken, so let's sync internal
>>> @@ -1412,6 +1412,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
>>>                       0, virtio_queue_get_avail_size(vdev, idx));
>>>    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
>>>                       0, virtio_queue_get_desc_size(vdev, idx));
>>> +    return r;
>>> }
>>>
>>> static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
>>> @@ -2136,9 +2137,10 @@ fail_features:
>>> }
>>>
>>> /* Host notifiers must be enabled at this point. */
>>> -void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>>> +int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>>> {
>>>    int i;
>>> +    int rc = 0;
>>>
>>>    /* should only be called after backend is connected */
>>>    assert(hdev->vhost_ops);
>>> @@ -2157,10 +2159,10 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>>>        vhost_dev_set_vring_enable(hdev, false);
>>>    }
>>>    for (i = 0; i < hdev->nvqs; ++i) {
>>> -        vhost_virtqueue_stop(hdev,
>>> -                             vdev,
>>> -                             hdev->vqs + i,
>>> -                             hdev->vq_index + i);
>>> +        rc |= vhost_virtqueue_stop(hdev,
>>> +                                   vdev,
>>> +                                   hdev->vqs + i,
>>> +                                   hdev->vq_index + i);
>>
>> Also other function can fails, should we consider also them?
>> (e.g. 	, vhost_dev_set_vring_enable, etc.)
>>
>> If not, why?
>
>Since we only want to know the return value of callback when the 
>stopping device
>live migration, there is no need to catch the failure of `vhost_dev_start`.

Please add that in the commit message, and maybe also in a comment here.

>
>We can also catch the failure of `vhost_dev_set_vring_enable`, because
>`vhost_dev_set_vring_enable` will also fail if qemu lost connection with the
>the backend, but I need to test it.
>

Capturing failures of only some things is a little confusing to me, I 
think it needs to be better explained.

Thanks,
Stefano

>
>>
>>>    }
>>>    if (hdev->vhost_ops->vhost_reset_status) {
>>>        hdev->vhost_ops->vhost_reset_status(hdev);
>>> @@ -2177,6 +2179,7 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>>>    hdev->started = false;
>>>    vdev->vhost_started = false;
>>>    hdev->vdev = NULL;
>>> +    return rc;
>>> }
>>>
>>> int vhost_net_set_backend(struct vhost_dev *hdev,
>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>>> index a9469d50bc..fd96ec9c39 100644
>>> --- a/include/hw/virtio/vhost.h
>>> +++ b/include/hw/virtio/vhost.h
>>> @@ -232,8 +232,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
>>> * Stop the vhost device. After the device is stopped the notifiers
>>> * can be disabled (@vhost_dev_disable_notifiers) and the device can
>>> * be torn down (@vhost_dev_cleanup).
>>> + *
>>> + * Return: 0 on success, != 0 on error when stopping dev.
>>> */
>>> -void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
>>> +int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
>>>
>>> /**
>>> * DOC: vhost device configuration handling
>>> @@ -333,8 +335,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
>>>
>>> int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
>>>                          struct vhost_virtqueue *vq, unsigned idx);
>>> -void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
>>> -                          struct vhost_virtqueue *vq, unsigned idx);
>>> +int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
>>> +                         struct vhost_virtqueue *vq, unsigned idx);
>>>
>>> void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
>>> void vhost_dev_free_inflight(struct vhost_inflight *inflight);
>>> --
>>> 2.48.1
>
>


