Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06163C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZnd-0002MH-1k; Thu, 18 Jul 2024 18:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZnZ-00029h-Jw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:40:29 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZnY-0005Jm-1f
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:40:29 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-75ee39f1ffbso921928a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342425; x=1721947225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHp50MmDVUTH9w1ec+YlDJOUhxIcrkuiYu4S3QctF5Y=;
 b=O2KIzf787tFAksgnUi7kbTX55iJD6U5WmbPAoCKmrFWrGtl6t11Rhp0r0uEvGxf71k
 N+UQok1VCVo3nkh5HyTmjGm8rKX/QkKhtRyw93M0bISjdpLCJgiztHujbJO15EdR37JL
 D3ijjzz4jtHPnPgZTsAL9ks4tdxyu1behMTfDtXRjzwgNkfZT21IFHa3wvjxedEi7YO7
 kHrgC6WzNugzANDIQGOI3ALSgq8vtZ0AnseadwsOxoHOF6E43YAk2W8/QT6Sb9Ju7VlV
 UdgFwkekJDUB0w8+Ep7ovIQdkjDOZsHCpiqLl+2SBb69PvhTQi2MW68iLSB4BT23fB/x
 P79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342425; x=1721947225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHp50MmDVUTH9w1ec+YlDJOUhxIcrkuiYu4S3QctF5Y=;
 b=CntR9dQbvGuemjTGPnaYPnGvQxe7jpbbbmnfgOCvC94KRoZPcHPAVUbmhCazbnkQf9
 2M2Jq7mYl82Nopz+U7k4GD2oA5EcM2CVa3iqJCUTTZEfzz9c4IQXCcIQy/1Ba80fiAQX
 bK6HPZpW+sJXK8DckpUxh0/1p5SX+FWss51xDYyezkKA90gIrv3GmHdRDKaAfPNnE2Ju
 VNp0MD352vhkS8lm83XVd50A5wjjrmCDDm0f8stzvSntdUfjR+fub9vAF6F1k4xD0QzR
 zxznytrdM3Jvj8a3DIFrOsfu8lhp5aL5Nerq2Elu5ODOwPGz/hEaIQigB5ThspRQ+HVZ
 YY2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsjYEucE0gshdco4b579ZLYCb40NxmghABYhGD5DaSIYvodHcmtUiDNTuKZ8IMdV9mL2V+6POyuWekLjnAyFYliT2gyKY=
X-Gm-Message-State: AOJu0YwLGG4+dmkdk8UsA4JF1MWryDaV1zez9scg1rEAo8LwTCSiEfJg
 IK08nxCO1pS8tTM0hwU0teyj0CtaJogylFk0pbiJMP2r9VP6QGfkCpLHqtFmutA=
X-Google-Smtp-Source: AGHT+IHXAUmrN47FK4UfJse3ZzphSLOadDbZ/hZcDcnKF937Du6ERJua2+3+H92YHrDIaoUkbbZ0tQ==
X-Received: by 2002:a05:6a21:33a5:b0:1c3:b1b2:ce17 with SMTP id
 adf61e73a8af0-1c3fdd97d8bmr7794468637.48.1721342425196; 
 Thu, 18 Jul 2024 15:40:25 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7b2cff5sm158819a91.12.2024.07.18.15.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:40:24 -0700 (PDT)
Message-ID: <d939a36e-3e67-458e-96d1-b91e3db5a110@linaro.org>
Date: Fri, 19 Jul 2024 08:40:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/18] hw/intc/loongson_ipi: Move IPICore::mmio_mem to
 LoongsonIPIState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
> It is easier to manage one array of MMIO MR rather
> than one per vCPU.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   include/hw/intc/loongson_ipi.h | 2 +-
>   hw/intc/loongson_ipi.c         | 9 ++++++---
>   2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

