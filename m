Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E80C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 22:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC4aI-0004MP-UH; Mon, 05 May 2025 18:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uC4aD-0004LD-PD
 for qemu-devel@nongnu.org; Mon, 05 May 2025 18:46:47 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uC4aB-0008VB-4r
 for qemu-devel@nongnu.org; Mon, 05 May 2025 18:46:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227c7e57da2so45801995ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 15:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1746485199; x=1747089999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2KwTryLmEqksUJDIgZll0D60lMMx29gqtSbxh/p9gkE=;
 b=k4WwuJAZF7Frn++b4S3+/ViqNDcY5FAdkogCLNaCWiyRh6GxLhEIVjEcEE4EIWl27M
 UhIjmoBKcvhadcGf6ijw94VgF2DMN0FN32li9i5M5VmOTP/hhJK1yB2i4eriHWsfgZDV
 kni6QEdjElqfQALMSvpxo+WDO3rPSrdKF0H8VLPQ5BgV1URCz4jAey9uBbXRyMj4xFHK
 KNjD4gK3AU0mG5Fq7jJdsFIs4JM0qxAgxyZrwE+NFsh5GI67j4cndqKBsnb+giLxqaKp
 4g9q9/m9pwqsNYBu6ele7+Xg8W5qm8jcJrZXI3sU0Qf7V2MMcqKCcish+bgsCcRRo8m9
 Ldfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746485199; x=1747089999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2KwTryLmEqksUJDIgZll0D60lMMx29gqtSbxh/p9gkE=;
 b=I8vzglfrL7mGW9zJxHEFIGh51LX/2TMhAJl5HXpowmiRQdYmZi4Wl5JX5yb5jDOj0n
 ku7rcx3Q9V2qC4a355N945mUgHEfSQsZJy0okkvUfSfldsR2I2Wt+BkNVXvLmq1sgLQx
 U+gnV5kMndR5MhWDm9DPHbPJBr8Ak3HZ8+weOG9LyvWPG44s6D4lETilTIJd/GWvtmv+
 2KNIjZTqBrEX1DxlnjzviDhitHo9O4iw9CH2ZTgi9SkSHlj6d4T3fF9cYiXvGg0pSOB+
 L8JyIZYHqtXKWaK2tRLvLiI8rOnbu0mYpeg585jpUoeSJszowYeDqhod7L5bHcf6a1Q1
 fFfw==
X-Gm-Message-State: AOJu0YzywPshAsv1MQSJRlv9LF6tJy88DlSv5UlZzzMQ+OnYXm9H03yi
 j5jV75Z/XxUn1dtW+aODUe1xnAy0bUJ1Du8cVaJYRS5GiUOECmx0lu4VrnD8AIiMJPBxx2P+9sl
 k
X-Gm-Gg: ASbGncsShxGfJRYSAzw28P9PjsgNMGuIqFftQW2QZRctgfrlZ+EiN6TRGM9bXy3QP7t
 JLYzLVVF80MzT+k3HZXux9Cr6m4zLV/HexDJb+PMH/N+mnUDOZPWJikIky15AchcQUQn19MmgEZ
 DeOLD5VtdHsLvYq/ppOdySCOrXbfE2hZ57zOwrPHMMmLBQF3mL3/zTYUT/c39ymhr4LIkWuopaN
 Hc61bP7WgQhVaDZB3nWAegAzRnDeDSY/a2cof2CORwzj6+J0/WMxw15wBAI3I8r08oTFFB1HCiJ
 xdwEA2GfJ29AkQEHwc9hjZ3LpaxVJ80ttLP/eiKnArgy+VOayAZT3ng=
X-Google-Smtp-Source: AGHT+IFn59gU80SCvXAwTG7A7Pm9vFPyAmtbUf0C1Yt+15LYhmTD3Y+bxUNsXsq/dZZPeHPz85ufpg==
X-Received: by 2002:a17:902:f649:b0:216:794f:6d7d with SMTP id
 d9443c01a7336-22e33136152mr17017485ad.48.1746485199476; 
 Mon, 05 May 2025 15:46:39 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm60652855ad.137.2025.05.05.15.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 15:46:38 -0700 (PDT)
Message-ID: <c969d9ce-626a-4928-b050-7b7fbd8f7981@ventanamicro.com>
Date: Mon, 5 May 2025 19:46:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/riscv/virt.c: change default CPU to 'max'
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250404152750.332791-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

Hi Alistair,


I think we should push this upstream and see what happens. We'll have a
full release cycle to undo the change in case we find unintended side
effects. I'm fairly optimistic that this change will be a no-op for most
users and will benefit us when we'll have to deal with RVA23 specific
software.


Thanks,

Daniel

On 4/4/25 12:27 PM, Daniel Henrique Barboza wrote:
> Hi,
> 
> The 'rv64' CPU, the default CPU for the 'virt' machine, is a strange
> CPU. It is a collection of extensions that were enabled/disabled as
> extensions were being added in TCG, and in the end we ended up with a
> CPU that we can't say exactly what it does.
> 
> This is further aggravated by the distros move to support the RVA23
> profile. Patch 2 has more details, but long story short: distros uses
> the 'virt' machine, and they'll start building on top of RVA23, and rv64
> does not have RVA23 support. In short, distros will start to break in
> the default 'virt' CPU.
> 
> Changing the default CPU to 'max' will not cause (intentional) user
> regressions: if the software runs in rv64 it will run in 'max' too given
> that we're adding more extensions as default instead of removing them.
> In my opinion this might be enough to avoid a deprecation cycle and we
> can do the change for 10.1.
> 
> And yeah, patch 2 mentions the already old trope "and ARM does the
> same". This is intentional: I want RISC-V code and usability to be as
> close as possible to ARM and other archs to promote a more homogeneous
> experience when developing and using QEMU.
> 
> 
> Daniel Henrique Barboza (2):
>    target/riscv/tcg: make 'max' cpu rva23s64 compliant
>    hw/riscv/virt.c: change default CPU to 'max'
> 
>   hw/riscv/virt.c            | 2 +-
>   target/riscv/tcg/tcg-cpu.c | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 


