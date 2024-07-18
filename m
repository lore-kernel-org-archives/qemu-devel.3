Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA49BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZv9-00019t-RZ; Thu, 18 Jul 2024 18:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZv5-0000um-O0
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:48:17 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZv4-0006rn-1D
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:48:15 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb566d528aso638143a91.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342892; x=1721947692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZOsDHqkfTa1mH1pV0S5Cul7DFfwCdggrCV2X9KJzaZA=;
 b=mSygL1XugwsoXI6YuDAfPGyCiaTsZQt+h30EtbrZXnFx+filMUEPRtqHWiHY2TDxS5
 KGU0LoP7rGRohOuvziu7nyu94I8crlI8H97vD7HYBvFS2skf8GUhDHtkCZpWd9an4D2E
 edb3FOOGrqXPyLioJWPnrtwpXq519TVqsPDDFig/DTPVa0PYXaBb6CjVwmrYqFRZp2e/
 eiGXWy09YTvC3SCjgB6mjgb5qHx01u7oPr/vagkMeCKc1e3KAGLxZrFsTMEK+8bteuyH
 qBhHhj9h37B0XLYlvmz3sdLDCkklualsrI4ceRXrD4RVMrFa03/1tXqzC6HzxUVqES9Q
 MCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342892; x=1721947692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOsDHqkfTa1mH1pV0S5Cul7DFfwCdggrCV2X9KJzaZA=;
 b=nTEJbkoWa5be3/NyArOGxo6i+WfPNaeJQswC8AGxdIq7xSjaiPAEg+XR9D0E5zxZKN
 MbLJZlPq79+oN9Zgyjkd7YZ7BwA3IMTY0j8dQZ2Qpq7EAb4Zbw7ozbxAOmwHGw1kq0kX
 O6mzcSWF69HOThTGX9oTIzULtrfqRUau7kzIJhujqbqSBMGjh3ar8a5hXP4Q9y8Jmoss
 +hAm7sIdt7ikzyP9UBQJriMSfqtQ3cZbBIKNXT6vkIyR7ED9Jx+98zpMOEVgS3kEpSG8
 r19am5DrrzTNfS1Z1Q2/t7k/BdozRCCTUFTballUENJrV8oowfXBdYon+PpsUFY/eHxr
 je5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm9VTxaeKkPADTYORDm1lOVzp69hzFcuo1DsgwqPzQaCByNCIKw26sV98Sor0tdCsu4tv8FUCTHZY7jAg4I+qhm7ku4pY=
X-Gm-Message-State: AOJu0YySuATDA66kJRxoVRvj83pg1CJ6rUFfB55WLA70g6g3d8H7nu4F
 p2vmQmHdS0wdGEHaUNxycG9EgEwpXRjtqsGMaVEEGo83pvzOx/n9IHJfFWWUSqA=
X-Google-Smtp-Source: AGHT+IHx+0XfDvDa6hTKuvwPU5b8i8L8Zl+8WrBxuzD5ANAEoMEK3p/pPu7++JttwSdSfQsVCfwwcA==
X-Received: by 2002:a17:90b:ed5:b0:2c9:7fba:d895 with SMTP id
 98e67ed59e1d1-2cb529510dfmr5120481a91.38.1721342892269; 
 Thu, 18 Jul 2024 15:48:12 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb77540a6esm1273628a91.54.2024.07.18.15.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:48:11 -0700 (PDT)
Message-ID: <48135af0-9135-4d21-9821-ba22ee49374a@linaro.org>
Date: Fri, 19 Jul 2024 08:48:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] hw/intc/loongson_ipi: Restrict to MIPS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-18-philmd@linaro.org>
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
> Now than LoongArch target can use the TYPE_LOONGARCH_IPI
> model, restrict TYPE_LOONGSON_IPI to MIPS.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   MAINTAINERS            |  2 --
>   hw/intc/loongson_ipi.c | 14 --------------
>   2 files changed, 16 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

