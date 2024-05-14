Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68856C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uah-0002ur-PM; Tue, 14 May 2024 12:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uaX-0002rT-DK
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uaV-0006xJ-5h
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715702467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5F3yiEyJRh3qJpykRKP5al80E8wz8v/b8nlZtrslKlM=;
 b=KKOA8msNcavGuqKW+FHhmMvp7JhDG6+lhDhB0Y9AzQcK3lL3X7k8z/t2dG139V9alLGNDY
 h0Y3xpg4MJKtWxF9zpH4lQcVGNtCLrG4V7ajp7PQkTI+Zmj2PzlWPRGwaU/QWQbnIq9m1l
 upvN18b3bxPsfb6X31lrAdzvuAG+XWQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-cInP5rtjMWGh8kKIdL4Ecg-1; Tue, 14 May 2024 12:00:54 -0400
X-MC-Unique: cInP5rtjMWGh8kKIdL4Ecg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7fc2273536bso915868241.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 09:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715702454; x=1716307254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5F3yiEyJRh3qJpykRKP5al80E8wz8v/b8nlZtrslKlM=;
 b=k8jePzjTnR3F3Ydtgy4UwM8PN/IbytsIUyZ3ssB+ta1OS/DoUyrXLUoQC0RliRIttJ
 N+I739fPQrX3Sp0ZyEAbxi5PnvoNb04jA4X1vyQ243HotYf1bMRJ2MguPFm6vie6AANH
 eG+oPp9Ex6Kcebrhsp6AoI1gJyi/v9gr97WR6WgkvYnnuX9NtzjJko4OgPr6o1fJSyIN
 iUv941MGyf443DesrIbQp+jcAzp6rn487gYwUGTvuVbQsjUWdswY5XXz2c5AT9PhbF70
 pf/rDsU0Mt5s3t2UD+NC+wqqe4rF5UMi45QM9SEol8MrVY5v5NUkhJfqQ+Mu15Fupt+r
 0TeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5QAU2thBClP5lu2MzvlwVJSBD/hczsjgk/6xXgyHCBrHlhV2lx1harkATv+0PE8tTKMN2vkI2eY/JkZ2XdFCmAMWLVf0=
X-Gm-Message-State: AOJu0YyJT2iu9hemZUo04wf/F5FXVGpbYIOAtEb6pxlIBoOOcDL0wUFK
 u80fKGjc4JpnveGnn9HmFxfSo6bItGfXNRL9N7oEZCds0eXpXX9RoFVo5sz3YP6mPBhmn+432Dm
 AbQowqE0cAjRFlVYDkP09vYShpvYjyKnYmR72+4mqRkEJAELy6bCu
X-Received: by 2002:a05:6102:38c8:b0:47e:effb:f740 with SMTP id
 ada2fe7eead31-48077dccadamr14409982137.7.1715702453660; 
 Tue, 14 May 2024 09:00:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4J3k1v19cTUc5Gye4U0suYlOdCZtb1YZMvzGYOEHXjPIqLtOmtcojKP3TWGH4p7PvkD5BaQ==
X-Received: by 2002:a05:6102:38c8:b0:47e:effb:f740 with SMTP id
 ada2fe7eead31-48077dccadamr14409780137.7.1715702452724; 
 Tue, 14 May 2024 09:00:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4806cb008d2sm1720382137.2.2024.05.14.09.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 09:00:52 -0700 (PDT)
Message-ID: <3128057f-3a2f-44ce-b66d-d05c4f0abbac@redhat.com>
Date: Tue, 14 May 2024 18:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] vfio/container: Make vfio_set_iommu() return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-8-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/7/24 08:42, Zhenzhong Duan wrote:
> This is to follow the coding standand to return bool if 'Error **'
> is used to pass error.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 0a7edfcc43..5fb4bee082 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -391,21 +391,20 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
>       return VFIO_IOMMU_CLASS(klass);
>   }
>   
> -static int vfio_set_iommu(VFIOContainer *container, int group_fd,
> -                          VFIOAddressSpace *space, Error **errp)
> +static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
> +                           VFIOAddressSpace *space, Error **errp)
>   {
> -    int iommu_type, ret;
> +    int iommu_type;
>       const VFIOIOMMUClass *vioc;
>   
>       iommu_type = vfio_get_iommu_type(container, errp);
>       if (iommu_type < 0) {
> -        return iommu_type;
> +        return false;
>       }
>   
> -    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
> -    if (ret) {
> +    if (ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>           error_setg_errno(errp, errno, "Failed to set group container");
> -        return -errno;
> +        return false;
>       }
>   
>       while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
> @@ -420,7 +419,7 @@ static int vfio_set_iommu(VFIOContainer *container, int group_fd,
>               continue;
>           }
>           error_setg_errno(errp, errno, "Failed to set iommu for container");
> -        return -errno;
> +        return false;
>       }
>   
>       container->iommu_type = iommu_type;
> @@ -428,11 +427,11 @@ static int vfio_set_iommu(VFIOContainer *container, int group_fd,
>       vioc = vfio_get_iommu_class(iommu_type, errp);
>       if (!vioc) {
>           error_setg(errp, "No available IOMMU models");
> -        return -EINVAL;
> +        return false;
>       }
>   
>       vfio_container_init(&container->bcontainer, space, vioc);
> -    return 0;
> +    return true;
>   }
>   
>   static int vfio_get_iommu_info(VFIOContainer *container,
> @@ -613,8 +612,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->fd = fd;
>       bcontainer = &container->bcontainer;
>   
> -    ret = vfio_set_iommu(container, group->fd, space, errp);
> -    if (ret) {
> +    if (!vfio_set_iommu(container, group->fd, space, errp)) {
>           goto free_container_exit;
>       }
>   


