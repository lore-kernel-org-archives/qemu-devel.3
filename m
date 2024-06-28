Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C708C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sND2z-0007Hk-TI; Fri, 28 Jun 2024 10:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sND2y-0007Fq-Oc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:57:56 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sND2s-0003Af-5X
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:57:55 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7163489149eso516227a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719586667; x=1720191467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p/6/mO9+cDFjd2Lwn6Pdfpyts2msKL/kmbIlYJPWFCo=;
 b=rNSrAQdOXFnj43IrFAQLkknKbN9MaA1kwia28f1pbsjlhv28tCPqXghBmW1JDUsq+Y
 uIjIMIEUkv2QPvmpEvaf+hiOFkWvZmqMW5zLaP1YDea5JDmIbCFTd/6zNbsyHxn+yM7h
 3hf+FP25eWENEe641ZfKWQaNqPtWjEKlv2L8ktdg0VOOHv1DO9EBjOEqF0nMS4NwbPn3
 eNOW3WOkVqsiqiU7VfwRFhtfU/7AyhYVXHKeMivBIpKwRR1uzweWUS3pnsmh+4s3iqma
 hzi2CnPuUqpPOGa48Pmz3gzGLpm1pXIYtJNzWtnF4FeNCCkDpakv/YhMZb8mHKMqnKiC
 dSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719586667; x=1720191467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p/6/mO9+cDFjd2Lwn6Pdfpyts2msKL/kmbIlYJPWFCo=;
 b=FA92Ct4Ub4n8sG0iWHgKIgqtbWGxs0HInf6AT8TYRhoRblLEFIx28g+1UltF1N4QdG
 cIQmmrvKm1bL/R8Bt9np6vzwgrPQrVxb460WyzPU2UeszHDSvLhbPhuXMzHD8zz3hFcW
 WtUx869oA9JEhdy2JlxoONHBrxoPBHyNbdf2tER4fL1mkYXpJGt5cKGmiLOJ+V3cTbMC
 ppH2zLgH5Hjj4T/dFwWzcq3/9m4sTomFRHJaLXfYbAKDVyuRzQjU4GNuJ14e8MVSkx62
 W0oP9RnSkIgTIPhHNN2zcb+/a41FflZYE2u0se6boMfJUfGktdZFHWcw5PaljfX47Aut
 eMYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF3ZO6Xllt4nAGx6gCeBUqfFU8fbrmT07HLpMA4Ty/masHpaGJJR6G/CHiF9ZiWkwW2y/wLOG5v1/8BjGVqHaNAkHgcKY=
X-Gm-Message-State: AOJu0YyD/zoTI86V92H8bJ58rTf3g3eeFPM2mm5+wVZ3kN1UQPioe1a7
 XoObf1Eos9kyn8tP9zAadsZZNqyENbRZSi1Bo3c3DmUvC6UDG0JcTLtPBN+zIX8=
X-Google-Smtp-Source: AGHT+IFociIw2wT0pXKoNkzPq88RxAj0unywxRFOLNRXbTlRt7b77hzQ2AxwiSooGOogbajBOHzbfw==
X-Received: by 2002:a05:6a20:2d98:b0:1be:c2df:3ecf with SMTP id
 adf61e73a8af0-1bec2df4073mr7115941637.48.1719586666880; 
 Fri, 28 Jun 2024 07:57:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce17c54sm1729115a91.12.2024.06.28.07.57.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 07:57:46 -0700 (PDT)
Message-ID: <96c33d5a-aa19-4402-b5ad-d195c5139398@linaro.org>
Date: Fri, 28 Jun 2024 07:57:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/arm: Correct comments about M-profile FPSCR
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 6/28/24 07:23, Peter Maydell wrote:
> The M-profile FPSCR LTPSIZE is bits [18:16]; this is the same
> field as A-profile FPSCR Len, not Stride. Correct the comment
> in vfp_get_fpscr().
> 
> We also implemented M-profile FPSCR.QC, but forgot to delete
> a TODO comment from vfp_set_fpscr(); remove it now.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

