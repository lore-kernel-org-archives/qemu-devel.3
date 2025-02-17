Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE5CC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 22:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk9JW-0006RP-Pk; Mon, 17 Feb 2025 17:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9JU-0006Qp-W9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:10:05 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9JS-0003TC-S7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:10:04 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9JO-00000007PJi-3gMI; Mon, 17 Feb 2025 23:09:58 +0100
Message-ID: <4f335de0-ba9f-4537-b230-2cf8af1c160b@maciej.szmigiero.name>
Date: Mon, 17 Feb 2025 23:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/33] vfio/migration: Multifd device state transfer
 support - config loading support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <de41d1ae244fccfa928eb78787ba903b420e1346.1738171076.git.maciej.szmigiero@oracle.com>
 <6a7108ac-38be-4028-bc07-bb9b68625906@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <6a7108ac-38be-4028-bc07-bb9b68625906@redhat.com>
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

On 12.02.2025 17:21, Cédric Le Goater wrote:
> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Load device config received via multifd using the existing machinery
>> behind vfio_load_device_config_state().
>>
>> Also, make sure to process the relevant main migration channel flags.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration.c | 103 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 98 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index ab5b097f59c9..31f651ffee85 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/vfio.h>
>>   #include <sys/ioctl.h>
>> +#include "io/channel-buffer.h"
>>   #include "system/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>>   #include "migration/misc.h"
>> @@ -457,6 +458,57 @@ static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>>       return true;
>>   }
>> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>> +
>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +    VFIOStateBuffer *lb;
>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>> +    QEMUFile *f_out = NULL, *f_in = NULL;
>> +    uint64_t mig_header;
>> +    int ret;
>> +
>> +    assert(multifd->load_buf_idx == multifd->load_buf_idx_last);
>> +    lb = vfio_state_buffers_at(&multifd->load_bufs, multifd->load_buf_idx);
>> +    assert(lb->is_present);
>> +
>> +    bioc = qio_channel_buffer_new(lb->len);
>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
>> +
>> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
>> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
>> +
>> +    ret = qemu_fflush(f_out);
>> +    if (ret) {
>> +        g_clear_pointer(&f_out, qemu_fclose);
>> +        return ret;
>> +    }
>> +
>> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
>> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
>> +
>> +    mig_header = qemu_get_be64(f_in);
>> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
>> +        g_clear_pointer(&f_out, qemu_fclose);
>> +        g_clear_pointer(&f_in, qemu_fclose);
>> +        return -EINVAL;
>> +    }
>> +
>> +    bql_lock();
>> +    ret = vfio_load_device_config_state(f_in, vbasedev);
>> +    bql_unlock();
>> +
>> +    g_clear_pointer(&f_out, qemu_fclose);
>> +    g_clear_pointer(&f_in, qemu_fclose);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
>>   {
>>       VFIOStateBuffer *lb;
>> @@ -477,11 +529,6 @@ static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
>>       return lb;
>>   }
>> -static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>> -{
>> -    return -EINVAL;
>> -}
> 
> Please remove this change from this patch and from patch 28.

The dummy call has to be there, otherwise the code at the
previous commit time wouldn't compile since that
vfio_load_bufs_thread_load_config() call is a part of
vfio_load_bufs_thread().

This is an artifact of splitting the whole load operation in
multiple commits.

>>   static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
>>                                            VFIOStateBuffer *lb,
>>                                            Error **errp)
>> @@ -1168,6 +1215,8 @@ static int vfio_load_cleanup(void *opaque)
>>   static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>>       int ret = 0;
>>       uint64_t data;
>> @@ -1179,6 +1228,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>           switch (data) {
>>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>>           {
>> +            if (migration->multifd_transfer) {
>> +                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
>> +                             vbasedev->name);
>> +                return -EINVAL;
>> +            }
>> +
>>               return vfio_load_device_config_state(f, opaque);
>>           }
>>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
>> @@ -1223,6 +1278,44 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>               return ret;
>>           }
>> +        case VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY:
>> +        {
>> +            if (!migration->multifd_transfer) {
>> +                error_report("%s: got DEV_CONFIG_LOAD_READY outside multifd transfer",
>> +                             vbasedev->name);
>> +                return -EINVAL;
>> +            }
>> +
>> +            if (!vfio_load_config_after_iter(vbasedev)) {
>> +                error_report("%s: got DEV_CONFIG_LOAD_READY but was disabled",
>> +                             vbasedev->name);
>> +                return -EINVAL;
>> +            }
> 
> Please put the above chunck at the end of the series with the patch
> adding ARM support.

Done.

> 
>> +            assert(multifd);
>> +
>> +            /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
>> +            bql_unlock();
>> +            WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
>> +                if (multifd->load_bufs_iter_done) {
>> +                    /* Can't print error here as we're outside BQL */
>> +                    ret = -EINVAL;
>> +                    break;
>> +                }
>> +
>> +                multifd->load_bufs_iter_done = true;
>> +                qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
>> +                ret = 0;> +            }
>> +            bql_lock();
> 
> Please introduce a vfio_multifd routine for the code above.

Done.

> 
> 
> Thanks,
> 
> C.
> 

Thanks,
Maciej


