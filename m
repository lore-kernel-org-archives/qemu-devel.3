Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29398CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98eB-0000mf-3K; Wed, 15 Oct 2025 17:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v98e8-0000mT-Tv
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:02:56 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v98e4-0007dA-OJ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:02:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id AD3F980885;
 Thu, 16 Oct 2025 00:02:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a94::1:15] (unknown
 [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id j2YGcu2FqqM0-MwJU1PHl; Thu, 16 Oct 2025 00:02:46 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760562166;
 bh=PB6n/T1tnggcONW4Ug4Yu9VD2fuo52LAvBGN8vPwcMk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CuSs5I/fDaI4Vcej6gD9zNHKLW5OMWEckqalvrAFQeSAmqkkXS5mxDu8ne1UCopdX
 6wRSvEGwrcWfuAgPIM/Oq5y8bMRteVgVAi9eBs35ntxGQufR7QCofUW0jvVDJ1DA8p
 4Qi48XaxYfidJ2Ytcc2giAfpO9vAjSyPnnlsJj+A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
Date: Thu, 16 Oct 2025 00:02:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, raphael.s.norwitz@gmail.com
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aO_--QWDJO7iOhR4@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 15.10.25 23:07, Peter Xu wrote:
> On Wed, Oct 15, 2025 at 10:02:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.10.25 21:19, Peter Xu wrote:
>>> On Wed, Oct 15, 2025 at 04:21:32PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> This parameter enables backend-transfer feature: all devices
>>>> which support it will migrate their backends (for example a TAP
>>>> device, by passing open file descriptor to migration channel).
>>>>
>>>> Currently no such devices, so the new parameter is a noop.
>>>>
>>>> Next commit will add support for virtio-net, to migrate its
>>>> TAP backend.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>
>> [..]
>>
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -951,9 +951,16 @@
>>>>    #     is @cpr-exec.  The first list element is the program's filename,
>>>>    #     the remainder its arguments.  (Since 10.2)
>>>>    #
>>>> +# @backend-transfer: Enable backend-transfer feature for devices that
>>>> +#     supports it. In general that means that backend state and its
>>>> +#     file descriptors are passed to the destination in the migraton
>>>> +#     channel (which must be a UNIX socket). Individual devices
>>>> +#     declare the support for backend-transfer by per-device
>>>> +#     backend-transfer option. (Since 10.2)
>>>
>>> Thanks.
>>>
>>> I still prefer the name "fd-passing" or anything more explicit than
>>> "backend-transfer". Maybe the current name is fine for TAP, only because
>>> TAP doesn't have its own VMSD to transfer?
>>>
>>> Consider a device that would be a backend that supports VMSDs already to be
>>> migrated, then if it starts to allow fd-passing, this name will stop being
>>> suitable there, because it used to "transfer backend" already, now it's
>>> just started to "fd-passing".
>>>
>>> Meanwhile, consider another example - what if a device is not a backend at
>>> all (e.g. vfio?), has its own VMSD, then want to do fd-passing?
>>
>> Reasonable.
>>
>> But consider also the discussion with Fabiano in v5, where he argues against fds
>> (reasonable too):
>>
>> https://lore.kernel.org/qemu-devel/87y0qatqoa.fsf@suse.de/
>>
>> (still, they were against my "fds" name for the parameter, which is
>> really too generic, fd-passing is not)
>>
>> and the arguments for backend-transfer (to read similar with cpr-transfer)
>>
>> https://lore.kernel.org/qemu-devel/87ms6qtlgf.fsf@suse.de/
>>
>>
>>>
>>> In general, I think "fd" is really a core concept of this whole thing.
>>
>> I think, we can call "backend" any external object, linked by the fd.
>>
>> Still, backend/frontend terminology is so misleading, when applied to
>> complex systems (for me, at least), that I don't really like "-backend"
>> word here.
>>
>> fd-passing is OK for me, I can resend with it, if arguments by Fabiano
>> not change your mind.
> 
> Ah, I didn't notice the name has been discussed.
> 
> I think it means you can vote for your own preference now because we have
> one vote for each. :) Let's also see whether Fabiano will come up with
> something better than both.
> 
> You mentioned explicitly the file descriptors in the qapi doc, that's what
> I would strongly request for.  The other thing is the unix socket check, it
> looks all good below now with it, thanks.  No strong feelings on the names.
> 

After a bit more thinking, I leaning towards keeping backend-transfer. I think
it's more meaningful for the user:

If we call it "fd-passing", user may ask:

Ok, what is it? Allow QEMU to pass some fds through migration stream, if it
supports fds? Which fds? Why to pass them? Finally, why QEMU can't just check
is it unix socket or not, and pass any fds it wants if it is?

Logical question is, why not just drop the global capability, and check only
is it unix socket or not? (OK, relying only on socket type is wrong anyway,
as it may be some complex tunneling, which includes unix sockets, but still
can't pass fds, but I think now about feature naming)

But we really want an explicit switch for the feature. As qemu-update is
not the only case of local migration. The another case is changing the
backend. So for the user's choice is:

1. Remote migration: we can't reuse backends (files, sockets, host devices), as
we are moving to another host. So, we don't enable "backend-transfer". We don't
transfer the backend, we have to initialize new backend on another host.

2. Local migration to update QEMU, with minimal freeze-time and minimal
extra actions: use "backend-transfer", exactly to keep the backends
(vhost-user-server, TAP device in kernel, in-kernel vfio device state, etc)
as is.

3. Local migration, but we want to reconfigure some backend, or switch
to another backend. We disable "backend-transfer" for one device.

4. Some problem with "backend-transfer", may be some bug. Disable the whole
beackend-transfer feature, and do normal local migration to a new version
with bug fixed.

-

"backend-transfer" better reflects, what management layer should do, or
should not do with backends, depending on migration type.

>>
>>>   One
>>> thing to complement that idea is, IMHO this patch misses one important
>>> change, that migration framework should actually explicitly fail the
>>> migration if this feature is enabled but it's not a unix socket protocol
>>> (aka, fd-passing REQUIRES scm rights).  Would that look more reliable?
>>> Otherwise IIUC it'll throw weird errors when e.g. when we enabled this
>>> feature and trying to migrate via either TCP or to a file..
>>>
>>
>> Right. I rely on checking in qemu_file_get_fd() / qemu_file_set_fd()
>> handlers.
>>
>> But of course, earlier clean failure of qmp-migrate / qmp-incoming-migate
>> commands would be nice, will do.
>>
>> Like this, I think:
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6ed6a10f57..0c73332706 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -255,6 +255,14 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
>>           return false;
>>       }
>>
>> +    if (migrate_backend_transfer() &&
>> +        !(addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>> +          addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX)) {
>> +        error_setg(errp, "Migration requires a UNIX domain socket as transport, "
>> +                   "because backend-transfer is enabled");
>> +        return false;
>> +    }
>> +
>>       return true;
>>   }
>>
>>
>>
>>
>>
>> -- 
>> Best regards,
>> Vladimir
>>
> 


-- 
Best regards,
Vladimir

