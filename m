Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ECEC48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 07:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raW5d-0003zG-45; Thu, 15 Feb 2024 02:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raW5Z-0003yc-GM
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:23:23 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raW5X-0006tK-9m
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:23:20 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d7431e702dso4557175ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 23:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707981797; x=1708586597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HaLcyOZi7VLTHOLpBSDx9OmhlMu9oQQHLmdwc9b9A3U=;
 b=t9lUpb/7KKTkjxJPdw1Nsy5XQWgfZt6nvAELtm3FAvm8VIg3A/1jQxGdoWAlWMZQBm
 1EGZaPjGqTD9/dDcA/SwJ4h/4WYGp0ggp6pxVKBZbOoAeYbRKouVZzcodTwxjczfJhn3
 ws1ACAyjH7lkV5UYhXKA3GWH16BQeLrjYv/mIiwZOTF7TUYICv3nZrCVrIKdlkzn9U47
 uHkfYrford0mp//oCSAL/UB08/Gi/IEnIHoXANnBTCMRbBVFUpzV9oql6uwBEXdHqigr
 rfJop/07Dj61GWHdIPQd1Qpru7ornc+YNaJbK9ueX1cuksH6gu62vtwrgTBwsqQn+Kdx
 sDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707981797; x=1708586597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HaLcyOZi7VLTHOLpBSDx9OmhlMu9oQQHLmdwc9b9A3U=;
 b=I7BWAt0k+pnIQv179AVQXZs3svYJVQz1bh3sZdOm5uRqsEYXwvvQUqW8wLewAPnJ5A
 hplvYRhGKcgmCoAs14OgKF4C7xtq31JiaoUEILM47ZpoaLTJWZ1gUhnihCOqzOnAso9h
 wP/LbqymjU2yxg/jE2tytQtpmEEhYaBo1/p+C9yru3eWTGJJKS5+xhpi2AylHAd4mtC0
 8sQKbHRKeUuIM02ElEKc+Spwhjhcgsux6unlep2Pau9L/50046F7xdJyE+4O3Tg4gxME
 6Z4SAv9O1xgxcz1rgzWwiWv/tezBJVHVfZmbRCtMraP7+hZh6dzs5PwTDzNqRVrFIXZ/
 8Qfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCjJ0+TfUrNhTjjAahoM7hiTpIoOcFX+N+ZBzllULbVj+H1l/YA75dGGSbZRks0CknSuJM6bPBbePwkg92F/3w2yOEGbg=
X-Gm-Message-State: AOJu0YxHsqXgjZyEOqEvW2hqjwYpn42eDL16x8+xfY+UivHA2cJS0609
 ueyus+6n+PGwg+Fn/9vvVxpTH7F06K1yN31wwChjKOGdrSOHkpszAmGY61sXg80uNX4zU87vpYo
 u
X-Google-Smtp-Source: AGHT+IE+AD7LnaPvRe/BTfcMP5VO8OCAgPC9K8Pew4N5lQJdRJFYAXHCw0O28AycCKFGdGxvpyu/MA==
X-Received: by 2002:a17:903:1103:b0:1db:4245:454b with SMTP id
 n3-20020a170903110300b001db4245454bmr1149706plh.57.1707981797469; 
 Wed, 14 Feb 2024 23:23:17 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k5-20020a170902f28500b001db37da684bsm598753plc.71.2024.02.14.23.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 23:23:17 -0800 (PST)
Message-ID: <1165d690-b272-4e59-84de-50a53c5abefa@linaro.org>
Date: Wed, 14 Feb 2024 21:23:14 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 36/36] linux-user: Remove pgb_dynamic alignment
 assertion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexey Sheplyakov <asheplyakov@yandex.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
 <20240215062018.795056-37-richard.henderson@linaro.org>
 <2854a908-bc6f-4c18-bcf7-632efdd070eb@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2854a908-bc6f-4c18-bcf7-632efdd070eb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/14/24 21:07, Philippe Mathieu-Daudé wrote:
> On 15/2/24 07:20, Richard Henderson wrote:
>> The assertion was never correct, because the alignment is a composite
>> of the image alignment and SHMLBA.  Even if the alignment didn't match
>> the image an assertion would not be correct -- more appropriate would
>> be an error message about an ill formed image.  But the image cannot
>> be held to SHMLBA under any circumstances.
>>
>> Fixes: ee94743034b ("linux-user: completely re-write init_guest_space")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2157
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/elfload.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index f3f1ab4f69..d92d66ca1e 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3022,8 +3022,6 @@ static void pgb_dynamic(const char *image_name, uintptr_t 
>> guest_loaddr,
>>       uintptr_t brk, ret;
>>       PGBAddrs ga;
>> -    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
>> -
>>       /* Try the identity map first. */
>>       if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
>>           brk = (uintptr_t)sbrk(0);
> 
> I suppose this isn't part of this series since posted as
> https://lore.kernel.org/qemu-devel/20240214045413.541677-1-richard.henderson@linaro.org/
> 
> Still:
> Reported-by: Alexey Sheplyakov <asheplyakov@yandex.ru>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Whoops, no.  But I did need it for testing on ppc64 64k page host.


r~

