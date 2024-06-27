Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A0CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiTb-0003D6-IS; Thu, 27 Jun 2024 02:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiTR-0003AS-Ss
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:19:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiTO-0000Dd-BQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:19:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-424ad991c1cso18290405e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719469148; x=1720073948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sg3SGiLRMd/3ulstLZfZlfyLTKREodq4xWSHLAeW5DU=;
 b=cYxyh4zAV8cBd8LmyynKNKF8Cd03kCB4UiWkUPHdfCd8lCZ+GwFBjhIPXDBm4dseET
 enQC2y23Cm+3YOWCzI0xky2xCaQYVpihtFRpeXy0NEhK0JP74jbkrUFOEtqMIjA/ZcBs
 Kv67VO+SxagNo9r0yRIS9GwZTCzXm89Xz6if4Lzqgp96RXbJWF9yO3z5prSipFMxE/xV
 cfVbe6rhL1NHQYiPTQSIX9pUlSUx2TFfyOpPdHGz0MH1t5OE7JQ4inmVFoy9TGIMGqFY
 GhYcrrpGL1hXFXtF719hYvjuGAXxJeA25qy9ecuH009Drmu+DxjQIMHsbg80wLr//kXV
 bZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719469148; x=1720073948;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sg3SGiLRMd/3ulstLZfZlfyLTKREodq4xWSHLAeW5DU=;
 b=V2fkyi5uEYthYJ0gKtmYAvLAwAuHprszDsayiPNK3B1bg4AwEtcD+KWmseu99vB9XK
 drzuZfkwE8MlxREremC5Pl8IyybHLQVQc7lNBh0gMUgMv3BFopnE5I3gk5cEhMdeiUpx
 YRsvhlXgdw2aSg3GcUWD8EwwwFu2NLp3oiL0TJqiMvtfBjkjyH2Qussb8Ra35z4+/Tt+
 IW0WHUEQ+s46cdSTbd5URswoH5jbbaXF+3/qTjtaeqfI6UmBpCQTXXAFp+2rboFwWIfs
 HMDtUs0PezDOHyohQ+Z84y/lzfzv0gOitDfLT6Fa1vkKm78AiiFV+G8vlcSejOfy3JFw
 i2Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5VXadQmHTIxsGPf9JUaMTNXDLyA5foEEIruiyXUt7QyED6s/39zp1OK8jy4VPtmcHTbJkEqxOxs3BzR+WezLMnrJ+2+c=
X-Gm-Message-State: AOJu0YzD1Jv3qjgkyavONa83tKlnNnUW9FJpS2P6eG/JRb9dfd3M3oS0
 SY4xRwV+7kJVYb7IlYpTr7o+Sf2sVkWTNSv2aWVLuXOmPd2FkTrXJrjdO0YYZEk=
X-Google-Smtp-Source: AGHT+IGwPWrhE8KoH8jM9KLamO7evBPLYNF4zlXWjQhPIvJZvJHUyL6Mk9LaGhPUZ69ST7l3IIqdcw==
X-Received: by 2002:a05:600c:5713:b0:421:29cd:5c95 with SMTP id
 5b1f17b1804b1-4248cc27143mr106487275e9.10.1719469148228; 
 Wed, 26 Jun 2024 23:19:08 -0700 (PDT)
Received: from [192.168.236.175] (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8475aacsm49351965e9.47.2024.06.26.23.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:19:07 -0700 (PDT)
Message-ID: <9100e0c1-ad15-418f-8979-912386f6324e@linaro.org>
Date: Thu, 27 Jun 2024 08:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-8-gustavo.romero@linaro.org>
 <e0412202-3dd3-465d-8ed9-37ea9af1751b@linaro.org>
Content-Language: en-US
In-Reply-To: <e0412202-3dd3-465d-8ed9-37ea9af1751b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 27/6/24 08:10, Philippe Mathieu-Daudé wrote:
> On 27/6/24 06:13, Gustavo Romero wrote:
>> Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
>> are not confined to use only in gdbstub.c.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   gdbstub/internals.h        | 2 --
>>   include/exec/gdbstub.h     | 5 +++++
>>   include/gdbstub/commands.h | 6 ++++++
>>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> 
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index 1bd2c4ec2a..77e5ec9a5b 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -135,4 +135,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
>>   /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
>>   extern const GDBFeature gdb_static_features[];
>> +/**
>> + * Return the first attached CPU
>> + */
>> +CPUState *gdb_first_attached_cpu(void);
> 
> Alex, it seems dubious to expose the API like that.
> 
> IMHO GdbCmdHandler should take a GDBRegisterState argument,
> then this would become:
> 
>    CPUState *gdb_first_attached_cpu(GDBRegisterState *s);

(With GDBRegisterState typedef being forward-declared).

That said, this can be done as another series on top...

