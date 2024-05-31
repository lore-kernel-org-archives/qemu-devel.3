Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC27BC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8Rq-00074P-47; Fri, 31 May 2024 16:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sD8Rp-00074B-Ci
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:01:57 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sD8Rn-0004oy-Mz
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:01:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70245b22365so925359b3a.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717185713; x=1717790513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0xJjUi9sP37YBjk3xxaFU6m+enDZbK/pecQOqYr4E7Y=;
 b=ubZNAcU/swWHW0BqhA+mID+Z2YHueC2AFXEaciov43RcCcF55b550YZjIFg3o1z5Il
 8HvGc8UTu9q4gyg28lxnO7+MLVIDEN0hyrjh8u1iJedsqf2gpkx3IW570hsbHXfl/YwE
 74oP5G/WiUu1HZa0SG44AsPSZNJZqu/NFKUq0981baj2+Jeh03MgikkyMawNMQ2TP8w3
 93NLCgcR7Xgm3h4SoUxbnqRWMV8tajKthq1Q202fQME1ZJlE4P5XK+cAYWIeRg5uDmiS
 ydBZn77vDPxpdC+PR0e4piXfd/2HTTPOfTpxgMUHG7RYXkgvKcMIEco/lpQn4no6VJDI
 1hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717185713; x=1717790513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0xJjUi9sP37YBjk3xxaFU6m+enDZbK/pecQOqYr4E7Y=;
 b=QQL+HnAvBZyrgSa0CH2Ia3EMmJdJu4Zf4DXUnQVa2KNSrUavfuoio7Ne+QhpXq3N5m
 IzDd7rSDr7GNofdx6xOZJGgPI0EL1hj2leTBPC0UZ+oeGZNxkpIDVr+e+uosuDL4TdHY
 Mb4ExyneFlgAaaYoh2VxGlSm7R2D9jV5Jr09W2HhVRyhJMdb/J+FX8v0RUqdzEL/f8EI
 bqyqhWSgEd40H7vfr71aT38RDKFBMuO9Nc1UxZHIyczwYODo5MPm8MCFGsp/Y6P30iRy
 RhboXSw5uDaQwQnXkTx37uirA1JgN44PD1LoQ5rq1zMZv7A3ASsb25T/VAYFzGsrxomo
 THzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmxot9zs0Hus/WVQbRf9KpVKSowh1S9+MJmwbspY4LI41ah+AmoDi4AAoAVzRGNVN8eDdr+y0+nJqQ7qLiCGITVliWzX0=
X-Gm-Message-State: AOJu0YxPegMvzEPvmzdfYQLbuMyHEQ24JtWtRSyPSX3noLB9yeFvY1Pf
 kw1uhBpxtSLjdZyp/KrUapImtDfMjICSMwYXFBNQ36f1LEqNpe4IN3AbpEJkuXphEXtwlxQPo/r
 9
X-Google-Smtp-Source: AGHT+IEtWheCMO6lQnM5Zn3QpCj7QsrIS0grBEAX3OY46OdTq+f1htfUtauLZQSX22pCeCYqJ3956Q==
X-Received: by 2002:a05:6a00:847:b0:6e9:38d0:5019 with SMTP id
 d2e1a72fcca58-70247664028mr3582881b3a.0.1717185713169; 
 Fri, 31 May 2024 13:01:53 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8f63:c378:eef6:b8e3:754a:aabf?
 ([2607:fb90:8f63:c378:eef6:b8e3:754a:aabf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702425df2a4sm1743311b3a.54.2024.05.31.13.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 13:01:52 -0700 (PDT)
Message-ID: <acbe852b-1a8e-4074-b45f-f6ce2364c9b3@linaro.org>
Date: Fri, 31 May 2024 13:01:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/43] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240531120401.394550-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/31/24 05:03, Peter Maydell wrote:
> The following changes since commit 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80:
> 
>    Merge tag 'pull-request-2024-05-29' ofhttps://gitlab.com/thuth/qemu  into staging (2024-05-29 08:38:20 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20240531
> 
> for you to fetch changes up to 3c3c233677d4f2fe5f35c5d6d6e9b53df48054f4:
> 
>    hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT (2024-05-31 11:26:00 +0100)
> 
> ----------------------------------------------------------------
> target-arm:
>   * hw/intc/arm_gic: Fix set pending of PPIs
>   * hw/intc/arm_gic: Fix writes to GICD_ITARGETSRn
>   * xilinx_zynq: Add cache controller
>   * xilinx_zynq: Support up to two CPU cores
>   * tests/avocado: update sbsa-ref firmware
>   * sbsa-ref: move to Neoverse-N2 as default
>   * More decodetree conversion of A64 ASIMD insns
>   * docs/system/target-arm: Re-alphabetize board list
>   * Implement FEAT WFxT and enable for '-cpu max'
>   * hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


