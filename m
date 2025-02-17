Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A83C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5SF-0001Cj-Rz; Mon, 17 Feb 2025 13:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tk5SB-0001CS-Ps
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tk5SA-0004oA-4d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739815365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KF9gTo/IbXyyCdeLq5ZjZjJdaYMI20IAeEbeZ7zOx5k=;
 b=PiKUGv60uLaOR2eDYKYgBatIh+DpD/50YX/c1HR5mGPZmnS8s6Qi2yWubwmKCoZWMNWes4
 mRfNtTXhLbyAwqHEnT9c/LmC2AiVP+ojDBBF5tMSXVZ9be4WhNu60aJEMQNvmwGiwQUB7p
 YDj5m07SwHH8eMMXBxrg1d76bXbT330=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-T4XMAxafNxyaJhooF0wcjg-1; Mon, 17 Feb 2025 13:02:43 -0500
X-MC-Unique: T4XMAxafNxyaJhooF0wcjg-1
X-Mimecast-MFC-AGG-ID: T4XMAxafNxyaJhooF0wcjg_1739815362
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43945f32e2dso37674955e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739815362; x=1740420162;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KF9gTo/IbXyyCdeLq5ZjZjJdaYMI20IAeEbeZ7zOx5k=;
 b=Go7FhnsLMQ37fNv7bILVwZMqwk5k3noEBub2iyCO8N2UK4Znvnhm5koaWlYFXAHREL
 DLR5aG0kbRquGsJxNKIXdhfKwgtkVucOdb9BmI0bvCCszVn4TEkzFYyG04bqJOOn2VI0
 BNLue5BLdU5aF6zieRevYKTidvWQ/VCAvlgMV3Kt27k/CFyECT2fTOpOJKcXBM5cvYr/
 AiHSASQBiENPN8347u/UKHYHwZO09uRLlrn0e7J1f1H39Hje6ooSSrwW9ExyLSkb3676
 uW8Lh4UCP4bA8x9Vh8zfrG6GG/dzEWJ6G0nWSxfGFF5Kj5isgSEh+Lvcroj/T+t6a7Ni
 ahgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8xJMJYbWVgMW4LzEv83OCyIBiFD5FsVlDgbWYKJnEPoEyKH5wBTJIs4BywLquK0JxTi1mNvgeJoBU@nongnu.org
X-Gm-Message-State: AOJu0YxKA+9c3TblatS7qJiAbaTdYSU9QEHYGyvqZw4LO90L8dyhXdVI
 WKBhU4I2KIz3t3oBlbqJrKQS29QWqnECcnIHAATiM/418mLAHLKF6OijbEwElEiIBBe4DSdDYa+
 oc6DyTR6gN+9y9ZV83pzsHOPnV0nHWIGbqIN8b/BFNoDz1smcT99t
X-Gm-Gg: ASbGnctWo5uzY/q7HbVpqGJB4Rf0oqPz5QveOT+7W332rO9ICHXtmjJsro4tcqwXqBN
 rbst1yRBrAWJV5RW5lybitm7/zh4ptIqSz3+sJh/syxAgIPhYo/ZXHSB35PLFcPxfocm2VCPuxW
 uiVzmBJxSz+o7+4giVZxqlhkphBvL12wqcG7UjlDZDrECep0QiNuUEw3BThRnb+vdLRVNyUKqOe
 aFTpAL+uUySk35IkUhyA1Xoy64jORSaio8zwRqpWMtyJ4mYJWOBiKXOKI+PhIUmvQ2fI2vvbNBz
 ZICgfXneHu9J/W5ySGn1FYt7diHneaVjL1BuxqWW
X-Received: by 2002:a05:600c:1c1e:b0:439:34e2:455f with SMTP id
 5b1f17b1804b1-4396e6c4c44mr107736705e9.12.1739815362154; 
 Mon, 17 Feb 2025 10:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGhaG+zFUbmbRIQJw0Gc+HzW56blc7MBLz+cDHgmPDgbmM7/z/K4bdXCiwz0IVv1KGH2vemA==
X-Received: by 2002:a05:600c:1c1e:b0:439:34e2:455f with SMTP id
 5b1f17b1804b1-4396e6c4c44mr107736215e9.12.1739815361759; 
 Mon, 17 Feb 2025 10:02:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43984924201sm36366345e9.6.2025.02.17.10.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:02:41 -0800 (PST)
Message-ID: <73883ee3-e85b-40ba-8adf-80f1afe8274d@redhat.com>
Date: Mon, 17 Feb 2025 19:02:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 07/45] vfio/container: vfio_container_group_add
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-8-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1739542467-226739-8-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/14/25 15:13, Steve Sistare wrote:
> Add vfio_container_group_add to de-dup some code.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 47 +++++++++++++++++++++++++----------------------
>   1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c668d07..c5bbb03 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -582,6 +582,26 @@ static bool vfio_attach_discard_disable(VFIOContainer *container,
>       return !ret;
>   }
>   
> +static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
> +                                     Error **errp)
> +{
> +    if (!vfio_attach_discard_disable(container, group, errp)) {
> +        return false;
> +    }
> +    group->container = container;
> +    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> +    vfio_kvm_device_add_group(group);
> +    return true;
> +}
> +
> +static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
> +{
> +    QLIST_REMOVE(group, container_next);
> +    group->container = NULL;
> +    vfio_kvm_device_del_group(group);
> +    vfio_ram_block_discard_disable(container, false);
> +}
> +
>   static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                      Error **errp)
>   {
> @@ -592,20 +612,13 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       VFIOIOMMUClass *vioc = NULL;
>       bool new_container = false;
>       bool group_was_added = false;
> -    bool discard_disabled = false;
>   
>       space = vfio_get_address_space(as);
>   
>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>           if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
> -            if (!vfio_attach_discard_disable(container, group, errp)) {
> -                return false;
> -            }
> -            group->container = container;
> -            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> -            vfio_kvm_device_add_group(group);
> -            return true;
> +            return vfio_container_group_add(container, group, errp);
>           }
>       }
>   
> @@ -632,11 +645,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           goto fail;
>       }
>   
> -    if (!vfio_attach_discard_disable(container, group, errp)) {
> -        goto fail;
> -    }
> -    discard_disabled = true;
> -
>       vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>       assert(vioc->setup);
>   
> @@ -644,12 +652,11 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           goto fail;
>       }
>   
> -    vfio_kvm_device_add_group(group);
> -
>       vfio_address_space_insert(space, bcontainer);
>   
> -    group->container = container;
> -    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> +    if (!vfio_container_group_add(container, group, errp)) {
> +        goto fail;
> +    }
>       group_was_added = true;
>   
>       bcontainer->listener = vfio_memory_listener;
> @@ -669,15 +676,11 @@ fail:
>       memory_listener_unregister(&bcontainer->listener);
>   
>       if (group_was_added) {
> -        QLIST_REMOVE(group, container_next);
> -        vfio_kvm_device_del_group(group);
> +        vfio_container_group_del(container, group);
>       }
>       if (vioc && vioc->release) {
>           vioc->release(bcontainer);
>       }
> -    if (discard_disabled) {
> -        vfio_ram_block_discard_disable(container, false);
> -    }
>       if (new_container) {
>           vfio_cpr_unregister_container(bcontainer);
>           object_unref(container);


