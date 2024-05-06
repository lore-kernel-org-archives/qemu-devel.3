Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECAFC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 14:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3zVJ-0001Lb-TE; Mon, 06 May 2024 10:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3zVF-0001LD-5U
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3zVD-0006cE-Bz
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715006377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBt8s9YJz83wEYf4XU97Hn39O1i06e0RtM3LvXKpOYM=;
 b=Ig1m1u3tdFVCV0rkV4FASyOOGWCBqvFtNMVu1fRdyMr52kuhVJ3+JfzN1ZUCXmc6hwjb+5
 86yEHxc55N26yi8HlZ+KmL36zU5+O4hIPRzHCXAstYYnpU0OQFcxaccjK9FutfpA494zT6
 M8rsdx5Tnf3Gz/Q9ZuUO57w405wJjqg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-DP5DvT8UN966DXLNdgmY5A-1; Mon, 06 May 2024 10:39:36 -0400
X-MC-Unique: DP5DvT8UN966DXLNdgmY5A-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c70bd60240so1361302b6e.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 07:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715006375; x=1715611175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GBt8s9YJz83wEYf4XU97Hn39O1i06e0RtM3LvXKpOYM=;
 b=vUqthzTcvDGIskuLcdOELpZhd4qTzrmx3I2Q72/3LxUSEFV9rM61ONr8GL75Esdeb8
 O3I8wrqLlRbXxfvzvcUjSRo5n5g/o+wIr334O3Ej88iu96g8MsKw6iDDaW57lnckPG00
 xHwbt7HeCW0laHMQVOD1ecbraXS70nmPRRUwq4R8SedX/oH5Kv8H3QIVD5+BodzAoia/
 pFymgMqxtq5lcdZeKcEFeyX5wPwRn+gEtF2reoXZIf1p26Wlm6T2uEd9IJoKPbKBKCE/
 lGaRyRWt5ADBbDJ7pssnraOgdLkO7jl6iHP+iydZlrsxkGhox0b9hRzge0z3BeegAlTK
 FLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2d2il5MfWHkL8IMwtxCcp7BTAm0d9zD8HqDPuAAMe52Po8pP7z2LNugivBDDQQq0sRmdtzoXU2hfmiRf0zaSrWmEfxuM=
X-Gm-Message-State: AOJu0YxER4ODDjbl1CzyAS7SzAeOnnRFyJxKckTeLkx/nHx357XtFzVw
 TWKpxmr4X47y858rF58DwwXjT+UTqunuDVy2XN2kNTrvPS8tCNGeIqPcwlXgoWXts/4DGKzHVDB
 qs696ipCCrl9o2NPGJCwjAuu+SnkvpQDmsUS0Kjn1Di0tIDjVfgY5
X-Received: by 2002:a05:6808:690:b0:3c7:5292:33f5 with SMTP id
 k16-20020a056808069000b003c7529233f5mr10328185oig.31.1715006375566; 
 Mon, 06 May 2024 07:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu8ktk8ttnxun8QOQqhTMzqNtxnlNo96+8jjslD/h1nl6qSz/giAaXhg+DK52G3GZHzCFmSA==
X-Received: by 2002:a05:6808:690:b0:3c7:5292:33f5 with SMTP id
 k16-20020a056808069000b003c7529233f5mr10328155oig.31.1715006375152; 
 Mon, 06 May 2024 07:39:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 mz4-20020a0562142d0400b006a0d0d792cesm3785181qvb.83.2024.05.06.07.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 07:39:34 -0700 (PDT)
Message-ID: <1feeec7c-8b53-40f8-8db7-40ea5425bb39@redhat.com>
Date: Mon, 6 May 2024 16:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio/migration: Don't emit STOP_COPY state change
 event twice
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-4-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240430051621.19597-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Hello Avihai,

On 4/30/24 07:16, Avihai Horon wrote:
> When migrating a VFIO device that supports pre-copy, it is transitioned
> to STOP_COPY twice: once in vfio_vmstate_change() and second time in
> vfio_save_complete_precopy().
> 
> The second transition is harmless, as it's a STOP_COPY->STOP_COPY no-op
> transition. However, with the newly added migration state change QAPI
> event, the STOP_COPY state change event is undesirably emitted twice.
> 
> Prevent this by conditionally transitioning to STOP_COPY state in
> vfio_save_complete_precopy().
> 
> Note that the STOP_COPY transition in vfio_save_complete_precopy() is
> essential for VFIO devices that don't support pre-copy, for migrating an
> already stopped guest and for snapshots.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 6bbccf6545..30a2b2ea74 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -591,14 +591,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       ssize_t data_size;
>       int ret;
>   
>       /* We reach here with device state STOP or STOP_COPY only */
> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP);
> -    if (ret) {
> -        return ret;
> +    if (migration->device_state == VFIO_DEVICE_STATE_STOP) {

Shouldn't we handle no-op transitions in vfio_migration_set_state()
instead ?

Thanks,

C.



> +        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> +                                       VFIO_DEVICE_STATE_STOP);
> +        if (ret) {
> +            return ret;
> +        }
>       }
>   
>       do {


