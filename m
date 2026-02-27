Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3825AFEFB6F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 23:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw7hK-0007bM-6R; Fri, 27 Feb 2026 18:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vw7hI-0007b5-2W; Fri, 27 Feb 2026 18:56:40 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vw7hE-0006MZ-Ut; Fri, 27 Feb 2026 18:56:38 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 14BBA807BE;
 Sat, 28 Feb 2026 02:56:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:42e::1:38] (unknown
 [2a02:6bf:8080:42e::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Uut7du7Ag8c0-6i8IMy0Z; Sat, 28 Feb 2026 02:56:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772236591;
 bh=ypShSVZ4kRJbpPOKBgdfb3jtGN0KL/Lf1jCUjbPBsHU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=sLv0Y/o/++UYlZ5yh5C0eS9dPj/8F7dqGUDfWhAORpaHc5LUQgrmYw+Q4MM5Gm5j9
 KizJTKvhq7MQvuxON91rcpZGnB6wGuUx0fAV+mLsbrKAPvbTlW4yoEJCFArDcuDVB2
 yfisNmO7WIHdGKdxKyhzdJ2/f4fUsyuVqq2K6mYs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5be3da95-a636-4b50-8d68-17f363fc005b@yandex-team.ru>
Date: Sat, 28 Feb 2026 02:56:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] migration: make .post_save() a void function
To: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-4-vsementsov@yandex-team.ru> <87ecm5u7wc.fsf@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ecm5u7wc.fsf@suse.de>
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

On 28.02.26 01:41, Fabiano Rosas wrote:
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 3695afd483..15578b3e28 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -223,7 +223,15 @@ struct VMStateDescription {
>>       bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
>>       int (*pre_save)(void *opaque);
>>       bool (*pre_save_errp)(void *opaque, Error **errp);
>> -    int (*post_save)(void *opaque);
>> +
>> +    /*
>> +     * post_save() rarely used to free some temporary resources.
>> +     * It's is called if .pre_save[_errp]() call was successful
>> +     * (or .pre_save[_errp] handler absent), regardless success
>> +     * or failure during fields and subsections save. If
>> +     * .pre_save[_errp]() fails, .post_save() is not called.
>> +     */
> I would not mention usage directly and maybe also simplify the language
> a bit. If there's doubt on the exact flow, people can read the code:
> 
>    /*
>     * Unless .pre_save() fails, post_save() is called after saving
>     * fields and subsections. It should not fail because at this point
>     * the state has potentially already been transferred.
>     */


Agree, sounds good.

-- 
Best regards,
Vladimir

