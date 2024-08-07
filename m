Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1CAC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbWBR-0001aj-95; Tue, 06 Aug 2024 22:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWBQ-0001Vl-1h
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:13:48 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWBO-0000RT-JO
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:13:47 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70936061d0dso875644a34.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722996825; x=1723601625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lyHZ8QyMRXYtATudGdNQyXw9EsOe/vp7iSFzfhAImlM=;
 b=Z15GqNJ/U55CCMLUaML+bJQEHHJS2xabUFPCH3FDXudkXXuqVduUGVBJQCvE0q+N7y
 eKXFlCgI1Z2mG/1v1iQQJCzPDac7pkUJVZlgww+OJVs80XYKnCGKxddzqaQfp+bUxL3m
 ggxeC/yQt/q2r0ZtLipk1SoYKVAB3GC32DR73ZTDzccxFYUmuPngOa2A2qt7HauvpiQe
 dkBYTCI45RUZbT16Pz5x6UTdeHDPq8tH1GyD3nNS8Mc040jKupckxrLRJ9yuxonbokgg
 JWMb8QTdzbbDCvnIi7hXrFaaBwHHm+3SibB7OR5tvBEDa1vAMpjuNhQd+jbmGg8sa2xx
 iIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722996825; x=1723601625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lyHZ8QyMRXYtATudGdNQyXw9EsOe/vp7iSFzfhAImlM=;
 b=mvpvu1uI4v7KTJh5F8ZhByPqb0vDshW9jwITKyWQsA5n3cAmJ0LOTUMSU2OMcaYxPU
 WFe3CGrOivu5o7dMbitlMv2hQxlq3IXCrUiQksnsP3kBdHiucxw8zTcZ4GQ/oRNRLHNh
 wZJH23Tpbpjgvb/toY9EnFND3AW2XvP/rHPx/5o50YposgY00B4Yt+P0hFheJ5Qju1YV
 8pdXBBMFFgpUqaOOUAgW4/MHOhjhtDGTcoSZZV85g7veTgv1HCutx16mBpgp7OBOhnb/
 bqbPCN6YCCdOPO6Yjdp4QhW8JmzZtpQcd39RNuQdDm0/a4+ESpvvRmtTKipZXNSiooq+
 6N6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu6QDM64lR8uft6DQVHamODt0FeovZ9Ijcb7jhBEQekTjXziKd5dcuUB6eZc4LX9btLp+Gg8Q/9GtAAs9DIayPGPuMunc=
X-Gm-Message-State: AOJu0YyPnY+5gbjJhiU1zCK6FzhJxgYO5LHD1TiZuWYjx0FaRjL2ujpw
 /1gVheGScnMjtvFNnlLVdxscVim2W6ZIodaB2P7/cSiCP/XpDfsaTLeXXrA1ntU=
X-Google-Smtp-Source: AGHT+IFYQ3eSsf5AV2g/LGzqXOsvXwXIDPNuIzJHWtl6XzL9lHzNZzYv0FrLUZPG5YPoZY/vDPMarg==
X-Received: by 2002:a05:6830:3808:b0:709:33ee:f578 with SMTP id
 46e09a7af769-709b32177d7mr20502184a34.14.1722996825295; 
 Tue, 06 Aug 2024 19:13:45 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b76346a9absm6380299a12.29.2024.08.06.19.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:13:44 -0700 (PDT)
Message-ID: <d9764ed2-b898-445c-83c2-7b21fe3f4663@linaro.org>
Date: Wed, 7 Aug 2024 12:13:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] target/riscv: tb flag for shadow stack
 instructions
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-12-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-12-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> Shadow stack instructions can be decoded as zimop / zcmop or shadow stack
> instructions depending on whether shadow stack are enabled at current
> privilege. This requires a TB flag so that correct TB generation and correct
> TB lookup happens. `DisasContext` gets a field indicating whether bcfi is
> enabled or not.
> 
> This patch also implements helper bcfi function which determines if bcfi
> is enabled at current privilege or not. qemu-user also gets field
> `ubcfien` indicating whether qemu user has shadow stack enabled or not.
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Co-developed-by: Jim Shu<jim.shu@sifive.com>
> Co-developed-by: Andy Chiu<andy.chiu@sifive.com>
> ---
>   target/riscv/cpu.c        |  2 ++
>   target/riscv/cpu.h        |  4 ++++
>   target/riscv/cpu_helper.c | 30 ++++++++++++++++++++++++++++++
>   target/riscv/translate.c  |  4 ++++
>   4 files changed, 40 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

