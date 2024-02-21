Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFA7C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctwU-0001Op-8j; Wed, 21 Feb 2024 16:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctwS-0001Nz-IO
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:15:48 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctwQ-0000bC-0B
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:15:48 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5650ac9a440so1403864a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550144; x=1709154944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jr+eux/dBX8kmIR3Ayd3qq7P8Y3vpvqeXNoEhGDigII=;
 b=RZXEDt0+lDXGNpHF8Rw4phcFqHns/oTEF+IBq0/B2Cdkc39PPqq/hOavehr1J52IJo
 gs16lC1H2lBTXk3rgCMDOwco3GKwz+uXI2sG12W+NRVAxMZvgLIvCo/ppiPaUJMy9H2G
 5Y47nOeFrPHLOM+b46bMPA6GYY5wGAZi+AxVcyzpIAwBi/PK9K+HG/YIqR9apPT2mV+6
 vSpVNi5tcdZf1+1vXuIzB7gktrumLOMNxQlCB2ICAEeZiuABaBTq/H55Ow22hTN6FFfQ
 Mo5qVqxoqb0TfvvwXTX/6TbU+TGT/2qERc65UBaVS8kEIXM75YE5NNf0f9HhavyfNRfa
 ngbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550144; x=1709154944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jr+eux/dBX8kmIR3Ayd3qq7P8Y3vpvqeXNoEhGDigII=;
 b=QmdpOygVDHy4xf1mZ6RBVree4Z+rlnte8nnKZhaejKdY0Tg8Y3LbNpg0XPPVWboiT9
 T6bFI6k0x6T7WPfOejkEliVHZ6dXc47Ckpr6f2UCXemtFbzr8kovQymXAG05Sox6H90n
 HdtHZiBIUw5ecnDjPttpW0/EZjOSKaTejbzNBrMRMsk5MCUGfDhc1lvOzgVTXKS7JhP5
 DbjW6GDh5EiiTMaLDRYHbQSM7A4GWPT3AVhNCvP6ASFiKsD19Unxm2rfLmHz9ElPqxjg
 bNy7Hqrfnp5DexTDmRoR4KPwCSX0j8vrUiGp9w8yaxxw6WbBKnXV/ejvnQy2+AmVaZxC
 DEhw==
X-Gm-Message-State: AOJu0Yx8WST0GJvnoe2wdRX7Jw5DNUr/cQ0hktMt81S7mBE/EOR39RZn
 cQsF6nvy3Kq7RNnxBxyOaYOQQh17+/sN+et3JksrTMPZevIVYHf1GgUmK533zF+cR1OnqWFe/CR
 /wF4=
X-Google-Smtp-Source: AGHT+IF7IT6dJ/MB7YgezzT9dXxWa55gV+7lqZvp/6nPFZbCXN4b7h7tUXetXJAOSWGI1So9NlLw1Q==
X-Received: by 2002:a50:bb2e:0:b0:565:11c5:c7db with SMTP id
 y43-20020a50bb2e000000b0056511c5c7dbmr1375982ede.5.1708550144108; 
 Wed, 21 Feb 2024 13:15:44 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a50a6d7000000b0056392b7d85fsm5242896edc.9.2024.02.21.13.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:15:43 -0800 (PST)
Message-ID: <79cfbd5b-2be8-4688-9d62-869955116433@linaro.org>
Date: Wed, 21 Feb 2024 22:15:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hw/pci-host: Build ppc4xx_pci.c/ppc440_pcix.c once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240215105017.57748-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215105017.57748-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/2/24 11:50, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
>    hw/ppc/ppc4xx_pci: Extract PCI host definitions to
>      hw/pci-host/ppc4xx.h
>    hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
>    hw/ppc/ppc440_pcix: Move ppc440_pcix.c to hw/pci-host/

Series queued.

