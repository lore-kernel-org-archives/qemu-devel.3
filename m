Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB60CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgze-0007oK-6o; Thu, 28 May 2026 16:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSgzS-0007im-Rq
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:06:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSgzN-0005dJ-9e
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:06:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4903974854dso65726015e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998755; x=1780603555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MfiIvzTFmrEkcL1uOiqJl4DJ3Tk+9nPLLzk58DgkAWc=;
 b=uQRpU+tvcbYEPqEz0y0VpigwMSOtlRR8ADYN+hDNkHsE9qdUn+9/nkgB4jXFr5a63F
 0g/4rnRJp0IAiOY3oV/MtcFHcrrrkCOGDnUwZjthDh1IPnyRxP1YL3iajWBkzN97t+tm
 Mq9wZN8jqWY8QL6fcgNSZ3vOZuLGvUZqBtU8Xg6YUaW84KtOryR0UgOjgnfLGnpdMj9M
 PaWcBVphjj4FwVoJqEz+Tnd5ew9GmCA43MahuArPAMsGHBE8SWUACx22jyrZlzXDQVXd
 aGN972jd+0VzzVBPOE/30i9xr8EeXPTr+Wg+XoqWgqcaji2W6PoAWLNb+bndGEfuVxFc
 j24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998755; x=1780603555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MfiIvzTFmrEkcL1uOiqJl4DJ3Tk+9nPLLzk58DgkAWc=;
 b=AyPP6IB4D7qfDQ8KRjYgxkwQ2kDgl+ghuq/5FArx4JPvbi5A+IDrUGriyBo5BaukZn
 1tH9Nmsq2xnOsY6JnLPDYHHlVlyghkUjP791DOXSI9+WBTgcIqbzYDSWXj6OPn/AnEnV
 vRT9A9wLnXO5aOgW1iOwFDyaxS/XKvKefdlGPpXGRGuU5Jxz2CYg2M9WHNkwWXkLRib4
 O61BdO2S3x4QxxnEbDF10JGZYcHDESmh/UBdN6fG6cIPxxsOb0c26WucSsKK6hP0yFh2
 StAm3/7rMucui4lMW//MwsV/aLgxIRmLZQHvXKsvBzkDRNtgUl/YBYZNZca271EpbRDK
 PH3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YrS+C3Nw4UuWUhZtwcnF2nDXjeP8ZsDIIA7XsK3NgzJskhSid64aj/gRhclx2bAgu6eWoQFd/NF2K@nongnu.org
X-Gm-Message-State: AOJu0Yw5q8QlkdLwqX6wMMMYVt1/sej/szwi2pRRf6rrfk7jJSli8ZDB
 oDeRlLy61ShH8cKDz5ZoEbZbcmQ+7Rt2FIiE1i97UIy6d+fGPtxuyUzyihqv2CadDJE=
X-Gm-Gg: Acq92OE8USnJZTihFpFgmdh0PU+b8ZdnJS12aVS4rb9L7uXFLwmWqg3zcYhUELWkPWB
 kRcxMHitKUVKxH4IGBK2xU/Xgb1ICoSvLr9FNu+zKxzGQ2ip70zIFqCWSYADf72Kf5/6JnUwuvY
 wMtwJpK41AHlmx2CCL7rUc+WsaU1Fe1ftlsMUXOJfAgF8uHtXk1SucsJrndY22KK4RRANIGSoxm
 CciCg/xSgDkotqiv6r+z8oPJ3M2zE08fI4Ac0Q1qmbh1o+bablwTMtv9lClf5y+eX/pqSG/AFZL
 Qork0Jp1gSzCQLoNpGyZdvDODlBh1j5KiWC1WZlrHju0J6tQOcZ7XTSZOsggyhJsEmGganFZg6y
 06Ck8cm/+WKUYcEDEVLqavjG2ebYatbYvVughWOOcsTXBEP8o65BYjm9T0vOolo2F204ogcMAdL
 JESQa0rMrb6cGtsU+1vkOa21t1Tru639oT76StdDsSl2/VURKM/tPK7XMNHoqBRvNJZm4JwJ9cF
 GoA
X-Received: by 2002:a7b:cb48:0:b0:490:51e2:bc86 with SMTP id
 5b1f17b1804b1-4909bfced80mr960615e9.23.1779998755230; 
 Thu, 28 May 2026 13:05:55 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909294cb81sm53562795e9.12.2026.05.28.13.05.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:05:53 -0700 (PDT)
Message-ID: <d363d6fd-4c6b-42f6-b7d3-fe43e5e7d64a@linaro.org>
Date: Thu, 28 May 2026 22:05:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] hw/riscv/boot: Replace cpu_to_le32() ->
 const_le32()
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Anton Johansson <anjo@rev.ng>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-9-philmd@linaro.org>
 <9d0853dd-5c22-4c46-9c42-a76d18230271@oss.qualcomm.com>
 <e636c43a-a613-4819-a272-61fef832627c@linaro.org>
 <595550a6-7efa-4e6b-b025-ae1253a029ed@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <595550a6-7efa-4e6b-b025-ae1253a029ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 28/5/26 22:01, Pierrick Bouvier wrote:
> On 5/28/2026 12:56 PM, Philippe Mathieu-Daudé wrote:
>> On 28/5/26 21:40, Pierrick Bouvier wrote:
>>> On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
>>>> Rather than adapting the array endianness when it it
>>>> filled, directly initialize the CODE words with the
>>>> correct endianness.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    hw/riscv/boot.c | 30 +++++++++++++-----------------
>>>>    1 file changed, 13 insertions(+), 17 deletions(-)
>>>>
>>>
>>> One could argue original version is more readable.
>>> Any specific reason for rewriting things this way (performance, personal
>>> preference, other)?
>>> Not a blocker, just want to understand the original motivation.
>>
>> Looking at the following changes, I think it makes more sense to
>> have the CODE section const little-endian, while the DATA section
>> is swapped. Otherwise we'd need 2 distinct loops.
>>
> 
> In this case, having two distinct arrays, and two distinct loops might
> be more clear IMHO.
> The function is called only once, we can afford this.

This was my first approach until I realized this array is
registered with rom_add_blob_fixed_as().

We could register 2 distincts arrays, mrom.reset.code and
mrom.reset.rodata. Now than the patch is written & reviewed,
it sure it is worth it.

