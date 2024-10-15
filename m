Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0969FD216BF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ivZ-0007Sb-R9; Tue, 15 Oct 2024 10:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0ivX-0007Qk-Ie
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:53:35 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0ivW-0007w9-6k
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:53:35 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ea0ff74b15so3304329a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729004011; x=1729608811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9KJN/B/s1bQm0ID/aXGKN/rQyeIUkYjYZeuGStJvZoo=;
 b=tFvcHmQ++2G/lxqZ8IP9W7YOxOeDJTIukXC2Nb5Td51yfp+n/uA80tVteDjl6qUtlN
 zSTiZZISJ5uqSA/Dkew7GyQYVfFNSim2TMcx9be/gUz/OjgMAxfq8lSptPEvuAcsM8RE
 G9saArcHjaBL4pJ1Cazt/BqVooNrhGbR7O2eNWV9mJQrUdHNxGgaCeiq3yTJ4C/8NVyw
 GcvpAa2utazDFmwtfPIc47fKDj0cNwSebKX7/a1Rnd+YjF6HFlqIsASSz+Y0ULT7GXP3
 9VaTxS1kmfrPcCoebwROUcgyGQU1Juql9qlmVUVVzMCdQVa1xDU8xciHmWdYN8xq4UDV
 ZXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729004011; x=1729608811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9KJN/B/s1bQm0ID/aXGKN/rQyeIUkYjYZeuGStJvZoo=;
 b=EdGyHfPevqLxx1cVJGf19q63BgvfQ1jNP5UlakcSXrX3/n6luJo0Hx2t5CJXf4BZld
 /4ewanVqetNcGOBJ5pKt3MCEfOtlS4/bQttCEGHUkPOOjCOzjxOWM1T38nZ9npOjgq+6
 FhiY25HyL/1MSjYEgrnv4ae7OLxlV/1K2554/icYiLvykuSckcgAkKEBTkO0uaAW5pEL
 ew46p+n0qZu4GfVxx+Dxh18vTaMWmB3Ncnnvmr/2QKbmCCkxkREsm26iPQAwSkTcZmme
 oCZE8kNiu46iUGOD7BuH0Oc+jDccMU7Wv7QPuKWWR1bVlDuCoc5GpP77qQRN5ud7LLze
 JAZQ==
X-Gm-Message-State: AOJu0YxdDhtRZZgtnbWyhNc2Gi/5nxE7NBOc2vtaDFeG4H29g1yvC15P
 MP89vQJUzS3/ZDbAgyv5w5cYL0ZNiWE7LbnOaX/SZYD+La3j31uLpMXAw0Rf7fXRP42baojH9wt
 Y
X-Google-Smtp-Source: AGHT+IHT5TpJe/uSmcXpNzZYC2WPqI+7fcudzsRlKLfod6wP4zrzC8v3Eo8SdKB477t+wXYJyf47Wg==
X-Received: by 2002:a17:90b:2313:b0:2e2:cf5c:8ee3 with SMTP id
 98e67ed59e1d1-2e3ab7fe655mr544223a91.10.1729004011359; 
 Tue, 15 Oct 2024 07:53:31 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392f02ac2sm1879991a91.28.2024.10.15.07.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:53:30 -0700 (PDT)
Message-ID: <70d4b9d9-a2db-4279-a37b-817510ad735b@linaro.org>
Date: Tue, 15 Oct 2024 11:53:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20241004202621.4321-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241004202621.4321-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/10/24 17:26, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    target/mips: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
>    target/tricore: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
>    target/ppc: Use tcg_constant_tl() instead of tcg_gen_movi_tl()

Series queued, thanks.


