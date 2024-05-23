Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08CFC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sABYz-0006tN-QB; Thu, 23 May 2024 12:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sABYw-0006qE-I2
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:45:07 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sABYs-0007gC-Pu
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:45:06 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso2535819a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716482701; x=1717087501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ylCytKKddRWL8lgcKtH/HdYtTVfVdWXvayurx4ut3oY=;
 b=hRe+flxYsoJBNfO46+cRpOKFV5Suux3Sbdea1X5GtM+srobu5Wqt05UZBsK8wYDkAT
 nC6+heLnPX9Kko9FZV8R2CShuxPWbvu6VDIUXozeLIFJmWaY7cysTdtgqxoTqXgn2xWh
 wERHbqmvGALN8sgCpWWxg8WSzRxtFqe7kvCSVXzrpUQRHMQCUr1AJdE8fUgfJgYB4ivO
 rc5TRlME+2xUoGL6Une0TEw8hP6mWSLipyzZ2ZCOKCPD2fSE9fdC3wNbMNMfPjUOM3hS
 O0aRZHjcJXkLdTxm4HYmkzhc1Wf5xQdboJZe+lpWs4UGLdnwmR9Fs7lkIJPCCGhZGi01
 M5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716482701; x=1717087501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ylCytKKddRWL8lgcKtH/HdYtTVfVdWXvayurx4ut3oY=;
 b=MeVk0rPKLac7VhxZCNt32asOGUhD8+K/8+k8YbQR5PNplKpUTHrZpZ1UNYdyjIThW0
 pa5nOMVoXTHPJoqDLNblJDiUmts3W3jfEyvQPeQXwui2+mFjY1XYzpOxXwTiV/k+7NcD
 YDabIShaAgG6fKvLmWMLTEJDnN0rre+tGHJZo0axoeluwhEGMRyB9L06PqP+pzafT5+N
 9nRUB/oiCKtUPxb2os5Gn9UTUMwkVevSDYU9tBtdhNpOdx62Q5ldTXjpYybQVtA4hBmJ
 9K+vJlLnMQ0mqAY/FcP2y2YV4JbifxZ5UKc+4aomzarxcOSfIkfI2yHiH+brbCHFjqct
 gtYw==
X-Gm-Message-State: AOJu0Yw4mVOQr2vml6liEl9H+boITuX8cTxLtnCYZIgnC+ZU6W2OEDVn
 ORefGKjDR9cNktxnobiZYtPyu7iTjVMMfRHSPJ3UYvjgALxYwHuVrsXkIlC1Y/jrqzcniuMKBQC
 I
X-Google-Smtp-Source: AGHT+IFtz6F02u7s0x/2EmstF6C2n0KQPc3Q4qHyQsCkssWWxEu4Av6Hin6dMnkNJdzEUzYPbb9dXg==
X-Received: by 2002:a17:90a:930c:b0:2bd:d42a:e071 with SMTP id
 98e67ed59e1d1-2bdd42ae149mr3209042a91.30.1716482700937; 
 Thu, 23 May 2024 09:45:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9090a24sm1819372a91.0.2024.05.23.09.45.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 09:45:00 -0700 (PDT)
Message-ID: <5f026225-3ebe-477f-9298-f51d83b6be25@linaro.org>
Date: Thu, 23 May 2024 09:44:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] i386 changes for 2024-05-23
To: qemu-devel@nongnu.org
References: <20240523150036.1050011-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/23/24 08:00, Paolo Bonzini wrote:
> The following changes since commit 01782d6b294f95bcde334386f0aaac593cd28c0d:
> 
>    Merge tag 'hw-misc-20240517' ofhttps://github.com/philmd/qemu  into staging (2024-05-18 11:49:01 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 84d4b72854869821eb89813c195927fdd3078c12:
> 
>    target-i386: hyper-v: Correct kvm_hv_handle_exit return value (2024-05-22 19:56:28 +0200)
> 
> ----------------------------------------------------------------
> * hw/i386/pc_sysfw: Alias rather than copy isa-bios region
> * target/i386: add control bits support for LAM
> * target/i386: tweaks to new translator
> * target/i386: add support for LAM in CPUID enumeration
> * hw/i386/pc: Support smp.modules for x86 PC machine
> * target-i386: hyper-v: Correct kvm_hv_handle_exit return value

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


