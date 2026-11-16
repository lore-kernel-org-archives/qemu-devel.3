Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Bvz3NEGp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Rb-0002Qw-2k; Mon, 16 Nov 2026 16:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT4RZ-0002Qj-Jr
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:40:53 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT4RX-0004P4-Tv
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:40:53 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cdb684859cbso2809086a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794865250; x=1795470050; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7auOBJMyL5ZFNGSs8en1z/NJzJOdFqsTjJoNOavYZ3k=;
 b=Bvz3NEGpfYCstXiZ4PdbHcnLpGACcAJQCAc4UrSN7+bP+DMHWO+zDpj6e8Zuvi0+Ai
 rZJdy9QHyQsYs3IkyR88sr2HxAv35NrYoDWJ6OPtCy8iqPpl4TaVcxSXrYX/WIKIRpuy
 FyeuJ9EwwYvlc0+asgUr8lki9MXMK/WgbYA/yJYvIB0r2u8z4k7sm79Y7Hz01jYLGnA1
 wlr4/nWcBnbyVYFguau1eTMDzgn/pbIY5AGwe8Ana8QysxJCtAGe/9lfHKpFcoN/kadt
 o8KxSiC84sodlY+4GBVKf2HZTp1QI4y+ul376qD8kqymOnm5WEm9QQt9CtDBO62gVqSZ
 Hkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865250; x=1795470050;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7auOBJMyL5ZFNGSs8en1z/NJzJOdFqsTjJoNOavYZ3k=;
 b=pCGkavc4+y3GmlG/YXlLMqN1L01WrrlGJGNuNQW7LFuUN1nEhK6i/tudXThJYhdHKo
 jtknFpzN4EP/bQXP9ZjgTEb2ayF8jWSFJMAANweXxcQdSpBXXDqba8V4Jgt2auGAjsOe
 kCJZhxz3lTkoCze0yb95tLMXI/+cohsHL/YiZ/6OF4UiBStDibv56F0y++oeoSmVOZC0
 9UxFeFkN+nYurK0PJPSf0j3WaVzxkpergQmPNUpemTqBE/btUI+J1OoOCa5/Mv8jYACM
 hgbTd47NlFHNnSOFQNvgMGJLYYVZCkRt4ELDk/7aIRLBER3dqjFU2lQ3rnFJjBxUcRwU
 WacA==
X-Forwarded-Encrypted: i=1;
 AL+hErH2vdl9dxk7FEOduOKOVviQ+hiRdNUxetQB3Of9pftT75Ekp/VkH1tVtOTOTFLYruf6UKn+GF+Wn590@nongnu.org
X-Gm-Message-State: APuU4Z/qcbE2S7vR63LHSmubKo1AeOsLz9DCx/MoIZDHQBoG5sXTqtP4
 sFhtO45eoE6n4lzPDqMHdpIlBoaMeWrFQDthLXxnkbYNPHVFBGlPW/YK86QL3VbI/So=
X-Gm-Gg: AZFdTZc4tdy9CFxnNsGEv5VFKhEfUYPutjiLcj8VfB3lLwsnJqdmFkft0LT+JX3sGyc
 132X9QPpiZb72+YnAxqN95ncQgF29Dm+cICpjbNeiYALGk84X948n+h44yhv/d+2leSHHI855Dg
 T7qPsj6HKMhXGdcESCPKofpPwQGrY1FMKR+keXAwj7t1kSB4qtJgXDONrRpb0szSo8E86KG8OuG
 ubQqQ/FCoBPO+JBxO+W2p5NX0qXOZ0rDmBMSsQD2FFQIz35DfrDXf7Aj1pEM6UuyluGkhmj0KVO
 Ayvp+Kf0bWXFnCQzRrhr5vOMCEDoXa0kzxPZQ+FzDTbt8ehelHCxtMLixxWrsfwQcRiTvbaqWNX
 hfRUuzwnX4tfacZecB920gE+KAhQBr5hb3zpZTsJZHZUpVkzauvGWKwXTSnETCN1xD4MYFO2QYz
 RRioy/35ZPjkC1RPEbpNJ0ZUnzR/jPvpvHDZRCfU+ud8LtHc+l/SRT6wTeZH0R6vQX4Xc6E+gfR
 SPsnd/oVyPEkm7B1E1O1RaKGJZt+2O0HtdWZiRmATXCs9DSuHdW1pyMDibP4tTHvmcA1U8EKUhO
 LTP2fayEjHJIGGNqPbu6tCLHCoqStw9bQxNDNmr4gbEPpk1b5rgggCNJLjgEOG4ByDywN4Om6a4
 9t5cltMnnJjau26lw
X-Received: by 2002:a17:90b:2803:b0:3b1:2810:dfd6 with SMTP id
 98e67ed59e1d1-3b1b0b57df0mr11400570a91.64.1794865249948; 
 Mon, 16 Nov 2026 13:40:49 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abd06666sm845830a91.5.2026.11.16.13.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:40:49 -0800 (PST)
Message-ID: <f5b35d78-ae76-48af-b619-db0181a2d352@linaro.org>
Date: Mon, 16 Nov 2026 13:40:47 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/33] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 03:12, Peter Maydell wrote:
> Hi; this is quite a large pullreq, but it's all bug fixes aimed at
> rc1 (both arm-specific and otherwise).  Notably, there are a set of
> patches in here which fix various problems with handling of packets
> in the net/ code.
> 
> thanks
> -- PMM
> 
> The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5:
> 
>    Merge tag 'pull-nbd-2026-11-10-v2' ofhttps://gitlab.com/ebblake/qemu into staging (2026-11-13 08:44:16 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261116
> 
> for you to fetch changes up to 7d8fc59308ce20661515555855af4e01ac9bab77:
> 
>    hw/arm/virt-acpi-build: test vms->acpi_dev before building HEST (2026-11-16 11:09:47 +0000)
> 
> ----------------------------------------------------------------
> target/arm queue:
>   * hw/ssi/stm32f2xx_spi: avoid transferring data on DR reads
>   * hw/arm/bcm2838: Route SPI0 interrupt to GIC
>   * hw/intc/arm_gicv5: Various minor bug fixes
>   * hw/core/qdev-properties-system.c: Don't leak str in set_drive_helper()
>   * hw/watchdog/wdt_imx2: Set vmstate minimum_version_id to 1
>   * include/hw/core/ptimer.h: Fix 'version' argument of VMSTATE_PTIMER
>   * net: Tighten various size/offset checks in packet parsing functions
>   * net: Pad short packets regardless of network backend
>   * hw/net/eepro100: fix use-after-free on reset after hot-unplug
>   * hw/arm: Deprecate Nuvoton quanta-gsj board model
>   * Revert ".dir-locals: include QEMU code in PYTHONPATH"
>   * docs/about/deprecated: Add missing "since" marker for OABI/NWFPE
>   * docs/about/deprecated: Fix heading level for AF_ALG heading
>   * hw/net: cadence: Honor subword lanes in the GEM registers
>   * hw/arm/virt-acpi-build: test vms->acpi_dev before building HEST

Applied, thanks.

r~

