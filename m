Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB37DF417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzc0G-0003H9-6V; Mon, 09 Mar 2026 10:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbzl-00039T-5L
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:54:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbzj-00062c-5E
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:54:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so23706125e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773068045; x=1773672845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DiQAVEFb3r6ogPZf0GUrrnxuG22BmOSeHtlf/Q6Q7Ng=;
 b=SMXpvJHp7zFyqdrmOa60GkTf7VqcYSmWz7K+XNMfqJrOz1hSYBJTeE0IjAIMtkayf+
 WokUx5TTo4EOZ4iLYY6bHGsdKIS/E1b56GmdH/JGT0TiIRU55n1BrccsvfOieitwRofI
 ihHAPvwLE24Apcp8NDW/qg20Rz6GiZWRdXhmtcABJH9ny94D1692CwvzLTYJgh3Avc8R
 GnFR30oI8q31660tqwK6o5sxeYzHfq1pzGyJnQvd4ucXGuAzLIWFonxB3xKRmI8MxSOd
 iIKgJuuNOVJvCvaLZlZ+aK7qC8yuvA4DGD5bP2XeS6OkxYewqxkj0IgqiwwAyoUren14
 0TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068045; x=1773672845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DiQAVEFb3r6ogPZf0GUrrnxuG22BmOSeHtlf/Q6Q7Ng=;
 b=SmCyKTPCyBgcuQbqtpN0Dc2t/KcCaY3IagH8s4k9RXQqPJejE6o2G/3nLqH7EIhfHP
 wV+WWQ0Gtcm+U8ZP7WJdJ1Df7cggyDyznx5N8u2VQJyv5UuUmjA85LZY7iD0+OBOcBjL
 O/bsTwcmu5BX5bVJ59BXKAlVsOS9cvu2J+oFLV2HpcdjInjC96WD56xKvbBQ+5ZA6vC4
 WbZn/VG4Sw6rRq42M2rEjg/ESbFU96a9D08JiDDtEbyxeARChzQJICgP1xfwCrsRKVcY
 W+qaHqljErTFTWCdlZn7HGLpbghXY4qMAc4WG//n/UtBf1XGKzBxHxrkTHqmdSYJbW5O
 UzRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZB3GeWlDaT7cjw3Rr0aaahzuovwJf7P9Qt2qdG8RR9VIhHIN95Rjcexs9J7I1JUU6rC38X8ddeV5F@nongnu.org
X-Gm-Message-State: AOJu0YyxqGFVJUf0XlyBEREvYpbM28bOy1IsUWdJQ1d7AtmXV1DE/Pl7
 Wd2i7tBvbuGodjsO2/r1RUWBN9YFBp3w1/N6VF2ZYRkBef4rrHr2qCpIJz6+L8/WLjbCaxLwiAk
 0fQW5gmg=
X-Gm-Gg: ATEYQzzVTGu5UPxHN1O5bob/3uNZgX9zqRB+25WhN9/y2CYpkh1w/qwb5zfN0dAY8zI
 zZLMoUtVoco6ZEIMfYG7wGqBoiC4Q6zvMnlpnZVtJgl9Uu0X8m1y0W5aAR2jiT9FLjG0gNxksDb
 qdx3Oj1q6IWv4CgAOUUEGf4ckOZ88bLZ70XGTf1yQYxMDEx3t1vxqLLoJoinJ0e7VuyVRyZeSPz
 3TQtUrFuArDSpFCTKMFbExlEQInsETRgX/iCJjdiY48EVtzJZAU2cj6jAQsJwiEqJ73EVqo8vae
 xoeTg3e0eU34bVSMgZ8iJ7XVV2CD5l9z9UsPSEMtRb10E7OigrWxqeoN+wAht3aqbCwJx2EcDvh
 HBlm5O/xxJNlLzJJcDa9UQ2kZdeJPRgPOnZNgwiAiQozOuGFREoTew6ISXnxfS4RndG7t+9w4rL
 4PMleVyD36al7DaUsDtoWncM9bclGu/gfZkqwa00yDC8cho2qBCoKzGe5PKAuEw4Vv3wzIawkuB
 yuNdUVV7Q==
X-Received: by 2002:a05:600c:4686:b0:485:3ae8:2236 with SMTP id
 5b1f17b1804b1-4853ae82538mr62224835e9.32.1773068044635; 
 Mon, 09 Mar 2026 07:54:04 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e3fsm248652025e9.6.2026.03.09.07.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 07:54:04 -0700 (PDT)
Message-ID: <a038115b-8855-42a3-bf7a-b56a93c18e10@linaro.org>
Date: Mon, 9 Mar 2026 15:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ui: fix small leaks in -display dbus
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
 <CAFEAcA8PwXsmYGsPDyctxm7Ud78VYB_3nFazxvTXpu=HsGTnzw@mail.gmail.com>
 <d884b7c9-5bc6-4b5f-a45b-43716fdb2268@linaro.org>
 <CAFEAcA-Ji3o6qZSTevUdVVZBforcjo4uOhjDRsUPJe+qJ=bKPw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-Ji3o6qZSTevUdVVZBforcjo4uOhjDRsUPJe+qJ=bKPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 9/3/26 15:51, Peter Maydell wrote:
> On Mon, 9 Mar 2026 at 14:21, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> On 8/3/26 14:25, Peter Maydell wrote:


>>>> Marc-André Lureau (4):
>>>>     tests: fix leaks in dbus-display-test
>>>>     ui/dbus: fix leak regression
>>>>     ui/dbus: fix Unix.Map proxy leak
>>>>     ui/dbus: fix pixman cleanup
>>>>
>>>>    tests/qtest/dbus-display-test.c |  9 +++++++++
>>>>    ui/dbus-listener.c              | 11 +++++------
>>>>    2 files changed, 14 insertions(+), 6 deletions(-)
>>>
>>> I don't know the code well enough to review more than the
>>> two really obvious ones, but this series fixes all the leaks I
>>> see in the dbus-display-test test.
>>
>> Is this statement equivalent to:
>>
>> Tested-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I thought about that, but I decided against it, because
> I have not tested the actual dbus functionality at all;
> I only ran 'make check'. For all I know the tests could have
> fixed the leaks and broken something for users :-)

OK. I'll queue this series then, thanks!

