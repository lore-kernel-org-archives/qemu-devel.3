Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BA9FCE08C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvc5k-0007tC-27; Thu, 26 Feb 2026 09:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vvc5J-0007i1-S7; Thu, 26 Feb 2026 09:11:21 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vvc5G-00086S-NC; Thu, 26 Feb 2026 09:11:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1595C80C42;
 Thu, 26 Feb 2026 17:11:14 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:119::1:2a] (unknown
 [2a02:6bf:8080:119::1:2a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id DBjg900AiGk0-suLptHr5; Thu, 26 Feb 2026 17:11:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772115073;
 bh=FWEKj4SphHGRa8+5viiLw4d8Lkq2WPYiV6R9Za6ll1E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=e54DWViGsF2sVmQ/sSO5VDz35cfHQy0wwq4R/Xg2+zzFBfpxAX+B15HZnif3OBDrm
 QiMXVk5ACVNTGvR1PZPQKOyVz31s6TzciJg0m0JATe9/vJYOgjD81O26qh/YpP0l0P
 E74XdwK4ArFBCTUY4DTdsGxwWunrsDNPvgzB54eY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2f1a92ff-fc51-4f8c-b50f-099c06bfc6e0@yandex-team.ru>
Date: Thu, 26 Feb 2026 17:11:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] [for-10.1] block-jobs: add final flush
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com, den@openvz.org
References: <20250402083715.391059-1-vsementsov@yandex-team.ru>
 <aZ8leLFRoF4J7s6a@redhat.com>
 <2a294c9c-fd5d-4c57-a43d-4ba08e24fe48@yandex-team.ru>
 <aaBHWpS78HWizzmv@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aaBHWpS78HWizzmv@redhat.com>
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

On 26.02.26 16:15, Kevin Wolf wrote:
> Am 25.02.2026 um 21:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> On 25.02.26 19:38, Kevin Wolf wrote:
>>> Am 02.04.2025 um 10:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Actually block job is not completed without the final flush. It's
>>>> rather unexpected to have broken target when job was successfully
>>>> completed long ago and now we fail to flush or process just
>>>> crashed/killed.
>>>>
>>>> Mirror job already has mirror_flush() for this. So, it's OK.
>>>>
>>>> Do this for stream, commit and backup jobs too.
>>>>
>>>> Note that jobs behave a bit different around IGNORE action:
>>>> backup and commit just retry the operation, when stream skip
>>>> failed operation and store the error to report later. Keep
>>>> these different behaviors for final flush too.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>
>>>> v2 was old "[PATCH v2 0/3] block-jobs: add final flush"[1]
>>>> v3: follow Kevin's suggestion to introduce block_job_handle_error()
>>>>      (still, it's not obvious how to rewrite commit and stream operation
>>>>      loops reusing this helper, not making things more complicated..
>>>>      I decided too keep them as is, using new helper only for final flush.)
>>>>
>>>> [1] https://patchew.org/QEMU/20240626145038.458709-1-vsementsov@yandex-team.ru/
>>>> Supersedes: <20240626145038.458709-1-vsementsov@yandex-team.ru>
>>>>
>>>>    block/backup.c           |  8 ++++++++
>>>>    block/commit.c           |  6 +++++-
>>>>    block/stream.c           |  8 ++++++--
>>>>    blockjob.c               | 34 ++++++++++++++++++++++++++++++++++
>>>>    include/block/blockjob.h |  9 +++++++++
>>>>    5 files changed, 62 insertions(+), 3 deletions(-)
> 
>>>> diff --git a/block/commit.c b/block/commit.c
>>>> index 5df3d05346..711093504f 100644
>>>> --- a/block/commit.c
>>>> +++ b/block/commit.c
>>>> @@ -201,7 +201,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>>>>            }
>>>>        }
>>>> -    return 0;
>>>> +    do {
>>>> +        ret = blk_co_flush(s->base);
>>>> +    } while (block_job_handle_error(&s->common, ret, s->on_error, true, true));
>>>
>>> Why does commit still flush even if we return an error?
>>
>> Hmm. We are on success path here, we do flush where "return 0;" was.
> 
> True, disregard it here. I saw it on stream and didn't read commit
> carefully enough assuming it was the same.
> 
>>>> @@ -235,8 +235,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>>>>            }
>>>>        }
>>>> +    do {
>>>> +        ret = blk_co_flush(s->blk);
>>>> +    } while (block_job_handle_error(&s->common, ret, s->on_error, true, false));
>>>
>>> Same here about flushing even on error.
>>
>> Here I keep the behavior of stream: for "ignore" action, it continues streaming,
>> but in the end return failure. It's documented in QAPI, and I note it in commit
>> message.
>>
>> If we continue writes after failure, I assume we still need these writes, so,
>> why not flush them?
> 
> It probably doesn't hurt much, but since we already know that the
> streaming won't complete successfully, it's probably also not incorrect
> not to flush - nobody can rely on everything being present in the active
> layer.
> The only thing that can happen is that you get another failure,
> which could be nasty if the failure comes only after a long timeout. But
> I guess either way is fine.
> 
>> As far as I understand semantics of "ignore", it means "ignore errors, but still
>> try to do as much progress as possible". And it seems strange that other jobs do
>> endless retry in case of "ignore" action..
> 
> Yes, I wonder if anyone is using this mode in practice.

Me too. Maybe, try to deprecate it? And we'll see, will someone be against it.

> 
>>>
>>>> +
>>>>        /* Do not remove the backing file if an error was there but ignored. */
>>>> -    return error;
>>>> +    return error ?: ret;
>>>>    }
>>>>    static const BlockJobDriver stream_job_driver = {
>>>> diff --git a/blockjob.c b/blockjob.c
>>>> index 32007f31a9..70a7af2077 100644
>>>> --- a/blockjob.c
>>>> +++ b/blockjob.c
>>>> @@ -626,3 +626,37 @@ AioContext *block_job_get_aio_context(BlockJob *job)
>>>>        GLOBAL_STATE_CODE();
>>>>        return job->job.aio_context;
>>>>    }
>>>> +
>>>> +bool coroutine_fn
>>>> +block_job_handle_error(BlockJob *job, int ret, BlockdevOnError on_err,
>>>> +                       bool is_read, bool retry_on_ignore)
>>>> +{
>>>> +    assert(ret >= 0);
>>>> +
>>>> +    if (ret == 0) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    if (job_is_cancelled(&job->job)) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    BlockErrorAction action =
>>>> +        block_job_error_action(job, on_err, is_read, -ret);
>>>> +    switch (action) {
>>>> +    case BLOCK_ERROR_ACTION_REPORT:
>>>> +        return false;
>>>> +    case BLOCK_ERROR_ACTION_IGNORE:
>>>> +        if (!retry_on_ignore) {
>>>> +            return false;
>>>> +        }
>>>> +        /* fallthrough */
>>>
>>> What is the idea behind having a pause point for "ignore"? Is it to at
>>> least avoid QEMU hanging completely if it goes into an infinite loop
>>> with retry_on_ignore?
>>
>> Yes, just to have a pause point on every iteration of retrying loop,
>> like we do it in data-copying iterations of block jobs.
> 
> Ok, that's fair. If you want, we could add a comment to this effect.
> 

Will do. Honestly it cost me some minutes to understand why we "fallthrough"
from "ignore" to "stop" case, even though I wrote it myself.


-- 
Best regards,
Vladimir

