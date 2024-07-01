Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C536C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 14:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOHjc-0006Ih-I4; Mon, 01 Jul 2024 10:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOHhR-0003R1-PA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOHhP-0001I1-Dt
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719842885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yy3BnolVG5ZiRy/QV4Ab4Xyy+6Xfr5pMoigAQgMUHhA=;
 b=PItH7mGMOCE1YkuLY5uABwhAeF5hn/RZR2TDk88KdTFfp4PQkGYLzNJ4b5jeLrEvGTlZxo
 truGO4WCvPYCXnA+O/IU/7K0hZ3ATg5fEIQ1jdNsgy/TlQULfz8mDxQFxL4PesddGSYOyQ
 eqAeIrn405hYXgTGs4WRrB76utuSIfw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-EOQBAjV4M8i3jHr807Md0w-1; Mon, 01 Jul 2024 10:08:00 -0400
X-MC-Unique: EOQBAjV4M8i3jHr807Md0w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ce7a15a62so3385866e87.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842879; x=1720447679;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yy3BnolVG5ZiRy/QV4Ab4Xyy+6Xfr5pMoigAQgMUHhA=;
 b=cKh9SvNq8minDZ4wOQWM+S4CIdTpcyGRdey1iCgyav5d2T1GXBDyvl6UVgV+Yu1KOW
 0B4VPfdh38DDNkTy1KO0p1EdVMOtagN3iWklUZivCnzvx76yS/lVMb2Bq6r/oeYbqUiW
 ACI8IxuZAx9nBAr8ZfJDEkys3l9m2ZaOE1s0mMUt2bqRyahzt3VQHw+lPSZaEU19LXgf
 kzQkUVrzv806GcYzKZn9xo0cBIJToTVib8WNsUwLwLu96E7GXmrYPPVzGWDD7b2RELCV
 JIHAWZLTZ0E6BHoFkypzH5idrYQlLlEDIxywLrcsLin0Ms7s/OPINBftvHVVch5QY7k5
 KKLA==
X-Gm-Message-State: AOJu0Yx8eSWfVHu6YwXO/mKiXqTkKEMaQ8IKURvvCVNilt4AP9Y1ZmsD
 4Gsjq/OSiadEcjIkTx6QBCDut8fQKQIiUNF9ErHZG/MQ9GzYYahelMXGUTCsKT4EyXaP3KwklHK
 ZZWvM9zFrsSMl1DgS4cmreOkRbN8VrZrdunaafRiQxBN8PlvHjTD8jtr1O2iYGzjcCTNs0wN0Tc
 4yMEVtEVu7+2Ct143CoPmkpXH6dOmCjZS+
X-Received: by 2002:a05:6512:398f:b0:52c:e4bf:d55d with SMTP id
 2adb3069b0e04-52e8264d9fdmr4841698e87.8.1719842878987; 
 Mon, 01 Jul 2024 07:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU2j1dIGG/7iNCkhQ42sWjEIBm2CpvkWBhvhVsChJ5szBI3xGfHqMQMlAqBkey6wNHKdDBYg==
X-Received: by 2002:a05:6512:398f:b0:52c:e4bf:d55d with SMTP id
 2adb3069b0e04-52e8264d9fdmr4841670e87.8.1719842878478; 
 Mon, 01 Jul 2024 07:07:58 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-66.web.vodafone.de.
 [109.43.177.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257dee5f2asm66630075e9.22.2024.07.01.07.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 07:07:58 -0700 (PDT)
Message-ID: <3f96e237-d367-4f8e-b96d-f51d4ba33ab1@redhat.com>
Date: Mon, 1 Jul 2024 16:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: Fix the de-initialization of vhost-user devices
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240618121958.88673-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240618121958.88673-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/06/2024 14.19, Thomas Huth wrote:
> The unrealize functions of the various vhost-user devices are
> calling the corresponding vhost_*_set_status() functions with a
> status of 0 to shut down the device correctly.
> 
> Now these vhost_*_set_status() functions all follow this scheme:
> 
>      bool should_start = virtio_device_should_start(vdev, status);
> 
>      if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>          return;
>      }
> 
>      if (should_start) {
>          /* ... do the initialization stuff ... */
>      } else {
>          /* ... do the cleanup stuff ... */
>      }
> 
> The problem here is virtio_device_should_start(vdev, 0) currently
> always returns "true" since it internally only looks at vdev->started
> instead of looking at the "status" parameter. Thus once the device
> got started once, virtio_device_should_start() always returns true
> and thus the vhost_*_set_status() functions return early, without
> ever doing any clean-up when being called with status == 0. This
> causes e.g. problems when trying to hot-plug and hot-unplug a vhost
> user devices multiple times since the de-initialization step is
> completely skipped during the unplug operation.
> 
> This bug has been introduced in commit 9f6bcfd99f ("hw/virtio: move
> vm_running check to virtio_device_started") which replaced
> 
>   should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
> 
> with
> 
>   should_start = virtio_device_started(vdev, status);
> 
> which later got replaced by virtio_device_should_start(). This blocked
> the possibility to set should_start to false in case the status flag
> VIRTIO_CONFIG_S_DRIVER_OK was not set.
> 
> Fix it by adjusting the virtio_device_should_start() function to
> only consider the status flag instead of vdev->started. Since this
> function is only used in the various vhost_*_set_status() functions
> for exactly the same purpose, it should be fine to fix it in this
> central place there without any risk to change the behavior of other
> code.
> 
> Fixes: 9f6bcfd99f ("hw/virtio: move vm_running check to virtio_device_started")
> Buglink: https://issues.redhat.com/browse/RHEL-40708
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/virtio/virtio.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..2eafad17b8 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -470,9 +470,9 @@ static inline bool virtio_device_started(VirtIODevice *vdev, uint8_t status)
>    * @vdev - the VirtIO device
>    * @status - the devices status bits
>    *
> - * This is similar to virtio_device_started() but also encapsulates a
> - * check on the VM status which would prevent a device starting
> - * anyway.
> + * This is similar to virtio_device_started() but ignores vdev->started
> + * and also encapsulates a check on the VM status which would prevent a
> + * device from starting anyway.
>    */
>   static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status)
>   {
> @@ -480,7 +480,7 @@ static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status
>           return false;
>       }
>   
> -    return virtio_device_started(vdev, status);
> +    return status & VIRTIO_CONFIG_S_DRIVER_OK;
>   }

Michael, any concerns or comments about this patch?

If not, I could also take it via my s390x tree since this fixes vhost-ccw 
devices on s390x.

  Thomas



