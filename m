Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AF9C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uag-0002sI-1Y; Tue, 14 May 2024 12:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uZq-0002l4-Bd
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uZn-0006eS-Na
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715702426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2ufjfmx19dFOliH7NoIvH5uXJNN1B4VZvBUauSfcQc=;
 b=hjnJmnVuQWP4JEF956B/k+0jhSkFQNql5xHYuFfmxMryUyh1AqF1R/n395KeDNdlUzjiln
 1ZxJ1vZOmrq5X2PxQPbXoYfLkHQqrfgmVJskXl1IQe+HdonqYG8AIqVTDvpzxVn/8UN+H8
 nyDuQ1R8VzF9duqNHBytRPHSXZKKiuU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-_1eIAglBMn23cLZYeR3cEw-1; Tue, 14 May 2024 12:00:22 -0400
X-MC-Unique: _1eIAglBMn23cLZYeR3cEw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43e168e8443so27336461cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 09:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715702422; x=1716307222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y2ufjfmx19dFOliH7NoIvH5uXJNN1B4VZvBUauSfcQc=;
 b=q2pIFGU07G8CPXSsOsB8Fi0GIVcHwkkY3+az9KaTaCTEN57DjZML51w6LN3/jcXIeC
 qN0q7FvkYIcGr9eIUXGDtbRqbyK6obznjLWbJd0cAqlb8BLmOBmJhAYtxZC/5EnzSmeL
 DyDHIfgQbgHP4BDjz+39+peqsUNdvUW+QVcD/bpscIgcqErT7Dw0m8pqE644WzVdg6wX
 wIpAWt5Wiz6Er68jhHKQGQxWtIIfDOPHsfDgzbyMmysMWDVHTinv0j2CrUVsFMWHX/wt
 fi9No6PbQLYRvDxWMM1HtBfeVUKWvBO8LxlMeMwDmLrI/ZhUxQKryFue5JlHwfVpxWBB
 y20w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6jDHa3ga6wrQ5EAA6uQ7Ig52R+r/eLf+T3SklY0+gUfoEYZ58WykaH8GMAYlsHkUy7rtufE+t4E2D4qnONTTALpO4hM0=
X-Gm-Message-State: AOJu0Yz3F3ylzNtmT6X0mLJy8DBNopZBfEOVaB9e6yj07v7JokFLaZw7
 47eUrGD+PRlLQc0fnWpiFPwbOWn4NEqWSJk6+2bmVG/OoeLkNQFcJf+5d4FnzwsJhrqgAl20yXQ
 h204PqBPyiqUOH6D1c3cLFrbIJz1HwwiGNPcbPDDTfh6NKDQUf79e
X-Received: by 2002:ac8:7f51:0:b0:43a:9717:3056 with SMTP id
 d75a77b69052e-43dfdcd726dmr179156561cf.43.1715702422004; 
 Tue, 14 May 2024 09:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDosmg6Mr4JKgvZGmafE/t0/U5HHRaQXw02O/ak7cZ+zMRTEqyx3wQ5bVsSVll9xwOSs4QVw==
X-Received: by 2002:ac8:7f51:0:b0:43a:9717:3056 with SMTP id
 d75a77b69052e-43dfdcd726dmr179156061cf.43.1715702421257; 
 Tue, 14 May 2024 09:00:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df56ddd77sm69433291cf.92.2024.05.14.09.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 09:00:20 -0700 (PDT)
Message-ID: <d164d7b5-e7ac-4173-b2ef-0e49465ffa11@redhat.com>
Date: Tue, 14 May 2024 18:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] vfio/container: Make vfio_connect_container()
 return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-7-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 85a8a369dc..0a7edfcc43 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -534,8 +534,8 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
>       return true;
>   }
>   
> -static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> -                                  Error **errp)
> +static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> +                                   Error **errp)
>   {
>       VFIOContainer *container;
>       VFIOContainerBase *bcontainer;
> @@ -587,19 +587,18 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                       error_report("vfio: error disconnecting group %d from"
>                                    " container", group->groupid);
>                   }
> -                return ret;
> +                return false;
>               }
>               group->container = container;
>               QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>               vfio_kvm_device_add_group(group);
> -            return 0;
> +            return true;
>           }
>       }
>   
>       fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
>       if (fd < 0) {
>           error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
> -        ret = -errno;
>           goto put_space_exit;
>       }
>   
> @@ -607,7 +606,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       if (ret != VFIO_API_VERSION) {
>           error_setg(errp, "supported vfio version: %d, "
>                      "reported version: %d", VFIO_API_VERSION, ret);
> -        ret = -EINVAL;
>           goto close_fd_exit;
>       }
>   
> @@ -634,7 +632,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       assert(bcontainer->ops->setup);
>   
>       if (!bcontainer->ops->setup(bcontainer, errp)) {
> -        ret = -EINVAL;
>           goto enable_discards_exit;
>       }
>   
> @@ -650,7 +647,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>   
>       if (bcontainer->error) {
> -        ret = -1;
>           error_propagate_prepend(errp, bcontainer->error,
>               "memory listener initialization failed: ");
>           goto listener_release_exit;
> @@ -658,7 +654,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   
>       bcontainer->initialized = true;
>   
> -    return 0;
> +    return true;
>   listener_release_exit:
>       QLIST_REMOVE(group, container_next);
>       QLIST_REMOVE(bcontainer, next);
> @@ -683,7 +679,7 @@ close_fd_exit:
>   put_space_exit:
>       vfio_put_address_space(space);
>   
> -    return ret;
> +    return false;
>   }
>   
>   static void vfio_disconnect_container(VFIOGroup *group)
> @@ -770,7 +766,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>       group->groupid = groupid;
>       QLIST_INIT(&group->device_list);
>   
> -    if (vfio_connect_container(group, as, errp)) {
> +    if (!vfio_connect_container(group, as, errp)) {
>           error_prepend(errp, "failed to setup container for group %d: ",
>                         groupid);
>           goto close_fd_exit;


