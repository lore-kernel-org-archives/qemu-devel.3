Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F882F8DFDF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDeq7-0002a4-Vs; Fri, 17 Apr 2026 04:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDeq5-0002Zh-4C
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:46:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDeq2-0001kJ-9h
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:46:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso13363585e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776415557; x=1777020357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22Ho4kX+CjuKV5lN3tRKrHzmNOhqtSwAYe2V5z1im1A=;
 b=CI1tSzSKKXfMh83Uyk7hNL7RyVwZrhBrWdjck+gXLK7Ljh/G5jla8+GKK4PIvjrWM+
 ASIQMjVEhS0C2Faew1cvmlULrh2/sdYE/cdvhR7DG3jE9vSa24pN0uJgFx/ZZCLYfPc/
 rO6akHRxzV5WTeuW6I7+OFQPUIegth2mxaVPiRwYiIpJiPWQNt1JYyfEyyw7GR/h6qpb
 udcbaV9HNbaEymUXuEM5PFw12/Ha+waRM8G2xxCrMtUGigtf6XA0SIWxQuTcploDlAHX
 382OIKpKG5eFCATJelG7Kuv5CN9E3iQBIjVzyVeRCmq4WDnhw3rQaLaZLFyQIPJbQ9GE
 /zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776415557; x=1777020357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22Ho4kX+CjuKV5lN3tRKrHzmNOhqtSwAYe2V5z1im1A=;
 b=gSUhdh/UkcRIAT64HjHWz06IUOGAkwU5JvdCfoC38pLyf5cuPdmjokpB+6BkXr7NZ4
 GEv6vhYPSDIfDiae4Z+EtDOKoVgmxzKRUoLwqyAIQZqxZ5WoM3eFM+s5ZlK1H+BxncFf
 oKeMQ5kowlfzcwVhTD3+kSE9aLOVBM24Sl4AL+ZgqW3jLFo0sN3dbqikqRQEMI7oHfjE
 duV+AUfbx1jCypUTJ2mnM0+b7iaqbQdLizgo4H6pMvIIvD6fBOyEVGXMPXRECjzFRJvY
 Z7VQyJH5FFJcrA5MLaH9JXXVTPczHjSw8JnCG5m/J0CHNS8kcM+WdanJ/qU69xHeSoYO
 7+CQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vJ7PngIl1HyoyEgkhelqauqO/1RSZPHG9JRnkwb+FkAv4mMUpl46hbDfxJmHr+v7IOP++XdozsZMj@nongnu.org
X-Gm-Message-State: AOJu0Yw9hpsZuLPb9O0IcCUp0rJz3VEf3qs/o0T2vEVawZdkMF6zFYBx
 pjQXbgUBQi9kHZkk1ZRdSCY9+vSuW7n35YkrUsSlla4JHYz3BSeBF473h5VrFhCcSr8=
X-Gm-Gg: AeBDiestTC0flOQxxXq1ZD3MjT7K70tQWmZWLLYY+EquKW3xJHuH/r43ayu7iRMxuSw
 Lt/WGjkXYtx+9pLnIJ+itthWjQvoB7qhSdGff4Dlpuhp4BoJiVCNpeJ8czMWHmNjK21GElEulZx
 mhhOVIORT9bLjUxsHLDgC2jSKzEIbmtZhGIeT+TOEDDXtFozPsbN+vt/mn8Ka7oKV+sn4ed96h2
 jTVs/jiTdGUk3O6/K5psqX2DuBplOQrZ5teWWh6oDLp5KCSOmZ5HHg8dPAt1ZqtUD9myXJ4HOCs
 fDLuCkWwrkIDx5WTMxrIwmiVRQxZV90aiEekQmrhjm9XfsES27xjHeBuZuazfW/+ohj7BpoOhcB
 J51koHH6oLP7TDoziFs9hQea0Nm6ypaNXjo4EZf7tx9gzhxPNAatfxzcF4a0+284XnRs5joLyv0
 UXQFTK1sMABBq5Z+nZglDuHLjpdYPi8ucylP7qOoL02KC+AKc2uXCjKdSo5S49bFVNcaFU2ApXg
 Gxa
X-Received: by 2002:a05:600c:4749:b0:488:c6e9:1e0c with SMTP id
 5b1f17b1804b1-488fb889385mr22105915e9.5.1776415556944; 
 Fri, 17 Apr 2026 01:45:56 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc14a61asm26929235e9.15.2026.04.17.01.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 01:45:54 -0700 (PDT)
Message-ID: <3d147229-24b2-4a2b-87ce-6e87157c330d@linaro.org>
Date: Fri, 17 Apr 2026 10:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/28] MAINTAINERS: Remove Paul Burton
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-17-peter.maydell@linaro.org>
 <2d316b10-e6cc-401a-bceb-47777c3e6205@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2d316b10-e6cc-401a-bceb-47777c3e6205@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/4/26 10:10, Thomas Huth wrote:
> On 16/04/2026 11.16, Peter Maydell wrote:
>> Paul Burton has not posted to qemu-devel in some years and did not
>> respond to a query about whether they still wished to be listed in
>> our MAINTAINERS file.  Remove them, on the assumption that they are
>> no longer active in QEMU.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   MAINTAINERS | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6cbb1e049a..a7a345c514 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1486,7 +1486,6 @@ F: include/hw/intc/loongson_liointc.h
>>   F: tests/functional/mips64el/test_loongson3v.py
>>   Boston
>> -M: Paul Burton <paulburton@kernel.org>
>>   R: Aleksandar Rikalo <arikalo@gmail.com>
>>   S: Odd Fixes
>>   F: hw/core/loader-fit.c
> 
> Aleksandar is only listed as Reviewer ... so should the status rather be 
> changed to "Orphan" now?

No need to orphanize, I'll maintain it with other MIPS boards.

