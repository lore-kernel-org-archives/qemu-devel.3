Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5EBC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoF0-00077t-7g; Wed, 07 Feb 2024 15:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rXoEy-00077M-5O
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:09:52 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rXoEw-0005B6-HL
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:09:51 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so860149b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707336589; x=1707941389; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IelbRvG3OMN2FgBCSfkKZhNE958F64hkX70POJQHsrM=;
 b=pdCnbhK0zgPZFnYuIjLK9EpJFmmNKTIViTvZ4n+4YB5R9ZiSaxjT1g8D4OqXpaUTVn
 lsK/msMlf8hz3CKwM3CuHkM7A+GctRAW/dzFtfSVhj4WruknpBV2Mzt+Q64cjlwgWWWw
 rLJuGQ1az7lTNj6HOPkA16KR9LbE37WTDWTLRu080Mo79hHqkozNz75crQpCKl/8V5mb
 yz84nX5q4NhJx2IX/AjUMlw1Kr49Y7YnDL9E6lidK5tAujtQZImzulhwq2/DmQFtZd/G
 sB/Rb+1MAOtxnUsw3nSaTLp1dXJB3hlc2NNkZdvFh00Jxuz3ZVnWV9cHIjDJWbz/T+si
 ZxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707336589; x=1707941389;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IelbRvG3OMN2FgBCSfkKZhNE958F64hkX70POJQHsrM=;
 b=IyKsjxiSLx+Y7Rza67ZZYAYmMLm2AEn21JMhYSjpmhqqK5n+lQliRZkzpSzUkfDLhT
 T+VdJCGcocXLko5RYdMBbKRug5RBsFuHH5pSsUBMbDpONHvs0WSMdBmzAOn3JCuv+mxm
 eumsQI8ZRWH19chl1q2sC8MrjAq4IWAg9AS/4JFRzksUW+pwe2ng3d33UJyfwcE9g1jq
 0ODjfqYalLqiAhzOnrmmQxH5VZCZ2NP9zhayEGYSHWCqZsbinA2yYPK0rBsyQvvP8OnX
 auKTf340TR+jkqas+II5va08aji99ttDRw1QhDnpzUE/juaKBJSU7WuXXHPzM0IQ9ZHT
 fddA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh3YY1aXh+/7eTwe3Aa9CAmBvvBMFpZ3LDheOhGtIF6IZtPJ7f7s4oJhiGarS5L2fpF3cA+qNN2LgkCYkf8hwzQPtiGFM=
X-Gm-Message-State: AOJu0YyvpVovbOXKudfyykC2ImqqZ146+s6ADuw08aPEijC4SNfUtxrv
 3ndbPh7xX/oWOsUdfqj8yxk4FLHbIKiSnctVOwtIm0JqT7mYDDWgfPPEHvjeNzP7TDGF64kgHD/
 3
X-Google-Smtp-Source: AGHT+IH+gJPAaqhji1wyJ1ECKckOgF6LkwrlaxujXwHAqvt6fgOEnE0bzCHyywtus50ECiuCSz9S2Q==
X-Received: by 2002:a05:6a00:d77:b0:6e0:4204:2d04 with SMTP id
 n55-20020a056a000d7700b006e042042d04mr3455887pfv.26.1707336588228; 
 Wed, 07 Feb 2024 12:09:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWu1n9ltQtFPZvqOknMMerW3Kf63myDrLRlIU7vK9Cj7U3oKxmAaJ/vnz3tgt8mglDwocGRKWLxRTCEhkiA0pfvqgOjO8M=
Received: from ?IPv6:2804:7f0:b402:df90:2add:f1b6:5717:16e1?
 ([2804:7f0:b402:df90:2add:f1b6:5717:16e1])
 by smtp.gmail.com with ESMTPSA id
 p53-20020a056a0026f500b006e0472fd7d1sm2037058pfw.130.2024.02.07.12.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:09:47 -0800 (PST)
Subject: Re: [PATCH v3 0/6] target/arm: assorted mte fixes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240207025210.8837-1-richard.henderson@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <6c9b8fac-319f-3854-3550-8219ef74fe2d@linaro.org>
Date: Wed, 7 Feb 2024 17:09:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240207025210.8837-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.632,
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

On 2/6/24 11:52 PM, Richard Henderson wrote:
> Changes for v3:
>    - As if /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred is "sync".
>    - Fix do_st_zpa as well as do_ld_zpa.  Oops.
> 
> Because of the above, I dropped Gustavo's t-b.
> 
> 
> r~
> 
> 
> Richard Henderson (6):
>    linux-user/aarch64: Choose SYNC as the preferred MTE mode
>    target/arm: Fix nregs computation in do_{ld,st}_zpa
>    target/arm: Adjust and validate mtedesc sizem1
>    target/arm: Split out make_svemte_desc
>    target/arm: Handle mte in do_ldrq, do_ldro
>    target/arm: Fix SVE/SME gross MTE suppression checks
> 
>   linux-user/aarch64/target_prctl.h | 29 ++++++-----
>   target/arm/internals.h            |  2 +-
>   target/arm/tcg/translate-a64.h    |  2 +
>   target/arm/tcg/sme_helper.c       |  8 +--
>   target/arm/tcg/sve_helper.c       | 12 ++---
>   target/arm/tcg/translate-sme.c    | 15 ++----
>   target/arm/tcg/translate-sve.c    | 83 ++++++++++++++++++-------------
>   7 files changed, 83 insertions(+), 68 deletions(-)
> 
Since this patchset fixes the "prctl() failed: Invalid argument"
on QEMU user-mode when both flags (ASYNC | SYNC) are passed
to prctl(PR_SET_TAGGED_ADDR_CTRL, ...), I tested it again --
expecting no different result -- so:

Tested-by: Gustavo Romero <gustavo.romero@linaro.org>

If that t-b tag doesn't make sense, feel free to drop it :)

Thanks for fixing it!


Cheers,
Gustavo

