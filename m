Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE2CC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 22:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpE6x-0003b3-TL; Mon, 03 Mar 2025 17:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpE6P-0003Ci-9a
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 17:17:36 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpE6M-0006t7-Od
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 17:17:32 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpE6I-00000000IFa-46XD; Mon, 03 Mar 2025 23:17:26 +0100
Message-ID: <4c7eb813-5397-463b-b92e-e9894dbc2a4c@maciej.szmigiero.name>
Date: Mon, 3 Mar 2025 23:17:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <608c869621ffe1688e08af98a373c33376487d53.1739994627.git.maciej.szmigiero@oracle.com>
 <bdf89ec6-95e0-4256-9944-5a94b3c88d22@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 xsFNBFpGusUBEADXUMM2t7y9sHhI79+2QUnDdpauIBjZDukPZArwD+sDlx5P+jxaZ13XjUQc
 6oJdk+jpvKiyzlbKqlDtw/Y2Ob24tg1g/zvkHn8AVUwX+ZWWewSZ0vcwp7u/LvA+w2nJbIL1
 N0/QUUdmxfkWTHhNqgkNX5hEmYqhwUPozFR0zblfD/6+XFR7VM9yT0fZPLqYLNOmGfqAXlxY
 m8nWmi+lxkd/PYqQQwOq6GQwxjRFEvSc09m/YPYo9hxh7a6s8hAP88YOf2PD8oBB1r5E7KGb
 Fv10Qss4CU/3zaiyRTExWwOJnTQdzSbtnM3S8/ZO/sL0FY/b4VLtlZzERAraxHdnPn8GgxYk
 oPtAqoyf52RkCabL9dsXPWYQjkwG8WEUPScHDy8Uoo6imQujshG23A99iPuXcWc/5ld9mIo/
 Ee7kN50MOXwS4vCJSv0cMkVhh77CmGUv5++E/rPcbXPLTPeRVy6SHgdDhIj7elmx2Lgo0cyh
 uyxyBKSuzPvb61nh5EKAGL7kPqflNw7LJkInzHqKHDNu57rVuCHEx4yxcKNB4pdE2SgyPxs9
 9W7Cz0q2Hd7Yu8GOXvMfQfrBiEV4q4PzidUtV6sLqVq0RMK7LEi0RiZpthwxz0IUFwRw2KS/
 9Kgs9LmOXYimodrV0pMxpVqcyTepmDSoWzyXNP2NL1+GuQtaTQARAQABzTBNYWNpZWogUy4g
 U3ptaWdpZXJvIDxtYWlsQG1hY2llai5zem1pZ2llcm8ubmFtZT7CwZQEEwEIAD4CGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZ7BxhgUJD0w7
 wQAKCRCEf143kM4JdwHlD/9Ef793d6Q3WkcapGZLg1hrUg+S3d1brtJSKP6B8Ny0tt/6kjc2
 M8q4v0pY6rA/tksIbBw6ZVZNCoce0w3/sy358jcDldh/eYotwUCHQzXl2IZwRT2SbmEoJn9J
 nAOnjMCpMFRyBC1yiWzOR3XonLFNB+kWfTK3fwzKWCmpcUkI5ANrmNiDFPcsn+TzfeMV/CzT
 FMsqVmr+TCWl29QB3U0eFZP8Y01UiowugS0jW/B/zWYbWo2FvoOqGLRUWgQ20NBXHlV5m0qa
 wI2Isrbos1kXSl2TDovT0Ppt+66RhV36SGA2qzLs0B9LO7/xqF4/xwmudkpabOoH5g3T20aH
 xlB0WuTJ7FyxZGnO6NL9QTxx3t86FfkKVfTksKP0FRKujsOxGQ1JpqdazyO6k7yMFfcnxwAb
 MyLU6ZepXf/6LvcFFe0oXC+ZNqj7kT6+hoTkZJcxynlcxSRzRSpnS41MRHJbyQM7kjpuVdyQ
 BWPdBnW0bYamlsW00w5XaR+fvNr4fV0vcqB991lxD4ayBbYPz11tnjlOwqnawH1ctCy5rdBY
 eTC6olpkmyUhrrIpTgEuxNU4GvnBK9oEEtNPC/x58AOxQuf1FhqbHYjz8D2Pyhso8TwS7NTa
 Z8b8o0vfsuqd3GPJKMiEhLEgu/io2KtLG10ynfh0vDBDQ7bwKoVlqC3It87AzQRaRrwiAQwA
 xnVmJqeP9VUTISps+WbyYFYlMFfIurl7tzK74bc67KUBp+PHuDP9p4ZcJUGC3UZJP85/GlUV
 dE1NairYWEJQUB7bpogTuzMI825QXIB9z842HwWfP2RW5eDtJMeujzJeFaUpmeTG9snzaYxY
 N3r0TDKj5dZwSIThIMQpsmhH2zylkT0jH7kBPxb8IkCQ1c6wgKITwoHFjTIO0B75U7bBNSDp
 XUaUDvd6T3xd1Fz57ujAvKHrZfWtaNSGwLmUYQAcFvrKDGPB5Z3ggkiTtkmW3OCQbnIxGJJw
 /+HefYhB5/kCcpKUQ2RYcYgCZ0/WcES1xU5dnNe4i0a5gsOFSOYCpNCfTHttVxKxZZTQ/rxj
 XwTuToXmTI4Nehn96t25DHZ0t9L9UEJ0yxH2y8Av4rtf75K2yAXFZa8dHnQgCkyjA/gs0ujG
 wD+Gs7dYQxP4i+rLhwBWD3mawJxLxY0vGwkG7k7npqanlsWlATHpOdqBMUiAR22hs02FikAo
 iXNgWTy7ABEBAAHCwXwEGAEIACYCGwwWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZ7BxrgUJ
 D0w6ggAKCRCEf143kM4Jd55ED/9M47pnUYDVoaa1Xu4dVHw2h0XhBS/svPqb80YtjcBVgRp0
 PxLkI6afwteLsjpDgr4QbjoF868ctjqs6p/M7+VkFJNSa4hPmCayU310zEawO4EYm+jPRUIJ
 i87pEmygoN4ZnXvOYA9lkkbbaJkYB+8rDFSYeeSjuez0qmISbzkRVBwhGXQG5s5Oyij2eJ7f
 OvtjExsYkLP3NqmsODWj9aXqWGYsHPa7NpcLvHtkhtc5+SjRRLzh/NWJUtgFkqNPfhGMNwE8
 IsgCYA1B0Wam1zwvVgn6yRcwaCycr/SxHZAR4zZQNGyV1CA+Ph3cMiL8s49RluhiAiDqbJDx
 voSNR7+hz6CXrAuFnUljMMWiSSeWDF+qSKVmUJIFHWW4s9RQofkF8/Bd6BZxIWQYxMKZm4S7
 dKo+5COEVOhSyYthhxNMCWDxLDuPoiGUbWBu/+8dXBusBV5fgcZ2SeQYnIvBzMj8NJ2vDU2D
 m/ajx6lQA/hW0zLYAew2v6WnHFnOXUlI3hv9LusUtj3XtLV2mf1FHvfYlrlI9WQsLiOE5nFN
 IsqJLm0TmM0i8WDnWovQHM8D0IzI/eUc4Ktbp0fVwWThP1ehdPEUKGCZflck5gvuU8yqE55r
 VrUwC3ocRUs4wXdUGZp67sExrfnb8QC2iXhYb+TpB8g7otkqYjL/nL8cQ8hdmg==
In-Reply-To: <bdf89ec6-95e0-4256-9944-5a94b3c88d22@nvidia.com>
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

On 2.03.2025 15:41, Avihai Horon wrote:
> 
> On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Implement the multifd device state transfer via additional per-device
>> thread inside save_live_complete_precopy_thread handler.
>>
>> Switch between doing the data transfer in the new handler and doing it
>> in the old save_state handler depending on the
>> x-migration-multifd-transfer device property value.
> 
> x-migration-multifd-transfer is not yet introduced. Maybe rephrase to:
> 
> ... depending if VFIO multifd transfer is enabled or not.

Changed accordingly.

>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration-multifd.c   | 139 ++++++++++++++++++++++++++++++++++
>>   hw/vfio/migration-multifd.h   |   5 ++
>>   hw/vfio/migration.c           |  26 +++++--
>>   hw/vfio/trace-events          |   2 +
>>   include/hw/vfio/vfio-common.h |   8 ++
>>   5 files changed, 174 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 7200f6f1c2a2..0cfa9d31732a 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -476,6 +476,145 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>>       return true;
>>   }
>>
>> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
>> +{
>> +    assert(vfio_multifd_transfer_enabled(vbasedev));
>> +
>> +    /*
>> +     * Emit dummy NOP data on the main migration channel since the actual
>> +     * device state transfer is done via multifd channels.
>> +     */
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +}
>> +
>> +static bool
>> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>> +                                               char *idstr,
>> +                                               uint32_t instance_id,
>> +                                               uint32_t idx,
>> +                                               Error **errp)
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
>> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
>> +        return false;
>> +    }
>> +
>> +    ret = qemu_fflush(f);
>> +    if (ret) {
>> +        error_setg(errp, "save config state flush failed: %d", ret);
> 
> Let's add vbasedev->name to the error message so we know which device caused the error.

Done.

>> +        return false;
>> +    }
>> +
>> +    packet_len = sizeof(*packet) + bioc->usage;
>> +    packet = g_malloc0(packet_len);
>> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>> +    packet->idx = idx;
>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>> +    memcpy(&packet->data, bioc->data, bioc->usage);
>> +
>> +    if (!multifd_queue_device_state(idstr, instance_id,
>> +                                    (char *)packet, packet_len)) {
>> +        error_setg(errp, "multifd config data queuing failed");
> 
> Ditto.

Done.

>> +        return false;
>> +    }
>> +
>> +    vfio_add_bytes_transferred(packet_len);
>> +
>> +    return true;
>> +}
>> +
>> +/*
>> + * This thread is spawned by the migration core directly via
>> + * .save_live_complete_precopy_thread SaveVMHandler.
>> + *
>> + * It exits after either:
>> + * * completing saving the remaining device state and device config, OR:
>> + * * encountering some error while doing the above, OR:
>> + * * being forcefully aborted by the migration core by
>> + *   multifd_device_state_save_thread_should_exit() returning true.
>> + */
>> +bool vfio_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
>> +                                       Error **errp)
>> +{
>> +    VFIODevice *vbasedev = d->handler_opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    bool ret;
>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>> +    uint32_t idx;
>> +
>> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
>> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
>> +        return true;
>> +    }
>> +
>> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
>> +                                                  d->idstr, d->instance_id);
>> +
>> +    /* We reach here with device state STOP or STOP_COPY only */
>> +    if (vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>> +                                 VFIO_DEVICE_STATE_STOP, errp)) {
>> +        ret = false;
>> +        goto ret_finish;
>> +    }
>> +
>> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
>> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>> +
>> +    for (idx = 0; ; idx++) {
>> +        ssize_t data_size;
>> +        size_t packet_size;
>> +
>> +        if (multifd_device_state_save_thread_should_exit()) {
>> +            error_setg(errp, "operation cancelled");
> 
> Same comment as in patch #27:
> 
> IIUC, if multifd_device_state_save_thread_should_exit() returns true, it means that some other code part already failed and set migration error, no?
> If so, shouldn't we return true here? After all, vfio_save_complete_precopy_thread didn't really fail, it just got signal to terminate itself

Same as in the "load thread" case - the thread didn't succeed with saving all the data either,
but got cancelled.

> 
>> +            ret = false;
>> +            goto ret_finish;
>> +        }
>> +
>> +        data_size = read(migration->data_fd, &packet->data,
>> +                         migration->data_buffer_size);
>> +        if (data_size < 0) {
>> +            error_setg(errp, "reading state buffer %" PRIu32 " failed: %d",
>> +                       idx, errno);
> 
> Let's add vbasedev->name to the error message so we know which device caused the error.

Done.

>> +            ret = false;
>> +            goto ret_finish;
>> +        } else if (data_size == 0) {
>> +            break;
>> +        }
>> +
>> +        packet->idx = idx;
>> +        packet_size = sizeof(*packet) + data_size;
>> +
>> +        if (!multifd_queue_device_state(d->idstr, d->instance_id,
>> +                                        (char *)packet, packet_size)) {
>> +            error_setg(errp, "multifd data queuing failed");
> 
> Ditto.

Done.

> Thanks.
> 

Thanks,
Maciej


