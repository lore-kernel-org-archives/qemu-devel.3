Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FD8C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZsm-0008Hi-M5; Thu, 18 Jul 2024 18:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZsk-0008B1-UZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:45:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZsj-0006Oj-BG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:45:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70b703eda27so264582b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342747; x=1721947547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M5POmAzSHJWd3LsxdfZ6p2jXOAVgjxAnj8lvlyZIEkM=;
 b=Mz3I7C7NNOGdMpghEpDDCXFYGkaN5aqhQVqWtdSWuMGxqjNUzfQZcMziEQxZcBrUnl
 coc4wGlSNNfJBemeC8Ht3blEo9xSq+O6tRcIZmcGLQcOPuWHDyhzKW06GqIjw6MGCmCA
 mu0GNjYfBbIlBsf/CF537ODm8Zn5T5bYOvvxcsA+IcS+R9527tE6d0KWXKw2DDclSpH3
 x/hbHS9RVoMJIoCfoESQJWuxsWumyrzG/fyxhHuAgVzZmcKtdyH9/x7HmgUWSmLgLjRu
 P/2pPr1BZjTa6W/NpXZPO07aKGDgMrWf53dfBoyTKyKECxb7aeQLqv2TQhU5T+j23zjx
 QgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342747; x=1721947547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5POmAzSHJWd3LsxdfZ6p2jXOAVgjxAnj8lvlyZIEkM=;
 b=KRRPwiwpiQaQJ5l135J/4O51UrztPVqADQ6f+IlfsvzOPIoPjcDoa0wV964ANzE8tT
 d7bCX52HmtrIHXjaM2si83oU71hhMIwUG4jLQ5xvyRFFeecdUakanBF/croGLuGoTFx4
 2wqvl39xxM61skauxY+fqVkwzFTWQor1I0zySfezJD2ojJlD4fCUcLIuUcIdQLRRJqzl
 pW35pzS6wWwqMwGD9EVXH9LlizTn7qqHgmg7UX3HVW3SmIw30VayNIoADOC5t5Ou5Sdw
 MtfUK3CToVwY6Rt+GiqE/2PXfkJeY+SH5XrXLGOblqr0zc/bo2dF05sGwaiGZaRZhr8G
 o5Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI7sF+hRo7KrmYJ0+FxfAVamM4Frwc392iJ7I2k2ir/SZTh+xR2wPGp+oj4c2OnTr9C8MflxfKFelqGwmZkQUoJfDv9ms=
X-Gm-Message-State: AOJu0YyAdMEVagbAFmvJDmUICDxWSxvBtFyXg6U1fLVGI2YjZPUmMVtA
 nu4XdQ9biy+1pB/xIV9/BjgMNXBh9gegsqv8EiDBlfwCS4VWjg6QcO2LhbHgMbc=
X-Google-Smtp-Source: AGHT+IGJS2iPaFTK6H7BKRl24sAyJNPZ+2bsa7DVgv98endTAY1EKmo/OHXbL++cAFpUzl/hYLZD7A==
X-Received: by 2002:a05:6a20:c99a:b0:1c3:b231:33f3 with SMTP id
 adf61e73a8af0-1c3fdd3c152mr6860187637.38.1721342747202; 
 Thu, 18 Jul 2024 15:45:47 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb775416fasm1279006a91.53.2024.07.18.15.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:45:46 -0700 (PDT)
Message-ID: <02fa9779-10bb-43bb-92b8-5db7fc40ca69@linaro.org>
Date: Fri, 19 Jul 2024 08:45:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/18] hw/intc/loongson_ipi: Move common code to
 loongson_ipi_common.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
> Move the common code from loongson_ipi.c to loongson_ipi_common.c,
> call parent_realize() instead of loongson_ipi_common_realize() in
> loongson_ipi_realize().
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   hw/intc/loongson_ipi.c        | 269 +--------------------------------
>   hw/intc/loongson_ipi_common.c | 272 ++++++++++++++++++++++++++++++++++
>   2 files changed, 274 insertions(+), 267 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

