Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF48BC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 22:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk9Iw-0006NA-Hz; Mon, 17 Feb 2025 17:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9Iu-0006Mg-B4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:09:28 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9Ir-0003RK-MW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:09:28 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9Ij-00000007PJ6-47kw; Mon, 17 Feb 2025 23:09:17 +0100
Message-ID: <b60f796a-2194-4ca1-99ce-b5d43a3828dd@maciej.szmigiero.name>
Date: Mon, 17 Feb 2025 23:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/33] vfio/migration: Multifd device state transfer
 support - load thread
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <3e1708a19ab743441a4771a8868043887ea4543c.1738171076.git.maciej.szmigiero@oracle.com>
 <da120a2a-a906-48be-a20e-8cd570a5c0b6@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <da120a2a-a906-48be-a20e-8cd570a5c0b6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 12.02.2025 16:48, Cédric Le Goater wrote:
> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
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
>>   hw/vfio/migration.c  | 229 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |   5 +
>>   2 files changed, 234 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 0c0caec1bd64..ab5b097f59c9 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -301,8 +301,16 @@ typedef struct VFIOStateBuffer {
>>   } VFIOStateBuffer;
>>   typedef struct VFIOMultifd {
>> +    QemuThread load_bufs_thread;
>> +    bool load_bufs_thread_running;
>> +    bool load_bufs_thread_want_exit;
>> +
>> +    bool load_bufs_iter_done;
>> +    QemuCond load_bufs_iter_done_cond;
>> +
>>       VFIOStateBuffers load_bufs;
>>       QemuCond load_bufs_buffer_ready_cond;
>> +    QemuCond load_bufs_thread_finished_cond;
>>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>       uint32_t load_buf_idx;
>>       uint32_t load_buf_idx_last;
>> @@ -449,6 +457,171 @@ static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>>       return true;
>>   }
>> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
>> +{
>> +    VFIOStateBuffer *lb;
>> +    guint bufs_len;
>> +
>> +    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
>> +    if (multifd->load_buf_idx >= bufs_len) {
>> +        assert(multifd->load_buf_idx == bufs_len);
>> +        return NULL;
>> +    }
>> +
>> +    lb = vfio_state_buffers_at(&multifd->load_bufs,
>> +                               multifd->load_buf_idx);
>> +    if (!lb->is_present) {
>> +        return NULL;
>> +    }
>> +
>> +    return lb;
>> +}
>> +
>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>> +{
>> +    return -EINVAL;
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
>> +
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
>> +        wr_ret = write(migration->data_fd, buf_cur, buf_len);
>> +        errno_save = errno;
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
>> +
>> +    return true;
>> +}
>> +
>> +static bool vfio_load_bufs_thread_want_abort(VFIOMultifd *multifd,
>> +                                             bool *should_quit)
>> +{
>> +    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
>> +}
> 
> _abort or _exit or _quit ? I would opt for vfio_load_bufs_thread_want_exit()
> to match multifd->load_bufs_thread_want_exit.
> 

Will rename to vfio_load_bufs_thread_want_exit().

> 
>> +static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +    bool ret = true;
>> +    int config_ret;
>> +
>> +    assert(multifd);
>> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
>> +
>> +    assert(multifd->load_bufs_thread_running);
>> +
>> +    while (!vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
>> +        VFIOStateBuffer *lb;
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
>> +        assert(multifd->load_buf_queued_pending_buffers > 0);
>> +        multifd->load_buf_queued_pending_buffers--;
>> +
>> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
>> +        }
>> +
>> +        multifd->load_buf_idx++;
>> +    }
>> +
>> +    if (vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
>> +        error_setg(errp, "operation cancelled");
>> +        ret = false;
>> +        goto ret_signal;
>> +    }
>> +
>> +    if (vfio_load_config_after_iter(vbasedev)) {
>> +        while (!multifd->load_bufs_iter_done) {
>> +            qemu_cond_wait(&multifd->load_bufs_iter_done_cond,
>> +                           &multifd->load_bufs_mutex);
>> +
>> +            if (vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
>> +                error_setg(errp, "operation cancelled");
>> +                ret = false;
>> +                goto ret_signal;
>> +            }
>> +        }
>> +    }
> 
> Please put the above chunck at the end of the series with the patch
> adding ARM support. I think load_bufs_iter_done_cond should be moved
> out of this patch too.

Done, including moving multifd->load_bufs_iter_done_cond:
https://gitlab.com/maciejsszmigiero/qemu/-/commit/3739872954d79373d4d99c8ff9ed50709e84a9c5

> 
> 
> Thanks,
> 
> C.

Thanks,
Maciej


