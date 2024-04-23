Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ACFC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 16:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzIn8-00033F-U4; Tue, 23 Apr 2024 12:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rzIn7-000335-6a
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 12:14:45 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rzIn4-00060A-48
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 12:14:44 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rzImm-00017t-Jm; Tue, 23 Apr 2024 18:14:24 +0200
Message-ID: <9fa34f3e-2f65-442b-8872-513565bb335c@maciej.szmigiero.name>
Date: Tue, 23 Apr 2024 18:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_RFC_00/26=5D_Multifd_=F0=9F=94=80_device_s?=
 =?UTF-8?Q?tate_transfer_support_with_VFIO_consumer?=
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <ZiF8aWVfW7kPuOtn@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On 18.04.2024 22:02, Peter Xu wrote:
> On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
>> On 18.04.2024 12:39, Daniel P. Berrangé wrote:
>>> On Thu, Apr 18, 2024 at 11:50:12AM +0200, Maciej S. Szmigiero wrote:
>>>> On 17.04.2024 18:35, Daniel P. Berrangé wrote:
>>>>> On Wed, Apr 17, 2024 at 02:11:37PM +0200, Maciej S. Szmigiero wrote:
>>>>>> On 17.04.2024 10:36, Daniel P. Berrangé wrote:
>>>>>>> On Tue, Apr 16, 2024 at 04:42:39PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>> (..)
>>>>>>> That said, the idea of reserving channels specifically for VFIO doesn't
>>>>>>> make a whole lot of sense to me either.
>>>>>>>
>>>>>>> Once we've done the RAM transfer, and are in the switchover phase
>>>>>>> doing device state transfer, all the multifd channels are idle.
>>>>>>> We should just use all those channels to transfer the device state,
>>>>>>> in parallel.  Reserving channels just guarantees many idle channels
>>>>>>> during RAM transfer, and further idle channels during vmstate
>>>>>>> transfer.
>>>>>>>
>>>>>>> IMHO it is more flexible to just use all available multifd channel
>>>>>>> resources all the time.
>>>>>>
>>>>>> The reason for having dedicated device state channels is that they
>>>>>> provide lower downtime in my tests.
>>>>>>
>>>>>> With either 15 or 11 mixed multifd channels (no dedicated device state
>>>>>> channels) I get a downtime of about 1250 msec.
>>>>>>
>>>>>> Comparing that with 15 total multifd channels / 4 dedicated device
>>>>>> state channels that give downtime of about 1100 ms it means that using
>>>>>> dedicated channels gets about 14% downtime improvement.
>>>>>
>>>>> Hmm, can you clarify. /when/ is the VFIO vmstate transfer taking
>>>>> place ? Is is transferred concurrently with the RAM ? I had thought
>>>>> this series still has the RAM transfer iterations running first,
>>>>> and then the VFIO VMstate at the end, simply making use of multifd
>>>>> channels for parallelism of the end phase. your reply though makes
>>>>> me question my interpretation though.
>>>>>
>>>>> Let me try to illustrate channel flow in various scenarios, time
>>>>> flowing left to right:
>>>>>
>>>>> 1. serialized RAM, then serialized VM state  (ie historical migration)
>>>>>
>>>>>          main: | Init | RAM iter 1 | RAM iter 2 | ... | RAM iter N | VM State |
>>>>>
>>>>>
>>>>> 2. parallel RAM, then serialized VM state (ie today's multifd)
>>>>>
>>>>>          main: | Init |                                            | VM state |
>>>>>      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>
>>>>>
>>>>> 3. parallel RAM, then parallel VM state
>>>>>
>>>>>          main: | Init |                                            | VM state |
>>>>>      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>      multifd4:                                                     | VFIO VM state |
>>>>>      multifd5:                                                     | VFIO VM state |
>>>>>
>>>>>
>>>>> 4. parallel RAM and VFIO VM state, then remaining VM state
>>>>>
>>>>>          main: | Init |                                            | VM state |
>>>>>      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>>>>>      multifd4:        | VFIO VM state                                         |
>>>>>      multifd5:        | VFIO VM state                                         |
>>>>>
>>>>>
>>>>> I thought this series was implementing approx (3), but are you actually
>>>>> implementing (4), or something else entirely ?
>>>>
>>>> You are right that this series operation is approximately implementing
>>>> the schema described as numer 3 in your diagrams.
>>>
>>>> However, there are some additional details worth mentioning:
>>>> * There's some but relatively small amount of VFIO data being
>>>> transferred from the "save_live_iterate" SaveVMHandler while the VM is
>>>> still running.
>>>>
>>>> This is still happening via the main migration channel.
>>>> Parallelizing this transfer in the future might make sense too,
>>>> although obviously this doesn't impact the downtime.
>>>>
>>>> * After the VM is stopped and downtime starts the main (~ 400 MiB)
>>>> VFIO device state gets transferred via multifd channels.
>>>>
>>>> However, these multifd channels (if they are not dedicated to device
>>>> state transfer) aren't idle during that time.
>>>> Rather they seem to be transferring the residual RAM data.
>>>>
>>>> That's most likely what causes the additional observed downtime
>>>> when dedicated device state transfer multifd channels aren't used.
>>>
>>> Ahh yes, I forgot about the residual dirty RAM, that makes sense as
>>> an explanation. Allow me to work through the scenarios though, as I
>>> still think my suggestion to not have separate dedicate channels is
>>> better....
>>>
>>>
>>> Lets say hypothetically we have an existing deployment today that
>>> uses 6 multifd channels for RAM. ie:
>>>           main: | Init |                                            | VM state |
>>>       multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>
>>> That value of 6 was chosen because that corresponds to the amount
>>> of network & CPU utilization the admin wants to allow, for this
>>> VM to migrate. All 6 channels are fully utilized at all times.
>>>
>>>
>>> If we now want to parallelize VFIO VM state, the peak network
>>> and CPU utilization the admin wants to reserve for the VM should
>>> not change. Thus the admin will still wants to configure only 6
>>> channels total.
>>>
>>> With your proposal the admin has to reduce RAM transfer to 4 of the
>>> channels, in order to then reserve 2 channels for VFIO VM state, so we
>>> get a flow like:
>>>
>>>           main: | Init |                                            | VM state |
>>>       multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd5:                                                     | VFIO VM state |
>>>       multifd6:                                                     | VFIO VM state |
>>>
>>> This is bad, as it reduces performance of RAM transfer. VFIO VM
>>> state transfer is better, but that's not a net win overall.
>>>
>>>
>>>
>>> So lets say the admin was happy to increase the number of multifd
>>> channels from 6 to 8.
>>>
>>> This series proposes that they would leave RAM using 6 channels as
>>> before, and now reserve the 2 extra ones for VFIO VM state:
>>>
>>>           main: | Init |                                            | VM state |
>>>       multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
>>>       multifd7:                                                     | VFIO VM state |
>>>       multifd8:                                                     | VFIO VM state |
>>>
>>>
>>> RAM would perform as well as it did historically, and VM state would
>>> improve due to the 2 parallel channels, and not competing with the
>>> residual RAM transfer.
>>>
>>> This is what your latency comparison numbers show as a benefit for
>>> this channel reservation design.
>>>
>>> I believe this comparison is inappropriate / unfair though, as it is
>>> comparing a situation with 6 total channels against a situation with
>>> 8 total channels.
>>>
>>> If the admin was happy to increase the total channels to 8, then they
>>> should allow RAM to use all 8 channels, and then VFIO VM state +
>>> residual RAM to also use the very same set of 8 channels:
>>>
>>>           main: | Init |                                            | VM state |
>>>       multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
>>>       multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
>>>       multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
>>>       multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
>>>       multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
>>>       multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
>>>       multifd7:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
>>>       multifd8:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
>>>
>>> This will speed up initial RAM iters still further & the final switch
>>> over phase even more. If residual RAM is larger than VFIO VM state,
>>> then it will dominate the switchover latency, so having VFIO VM state
>>> compete is not a problem. If VFIO VM state is larger than residual RAM,
>>> then allowing it acces to all 8 channels instead of only 2 channels
>>> will be a clear win.
>>
>> I re-did the measurement with increased the number of multifd channels,
>> first to (total count/dedicated count) 25/0, then to 100/0.
>>
>> The results did not improve:
>> With 25/0 multifd mixed channels config I still get around 1250 msec
>> downtime - the same as with 15/0 or 11/0 mixed configs I measured
>> earlier.
>>
>> But with the (pretty insane) 100/0 mixed channel config the whole setup
>> gets so for into the law of diminishing returns that the results actually
>> get worse: the downtime is now about 1450 msec.
>> I guess that's from all the extra overhead from switching between 100
>> multifd channels.
> 
> 100 threads are probably too much indeed.
> 
> However I agree with Dan's question raised, and I'd like to second that.
> It so far looks better if the multifd channels can be managed just like a
> pool of workers without assignments to specific jobs.  It looks like this
> series is already getting there, it's a pity we lose that genericity only
> because some other side effects on the ram sync semantics.

We don't lose any genericity since by default the transfer is done via
mixed RAM / device state multifd channels from a shared pool.

It's only when x-multifd-channels-device-state is set to value > 0 then
the requested multifd channel counts gets dedicated to device state.

It could be seen as a fine-tuning option for cases where tests show that
it provides some benefits to the particular workload - just like many
other existing migration options are.

14% downtime improvement is too much to waste - I'm not sure that's only
due to avoiding RAM syncs, it's possible that there are other subtle
performance interactions too.

For even more genericity this option could be named like
x-multifd-channels-map and contain an array of channel settings like
"ram,ram,ram,device-state,device-state".
Then a possible future other uses of multifd channels wouldn't even need
a new dedicated option.

>>
>> I think one of the reasons for these results is that mixed (RAM + device
>> state) multifd channels participate in the RAM sync process
>> (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> 
> Firstly, I'm wondering whether we can have better names for these new
> hooks.  Currently (only comment on the async* stuff):
> 
>    - complete_precopy_async
>    - complete_precopy
>    - complete_precopy_async_wait
> 
> But perhaps better:
> 
>    - complete_precopy_begin
>    - complete_precopy
>    - complete_precopy_end
> 
> ?
> 
> As I don't see why the device must do something with async in such hook.
> To me it's more like you're splitting one process into multiple, then
> begin/end sounds more generic.

Ack, I will rename these hooks to begin/end.

> Then, if with that in mind, IIUC we can already split ram_save_complete()
> into >1 phases too. For example, I would be curious whether the performance
> will go back to normal if we offloading multifd_send_sync_main() into the
> complete_precopy_end(), because we really only need one shot of that, and I
> am quite surprised it already greatly affects VFIO dumping its own things.

AFAIK there's already just one multifd_send_sync_main() during downtime -
the one called from save_live_complete_precopy SaveVMHandler.

In order to truly never interfere with device state transfer the sync would
need to be ordered after the device state transfer is complete - that is,
after VFIO complete_precopy_end (complete_precopy_async_wait) handler
returns.

> I would even ask one step further as what Dan was asking: have you thought
> about dumping VFIO states via multifd even during iterations?  Would that
> help even more than this series (which IIUC only helps during the blackout
> phase)?
> 
> It could mean that the "async*" hooks can be done differently, and I'm not
> sure whether they're needed at all, e.g. when threads are created during
> save_setup but cleaned up in save_cleanup.

Responded to this thread in another e-mail message.

> Thanks,
> 

Thanks,
Maciej


