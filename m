Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC657C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDSM-00016L-5x; Tue, 25 Mar 2025 19:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txDSL-000165-4C
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:13:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txDSJ-0002E5-Eh
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:13:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso64620645e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742944390; x=1743549190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CAaUY96xpxXz7XUEj+ysk1336m1bvVLdVpIlMzrki1A=;
 b=n7HgWvILKoIAbUs0KAju8VyNypJXFKnTkUCwb0HooJDx9xGxtYKIY3uwHF14/v/IWP
 tA2jPNqOWSbgy98KnBwv/Eyjl4EK7qHBpkeux6A48Rzegf5RXLiAeVHgTxEfE3k381CJ
 NM+h2fZWgijNcyoX82811hqWlko8T1xVVKuABQJdY1dVtpbPHcZwp/gxt6+XOVOiSF0I
 FFI3ZrAVBt2cxiy9/Ez9Ht0z75NB/u5iBHqZFhfZ1sZZrYBhYckj99vOLWtFFRI0RZwj
 LkFrUrae07/T/3qZVUyKz68E4PP/cZ4xkFoKfFpyOlZv8eoKF8uUvqMiL40UU5i3VNCC
 uzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742944390; x=1743549190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CAaUY96xpxXz7XUEj+ysk1336m1bvVLdVpIlMzrki1A=;
 b=n5/EVAqGW/MIjkGSw+tzeoefTi1L/Dv1K+Gbw+yr+Nhjo6mkTQjpCjlfhkqTkgOq9n
 UuTQ179LaFvP0oz2o8z7V8b3K7q8RjlY+h5MT4ZkjJm8FwUimdx0kYF8L88BHagRoeFm
 IN80bdQRbnciwGSqEDTsFxsFithS6e9VuQ/4KaBViYYelTky0ir2KLYl73OjaxQZws5C
 azajvu4tBeqJJBmihSpONpIRfcmAUmt0FaRlRs+LByoWXg7nf4uE11PckXeDzJI4GHkb
 AS8OmIwQWY/5JBMvrqDXpr01kb8/AycmGTfS98z3emC6OdXvzsrG978NoQ2ZOHRy5Doh
 qnCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfk5XsyaFnW4JhNu7gh4bV2DXK1QauRy5N9U2wCNhGzeNRJLGB7F+NeYYJi8U9sRrHPUlJ1OAKSlOJ@nongnu.org
X-Gm-Message-State: AOJu0YwvdOVeF7aARgspcadeOUHy4UYinSmpyFh1Bpy4WB+mF02FgQs5
 4xFhMPE5m5reOUhaQHDJWk8Kcaj4g94tVPmLAbUpeEtvWJi7QdcaUKJ5AfEtv2U=
X-Gm-Gg: ASbGnct88Nys2xYHvvDgy5JQ4KZV1chZtxvFmrg1xGraEumFNyQXzqnAp/2vf0lB1VB
 HpcTHjS2Za5CA9U0jadxeaI5RuaCMG3exiuavORK+mlr3IaH0RziDe7nE9PslRJOQZcYooBCdUT
 OTsdd9VsfGsWQJVDTxmO+DjDOuwpT32dYeHwhVAgx7bB1fWjd6hB+7YajenioxFxYVgew2Ry83M
 rNFF//AzSzrQlkm0wMIsaFC7G37Y+E7y8xC/Jq3BRPDWNTBt45LF0FQ+F2A9hj4nw7az29NkU+5
 i4PbvxhY5w73MhKtMPVh0eTxNC0kBLg9aCtPi0zfJ7Ephpxm/RpRxaD/Dsy/YnYohQtMXjxmPNt
 WQfJPyEGNnSKn
X-Google-Smtp-Source: AGHT+IFXsrXXJ/PNajTdL5TX6W628DCGOxz71jTtTGY0KooUu7qnIVAf7wmuP6I24+fmtpKLLSYHMw==
X-Received: by 2002:a05:600c:4584:b0:43c:fe85:e4ba with SMTP id
 5b1f17b1804b1-43d509f4b25mr200294175e9.15.1742944389648; 
 Tue, 25 Mar 2025 16:13:09 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6667sm15188151f8f.72.2025.03.25.16.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 16:13:09 -0700 (PDT)
Message-ID: <390926c0-b449-41e9-9b25-f19837df810b@linaro.org>
Date: Wed, 26 Mar 2025 00:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] target/avr: Improve decode of LDS, STS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org, qemu-stable@nongnu.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325224403.4011975-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/3/25 23:43, Richard Henderson wrote:
> The comment about not being able to define a field with
> zero bits is out of date since 94597b6146f3
> ("decodetree: Allow !function with no input bits").
> 
> This fixes the missing load of imm in the disassembler.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9d8caa67a24 ("target/avr: Add support for disassembling via option '-d in_asm'")

Isn't it:

Fixes: 9732b024f79 ("target/avr: Add instruction translation - Data 
Transfer Instructions")
?

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/translate.c | 2 --
>   target/avr/insn.decode | 7 ++-----
>   2 files changed, 2 insertions(+), 7 deletions(-)


