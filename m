Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5487BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 17:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwOc0-000613-Ao; Wed, 10 Sep 2025 13:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwObr-00060C-2R
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 13:27:55 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwObi-0007st-0N
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 13:27:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E025F80928;
 Wed, 10 Sep 2025 20:27:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b48::1:39] (unknown
 [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id cROOx10Fm4Y0-FqmEVflR; Wed, 10 Sep 2025 20:27:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757525259;
 bh=exHXcWhFG+0/w96bBCuyqdkWnXMZsFD9o1dfKwsWz74=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wvNuYMKrTyhvU121309h7MVHjp5gdW1aBW/ni8BqkZG9qrH16HnQM+XOVsuAEf3zJ
 tjuSQ0vmc95N/n/4gA3HyaB92G2vjLPsPwWN+ROnVycCGfTtPlcmQuxOAHAxLTiHKa
 khkoP9uCJUR7wu8ou42iL9/paPP3/dSOglOQrvaQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8550b188-8ec9-4dbb-95f8-f9bad5db1777@yandex-team.ru>
Date: Wed, 10 Sep 2025 20:27:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 "Chaney, Ben" <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hamza Khan <hamza.khan@nutanix.com>, qemu-devel@nongnu.org
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru>
 <f3cb36ee-e677-4377-9e4d-652085b205aa@oracle.com>
 <3c939b30-2479-4bdd-8fa8-1dcd7adaada5@oracle.com>
 <2e6a35a4-b9b6-444c-90d7-1c748ad1b7d0@yandex-team.ru>
 <ccd353ef-26c7-4590-94ae-d8f6193c2805@oracle.com>
 <c8b799f7-c549-4534-a156-99df204e62ec@yandex-team.ru>
 <aLsM-_Bfj2bYtwSX@x1.local>
 <e93c1318-7530-4d02-95e1-bf60a6142e75@yandex-team.ru>
 <b742f0e7-3ee6-4824-9713-b45ba390df1e@yandex-team.ru>
 <aMGuGDnjsfo8wBU-@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMGuGDnjsfo8wBU-@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 10.09.25 19:58, Peter Xu wrote:
> On Wed, Sep 10, 2025 at 12:35:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> I wished devices could opt-in to provide its own model so that it is
>>>> prepared to boot the QEMU without FDs being there and pause itself at that
>>>> stage if a load would happen.
>>>
>>> So, you suggest to postpone the initialization up to "start" even for "normal start"
>>> of QEMU, to avoid these endless "if (we are in our special local-incoming/CPR mode)".
>>>
>>> Actually, that's how normal migratable devices live: we don't have "if (incoming)" for
>>> every step of initialization/start currently.
>>>
>>> I'll see, could I apply the concept to TAP local migration series.
>>
>>
>> Hmm, not so simple.
>>
>> OK, my current series behave like this:
>>
>> init:  if tap.local_incoming then do nothing else open(/dev/net/tun)
>>
>> incoming migration: get fd, and continue initialization
>>
>>
>> Assume, we want to avoid extra "if"s, and just postpone the initialization to vm start point, like
>>
>> init: do nothing. set fd=-1
>>
>> incmoing migration: get fd (if cap-fd-passing enabled)
>>
>> start: open(), if fd==-1, continue initialization
>>
>>
>> But that mean that we postpone possible errors up to start as well, when we cannot rollback the
>> migration..
> 
> Yep, doesn't sound like a good idea.  We also don't want to slow down VM
> starts.
> 
>>
>>
>> Alternatively, we can postpone open() to post-load.. But what for normal start of vm?
>>
>> init: if INMIGRATE then do nothing, else open()
>>
>> incoming: get fd (if cap-fd-passing)
>>
>> post-load: open(), if fd==-1, continue initialization
>>
>> start: if fd is still -1, open(), continue initialization
>>
>> that avoids extra tap.local_incoming option, but:
>>
>> - seems even more complicated
>> - open() and some initialization is done in downtime, when we don't enable cap-fd-passing
>>
>>
>> So, now I think, that my current approach with additional "local-incoming" per-device option is better.
>>
>> What do you think?
>>
>>
>> Probably I'm trying to optimize wrong "if". As "if local-incomging .." in generic layer is a lot
>> more expensive than checking the options in device code.
>>
>> But the idea is generic: for non-fd migration, we do as much initialization at start as possible,
> 
> AFAIU, the non-fd migrations works simply because the portion that VMSD
> loads will always be over-writeable.  When it's not, a pre_load() or
> post_load() would make it work.
> 
>> to get early errors and to decrease further downtime. For fd migration, we postpone fd-initialization
>> up to post-load stage. So, we have "if"s in device code to handle it, and we have "if"s in generic
>> code to support device, which doesn't still have fully initialized backend (no fds during init).
> 
> What I meant is, IMHO we should try to not use things like
> cpr_is_incoming() too deep into the device stack, and we should use it as
> less frequent as possible.
> 
> In many cases, IIUC it's because the current device emulation code is not
> yet separating the FD installation (and also whatever that can be relevant
> to the FD) from the realize() process.  Hence a quick way to make it work
> is to add cpr_is_incoming() or similar helpers either to skip some process,
> or do something different with an existing FD.
> 
> If we can have device emulation be prepared with such, in an ideal world
> and just to show what I am thinking.. it could be:
> 
>    - realize()
>      - realize_frontend()
>      - if migration is incoming, and backend should be postponed (for fd
>        loading, or maybe something else)?
>        - ... realize_backend() postponed until post_load()...
>      - else
>        - realize_backend()
> 
> If all of the devices would support such split of realize() process
> v.s. FDs / backends, _maybe_ we can remove all cpr_is_incoming() but move
> it upper and upper until qdev code, like:
> 
> device_set_realized():
>          if (migration_incoming_XXX() && dc->realize_prepare) {
>              /*
>               * This is only part of realize(), rest done in a separate VMSD
>               * post_load().
>               */
>              dc->realize_prepare(dev, &local_err);
>              if (local_err != NULL) {
>                  goto fail;
>              }
>          } else if (dc->realize) {
>              dc->realize(dev, &local_err);
>              if (local_err != NULL) {
>                  goto fail;
>              }
>          }
> 
> In general, that "whether is incoming fd migration" concept will be passed
> down from higher the stack, rather than randomly checked very deep in
> stack.  That should IMHO make code more maintenable.
> 
> But that's only my two cents.. so please take that with a grain of salt.  I
> don't really know device code well to say.
> 


Thanks for explanation, I see the idea now. Will see, how much I can apply it to
TAP series. I believe, TAP is good chance to make good design, as it's a lot simpler than
vhost-user-blk or vfio.


-- 
Best regards,
Vladimir

