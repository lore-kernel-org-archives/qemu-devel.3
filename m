Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BADFC25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dzA-0004cH-73; Thu, 16 May 2024 12:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7dz8-0004Tf-7s
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7dz5-0004Ur-Dq
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715876974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lw4eYNSsBXax5h/YJpdKy77ihwv8nkl35GUPcO6lkoo=;
 b=GQicDr+t6/gjE4mgOnFo3TnvmirxPPtuIABucMVZ7Y3zmAqKeoC7qBAerQVR+Qt1p4+/lV
 3lE4o0h20S1QMxrj/0+nwUmSbQtuOpPOEtsr2fK66NUD6ZtyKRzamIWG7tT3QZ1EHny+Nx
 kUTVcuBebZ7KahI95vBykGygnG04Qfc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-ksZxD4oENDWJljE9-RR53w-1; Thu, 16 May 2024 12:29:33 -0400
X-MC-Unique: ksZxD4oENDWJljE9-RR53w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43d873466b6so92930681cf.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 09:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715876973; x=1716481773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lw4eYNSsBXax5h/YJpdKy77ihwv8nkl35GUPcO6lkoo=;
 b=prqOkVGanBeR+4e2DA9OrX9iutBXatOLtlVyyaPwu/Vz4ICPwXvevE+xV7NAuXuzSA
 0Z8iwHuc7MNj+iH8Z/JnSkLCwqTQ7U7Ybu13VQq5TW8GLb3apBkDm4+793TdSehOiiEl
 9EXbLoeh0s+Dr9COtGKUZ2M+zTiaHyrqmvuZVDI09MdAKYUAKBIjPVODwnRIEitBZ7oj
 uZcjSwRvlyieC2fAQOwtJ1yUs8K5n/UjVRcA2fTTChZ/P8+yq9okv1iw3ZSCiDraFn+O
 60wMtqnCVbkd+eD+/2q6PToX5KGHlDz+jFohd4VcldgFT0lAVKlK+es89QkJj1GtPgbp
 javA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEhn8OEmS9qyJjLUi/OfsHkTLaoxq8B3OlJliftZygDcabUkgZt/0FhwZExuBq5TuFT0JRPd0qq592vmkA+Qcs7Bcaujc=
X-Gm-Message-State: AOJu0YyCk95bVemoVVrJQka2/OWZZxGiKRJq604Yspo2vh/7cknixpu9
 CkM3CUUaKhpJP7di3XJtmpkpgVZ7pNOi5+vtYH6FpeG73cFZe/OsDVQ/XzUIMKdbouJiI/3Oo6d
 bOKgJ8EehP7i/dnZjmMoja6eYRgR9X8BrV4qxUzEYlHzMCvR/KZo/
X-Received: by 2002:a05:622a:24d:b0:43d:e71e:9772 with SMTP id
 d75a77b69052e-43dfdb2b230mr183374271cf.40.1715876972767; 
 Thu, 16 May 2024 09:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG9CVGcf3Oy4uArIc8AqTmKy7X/pzh0E9/M7n+lJJuA/DkQmGbDXwATRKvALWC00QTYKUkSw==
X-Received: by 2002:a05:622a:24d:b0:43d:e71e:9772 with SMTP id
 d75a77b69052e-43dfdb2b230mr183374031cf.40.1715876972384; 
 Thu, 16 May 2024 09:29:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df8308580sm96620421cf.66.2024.05.16.09.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 09:29:31 -0700 (PDT)
Message-ID: <bff59c81-35e8-40c4-86a6-1f571073d61d@redhat.com>
Date: Thu, 16 May 2024 18:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] qapi/vfio: Add VFIO migration QAPI event
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240515132138.4560-1-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515132138.4560-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

On 5/15/24 15:21, Avihai Horon wrote:
> Hello,
> 
> This series adds a new QAPI event for VFIO device migration state
> change. This event will be emitted when a VFIO device changes its
> state, for example, during migration or when stopping/starting the
> guest.
> 
> This event can be used by management applications to get updates on the
> current state of the VFIO device for their own purposes.
> 
> A new per VFIO device capability, "migration-events", is added so events
> can be enabled only for the required devices. It is disabled by default.
> 
> Feedback/comments are appreciated,


Applied to vfio-next.

Thanks,

C.


> 
> Thanks.
> 
> Changes from v2 [2]:
> * Added assert for vbasedev->ops->vfio_get_object and obj. (Cedric)
> * Renamed set_state() to vfio_migration_set_device_state(). (Cedric)
> * Enhanced tracing of device state change. (Cedric)
> * Added Cedric's R-b.
> 
> Changes from v1 [1]:
> * Added more info to patch #1 commit mesasge. (Markus)
> * Renamed VFIODeviceMigState to VfioMigrationState and
>    VFIO_DEVICE_MIG_STATE_CHANGED to VFIO_MIGRATION. (Joao, Markus)
> * Added qom-path and qdev id to VFIO_MIGRATION event data. (Markus)
> * Handled no-op state transitions in vfio_migration_set_state().
>    (Cedric)
> * Added helper to set VFIO state and emit VFIO event. (Peter)
> 
> [1]
> https://lore.kernel.org/qemu-devel/20240430051621.19597-1-avihaih@nvidia.com/
> 
> [2]
> https://lore.kernel.org/qemu-devel/20240509090954.16447-1-avihaih@nvidia.com/
> 
> Avihai Horon (4):
>    qapi/vfio: Add VFIO migration QAPI event
>    vfio/migration: Emit VFIO migration QAPI event
>    vfio/migration: Don't emit STOP_COPY VFIO migration QAPI event twice
>    vfio/migration: Enhance VFIO migration state tracing
> 
>   MAINTAINERS                   |  1 +
>   qapi/qapi-schema.json         |  1 +
>   qapi/vfio.json                | 67 +++++++++++++++++++++++++++++++++
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/migration.c           | 71 ++++++++++++++++++++++++++++++++---
>   hw/vfio/pci.c                 |  2 +
>   hw/vfio/trace-events          |  3 +-
>   qapi/meson.build              |  1 +
>   8 files changed, 141 insertions(+), 6 deletions(-)
>   create mode 100644 qapi/vfio.json
> 


