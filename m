Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87628C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 08:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1MH9-0001Rx-UU; Mon, 29 Apr 2024 04:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1MH1-0001RJ-Iy
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 04:22:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1MH0-0000Vy-2J
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 04:22:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41bab13ca4eso17239695e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714378924; x=1714983724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VRPEHFkrMLw3YjCU2xm/vJqxvftCfDxYd5rf7RnMQ/k=;
 b=S17Z2Yk9iRjLvkGODJ5Brn0zalOG0VA5MmEc8PoixETh5MRFUpZfyj0nMJLlqJnJ1S
 z3154+gDDzetEwS+pXx6IXXrDjznKYtkSS/I2ibVcdN1ZLsDBQRCrp8oSitGIkN3ib3t
 keMooXZvoNIK/vUw0bOj8JDsZ87rTezevIUFDA8PLTHi6UbN60lHGL3YQ8DTCPzWlpdJ
 RMmojLrPm6Fjq4QOj5/ifyniKZ5IYh9hTnjBqTFo2Y+me/kcTlaeaTLmCqwhE4obLhWw
 /29e0o8XptDC2GWserqIAv1GObna80WzpW8Qv+E306hvAC7ccqUsRAUjXGOS3IvXzACG
 cDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714378924; x=1714983724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VRPEHFkrMLw3YjCU2xm/vJqxvftCfDxYd5rf7RnMQ/k=;
 b=T7rAJqgKwz8Vye5E6MC/6fryFNubwC31fu7MFWlybKIf45mBwazMppbMOzPrTqPFQ6
 lGjVHXXwPwQ+sVXCZpVVypdl3mVaofi9LIcbFMTlcItc/zBzN4NMm0MXWQ4TrV1+svmn
 pNe1GB2Ubf/Rtw8EjdTDNeXVblFNxpQntCsqBjU+rInbfeQuHinLwhlzqWiuo3W6m7p6
 iK1inAj1mk+O9rbOAKD4Ak+vdq+iXz54FX4tnUMlRCRy0O3sFNgjeNhE7DFMHcMYBaOE
 ypu3mnxJvcuH443sWGZjC2nr3a0w/jGBEkEXuU1AlGFgj3eW7UD3tZrzgbW7p5FSpP/y
 DZ/Q==
X-Gm-Message-State: AOJu0YyjST63R2CuDGcGyh6XV3iaWS8PFITNK0/hyMy/TyBhglGQTZia
 d7m7sWZfpB9ruAAT0uqnflJ+ouPbUbqfrc5otiRp3CvbWzZee3gXRFMCmqhVAXI=
X-Google-Smtp-Source: AGHT+IHX6Duty0OqTUEhnM9I2sdbjattxMgQxe4MRY+UYbz4Q/evxIx4A5mQ6sOS0C9n4+s39GuuZg==
X-Received: by 2002:a05:600c:1f94:b0:41b:83bc:e9ba with SMTP id
 je20-20020a05600c1f9400b0041b83bce9bamr6836557wmb.23.1714378924535; 
 Mon, 29 Apr 2024 01:22:04 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 n4-20020a5d4844000000b00349f098f4a6sm28701253wrs.53.2024.04.29.01.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 01:22:04 -0700 (PDT)
Message-ID: <2a9141b0-3c67-4f88-a4bc-c35e810fd14c@linaro.org>
Date: Mon, 29 Apr 2024 10:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/38] accel/whpx: Use accel-specific per-vcpu @dirty field
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
References: <20240426194200.43723-1-philmd@linaro.org>
 <20240426194200.43723-21-philmd@linaro.org>
 <3835c44b-845e-4c4c-8207-ce46a31f70a0@t-online.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3835c44b-845e-4c4c-8207-ce46a31f70a0@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 28/4/24 22:12, Volker Rümelin wrote:
> Am 26.04.24 um 21:41 schrieb Philippe Mathieu-Daudé:
>> WHPX has a specific use of the CPUState::vcpu_dirty field
>> (CPUState::vcpu_dirty is not used by common code).
>> To make this field accel-specific, add and use a new
>> @dirty variable in the AccelCPUState structure.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20240424174506.326-2-philmd@linaro.org>
>> ---
>>   target/i386/whpx/whpx-all.c | 23 ++++++++++++-----------
>>   1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
>> index 31eec7048c..b08e644517 100644
>> --- a/target/i386/whpx/whpx-all.c
>> +++ b/target/i386/whpx/whpx-all.c
> 
>> @@ -2235,7 +2236,7 @@ int whpx_init_vcpu(CPUState *cpu)
>>       }
>>   
>>       vcpu->interruptable = true;
>> -    cpu->vcpu_dirty = true;
> 
> Hi Philippe,
> 
> cpu->accel is NULL here. You probably wanted to write
> 
> +    vcpu->dirty = true;
> 
> instead of
> 
> +    cpu->accel->dirty = true;
> 
> I think your patch for nvmm_init_vcpu() in target/i386/nvmm/nvmm-all.c
> has the same issue.

Doh, sorry I missed that :/

I'll post fixes, thanks Volker!

Phil.

