Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 10:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seBTi-0005Y3-Mt; Wed, 14 Aug 2024 06:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seBTh-0005VU-5z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seBTf-0007Rr-7W
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723632218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ktFmA/xyBBfMsQuAotq7uewnOjUBTVvJRe2OUkn8mVE=;
 b=a+Drzkk+xc710CuRB6gJPI3Z5/zieSU2R3F+7sLEbBsyLafl37LKV/XAx+HkXxUbVDyI+8
 AnSRSNTS7J+2ldRDTcdWJ9JBzt3Nsq71Y4r23S8a4UnitggQS1Mc4f3tIGlOECuhJhTxsy
 3fhEVObaDZdp+ot1bwFycny5r9NOTwM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-NCaOEYswM_afYBoP94ZjBQ-1; Wed, 14 Aug 2024 06:43:36 -0400
X-MC-Unique: NCaOEYswM_afYBoP94ZjBQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42816aacabcso47490615e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 03:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723632215; x=1724237015;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktFmA/xyBBfMsQuAotq7uewnOjUBTVvJRe2OUkn8mVE=;
 b=Ly832TF4V/3JmZjm3Qj0n0WREWixMWcPHyFWC/oFl7698LO5P5M7+49cro9sXtS3ss
 Ia10kwBnRH3z/RIJu3og2MYPi0N3PFd98vQULYLWotO3u735MEEs8h2Bp0tkcrxa860C
 lJLlo5catipOpIkxzsFtEb9C/PpT7L7K8D5RWVm3C6uoOXjMQiUplG+3pmY5i2K6lNFI
 GsuyCc45kWfjQPEvqQA4azGY+LbjhrnW6njgIGSE2kTMbwpal7yI9mUyZSRgplNTGZAc
 b/qZ8tT9epSYN3ebtWCSqCYhZxo1ICTPu3MgTfdB5sTigKg+KKnDi/GG2loIrK7JxDrl
 GX2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY2IVGzJHAOkv9iJhP2Ryy5nz+U9R+u2fs930xKdhL4seZkobZnROfgptxn9wKy0AphTVgtLsLaFhO/Wys8PyA3lVHLZY=
X-Gm-Message-State: AOJu0YyIAevau+da+SJUrhOlaYpWCdGyiqFrnMzIZou0pLy+AR4Dpj5t
 CnHKno5SvWQUYUklKInW+ieRyrCpIzTiy2U5v2InQAicUJYDC3PtvzJC4YZxH5BL17EthHEntZd
 iWViIPnGqwWN/PyF7kKFEtw6bVHWUoW3mnfMFCKoMekvofLLeFoDN
X-Received: by 2002:a05:600c:3c97:b0:429:a0d:b710 with SMTP id
 5b1f17b1804b1-429dd23b17cmr14589195e9.12.1723632214960; 
 Wed, 14 Aug 2024 03:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe5GTZxN1R1xJMPGDhH94xdnvB1qzxHJPUgaZmrGpZHwBWDlL8pPILJ+4sQANx3HwtR0NXLQ==
X-Received: by 2002:a05:600c:3c97:b0:429:a0d:b710 with SMTP id
 5b1f17b1804b1-429dd23b17cmr14588985e9.12.1723632214410; 
 Wed, 14 Aug 2024 03:43:34 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-179-177.web.vodafone.de.
 [109.43.179.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3717314e38bsm3699222f8f.97.2024.08.14.03.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 03:43:33 -0700 (PDT)
Message-ID: <6de48b8d-207a-47d3-8eb3-523fc5f9e0ea@redhat.com>
Date: Wed, 14 Aug 2024 12:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 01/10] hw/s390/virtio-ccw: Convert to three-phase
 reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-2-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240813165250.2717650-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/08/2024 18.52, Peter Maydell wrote:
> Convert the virtio-ccw code to three-phase reset.  This allows us to
> remove a call to device_class_set_parent_reset(), replacing it with
> the three-phase equivalent resettable_class_set_parent_phases().
> Removing all the device_class_set_parent_reset() uses will allow us
> to remove some of the glue code that interworks between three-phase
> and legacy reset.
> 
> This is a simple conversion, with no behavioural changes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> It looks a little odd that we do the this-class reset first
> and then chain up to the parent's reset, but that's what the
> existing code does, so I left it alone.
> ---
>   hw/s390x/virtio-ccw.h |  2 +-
>   hw/s390x/virtio-ccw.c | 13 ++++++++-----
>   2 files changed, 9 insertions(+), 6 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>


> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
> index fac186c8f64..c7a830a1944 100644
> --- a/hw/s390x/virtio-ccw.h
> +++ b/hw/s390x/virtio-ccw.h
> @@ -57,7 +57,7 @@ struct VirtIOCCWDeviceClass {
>       CCWDeviceClass parent_class;
>       void (*realize)(VirtioCcwDevice *dev, Error **errp);
>       void (*unrealize)(VirtioCcwDevice *dev);
> -    void (*parent_reset)(DeviceState *dev);
> +    ResettablePhases parent_phases;
>   };
>   
>   /* Performance improves when virtqueue kick processing is decoupled from the
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index b4676909dd6..96747318d2a 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -913,14 +913,15 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
>       }
>   }
>   
> -static void virtio_ccw_reset(DeviceState *d)
> +static void virtio_ccw_reset_hold(Object *obj, ResetType type)
>   {
> -    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> +    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(obj);
>       VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>   
>       virtio_ccw_reset_virtio(dev);
> -    if (vdc->parent_reset) {
> -        vdc->parent_reset(d);
> +
> +    if (vdc->parent_phases.hold) {
> +        vdc->parent_phases.hold(obj, type);
>       }
>   }
>   
> @@ -1233,11 +1234,13 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       CCWDeviceClass *k = CCW_DEVICE_CLASS(dc);
>       VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
>       k->unplug = virtio_ccw_busdev_unplug;
>       dc->realize = virtio_ccw_busdev_realize;
>       dc->unrealize = virtio_ccw_busdev_unrealize;
> -    device_class_set_parent_reset(dc, virtio_ccw_reset, &vdc->parent_reset);
> +    resettable_class_set_parent_phases(rc, NULL, virtio_ccw_reset_hold, NULL,
> +                                       &vdc->parent_phases);
>   }
>   
>   static const TypeInfo virtio_ccw_device_info = {


