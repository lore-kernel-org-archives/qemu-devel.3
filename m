Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0541C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZrR-0002Fl-KD; Thu, 18 Jul 2024 18:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZrP-00028j-Rj
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:44:27 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZrO-0005z9-4I
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:44:27 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so886308a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342664; x=1721947464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JD5fPawt4lPlzBllp5DbpJnNe+zLlalgQN9NH3rSagI=;
 b=NVtRtK6hPDC5h5+cIIhKfSx3r5reSMUlI6BYAo0lOC72yCt819K5zRjnIDO/LhoBdS
 3MEYNkPiIQuWQ7gT9Dp64TGskF6H7XQZrIu8P3SApKH3PUgdooWNTEchhnC7BtYJzn9t
 iG81QC8K5GZeGdya3yCytDd+AfCQIyxp5PzLEx9EKBADZR0RGcMjW5r6gCslJJILB0+k
 JR++4jMoA38i0c9hho0yjVVq0ZrzzzYQl31uflNPC1Ea2btCueSvWjgH6gFubjetf0QH
 orPgNaPaR7M2xf7OVPuVaZ5fXNRWfVH6knniOZfv1d0CdvH88TvkK8bwQWFTga0zLrVg
 18pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342664; x=1721947464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JD5fPawt4lPlzBllp5DbpJnNe+zLlalgQN9NH3rSagI=;
 b=qIa7zwdoUoRelc+c7hHvlM989Dt0B9IOX90ecHZ8n0XLHTQeDJ44ABzDWY6sSe6aQf
 mXnLiz8psuQuddLc5XaLW6oniXK9u/+YbWtmlsbs5cMtdROAGpr7XkXqRJSyqA5aJbYN
 wOde6AoeXicNSI/WycGJhuePzhHKUwrCNbP/XnA3sqqT41Dd1TPAbkdm6Cys/lMqkoLV
 ec6jf/PmkqGzhTdDSExKdpMTD/8/4bd5y1ESqZCgSzKc33inO5WnkSOXffi2ro7E7Qac
 fzwzWRfFoXb+IAJtnxSu4TPKFqKJGbd/3m5q/6bR22Z/tx+bxM4Kn8HSiEXXC+X7oVtN
 Aq6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPfi9sCQKgf6UKpSU1m/PixEwKO7pxLYW5tEDrtBa00lQEq4JFgc6yDG1gTb7qgS9Z03u3mWZ0lPk2pqu+RQcA7rBc/Dw=
X-Gm-Message-State: AOJu0YwLXxW7GaAGClBqmQdvEqS/uP/xoHCpQoY7OYXfscuSa+kZjdMn
 bp3GV1p7eFonsmLPfRfIKskkazfAMhX+8XzFidxx9yitAK/L4A/pY+FCZ8oEPwc=
X-Google-Smtp-Source: AGHT+IEUgkgEc3DrZ+Rbxl0H0sqe3SC9dk0XUQMs0TdZij8C/NWDpGIZom5VSvkhPSAtYc1F5onEtg==
X-Received: by 2002:a05:6a21:174b:b0:1c0:f648:8574 with SMTP id
 adf61e73a8af0-1c3fdcbfd8bmr7040793637.29.1721342664415; 
 Thu, 18 Jul 2024 15:44:24 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff5fe7b7sm46047b3a.198.2024.07.18.15.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:44:23 -0700 (PDT)
Message-ID: <bd8d43df-c6d0-423d-ba73-364a6ef03d96@linaro.org>
Date: Fri, 19 Jul 2024 08:44:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/18] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::cpu_by_arch_id handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
> Allow Loongson IPI implementations to have their own cpu_by_arch_id()
> handler.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   include/hw/intc/loongson_ipi_common.h |  1 +
>   hw/intc/loongson_ipi.c                | 10 +++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

