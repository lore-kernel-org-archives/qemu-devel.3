Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864F3E7FDDC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn11J-0004Uw-41; Mon, 02 Feb 2026 15:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn110-00046h-1T
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:59:24 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn10y-0003oo-Ao
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:59:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so47115395e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770065958; x=1770670758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d8z/6YfOQMfVZPds9k7vA/uKd1CPkoDSy0REQ0YVkHo=;
 b=PHsjp5shyXVgTKTUW/8eB7qNNyErLRNI4FrJcfbvHgxJg8WtjGQaBD/ZdDQkNWLHl0
 f+WlDjSlJgtSUqDN2zHHhpZKNM5dumjf5QwLMLDbRgjv+viehMOi9mAtk5i06LCdOfMd
 lmu1pnrTeKIzgQSNLv5DFTns8Cn+jXECVSEY4XOJTep4RRDRMLUygcubJJEOyLrWcgmH
 wOXhiFzSF+ulryP49e+U/dCHvJeXVlWrPCIFcyJCjLe3sSduJ/HHqAjpC2eFTUA3bNGO
 Q0ZnL4GhUtS/Djmq4pP2uDBvmK/ecs96Cst2rnuBQY0DbvGZTSDWpNpFS6ZEoQCCyII/
 dQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770065958; x=1770670758;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d8z/6YfOQMfVZPds9k7vA/uKd1CPkoDSy0REQ0YVkHo=;
 b=n4LXTyOCDUo99TcY+Csi7eOG+51vsJqXu+4sU688qWgTgnB2cvf8HAWjz3vA5mPGwu
 MMce5PXtph4tO9qwLlpLuRVncAlyDrOZBhbkBbIdljD4HyDEQJuRv01c7U8oIxqEuM80
 jfg4ukpbz0xqBkc8EpB1v5nHl21jvUXQLrtXeNb+kwpbGSe8xhnZ5Th2Tmc0+BNs7Kf0
 mF8h8y7c3GQrly2HABE0pOH3Xez0mb5sntzkw5Q43/NlwiencsEP4RsPmo7SpHQJqV/u
 CbZSICcVhr5tdYtaVXkZfRbXFarVxjj5R3utnOoT6nwhAfcNyHFma+qd1nAXz0fiYvQl
 iQoA==
X-Gm-Message-State: AOJu0Yx+O7J/EVF0+51BOArlhkYO9MipI4WhYdIeXMMHD0GYb5yKZolI
 0LgYSXWXDIcGcf74rteP3ODor2HSrsgx6SDXhvhltazO27TBHZbi/0hy41bh5qnD7HU=
X-Gm-Gg: AZuq6aLzXDl5YWgXogrtr+Af4hbSoOPYlot+5ESeMQO4EBNP5Y6C9rGfWEXFNdnzNjn
 i/UZARquE0F63B57iAsWVUK07jDbv1StUanHS/H2jPCoHQi31/IICi9VdWodgB63qT0mCaKMvrJ
 7U6rjehsLjw4oLSnyLqybnnVkxvnlXi4rHdeSS/u3DHcdSJtgcGliScPaOZLL5+O0WGo8aqmONp
 Qfd8G92z646ZnLODgXHrptcwIuRGnWIqLjTdkbsV5KLVSFNzuOlen6xyLL3yhlYZ0cvPqBdj3mo
 SyrpoRv9C3z17BZaQMvcx4tK6VJXBZ7Is+lzuPTgmNnjtwqFyUlbH3wmNBAXUD1XOudXKYEOiVA
 cdy21oabPqJjSkr7esQuqNnzUE8pJimcrWQ4S+E+5l3xMpcIkAV6NGMIihUHwT5WGUq7Vyig+TB
 OAEUerKLNIgpUoFnNetSBGCgJRYutjNU+HtgsXpJS8Q61+9R+lFJwx3g==
X-Received: by 2002:a05:600c:1c06:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-482db4d859amr172273405e9.21.1770065957860; 
 Mon, 02 Feb 2026 12:59:17 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511c049sm22744545e9.1.2026.02.02.12.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 12:59:17 -0800 (PST)
Message-ID: <1ee4374a-ca84-44ab-ada7-99782bd67442@linaro.org>
Date: Mon, 2 Feb 2026 21:59:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] target/ppc: Introduce ppc_code_endian() helper
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20260122221106.57184-1-philmd@linaro.org>
 <20260122221106.57184-7-philmd@linaro.org>
 <aYC1bfhw1CtIED8Y@hive.localdomain> <aYC28VNE0yNjlJw6@hive.localdomain>
 <041edfda-541f-4274-94ba-b7e6b64399ac@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <041edfda-541f-4274-94ba-b7e6b64399ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/2/26 18:56, Pierrick Bouvier wrote:
> On 2/2/26 6:39 AM, Anton Johansson wrote:
>> On 02/02/26, Anton Johansson wrote:
>>> On 22/01/26, Philippe Mathieu-Daudé wrote:
>>>> Introduce the ppc_code_endian() helper which returns the
>>>> MemOp endianness for the CODE path.
>>>>
>>>> Use it in need_byteswap(), removing one TARGET_BIG_ENDIAN.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   target/ppc/translate.c | 11 ++++++-----
>>>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>>> index 17e6d07c8c2..4a9199a4473 100644
>>>> --- a/target/ppc/translate.c
>>>> +++ b/target/ppc/translate.c
>>>> @@ -214,14 +214,15 @@ static inline bool is_ppe(const DisasContext 
>>>> *ctx)
>>>>       return !!(ctx->flags & POWERPC_FLAG_PPE42);
>>>>   }
>>>> +static inline MemOp ppc_code_endian(const DisasContext *ctx)
>>>> +{
>>>> +    return MO_BE ^ (ctx->le_mode * MO_BSWAP);
>>>> +}
>>>
>>> This was not super obvious to me, is this a common pattern?
>>
>> Ignore this comment, I see we do it for translator_ld*()!:)
> 
> I agree that even though it's used there, it's far from being obvious 
> when reading it :)

In order to clarify, I amended:

---
     Note, the target MemOp endianness can be evaluated as (see
     commit 5c43a750b67 "accel/tcg: Implement translator_ld*_end"):

         MO_TE ^ (do_swap * MO_BSWAP)

     For PPC we use the DisasContext::le_mode field to swap the
     default (big-endian) order, so to get the PPC MemOp endianness
     we can directly use:

         MO_BE ^ (ctx->le_mode * MO_BSWAP)
---

