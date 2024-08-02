Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD00C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqBI-0000yf-T4; Fri, 02 Aug 2024 07:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZqBG-0000xg-5X; Fri, 02 Aug 2024 07:10:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZqBC-0004jf-NY; Fri, 02 Aug 2024 07:10:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:440a:0:640:8c95:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A9F5E60B63;
 Fri,  2 Aug 2024 14:10:30 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b725::1:34] (unknown
 [2a02:6b8:b081:b725::1:34])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TAWG4I1Aca60-RYI8QBIS; Fri, 02 Aug 2024 14:10:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722597030;
 bh=cGzyL897Ce2iOqGz9HgoOfZGIuI5BFPN7707xsh4P6I=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pZxoJTccI+2jlVuDDuYH+wdI4TJCWCENq3ZgjcJr3krF6B+uvyAtxNwgqgMbQrvVG
 +r+dJrYJmAu6z+EBxpc9uOYfLp/1mtYetLcwy7sMX7hufTtus6vmWDZsufMUCDnpvb
 N9AgGiS+FAuRMyjfpZwXhWwwDYF6blYYKae6XMWE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d74a4f09-beff-40aa-9c60-292188798722@yandex-team.ru>
Date: Fri, 2 Aug 2024 14:10:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] qapi: add job-change
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
 <20240626110124.374336-6-vsementsov@yandex-team.ru>
 <87le1zx8x1.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87le1zx8x1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18.07.24 13:59, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add a new-style command job-change, doing same thing as
>> block-job-change. The aim is finally deprecate block-job-* APIs and
>> move to job-* APIs.
>>
>> We add a new command to qapi/block-core.json, not to
>> qapi/job.json to avoid resolving json file including loops for now.
>> This all would be a lot simple to refactor when we finally drop
>> deprecated block-job-* APIs.
>>
>> @type argument of the new command immediately becomes deprecated.
> 
> Where?

Oops, that type-based union was dropped, so this sentence should be dropped as well.

> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   job-qmp.c            | 14 ++++++++++++++
>>   qapi/block-core.json | 10 ++++++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/job-qmp.c b/job-qmp.c
>> index c764bd3801..248e68f554 100644
>> --- a/job-qmp.c
>> +++ b/job-qmp.c
>> @@ -139,6 +139,20 @@ void qmp_job_dismiss(const char *id, Error **errp)
>>       job_dismiss_locked(&job, errp);
>>   }
>>   
>> +void qmp_job_change(JobChangeOptions *opts, Error **errp)
>> +{
>> +    Job *job;
>> +
>> +    JOB_LOCK_GUARD();
>> +    job = find_job_locked(opts->id, errp);
>> +
>> +    if (!job) {
>> +        return;
>> +    }
>> +
>> +    job_change_locked(job, opts, errp);
>> +}
>> +
>>   /* Called with job_mutex held. */
>>   static JobInfo *job_query_single_locked(Job *job, Error **errp)
>>   {
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 660c7f4a48..9087ce300c 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3104,6 +3104,16 @@
>>   { 'command': 'block-job-change',
>>     'data': 'JobChangeOptions', 'boxed': true }
>>   
>> +##
>> +# @job-change:
>> +#
>> +# Change the block job's options.
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'command': 'job-change',
>> +  'data': 'JobChangeOptions', 'boxed': true }
>> +
>>   ##
>>   # @BlockdevDiscardOptions:
>>   #
> 

-- 
Best regards,
Vladimir


