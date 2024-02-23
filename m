Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51940C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdaJq-0003qJ-SL; Fri, 23 Feb 2024 13:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rda9T-0005Zd-Oa
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:20:03 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rda9R-0001vq-VL
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:20:03 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c132695f1bso463046b6e.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708712400; x=1709317200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LklWzCbZx7Ck0JRACSyFYvfkFz2hYYkazCbjgi1SDKE=;
 b=f7hdXjKipwO3q5ywO7wkcKu5Z1JINqcB5PXxLnVDge2br1zntM0lENUBgvvte1NqgB
 TcLzpeyGIdJlKjfL+tvW1b2/WB+akrTdaIRzZT8FXVHxwDQp2Hp1rMQDMHhJcjML5r1u
 l4wJMd2bKgPvAw1wS7cGGIReg1IXqM3CYpLxDrPotCnIKHAj6Is1yHxw/zESciAX3KgD
 ozSV7NUuC+xOPbjr+GmiokRRMKsMNvwCIOhjC0DvywgrRkHtToN2bBXbSTyDW9xtjayB
 Op59IOAeUwjPW0XIplkCGhzjcDqto7Z+7W0z5P7nxl/fk/gfP7+RbMmSKxL7CgyxhCh9
 JbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708712400; x=1709317200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LklWzCbZx7Ck0JRACSyFYvfkFz2hYYkazCbjgi1SDKE=;
 b=hVDjV2KufDJM6nRwX21YS+TPDK3AcDvnHOmBQlfoAKb0wlgBJT2bRD3zU3RTDrfXhL
 LkwoHOlTgfjiClRPNA/J5UGPuX7cr6DNF/FqwM6RcEHICf2IEXSOF4kzOE/O1h5h0LSg
 WdxbNYiVKLuYV4CfbocrgMV0h4Svf5rAAcEKuHxMrVeSVlW6NXHk2cyl34U6TYL5WT8r
 YQUnkPfu903vN/wV+1zoVFKBh8laLEXAoagtCluJWUaAKXyAqM2NvXSrzYdnR/jnS53o
 GlrC5V+b553MntgmbSqvXeUfiMqgMhAMzMWzkQW8Pnkwz5fKvcbZ/Xf5kP/Cyl/BSL7f
 7SDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrOQyBHSDJSGYHB7XLORaBIelT75MMWc8KQ0yZ5bzox+HIC40ZS/00lLH3hgD0Ot4TfqruA7okEBJERnLd3PEmFr9YTHY=
X-Gm-Message-State: AOJu0YzfGwtR3O7QwkH0BUPfd2xF8qGFBoaALoAVDX10XsqGQ6icFf5W
 syh0lVjpAT4pFXaaW7cWZiHwN0HNb57s+9l6bUsMzN4a79rPhmrIlVS0NLaUtpE=
X-Google-Smtp-Source: AGHT+IHLome3EF/8wSzFbHPRxEopmaWUd7kVWnhOMJyUCshJRInWlfI5JqADDBK+g5fkQ6ZST6xm4w==
X-Received: by 2002:a05:6870:c992:b0:21f:c7fa:753b with SMTP id
 hi18-20020a056870c99200b0021fc7fa753bmr312202oab.16.1708712400045; 
 Fri, 23 Feb 2024 10:20:00 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 b13-20020a63eb4d000000b005dc9439c56bsm12397324pgk.13.2024.02.23.10.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 10:19:59 -0800 (PST)
Message-ID: <47974032-2c22-481c-a9e1-1fc5990340d6@linaro.org>
Date: Fri, 23 Feb 2024 08:19:55 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm/ptw: Handle atomic updates of page tables entries
 in MMIO during PTW.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 2/23/24 08:01, Jonathan Cameron wrote:
> Seen testing of CXL emulation on arm64 (currently out of tree).
> 
> CXL interleave occurs at subpage granularity so is emulated using an IO
> Memory Region. The memory is general purpose and as such may contain page
> tables. FEAT_HADFS using atomic accesses from the page table walkers to
> update accessed and dirty bits.
> 
> Note that disabling kernel support this ARM 8.1 feature avoids this issue
> as the PTW no longer does an atomic update of the page table entries, but
> that is a nasty workaround beyond its use in root causing this issue.
> 
> Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

