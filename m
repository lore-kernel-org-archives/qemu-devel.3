Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AADF54AB8
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w51sO-0007Op-VX; Tue, 24 Mar 2026 09:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w51sN-0007Oc-26
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:32:55 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w51sL-0002xA-4T
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:32:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E0DDFC01A6;
 Tue, 24 Mar 2026 16:32:48 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:46c::1:35] (unknown
 [2a02:6bf:8080:46c::1:35])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kWTDON0AsuQ0-HzwcQEqR; Tue, 24 Mar 2026 16:32:48 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774359168;
 bh=C3PF4XPTEf+NoGf/S0bHt4v49k+fVw/T7NCbskJkH9g=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WppFlKkUEhIuzYXrX3SRxnnDOgyTjaTQR3Cw8kX7TeGVq2YuWrLDYUxYxc5LIN2HB
 MyO5Pw5CuIRxgiRKHiBzz8aAO40TC3xKf//QhwNgYN0x5pYiK38PxbzgIgVm+LP8yB
 9NIqSx1I373vS6J7x8H/tMGgPqu++Rdjh0S38zTg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0a8a94d8-2365-4f85-9529-cb204149c585@yandex-team.ru>
Date: Tue, 24 Mar 2026 16:32:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/8] qapi: add local migration parameter
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, farosas@suse.de,
 peterx@redhat.com, zhao1.liu@intel.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 leiyang@redhat.com, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 th.huth+qemu@posteo.eu, berrange@redhat.com, pbonzini@redhat.com
References: <20260319155333.260341-1-vsementsov@yandex-team.ru>
 <20260319155333.260341-4-vsementsov@yandex-team.ru>
 <87341ptnxo.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87341ptnxo.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 24.03.26 15:24, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> We are going to implement local-migration feature: some devices will be
>> able to transfer open file descriptors through migration stream (which
>> must UNIX domain socket for that purpose).  This allows to transfer the
>> whole backend state without reconnecting and restarting the backend
>> service. For example, virtio-net will migrate its attached TAP netdev,
>> together with its connected file descriptors.
>>
>> In this commit we introduce a migration parameter, which enables
>> the feature for devices that support it (none at the moment).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>>   void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 7134d4ce47e..cf7037ed3fc 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -831,7 +831,8 @@
>>              'mode',
>>              'zero-page-detection',
>>              'direct-io',
>> -           'cpr-exec-command'] }
>> +           'cpr-exec-command',
>> +           'local'] }
>>   
>>   ##
>>   # @migrate-set-parameters:
>> @@ -1007,6 +1008,12 @@
>>   #     is @cpr-exec.  The first list element is the program's filename,
>>   #     the remainder its arguments.  (Since 10.2)
>>   #
>> +# @local: Enable local migration for devices that support it.  Backend
>> +#     state and its file descriptors can then be passed to the
>> +#     destination in the migration channel.  The migration channel
>> +#     must be a Unix domain socket.  Usually needs to be enabled per
>> +#     device.  (Since 11.0)
> 
> Sure your're still targeting 11.0?

Time passes quickly) Will fix to 11.1.

> 
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-checkpoint-delay and
>> @@ -1046,7 +1053,8 @@
>>               '*mode': 'MigMode',
>>               '*zero-page-detection': 'ZeroPageDetection',
>>               '*direct-io': 'bool',
>> -            '*cpr-exec-command': [ 'str' ]} }
>> +            '*cpr-exec-command': [ 'str' ],
>> +            '*local': 'bool' } }
>>   
>>   ##
>>   # @query-migrate-parameters:
> 
> With the appropriate Since: tag
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks!

-- 
Best regards,
Vladimir

