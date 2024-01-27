Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB9BC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaRZ-0003KR-83; Fri, 26 Jan 2024 23:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaRX-0003KG-QL
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:37:23 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaRW-0007NX-7d
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:37:23 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so689237b6e.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706330241; x=1706935041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cj8/9w34sekw9fqgeXEmZYVNBwa1Bhh4HEMqpuehIec=;
 b=sEBfZ6Lj5Xa4Diew//kLxl+2/x+hF8nbG26KSElKSh5fkPimy7Q3QHvZ1clfBxN+Rq
 VlcN/7bvKwEZfoO+5bi636w8c17oL6NSIB1W6a7z/HTJKw4YnLG6DgZRlpmtuvAQJVkp
 7g7AnHCJ2/BSnw3SZy9gp5Ky6/xYHZfRac3uh79FIhgEFWF4QgNaBHRjDdf4dGC15rsB
 C9p4ME8WpjffQdT/MdB0OZ+7C+GnfpNChyJp9uKLcCT8Gao5GYZ51CqbFpO1HMETbMFe
 39spyC49TgC0kRW2YzY1vocu3SnRuxPhxcci0uIAv3VfNDVrruV6ZOCluFISAlUgPggD
 mZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706330241; x=1706935041;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cj8/9w34sekw9fqgeXEmZYVNBwa1Bhh4HEMqpuehIec=;
 b=CIx1SMfed1B4iSI/BJElZhen1BWkz6M0B4WefUJyvO4VSgpKLae3uJjTdM4UiQvyM7
 v/3/Fge0IsIUrBIEJrDzXWJ6DhZYTLqjdzaHeVjMkIuEGjLiam9U+ypJgO/WuSqCkaSh
 6C4KPMbUKfcWFQT77uW4qLx7tXJMNm3UnWfsGYOGd78zAdMjayY0tRthfgKZQ3UXwQkc
 19m/1BH40yDsylHVCR+cjkKdLXdsKgTFcmm0sHvgOVEM9aeTd1oo8knzzSYxISNnD0C8
 wLyz5pOwkyruHrB92w0Wm/iW4/a9R4s8xbpfYkkgO52pqU7vtcjO8leXvZYMdtgvg0p3
 TffQ==
X-Gm-Message-State: AOJu0YyPLLxmkvD58XpKhsMjWD2zSZSasJWqoiDoxPIgEQTUmPwvaNcn
 9umPqLxxP1lcHNP8mVCuItvDtZWWhc/VHKoM7x4aTLz3aat16+bpHqVEaY/11EI=
X-Google-Smtp-Source: AGHT+IFLtwL3OJZ0vfjt1cv3+z+nsaNds2MO2tYqKmDJmrzC5RSFp8haTxthDiGgEgOpw5424ly/mA==
X-Received: by 2002:a05:6808:1183:b0:3bd:e0bb:1d09 with SMTP id
 j3-20020a056808118300b003bde0bb1d09mr1270779oil.40.1706330240831; 
 Fri, 26 Jan 2024 20:37:20 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 p30-20020aa79e9e000000b006ddd13c09c7sm1924769pfq.172.2024.01.26.20.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:37:20 -0800 (PST)
Message-ID: <64ecc73c-91f7-4729-959a-2ee763c44f6e@linaro.org>
Date: Sat, 27 Jan 2024 14:37:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/23] target/nios2: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/nios2/cpu.c        | 15 +++------------
>   target/nios2/helper.c     |  3 +--
>   target/nios2/nios2-semi.c |  6 ++----
>   3 files changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

