Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38458CAC5B1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yya-0003ne-7F; Tue, 23 Sep 2025 05:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yyX-0003mB-05
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:06:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yyM-0008NA-DC
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:06:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45f2cf99bbbso25066365e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758618359; x=1759223159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLhw0MG6P/nv2aD54ftxzSa4yDLYhf66ozUOdh2WoYk=;
 b=QJ7sm4ujFiQ5kJ6nml9XgIaRd3BaWmVDig4cji8bAFJM9ec66HxtdFyGJv17De0soK
 XJVOOgcNV/4cApP5IXnf07AWz47nk34CFXRYAbF+OdJZLHIB1xU+KXPtaRGA3S3Ml/mJ
 vnZN/p8vUCvev9aHmx0XvGQaG7a8h+7jGTDCcv3VHsbl4QTt8p6BwS4mPV6sfrxTjT/Z
 SPnXFlcYzZdNvxtfiRvNSaLNceBLFEsgTUzxmXtRChx1V94K1usTzt1yS/EfPdu/7nmW
 q5YABDOXXzXNSHUJRBWKa/AUgD0uQxzI9LlQgIqR2QhpxOGS5pEtMqspTBzOdC3Mzgee
 dUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758618359; x=1759223159;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DLhw0MG6P/nv2aD54ftxzSa4yDLYhf66ozUOdh2WoYk=;
 b=Qys4yBn2oJEbk0GnLgayoUIpAfY2tTThde9231FuTmQJEdcvTVY2M7SnwmjIvM4XyA
 QsrGf8SOF3CjTBlo7hwwvUtailHZHr8BZ/OWKZWiEnhLmbITB3X1BhB97f+Zzh7a/HqG
 TV+ZW+UBmmmAkueriZqlKrLsl4P08yfgSUYqespj9idndcXj9rR7Gyd3HZx3QJ7NmJkP
 DR04sMybJEkMU1uCChTNPgvH33btOfzpCEhAO4zdYiltT78e6hDy9vu1edTFh5ToxUBU
 tXBbc48hKeiB0WnWHtFXd/OYiQ71xDfRjB/zj4jPt7D5e8gbIJ1W5UpQje5EuQO15rYH
 3YSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVH1DaNQr+xfmmkw8Lxz5M79a68q/KKzwTSN5Tv5E9TmjQeNgI7FFSW6K8YCxaVlf4TYNttSw/yeyp@nongnu.org
X-Gm-Message-State: AOJu0YwAQQTjCIfIJbYGZhysz+Rbp6qdgU0x+SUoW3mF7JbGvLpIwO8d
 FprBxSWJ0Ltx8REaPro2j2nSlV14c4Qzb+fLn012j2P/E9kwJpi3dTdFTRI/xNSg0czjMPlGGQo
 /4FzCpg97tg==
X-Gm-Gg: ASbGncvp4JKwNVW7hzopoij85JwKoXEStQ8fgR/Toaagf/rVFs5duGLp/NWvzYvEk/2
 ziNHim5X2NMZ32rorrRv7QjZUGbvdTEggDKiY/KyU0HbwAIVSf5zPJkTLHytTRl3WNqbS4EOZkJ
 5Sr4GOGyG6fPJ0lu1otUWXkxSgw03txH+7qmYEgRamK7/BoUNr44yxtjIv8mI/IQnrT8ZV0ju32
 QFUU2IqnQLIiQ0MK4ExYCyoMysPjL8cwUtilLn9BNXLGDHEgW04NT+YzWj1BEtmICbH4WLF8pmG
 5J53dD0f6+jn/ZM2i2FOn0aKDq+SX1/Hyn+cCu1woqGLIc1Beh6Mpgbu0pKvfqMVnhs4FXPyTqA
 cvNaNMY/hphFIW7VIVnVUcBP+gT1NEKLOxbckt91A22Ho3JlZWB5qNGqGUTwMAYAZlQfx1U7Ikd
 sG
X-Google-Smtp-Source: AGHT+IGI7ncS2M2tBg9fLBqO6Cm1CbYif3sOR2AXL3cS/1Epj2HhCvT8b+PFIwYe1vJoYo9WfBKbhw==
X-Received: by 2002:a05:600c:1e09:b0:45d:cf5f:cff8 with SMTP id
 5b1f17b1804b1-46e1d97fad2mr15504235e9.11.1758618359295; 
 Tue, 23 Sep 2025 02:05:59 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46c9d5d52dcsm103412655e9.8.2025.09.23.02.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:05:58 -0700 (PDT)
Message-ID: <6a091e0b-c198-42ce-9279-702785939cfb@linaro.org>
Date: Tue, 23 Sep 2025 11:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] target/alpha: Simplify call_pal implementation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-4-richard.henderson@linaro.org>
 <adcd026f-398f-47c3-828b-af13f362cc94@linaro.org>
Content-Language: en-US
In-Reply-To: <adcd026f-398f-47c3-828b-af13f362cc94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 23/9/25 09:30, Philippe Mathieu-Daudé wrote:
> On 23/9/25 04:39, Richard Henderson wrote:
>> Since 288a5fe980f, we don't link translation blocks
>> directly to palcode entry points.  If we load palbr
>> from env instead of encoding the constant, we avoid
>> all need for tb_flush().
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/alpha/helper.h     |  1 -
>>   target/alpha/sys_helper.c |  6 ------
>>   target/alpha/translate.c  | 21 ++++++---------------
>>   3 files changed, 6 insertions(+), 22 deletions(-)


> Probably unrelated but still same target, could you also update the
> comment added in commit fe57ca82b09 ("target-alpha: Add placeholders
> for missing userspace PALcalls")?
> 
>          case 0x86:
>              /* IMB */
>              /* ??? We can probably elide the code using page_unprotect
>                 that is checking for self-modifying code.  Instead we
>                 could simply call tb_flush here.  Until we work out the
>                 changes required to turn off the extra write protection,
>                 this can be a no-op.  */
>              break;
> 

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


