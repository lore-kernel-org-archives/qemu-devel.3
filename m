Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE16C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhcSo-0004lR-Cu; Tue, 05 Mar 2024 16:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcSm-0004l8-Vs
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:36:41 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcSl-0003kd-GI
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:36:40 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-36602d8ae4fso1258295ab.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 13:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709674598; x=1710279398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uIDPaQ9p4Bh8kYkbG1aNC/r3mhO071zWcGdOe1pZtEw=;
 b=pUmNQEzs9Hv+pEDYGY/ePNU92wiUbQVpFdz01XaTyboiyyOg/xi8wO5hMJOY9JiBLR
 vxjEiarriaqlotCPAuVkc2v1yYJFgYJqCrl6PpV2ZfpniIYcTw1JzUEglWKRBew+85B9
 sV40W4BwiuPnTU3zK0fcBRR82UX1ic31gNvgzsfxEoHl+xIm0bNeo65NFDURia8AHys5
 2nrs5NKB4ZzMakrS+gIIniikopodRcDaE2zDVoU88quMnVallkDRmp6Lom28x88P8NK2
 we9jP+LI97GClzt7eL1pD8BOFObqG6Kn9ZZWb6Wuh3gz3RPlbz37a5+pRhAzKGSpS1Z/
 S/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709674598; x=1710279398;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIDPaQ9p4Bh8kYkbG1aNC/r3mhO071zWcGdOe1pZtEw=;
 b=oSdF5BVpID2gvYEHw7s2zQ5A/HAWoiksCm3Atdzbvqg8g5LcKYY+bWpreG7I5pNsk/
 dhb1jCSgM5Kr9Oq7kitBLHV/7FSYoMHbsDOPwtllrQ1VfEEvnIgGkis9QIt/lxN5pEdD
 vKL6gCnoX7cGwijHwCpdgbZsZ8UdI7T+BOiWTMmSCGLUhRyK5M5+qSbj0g8MPMRZH4MP
 gwYH2K3yqJN53JoZc1Fimf5Er+RgdswHcugdWOffi/BcVrX1DJdDg/+pMtjrIY/mIV98
 rnif4qu55A4vwPCd4L+Z16hJE/v8LDlFFfK6EBtdVGBUFj5DqvxrODnfEpC6lZPNiMdo
 x3qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAgOz2FGgssfL4iqSyn3NynnVJ4NQ8OdWid0OTyHR82y12r/6frGt86rQTDYN9HtplhDmI781+zokg/CSpDG24QC/dAwE=
X-Gm-Message-State: AOJu0Yx5g/FnOxjyf06Huo8lZ1akDThJ+n0zSl0gx45LWIMrWWWEcxXO
 n/ycMFW0aUoktBvi8cfEjjzXWUGtEawrpNtugLJSIXX+UorHIaRphBLGFRkepxE=
X-Google-Smtp-Source: AGHT+IGfvf0lbv7gUsA3bN+OtANzPzHleeQB7jgIvssQcmBKRvr1uQt4P2+meVY4BZatU3m+DNSupg==
X-Received: by 2002:a92:c26f:0:b0:365:29e4:d95d with SMTP id
 h15-20020a92c26f000000b0036529e4d95dmr14481486ild.30.1709674598153; 
 Tue, 05 Mar 2024 13:36:38 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 q12-20020a63504c000000b005df58c83e89sm9684140pgl.84.2024.03.05.13.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 13:36:37 -0800 (PST)
Message-ID: <f3db8d07-71dc-4b25-b50a-94f52b5ad3b2@linaro.org>
Date: Tue, 5 Mar 2024 11:36:34 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 04/23] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
 <20240305070331.2151131-5-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305070331.2151131-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x129.google.com
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

On 3/4/24 21:03, Jinjie Ruan via wrote:
> Add ALLINT MSR (immediate) to decodetree, in which the CRm is 0b000x. The
> EL0 check is necessary to ALLINT, and the EL1 check is necessary when
> imm == 1. So implement it inline for EL2/3, or EL1 with imm==0. Avoid the
> unconditional write to pc and use raise_exception_ra to unwind.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v6:
> - Fix DISAS_TOO_MANY to DISAS_UPDATE_EXIT and add the comment.
> v5:
> - Drop the & 1 in trans_MSR_i_ALLINT().
> - Simplify and merge msr_i_allint() and allint_check().
> - Rename msr_i_allint() to msr_set_allint_el1().
> v4:
> - Fix the ALLINT MSR (immediate) decodetree implementation.
> - Remove arm_is_el2_enabled() check in allint_check().
> - Update env->allint to env->pstate.
> - Only call allint_check() when imm == 1.
> - Simplify the allint_check() to not pass "op" and extract.
> - Implement it inline for EL2/3, or EL1 with imm==0.
> - Pass (a->imm & 1) * PSTATE_ALLINT (i64) to simplfy the ALLINT set/clear.
> v3:
> - Remove EL0 check in allint_check().
> - Add TALLINT check for EL1 in allint_check().
> - Remove unnecessarily arm_rebuild_hflags() in msr_i_allint helper.
> ---
>   target/arm/tcg/a64.decode      |  1 +
>   target/arm/tcg/helper-a64.c    | 12 ++++++++++++
>   target/arm/tcg/helper-a64.h    |  1 +
>   target/arm/tcg/translate-a64.c | 19 +++++++++++++++++++
>   4 files changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

