Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DA8CED241
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxv7j-0001aB-TM; Mon, 07 Oct 2024 17:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxv7U-0001HS-3r
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:18:25 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxv7R-0001A7-H6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:18:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20ba9f3824fso36651785ad.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728335893; x=1728940693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WUs1MzGBq8oTTzLkkmLgPiacHYjlN0lvec1dDM3ysJs=;
 b=FcnZECzNIO8Ip4t4zG8gtEu9WarzpbUd6Gv48QhluldaFemX6yP8puSGTgQWMgfhdK
 t7izS5XneMWyEDb+2dWiGhUT5D3cYv261Fp1DKusELGmJu2uawPgNSgsst1R9m5EwaKV
 F5x4cubN5Mcsiw7f4tw4xE62KBcJvw1W/z966tHkFS6FBuPdsNJlin6E8DO1NknOlFYu
 xQkJMZjCzjQjGzIdd90patoSXtxbFMAHn/qdIpfpgio/is9voiExxT4AUKJfDyDI3rmz
 4utr14jtJ45hQ0MGEf+ooghBZW1BK6OVYOzYn+4cJZvHe7qjpJIsqF/0XBuphacWeMcR
 68YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728335893; x=1728940693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WUs1MzGBq8oTTzLkkmLgPiacHYjlN0lvec1dDM3ysJs=;
 b=prJ18xSginWJJ5VZhDaNRyJqLZigHy8KzbluOR7DI4IlN38v6cuGTHvo+NFVVidaCQ
 rgGRw020A43TYRQj8Ub9V6MF/Y//MF9zH5WZXmJlntO/M34Z0Lwct4Y/a8xdPklusi0b
 2L1h69PlFAIHf0yhxHbHcupbM504S+wRKH+ODY30KWQktkTXWQXeU3CcdpshgAhkEjZb
 imFVcR7EVR+G/2leK1HRZ0EqpvQUcuDFdPmuHPrsifHzLi+KnkpDlEZIH7uQ6SpojB9s
 3RTmTj+6N+gqULgAb90Ym8M+OcA+GEzFNy/4lmaE50Kbs38vz6qGSRwHh7A+W/Pzt0+u
 SZKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUPkjkAPdVGhpDCowlXamVLPOrYnEvYXtOeXbny0m7I8H67P5HxaIeEHC5eMHnUV03c8YT4VJvL7At@nongnu.org
X-Gm-Message-State: AOJu0Yw0u4PMbG5rZjxi82qOPCLceq7rq/Z8AF0qErEGMcSUmc3f6OYm
 9SuW2aHly3cl9UKQO1ir6KLM2siq3wRVfq2EcfVLGPHE+0AedRnskVbiSOYENKqwhbhndL7a/xF
 E
X-Google-Smtp-Source: AGHT+IHLjxdI73ZFA1uACTxTQR7LmFrpC2nLEP5ovsgcbR9VpKeVtrR3TIrUVb4iSlbnZFd2IgsyBQ==
X-Received: by 2002:a17:903:230f:b0:20b:bad4:5b6e with SMTP id
 d9443c01a7336-20bfe292621mr209530905ad.38.1728335893666; 
 Mon, 07 Oct 2024 14:18:13 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1398ee06sm43758895ad.288.2024.10.07.14.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:18:13 -0700 (PDT)
Message-ID: <88485d15-b86a-430e-91e0-0225ddff5849@linaro.org>
Date: Mon, 7 Oct 2024 18:18:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] include/exec/memop: Rename get_alignment_bits
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/10/24 12:25, Richard Henderson wrote:
> Rename to use "memop_" prefix, like other functions
> that operate on MemOp.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/memop.h           | 4 ++--
>   accel/tcg/cputlb.c             | 4 ++--
>   accel/tcg/user-exec.c          | 4 ++--
>   target/arm/tcg/translate-a64.c | 4 ++--
>   target/xtensa/translate.c      | 2 +-
>   tcg/tcg-op-ldst.c              | 6 +++---
>   tcg/tcg.c                      | 2 +-
>   tcg/arm/tcg-target.c.inc       | 4 ++--
>   tcg/sparc64/tcg-target.c.inc   | 2 +-
>   9 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


