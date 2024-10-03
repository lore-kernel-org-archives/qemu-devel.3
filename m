Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AE4CF34D2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUkf-0007p6-UO; Thu, 03 Oct 2024 18:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUkf-0007ow-AN
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:56:53 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUkd-0001bz-PR
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:56:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so969752a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727996210; x=1728601010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=44MDUSsIuFlTp+oQ7wauFdtdbGp4y9raSKV2dwHi4lA=;
 b=sm215yeY4gsKfLqKHyYtX7iVRUGIGgYeY19uDqOqTAQBWjBngBmar2gQ+7BuOVqlUz
 PB/3GHX+BdvwxXan7onL3+FALJCVrKAAINP3AwsclAn+TwYpKsbQtZhRhjX4i57YOWly
 hqHCwHXftC2COzgKNeOC6W4a73TZStivNvFx/5PwY03nqeSa0AoTWwFZKlzj3ePCfZgF
 2fihHpO8qHHAkPU8VE/sNVCBl+5lNd7WMnfSUbMaJgvKoDnJz3JgIVYEQmrDC+mw7ezO
 IxB+BDxX1nNZBt4xLd9bZcUpE0waFhfTbi1Qor1L2+awJj1QNmHUrb+a0SxHOEjFbXbt
 u3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727996210; x=1728601010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=44MDUSsIuFlTp+oQ7wauFdtdbGp4y9raSKV2dwHi4lA=;
 b=nwu8xD2nhvKT6tPlKgvErE8sbWbNRSdNx/uaLjsouMzA9qi5gG0LKeRg2v/GDaqaxf
 gUWXHokXIxhXDiyDSGUUNLmSb2YIkj36kciq0r7ZtzHnig1IlpcIveHGTERoRN8o1upp
 TOecLJAR/mNWwmAQWu7qvM2EVTL3qzPru4zgq/3NgnzKUolsx+2fR+Ih2+fteM2KG9a+
 WXUDCFsz2st3YGEUAtjsbQ6oPXdDXb1EeO8TjdtUXaHgYuFU+7d+b/uePj7io235oiH2
 OwRCnBJeu9gL7g0pO12Bv0ifxKCVTprIZRmPtISpVXBNaM5W4nqjzHJUsvH5UlA2IpNX
 kGlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIqfkQISCDin4hCHMjWBvUWVlaXRwbLBptd3QEMtl18gg3YEg57Ksejv8J1ljM1aWMBpX9sH7JDt51@nongnu.org
X-Gm-Message-State: AOJu0YwA7rPk9bcix9jBJWZ/jGjLwhjR/1jvsQPcy7qFdXTH+d3eYPeM
 hkCPeEpSMUzXDh5kBBtRQMRXwISu0OzbS1xtvZAldTEBPE1Rhm7fPiG7gyW++1c=
X-Google-Smtp-Source: AGHT+IEQ2ZDLJ/UtSZZZ1UUHdDrlVqU32lgfyBJl78E1dgiVRocvNTbGQnJ+9ovH2/g7VKIfLIpKQA==
X-Received: by 2002:a05:6a20:e615:b0:1d5:1252:ebde with SMTP id
 adf61e73a8af0-1d6dfa3a7a8mr1329721637.12.1727996210397; 
 Thu, 03 Oct 2024 15:56:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9ddb51csm1926133b3a.113.2024.10.03.15.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:56:49 -0700 (PDT)
Message-ID: <6413cf66-c1e6-4754-a26b-2467999c699e@linaro.org>
Date: Thu, 3 Oct 2024 15:56:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] target/mips: Introduce mo_endian() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
References: <20240930091101.40591-1-philmd@linaro.org>
 <20240930091101.40591-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930091101.40591-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 9/30/24 02:10, Philippe Mathieu-Daudé wrote:
> Introduce mo_endian() which returns the endian MemOp
> corresponding to the vCPU DisasContext.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
> index 2b6646b339..54955437ef 100644
> --- a/target/mips/tcg/translate.h
> +++ b/target/mips/tcg/translate.h
> @@ -240,4 +240,9 @@ static inline bool cpu_is_bigendian(DisasContext *ctx)
>       return extract32(ctx->CP0_Config0, CP0C0_BE, 1);
>   }
>   
> +static inline MemOp mo_endian(DisasContext *dc)
> +{
> +    return cpu_is_bigendian(dc) ? MO_BE : MO_LE;
> +}

Based on patch 6, I think you'd better pass 'bool reversed' to this function.
Then

     disas_is_bigendian(dc) ^ reversed ? MO_BE : MO_LE;

r~

