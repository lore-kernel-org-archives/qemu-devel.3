Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0ACCCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 08:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wjG-00027G-Hg; Wed, 15 Oct 2025 04:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8wjD-00024R-Km
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 04:19:23 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8wj1-0008Cq-Ac
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 04:19:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 01126807A5;
 Wed, 15 Oct 2025 11:19:03 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a94::1:15] (unknown
 [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1JLCc13FQ4Y0-3rIS3Kyk; Wed, 15 Oct 2025 11:19:02 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760516342;
 bh=hIEo4UKbbkRokvPuAA75HLkO7HaFDlo2bz6Uz14d6ag=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zwUTZ6R3LA0mdmx0+ZZEK07q4bU7/LcpYBd57BAFVAQ0lnpaIYSIYIRH9+khJXdpX
 DZVCTX5QlMvNA/NoFuzNtlKd9Z1CgdWGTl8sog1JqbInxO3HXFRd8CQ9WTd2KxI6Tm
 Ta75gz6I2EbwU9GAjd1BFJrCIS+VxWC3vb4K1PJY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <87f1805d-47c7-416a-b4da-7f2717197e5d@yandex-team.ru>
Date: Wed, 15 Oct 2025 11:19:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org, raphael@enfabrica.net,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-8-vsementsov@yandex-team.ru>
 <87tt00irg0.fsf@pond.sub.org>
 <2df28aa4-d979-4659-a1ca-33d9cba94fb1@yandex-team.ru>
 <87ldlcfvjt.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ldlcfvjt.fsf@pond.sub.org>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15.10.25 10:55, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 15.10.25 09:56, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> For further vhost-user-blk backend-transfer migration realization we
>>>> want to give it (vhost-user-blk) a possibility (and responsibility) to
>>>> decide when do connect.
>>>>
>>>> For incoming migration we'll need to postpone connect at least until
>>>> early stage of migrate-incoming command, when we already know all
>>>> migration parameters and can decide, are we going to do incoming
>>>> backend-transfer (and get chardev fd from incoming stream), or we
>>>> finally need to connect.
>>>>
>>>> With this patch, we only provide new macro, to define chardev property,
>>>> later it will be used in vhost-user-blk instead of DEFINE_PROP_CHR.
>>>
>>> There is no "later" in this series.
>>> The new macro is called DEFINE_PROP_CHR_NO_CONNECT().
>>>
>>>> Then, vhost-user-blk will call qemu_chr_connect() by hand when needed
>>>> (for example through qemu_chr_fe_wait_connected(), which is already
>>>> called in vhost_user_blk_realize_connect()).
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>
>>> Excuse my quick & ignorant questions...
>>>
>>> I understand ChardevClass provides either methods init() and connect(),
>>> or method open().
>>>
>>> Is a ChardevClass providing open() usable with
>>> DEFINE_PROP_CHR_NO_CONNECT()?
>>
>> Good question. It's usable, but it will work like simple DEFINE_PROP_CHR.
>> I should improve it somehow. Better is to fail than go unexpected way.
>>
>>> Is a ChardevClass providing init() and connect() usable with
>>> DEFINE_PROP_CHR()?
>>
>> Yes, and works correctly.
>>
>>> Could the code do the right thing based on presence of open() vs. init()
>>> and connect() instead of DEFINE_PROP_CHR()
>>> vs. DEFINE_PROP_CHR_NO_CONNECT()?
>>>
>>
>> No, because, the frontend should be prepared to work with new _NO_CONNECT (e.g.,
>> call _connect() by hand when needed). There are a lot of frontends, which
>> expect already connected backend, updating them all would be big (and
>> unnecessary) work.
> 
> QMP command
> 
>      {"execute": "qom-list-types", "arguments": {"implements": "chardev"}}
> 
> shows me 23 subtypes of "chardev".  Could miss a few not in this build.
> 
> Converting them all would be work.  It's not a prohibitive amount of
> work, though.  Whether it's worth our while is not for me to judge.
> 

I'm not sure we talk about the same thing.

Converting all chardevs to new API .init + .connect is feasible, and I say
in cover letter:

> If the design gets general approval, I'll try to update other
> chardev backends, to avoid supporting two different initialization
> APIs in future.

But converting all chardev users to DEFINE_PROP_CHR_NO_CONNECT is another
thing:

git grep DEFINE_PROP_CHR | wc -l
71

- it would be a huge work, and no benefits. Having a default of "already
connected chardev" seems reasonable. No reason to teach these 70 frontends
to call _connect() by hand.

-

frontend/backend is always misleading terminology for me, especially when
we have more than two components in the system :/


-- 
Best regards,
Vladimir

