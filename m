Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71BFCCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 17:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8MGN-0008Gm-Et; Mon, 13 Oct 2025 13:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8MGL-0008GV-OK; Mon, 13 Oct 2025 13:23:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8MGI-0004Iv-P9; Mon, 13 Oct 2025 13:23:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D86AD15D192;
 Mon, 13 Oct 2025 20:22:31 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9EFB329EE76;
 Mon, 13 Oct 2025 20:22:50 +0300 (MSK)
Message-ID: <d2cf0acc-7ba2-43fd-9d1b-3fcfbb8f7dc7@tls.msk.ru>
Date: Mon, 13 Oct 2025 20:22:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 0/2] Fix cross migration issue with missing
 features: pdcm, arch-capabilities
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 hector.cao@canonical.com, lk@c--e.de, berrange@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250923104136.133875-1-pbonzini@redhat.com>
 <aNVrAkx+ahn7ZRns@intel.com>
 <8a754d6c-1d8c-43d7-b3f8-a4b3e194d30e@tls.msk.ru>
 <aOyouIh//WY+EkKb@intel.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <aOyouIh//WY+EkKb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

On 10/13/25 10:22, Zhao Liu wrote:
> On Fri, Oct 10, 2025 at 08:40:56PM +0300, Michael Tokarev wrote:
..>>> I found the previous 2 fixes were merged into stable 10.0:
>>>
>>> 24778b1c7ee7aca9721ed4757b0e0df0c16390f7
>>> 3d26cb65c27190e57637644ecf6c96b8c3d246a3
>>>
>>> Should stable 10.0 revert these 2 fixes, to ensure migration
>>> compatibility?
> 
> Sorry for late...just return from vacation.

I returned from vacation today too :)

>> Now when I think about it.
>>
>> There were at least 2 point releases of 10.0.x (10.0.4 & 10.0.5)
>> with these 2 patches already.
> 
> EMM, it seems 10.0.x (x < 4) can't migrate to 10.0.y (4 <= y <= 5),
> right? If so, could we treat this behavior as a regression?

It is a regression in 10.0.4 indeed.  But it already lasted for
2 stable releases (10.0.4 & 10.0.5).  So by reverting the above
mentioned two changes in 10.0.6, we'll make yet another regression,
now when migrating from 10.0.[45] to 10.0.6. This is why I thought
it might be an idea to keep just one regression in 10.0.x, so to
say.  Especially since these changes already fixes issues with
existing guests, so by reverting them, we'll bring them back to
10.0.x.

It is an either-or combination.  It is not bad either way, I'm just
thinking what is best currently.

And with my limited understanding of the migration issue in the context
(for which I asked for clarification some 5 or 6 times already), it
feels to me like "pretending" these above 2 mentioned above patches has
always been part of 10.0.x, - declare that migration wont work from
10.0.[1-3] (or [1-5]?) to subsequent versions, and be done with it.

And modify the 2 properties introduced by:

6529f31e0d target/i386: add compatibility property for pdcm feature
e9efa4a771 target/i386: add compatibility property for arch_capabilities

to be part of pc_compat_9_2 machine, not 10.0..

Hopefully it's understandable what I mean.

>> Reverting them in 10.0 will make
>> 10.0 to be non-migratable with itself (10.0.5 can't be migrated
>> to 10.0.6 if we'll release 10.0.6 with these 2 patches reverted).
>>
>> Also, as far as I can see (and I asked about this some 5 times
>> already, with no one answering - is it that difficult?) - we
>> should pick this series (pdcm, arch-capabilities) to 10.1.x stable
>> series too, since we can't migrate from previous versions to 10.1
>> which has the two changes mentioned above.
> 
> I think so. in this series, Paolo added compat options in pc_compat_10_0
> so it should be picked to stable v10.1.

Again, I asked about this some 5 times already, with no single
answer.

>> It looks to me - since the breakage is already done, and both 10.0
>> and 10.1 is broken, we should declare the current situation as a
>> status quo, and do the following:
>>
>> 1. keep the above mentioned 24778b1c7ee7a and 3d26cb65c27190e5 in
>>     10.0.x (instead of reverting them);
>>
>> 2. pick up this 2 patches (fix cross migration issue with missing
>>     pdcm, arch-capabilities) to 10.1.x (it should be done either way,
>>     I think);
> 
> IIUC, if we picked current compat options to stable v10.1, then stable
> v10.1 requires previous v10.0 sets the pdcm & arch-cap bits (i.e., do
> not apply the fixes or revert the previous fix).

Ugh.  Confusion++ :)  As you wrote yourself right above, "Paolo added
compat options in pc_compat_10_0, so it should be picked up to stable
10.1".  This point "2" is exactly this case I'm talking about.  Two
commits:

6529f31e0d target/i386: add compatibility property for pdcm feature
e9efa4a771 target/i386: add compatibility property for arch_capabilities

should be picked up for 10.1.x.

This "2" point is not (yet) about 10.0.x.


> So it seems the reverts are unavoidable on v10.0?
> 
> (Let's see what Paolo and the other maintainers think.)

For 10.0, there are 2 either-or options: either we revert, or we
pretend these has always been in 10.0.x and compensate, like I described
in my previous email in this thread (to which you're replying) and
re-describing now.

>> 3. on top of these 2 "missing features: pdcm, arch-capabilities",
>>     make the crossing line for before-10.0, not for before-10.1 series, -
>>     ie, consider 10.0 *also* has these properties, but 9.2 and before
>>     are not.

> This issue is indeed quite tricky. Sometimes people (including myself)
> assume that backporting fixes to the stable branch can avoid adding a
> compat option. Now it seems the compat option is the better choice, as
> users need to ensure migration rather than downtime before upgrading to
> the stable version :-(.
It's a good (hopefully) lesson for me myself, - I blindly picked up
a change which felt like an innocent (I even mentioned that in a commit
- it's a "cleanup patch") - just so a subsequent change in this area
applies cleanly.  But it wasn't a cleanup, and it wasn't trivial at
all.  So I must be much more careful the next time.  I'm talking about
3d26cb65c2 "Move adjustment of CPUID_EXT_PDCM..".

Speaking of the other change - it fixed a real bug which I hit myself,
and I had no idea it's tricky - actually no one had this idea until
e9efa4a771 "property for arch_capabilities".  So yes, this is a "sh*t
happens" case :)


Ok.

So, back to the situation and the plan (two of them).


1. It looks like we agree we should pick

6529f31e0d target/i386: add compatibility property for pdcm feature
e9efa4a771 target/i386: add compatibility property for arch_capabilities

to 10.1.x, to make migration from older versions to 10.1.x work.


2.  For 10.0.x, we've two options:

  2.a.  Revert
     e9efa4a771 "do not expose ARCH_CAPABILITIES"
     3d26cb65c2 "Move adjustment of CPUID_EXT_PDCM"
   as you initially suggested and already reviewed.

   This will make 10.0.[45] "bad" wrt migration, and will re-create the
   issues these 2 commits fixed, but will make next 10.0.x as good as
   initial 10.0.0 wrt migration.

  2.b.  Instead of reverting these two which are already in 10.0.[45],
   pretend 10.0 always had these 2 commits, and adjust subsequent
   qemu versions just like we did with 2 "add compatibility property"
   changes, but make it to be 9.2-compat property, not 10.0-compat
   property.

   This - as far as I can see - will make 10.0.[0-3] to be "bad" wrt
   migration, but not subsequent 10.0.x ones.  And will keep the bugs
   fixed in 10.0.x too.

But again, I don't understand the migration logic well, so don't know
if it even makes sense.  2.b, if deemed to be good, will be the first
in history (I think) to introduce compat properties for past machine
types.

Please excuse me for so much text :)

Thank you!

/mjt

