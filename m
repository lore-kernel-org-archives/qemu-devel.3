Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09837C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRD7g-0005J3-5j; Tue, 09 Jul 2024 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRD7c-00056u-WC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:51:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRD7Z-0003Ha-S4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:51:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fb05b0be01so31341335ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720540271; x=1721145071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LlhSgxXmeIbp9/lrJEjIjrQkX2Q1dIcFiuiUW83SnM4=;
 b=SE6vLJXr2tMjtOWeccvU0CoMse2LcEoZRn4FeXW05CHVqwfQ1QlWE8AYMLXuWDCAV1
 mbK8GQPOSspntpfi26cN9U7j0j6ihK7L1s2j1PBgve4IJ2xms81KDr0oVsrReYG5Srie
 gzRkJvCt1bXVADTlW+V5zXlSlGgwtvbddaq291Zl7NWYcbakfaIAB47tpDIOK6tVibEc
 CGLmtAElUXmRZIkkoa5X25LH+4IuyKKV4GdPHA8bWKEqTy2OjJSeX46zSC3l6uOrzGVf
 mQga8LdvmXgNwMKoVF5pQEmkizFIUGV4IhajgeFIJ1tw/XylXs1q/2rrgtDOTS/aEoY5
 K2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720540271; x=1721145071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LlhSgxXmeIbp9/lrJEjIjrQkX2Q1dIcFiuiUW83SnM4=;
 b=SXsj3vJD1WWheK/vnrkBDpatLbNno+vfxBMG1JO9+Xd1hnNt63Tdl5G02iIRzwy/QT
 frXlZ7vlKMmRDZ+x4zG5k16Ftt8dc+mOi5If/ANfa4VX9EmzaJCjTFN4s8AUp9eFPEt8
 Z4a0lJCtyWI6EEMfaWmsbN4lbnliEOZEJP5z9ob8fB937J9N1Xby0+NhMEMt+E0sNuOM
 wiJ4n2S5uyQ6/V6pOR3GQIRiA13M6O0CH8/1f4zDPsUHUDGSmDI1izWKDWs8udovGC/v
 tA2lTWCit6U1Gw4DYdvwIwPtrfu6qDicHUl4528osMjxy2DUTAtdCxFQUeEeLq6K099w
 nl/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxGmeq4NUPCGC9tl3EOYmf1N6Mxkhjr6Wda2CjRrJgqUflShviE4g7rSvkNCRNQHLBsHCJXHWtJzajYsqwI/LaqAqCBoI=
X-Gm-Message-State: AOJu0Yy3OL1IjLe4WqA6A9nztlV5Egv5u8KCRTgEtKUYI1bL6Nzsnr5X
 KBmBPmRA33p+dz7QrIeXKPWxuO1hIiCjxZKPBIPGgmwmmJX4C3lGLsEaJ4jeACA=
X-Google-Smtp-Source: AGHT+IGVDNcSEoLySu6WfzZoAgY9g5wFajpOcqHpeFxToLzYQJJUbPwf5Yqr9pTotgk4lIRN2/Y+vg==
X-Received: by 2002:a17:902:9f8f:b0:1fb:7f2c:5644 with SMTP id
 d9443c01a7336-1fbb6d59c22mr19592045ad.31.1720540270809; 
 Tue, 09 Jul 2024 08:51:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a3fd26sm18288665ad.117.2024.07.09.08.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 08:51:10 -0700 (PDT)
Message-ID: <5b37a1af-e066-4916-9071-c9bf0c84d837@linaro.org>
Date: Tue, 9 Jul 2024 08:51:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: LDAPR should honour SCTLR_ELx.nAA
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240709134504.3500007-1-peter.maydell@linaro.org>
 <20240709134504.3500007-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240709134504.3500007-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/9/24 06:45, Peter Maydell wrote:
> In commit c1a1f80518d360b when we added the FEAT_LSE2 relaxations to
> the alignment requirements for atomic and ordered loads and stores,
> we didn't quite get it right for LDAPR/LDAPRH/LDAPRB with no
> immediate offset.  These instructions were handled in the old decoder
> as part of disas_ldst_atomic(), but unlike all the other insns that
> function decoded (LDADD, LDCLR, etc) these insns are "ordered", not
> "atomic", so they should be using check_ordered_align() rather than
> check_atomic_align().  Commit c1a1f80518d360b used
> check_atomic_align() regardless for everything in
> disas_ldst_atomic().  We then carried that incorrect check over in
> the decodetree conversion, where LDAPR/LDAPRH/LDAPRB are now handled
> by trans_LDAPR().
> 
> The effect is that when FEAT_LSE2 is implemented, these instructions
> don't honour the SCTLR_ELx.nAA bit and will generate alignment
> faults when they should not.
> 
> (The LDAPR insns with an immediate offset were in disas_ldst_ldapr_stlr()
> and then in trans_LDAPR_i() and trans_STLR_i(), and have always used
> the correct check_ordered_align().)
> 
> Use check_ordered_align() in trans_LDAPR().
> 
> Cc:qemu-stable@nongnu.org
> Fixes: c1a1f80518d360b ("target/arm: Relax ordered/atomic alignment checks for LSE2")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

