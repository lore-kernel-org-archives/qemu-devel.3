Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CECCF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 19:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srNBU-0007Kj-Jq; Thu, 19 Sep 2024 15:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1srNBT-0007HQ-T0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:51:23 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1srNBS-0007Qz-4L
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:51:23 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1srNBK-0000eh-Hz; Thu, 19 Sep 2024 21:51:14 +0200
Message-ID: <324c13cd-f64f-418c-a534-409c9301bc93@maciej.szmigiero.name>
Date: Thu, 19 Sep 2024 21:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer support
 - send side
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de> <ZuCickYhs3nf2ERC@x1n> <87zfoc1zms.fsf@suse.de>
 <ZuOGAb3988ExsrHi@x1n> <87o74r1yfw.fsf@suse.de> <ZuRJ8i4T_vUzrawY@x1n>
 <87ldzv1tpb.fsf@suse.de> <ZuRYouLwikc4OYye@x1n>
 <45f44392-cb56-4341-ab1d-7d7f28554c77@redhat.com> <ZunBeBnqpgAIpt4Z@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <ZunBeBnqpgAIpt4Z@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17.09.2024 19:50, Peter Xu wrote:
> On Tue, Sep 17, 2024 at 07:07:10PM +0200, Cédric Le Goater wrote:
>> [ ... ]
>>
>>>>> I as a patch writer always like to do that when it's essential.  Normally
>>>>> the case is I don't have enough reviewer resources to help me get a better
>>>>> design, or discuss about it.
>>>>
>>>> Right, but we can't keep providing a moving target. See the thread pool
>>>> discussion for an example. It's hard to work that way. The discussion
>>>> here is similar, we introduced the union, now we're moving to the
>>>> struct. And you're right that the changes here are small, so let's not
>>>> get caught in that.
>>>
>>> What's your suggestion on the thread pool?  Should we merge the change
>>> where vfio creates the threads on its own (assuming vfio maintainers are ok
>>> with it)?
>>>
>>> I would say no, that's what I suggested.  I'd start with reusing
>>> ThreadPool, then we found issue when Stefan reported worry on abusing the
>>> API.  All these discussions seem sensible to me so far.  We can't rush on
>>> these until we figure things out step by step.  I don't see a way.
>>>
>>> I saw Cedric suggesting to not even create a thread on recv side.  I am not
>>> sure whether that's easy, but I'd agree with Cedric if possible.  I think
>>> Maciej could have a point where it can block mutlifd threads, aka, IO
>>> threads, which might be unwanted.
>>
>> Sorry, If I am adding noise on this topic. I made this suggestion
>> because I spotted some asymmetry in the proposal.
>>
>> The send and recv implementation in VFIO relies on different
>> interfaces with different level of complexity. The send part is
>> using a set of multifd callbacks called from multifd threads,
>> if I am correct. Whereas the recv part is directly implemented
>> in VFIO with local thread(s?) doing their own state receive cookery.
> 
> Yeh, the send/recv sides are indeed not fully symmetrical in the case of
> multifd - the recv side is more IO-driven, e.g., QEMU reacts based on what
> it receives (which was encoded in the headers of the received packets).
> 
> The src is more of a generic consumer / producer model where threads can
> enqueue tasks / data to different iochannels.

Currently, the best case happens if both sides are I/O bound with respect
to the VFIO devices - reading device state from the source device as
fast as it can produce it and loading device state into the target device
as fast as it can consume it.

These devices aren't normally seriously network bandwidth constrained
here.

>>
>> I was expecting a common interface to minimize assumptions on both
>> ends. It doesn't have to be callback based. It could be a set of
>> services a subsystem could use to transfer state in parallel.
>> <side note>
>>       VFIO migration is driven by numerous callbacks and it is
>>       difficult to understand the context in which these are called.
>>       Adding more callbacks might not be the best approach.
>> </side note>
>>
>> The other comment was on optimisation. If this is an optimisation
>> then I would expect, first, a non-optimized version not using threads
>> (on the recv side).
> 
> As commented in a previous email, I had a feeling that Maciej wanted to
> avoid blocking multifd threads when applying VFIO data chunks to the kernel
> driver, but Maciej please correct me.. I could be wrong.

Yes, we don't want the case that loading device state into one VFIO device
blocks loading such state into another VFIO device and so the second VFIO
device ends up being partially idle during that time.

> To me I think I'm fine even if it blocks multifd threads, as it'll only
> happen when with VFIO (we may want to consider n_multifd_threads to be
> based on num of vfio devices then, so we still always have some idle
> threads taking IOs out of the NIC buffers).

The current design uses exactly one loading thread per VFIO device.

> So I agree with Cedric that if we can provide a functional working version
> first then we can at least go with the simpler approach first.
> 
>>
>> VFIO Migration is a "new" feature which needs some more run-in.
>> That said, it is stable, MLX5 VFs devices have good support, you
>> can rely on me to evaluate the future respins.
>>
>> Thanks,
>>
>> C.
>>
> 

Thanks,
Maciej


