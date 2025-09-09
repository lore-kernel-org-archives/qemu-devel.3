Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37204CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvsxj-0004Ul-51; Tue, 09 Sep 2025 03:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvsxg-0004Ty-AC
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:40:20 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvsxb-0003mG-2d
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:40:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3FB33804E6;
 Tue, 09 Sep 2025 10:40:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6eDGAP2GweA0-jTjRWAN2; Tue, 09 Sep 2025 10:40:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757403607;
 bh=0L8a9a9pWIBTP3UJ7gkNzNdHLMcu6D/UlETk2otK3ZA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jlgngtqTLI5XOCtzSvRz3Px58F6BgorWADJeL8V2xGBrb2Z8+DSgHB8Ezkg3Dzgty
 pXYPn9cjQxVd8PUHKQAjO436oWttUDL3zkM8dxi1sCzv8EXe+F4LNKpnHKPeJ/IwkC
 k4PM4esWk7F9rAiTU4/egStjFy0guMBVqFIU08B8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <923a500a-74d9-4e00-91da-560049aa6522@yandex-team.ru>
Date: Tue, 9 Sep 2025 10:40:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] qapi: add interface for local TAP migration
To: Peter Xu <peterx@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-5-vsementsov@yandex-team.ru>
 <aL730XiXhM1Vj4Zg@x1.local>
 <2626fb74-a8f4-475b-ab01-3b20c6ff2ae2@yandex-team.ru>
 <aL8kuXQ2JF1TV3M7@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL8kuXQ2JF1TV3M7@x1.local>
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

On 08.09.25 21:47, Peter Xu wrote:
> On Mon, Sep 08, 2025 at 07:38:45PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 08.09.25 18:35, Peter Xu wrote:
>>> On Fri, Sep 05, 2025 at 04:50:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 2387c21e9c..992a5b1e2b 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -517,6 +517,12 @@
>>>>    #     each RAM page.  Requires a migration URI that supports seeking,
>>>>    #     such as a file.  (since 9.0)
>>>>    #
>>>> +# @local-tap: Migrate TAPs locally, keeping backend alive. Open file
>>>> +#     descriptors and TAP-related state are migrated. Only may be
>>>> +#     used when migration channel is unix socket. For target device
>>>> +#     also @local-incoming option must be specified (since 10.2)
>>>> +#     (since 10.2)
>>>
>>> IMHO we should move this into a per-device property, at least we need one
>>> there to still control the device behavior; we had a similar discussion
>>> recently on iterable virtio-net.
>>>
>>> But maybe this one is slightly special?  Maybe the tap device needs to at
>>> least know whether in this specific migration, if we want to pass over FD
>>> or not (e.g. local upgrade, or remote _real_ migration)?
>>>
>>> If that's the case, we may consider providing a generic migration
>>> capability, like cap-fd-passing.  Nowadays since Fabiano's moving migration
>>> capabilities all over to migration parameters, this one can start with a
>>> parameter instead of a capability.  The problem with migration capability
>>> is (at least) that it can't by default ON on any machine types.. meanwhile
>>> it simply looks like identital to parameters except it's always bool.
>>>
>>> The high level rational is that we should never add a per-device cap flag
>>> into migration framework.
>>>
>>
>> Hmm.
>>
>> 1. Yes, we need to distinguish, is that _real_ migration or local. And setting a
>> special property for each device (which supports fd-migration) to turn on passing
>> FD to the channel seems not comfortable and error prune.
>>
>> 2. Initially, I decided separate "local-tap" and "local-vhost-user-blk" capabilities
>> just to simplify further testing/debugging in real environment: the possibility to
>> enable only "half of magic" helps.
>>
>> So, granularity makes sence, but having local-XXX capability for each device class
>> looks bad.
>>
>> Maybe, having generic cap-fd-passing, together with possibility to disable it on
>> per-device basis (like migrate-fd=false) is good compromise.
>>
>>
>> Another question is, do we need "local-incoming" option for target device.
>>
>> Initially I added this because I thought: ho, I need to distinguish it initialization
>> time: do I need to call open(), or wait for incoming fd.
>>
>> Now I see that I can just postpone this decision up to "start" point, where
>>
>> - either I already have fd from incoming migration
>> - or have nothing: in this case, let's call open()
>>
>> -
>>
>> I'll try to go with one "fd-passing" capability, as any kind of granularity may be
>> added later on demand.
>>
>>
>> Hmm2. Probably we can avoid even adding such a capability, but just check, is migration
>> channel support fd passing or not? Seems too implicit for me.
> 
> If we want to expose a feature internally, IIUC we can use QAPI "features"
> like this:
> 
> https://lore.kernel.org/all/20250603013810.4772-17-farosas@suse.de/
> 
> But I'm not yet sure whether it's useful..
> 
> In this case the "capability" itself should almost always be present when
> using unix sockets..  The problem is, IIUC we're not trying to describe a
> capability, but a choice the user made.
> 
> For example, when unix socket is the transport, we can still decide to not
> use fd passing even if it's fully supported in the current QEMU binary for
> any devices that are involved, because any of: (1) it could be a unix
> socket to a proxy daemon (of a container?) when fd passing isn't supported
> in the daemon, or (2) as you mentioned above, for debugging purpose when we
> want to triage whether a bug is relevant to fd-passing.  Maybe more.
> 
> The per-device granularity you mentioned also makes sense to me.
> 
> An use case is when, imagine, we have a QEMU that (1) supports tap local
> migration, but (2) doesn't yet support virtio-blk local migration.  Then we
> want to be able to enable the fd-passing for tap/virtio-net, but not for
> virtio-blk (even if the src QEMU in the context might support both)?
> 
> IOW, it makes sense to me to have two layers of controls here:
> 
>    (a) Migration new parameter, "migrate-fds" (or any better name..).
> 
>        When set, it enables all devices that supports fd-passing to migrate
>        the fds directly.  OTOH, when not set, even if all devices enabled
>        fd-passing, it should still do a full migration.  This one is the
>        user knob saying "I want to migrate with fd migrated".
> 
>        This should imply unix sockets for sure as the transport, and should
>        fail upfront if it's not a unix socket.
> 
>        We should also auto-select this with cpr migrations..  then in any
>        code path (whenever such path exists?) that the fds can be either
>        migrated from cpr or main channels.
> 
>    (b) Device new parameter, "migrate-fds" (or any better name..).
> 
>        When set, the device will declare support migrating fds "whenever the
>        migration applies", aka, when above (a) is selected first.
> 
>        Taking tap device as example here, setting it ON here means "please
>        enable fd-passing whenever the user enables this migration option".
>        So in tap code, it should migrate fd if both (a) and (b) are ON.
>        When migrating to e.g. old QEMUs, here (b) should be OFF even if (a)
>        is ON.
> 
> Would above make sense?
> 

Yes, I meant something like this, sounds good.

-- 
Best regards,
Vladimir

