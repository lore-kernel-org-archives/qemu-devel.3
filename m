Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A4AC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWig-0003bg-9E; Tue, 18 Jun 2024 07:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWie-0003b2-Cq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:09:44 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWib-0004EQ-Gh
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:09:42 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6f1da33826so728404166b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718708979; x=1719313779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lh2Bgm4DFNco4vvy+zDJqLopRKUKNcfNfDT/vS7icZY=;
 b=nwhALGOVj8GxQ63olD6tO8jFz3Jhmxu9Gmr+tYymRjNt8M3+5SUSgNGYqHYYfbbGnA
 oCoPiYYhLesYrxj3BuVW91XNQtBr594GEtgJ/RpR83rmi0Xa4mD5vptx425OwD7ENG7R
 wZeMa2yrvoudh32qoJ/+GSN2Gn863UyJJuXMwWBAOD6Zl0cXhgr92c40susyDKLYsFNa
 VCiUxZTJk2i84Y3zYD2TITdBf0ItSjAXdl81C5Y/5OyosZCQl6NH8S8KbgBa2VsIrkdz
 +0/N2nqjqKt6fub/pcHzcIZUNI5FRP4FdtBR4ny4HY5JSAzRoga2zKrTlojUesGc3yXJ
 hnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718708979; x=1719313779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lh2Bgm4DFNco4vvy+zDJqLopRKUKNcfNfDT/vS7icZY=;
 b=nHJbs/bIX6BSC3s4/75ZaQCdKNjnIuN6gCieIWnXp/SAzz7EtKZUCNaqK0vRwD19ow
 dgDDIhvBltbmfIpaHqpuJ4LpwS7wsydSdxavUhKjO/ZyuOntAPW8D3Q/9e5MSKVu0+JT
 ySBSj8jo2E71EBWWtg2IAA9G5oH8VW2WJSKZ67wNuOcIDXSXoXbzMQPS6XfO92iiHOml
 uiotlQTGZFuhS2AgM5ZVexPNG6aAvVG+BAw/BSx1Y0DCgGgoTI2qAnVkuC8OEDQcns4z
 7qtGF1HvvLsXa27gp3XyGXdloKJ/7CsUhfPVdoMkEEgF/b9IlsczoIdVNy64co0XFPrx
 rI7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdDKBmFihv4lQ1sN80JlnUlMMWdR2OJd7jGHSWMIJ6Nec0Vm4EwOFCB0sMAOjDQjzhUYoCsLljwEj/AduTXiy67aKk5HM=
X-Gm-Message-State: AOJu0Yz0B+3/V3UxRXoicfpUfhhyB2KEmXnaXTU94Qnwn6kaZDAUnc2k
 snJsBCgDxJqArDQP+B+zDXlUfLE48yIRUKi3vF556KCi3y4zPJBmszW3WeXZ30E=
X-Google-Smtp-Source: AGHT+IG2Gdj6nIPLPzx/tiD2Opyr5W2+PQz5TJGbPwcs6Lnso6Y4z/7f3W+3Hxp9qsn/U1UrvZjcuw==
X-Received: by 2002:a17:906:e295:b0:a6f:5949:35b with SMTP id
 a640c23a62f3a-a6f60d38c6fmr1023355266b.29.1718708979612; 
 Tue, 18 Jun 2024 04:09:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db674esm605846966b.83.2024.06.18.04.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:09:39 -0700 (PDT)
Message-ID: <71ca0cbd-449d-4fc0-8329-57038c714f1a@linaro.org>
Date: Tue, 18 Jun 2024 13:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/6/24 04:15, Jiaxun Yang wrote:
> It was missed out in previous commit.
> 
> Fixes: b4a12dfc2132 ("hw/intc/loongarch_ipi: Rename as loongson_ipi")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/intc/loongarch_ipi.c | 347 ------------------------------------------------
>   1 file changed, 347 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


