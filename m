Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC9EEDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE5j-0002uz-9p; Tue, 10 Sep 2024 23:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE5h-0002nZ-WF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:32:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE5g-0001Qy-9d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:32:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20551eeba95so55880735ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025543; x=1726630343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ES6FiT4lqZrCtImSuhQ65aR2+QX5BFbPxEnohGmuPM=;
 b=qibjhrDJaKQXYxBFWB7jt8S7akeBK9iOAPha9CJCeGRsET5wuPWXTlt85yOqL1Ys6C
 G37roY9JkrgYMbDZMR3ektzAOLJZvlqRiOT1Bd5Y7d6HE09CG9SU5YwPojpvLiBsxe+Z
 /5dZ0HaUArPNrJL5AxXbqDZ9qJhgMFqOBsQ+ourgOw5+wsR0SecRiyDSgcr0d5ZWLhgx
 miR+jf7A0v4eUdnpW4FwSclNWj3zt/EQE29BKN8WxJZCbQLdve7/i9VWGSWkGl/leOMQ
 KJGGS90prYDo7otOkpcL/RPtLuuwYrZSJhXOPapoWSo2WLARpGZT5qwe8rLzidyirEWU
 nHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025543; x=1726630343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ES6FiT4lqZrCtImSuhQ65aR2+QX5BFbPxEnohGmuPM=;
 b=O5rw8/BDzdHfGz3cbXJbWKScJvlkuAzJw+MtFTrQ5ZxlCJVxYDpcjtxQqyl1C77PXD
 m9kRX27jRBzLMA9ULF853+ql0iedxGNly08H01jtyqfZvUOEsMPNqK2YHs5jjsia5J4b
 zptPJyaOQ5AlAadx5lUlymI+SEL7oODOYsVtxlaoLlWiI8rfV8mvabpmT3jqexGeUUvk
 9nnfIHMOBqGlVrKsLPl935xwvdvJyU7T3jkqNW7D6ZyT7/8G2aYNTZ6O+KmmV27j5RJX
 eKXs0PFBbhz8sB9oNvFp5hB7dISPF+SCbmzHux55MFaGqhiMN2Ew8IVLFpcCgUyFuW9C
 Lnzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjwC0tZZizMEZ7ajWq+MyBRPUOi848CfoypfzylsbW3MV8Kt+vMwISlDZHJgI6dIlEg+OqcatErml6@nongnu.org
X-Gm-Message-State: AOJu0YzYGnY871Z09E//Fd2byaH3xEtjQh01MVBJ5fToAtjJrIHBOv70
 fzMm7efhsNtNYoAULRkkO6TzVuWo7pyuG5g49oJyPkHFJZtcV/ezutS+KjP5A0Ryou+7UbDf6Se
 A
X-Google-Smtp-Source: AGHT+IGD83hUniAL5LEfM2eU5pyQmCKykdvtXaVABt1PU7uoNrGVqHRrSMhwxD6gXGJoYMOfuhM3+A==
X-Received: by 2002:a17:902:d586:b0:206:c43f:7896 with SMTP id
 d9443c01a7336-2074c5f7829mr41051015ad.21.1726025542743; 
 Tue, 10 Sep 2024 20:32:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f3414fsm54848645ad.280.2024.09.10.20.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:32:22 -0700 (PDT)
Message-ID: <418530f9-c039-4eba-adbb-29750c77275f@linaro.org>
Date: Tue, 10 Sep 2024 20:32:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/39] hw/pci-host: remove break after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-31-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-31-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/pci-host/gt64120.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index 33607dfbec4..58557416629 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -689,7 +689,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
>       case GT_PCI0_CFGDATA:
>           /* Mapped via in gt64120_pci_mapping() */
>           g_assert_not_reached();
> -        break;
>   
>       /* Interrupts */
>       case GT_INTRCAUSE:
> @@ -933,7 +932,6 @@ static uint64_t gt64120_readl(void *opaque,
>       case GT_PCI0_CFGDATA:
>           /* Mapped via in gt64120_pci_mapping() */
>           g_assert_not_reached();
> -        break;
>   
>       case GT_PCI0_CMD:
>       case GT_PCI0_TOR:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

