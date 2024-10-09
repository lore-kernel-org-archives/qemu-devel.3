Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376C4CEE342
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 18:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sybqd-0003oN-DQ; Wed, 09 Oct 2024 14:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sybqb-0003o4-Vy
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:55:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sybqa-0003rK-D6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:55:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71df0dbee46so113989b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728500143; x=1729104943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tc6VkZnx60BiTg2WXO4EChgnJa2XgmHv0c0PzLUQ2g8=;
 b=Ms9lDIyvpUD4IkjwE79A8f/jqFHlZB1JMy0T02W7WXNDdStDutsbPL2FpZk5iZ5seF
 xJioCqNMMwNvD/K60N+ZG7q8glWm5MSWwnjwjHvxTcsPVLwWLimBhFBZ7uBuEsypUqm0
 mFjIcq/prKInkefqs05WBgM1r337lseLtc7QxDW8ZF4eOM42X/Ygr6jzprO3kJGMAFmE
 LnhkWclhbSFrDmfeCl/aoKaj/moV/VIOsubEQYL81zeh19I/BVqq8bF/t4jqF/Sf1cyk
 ISm6YnLZJv29W7l/t81I55hlwqSznHCJWIz/Ar+udW13V7LMi10ElXZdVwX4xa42xXQ9
 Ibkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728500143; x=1729104943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tc6VkZnx60BiTg2WXO4EChgnJa2XgmHv0c0PzLUQ2g8=;
 b=ASA4HMZGco0rNdNE8KpUUAWy4mbAfMG2UXwBe6+izplOhUPsn/KSpmnm3t/8X5Or0b
 4XyGwxxHrvtkYQc3mN9Rgo3T7c8BzgG2lwDUI4sBs5t7/IVslv/8VTkMmtfAX7iu/qKH
 3orVExxW+wkAZzZXMN/KJWru197R4mybfBsbSfY6zkWC7cTP2u8pVuPYyqWSMi2fnLmV
 vrg98czKoZyIFYSJxH1uwDHZ8AGL8Qp+sjbIYYDaeYlmyAPN+2U7PWsqdg8OIRrnE7H0
 cjdYcr360JuNV35T+kBHRvLlF0p2a/9cpyXNrraFtOEyan0vAWFDW2mgSEkYoMqGP7Bd
 y9Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtMprL9p/wLyiQKyijrgLvO9pZsoO3r2kRZLsmcY94JSXRKEpNpyU2DCOGw5c7qc/dy5rsiQyXRyMK@nongnu.org
X-Gm-Message-State: AOJu0YyWzIQh2WzH0Zio4Qzf686A0BKTVvT2A0e2hgfQArs9zfFAkyGr
 4Ro0oBEYhTKGcZd7Zt1cgQZbk6XdClJ8hNXIw3vRviZj9h1oR8CD10bfpfuzDb4=
X-Google-Smtp-Source: AGHT+IHFh34X8FwppPdPD7NUkEI4OdCjpJWkeGjLIJ1+Gvz2oVK0sToQsbnPoVjVfsaH8OQ5e7yGTg==
X-Received: by 2002:a05:6a21:9d83:b0:1d7:fca:7b46 with SMTP id
 adf61e73a8af0-1d8a3c49baamr5989989637.31.1728500142944; 
 Wed, 09 Oct 2024 11:55:42 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e03288a37sm5592380b3a.155.2024.10.09.11.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 11:55:42 -0700 (PDT)
Message-ID: <dcdb157d-c9ed-4786-a58b-b31357cc51f6@linaro.org>
Date: Wed, 9 Oct 2024 15:55:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] include/exec/memop: Introduce
 memop_atomicity_bits
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
 <20241009000453.315652-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241009000453.315652-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42b.google.com
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

On 8/10/24 21:04, Richard Henderson wrote:
> Split out of mmu_lookup.
> 
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/memop.h | 24 ++++++++++++++++++++++++
>   accel/tcg/cputlb.c   | 16 ++--------------
>   2 files changed, 26 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


