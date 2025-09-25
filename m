Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2930CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1mC7-0000We-0O; Thu, 25 Sep 2025 09:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1mC2-0000WV-VV
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:39:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1mBX-0006e8-8B
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:39:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so987129f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758807532; x=1759412332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vi3btviByP1U0LeZRfIyH6I9UfgY4+Q5pMw1i3ywzBI=;
 b=yxsdanAsDgzQoY2bh2Kte2ODA7SBQYK85XGTZ37ITILUXvY9y4zSKTBc17TtuSgQA0
 1J/2kjbY97/OyJ/lKvV5TXNUIrBec9ZKT2tLbeJRs2c1KZeNzaAzRo+JjrmCcUG6b7Mw
 ubfo0d4Sdb7NqVMlilqKan03MV32CdDeOZDeDwvCbJoHqiLGrJuhALPt0bypfrHr2o3M
 EekzSm3EUN38jHQ4cMeLHAhqUx/bRTvsbW24kJoGWMgwtkOApVC7v0mWnnxJV7zHa0s1
 c7EaulpUre3xTZe8hJ97ATZhNHiOIrw22lRuaHAWtVBfafIP6dsbltjjCW//jUpOkmLr
 eFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758807532; x=1759412332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vi3btviByP1U0LeZRfIyH6I9UfgY4+Q5pMw1i3ywzBI=;
 b=GLVixLZ3ZFiGH0Ab/lmrtekG6FhjFcVFv35x2zQqoxDomcHg5O+HPhZj3wA5GmxL2Q
 VHq2UFTjtryZ/v/RePc6OFpCWAdAQYTxLkA9InadPNUp8Z+CTyD2kMqbw965st63EgAR
 GwJVECqt7luOHT7pM+Ci4yw12utijAGRDFV3DJdm/bssCV+qiMrsBGrbFBzXxr+ZhmEm
 iuctWg+N7rS8a5+ChXD0FJDo1gh0A9OmGmJ08pAa9lKxeD3Sb+JkwNOzEsrJY/sWEZy9
 T0l+VNnZKS2BkvkaD+PN5tDWfzZ5xJPvDgEeEd/UJVbkRR6LLUg+ubYQ+U6KX0ndHx0N
 OsGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcZ85q7v0EBA/5C7s77xLxRdVEcdJ56cRrAXQ8chpkWm5gkeKsNmQSYHVVtU3n1lO5wOeRwyuU5pku@nongnu.org
X-Gm-Message-State: AOJu0YyFaii9arJpNy7H4kK4GTSycZBFp3tYaJMdaUUxx5gP42vu2ZMK
 Y2s6W0mLYtCM0zIh0UMItwzVTuV5b6s1dU4+jrBht5MP0knes/ArnHciik+ov/nn+uQ=
X-Gm-Gg: ASbGncuWAT5jOrdAPS3pTZUrU6o/LX4dRawxZ3JodBOfHuSRe9jcWnUMxoKy0lXMs9z
 gfr6zlNuTc6CeUWSGmiyM7uW0BkOTyU2bGqMReZ8X7y4VXbuzPpcOy9whNu9ph36mjWD1YZKlRS
 2zM6lmqGrFrfO0wHONcAIdu9MG/jNqtPx51WXMqRDIZ/AFTFHJ+0llVxtLq5oVH/8JzGUEaioE/
 8ipf4juuKXn1iHoJzJhjhaFDsUrBMQEGRllgO18YUBaG+kpv8XDm2tGNqnwVGYwmwfPKM1uNYZu
 EZ6l6DFwtbP/7PHvJDhYGqTwTu7a2aKaxwaAG1Qs8sxDcO4ek516kRGPZQ4PQ+702kN7nKvFfci
 LCFrG55fTXOfbFjUr7CckrpFAYrYhCepnO2fn2nfkMgvwy9pXXdlivaoa5ZmjZWYK+Q==
X-Google-Smtp-Source: AGHT+IFT7Bkk5TyHeqV0VGcIjfmu5TLrQ2dcF/qEr88uXczSCogaeN/eJzn21OXTJTLyCWZTvZPSHQ==
X-Received: by 2002:a05:6000:24c6:b0:3ec:1b42:1f8d with SMTP id
 ffacd0b85a97d-40e468e7444mr3701730f8f.10.1758807531984; 
 Thu, 25 Sep 2025 06:38:51 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab48c28sm77317325e9.18.2025.09.25.06.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 06:38:51 -0700 (PDT)
Message-ID: <d0e0dccf-3975-4c71-9de7-803439fd6f76@linaro.org>
Date: Thu, 25 Sep 2025 15:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/36] target/arm/hvf: Sort the cpreg_indexes array
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-9-richard.henderson@linaro.org>
 <59ae43f2-d392-4582-96dc-8465bf893bb1@linaro.org>
 <CAFEAcA9QSfz=JaDhLyf0v6ttCGX3fsy6U1tJMV4hqHRfZSitDg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9QSfz=JaDhLyf0v6ttCGX3fsy6U1tJMV4hqHRfZSitDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 25/9/25 15:23, Peter Maydell wrote:
> On Thu, 25 Sept 2025 at 11:33, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 16/9/25 16:22, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    target/arm/hvf/hvf.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>>> index b043eac8c6..99d8672b9b 100644
>>> --- a/target/arm/hvf/hvf.c
>>> +++ b/target/arm/hvf/hvf.c
>>> @@ -925,6 +925,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>>        arm_cpu->cpreg_array_len = sregs_cnt;
>>>        arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
>>>
>>> +    /* cpreg tuples must be in strictly ascending order */
>>
>> I don't get the "why". If this is related to a previous change,
>> maybe better to squash there?
> 
> It's a requirement on the cpreg list data structure;
> compare kvm_arm_init_cpreg_list()'s comment
>      /* Sort the list we get back from the kernel, since cpreg_tuples
>       * must be in strictly ascending order.
>       */
> and the one in init_cpreg_list():
>      /*
>       * Initialise the cpreg_tuples[] array based on the cp_regs hash.
>       * Note that we require cpreg_tuples[] to be sorted by key ID.
>       */
> 
> The underlying reason for this is the algorithm we use
> for incoming migration in cpu_post_load(), where we
> iterate through the incoming-data list and the one
> we have on the destination comparing indexes. This
> only works if the list is in order so that we can
> easily identify "register in our list but not theirs"
> and "register in their list but not ours" by comparing
> the next value in the index lists.

Thank you, this is very clear now. Could we centralize this knowledge
as a docstring comment in ARMCPU::cpreg_indexes? (This is where I
naturally looked, trying to understand).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


