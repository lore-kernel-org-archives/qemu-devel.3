Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A31C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjRa-0002j3-VO; Wed, 05 Mar 2025 02:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpjRK-0002ci-U6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:45:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpjRI-0006U1-P0
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741160712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e2l8Iged6IWwB/YCp4Evv0R5wFm6TM1d9NiDie7Max4=;
 b=RCURXqzksLJjyfw55/kwJXcrVyHPAg30beI4Xj/z30kMWAkAyrlD90qTAif0jMVGWVZrsg
 Kql0GTRJ61cs675CjdwR2SjrugmQVsk3haRJr7veLsQag9zttylHrNj5nGsMQQNz9uVZAG
 W5jHZ8LbfIl0QEkC4P6+e2KM4hswMW0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-gluh-mBJOvOydBiCRBjcYA-1; Wed, 05 Mar 2025 02:45:00 -0500
X-MC-Unique: gluh-mBJOvOydBiCRBjcYA-1
X-Mimecast-MFC-AGG-ID: gluh-mBJOvOydBiCRBjcYA_1741160699
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390f7db84faso3226107f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741160699; x=1741765499;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2l8Iged6IWwB/YCp4Evv0R5wFm6TM1d9NiDie7Max4=;
 b=sz7nnvCz4jRQqIlZ9KsyU1+M1H/PrBTdkDE1uDKQ33N68gnR7uL7sjEnMhl3Yp5fhq
 WwA/Y15WieWfuqVODCxDUtdrGzKZpBLUpk0VX2nrn78TvV4LdWViQRVEkuLLHOG/Y1OA
 LeNl/NzNpHmZNS7pnOLmW4ICpTrXcs3LfeZp4NyakWqJ3vGGCXNhFuk4Nbkw4l2+pH7P
 x0OegxpUDe5l3J/1RXOnJPXzNk1Ao0OYT+EMsfHmfs4p1vcZJZ7nigpnR0lBGhw5/R8p
 i0Mlf4ruAxSJfJeLC5THgz4//clgG8X803YACVzSyXHNsNpS/0ii9IZSRbzqUWLwKawj
 RkCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfj3PrnGQiLL0HN67kupamcFb0BRovkuzwWkfpiub2zTpOEKkUMaoviA0jimia/nEw0BL6TORZyRvJ@nongnu.org
X-Gm-Message-State: AOJu0YysQzfXnnBjqnwE2U14Q4yvDI0LbcTgvxhFQQzMoE+NKHDYg+2u
 mcdKGOP2ccTh/1qDD8/ZQiunNMmYGfEdHDQi0fkjh+gjqev4AfVBlEugGXYQaWsE0msz5M7EqHm
 XbgjWIgOIulQDZ6V2a2ZWWOLzOXQCtQE/leQQ9IMy8sTz3uKcXRF7
X-Gm-Gg: ASbGncuTZ9c076E7jRN8OqRNBUfJoaUM5fme1kAYfjJQIv2/IS4t71fU3PURmSnU6mI
 TdJqth5ZFNSTRGLXiB4rvN1P6u9bz/VSiy2Hdg+9Q5CrRYKNxakaQ/xZzcJzCyRjcLXX2swSa7u
 C4oEPDqu7EC87CjfZNPt4hkL4YIAm0Y4AwYpoNBIykMkA+FKLP+q4NLLdSk7ouiPFcJwgpPAr1y
 /0rRTH7an8bPmQMezJ5x3kK/lNwhrrotMczT0M5wRGEZrfEvmj45kZRybm4GbGVXAECWdrCp+z6
 cONoZEyiEhB6gPMD1+8xCUzSy0NwJlkzKjjaoZaoo26+xw9AEXqZDw==
X-Received: by 2002:a05:6000:156d:b0:390:debd:70c3 with SMTP id
 ffacd0b85a97d-3911f7caa1fmr1526087f8f.54.1741160699450; 
 Tue, 04 Mar 2025 23:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJJQkOFSVFpzrtI3IuhyWni5GiBpj8carLXucHrMlJC9MVRA3lVOa7XKXDluL7Fxl8tUIqYw==
X-Received: by 2002:a05:6000:156d:b0:390:debd:70c3 with SMTP id
 ffacd0b85a97d-3911f7caa1fmr1526064f8f.54.1741160699011; 
 Tue, 04 Mar 2025 23:44:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4796051sm20507341f8f.12.2025.03.04.23.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 23:44:58 -0800 (PST)
Message-ID: <1fe40fc1-c7b9-4caa-8067-2d7e47d0a0ad@redhat.com>
Date: Wed, 5 Mar 2025 08:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/36] vfio/migration: Multifd device state transfer
 support - basic types
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4eedd529e6617f80f3d6a66d7268a0db2bc173fa.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4eedd529e6617f80f3d6a66d7268a0db2bc173fa.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/4/25 23:03, Maciej S. Szmigiero wrote:
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


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/meson.build         |  1 +
>   hw/vfio/migration-multifd.c | 33 +++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h | 17 +++++++++++++++++
>   hw/vfio/migration.c         |  1 +
>   4 files changed, 52 insertions(+)
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
> index 000000000000..fa594b33fdd1
> --- /dev/null
> +++ b/hw/vfio/migration-multifd.c
> @@ -0,0 +1,33 @@
> +/*
> + * Multifd VFIO migration
> + *
> + * Copyright (C) 2024,2025 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> index 000000000000..5b221c6e16b0
> --- /dev/null
> +++ b/hw/vfio/migration-multifd.h
> @@ -0,0 +1,17 @@
> +/*
> + * Multifd VFIO migration
> + *
> + * Copyright (C) 2024,2025 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_MIGRATION_MULTIFD_H
> +#define HW_VFIO_MIGRATION_MULTIFD_H
> +
> +#include "hw/vfio/vfio-common.h"
> +
> +#endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index a9b0970604aa..dc1fe4e717a4 100644
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


