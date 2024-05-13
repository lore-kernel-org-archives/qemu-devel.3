Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6A1C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WFg-0002u8-Ez; Mon, 13 May 2024 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6WFe-0002tB-PU
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6WFb-00051w-OI
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715608916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQGgBUXKtbpDLx7+/NLYGPfp6n3rmsAldIdvBRk7bP4=;
 b=bT7bJ1Uf6re9uxXgvpfkdz8ybhluAd7j50a4+IxfLzsB/ybq8BspGuA7P8zJ+IyiOG00H2
 51FsZzfahYZsBRWYRYiGfdt0zvy6G/Ds+8LLe5OPyvzTompE+KRc0a0mzWJzrWIgOo9MgN
 V/DMa1NvYSsIwS3n7mDWSnhvgA/njr0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-IugvM_M-MBKfur-29T89eA-1; Mon, 13 May 2024 10:01:40 -0400
X-MC-Unique: IugvM_M-MBKfur-29T89eA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43de2f59d09so56217921cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715608893; x=1716213693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CQGgBUXKtbpDLx7+/NLYGPfp6n3rmsAldIdvBRk7bP4=;
 b=CKu4kxptN8aFQxzUgUa8D38YZCrGD/qTZ7P3Jh0sDNEpdXALX4KniPkvumgEEE1LAw
 kFnRjpr+HCFVQE4iT/hAjPpO18NKRy52WvrhhtImzwCf2bP7zOt5ycVyX81nOzac5vvu
 Qi9nxj0KjwoG+ed3jzLG0TUJ8a0OCIJSdFJiYtyrwZD49QprADGqi6JulOMJjqrOId4r
 tPXzEtFiXZOfOS7bG/R/FH9k5B1E0WPzZW0TR7k+X+8VA147yvk9fhn9VLPuULYOO8pp
 hbtORn3ZCzZ3Cdxv4KLKZOT10pfcHqQZqbQiWYCl94BYfaFbyEYLjVXLjO3HLERZOkGd
 Sm5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDnTOGKAOwNFJ7q//2OlYNwyQOMF3Gu3QB3aW1Ox9JaDFSAHpLdd5WBDddMof+mOK6Sm1EXEVEvqSPWcfahoc1RXStv4o=
X-Gm-Message-State: AOJu0Yy0JGx8Zmr41YhphcbeltY0RCXCD51GLwCqnrz+gQ2Si3fpTi8H
 Y8iRg4bSXCHxSS1nrsl0kVnxmC/Hu8nURq91cIBXGJ6N+LX1P+sYmNL4ZWG4xma12lk1pQc1Ea3
 WTV0jikyVtlNjf73cDd5hnYj+NXfWfGrlHyMRePmEVtXJ09v8K6jh
X-Received: by 2002:ac8:58c9:0:b0:43b:70f:64b1 with SMTP id
 d75a77b69052e-43dfdaf7863mr114496661cf.25.1715608892783; 
 Mon, 13 May 2024 07:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjONQQfpd25DUep9OxHbjxYMpwxiCBrfRpouIvJUsZY6FzFtx/kCPbjMZWHI5YK5IK1y5qJA==
X-Received: by 2002:ac8:58c9:0:b0:43b:70f:64b1 with SMTP id
 d75a77b69052e-43dfdaf7863mr114496231cf.25.1715608892357; 
 Mon, 13 May 2024 07:01:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e0bf64844sm28674001cf.62.2024.05.13.07.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:01:31 -0700 (PDT)
Message-ID: <8fe65dfe-dd9c-47c0-8769-3479484b3e5e@redhat.com>
Date: Mon, 13 May 2024 16:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/migration: Emit VFIO migration QAPI event
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
 <20240509090954.16447-3-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240509090954.16447-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/9/24 11:09, Avihai Horon wrote:
> Emit VFIO migration QAPI event when a VFIO device changes its migration
> state. This can be used by management applications to get updates on the
> current state of the VFIO device for their own purposes.
> 
> A new per VFIO device capability, "migration-events", is added so events
> can be enabled only for the required devices. It is disabled by default.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/migration.c           | 56 +++++++++++++++++++++++++++++++++--
>   hw/vfio/pci.c                 |  2 ++
>   3 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..3ec5f2425e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>       bool no_mmap;
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
> +    bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 06ae40969b..5a359c4c78 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -24,6 +24,7 @@
>   #include "migration/register.h"
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
> +#include "qapi/qapi-events-vfio.h"
>   #include "exec/ramlist.h"
>   #include "exec/ram_addr.h"
>   #include "pci.h"
> @@ -80,6 +81,55 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>       }
>   }
>   
> +static VfioMigrationState
> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
> +{
> +    switch (state) {
> +    case VFIO_DEVICE_STATE_STOP:
> +        return QAPI_VFIO_MIGRATION_STATE_STOP;
> +    case VFIO_DEVICE_STATE_RUNNING:
> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING;
> +    case VFIO_DEVICE_STATE_STOP_COPY:
> +        return QAPI_VFIO_MIGRATION_STATE_STOP_COPY;
> +    case VFIO_DEVICE_STATE_RESUMING:
> +        return QAPI_VFIO_MIGRATION_STATE_RESUMING;
> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING_P2P;
> +    case VFIO_DEVICE_STATE_PRE_COPY:
> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void vfio_migration_send_event(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    DeviceState *dev = vbasedev->dev;
> +    g_autofree char *qom_path = NULL;
> +    Object *obj;
> +
> +    if (!vbasedev->migration_events) {
> +        return;
> +    }

I would add an assert on vbasedev->ops->vfio_get_object

> +    obj = vbasedev->ops->vfio_get_object(vbasedev);

and another assert on obj.

> +    qom_path = object_get_canonical_path(obj);
> +
> +    qapi_event_send_vfio_migration(
> +        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
> +}
> +
> +static void set_state(VFIODevice *vbasedev, enum vfio_device_mig_state state)

to avoid the conflict with vfio_migration_set_state(), let's call it :
vfio_migration_set_device_state() ? We want a 'vfio_migration_' prefix.


Thanks,

C.




> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    migration->device_state = state;
> +    vfio_migration_send_event(vbasedev);
> +}
> +
>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>                                       enum vfio_device_mig_state new_state,
>                                       enum vfio_device_mig_state recover_state)
> @@ -125,12 +175,12 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>               goto reset_device;
>           }
>   
> -        migration->device_state = recover_state;
> +        set_state(vbasedev, recover_state);
>   
>           return ret;
>       }
>   
> -    migration->device_state = new_state;
> +    set_state(vbasedev, new_state);
>       if (mig_state->data_fd != -1) {
>           if (migration->data_fd != -1) {
>               /*
> @@ -156,7 +206,7 @@ reset_device:
>                    strerror(errno));
>       }
>   
> -    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
> +    set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
>   
>       return ret;
>   }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b79..8840602c50 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
> +                     vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>                        vbasedev.ram_block_discard_allowed, false),


