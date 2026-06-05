Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE803CD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVP65-0007ak-1v; Fri, 05 Jun 2026 03:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wVP63-0007aK-RK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 03:36:03 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wVP61-0003vV-GT
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 03:36:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 81719C01E9;
 Fri, 05 Jun 2026 10:35:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8011:f00:70c8:148f:d983:951f] (unknown
 [2a02:6bf:8011:f00:70c8:148f:d983:951f])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id qZcWhY3ZMKo0-B0iKFnTm; Fri, 05 Jun 2026 10:35:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1780644953;
 bh=jWccB9BwHzEoZRFlB6lpUhf03yNXJOmHWsACODdNypU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BwsryF3lR0694Q3ZVdvwj38e21pfBSbDc1duV6jBtWHKKqfHeOzOOuQ8QHBf3q5Zh
 hVpzjJ1l/sgEMbXYwqvkDiorGIj3lQKLpLtVBSplilHYDX23y4i+W09///jURAv6RQ
 U5JTKGZKf9bJi1ucjbt/VAyeKCmZWu1P8YzTuXpg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fde9e6a3-9aef-4c9b-8458-6b135cd60598@yandex-team.ru>
Date: Fri, 5 Jun 2026 10:35:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com> <87o6hr7brx.fsf@suse.de>
 <aiBrp1UJZjmC1aI1@redhat.com> <aiB2nA5bmtBRWras@x1.local>
 <21a05595-0266-4755-8a99-29a85b9da2db@yandex-team.ru>
 <aiG9Yn5My8LoTraZ@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aiG9Yn5My8LoTraZ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

On 04.06.26 21:01, Peter Xu wrote:
> On Thu, Jun 04, 2026 at 01:00:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 03.06.26 21:46, Peter Xu wrote:
>>>> My general feeling wrt changes to the current command line is that
>>>> any suggestion should be desgined with a nod towards a future scenario
>>>> where QEMU is 100% configured with QMP. ie the full command line is
>>>>
>>>>      qemu-system-x86_64 -qmp <address>
>>>>
>>
>> [..]
>>
>>>
>>> Requirements like this (allow migration parameters to be accessible during
>>> early stage of QEMU) is going towards the other direction of the that idea.
>>> That means even if we put all configs (caps/params) into QMP command
>>> migrate[-incoming], libvirt will still need to manage these global setup
>>> and making sure when invoking migrate[-incoming] QMP commands they match
>>> with the globals.  Say, if one start QEMU with -incomingconfig:local=on
>>> but then invoke "migrate-incoming,local=off" it's illegal.
>>
>> Right.. And this show, that moving "local" from migrate-set-parameters to
>> commandline is not a clear solution for the whole problem.
>>
>> We don't need cmdline argument. We need two things:
>>
>> 1. "local" must be set before initializing tap-device.
>>
>> It not actually requires it being a cmdline parameter. Calling
>> migrate-set-parameters before netdev_add is also OK.
> 
> Ohh is it ok?  I thought it was not OK so we look at this.
> 
> Say, this is what I see on init TAP device when without hotplug:
> 
> qemu_create_late_backends() -> net_init_clients()
> 
> Such happens before migration object initialization.

Yes, it doesn't work for TAP devices added through commandline. But
if devices are added only throuhg QMP (isn't libvirt do so?), it
should work.

> 
>>
>> So, moving to cmdline solves this [1] point, but may be too restrictive.
>>
>>
>> 2. "local" must not be changed after initializing tap-device.
>>
>> And this one is not guaranteed anyway, with cmdline or with QMP.
>>
>> ---
>>
>>
>> So, in my series, if drop "incoming-fds" and rely on "local" instead, we
>> actually want "local" be immutable after first read in tap initialization
>> code.
>>
>> Maybe, just implement this feature? So, in code it will look like:
>>
>> set_migration_parameters(...) {
>>
>> ...
>>
>> if "local" value is changing and "local" is immutable:
>>     fail
> 
> We can't do that, can we?
> 
> Imagine we need to further migrate this VM to another host, where we need
> to turn "local" off after this incoming migration.. we can forbid only
> during incoming phase and re-enable the mutability, but it seems too much.

Agree, right. I missed further outgoing migration.

> 
> My understanding is such protection is fine but not strongly necessary.
> IMHO we rely on a lot of things that admin needs to do right.  I hope this
> isn't a major issue to offload that to admin to say the admin should always
> do the right things.
> 
> We have a bunch of similar issues in QEMU IIUC, e.g. we have known issue
> that some -device needs to be ordered in some way otherwise it'll stop
> working.  We then need admin (or in this case libvirt) do the right thing
> too.

So, possible way is:

1. net devices are only added by QMP commands
2. migration parameter "local" is set before adding devices

So, we can omit "incoming-fds" and rely on "local" && "support-local-migration".

And we can check in .pre_incoming of TAP device, does current value of "local"
equal to what it was at time of TAP initialization, and fail if it differs.

Still, having explicit incoming-fds looks safer, as it's more difficult to do
a mistake.

With incoming-fds=true, user is sure, that new target vm will not try
to connect/open resources, which are still used by running source vm,
regardless of migration configuration correctness.

For example, if user accidentally set "local" _after_ creating TAP device,
we can of-course check it in .pre_incoming and fail, but at the moment we
already break networking in running guest, by attaching to same backend on
target QEMU.

-- 
Best regards,
Vladimir

