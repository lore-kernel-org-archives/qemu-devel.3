Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F65C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1iHy-0005Pz-Ui; Tue, 30 Apr 2024 03:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1iHx-0005PV-6K
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1iHv-0006Xt-LM
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714463550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWkqVmipc1+/9rdsEjyk1YUp/O2b7/vsH5ktQ1I3IJQ=;
 b=iBOkExL6JpwvIiwvNwY2HGvrofTGJeCDrMgs/3gajHiU+y5TEeOvEB/MpCGb78WX7PaLvo
 G/DhfoAkUH17jIamZPwXoPg6cjgITHTI0FkbGj/S28bNwir7NMNWAC/qme7iLP094yTB8m
 18m6UxsiCoUOrY++yfpP5+jo5SYcMJQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-dgF5uaoRO4m72uiM0K3f5w-1; Tue, 30 Apr 2024 03:52:28 -0400
X-MC-Unique: dgF5uaoRO4m72uiM0K3f5w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69b6fe789e9so61258656d6.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 00:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714463548; x=1715068348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BWkqVmipc1+/9rdsEjyk1YUp/O2b7/vsH5ktQ1I3IJQ=;
 b=IhjT71bMmukFESxQPCDN5xK+0EiZ5DaYeXo72oOpNPfAbB/wCdHgB1qBUOZPWoLQUq
 uRW65rmwm850ftg5q6p+PaSH2S3SjUun2V6LX5v+IOnwVqb/AGmSmLdxinQN2QZkrLVU
 vFKklka/TODPVGe+IwvaZNed3nViACJj+ZgLaCnfzh+V36xJ9ED5037NWWg8+zyUVBBU
 RHV4Qa+IO0bboKyzMEGzhbNt5x8JECEF6nuvlv57XjJ/ybadntLp2nu3wrXEjFExE8jV
 2DatBbPMlqa2nvHvV1dLuXdXEZ/5rUixXlhTWH4esckw/j2OUIDPPA5OEJLk7orBKht5
 jM8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoRArdQu6UtxZU++XsMQPL+x85SJxsPm6b+bg/gb2BRmtw9lyJffOtJIdZb45VXyS0x5YpQCRZEzLkBkolfp8pd9Oplv4=
X-Gm-Message-State: AOJu0YzGekHzNzvgvrD9ShFlYBhulHUZgagRue5Rf1Fbj+02HifnudV4
 5qLUdee5NjAca5IKF3kVJCt6prABHKPTM6wFSXpZAjOMTW4I+LyToCTfymMrbaK0oWdIuFZo6HT
 lIhH5pQQ66SfF+V7BLbC1rKCOXd+2ECHMMJ98IMYWj5oQPYLef/cv
X-Received: by 2002:a05:6214:1310:b0:6a0:7ddf:4004 with SMTP id
 pn16-20020a056214131000b006a07ddf4004mr15893264qvb.54.1714463548209; 
 Tue, 30 Apr 2024 00:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZJvJ6/Bd6jUbmzX4MvOZ0JXkFm2HBto60tWvzDzzZheFjdm7+ioDrmdjXcu11xN/VO/Y8eg==
X-Received: by 2002:a05:6214:1310:b0:6a0:7ddf:4004 with SMTP id
 pn16-20020a056214131000b006a07ddf4004mr15893251qvb.54.1714463547974; 
 Tue, 30 Apr 2024 00:52:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 cs11-20020ad44c4b000000b006a0dc0351cfsm572980qvb.145.2024.04.30.00.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 00:52:27 -0700 (PDT)
Message-ID: <9dd29616-43be-46a3-89dd-68f6ec504848@redhat.com>
Date: Tue, 30 Apr 2024 09:52:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/19] vfio/iommufd: Introduce
 HostIOMMUDeviceIOMMUFDVFIO device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-5-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240429065046.3688701-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On 4/29/24 08:50, Zhenzhong Duan wrote:
> HostIOMMUDeviceIOMMUFDVFIO represents a host IOMMU device under VFIO
> iommufd backend. It will be created during VFIO device attaching and
> passed to vIOMMU.
> 
> It includes a link to VFIODevice so that we can do VFIO device
> specific operations, i.e., [at/de]taching hwpt, etc.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 13 +++++++++++++
>   hw/vfio/iommufd.c             |  6 +++++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index aa3abe0a18..0943add3bc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -32,6 +32,7 @@
>   #include "sysemu/sysemu.h"
>   #include "hw/vfio/vfio-container-base.h"
>   #include "sysemu/host_iommu_device.h"
> +#include "sysemu/iommufd.h"
>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -159,6 +160,18 @@ struct HostIOMMUDeviceLegacyVFIO {
>       VFIODevice *vdev;
>   };
>   
> +#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
> +            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
> +OBJECT_DECLARE_SIMPLE_TYPE(HostIOMMUDeviceIOMMUFDVFIO,
> +                           HOST_IOMMU_DEVICE_IOMMUFD_VFIO)
> +
> +/* Abstraction of host IOMMU device with VFIO IOMMUFD backend */
> +struct HostIOMMUDeviceIOMMUFDVFIO {
> +    HostIOMMUDeviceIOMMUFD parent;
> +
> +    VFIODevice *vdev;

Seems useless today.

Thanks,

C.



> +};
> +
>   typedef struct VFIODMABuf {
>       QemuDmaBuf buf;
>       uint32_t pos_x, pos_y, pos_updates;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8827ffe636..997f4ac43e 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -639,7 +639,11 @@ static const TypeInfo types[] = {
>           .name = TYPE_VFIO_IOMMU_IOMMUFD,
>           .parent = TYPE_VFIO_IOMMU,
>           .class_init = vfio_iommu_iommufd_class_init,
> -    },
> +    }, {
> +        .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
> +        .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
> +        .instance_size = sizeof(HostIOMMUDeviceIOMMUFDVFIO),
> +    }
>   };
>   
>   DEFINE_TYPES(types)


