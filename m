Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C287D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxEm-0007u5-2N; Thu, 08 Jan 2026 16:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxEk-0007pF-HK
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:08:06 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxEj-0004I9-0J
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:08:06 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c075ec1a58aso1545649a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906483; x=1768511283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ziI4BWcl2GdbvwhB1oeCzrrRMbMBSD1h+o2Xn58dEi4=;
 b=mmSdKLdmmkpT2Iw1IV2seNT3eO4iSAolQh5j9VX2XE5zjv2GM5+PU3tqfypOChdAgW
 wWkcl9RlmzAwLKhqYhTlW9SIrHmHhJW4tGLexVIQpH7F2QboC3+KdXoSfpqrRzEUsYun
 g4hJ+Bmet2w/PWktH2NiFPy0CKXJyhqukktXmtH11ISH/WpuPApMh5h4pjqgxNgAp7si
 AgLx09JGjr0wQYlaV7pvIClyAU5F+9NbYXOFUWmCqAsh7whqt0J8NzQUiY082X7Geozh
 Jp0U2/LlWQD+k24l1NPp1R8371+nwrhhn32uXee63tjuLf8JH/VALvaGet0BtVdkXAjp
 3vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906483; x=1768511283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ziI4BWcl2GdbvwhB1oeCzrrRMbMBSD1h+o2Xn58dEi4=;
 b=CwYzn7Et8UZpK8uXkpNvAOdxc3rThdXLQfGltrR7xD0aTPYEzrkdUDQBj8qSu2PdDX
 LZxX24mSw27gUjbuolFDN2a9ylplzNrC/4W0wTdGO0aMBiT/Jj/SXyOa+b0UoAkNZzpt
 eK/UVn2bThLtZsb636n9JlbwWQygnQSGi8IZDtZ3V3azQeR+Y1xrz0AfwLuv6ED3RR4e
 d6Omn8n4Zo4egazmQn89Vnkab0IhMBxqCdIbH6TS6se3xdWmbjtQ7tkzS1wpaop/OPn5
 fEqQY2GIxL5BQpaIaqOFlJSliB4QXR1YZ6AxE5maT9BCkFjjk6VtRWxJmJuxYshjtdf7
 Bwmw==
X-Gm-Message-State: AOJu0YyIb1Lj6+EA/iOrtHm5fAk0YnDBjETSCm2IhxnJTVZgifDV1at/
 ndiUA+36ycRSRRdN664uKBYI7/B8Ari0x9PE6E4Q0joApCrEhzWw8bIzWTa4mSQoJn+mQ/aQTEs
 ZT2wz
X-Gm-Gg: AY/fxX5laktN/J/CVnCWUZY/VWT3ngft8wyXJBqaQfk5+O8PQ880LZ8D3AfNCjXJ96z
 YTNiCdBbrj0q5KasJ9TGETP2tbzl83HexbIv/qzLMJFmIBx2P8hNhzttVUzvNXv6mjUyc+nedN9
 qBzaQ5o+Dy0iWGvdcdnBIZ6ogJoinrH6lTNBK64GOLWEASqBKJuQp9lEs5oDRw28B6uImshFlOn
 qPGjz5bWkYeWs8HW44Khpc43wscneGwvjWuG+PyrJg2vkTv+ZSKOMqgmvPfmMdFhsClRFmK6w1U
 tBr5hXGj3dgLfoQL/2Dq0PJ/iIV2eFc4vwUzlXQ9u2yedq8EOHwYCfrALABI7K8Rq/eh9yaF8Ux
 akPoSvBqQBcOhFcZtzarNJEX7jZ62c2gEu6dI0cXpNywgLvdUV3OM0R39czYh4INOzA+KyJAvr1
 FWFdnm8PrXGKTEXCnMYlmeebJhtvqjESJ1px/7wcmX1EglxZcWySc62y8SShRhBCr5EMY=
X-Google-Smtp-Source: AGHT+IE/iwFAk9Y7iLIjrlZXpIplq4nS3kzfbzYAJAT6UzTeVtbRx4cmPJUGPyPpJAyIvN1We8Zqbg==
X-Received: by 2002:a17:903:2341:b0:2a0:c1ed:c8c2 with SMTP id
 d9443c01a7336-2a3ee4b4497mr60543505ad.55.1767906483282; 
 Thu, 08 Jan 2026 13:08:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2c0fsm86979535ad.66.2026.01.08.13.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:08:02 -0800 (PST)
Message-ID: <883095d5-0df5-415a-9c4c-a98ec705b973@linaro.org>
Date: Thu, 8 Jan 2026 13:08:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x543.google.com
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

On 12/16/25 3:57 PM, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> User creatable SMMU are handled as well for virt machine,
> by setting the memory properties when device is plugged in.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   include/hw/arm/virt.h        |  2 ++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>   hw/arm/virt.c                | 13 +++++++++++--
>   5 files changed, 54 insertions(+), 6 deletions(-)
> 

v5 sent:
https://lore.kernel.org/qemu-devel/20260108210453.2280733-1-pierrick.bouvier@linaro.org/T/#u

