Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C71E7719C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1QM-0008Nm-L3; Thu, 09 Jan 2025 17:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1QF-0008NR-F4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:54:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1QD-0007gz-5H
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:54:38 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so17551395e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736463275; x=1737068075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UWF8YIz12GKR9/kal75h5Zlbk+GTvUxCMwpaex2Uy2I=;
 b=ySIBEdiuuBJE0N6Iw9mU+/vWhsfMZsJi3tTxLXC/9ikSEYiD8N+VsJ9BC833rd0jGU
 E/DHs0kWfUsz9ft4uHBI4Ry38Fgkt0HS+S43d3WmL7DWuUGlWPtFXKjMa2eNF7VMmK5e
 wmoY2VoZT/KQb5+Dak/WNpTIoxcWdu1/yn66hpawta0SNyqChMrnNVEYi+8dy7Drj4V1
 z1HLMPQMKJ2uodyXG9LcmaIoJaLHZmnVWwSiKPIr+sSZR+v2Zj6tXCsQIckbStyur9MR
 SrCW56h80fpRtRimtAVvOtt+Ej+rbdv+jiofcTMVTwQFXU1VN6UBLS+901NFIFHdBv6a
 m0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736463275; x=1737068075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UWF8YIz12GKR9/kal75h5Zlbk+GTvUxCMwpaex2Uy2I=;
 b=Z3kFSZcWR3ksNh7y4C4dZyJ0e/9G8SDE/w8EeGNZVFVJW6rga7sywHem97bBOO9ISf
 6vq6uVMrh7uioW/DW5qZj0Yj8JJGVSzM4NWHD04iG7jsc0wgj5rJP2mPIq2H35ivV4ZG
 lmaKo3+1ybUVTZyuZhtoUbvC5ygxQqnjbmmRYFSksPdErxXBUSmtJUP84Hm56YBb0z6j
 RvmpqaRZlS+OYktgw9ESnMg7AjYzhCD4KLDZVN+sOngxQSbIxlmqoewy3nLHCL04qb7m
 TD2nDmYRdDrFD2kzHBEjbNnARf7jZTBjq5QMafx1Hq3rSXURZvlRhDYr95jjZhvM7qBj
 guAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgR+Uf/51uS+aClws1785j/vDKAODVk6x8FNag80RSPSqKcokcH8GrjdnbXhQfvgCM/tnObBuvNvz5@nongnu.org
X-Gm-Message-State: AOJu0YwyE5RtylAMLuEb4IngULbHMJBsg4HdANz4kOyevK33CVnl0eYu
 0j/Lo8IRy9QAVt1BzV/d9tHkObEooFaJFqnZjY9g3St2S8WaAjIA6223Ueaapcw=
X-Gm-Gg: ASbGncsyYrE9mAPzqL5sm/RCHfIMlv2ouceFh6TgNDVjUn2Zn/k4af3/1VeNhbifnRi
 AEpUo9ZsHZDb/IjKaOyiBNrx39s11lfeoozhSwrVikuvm3WkbpLCUmbbdAPNURgcpYrBM6S8vXy
 v98680nu9AM/Ec+O9Wl6nOacTd6vc4Uy4MM415ShPnEAwcQiMrA4WDbf1XP4UFwmoswO6pDX8ch
 oA1d+1cgd3crQC7hgOKPCOtx61L8oXfCagf+7OBKS0DFUEXx3k0SryhVVmzN5jqvdSgif0jfqHt
 3TCdGUltxr1NjvpIlBwF5idJPF0=
X-Google-Smtp-Source: AGHT+IExM3cAzdmfftsrz7iL9DYpkFyWOD5uoy/FyEUcN+jmMIK1uzMkCA5TJjkpdAC1Picn+Bq7Nw==
X-Received: by 2002:a05:600c:354e:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-436e269c42dmr88619425e9.10.1736463275282; 
 Thu, 09 Jan 2025 14:54:35 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03e5fsm33563585e9.18.2025.01.09.14.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:54:34 -0800 (PST)
Message-ID: <1fde6753-46ad-4c40-964a-2dc9da2930bc@linaro.org>
Date: Thu, 9 Jan 2025 23:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 43/81] tcg/s390x: Fold the ext{8, 16, 32}[us] cases into
 {s}extract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-44-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Accept byte and word extensions with the extract opcodes.
> This is preparatory to removing the specialized extracts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target-has.h | 22 ++++++++++++++++++++--
>   tcg/s390x/tcg-target.c.inc | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 57 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


