Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B455CD729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4a0-0007qi-PE; Fri, 29 Nov 2024 12:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tH4Zt-0007qO-GH
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:14:51 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tH4Zq-0002CB-93
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:14:48 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tH4Zc-00000002z5K-12Us; Fri, 29 Nov 2024 18:14:32 +0100
Message-ID: <7f47724d-f42a-4dc4-9f4c-2fad8e55e115@maciej.szmigiero.name>
Date: Fri, 29 Nov 2024 18:14:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/24] migration: Add save_live_complete_precopy_thread
 handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <87f31f02484d33e9a3bf1df08b0c8a9fa5fa9fe0.1731773021.git.maciej.szmigiero@oracle.com>
 <bac4bc49-4db2-4188-b449-1f324ab32074@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <bac4bc49-4db2-4188-b449-1f324ab32074@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 29.11.2024 15:03, Cédric Le Goater wrote:
> On 11/17/24 20:20, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This SaveVMHandler helps device provide its own asynchronous transmission
>> of the remaining data at the end of a precopy phase via multifd channels,
>> in parallel with the transfer done by save_live_complete_precopy handlers.
>>
>> These threads are launched only when multifd device state transfer is
>> supported.
>>
>> Management of these threads in done in the multifd migration code,
>> wrapping them in the generic thread pool.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   include/migration/misc.h         |  8 +++
>>   include/migration/register.h     | 23 +++++++++
>>   include/qemu/typedefs.h          |  4 ++
>>   migration/multifd-device-state.c | 85 ++++++++++++++++++++++++++++++++
>>   migration/savevm.c               | 33 ++++++++++++-
>>   5 files changed, 152 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 43558d9198f7..67014122dcff 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -114,4 +114,12 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>>                                   char *data, size_t len);
>>   bool migration_has_device_state_support(void);
>> +void
>> +multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
>> +                                       char *idstr, uint32_t instance_id,
>> +                                       void *opaque);
>> +
>> +void multifd_abort_device_state_save_threads(void);
>> +int multifd_join_device_state_save_threads(void);
>> +
>>   #endif
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index 761e4e4d8bcb..ab702e0a930b 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -105,6 +105,29 @@ typedef struct SaveVMHandlers {
>>        */
>>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>> +    /* This runs in a separate thread. */
>> +
>> +    /**
>> +     * @save_live_complete_precopy_thread
>> +     *
>> +     * Called at the end of a precopy phase from a separate worker thread
>> +     * in configurations where multifd device state transfer is supported
>> +     * in order to perform asynchronous transmission of the remaining data in
>> +     * parallel with @save_live_complete_precopy handlers.
>> +     * When postcopy is enabled, devices that support postcopy will skip this
>> +     * step.
>> +     *
>> +     * @idstr: this device section idstr
>> +     * @instance_id: this device section instance_id
>> +     * @abort_flag: flag indicating that the migration core wants to abort
>> +     * the transmission and so the handler should exit ASAP. To be read by
>> +     * qatomic_read() or similar.
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>> +    SaveLiveCompletePrecopyThreadHandler save_live_complete_precopy_thread;
>> +
>>       /* This runs both outside and inside the BQL.  */
>>       /**
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index 8c8ea5c2840d..926baaad211f 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -132,5 +132,9 @@ typedef struct IRQState *qemu_irq;
>>    */
>>   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>>   typedef int (*MigrationLoadThread)(bool *abort_flag, void *opaque);
>> +typedef int (*SaveLiveCompletePrecopyThreadHandler)(char *idstr,
>> +                                                    uint32_t instance_id,
>> +                                                    bool *abort_flag,
>> +                                                    void *opaque);
>>   #endif /* QEMU_TYPEDEFS_H */
>> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
>> index bcbea926b6be..74a4aef346c8 100644
>> --- a/migration/multifd-device-state.c
>> +++ b/migration/multifd-device-state.c
>> @@ -9,12 +9,17 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/lockable.h"
>> +#include "block/thread-pool.h"
>>   #include "migration/misc.h"
>>   #include "multifd.h"
>>   #include "options.h"
>>   static QemuMutex queue_job_mutex;
>> +static ThreadPool *send_threads;
>> +static int send_threads_ret;
>> +static bool send_threads_abort;
>> +
>>   static MultiFDSendData *device_state_send;
>>   void multifd_device_state_send_setup(void)
>> @@ -22,6 +27,10 @@ void multifd_device_state_send_setup(void)
>>       qemu_mutex_init(&queue_job_mutex);
>>       device_state_send = multifd_send_data_alloc();
>> +
>> +    send_threads = thread_pool_new();
>> +    send_threads_ret = 0;
>> +    send_threads_abort = false;
>>   }
>>   void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
>> @@ -32,6 +41,7 @@ void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
>>   void multifd_device_state_send_cleanup(void)
>>   {
>> +    g_clear_pointer(&send_threads, thread_pool_free);
>>       g_clear_pointer(&device_state_send, multifd_send_data_free);
>>       qemu_mutex_destroy(&queue_job_mutex);
>> @@ -106,3 +116,78 @@ bool migration_has_device_state_support(void)
>>       return migrate_multifd() && !migrate_mapped_ram() &&
>>           migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
>>   }
>> +
>> +struct MultiFDDSSaveThreadData {
>> +    SaveLiveCompletePrecopyThreadHandler hdlr;
>> +    char *idstr;
>> +    uint32_t instance_id;
>> +    void *handler_opaque;
>> +};
>> +
>> +static void multifd_device_state_save_thread_data_free(void *opaque)
>> +{
>> +    struct MultiFDDSSaveThreadData *data = opaque;
>> +
>> +    g_clear_pointer(&data->idstr, g_free);
>> +    g_free(data);
>> +}
>> +
>> +static int multifd_device_state_save_thread(void *opaque)
>> +{
>> +    struct MultiFDDSSaveThreadData *data = opaque;
>> +    int ret;
>> +
>> +    ret = data->hdlr(data->idstr, data->instance_id, &send_threads_abort,
>> +                     data->handler_opaque);
>> +    if (ret && !qatomic_read(&send_threads_ret)) {
>> +        /*
>> +         * Racy with the above read but that's okay - which thread error
>> +         * return we report is purely arbitrary anyway.
>> +         */
>> +        qatomic_set(&send_threads_ret, ret);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +void
>> +multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
>> +                                       char *idstr, uint32_t instance_id,
>> +                                       void *opaque)
>> +{
>> +    struct MultiFDDSSaveThreadData *data;
>> +
>> +    assert(migration_has_device_state_support());
>> +
>> +    data = g_new(struct MultiFDDSSaveThreadData, 1);
>> +    data->hdlr = hdlr;
>> +    data->idstr = g_strdup(idstr);
>> +    data->instance_id = instance_id;
>> +    data->handler_opaque = opaque;
>> +
>> +    thread_pool_submit(send_threads,
>> +                       multifd_device_state_save_thread,
>> +                       data, multifd_device_state_save_thread_data_free);
>> +
>> +    /*
>> +     * Make sure that this new thread is actually spawned immediately so it
>> +     * can start its work right now.
>> +     */
>> +    thread_pool_adjust_max_threads_to_work(send_threads);
>> +}
>> +
>> +void multifd_abort_device_state_save_threads(void)
>> +{
>> +    assert(migration_has_device_state_support());
>> +
>> +    qatomic_set(&send_threads_abort, true);
>> +}
>> +
>> +int multifd_join_device_state_save_threads(void)
>> +{
>> +    assert(migration_has_device_state_support());
>> +
>> +    thread_pool_wait(send_threads);
>> +
>> +    return send_threads_ret;
>> +}
> 
> There is a lot in common with the load_thread part in patch 8. I think
> more code could be shared.

I will have a second look whether some code can be indeed shared with
load threads here when I will be preparing the next version of this
patch set.

> C.

Thanks,
Maciej


