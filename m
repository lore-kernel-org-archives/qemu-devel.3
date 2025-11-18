Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E8CEE349
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQZj-0001YR-6F; Tue, 18 Nov 2025 13:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQZd-0001XC-Sg
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:37:06 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQZb-0002Wi-4m
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:37:05 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so3322282f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763491020; x=1764095820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5nZ6PbcPVgM+2Ts7vehtNsbsk/ESLzXi7hzw3ZpWKBk=;
 b=hNvx3X+ReZUtTaH33H2EuDuUAu+ZaC691adOI1tqRGq0vIch8lkzd0ZXPsAE3jn96N
 BPHzo2YTiuLVVjmwGRAFG9Gle+5v5NiHmMkDtgWwyi8I1q6ASN9ICCBVZYJrO09Scev4
 NaPiNfzHJ+6w4m8nKeTzFsG/1FBt6ylUmsuO4UPZUnPpp3jhyGKJyUg+nU/bntT9a/QZ
 7S1GT7SUSYIQntwK8hgqiVYPB7vzSfBHmytZAfqvje/l4Y5kpaDJr3nqEgC3W4gcmBVf
 bLz9zIIw5JksnNctkSAyZwO1NJYxpLh0fZRp9bsRyFgkaCN2FFF0osh6vIngtyCzdXHU
 44rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763491020; x=1764095820;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5nZ6PbcPVgM+2Ts7vehtNsbsk/ESLzXi7hzw3ZpWKBk=;
 b=woIjxrM23Uozwp1D7ucQ/DcouF9XteW0O/RfrqIy8pTN8DTHho7UpPOSU2YHMhID9h
 VN71K5ywgEYUTHuZXYnIqDJ4aLGNqAV1grAv6aVm9eWcZHRdvYc1ecDbq6LkyNhjFk2L
 nSzwHmIm4Og0UbuUkj8Ku/ZeHRVc8LB5+PBUGHMTbctjxQudDulYLod9Cv60X1sm6/Qw
 XcynHOcFN1flMhgRT1h0AAr8t/K6WHm370r7FLHBXkbOpmbn8aJ99p2FwC8QVjQq6NhY
 bafxIiRxdKr2ucZSTh1qfB/Imp/TBeqbb4xbVA10j+axnmiBOKRuKoQogoaPcU+vrzIN
 sVng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRyCze2LLtItFVJO2mSoJ+Y8FdDotVB2ROcdWTkN0y03nVu2uXqU0n3MMpqA1YI/DxJ2VvvlKNedDk@nongnu.org
X-Gm-Message-State: AOJu0YzKN+Chm+EbLYUt2sSgGl0pgfMOsc3maUml4DomowUOKK99jhDp
 3r0SRHw7wfZAsQYuuxbkQf0mv/cvsSJQrIAssw6Ds6ywHXoYNxPG10P2fPWVGzKito8=
X-Gm-Gg: ASbGncuV/wBuJkcJ2T4+enE2FBToRcFmMWe7FCboMovv3WpzbgBVSq7xwQBT0N3otp8
 y5l++Hmm24BzJUXahRkKK3V5wvQqFiUFO6v0FceSxRwIdtmmK57HcIMw1mNS/DngLfcbduJXaW9
 Nw2yQU+xfxv9VO3MaT/PsZ+P0OF0ytCsRrrs9BCOE/mmSAaaV5Ne6CtRURhU5NvrVtJKBI2iD1Q
 pvHvsFUoR6vCaudBIfOhyrYh83ZLRI5ri/VXHd7eqv3Ky3tYUM8goK2cA08ZqNuqG7nwNbz1v6q
 QGS9Pxp4t95hs2EaAe6kIYPAqTsRPgopCCcwr20F3j8KbiD3M5Q+JtaueRO98K3WBFoK25a+ctm
 xU0zFCjJ2xLSSNaOFF5o1FXfBCKflKrjZjwnaoX/jVnTObNJQdUkXbdxnndB4ioFVCPc4/8DtU0
 aDa0ovlgASqQdCliox6fuZkfeApRZrvJrr8JVM/ISlDnzfTUzW/b7D59T/wka829qD
X-Google-Smtp-Source: AGHT+IHlnTBaYNXbM/rlZJZwc4XVkWw3cdqiudlEH7ZOceGLYneeRroVLUtI2mspQ+Pi1wzXAlmbpw==
X-Received: by 2002:a05:6000:613:b0:42b:40df:2337 with SMTP id
 ffacd0b85a97d-42b59373843mr15845122f8f.50.1763491020198; 
 Tue, 18 Nov 2025 10:37:00 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19aa0sm34087871f8f.37.2025.11.18.10.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:36:59 -0800 (PST)
Message-ID: <cfd9d2c0-9321-4709-931f-6befaafd6c36@linaro.org>
Date: Tue, 18 Nov 2025 19:36:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Avoid confusing address calculation in
 rpmb_calc_hmac
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-block@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>
References: <4f7e1952-ecbd-4484-b128-9d02de3a7935@siemens.com>
 <663acd8d-5c39-4f1c-b5b1-569e36e4ff95@linaro.org>
 <99d516b4-28f0-4605-8e14-fbf3d282890e@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <99d516b4-28f0-4605-8e14-fbf3d282890e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 17/11/25 07:09, Jan Kiszka wrote:
> On 16.11.25 18:43, Philippe Mathieu-Daudé wrote:
>> Hi Jan,
>>
>> On 14/11/25 22:27, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>>   From the source frame, we initially need to copy out all fields after
>>> data, thus starting from nonce on. Avoid expressing this indirectly by
>>> pointing to the end of the data field - which also raised the attention
>>> of Coverity (out-of-bound read /wrt data).
>>>
>>
>> Resolves: CID 1642869
>> Fixes: 3acf956ea1a ("hw/sd/sdcard: Handle RPMB MAC field")
>>
> 
> Feel free to add it. But not that it is not really a bug fix IMHO. It is
> a code clarification, output is identical.
> 
>>> Reported-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Tested, not causing any regression. Please check again if Coverity is
>>> happy as well. Thanks!
>>>
>>>    hw/sd/sd.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 9c86c016cc..7fdb9195e0 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const
>>> RPMBDataFrame *frame,
>>>              assert(RPMB_HASH_LEN <= sizeof(sd->data));
>>>    -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>>> data[RPMB_DATA_LEN],
>>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
>>> +               (uint8_t *)frame + offsetof(RPMBDataFrame, nonce),
>>>                   RPMB_HASH_LEN - RPMB_DATA_LEN);
>>
>> Having:
>>
>> #define RPMB_HASH_LEN       (RPMB_DATA_LEN + RPMB_NONCE_LEN)
>>
>> then
>>
>> RPMB_HASH_LEN - RPMB_DATA_LEN = RPMB_NONCE_LEN.
> 
> This is not correct: 284 - 256 != 16
> 
> We hash 284 bytes, that is everything from data field to the end of
> RPMBDataFrame.

Right. This is why I took so long time before starting to review your
previous series, I was looking for full-focused brain mode. Now than
I could focus again, this is now clear crystal. I'll just add a
"Hash everything from data field to the end of RPMBDataFrame" comment.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued!


