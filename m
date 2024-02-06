Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09223C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNCa-00060C-9k; Tue, 06 Feb 2024 10:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rXNCY-000604-Sx
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:17:34 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rXNCN-00053S-6t
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:17:34 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d7858a469aso42313555ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707232639; x=1707837439; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSoX3wz+SC6Oc2pQuAPkNIb+l0HOZz5F86zphhSpob4=;
 b=uBzfspip7Vs0SvEBraTMj2uTvYQ/x0x9u9WyenggLb7SS12vSSND1/PYVV0hDiN+uM
 xyrEDWgEg8dGigMS42vSprKUeIUPVElt66V4037dQxAep7o9/PTlvr5Q99gfaEObypcP
 cuYMao/WCzk/P9nGtnfiZ+YnFtOtDv6NsVitw9fS8iW5Dlrt0hpoi6Z0YuUOGma+6uNh
 kzC9Frz4Fl/Fo8P5xh+kLNK5voErU505y+3vxZ2bFD/dLN6+cQzLjlLPjQ9QS0e8e8dj
 MGNE4kjzWoYVIT9xwe1oO44bC8Ol8kX5Yh2v+sedYVD2Tj+1fIYU251zO8Ns98xE66bC
 WwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707232639; x=1707837439;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSoX3wz+SC6Oc2pQuAPkNIb+l0HOZz5F86zphhSpob4=;
 b=FmOCimS9dCf/5ndILoHQ2UP+mK+W8bi1xSxulo44Gp7lUMRWSE6QCOmC+M/64QUAT8
 XW9WlJD0nMJNIdgz4iNJmpt7UgxcagS/cR4eYKGv5LURikb9MitSMbxge8PEqBRToUZw
 x/XWOvB5+KuH+yfAobKh2j8VdQuyZLJN7npLyFcfelfHTt7Giqm4nko/Gv8PwV/vyBFu
 BEl8z4Zxq2xdGZpm6oYJqSqWh+r212ESRMcgmWGbqc4ohOyBn3y60y87ywPQ5z7p2A4v
 YLvH4zDoRQUTXmTxaw3jdGaVvgcg2jitS9wfLlc7kZEHBKdoxgzJQujM6/XcSjGqEceT
 LZzg==
X-Gm-Message-State: AOJu0YxLtjBOeyLkvc5AXJP8Fw5jxGgnvGaAdDJPUdzbSQrT6S7uajzj
 CToJayii4PXpUHVq28mt7mAJeHBBhvz5992ZjOLDrogsJeF7FfugOUOcFJggwG8=
X-Google-Smtp-Source: AGHT+IEiicFWzKebVXIYJdPV0PGC7T7TAnXQcsu9rkX6rX20fb2O/xFGUY7ZeLSXag7B5slv5sgwGQ==
X-Received: by 2002:a17:90b:1981:b0:296:9766:11cb with SMTP id
 mv1-20020a17090b198100b00296976611cbmr2362865pjb.27.1707232639483; 
 Tue, 06 Feb 2024 07:17:19 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUneKDGHc6ElVGXJWMCKQbeg+dDz7ZWM8R6Siv3F4ZumvsvIzfkXrHdiYt8OW/b8SDYVEhMbBhT+LeCzCrH3ii/biosXQ4=
Received: from ?IPv6:2804:7f0:b402:df90:2add:f1b6:5717:16e1?
 ([2804:7f0:b402:df90:2add:f1b6:5717:16e1])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b001d8f12b0009sm1977004plk.293.2024.02.06.07.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:17:19 -0800 (PST)
Subject: Re: [PATCH v2 0/6] target/arm: assorted mte fixes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240206030527.169147-1-richard.henderson@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <b09670f6-7b0f-d8da-6187-e368c7c91bc2@linaro.org>
Date: Tue, 6 Feb 2024 12:17:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240206030527.169147-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.371,
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

Hi Richard,

On 2/6/24 12:05 AM, Richard Henderson wrote:
> The first patch is unchanged from
> 
> Supercedes: <20240131003557.176486-1-richard.henderson@linaro.org>
> 
> while the remaining patches replace
> 
> Supercedes: <20240205023948.25476-1-richard.henderson@linaro.org>
> 
> While digging through Gustavo's test case, wondering why it
> should be failing at all, I finally noticed that we weren't
> overflowing MTEDESC.SIZEM1, but underflowing (-1).  Oops.
> 
> But I did find a few other points by inspection where we
> weren't properly handling or supplying MTEDESC.
> 
> 
> r~
> 
> 
> Richard Henderson (6):
>    linux-user/aarch64: Extend PR_SET_TAGGED_ADDR_CTRL for FEAT_MTE3
>    target/arm: Fix nregs computation in do_ld_zpa
>    target/arm: Adjust and validate mtedesc sizem1
>    target/arm: Split out make_svemte_desc
>    target/arm: Handle mte in do_ldrq, do_ldro
>    target/arm: Fix SVE/SME gross MTE suppression checks
> 
>   linux-user/aarch64/target_prctl.h | 25 +++++-----
>   target/arm/internals.h            |  2 +-
>   target/arm/tcg/translate-a64.h    |  2 +
>   target/arm/tcg/sme_helper.c       |  8 ++--
>   target/arm/tcg/sve_helper.c       | 12 ++---
>   target/arm/tcg/translate-sme.c    | 15 ++----
>   target/arm/tcg/translate-sve.c    | 80 ++++++++++++++++++-------------
>   7 files changed, 78 insertions(+), 66 deletions(-)
> 

Tested-by: Gustavo Romero <gustavo.romero@linaro.org>


Thanks!

