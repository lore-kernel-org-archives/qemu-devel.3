Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B203C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1refMs-0006W0-R1; Mon, 26 Feb 2024 13:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1refMq-0006Um-9p
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:06:20 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1refMl-0003bg-3a
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:06:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d509ab80eso1512701f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 10:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708970768; x=1709575568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dl5u8YgahXYNv5D9gqTEhepCdzbNIfkrqC1S5eOosEc=;
 b=shh2CtG+7gfcKW9zVGInPiZ3lOVEfJ6Sz/xVT+WrU6gsSDJjm7wqk9Ek13Pt8yTc9r
 ZxAYVhhg4Z8wPidhf8HRJKhYhCG7AaKlSaNZeU4+vPj650l5LfXnoN8pcyFWJUpFM+dq
 L9khUAb/tasDyAcKQImYB95dm5uQvFqOZ/xLDTqLmSbwW3I23z+izNZ5kp0PKI9YQ7+m
 hsFKQPJatHlQCHkEQjl9LZyf7gmSgS6YFI5ByuZtJKI1Ghpe913LIx7e0NLwgf7GaUVv
 q8imoD87S/AirHJGwmDTOAJSWGtUNwTSINxDDw5en/MqqSxrugNrt3N7WWp146hjm0QU
 F0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708970768; x=1709575568;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dl5u8YgahXYNv5D9gqTEhepCdzbNIfkrqC1S5eOosEc=;
 b=ir/qdHdvCIb6EFHzzZHuHupZtZF/ykXNBUzK77oPkjJUCaKib3VfNvvW94Oe1o5A4j
 gyBGrbbaMUs9cMRw3c7PeCMIfzCuOEGWCNqhOEURUIRmSlPNZU3Vgo0mdEXEkGxYbWn3
 7vrDgD+32oh/49fINybIlKkmHuUkKOlmK3ARs8HSWRwVgmTRwyhBDTdcTKMgnPmX5N8a
 2HArsd8ePcDs6Vd547RRrGLQsxPfEPzR20WTw3ZbUKILHsOX3PAp0g7jFYfFyhEowFtA
 GYEPd5ESgVpNCvAdJ+7fIB334wr0f/SZB2+fdeTEbEcdm0WJp0hxWjiURdqPhvwU+WZp
 iu6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoJBQfn/LHfRJxv3rjym+GFO/vtPQJEDmi/ymuF6eE+wz2pCE14a4TIrrPmneY3C3tApRIIqwmNpAsbRjvXT/llzjSK5A=
X-Gm-Message-State: AOJu0YxNyXLxjklfg7DaIvn9I8WpB6qQKpltKeVlIomqUNBMyg7epZ8S
 2pYXUW7o8VuyTLKwb6StVzMRSmzGnozOoisGEpKZhBjG3Jwk2u8/kIz4BLsulf0=
X-Google-Smtp-Source: AGHT+IEd9n1vfXtjoNKFaRimBxaey/wZXE0CMG2adDf+PYDpEk7mm82TjFTxgbkLypiC69BmwkRI4g==
X-Received: by 2002:adf:e886:0:b0:33d:39dd:12f4 with SMTP id
 d6-20020adfe886000000b0033d39dd12f4mr5521445wrm.67.1708970768676; 
 Mon, 26 Feb 2024 10:06:08 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 c20-20020adfa314000000b0033d90b314e7sm8939920wrb.101.2024.02.26.10.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 10:06:07 -0800 (PST)
Message-ID: <10f947d4-51da-4187-acd7-d40152fed65e@linaro.org>
Date: Mon, 26 Feb 2024 19:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] test/qtest: Add API functions to capture IRQ toggling
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 thuth@redhat.com
Cc: lvivier@redhat.com, pbonzini@redhat.com
References: <20231113230149.321304-1-gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231113230149.321304-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 14/11/23 00:01, Gustavo Romero wrote:
> Currently, the QTest API does not provide a function to capture when an
> IRQ line is raised or lowered, although the QTest Protocol already
> reports such IRQ transitions. As a consequence, it is also not possible
> to capture when an IRQ line is toggled. Functions like qtest_get_irq()
> only read the current state of the intercepted IRQ lines, which is
> already high (or low) when the function is called if the IRQ line is
> toggled. Therefore, these functions miss the IRQ line state transitions.
> 
> This commit introduces two new API functions:
> qtest_get_irq_raised_counter() and qtest_get_irq_lowered_counter().
> These functions allow capturing the number of times an observed IRQ line
> transitioned from low to high state or from high to low state,
> respectively.
> 
> When used together, these new API functions then allow checking if one
> or more pulses were generated (indicating if the IRQ line was toggled).
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/qtest/libqtest.c | 24 ++++++++++++++++++++++++
>   tests/qtest/libqtest.h | 28 ++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)

Sorry I totally forgot this patch :/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


