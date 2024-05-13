Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65077C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WTS-0007Vh-FP; Mon, 13 May 2024 10:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6WT5-0007Pe-9O
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:15:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6WT1-00088i-OL
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:15:55 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a5a4bc9578cso477805466b.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715609750; x=1716214550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rTvTBkMIQBnU7GJ9XbxgQs3dmakCpc+BNwsMq0h72Q0=;
 b=hNU2AI4vgmxANQpFZPttHDVMvSCfw0k2ekv8rnFLPUGfywyCXkcakkJMNaoBfLqbYu
 upkxPLN/lXsplQJyj6Rm3STwvPGbs69tdFDPUbWM57oh7JV/FVJgkcf937TBEFxF6alq
 5Iun340UA52VrJXn/04SvHrpmjFOxS1c+WgvAsxMJE8VfTA3mE6pF0k6bSNwmmtObwHW
 LtveGq/oFr7Cml1m+fNAjYR3+XeC5ar0u9PBaqKT7UqZl7Wja4ZYsaLZ0xv3zmJlWQu9
 N4aW4aK7CbfSW6mBoibHKZeJSD+GuRXosBqzypTxZPYMX6jr3VCb15wK7VMIbw1p/j2y
 Ewqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715609750; x=1716214550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTvTBkMIQBnU7GJ9XbxgQs3dmakCpc+BNwsMq0h72Q0=;
 b=A3W6HYDWvhuFlp+W29CwIA3GmmeXCVL4dBezsGrMlAwiVjlM7A4icCrNFdwU3PRmGA
 xPgY304TtRr5KxsBrwbp/De/0ZHwLxoUDE89WZp0E7jUZVso6T4FiB4VkcE0Gf//ubC0
 DkR9TL+sWxov4qJ9nyHVZIyNuGckZy7coLpdVuTh218xOmwZY3tQAxamBlMulyRYMVi5
 agpupyPCWobySOEcSBqlaygp8NW8OJf7MdRusXeoJ1itqPU6NEAW6D+siC5iUIvN41Jf
 K6M90fkQ2XOQau/lLa19QJPhClZf8Ub74bnVX/ZAYvHlI79tYzHBOKmar3xb9Vdg2Iy5
 Ouug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnlXReh9IZY7yQTWUiWfIAJ4bkcKsw0TFoefcV3U+65tDvI5xhSnEHk0502be5Ow+Hp+m488FKt7NiywxPEcdUcB5SWo8=
X-Gm-Message-State: AOJu0Ywg0AnkR2kWay2A2bgWF/MZIZ/xu+xntKpvn+iygHSuBrxMtTBE
 jTbSw36z3Dzqu3K8hO9/WojnzOmHX5YPGGKShcFD4oYiYUeqvrVmEKyI2yK4m0g=
X-Google-Smtp-Source: AGHT+IELm5eYpMwjvZBCBxOOeSERaH9FiXK4wo+XRcY1V2Lk6qMNF9VdwPEpFtQws+1Yexy94mPang==
X-Received: by 2002:a50:8714:0:b0:572:a073:a39a with SMTP id
 4fb4d7f45d1cf-5734d5c1651mr10021782a12.5.1715609749868; 
 Mon, 13 May 2024 07:15:49 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bebb660sm6421851a12.36.2024.05.13.07.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:15:49 -0700 (PDT)
Message-ID: <352be157-1b7d-42d0-b3ed-be3f933ae2eb@linaro.org>
Date: Mon, 13 May 2024 16:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/45] target/hppa: Use umax in do_ibranch_priv
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-16-richard.henderson@linaro.org>
 <c9942efa-4f3c-46b0-b29d-9e4107314c58@linaro.org>
 <15733f35-f65a-4af3-9007-7a4e9e4b660f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <15733f35-f65a-4af3-9007-7a4e9e4b660f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 13/5/24 15:23, Richard Henderson wrote:
> On 5/13/24 13:18, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 13/5/24 09:46, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/hppa/translate.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>>> index ae66068123..22935f4645 100644
>>> --- a/target/hppa/translate.c
>>> +++ b/target/hppa/translate.c
>>> @@ -1981,7 +1981,7 @@ static TCGv_i64 do_ibranch_priv(DisasContext 
>>> *ctx, TCGv_i64 offset)
>>>           dest = tcg_temp_new_i64();
>>>           tcg_gen_andi_i64(dest, offset, -4);
>>>           tcg_gen_ori_i64(dest, dest, ctx->privilege);
>>> -        tcg_gen_movcond_i64(TCG_COND_GTU, dest, dest, offset, dest, 
>>> offset);
>>> +        tcg_gen_umax_i64(dest, dest, offset);
>>
>> Isn't tcg_gen_umax_i64(dest, dest, offset) equal to:
>>
>>      tcg_gen_movcond_i64(TCG_COND_GEU, dest, dest, offset, dest, offset);
>>
>> ?
> 
> Yes, but I think it is clearer to use max.

OK, maybe mention it in commit description to clear doubts?

> At some point we might add min/max opcodes to tcg too.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



