Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F85C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnD9m-0000QD-TT; Wed, 26 Feb 2025 03:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnD9m-0000Q3-Ap
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:52:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnD9k-0007BT-37
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740559957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I1eoAPvwdMHAxsridXUmI7xuHlHLqnsvumOwC/AaK4k=;
 b=GRqR+y1msVYOqYZu/RE9UvAwnpxcnTRh3fiXvfwFGb2a/bpYdv8u3HwvaxWyjFSpySuXur
 2fi02aA5SLTm9+EcNidCoyZMn8leD/ZDH4/PN4coru1PEDDJ5PF2Fva8H4jZLpSrJfyi7t
 +CW2a8jbGjlwPUzCfCcM6f/vUyjgn/8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-OTiMPjIDOASKkO_0V_KgHg-1; Wed, 26 Feb 2025 03:52:35 -0500
X-MC-Unique: OTiMPjIDOASKkO_0V_KgHg-1
X-Mimecast-MFC-AGG-ID: OTiMPjIDOASKkO_0V_KgHg_1740559954
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f455a8fcaso4696572f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 00:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740559954; x=1741164754;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1eoAPvwdMHAxsridXUmI7xuHlHLqnsvumOwC/AaK4k=;
 b=wwL2wXP0ibx8Y58780eBXDkO3vPhpMAiK1mvvmNrCp/EO6oloW/j8MQbPsbgdsnQ7W
 KJkFbOwpXQktqmplrZ3KgqbXeWkKJupmRyUvWTGbv+BdbEJV67qEhH5RMglz9XLl193v
 nQYj8ayhyxMv0ibQQ1PDLuA52q1icUITtqcjUJ4unx4yZ3fnkmrvvwP5r4+NTwNh/9DM
 Z8hgnanRv/XwIeW0UWIAa39UPNPyHGY8B9wULVr2Bh1JqIZ21mmxqajjzAK1ePdZ1YG/
 hjuGN224xtuuvFfRYU6Gv4kbjwTHsTAiVfHbnetT6r+TpxEQaHC6i3NcqdFdsJz02ykz
 S5cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4SNno+5aLejC+HxU62gpQ9Nfvxs06Y1YZyzPgmamBx3Bh8fA0ZS4gm9Yw/gpu8m3xnk7d5Awg1ArW@nongnu.org
X-Gm-Message-State: AOJu0YxQGH7TByiEusucxjKmiN0NnOXZYyAeQLgzQXOiB7HTrahYqZah
 MvazJsKEzEjzXws05S7jgl3sepQPhGpybzKwRIwvpmqJQjWZfoqnkYG08DL2vVbQDtbgziPfviL
 CAROCH29Tvk5FWL2viWYZvXybSSkYU3jXbAWwMOA+McT+vktnD/Ox
X-Gm-Gg: ASbGncvv1FaNxL22Pq6JCH0wikLhagEkyW+SPv+cS8B3o8lfpkCtbIMHMp07H5pH5jR
 25s1gISomFgWG31SEGOfA5I3K+9fw36gPq01ZkmoEqlitZY+ZsQ9kmJ+rPCLKRfZRdo42nduD+7
 jTyNVk1CWjxB2UkkucOnMmKqefOZSNi97Z8AegvLjSZ7QDv0i+nasRQteDWtzmLvgBHEGOLRKQj
 VqC/t0ifmtWdTeys8oJZZgT8Dwg8MoQTm5MAcLthG1CXVbR5tC+cWkpnLyaRPGlTNOq0IcrOeZN
 YedGVFVUrLKn4kw6Yd1qXgK99sIVKilUkIrN2kn+N3qZnZNJi9DWYZlSSHA=
X-Received: by 2002:a05:6000:1f82:b0:38c:5cd0:ecd5 with SMTP id
 ffacd0b85a97d-390d4f8b468mr1959355f8f.38.1740559954050; 
 Wed, 26 Feb 2025 00:52:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVWs/jZUGmxmOkb4GNKGoSiOkN/Yg+5S/DqPqfFYYCoyjdaKYbWyR6pcgd2JRWEjM8Ryd8HA==
X-Received: by 2002:a05:6000:1f82:b0:38c:5cd0:ecd5 with SMTP id
 ffacd0b85a97d-390d4f8b468mr1959341f8f.38.1740559953705; 
 Wed, 26 Feb 2025 00:52:33 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532bb1sm13419825e9.9.2025.02.26.00.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 00:52:33 -0800 (PST)
Message-ID: <cfbff71b-3183-4291-ba00-90b8bb2c3529@redhat.com>
Date: Wed, 26 Feb 2025 09:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/36] vfio/migration: Multifd device state transfer
 support - basic types
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <b93731a2e5b4d6fcb673606cfd19178525204c19.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b93731a2e5b4d6fcb673606cfd19178525204c19.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Add basic types and flags used by VFIO multifd device state transfer
> support.
> 
> Since we'll be introducing a lot of multifd transfer specific code,
> add a new file migration-multifd.c to home it, wired into main VFIO
> migration code (migration.c) via migration-multifd.h header file.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/meson.build         |  1 +
>   hw/vfio/migration-multifd.c | 31 +++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h | 15 +++++++++++++++
>   hw/vfio/migration.c         |  1 +
>   4 files changed, 48 insertions(+)
>   create mode 100644 hw/vfio/migration-multifd.c
>   create mode 100644 hw/vfio/migration-multifd.h
> 
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index bba776f75cc7..260d65febd6b 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -5,6 +5,7 @@ vfio_ss.add(files(
>     'container-base.c',
>     'container.c',
>     'migration.c',
> +  'migration-multifd.c',
>     'cpr.c',
>   ))
>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> new file mode 100644
> index 000000000000..0c3185a26242
> --- /dev/null
> +++ b/hw/vfio/migration-multifd.c
> @@ -0,0 +1,31 @@
> +/*

Please add :

   SPDX-License-Identifier: GPL-2.0-or-later

in new files.


Thanks,

C.




> + * Multifd VFIO migration
> + *
> + * Copyright (C) 2024,2025 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "migration/misc.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/lockable.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/thread.h"
> +#include "migration/qemu-file.h"
> +#include "migration-multifd.h"
> +#include "trace.h"
> +
> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
> +
> +#define VFIO_DEVICE_STATE_PACKET_VER_CURRENT (0)
> +
> +typedef struct VFIODeviceStatePacket {
> +    uint32_t version;
> +    uint32_t idx;
> +    uint32_t flags;
> +    uint8_t data[0];
> +} QEMU_PACKED VFIODeviceStatePacket;
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> new file mode 100644
> index 000000000000..64d117b27210
> --- /dev/null
> +++ b/hw/vfio/migration-multifd.h
> @@ -0,0 +1,15 @@
> +/*
> + * Multifd VFIO migration
> + *
> + * Copyright (C) 2024,2025 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_VFIO_MIGRATION_MULTIFD_H
> +#define HW_VFIO_MIGRATION_MULTIFD_H
> +
> +#include "hw/vfio/vfio-common.h"
> +
> +#endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 46adb798352f..7b79be6ad293 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -23,6 +23,7 @@
>   #include "migration/qemu-file.h"
>   #include "migration/register.h"
>   #include "migration/blocker.h"
> +#include "migration-multifd.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-events-vfio.h"
>   #include "exec/ramlist.h"
> 


