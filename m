Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626BEC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjQL-0008VY-Ve; Wed, 05 Feb 2025 12:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfjQJ-0008VI-My
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfjQH-0002PO-HR
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738777368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Sn+Z7o57nvavXN002dEuiQDCvDtqMHUi+7yQjtK3OLw=;
 b=LlOC85zzUOOmVm2ckbDcXKG4KIbkAv4VxyUyFiFMJUgcMQ+fUhqFkaLfZ2baFUglZ3qxJf
 RUNyjwxeQmTz6ETfPHYzlfH7P9LaDxWHtF9c0K5N2mke089rHWgRM5qD2fKcFYtOA5e39/
 3Ch99NSlVLe9eYvG5CW+PGhDuXAP8UE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-eb68K5_aNbiLGoCBiN44ZQ-1; Wed, 05 Feb 2025 12:42:47 -0500
X-MC-Unique: eb68K5_aNbiLGoCBiN44ZQ-1
X-Mimecast-MFC-AGG-ID: eb68K5_aNbiLGoCBiN44ZQ
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e429634330so38126d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738777366; x=1739382166;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sn+Z7o57nvavXN002dEuiQDCvDtqMHUi+7yQjtK3OLw=;
 b=r9AZ/RfcytZIXu8d3miiuWxgQ430yYoRR7qSt60sIRguaD+DmN/TkjzBXQo5rV3Kxv
 kOGL4YmvTtsO9TXaOvY1PM2vq3l3hgOU0dbC+AWzvg0rxzwMWq7IsBQerPXYZ6KsEJBI
 IOhfko61a3EFoMGQFshaLwqCEc/afFXFvQJJvrtip6LcFKymnSBcbZzd80Ar0LGFIh94
 eu8AxZl1xVkyEe1ibJaMrYdAXSj9/+xAETm1LMErWSz0G2VQ1rXniFSXeIPpFK4beg2v
 cthKdUFsgTVpa9ckPp/mVsJRqaww0O5u3s705wd/XFB5G+AhFEACqI7G0GbByF6GXl0U
 HD6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6cHTvJCJUiuRqf7cOJxV9itA/WKnszqMkqP7jLbaP5rUKVafdEqgAmtSVyvbvifGCeLoQxL/NBnIe@nongnu.org
X-Gm-Message-State: AOJu0YwPrpvaDqpSMFeC5KMhzBYZ1Ogp56ebIRV1DOptUpbe+uUTmYWo
 zTVgVAYPLoSV3T5OANtMnLop0z9u1Luo1gZH1EqFJL8C4dBU7TmPkYFuOFn0IsT9k63m+d3VaLk
 12lr51hrcQ/cDUp79HxNXnGi5FVhf9hFjEY40i9NmVIzv9rMXNK45
X-Gm-Gg: ASbGncsCchdl14CO3Pf02aBt81CURbdFpZabCCtx9ZgNHzZ2ESmdlf+718NRJ9SELo5
 dtQ5r1UjFElqPhyME7SZRht34xMNxF8K6wxnSaqDCT3N+0OjgRZsJLkHknolC6FBObwiGB1ULud
 Q3YyPPLZRD+68l7Rdevf5we+4QMRGl2t0GvEhqfwGA5fJe6XRYNR0JFA0XW+t4qEt6AUpjGnLKm
 42KvFyU+jjRl5r8m8NzIOr0omyB1ZdJsrWR+NauYbd3uhGT7UR55OfTFdUXsZ+I+6c/xG9pOB9z
 1MzIWGC6tzgGYt5a0S/FusgoEx1JPnVwUWqRmrVBbWU=
X-Received: by 2002:a05:6214:f05:b0:6d8:e7c9:ffa0 with SMTP id
 6a1803df08f44-6e439b7bfd1mr1921896d6.19.1738777366483; 
 Wed, 05 Feb 2025 09:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq0tutKx1oW8RcTXvg59pjYCrB04XOVXbJa6wu/Fk9KTZWdsYF2pOKgB7bna6Yl4sDlRuS+g==
X-Received: by 2002:a05:6214:f05:b0:6d8:e7c9:ffa0 with SMTP id
 6a1803df08f44-6e439b7bfd1mr1921636d6.19.1738777366182; 
 Wed, 05 Feb 2025 09:42:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2549222cesm75757886d6.83.2025.02.05.09.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:42:45 -0800 (PST)
Message-ID: <6b0a3435-dfcf-496c-8cbf-521cbb500c5a@redhat.com>
Date: Wed, 5 Feb 2025 18:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 22/26] vfio/iommufd: invariant device name
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-23-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-23-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/29/25 15:43, Steve Sistare wrote:
> cpr-transfer will use the device name as a key to find the value
> of the device descriptor in new QEMU.  However, if the descriptor
> number is specified by a command-line fd parameter, then
> vfio_device_get_name creates a name that includes the fd number.
> This causes a chicken-and-egg problem: new QEMU must know the fd
> number to construct a name to find the fd number.
> 
> To fix, create an invariant name based on the id command-line
> parameter.  If id is not defined, add a CPR blocker.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/helpers.c             | 18 +++++++++++++++---
>   hw/vfio/iommufd.c             |  2 ++
>   include/hw/vfio/vfio-common.h |  1 +
>   3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 913796f..bd94b86 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -25,6 +25,8 @@
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/hw.h"
>   #include "trace.h"
> +#include "migration/blocker.h"
> +#include "migration/cpr.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/units.h"
> @@ -636,6 +638,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>   {
>       ERRP_GUARD();
>       struct stat st;
> +    bool ret = true;
>   
>       if (vbasedev->fd < 0) {
>           if (stat(vbasedev->sysfsdev, &st) < 0) {
> @@ -653,15 +656,24 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>               return false;
>           }
>           /*
> -         * Give a name with fd so any function printing out vbasedev->name
> +         * Give a name so any function printing out vbasedev->name
>            * will not break.
>            */
>           if (!vbasedev->name) {
> -            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
> +            if (vbasedev->dev->id) {
> +                vbasedev->name = g_strdup(vbasedev->dev->id);
> +            } else {
> +                vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
> +                error_setg(&vbasedev->cpr_id_blocker,
> +                           "vfio device with fd=%d needs an id property",
> +                           vbasedev->fd);
> +                ret = migrate_add_blocker_modes(&vbasedev->cpr_id_blocker, errp,
> +                                                MIG_MODE_CPR_TRANSFER, -1) == 0;

cpr helper please.



> +            }
>           }
>       }
>   
> -    return true;
> +    return ret;
>   }
>   
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 2f888e5..8308715 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -24,6 +24,7 @@
>   #include "system/reset.h"
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
> +#include "migration/blocker.h"
>   #include "pci.h"
>   #include "exec/ram_addr.h"
>   
> @@ -657,6 +658,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>       iommufd_cdev_container_destroy(container);
>       vfio_put_address_space(space);
>   
> +    migrate_del_blocker(&vbasedev->cpr_id_blocker);
>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>       close(vbasedev->fd);
>   }
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ca10abc..37e7c26 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -147,6 +147,7 @@ typedef struct VFIODevice {
>       VFIOMigration *migration;
>       Error *migration_blocker;
>       Error *cpr_mdev_blocker;
> +    Error *cpr_id_blocker;

a struct VFIODeviceCPR would be welcome.


Thanks,

C.



>       OnOffAuto pre_copy_dirty_page_tracking;
>       OnOffAuto device_dirty_page_tracking;
>       bool dirty_pages_supported;


