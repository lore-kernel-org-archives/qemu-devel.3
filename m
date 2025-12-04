Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2150D2A521
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFQV-0004fG-Tw; Thu, 04 Dec 2025 14:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRFQT-0004f3-S9
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:55:41 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRFQR-0000pG-JP
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:55:41 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4869380900;
 Thu, 04 Dec 2025 22:55:35 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:83c::1:2e] (unknown
 [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Ytrhmc0FxOs0-sr1KdAUq; Thu, 04 Dec 2025 22:55:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764878134;
 bh=rVzKkU8mq+twYDp6MTw6s4XOkYg9I7vF0BBn2bEjeGo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=fc4cHFbPy29pqte8+VABkWNl5c3z8RRkGEFPuKrb8Cd4Y+uDActZ/pFhzKPZrZmQa
 gfbqqngHkQhwrTJeTqYafIV37SlbGI5AvDpSrXg0i6SF9vm+RHHDAiY7KA7VnWH42/
 omjg8/CpXWKDJ5BjabzWbliqJWwK04Oxod4DJXKA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d986f0ac-a0ae-44f6-b7a5-e002b7d3226e@yandex-team.ru>
Date: Thu, 4 Dec 2025 22:55:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] vhost-user-blk: support inflight migration
To: Peter Xu <peterx@redhat.com>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael@enfabrica.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
 <cf0f69b9-4b2b-4c09-a32b-ad86bbe04f6d@yandex-team.ru>
 <aRztnfZFl-OcbVYI@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aRztnfZFl-OcbVYI@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 19.11.25 01:05, Peter Xu wrote:
> On Tue, Nov 18, 2025 at 11:24:12PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Add Daniel
>>
>> On 10.11.25 13:39, Alexandr Moshkov wrote:
>>> v3:
>>> - use pre_load_errp instead of pre_load in vhost.c
>>> - change vhost-user-blk property to
>>>     "skip-get-vring-base-inflight-migration"
>>> - refactor vhost-user-blk.c, by moving vhost_user_blk_inflight_needed() higher
>>>
>>> v2:
>>> - rewrite migration using VMSD instead of qemufile API
>>> - add vhost-user-blk parameter instead of migration capability
>>>
>>> I don't know if VMSD was used cleanly in migration implementation, so
>>> feel free for comments.
>>>
>>> Based on Vladimir's work:
>>> [PATCH v2 00/25] vhost-user-blk: live-backend local migration
>>>     which was based on:
>>>       - [PATCH v4 0/7] chardev: postpone connect
>>>         (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
>>>       - [PATCH v3 00/23] vhost refactoring and fixes
>>>       - [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler
>>>
>>
>> Hi!
>>
>> On my series about backend-transfer migration, the final consensus (or at least,
>> I hope that it's a consensus:) is that using device properties to control migration
>> channel content is wrong. And we should instead use migration parameters.
>>
>> (discussion here: https://lore.kernel.org/qemu-devel/29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru/ )
>>
>> So the API for backend-transfer features is a migration parameter
>>
>>      backend-transfer = [ list of QOM paths of devices, for which we want to enable backend-transfer ]
>>
>> and user don't have to change device properties in runtime to setup the following migration.
>>
>> So I assume, similar practice should be applied here: don't use device
>> properties to control migration.
>>
>> So, should it be a parameter like
>>
>>      migrate-inflight-region = [ list of QOM paths of vhost-user devices ]
>>
>> ?
> 
> I have concern that if we start doing this more, migration qapi/ will be
> completely messed up.
> 
> Imagine a world where there'll be tons of lists like:
> 
>    migrate-dev1-some-feature-1 = [list of devices (almost only dev1 typed)]
>    migrate-dev2-some-feature-2 = [list of devices (almost only dev2 typed)]
>    migrate-dev3-some-feature-3 = [list of devices (almost only dev3 typed)]
>    ...


Yes, hard to argue against it.

I still hope, Daniel will share his opinion..

 From our side, we are OK with any interface, which is accepted)


Let me summarize in short the variants I see:

===

1. lists

Add migrations parameters for such features:

migrate-inflight-region = [ list of QOM paths of vhost-user devices ]
backend-transfer = [ list of QOM paths of devices, which backend should be migrated ]

This way, we just need to set the same sets for source and target QEMU before migration,
and it have no relation to machine types.

PROS: Like any other migration-capability, setup what (and how) should migrate, no
relation to device properties and MT.

CONS: Logically, that's the same as add a device property, but instead we implement
lists of devices, and create extra QOM_PATH-links.

===

2. device parameters

Before migration we should loop through devices and call corresponding
qom-set commands, like

qom-set {path: QOM_PATH, property: "backend-transfer", "value": true}
qom-set {path: QOM_PATH, property: "migrate-inflight-region", "value": true}

And of course, we should care to set same values for corresponding devices on source
and target.

In this case, we also _can_ rely on machine types for defaults.

Note, that "migrate-inflight-region" may become the default in the 11.0 MT.
But backend-transfer can't be a default, as this way we'll break remote migration.

PROS: No lists, native properties

CONS: These properties does not define any portion of device state, internal or
visible to guest. It's not a property of device, but it's and option for migration
of that device.

===

2.1 = [2] assisted by one boolean migration-parameter

Still, if we want make backend-transfer "a kind of" default, we'll need one boolean
migration parameter "it-is-local-migration", and modify logic to

really_do_backend_transfer = it-is-local-migration and device.backend-transfer
really_do_migrate_inflight_region = not it-is-local-migration and device.migrate-inflight-region

PROS: starting from some MT, we'll have good defaults, so that user don't have
to enable/disable the option per device for every migration.

CONS: a precedent of the behavior driven by combination of device property and
corresponding migration parameter (or we have something similar?)

===

4. mixed

Keep [2] for this series, and [1] for backend-transfer.

PROS: list for backend-transfer remains "the only exclusion" instead of "the practice",
so we will not have tons of such lists :)

CONS: inconstant solutions for similar things

===

5. implement "per device" migration parameters

They may be set by additional QMP command qmp-migrate-set-device-parameters, which
will take additional qom-path parameter.

Or, we may add one list of structures like

[{
    qom_path: ...
    parameters: ..
}, ...]

into common migration parameters.

PROS: keep new features as a property of migration, but avoid several lists of QOM paths
CONS: ?

Hmm, we also may select devices not only by qom_path, but by type, for example, to enable
feature for all virtio-net devices. Hmm, and this type may be also used as discriminator
for parameters, which may be a QAPI union type..

===


Thoughts?

> 
> That doesn't look reasonable at all.  If some feature is likely only
> supported in one device, that should not appear in migration.json but only
> in the specific device.
> 
> I don't think I'm fully convinced we can't enable some form of machine type
> properties (with QDEV or not) on backends we should stick with something
> like that.  I can have some closer look this week, but.. even if not, I
> still think migration shouldn't care about some specific behavior of a
> specific device.
> 
> If we really want to have some way to probe device features, maybe we
> should also think about a generic interface (rather than "one new list
> every time").  We also have some recent discussions on a proper interface
> to query TAP backend features like USO*.  Maybe they share some of the
> goals here.
> 
What do you mean by probing device features? Isn't it qom-get command?

-- 
Best regards,
Vladimir

