Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21B5C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WYg-0006jA-PM; Mon, 13 May 2024 10:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6WYe-0006is-43
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6WYb-0000k5-Dy
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715610096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROnJEd+NY5tmbirGFDuGuh4vgsUPwZ69j5GRcKzJOjM=;
 b=J7y0uGDHJiQLM+0i7AsF4xB2HVybg878oUOuFRW4ndgSzkX3PJHAXAus7m/fpm11SFp5Pv
 KoiEQnsgPybZOMuQr7Aj1ZlcV6gaMz+ZEe1u6YyXH75rvESOBmos+W6IsMtR08V+hVkFO1
 NcSCPweBRk0v/jGM8R288LatXdRgkuw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-ceRE5oaVPamEzixXU5En4g-1; Mon, 13 May 2024 10:13:51 -0400
X-MC-Unique: ceRE5oaVPamEzixXU5En4g-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43e0e0dab52so33858611cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715609631; x=1716214431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ROnJEd+NY5tmbirGFDuGuh4vgsUPwZ69j5GRcKzJOjM=;
 b=WWP0BbMQG1H3BL1uzBOcah/VkISEw9gLG96Qc/IcJ7tgDuKvxoDcu7QtFUz69kUWdW
 eAU2BP6E+MCFqN/Ar6QCCfoo4fv2OgdI4yI6aBNcPHbC3dwGurgflmZykxATYwufc5ds
 sdIYp0ZrMYfrRoFpfwpXCd7++PYsLYkPypesvK7D/4PpceldKecefV5GWi0TXRoN4FJU
 6Ems0OCei2Y5h2j7dz2MnhntLQ3nBuIGRtoTR6MG77lmErGJ674akC34ki2hEOAY6/oq
 2i78oYS7pDKKXQ0MyJccK+1RQywzmtyTmHb9KmjGgQ59H7ZVRuJeP1Pw4+8x6T2voB64
 n+bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlWoY7WFoR/jGDQUNqP9J1Q1vJllJxdjwlIEwzm30RIjxhN367dOnaODoCaXq9B+kVIlsTzGvXXdXGGywgt9/QLRZK1ho=
X-Gm-Message-State: AOJu0YzpPAHTMu0qLuYAZyr9Gaw5xT5kGe9UojyPnYV0mWplWbnvSatv
 8cPucjgatXEbP+hhTTZa3VXU8502Le0/06Ry6LiK77y62twjuoQxbuBrW61yGOtk3XZVQq0n3II
 lkMHkHqqWj0UIA98manpPFGeBpjgL/UdpB7iBA0DugmKT7Y38jkKs
X-Received: by 2002:a05:622a:199f:b0:43a:c1a3:e283 with SMTP id
 d75a77b69052e-43dfce3ca89mr178842501cf.28.1715609631001; 
 Mon, 13 May 2024 07:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1tfnNogDsfkwQPBjqupGzT816+bPlrOisbOwsObDBRbD/UiA1RAPRYMb1jIh5VTmfd7pvIQ==
X-Received: by 2002:a05:622a:199f:b0:43a:c1a3:e283 with SMTP id
 d75a77b69052e-43dfce3ca89mr178842131cf.28.1715609630605; 
 Mon, 13 May 2024 07:13:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e137a737asm19096401cf.4.2024.05.13.07.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:13:50 -0700 (PDT)
Message-ID: <8bc6d519-5132-4061-92f1-64012fc06e04@redhat.com>
Date: Mon, 13 May 2024 16:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] vfio/migration: Don't emit STOP_COPY VFIO
 migration QAPI event twice
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
 <20240509090954.16447-4-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240509090954.16447-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

On 5/9/24 11:09, Avihai Horon wrote:
> When migrating a VFIO device that supports pre-copy, it is transitioned
> to STOP_COPY twice: once in vfio_vmstate_change() and second time in
> vfio_save_complete_precopy().
> 
> The second transition is harmless, as it's a STOP_COPY->STOP_COPY no-op
> transition. However, with the newly added VFIO migration QAPI event, the
> STOP_COPY event is undesirably emitted twice.
> 
> Prevent this by returning early in vfio_migration_set_state() if
> new_state is the same as current device state.
> 
> Note that the STOP_COPY transition in vfio_save_complete_precopy() is
> essential for VFIO devices that don't support pre-copy, for migrating an
> already stopped guest and for snapshots.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 5a359c4c78..14ef9c924e 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -143,6 +143,10 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>           (struct vfio_device_feature_mig_state *)feature->data;
>       int ret;
>   

I wonder if we should improve the trace events a little to track better
the state transitions. May be move trace_vfio_migration_set_state()
at the beginning of vfio_migration_set_state() and introduce a new
event for the currently named routine set_state() ?

This can come with followups.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> +    if (new_state == migration->device_state) {
> +        return 0;
> +    }
> +
>       feature->argsz = sizeof(buf);
>       feature->flags =
>           VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;


