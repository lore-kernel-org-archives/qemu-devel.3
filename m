Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A538CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0PT2-0006Rp-I0; Fri, 26 Apr 2024 13:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1s0PT0-0006QT-VW
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:34:34 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1s0PSy-0005hj-L0
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:34:34 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1s0PSg-00049H-T8; Fri, 26 Apr 2024 19:34:14 +0200
Message-ID: <1a0b3c24-fffd-4db3-a35e-e40ae2e0a074@maciej.szmigiero.name>
Date: Fri, 26 Apr 2024 19:34:09 +0200
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
References: <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n> <ZiJCSZvsekaO8dzO@redhat.com> <ZiKOTkgEIKo-wj5N@x1n>
 <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
 <Zig0IPofMCpJdGsn@x1n>
 <e88ecd55-14a2-4043-946b-9c2447fe9def@maciej.szmigiero.name>
 <Zig3vebacR4SfJLh@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Zig3vebacR4SfJLh@x1n>
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

On 24.04.2024 00:35, Peter Xu wrote:
> On Wed, Apr 24, 2024 at 12:25:08AM +0200, Maciej S. Szmigiero wrote:
>> On 24.04.2024 00:20, Peter Xu wrote:
>>> On Tue, Apr 23, 2024 at 06:15:35PM +0200, Maciej S. Szmigiero wrote:
>>>> On 19.04.2024 17:31, Peter Xu wrote:
>>>>> On Fri, Apr 19, 2024 at 11:07:21AM +0100, Daniel P. Berrangé wrote:
>>>>>> On Thu, Apr 18, 2024 at 04:02:49PM -0400, Peter Xu wrote:
>>>>>>> On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>> I think one of the reasons for these results is that mixed (RAM + device
>>>>>>>> state) multifd channels participate in the RAM sync process
>>>>>>>> (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
>>>>>>>
>>>>>>> Firstly, I'm wondering whether we can have better names for these new
>>>>>>> hooks.  Currently (only comment on the async* stuff):
>>>>>>>
>>>>>>>      - complete_precopy_async
>>>>>>>      - complete_precopy
>>>>>>>      - complete_precopy_async_wait
>>>>>>>
>>>>>>> But perhaps better:
>>>>>>>
>>>>>>>      - complete_precopy_begin
>>>>>>>      - complete_precopy
>>>>>>>      - complete_precopy_end
>>>>>>>
>>>>>>> ?
>>>>>>>
>>>>>>> As I don't see why the device must do something with async in such hook.
>>>>>>> To me it's more like you're splitting one process into multiple, then
>>>>>>> begin/end sounds more generic.
>>>>>>>
>>>>>>> Then, if with that in mind, IIUC we can already split ram_save_complete()
>>>>>>> into >1 phases too. For example, I would be curious whether the performance
>>>>>>> will go back to normal if we offloading multifd_send_sync_main() into the
>>>>>>> complete_precopy_end(), because we really only need one shot of that, and I
>>>>>>> am quite surprised it already greatly affects VFIO dumping its own things.
>>>>>>>
>>>>>>> I would even ask one step further as what Dan was asking: have you thought
>>>>>>> about dumping VFIO states via multifd even during iterations?  Would that
>>>>>>> help even more than this series (which IIUC only helps during the blackout
>>>>>>> phase)?
>>>>>>
>>>>>> To dump during RAM iteration, the VFIO device will need to have
>>>>>> dirty tracking and iterate on its state, because the guest CPUs
>>>>>> will still be running potentially changing VFIO state. That seems
>>>>>> impractical in the general case.
>>>>>
>>>>> We already do such interations in vfio_save_iterate()?
>>>>>
>>>>> My understanding is the recent VFIO work is based on the fact that the VFIO
>>>>> device can track device state changes more or less (besides being able to
>>>>> save/load full states).  E.g. I still remember in our QE tests some old
>>>>> devices report much more dirty pages than expected during the iterations
>>>>> when we were looking into such issue that a huge amount of dirty pages
>>>>> reported.  But newer models seem to have fixed that and report much less.
>>>>>
>>>>> That issue was about GPU not NICs, though, and IIUC a major portion of such
>>>>> tracking used to be for GPU vRAMs.  So maybe I was mixing up these, and
>>>>> maybe they work differently.
>>>>
>>>> The device which this series was developed against (Mellanox ConnectX-7)
>>>> is already transferring its live state before the VM gets stopped (via
>>>> save_live_iterate SaveVMHandler).
>>>>
>>>> It's just that in addition to the live state it has more than 400 MiB
>>>> of state that cannot be transferred while the VM is still running.
>>>> And that fact hurts a lot with respect to the migration downtime.
>>>>
>>>> AFAIK it's a very similar story for (some) GPUs.
>>>
>>> So during iteration phase VFIO cannot yet leverage the multifd channels
>>> when with this series, am I right?
>>
>> That's right.
>>
>>> Is it possible to extend that use case too?
>>
>> I guess so, but since this phase (iteration while the VM is still
>> running) doesn't impact downtime it is much less critical.
> 
> But it affects the bandwidth, e.g. even with multifd enabled, the device
> iteration data will still bottleneck at ~15Gbps on a common system setup
> the best case, even if the hosts are 100Gbps direct connected.  Would that
> be a concern in the future too, or it's known problem and it won't be fixed
> anyway?

I think any improvements to the migration performance are good, even if
they don't impact downtime.

It's just that this patch set focuses on the downtime phase as the more
critical thing.

After this gets improved there's no reason why not to look at improving
performance of the VM live phase too if it brings sensible improvements.

> I remember Avihai used to have plan to look into similar issues, I hope
> this is exactly what he is looking for.  Otherwise changing migration
> protocol from time to time is cumbersome; we always need to provide a flag
> to make sure old systems migrates in the old ways, new systems run the new
> ways, and for such a relatively major change I'd want to double check on
> how far away we can support offload VFIO iterations data to multifd.

The device state transfer is indicated by a new flag in the multifd
header (MULTIFD_FLAG_DEVICE_STATE).

If we are to use multifd channels for VM live phase transfers these
could simply re-use the same flag type.

> Thanks,
> 

Thanks,
Maciej


