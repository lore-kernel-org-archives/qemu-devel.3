Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0701CC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 04:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSrgH-0004LT-FR; Wed, 24 Jan 2024 23:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrgA-0004KX-0h
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 23:49:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrg6-0007jt-Ty
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 23:49:28 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40ed1e78835so1094985e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 20:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706158164; x=1706762964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cLxTTOXo7xpLqBEJ9vWV9WSn92V3ukRQLKc/frP90ZI=;
 b=IqYjgj4LuNn0CucpfSk9Mv6KvwM/J7aRT52zZch9EIbuuoD++agX8+ZC6XZujJjvMS
 pXqAAO6IY7y5NQLW4TgbZSPA2pUm5OtIDiygY3N0l6J6Ehm02U8XUbNVkVsUJMvX1x4v
 tcqCqEr41eQ3yHZB2cxy0GuRpvgPRl5QZCBRtbflc2roLsHtLrNefgUSAlun5WPuyfsX
 7VdgV4HTmOdb2X5CE3/T0HXUjfOlUuWS79wM/xER4XnKtT/ic+T0xF+mqLm0LPscIlCt
 wx+jsYgFlVNTtvVBwYRP9C0g3SwXm6iLTqcebPDkE3y1JoLR6WyZYzxZNhyyfs0OjvGD
 H1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706158164; x=1706762964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLxTTOXo7xpLqBEJ9vWV9WSn92V3ukRQLKc/frP90ZI=;
 b=u+YuPx1heNOvKclmLeSjHXxOoVULtmar77jK8Wv2F4+DAnNT2zELz1ldPcgXPt9w6z
 H5TqdqyZHZ3WLbG4WIOZOq3idLijFIcnsTI0R+ILLC58H4GQbLKEG7cKcD9YXIqh0Lb3
 h7wzXGF4QgITgeg5KZPsITDgvl68x5L4Zd+ecEgKUHR8xe0oKdUGJo6k2xgKTiT8eob5
 rfQ1jij1YXjlNhHDUS5mvGtjejyBkxJKeOGkQhYgyfIbvwvOzFRr5zzmXyeb67FnAkJd
 KKlGgy3CX8n7FTZ49ASTn54gHhTgRSouuEAjyX2FowQLYsQ6TzIZI08oNNDTaZ9Sz8t3
 9BQg==
X-Gm-Message-State: AOJu0YxVlcjxp9fHEQ5mAF7ZzuChVIYfqphewJWeGYV/UMYq+KCbZTTH
 ZRf9SC2itPIFiVU7+TrxBcBq5RpLxEAZnQBW2UlQCcZgfUwfvUtskzG0YxCZOs0=
X-Google-Smtp-Source: AGHT+IEEWoSlodstLFMAyAhCCVAkJ9rWNQ4m94c1TeiEnN/JNR88UwNA5pbYRqfpR3P55fzwAQZTNA==
X-Received: by 2002:a05:600c:450:b0:40e:4d21:6729 with SMTP id
 s16-20020a05600c045000b0040e4d216729mr2142361wmb.71.1706158164462; 
 Wed, 24 Jan 2024 20:49:24 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 m5-20020a05600c4f4500b0040ec8330c8asm1076496wmq.39.2024.01.24.20.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 20:49:24 -0800 (PST)
Message-ID: <4bef6135-d1f2-4d91-8914-4b4debc30758@linaro.org>
Date: Thu, 25 Jan 2024 05:49:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/arm/vexpress: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-6-philmd@linaro.org>
 <264a79c2-7aad-468b-b53e-a269b524bb11@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <264a79c2-7aad-468b-b53e-a269b524bb11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 25/1/24 00:09, Richard Henderson wrote:
> On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
>> Restrict MachineClass::valid_cpu_types[] to the single
>> valid CPU types.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/vexpress.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
>> index f1b45245d5..a3561a1b56 100644
>> --- a/hw/arm/vexpress.c
>> +++ b/hw/arm/vexpress.c
>> @@ -783,22 +783,32 @@ static void vexpress_class_init(ObjectClass *oc, 
>> void *data)
>>   static void vexpress_a9_class_init(ObjectClass *oc, void *data)
>>   {
>> +    static const char * const valid_cpu_types[] = {
>> +        ARM_CPU_TYPE_NAME("cortex-a9"),
>> +        NULL
>> +    };
>>       MachineClass *mc = MACHINE_CLASS(oc);
>>       VexpressMachineClass *vmc = VEXPRESS_MACHINE_CLASS(oc);
>>       mc->desc = "ARM Versatile Express for Cortex-A9";
>>       mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
>> +    mc->valid_cpu_types = valid_cpu_types;
> 
> Repetition of the cpu type here.  Do you still need default_cpu_type?
> I didn't see it in the highbank patch, but it might have been outside 
> the patch context.
> 
> If it is needed, perhaps "default_cpu_type = valid_cpu_types[0]".

The plan is to eventually get there applying
https://lore.kernel.org/qemu-devel/20231116163726.28952-1-philmd@linaro.org/

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


