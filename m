Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438B0CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1PG-0000ZL-L6; Tue, 09 Sep 2025 12:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uw1PE-0000Yy-25
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:41:20 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uw1P7-0005Tc-ES
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:41:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2B6E48073A;
 Tue, 09 Sep 2025 19:41:04 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2fMn5l6GlKo0-GAjGyBPC; Tue, 09 Sep 2025 19:41:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757436063;
 bh=3MmlvhV/Ayny45W2pFi8f5DjZTEUSIjmY/EPXjskt/k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=D2iHJj2Eg3XdUegoaBU/eLp6b10sSYcRUWQoNskZEntoTBNLpke/1YMQfccQUohnH
 GNJKSCMLZOY+VLrVptLveQ6fJy4+JY3rJo/Gl033m/mgAazoq0cs096EvQVttPVX9b
 u5nYrm30rVTN2+3jnhPp40WznkAnKU5C28A0Uk8Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <86f47819-90a4-409b-bbb4-12fa87e3e04b@yandex-team.ru>
Date: Tue, 9 Sep 2025 19:41:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local> <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
 <aMBGnHXieiXpBCqF@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMBGnHXieiXpBCqF@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 09.09.25 18:24, Peter Xu wrote:
> On Tue, Sep 09, 2025 at 10:36:16AM -0400, Steven Sistare wrote:
>> On 9/5/2025 12:48 PM, Peter Xu wrote:
>>> Add Vladimir and Dan.
>>>
>>> On Thu, Aug 14, 2025 at 10:17:14AM -0700, Steve Sistare wrote:
>>>> This patch series adds the live migration cpr-exec mode.
>>>>
>>>> The new user-visible interfaces are:
>>>>     * cpr-exec (MigMode migration parameter)
>>>>     * cpr-exec-command (migration parameter)
>>>>
>>>> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
>>>> primary difference being that old QEMU directly exec's new QEMU.  The user
>>>> specifies the command to exec new QEMU in the migration parameter
>>>> cpr-exec-command.
>>>>
>>>> Why?
>>>>
>>>> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
>>>> container and its assigned resources.  By contrast, cpr-transfer mode
>>>> requires a new container to be created on the same host as the target of
>>>> the CPR operation.  Resources must be reserved for the new container, while
>>>> the old container still reserves resources until the operation completes.
>>>> Avoiding over commitment requires extra work in the management layer.
>>>
>>> Can we spell out what are these resources?
>>>
>>> CPR definitely relies on completely shared memory.  That's already not a
>>> concern.
>>>
>>> CPR resolves resources that are bound to devices like VFIO by passing over
>>> FDs, these are not over commited either.
>>>
>>> Is it accounting QEMU/KVM process overhead?  That would really be trivial,
>>> IMHO, but maybe something else?
>>
>> Accounting is one issue, and it is not trivial.  Another is arranging exclusive
>> use of a set of CPUs, the same set for the old and new container, concurrently.
>> Another is avoiding namespace conflicts, the kind that make localhost migration
>> difficult.
>>
>>>> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
>>>> is that the container may include agents with their own connections to the
>>>> outside world, and such connections remain intact if the container is reused.
>>>
>>> We discussed about this one.  Personally I still cannot understand why this
>>> is a concern if the agents can be trivially started as a new instance.  But
>>> I admit I may not know the whole picture.  To me, the above point is more
>>> persuasive, but I'll need to understand which part that is over-commited
>>> that can be a problem.
>>
>> Agents can be restarted, but that would sever the connection to the outside
>> world.  With cpr-transfer or any local migration, you would need agents
>> outside of old and new containers that persist.
>>
>> With cpr-exec, connections can be preserved without requiring the end user
>> to reconnect, and can be done trivially, by preserving chardevs.  With that
>> support in qemu, the management layer does nothing extra to preserve them.
>> chardev support is not part of this series but is part of my vision,
>> and makes exec mode even more compelling.
>>
>> Management layers have a lot of code and complexity to manage live migration,
>> resources, and connections.  It requires modification to support cpr-transfer.
>> All that can be bypassed with exec mode.  Less complexity, less maintainance,
>> and  fewer points of failure.  I know this because I implemented exec mode in
>> OCI at Oracle, and we use it in production.
> 
> I wonders how this part works in Vladimir's use case.


For now, we don't have live-update with fd-passing, I'm working on it. But we do
have working live-update with starting second QEMU process.

I hope, that finally support for fd-passing in management layer will only
need three steps:

- use unix-socket as migration channel
- enable new migration capability (and probably some options to enable feature per device)
- opt-out the code [1], which implements logic of switching TAP and disk for new QEMU instance

And I don't think we want to remove this logic [1] completely, as we may want to do
normal migration without fds at some moment, for example to change the backend. Or
to jump-over some theoretical future problems with fds passing (that's a new experimental
feature, there may be bugs, or even future incompatible changes (until it become stable).

cpr-transfer needs additional steps:

- more complex interface to setup two migration channels
- tricky logic about unavailable QMP for target process at start

Still, that's possible.

> 
>>> After all, cloud hosts should preserve some extra memory anyway to make
>>> sure dynamic resources allocations all the time (e.g., when live migration
>>> starts, KVM pgtables can drastically increase if huge pages are enabled,
>>> for PAGE_SIZE trackings), I assumed the over-commit portion should be less
>>> that those.. and when it's also temporary (src QEMU will release all
>>> resources after live upgrade) then it looks manageable. >>
>>>> How?
>>>>
>>>> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
>>>> and by sending the unique name and value of each descriptor to new QEMU
>>>> via CPR state.
>>>>
>>>> CPR state cannot be sent over the normal migration channel, because devices
>>>> and backends are created prior to reading the channel, so this mode sends
>>>> CPR state over a second migration channel that is not visible to the user.
>>>> New QEMU reads the second channel prior to creating devices or backends.
>>>>
>>>> The exec itself is trivial.  After writing to the migration channels, the
>>>> migration code calls a new main-loop hook to perform the exec.
>>>>
>>>> Example:
>>>>
>>>> In this example, we simply restart the same version of QEMU, but in
>>>> a real scenario one would use a new QEMU binary path in cpr-exec-command.
>>>>
>>>>     # qemu-kvm -monitor stdio
>>>>     -object memory-backend-memfd,id=ram0,size=1G
>>>>     -machine memory-backend=ram0 -machine aux-ram-share=on ...
>>>>
>>>>     QEMU 10.1.50 monitor - type 'help' for more information
>>>>     (qemu) info status
>>>>     VM status: running
>>>>     (qemu) migrate_set_parameter mode cpr-exec
>>>>     (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
>>>>     (qemu) migrate -d file:vm.state
>>>>     (qemu) QEMU 10.1.50 monitor - type 'help' for more information
>>>>     (qemu) info status
>>>>     VM status: running
>>>>
>>>> Steve Sistare (9):
>>>>     migration: multi-mode notifier
>>>>     migration: add cpr_walk_fd
>>>>     oslib: qemu_clear_cloexec
>>>>     vl: helper to request exec
>>>>     migration: cpr-exec-command parameter
>>>>     migration: cpr-exec save and load
>>>>     migration: cpr-exec mode
>>>>     migration: cpr-exec docs
>>>>     vfio: cpr-exec mode
>>>
>>> The other thing is, as Vladimir is working on (looks like) a cleaner way of
>>> passing FDs fully relying on unix sockets, I want to understand better on
>>> the relationships of his work and the exec model.
>>
>> His work is based on my work -- the ability to embed a file descriptor in a
>> migration stream with a VMSTATE_FD declaration -- so it is compatible.
>>
>> The cpr-exec series preserves VMSTATE_FD across exec by remembering the fd
>> integer and embedding that in the data stream.  See the changes in vmstate-types.c
>> in [PATCH V3 7/9] migration: cpr-exec mode.
>>
>> Thus cpr-exec will still preserve tap devices via Vladimir's code.
>>> I still personally think we should always stick with unix sockets, but I'm
>>> open to be convinced on above limitations.  If exec is better than
>>> cpr-transfer in any way, the hope is more people can and should adopt it.
>>
>> Various people and companies have expressed interest in CPR and want to explore
>> cpr-exec.  Vladimir was one, he chose transfer instead, and that is fine, but
>> give people the option.  And Oracle continues to use cpr-exec mode.
> 
> How does cpr-exec guarantees everything will go smoothly with no failure
> after the exec?  Essentially, this is Vladimir's question 1.  Feel free to
> answer there, because there's also question 2 (which we used to cover some
> but maybe not as much).
> 
> The other thing I don't remember if we discussed, on how cpr-exec manages
> device hotplugs. Say, what happens if there are devices hot plugged (via
> QMP) then cpr-exec migration happens?
> 
> Does cpr-exec cmdline needs to convert all QMP hot-plugged devices into
> cmdlines and append them?  How to guarantee src/dst device topology match
> exactly the same with the new cmdline?
> 

Seems, we discussed.

As I understand, it should work the same way like for normal migration:
we add -incoming defer to cpr-exec-command, and after exec we can add
our infrastructure through QMP interface, and than run "migrate-incoming".

Still, that would be done during downtime, unlike cpr-transfer, where source
is still running during target QMP setup.

So exec mode works more like migrating to file, and than restore from it.

Maybe, we may have a mediator program, which gets migration stream and fds
from source QEMU together with fds, than we start new QEMU process in same
container, and it gets the incoming migration stream together with fds
from the mediator?

Probably target QEMU itself may be used as this mediator, but we'll need an
option to buferise somehow the incoming migration state (together with fds),
and only start to apply it when source QEMU is closed.

How much exec mode would differ from such setup?

>>
>> There is no downside to supporting cpr-exec mode.  It is astonishing how much
>> code is shared by the cpr-transfer and cpr-exec modes.  Most of the code in
>> this series is factored into specific cpr-exec files and functions, code that
>> will never run for any other reason.  There are very few conditionals in common
>> code that do something different for exec mode.
>>> We also have no answer yet on how cpr-exec can resolve container world with
>>> seccomp forbidding exec.  I guess that's a no-go.  It's definitely a
>>> downside instead.  Better mention that in the cover letter.
>> The key is limiting the contents of the container, so exec only has a limited
>> and known safe set of things to target.  I'll add that to the cover letter.
> 
> Thanks.
> 


-- 
Best regards,
Vladimir

