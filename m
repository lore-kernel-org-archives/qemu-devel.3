Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC83DC021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj74i-000447-1s; Fri, 14 Feb 2025 20:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tj2jK-0003fW-Oa
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:56:10 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tj2jI-0004tH-6y
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:56:10 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tj2j2-00000007HoU-34vJ; Fri, 14 Feb 2025 21:55:52 +0100
Message-ID: <1ab2d96f-f37d-466e-83db-0e3d39581bc7@maciej.szmigiero.name>
Date: Fri, 14 Feb 2025 21:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/33] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <1fcf182307e8e1f67a3c226e62d26cad3a2f60d0.1738171076.git.maciej.szmigiero@oracle.com>
 <6c337aec-d004-4ede-a86b-0c934b275fa9@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <6c337aec-d004-4ede-a86b-0c934b275fa9@redhat.com>
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

On 12.02.2025 11:55, Cédric Le Goater wrote:
> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Add support for VFIOMultifd data structure that will contain most of the
>> receive-side data together with its init/cleanup methods.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration.c           | 52 +++++++++++++++++++++++++++++++++--
>>   include/hw/vfio/vfio-common.h |  5 ++++
>>   2 files changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 3211041939c6..bcdf204d5cf4 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -300,6 +300,9 @@ typedef struct VFIOStateBuffer {
>>       size_t len;
>>   } VFIOStateBuffer;
>> +typedef struct VFIOMultifd {
>> +} VFIOMultifd;
>> +
>>   static void vfio_state_buffer_clear(gpointer data)
>>   {
>>       VFIOStateBuffer *lb = data;
>> @@ -398,6 +401,18 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>       return qemu_file_get_error(f);
>>   }
>> +static VFIOMultifd *vfio_multifd_new(void)
>> +{
>> +    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>> +
>> +    return multifd;
>> +}
>> +
>> +static void vfio_multifd_free(VFIOMultifd *multifd)
>> +{
>> +    g_free(multifd);
>> +}
>> +
>>   static void vfio_migration_cleanup(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>> @@ -785,14 +800,47 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    /*
>> +     * Make a copy of this setting at the start in case it is changed
>> +     * mid-migration.
>> +     */
>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
> 
> Attribute "migration->multifd_transfer" is not necessary. It can be
> replaced by a small inline helper testing pointer migration->multifd
> and this routine can use a local variable instead.

It's necessary for the send side since it does not need/allocate VFIOMultifd
at migration->multifd, so this (receive) side can use it for commonality too.

> I don't think the '_transfer' suffix adds much to the understanding.

The migration->multifd was already taken by VFIOMultifd struct, but
it could use other name (migration->multifd_switch? migration->multifd_on?).

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
> The above checks are also introduced in vfio_save_setup(). Please
> implement a common routine vfio_multifd_is_enabled() or some other
> name.

Done (as common vfio_multifd_transfer_setup()).

>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> +                                   migration->device_state, errp);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    if (migration->multifd_transfer) {
>> +        assert(!migration->multifd);
>> +        migration->multifd = vfio_multifd_new();
>> +    }
>> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> -                                    vbasedev->migration->device_state, errp);
>> +    return 0;
>>   }
>>   static int vfio_load_cleanup(void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    g_clear_pointer(&migration->multifd, vfio_multifd_free);
> 
> please add a vfio_multifd_cleanup() routine.
> 

Done.

>>       vfio_migration_cleanup(vbasedev);
>>       trace_vfio_load_cleanup(vbasedev->name);
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 153d03745dc7..c0c9c0b1b263 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -61,6 +61,8 @@ typedef struct VFIORegion {
>>       uint8_t nr; /* cache the region number for debug */
>>   } VFIORegion;
>> +typedef struct VFIOMultifd VFIOMultifd;
>> +
>>   typedef struct VFIOMigration {
>>       struct VFIODevice *vbasedev;
>>       VMChangeStateEntry *vm_state;
>> @@ -72,6 +74,8 @@ typedef struct VFIOMigration {
>>       uint64_t mig_flags;
>>       uint64_t precopy_init_size;
>>       uint64_t precopy_dirty_size;
>> +    bool multifd_transfer;
>> +    VFIOMultifd *multifd;
>>       bool initial_data_sent;
>>       bool event_save_iterate_started;
>> @@ -133,6 +137,7 @@ typedef struct VFIODevice {
>>       bool no_mmap;
>>       bool ram_block_discard_allowed;
>>       OnOffAuto enable_migration;
>> +    OnOffAuto migration_multifd_transfer;
> 
> This property should be added at the end of the series, with documentation,
> and used in the vfio_multifd_some_name() routine I mentioned above.
> 

The property behind this variable *is* in fact introduced at the end of the series -
in a commit called "vfio/migration: Add x-migration-multifd-transfer VFIO property"
after which there are only commits adding the related compat entry and a VFIO
developer doc update.

The variable itself needs to be introduced earlier since various newly
introduced code blocks depend on its value to only get activated when multifd
transfer is enabled.

> Thanks,
> 
> C.

Thanks,
Maciej


