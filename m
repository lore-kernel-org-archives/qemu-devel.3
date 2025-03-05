Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DB4C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkHH-0007Kz-2U; Wed, 05 Mar 2025 03:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkHF-0007Kd-VI
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:38:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkHD-0000as-Nz
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741163930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pG1S+QEIAEELB9tRMg9eIb/uB9YPD4xRGEoXhuy8buQ=;
 b=R2EZU6dlwkQ4+01Ooc8Mpdk6n4g7yjznl8CBp4HXCz2ngywDAFVilfJsX4zo+EGBTBYNWn
 sCw3247IIfwxvNFPE85pwngXMt73VElHXs8mDTBVK8dmASPjohiwXDp221NGUmgEBBubYB
 7KW9ff97HeBuzHDbTG5onYdF/KhhQV8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-sSbXvbCpO8m3eO0tMLUGPw-1; Wed, 05 Mar 2025 03:38:49 -0500
X-MC-Unique: sSbXvbCpO8m3eO0tMLUGPw-1
X-Mimecast-MFC-AGG-ID: sSbXvbCpO8m3eO0tMLUGPw_1741163928
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so47303085e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741163928; x=1741768728;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pG1S+QEIAEELB9tRMg9eIb/uB9YPD4xRGEoXhuy8buQ=;
 b=uWvdeXVvj0RZzfMkKTAViSTkyKYnegFFy7MbPAgmIb/17QyMm2tb5VmXZKimNSt/Rd
 pVvlqNgdR6Bo0cdLDMsV9I1uG8ui/lPyNVHNsGs8JPH5fBgpWEtW6V+SB6iBDY2oh3rY
 A5wLd0vN50vA9ARzJ8OK/ASkIv/wBCfLT7KLqJyY9DtSTtvDR0HJZEWBazilY+KroFWc
 al3bS62Pp42pG+BWgaMA/LcnXYqm1DQlMhJYiVP0joLtzwudEaWnrAm8GdfKdqbWTtVR
 pSRXpAT5RNdg/pLdUZ6plI79Oc44MzmJIrWS4LKkgCX7guwSAlBCabz3E3GO3npXF84z
 ZF+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLd2RuyJJtMR6vB6LuzAkBtIu5ImZwz7hzJwCYYVYooA+YQIL+ADSR9OaCizIT/80x4BKtpgCJzB9B@nongnu.org
X-Gm-Message-State: AOJu0YzmJPVi2etXfs3CJNHVoMGNf/6qg1q8p2V5OryJZFR4cK2If2VN
 /0e8UXvHQ/W6tdHSsPWcC4b5FIZt0O/+1RoINjHXJeQb/cacQNgigTWAqNXryjsPliwxzpGW+Un
 NaA1WTRIAar34yBTWGOJgDLCfN/5DJIZ715kVc4u6yKqBT1HopV8i
X-Gm-Gg: ASbGncsycx0SLcRKtTzn60nGA2peMQF7t9hPsv6Q3wIHfloF3pFs/YoxyrdMsoksC5V
 nP+VKhMcx8YLEX08XJLJUCvWVeBE409sF5vQfIKWrYEYalPo79pYCqt+jUE4aS0TJJ3PasPrui0
 QqXFIWmp55rS29TdDfHpYxPbfWsu+I2NG6mfziAvqZbGChQYvkZU0DxytlRCmNK4yL04vnr4pbe
 xfWjRW8eZk0I8IdCNrtXkr8aHnJqlvv1XbxsXo4aznlWyRO57mFIckiw8Fpw/wGhrf446dvi4G0
 y71Ay0ImpVw3y/C0pMzm2FnA3bmZb+2fg3KF9dEWRGn62UJPlAzQrA==
X-Received: by 2002:a05:600c:3b87:b0:439:6101:5440 with SMTP id
 5b1f17b1804b1-43bd296abc2mr13873855e9.8.1741163928231; 
 Wed, 05 Mar 2025 00:38:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJNKzLco+LstKsdXlNqrjBpjCdy3yGaflwCsX/M3dijSh4o+i4MfObkqDEQ6WyLhVNTfrk/w==
X-Received: by 2002:a05:600c:3b87:b0:439:6101:5440 with SMTP id
 5b1f17b1804b1-43bd296abc2mr13873715e9.8.1741163927836; 
 Wed, 05 Mar 2025 00:38:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e61csm20556570f8f.98.2025.03.05.00.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:38:47 -0800 (PST)
Message-ID: <55553268-a8b3-4c7b-ab72-bb81a58f4911@redhat.com>
Date: Wed, 5 Mar 2025 09:38:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
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
> Implement the multifd device state transfer via additional per-device
> thread inside save_live_complete_precopy_thread handler.
> 
> Switch between doing the data transfer in the new handler and doing it
> in the old save_state handler depending if VFIO multifd transfer is enabled
> or not.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration-multifd.c   | 142 ++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h   |   6 ++
>   hw/vfio/migration.c           |  22 ++++--
>   hw/vfio/trace-events          |   2 +
>   include/hw/vfio/vfio-common.h |   6 ++
>   5 files changed, 172 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 1d81233c755f..bfb9a72fa450 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -496,6 +496,148 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
>       return true;
>   }
>   
> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    assert(vfio_multifd_transfer_enabled(vbasedev));
> +
> +    /*
> +     * Emit dummy NOP data on the main migration channel since the actual
> +     * device state transfer is done via multifd channels.
> +     */
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +}
> +
> +static bool
> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
> +                                               char *idstr,
> +                                               uint32_t instance_id,
> +                                               uint32_t idx,
> +                                               Error **errp)
> +{
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    g_autoptr(QEMUFile) f = NULL;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    size_t packet_len;
> +
> +    bioc = qio_channel_buffer_new(0);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
> +
> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
> +
> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
> +        return false;
> +    }
> +
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        error_setg(errp, "%s: save config state flush failed: %d",
> +                   vbasedev->name, ret);
> +        return false;
> +    }
> +
> +    packet_len = sizeof(*packet) + bioc->usage;
> +    packet = g_malloc0(packet_len);
> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +    packet->idx = idx;
> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
> +    memcpy(&packet->data, bioc->data, bioc->usage);
> +
> +    if (!multifd_queue_device_state(idstr, instance_id,
> +                                    (char *)packet, packet_len)) {
> +        error_setg(errp, "%s: multifd config data queuing failed",
> +                   vbasedev->name);
> +        return false;
> +    }
> +
> +    vfio_mig_add_bytes_transferred(packet_len);
> +
> +    return true;
> +}
> +
> +/*
> + * This thread is spawned by the migration core directly via
> + * .save_live_complete_precopy_thread SaveVMHandler.
> + *
> + * It exits after either:
> + * * completing saving the remaining device state and device config, OR:
> + * * encountering some error while doing the above, OR:
> + * * being forcefully aborted by the migration core by
> + *   multifd_device_state_save_thread_should_exit() returning true.
> + */
> +bool
> +vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
> +                                          Error **errp)
> +{
> +    VFIODevice *vbasedev = d->handler_opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    bool ret = false;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    uint32_t idx;
> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
> +        return true;
> +    }
> +
> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
> +                                                  d->idstr, d->instance_id);
> +
> +    /* We reach here with device state STOP or STOP_COPY only */
> +    if (vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> +                                 VFIO_DEVICE_STATE_STOP, errp)) {
> +        goto thread_exit;
> +    }
> +
> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +
> +    for (idx = 0; ; idx++) {
> +        ssize_t data_size;
> +        size_t packet_size;
> +
> +        if (multifd_device_state_save_thread_should_exit()) {
> +            error_setg(errp, "operation cancelled");
> +            goto thread_exit;
> +        }
> +
> +        data_size = read(migration->data_fd, &packet->data,
> +                         migration->data_buffer_size);
> +        if (data_size < 0) {
> +            error_setg(errp, "%s: reading state buffer %" PRIu32 " failed: %d",
> +                       vbasedev->name, idx, errno);
> +            goto thread_exit;
> +        } else if (data_size == 0) {
> +            break;
> +        }
> +
> +        packet->idx = idx;
> +        packet_size = sizeof(*packet) + data_size;
> +
> +        if (!multifd_queue_device_state(d->idstr, d->instance_id,
> +                                        (char *)packet, packet_size)) {
> +            error_setg(errp, "%s: multifd data queuing failed", vbasedev->name);
> +            goto thread_exit;
> +        }
> +
> +        vfio_mig_add_bytes_transferred(packet_size);
> +    }
> +
> +    if (!vfio_save_complete_precopy_thread_config_state(vbasedev,
> +                                                        d->idstr,
> +                                                        d->instance_id,
> +                                                        idx, errp)) {
> +        goto thread_exit;
> +   }
> +
> +    ret = true;
> +
> +thread_exit:
> +    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
> +
> +    return ret;
> +}
> +
>   int vfio_multifd_switchover_start(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index f0d28fcef2ea..a664051eb8ae 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -23,6 +23,12 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>   bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>                                       Error **errp);
>   
> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
> +
> +bool
> +vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
> +                                          Error **errp);
> +
>   int vfio_multifd_switchover_start(VFIODevice *vbasedev);
>   
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index f325a619c3ed..24bdc9e24c71 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -120,10 +120,10 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>       vfio_migration_send_event(vbasedev);
>   }
>   
> -static int vfio_migration_set_state(VFIODevice *vbasedev,
> -                                    enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state,
> -                                    Error **errp)
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -238,8 +238,7 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>   
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> -                                         Error **errp)
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
>       int ret;
> @@ -638,6 +637,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       int ret;
>       Error *local_err = NULL;
>   
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        return 0;
> +    }
> +
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>   
>       /* We reach here with device state STOP or STOP_COPY only */
> @@ -669,6 +673,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>       Error *local_err = NULL;
>       int ret;
>   
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        return;
> +    }
> +
>       ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
>           error_prepend(&local_err,
> @@ -815,6 +824,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .is_active_iterate = vfio_is_active_iterate,
>       .save_live_iterate = vfio_save_iterate,
>       .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .save_live_complete_precopy_thread = vfio_multifd_save_complete_precopy_thread,
>       .save_state = vfio_save_state,
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index d6b7e34faa39..9347e3a5f660 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -171,6 +171,8 @@ vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>   vfio_save_complete_precopy_start(const char *name) " (%s)"
> +vfio_save_complete_precopy_thread_start(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
> +vfio_save_complete_precopy_thread_end(const char *name, int ret) " (%s) ret %d"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_save_iterate_start(const char *name) " (%s)"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9d72ac1eae8a..961931d9f457 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -298,6 +298,7 @@ void vfio_mig_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>   
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
>   int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>   
>   #ifdef CONFIG_LINUX
> @@ -314,6 +315,11 @@ struct vfio_info_cap_header *
>   vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
>   struct vfio_info_cap_header *
>   vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
> +
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp);
>   #endif
>   
>   bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> 


