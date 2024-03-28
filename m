Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F79C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnRB-0003cQ-OV; Thu, 28 Mar 2024 06:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rpnR9-0003c8-Tj; Thu, 28 Mar 2024 06:56:47 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rpnR6-0006DQ-62; Thu, 28 Mar 2024 06:56:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:400c:0:640:9907:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9654360DC5;
 Thu, 28 Mar 2024 13:56:37 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6509::1:4] (unknown
 [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id auKPTE26PuQ0-Xg93tGc2; Thu, 28 Mar 2024 13:56:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711623396;
 bh=LjN58xIxvEPkbyJUIir6gPrGs5p+B85iRHzNqn7n9D4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=I/Je24e0fBjjKvIQLc7usOJSMJwCs9Y98K480dFisikGtYiteaFWH5BfsenuA+x/4
 k4F3G+MZBAxxkf+R6dZM8RSZgCwfXvIQ2ta/FIGEyev2o7REDJQNWPwhLAy77+Oek4
 iC+USkFxAUE7SRJJ6IYQqDZHxtGDtKrZxLYMsDwo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <842e4bd6-a7e4-463c-b319-e959e1204943@yandex-team.ru>
Date: Thu, 28 Mar 2024 13:56:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/15] qapi: block-job-change: make copy-mode parameter
 optional
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, michael.roth@amd.com, pbonzini@redhat.com,
 pkrempa@redhat.com, f.ebner@proxmox.com
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
 <20240313150907.623462-5-vsementsov@yandex-team.ru>
 <878r22emjr.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <878r22emjr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 28.03.24 12:24, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> We are going to add more parameters to change. We want to make possible
>> to change only one or any subset of available options. So all the
>> options should be optional.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   block/mirror.c       | 5 +++++
>>   qapi/block-core.json | 2 +-
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index a177502e4f..2d0cd22c06 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1265,6 +1265,11 @@ static void mirror_change(BlockJob *job, JobChangeOptions *opts,
>>   
>>       GLOBAL_STATE_CODE();
>>   
>> +    if (!change_opts->has_copy_mode) {
>> +        /* Nothing to do */
> 
> I doubt the comment is useful.
> 
>> +        return;
>> +    }
>> +
>>       if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
>>           return;
>>       }
> 
>         if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
>             error_setg(errp, "Change to copy mode '%s' is not implemented",
>                        MirrorCopyMode_str(change_opts->copy_mode));
>             return;
>         }
> 
>         current = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
>                                   change_opts->copy_mode);
>         if (current != MIRROR_COPY_MODE_BACKGROUND) {
>             error_setg(errp, "Expected current copy mode '%s', got '%s'",
>                        MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
>                        MirrorCopyMode_str(current));
>         }
> 
> Now I'm curious: what could be changing @copy_mode behind our backs
> here?
> 

For now - nothing. But it may be read from another thread, so it's declared as atomic access.

So, we can check it with qatomic_read() instead, check the value first, and write then with qatomic_set().

But, I think it would be extra optimization (if it is). The operation is not often, and cmpxchg looks like a correct way to conditionally change atomic variable (even being a bit too safe)	.

>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 67dd0ef038..6041e7bd8f 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3071,7 +3071,7 @@
>     ##
>     # @BlockJobChangeOptionsMirror:
>     #
>     # @copy-mode: Switch to this copy mode.  Currently, only the switch
>     #     from 'background' to 'write-blocking' is implemented.
>     #
>>   # Since: 8.2
>>   ##
>>   { 'struct': 'JobChangeOptionsMirror',
>> -  'data': { 'copy-mode' : 'MirrorCopyMode' } }
>> +  'data': { '*copy-mode' : 'MirrorCopyMode' } }
>>   
>>   ##
>>   # @JobChangeOptions:
> 
> A member becoming optional is backward compatible.  Okay.
> 
> We may want to document "(optional since 9.1)".  We haven't done so in
> the past.

Will do, I think it's useful.

> 
> The doc comment needs to spell out how absent members are handled.
> 

Will add.

-- 
Best regards,
Vladimir


