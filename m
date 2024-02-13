Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A05FC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 17:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZwFW-0002Z2-MW; Tue, 13 Feb 2024 12:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZwFU-0002Yp-Qe
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 12:07:12 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZwFQ-0003VN-0h
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 12:07:12 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e0cc8d740cso1916408b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 09:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707844024; x=1708448824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xJ1iAr+G1J+RuMQ/20sRzspXKp5eJ0gOSy1wQERXhdU=;
 b=BzxoNgw2/TVymCsbV8HU8zuZ6GX6903IvPZUHvrl6qLb63N7LLDqUT1hyYnan7iZoY
 PaSKi7NKvqq8yIJrxG1+YR5MRM7eyv7b8Ij10oORZs/lR3lJlb2X1shoArTXlBnPd7vm
 gx8Eshbn2sp+IDCmDasM4fYJQ2eWJtCHwAR4ICMXPDex0er0qbOIpM/C4CbVd0TNq1Lz
 jeJ/gmBctQprAcREzTznbw+xblufKmAH/dgIaB5YEmcVrQMcY9aWwTBD/bH2WsYhORKZ
 oRqqYigushfoQ5FcHXKWxMvwx5Fx1+0CLWXM1pWOmHhCNd1dpsRevNwfBj6NmDFVhBgN
 NXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707844024; x=1708448824;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJ1iAr+G1J+RuMQ/20sRzspXKp5eJ0gOSy1wQERXhdU=;
 b=KVwnT9n16IC3yShIwaZcLvTWeMiXT2YDM7CmAclSX7aKLeORC36SiVrIdW+LFAkWFl
 xYN1v72SOyf5Wq/dWQMQBe1ebQpehny5DRP14pHQx0lnzpl/3tw4fDUBuZvjm9YczAAt
 s+z1qvATzSH+9hCToYoEarU01TwFFOoa/VQJnVF39piDb9WLtspdkKBgciX4QoMfGCc2
 7wnaJn3rsvTwbd9rIPlyJivonZc0h+9CO9SLmllgzY4cfr1rDUjDbYBj9nPTVyOWOIjF
 DwB5rWbgTLL1JVonk/+UMedkNwc6oo79O0NaLnqufZWVPfuFsr95vRbKeAG9CUBciOig
 J7dw==
X-Gm-Message-State: AOJu0YwNL20WQFsnaWpQlwwZrTz5yPivcRnQaYTsZziHlnPMdt/P3ybx
 msEqOG55kNcEzt0IS8YCuTgPR4UvHnH2iXo+ZSIMsBMqAttVz01YN6taOLs4F/8=
X-Google-Smtp-Source: AGHT+IGURZESN3hSIViXG4ddOkg7jAtJG7GHYCjuQUSas1Y0+eNIZ2j67MaHgh28p2Hh5ta3k0qETw==
X-Received: by 2002:a05:6a20:5105:b0:19e:cd13:eebf with SMTP id
 a5-20020a056a20510500b0019ecd13eebfmr115240pzc.40.1707844023955; 
 Tue, 13 Feb 2024 09:07:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUWv+SZgTMMtRkvv77WBzSkN81gPLLPa6QzHFVOuHoB56372UUbGqTTRDKJG3mvTnEMU28FXjMXH3vDxZ1W2bTDblK9+YQ=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ei52-20020a056a0080f400b006e0e4b9b7e6sm3542867pfb.212.2024.02.13.09.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 09:07:03 -0800 (PST)
Message-ID: <fb3bf2f5-4405-4b8b-90b3-82052f2e0e88@linaro.org>
Date: Tue, 13 Feb 2024 07:07:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] hw: Strengthen SysBus & QBus API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240213130341.1793-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/13/24 03:03, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (12):
>    hw/ide/ich9: Use AHCIPCIState typedef
>    hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
>    hw/rx/rx62n: Only call qdev_get_gpio_in() when necessary
>    hw/i386/q35: Realize LPC PCI function before accessing it
>    hw/ppc/prep: Realize ISA bridge before accessing it
>    hw/misc/macio: Realize IDE controller before accessing it
>    hw/sh4/r2d: Realize IDE controller before accessing it
>    hw/sparc/sun4m: Realize DMA controller before accessing it
>    hw/sparc/leon3: Realize GRLIB IRQ controller before accessing it
>    hw/sparc/leon3: Pass DeviceState opaque argument to leon3_set_pil_in()
>    hw/sparc/leon3: Initialize GPIO before realizing CPU devices
>    hw/sparc64/cpu: Initialize GPIO before realizing CPU devices

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

