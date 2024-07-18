Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010B8C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZlz-0003LI-2k; Thu, 18 Jul 2024 18:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZlv-00039b-3O
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:38:47 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZlt-0004dd-Dn
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:38:46 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cb56c2c30eso633352a91.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342324; x=1721947124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xTc/41eJE6btzmnVe85ABXf+Hya5KUWxBG+6ODgmS/Q=;
 b=F2Kb8KRsgATNOm4bMiS8kpYxIYrnS+o+KY7gHcfvF3yDwMswA07i7sUlk7DUqnCVpS
 gEwwNdbLjC2BdZ8EHs2x6V6hUSvBx10t9D5jmsnEbvhZk3HbtciilQLj1Eqwbk/V5Nh0
 UeC/ayL/hwfcyr8c1H29ThM2gKApwaQuTlR/j1TCcpwSxoOY6dxCF6bptPbXY1KXktOZ
 f8HtoKw57LfJSiihNOLWiTlaW9nV/+w7d9fS65gx/j+6fZ/6bAuENqrYOo/jNFKkREPn
 HCRDrIHJ/9jxBN45R0S49AdsUhTaCMVIN1m53WWpjEK6LOVis5apgohXTDk9nSwoHGHp
 y93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342324; x=1721947124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTc/41eJE6btzmnVe85ABXf+Hya5KUWxBG+6ODgmS/Q=;
 b=Kj8/YVChEqe6GRRzpUi16g8Xmu/KK2I6MuynOTdeBCYBoGO2WOl4Lqg6ltKAlqAe7L
 lxeoSHzRO9Dbj93Wx+mYfEcwNNXm8zNaH9p7Lxhr9DQ788F6AbHhY3c6gALxPEuO4hQv
 ajf8MggO5gxcXdMZq66WAilMOryOaIxUZOgJAVVetusqc+AMvJRdnPipNSi8Hl4AK2Nb
 063J/DoIS3PY1a08ho9hQgWrb3kxB0gWOYv+3njJZtwSAyD4z1veBtwt1XiXVTZ2ai+m
 mTbgzsAUVafzi4aifecJ4j3o4Fybg6aOXhMmIePzS91R767ccQacPtRSOjXafMqwU3FA
 iVnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbsvQE97hfqpCmu+AwPEC54aQMAR/zikFI3LOnBbhMbDiCJScpUNF3q2I1wZGAzdWn/MEShRMTOVyR+6KCZZi70oZokKA=
X-Gm-Message-State: AOJu0YwDWtIpuMtafMiwY61KeYFtN7+XGEMF3l5KuuvT+FyCgLB3LPvH
 lCTKahyFjW7zp/PJExVDPcK4lr5r2CTplpUOiC4oQKHQ/FB6hOl2OwZ4AEJuy78=
X-Google-Smtp-Source: AGHT+IHZqP5WcEsM5cuFeoqihvhRpEH/k6uBeQJVLMNFl1/ImtHQXna71O3dCFherXhIg0jrT2Ybxw==
X-Received: by 2002:a17:90a:9c6:b0:2cb:5883:8fb0 with SMTP id
 98e67ed59e1d1-2cb77520719mr3318156a91.14.1721342323765; 
 Thu, 18 Jul 2024 15:38:43 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf80a9873sm148376a91.51.2024.07.18.15.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:38:43 -0700 (PDT)
Message-ID: <56eaca99-4132-42ea-bfa5-22b8b65baed2@linaro.org>
Date: Fri, 19 Jul 2024 08:38:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/18] hw/intc/loongson_ipi: Add
 TYPE_LOONGSON_IPI_COMMON stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
> Introduce LOONGSON_IPI_COMMON stubs, QDev parent of LOONGSON_IPI.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   MAINTAINERS                           |  4 ++++
>   include/hw/intc/loongson_ipi.h        | 13 +++++++++++--
>   include/hw/intc/loongson_ipi_common.h | 26 ++++++++++++++++++++++++++
>   hw/intc/loongson_ipi.c                |  7 ++++---
>   hw/intc/loongson_ipi_common.c         | 22 ++++++++++++++++++++++
>   hw/intc/Kconfig                       |  4 ++++
>   hw/intc/meson.build                   |  1 +
>   7 files changed, 72 insertions(+), 5 deletions(-)
>   create mode 100644 include/hw/intc/loongson_ipi_common.h
>   create mode 100644 hw/intc/loongson_ipi_common.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

