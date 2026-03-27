Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F5A10F2862
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6BlI-0007jM-8P; Fri, 27 Mar 2026 14:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6Bl6-0007gt-OS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:18:16 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6Bl0-0004Ju-4x
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:18:11 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso1069743a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774635484; x=1775240284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DI62CKUeerbl7nsL7wtkGEa0ArXEH8fdjMwvOc+cnCQ=;
 b=Rh41D363M5Bz8SPmu7ow2gsoid2O/yB6JZgC0hQsR3Dw/Q6Zi/KcEuC8OkaW0A+sR5
 6P2+/WT7udf+on280MB6ynacIcE6N/uOpwSFwTJ89UpHAJTy4svckvm0hDx4x+0e42mA
 UEfk3A1hidZKkzYTm/lyh1aU59fiwQdBwW2ZHTsx1uQCdxweMejmcbDv4lDR/hXvGWbY
 XIKyk1VmUcJ8TPwO9U8T4ejNah6YuKEs9ukY1nCwV+zkhtcMo+D+/LOKzVedJTut6udq
 SQHFHmCZkz3dyG1q9xrTb6appo2UIcHsFKfYgBM/s44RHXZQbmC5GrI0gfuyt/eTfjj0
 k+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774635484; x=1775240284;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DI62CKUeerbl7nsL7wtkGEa0ArXEH8fdjMwvOc+cnCQ=;
 b=fxkyqUfHT3dBUjt8wbi08SoC2/Upn51RFrAJzMCydlcxuG2invvwblPtYBF0cBQdFx
 n7e6E+0X241eydy29ezVGGql0SAFeRUjOLWdGIKuFmRxzUnVNnUULwNCJKALbFB8w6Oq
 GJw4LbGIxmfqmmenVwg42Ab6in5Saql2EIRuQyAuM9C+j/a4PR6U4YCnZNE6qTBX5aYK
 ayEJbd3GLdMDNSBtv3W+7yOshnyBPT2MYEfaBt91+7a9xkq+oLshGpTWKFda0CfJUH6Q
 25DpuId1fjO7cOqjJ/szj5aDact0IED7PfuuQpIo9lINGAZZJul+7Y+YbL5CgaCk/0Zy
 PBnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbI/QZXTs2ty75E6jY9nzyKFCrXN90x28VmzjdJoJsUjVa4Kkgdf0SI7Kg/3FLQaCk7hEdthMvnI4k@nongnu.org
X-Gm-Message-State: AOJu0YwBKJ6bikWAGBBzezuVU0WbDCy9qnNg0ph31gVKmaeO2kr8nwwb
 BqC7oWAIMIFAsG4JvuJX+yBnH+5f52yjsPMjuT9h5igNUQ4Z9mkgl+3WRPq30Gyoehg=
X-Gm-Gg: ATEYQzxA0wmvuPWRqOl2ubXdCuHMvHUFzKwej+VPeNhh84HEzxXnTCtXsTDkhle2wHD
 YepXPAtM2r5JtnZ21kBu9x9MKeAjCCXUcLggesnECO8YsNoskz5+jk4PiN33qvGdeEiOV80h20X
 fVCz/dj4cxUG5EbH/uEsJcHCNcqDQ7nkQGctEPioPPvIHhNes5UCr037Tdqco85eyEQ6+DxWT9U
 YkQw02RDz1d/GHoBdXHOLzVQgSiLnhWoDkU2PL4xID184O1GlfM4wW2ysPqbdYm31pkVexZBBs+
 bHjMn6UDQWKAtRXRut4MmeRNhWHg4IccbGkWMIomyGGlIdHJ7x20DV1jJBIMCK/iFFx+FPoFzN/
 yd5v1OxWz8QMURbZbljdr+BO5z157WMroifSFW9gg++R5ZSkZXWUbQEahHZi3SxSUN4r9K2PeUW
 S0qlDW/nu32G92yu4Y38PDbxzQsh0DqDImskZx1BJH4yrXIdTNdCUTNtihiIRdiiI98QIE
X-Received: by 2002:a05:6a20:3c8e:b0:398:ae03:722f with SMTP id
 adf61e73a8af0-39c87bcf187mr3867245637.45.1774635484042; 
 Fri, 27 Mar 2026 11:18:04 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767382c2a6sm5229292a12.12.2026.03.27.11.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 11:18:03 -0700 (PDT)
Message-ID: <88a91611-2d27-4c6d-bcad-09ff32f71d97@linaro.org>
Date: Fri, 27 Mar 2026 11:18:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] plugins: Introduce Fault Injection framework and
 API extensions
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
 <4e8f4e6e-e9d2-4457-af3d-755ced6d2a45@linaro.org>
 <CAN-aV1FER7w1rqw0zM=L2z7MT_RKsBhFg7m6NijxyQa6t5JNqw@mail.gmail.com>
 <4d2d16df-0047-4b96-8312-46489ba0f1bf@linaro.org>
 <CAN-aV1F6O3dv5F1946wEugdLxkYDp0BW6QZPxwye02A5-HYz9g@mail.gmail.com>
 <79fca2cf-7618-4a35-a915-e2bf1811a851@linaro.org>
 <CAN-aV1HRZPxuS_U4mHYhnobbKkq2G5T9P2cJ2=LahT3TzGsC6A@mail.gmail.com>
 <005aa40d-4749-44d5-a65c-8f59cbd06d0c@linaro.org>
 <87a4vu3jcn.fsf@draig.linaro.org>
 <ebb0227f-87c1-4436-b48b-10f5dc150884@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <ebb0227f-87c1-4436-b48b-10f5dc150884@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 3/26/26 8:59 AM, Pierrick Bouvier wrote:
>>> One thing that could be considered on API side is to add a possibility
>>> to invalidate a specific hardware address (not all tb), based on
>>> tb_invalidate_phys_range. The problem is that plugin now need to keep
>>> track of all physical addresses matching virtual ones you want to
>>> invalidate, which is not convenient.
>>>
>>> Else, the easiest way to solve all this is to expose tb_flush, like
>>> you did, but keep this patch downstream for now.
>>> If your final plugin will stay downstream (which I expect, given it
>>> has its own protocol for injecting faults and no source for it), it's
>>> really the cheapest solution.
>>>
>>> The current design is built around the assumption that instrumentation
>>> is made at translation time (and not later). So changing it by
>>> instrumenting after translation brings new constraints we can't solve
>>> at the moment without exposing internal details.
>>
>> We should certainly consider automatically triggering tb_flush() on each
>> qemu_plugin_register_vcpu_tb_trans_cb() so at least the case of
>> dynamically loading a plugin doesn't miss previous translations.
>>
> 
> Sounds fair yes, but not sure it covers the current use case.
> It would require the plugin to register several tb_trans to achieve the
> desired effect, which I'm not sure is a good idea. At this point, maybe
> we just accept to expose tb_flush through plugin API and call it a day.
>

@Ruslan:

After looking at it again, this is already covered with:
```
void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
```

which performs a tb_flush as expected, and calls cb once the reset is 
asynchronously done.
In the callback cb, you can reinstall your trans_cb, and it should do 
exactly what you expect.


