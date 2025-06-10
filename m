Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CB7C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 06:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOsDp-0006IO-Dp; Tue, 10 Jun 2025 02:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsDh-0006FL-Vz
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsDf-0008Mm-LV
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749535941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ASEwdbdxQ1/LXoFqHlFdlRv7hwH7nB1r8lHS6KwYzyw=;
 b=C2D8WTwg+S1HNg9eqL2DroyeECjz9OwJWV04kguw8wVvX29ay2p/FOoMSOfbGJ5oqIpE1d
 dlAb0YWywz8doVx+i401KF7ZRPZyzjrl+Iv4+Th8ZxuU/71Qzujk9F11rdBPL2quTkys0D
 BG59ECNXC+OBugf1wndomyUJymTWAjQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-S-fWomeINi6psAisk_9Y3Q-1; Tue, 10 Jun 2025 02:12:19 -0400
X-MC-Unique: S-fWomeINi6psAisk_9Y3Q-1
X-Mimecast-MFC-AGG-ID: S-fWomeINi6psAisk_9Y3Q_1749535938
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453145854a6so8982455e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 23:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749535938; x=1750140738;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASEwdbdxQ1/LXoFqHlFdlRv7hwH7nB1r8lHS6KwYzyw=;
 b=WNyHOcA011MwIRu3Sc7n+N8/8JLsb8c7wVxf8c7nuHec/v3vq+hjEnZRFQ2RlpS/r8
 8ZkmmS9CVoIbsk41RJsXsk4sCwjPwdVPRv6+JhiAF1vefB1iYD53o0MmOeKuiGdRm6KA
 2qnhMpdTJYjFxcSef83tV/LOV7ILe+u7tiq0w17Kj4KvU8dD89EqSWFKHwMOqAfY8fem
 SPZNQ5qvjQhSIhZDZhp0S4v1Ela69BSbB6aOnJgxAJfMY9aiE5CE8IWiYqtivkyS0Vcf
 c/FvbEEzbqEn45jDFtX0YG6RzSes2bsO3tBO4IU0gdDQZa2wP6fTGRstaZkwEyrh9JY7
 4BCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8LG/PJrNW/H05z1hrr6uexTBN7Xv07KoxP1VgHwonGs0jlZnZ3bVJZuZcIHkHwImE5o1V/TyqHosf@nongnu.org
X-Gm-Message-State: AOJu0YyGfphrrH8z9jzvqvykhxKJEUv3p7h31LJzvupd/zybeLF1FFhe
 wJWSqU+rXKrlOs3l8AQp+xpY9KD7pIeWZIqha1aPNKZ9pUPX0L/ObrclPbS89UKh4DP/rZRR14l
 6Yf8xQS0ZZiYP/aFCb8fIMaTaqvRG08v0BQ6gKx7nMDc0L30seS7qt6yv
X-Gm-Gg: ASbGnct6+s4+7VxFpC8LJz+6FexXfTYBmyAsCG519MhdZjDYtrY1P1Zu0v1KBQMfJEs
 z8AGPJIJFppgcK69PHKVfpGQkqMv5SpaqVzkl3fFpcIhSib1TD5lJpET1j/PD0YKMZt/cQAXUrB
 98RaC6d5cJ6Ufo/Zq0MslENdOQK46BWsRAErynLCsmYbQjr/AL6oAnW38yGPytQBEkbmw6ebBgG
 MFgkQQHZxo1gfth6v6oniGVMkFhCGlaawD+YbU82u4RFCUCEfASfncxU+cv93fV/axO3ITX7Tvl
 OHHFDm0gYBsSEPYyiL6sm7FUiorscq0uuoWO+QsDleIO6rFmfIPp6How2qDf
X-Received: by 2002:a05:600c:8b06:b0:453:9b7:c214 with SMTP id
 5b1f17b1804b1-4531dea9cb5mr9607115e9.29.1749535938456; 
 Mon, 09 Jun 2025 23:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXRY/SG9RovhwDj4yoZOrKO/VzcuPQQ40IUWmt6RbWhwhNGf8i1edYB/w7dAVcA9cwgYV23w==
X-Received: by 2002:a05:600c:8b06:b0:453:9b7:c214 with SMTP id
 5b1f17b1804b1-4531dea9cb5mr9606905e9.29.1749535938079; 
 Mon, 09 Jun 2025 23:12:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45213709670sm130265845e9.25.2025.06.09.23.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 23:12:17 -0700 (PDT)
Message-ID: <bd8e520b-bfa5-426d-98fa-5a4e4f14cd56@redhat.com>
Date: Tue, 10 Jun 2025 08:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 33/43] vfio/iommufd: add vfio_device_free_name
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-34-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-34-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/29/25 21:24, Steve Sistare wrote:
> Define vfio_device_free_name to free the name created by
> vfio_device_get_name.  A subsequent patch will do more there.
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
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
> index 71fa9f4..151c618 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -317,6 +317,11 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>       return true;
>   }
>   
> +void vfio_device_free_name(VFIODevice *vbasedev)
> +{
> +    g_free(vbasedev->name);

you could use g_clear_pointer().

Thanks,

C.

  
> +}
> +
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>   {
>       ERRP_GUARD();
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c8d6ee0..7da7a9c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2949,7 +2949,7 @@ static void vfio_pci_put_device(VFIOPCIDevice *vdev)
>   {
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


