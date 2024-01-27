Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2256AC47DA9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaAX-00080G-J9; Fri, 26 Jan 2024 23:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaAW-0007zz-9M
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:19:48 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaAU-00048N-PK
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:19:48 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d50d0c98c3so20086315ad.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329185; x=1706933985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CVX2edzfuKRTworR6gJh/3EPZhRhdIcw6pYfZSQqd3A=;
 b=BlJ+ck0wkK4ZDV+v4gFHnqcLwGEF6bNMcL3k3BOx1j2f/SMD2Q/p2fCC/G1wDe2bgv
 8oZLl1Vv8kzNQa/LZ1G3A9xS9lifS44LSzy+ZoL/XxjJ6VfFgA372xIIbXzAuBqycD9M
 TgWNwzYHjrV8NcIE3UIENfEsT+eQSad4Y9jL5pE/apKqwVBzDllDaV5KGUPcdqYdPai+
 t/kXfpCMd7kp5c/daJbpmGV1G9ipZoKLcEaspE2DecT9AIBiftzAsGvp7zFrO2qvAyvK
 1x9Au8Ujgj6Q/LtNQnMVqNCmuwSD60fN9ttBak+RAJVCExHVx6npr0KQKL7KpIeI0DUW
 5fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329185; x=1706933985;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CVX2edzfuKRTworR6gJh/3EPZhRhdIcw6pYfZSQqd3A=;
 b=BStvwgWjPYiS88zLYFfa7WYUs+llYdEykXst3FxGj/gqovFfs3dCAN76Qvib+r0yl1
 FsCnm8E4DDdzhsOjR5Y7TrI9GqGioKF2RkDGztSaaYHrzgDJ586A99WGkobwnGWQlCz3
 MbE/lq+wYwHUpU4n+NhbF9/2sRE5U+zugpLtfnvtrqMMKePH629ioZPytdi3j71h8gdJ
 E2730LrrHpuo8YKTrOFsRJn4XYYV/jSc4SztsaU7LXuwQE7Bvx8PPVcehoEeWS+5agOE
 5g/Sp0u0oR3ApuzSsQNnz/D6yyfATuDlgX+v/QBDM57BvnApiU6N4cOqizmMb5mJZiCd
 GwvA==
X-Gm-Message-State: AOJu0Yw/X6o/VK6nBPPLuYgoJhl0IzP29jEomXzNU3Ltq5dUvOc6BCZA
 oD+AAhPgZAw9So/6Hm6E0tQWcuRUmcwJ8pTdw4kr8K1cB392Ak0p5iWvoMUzPO8=
X-Google-Smtp-Source: AGHT+IHWqmJO1jONK4ag5QfW9KshB4TJ0wVIDE43PDrCRTVnLOZTUgHA5aMHnl4qfftAtpiePZhKjA==
X-Received: by 2002:a17:902:c412:b0:1d4:2c93:39e2 with SMTP id
 k18-20020a170902c41200b001d42c9339e2mr1186910plk.61.1706329185044; 
 Fri, 26 Jan 2024 20:19:45 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 ju4-20020a170903428400b001d785905435sm1663327plb.28.2024.01.26.20.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:19:44 -0800 (PST)
Message-ID: <dc45aa3b-a313-44e8-a726-df02b90105ee@linaro.org>
Date: Sat, 27 Jan 2024 14:19:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/23] bulk: Call in place single use cpu_env()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
> Avoid CPUArchState local variable when cpu_env() is used once.
> 
> Mechanical patch using the following Coccinelle spatch script:
> 
>   @@
>   type CPUArchState;
>   identifier env;
>   expression cs;
>   @@
>    {
>   -    CPUArchState *env = cpu_env(cs);
>        ... when != env
>   -     env
>   +     cpu_env(cs)
>        ... when != env
>    }
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c             |  3 +--
>   linux-user/i386/cpu_loop.c       |  4 ++--
>   target/hppa/mem_helper.c         |  3 +--
>   target/hppa/translate.c          |  3 +--
>   target/i386/nvmm/nvmm-all.c      |  6 ++----
>   target/i386/whpx/whpx-all.c      | 18 ++++++------------
>   target/loongarch/tcg/translate.c |  3 +--
>   target/rx/translate.c            |  3 +--
>   target/sh4/op_helper.c           |  4 +---
>   9 files changed, 16 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

