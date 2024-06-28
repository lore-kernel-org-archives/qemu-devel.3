Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297E3C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN4GR-0004n1-Pi; Fri, 28 Jun 2024 01:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sN4GN-0004ly-Ga; Fri, 28 Jun 2024 01:35:12 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sN4GK-0006nE-Gb; Fri, 28 Jun 2024 01:35:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0EDD160E34;
 Fri, 28 Jun 2024 08:35:01 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b511::1:0] (unknown
 [2a02:6b8:b081:b511::1:0])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xYKMtY01NuQ0-IlIXMf4f; Fri, 28 Jun 2024 08:35:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719552900;
 bh=rug9sgwWPNNsVCj+k/2zbWP79s3VI/39i5UYYa3Qh04=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=yrDoi3zt+7xxtILhC0rtCJ/SxEKloO/+fxqsDNs+rrFpMSgd2mCoLhqILepf+jNmP
 8UiqQwbrrNC3zf9eNpJu1dlUwHqj0NeD4cQkSy5qHrkRmAYBYlvaB3ay6xVLzdjKKi
 +jOg4WRhfG8w4IVGKgYJL/ncj/TS9QEbkDGt0RLU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <faa585ef-b1f9-48e7-9d49-b362ad26e69e@yandex-team.ru>
Date: Fri, 28 Jun 2024 08:34:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/curl: explicitly assert that strchr returns
 non-NULL value
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 qemu-trivial@nongnu.org
References: <20240627153059.589070-1-vsementsov@yandex-team.ru>
 <Zn2p4v8jmkGB1on-@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <Zn2p4v8jmkGB1on-@redhat.com>
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

On 27.06.24 21:05, Kevin Wolf wrote:
> Am 27.06.2024 um 17:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> strchr may return NULL if colon is not found. It seems clearer to
>> assert explicitly that we don't expect it here, than dereference 1 in
>> the next line.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   block/curl.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 419f7c89ef..ccfffd6c12 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -219,7 +219,9 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>>           && g_ascii_strncasecmp(header, accept_ranges,
>>                                  strlen(accept_ranges)) == 0) {
>>   
>> -        char *p = strchr(header, ':') + 1;
>> +        char *p = strchr(header, ':');
>> +        assert(p != NULL);
>> +        p += 1;
> 
> I'm not sure if this is actually much clearer because it doesn't say why
> we don't expect NULL here. If you don't look at the context, it almost
> looks like an assert() where proper error handling is needed. If you do,
> then the original line is clear enough.
> 
> My first thought was that maybe what we want is a comment, but we
> actually already know where the colon is. So how about this instead:
> 
>      char *p = header + strlen(accept_ranges);
> 

Oh, right. That's better.

> 
>>           /* Skip whitespace between the header name and value. */
>>           while (p < end && *p && g_ascii_isspace(*p)) {
>> -- 
>> 2.34.1
>>
> 

-- 
Best regards,
Vladimir


