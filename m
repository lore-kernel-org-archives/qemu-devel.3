Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309D0CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeln-0006ZZ-J4; Wed, 20 Aug 2025 05:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uoelh-0006Yj-1x
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:06:05 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uoele-0006tb-11
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:06:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:5cc1:0:640:c8e3:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6961B8077C;
 Wed, 20 Aug 2025 12:05:53 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b25::1:17] (unknown
 [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id q5OXe80FoGk0-fNixkfdO; Wed, 20 Aug 2025 12:05:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755680753;
 bh=1yfk0wDwM22SJMWK70L++MFvErgHjiZg+n6sDxJuFFs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=oIsfAmrrl0PuFBeHnvWDwBD3EE1LapodnaH8Yr7oX/En8V/KxSC59QIRAhrNYam+4
 pBc/h8O2CjESvMxFreCB2y0Xrl/yDRezIhLaTgwpQ8VtMJeKLLK8rlY0JIRBrW8LvH
 n45FupKk5BKl6uzpelLP/ZG+pa24+f9KC1LKUvAs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <76e52959-0ec0-4b0d-9251-7660ef6f220f@yandex-team.ru>
Date: Wed, 20 Aug 2025 12:05:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] TAP initialization refactoring
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
 <CACGkMEvHXy0=vwAGS+2S7jCa5TjLxOso-SYb15TTE5q=VtPA2A@mail.gmail.com>
 <bcc0adcc-4d50-454c-abf9-334e15c712e4@yandex-team.ru>
 <CACGkMEsh2XCHsvMF49xJ0SrxY4bRAvjVWASrxWjqqsBYx5XKZA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEsh2XCHsvMF49xJ0SrxY4bRAvjVWASrxWjqqsBYx5XKZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 20.08.25 05:33, Jason Wang wrote:
> On Tue, Aug 19, 2025 at 4:41 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 19.08.25 05:45, Jason Wang wrote:
>>> On Mon, Aug 18, 2025 at 10:06 PM Vladimir Sementsov-Ogievskiy
>>> <vsementsov@yandex-team.ru> wrote:
>>>>
>>>> Hi all!
>>>>
>>>> As preparation for further development of TAP live local migration
>>>> (passing open fds through unix socket),
>>>
>>> I'm not sure I understand this, but I think it has been supported now,
>>> or anything I miss?
>>>
>>
>> Hmm, may be I missing something, but where?
>>
>> I see no code which put TAP fd into migration channel. Nothing about migration in tap.c at all.
>>
>> So, normally, to make local migration with TAP device, you have to create a new TAP for new QEMU
>> process.
>>
>> I want to add a migration state, which will include needed part of TAPState, including fd,
>> to continue using same TAP device in target process, avoiding also any initialization steps
>> on that fd.
> 
> Ok, I see. But the question is that TAP is not something that is
> visible to guests. Doing that may be a suboptimal as we need to deal
> with the migration compatibility.
> 
> Can we simply teach the management layer to use the same TAP fd
> instead assuming it's a local migration.
> 

Theoretically yes: we can pass same fds to the target. We'll still need some new option, to avoid
some operations with TAP on initialization (as when we initialize it on target, source is still running,
and TAP should work on source), but that's possible.

Still, at least in our case, making an additional migration state looks more straightforward.

1. Management layer doesn't store these fds. And its not simple to store them in our architecture,
as management layer just doesn't live as long as QEMU, it's being restarted more often.

2. So, we'll need to add interfaces to get all these fds from QEMU, and than pass them to the target
QEMU.

So, it's a lot simpler for QEMU to care about these fds. QEMU owns them, why not to pass them through
migration stream?

Also, that's not a precedent of passing fds (which are not visible to the guest) through migration
channel, see docs/devel/migration/CPR.rst.

(Hmm, I missed that Steve recently resent his "[RFC V2 0/8] Live update: tap and vhost", which
transfers TAP fds through CPR state.. I still think, using one migration channel is quite
possible and more convenient. But that's a topic to discuss on corresponding series, and this
one is just a refactoring, which just make the code more readable)

> 
>>
>> --
>> Best regards,
>> Vladimir
>>
> 


-- 
Best regards,
Vladimir

