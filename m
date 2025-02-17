Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC91C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 22:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk9M3-0000B6-9i; Mon, 17 Feb 2025 17:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9M1-0000Ax-QS
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:12:41 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9Lz-0003lW-CG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:12:41 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9Lu-00000007PK5-08zN; Mon, 17 Feb 2025 23:12:34 +0100
Message-ID: <f5469b68-bd93-4feb-8109-bcc6abd533d7@maciej.szmigiero.name>
Date: Mon, 17 Feb 2025 23:12:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 31/33] vfio/migration: Multifd device state transfer
 support - send side
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <6c79a4f61f0b8bee30cda8242af7f51856392051.1738171076.git.maciej.szmigiero@oracle.com>
 <adfcab18-549c-4a15-be87-1ca73ffffa0f@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <adfcab18-549c-4a15-be87-1ca73ffffa0f@redhat.com>
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

On 12.02.2025 18:03, Cédric Le Goater wrote:
> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Implement the multifd device state transfer via additional per-device
>> thread inside save_live_complete_precopy_thread handler.
>>
>> Switch between doing the data transfer in the new handler and doing it
>> in the old save_state handler depending on the
>> x-migration-multifd-transfer device property value.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration.c  | 159 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |   2 +
>>   2 files changed, 161 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 31f651ffee85..37d1c0f3d32f 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -943,6 +943,24 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>>       int ret;
>> +    /*
>> +     * Make a copy of this setting at the start in case it is changed
>> +     * mid-migration.
>> +     */
>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
>> +    } else {
>> +        migration->multifd_transfer =
>> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
>> +    }
>> +
>> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
>> +        error_setg(errp,
>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>> +                   vbasedev->name);
>> +        return -EINVAL;
>> +    }
> 
> Please implement a common routine vfio_multifd_is_enabled() that can be
> shared with vfio_load_setup().

Done/almost done (details are being worked out in conversation about other patch).

>> +
>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>> @@ -1114,13 +1132,32 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>       return !migration->precopy_init_size && !migration->precopy_dirty_size;
>>   }
>> +static void vfio_save_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
> 
> I would prefer naming it vfio_multifd_emit_dummy_eos().

Done.

>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    assert(migration->multifd_transfer);
>> +
>> +    /*
>> +     * Emit dummy NOP data on the main migration channel since the actual
>> +     * device state transfer is done via multifd channels.
>> +     */
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +}
>> +
>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       ssize_t data_size;
>>       int ret;
>>       Error *local_err = NULL;
>> +    if (migration->multifd_transfer) {
>> +        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
>> +        return 0;
>> +    }
>> +
>>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>>       /* We reach here with device state STOP or STOP_COPY only */
>> @@ -1146,12 +1183,133 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>       return ret;
>>   }
>> +static int
>> +vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
>> +                                                     char *idstr,
>> +                                                     uint32_t instance_id,
>> +                                                     uint32_t idx)
> 
> why use 'async_thread' in the name ?
> 
> vfio_save_complete_precopy_config_state() should be enough to refer
> to its caller vfio_save_complete_precopy_thread(). 

That "async" part is truly unnecessary since it's a leftover from
patch set v1 days when the thread entry point was called
"vfio_save_complete_precopy_async_thread".

But I will keep the "thread" part since naming it just
"vfio_save_complete_precopy_config_state()" would suggest it's
called from normal precopy handler (vfio_save_complete_precopy()).

> Please add
> an 'Error **' argument too.
> 

Good idea, done now.

>> +{
>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>> +    g_autoptr(QEMUFile) f = NULL;
>> +    int ret;
>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>> +    size_t packet_len;
>> +
>> +    bioc = qio_channel_buffer_new(0);
>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
>> +
>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>> +
>> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
> 
> I would prefer that we catch the error and propagate it to the caller.

Sure.

>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    ret = qemu_fflush(f);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    packet_len = sizeof(*packet) + bioc->usage;
>> +    packet = g_malloc0(packet_len);
>> +    packet->idx = idx;
>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>> +    memcpy(&packet->data, bioc->data, bioc->usage);
>> +
>> +    if (!multifd_queue_device_state(idstr, instance_id,
>> +                                    (char *)packet, packet_len)) {
>> +        return -1;
>> +    }
>> +
>> +    qatomic_add(&bytes_transferred, packet_len);
>> +
>> +    return 0;
>> +}
>> +
>> +static int vfio_save_complete_precopy_thread(char *idstr,
>> +                                             uint32_t instance_id,
>> +                                             bool *abort_flag,
>> +                                             void *opaque)
> 
> This lacks an "Error **" argument. I am not sure what was decided
> in patch 19 "migration: Add save_live_complete_precopy_thread
> handler".
> 
> We should do our best to collect and propagate errors and avoid
> error_report() calls. With VFIO involved, the reasons why errors
> can occur are increasingly numerous, as hardware is exposed and
> host drivers are involved.
> 
> I understand this is a complex request for code when this code
> relies on a framework using callbacks, even more with threads.

It now has an Error argument from the changes resulting from
discussions with Peter:
https://gitlab.com/maciejsszmigiero/qemu/-/commit/0e23b66291b95c10ec1f0d82830320cae9e06ce4

>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>> +    uint32_t idx;
>> +
>> +    if (!migration->multifd_transfer) {
>> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
> 
> why would vfio_save_complete_precopy_thread be called then ? 

The migration core launches these threads if it supports device
state transfer.

But the driver (in this case) VFIO might have such transfer
unsupported for its own reasons - like because user disabled
switchover start message or just explicitly disabled this transfer.

Or maybe even the device does not like this transfer for some
reason (possible in the ARM case without config state interlock).

We discussed this detail during v3 with Avihai and Peter and
decided to do this this way (launching this thread unconditionally)
rather than export additional SaveVMHandler through which
the device could tell the migration core whether it wants such thread:
https://lore.kernel.org/qemu-devel/Z2BkbkF6P-2MHNN2@x1n/

> Looks
> like an error to me, may be not fatal but an error report would be
> good to have. no ?
> 
>> +        return 0;
>> +    }
>> +
>> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
>> +                                                  idstr, instance_id);
>> +
>> +    /* We reach here with device state STOP or STOP_COPY only */
>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>> +                                   VFIO_DEVICE_STATE_STOP, NULL);
> 
> Error missing.

Already taken care of when adding Error parameter to the thread entry
point function, but good point anyway.

>> +    if (ret) {
>> +        goto ret_finish;
>> +    }
>> +
>> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
>> +
>> +    for (idx = 0; ; idx++) {
>> +        ssize_t data_size;
>> +        size_t packet_size;
>> +
>> +        if (qatomic_read(abort_flag)) {
>> +            ret = -ECANCELED;
>> +            goto ret_finish;
>> +        }
>> +
>> +        data_size = read(migration->data_fd, &packet->data,
>> +                         migration->data_buffer_size);
>> +        if (data_size < 0) {
>> +            ret = -errno;
>> +            goto ret_finish;
>> +        } else if (data_size == 0) {
>> +            break;
>> +        }
>> +
>> +        packet->idx = idx;
>> +        packet_size = sizeof(*packet) + data_size;
>> +
>> +        if (!multifd_queue_device_state(idstr, instance_id,
>> +                                        (char *)packet, packet_size)) {
>> +            ret = -1;
>> +            goto ret_finish;
>> +        }
>> +
>> +        qatomic_add(&bytes_transferred, packet_size);
>> +    }
>> +
>> +    ret = vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
>> +                                                               instance_id,
>> +                                                               idx);
>> +
>> +ret_finish:
>> +    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
>> +
>> +    return ret;
>> +}
>> +
>>   static void vfio_save_state(QEMUFile *f, void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       Error *local_err = NULL;
>>       int ret;
>> +    if (migration->multifd_transfer) {
>> +        if (vfio_load_config_after_iter(vbasedev)) {
>> +            qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY);
> 
> 
> Please put the above chunck at the end of the series with the patch
> adding ARM support.

Done.

>> +        } else {
>> +            vfio_save_multifd_emit_dummy_eos(vbasedev, f);
>> +        }
> 
> Please introduce a vfio_multifd_save_state() routine and a
> vfio_"normal"_save_state() routine and change vfio_save_state()
> to call one or the other.
> 

So what should be the name of this "normal" save state routine
then, since you put "normal" in quotes?
vfio_nonmultifd_save_state()?

> Thanks,
> 
> C.

Thanks,
Maciej


