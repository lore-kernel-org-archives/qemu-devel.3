Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A5CC48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 14:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbiDt-0006iB-Br; Sun, 18 Feb 2024 09:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1rbiDr-0006hb-Bi
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 09:32:51 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1rbiDn-0005xF-To
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 09:32:51 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:378d:0:640:d5c4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7923862FA5;
 Sun, 18 Feb 2024 17:32:40 +0300 (MSK)
Received: from [IPV6:2a02:6b8:82:604:49ba:dd75:c3fc:4af8] (unknown
 [2a02:6b8:82:604:49ba:dd75:c3fc:4af8])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id cWQO7f5Ik4Y0-obNNa9yH; Sun, 18 Feb 2024 17:32:39 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1708266759;
 bh=NUeHuznO3u6a+A4ksHhqWtt+zxVfDmWKNvHtVGxRsUw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WyIe8cJPU0s9Q6c781vbphBXTx63bxwwauzXWq/Eqi96WuWkDj0WWiagKNPxxThVs
 tkzT82OymD7T+9pRqR2Nf4aqM+5Koj69uqgVHXZRR8ihw0cGn/GpYGyDhFyYer/sZF
 zX1B6f7qw//yNW3WO2IMObdrGI7SMGbahBJavysc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d1f73aaa-f5cb-4366-a567-fad7d965b76e@yandex-team.ru>
Date: Sun, 18 Feb 2024 19:32:38 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qapi/migration.json: add reason to MIGRATION event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, yc-core@yandex-team.ru
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
 <20240215122759.1438581-2-rkhapov@yandex-team.ru>
 <87il2p0w78.fsf@pond.sub.org>
Content-Language: en-US
From: Roman Khapov <rkhapov@yandex-team.ru>
In-Reply-To: <87il2p0w78.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=rkhapov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

To be clear: you meant that the description of the event must be 
extended, similar to its description on the commit message? Or you don't 
see its proper usage at all?

If the first is true, then I agree, the description can be improved, and 
it will be useful, thanks! Will add it in the next version of the patch 
soon.

On 2/16/24 11:17, Markus Armbruster wrote:
> Roman Khapov <rkhapov@yandex-team.ru> writes:
>
>> This commit adds the optional field reason for the events, which
>> contains the string, describing reason of status changing.
>> For example: reason of migration fail.
>>
>> Function migrate_set_state now accepts 4th argument: the reason to
>> pass to event. Every call of this function appended with NULL argument.
>>
>> Also migrate_set_state_err_reason was added to form reason from Error*
>>
>> Signed-off-by: Roman Khapov <rkhapov@yandex-team.ru>
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 5a565d9b8d..33bb5b7f50 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1392,6 +1392,7 @@
>>   # Emitted when a migration event happens
>>   #
>>   # @status: @MigrationStatus describing the current migration status.
>> +# @reason: Optional description of status changing reason.
> Intended use?
>
> When is it present?
>
>>   #
>>   # Since: 2.4
>>   #
>> @@ -1402,7 +1403,7 @@
>>   #     "data": {"status": "completed"} }
>>   ##
>>   { 'event': 'MIGRATION',
>> -  'data': {'status': 'MigrationStatus'}}
>> +  'data': {'status': 'MigrationStatus', '*reason': 'str'}}
>>   
>>   ##
>>   # @MIGRATION_PASS:

-- 
Best regards,
Roman


