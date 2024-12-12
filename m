Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835EFE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 22:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLs33-0000dQ-I2; Thu, 12 Dec 2024 17:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLs31-0000dB-D8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:52:43 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLs2y-0006xz-Ko
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:52:43 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLs2q-00000003gVD-1HxW; Thu, 12 Dec 2024 23:52:32 +0100
Message-ID: <4c8c3309-b2a1-465a-9108-52eae22d67aa@maciej.szmigiero.name>
Date: Thu, 12 Dec 2024 23:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] vfio/migration: Multifd device state transfer
 support - send side
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
 <51279885-5229-4c5f-93af-d1214dd65f90@nvidia.com>
 <06360868-95e3-46e2-8960-51348025a1b7@maciej.szmigiero.name>
 <80c9dfc4-4105-4e48-bcae-4fa9780a43c8@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <80c9dfc4-4105-4e48-bcae-4fa9780a43c8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12.12.2024 12:10, Cédric Le Goater wrote:
> On 12/11/24 00:06, Maciej S. Szmigiero wrote:
>> On 9.12.2024 10:28, Avihai Horon wrote:
>>>
>>> On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Implement the multifd device state transfer via additional per-device
>>>> thread inside save_live_complete_precopy_thread handler.
>>>>
>>>> Switch between doing the data transfer in the new handler and doing it
>>>> in the old save_state handler depending on the
>>>> x-migration-multifd-transfer device property value.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   hw/vfio/migration.c  | 155 +++++++++++++++++++++++++++++++++++++++++++
>>>>   hw/vfio/trace-events |   2 +
>>>>   2 files changed, 157 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index b54879fe6209..8709672ada48 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
(...)
>>>> +
>>>>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>>>>
>>>>       /* We reach here with device state STOP or STOP_COPY only */
>>>> @@ -974,12 +1011,129 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>>       return ret;
>>>>   }
>>>>
>>>> +static int
>>>> +vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
>>>> +                                                     char *idstr,
>>>> +                                                     uint32_t instance_id,
>>>> +                                                     uint32_t idx)
>>>> +{
>>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>>> +    g_autoptr(QEMUFile) f = NULL;
>>>> +    int ret;
>>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>>> +    size_t packet_len;
>>>> +
>>>> +    bioc = qio_channel_buffer_new(0);
>>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
>>>> +
>>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>>> +
>>>> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
>>>> +    if (ret) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = qemu_fflush(f);
>>>> +    if (ret) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>>> +    packet = g_malloc0(packet_len);
>>>> +    packet->idx = idx;
>>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>>> +    memcpy(&packet->data, bioc->data, bioc->usage);
>>>> +
>>>> +    if (!multifd_queue_device_state(idstr, instance_id,
>>>> +                                    (char *)packet, packet_len)) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    qatomic_add(&bytes_transferred, packet_len);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int vfio_save_complete_precopy_thread(char *idstr,
>>>> +                                             uint32_t instance_id,
>>>> +                                             bool *abort_flag,
>>>> +                                             void *opaque)
>>>> +{
>>>> +    VFIODevice *vbasedev = opaque;
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +    int ret;
>>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>>> +    uint32_t idx;
>>>> +
>>>> +    if (!migration->multifd_transfer) {
>>>> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
>>>> +                                                  idstr, instance_id);
>>>> +
>>>> +    /* We reach here with device state STOP or STOP_COPY only */
>>>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>>>> +                                   VFIO_DEVICE_STATE_STOP, NULL);
>>>> +    if (ret) {
>>>> +        goto ret_finish;
>>>> +    }
>>>> +
>>>> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
>>>> +
>>>> +    for (idx = 0; ; idx++) {
>>>> +        ssize_t data_size;
>>>> +        size_t packet_size;
>>>> +
>>>> +        if (qatomic_read(abort_flag)) {
>>>> +            ret = -ECANCELED;
>>>> +            goto ret_finish;
>>>> +        }
>>>> +
>>>> +        data_size = read(migration->data_fd, &packet->data,
>>>> +                         migration->data_buffer_size);
>>>> +        if (data_size < 0) {
>>>> +            ret = -errno;
>>>> +            goto ret_finish;
>>>> +        } else if (data_size == 0) {
>>>> +            break;
>>>> +        }
>>>> +
>>>> +        packet->idx = idx;
>>>> +        packet_size = sizeof(*packet) + data_size;
>>>> +
>>>> +        if (!multifd_queue_device_state(idstr, instance_id,
>>>> +                                        (char *)packet, packet_size)) {
>>>> +            ret = -1;
>>>> +            goto ret_finish;
>>>> +        }
>>>> +
>>>> +        qatomic_add(&bytes_transferred, packet_size);
>>>> +    }
>>>> +
>>>> +    ret = vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
>>>> +                                                               instance_id,
>>>> +                                                               idx);
>>>
>>> I am not sure it's safe to save the config space asyncly in the thread, as it might be dependent on other device's non-iterable state being loaded first.
>>> See commit d329f5032e17 ("vfio: Move the saving of the config space to the right place in VFIO migration") which moved config space saving to the non-iterable state saving.
>>
>> That's an important information - thanks for pointing this out.
>>
>> Since we don't want to lose this config state saving parallelism
>> (and the future config state saving parallelism) on unaffected platform
>> we'll probably need to disable this functionality for ARM64.
>>
>> By the way, this kind of an implicit dependency in VMState between devices
>> is really hard to manage, there should be a way to specify it in code somehow..
> 
> vmstate has a MigrationPriority field to order loading between
> devices. Maybe we could extend but I think it is better to handle
> ordering at the device level when there are no external dependencies.
> It should be well documented though in the code.
> 

To be clear, by "handling ordering at the device level" you mean
just disabling this functionality for ARM64 as proposed above?

> 
> Thanks,
> 
> C.
> 
> 
>>
>>> Thanks.


Thanks,
Maciej



