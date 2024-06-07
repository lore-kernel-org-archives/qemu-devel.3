Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46CEC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFZxo-0002wm-TE; Fri, 07 Jun 2024 09:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFZxn-0002wH-Hh
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:49:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFZxl-0007JW-W5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:49:03 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57a31d63b6bso3058739a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717768140; x=1718372940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FSL2qKKtjXLKKqSsYqmkSjAD/o7fRQA6ifx0uw3IlM4=;
 b=kEWgQKgUwIQpdGrBGG8QBu2txDuRJ+yp/BbAqhtGhcrjS22/XntIq4NEKD03F5csEh
 TG3HWBLn72pqfO1BGV2BeU08yjSJprtE0dy6TVqfU+i6n+BNKrZItBGQypIMEVGUnw2a
 xLue44xDtcvbP9mxRvPtig1RhkrgCjTu6S6crCWrA1fYTxXEQHs4nin1AEnIrPP6z3ZO
 l3dgakA2LAYZxFlU+s6Lmmd4GWieIJHWW2ixf5sYfDpv/NxgeydN6soHBCAV0YW9MRZe
 +H3nk+W054BuuzuqVr6dZTUZdtcJjlYC0/xCfXVEuUkq/YsY/DP/0wgO6hNezff2R8LR
 /v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717768140; x=1718372940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FSL2qKKtjXLKKqSsYqmkSjAD/o7fRQA6ifx0uw3IlM4=;
 b=d2ryn4n6AuLB6WZdE7MdUsj4mkSFaTdnJiYONFv4YVIn45lw1EeSYA0wK2tBXUcjqg
 l3QFiFtn8/ATb5QEp/LnDaUNC1vp+DYVHFAfUNWb/PkWq/Biw1OWc9TP4SZqlMZSaTor
 kRu0rKbS86sYbKkpDjAtKXqtHPJtqzNRmngpcXX1TsBofZQmjxRGKJGN2NxtMZ+Yt4RP
 DFkD4VeuXkCEubZoJAJtj13WSh93uz32q2rBdGd1mPDehRzEmGF/uvv+OO66K4A4sK3v
 4N6AfjnxMiaoNPL87R06Y82vc3ov0dFqQqRlcBoFkbLCBagr8CaSVwomXsXBgybQKMgF
 8pSw==
X-Gm-Message-State: AOJu0YyYNByDFHkG8K2URZYDrPYgj6wCvZUNypLBJukaBrsNc2aUnPdB
 WjBe0lqgvfGmmYf8MqJWzt8YTAYZaHdT5b44YwFZ42+6is0JdOMD6Q9LR4xHzw0=
X-Google-Smtp-Source: AGHT+IHvA5C07OMA+AGKxQ86u4sMa5aCjmHBkg1yOZd42IVp7zwG2/EFUe/+AoRVrqNK8VCc6/9PBw==
X-Received: by 2002:a17:906:b313:b0:a6e:2a67:789f with SMTP id
 a640c23a62f3a-a6e2a677a24mr97972666b.40.1717768139826; 
 Fri, 07 Jun 2024 06:48:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.231])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80588851sm254195466b.29.2024.06.07.06.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 06:48:59 -0700 (PDT)
Message-ID: <aea6bd27-6c59-4257-ab89-18809444f8a8@linaro.org>
Date: Fri, 7 Jun 2024 15:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/mips: Restrict semihosting to TCG
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240530145349.41309-1-philmd@linaro.org>
 <20240530145349.41309-2-philmd@linaro.org>
 <c2kx2jt43pcujrfx3szs3wztny7i5bvb3gypmw73dpcf5izvbo@3ahkvdtgrfl5>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c2kx2jt43pcujrfx3szs3wztny7i5bvb3gypmw73dpcf5izvbo@3ahkvdtgrfl5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/6/24 13:08, Anton Johansson wrote:
> On 30/05/24, Philippe Mathieu-Daudé wrote:
>> Semihosting currently uses the TCG probe_access API. To prepare for
>> encoding the TCG dependency in Kconfig, do not enable it unless TCG
>> is available.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> xtensa and m68k also `select SEMIHOSTING`, were these missed?

TCG is the only accelerator they use, so it is kinda implicit,
but you are right, I'll update for completeness.

> Otherwise for patch 1 & 2:
> Reviewed-by: Anton Johansson <anjo@rev.ng>

Thanks!

