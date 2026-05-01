Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223A9FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkfk-0005v3-2k; Fri, 01 May 2026 06:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkfh-0005uQ-OG
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:00:33 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkfg-0002B8-60
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:00:33 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-362e50b4641so1103901a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629631; x=1778234431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pLkwIXJsjLAshz2fU0cTuffi/lJHGNRnY8UpHApKS+8=;
 b=StBKuuOvGX619AvrcKxVGCRncifrDvQ1WSo4Vx2nQs4/FCcAg9tgXJLwZEXcyF6rhA
 IZu/D3oiC1X9NlHVwFFcPMxKXDDrAFYmLfii0Gufvi/aQNtQes+tWIwGdL/792ShwZdF
 zRHueKvLVXMbaB2VrHLiCc8lKLVHjqZ+GJaX4vwHPULC52u5/wMZdAYoOp7f311XyT/g
 fp+7HM/1a4NvMqeK7niCxPYC89Pqd0UX+3/d5B0vHCzCp9bEKYeRM9evDJugrlpZ+Cux
 RnvTeT7WqAs0W5ZmSmXlsucp07wbIa9MDs0ObJKZ+iWDN+UbeOUkQUX+PeMOYkcga322
 aLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629631; x=1778234431;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pLkwIXJsjLAshz2fU0cTuffi/lJHGNRnY8UpHApKS+8=;
 b=AcQG/2EnaoG+DqOORk0Ac/cSTHxhjgQbtDjurWzIrgJ+Llwkw0Nu1UiDc+4VGLV3FS
 8AujP3OtRa2lh4/fsJkTRjq+YYblHY7j4kCqFb+e1Ke/MnfP0oW+tZ/V5ekARu7wSrMK
 0WXUck4KhiEr+B2KcgrqUQMwUlabJdtaUDw8r6qGiSPZaPST2O/3tNoEeT5vtSMuub0Y
 PaRGR1Li/Y6R0gWZSZBqrbYOJzIVATV2zPrcAG+z1rMMa1IbjSAkvjoqgXquDQuQa0P9
 jABi3so+KSTxlFD8useukEMVgtUjtlbfZGC3Nhu14o/Le2bd3rabbIis/wofTZnlNe8M
 Qr0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+q8ni5Xh0OdquOgKswkPMm8sjImSAT1WjGo3qoCm9IymvbGU0OybAqEnhG8zUpXDGkpMIfuHBTkNMt@nongnu.org
X-Gm-Message-State: AOJu0Yx5kqkq4ruCOOPqvQSeDwNQy5YU1pw5T1ng5Rcn3P0ej1v04Ela
 gKHJFcE+nXgY7bM4Dd+UX3ViRD6ljtVkMjTQu6d6vN+l8OUlF2w9/9MQ4dvSYD4yZghEiEwVP8w
 YQhxbeGQ=
X-Gm-Gg: AeBDiev7IG9K00CExH8CnXcGgboLfhXBzVMOPjRn1ECZdgw8AQlw1AjxBtfFuE9Xhvt
 TBS1qB/Ow6oC73v4437o5AFlzasTOtw/t2RagOu548Dsxie1e5poM+T1Gj5wqK1Sbd4yO5rPaOC
 U6OPUVOKmT5/Al1r2xEBtyqaItjfGH2t/43spnUY3Jcvl5yKHNJvn5m7/GJ8v/C96dk2mS7oAXH
 PBqkVG6j79i30Ltj9cvyZCw7hk5xU/VSVE8famNmD0QDe8c9r7miYvGkeQbhfiuWEvU12carmK5
 ZwMjGotXhu/bOc2I4duW0EnOAm5rL5nxsScKUrXEIctL2/LBkKucfAMDMrcTLsxQ9AXV2jzxX7A
 i1pOnw6VEbXnl8XgBMJtrVmOO/uJZo0Rb/yf1pbRRy49Xb/r/9Azz29jhgQ1Zx1NRTrjTyy8+GV
 rAziJgTPo+lxdpG3B7OM30OjMoY6OBQ8G7acEut1Kwds5FrgubZYtS
X-Received: by 2002:a17:90b:1dcc:b0:35b:e4f8:7cc5 with SMTP id
 98e67ed59e1d1-364ef654022mr2419214a91.25.1777629630577; 
 Fri, 01 May 2026 03:00:30 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364be00ae51sm5308019a91.11.2026.05.01.03.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 03:00:30 -0700 (PDT)
Message-ID: <01e02448-8ad2-4073-91e3-99a142540f1d@linaro.org>
Date: Fri, 1 May 2026 20:00:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/25] target/sparc: Use cpu_translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/30/26 19:38, Peter Maydell wrote:
> We want to remove the cpu_get_phys_addr_debug() function; update the
> sparc dump_mmu() function to use cpu_translate_for_debug() instead.
> 
> The "mmu_probe succeeds but debug translate fails" cases are probably
> not possible in practice; since cpu_get_phys_addr_debug() would
> return -1 in that situation we make this conversion retain that
> behaviour.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/sparc/mmu_helper.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

