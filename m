Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C24C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZl8-00084k-Kd; Thu, 18 Jul 2024 18:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZl7-0007zr-9M
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:37:57 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZl5-0004LR-O7
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:37:56 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-75ee39f1ffbso920953a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342274; x=1721947074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o0O4G0meMCPwa8a44fkDzPlOzgZQVNsXhd6nSZzdhfY=;
 b=iQDP4T9InTUMXpoyp46Ge6pR/E7s7DQve9qyNd0+ZZPfmm8dcvlrqlWjad+WccFjPg
 E5yScV4Tm2FB3Nw2oQqaO5OLVgDWz08KLn6KUY5yztxPSQjywg5zy+zhwm6RTXSGsKN+
 7aHpT2Zd5a9FO+yMkoCKPX6ZFv99Dk95JciY1jhZUq+Ycz/hZC+MhHOjnMBtjKhn7sPR
 C1zC0mrieVVC5VY78z8JrzL+MYoWy+XDxadq25wD6HDh2oys7LefHxXo6e3Yg5noHotz
 nlIayxSsjydKSU+ctLI9b5nv+AB1azKZP8H+Kvw8+fDRSzX6f+7qcqYe6zW5Voaa2pwn
 CjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342274; x=1721947074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o0O4G0meMCPwa8a44fkDzPlOzgZQVNsXhd6nSZzdhfY=;
 b=H3h3MrG9UhVlsFBoPzupHSy9fTiCI9g6nR2faZAR4DE+oXpKHkN2nlOr2sTd1XqVyf
 idAbjJSJT+jYTxFmWkfluIWaFjFrvrQi/+sZRU36Jlx0kCer9qS/pHb/dK857PJfOXz7
 uo1A/yeCwcsSBzuFC6dekuFh2dFvTDo958rZWZj4kBHFyNSkzZsyQxsjcN9KbtJfNcL6
 fBTbZUa5UAls1KSPWJ6UPw9NTseU2b/vNQo19G7yqWpi2ablLVgOxupre/QyXdLmYQoa
 AVQWctViDVFm1iR9qCV5yXM7ZmMhO7j2vCuh5X3UvGsVU00/PK+7ubmh4N7NLpFPw7p0
 6R1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlL4rN055LP1OrUXJIHVFwY1nHv1hI3lcqcDkf2ODKf1Ic9upwUzbT8qcFLRix5KrfVy/9qGoKF3S04/0/pyumfwaNcHQ=
X-Gm-Message-State: AOJu0YxE2OUOV1MAWjMEUitJABxcX47iFgh4inZ+9TIpyj6SRjZ5g5Z6
 e8DBbqwNIisfyZ+5XSBHuRWsUxq26T+YLiRgNzXvffnJhbT7YcINaAKJiVTku7M=
X-Google-Smtp-Source: AGHT+IG0H7TUpQZhZHGGYEYoMmbBazRl+0NA4H1Np6VTE/yKL8xzWJgK+y5RcsCiNfuJjpChyyoONA==
X-Received: by 2002:a05:6a20:2443:b0:1c0:f288:4903 with SMTP id
 adf61e73a8af0-1c3fdc9ad06mr8341001637.17.1721342273970; 
 Thu, 18 Jul 2024 15:37:53 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7b2d5e2sm154262a91.7.2024.07.18.15.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:37:53 -0700 (PDT)
Message-ID: <8dd18c34-859d-4fa3-a9ad-14a4481c99c8@linaro.org>
Date: Fri, 19 Jul 2024 08:37:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/18] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_realize()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
> extract loongson_ipi_common_realize().
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   hw/intc/loongson_ipi.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

