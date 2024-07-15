Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63411C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTISO-0005Mf-CR; Mon, 15 Jul 2024 05:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTISM-0005IP-M0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:57:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTISK-00007u-Oj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:57:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so31401555e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721037434; x=1721642234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9fq/ix6OT2tXwL94/8kdg9s1x8WQDE9G1JkkFziTutA=;
 b=b3Hc/pnrJqhexCvKzqXzKEVtunYoBSRW/GDQDUJ1yX0GuxKtWUSvs+eEzuEkcaFu2H
 nUmR2/ShEXORdOTyi8y0A7PyWejMkhO7T7455XfZHgxozsa7MOqKgS2mL/3uKdEesq5x
 d/vToyxO6kiWfxFG6aNMadVnJHTe4yl8t/r5bxwKaRrJidq9rxvo4MRnqt35S9aanFqV
 9TaSpTXEwun9re/DeLm5RLkH/Z0FGJ6JkrXdvhgJ6AF6/LsXAUy3sws//m6Us7912Z91
 D3W7vxPqo3yJlm8TVzSNJ7w9XT5+tABNeJ9HdcMwCT+1lTcpIG28sSOpNZzZ+uvHw9/F
 0wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721037434; x=1721642234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fq/ix6OT2tXwL94/8kdg9s1x8WQDE9G1JkkFziTutA=;
 b=o7I4I8Tk5inRy2Y2+Wev/2lo1hU6QzdMXjdkQ+CuRfoS+Msqu2vpDs1O+L6jjXswiD
 186bMdu/HtS6LADHQxID8BWcYt8IifphplvGIrjfWtFdZFifSRdBhDKAZEssDAI+X7qt
 QKDTT11mgN0ZkGyBkykpwfhB5iohLIoVIVxWbjPXRH084xMEuckFY85fbfKgePKkeIow
 +V1V4KKOoydWx6r3hXSlMloO/lT5VkN8PpGdNZejZOpBqSBDAC5uFjEkgTtIsQU+I6Rg
 20K22XcUoVOFvuY3fkfyoSgsZ48IQnYP1X1+IGmsr5r4faoC5a6v15YROATTbt+oUqMw
 xWOQ==
X-Gm-Message-State: AOJu0YwX8a1yVrcmvCEykCh713gnIe+WJLgSaExKXNdcmv4ikAvLXuuF
 4zvRoYYKEFX6bdPA44KqOrKZB1/ktH0VNNMvPvbPW/IYKgwuy5zKWotlVvhPSIxYKtcYpWgpdqY
 aQjo=
X-Google-Smtp-Source: AGHT+IEfT3I4/7zhWueWxuxJPqFiQFGATOKIIHCQHqcLQ5RiYsxNE2pJT+dHk1UB/VtAb0fV4L3JIQ==
X-Received: by 2002:a05:600c:2206:b0:426:6822:5aa8 with SMTP id
 5b1f17b1804b1-426707da4eemr151508415e9.18.1721037434433; 
 Mon, 15 Jul 2024 02:57:14 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e77b0bsm79545605e9.1.2024.07.15.02.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:57:13 -0700 (PDT)
Message-ID: <05b70832-b1a6-4a6b-87f6-373f02fbbb4e@linaro.org>
Date: Mon, 15 Jul 2024 11:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] hw/intc/loongson_ipi: Fix for LoongArch
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 maobibo <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
References: <20240627125819.62779-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627125819.62779-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 27/6/24 14:58, Philippe Mathieu-Daudé wrote:
> v2:
> - Only skip mmio-related code in loongson_ipi_realize()
> 
> Jiaxun Yang (1):
>    hw/intc/loongson_ipi: Gate MMIO regions creation with property
> 
>   include/hw/intc/loongson_ipi.h |  1 +
>   hw/intc/loongson_ipi.c         | 16 ++++++++++------
>   hw/mips/loongson3_virt.c       |  1 +
>   3 files changed, 12 insertions(+), 6 deletions(-)
> 

ping?

