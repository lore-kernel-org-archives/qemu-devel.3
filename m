Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BAFC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfc2P-0003in-Ki; Thu, 29 Feb 2024 03:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfc2J-0003Z9-Tt
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfc2H-0007ZC-Tm
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709196300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkYq0TLEXHSmUZvdY6ziO2pUvqEWPfR79c57rCNmp00=;
 b=ceJRLzML5wpruA0HBSQtXe9gVWIlPVC4E+D05zeU5CvciXJiOk7mbnum8uF/g5kcu7cAiI
 CD3hmc42RZeanCoFSZxuCGkE4E/X1pET3djpbyE2mjv6tLtKAKSTR2av0OyuYk1bshfiBc
 ZPJpl9FC8n2Bx7SB56qOBXCK8nl0xSg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-R6kXiApTMfaOvB1WwLuH4A-1; Thu, 29 Feb 2024 03:44:57 -0500
X-MC-Unique: R6kXiApTMfaOvB1WwLuH4A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42eb8c93f23so6671631cf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 00:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709196297; x=1709801097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NkYq0TLEXHSmUZvdY6ziO2pUvqEWPfR79c57rCNmp00=;
 b=ODF2cvhAdHLeMVe8gk7mopyNqxulILNBXeuYYpdM20T6ZK9C95GK22EaUqrloGCxV8
 41kxLa6ASCZADSotoNZbqrwOFKAUM9/qOjz0tcd8NnXXCDaf99Vs16s+ccheVvrxccoG
 BEZShAe2Lo2z+GPhmmhaWKuAEDqYyMBJSfc9tx673H4eNApPCXmDoX7RWTFOampnCx/W
 Fxma3+SlQW7+lTjbI+/1XsNlhBZt0+/0ziCeOy0PoN3QtUyaKf8tVm5JqqvLQswaA1nq
 ncHbhnABwLyl5zAVSCArTq9vigWvF2LqT+CuRNsYVONB81r2jRul1YPzH3Bzw2+wwH09
 /sjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUQ1FjD8Rk41e6M33lClUa7Z9aCZJSyC2vkhv0QBfgV4A9JGDiSQ5W1GwHXjTP5IpqEJrAZCIgnDNJKZdXk18FwUVQJb4=
X-Gm-Message-State: AOJu0Yy5w2Qwleo/lePRWiB7VtvLuX9QezJ8H9M1TAYx3k4DLfzKtQwB
 mE5GyQ3gLLYPamyaM15nmVCsgAc7GgQH3Xr+Xl4KaaU7W+DSz/ZAorO2Z4EOqMc+8z8NxrdNOcj
 qUghvvFxLKiaqvQjf2PQP9m8Bbn8eSy58Z1yFU824X0fmxan3WxyT
X-Received: by 2002:ac8:5c81:0:b0:42e:b75c:e02d with SMTP id
 r1-20020ac85c81000000b0042eb75ce02dmr1404988qta.5.1709196297305; 
 Thu, 29 Feb 2024 00:44:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHEaevzT4+B2QhTylBX1BJxgz2bnB/adjG1QpdknF6u1eHhIx5DGEWlc1kxbYRl2JuO/L7CA==
X-Received: by 2002:ac8:5c81:0:b0:42e:b75c:e02d with SMTP id
 r1-20020ac85c81000000b0042eb75ce02dmr1404979qta.5.1709196297046; 
 Thu, 29 Feb 2024 00:44:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x2-20020ac87302000000b0042e6be98dbasm505187qto.31.2024.02.29.00.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 00:44:56 -0800 (PST)
Message-ID: <3fa83623-04b8-4cfd-af4f-f783f8fd9ec1@redhat.com>
Date: Thu, 29 Feb 2024 09:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 12/14] vfio: allow cpr-reboot migration if suspended
Content-Language: en-US, fr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-13-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <1708622920-68779-13-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/22/24 18:28, Steve Sistare wrote:
> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> guest drivers' suspend methods flush outstanding requests and re-initialize
> the devices, and thus there is no device state to save and restore.  The
> user is responsible for suspending the guest before initiating cpr, such as
> by issuing guest-suspend-ram to the qemu guest agent.
> 
> Relax the vfio blocker so it does not apply to cpr, and add a notifier that
> verifies the guest is suspended.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




> ---
>   hw/vfio/common.c                      |  2 +-
>   hw/vfio/cpr.c                         | 20 ++++++++++++++++++++
>   hw/vfio/migration.c                   |  2 +-
>   include/hw/vfio/vfio-container-base.h |  1 +
>   4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 059bfdc..ff88c3f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>       error_setg(&multiple_devices_migration_blocker,
>                  "Multiple VFIO devices migration is supported only if all of "
>                  "them support P2P migration");
> -    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
>   
>       return ret;
>   }
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 3bede54..392c2dd 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -7,13 +7,33 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "migration/misc.h"
>   #include "qapi/error.h"
> +#include "sysemu/runstate.h"
> +
> +static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
> +                                    MigrationEvent *e, Error **errp)
> +{
> +    if (e->type == MIG_EVENT_PRECOPY_SETUP &&
> +        !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
> +
> +        error_setg(errp,
> +            "VFIO device only supports cpr-reboot for runstate suspended");
> +
> +        return -1;
> +    }
> +    return 0;
> +}
>   
>   int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
>   {
> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
> +                                vfio_cpr_reboot_notifier,
> +                                MIG_MODE_CPR_REBOOT);
>       return 0;
>   }
>   
>   void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>   {
> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>   }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 50140ed..2050ac8 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -889,7 +889,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>       vbasedev->migration_blocker = error_copy(err);
>       error_free(err);
>   
> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
> +    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
>   }
>   
>   /* ---------------------------------------------------------------------- */
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index b2813b0..3582d5f 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -49,6 +49,7 @@ typedef struct VFIOContainerBase {
>       QLIST_ENTRY(VFIOContainerBase) next;
>       QLIST_HEAD(, VFIODevice) device_list;
>       GList *iova_ranges;
> +    NotifierWithReturn cpr_reboot_notifier;
>   } VFIOContainerBase;
>   
>   typedef struct VFIOGuestIOMMU {


