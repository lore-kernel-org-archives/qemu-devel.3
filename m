Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4350C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpk9t-0002ad-Ki; Wed, 05 Mar 2025 03:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpk9i-0002QZ-Jc
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpk9g-0008Ck-GR
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741163463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=43U7b7wcPVNrxJy0h0WCCqdBpAkhvoSrXjCLmtstfBs=;
 b=VBxWScsFHYR/wzSmHuUcgcFINMPWg/2CIE9YvsIhzKGt04p1ifLeCyQC1aaPNstm28TgKP
 BCIPsXDvRWkbIcFKi8JSe48wUN6R/WaW0qJIYNRIg9QKRLuqZACIBjDtUpmXlfG8sLe1VL
 54HRhRTc8VbmVXEqEtN5gBcn65yg1Cg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-5gw6DHoSN9uais2HQyLOrg-1; Wed, 05 Mar 2025 03:31:01 -0500
X-MC-Unique: 5gw6DHoSN9uais2HQyLOrg-1
X-Mimecast-MFC-AGG-ID: 5gw6DHoSN9uais2HQyLOrg_1741163460
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390eb06d920so4882102f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741163460; x=1741768260;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43U7b7wcPVNrxJy0h0WCCqdBpAkhvoSrXjCLmtstfBs=;
 b=AAxnyWNKROnlZgAtntE+vrnLXcO8x4yuON2k03+zh4w2xWzsUVHZrySkGmeMQyN58a
 SMgAGBsR1ugS6XTv+9XPYZUFThHHFVE/f2HeUr8wJvXVSzEcKqRrWQZt+5r/zwlnydaF
 9pxuhg5fw5euMYV2Cht6H+QUISQSXjVLCxFQSLsJaR+Vx88jvXTsZWLGxiyxZ61O/guS
 3Z5AummwqJlI50ljHurw4UAmJiVoJZAsn4rNUFJfAzr9V8ZR+2rPP0fTpMg0gHK+YlgX
 JKEtZ8SeuBV6H9wuAcps251Lcos9N+fOPsuq4iZqjKJRkVJFXklqOWuU8aTJjMXUBjtB
 g+Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA6wKedISCpLWr2/3QiPTvoGzggq8AEYxndKTveOrUJRA4BHGk48MqdRWU7CmAaPKwEfuua4qPwCli@nongnu.org
X-Gm-Message-State: AOJu0YxSyGQ2RyqquSiD+GBxsHiGm0OmrFd4jFDtk7tWFb2Vc7Z1DvbR
 AVC7C+9D3Vla9nbs53n0zLyzSs/NuqBztQZUz6Zl5u4qvF0srPwttyrqABuoC4voyqwDver19Dn
 lbc+r4Y+z3myfEEcMu8dhW64/VrlDjPajMBzgAEDvO7SL40J4Ox2m
X-Gm-Gg: ASbGncv8OXezKzM8qvAS5f4O+l1SrSHfn4MC9Mo/ykFC+AqkPdFBHGoJ6nayMIeAZWU
 1Zi1z/5hzWJsY1/WyeS9XeIqDxbKUxvaIhnoiUAQvYlabwkCD5naTaD1R+oaYs4RuRo8yTLjBzp
 0J8p06VbtZGWCc/JS3z7J2cjJNkGas4Mb6B5p0hG1sy5e5Sa4+UN1Zz/FVkgxImkjODo84SGN6x
 4Zvvo0drFGIQkGB64BCqhDvjG8BAXJqkjEDMtyrSTrhAKTRNOC6p5yxCywLZ2ZLiUvRu5ROcC0B
 1itM8Q/S+EvEGUkMiya6E2o3at8oIfYlzpf7Jl+1LG0klcfPjnl1uA==
X-Received: by 2002:a5d:5f91:0:b0:390:e9e0:5cb3 with SMTP id
 ffacd0b85a97d-3911f73b6b4mr1346676f8f.12.1741163459906; 
 Wed, 05 Mar 2025 00:30:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXyzeZ1+MpwFValD0wSQY/kfVEM7dnGQ8sWkLRMCYJrCrFv7EU4km/zbwEhUc9jPTdQ5aSyg==
X-Received: by 2002:a5d:5f91:0:b0:390:e9e0:5cb3 with SMTP id
 ffacd0b85a97d-3911f73b6b4mr1346651f8f.12.1741163459505; 
 Wed, 05 Mar 2025 00:30:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a66adsm20036846f8f.25.2025.03.05.00.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:30:58 -0800 (PST)
Message-ID: <1ed59cbe-eb42-4da4-a829-a31b5b9986ae@redhat.com>
Date: Wed, 5 Mar 2025 09:30:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 26/36] vfio/migration: Multifd device state transfer
 support - received buffers queuing
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <e3bff515a8d61c582b94b409eb12a45b1a143a69.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e3bff515a8d61c582b94b409eb12a45b1a143a69.1741124640.git.maciej.szmigiero@oracle.com>
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
> The multifd received data needs to be reassembled since device state
> packets sent via different multifd channels can arrive out-of-order.
> 
> Therefore, each VFIO device state packet carries a header indicating its
> position in the stream.
> The raw device state data is saved into a VFIOStateBuffer for later
> in-order loading into the device.
> 
> The last such VFIO device state packet should have
> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration-multifd.c | 163 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h |   3 +
>   hw/vfio/migration.c         |   1 +
>   hw/vfio/trace-events        |   1 +
>   4 files changed, 168 insertions(+)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 091dc43210ad..79df11b7baa9 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -32,18 +32,181 @@ typedef struct VFIODeviceStatePacket {
>       uint8_t data[0];
>   } QEMU_PACKED VFIODeviceStatePacket;
>   
> +/* type safety */
> +typedef struct VFIOStateBuffers {
> +    GArray *array;
> +} VFIOStateBuffers;
> +
> +typedef struct VFIOStateBuffer {
> +    bool is_present;
> +    char *data;
> +    size_t len;
> +} VFIOStateBuffer;
> +
>   typedef struct VFIOMultifd {
> +    VFIOStateBuffers load_bufs;
> +    QemuCond load_bufs_buffer_ready_cond;
> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
> +    uint32_t load_buf_idx;
> +    uint32_t load_buf_idx_last;
>   } VFIOMultifd;
>   
> +static void vfio_state_buffer_clear(gpointer data)
> +{
> +    VFIOStateBuffer *lb = data;
> +
> +    if (!lb->is_present) {
> +        return;
> +    }
> +
> +    g_clear_pointer(&lb->data, g_free);
> +    lb->is_present = false;
> +}
> +
> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
> +{
> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
> +}
> +
> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
> +{
> +    g_clear_pointer(&bufs->array, g_array_unref);
> +}
> +
> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
> +{
> +    assert(bufs->array);
> +}
> +
> +static unsigned int vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
> +{
> +    return bufs->array->len;
> +}
> +
> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs,
> +                                        unsigned int size)
> +{
> +    g_array_set_size(bufs->array, size);
> +}
> +
> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs,
> +                                              unsigned int idx)
> +{
> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
> +}
> +
> +/* called with load_bufs_mutex locked */
> +static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
> +                                          VFIODeviceStatePacket *packet,
> +                                          size_t packet_total_size,
> +                                          Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIOStateBuffer *lb;
> +
> +    vfio_state_buffers_assert_init(&multifd->load_bufs);
> +    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
> +        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
> +    }
> +
> +    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
> +    if (lb->is_present) {
> +        error_setg(errp, "%s: state buffer %" PRIu32 " already filled",
> +                   vbasedev->name, packet->idx);
> +        return false;
> +    }
> +
> +    assert(packet->idx >= multifd->load_buf_idx);
> +
> +    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
> +    lb->len = packet_total_size - sizeof(*packet);
> +    lb->is_present = true;
> +
> +    return true;
> +}
> +
> +bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                                    Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        error_setg(errp,
> +                   "%s: got device state packet but not doing multifd transfer",
> +                   vbasedev->name);
> +        return false;
> +    }
> +
> +    assert(multifd);
> +
> +    if (data_size < sizeof(*packet)) {
> +        error_setg(errp, "%s: packet too short at %zu (min is %zu)",
> +                   vbasedev->name, data_size, sizeof(*packet));
> +        return false;
> +    }
> +
> +    if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
> +        error_setg(errp, "%s: packet has unknown version %" PRIu32,
> +                   vbasedev->name, packet->version);
> +        return false;
> +    }
> +
> +    if (packet->idx == UINT32_MAX) {
> +        error_setg(errp, "%s: packet index is invalid", vbasedev->name);
> +        return false;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
> +
> +    /*
> +     * Holding BQL here would violate the lock order and can cause
> +     * a deadlock once we attempt to lock load_bufs_mutex below.
> +     */
> +    assert(!bql_locked());
> +
> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +        /* config state packet should be the last one in the stream */
> +        if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
> +            multifd->load_buf_idx_last = packet->idx;
> +        }
> +
> +        if (!vfio_load_state_buffer_insert(vbasedev, packet, data_size,
> +                                           errp)) {
> +            return false;
> +        }
> +
> +        qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> +    }
> +
> +    return true;
> +}
> +
>   static VFIOMultifd *vfio_multifd_new(void)
>   {
>       VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>   
> +    vfio_state_buffers_init(&multifd->load_bufs);
> +
> +    qemu_mutex_init(&multifd->load_bufs_mutex);
> +
> +    multifd->load_buf_idx = 0;
> +    multifd->load_buf_idx_last = UINT32_MAX;
> +    qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
> +
>       return multifd;
>   }
>   
>   static void vfio_multifd_free(VFIOMultifd *multifd)
>   {
> +    vfio_state_buffers_destroy(&multifd->load_bufs);
> +    qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
> +    qemu_mutex_destroy(&multifd->load_bufs_mutex);
> +
>       g_free(multifd);
>   }
>   
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index 2a7a76164f29..8c6320fcb484 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -20,4 +20,7 @@ void vfio_multifd_cleanup(VFIODevice *vbasedev);
>   bool vfio_multifd_transfer_supported(void);
>   bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>   
> +bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                                    Error **errp);
> +
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 3c8286ae6230..ecc4ee940567 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -801,6 +801,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .load_state_buffer = vfio_multifd_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
>   };
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index a02c668f28a4..404ea079b25c 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -154,6 +154,7 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
>   vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
> +vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
> 


