Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8936CC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 21:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaA3-0004Ij-DM; Tue, 04 Mar 2025 16:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaA1-0004IY-Ks
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 16:50:45 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpa9y-0004fW-D1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 16:50:44 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpa9q-00000000LUA-3EEu; Tue, 04 Mar 2025 22:50:34 +0100
Message-ID: <bf254e83-d7fb-481b-929b-189a2436c21c@maciej.szmigiero.name>
Date: Tue, 4 Mar 2025 22:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/36] migration: Add save_live_complete_precopy_thread
 handler
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <910a9d0950b609943e414ec557bebee85a4804a5.1739994627.git.maciej.szmigiero@oracle.com>
 <Z79EyapCxc2HMHPQ@x1.local>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Z79EyapCxc2HMHPQ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 26.02.2025 17:43, Peter Xu wrote:
> On Wed, Feb 19, 2025 at 09:33:59PM +0100, Maciej S. Szmigiero wrote:
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
>>   include/migration/misc.h         | 17 +++++++
>>   include/migration/register.h     | 19 +++++++
>>   include/qemu/typedefs.h          |  3 ++
>>   migration/multifd-device-state.c | 85 ++++++++++++++++++++++++++++++++
>>   migration/savevm.c               | 35 ++++++++++++-
>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 273ebfca6256..8fd36eba1da7 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -119,8 +119,25 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>>                          Error **errp);
>>   
>>   /* migration/multifd-device-state.c */
>> +typedef struct SaveLiveCompletePrecopyThreadData {
>> +    SaveLiveCompletePrecopyThreadHandler hdlr;
>> +    char *idstr;
>> +    uint32_t instance_id;
>> +    void *handler_opaque;
>> +} SaveLiveCompletePrecopyThreadData;
>> +
>>   bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>>                                   char *data, size_t len);
>>   bool multifd_device_state_supported(void);
>>   
>> +void
>> +multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
>> +                                       char *idstr, uint32_t instance_id,
>> +                                       void *opaque);
>> +
>> +bool multifd_device_state_save_thread_should_exit(void);
>> +
>> +void multifd_abort_device_state_save_threads(void);
>> +bool multifd_join_device_state_save_threads(void);
>> +
>>   #endif
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index 58891aa54b76..c041ce32f2fc 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -105,6 +105,25 @@ typedef struct SaveVMHandlers {
>>        */
>>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>>   
>> +    /**
>> +     * @save_live_complete_precopy_thread (invoked in a separate thread)
>> +     *
>> +     * Called at the end of a precopy phase from a separate worker thread
>> +     * in configurations where multifd device state transfer is supported
>> +     * in order to perform asynchronous transmission of the remaining data in
>> +     * parallel with @save_live_complete_precopy handlers.
>> +     * When postcopy is enabled, devices that support postcopy will skip this
>> +     * step.
>> +     *
>> +     * @d: a #SaveLiveCompletePrecopyThreadData containing parameters that the
>> +     * handler may need, including this device section idstr and instance_id,
>> +     * and opaque data pointer passed to register_savevm_live().
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns true to indicate success and false for errors.
>> +     */
>> +    SaveLiveCompletePrecopyThreadHandler save_live_complete_precopy_thread;
>> +
>>       /* This runs both outside and inside the BQL.  */
>>   
>>       /**
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index fd23ff7771b1..42ed4e6be150 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -108,6 +108,7 @@ typedef struct QString QString;
>>   typedef struct RAMBlock RAMBlock;
>>   typedef struct Range Range;
>>   typedef struct ReservedRegion ReservedRegion;
>> +typedef struct SaveLiveCompletePrecopyThreadData SaveLiveCompletePrecopyThreadData;
>>   typedef struct SHPCDevice SHPCDevice;
>>   typedef struct SSIBus SSIBus;
>>   typedef struct TCGCPUOps TCGCPUOps;
>> @@ -133,5 +134,7 @@ typedef struct IRQState *qemu_irq;
>>   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>>   typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
>>                                       Error **errp);
>> +typedef bool (*SaveLiveCompletePrecopyThreadHandler)(SaveLiveCompletePrecopyThreadData *d,
>> +                                                     Error **errp);
>>   
>>   #endif /* QEMU_TYPEDEFS_H */
>> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
>> index 5de3cf27d6e8..63f021fb8dad 100644
>> --- a/migration/multifd-device-state.c
>> +++ b/migration/multifd-device-state.c
>> @@ -8,7 +8,10 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qapi/error.h"
>>   #include "qemu/lockable.h"
>> +#include "block/thread-pool.h"
>> +#include "migration.h"
>>   #include "migration/misc.h"
>>   #include "multifd.h"
>>   #include "options.h"
>> @@ -17,6 +20,9 @@ static struct {
>>       QemuMutex queue_job_mutex;
>>   
>>       MultiFDSendData *send_data;
>> +
>> +    ThreadPool *threads;
>> +    bool threads_abort;
>>   } *multifd_send_device_state;
>>   
>>   void multifd_device_state_send_setup(void)
>> @@ -27,10 +33,14 @@ void multifd_device_state_send_setup(void)
>>       qemu_mutex_init(&multifd_send_device_state->queue_job_mutex);
>>   
>>       multifd_send_device_state->send_data = multifd_send_data_alloc();
>> +
>> +    multifd_send_device_state->threads = thread_pool_new();
>> +    multifd_send_device_state->threads_abort = false;
>>   }
>>   
>>   void multifd_device_state_send_cleanup(void)
>>   {
>> +    g_clear_pointer(&multifd_send_device_state->threads, thread_pool_free);
>>       g_clear_pointer(&multifd_send_device_state->send_data,
>>                       multifd_send_data_free);
>>   
>> @@ -115,3 +125,78 @@ bool multifd_device_state_supported(void)
>>       return migrate_multifd() && !migrate_mapped_ram() &&
>>           migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
>>   }
>> +
>> +static void multifd_device_state_save_thread_data_free(void *opaque)
>> +{
>> +    SaveLiveCompletePrecopyThreadData *data = opaque;
>> +
>> +    g_clear_pointer(&data->idstr, g_free);
>> +    g_free(data);
>> +}
>> +
>> +static int multifd_device_state_save_thread(void *opaque)
>> +{
>> +    SaveLiveCompletePrecopyThreadData *data = opaque;
>> +    g_autoptr(Error) local_err = NULL;
>> +
>> +    if (!data->hdlr(data, &local_err)) {
>> +        MigrationState *s = migrate_get_current();
>> +
>> +        assert(local_err);
>> +
>> +        /*
>> +         * In case of multiple save threads failing which thread error
>> +         * return we end setting is purely arbitrary.
>> +         */
>> +        migrate_set_error(s, local_err);
> 
> Where did you kick off all the threads when one hit error?  I wonder if
> migrate_set_error() should just set quit flag for everything, but for this
> series it might be easier to use multifd_abort_device_state_save_threads().

I've now added call to multifd_abort_device_state_save_threads() if a migration
error is already set to avoid needlessly waiting for the remaining threads to
do all of their work.

> Other than that, looks good to me, thanks.
> 

Thanks,
Maciej


