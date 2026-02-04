Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97505E83F0E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhEd-00053h-4x; Wed, 04 Feb 2026 13:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhEX-00053B-Ox
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:04:11 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhEV-00048T-0K
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:04:09 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43596062728so861040f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770228245; x=1770833045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L/Nny+CcBI3i+79c5S2V6/m35Mota+9QqGXJcwq3/aY=;
 b=QbHc7m418AXhbjOuB5u56OkisUgrFdkoG9p6G7Pa4UCScgz6B63I3uzcktOV5nIfCC
 I3YbSZnuZZPpl3QSaNXrb8bQyo122ICocuLKe4L13bRoaqMuYZW+uyiz+i5c2NKuUMc5
 xm3Jhh5fadad8Trt9ksF3m1ReYxMuB6wXtC3MP16ok3+fQAGrRpJ7bjG7VVn3JnS5ljG
 4HomqS+5rG4+2r1pg3bRS6VmZlJre5Edlu6NzllNHWJBVkrLRv+/Fb9DNHBUveeMCI9R
 cFXzCOgBPiLgEUaLV2XuPixFo+N4GUOnXpdqZ9PR42stoXb2R6XY+kduvXbYB5e94DML
 5wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770228245; x=1770833045;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/Nny+CcBI3i+79c5S2V6/m35Mota+9QqGXJcwq3/aY=;
 b=eu36VumScEnxPy2ScciWGIIIEXrYbB//cTssKpUnflP03OVNSxveZf+EL38XOFZpAW
 BuXOOQXg7ShGmUzPXJ2qkBOVEjNZgzZYFaIOrqVpY5bqL7PgXhtEfbSm6JLe/LOmkkrF
 wkbOQAlhhoSjxG74KTJhLQ65Xgbbn+sHLA1lpIpqa6c+5wujEvaqyRzxFumll3pfd36E
 oDxnIEihqx4+QRcc0japRD10RdNlXGdEZF9pA0tYrlRGwtT59c9JPh+VFizgrP6xGH/n
 gxlKbb1JiT/fUNtrM1a1ei/LteCkaZTg6n5NOz8Oti0gF3lhz13ugwaqBNxFBx9Go6SC
 s+bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlWTZW86VHPIJgVCJsXglYJsNJD0qkWRQ54c5iyRsv+jCuQctnQ39Mf1f3ZnWgJ9nUzQ+m9PkiMJaF@nongnu.org
X-Gm-Message-State: AOJu0Yw2eJAN7opkaK+PiJUozly15NPMDzqmkjT8gPRwCZI5+jCgVRUx
 97yEAQqpo8y15QjT57DhBCYBNa8OB5PIHjq2sJ/14sq0JxbSTmn6tFAxCsRoVZp1OSw=
X-Gm-Gg: AZuq6aLXkN+bXRgF3v2CagcPierRfDi7L/j/Ccp0L0YghMzwUd8dEZmkwiyEk1/OvbD
 JO2JcIm0ykYdwUCwroEHWEdLXSVKG8OF7QO8H6AC6DNxbEA+hWy9l8ToFABKOKJR2rV2KnaPUCI
 wew68eVoBJpfVOIYGuV4RezkA/79fZ3Ab3p+FdveC4lPtq/VA7E6zU87kEAMIAKySul2TZEWFoU
 1F80iP0/8mjbjdreJ8O04gPfk7VZesabobqkRfpKG137+h4o9J0BULLhXq2+QSLKE4LZeRVpiFt
 32vn15U/qZdB+XLIoWREYy6y5zTZI5uYgs4jO14jfCoNc1KqN7ORYx55YyevG/ylUGvBvTwifen
 nS6E1LRCC+hPrt+RpQ3yNonwoaHWu8M3mxNEp2ctRWalNOiAc4rP3UXL315hmB0juMw/FLft97/
 gDMX8uRsbij8mKuRWC4Ol5qrZ7XfSB+eekZuHzEMVBmgyy1hGjcbNMaQ==
X-Received: by 2002:a5d:5d13:0:b0:435:a43b:2dde with SMTP id
 ffacd0b85a97d-436213dfe91mr198150f8f.15.1770228244505; 
 Wed, 04 Feb 2026 10:04:04 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38ec5sm8794354f8f.14.2026.02.04.10.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 10:04:03 -0800 (PST)
Message-ID: <038cc071-1a40-47a8-acf4-55016af8d5b2@linaro.org>
Date: Wed, 4 Feb 2026 19:04:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] target/s390x: Introduce CHSC_MAX_REQ_LEN definition
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-14-philmd@linaro.org>
 <5302604f-0fe5-4dfb-8baa-f072e279504a@redhat.com>
 <0fef147f-8268-47ae-b037-ce7d7063489a@linaro.org>
Content-Language: en-US
In-Reply-To: <0fef147f-8268-47ae-b037-ce7d7063489a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/1/26 12:46, Philippe Mathieu-Daudé wrote:
> On 8/1/26 08:53, Thomas Huth wrote:
>> On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
>>> Since commit 166f1bb7968 ("s390x/ioinst: Rework memory access
>>> in CHSC instruction") the access is no more tied to the page
>>> size. Define CHSC_MAX_REQ_LEN to better express the relation
>>> with the length of the Channel Subsystem Call request.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/s390x/ioinst.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>>> index 2320dd4c122..d07773d14a3 100644
>>> --- a/target/s390x/ioinst.c
>>> +++ b/target/s390x/ioinst.c
>>> @@ -398,6 +398,7 @@ typedef struct ChscResp {
>>>       char data[];
>>>   } QEMU_PACKED ChscResp;
>>> +#define CHSC_MAX_REQ_LEN  0x1000
>>>   #define CHSC_MIN_RESP_LEN 0x0008
>>>   #define CHSC_SCPD 0x0002
>>> @@ -660,7 +661,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t 
>>> ipb, uintptr_t ra)
>>>       uint16_t len;
>>>       uint16_t command;
>>>       CPUS390XState *env = &cpu->env;
>>> -    uint8_t buf[TARGET_PAGE_SIZE];
>>> +    uint8_t buf[CHSC_MAX_REQ_LEN];
>>>       trace_ioinst("chsc");
>>>       reg = (ipb >> 20) & 0x00f;
>>> @@ -690,7 +691,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t 
>>> ipb, uintptr_t ra)
>>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>>           return;
>>>       }
>>> -    memset((char *)req + len, 0, TARGET_PAGE_SIZE - len);
>>> +    memset((char *)req + len, 0, CHSC_MAX_REQ_LEN - len);
>>>       res = (void *)((char *)req + len);
>>>       command = be16_to_cpu(req->command);
>>>       trace_ioinst_chsc_cmd(command, len);
>>
>> Sorry, I don't quite get it, there are still dozends of others 
>> TARGET_PAGE_SIZE usages in target/s390x/, what's the advantage of 
>> removing that one here?

The other ones are really related to the s390x page size.

This one seems to use TARGET_PAGE_SIZE as an optimization.

> 
> The other ones are also used by user emulation so need more care. This
> series addresses all system-only files. I neglected to mention that in
> the cover :(
> 
> But if you think this is better to review all target/s390x/ conversion
> in one go, I can wait until I finish the rest.


