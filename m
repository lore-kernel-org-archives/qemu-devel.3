Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232CAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HMI-0001Fv-FM; Wed, 15 May 2024 12:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7HMG-0001FO-0g
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7HME-0006Ns-GD
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715789997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEvsCdxZLNJgu7YJhGydowaMOz1iOrp1VfG8SwkDxSs=;
 b=RU+3V/k7CoaxIA6sTI139/FioUA2lbpZ+Wzx6XfsmuyhN4/QLtYgQmOE2Sf19oeIHQ1Oes
 FU/goe0twBU8fRgKshmxRrxd1gGwIvMJmhrPVgvwu0gVCgwA8YjUZ7mofTS5tg+KS8S9dM
 hLUwgNhAgdpHO0PLb+s95ToCKYYGb8A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-ITtVgwjTMGuLGmlfyp4ntQ-1; Wed, 15 May 2024 12:19:42 -0400
X-MC-Unique: ITtVgwjTMGuLGmlfyp4ntQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69649f1894dso121239586d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715789982; x=1716394782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEvsCdxZLNJgu7YJhGydowaMOz1iOrp1VfG8SwkDxSs=;
 b=umbu6pgNYTtKgsPXVjjXyiTvWmWoGbDHnfZIpXMA7cqzJ1zaqWcvYiL+6/W3KWOQbe
 4Nr9QFEakHFHQC54RvO0dz1C3481YP6R83zqTSolXydBf0YIgrf3MjxYCT4BplpAtY0G
 i+Uw8HTY/d5RllntJskMcGfL5/JNwYxfqaS4FbMRI+4g8/OmkITdiGXfkv6pif2JEQbK
 kDElmFG606QbbFz+J1OzOUijqcMWziqSmTIsVAXg7hZH+ciY9QOqdY+eHNL+lsRKZxl+
 VlrvZj7vK6qqIeqgElHhRXUdLyMpnHjodPZiZRSGD7eBZbgHcBMVZ4pYkVyz47yc0h8F
 xMew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdqhS5FKkVSXbDi+ILwkkktjsaNgySeKa91lKjUfCjnNzMlyztKYgDnw1jd5GsmoEzeuiTTHvj8q4dm0Kv76QjzWqtKhY=
X-Gm-Message-State: AOJu0Yxf2nTlf+pY7u7zPco9l0BqPXVFMltz4g9B32oKQCkCuZgbNCIh
 Q/vsy0a5M7bEU0oedRr3HhekbTv/GmzDn1mTK3FzzYHrZYwyy6ek1fSbVPFecqQ5NYrklt/LSf7
 1ESyWXq4T3z7PXqbgMe/8bRZ0oEH3D9HR3LYYF01+OtvLBUkBMSG+
X-Received: by 2002:a05:6214:3a09:b0:69b:8053:2c88 with SMTP id
 6a1803df08f44-6a168226a64mr223738506d6.49.1715789981949; 
 Wed, 15 May 2024 09:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjpMFWbSZ5brgnvO3FiSQ/qU06oMjOLBGcVuznZ7cVLXF6HXLJC/phljC9du35s07zKe7Wwg==
X-Received: by 2002:a05:6214:3a09:b0:69b:8053:2c88 with SMTP id
 6a1803df08f44-6a168226a64mr223738126d6.49.1715789981464; 
 Wed, 15 May 2024 09:19:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1ccc6esm65110056d6.103.2024.05.15.09.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 09:19:40 -0700 (PDT)
Message-ID: <3ce1d9af-b226-44ab-b77d-9d77954be7c2@redhat.com>
Date: Wed, 15 May 2024 18:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] vfio/migration: Enhance VFIO migration state
 tracing
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240515132138.4560-1-avihaih@nvidia.com>
 <20240515132138.4560-5-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515132138.4560-5-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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
> Move trace_vfio_migration_set_state() to the top of the function, add
> recover_state to it, and add a new trace event to
> vfio_migration_set_device_state().
> 
> This improves tracing of device state changes as state changes are now
> also logged when vfio_migration_set_state() fails (covering recover
> state and device reset transitions) and in no-op state transitions to
> the same state.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Thanks for doing so,



Reviewed-by: Cédric Le Goater <clg@redhat.com>


C.


> ---
>   hw/vfio/migration.c  | 8 ++++++--
>   hw/vfio/trace-events | 3 ++-
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index f2b7a3067b..7f0d76ab50 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -129,6 +129,9 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>   {
>       VFIOMigration *migration = vbasedev->migration;
>   
> +    trace_vfio_migration_set_device_state(vbasedev->name,
> +                                          mig_state_to_str(state));
> +
>       migration->device_state = state;
>       vfio_migration_send_event(vbasedev);
>   }
> @@ -146,6 +149,9 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>           (struct vfio_device_feature_mig_state *)feature->data;
>       int ret;
>   
> +    trace_vfio_migration_set_state(vbasedev->name, mig_state_to_str(new_state),
> +                                   mig_state_to_str(recover_state));
> +
>       if (new_state == migration->device_state) {
>           return 0;
>       }
> @@ -203,8 +209,6 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>           migration->data_fd = mig_state->data_fd;
>       }
>   
> -    trace_vfio_migration_set_state(vbasedev->name, mig_state_to_str(new_state));
> -
>       return 0;
>   
>   reset_device:
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index f0474b244b..64161bf6f4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -152,7 +152,8 @@ vfio_load_device_config_state(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
>   vfio_migration_realize(const char *name) " (%s)"
> -vfio_migration_set_state(const char *name, const char *state) " (%s) state %s"
> +vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
> +vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
>   vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
>   vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>   vfio_save_cleanup(const char *name) " (%s)"


