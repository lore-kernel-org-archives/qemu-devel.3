Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52B0CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umuBY-00069v-L2; Fri, 15 Aug 2025 09:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuBW-00069V-6w
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:09:30 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuBT-0002of-OA
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:09:29 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e933af9f8b5so108739276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755263366; x=1755868166; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eNnnnAKQC3kbe0z20XYAbU8h7BreX6jnZJOpX4WVIi0=;
 b=dBgwdTy82x9WDNYkFkoKOhXKeb4/9EJWaTSLBwnbQpSHstw4mQTzC2R0ScPaPuVjpX
 ree7IaBX3gOGtv/WmxmoG5nJ+MgHjqI7L3PPppHKDXonB2A3WgHrtvugubmv2tcru4H4
 ixX7+1BZNRlu9o81CdZEnFKm9dtTRkbqedHTMEWQz2oGFd9PgfywMcmIb0qTc1nY7m6L
 dWneQjPE6dmUgwObZqzLUKqLpLuBH6U7OEz7wW1EA/285ZQeSr4/FovBWEF5ab3WG8lN
 v4J6WYInMSiMGyfahEtZkRDD5cfWtr3NFKIXeA5vqrGSUgfUkQDVNRaigLlgJ6sOOYuQ
 J8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755263366; x=1755868166;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eNnnnAKQC3kbe0z20XYAbU8h7BreX6jnZJOpX4WVIi0=;
 b=D2uuzN19cJZNgMYD2CJwd38juUAEpoJ8vyFOSGV2ZweesSsuBhIXgzInXuRSuc6qY9
 JRktfgZOL4q6sYG+Iv5Z7MrW45ejJ1VFrwlyX0Wyzgz8smc0KVohSyFBi3icGEdVL0CD
 R9lDwkjxFX2eeIlwR08WSxV99vHSoNjOj/cAqQkIKB7xzVLg/sR26cedUzJvjciqem67
 x7e+bRw468wIrn2sUOwpinwpwfHo5FnoKcG5s5YLfslQ9j3ZoCQtc8Jy00oGZUD+fbOw
 +sg18bPGdRP7BbCmW4wdZKQjKFYl9PCxeZu6VmXA9dr8xPD9CHtcTuIVcQAVvKpTRvpZ
 G+1Q==
X-Gm-Message-State: AOJu0Yzdm2+6rlRqq6+XRgXVPyvm9BpbhiQo2AoE4ErvMVPkC7XK/OQ5
 jCAjcCPET9AxoqWy3CQ5Pe+96gsH/NKy8qxiooo4pH8FIEmpDCP5HD2jsKYIUbQ4PrgbG+kYVBn
 nM6gWUENik44T9GhJf/cLp43Ted+QXVWpPyRv7dnPKg==
X-Gm-Gg: ASbGncvKAunKAM+cqnjPfNY6kyCwRnx4HQQASkYZLwyaYAn1/nMiiSACxne25EctNUS
 JHil41WUZbWqAjcOvRNZ2l042jKR2omDvW84h5O0yrsosLVnJX0PzDYXfPbg5IItbnf58efciTo
 x2ngo+0caGTuK6I8d+8pwKbbZeZMFbA7/b1nsdpmMhzJaCNcbhJ6090OEtrF/50q1gTj65tRXlo
 /aC+3et
X-Google-Smtp-Source: AGHT+IFcHyJy/F9bQKIEMST3bfgy2Ezn9plUC+TFKkh9vPSFE6OrJ6Z0C3p7rSGRXepIDgu+VrCV0BAW4hWaCCnPsqs=
X-Received: by 2002:a05:6902:102d:b0:e91:d090:8250 with SMTP id
 3f1490d57ef6-e93323d602amr2642509276.7.1755263366212; Fri, 15 Aug 2025
 06:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-5-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 14:09:13 +0100
X-Gm-Features: Ac12FXx43hKic7iXid1o2BczbfgDd5c0e5gvEQa8e7enoBdeGX0BzUwXZhg4am4
Message-ID: <CAFEAcA_qMsMonkx0Kwkuk+S8p7vcSQo2AeWGKB4zKtUMTP8Qew@mail.gmail.com>
Subject: Re: [PATCH 04/11] target/arm: Split out gen_wrap2_i32 helper
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Sun, 3 Aug 2025 at 02:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Wrapper to extract the low 32 bits, perform an operation,
> and zero-extend back to 64 bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index bb92bdc296..64a845d5fb 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -8231,13 +8231,18 @@ static bool gen_rr(DisasContext *s, int rd, int rn, ArithOneOp fn)
>      return true;
>  }
>

A brief comment here would help:

  /*
   * Perform 32-bit operation fn on the low half of n;
   * the high half of the output is zeroed.
   */
> +static void gen_wrap2_i32(TCGv_i64 d, TCGv_i64 n, NeonGenOneOpFn fn)
> +{
> +    TCGv_i32 t = tcg_temp_new_i32();
> +
> +    tcg_gen_extrl_i64_i32(t, n);
> +    fn(t, t);
> +    tcg_gen_extu_i32_i64(d, t);
> +}
> +

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

