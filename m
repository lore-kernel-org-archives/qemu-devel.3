Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE4AC48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raymA-0001Qg-Ng; Fri, 16 Feb 2024 09:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayly-0001Mh-01
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:01:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raylw-0004Ow-Ei
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:01:01 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so20979595ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708092058; x=1708696858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20w2KNkwcXyrY1rsv8qQoAFKgk5Acwo4B/7qrcZQgtY=;
 b=KSjPSb+i5KbjSnSq5WlNCz314vkz+AUebkhoOKyBE6+PPMaqypKrs5Bb66qTyLRdIy
 jz1ZtEQo7XXVMv8OXwpZ/8bo+W92e22eSO4udfJLdSxSHFSoFKTc71MSPR+oytVllwVW
 yoB+8Z189rs1bgF3u6UNJzF/K7J+V/G+gP2pWlUmRmLj3d4PwT/rPcx5NJK6ims4j1xy
 1qEUiHZkSZ7H31+Grjr3s9VKS+42pJcfW8N6kiRYC41yd5Mjee1XHwUyaTjqrOo3na4K
 Gly/6BFncADn2bIgAGd/YvRAG6yb35ICDBiN6zBHc6htTSwPj/nIrigwT/8m2FVk8/AZ
 UOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708092058; x=1708696858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=20w2KNkwcXyrY1rsv8qQoAFKgk5Acwo4B/7qrcZQgtY=;
 b=IDLvWOFhxNhnSb9kAIUS53kFft0BWtcpjF9UC10BRiQaYp8724Dq+Xf1bnr9JgqJM5
 +oMSSiBxOrJfsr+AZbR6ET56sbBro17R24TE2Ziiorge7mgT+KxCa1QgAmaeJg2d6Bkb
 Yb0xqthHBpXmUmdzn6egPNak5kXFX7c4W3aJ4VNszOB+v2yETlQ3Sw9BnB3yJoNxzIVT
 pNM+0t3wGUjlsn1QcHCUHz/v/CwQjR9oUjn/UIN0VbBIQJFuIOZ8m6KyD/RlP+Dt5Qx7
 ktIff61v4he+8D0Cyj9RdPT0gyZtHklBWr7A6BKRw85MtITFwARLTj1GlHIS1rwzrpvy
 m9Gg==
X-Gm-Message-State: AOJu0Yy86NZyj/82CxwGAnak6Dp3/SKcmXiPzDrTILyHL+6BmGcP0qGv
 J0dBHQvnDdU8LUh/pKkOfvTsMF+aph2g+qafzSwGrQxttbKx3HRCHa0gpGsGWLE++jz8ieZIwnw
 n
X-Google-Smtp-Source: AGHT+IEuKPPplDjyMpoQXN0+CRzkfQMUVDfUWH5Ss85dnEZiyCgqGeXG4Z9sRoIDq/U3+LRuyQdi+g==
X-Received: by 2002:a17:902:e849:b0:1d9:713f:6224 with SMTP id
 t9-20020a170902e84900b001d9713f6224mr5383956plg.11.1708092057903; 
 Fri, 16 Feb 2024 06:00:57 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170902b60b00b001d8f0e4bc32sm3019642pls.144.2024.02.16.06.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 06:00:57 -0800 (PST)
Message-ID: <4ba89060-c334-4a78-9222-22c928e77bfc@ventanamicro.com>
Date: Fri, 16 Feb 2024 11:00:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] riscv: set vstart_eq_zero on mark_vs_dirty
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com
References: <20240216112806.997948-1-dbarboza@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240216112806.997948-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

Please disregard this version. I just posted a v2 after feedback from people
in Gitlab.

Thanks,

Daniel

On 2/16/24 08:28, Daniel Henrique Barboza wrote:
> Hi,
> 
> This is my shot to fix https://gitlab.com/qemu-project/qemu/-/issues/1976.
> 
> First patch ensures that every vector instruction that changes the
> vector state will call mark_vs_dirty(). Second patch is a trivial
> simplification.
> 
> Third patch is where the bug is solved: check if 'vstart' is zeroed and
> set vstart_eq_zero accordingly.
> 
> Patches based on alistair/riscv-to-apply.next. It can also be fetched
> here:
> 
> https://gitlab.com/danielhb/qemu/-/tree/vstart_bug1976_v1
> 
> 
> Daniel Henrique Barboza (3):
>    trans_rvv.c.inc: write CSRs must call mark_vs_dirty() too
>    trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>    target/riscv/translate.c: set vstart_eq_zero in mark_vs_dirty()
> 
>   target/riscv/insn_trans/trans_rvv.c.inc | 28 +++++++------------------
>   target/riscv/translate.c                | 22 +++++++++++++++++++
>   2 files changed, 29 insertions(+), 21 deletions(-)
> 

