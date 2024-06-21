Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD70C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiFI-0003W3-4m; Fri, 21 Jun 2024 13:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sKiFD-0003VI-Ux
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:40:16 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sKiFB-0000k8-Nr
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:40:15 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sKiF4-00044s-O9; Fri, 21 Jun 2024 19:40:06 +0200
Message-ID: <2d245ec8-0b0d-4596-a3a7-8bbbfd9c3d41@maciej.szmigiero.name>
Date: Fri, 21 Jun 2024 19:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] migration/multifd: Introduce storage slots
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20240620212111.29319-1-farosas@suse.de>
 <f6f84518-530e-4332-8881-41a6219b8d4d@maciej.szmigiero.name>
 <87v822ibh8.fsf@suse.de>
 <dfe0384e-a765-4bfb-81c8-529329d76052@maciej.szmigiero.name>
 <ZnWinGjeZGRGVOF-@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <ZnWinGjeZGRGVOF-@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 21.06.2024 17:56, Peter Xu wrote:
> On Fri, Jun 21, 2024 at 05:31:54PM +0200, Maciej S. Szmigiero wrote:
>> On 21.06.2024 17:04, Fabiano Rosas wrote:
>>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>>>
>>>> Hi Fabiano,
>>>>
>>>> On 20.06.2024 23:21, Fabiano Rosas wrote:
>>>>> Hi folks,
>>>>>
>>>>> First of all, apologies for the roughness of the series. I'm off for
>>>>> the next couple of weeks and wanted to put something together early
>>>>> for your consideration.
>>>>>
>>>>> This series is a refactoring (based on an earlier, off-list
>>>>> attempt[0]), aimed to remove the usage of the MultiFDPages_t type in
>>>>> the multifd core. If we're going to add support for more data types to
>>>>> multifd, we first need to clean that up.
>>>>>
>>>>> This time around this work was prompted by Maciej's series[1]. I see
>>>>> you're having to add a bunch of is_device_state checks to work around
>>>>> the rigidity of the code.
>>>>>
>>>>> Aside from the VFIO work, there is also the intent (coming back from
>>>>> Juan's ideas) to make multifd the default code path for migration,
>>>>> which will have to include the vmstate migration and anything else we
>>>>> put on the stream via QEMUFile.
>>>>>
>>>>> I have long since been bothered by having 'pages' sprinkled all over
>>>>> the code, so I might be coming at this with a bit of a narrow focus,
>>>>> but I believe in order to support more types of payloads in multifd,
>>>>> we need to first allow the scheduling at multifd_send_pages() to be
>>>>> independent of MultiFDPages_t. So here it is. Let me know what you
>>>>> think.
>>>>
>>>> Thanks for the patch set, I quickly glanced at these patches and they
>>>> definitely make sense to me.
>>>>
>> (..)
>>>>> (as I said, I'll be off for a couple of weeks, so feel free to
>>>>> incorporate any of this code if it's useful. Or to ignore it
>>>>> completely).
>>>>
>>>> I guess you are targeting QEMU 9.2 rather than 9.1 since 9.1 has
>>>> feature freeze in about a month, correct?
>>>>
>>>
>>> For general code improvements like this I'm not thinking about QEMU
>>> releases at all. But this series is not super complex, so I could
>>> imagine we merging it in time for 9.1 if we reach an agreement.
>>>
>>> Are you thinking your series might miss the target? Or have concerns
>>> over the stability of the refactoring? We can within reason merge code
>>> based on the current framework and improve things on top, we already did
>>> something similar when merging zero-page support. I don't have an issue
>>> with that.
>>
>> The reason that I asked whether you are targeting 9.1 is because my
>> patch set is definitely targeting that release.
>>
>> At the same time my patch set will need to be rebased/refactored on top
>> of this patch set if it is supposed to be merged for 9.1 too.
>>
>> If this patch set gets merged quickly that's not really a problem.
>>
>> On the other hand, if another iteration(s) is/are needed AND you are
>> not available in the coming weeks to work on them then there's a
>> question whether we will make the required deadline.
> 
> I think it's a bit rush to merge the vfio series in this release.  I'm not
> sure it has enough time to be properly reviewed, reposted, retested, etc.
> 
> I've already started looking at it, and so far I think I have doubt not
> only on agreement with Fabiano on the device_state thing which I prefer to
> avoid, but also I'm thinking of any possible way to at least make the
> worker threads generic too: a direct impact could be vDPA in the near
> future if anyone cared, while I don't want modules to create threads
> randomly during migration.
> 
> Meanwhile I'm also thinking whether that "the thread needs to dump all
> data, and during iteration we can't do that" is the good reason to not
> support that during iterations.
> 
> I didn't yet reply because I don't think I think all things through, but
> I'll get there.
> 
> So I'm not saying that the design is problematic, but IMHO it's just not
> mature enough to assume it will land in 9.1, considering it's still a large
> one, and the first non-rfc version just posted two days ago.


The RFC version was posted more than 2 months ago.

It has received some review comments from multiple people,
all of which were addressed in this patch set version.

I have not received any further comments during these 2 months, so I thought
the overall design is considered okay - if anything, there might be minor
code comments/issues but these can easily be improved/fixed in the 5 weeks
remaining to the soft code freeze for 9.1.


If anything, I think that the VM live phase (non-downtime) transfers
functionality should be deferred until 9.2 because:
* It wasn't a part of the RFC so even if implemented today would get much
less testing overall,

* It's orthogonal to the switchover time device state transfer functionality
introduced by this patch set and could be added on top of that without
changing the wire protocol for switchover time device state transfers,

* It doesn't impact the switchover downtime so in this case 9.1 would
already contain all what's necessary to improve it.


Thanks,
Maciej


