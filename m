Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6494DD132CF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xdq-0004Ly-Rq; Mon, 04 Nov 2024 09:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t7xdI-0004JJ-Uy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:01:05 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t7xdG-00054D-At
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:00:40 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t7xd2-00000001Lr0-0PZ3; Mon, 04 Nov 2024 15:00:24 +0100
Message-ID: <977126cd-b0ad-4a34-980f-5ed88d858075@maciej.szmigiero.name>
Date: Mon, 4 Nov 2024 15:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vfio/migration: Add
 save_{iterate,complete_precopy}_started trace events
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1730203967.git.maciej.szmigiero@oracle.com>
 <68f51cf0eb3daf448ae80219dded4b10984e32db.1730203967.git.maciej.szmigiero@oracle.com>
 <1eac2eb5-c154-438c-91a3-fb7ac7e3baef@nvidia.com>
 <c78686f9-d8a8-4fc1-bd2b-5268aa1aaf4c@maciej.szmigiero.name>
 <cceed8b5-6d56-4da9-8321-7f361f0f74c9@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <cceed8b5-6d56-4da9-8321-7f361f0f74c9@nvidia.com>
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

On 4.11.2024 09:08, Avihai Horon wrote:
> 
> On 01/11/2024 0:17, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Avihai,
>>
>> On 31.10.2024 15:21, Avihai Horon wrote:
>>> Hi Maciej,
>>>
>>> On 29/10/2024 16:58, Maciej S. Szmigiero wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> This way both the start and end points of migrating a particular VFIO
>>>> device are known.
>>>>
>>>> Add also a vfio_save_iterate_empty_hit trace event so it is known when
>>>> there's no more data to send for that device.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   hw/vfio/migration.c           | 13 +++++++++++++
>>>>   hw/vfio/trace-events          |  3 +++
>>>>   include/hw/vfio/vfio-common.h |  3 +++
>>>>   3 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 992dc3b10257..1b1ddf527d69 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -472,6 +472,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>>           return -ENOMEM;
>>>>       }
>>>>
>>>> +    migration->save_iterate_started = false;
>>>> +    migration->save_iterate_empty_hit = false;
>>>> +
>>>>       if (vfio_precopy_supported(vbasedev)) {
>>>>           switch (migration->device_state) {
>>>>           case VFIO_DEVICE_STATE_RUNNING:
>>>> @@ -602,9 +605,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>>>       VFIOMigration *migration = vbasedev->migration;
>>>>       ssize_t data_size;
>>>>
>>>> +    if (!migration->save_iterate_started) {
>>>> +        trace_vfio_save_iterate_started(vbasedev->name);
>>>> +        migration->save_iterate_started = true;
>>>> +    }
>>>> +
>>>>       data_size = vfio_save_block(f, migration);
>>>>       if (data_size < 0) {
>>>>           return data_size;
>>>> +    } else if (data_size == 0 && !migration->save_iterate_empty_hit) {
>>>> +        trace_vfio_save_iterate_empty_hit(vbasedev->name);
>>>> +        migration->save_iterate_empty_hit = true;
>>>>       }
>>>
>>> Can we instead use trace_vfio_save_iterate to understand if the device reached 0?
>>
>> AFAIK there's not way to filter trace events by their parameters,
>> like only logging vfio_save_iterate trace event if both parameters
>> are zero.
>>
>> It means that vfio_save_iterate has to be enabled unconditionally to
>> serve as a replacement for vfio_save_iterate_empty_hit, which could
>> result in it being logged/emitted many extra times (with non-zero
>> parameters).
>>
>> Because of that I think having a dedicated trace event for such
>> occasion makes sense (it is also easily grep-able).
> 
> Ahh, I understand.
> 
>>
>>> In any case, I think the above could fit better in vfio_save_block(), where ENOMSG indicates that the device has no more data to send during pre-copy phase:
>>>
>>> ...
>>> if (data_size < 0) {
>>>      /*
>>>       * Pre-copy emptied all the device state for now. For more information,
>>>       * please refer to the Linux kernel VFIO uAPI.
>>>       */
>>>      if (errno == ENOMSG) {
>>> trace_vfio_save_iterate_empty_hit(vbasedev->name) <--------------- move it here
>>>          return 0;
>>>      }
>>>
>>>      return -errno;
>>> }
>>> ...
>>>
>>> If you move the trace there, maybe renaming it to trace_vfio_precopy_empty_hit() will be more accurate?
>>
>> This move and rename seems sensible to me.
>>
>>> And trying to avoid adding the extra VFIOMigration->save_iterate_empty_hit flag, can we simply trace it every time?
>>
>> Will have to do some tests to be sure but if there's possibility that
>> we get ENOMSG many times then obviously we don't want to flood logs with
>> this trace event in this case - we want to only log the
>> "data present" -> "data not present" edge/change.
> 
> OK, so I guess a flag is really needed.
> BTW, there is also trace_vfio_state_pending_exact, maybe it could do the job? It might get called multiple times but not as many as vfio_save_iterate.

In a quick test run it was still called/logged 5 times for each VFIO device
so quite more often than the empty_hit one (which was logged just once per dev).

>>
>>>>
>>>>       vfio_update_estimated_pending_data(migration, data_size);
>>>> @@ -630,6 +641,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>>       int ret;
>>>>       Error *local_err = NULL;
>>>>
>>>> + trace_vfio_save_complete_precopy_started(vbasedev->name);
>>>
>>> I assume this trace is used to measure how long it takes for vfio_save_complete_precopy() to run? If so, can we use trace_vmstate_downtime_save to achieve the same goal?
>>
>> With an appropriate filtering I guess it could be used to
>> extract the same data, although explicit VFIO trace point
>> makes it easier to just look at these traces directly
>> (less noise from other devices).
> 
> I see. Well, I don't have a strong opinion if it makes life easier.
> 
> Thanks.
> 
>>
>> But at the same time trace_vfio_save_complete_precopy
>> already exists and by this metric it would also be
>> unnecessary.
>>
>>> Thanks.
>>
>> Thanks,
>> Maciej
>>

Thanks,
Maciej


