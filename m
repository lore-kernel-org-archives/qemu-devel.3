Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27A6D66BA1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVy2L-0002vq-H8; Wed, 17 Dec 2025 15:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVy2J-0002vQ-4U
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:22:15 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVy2H-0004ZD-0K
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:22:14 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a09757004cso55965335ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766002931; x=1766607731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x4EyUhstuSRbAbkfdJZWtj0XuxMXlPWndB6ZRjV/U6A=;
 b=rtAixXcZN1WtolgD1u5dK8V3msKuEBIZ1J1macoicIGU+67SLgSLax/44kDECp97JY
 y3H8Yde+jerJMYykboy03oTzIIY+2S5hFYPmcSFPzQPjgmp1al4bNrR6SG73mo+EfB+5
 KrRdt9Y0Xdv0tS/BciZI2cgpbf5Le7P6TgFq75n5V2VeBdo5lu7GK0/RUhOG4VaeyR9h
 Nkiji6Qdw4SpXer7x7uRZl4UzewbjTkDBNJO2N5mrLP9jY4shm01iVKXm0Q1Zw5JuBSP
 A8CVKDsqunOdd3j8NtCEJBBSMcaCattujxBGQrI+77OFTiz9AZZfLycpgVrrUW++f3/W
 I4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766002931; x=1766607731;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4EyUhstuSRbAbkfdJZWtj0XuxMXlPWndB6ZRjV/U6A=;
 b=fWrLNAoqAj/21paJKa/FQDfvkq3siOT+h14yraNNSGJQ+ClRH3J4l4oGroqUL46W+j
 0iVetr3fNjBBgppgoyv2YB1GRg6alj9CpEIb3f3komfdCZQKaaSBVAfOb8hQlB1kWmE8
 AieMOBR3ObnKl1/Kf9YBlT+chE5Jo3lP2KQXKXnH/FL4+z2motUBeuXBGnJiuZtMn5Ye
 gJq5dFWDr/yQXRN3IqPv6m2NuJMEQWIz3RDsxWxcP9UJq/NV05+BAd18vE9CM/r2m8Zm
 xbwy0eJne1gbrmPsbmFPdniBkNmTjAYEv0F5/h0e75HPLYGMuw+ABNUxHmAFNdAgXDyg
 Nu3Q==
X-Gm-Message-State: AOJu0YzJPd59waq2OXM4T01T0zEJy+eFBRa2nBw0yyC3OJrxIERdjjPn
 TKv3Y6ckuOV3WbjdwZTmCdo6i1jrHApuWEguA9b11rw8pqZFfd+5AidUWi885Pf7Gs4A7hyFRox
 f62kg4uo=
X-Gm-Gg: AY/fxX4i0UVBjXnMM2suGWHzS4UxaDtNd2wBmAo1jKSIwqdjBmXDi+epvN5TYv8Mw4n
 remMTdeN/FRvNxIQsW2klElyIhV0ZucUGrwPBvhIgSVdQXT+N4trsUesetx313HljY/FjmMouu3
 npiXEau7Zwwmo/3zc3MokM3QWdqJs6bsVYpslYEpxJSuN8dGJI2q8vROjjvMAIGUJyHCBO+qOPD
 5GFJHeJuDfGxvc5qMOaQ3AyOhN5Hea+V6ZY7fSEsvOeHIUnFpCHn4dxLJK2ap/TSCr5Te1NMB0Z
 CC0mrY04hNGs0IQZZx7VjJq7sqUY51MAGUIRd9l4qPOKJfwRQBLbW/8Kg6k8AL1/T+veJo8qClK
 8YtGC4dItbsGGkp4vrE3EnPVNiBiJF2igj21ziGIG+9uaG9IiU9sMX/5Za25Wv+yR1GFsdwprco
 a6e9JCIOp6VNZDh1gF9sbyjMdatAoY1Q==
X-Google-Smtp-Source: AGHT+IHNwaFSeXuVgAzfEJvyn4WFfnlIPdlSx3wrhGrhDzcUY4P/lCKI41RKntnps6EGnNUqZNigMw==
X-Received: by 2002:a17:902:da83:b0:2a0:7f87:2347 with SMTP id
 d9443c01a7336-2a07f87241cmr157607535ad.46.1766002931268; 
 Wed, 17 Dec 2025 12:22:11 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d193ea77sm1671485ad.102.2025.12.17.12.22.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 12:22:10 -0800 (PST)
Message-ID: <20d81e79-11aa-466d-911e-633eb66da727@linaro.org>
Date: Thu, 18 Dec 2025 07:22:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] system/memory: Define address_space_ldst[L] endian
 variants via template
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/memory_ldst.h.inc               | 12 ------
>   include/exec/memory_ldst_phys.h.inc          | 36 -----------------
>   include/system/memory_ldst_endian.h.inc      |  4 ++
>   include/system/memory_ldst_phys_endian.h.inc | 10 +++++
>   system/memory_ldst.c.inc                     | 42 --------------------
>   system/memory_ldst_endian.c.inc              | 14 +++++++
>   6 files changed, 28 insertions(+), 90 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

