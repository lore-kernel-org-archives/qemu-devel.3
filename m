Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8F7C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEV63-0003ud-Jf; Tue, 04 Jun 2024 10:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEV61-0003u1-5x
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:25:05 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEV5z-0000MM-IU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:25:04 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a68b54577aaso357617666b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717511101; x=1718115901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yTmKZg3CoJGtoh9Amocye8ceQAZCifXakhS9aJZgX3w=;
 b=oApUvDoJs+29v1FYB/WWhWPLR3v7KncmXlsuKnsyeGjdh0daTieMP1FkNCKlul58KU
 D451v74ILdhIFfmhk4a+h1Fohd2DrFlJ6boRBuTaG11PVZVGWbeUECKp7o42ORthELsF
 J5u08b6gi78AKaZy6vZUGSPg9ax/Zn23q4xhuL0cILVi3J9jBuqH8ewfVBE9tGJNVvwG
 1UC7l0wTTo8M6oAb/NBsOJNPvVlcTVPjZHxYxn8hkMa/o5ESECKv+VO4BvSd4/020DD2
 lvKrfg1MpFD7ebp25a3IoO7TGPqoYDmSx/CuVt72q65ymieM8N1LsMpOhiTCj8wOrpaU
 oxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717511101; x=1718115901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yTmKZg3CoJGtoh9Amocye8ceQAZCifXakhS9aJZgX3w=;
 b=VpWQZaZXpMC2/jgpUGgeDlaIlmTVtlxdmCcTySUnXU90MVGkQ5Zw34yr+ccKLltl0F
 g6vaSvBhM1RwgtyHk2+zRbiZ+wZuBkA+UvZ+S1jhSVwd2gRl02ZUsTLMbei2zGjwC44t
 ZjBqvmODT7XpyMj6n4WDF5tr4CKnSApQ8YAKHEGBEYqsl+K1jvuc0zK2AktvfK3uh7Qh
 7Tg/SAq+HN1JdxnBcEYdeKwQyiRNLRIbbfFa0SWfTqygmSgBIbkSpYo25oSPBfXOEjT9
 MXJCotGJzB81LDNbTI7Ctaj0p+liQBf0c1ynceSI6ryB14i8SFdrM6ZBTrIYp+Bl0JfL
 UNVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI+bTeFuFK1gksWVjo6VIhy/H/s9y8eQ7BfF2NIPDjeiq+zM6rDYIFED1EbCH2HU+dEBHld9dX+htpGFBZYGWczqEiLUQ=
X-Gm-Message-State: AOJu0YyUv8WiOw84M88C3spTWdME/bJ8iBKdyFxwupAFUjayNhXUjXiw
 P3Ei01cOUMx+92GLpoGp3XXKTkCQnCWoFxr//Bzb2FKcjJ0WxbJbvuuUTiXcviA=
X-Google-Smtp-Source: AGHT+IHRfw8w8oQ7IsvYJ0H/aXNJRK7M5wNgBbYHtuSIROj+lvSNNNX1GOwHmCc38M10zM7wsoSR9A==
X-Received: by 2002:a17:906:60b:b0:a68:afbb:c010 with SMTP id
 a640c23a62f3a-a68afbbec4amr542661066b.10.1717511101521; 
 Tue, 04 Jun 2024 07:25:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e728b92fsm415329766b.60.2024.06.04.07.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 07:25:00 -0700 (PDT)
Message-ID: <1f4daf4d-980b-47c6-ab3c-f7ec5852d423@linaro.org>
Date: Tue, 4 Jun 2024 16:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw/mips/loongson3_virt: Implement IPI support
To: gaosong <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <a9717e72-9de2-469f-89c1-8ae969b0031e@linaro.org>
 <75c78b9e-4a18-4faf-9b80-a497d3401dba@app.fastmail.com>
 <96870199-5782-4d87-ba10-f4b886936a96@linaro.org>
 <3836d4b2-ed2d-3a4c-7092-54d0d9e1429d@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3836d4b2-ed2d-3a4c-7092-54d0d9e1429d@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 4/6/24 14:55, gaosong wrote:
> 在 2024/6/3 下午11:35, Philippe Mathieu-Daudé 写道:
>> On 16/5/24 12:53, Jiaxun Yang wrote:
>>> 在2024年5月8日五月 下午10:41，Philippe Mathieu-Daudé写道：
>>>> On 8/5/24 15:06, Jiaxun Yang wrote:
>>>>> Hi all,
>>>>>
>>>>> This series enabled IPI support for loongson3 virt board, loosely
>>>>> based on my previous work[1].
>>>>> It generalized loongarch_ipi device to share among both loongarch
>>>>> and MIPS machines.
>>>>
>>>>
>>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>>> ---
>>>>> Jiaxun Yang (5):
>>>>>         hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
>>>>>         hw/intc/loongarch_ipi: Rename as loongson_ipi
>>>>>         hw/intc/loongson_ipi: Implement IOCSR address space for MIPS
>>>>
>>>> So far patches 1-3 queued to hw-misc tree, thanks.
>>>
>>> Hi Philippe,
>>>
>>> Thanks! What's your plan with the rest of the series
>>
>> Patches LGTM, but I'd like an Acked-by from Song Gao ;)
>>
> Patch 1 - 4:
> Acked-by: Song Gao <gaosong@loongson.cn>

Thanks!

> and patch2 missed to delete the file loongarch_ipi.c.

Jiaxun, I can not apply this series anymore, could you respin?

Regards,

Phil.

