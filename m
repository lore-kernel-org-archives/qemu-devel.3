Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC98CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jHW-0007Yd-O9; Thu, 25 Sep 2025 06:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jH1-00077c-Do
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:32:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jGn-0003Xx-J9
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:32:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so551330f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796325; x=1759401125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=spYS1zKfTXAxRYeHL07RweLVs+lTMBzOxEgH7rHEpMw=;
 b=Myf3xlnJrAEvka+yiXThLsXM5sznhZejBjFjSw82qKUdVwygKJHz2SaGD/8q2RHDcb
 JQ3oZihV4rToNCjKixmpizNXO2B2zVyNbp2X7gY8/RPCdnK/V/WdnFMjI9og2ihak8kA
 Y7oxEKIRCycW9Z8qBqLn8DKbHPzYxS5ISi1nnsmYPRNviSyHbI6TRSHJKugVAzVhalMy
 fUd3tvH17pBi71gUEd8rGXglO/2Lxo28o4ZE6+lZlz0GO1OScKfNsrnFN8T96HXMSvfj
 TTm7kff82d8RcNcst/jeK0DKU3ziDP/NFntmlF9hV5doplbRp0Cbn09EfSThR6O9vM7O
 5Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796325; x=1759401125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=spYS1zKfTXAxRYeHL07RweLVs+lTMBzOxEgH7rHEpMw=;
 b=nOwTx1XaVrOQQV3ceGS+ZYOHYeXB3FETYjlJF/CkddVR5/Bd8Wtg/tCoDI2vIHb8cJ
 g78DYG2DL1VJeRlIJYC8pSeQ+RLZdKGQSwGGCTfhxaT4F5U/1tIpRb3LLMHPoI9P51Dt
 s1TBOjGCdGgGiiONu3lJmx6ckEW3W8G0/5De3ptDshtMIZUcTLM1qNYVsjVHlAEQ/hEI
 R6wfmr2SJ4ztIKf1dzUdOrDRqOvxQ5m+egj7ftVlcmEaHHLO4QUcY7tAj6hYyPSPTqpX
 NnhlnJCZZafpu09ATHHlJDO17h2kbllodFpXwdO1EbPbjE0O8OOKDUhOogmlVSGIvPV7
 Ek/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdp4VZev0JIZGC+GqFnJVVEFadkcH9QJWRHOb7z4NmWNskU2WvYL55yLTh3AKe1tDkcYCeFsMnMT3O@nongnu.org
X-Gm-Message-State: AOJu0YxGUOAT8IYivt5QiYpPklKjTP2r/17S/JTzJjWz8PmGrKvFCzjy
 HZ7IUSezJYhKbEdTcDAlE/XOB5gYG2PUHUVfq2Yom77t2Y3QEA+tzssWaiIag72FTbs=
X-Gm-Gg: ASbGnctNTRlhYBmFgkeYmHBOJppC2sr1wHw3TI0lJjWDvarSqcXMjNLLS62i/IGj0ya
 +Qf8V+lLqHLtWcDb58LWJm5Pl8PlHpGKEXWWAHRwJoMn2A7Et4iGSE4L0kLxaWstxrs9sdQcGlM
 mifSYH4a9DROxqVuZDBgDABdbhxUVHsnbwrqt0OVGFocXNReAU3mQAHGSAooT7Iigm4YvWA+CWl
 dxy1rg93zB3lOH8zE50jJtl9XphQVQC7vA922gdL211LF+MU3zpFqglDamXYh5xhU4rNUSFv6Aq
 pgp4TeuetAVJru6N/HY5M5RO9hvIVTU7JcjNroRoCM7zL8sDvwkSBqVJ6OQ/dC9IK45ikKlmHXq
 yYbuJtef3+J1WBTDYUBhMvHdz/G732rjEEqJFaPTI2qalH/uQfpoe6///1RFUa1YOSg==
X-Google-Smtp-Source: AGHT+IGDVOja2Yg8Y3rx/e9YYtEtdhVk+lw7MxWJvclITZZlx/MpoxAIqBMQ445Bo/QBMfrZHZIyag==
X-Received: by 2002:a05:6000:144f:b0:3eb:c276:a361 with SMTP id
 ffacd0b85a97d-40e4d9c8fedmr2925161f8f.54.1758796325365; 
 Thu, 25 Sep 2025 03:32:05 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7e2bf35sm2514424f8f.53.2025.09.25.03.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:32:04 -0700 (PDT)
Message-ID: <da7889f5-07bd-469a-9e22-2765e3316ded@linaro.org>
Date: Thu, 25 Sep 2025 12:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/36] target/arm/hvf: Replace hvf_sreg_match with
 hvf_sreg_list
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Change hvf_get_registers and hvf_put_registers to iterate over
> cpregs_indexes instead of hvf_sreg_match.
> 
> This lets us drop the cp_idx member of hvf_sreg_match, which leaves
> only one member in the struct.  Replace the struct with a const array.
> Instead of int, use the proper enum type: hv_sys_reg_t.
> Rename from hvf_sreg_match to hvf_sreg_list because there is no
> longer any matching going on.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 45 +++++++++++++++-----------------------------
>   1 file changed, 15 insertions(+), 30 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

