Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC5AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 16:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuZjx-00033x-Nd; Tue, 18 Mar 2025 12:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuZjY-0002vM-8P
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:24:08 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuZjW-0001aC-2c
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:24:03 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so5058331276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742315038; x=1742919838; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UppjjWlWSTLKDWRjdyvOdEUFM+09Ar8wGDH4QMQJtJg=;
 b=FgBY2ZrbmPmFLhl6EDMTOcHFbjuQ9Ncci+Jj2C70wWePLzgrWzavvuAgDjiVEjtvcT
 vAnauGsKMkT6p6/EpCkeUl/arIQlO/dMRVMWrEnDVRTmXfY03yr0fOzBKdI0We2rLnUN
 5gcuZ+vM32cyX5IGzS44M7ZncIAVskKD0H/PGwiP8ijCnIG07Rj6FZoZ68wUfQJ1uWiQ
 55WigwEgbiEQfIrjUWn4n5XGrzwcvpgvZBz1aAOa8J8z40dZYHGPbDJZ0vFAstVKb/00
 n9blIX33fobAQfq03cnfeI7l7PqSX3bRg1k9LvHGLuwOsasXFSH940Koyv0UcSpjloom
 LJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742315038; x=1742919838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UppjjWlWSTLKDWRjdyvOdEUFM+09Ar8wGDH4QMQJtJg=;
 b=KqHj8FGgpyeH0Jzy7eMqAh4LEtdncn3v7EWUVdzA9PlXTBnc3ulsruqGifRcfiAJrk
 fBDrPJ0rqRBYR6Bsr7Z29fGItXLnQvshc2uT+AXSY4rQ3iwfYkuBgB1Uiu3eLlyMMM0F
 aqDn97W5HPNoUPefPpAxSurpeRItwVyjzee1bEpi/vV4ts0jofwb1kWUYNE3jALTr1Kz
 J0YqXWFRsaWLooYkHOCf8sl4gUaQQanpowSNkiC6tVWmc64vsxDmfSwyG4fbMxadjOUQ
 aodqPVFsNhKKWv9Czqs/RY9OB1s8Ylp6rs1YNt5F3v92GlrgCvr6HKuB78z79LqSSj7i
 SxJA==
X-Gm-Message-State: AOJu0Yz+DhGV2WNMoKqmykmLS/L/hl5A1yREg7bALDiv/95h2gdXY5FK
 NY+8LJJGeoqkwVjkU2xqfKxfJhyGFRaBrsN3UxPmb/eFYigF6o6BfRqQ4vkdFHhwq/TA7kGwptJ
 PIn6Duz2Yy+ehxn3WkfslxY7ZYv0DXtyG9VEexA==
X-Gm-Gg: ASbGnctkCLIh+MFKYgvqHaFWoXPbO799GFxMzfzWfmBKGUvxT8GiiclIkZaKmsSBHiT
 9n1U8wzVzR899GaLrmyHH3FyfDVqtgJdpI6SQ8R75Afq22aK/sjwHycv/9ww6J7LB+PLt+kn7x4
 Ca8cFprjN+UKL3KmwqzJ3Tom98e87SV5UzYJSw0w==
X-Google-Smtp-Source: AGHT+IHhFxRAmLC45GEZDWj8bbxNM/R/ZALB27ky2WP4bZ7IUeeDZe55PscTAcrFUCHxRgUYyxeCH5XviUTrsKGSEyc=
X-Received: by 2002:a05:6902:1ac2:b0:e5e:18bc:f17 with SMTP id
 3f1490d57ef6-e65118f92c3mr5198769276.1.1742315037885; Tue, 18 Mar 2025
 09:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250307021934.1080115-1-gaosong@loongson.cn>
 <20250307021934.1080115-3-gaosong@loongson.cn>
In-Reply-To: <20250307021934.1080115-3-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 16:23:46 +0000
X-Gm-Features: AQ5f1Jr02re6pAX0dhbhBXV57quliRglQB0QndJaf1hfrSVQXty9tyy3EtvKA_o
Message-ID: <CAFEAcA_7x4Ee5gj=CP_XbR+bcZJdXJfqjJ6c6ix8OVvAmxKs3A@mail.gmail.com>
Subject: Re: [PULL 2/2] target/loongarch: check tlb_ps
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Fri, 7 Mar 2025 at 02:42, Song Gao <gaosong@loongson.cn> wrote:
>
> For LoongArch th min tlb_ps is 12(4KB), for TLB code,
> the tlb_ps may be 0,this may case UndefinedBehavior
> Add a check-tlb_ps fuction to check tlb_ps,
> to make sure the tlb_ps is avalablie. we check tlb_ps
> when get the tlb_ps from tlb->misc or CSR bits.
> 1. cpu reset
>    set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits a default value
>    from CSR_PRCFG2;
> 2. tlb instructions.
>    some tlb instructions get  the tlb_ps from tlb->misc but the
>    value may  has been initialized to 0. we need just check the tlb_ps
>    skip the function and write a guest log.
> 3. csrwr instructions.
>    to make sure CSR_PWCL.PTBASE and CSR_STLBPS.PS bits are avalable,
>    cheke theses bits and set a default value from CSR_PRCFG2.
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Message-Id: <20250305063311.830674-3-gaosong@loongson.cn>

Hi; Coverity points out what looks like an error in this commit
(CID 1593475):

> +bool check_ps(CPULoongArchState *env, int tlb_ps)
> +{
> +     if (tlb_ps > 64) {
> +         return false;
> +     }
> +     return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);

BIT_ULL(64) isn't valid, as it would be off the end of a
64-bit value. Should the check be for "tlb_ps >= 64" ?

> +}

thanks
-- PMM

