Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F3AD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80mL-0003gX-5Q; Mon, 04 Nov 2024 12:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t80mI-0003g2-9t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:22:10 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t80mF-0007uO-N4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:22:10 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t80m6-00000001MWl-2OtE; Mon, 04 Nov 2024 18:21:58 +0100
Message-ID: <3cdafdcd-570a-45ed-bb4d-f157842fcecb@maciej.szmigiero.name>
Date: Mon, 4 Nov 2024 18:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/migration: Add
 save_{iterate,complete_precopy}_started trace events
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <8fbb9cc40d9db570eff0a02e49104835014a5a4d.1730731549.git.maciej.szmigiero@oracle.com>
 <01c3cab0-75f2-4e36-b39f-00afea6058a9@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <01c3cab0-75f2-4e36-b39f-00afea6058a9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi Cédric,

On 4.11.2024 18:11, Cédric Le Goater wrote:
> Hello Maciej,
> 
> On 11/4/24 15:58, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This way both the start and end points of migrating a particular VFIO
>> device are known.
>>
>> Add also a vfio_precopy_empty_hit trace event so it is known when
>> there's no more data to send for that device.
> 
> Would you mind splitting the patch in 2, one patch for each event flag
> added ?

Sure,
so you'd prefer 3 patches in total then, for 3 trace events added
or vfio_save_{iterate,complete_precopy}_start* in the first and
vfio_precopy_empty_hit in the second patch?

>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>
>> This is just the lone remaining functionality-affecting patch from this
>> series of 4 trivial patches for QEMU 9.2:
>> https://lore.kernel.org/qemu-devel/cover.1730203967.git.maciej.szmigiero@oracle.com/
>> Two other such patches were already queued and the fourth one is only
>> an annotation in a code comment block.
>>
>> Changes from the v1 that was posted as a part of the above series:
>> * Move the vfio_save_iterate_empty_hit trace event to vfio_save_block(),
>> trigger it on ENOMSG errno and rename it to vfio_precopy_empty_hit.
>>
>> * Re-arm the above trace event if we see another data read so not only
>> the first "data present" -> "data not present" edge is logged.
>>
>>   hw/vfio/migration.c           | 17 +++++++++++++++++
>>   hw/vfio/trace-events          |  3 +++
>>   include/hw/vfio/vfio-common.h |  3 +++
>>   3 files changed, 23 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 992dc3b10257..e7b81f99e595 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -370,6 +370,10 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>>            * please refer to the Linux kernel VFIO uAPI.
>>            */
>>           if (errno == ENOMSG) {
>> +            if (!migration->precopy_empty_hit) {
>> +                trace_vfio_precopy_empty_hit(migration->vbasedev->name);
> 
> 
> There is a kind of implicit rule that is to keep the name of the
> routine in the trace event. This is true for this file at least.
> In this regard, could you please rename the event to :
> 
>      vfio_save_block_precopy_empty_hit

Okay, will change to the above name.

> or
>      vfio_save_block_precopy_empty
> 
> as you wish.
> 
>> +                migration->precopy_empty_hit = true;
>> +            }
>>               return 0;
>>           }
>> @@ -379,6 +383,9 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>>           return 0;
>>       }
>> +    /* Non-empty read -> re-arm the trace event */
>> +    migration->precopy_empty_hit = false;
>> +
>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>>       qemu_put_be64(f, data_size);
>>       qemu_put_buffer(f, migration->data_buffer, data_size);
>> @@ -472,6 +479,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>           return -ENOMEM;
>>       }
>> +    migration->save_iterate_started = false;
>> +    migration->precopy_empty_hit = false;
>> +
>>       if (vfio_precopy_supported(vbasedev)) {
>>           switch (migration->device_state) {
>>           case VFIO_DEVICE_STATE_RUNNING:
>> @@ -602,6 +612,11 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>       VFIOMigration *migration = vbasedev->migration;
>>       ssize_t data_size;
>> +    if (!migration->save_iterate_started) {
>> +        trace_vfio_save_iterate_started(vbasedev->name);
>> +        migration->save_iterate_started = true;
>> +    }
>> +
>>       data_size = vfio_save_block(f, migration);
>>       if (data_size < 0) {
>>           return data_size;
>> @@ -630,6 +645,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>       int ret;
>>       Error *local_err = NULL;
>> +    trace_vfio_save_complete_precopy_started(vbasedev->name);
>> +
>>       /* We reach here with device state STOP or STOP_COPY only */
>>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>>                                      VFIO_DEVICE_STATE_STOP, &local_err);
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 29789e8d276d..d5277cb7697a 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -156,11 +156,14 @@ vfio_migration_realize(const char *name) " (%s)"
>>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
>>   vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
>> +vfio_precopy_empty_hit(const char *name) " (%s)"
>>   vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>>   vfio_save_cleanup(const char *name) " (%s)"
>>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>> +vfio_save_complete_precopy_started(const char *name) " (%s)"
>>   vfio_save_device_config_state(const char *name) " (%s)"
>>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>> +vfio_save_iterate_started(const char *name) " (%s)"
>>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
>>   vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>>   vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index fed499b199f0..0410111e9868 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -73,6 +73,9 @@ typedef struct VFIOMigration {
>>       uint64_t precopy_init_size;
>>       uint64_t precopy_dirty_size;
>>       bool initial_data_sent;
>> +
>> +    bool save_iterate_started;
>> +    bool precopy_empty_hit;
> 
> Additionally, I would add an 'event_' prefix to give some indication
> of what these new attributes are.
> 
> Also, how about replacing 'started' with 'start' ? That's fine if you
> prefer start.

Will change it the name suffix to '_start' for consistency with other
trace events.

> Tomorrow is soft-freeze, let's get these changes in for QEMU 9.2.
> 
> Thanks,
> 
> C.

Thanks,
Maciej


