Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB91C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 12:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruAKC-0002wK-FG; Tue, 09 Apr 2024 08:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ruAK9-0002pi-Sy
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 08:11:38 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ruAK8-0000om-3u
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 08:11:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e24c889618so44308815ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1712664694; x=1713269494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+MtvqGedlmIcQBUKhZ9lqUhS+zk6jqD402XTV4y5BOs=;
 b=UFGfdVpZCNSjqYwbDWPemraJo8klwWVioEWrLawGWVXMFxLuDFizzkXgGeGh/PwUpj
 KHh3nhgj+X14lNRbjbm/G6T2uW2XiHhGY8vHfPDHqD+2NLJXh0pF3Fxat6tvtjdwI/Vk
 pkfQBaNVaQBiOHane+JMfka07imDxMABC095vO+b2jhwVFVOWnsPRtbKJSjBGKs7Vkm/
 31G66H9sdxQ8I3FoNKhfxSzkz29vCjDVhQUwIi9hpq8NIBtw5/uwvlipxl4+HHI1GS8l
 20brAtp396WB0l6OPT7XyAKFbzRpo7ECVpP+AkOZuFzy3t7Q7qBCT0T/HoN4VQpmjpam
 9kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712664694; x=1713269494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+MtvqGedlmIcQBUKhZ9lqUhS+zk6jqD402XTV4y5BOs=;
 b=bjBy2FPSt3nTe/5cuMrDRDi+rcMSKdKEjnwdAvJDCO/G30AwO4iK7qUl6ovYfGbpMb
 xfipth/0i7oGuhm5ljVMoFeSvpGY6aXAvVcQEC5LrAGDyktC9wUAlZCduzZ0f7zF0H3W
 pD/1s3B9t/MKZCC9br+HyP0R2YlKFvkWwTjNX1dX83zelEngbzXt2zm9+Kbv9edyJGt0
 tSVF9C5TIbCU+qFr3ViljEIJ5YVvh1ikAewdF5HOhCVY0SlP6n53ZoGXXlOS49FxN2wW
 IXjXpAWCB9e9x3eULk7OWPbcnyi8YGbp6m5XEVqYZG6M1HK8/vNYBbm1DmXv10/7PDYY
 hSzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3bK2bWEDmU1ASDsdbZCRKZO7nkGGd8pvYi88tF6dsRpvnRieG6jQGIytj07HhLKIWj5Yf9votO88SA+s6I+vL8zfkk9Q=
X-Gm-Message-State: AOJu0YydgfkWuu0LmHLKKnmt6rJn7vGeOJU1BIn6+0tfRu9vJy5+/VPa
 shUsfonlBRbzn6v67pvvb7rKd05pclM1Ash+R/YM0usKLQIX+AUAJM2r1fs8KbY=
X-Google-Smtp-Source: AGHT+IF/q0ZgQ6ygDRt4xL5QffmD2jz0GuNr9yTnG2vQVYYfWCQC3kUdDrhlyCec7SvvLgIgQ0UBoQ==
X-Received: by 2002:a17:902:cf07:b0:1e4:6e70:25d8 with SMTP id
 i7-20020a170902cf0700b001e46e7025d8mr3577434plg.13.1712664694280; 
 Tue, 09 Apr 2024 05:11:34 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a170902c40c00b001d8edfec673sm8681795plk.214.2024.04.09.05.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 05:11:34 -0700 (PDT)
Message-ID: <e68e899e-444e-4f8b-9b76-9c178516330d@ventanamicro.com>
Date: Tue, 9 Apr 2024 09:11:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/cpu_helper.c: fix wrong exception raise
Content-Language: en-US
To: Alexei Filippov <alexei.filippov@syntacore.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20240329134527.1570936-1-alexei.filippov@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240329134527.1570936-1-alexei.filippov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 3/29/24 10:45, Alexei Filippov wrote:
> Successed two stage translation, but failed pmp check can cause guest
> page fault instead of regular page fault.
> 
> In case of execution ld instuction in VS mode we can
> face situation when two stages of translation was passed successfully,
> and if PMP check was failed first_stage_error variable going to be
> setted to false and raise_mmu_exception will raise
> RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT(scause == 21) instead of
> RISCV_EXCP_LOAD_ACCESS_FAULT(scause == 5) and this is wrong, according
> to RISCV privileged spec sect. 3.7: Attempting to execute a load or
> load-reserved instruction which accesses a physical address within a
> PMP region without read permissions raises a load access-fault
> exception.
> 
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> ---
>   target/riscv/cpu_helper.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index bc70ab5abc..eaef1c2c62 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1408,9 +1408,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                                 __func__, pa, ret, prot_pmp, tlb_size);
>   
>                   prot &= prot_pmp;
> -            }
> -
> -            if (ret != TRANSLATE_SUCCESS) {
> +            } else {


This solves the issue but we're leaving the 'first_stage_error' flag in an inconsistent
state - the call for get_physical_address_pmp() inside "if (ret == TRANSLATE_SUCCESS)" is
both a PMP error and also a non-first stage error, but now we're leaving it to 'true'.
Raise raise_mmu_exception() will give the expected PMP fault for the wrong reasons, since
it thinks that it's a first-stage fault when it's not. This will work now, but any
future change to raise_mmu_exception can break this logic.

I have an internal (not yet sent to review) fix for the same problem. In my case I was
supposed to have an INST_ACCESS_FAULT (1) and was getting an INST_GUEST_PAGE_FAULT (20).
I'll see if I can send it ASAP so you can have a look and see if it's also good for your
problem.



Thanks,

Daniel






>                   /*
>                    * Guest physical address translation failed, this is a HS
>                    * level exception

