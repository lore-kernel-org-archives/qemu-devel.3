Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F146C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKjT-0007fp-2T; Wed, 11 Jun 2025 08:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPKjQ-0007aA-Lt
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPKjG-0001dG-JC
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749645530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AzX4/aL6j/pTkekjiNlSBQ84LNAuMaTtNREsBrZSV3Y=;
 b=FLIQrkERg18r+HGRDC/Rfs4gV6AwSrcgR12fcmVUIv6kiFTHroPfVl1Pl39d/bwrF9teG9
 pAcv2eti+vPA/M80Z4WcNdAUQ3wSgU1IfuwzDu6S8gi5+iM6/+cCG0ihv10Zp9GMOg3JZa
 OWH/A2UoArV7M3q6bEeDgudbbm7nMtA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-s8bzR4eTNteIWl-8QINTig-1; Wed, 11 Jun 2025 08:38:48 -0400
X-MC-Unique: s8bzR4eTNteIWl-8QINTig-1
X-Mimecast-MFC-AGG-ID: s8bzR4eTNteIWl-8QINTig_1749645527
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso3671907f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 05:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749645527; x=1750250327;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzX4/aL6j/pTkekjiNlSBQ84LNAuMaTtNREsBrZSV3Y=;
 b=sSZzCzw0sumOrnsnRbU4fijIJwvpxngWgvBFSpIiGBpgz4tnNr1tSroPYSzirpmubl
 gNaA93Nx3tjNsbatu9xmFtdiCQMR05q6evmsKlb2CEMyz7rGWpSs+MRl6EF5HaSt0fTW
 WTcYkr3Lx/SzWEoEwwlfxG4zJMLK02iu/nOdOK1yetfyvmQWwmuLfe7lVpIQ9IiWkq+6
 GJ295/cyG7m6C+WcmhG/+sVokQGtX7fwui5d+BpZjTATkc1eEhtoyOU45DvDi5/yvrk8
 89z7k6NK8LjSKWTm5VywI8BzuRQOBKunxdMCBiRLFsl8JgWHH8KavwHWrWZe0figyIWA
 snFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfRoqW8KoeWB/xPg2ZWNlCxLr1/+hChjCAk4ftB6n5NPuu8mkheGbCJbvoNn5fpIvF1ZNXwDDYtwdq@nongnu.org
X-Gm-Message-State: AOJu0YyCNuHXM7eSpySkyYs0oflvznW4tUGDpCcaP4nEOy9CuOPkTZ19
 v8pPpeyeMVWIXwT2mv834wJVpIEf5276xLqu4BYAu/E9O7M9PIeaG5erhiLYQqqQQOx73eu8Krk
 ITksfOB92HfWfZmISuk64uibPDxs00s42L4fk8gzJwCIlsUluvGl367ox
X-Gm-Gg: ASbGncvwX9OUmPpbiSVqzjsexC/zW+Bj6E3Y1Bi97gRW3DC7U3dwjSPBGMmQYKyRQN9
 /9pPI9mY1qxd/snRnjgGBdT17AcXXel2H0dKxPKVdWHs7ubJmPUhUcw0Pb8RJ0hb9xXvCX+zpm7
 BPAyu9klMVVkXnPrAy2zZl8CxfRV20ZCplliGX3VU13Po4qyItXMe/EnYMSUD0PrR6R/4oq+L+j
 Mf47brvauTpvy26Ej8w8UVAb9fGQ9RA4l6FQYbDk84LQTUmL79pwT0EWIx+LSXWJOYgp/9nJuwo
 gPG+2dqOobnGwZCDGABDMjjpoczRf90nDwcid5231dQeLw64/gGVQp1wKMr1
X-Received: by 2002:a05:6000:1448:b0:3a4:f52d:8b11 with SMTP id
 ffacd0b85a97d-3a5586f1905mr2522424f8f.20.1749645527298; 
 Wed, 11 Jun 2025 05:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxzazbFfNlcF2vrCY6wKVLo8Im/n2x5QZXPhRGBrKPPH94fl232FdNnjcZDDvaXX5Xd4IaTg==
X-Received: by 2002:a05:6000:1448:b0:3a4:f52d:8b11 with SMTP id
 ffacd0b85a97d-3a5586f1905mr2522397f8f.20.1749645526871; 
 Wed, 11 Jun 2025 05:38:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324641c2sm15401948f8f.93.2025.06.11.05.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 05:38:46 -0700 (PDT)
Message-ID: <1569b7ab-24da-4cf3-8ce8-fa9e10f9e172@redhat.com>
Date: Wed, 11 Jun 2025 14:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 27/38] vfio/iommufd: add vfio_device_free_name
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-28-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1749569991-25171-28-git-send-email-steven.sistare@oracle.com>
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

On 6/10/25 17:39, Steve Sistare wrote:
> Define vfio_device_free_name to free the name created by
> vfio_device_get_name.  A subsequent patch will do more there.
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-device.h | 1 +
>   hw/vfio/ap.c                  | 2 +-
>   hw/vfio/ccw.c                 | 2 +-
>   hw/vfio/device.c              | 5 +++++
>   hw/vfio/pci.c                 | 2 +-
>   hw/vfio/platform.c            | 2 +-
>   6 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 6eb6f21..321b442 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -227,6 +227,7 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>   
>   /* Returns 0 on success, or a negative errno. */
>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> +void vfio_device_free_name(VFIODevice *vbasedev);
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>                         DeviceState *dev, bool ram_discard);
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 785c0a0..013bd59 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -180,7 +180,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>   
>   error:
>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
> -    g_free(vbasedev->name);
> +    vfio_device_free_name(vbasedev);
>   }
>   
>   static void vfio_ap_unrealize(DeviceState *dev)
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index cea9d6e..903b8b0 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -619,7 +619,7 @@ out_io_notifier_err:
>   out_region_err:
>       vfio_device_detach(vbasedev);
>   out_attach_dev_err:
> -    g_free(vbasedev->name);
> +    vfio_device_free_name(vbasedev);
>   out_unrealize:
>       if (cdc->unrealize) {
>           cdc->unrealize(cdev);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 71fa9f4..a3603f5 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -317,6 +317,11 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>       return true;
>   }
>   
> +void vfio_device_free_name(VFIODevice *vbasedev)
> +{
> +    g_clear_pointer(&vbasedev->name, g_free);
> +}
> +
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>   {
>       ERRP_GUARD();
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b52c488..b4136432 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2966,7 +2966,7 @@ static void vfio_pci_put_device(VFIOPCIDevice *vdev)
>   
>       vfio_device_detach(&vdev->vbasedev);
>   
> -    g_free(vdev->vbasedev.name);
> +    vfio_device_free_name(&vdev->vbasedev);
>       g_free(vdev->msix);
>   }
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 9a21f2e..5c1795a 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -530,7 +530,7 @@ static bool vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>   {
>       /* @fd takes precedence over @sysfsdev which takes precedence over @host */
>       if (vbasedev->fd < 0 && vbasedev->sysfsdev) {
> -        g_free(vbasedev->name);
> +        vfio_device_free_name(vbasedev);
>           vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
>       } else if (vbasedev->fd < 0) {
>           if (!vbasedev->name || strchr(vbasedev->name, '/')) {


