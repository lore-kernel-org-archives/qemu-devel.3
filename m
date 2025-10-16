Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CB8CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Msc-0005lq-JS; Thu, 16 Oct 2025 08:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MsZ-0005lh-GD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:14:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MsT-0007jo-S2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:14:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so5228045e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616876; x=1761221676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gtl3ClU6xBzpfKdKR6fd+O5QQKhW4PC8dJF3m+7agAM=;
 b=zdnURsjvcElrCf1Qd0td+TpktennkvpcF48TfcOqRTYovLtMe0Ss7Do6yOzaai5JOu
 WPsvDX9EU1idLRAY0UbPAKSO8DkoyvrQZHjba+UWvJphyWGI6khUgQO7oORgOb/5wQtw
 O+S5jOAhYAUHtTczLkLDPm1Pqeh3we2bPVnjIRqD2vRD5BVeYJ45YjF4VEvBSaq8UZC1
 uQMd8A0hVOa3j7CQzZA0eKXUeAmYHMXd0H4xAIwOKZTHaveR6sRAjiDV1KFgBMz9pBI5
 qSpdWpKSLZWVEDenaE4HVaj8PUyym8PDzpcJE34qSYlUN4uCoT0cylODY90CAiBEQMPX
 LTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616876; x=1761221676;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtl3ClU6xBzpfKdKR6fd+O5QQKhW4PC8dJF3m+7agAM=;
 b=HLJG+q6fR1JmykomYwgT8VaI8OOMeWhfbC6P00h9Z2g+bn13nAt00bn5s8/w/of9vX
 QSlc07kPuNsLKBhcuzD0vX4kseCHuMH7wmlhjccbcQXhvdT7742NqkWAM8w0aef1bH9W
 d0lVzCLOZ65r9lbg44TpRSJGFrxVMBhKQ60X9jaqHNErd4NsCiLEQUQfauOw0mmu2QMe
 r2Rj9HCZ+grYxzWZPJhYB/PQOmAh8WNlvy+VidRaNsrWXp+NDv4JoYCgMfxFkY3FfQgh
 w+BsMmVleVZ8yKnfpPc8DCi9B6WwWfSY6oNkfhtqi67cuoTAmaOLXXLJEBVuHK2Df2Td
 NrDg==
X-Gm-Message-State: AOJu0YwqcFjLwXUQXopE4GmLoIWle0qOBxMxMSLsOLffpyLgnS32322V
 88WLFUEJW1ENXTM6yOpo/z6PuhssFOr8DWUfgD4EJY9DV1d5iBgLqaGSBjZj17Na3la1H4gzewC
 3kKdPatA=
X-Gm-Gg: ASbGncu09bgLVg4RGkeIJKGhZfg5o7ZXLxWA+NjAg9gYMEb40e6XwhLH50Fl+O3wEkg
 2eRD59TU8QALchIM4doEFWIpYvduUOm2sYfzGg3I4SYlCW3O3gTJNhZ/DjjjPwrSiB4BxbT8KeY
 onkwGo6uzke8dd1L8+rIoW8t5lqOdnjQkss3aeaz7LlxJurTUoSYd7v6qLzp2We2skULGucjfiZ
 755724LlEC78MTmk4R/fPg3TNQKJ0Ws3LUAs5RAWjcuamwBwpB5pE5FXX+29ddYwHT92HLLJKXZ
 SICa0tmto0vgDvCpVnCGJjNQuN1fWhAo5AVoO3Zs8UppKlbK08QL0BVwpJOp6JspamXZl0JCjzk
 lCGY2JEbpkFu6RWRlEUIyleqGCe10ESJvXQFazfFKKEDImL9iYaz8ZoTlG+d4rsZ5QRmcQVcugi
 xlsNdWzyAna2+hU1G2iRRTd4ssdkdWI2kNfk5LvY2AVKQbyBE=
X-Google-Smtp-Source: AGHT+IHORZV1h2C86K1d9BAwdjnDPOELSI7nC0lUJt5poPz8kopY+3Pcv8Ys/71/uXv1nVxvWYcPAA==
X-Received: by 2002:a05:600c:1990:b0:46e:37af:f90e with SMTP id
 5b1f17b1804b1-46fa9a8f085mr242024365e9.6.1760616875886; 
 Thu, 16 Oct 2025 05:14:35 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426fb279857sm5620550f8f.20.2025.10.16.05.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 05:14:35 -0700 (PDT)
Message-ID: <a45cff7a-7a35-4d77-83f5-462135a5d4a6@linaro.org>
Date: Thu, 16 Oct 2025 14:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Name gen_goto_tb()'s TB slot index as
 @tb_slot_idx
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20251010031745.37528-1-philmd@linaro.org>
In-Reply-To: <20251010031745.37528-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/10/25 05:17, Philippe Mathieu-Daudé wrote:
> tcg_gen_goto_tb() takes an unsigned index to the TB slot (0 or 1).
> Declare the argument as unsigned and rename it as @tb_slot_idx
> (which is more descriptive than @n) on all targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c         | 8 ++++----
>   target/arm/tcg/translate-a64.c   | 8 ++++----
>   target/arm/tcg/translate.c       | 8 ++++----
>   target/avr/translate.c           | 7 ++++---
>   target/hexagon/translate.c       | 8 ++++----
>   target/loongarch/tcg/translate.c | 7 ++++---
>   target/microblaze/translate.c    | 7 ++++---
>   target/mips/tcg/translate.c      | 7 ++++---
>   target/ppc/translate.c           | 7 ++++---
>   target/riscv/translate.c         | 9 +++++----
>   target/rx/translate.c            | 7 ++++---
>   target/sh4/translate.c           | 7 ++++---
>   target/sparc/translate.c         | 6 +++---
>   target/tricore/translate.c       | 7 ++++---
>   14 files changed, 56 insertions(+), 47 deletions(-)

Patch queued, thanks.

