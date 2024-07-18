Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B82CC3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZpg-0002us-W0; Thu, 18 Jul 2024 18:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZpe-0002ln-7q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:42:39 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZpc-0005ga-Lb
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:42:37 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb0f5ee745so567425a91.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342555; x=1721947355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dh4z29QDRZDsmC+kf+CdJyIo7dPtd+ZXJiGGKUwWYuQ=;
 b=qlm7ApI5bhowABD+4GqTVFhicJDVzkU8/XXjPokkcFYdIzh8K4Inr0OE7dwrv7iyvw
 Cxz9oZuFG4d0Sy4PzggbBwnNFzuTH+xaPMZkFdnuzpVohihv9MAJ1WNpiX9dPbGusAfN
 hCw/e+Btl6A8T3Tr43L4Z7tosOgKFkIBmxj5T+hjS7MJDAl808lS4QuffSW7i7ZlIToP
 OZFGiZRaqj5sD8lFHc8dwFHuJyXBRpXWeggueVwMScrwY4ZJepBa5RlHIm7edCgaVvd6
 lDP5euYOelp6DkllcGMnYeNpjtBOQy9DXXlz+5/ydTzf1ix4cbc5nR6B2WmbkF3c/qaU
 /uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342555; x=1721947355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dh4z29QDRZDsmC+kf+CdJyIo7dPtd+ZXJiGGKUwWYuQ=;
 b=pE/S8X6lCT5eYzzVyK+fkWe61MRfDjBcXmqyPv0L33uZfxUvR64O0xKPoig5SebdCs
 eiEruHqLk3VWxhFEJYvquO3lY3hAVdPyvqd9r5O97kTXvTSOpKIwja0IVMxTyajlgnBz
 9+at8nzxbO2iw+5GBItU6T14xyojm2ppMuwtFOy91XHTp194Skh1QTNvq9ClCCFVz3qz
 sxGz9r1w5ViG86lJvyA1era1qxKgcL9GcC49lbQmpFOhtpcHqaiBb5mus3656ncZN8zt
 HLqfjgrl+rnI/5nI84y4FvFpZyog8aZkh2gTZBKwqElkAXW/M0DyPfe/bs/DOSF+vVBk
 QHow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlhh7fj+O1keFXEd1ciJ6JAH4Q1NWdN41duWcJpQZFNU4EXYDVdLBDX2fPhJeGOu7eF8BUUxM41BhOBuZXD1c7F4J6G+0=
X-Gm-Message-State: AOJu0YzOU0nvXgCTgO1S64aTINTnIIweho1i14TWsm1rBF0wCUPEdPYz
 n2FY/PYwRqByBXrpLMW0sAPCIb5kbcKrY/mujTGWjRiWb0jZs5nvVhmdB2ROhv8=
X-Google-Smtp-Source: AGHT+IGiRxxGqJuZwapxiZ/S0kpmuLfxMZ9FdGzZ7PjoVfB3EM/DkZgJEe0ut3SwxcVpB2vpI8xBew==
X-Received: by 2002:a17:90a:9ce:b0:2c9:679d:78a7 with SMTP id
 98e67ed59e1d1-2cb527bc717mr5257982a91.25.1721342555087; 
 Thu, 18 Jul 2024 15:42:35 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb77304a15sm1292771a91.19.2024.07.18.15.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:42:34 -0700 (PDT)
Message-ID: <8a6cf7f4-5159-461a-aae8-39ef5ddb47ef@linaro.org>
Date: Fri, 19 Jul 2024 08:42:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/18] hw/intc/loongson_ipi: Pass
 LoongsonIPICommonState to send_ipi_data()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 7/18/24 18:38, Philippe Mathieu-Daudé wrote:
> From: Bibo Mao<maobibo@loongson.cn>
> 
> In order to get LoongsonIPICommonClass in send_ipi_data()
> in the next commit, propagate LoongsonIPICommonState.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   hw/intc/loongson_ipi.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

