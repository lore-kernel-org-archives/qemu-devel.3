Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F76C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjxA0-0007ra-H4; Wed, 15 Jul 2026 06:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjx9x-0007r9-Ri
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:48:13 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjx9v-0003iE-3K
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:48:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 7949D8082C;
 Wed, 15 Jul 2026 13:48:06 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c75::1:c] (unknown [2a02:6bf:8080:c75::1:c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 5mNadh0a3Os0-i2c35wBA; Wed, 15 Jul 2026 13:48:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784112486;
 bh=diMEYeAFp+5QntB96QBW/FrgFsXrewECtymFuRSQDu0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TUNrANGLSm65Wrq4cpM2+9vJ3e2/A0UDu16+xx1MbWrK8+b751PbbjiaTm6QrHt0p
 1OnXpDutj6In7pXVZE+G+eaeHIXXG7O1WsBeXgQhoV9eLUkbORpVcxuEEr+XdvOVNe
 wjN9gXE+Dl/j6dB5XvzFcW2y1+bwEOPTZWk/+AwQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <db23c15d-cfb2-49a8-b748-5195a36a50d9@yandex-team.ru>
Date: Wed, 15 Jul 2026 13:48:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <e8cb2e45-b58b-41f8-a69c-4f3e0f3cdd8d@yandex-team.ru>
 <d22dfbcc-b2ea-43cc-a612-589d5764423b@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <d22dfbcc-b2ea-43cc-a612-589d5764423b@virtuozzo.com>
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

On 15.07.26 13:25, Andrey Drobyshev wrote:
> On 7/14/26 6:03 PM, Vladimir Sementsov-Ogievskiy wrote:
>> On 26.06.26 19:46, Andrey Drobyshev wrote:
>>> v2 -> v3:
>>>
>>> Re-design device ownership hand-off (suggested by Dongli).  Do not rely
>>> on SETUP migration notifiers, as this approach forces us to reorder
>>> generic migration code (see v2 discussion).  Instead:
>>>
>>>     * .pre_save() releases ownership on the source (RESET_OWNER) once VM
>>>       is stopped;
>>>     * .realize() is adjusted to defer device ownership acquisition for an
>>>       incoming CPR;
>>>     * .post_load() actually claims the device (VHOST_SET_OWNER);
>>>     * FAILED migration event callback re-aquires the ownership on the
>>>       source after re_save released it.
>>>
>>> v2:https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com
>>
>> Hi!
>>
> 
> Hello Vladimir!
> 
>> Two notes:
>>
>> 1. Did you consider migrating needed FDs through main migration channel, without
>> use of CPR, like I do in (not yet landed) "[PATCH v19 00/15] virtio-net: live-TAP local migration" [1]
>>
> 
> AFAIU you're doing local same-host migration as a way to update QEMU
> binary.  With this approach transferring FDs through the main channel is
> indeed cleaner.  However in our own downstream we use enhanced in-place
> memory preservation which is based entirely on cpr-exec migration mode.
> 
> So, to answer your question: yes, we considered it, and it might work
> for cpr-transfer where we're also doing same-host migration.  But in
> cpr-exec case there's only one QEMU process involved => we can't use
> UNIX socket for migration transport => no SCM_RIGHTS FDs passing => FDs
> should be passed via additional transport, no way around it.


Hmm. Looking at code for fd-passing through migration channel:

static bool load_fd(QEMUFile *f, void *pv, size_t size,
                     const VMStateField *field, Error **errp)
{
     int32_t *v = pv;

     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
         qemu_get_sbe32s(f, v);
         return true;
     }
...


Seems like passing FDs through main channel (like in my TAP-series) would
work both for local migration (with two processes and UNIX socket) and for
CPR_EXEC mode. So the FD is passed as simple number in case of cpr-exec.

So, if simply pass FDs through migration state, it should work both for
CPR_EXEC and local migration.

(hmm, still, keeping in mind that TAP-series API still not negotiated,
it's simpler to start from pure CPR approach, and add local-migration
support in future)

> 
> 
>> 2. I don't know how much vhost-vsock differs from vhost-net, but for vhost-net I remember
>> that RESET_OWNER + SET_OWNER is effectively equal to simply recreating vhost device on target,
>> because in kernel vhost device is hardly bound to the process itself, and can't be passed to
>> another process. So, we can pass only "empty" FD, not the initialized vhost device.
>> That's why in [1] I only pass tap-fds (and some additional state), but vhost fds are simply
>> reopened on target (or passed by mgmt app).
>> Does vhost-vsock work in a different way? Is there real sense in passing vhost fds here?
>>
>>
>> [1] https://lore.kernel.org/qemu-devel/20260714154246.1242856-1-vsementsov@yandex-team.ru/
>>
> 
> I'm also not extremely keen on vhost-net internals, but as I understand
> with vhost-net we have 2 FDs: TAP FD for the network endpoint and vhost
> FD for the memory tables, vring addresses etc.  The TAP FD is
> process-independent state - and we pass it via migration channel.  The
> vhost FD is entirely per owning process - and we're able to close it on
> source, reopen on target and bind to the passed TAP FD.

Yes, my understanding matches.

> 
> However with vhost-vsock there's only one FD.  It's used both for
> plumbing and the endpoint.  At the very least, vhost device state holds
> guest CID registration in the global vhost_vsock_hash.  If we go the
> "recreate/reopen the device" path - CID is removed from the hash in
> vhost_vsock_dev_release(), and then we're gonna get ECONNRESET for any
> incoming packets => connections are dead.  We can't afford that.
> 

OK, thanks for explanation!


-- 
Best regards,
Vladimir

