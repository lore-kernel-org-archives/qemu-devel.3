Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BD3C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 16:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ronIQ-0006I5-Rt; Mon, 25 Mar 2024 12:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ronIO-0006HK-Co; Mon, 25 Mar 2024 12:35:36 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ronIM-0003Ye-Cp; Mon, 25 Mar 2024 12:35:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 23CC460CD9;
 Mon, 25 Mar 2024 19:35:27 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b406::1:29] (unknown
 [2a02:6b8:b081:b406::1:29])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PZN9jk2IfeA0-gZ3YLPi4; Mon, 25 Mar 2024 19:35:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711384526;
 bh=KM2tzKPQvwS7pDT+tsn58oFgGgLoGcCa2+I1zOE5TU0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XEKIouMV7xR7+2Oe9gZs1ATLscsqHWuR0eUp15flACqBLFcDgOMVB4hHLE+blEE05
 WGhUuuwMVxU4pdiE7LnjA+I0VUfsHdjlYuxoRd0YWLEy9LTSxBVsCV5IG9OOfaMQAF
 Zv9O3wQ1iqOonxorYDmDFl0XvkI57I5WnpvdFjEg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d4cf3716-5a05-4388-8382-1a2ccd3b7107@yandex-team.ru>
Date: Mon, 25 Mar 2024 19:35:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/block-core: improve Qcow2OverlapCheckFlags
 documentation
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com
References: <20240325120054.2693236-1-vsementsov@yandex-team.ru>
 <87le66laxs.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87le66laxs.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 25.03.24 16:04, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>  writes:
> 
>> Most of fields have no description at all. Let's fix that. Still, no
>> reason to place here more detailed descriptions of what these
>> structures are, as we have public Qcow2 format specification.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
>> ---
>>   qapi/block-core.json | 25 +++++++++++++++++++++----
>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 1874f880a8..b9fb994a66 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3403,14 +3403,31 @@
>>   # @Qcow2OverlapCheckFlags:
>>   #
>>   # Structure of flags for each metadata structure.  Setting a field to
>> -# 'true' makes qemu guard that structure against unintended
>> -# overwriting.  The default value is chosen according to the template
>> -# given.
>> +# 'true' makes qemu guard that Qcow2 format structure against
> Mind if I use the occasion to correct the spelling of QEMU?

No problem, thanks for fixing

-- 
Best regards,
Vladimir


