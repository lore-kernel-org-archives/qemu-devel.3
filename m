Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D701EE6B59
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voSaX-0001nt-NE; Fri, 06 Feb 2026 15:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voSaU-0001nH-R6
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:37:59 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voSaP-0006kb-6y
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:37:56 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 54733C0291;
 Fri, 06 Feb 2026 23:37:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:473::1:1e] (unknown
 [2a02:6bf:8080:473::1:1e])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ibVPjq0A1Os0-4DCXS9R3; Fri, 06 Feb 2026 23:37:46 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770410266;
 bh=kR6pWzY49vVF+bV0uIydLPMRYvhAAbUVWVxeMMUOCBs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NR427emwOYvdMAY7QOIRBsNsu9fK+Dg4zjzCr4INm8A+XFAiLqBX+DoLq/7vIYHoH
 FzO2Eqc9yYU70zX6WUWENaICmtYRkL6cs+/ng3jn3IMT+3jdaqhY3Crze+Ki/zqqzI
 xxOzUM44gq3bYzlQWafOzQ8+O1RoPtHYQtdEYRlc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d2b504e4-9437-4a32-bdbf-22daf173b941@yandex-team.ru>
Date: Fri, 6 Feb 2026 23:37:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] qapi: add backend-transfer migration parameter
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, jasowang@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, berrange@redhat.com, thuth@redhat.com,
 eblake@redhat.com, farosas@suse.de, zhao1.liu@intel.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-4-vsementsov@yandex-team.ru>
 <aYOAAfzZQ3PeKf4q@x1.local> <87ecmzu0qx.fsf@pond.sub.org>
 <f83e7888-8159-4522-a40d-352ed0a81be3@yandex-team.ru>
 <aYTEhSjA6Dnvw1yf@x1.local>
 <988c8747-708b-4ed7-9f4c-8d410a1c45db@yandex-team.ru>
 <aYYSCBQ5zjRN3djX@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aYYSCBQ5zjRN3djX@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 06.02.26 19:08, Peter Xu wrote:
> On Fri, Feb 06, 2026 at 11:56:27AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 05.02.26 19:25, Peter Xu wrote:
>>> On Thu, Feb 05, 2026 at 11:06:03AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 05.02.26 10:07, Markus Armbruster wrote:
>>>>> Peter Xu <peterx@redhat.com> writes:
>>>>>
>>>>>> On Sun, Feb 01, 2026 at 07:19:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>     # @migrate-set-parameters:
>>>>>>> @@ -1004,6 +1005,13 @@
>>>>>>>     #     is @cpr-exec.  The first list element is the program's filename,
>>>>>>>     #     the remainder its arguments.  (Since 10.2)
>>>>>>>     #
>>>>>>> +# @backend-transfer: Enable backend-transfer feature for devices that
>>>>>>> +#     supports it.  In general that means that backend state and its
>>>>>>> +#     file descriptors are passed to the destination in the migraton
>>>>>>> +#     channel (which must be a UNIX socket).  Individual devices
>>>>>>> +#     declare the support for backend-transfer by per-device
>>>>>>> +#     backend-transfer option.  (Since 11.0)
>>>>>>
>>>>>> I still think it'll be nice to either have "local" in the name of parameter
>>>>>> or at least document it with crystal clear terms.
>>>>>>
>>>>>> I used to suggest fd-passing, but maybe you wanted to emphasize there's
>>>>>> more than fds to be migrated at least for tap?
>>>>
>>>> For vhost-user-blk it's the same: not only FDs.
>>>>
>>>>>> Then it can still be
>>>>>> "local-backend-transfer", because nobody stops a device to transfer backend
>>>>>> states in a remote migration either.. so "backend-transfer" seems to also
>>>>>> work for remote migrations, but it is not.
>>>>
>>>> Hmm. I imagine a mechanism, where OS supports passing FDs to another host.
>>>> This needs support for actually migrating the corresponding kernel object
>>>> by OS automatically. But theoretically I think it can be done transparently
>>>> for userspace QEMU process, which will simply pass FDs to the some special
>>>> socket, similar to UNIX domain socket.
>>>>
>>>> So, the key aspect is that we should be able to pass FDs to the migration
>>>> channel, which currently meant that it must be UNIX domain socket, and it
>>>> must be local migration. But in future it may change.
>>>
>>> That's a nice vision, but IMHO we shouldn't take it into account when
>>> defining any QEMU interface, when it's only about pure imaginations..
>>> unless there is solid work in progress, or ideas proposed / known feasible
>>> at least.
>>>
>>>>
>>>> And yes, "backend-transfer" work for remote migration of backend.
>>>> If we ever implement remote backend migration, why not to
>>>> reuse "backend-transfer" for it? Even if there will not be transparent
>>>> support from OS, and we'll implement another mechanics, we may add
>>>> new parameter
>>>>
>>>>
>>>>      backend-transfer-mechanism = "scm-rights" | "something-other"
>>>
>>> Yes, this will look much better.  We likely shouldn't make it "scm-rights",
>>> it should be generic terms that applies to all platforms like "local", even
>>> if the implication / implementation might be different on various
>>> platforms.
>>>
>>> That's also the major confusion I got when I was reading the other
>>> vhost-user-blk series, thought it was a local migration but not.
>>>
>>> I feel like the interface is simply wrong to make it one covering both, or
>>> at least it shouldn't be a boolean as you said because it represents more
>>> than one use case.
>>>
>>> If it's a boolean, it also shouldn't rely on UNIX sockets if it was trying
>>> to describe a remote migration, right?  The vhost-usr-blk way of
>>> backend-migration doesn't require UNIX socket, or does it?
>>
>> It does require UNIX socket too.
> 
> I'm lost once more.. :( Could you share what requires the UNIX socket for
> the other work here?
> 
> https://lore.kernel.org/all/20260115081103.655749-1-dtalexundeer@yandex-team.ru/#r

Ah sorry, I thought we are talking about my series
"[PATCH v2 00/25] vhost-user-blk: live-backend local migration"

Of course, Alexander's series doesn't need UNIX socket.

> 
> There's indeed the inflight->fd, but it's not migrated but allocated before
> taking the inflight buffer.  I don't see how it requires UNIX socket.

It doesn't. But it doesn't transfer "the whole backend", only the inflight
region.

> 
>>
>>>
>>> Especially, if we still want to have your new proposal try to work for CPR
>>> too or even replace it some day (or a continuous set of proposals in the
>>> future, from different developers based on this feature), we need to have a
>>> solid and clear way represents what CPR does, which is to do local fd
>>> sharing.  "backend-transfer: local" or something similar can be that.
>>>
>>>>
>>>> (or we can put this into "backend-transfer", supporting passing string to
>>>> it and deprecating boolean)
>>>
>>> It can be a enum, something like NONE, LOCAL, REMOTE.  But before that..
>>>
>>>>
>>>> More over, this future "remote-backend-transfer" could be used for local
>>>> migration, so again, it should be called simply "backend-transfer"..
>>>
>>> Yes, REMOTE might be slightly misleading.  And considering you seem to want
>>> to allow any of below to work:
>>>
>>>     (1) enable fd migrations only,
>>>     (2) enable remote migrations on backends only,
>>>     (3) enable both of (1)+(2)
>>>
>>> Maybe we should have two different feature bits?  The per-device one can be
>>> kept as backend-transfer, however we need to change the global migration
>>> knob to something describing a local migration.
>>>
>>> In summary, still 1 new parameter for migration, 1 new parameter for
>>> device, but adjust to:
>>>
>>>     - Migration parameter: "local", boolean, when set, the migration must be
>>>       a local migration within host (which requires UNIX sockets on Linux)
>>>
>>>     - Per-device parameter "backend-transfer", boolean, when set, device will
>>>       migrate backends when migration happens.  Otherwise, backends are not
>>>       migrated; dest QEMU needs to re-initialize it.  The backends may or may
>>>       not contain FDs.
>>>
>>>       When the backend device states contain FDs and FD migrations are
>>>       required, it requires "local" set first above, or it should fail the
>>>       migration when user requested backend-transfer=on.
>>>
>>>       When it doesn't contain FD at all (or FD migration is not a must?), it
>>>       should either migrate the backend or not depending on the user's
>>>       selection.
>>>
>>> For tap (your series here), you need to set both ON and required.
>>>
>>> For vhost-usr-blk, that only needs to set per-device knob to ON, the other
>>> one shouldn't matter.
>>>
>>> Then when we want to replace cpr, we request people switch (cpr-transfer
>>> only, keeping cpr-exec / cpr-reboot aside for now) from setting
>>> mode=cpr-transfer to local=on, which hopefully will start work as before.
>>> The per-device parameter doesn't matter in this case.
>>>
>>> Would this be more reasonable?
>>>
>>
>> Hmm. So, with backend-transfer=on on device and local mig parameter set to false, it fails?
>>
>> But this way we'll have to set backend-transfer to on/off before any migration (local or
>> remote) on all devices with help of set-qom. That's not comfortable.
> 
> Personally as long as we can separate the two use cases with the two knobs
> properly, then it will look good to me.  It doesn't need to be strictly a
> failure on such conflictions indeed.
> 
> E.g. we can also define this case (local=off, backend-transfer=on) the
> other way round if failing is not wanted; that is, allow migration to
> happen but skip the part of backend transfer that requires the locality.
> 
> Fundamentally, we should accept two kinds of backend-transfer impl:
> 
>    - When it is supported regardless of local=on/off.  I believe that's
>      vhost-usr-blk's case (but I'll now need to double check with you again
>      above on UNIX dependency).  Then this only relies on the per-dev knob.
> 
>    - When it is supported only if local=on (this series).  This part is
>      where we can define the behavior of whether we fail the migration on
>      local=off, or we skip the feature instead.
> 
> So I think we can choose to skip it for the latter.  It should almost be
> the same logic as what you have done in this patchset, afaict, besides the
> rename and re-definition of the migration knob.
> 
>>
>> The original idea was that backend-transfer is done for the device when both migration
>> parameter and device option are set to true. This way before the migration (local or
>> remote) we only have to set appropriate migration parameters. And backend-transfer
>> per-device options can be setup once (and the same way) when starting the QEMU, or
>> they may be inherited from Machine Type. And with such logic, it's good to have
>> similar names for migration parameter and device option.
> 
> I hope above will solve this problem.  IIUC what you described should work
> if we tweat the new proposal on the local=off & backend-transfer=on case.
> 
>>
>> Considering all this, could we keep the logic as is (in this patch), but rename
>> backend-transfer parameter to local-backend-transfer, as you proposed before?
>> Or turn it into "backend-transfer" = "local" | "off" (but IMHO it's too optimistic:
>> who knows, will we really add something into this enum in the future? I don't have
>> such plans)
> 
> IMHO "local" would be nicer because it's very simple, generic and clear on
> is own.  It almost says "requires UNIX sockets" on Linux and it also opens
> the door for this parameter to be reused when without a backend: for
> example, when some frontend or any-not-trivially-a-backend also want to
> migrate an FD in the future.  I'm not surprised to see it coming.
> 
> But let's finish above disucssion and see if we can reach the same page.
> 

So finally, rename to "local", and keep the logic as is, right? OK for me, will do.

-- 
Best regards,
Vladimir

