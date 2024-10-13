Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92336CF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 15:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t00tT-0001ZJ-Tw; Sun, 13 Oct 2024 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t00tS-0001Xu-D3
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:52:30 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t00tQ-0002ZE-PX
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:52:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso439210b3a.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728834747; x=1729439547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LTwSA9Db8z7OXZHseNSAYbDLSXpbWvFl04pjymsu+Tc=;
 b=A4aap5LU0eOzm9TemcEyqzCQEI+H2iS/uHQDPN2S+vkA9E1XnAgBnOxI6zlDHS56Ni
 8YZy4D2rrV17xg/nUReIbQpoauC++8jGqq8gPswKvBFi7kzQzVbBzhfw5vR7kjlLhKLu
 tsPeLuUnO/9jgqrhYJMhZ8qPx+cDpH1TAGOomAlIIUcUrOuB4T8E9FjGyJ7UAY5kbtqF
 bBwzq6vNhg4+jkgIyxXQ9rItpQosN/8cQdNgtZdzEjvRs9KWnHQ/3OLbh3EkuoSBgQeX
 61KcpNPSGFiowlYyE88HxmSpZYV1NK24BDFMnM6HiqI7uewW6gZI3BPDL5bGXxB7FTYC
 7eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728834747; x=1729439547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LTwSA9Db8z7OXZHseNSAYbDLSXpbWvFl04pjymsu+Tc=;
 b=e0ACADDU26tlmYf5eJKNYNHg0j5WyBb+pTxWEonX0rZM1TCbAxRHeoJ9/Dh8UhfTy9
 FAY8sObxNxV6fJLz0fv3xSjsU6N1K/znByle+uM095c+tvuulTJuFoXegyKm/FASL793
 0O6yK/K0IiSaM8pbApgwIO7tr++l4tsbNpFzbISAvSjVi0FNggv2YgJXfb+zN2X4KLVf
 8xb1sO0Gj6QQtUe7W7Xg/wjKfzNftBTo/rQ55cp66024PcAWcGMNIvuxvJVw5Ojk7CeT
 LNETssEuRfSORoiyB6vHX+CRB0OtrrKiUuzGxYeilp0V2Tq0C3IUNcnj2U8KOja89lhS
 tASQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS9H39g9pPQuno4h+l72QrbG9oSXlj+XV0fy/XnDmQalXC0yFb1H23JNbmIfw9xHFOvO2J8XqoGnRY@nongnu.org
X-Gm-Message-State: AOJu0Yxu0Y8qibKEeuUmV/EumlXXuogpTmC+JwlwD/ZJ5ESizXiDrVai
 yRgQ1p3zuMRT7/IgcHRdPbE4794Izz8sk5SgF5g4PsqElyFfKeAoAisgYDeV+VA=
X-Google-Smtp-Source: AGHT+IFOKQAxyC5dO7WFAUZ10PXpaqiUBSG4UOjnLlI/n7J/gyhuy/5hK+OuT6QGzu+RBzlvh74++g==
X-Received: by 2002:a05:6a00:22d4:b0:71e:104d:62fe with SMTP id
 d2e1a72fcca58-71e4c1bfbcbmr9665170b3a.20.1728834747356; 
 Sun, 13 Oct 2024 08:52:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e66928210sm358174b3a.107.2024.10.13.08.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 08:52:26 -0700 (PDT)
Message-ID: <6c7a3069-e620-4eca-ba0c-5ef83ae355c2@linaro.org>
Date: Sun, 13 Oct 2024 08:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] target/mips: Rename cpu_is_bigendian() ->
 disas_is_bigendian()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Methods using the 'cpu_' prefix usually take a (Arch)CPUState
> argument. Since this method takes a DisasContext argument,
> rename it as disas_is_bigendian().
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h              | 2 +-
>   target/mips/tcg/translate.c              | 6 +++---
>   target/mips/tcg/nanomips_translate.c.inc | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

