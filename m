Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC4BC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6udD-0004dT-Ei; Tue, 14 May 2024 12:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6ucv-0004Ze-CS
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uch-0007O9-QB
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715702598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwFR7NV6qLsnSeTRAy74jRuV54b6YaLd5jJZC826/as=;
 b=GVxjUjBevZSf/Dtnjlq9SzSW2842xdLRsNnQV6Wrog6MaFtjQqAE2UNuxZQqB02LHfuEk1
 /UKJ+DDqFgiHMu/sQ5N0dBOLk9yvLFYHv6grgVtg9royfC/3dcoU9wU35BjKflwrnfaD/b
 W61Qoo4jmw0g3KhZTY5JTX9i9sk+R5k=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-iIYMGIIIOoiqvZrmF48GTg-1; Tue, 14 May 2024 12:03:16 -0400
X-MC-Unique: iIYMGIIIOoiqvZrmF48GTg-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4df94adb21fso2799224e0c.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 09:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715702595; x=1716307395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fwFR7NV6qLsnSeTRAy74jRuV54b6YaLd5jJZC826/as=;
 b=q7QT7K70f/IIyUYDPA9v66+ot0sZiKwTffIV+KDFGUy1R29iml9c9hvWESVCP9x0gF
 TW5EhVTgRqMcvNaAmr5Eg2mZhnNv6LHKByYtuTPUHuYuYdMHHKZ+AWzr8vZPnG3+yAue
 QvAknY5x7o3HciuPg5h3c+TlJhHV/kKWUdGkM2QksJ+XltBIQNLcuLi+CqdwueyqN3e2
 z+Xh82/yeysbJ5epxDLfh7Asb82QyNUxt+v0QobHBvmyr/b/ihuXCwoTcYgPEVGDHrs7
 xjjryXa0+9OP0Gw/vsoVp/xP1ICZa1PpboC6jF3q5M2TV1zUS7M7M5lOC9Z1d5QAezO9
 MrkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9qfFYqbhYeRigd7fwZsGL5eXU/Kwu25bqPcqUMGueQD/JFe+qN1sxlbSpZmBnl4DUzIfDO3Qzb+1McJArfhOV7Q42dlY=
X-Gm-Message-State: AOJu0YxPaSZzI6++px9iwnzEb421S7WkCaf3Y1CHKaDxensKBrtAAb04
 fvyoKqbP9mh9y/gqKTW48L+l5DHd2Oq+LAZVWWAbrP63LYCSlQKEaE4wU9p5nFmPq+VChkdCOwt
 Yo04p5lAXGW3QpYl8nRiAGVlQwW14DlHnpg0f1KypooxTX8lRvSEs
X-Received: by 2002:a05:6122:914:b0:4d3:3f2b:dc63 with SMTP id
 71dfb90a1353d-4df882a16cdmr10838436e0c.5.1715702595337; 
 Tue, 14 May 2024 09:03:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4YDUmJens/PgK+4rVkPBGK/2gzBbnV+XjhZZ7YvV8ecJNz1o9hum57Im+kxmTrI1gDz53lQ==
X-Received: by 2002:a05:6122:914:b0:4d3:3f2b:dc63 with SMTP id
 71dfb90a1353d-4df882a16cdmr10838401e0c.5.1715702594921; 
 Tue, 14 May 2024 09:03:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-4df7bf44cf5sm1478719e0c.10.2024.05.14.09.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 09:03:14 -0700 (PDT)
Message-ID: <b9c1483b-7ac8-4e2e-8519-862154a632cb@redhat.com>
Date: Tue, 14 May 2024 18:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] backends/iommufd: Make iommufd_backend_*()
 return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Yi Liu <yi.l.liu@intel.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-12-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> The changed functions include:
> 
> iommufd_backend_connect
> iommufd_backend_alloc_ioas
> 
> By this chance, simplify the functions a bit by avoiding duplicate
> recordings, e.g., log through either error interface or trace, not
> both.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/sysemu/iommufd.h |  6 +++---
>   backends/iommufd.c       | 29 +++++++++++++----------------
>   hw/vfio/iommufd.c        |  5 ++---
>   backends/trace-events    |  4 ++--
>   4 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 9af27ebd6c..293bfbe967 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -23,11 +23,11 @@ struct IOMMUFDBackend {
>       /*< public >*/
>   };
>   
> -int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
> +bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>   void iommufd_backend_disconnect(IOMMUFDBackend *be);
>   
> -int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
> -                               Error **errp);
> +bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
> +                                Error **errp);
>   void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
>   int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly);
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 76a0204852..c506afbdac 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -72,24 +72,22 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
>       object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>   }
>   
> -int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
> +bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>   {
> -    int fd, ret = 0;
> +    int fd;
>   
>       if (be->owned && !be->users) {
>           fd = qemu_open_old("/dev/iommu", O_RDWR);
>           if (fd < 0) {
>               error_setg_errno(errp, errno, "/dev/iommu opening failed");
> -            ret = fd;
> -            goto out;
> +            return false;
>           }
>           be->fd = fd;
>       }
>       be->users++;
> -out:
> -    trace_iommufd_backend_connect(be->fd, be->owned,
> -                                  be->users, ret);
> -    return ret;
> +
> +    trace_iommufd_backend_connect(be->fd, be->owned, be->users);
> +    return true;
>   }
>   
>   void iommufd_backend_disconnect(IOMMUFDBackend *be)
> @@ -106,25 +104,24 @@ out:
>       trace_iommufd_backend_disconnect(be->fd, be->users);
>   }
>   
> -int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
> -                               Error **errp)
> +bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
> +                                Error **errp)
>   {
> -    int ret, fd = be->fd;
> +    int fd = be->fd;
>       struct iommu_ioas_alloc alloc_data  = {
>           .size = sizeof(alloc_data),
>           .flags = 0,
>       };
>   
> -    ret = ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data);
> -    if (ret) {
> +    if (ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data)) {
>           error_setg_errno(errp, errno, "Failed to allocate ioas");
> -        return ret;
> +        return false;
>       }
>   
>       *ioas_id = alloc_data.out_ioas_id;
> -    trace_iommufd_backend_alloc_ioas(fd, *ioas_id, ret);
> +    trace_iommufd_backend_alloc_ioas(fd, *ioas_id);
>   
> -    return ret;
> +    return true;
>   }
>   
>   void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 6a446b16dc..554f9a6292 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -71,7 +71,7 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>           .flags = 0,
>       };
>   
> -    if (iommufd_backend_connect(iommufd, errp)) {
> +    if (!iommufd_backend_connect(iommufd, errp)) {
>           return false;
>       }
>   
> @@ -346,8 +346,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       }
>   
>       /* Need to allocate a new dedicated container */
> -    ret = iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp);
> -    if (ret < 0) {
> +    if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
>           goto err_alloc_ioas;
>       }
>   
> diff --git a/backends/trace-events b/backends/trace-events
> index d45c6e31a6..211e6f374a 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -7,11 +7,11 @@ dbus_vmstate_loading(const char *id) "id: %s"
>   dbus_vmstate_saving(const char *id) "id: %s"
>   
>   # iommufd.c
> -iommufd_backend_connect(int fd, bool owned, uint32_t users, int ret) "fd=%d owned=%d users=%d (%d)"
> +iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d users=%d"
>   iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>   iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>   iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
> -iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
> +iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"


