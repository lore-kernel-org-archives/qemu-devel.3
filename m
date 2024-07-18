Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE46FC3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZqf-0007Cu-Sz; Thu, 18 Jul 2024 18:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZqd-00073r-TR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:43:39 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZqc-0005qA-1f
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:43:39 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7fd3dbc01deso56396939f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342617; x=1721947417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uvhqo9KaOFeMGB/aHMoVG+x8SIseW8Ar8//LOAsuaPo=;
 b=wAss3AfWJqGCDhea9gyjfRmMwNasbxTZ0ZkeRBhSoaNA8pl0lgs2sxZCbI2luH88BC
 iTrxL8iNTML1C6Y2YbkOEzJD6dRSKrm/nbC8lEE8Z2mtj9PMAOrSd3PRttiRUzK0VK+P
 T8gv/2uLzooEjIY/OgC7MppQYee/Jqa7SjpuyiGD3YKaX521NnI3rcWJxGLrx0B1JIjj
 keVw6M+T0vGA61xA9FnkGBE173YXGWFzedoV3QBvspXIE063ztA3ig6IU4t1HsQ7qhra
 1ItuofMxtevzEGyr5Fh2RCLOzDsOkahR5RzidTun8m+4Ojj7lojrRVUOO859/GnjediW
 bdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342617; x=1721947417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uvhqo9KaOFeMGB/aHMoVG+x8SIseW8Ar8//LOAsuaPo=;
 b=f5z4fOFv5AZo+FIi6/c+a9C6CGq41VqTxRLLSBqmLV1vJvLHppLX9FIJkr6U7dFGJ6
 8XHcNnO1HT0mWyaqrLhbURgXveB2BBUl5IJt/IOVCH8PugVqdB1Vfq8SFWJG2NKRovHh
 NSvWZjGXlFqazLX/Ix1hNXwhFbJZcRHWBgZBz63ip7TebrTA7w82TB4xHWQh4ZBSAg+l
 otZc6FYgjOYCkA9aC3FemCX2xE8sk0TL05E4tE5N42yWKtgmZMYYv9N50AtmYmidE4ya
 Dbckhz87/5F3Rm5nBZ7DlU4zjPYOX4bDBYuhyGjb3zFMO0iPtcQ7DfvSfJwLhU+Yk6sW
 Uylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXITrhy69HUEikNRi5+vjeNaetl50yTtPZJnw3wkNgHIsIw18t66ha6Rhs8Fz9EQWSAR0vqBPcHn9H+yMjyosHtAPE8fiM=
X-Gm-Message-State: AOJu0YysDimDr7uPC8XBYaAJlChLlosr1b9riyT8TYIsL/bL3H99MbLH
 XnoasFqaQmFqeofwpHXy+cGLO/DvDkZAZA8Bhg/MCsrUVp/B04/GLDM428WHjTbW2fWOkDvHBq9
 HV1iXYQ==
X-Google-Smtp-Source: AGHT+IFehCSqRLLUbC1YeRwl6uzLZwxRtlrXmgju/ecwdc0XBj/ZBHMeqjo6R8ABK24QlVw7au1isg==
X-Received: by 2002:a05:6602:1593:b0:804:f2be:ee3a with SMTP id
 ca18e2360f4ac-81710043797mr666699839f.1.1721342616687; 
 Thu, 18 Jul 2024 15:43:36 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff5525ffsm47081b3a.126.2024.07.18.15.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:43:36 -0700 (PDT)
Message-ID: <c717fd23-315e-469e-b3f9-4a8f397acbc0@linaro.org>
Date: Fri, 19 Jul 2024 08:43:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/18] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::get_iocsr_as handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd35.google.com
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
> Allow Loongson IPI implementations to have their own get_iocsr_as()
> handler.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   include/hw/intc/loongson_ipi_common.h |  2 ++
>   hw/intc/loongson_ipi.c                | 16 ++++++++++++----
>   2 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

