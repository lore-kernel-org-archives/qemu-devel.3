Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF82C7113E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 06:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPbGz-0005VG-Il; Thu, 12 Jun 2025 02:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPbGw-0005Td-UM
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPbGv-0005wc-Ci
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749709123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FMsOsNV1X5Cn33hKgN7nVpXDIvGIDnQPSSDh2421dck=;
 b=MCpdn1YUxaAVJUqSLGMYSIUo9O3zx86pDqzt12ErKXmHGYQ1TYKCWP9Moyuzi46SMoCLQl
 X7Kaoj0Uqg1S9j11i3ui7y2L435jv7p5rbaKQSAwbTAdE7eTLfZ64odHwk3E+pvdBrBiIH
 SmdfsDsEfvXO+6DZGoCI5joroTS4ueI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-41KtuPTSMYib3bptv1fJVA-1; Thu, 12 Jun 2025 02:18:41 -0400
X-MC-Unique: 41KtuPTSMYib3bptv1fJVA-1
X-Mimecast-MFC-AGG-ID: 41KtuPTSMYib3bptv1fJVA_1749709120
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so2602955e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 23:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749709120; x=1750313920;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMsOsNV1X5Cn33hKgN7nVpXDIvGIDnQPSSDh2421dck=;
 b=bBIGMPrvnYCvHIhwv+3/fU1w6TwafLCDtr7wOPzojnCowwVq+bNqy67wYM1YcoR0Tp
 /mLCcP2xCAziZRagupN2MP7YpBl2BtOVIDGASsxolEM01onyKdhbXsYEyPRkPHCABsV7
 rhJzEmLfcp71DKxN7CR1x8PVzzfdK6HAOxtAKwCz5ubuPIbJfBoLifNu63mRnU8x10Np
 WAd3KuxuA8MlzU5vQDTRZTHVnFvVwH2m6p5jeMGvloxqCY5kPF74BS2SKTAoshT/y4MB
 FbbGfhRrtJsfvRQ/Lr6n4hgn5dGKF1e5LYmz1kFn8R/YqD2q85v+ZoLNegrORayuzoT3
 HbIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUCWVwe9TRpS6+s5z00n6gT4Ky8W9IK4RHtpEeAqgQkAREvA6m6jzmoAzlBFktjzo+P+E5bx6kYLC8@nongnu.org
X-Gm-Message-State: AOJu0Yx7ClKVLUZQtSet9wlE8kkgw5s/n2zuvgSmUE5kQDYbcn7ft3ZH
 g+Yan7utoJNla9mumTWuZ1Lw8D2jkrCGOkXAbXJPpjFBi80z6H5Gy+bdZ9R2UinIoJramb6Pqp5
 PPNtCcMsZfboB3/mwoo2HFxYuI18MCxc1cVZ19PacBDvhOIEbmXuAyIvf
X-Gm-Gg: ASbGncuiNIfh7s0f6MZm6rajTbX4hQPxuCjo0/pgVLqlgF+NJcLRPYBpK8OGQVcGZWK
 QrwzGfN8rVrTcZsiTy2Yhe/huAQicGbXuxj+M7Ck+2tLVUiSPKrXBl8Givii4Ne4Ie83Tjk/5XR
 snbXMPPpL80eKMSe2yZbzPfGjOTmROeN8ily6PJiBRkKJXuop+hLbCNqFqGLkv0eEL1bby/7nC+
 rmltbe5OGMQeHuwZe7eJ5oTKycDYSGd4aGGrwPCxMXLNTjdcM7aQeibP/kpsI3M5YXD2ZZrwFZL
 KQTs7r6ARYN99M2jcRYq3aFsBZSApvx/aM9MWSh1lNcwID+Vo/i5+r72RzuF
X-Received: by 2002:a05:600c:8587:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-453249d2072mr40916445e9.3.1749709120389; 
 Wed, 11 Jun 2025 23:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgWpjKsQFGOeG6t60KZ0Pqnfov5Ibc3yy49bbZFppZ90kumSHdRKeb+qgTtERvvdg7Bxs9Iw==
X-Received: by 2002:a05:600c:8587:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-453249d2072mr40916175e9.3.1749709119962; 
 Wed, 11 Jun 2025 23:18:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc8bsm10100095e9.28.2025.06.11.23.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 23:18:39 -0700 (PDT)
Message-ID: <7db34f93-e373-4a27-a0e9-e76d6fe5e032@redhat.com>
Date: Thu, 12 Jun 2025 08:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] hw/vfio/ap: attribute constructor for
 cfg_chg_events_lock
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250611211252.82107-1-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250611211252.82107-1-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/11/25 23:12, Rorie Reyes wrote:
> Created an attribute constructor for cfg_chg_events_lock for locking
> mechanism when storing event information for an AP configuration change
> event
> 
> Fixes: fd03360215 ("Storing event information for an AP configuration change event")
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 874e0d1eaf..1df4438149 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -52,6 +52,11 @@ static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>   
>   static QemuMutex cfg_chg_events_lock;
>   
> +static void __attribute__((constructor)) vfio_ap_global_init(void)
> +{
> +    qemu_mutex_init(&cfg_chg_events_lock);
> +}
> +
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>   
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> @@ -230,13 +235,6 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
>   
> -    static bool lock_initialized;
> -
> -    if (!lock_initialized) {
> -        qemu_mutex_init(&cfg_chg_events_lock);
> -        lock_initialized = true;
> -    }
> -
>       if (!vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Applied to vfio-next.

Thanks,

C.


