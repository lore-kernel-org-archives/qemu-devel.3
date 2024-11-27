Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96F3D6D22E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 19:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGNcm-00039K-QM; Wed, 27 Nov 2024 14:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGNck-00038w-VY
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 14:22:55 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGNcj-0007Ox-2e
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 14:22:54 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3823e45339bso72863f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732735371; x=1733340171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o0aH4alW4mStXgjAu+q2wshRCmic4d3mjkw5bj2WKJo=;
 b=Jux2dhqWsc8YT/v+1FhpI8Cy54UPhTqb9R5JJhcF7lKTaJgYdFTQn0oRvUSgJaowm3
 Uugw1hItBc6YLfCpiBaIb3KILXe7F3OBqmvGOI3LNF0LmMiPc2HWKjBM0PgH4PFQ+V4o
 C6UJ/WguZ55rhLT62NzpYeKmE7V+MCoOmFhbdixMFCXm8bKxLBP0kaO8pA4z5EslXz0r
 aOpgmHV8L5BgyArTbbIhx+70BeAcjBEn7Gm8rpvQp2OR3gQDPbdBdpVjUJT+P/THR4d0
 ZD26oWpicDiErTF0WnIRxO/VPDFIy4jtr5Bn27X/td2a5xuixMM95mju2VEBMWjHW1/l
 J8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732735371; x=1733340171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0aH4alW4mStXgjAu+q2wshRCmic4d3mjkw5bj2WKJo=;
 b=Qq1GU2MqSa4qAdoyf/CFTtPWC26BfNNMdb5PCiaiS+qXzmcQCi5MrjrrCIZcO7/1HY
 w43Y+Rjkx5ruE2DN5yCS03yQcVq/qiCRpqxbF42TaAW7ZrpzTs7v54DEscQFUSi3HvCs
 daR4wEUdws4FSydoMxF+PyQ+w14Oft5prbTPolCk+/r80wO6YmCr48bSX6lSJvtVztj+
 gcFr7vvLOxWfRRD6hYF1g4FMrWPllnkQ9JcF1V18JeCDTh3voTgQKXIcoB5h3GZK+xqR
 /QTV9KjV3NY0AbDg2RU46euIZzHla6fRbNOeiGKAA+B4jTeihkVQGXaOTzh9+0gROTGr
 MfNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWeko7j1ll7FAkxmraPbGi4dHNb+7T3m72jlZ955CIzhLIYy0qPCTUQ2OrefdEymZGTpsjFTjWGYrc@nongnu.org
X-Gm-Message-State: AOJu0Ywkg41JK2GdEiD5CMSQFdjZX+6DLKdiGCHnUPXIz81vNA5MLHXB
 Mj6X9u/wuLpXs/WeUHQvGtiM2smyWzpGHep+URwd/FZvIXedUQaYglPWoJlTHnw=
X-Gm-Gg: ASbGnctfclgun7iWyeyR+J2MHk2ETBc1VNZknjXOPHTvStV7wizQ0i9A6OpcHkuiG64
 BJfM8hwLWt0s6WSxL2t3rrFjyINHgK+PMCAFAwfnS/+Iqlus1PRVGLrbYaAp00w00cV2l+YFZMT
 NjxkX6oIli8HkVMnMNFwn0gYFjYP0QkBMDFKKNIsRVPbyqFn6fIw1CpP20j4wDVTDZO1z3wTIZE
 W/2MZ8TIPRwHeKVZg+KHwa26VilHHrBPqEawzDKsFkcfLjDrhpd9N/HOIINDT4jYWiDO1EsB9wK
 NAv9Kz6kcewGyIJH4mpM2X6srWZ3C3JTfO5Y
X-Google-Smtp-Source: AGHT+IHjaHOWkV873OUDP6iboKIDechhJE7U2r5oWHe/M7gYwe2LpRR/ZkT4Edwe7etfWk82CSKD2g==
X-Received: by 2002:a05:6000:4604:b0:382:2cbd:9a4b with SMTP id
 ffacd0b85a97d-385c6ebcd7emr3839635f8f.24.1732735371156; 
 Wed, 27 Nov 2024 11:22:51 -0800 (PST)
Received: from [192.168.69.146] (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr.
 [176.184.14.96]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3ba2sm17445292f8f.74.2024.11.27.11.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 11:22:50 -0800 (PST)
Message-ID: <cfa1c780-012b-4c4d-975a-e08068706607@linaro.org>
Date: Wed, 27 Nov 2024 20:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20241113094342.282676-2-frolov@swemel.ru>
 <Z0YUMoPr0oyQhqqK@redhat.com>
 <04edda40-32d2-43e0-8ade-a4b2a3e06eab@swemel.ru>
 <49cc1e5e-dd62-475e-b483-c2897c829529@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <49cc1e5e-dd62-475e-b483-c2897c829529@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 27/11/24 19:44, Pierrick Bouvier wrote:
> On 11/26/24 23:40, Дмитрий Фролов wrote:
>> Hello, Daniel
>>
>> On 26.11.2024 21:32, Daniel P. Berrangé wrote:
>>> On Wed, Nov 13, 2024 at 12:43:40PM +0300, Dmitry Frolov wrote:
>>>> Some tests need more time when qemu is built with
>>>> "--enable-asan --enable-ubsan"
>>>>
>>>> As was discussed here:
>>>> https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.r/u
>>>>
>>>> TIMEOUT_MULTIPLIER enviroment variable will be
>>>> a useful option, allowing non-invasive timeouts
>>>> increasing for a specific build.
>>>>
>>>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>>>> ---
>>>>    scripts/mtest2make.py | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
>>>> index eb01a05ddb..ff60b62724 100644
>>>> --- a/scripts/mtest2make.py
>>>> +++ b/scripts/mtest2make.py
>>>> @@ -27,7 +27,9 @@ def names(self, base):
>>>>    .speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), 
>>>> --suite $s)
>>>>    .speed.thorough = $(foreach s,$(sort $1), --suite $s)
>>>> +ifndef TIMEOUT_MULTIPLIER
>>>>    TIMEOUT_MULTIPLIER = 1
>>>> +endif
>>> Can you explain what scenario this is needed for, as unless I'm
>>> missing something this change has no purpose. This assignment is
>>> merely defining the defalt value, which can already be overridden
>>> at runtime without this 'ifndef'
>>>
>>> eg
>>>
>>> $ make check-unit TIMEOUT_MULTIPLIER=7
>>>
>>> In another shell:
>>>
>>> $ ps -axuwwf | grep 'meson test'
>>> berrange 1931657  3.9  0.1 330904 99344 pts/1    S+   18:29   
>>> 0:00                  \_ 
>>> /var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 
>>> /var/home/berrange/src/virt/qemu/build/pyvenv/bin/meson test 
>>> --no-rebuild -t 7 --num-processes 1 --print-errorlogs --suite unit
>>>
>>> shows TIMEOUT_MULTIPLIER being honoured
>> Yeah... You are right!
>> It is possible to set TIMEOUT_MULTIPLIER only to run tests.
>> It is not necessary to set it for the whole build.
>>
>> Sorry, and thanks a lot!
>>>
>>>
>>> With regards,
>>> Daniel
>> regards,
>> Dmitry
>>
> 
> This patch is still useful if we want to set TIMEOUT_MULTIPLIER as 
> global env variable, and not explicitely on each make invocation.

If so, I'd rather use conditional assignment [*]:

- TIMEOUT_MULTIPLIER = 1
+ TIMEOUT_MULTIPLIER ?= 1

[*] 
https://www.gnu.org/software/make/manual/html_node/Conditional-Assignment.html



