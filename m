Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4D6C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKVmI-00044M-Qj; Fri, 21 Jun 2024 00:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVmG-0003x7-Is
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:21:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVmF-0007qG-5S
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:21:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f9de13d6baso8003615ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 21:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718943689; x=1719548489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IJqQVbfedTquPb0+nCNC2G5Z5S+6ydxq9SYZ2N2JxKw=;
 b=ynbAXOsYQtaOw81ou9elI5glKjEhToOGKUkgCe/PTC5xr4BHQaqeUtgnXGRjhkD5ba
 sbAE7zwe3qlPebKuGJXcSxOeYFQA7rw/U5ZyNeJAzugvyfle0LBnLI6E23le+VN2n0CY
 dr/yDKlsT8fDQZvTag7a4ntQKJ/qnTotlXAOWuv+QokrSij8kDBPIIof0sT7VP5Qdaxc
 mZOaG2ECgmqcgos8izzSg7O+jUJwuZh8Rdp1Npu13ehiKiqDbOCpXWByqqyWUzgyAQUJ
 hv2YiIOd0nFZfOCSplqvTRyxl53BZZ4X4U9Wl4I7ToEOMQpcQ5BDewf2hrXKCYTyS8D0
 AYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718943689; x=1719548489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IJqQVbfedTquPb0+nCNC2G5Z5S+6ydxq9SYZ2N2JxKw=;
 b=BjoyeGyL38GK25ZuzE5k9rOow/J3XxVFVPAeOlcEcF0olT9LmP9TpPqN2/V5CV0L5c
 Pw66YSBaKWsVYDKK7azaR8h4UmsGq27pWuBJlrOe4yBHhDVx5AyRQh2QLtu/4TO2mm72
 CBRorQo1U2oklj77Q2QbcdFq0zDpZUXW216N7Lgo6JuRfdSqOIEiuWI+kJ64WFqMBe9G
 nY6oRR2T0TRH8bslkM99QJ2EvEb5+WntjsVR9vDKve0a72OJINkQlgNE5tMr7CkyPrLv
 bNkLiviuI7wqfl1uhcgRXH/04YKbO5OqJCjULq9rw3xpXvmro+VMEfyDw2LXXtVlNYDw
 bm3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkw35fW5KbvWqSEW5ml3DLBt3fb0NhCtQ6cZIEiD/SMzTnm6Qjc6FuzbuhioqzM3i2XvS1kb+GYsUxwtvutEzN9kyTOVo=
X-Gm-Message-State: AOJu0YxeUyhJBSUUMgJbyAwfc/ybRWuXTVeL6j8mnp9E2o6DiJ5CfevX
 y/8iHc3QRChU6XYE/eWmjEXnIYdOeIbAHZzJ2U1f+vlOJTS385hU6RVwrMNnJYA=
X-Google-Smtp-Source: AGHT+IGcj8a2Whr1DbYoa082s4blT2imJax8kZj2jv4mCoMVx3r2lYW8IgiqIpgWCI1T2vvcc6O36g==
X-Received: by 2002:a17:902:d491:b0:1f6:1c1f:f32f with SMTP id
 d9443c01a7336-1f9aa40fd32mr88515885ad.16.1718943689220; 
 Thu, 20 Jun 2024 21:21:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb320673sm4519255ad.78.2024.06.20.21.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 21:21:28 -0700 (PDT)
Message-ID: <3faf6561-804f-4d1c-8204-f4bb9f7a3b94@linaro.org>
Date: Thu, 20 Jun 2024 21:21:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: pass code of conditional trap
To: YunQiang Su <syq@debian.org>, qemu-devel@nongnu.org
Cc: macro@orcam.me.uk, philmd@linaro.org
References: <20240620234633.74447-1-syq@debian.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620234633.74447-1-syq@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/20/24 16:46, YunQiang Su wrote:
> @@ -4553,7 +4559,7 @@ static void gen_trap(DisasContext *ctx, uint32_t opc,
>           if (ctx->hflags != ctx->saved_hflags) {
>               tcg_gen_movi_i32(hflags, ctx->hflags);
>           }
> -        generate_exception(ctx, EXCP_TRAP);
> +        generate_exception_with_code(ctx, EXCP_TRAP, code);
>           gen_set_label(l1);
>       }
>   }

There are two instances within gen_trap, one of which *does* store into error_code, but 
that gets overwritten by do_raise_exception_err.

Search for EXCP_TRAP.


r~

