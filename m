Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EDEC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 19:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgUGn-0000o4-6H; Fri, 07 Feb 2025 14:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tgUGf-0000ll-58
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:44:03 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tgUGc-00055g-PH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:44:00 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tgUGU-000000071GV-3fFB; Fri, 07 Feb 2025 20:43:50 +0100
Message-ID: <835d4000-8494-4217-85f0-907689620207@maciej.szmigiero.name>
Date: Fri, 7 Feb 2025 20:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/33] migration/multifd: Make MultiFDSendData a struct
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <e7a227c97319d036dd1b06d1ea93af77ce92563d.1738171076.git.maciej.szmigiero@oracle.com>
 <877c61n7nr.fsf@suse.de>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <877c61n7nr.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 7.02.2025 15:36, Fabiano Rosas wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> From: Peter Xu <peterx@redhat.com>
>>
>> The newly introduced device state buffer can be used for either storing
>> VFIO's read() raw data, but already also possible to store generic device
>> states.  After noticing that device states may not easily provide a max
>> buffer size (also the fact that RAM MultiFDPages_t after all also want to
>> have flexibility on managing offset[] array), it may not be a good idea to
>> stick with union on MultiFDSendData.. as it won't play well with such
>> flexibility.
>>
>> Switch MultiFDSendData to a struct.
>>
>> It won't consume a lot more space in reality, after all the real buffers
>> were already dynamically allocated, so it's so far only about the two
>> structs (pages, device_state) that will be duplicated, but they're small.
>>
>> With this, we can remove the pretty hard to understand alloc size logic.
>> Because now we can allocate offset[] together with the SendData, and
>> properly free it when the SendData is freed.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> [MSS: Make sure to clear possible device state payload before freeing
>> MultiFDSendData, remove placeholders for other patches not included]
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   migration/multifd-device-state.c |  5 -----
>>   migration/multifd-nocomp.c       | 13 ++++++-------
>>   migration/multifd.c              | 25 +++++++------------------
>>   migration/multifd.h              | 15 +++++++++------
>>   4 files changed, 22 insertions(+), 36 deletions(-)
>>
>> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
>> index 2207bea9bf8a..d1674b432ff2 100644
>> --- a/migration/multifd-device-state.c
>> +++ b/migration/multifd-device-state.c
>> @@ -16,11 +16,6 @@ static QemuMutex queue_job_mutex;
>>   
>>   static MultiFDSendData *device_state_send;
>>   
>> -size_t multifd_device_state_payload_size(void)
>> -{
>> -    return sizeof(MultiFDDeviceState_t);
>> -}
>> -
>>   void multifd_device_state_send_setup(void)
>>   {
>>       qemu_mutex_init(&queue_job_mutex);
>> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
>> index c00804652383..ffe75256c9fb 100644
>> --- a/migration/multifd-nocomp.c
>> +++ b/migration/multifd-nocomp.c
>> @@ -25,15 +25,14 @@
>>   
>>   static MultiFDSendData *multifd_ram_send;
>>   
>> -size_t multifd_ram_payload_size(void)
>> +void multifd_ram_payload_alloc(MultiFDPages_t *pages)
>>   {
>> -    uint32_t n = multifd_ram_page_count();
>> +    pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
>> +}
>>   
>> -    /*
>> -     * We keep an array of page offsets at the end of MultiFDPages_t,
>> -     * add space for it in the allocation.
>> -     */
>> -    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
>> +void multifd_ram_payload_free(MultiFDPages_t *pages)
>> +{
>> +    g_clear_pointer(&pages->offset, g_free);
>>   }
>>   
>>   void multifd_ram_save_setup(void)
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 61b061a33d35..0b61b8192231 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -105,26 +105,12 @@ struct {
>>   
>>   MultiFDSendData *multifd_send_data_alloc(void)
>>   {
>> -    size_t max_payload_size, size_minus_payload;
>> +    MultiFDSendData *new = g_new0(MultiFDSendData, 1);
>>   
>> -    /*
>> -     * MultiFDPages_t has a flexible array at the end, account for it
>> -     * when allocating MultiFDSendData. Use max() in case other types
>> -     * added to the union in the future are larger than
>> -     * (MultiFDPages_t + flex array).
>> -     */
>> -    max_payload_size = MAX(multifd_ram_payload_size(),
>> -                           multifd_device_state_payload_size());
>> -    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
>> -
>> -    /*
>> -     * Account for any holes the compiler might insert. We can't pack
>> -     * the structure because that misaligns the members and triggers
>> -     * Waddress-of-packed-member.
>> -     */
>> -    size_minus_payload = sizeof(MultiFDSendData) - sizeof(MultiFDPayload);
>> +    multifd_ram_payload_alloc(&new->u.ram);
>> +    /* Device state allocates its payload on-demand */
>>   
>> -    return g_malloc0(size_minus_payload + max_payload_size);
>> +    return new;
>>   }
>>   
>>   void multifd_send_data_clear(MultiFDSendData *data)
>> @@ -151,8 +137,11 @@ void multifd_send_data_free(MultiFDSendData *data)
>>           return;
>>       }
>>   
>> +    /* This also free's device state payload */
>>       multifd_send_data_clear(data);
>>   
>> +    multifd_ram_payload_free(&data->u.ram);
>> +
> 
> Shouldn't this be added to the switch statement at
> multifd_send_data_clear() instead?

I think the intention is that RAM pages are allocated at MultiFDSendData
instance allocation time and stay allocated for its entire lifetime -
because we know RAM pages packet data size upfront and also that's what
multifd send threads will be mostly sending.

In contrast with RAM, device state allocates its payload on-demand since
its size is unknown and can vary between each multifd_queue_device_state()
invocation. This payload is free'd after it gets send by a multifd send
thread.

There's even a comment about this in multifd_send_data_alloc():
>     multifd_ram_payload_alloc(&new->u.ram);
>     /* Device state allocates its payload on-demand */

Thanks,
Maciej


