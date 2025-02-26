Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C69C19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnOb3-0003DB-24; Wed, 26 Feb 2025 16:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnOap-00034h-Ht
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:05:24 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnOam-0003iq-C2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:05:23 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnOah-000000004jp-19tp; Wed, 26 Feb 2025 22:05:15 +0100
Message-ID: <438ee2cb-d29a-4975-806e-2e2f2dff1a44@maciej.szmigiero.name>
Date: Wed, 26 Feb 2025 22:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/36] vfio/migration: Multifd device state transfer
 support - load thread
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <9be8882ea2189c1a827bdf09835d6c65488d2ca6.1739994627.git.maciej.szmigiero@oracle.com>
 <573fab5e-4c0f-416c-bbd0-4786ad25e18f@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <573fab5e-4c0f-416c-bbd0-4786ad25e18f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26.02.2025 14:49, Cédric Le Goater wrote:
> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Since it's important to finish loading device state transferred via the
>> main migration channel (via save_live_iterate SaveVMHandler) before
>> starting loading the data asynchronously transferred via multifd the thread
>> doing the actual loading of the multifd transferred data is only started
>> from switchover_start SaveVMHandler.
>>
>> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
>> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
>>
>> This sub-command is only sent after all save_live_iterate data have already
>> been posted so it is safe to commence loading of the multifd-transferred
>> device state upon receiving it - loading of save_live_iterate data happens
>> synchronously in the main migration thread (much like the processing of
>> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
>> processed all the proceeding data must have already been loaded.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration-multifd.c | 225 ++++++++++++++++++++++++++++++++++++
>>   hw/vfio/migration-multifd.h |   2 +
>>   hw/vfio/migration.c         |  12 ++
>>   hw/vfio/trace-events        |   5 +
>>   4 files changed, 244 insertions(+)
>>
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 5d5ee1393674..b3a88c062769 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -42,8 +42,13 @@ typedef struct VFIOStateBuffer {
>>   } VFIOStateBuffer;
>>   typedef struct VFIOMultifd {
>> +    QemuThread load_bufs_thread;
>> +    bool load_bufs_thread_running;
>> +    bool load_bufs_thread_want_exit;
>> +
>>       VFIOStateBuffers load_bufs;
>>       QemuCond load_bufs_buffer_ready_cond;
>> +    QemuCond load_bufs_thread_finished_cond;
>>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>       uint32_t load_buf_idx;
>>       uint32_t load_buf_idx_last;
>> @@ -179,6 +184,175 @@ bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>>       return true;
>>   }
>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>> +{
>> +    return -EINVAL;
>> +}
> 
> 
> please move to next patch.

As I wrote on the previous version of the patch set at
https://lore.kernel.org/qemu-devel/4f335de0-ba9f-4537-b230-2cf8af1c160b@maciej.szmigiero.name/:
> The dummy call has to be there, otherwise the code at the
> previous commit time wouldn't compile since that
> vfio_load_bufs_thread_load_config() call is a part of
> vfio_load_bufs_thread().
> 
> This is an artifact of splitting the whole load operation in
> multiple commits.

I think adding empty dummy implementations is the typical way
to do this - much like you asked today to leave
vfio_multifd_transfer_setup() returning true unconditionally
before being filled with true implementation in later patch.

See also my response at the end of this e-mail message, below
the call to vfio_load_bufs_thread_load_config().

>> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
>> +{
>> +    VFIOStateBuffer *lb;
>> +    guint bufs_len;
> 
> guint:  I guess it's ok to use here. It is not common practice in VFIO.
> 
>> +
>> +    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
>> +    if (multifd->load_buf_idx >= bufs_len) {
>> +        assert(multifd->load_buf_idx == bufs_len);
>> +        return NULL;
>> +    }
>> +
>> +    lb = vfio_state_buffers_at(&multifd->load_bufs,
>> +                               multifd->load_buf_idx);
> 
> Could be one line. minor.
> 
>> +    if (!lb->is_present) {
>> +        return NULL;
>> +    }
>> +
>> +    return lb;
>> +}
>> +
>> +static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
>> +                                         VFIOStateBuffer *lb,
>> +                                         Error **errp)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +    g_autofree char *buf = NULL;
>> +    char *buf_cur;
>> +    size_t buf_len;
>> +
>> +    if (!lb->len) {
>> +        return true;
>> +    }
>> +
>> +    trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>> +                                                   multifd->load_buf_idx);
> 
> I thin we can move this trace event to vfio_load_bufs_thread()

It would get messy since we don't load empty buffers,
so we we don't print this trace point (and its _end sibling)
for empty buffers.

If we print this in vfio_load_bufs_thread() then it would
need to duplicate that !lb->len check.

>> +    /* lb might become re-allocated when we drop the lock */
>> +    buf = g_steal_pointer(&lb->data);
>> +    buf_cur = buf;
>> +    buf_len = lb->len;
>> +    while (buf_len > 0) {
>> +        ssize_t wr_ret;
>> +        int errno_save;
>> +
>> +        /*
>> +         * Loading data to the device takes a while,
>> +         * drop the lock during this process.
>> +         */
>> +        qemu_mutex_unlock(&multifd->load_bufs_mutex);
>> +        wr_ret = write(migration->data_fd, buf_cur, buf_len);> +        errno_save = errno;
>> +        qemu_mutex_lock(&multifd->load_bufs_mutex);
>> +
>> +        if (wr_ret < 0) {
>> +            error_setg(errp,
>> +                       "writing state buffer %" PRIu32 " failed: %d",
>> +                       multifd->load_buf_idx, errno_save);
>> +            return false;
>> +        }
>> +
>> +        assert(wr_ret <= buf_len);
>> +        buf_len -= wr_ret;
>> +        buf_cur += wr_ret;
>> +    }
>> +
>> +    trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
>> +                                                 multifd->load_buf_idx);
> 
> and drop this trace event.

That's important data since it provides for how long it took to load that
buffer (_end - _start).

It's not the same information as _start(next buffer) - _start(current buffer)
since the next buffer might not have arrived yet so its loading won't
start immediately after the end of loading of the previous one.

> In which case, we can modify the parameters of vfio_load_state_buffer_write()
> to use directly a 'VFIOMultifd *multifd'and an fd instead of "migration->data_fd".
> 
>> +
>> +    return true;
>> +}
>> +
>> +static bool vfio_load_bufs_thread_want_exit(VFIOMultifd *multifd,
>> +                                            bool *should_quit)
>> +{
>> +    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
>> +}
>> +
>> +/*
>> + * This thread is spawned by vfio_multifd_switchover_start() which gets
>> + * called upon encountering the switchover point marker in main migration
>> + * stream.
>> + *
>> + * It exits after either:
>> + * * completing loading the remaining device state and device config, OR:
>> + * * encountering some error while doing the above, OR:
>> + * * being forcefully aborted by the migration core by it setting should_quit
>> + *   or by vfio_load_cleanup_load_bufs_thread() setting
>> + *   multifd->load_bufs_thread_want_exit.
>> + */
>> +static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +    bool ret = true;
>> +    int config_ret;
> 
> No needed IMO. see below.
> 
>> +
>> +    assert(multifd);
>> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
>> +
>> +    assert(multifd->load_bufs_thread_running);
> 
> We could add a trace event for the start and the end of the thread.

Added vfio_load_bufs_thread_{start,end} trace events now.

>> +    while (true) {
>> +        VFIOStateBuffer *lb;
>> +
>> +        /*
>> +         * Always check cancellation first after the buffer_ready wait below in
>> +         * case that cond was signalled by vfio_load_cleanup_load_bufs_thread().
>> +         */
>> +        if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
>> +            error_setg(errp, "operation cancelled");
>> +            ret = false;
>> +            goto ret_signal;
> 
> goto thread_exit ?

I'm not sure that I fully understand this comment.
Do you mean to rename ret_signal label to thread_exit?

>> +        }
>> +
>> +        assert(multifd->load_buf_idx <= multifd->load_buf_idx_last);
>> +
>> +        lb = vfio_load_state_buffer_get(multifd);
>> +        if (!lb) {
>> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
>> +                                                        multifd->load_buf_idx);
>> +            qemu_cond_wait(&multifd->load_bufs_buffer_ready_cond,
>> +                           &multifd->load_bufs_mutex);
>> +            continue;
>> +        }
>> +
>> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last) {
>> +            break;
>> +        }
>> +
>> +        if (multifd->load_buf_idx == 0) {
>> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
>> +        }
>> +
>> +        if (!vfio_load_state_buffer_write(vbasedev, lb, errp)) {
>> +            ret = false;
>> +            goto ret_signal;
>> +        }
>> +
>> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
>> +        }
>> +
>> +        multifd->load_buf_idx++;
>> +    }
> 
> if ret is assigned to true here, the "ret = false" can dropped

I inverted the "ret" logic here now - initialized ret to false
at definition, removed "ret = false" at every failure/early exit block
and added "ret = true" just before the "ret_signal" label.

>> +    config_ret = vfio_load_bufs_thread_load_config(vbasedev);
>> +    if (config_ret) {
>> +        error_setg(errp, "load config state failed: %d", config_ret);
>> +        ret = false;
>> +    }
> 
> please move to next patch. This is adding nothing to this patch
> since it's returning -EINVAL.
> 

That's the whole point - if someone were to accidentally enable this
(for example by forgetting to apply the next patch when backporting
the series) it would fail safely with EINVAL instead of having a
half-broken implementation.

Another option would be to simply integrate the next patch into this
one as these are two parts of the same single operation and I think
splitting them in two in the end brings little value.

> Thanks,
> 
> C.

Thanks,
Maciej


