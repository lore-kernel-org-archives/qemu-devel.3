Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E2BC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWH8-0007qp-N8; Tue, 20 Feb 2024 14:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWH6-0007qc-Uk
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:59:32 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWH5-00042T-C9
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:59:32 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6de3141f041so4074012b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708459170; x=1709063970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/YElvzb/DD9XCi7wlN+eEnmV2PyfDxf2Nm1Dhe9Wl4=;
 b=Dnrz+LN1iWZnwrzoC9OQJOo7xSauYTiFAnpj7IOyQeBUhnb1UTLats7lXLFSJzppPl
 jFKt5KuORPFP0NGWz21pmgtQPtV8GzIvQTwvy4KEJike1n4x3gzD91+gFYwuHS1qjj2g
 Vr2pvMKeea7aUkF6gz7wI+Yrpg7Uo/jQUQaRHVq/Ev13AfVzibe5CSlF1JG8ERlWqCQq
 BA1ZUITPsnAV0SOt63HysTZDhmhrgdILeAmUMwPUwPwwa91QUfs5usNcIG5YaQ07m1iH
 s4vruPtqQEzmFdqddXzzQoBhi2EWMXJp2oF402uNsGhMrgPIRSUEMHVAwb9zev0aUvLC
 zxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708459170; x=1709063970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/YElvzb/DD9XCi7wlN+eEnmV2PyfDxf2Nm1Dhe9Wl4=;
 b=DNjfEsv2/1kjXYreo2yfNltRkhIm+C2yGAU8pwHBFiEQF4CUzoqA8f9paB1MdKdKaX
 9BIDBOB74CPCGnhj50qCmlrxO14wWXLdtTZkrLjk511K0LazeMqyJdSWH1DPw2dfqJE3
 d36qEFWrc2qVa+3aZPtPDo9mv2mJPjIXaZZ8PCPy6gleFlQpohN7jJmDjUUv1kxch+iz
 V//JqN0eidI9fnP9qq5Ys9vv8f9bX8fXZ9fzVhaOE+5P1mimZ/1cKvSwUhTEmEesEYAm
 YX6fZa5eJjZBXkUdIOKQUwOYAACM/yEcvVskKKehOLMG5zArr/P5xwITtpyKJ+UK5yEK
 AFtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVS0+NWiEz9iCIFfSv+IBU901kAp6SA0TyXOeZKgRcWAAiPtHz40NcoeZmHkxDk4dAuzUg3Rz3LGIv8GhNtkqThY2B+SQ=
X-Gm-Message-State: AOJu0Yy9PPxM8gUvdLvS/tbU3gGJelGJNBCI4sxHCARnZG5bKtMNyEU1
 CS3lSSgJRlS9vpFFFqfS0GDMlLOiWzgi7fFQM2bA9ntjWu7x4vtneBjOtMwUPhE=
X-Google-Smtp-Source: AGHT+IH1JpnwZP8vms07LC++oaaK8QaX4B1RYoASRdjF6wsDkcaKqdYb7MFhLkO3vZT5FUBv9HG80g==
X-Received: by 2002:aa7:8652:0:b0:6e4:6163:7e05 with SMTP id
 a18-20020aa78652000000b006e461637e05mr5790773pfo.6.1708459169779; 
 Tue, 20 Feb 2024 11:59:29 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 f10-20020a056a000b0a00b006dddf2ed8f0sm7240582pfu.154.2024.02.20.11.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:59:29 -0800 (PST)
Message-ID: <da0f12ca-c7c0-431b-863b-5981f41f6ca0@linaro.org>
Date: Tue, 20 Feb 2024 09:59:25 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/core/reset: Add qemu_{register,
 unregister}_resettable()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/20/24 06:06, Peter Maydell wrote:
> Implement new functions qemu_register_resettable() and
> qemu_unregister_resettable().  These are intended to be
> three-phase-reset aware equivalents of the old qemu_register_reset()
> and qemu_unregister_reset().  Instead of passing in a function
> pointer and opaque, you register any QOM object that implements the
> Resettable interface.
> 
> The implementation is simple: we have a single global instance of a
> ResettableContainer, which we reset in qemu_devices_reset(), and
> the Resettable objects passed to qemu_register_resettable() are
> added to it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/sysemu/reset.h | 37 ++++++++++++++++++++++++++++++++++---
>   hw/core/reset.c        | 31 +++++++++++++++++++++++++++++--
>   2 files changed, 63 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

