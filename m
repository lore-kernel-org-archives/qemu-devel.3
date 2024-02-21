Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F19C54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 22:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcugc-0007xL-T6; Wed, 21 Feb 2024 17:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcugb-0007x5-KL
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 17:03:29 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcugW-0002D1-VK
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 17:03:29 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-59927972125so4708522eaf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 14:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708553003; x=1709157803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=90WBAGCwy2F2XYUFXm1yvKLC6SVb6oJe6/N/XfSb+y0=;
 b=mlNdkT/ZxvmzXkmU5DKlIGU3Q2ND7kpOcIc3VtFSjIcuySf/wx7NoXKyIS3bYxP/GG
 xOMW5fQH4L6pM+gysyhTXKqBI3cjiE2y7HG1e41HA8yHm9wY/YV5jca0A3TQZoZr08U4
 K/7CUTz0PH/QSg6p18nmSK+LosGyjmWu1w8rFmLFlx/r0fXDNh6fBuKnARCndcpSZ9BB
 +v5nVt0NbX2WpNJP3EQ+0kektc6YKsOIYVk3UJVqRzVyUh3clQQ2BY1D3AAilur38H4e
 pjCIRHyTTvxRRsoogne+WVAtpFbHsfcCgd+Tk63ytH00K+l7NNye0HikZneteIgLnYZy
 YaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708553003; x=1709157803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=90WBAGCwy2F2XYUFXm1yvKLC6SVb6oJe6/N/XfSb+y0=;
 b=TzOVDoKJDGNoBw+CtBKq+hII3HCBLKSvBdeFD6BtLg3vE/xibD2TOsy8hNLo4fWo2O
 LBvlcxsrk04o9wMFHMVWr9Q5f8khQYhYy5JuSExeg7MJzI2JCshXQGlHT6ngAdNQMA2v
 TJa5BqVJuhh5r8DXijIuO6j+26QAdVbBG5huUNKVtGR6/6a5OFkIFxYvoNa10klD7eZp
 6roIp8gPhBhR1DHBb4I2JBbTJx7/SPgzXxkGHfw3mtUOf9w/7yAj3eJPCvsJ64jWgrVE
 4YrEKVqbKMEA0F0XOUm6NJVyP4+mutpPit3n1had1Hs6hx1QEjN4RXMnNJDIsX9dCQlm
 Ly2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1EYq32qn+d0bDuBmle2uP1f08OFaOzZjlZbE+yEjVCcCXYclQ4ko0u6Wcc63oDi8gDuYCKbXXWQ0BS5MkY5mAUCBzbV0=
X-Gm-Message-State: AOJu0YxHwDmLbtNIRI2hbMiZ5x0/LAdpTqAL/AtTtDn8ailpiE/k32R9
 GCOv0BPQh0jR/PTVdMWYz9lK+3b5v4wVao49PppGkm31O+yxswtD/jFrUWMIRi8=
X-Google-Smtp-Source: AGHT+IGuQePfU48GPJSIwX5tETuN8zl1udNvdSCzr4dzfg7knhhf0M7B0JoFFJO5dWmc76iYLwyKPA==
X-Received: by 2002:a05:6358:4403:b0:17b:2bb1:3c34 with SMTP id
 z3-20020a056358440300b0017b2bb13c34mr15564662rwc.0.1708553003067; 
 Wed, 21 Feb 2024 14:03:23 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 c18-20020a056a00009200b006dff3ca9e26sm9382389pfj.102.2024.02.21.14.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 14:03:22 -0800 (PST)
Message-ID: <b8076749-42c3-4ddd-a6f0-49c89230b284@linaro.org>
Date: Wed, 21 Feb 2024 12:03:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] target/riscv/vector_helper.c: optimize loops in
 ldst helpers
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-10-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221213140.365232-10-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/21/24 11:31, Daniel Henrique Barboza wrote:
> Change the for loops in ldst helpers to do a single increment in the
> counter, and assign it env->vstart, to avoid re-reading from vstart
> every time.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

