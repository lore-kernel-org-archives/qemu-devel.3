Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB39CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 10:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwI5U-00089Y-0x; Wed, 10 Sep 2025 06:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwI5Q-00087y-AK
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 06:30:01 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwI5M-0006FL-Kd
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 06:30:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 98F3180C22;
 Wed, 10 Sep 2025 13:29:50 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b48::1:39] (unknown
 [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mTHrb67GquQ0-u2ptn1RE; Wed, 10 Sep 2025 13:29:49 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757500189;
 bh=F+kjpgGQieEOw3eYBBsDn2ST3TcYipEfqtXU5BV89fQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zhMFkMTd6FBuOyuntvT1EGpQSip+RIDGVinqWp5FlDGbrFLWNEAXjux4d4MDUZqoJ
 7Pox7WeYD2X4s8XbK/kyo1r4nbF3kZt9CRpRieWBKvsZQgp1k+aNHZsXt+X2ihj5mu
 KR7d54EkUlmU5S0k0iohWkDbPYjLqQq7b+RqIEWQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0ebd65d0-8938-429a-b145-a99f72f956cf@yandex-team.ru>
Date: Wed, 10 Sep 2025 13:29:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] qapi: add interface for local TAP migration
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-5-vsementsov@yandex-team.ru>
 <87ikhqrfbs.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ikhqrfbs.fsf@pond.sub.org>
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

On 10.09.25 09:28, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> To migrate TAP device (including open fds) locally, user should:
>>
>> 1. enable local-tap migration capability both on source and target
>> 2. use additional local-incoming=true option for tap on target
>>
>> Why capability is not enough? We need an option to modify early
>> initialization of TAP, to avoid opening new fds. The capability
>> may not be set at the moment of netdev initialization.
> 
> Bummer.  No way around that?

Thanks, you made me think about it once again)

Let me first describe the problem:

At initialization time, we want to know, are we going to get the
live backend from migration stream, or we should initialize it
by hand (e.g. calling open(), and other syscalls, and making other
preparations).

If we don't know, we have to postpone the initialization to some
later point, when we have an information.

The most simple thing is to postpone it to start of the vm.

But that's work bad: at this point we can't clearly rollback the migration.

So, we have to postpone to post-load in case of incoming migration, and
to start for normal start of QEMU (not incoming).

Still, there is still a significant disadvantage:

In case of non-fds migration, we move initilization of backing into downtime,
downtime becomes longer.

What to do?

We need a point in time, when downtime is not started, but we can check for
fds-passing global capability.

And this point in time is migration_incoming_state_setup(), actually.



Peter, could we add .incoming_setup() handler to VMStateDescription ?



So, final interface could look like:

1. global fds-passing migration capability, to enable/disable the whole feature

2. per-device fds-passing option, on by default for all supporting devices, to be
able to disable backing migration for some devices. (we discussed it here: https://lore.kernel.org/all/aL8kuXQ2JF1TV3M7@x1.local/ ).
Still, normally these options are always on by default.
And more over, I can postpone their implementation to separate series, to reduce discussion field, and to check that everything may work without additional user input.


And how it works (using the example of TAP)

1. Normal start of vm

- On device initialization we don't open /dev/net/tun, and don't intialize it
- On vm start (in device's set_status), we see that we are still don't have open fd, so open /dev/net/tun, and do all other actions around it

2. Usual migration without fds

on target:
- On device initialization we don't open /dev/net/tun, and don't intialize it
- In .incoming_setup(), we see that we are still don't have open fd, and we see that fds-capability is disabled, so open /dev/net/tun, and do all other actions around it, source is still running!
- Next, incoming migration starts, downtime starts.
- On vm start, we see that TAP is already initialized, nothing to do

3. Local migration with fds

- enable fds capability both on source and target
- In .incoming_setup(), we see that fds-capability is enabled, so nothing to do (we can check, that fd must not be set)
- During load of migration, we get fds
- In .post_load(), we do any remaining initialization actions around incoming fd (not too much, as backend device is already initialized)
- On vm start, we see that TAP is already initialized, nothing to do

> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 2387c21e9c..992a5b1e2b 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -517,6 +517,12 @@
>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>   #     such as a file.  (since 9.0)
>>   #
>> +# @local-tap: Migrate TAPs locally, keeping backend alive. Open file
>> +#     descriptors and TAP-related state are migrated. Only may be
>> +#     used when migration channel is unix socket. For target device
>> +#     also @local-incoming option must be specified (since 10.2)
>> +#     (since 10.2)
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> 
> Missing here: local-tap is also experimental.
> 
>> @@ -536,7 +542,8 @@
>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>              'validate-uuid', 'background-snapshot',
>>              'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit', 'mapped-ram'] }
>> +           'dirty-limit', 'mapped-ram',
>> +           { 'name': 'local-tap', 'features': [ 'unstable' ] } ] }
>>   
>>   ##
>>   # @MigrationCapabilityStatus:
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 78bcc9871e..8f53549d58 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -353,6 +353,15 @@
>>   # @poll-us: maximum number of microseconds that could be spent on busy
>>   #     polling for tap (since 2.7)
>>   #
>> +# @local-incoming: Do load open file descriptor for that TAP
>> +#     on incoming migration. May be used only if QEMU is started
>> +#     for incoming migration. Will work only together with local-tap
>> +#     migration capability enabled (default: false) (Since: 10.2)
> 
> Scratch "Do".
> 
> Re "Maybe be used only": what happens when you use it without incoming
> migration or when local-tap is off?
> 
> Does "local-incoming": false count as invalid use then?
> 
> Two spaces between sentences for consistency, please.
> 
>> +#
>> +# Features:
>> +#
>> +# @unstable: Member @local-incoming is experimental
> 
> Period at the end for consistency, please.
> 
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'struct': 'NetdevTapOptions',
>> @@ -371,7 +380,8 @@
>>       '*vhostfds':   'str',
>>       '*vhostforce': 'bool',
>>       '*queues':     'uint32',
>> -    '*poll-us':    'uint32'} }
>> +    '*poll-us':    'uint32',
>> +    '*local-incoming': { 'type': 'bool', 'features': [ 'unstable' ] } } }
>>   
>>   ##
>>   # @NetdevSocketOptions:
> 


-- 
Best regards,
Vladimir

