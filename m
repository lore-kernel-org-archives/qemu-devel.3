Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F5EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZkD-0003lb-Uq; Thu, 18 Jul 2024 18:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZkA-0003Vk-CM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:36:58 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZk8-00041d-QF
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:36:58 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70afe18837cso235767b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342214; x=1721947014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/+3/nglO1XsIU4xBdCOF004SvcfcKcYhBPxOUrDCwM=;
 b=FZJI370JGw+D2hXTcxAU4uCf47VD5XI4MJfFiSaUvq8B6oDSfa3nBhGQrOA74GHOKQ
 foizceNc8ZY9aDs1U9jl9JwgQAKEdXthcBtKwqZtT22++fJx+2nLIRsFXVtmcNIgv6KY
 /kQ56Gb/bCme26AyJOzGEkGzyEfOA+NAWQhZXlYaHmooevzK+721XZE+mh/mvrx8z9vg
 Y3WtEpiAVn7jZaSdH2YaMIjN36SAPjsjPCN+dY5QaC+2CcS05NNDN8NMLwhYxQI/of0m
 4CRukxHVLQQT5VaLgrEs3hxvDaOhVGnnL1w64Z7omM8PuEufpAqjcpKPCh5RAj+16VST
 4cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342214; x=1721947014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E/+3/nglO1XsIU4xBdCOF004SvcfcKcYhBPxOUrDCwM=;
 b=CIIl/vlwn6LgzF3MaStk9TVtKersVJziTl0F34QUoErdt/Z/uLSh/Rk7O9ZhOMW7Gy
 AlT3DpQ/daM+70GPHZUirTt9MmKYc3/xlas3yXiVIkx206Drn7LCHHFOJJ3Ez6f0wyCN
 O6EkEsatH7ntHMHY9gDYzPUrlBXXMK4GMnmIfdgGNicHLWWDYKnzmfdgP1Arh6upn4lO
 +yV4QIOzIpGebLfFeIxPz3PJHuTbszWIbm48QtbUlNpvK06iWWQ3QsQC4JWKKNH5bmVR
 fABjL9ob6b21rzdsBoqI1Mr4cuiSjzPxx93k7kVZY2KCxXWsWv0D5snonXv3Q0Ru6WDm
 KUbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMDm+njK90uRsb+gY4/mI8W5o5sBGqUakylI9Agktg/7OMY06bTL28UH5IAjmbLsVjnBjlWRqBQ1ap+CM5epGAQzZfSv0=
X-Gm-Message-State: AOJu0YwS/BtF99Ky99CWvqyrxxoCn6DLA0siBmZDfzyukvMsm35yej3U
 b7/UfZuIgYvKjIXhAZO/mkFfBWS8ZcwA5+VhZZ4aFWOP3IQG2O0F2VEDOU85Ywk=
X-Google-Smtp-Source: AGHT+IENfvFrmVnABEbGBGiSiZbxayE7/leoHzEXPYRBELXh9GvkMMYCCzjYD+2D6qY7p3P/OsJmtw==
X-Received: by 2002:a05:6a20:cd93:b0:1c0:ed80:6e69 with SMTP id
 adf61e73a8af0-1c3fdd355f7mr6745085637.39.1721342214386; 
 Thu, 18 Jul 2024 15:36:54 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d4d010sm794955ad.273.2024.07.18.15.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:36:54 -0700 (PDT)
Message-ID: <43641744-ebc1-44be-b732-e709066a53d7@linaro.org>
Date: Fri, 19 Jul 2024 08:36:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/18] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_finalize()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
> In preparation to extract common IPI code in few commits,
> extract loongson_ipi_common_finalize().
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   hw/intc/loongson_ipi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

