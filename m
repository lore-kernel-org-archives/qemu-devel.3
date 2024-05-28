Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBz8c-0002eB-Kt; Tue, 28 May 2024 11:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz8a-0002aq-CB
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:53:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz8X-0006bq-0u
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:53:18 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45eso871587a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911595; x=1717516395; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5P3AcQqQ87lTlP+Votciw+vXl90vVn4cW94kR/MwpoU=;
 b=zNyyVpeGk5NusljUtdDr0aYStIYRPXy16T9bY1m/8zj6PTTAmyuPOdeuNDzz+kYolA
 1H840oia8/ixA02+MojC4PuPMOnh2mkZeASgJaA4wM6NFwsL2OXlYG+bi3tu72yiDulr
 6R97VwAjUzC/jXFhR4qV5FN1S3OI/mbXzOm/zJMJUof072JTVTU79ltGyp4aMKH1LF/L
 LzyyUqVfv4B3Y1JlgmmO84tyFG0tI0ZEg6gdwbuoG8EVOBw9JMG/fJdY865DO6Kytq31
 It2oN3IWkHVJapSBUsA/t3d3mttb/aKeI4/W8tnOW3qpe9+EeONvDRg3D7dQitwnsmft
 KvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911595; x=1717516395;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5P3AcQqQ87lTlP+Votciw+vXl90vVn4cW94kR/MwpoU=;
 b=ltBHKCy/Srzvqp6vnkN5w8eIeapixNlVRib0B3q0/rzMn8pbEhEWdjkRvo4HYrgUZ4
 WaF0QfftEIjPP+1B2JPGUcl4VOVWF26loXaD1CrFjdqDdyclyUZN9uebjQ+EQ8LkqNrM
 5TgPBScF6nNXbAtGmzBHqY6f5jRU/tkMLlU5AI9sxK7m1xFlPYkvWvK62MlEmg71t/S0
 gd8/1n//RYAmZTKP5yHOr3CIWG9HEmJNIQVNV56aFmmCnduX8xoQRcOgCpBEtWTHYPmq
 2eCqOxffNaMI5zlvi6ZGr38Y0rJxhvBOql9kQtg3tb8p5zOqGl7Z1kFcqvAfNzpVhSq3
 nqzA==
X-Gm-Message-State: AOJu0Yz2+qCS5rXiR+HZKuOzirPoRM3Ry/nsLXCPCJ4V75pM1U/fzEiG
 AqbGWhO75aH5DccSw9TbQrnV8Cq3CKobbGLJCjb6HRql7MPvc9y6fVYTZwCi6YymmlSCAOXlZ8D
 5FtluLkYztQa+pSVyhwL+1w26HrHttRJOAjiv682ghDASrl6z
X-Google-Smtp-Source: AGHT+IEbltGXqIxrYujX9p6HCnIGYowtYGdTyae40yEU/kTaTJU2PV34d+Noxz2wdyTKCrTW9qdx3xSH6GaYpAYP9Yk=
X-Received: by 2002:a50:d509:0:b0:578:4313:df10 with SMTP id
 4fb4d7f45d1cf-578519a926fmr13871322a12.31.1716911595405; Tue, 28 May 2024
 08:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-47-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:53:03 +0100
Message-ID: <CAFEAcA81fGFByCYbqYvDRWXib99tYGfYcujfBapfrsMxenMJmQ@mail.gmail.com>
Subject: Re: [PATCH v2 46/67] target/arm: Convert SQSHL and UQSHL (register)
 to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 25 May 2024 at 00:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h             |  8 ++++++++
>  target/arm/tcg/translate.h      |  4 ++++
>  target/arm/tcg/neon-dp.decode   | 10 ++-------
>  target/arm/tcg/gengvec.c        | 24 ++++++++++++++++++++++
>  target/arm/tcg/neon_helper.c    | 36 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c  | 17 +++++++---------
>  target/arm/tcg/translate-neon.c |  6 ++----
>  7 files changed, 83 insertions(+), 22 deletions(-)


> +#define NEON_GVEC_VOP2_ENV(name, vtype) \
> +void HELPER(name)(void *vd, void *vn, void *vm, void *venv, uint32_t desc) \
> +{                                                               \
> +    intptr_t i, opr_sz = simd_oprsz(desc);                      \
> +    vtype *d = vd, *n = vn, *m = vm;                            \
> +    CPUARMState *env = venv;                                    \
> +    for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
> +        NEON_FN(d[i], n[i], m[i]);                              \
> +    }                                                           \
> +    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
> +}
> +

Same question about H macros as for patch 44.

-- PMM

