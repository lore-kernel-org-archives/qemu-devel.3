Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A444FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJvl-0000t7-1o; Thu, 30 Apr 2026 01:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJvi-0000qw-Vb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:27:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJvh-0007Xx-Db
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:27:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so2445765e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777526836; x=1778131636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=apy2aRkw/7xjNJfFXgpkFfGlh7bXq2Gsr6zA2+oOEMk=;
 b=GMkoIxYoS6gbnWc6QBTE4uPlpUGudbBMVt8UnUoC4UdrWNXv3nvRYktr/aq4HeLS8u
 /97gixY6z2uKZO9tXZ+ke6L/mYu+P+qaZDf5sOtt+WDizAzGTAKQF17okRppOF8/6LQ7
 Tj52+/Eu9JCpHdzpxPhwjzjrgUF7gpB2OlpNaSrhyLE+kNOMQG8q+nCxXC0uJlWERu0r
 Telgc8nJ8EIB2AprByHjo0AJWgh71eQUJvEz7QzMu4LDxyKjtjYgymg03HB9gTfgMpC1
 OS4NdY32l59ulPA0bRArd4UkDCizMNvulf2X6Q7aoyEoDMGxEE8FupzqTcPs0hwi5vri
 i4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526836; x=1778131636;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=apy2aRkw/7xjNJfFXgpkFfGlh7bXq2Gsr6zA2+oOEMk=;
 b=KEzidmsBXnZVm38ny3j9TSsvxlyLM1xyb9/jGyp0EUO+TXjTvRkILC1mRr+YWyz4wn
 oPV4VOO/RyWyWc/PPI3mIvULZm/6a4E1Q9HFgUx2p/qJ90zpmFIa/9iBIBDsQ79MWhSk
 oBRPZGGja08dbKTqITQjs5B+InoV2+7ZDcC11aCQj6eE+/XZidXApJnZ2iBOXn+WsCMQ
 8UTddMaHw8bfmU2zmZn2Ukx5rYqvHf7PD1cZ7AJa65zU0mvBcdT/05za4RYP2c/xawR3
 bE/PHL0tFbZEN0nwN82N3Tw4sW4wbLrYgQ1Ej8/4NjrNFNv+XkEMU2N9FVnqxn9gnmWB
 JPog==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oaAI+eC17xPBQvVvk4VvSab0rbk6nD0Gqg1yvRUX8KsH5Qa2sYFXiu2xPg/HrKj2PLQc0S4U/Nzju@nongnu.org
X-Gm-Message-State: AOJu0Yz3wWuDS3W59Xkyn6OvLSwszBLTgVsJHVEHG/vScoQaXwmhmZOc
 CSHsqZSXF1gdDit5cG6baFtqFgIoPs0r2s9L1dWTd4x2gaFZ2ecbDxw0jz4c+6nCluk=
X-Gm-Gg: AeBDietRBFsFgNu/lbxnKAvTPcJw4EkJKhnAn7GKUtHiQ38yPQ0CWfe5DlLAQBH66S8
 1F03G+LFzPi5wCh06Uh0OPWXwuXtv5xILwJbw4hC36/+SX2MDFPuLsDlsWgBt9vNh4MJfxLNyQj
 0jqRN2y+s6bjcK0IIbZKACcpBdf4u/uNyS2a3e81TUjmqWMboqpw5ELIqsj08zj1zHokLwAtC7Z
 ZYcqUnkhd0Zv+F3sCyEp6L+LFdCNeNVVoaATs2FHbl1wQlyCnoKkS2HTMsJtb0Cc5fUTn+S3SpD
 AOyvZuw+TR6ectBzyl1cpJk8onZDYaBmXJLZs71aPCO2Z2zlzvbecCZgfy/lUjBjUa0dSSSb/nD
 NC9qNFgu4nzmiCpJRxNmfOhGXvGOdli3MCzxOOBfOcjkJXzF2LwmXfbHfJKtVTTLpyoVjqBQykn
 KcBFLyGkZF98xDslr1q3eoGQJG2AmuOnrSFdwYKBGfI/QzcBAK/peZnXlib1z6qm0wENfe7wLa1
 Cmd
X-Received: by 2002:a05:600c:4f52:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48a85e684a8mr14894835e9.6.1777526835809; 
 Wed, 29 Apr 2026 22:27:15 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c31fb8asm33685395e9.30.2026.04.29.22.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:27:15 -0700 (PDT)
Message-ID: <f337d463-c2c2-42fd-a600-de21df96a009@linaro.org>
Date: Thu, 30 Apr 2026 07:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Deprecate the shakti_c machine
Content-Language: en-US
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-3-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430052218.771358-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/4/26 07:22, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V shakti_c machine hasn't had meaningful contributions since 2021
> and is currently unmaintained. The machine is scheduled to be removed as it
> appears to have no users.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   hw/riscv/shakti_c.c       | 1 +
>   2 files changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

