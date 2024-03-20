Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46164C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2O9-0005x1-O8; Wed, 20 Mar 2024 16:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rn2O8-0005wh-Ge
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:18:16 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rn2O7-00070o-00
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:18:16 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so183402a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710965893; x=1711570693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0g2ewkBwGtZphnyaMlw+pjLQWUdy7YDAogBqxB/fyEE=;
 b=XzsJmQ67iUigxrz9mUZrj/abdJoRUb+S2tMg5BbQHyEtdJc+1zG0bAEOyGWq6xraET
 9r/CQa12L+nA/wJ6xK9cu8x+Qb8x2PyA9pjcAv0NSsituAJaHubryPbfL5dKCsaAAU77
 z3mu0/btHhykt97tq30wpZ4pRq56aeLvwNRTDGAJvQJClrybU0kaPkg8Wgo6p8tFmyQp
 4oewD2p65vqQzrzx6+H/Btiy4Q1eMjsZGYCzHOBPWFHvpruMwFuLEv2OHSrA36e6S+oB
 8YBchXLeLqDWJZFtoafyHVkHP6difQ5MwfQS/ytkt/2pXiURjQQwEXKM9cOLNhRU8cxr
 +L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710965893; x=1711570693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0g2ewkBwGtZphnyaMlw+pjLQWUdy7YDAogBqxB/fyEE=;
 b=UqyFO2lf99mZ+XryNMinwAQzSqYvachiJJBQBQpJ61Kjk7nhoUmys4Z/W9nw6aNxhT
 xnuCYc0it/FKyK+brcP+TuIyMOLtEzLDIV0ZpCoisDllmTaCUhK+sI6DF5tJSZ1geYf0
 M2VHy4+N0q/s+yoaFxtOjU3ANf+YPYmwkqjCE7uVCXFBM5TMfJyHscTVbCyRH9LvEB7i
 OHlNVX3HFgEG9dkEu7aTNtCJyemzUO6rXNksE9Tqk461FooQss3ZmY2C9Pl2C5MigunW
 pVFf32GFEZrUtS0/IpTu9ceUySuWRz2iHo/NphpPwcV0bwreISkbEr6P7DphiyLeMlZX
 kcsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuSO5bbk7nQlJNNWYClVQ3fs2vXUmaHNpqYmvKsS7FQISGezgCoMRLmBTKveWigO2EP4GA4eZrBSKTLYhpt7+WM+QZlMM=
X-Gm-Message-State: AOJu0YxyZ1y//muPiSDXK310Mmhyg2TN8t50a2SX7pdD8lP9R8ZSZB+5
 tg3jIqUgEZMuWcBw3MOdxVDmhCXRVCjrPZPBy7xckgd988n4g/g0alrfMEZxAOI=
X-Google-Smtp-Source: AGHT+IHdr08UWrcnIZlu+i9Se4QkdOMTCKi20OV7MACR8tWqXSYao2n+I3gl8W5HTMF6crbvaKdFig==
X-Received: by 2002:a05:6a20:9f87:b0:1a3:6b56:d4d8 with SMTP id
 mm7-20020a056a209f8700b001a36b56d4d8mr8905994pzb.48.1710965893556; 
 Wed, 20 Mar 2024 13:18:13 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 mi16-20020a170902fcd000b001dd578121d4sm14102988plb.204.2024.03.20.13.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 13:18:13 -0700 (PDT)
Message-ID: <00c69df0-b097-49a9-8287-f6db63dbbef5@ventanamicro.com>
Date: Wed, 20 Mar 2024 17:18:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix mode in riscv_tlb_fill
Content-Language: en-US
To: Irina Ryapolova <irina.ryapolova@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20240320172828.23965-1-irina.ryapolova@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240320172828.23965-1-irina.ryapolova@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
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



On 3/20/24 14:28, Irina Ryapolova wrote:
> Need to convert mmu_idx to privilege mode for PMP function.
> 

Please add:

Fixes: b297129ae1 ("target/riscv: propagate PMP permission to TLB page")

> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index ce7322011d..fc090d729a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1315,7 +1315,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       bool two_stage_lookup = mmuidx_2stage(mmu_idx);
>       bool two_stage_indirect_error = false;
>       int ret = TRANSLATE_FAIL;
> -    int mode = mmu_idx;
> +    int mode = mmuidx_priv(mmu_idx);
>       /* default TLB page size */
>       target_ulong tlb_size = TARGET_PAGE_SIZE;
>   

