Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CEFC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmE2L-0004h5-6P; Mon, 18 Mar 2024 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmE2J-0004gw-HL
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmE2G-0002lk-Me
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710772338;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwqyjbJEBejqY84MU2DuTpqVtwceFK+yMX4PGtEfEcM=;
 b=CmQgxfB8NuS5wc+NawRZyTunE3K1SheT11i78pJwsD+/nTq5Q41XwV35b0QXAVaKNHrr7T
 9mzKj6Bm3RSZedOWhvFvtw0HwhYNy0+Awce+1EvARxYSAp6/rCRWvXMy7KXC53cYdyKLcm
 mkGMWo/DUhkQqrWWAtwCe2k3LUJPwG4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-ac9-d9ttOe62iiQmyApb2g-1; Mon, 18 Mar 2024 10:32:16 -0400
X-MC-Unique: ac9-d9ttOe62iiQmyApb2g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ecc0f0c95so2332293f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710772335; x=1711377135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XwqyjbJEBejqY84MU2DuTpqVtwceFK+yMX4PGtEfEcM=;
 b=dNWBL90oYoiG3ZYLIixT49waJOyhAnLd9lZoVYrBXpcubkClXBeeMhXUhKb7W0qg+l
 JN70fKMGZXKIOm1rrm1gMzRLP0TiN9u0sI0S39CoWPs1g3TMn3Gzld1qdWCIPCBqbUA8
 jpEquZ8eiYaWjqp0piXVrUg7pdMt7dzrGMjmTut6uL9kA+svPrCD6Sbwp0SdeQuFHfDH
 Ywd6KWEmVoX3zq6avHrfWDa0MWHlO9JHlc4+wCpQGaL3KQGr62wjZSENecBFTYbFJY/u
 VDyQ7HAHA7DV4C4MRZHyZ1rYqZ5pqQz6H26U0t8gJ8XljXv2XaPkfcBDRCiO7n3qnWU7
 Mk+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsdkq4O1JOE+b20HK06QdjbN943Ph0tElqhLMgm1SbpCHQTk63ePrl0cKLbFxqY98V5Js5FtRe+yTvB6qdi5EEdWneRNI=
X-Gm-Message-State: AOJu0YxoI8OmHmAQuOeoGJLr/ymErw5wzx8BD7ln9K67B1n4MQ3E4l6B
 9Pqq6/8HFSp0jzLL7gMINwE376PoIDlXNQteSy209Z+HJLIub69UVIN0Z3BA5i/1HrPRQ9snKHZ
 yZgBcDd6NRjOQ+WWcHtLlYhePvd5iAYmD4glt6N/9Omo8RAx3f/dP
X-Received: by 2002:adf:e882:0:b0:33e:c69f:2cae with SMTP id
 d2-20020adfe882000000b0033ec69f2caemr6675745wrm.23.1710772335204; 
 Mon, 18 Mar 2024 07:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnbsM8yzg9aarqapayjas1e02d+ZnJ8TAtSbFN6wUH5Xb603ToiGk0SGcBIqwjMTkOKIoahA==
X-Received: by 2002:adf:e882:0:b0:33e:c69f:2cae with SMTP id
 d2-20020adfe882000000b0033ec69f2caemr6675733wrm.23.1710772334901; 
 Mon, 18 Mar 2024 07:32:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d6608000000b0033e45930f35sm9965173wru.6.2024.03.18.07.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:32:14 -0700 (PDT)
Message-ID: <49c49a2e-859e-45bb-b281-0ed9c72ecf9c@redhat.com>
Date: Mon, 18 Mar 2024 15:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create callback
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240228035900.1085727-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/28/24 04:58, Zhenzhong Duan wrote:
> Introduce host_iommu_device_create callback and a wrapper for it.
>
> This callback is used to allocate a host iommu device instance and
> initialize it based on type.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h         | 1 +
>  include/hw/vfio/vfio-container-base.h | 1 +
>  hw/vfio/common.c                      | 8 ++++++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b6676c9f79..9fefea4b89 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -208,6 +208,7 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>  int vfio_attach_device(char *name, VFIODevice *vbasedev,
>                         AddressSpace *as, Error **errp);
>  void vfio_detach_device(VFIODevice *vbasedev);
> +void host_iommu_device_create(VFIODevice *vbasedev);
>  
>  int vfio_kvm_device_add_fd(int fd, Error **errp);
>  int vfio_kvm_device_del_fd(int fd, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index b2813b0c11..dc003f6eb2 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -120,6 +120,7 @@ struct VFIOIOMMUClass {
>      int (*attach_device)(const char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>      void (*detach_device)(VFIODevice *vbasedev);
> +    void (*host_iommu_device_create)(VFIODevice *vbasedev);
Maybe return an int instead. It is common the allocation can fail and
the deallocation cannot. While at it I would also pass an errp in case
it fails

Eric
>      /* migration feature */
>      int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>                                     bool start);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 059bfdc07a..41e9031c59 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1521,3 +1521,11 @@ void vfio_detach_device(VFIODevice *vbasedev)
>      }
>      vbasedev->bcontainer->ops->detach_device(vbasedev);
>  }
> +
> +void host_iommu_device_create(VFIODevice *vbasedev)
> +{
> +    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
> +
> +    assert(ops->host_iommu_device_create);
> +    ops->host_iommu_device_create(vbasedev);
> +}


