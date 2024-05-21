Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F15C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OhO-0004Wg-Ja; Tue, 21 May 2024 08:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OhN-0004W7-0x
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OhL-0002QV-D7
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716294869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqEgk8QqmZ+q7JmB8eGQYtQ5+b7mzW/nYhfZjJtYSyw=;
 b=ZT4iSy8KJX2Lg5L8wncxa6Xku27I/rIjY0Nec8bBkrOFovL/8J6NhzepJXcnGxLiV/0I4Y
 rNc6qxZUwE4+cPxgr0URJRkgPesL409+wWwU0JHVsdv4XAXs9TPXZlvk23tAUzYUsKpsn5
 djCx0jEInpH4yWsNhyKj1gZIUT/A/6c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-kFdrYHBxONGXgM588CITOA-1; Tue, 21 May 2024 08:34:26 -0400
X-MC-Unique: kFdrYHBxONGXgM588CITOA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-792badf6670so1706630985a.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294866; x=1716899666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KqEgk8QqmZ+q7JmB8eGQYtQ5+b7mzW/nYhfZjJtYSyw=;
 b=lXJo7EBR0+UWdxV+sIw19bHZ/lR8FJE8YUl1pwo8XmtMeim+yU+Jzuv3tuP4T8MdBw
 nBjzdYjmDCtS0SfAI2wcFq3sAfPfwqhFZa+8Wk+6X2llZ9tMqqKozeMe+qHA/ISKQPMD
 Z5ZoXwPmA8B29NSu5FMq12aa1juzEHEt4uDlY8Og+hCjS6PqjvNtuRrkuKiBBdhUatB/
 XdjYa03ruJyhnBdPsCw4bHFgnTbfpSxjwprAW1KZJvGaoV8FzpGLGLsySXXBIHRF0WiX
 C4zwMUZKkS9EKDZAPJIUfNs2ywmdlWgQJkJGiUTJ7zQEvR7JiOdtipM++4YqlqYQT1BJ
 jzjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Jw1to2O9d21/oIMuXLXZjzTP8QkuoeHlvpm/B1Kg7VKcOi1IuwZSo9vXjaLsEbNOmsAeb3qyhBseoVHGpK6/5pwTTxg=
X-Gm-Message-State: AOJu0Yy0gLwcdM0ME5dB6ctsEu2XI80F6OkazuRVM+yliI8SK4TE+ZSb
 jicRL8gK0BJb4byUbjgez2mYSYi7PixRQuIjRQEthrDkuQLF5dZhfCjWkwWHk468hfLuFykuqnk
 DGXv7+UEsnKTVnIjDUBXdzDCqZCPc4GmfFZZc508C/AT/tPE4DoZw
X-Received: by 2002:a05:620a:28ca:b0:792:f406:6db6 with SMTP id
 af79cd13be357-792f4066e58mr2396782185a.39.1716294865768; 
 Tue, 21 May 2024 05:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnA9NtXiyVNKAUAZuegr3EuVr/4mS6drHf051C957Ix7myplA9Dx1t2///afpl3TzSd2E96A==
X-Received: by 2002:a05:620a:28ca:b0:792:f406:6db6 with SMTP id
 af79cd13be357-792f4066e58mr2396779985a.39.1716294865378; 
 Tue, 21 May 2024 05:34:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27f83csm1282378785a.32.2024.05.21.05.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:34:24 -0700 (PDT)
Message-ID: <05e016a1-0ae7-4d0f-ad77-d02a540096d9@redhat.com>
Date: Tue, 21 May 2024 14:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] vfio/ccw: Make vfio_ccw_get_region() return a bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-8-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> Since vfio_populate_device() takes an 'Error **' argument,
> best practices suggest to return a bool. See the qapi/error.h
> Rules section.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

One comment below

> ---
>   hw/vfio/ccw.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 8850ca17c8..2600e62e37 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -474,7 +474,7 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
>       event_notifier_cleanup(notifier);
>   }
>   
> -static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> +static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>   {
>       VFIODevice *vdev = &vcdev->vdev;
>       struct vfio_region_info *info;
> @@ -483,7 +483,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>       /* Sanity check device */
>       if (!(vdev->flags & VFIO_DEVICE_FLAGS_CCW)) {
>           error_setg(errp, "vfio: Um, this isn't a vfio-ccw device");
> -        return;
> +        return false;
>       }
>   
>       /*
> @@ -493,13 +493,13 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>       if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
>           error_setg(errp, "vfio: too few regions (%u), expected at least %u",
>                      vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
> -        return;
> +        return false;
>       }
>   
>       ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
>       if (ret) {
>           error_setg_errno(errp, -ret, "vfio: Error getting config info");
> -        return;
> +        return false;
>       }
>   
>       vcdev->io_region_size = info->size;
> @@ -553,7 +553,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           g_free(info);
>       }
>   
> -    return;
> +    return true;
>   
>   out_err:
>       g_free(vcdev->crw_region);
> @@ -561,7 +561,7 @@ out_err:
>       g_free(vcdev->async_cmd_region);
>       g_free(vcdev->io_region);
>       g_free(info);
> -    return;
> +    return false;
>   }
>   
>   static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
> @@ -597,8 +597,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)

vfio_ccw_realize() needs a little cleanup to avoid using the local
'Error *err' variable and the error_propagate() call at the end.

Thanks,

C.


>           goto out_attach_dev_err;
>       }
>   
> -    vfio_ccw_get_region(vcdev, &err);
> -    if (err) {
> +    if (!vfio_ccw_get_region(vcdev, &err)) {
>           goto out_region_err;
>       }
>   


