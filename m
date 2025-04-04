Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E80DC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 11:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fFw-0002Dd-5I; Fri, 04 Apr 2025 07:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0fFq-00028A-Nv
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:30:37 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0fFo-0007uu-GW
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:30:34 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so1824717b3a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743766230; x=1744371030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vvv3Zi3cXe312L8i+gf1a8w5A7tBqE1E8qNkYhPxRKw=;
 b=Si5b+zxMLXBQzKjDpeg0h/CS8fxKzwdJ/oc5SkksIwBK/VldPhyfyYnjXMEBIxfDkN
 95Ex8cr2SssWxZC/PCIWqOMyJcpLhubPBYD2DrXeb4L1CZ5yjhbCEKPUIugHEoxFnwtZ
 903jl+ryCl8bzFBEGdUg9g7a7p1XyfwV8lU6VbmnkF/6MVQgomeYEVJ3P440b8V5CyOF
 YUrnjrmTLFYyB2Txbs0nzhMO7SLHKv7up2h5dTBAafyeiFOvEBKDPi7U4F4BfZTNyCSn
 P+t8JaqSSAoU7+f9HX0HwLsRjX1SbOuOHzJYNxJ+ntJLpjBtOF7gBmaZVUV+LhKuH07a
 EwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743766230; x=1744371030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vvv3Zi3cXe312L8i+gf1a8w5A7tBqE1E8qNkYhPxRKw=;
 b=Q3UmwHH6mmAiJr/AzS1kUPEfF3Io0ccGg0S82nUAzcFc8Dy+NKZ20ha8X3lC4sQ3dz
 RLw5M2UR+Wr3g93l/HxjHMB/2gEeX/Fc5Ni5wsLXTOkB0LXct5Q9TddCYWqROTH1PBwt
 DAclXnt5g8alNO2Cvwnp93rB2dyrdwLrS2JNxgcU4AISqin4j4d7N6OuisaPqsj1fl7h
 KQpAoRKMWzH8rQYOEK9t4SKXSdipWNNH/SHhVyhm43TwZZlfds7Vv7xhljRDc3gaVQaS
 TZTY8oPWjufVUkj8x/akJfWWDtz2EXMTM9bDILqVk4w37+2Gcrzc/ux2tQGmbQmP79a6
 iSNA==
X-Gm-Message-State: AOJu0YwXLzgXZk4Jp9vO3zUHi41eDB1R+Epdn00KjU6ISZgyhb48gAPB
 QnwmD3m2+eF6lpcCT/OJa2t4pPD/VnTUXznoYFVG5yDiUTmxofwcfuALWwA6Zbo=
X-Gm-Gg: ASbGncsfH0ZoBA8GdSSZeP+QD6r3yygde1qYop7PFx6zfgfZhRi9da+PlVP96uy4/tz
 sg+ivh8Je75g92zYx1eS3B0+8lrJAANpsQ2uUJm0Ka8McnxRaucVikcig4XSf4fthaYonRHeh8l
 fFnFk3dkJp37B+PkAStq/szMHWKHvdpIfY5C2Y19Egv8QLHMKkbk+oFy7TUro3PMLLj7amnXwza
 STe6phwHvgzLR9RKhs6ZciMz8yyEanoxOP7SZCSVkf7w+vmJUkWMlkiRXtPDYF6l5/6uqmgeyAJ
 nDNn7yX9iTQBcfkhO9XtR1nIv4brcZHfM7e2v1d398BM5njdQJI5VU1bXYho
X-Google-Smtp-Source: AGHT+IHW2Ci90IkY2SeKdHPkvFoZNxRyMBYIpDt0ZICBqcCOKlKrN+X9jAJWPEXr9J1HCOcbAL3mrQ==
X-Received: by 2002:a05:6a21:9987:b0:1f3:47d6:aa05 with SMTP id
 adf61e73a8af0-20104045968mr4394808637.0.1743766230498; 
 Fri, 04 Apr 2025 04:30:30 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc2cfa87sm2659282a12.6.2025.04.04.04.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 04:30:29 -0700 (PDT)
Message-ID: <65b3fa18-0f04-4cf8-8d21-ecef180f2fcc@ventanamicro.com>
Date: Fri, 4 Apr 2025 08:30:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] hw/riscv: do not mark any machine as default
To: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250327130256.653357-1-dbarboza@ventanamicro.com>
 <19d7409d-35a0-486f-a626-9d382fb8a6bf@linaro.org>
 <CAKmqyKPsRvaVztUdPRwf5h90rVdT9MOrvQz_=WvoEj-bWoTWVg@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKPsRvaVztUdPRwf5h90rVdT9MOrvQz_=WvoEj-bWoTWVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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



On 4/4/25 2:50 AM, Alistair Francis wrote:
> On Fri, Mar 28, 2025 at 2:16 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 27/3/25 14:02, Daniel Henrique Barboza wrote:
>>> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
>>> made it default for qemu-system-riscv32/64. It was the first RISC-V
>>> machine added in QEMU so setting it as default was sensible.
>>>
>>> Today we have 7 risc64 and 6 riscv32 machines and having 'spike' as
>>> default machine is not intuitive. For example, [1] is a bug that was
>>> opened with the 'virt' board in mind, but given that the user didn't
>>> pass a '-machine' option, the user was using 'spike' without knowing.
>>>
>>> The QEMU archs that defines a default machine usually defines it as the
>>> most used machine, e.g. PowerPC uses 'pseries' as default. So in theory
>>> we could change the default to the 'virt' machine, but that would make
>>> existing command lines that don't specify a machine option to act
>>> weird: they would silently use 'virt' instead of 'spike'.
>>>
>>> Being explicit in the command line is desirable when we have a handful
>>> of boards available, so remove the default machine setting from RISC-V
>>> and make it obligatory to specify the board.
>>>
>>> After this patch we'll throw an error if no machine is specified:
>>>
>>> $ ./build/qemu-system-riscv64 --nographic qemu-system-riscv64: No
>>> machine specified, and there is no default Use -machine help to list
>>> supported machines
>>>
>>> 'spike' users that aren't specifying their machines in the command line
>>> will be impacted and will need to add '-M spike' in their scripts.
>>>
>>> [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
>>>
>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>> ---
>>>    hw/riscv/spike.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>
>> I'm in favor of this change, which I believe is the correct way to
>> go, so:
> 
> Agreed
> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> but I'd rather we follow the deprecation process. Up to the maintainer.
> 
> I agree, it is a breaking change, it would be nice to go through the
> deprecation process in case people are expecting Spike to be the
> default.

I don't mind going through the deprecation process in this case since we're
not just eliminating a default value, we're removing it.

What about other default val related changes, e.g. do we have to go through\
the deprecation process to change the default CPU of a board? And yeah,
spoiler alert :D


Thanks,

Daniel

> 
> Alistair
> 
>>
>>
>>


