Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B96C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhinI-0003qK-Mt; Tue, 05 Mar 2024 23:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhinG-0003pV-9z
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 23:22:14 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhinE-0007hX-Fx
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 23:22:14 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so4909855b6e.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 20:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709698931; x=1710303731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t3WFj/NxX7PbGY8RQmPQs/URWPmD9tQBuwxIK9h/vSs=;
 b=g5kPZkYLhO/++dGfXTLdkgIkTpJ2VgO+QromU0uwD1y0hD6o0G8irGaVHuelY7+qrQ
 hZaSDJwL/FLlXhiiwQ7ZTa2SDBEVfn3REF7wKVg/ZolJTIPvzIrErNv9uFD3k3Ly2RLp
 /2orOaBw9/S2XC0f0X3mV5xK8q3Qa7Un1bd7c6z5pYmOu5od04RrW21snBNUH9ydMmIf
 cewm4ATBdc4+6dBnHf7mTqeIStSG9049wX0fPctiH8/wCWPNd2uuu4gxR0lEmzjJSF4p
 t4qa0bUIpM8VNlk/oLS5AG4diY7wINW0bvy4cmoiVl4Ne3SYSDoD7p1IKbRiTiCNr0/N
 sYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709698931; x=1710303731;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t3WFj/NxX7PbGY8RQmPQs/URWPmD9tQBuwxIK9h/vSs=;
 b=Cppn09hBkjvQHQ8OSkLLQM9aa1DkOFmr+/SD60LAbyTGmeSV44aGc5SsmaRdmUGpOH
 Xi1vsimu/f/TYTBLqBNAjxsxCbq4Zv+q2XjO4rwSv+vMl0LdBHz4fwDAMmnGjF9iGObA
 ixB6gcWqy9U0iJbu6Oy3AkfvbSD823nfkfyJYItngRzEBX3TYCFRaFZTO1N0ZJautP++
 mNJvVU9EPqs/IUH22/VqtssfBQ2GgFHvPYxu+6xoDn1yzUmeVB1FZbWxxRLv5NV+LnGg
 8pncrjzzK8DRjHbXr4N9j3Np28bmtCZv1GSWMQdPv7K9l1XJy2nTb5x5KJaaMqprWLcL
 ctdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX4xpg915onljk+SsCPq520KpJqyH+wabd2zBm3xk8OLJXdmKGBeEbIzPzOEnliaeXbGdFB1Ed/YJEvw/2F2a2iy0okp8=
X-Gm-Message-State: AOJu0YxCtBhOh1+AOlUiVb5KtMBdcJzPBjXJ3G18wzV9NCjcv0x2BJgx
 GWl5zCVILVM1Tx3Jop5VheRhwFCL1uzvROD23SZLjs4yHUIHNgmkplFIoqpO1SK4Fi0gRRR5AXP
 p
X-Google-Smtp-Source: AGHT+IFGSMycbmn4zSum8VAk0wTvyzSit5UMRAiuVKWnIrY9q0Bj4e9lY7oAgSk5nkCQirL1my4yig==
X-Received: by 2002:a05:6808:2092:b0:3c1:ef08:6976 with SMTP id
 s18-20020a056808209200b003c1ef086976mr4436176oiw.10.1709698931247; 
 Tue, 05 Mar 2024 20:22:11 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 o189-20020a62cdc6000000b006e5597994c8sm10198339pfg.5.2024.03.05.20.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 20:22:10 -0800 (PST)
Message-ID: <fd515ea4-ca4b-4d54-9d9b-59683ccd683e@linaro.org>
Date: Tue, 5 Mar 2024 18:22:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 00/23] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240306035721.2333531-1-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240306035721.2333531-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 3/5/24 17:56, Jinjie Ruan via wrote:
> This patch set implements FEAT_NMI and FEAT_GICv3_NMI for armv8. These
> introduce support for a new category of interrupts in the architecture
> which we can use to provide NMI like functionality.
> 
> There are two modes for using this FEAT_NMI. When PSTATE.ALLINT or
> PSTATE.SP & SCTLR_ELx.SCTLR_SPINTMASK is set, any entry to ELx causes all
> interrupts including those with superpriority to be masked on entry to ELn
> until the mask is explicitly removed by software or hardware. PSTATE.ALLINT
> can be managed by software using the new register control ALLINT.ALLINT.
> Independent controls are provided for this feature at each EL, usage at EL1
> should not disrupt EL2 or EL3.
> 
> I have tested it with the following linux patches which try to support
> FEAT_NMI in linux kernel:
> 
> 	https://lore.kernel.org/linux-arm-kernel/Y4sH5qX5bK9xfEBp@lpieralisi/T/#mb4ba4a2c045bf72c10c2202c1dd1b82d3240dc88
> 
> In the test, SGI, PPI and SPI interrupts can all be set to have super priority
> to be converted to a hardware NMI interrupt. The SGI is tested with kernel
> IPI as NMI framework, softlockup, hardlockup and kgdb test cases, and the PPI
> interrupt is tested with "perf top" command with hardware NMI enabled, and
> the SPI interrupt is tested with a custom test module, in which NMI interrupts
> can be received and sent normally.

As far as I can see, this patch set is good to go.  I'm fairly confident of the CPU side 
of the equation, but the GIC could use a second set of eyes.


r~

