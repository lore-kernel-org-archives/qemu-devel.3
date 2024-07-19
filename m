Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1822C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUoQr-0004Wd-6d; Fri, 19 Jul 2024 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sUoQp-0004VP-7Y
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sUoQm-0001eK-OH
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721398675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yeBpZaS94ybF2PH1ZmlxttvXJ8BWqEFKSoy94zBX08=;
 b=T7gEjSO/7UxoMj8fPQYBX148WG5tH6e4/QH1q/0O+U+tWJ+mwAJb9PhW0laNVZwLYicm+w
 1SmHoybIZUwx/iq4FDgF/U74OQ0QKbiEC5FBtqSjdwsTqWPluYEgHuCH2q1OY0RuB0Hpdx
 Pe7ppWtik0kKY/TFX7581UknXhATkeo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-sHpfHPvVMtaazI9t80tWRg-1; Fri, 19 Jul 2024 10:17:53 -0400
X-MC-Unique: sHpfHPvVMtaazI9t80tWRg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79ef9c44d3eso200330185a.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 07:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721398673; x=1722003473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9yeBpZaS94ybF2PH1ZmlxttvXJ8BWqEFKSoy94zBX08=;
 b=PhwAURg8EV5smtXA/StqAEvMKrPAiQ58Wl7GWWPGmHZE6oKO9J30vg+Fn5MGtUyHCl
 eWd3mnsUKkDnZmhAUfVc29QCyauLFnG9sRYi/3Bc7VO6XpKaTMI7BPjhp48wYaJq0Fps
 KUjQvaGqFMjE4/Nhj9typBJXIW9LUiG0iDV6M4zNyLLd1/49GWpsFHqZhFATrSIQ4TiW
 SXSBmnQ5BDT1j8dRkalXd+2q9o8uwjca2g+nnr2jl8ODfj3mJa6f7wv7YDGhe+DInLdk
 aIwWeXtiQLu72uCrd3uSmLHL355pfJ/URkWm4QIQ9w5nhUADa4yyXBPGHwjXQO8HPPnn
 kmCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHaouHcXaZ9YDdNKHXNqIEEREANvGXKn0Y95xywho2i5NDBzJqgOt58sChazzop5cTDUnh4+LolCx1bwmi6RBk1/ogYns=
X-Gm-Message-State: AOJu0YwG+NKATcgmr5lHpoXAhby5wCeSTyWx4ED4YQeQbP3TLlerp2yD
 hnkdqF7dUYxO6x+9v6ElJWe4mCmygiU1z4VxckkebvLvDnjQOcOMU0cPtxyb6IDx1P9+F20/uyK
 MxSSh2qX4ykP26uwX1MGl/pUHJcB9cxsiovg//7oLdiYwAOl6tDsL
X-Received: by 2002:a05:620a:404a:b0:79f:4fe:9e24 with SMTP id
 af79cd13be357-7a18745c595mr900188385a.16.1721398672755; 
 Fri, 19 Jul 2024 07:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMuPDn+GP45XV29eh1+iJIYijVIg9FUcJ1TCnE1s+EDcIuqfMVPnYMnZ5iIXFCS8Bep6+qlQ==
X-Received: by 2002:a05:620a:404a:b0:79f:4fe:9e24 with SMTP id
 af79cd13be357-7a18745c595mr900185485a.16.1721398672379; 
 Fri, 19 Jul 2024 07:17:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198fab30fsm85636385a.26.2024.07.19.07.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 07:17:51 -0700 (PDT)
Message-ID: <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
Date: Fri, 19 Jul 2024 16:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240719120501.81279-13-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/19/24 14:05, Joao Martins wrote:
> By default VFIO migration is set to auto, which will support live
> migration if the migration capability is set *and* also dirty page
> tracking is supported.
> 
> For testing purposes one can force enable without dirty page tracking
> via enable-migration=on, but that option is generally left for testing
> purposes.
> 
> So starting with IOMMU dirty tracking it can use to accomodate the lack of
> VF dirty page tracking allowing us to minimize the VF requirements for
> migration and thus enabling migration by default for those too.
> 
> While at it change the error messages to mention IOMMU dirty tracking as
> well.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/iommufd.c             |  2 +-
>   hw/vfio/migration.c           | 11 ++++++-----
>   3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 7e530c7869dc..00b9e933449e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>   
>   /* Returns 0 on success, or a negative errno. */
>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 7dd5d43ce06a..a998e8578552 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -111,7 +111,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>       iommufd_backend_disconnect(vbasedev->iommufd);
>   }
>   
> -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>   {
>       return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>   }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 34d4be2ce1b1..63ffa46c9652 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   
> -    if (!vbasedev->dirty_pages_supported) {
> +    if (!vbasedev->dirty_pages_supported &&
> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {


Some platforms do not have IOMMUFD support and this call will need
some kind of abstract wrapper to reflect dirty tracking support in
the IOMMU backend.

Thanks,

C.



>           if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>               error_setg(&err,
> -                       "%s: VFIO device doesn't support device dirty tracking",
> -                       vbasedev->name);
> +                       "%s: VFIO device doesn't support device and "
> +                       "IOMMU dirty tracking", vbasedev->name);
>               goto add_blocker;
>           }
>   
> -        warn_report("%s: VFIO device doesn't support device dirty tracking",
> -                    vbasedev->name);
> +        warn_report("%s: VFIO device doesn't support device and "
> +                    "IOMMU dirty tracking", vbasedev->name);
>       }
>   
>       ret = vfio_block_multiple_devices_migration(vbasedev, errp);


