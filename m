Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBAAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 21:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdGEz-0005KT-4R; Sun, 11 Aug 2024 17:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGEw-0005Jr-Lv
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 17:36:38 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGEt-00040x-OW
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 17:36:37 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2cb5789297eso2446882a91.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723412193; x=1724016993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6njRn27TxDmSq/GVr40a6HRZ/KjDgpiIMW8LUYelVT0=;
 b=o6/ehWUX1nLuigiyN660UdiurZO9AEbbaLP3kyYRhjR7d40beruDJsoqbybKMltKMj
 tQ/Eei+ap7piF+qgOFN28o3N+Y8ERrz7t8e7WqAJUScu1MZfODCIxlhAH4ImMJKTV3NX
 JeGKtVzvHjMJHWRldPKfLZWOQ2zKcsDEZBbQiKtagmS9eWFljcDS4Rw2yIqy5PyM9FI+
 IMRZUt35eLtw+jaMbCUxJUqsOAhRGSbh7f+LaAkg1Fg/4tZ+OsiBYqqm8xpYMV0rFuQu
 JhDJ9efsYfw+nkExr/u4v+ccUJs4QEwikuOe7LnvzXybDXAXHgy6ELWBq9vA7j7X687z
 G2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723412193; x=1724016993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6njRn27TxDmSq/GVr40a6HRZ/KjDgpiIMW8LUYelVT0=;
 b=rd2SXUYzRQX1C2VHkRlhtHkWeW8O6W6qYbAW38jxXYXufBxGtMlZrd7K48Xxn0HQln
 GQPDjZ7kEG5DFXz0vmzQU/BELjjFU/5AjY0gx7wKwPQOSR1as8hQIIs77WyMacq/Csu2
 D4BLAKE3EDTASrhFprWCMhUfC4k+EdH6rzJLBqTbRsd1c+bFzgllkFi4UIDWHTEjO1dN
 rvkGTEYNlFDPzz7qwR47quBDna13l0mQVguS+o5avCysEIcYZOjGvdluYMF/aZb0V7zn
 ygvQKyHSI7b2lUNOvuonDPdpCmpTAMPbprSqvIiixS/jNbrAn8YZziKPJLv6jT1ad64b
 cb6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI6RDgSvMEkRbmEibyUcRl7QKAGkE2yHaMCZC7cUWK9OUqAZqDCAQ01zoFwCwX+ex8HXO5u3MxFeqIHV0ZtHhRafzXr7c=
X-Gm-Message-State: AOJu0YwOBSgo2mlDhvt6PCDquaqVbm4YFzCVGwNqAorvjl1ZitJYrqXw
 rz8Nbqd90aPlN7yLihb0F18W+uP1fqps/cG872mn6gsJgazRtryNErh+yKDydis=
X-Google-Smtp-Source: AGHT+IHH6M+jKvyxVrov9K+M4JZOYkadHIENEI3awxfqpDStW0eSimxnJelWwggP/6VL3VW1lEtq7A==
X-Received: by 2002:a05:6a20:9f4e:b0:1c3:f4b6:6c0d with SMTP id
 adf61e73a8af0-1c8a00ad5femr6470292637.52.1723412193200; 
 Sun, 11 Aug 2024 14:36:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fce5624csm3515054a91.11.2024.08.11.14.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 14:36:32 -0700 (PDT)
Message-ID: <945e5e14-9a15-4dfc-856f-f3a7d401a5bc@linaro.org>
Date: Sun, 11 Aug 2024 12:58:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/11] target/arm: add support for PMUv3 64-bit PMCCNTR in
 AArch32 mode
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
 <20240809180835.1243269-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240809180835.1243269-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 8/10/24 04:08, Peter Maydell wrote:
> From: Alex Richardson <alexrichardson@google.com>
> 
> In the PMUv3, a new AArch32 64-bit (MCRR/MRRC) accessor for the
> PMCCNTR was added. In QEMU we forgot to implement this, so only
> provide the 32-bit accessor. Since we have a 64-bit PMCCNTR
> sysreg for AArch64, adding the 64-bit AArch32 version is easy.
> 
> We add the PMCCNTR to the v8_cp_reginfo because PMUv3 was added
> in the ARMv8 architecture. This is consistent with how we
> handle the existing PMCCNTR support, where we always implement
> it for all v7 CPUs. This is arguably something we should
> clean up so it is gated on ARM_FEATURE_PMU and/or an ID
> register check for the relevant PMU version, but we should
> do that as its own tidyup rather than being inconsistent between
> this PMCCNTR accessor and the others.
> 
> See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en
> 
> Signed-off-by: Alex Richardson <alexrichardson@google.com>
> Message-id: 20240801220328.941866-1-alexrichardson@google.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8fb4b474e83..94900667c33 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>         .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
>         .writefn = sdcr_write,
>         .fieldoffset = offsetoflow32(CPUARMState, cp15.mdcr_el3) },
> +    { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
> +      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
> +      .cp = 15, .crm = 9, .opc1 = 0,
> +      .access = PL0_RW, .resetvalue = 0, .fgt = FGT_PMCCNTR_EL0,
> +      .readfn = pmccntr_read, .writefn = pmccntr_write,
> +      .accessfn = pmreg_access_ccntr },
>   };
>   
>   /* These are present only when EL1 supports AArch32 */

This fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7551982466

FAIL: duplicate register {'name': 'PMCCNTR', 'regnum': 96} vs {'name': 'PMCCNTR', 
'regnum': 79}
FAIL: counted all 219 registers in XML
FAIL: PMCCNTR 96 == 79 (xml)


r~

