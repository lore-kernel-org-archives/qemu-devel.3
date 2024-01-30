Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4E0C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjaY-0004y3-W3; Tue, 30 Jan 2024 03:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjaQ-0004wT-R3
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:35:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjaH-0004rr-Bp
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:35:14 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ae3be1c37so1378595f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706603706; x=1707208506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+oxqw9LaaR4ABwL+8F2feAdaVXYVhFV1aHt0UfCnPH4=;
 b=vY2WOk0xFC7U5jzwyR81U0g/E4uVWcLoX4zKMeBVLjN5sZNXqIzw8tfkxGJo/FYw4f
 gnJ0W9P4HoiOzmPDGaNx8VMQPG1Q6by+raR7x9e4OjIZm0UjPfTmwk8w1RARpgrERVjd
 HI+rHaUEBw9KWgFJxVEgJBU+yO4GAxok5I8znykhwmBAal2MPBw3biCptFC17n4T/XFM
 s0WwPimuDKRtVdCtVxW8e8TfcCHWq+28bb3rRD1FhelBnEMhYScmF6oWHhJtFU78zy0C
 xaUVZohKW4iU4ApkGq7lHXLsCoLjxRThHH1HCa3NdVDhQLYpaVkaEcwW6VerYknb9yXH
 nAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706603706; x=1707208506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+oxqw9LaaR4ABwL+8F2feAdaVXYVhFV1aHt0UfCnPH4=;
 b=MpQyqhxu2/eNaWG4wMFYp8vFqpJDB5dZ9BR+cbFFfGvpeRtu91nTw9irogfXXNXpjV
 J1ICDJC668K4EQDiixzFtDQwus2r9Z5wCW7g3InlBGSF8qJSLzEYdHN74XFHEIXfXIp0
 ms+6DHrCMvOhej9jd2Q3SH9+PVD6OwTMWThaKcSf77J3irW5wcknFOipI4KjS/vueU8T
 D9jDzokIeFut4UCCLvpB3XxcWYrFY5RGD4oWVhjHTld12wnr20g1GJ9DY9p/KuCbUW7S
 FOgB8f/i+6LLk8RxIzQknctaYTLITlAS3qk42RsTPf6jBpqHHMB7YwAyf+baZkmjifBE
 WnTg==
X-Gm-Message-State: AOJu0YzKr8KstxPWAda7FpsxVsZWiacCYg9Bt50TDHonidtrlwBnsDgs
 py6BB4kZ9jk+g7kI06A8asLZOhDblshWIHGoGJuiAxwWzhB8ZkwvBToq6ZYDOXMqYieM94iLG34
 n
X-Google-Smtp-Source: AGHT+IFinhriq9opApucFygFCf8/r8RCnbLlR0s9lHOzuLUuW/wPS37EuxVFbEZYu/F6pHaMYxSF/g==
X-Received: by 2002:a05:6000:12ca:b0:33a:d28c:222c with SMTP id
 l10-20020a05600012ca00b0033ad28c222cmr723780wrx.11.1706603706469; 
 Tue, 30 Jan 2024 00:35:06 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c510400b0040ef7186b7esm5150644wms.29.2024.01.30.00.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:35:06 -0800 (PST)
Message-ID: <1d4cc1d0-7230-4654-b534-339de480a5a2@linaro.org>
Date: Tue, 30 Jan 2024 09:35:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/29] target/riscv: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-23-philmd@linaro.org>
 <c1604184-d470-43ef-9530-cb8c0e5c8901@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c1604184-d470-43ef-9530-cb8c0e5c8901@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 29/1/24 22:53, Daniel Henrique Barboza wrote:
> Hey Phil,
> 
> This patch is giving me a conflict in target/riscv/cpu_helper.c when 
> applying
> on top of master. Not sure if I'm missing any dependency.

My 'master' was commit 7a1dc45af5.

> It's a trivial conflict though, just a FYI. As for the patch:
> 
> 
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!


