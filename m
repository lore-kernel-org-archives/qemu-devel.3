Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B5C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkAd-0004V5-VB; Wed, 05 Mar 2025 03:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkAb-0004Si-F2
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkAX-0008Id-Dg
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741163516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XmUrsKHIGDe23NOoMo09g/BSn/wpoIqq2iLvm1rLq6Y=;
 b=gwUmd/3/TLuU/EArgJ3gHPbjKZIW7XMhqBAsGfPMcbxBPORJOy1o2sH3e30OXOBGAcNckF
 CwDHeck+8J+vLAOnGehE5jh5YF8LuOO44/ecBTIeXDAfF8/wVgndyEAq8ZMKLo3DGgh5VZ
 UsTpeSwJIgMcE6s2Iq5BBUHq1UK1b8o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-cMGJJ6tvMN63eUIbgx9R0Q-1; Wed, 05 Mar 2025 03:31:55 -0500
X-MC-Unique: cMGJJ6tvMN63eUIbgx9R0Q-1
X-Mimecast-MFC-AGG-ID: cMGJJ6tvMN63eUIbgx9R0Q_1741163514
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390ddb832e6so3145783f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741163514; x=1741768314;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmUrsKHIGDe23NOoMo09g/BSn/wpoIqq2iLvm1rLq6Y=;
 b=g+MZ+3eIvm5Bu6JZJIhyTeCfUM8zhOZ501Fcoyik3uh0E24DQHk9B7Wc5ek2WgDzeM
 KyBMdZh3TyNzY5tq4UyhYZ7yNVxgMgJtmuX0EuRM1X4rNVBYwYcQpfxFrPErF6Ndqo2o
 WZO2VxKlDHfSS1z9qyL3UaqWBwXM93IzilR2XXOteX1/Y+Lnebb5gCkYKMEYni0fjHHW
 Q3j9DV2BKvzVRJ6ZsFhdz/iaN7SD0r20gtSLsO+Kom+JUpwLEWUcxUHN3Y0YVEhpmv4X
 VpcJj4Iu16G82a0A6j8U3S2s6h2Vy5ODibbAtxBanyObEFY/rfkcIrly15O6073GejLM
 M7qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUm0R8a79OuCtiCutvpkFvwMqC1U07NT95Aw3AGMGfKIPJGUVeH0rP8Yb86EY8uOnNfg8jOuqq8har@nongnu.org
X-Gm-Message-State: AOJu0Yw28XvQXnNmTkeacy7yUtLKaeG3aZdpA0JYOrDIyEH49uJnc3Q6
 d9DC3BrO/W5XXn/cm0pj5wfiqrw/O+i7Q/dSiwv1ozMomHNkAfAmvhuZuNdbtbjhMuq0txieOs/
 beEQI4nHlAyKyndGqzoJNPhp9f6vZ1+MLDFc7II8mPwrIvIByY4Cf
X-Gm-Gg: ASbGncuwAXFDhfZE9RfUdEIm1gRqhCePfd3m/HOmrlVuY3joIu1m68G99hrB43rqBsp
 yWFe7Blje/NAigPDrwEAv7NRVRBv+suCSzH4q646QIqEhrEZt3E/lqvA2v+P1zFbPeit4/oeS+Q
 PGeHCmcrI40QhAa3BsCC10UXLEVe1frp9KpNOoarBzYFTuImQ7Zuvo1s/aruvHYiX7U+jWQjGj8
 3c1WWGazt9fOicDKoMWnR5R2u1bD6zTNq1kZaTW+VMFcQPa9Z0cBfIQWS8XXjgHkLB52Bbib/ve
 8glx4ofSEsFyTBrV2pN+ULRjeWXWqudx4UuWYqL3EwoQXqSXx2xOaQ==
X-Received: by 2002:a5d:5f4d:0:b0:390:f55b:ba91 with SMTP id
 ffacd0b85a97d-3911f727cf9mr1412241f8f.14.1741163514064; 
 Wed, 05 Mar 2025 00:31:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAm4bLaqk3wnIe76hORiAe4RWnKr33b/QbfQP+cUKuuU+JRefwPViFRSj0DMCR+dJrNrrwIw==
X-Received: by 2002:a5d:5f4d:0:b0:390:f55b:ba91 with SMTP id
 ffacd0b85a97d-3911f727cf9mr1412211f8f.14.1741163513658; 
 Wed, 05 Mar 2025 00:31:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d906sm20453769f8f.90.2025.03.05.00.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:31:53 -0800 (PST)
Message-ID: <f129ad50-4231-402c-b7f2-86204fdf2af0@redhat.com>
Date: Wed, 5 Mar 2025 09:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/36] vfio/migration: Multifd device state transfer
 support - load thread
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <9abe612d775aaf42e31646796acd2363c723a57a.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9abe612d775aaf42e31646796acd2363c723a57a.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
> Add a thread which loads the VFIO device state buffers that were received
> via multifd.
> 
> Each VFIO device that has multifd device state transfer enabled has one
> such thread, which is created using migration core API
> qemu_loadvm_start_load_thread().
> 
> Since it's important to finish loading device state transferred via the
> main migration channel (via save_live_iterate SaveVMHandler) before
> starting loading the data asynchronously transferred via multifd the thread
> doing the actual loading of the multifd transferred data is only started
> from switchover_start SaveVMHandler.
> 
> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
> 
> This sub-command is only sent after all save_live_iterate data have already
> been posted so it is safe to commence loading of the multifd-transferred
> device state upon receiving it - loading of save_live_iterate data happens
> synchronously in the main migration thread (much like the processing of
> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
> processed all the proceeding data must have already been loaded.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration-multifd.c | 226 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h |   2 +
>   hw/vfio/migration.c         |  12 ++
>   hw/vfio/trace-events        |   7 ++
>   4 files changed, 247 insertions(+)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 79df11b7baa9..2eef27604e4f 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -44,8 +44,12 @@ typedef struct VFIOStateBuffer {
>   } VFIOStateBuffer;
>   
>   typedef struct VFIOMultifd {
> +    bool load_bufs_thread_running;
> +    bool load_bufs_thread_want_exit;
> +
>       VFIOStateBuffers load_bufs;
>       QemuCond load_bufs_buffer_ready_cond;
> +    QemuCond load_bufs_thread_finished_cond;
>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>       uint32_t load_buf_idx;
>       uint32_t load_buf_idx_last;
> @@ -186,6 +190,178 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>       return true;
>   }
>   
> +static bool vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
> +                                              Error **errp)
> +{
> +    error_setg(errp, "not yet there");
> +    return false;
> +}
> +
> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
> +{
> +    VFIOStateBuffer *lb;
> +    unsigned int bufs_len;
> +
> +    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
> +    if (multifd->load_buf_idx >= bufs_len) {
> +        assert(multifd->load_buf_idx == bufs_len);
> +        return NULL;
> +    }
> +
> +    lb = vfio_state_buffers_at(&multifd->load_bufs,
> +                               multifd->load_buf_idx);
> +    if (!lb->is_present) {
> +        return NULL;
> +    }
> +
> +    return lb;
> +}
> +
> +static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
> +                                         VFIOStateBuffer *lb,
> +                                         Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    g_autofree char *buf = NULL;
> +    char *buf_cur;
> +    size_t buf_len;
> +
> +    if (!lb->len) {
> +        return true;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
> +                                                   multifd->load_buf_idx);
> +
> +    /* lb might become re-allocated when we drop the lock */
> +    buf = g_steal_pointer(&lb->data);
> +    buf_cur = buf;
> +    buf_len = lb->len;
> +    while (buf_len > 0) {
> +        ssize_t wr_ret;
> +        int errno_save;
> +
> +        /*
> +         * Loading data to the device takes a while,
> +         * drop the lock during this process.
> +         */
> +        qemu_mutex_unlock(&multifd->load_bufs_mutex);
> +        wr_ret = write(migration->data_fd, buf_cur, buf_len);
> +        errno_save = errno;
> +        qemu_mutex_lock(&multifd->load_bufs_mutex);
> +
> +        if (wr_ret < 0) {
> +            error_setg(errp,
> +                       "%s: writing state buffer %" PRIu32 " failed: %d",
> +                       vbasedev->name, multifd->load_buf_idx, errno_save);
> +            return false;
> +        }
> +
> +        assert(wr_ret <= buf_len);
> +        buf_len -= wr_ret;
> +        buf_cur += wr_ret;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
> +                                                 multifd->load_buf_idx);
> +
> +    return true;
> +}
> +
> +static bool vfio_load_bufs_thread_want_exit(VFIOMultifd *multifd,
> +                                            bool *should_quit)
> +{
> +    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
> +}
> +
> +/*
> + * This thread is spawned by vfio_multifd_switchover_start() which gets
> + * called upon encountering the switchover point marker in main migration
> + * stream.
> + *
> + * It exits after either:
> + * * completing loading the remaining device state and device config, OR:
> + * * encountering some error while doing the above, OR:
> + * * being forcefully aborted by the migration core by it setting should_quit
> + *   or by vfio_load_cleanup_load_bufs_thread() setting
> + *   multifd->load_bufs_thread_want_exit.
> + */
> +static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    bool ret = false;
> +
> +    trace_vfio_load_bufs_thread_start(vbasedev->name);
> +
> +    assert(multifd);
> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
> +
> +    assert(multifd->load_bufs_thread_running);
> +
> +    while (true) {
> +        VFIOStateBuffer *lb;
> +
> +        /*
> +         * Always check cancellation first after the buffer_ready wait below in
> +         * case that cond was signalled by vfio_load_cleanup_load_bufs_thread().
> +         */
> +        if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
> +            error_setg(errp, "operation cancelled");
> +            goto thread_exit;
> +        }
> +
> +        assert(multifd->load_buf_idx <= multifd->load_buf_idx_last);
> +
> +        lb = vfio_load_state_buffer_get(multifd);
> +        if (!lb) {
> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
> +                                                        multifd->load_buf_idx);
> +            qemu_cond_wait(&multifd->load_bufs_buffer_ready_cond,
> +                           &multifd->load_bufs_mutex);
> +            continue;
> +        }
> +
> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last) {
> +            break;
> +        }
> +
> +        if (multifd->load_buf_idx == 0) {
> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
> +        }
> +
> +        if (!vfio_load_state_buffer_write(vbasedev, lb, errp)) {
> +            goto thread_exit;
> +        }
> +
> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
> +        }
> +
> +        multifd->load_buf_idx++;
> +    }
> +
> +    if (!vfio_load_bufs_thread_load_config(vbasedev, errp)) {
> +        goto thread_exit;
> +    }
> +
> +    ret = true;
> +
> +thread_exit:
> +    /*
> +     * Notify possibly waiting vfio_load_cleanup_load_bufs_thread() that
> +     * this thread is exiting.
> +     */
> +    multifd->load_bufs_thread_running = false;
> +    qemu_cond_signal(&multifd->load_bufs_thread_finished_cond);
> +
> +    trace_vfio_load_bufs_thread_end(vbasedev->name);
> +
> +    return ret;
> +}
> +
>   static VFIOMultifd *vfio_multifd_new(void)
>   {
>       VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
> @@ -198,11 +374,41 @@ static VFIOMultifd *vfio_multifd_new(void)
>       multifd->load_buf_idx_last = UINT32_MAX;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>   
> +    multifd->load_bufs_thread_running = false;
> +    multifd->load_bufs_thread_want_exit = false;
> +    qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
> +
>       return multifd;
>   }
>   
> +/*
> + * Terminates vfio_load_bufs_thread by setting
> + * multifd->load_bufs_thread_want_exit and signalling all the conditions
> + * the thread could be blocked on.
> + *
> + * Waits for the thread to signal that it had finished.
> + */
> +static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
> +{
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +        while (multifd->load_bufs_thread_running) {
> +            multifd->load_bufs_thread_want_exit = true;
> +
> +            qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> +            qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
> +                           &multifd->load_bufs_mutex);
> +        }
> +    }
> +    bql_lock();
> +}
> +
>   static void vfio_multifd_free(VFIOMultifd *multifd)
>   {
> +    vfio_load_cleanup_load_bufs_thread(multifd);
> +
> +    qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
>       vfio_state_buffers_destroy(&multifd->load_bufs);
>       qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
>       qemu_mutex_destroy(&multifd->load_bufs_mutex);
> @@ -244,3 +450,23 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
>   
>       return true;
>   }
> +
> +int vfio_multifd_switchover_start(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +
> +    assert(multifd);
> +
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +        assert(!multifd->load_bufs_thread_running);
> +        multifd->load_bufs_thread_running = true;
> +    }
> +    bql_lock();
> +
> +    qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
> +
> +    return 0;
> +}
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index 8c6320fcb484..f0d28fcef2ea 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -23,4 +23,6 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>   bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>                                       Error **errp);
>   
> +int vfio_multifd_switchover_start(VFIODevice *vbasedev);
> +
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index ecc4ee940567..0096344f74f9 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -788,6 +788,17 @@ static bool vfio_switchover_ack_needed(void *opaque)
>       return vfio_precopy_supported(vbasedev);
>   }
>   
> +static int vfio_switchover_start(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        return vfio_multifd_switchover_start(vbasedev);
> +    }
> +
> +    return 0;
> +}
> +
>   static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_prepare = vfio_save_prepare,
>       .save_setup = vfio_save_setup,
> @@ -803,6 +814,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_state = vfio_load_state,
>       .load_state_buffer = vfio_multifd_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
> +    .switchover_start = vfio_switchover_start,
>   };
>   
>   /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 404ea079b25c..d6b7e34faa39 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -149,12 +149,19 @@ vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
>   vfio_display_edid_write_error(void) ""
>   
>   # migration.c
> +vfio_load_bufs_thread_start(const char *name) " (%s)"
> +vfio_load_bufs_thread_end(const char *name) " (%s)"
>   vfio_load_cleanup(const char *name) " (%s)"
>   vfio_load_device_config_state_start(const char *name) " (%s)"
>   vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
>   vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_start(const char *name) " (%s)"
> +vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_end(const char *name) " (%s)"
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
> 


