Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62137C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ia8-0008TM-RD; Fri, 04 Apr 2025 11:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0iZl-0008Q3-RN; Fri, 04 Apr 2025 11:03:25 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0iZj-0000R8-0a; Fri, 04 Apr 2025 11:03:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 718F060AB8;
 Fri,  4 Apr 2025 18:03:14 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1220::1:20] (unknown
 [2a02:6b8:b081:1220::1:20])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id D3br900FhSw0-FXBfId66; Fri, 04 Apr 2025 18:03:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743778994;
 bh=OjO9VQG46JZDzBTgvMX6B3s83pb0YzMCKIWryGqgEKo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NPSNP0zm86Lrbf46vF/OmcmhgQMu2wrBuG5pNuSjKUfwMZE8CQn/T8V7S3H1DuLxY
 5kxwUCDgPuvdrZzuWxuFQnp8pbUERod3z/IzMRdAH4eoVUVWAM4NtOJVSx7k6+6DE9
 UvENynjbRVGvyOAFFi5tOif6mCw2Sg7I7ntzUylg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <184192da-6f38-4c7b-926e-ad5a42482a64@yandex-team.ru>
Date: Fri, 4 Apr 2025 18:03:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 devel@lists.libvirt.org, pkrempa@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com
References: <20250401155730.103718-1-vsementsov@yandex-team.ru>
 <8734eosb14.fsf@pond.sub.org>
 <638e4d21-6440-47e7-9ad5-ac44b0c03cb0@yandex-team.ru>
 <87ecy8nhfo.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ecy8nhfo.fsf@pond.sub.org>
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

On 04.04.25 17:13, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 04.04.25 09:20, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
> [...]
> 
>>>> +
>>>> +``block-job-finalize`` (since 10.1)
>>>> +''''''''''''''''''''''''''''''''''
>>>> +
>>>> +Use ``job-finalize`` instead.
>>>> +
>>>
>>> block-job-finalize's doc comment:
>>>
>>>       # Once a job that has manual=true reaches the pending state, it can be
>>>       # instructed to finalize any graph changes and do any necessary
>>>       # cleanup via this command.  [...]
>>>
>>> There is no member @manual anywhere in the QAPI schema.  I figure this
>>> should be @auto-finalize.
>>>
>>> job-finalize's doc comment:
>>>
>>>       # Instructs all jobs in a transaction (or a single job if it is not
>>>       # part of any transaction) to finalize any graph changes and do any
>>>       # necessary cleanup.  This command requires that all involved jobs are
>>>       # in the PENDING state.
>>>
>>> Nothing on @auto-finalize.
>>>
>>> @auto-finalize defaults to true for jobs that support controlling it.
>>> These are exactly the ones that support @auto-dismiss.
>>>
>>> I figure @auto-dismiss is always false for the other jobs, but that
>>> doesn't seem to be documented anywhere.
>>>
>>> The only other bits related to @auto-dismiss and @auto-finalize seem to
>>> be two states in JobStatus:
>>>
>>>       # @pending: The job has finished its work, but has finalization steps
>>>       #     that it needs to make prior to completing.  These changes will
>>>       #     require manual intervention via @job-finalize if auto-finalize
>>>       #     was set to false.  These pending changes may still fail.
>>>       [...]
>>>       # @concluded: The job has finished all work.  If auto-dismiss was set
>>>       #     to false, the job will remain in the query list until it is
>>>       #     dismissed via @job-dismiss.
>>>
>>>
>>> Is it possible to observe @concluded via QMP when @auto-dismiss is on?
>>
>> Seems not.
>>
>>>
>>> What about @pending?
>>
>> Hmm probably, if we have a transaction of several jobs (actually only backups may be joined to transactions), where some have auto-finalize and some not, the whole transaction would be pending, including jobs that has auto-finalize=true. Still, it's a strange case.
> 
> So, auto-finalize=true is silently ignored when another job in the same
> transaction has auto-finalize=false?

Yes, at least, it looks like so:

static void job_completed_txn_success_locked(Job *job)
{

[...]

     /* If no jobs need manual finalization, automatically do so */
     if (job_txn_apply_locked(job, job_needs_finalize_locked) == 0) {
         job_do_finalize_locked(job);
     }
}

> 
>>> Aside: getting rid of auto-dismiss and auto-finalize some day would be
>>> nice.
>>>
>>
>> Hmm.. You mean, deprecated "true" value, and finally drop the fields, making "false" the default? May be.
> 
> May or may not be practical.
> 
>> I'll resend, with additional patch to touch-up the documentation.
> 
> Thanks!
> 

-- 
Best regards,
Vladimir


