Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2E1C47422
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 03:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTYuj-0006Vp-Qe; Fri, 26 Jan 2024 21:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTYuh-0006OO-Pz
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 21:59:23 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTYug-0004vj-8W
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 21:59:23 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ff9adbf216so8382067b3.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 18:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706324360; x=1706929160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oYwRDpU6v6JW6v0+Qz5m8bYUmGEYSlsRj2lSwurCDNs=;
 b=szE0On9FSd6AQYpFz/rbWj2JQLQ8J8NutoVztNaLCr+aEMYwyIeierd0GbAYbIeJJL
 1KpYLKlGHCeefrBZtg36EqpLyDVmQhke5A8cGur7QPLMqgvBck4y4kNYieZHUgsy0tPq
 RHJJZAtaSf3p5M3MC2mWkMzGPVcV2l9elD8UpMTmreWPCvzdI+1/lqspDHnkKi8rg7Yq
 /g5VVCnLBZ8VpEe/gD4Z/42kQKA2tNiFreXIR8s9td/hl6NJrhtVEhiY+kMnrseOr0u6
 xmxoSdD4RxbozSQHZKC/Tba+rd+PwGOVjQy0UGR4W78MiAqIjBRRzjJgBK53MHNPG03e
 91Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706324360; x=1706929160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYwRDpU6v6JW6v0+Qz5m8bYUmGEYSlsRj2lSwurCDNs=;
 b=Ch8vmqRNG7qkvWvsnPCpP/yVvRb4u/BB4vMMcoL6ntVuW3p0YusMBNnKIXr8lBvPU4
 EP7cA+9gGZIkAN30/gdorns1XTEwWPPwjhhc7F7w2d7pZUuztKkMfR6r6bR6VPQWhgWq
 hhKg0G+eCuGhW4/XXp3cUantaRsrVuV+ffJVpuv7ztEmWM+YGPBuVP+6u7ug1eX3uUXL
 tefAIKdVP+1n566fRLd7ub1ThUEpMaAZnl6L2SDOWkj9PdmJrlTyDXCnWJr4Ae0qTlLt
 P9GwRkLFRjCrI7e+6K2QN8J+OFMWsDtF+zchMpYV3Uswodf4CThfGQ3I+hcs6rVRbk1T
 4Jjg==
X-Gm-Message-State: AOJu0Yzq9UtFrg0WgB9fZSBn/c/QHFVK+fk1VAm8vWt1XnTBP6YhEqoL
 mPjUASN+eF8hZv5jaZvr3e6BUd2sjri6xeEF9lgjyfLBMDWGrgsdRRyurddX/0U=
X-Google-Smtp-Source: AGHT+IE6npjZpa2TbAiGjEqYRZbHM2jlCISbGjqAt/wJg2/tq/++eQnJfirdtl/F2Ni7+NsbHPSnDw==
X-Received: by 2002:a81:c444:0:b0:5ff:7e6d:f549 with SMTP id
 s4-20020a81c444000000b005ff7e6df549mr938875ywj.27.1706324360707; 
 Fri, 26 Jan 2024 18:59:20 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a170903019100b001d89bce478bsm1571844plg.243.2024.01.26.18.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 18:59:20 -0800 (PST)
Message-ID: <4d73dc67-d691-4a0c-a7fd-97fece4a46fb@linaro.org>
Date: Sat, 27 Jan 2024 12:59:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/s390x: Emulate CVDG
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Ido Plat <Ido.Plat@ibm.com>
References: <20240125123059.220131-1-iii@linux.ibm.com>
 <20240125123059.220131-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125123059.220131-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1132.google.com
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

On 1/25/24 22:29, Ilya Leoshkevich wrote:
> CVDG is the same as CVD, except that it converts 64 bits into 128,
> rather than 32 into 64. Create a new helper, which uses Int128
> wrappers.
> 
> Reported-by: Ido Plat<Ido.Plat@ibm.com>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/helper.h            |  1 +
>   target/s390x/tcg/insn-data.h.inc |  1 +
>   target/s390x/tcg/int_helper.c    | 21 +++++++++++++++++++++
>   target/s390x/tcg/translate.c     |  8 ++++++++
>   4 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

