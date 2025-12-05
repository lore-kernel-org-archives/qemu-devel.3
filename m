Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C744ED33992
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYne-0003RA-Po; Fri, 05 Dec 2025 11:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRYnO-0003Pq-JX
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:36:40 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRYnM-0004w1-65
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:36:38 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42e2e167067so1142566f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952593; x=1765557393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nNrVVxuqLD2ZH0lRFR99zmMqv11cti3eofwvXq+Pltg=;
 b=iwZdv4E1/jJIcSKHiD2rMPQLcElZ6NDL5EuxjDkzZt8WdVdoKEVTguOsV5RYC/iIbW
 dC/TtfbDQPK+wNOOduXy9yI8pXVDm5lTGPxf6U7azscIOj+2bU8L/GdBXtveFhou210M
 GjVxsjIcZtQ5971cfhF5MZ6xH377yqA5Cy+deTLcAfEif7HSxb+NaMXuBZmNUb/8VPFd
 lhAtyE+tfRhUcTGN/jDlQqAM3q+kiO+NsiwX0ma2ZhqeYRBzgtuY9Ty7Sf5FYwLP2Kx4
 AW7kvpFwsilBNckYDBSTpjBOcDZotF0qLSfQDGVpGvP3GgxuoM08Nq4csCXoKEoBKRYC
 WJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952593; x=1765557393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNrVVxuqLD2ZH0lRFR99zmMqv11cti3eofwvXq+Pltg=;
 b=o6cXzAy+Zsmx2y5cgVTQHJP3k4fD5yid3s/claeqqrQmbToMb10WER8seRnsMc6xPk
 Tvd6bufPXDQRk1birI6rWsWVp1KkiUPfDkBNxKKWZpjWWvJk9ZHrFUo/7JMfamjxwgDw
 joFiehCfnaeKMA7kfiS3IYrfxftsVamQ50z1oI+rH1sI4vumqQSFv1kvfPD8Ri7DJ4wI
 iMdewE6yKiSaxTGoKgAHfLI/uiP3OXTdvLAEPgIgZB1eJNz8Kawjze7o98FJq9ebgmdz
 fTfZbRt4H28ZIqa6PDkJQzGDw2gd9+ztZzB6XEqiIzFVsgawmAxgpjGr1CWeg12EsSvA
 EAxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCcy94cIt4UY5b+wTe0gxEU/SvnP164ekEqGY7LPNwpRx3RvCOumCceJcP17GeGl/WchOHAa5mSEYT@nongnu.org
X-Gm-Message-State: AOJu0YzdYFmQCBfhKr0Sx95q+LLOkF0VZP+eM2MB6K9hAjZc6utknN9s
 GBnHgahApIwUQT2lonix0I7e1ganR+Dx3NdzRliVyL5IPDJy/kYmZNvM5+NdVDyl/Nw=
X-Gm-Gg: ASbGncuXHl6UUeO8dw0B4NJkONERXYYdAA97zm9ARMjz1YX393HRC79xjKvaDHkTveY
 Xmu1TRC1xDip+QVb3ffusL3kwuEbUzAsryiC0LwMojbmpzui8HoLJx9HMg+DntlGQv04dy27dnB
 KKIgXXOxtZ+wFyBB8LPOANamDx36Nuf7dqnN3imqDyoJzR1WO4wVcvaNGiFejjHfW1XK/zn5Hu6
 f/+9dSEkL+Z+2uwRbVpe8NIHhnXkpwekKlrcULkG1/RqjTtqSlIn1TVa0+jr71WIQPmeoaCXint
 3QjhyDcVdHSS9SKJU0/cYkSEEFlY/DDQ/RQgwQeOHvMWe/gW3zEb0wd/gPXSCu+ulDy9omcb+Er
 ik4wDYAGRgWznhQbjRuCynRCN/g8TsEwgqRX9zGoqFKDeF+yqfGX4re1au4dqIfWr1uUK0+lhm4
 Y9GaEWD5nTtNYR1QzoR1RVytf/DwXJn8h+ojZWXKQn3LVt5qNrjUDpqQ==
X-Google-Smtp-Source: AGHT+IE6XY2f5yaIA4IfMsn0jgYcJpCzUvOso+NEwCpSfCozUr5I8FcmfskQwsOU4jHfBtAaGaC61w==
X-Received: by 2002:a5d:5f47:0:b0:42b:2c53:3aba with SMTP id
 ffacd0b85a97d-42f73174420mr11701767f8f.10.1764952592913; 
 Fri, 05 Dec 2025 08:36:32 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:901:1329:d82a:8818?
 ([2a10:d582:31e:0:901:1329:d82a:8818])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222478sm9481624f8f.20.2025.12.05.08.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 08:36:32 -0800 (PST)
Message-ID: <e51b8d31-9f13-488f-9021-cdcf3f662e6b@linaro.org>
Date: Fri, 5 Dec 2025 16:36:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma/omap_dma.c: Use 64 bit maths for
 omap_dma_transfer_setup
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20251204193311.1281133-1-jim.macarthur@linaro.org>
 <87qztarkyf.fsf@draig.linaro.org>
 <a605c0b2-8122-424c-a917-7d6ad8371c34@linaro.org>
 <364a1c91-c7a0-41b1-8ae9-902b3158914c@linaro.org>
 <CAFEAcA8rj4oFV57QSiMmtz4WF8zRu04O6nF0auZv8m4tLiATyg@mail.gmail.com>
Content-Language: en-US
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <CAFEAcA8rj4oFV57QSiMmtz4WF8zRu04O6nF0auZv8m4tLiATyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x436.google.com
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

On 12/5/25 16:20, Peter Maydell wrote:
> On Fri, 5 Dec 2025 at 16:11, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>>
>> On 12/5/25 15:57, Philippe Mathieu-Daudé wrote:
>>> On 4/12/25 22:33, Alex Bennée wrote:
>>>> Jim MacArthur <jim.macarthur@linaro.org> writes:
>>>>
>>>>> If both frame and element count are 65535, which appears valid from my
>>>>> reading of the OMAP5912 documentation, then some of the calculations
>>>>> will overflow the 32-bit signed integer range and produce a negative
>>>>> min_elems value.
>>>>>
>>>>> Raised by #3204 (https://gitlab.com/qemu-project/qemu/-/issues/3204).
>>>>>
>>>> nit:
>>>>
>>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3204
>>> Format is:
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3204
>>> Fixes: afbb5194d43 ("Handle on-chip DMA controllers in one place")
>>>
>> I'm unclear on whether this actually resolves or fixes the issue, so I
>> just said 'Raised by'. The bug only includes a test case, not a text
>> description of the problem. The test case will give a different error if
>> this patch is applied, but still doesn't pass. I've mentioned this on
>> the bug page.
> Generally for this kind of fuzzer-generated bug report, the
> bug is "it is possible to make QEMU assert/crash/etc". They
> don't come with textual analysis of why exactly we ended up
> crashing, because the crash was auto-generated. So the
> "what actually happened here" is one of the things you have
> to figure out as part of fixing the bug.

By that criterion, this patch doesn't fix the bug as it will still throw 
a different address sanitizer error. The test case identified at least 
two problems, one of which is fixed by this patch (when I address your 
comments about u64/u32 math) and the other which I haven't figured out 
how to address yet. I can leave this without the Resolves: tag, or add 
an extra issue to Gitlab with the specific problem, or we can leave it 
until we have a patch for the other problems.

Jim


