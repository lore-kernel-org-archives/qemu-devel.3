Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55BEC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 11:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fIz-0003pi-Fo; Fri, 04 Apr 2025 07:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0fIx-0003p6-Kw; Fri, 04 Apr 2025 07:33:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0fIu-0008T2-2s; Fri, 04 Apr 2025 07:33:47 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1c:342e:0:640:ad4e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6CD7A60E14;
 Fri,  4 Apr 2025 14:33:38 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1220::1:20] (unknown
 [2a02:6b8:b081:1220::1:20])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXXtU30FVuQ0-P2Lhtq1H; Fri, 04 Apr 2025 14:33:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743766417;
 bh=xNr6d3kPNQr5TVRu1b1OomempEFQA8uuKk26LXBcvIQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cXOZhXihrOWlv315lwg5QpaKu0/aZmSA4n02eEpRKAoYdbP71TP7aF2yOcuY+Ggi9
 Eyr5yh8jamA4rzuPX+eifiehvak+lTfcqLWObLFjbMqVmjYN1JTPUZFDCj4o922Kqs
 9tLUil7z2Lq8C+JvhAIS00bV1NIumUaEF+h5X13Q=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <638e4d21-6440-47e7-9ad5-ac44b0c03cb0@yandex-team.ru>
Date: Fri, 4 Apr 2025 14:33:37 +0300
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <8734eosb14.fsf@pond.sub.org>
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

On 04.04.25 09:20, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> For change, pause, resume, complete, dismiss and finalize actions
>> corresponding job- and block-job commands are almost equal. The
>> difference is in find_block_job_locked() vs find_job_locked()
>> functions. What's different?
>>
>> 1. find_block_job_locked() do check, is found job a block-job. This OK
>>     when moving to more generic API, no needs to document this change.
>>
>> 2. find_block_job_locked() reports DeviceNotActive on failure, when
>>     find_job_locked() reports GenericError. So, lets document this
>>     difference in deprecated.txt. Still, for dismiss and finalize errors
>>     are not documented at all, so be silent in deprecated.txt as well.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Hi all!
>>
>> That's a continuation of my "[RFC 00/15] block job API"[1], exactly, the
>> simplest part of it - deprecating block-job-* commands which simply
>> duplicate job-* ones.
>>
>> Note that the old series was started with trying to introduce job-change
>> command as substitution to both block-job-change (which only can change
>> mirror copy-mode parameter), and block-job-set-speed. It was rather
>> complicated and controversial attempt, which latest implemenation was
>> "[PATCH v3 0/7] introduce job-change qmp command"[2].
>>
>> In [2] Kevin noted, that we'd better follow existing blockdev-reopen
>> approach of changing options (i.e. specify all options) than introduce a
>> new one. But, on the other hand, now I'm afraid, that rewriting in
>> third tools simple call to (old good) block-job-set-speed into
>> job-change(_all_options_ + changed speed) is too much work just for
>> "having nice interface". And too much for the only two options we want
>> to change.
>>
>> So, let's just start from something more obvious. Finally,
>> we can simple keep block-job-set-speed and block-job-change as is,
>> as they (unlike other block-job-* commands) are not duplicated by
>> similar job-* commands.
>>
>> [1] https://patchew.org/QEMU/20240313150907.623462-1-vsementsov@yandex-team.ru/
>> [2] https://patchew.org/QEMU/20241002140616.561652-1-vsementsov@yandex-team.ru/
> 
> Thank you for your efforts at making the interfaces cleaner, simpler,
> and less redundant.
> 
>>   docs/about/deprecated.rst | 31 +++++++++++++++++++++++++++++++
>>   qapi/block-core.json      | 30 ++++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index e2b4f077d4..eed3356359 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -148,6 +148,37 @@ options are removed in favor of using explicit ``blockdev-create`` and
>>   ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
>>   details.
>>   
>> +``block-job-pause`` (since 10.1)
>> +'''''''''''''''''''''''''''''''
>> +
>> +Use ``job-pause`` instead. The only difference is that ``job-pause``
>> +always reports GenericError on failure when ``block-job-pause`` reports
>> +DeviceNotActive when block-job is not found.
> 
> block-job-pause's doc comment:
> 
>      # The operation will pause as soon as possible.  No event is emitted
>      # when the operation is actually paused.  [...]
> 
> job-pause's:
> 
>      # The job will pause as soon as possible, which means transitioning
>      # into the PAUSED state if it was RUNNING, or into STANDBY if it was
>      # READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.
> 
> Either one of them is incorrect about event emission, or there is
> another difference.
> 

First is incorrect. Both commands simply call job_user_pause_locked() function.

I think, that block-job-pause documentation is older than JOB_STATUS_CHANGE event.

>> +
>> +``block-job-resume`` (since 10.1)
>> +''''''''''''''''''''''''''''''''
>> +
>> +Use ``job-resume`` instead. The only difference is that ``job-resume``
>> +always reports GenericError on failure when ``block-job-resume`` reports
>> +DeviceNotActive when block-job is not found.
> 
> block-job-resume's doc comment:
> 
>      # This command also clears the error status of the job.
> 
> Nothing like that job-resume's.  Either one of them is incorrect /
> incomplete about the error status clearance, or there is another
> difference.
> 

Comment is correct.. But it applies only to block-jobs. I can add it to job-resume,
like

    # This command also clears the error status of block jobs
`

>> +
>> +``block-job-complete`` (since 10.1)
>> +''''''''''''''''''''''''''''''''''
>> +
>> +Use ``job-complete`` instead. The only difference is that ``job-complete``
>> +always reports GenericError on failure when ``block-job-complete`` reports
>> +DeviceNotActive when block-job is not found.
> 
> block-job-complete's doc comment:
> 
>      # Manually trigger completion of an active background block operation.
>      # This is supported for drive mirroring, where it also switches the
>      # device to write to the target path only.  The ability to complete is
>      # signaled with a BLOCK_JOB_READY event.
>      #
>      # This command completes an active background block operation
>      # synchronously.  The ordering of this command's return with the
>      # BLOCK_JOB_COMPLETED event is not defined.  Note that if an I/O error
>      # occurs during the processing of this command: 1) the command itself
>      # will fail; 2) the error will be processed according to the
>      # rerror/werror arguments that were specified when starting the
>      # operation.
> 
> job-complete's:
> 
>      # Manually trigger completion of an active job in the READY state.
> 
> Is the latter lacking useful information?
> 

Actually, only mirror job supports this command. So yes, we can copy the comment
to job-complete as well.

>> +
>> +``block-job-dismiss`` (since 10.1)
>> +'''''''''''''''''''''''''''''''''
>> +
>> +Use ``job-dismiss`` instead.
> 
> block-job-dismiss's doc comment:
> 
>      # For jobs that have already concluded, remove them from the
>      # block-job-query list.  This command only needs to be run for jobs
>      # which were started with QEMU 2.12+ job lifetime management
>      # semantics.
> 
> I figure "started with QEMU 2.12+ job lifetime management semantics" is
> an awkward way to say "auto-dismiss is false".
> 
> job-dismiss's doc comment:
> 
>      # Deletes a job that is in the CONCLUDED state.  This command only
>      # needs to be run explicitly for jobs that don't have automatic
>      # dismiss enabled.
> 
> @auto-dismiss defaults to true for jobs that support controlling it:
> drive-backup, blockdev-backup, block-commit, drive-mirror,
> blockdev-mirror, block-stream.  I guess these are exactly the commands
> that already existed when we added "QEMU 2.12+ lifetime management".
> 
> I figure it's always false for the other jobs, but that doesn't seem to
> be documented anywhere.

Yes, relying on 2.12 version in modern documentation is awkward. I'll touch this up somehow.

> 
>> +
>> +``block-job-finalize`` (since 10.1)
>> +''''''''''''''''''''''''''''''''''
>> +
>> +Use ``job-finalize`` instead.
>> +
> 
> block-job-finalize's doc comment:
> 
>      # Once a job that has manual=true reaches the pending state, it can be
>      # instructed to finalize any graph changes and do any necessary
>      # cleanup via this command.  [...]
> 
> There is no member @manual anywhere in the QAPI schema.  I figure this
> should be @auto-finalize.
> 
> job-finalize's doc comment:
> 
>      # Instructs all jobs in a transaction (or a single job if it is not
>      # part of any transaction) to finalize any graph changes and do any
>      # necessary cleanup.  This command requires that all involved jobs are
>      # in the PENDING state.
> 
> Nothing on @auto-finalize.
> 
> @auto-finalize defaults to true for jobs that support controlling it.
> These are exactly the ones that support @auto-dismiss.
> 
> I figure @auto-dismiss is always false for the other jobs, but that
> doesn't seem to be documented anywhere.
> 
> The only other bits related to @auto-dismiss and @auto-finalize seem to
> be two states in JobStatus:
> 
>      # @pending: The job has finished its work, but has finalization steps
>      #     that it needs to make prior to completing.  These changes will
>      #     require manual intervention via @job-finalize if auto-finalize
>      #     was set to false.  These pending changes may still fail.
>      [...]
>      # @concluded: The job has finished all work.  If auto-dismiss was set
>      #     to false, the job will remain in the query list until it is
>      #     dismissed via @job-dismiss.
> 
> 
> Is it possible to observe @concluded via QMP when @auto-dismiss is on?

Seems not.

> 
> What about @pending?

Hmm probably, if we have a transaction of several jobs (actually only backups may be joined to transactions), where some have auto-finalize and some not, the whole transaction would be pending, including jobs that has auto-finalize=true. Still, it's a strange case.

> 
> Aside: getting rid of auto-dismiss and auto-finalize some day would be
> nice.
> 

Hmm.. You mean, deprecated "true" value, and finally drop the fields, making "false" the default? May be.


I'll resend, with additional patch to touch-up the documentation.


-- 
Best regards,
Vladimir


