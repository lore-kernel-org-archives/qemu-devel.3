Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027FFC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 12:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwFi-00061N-Gy; Tue, 28 May 2024 08:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBwFa-000617-Iz
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:48:22 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBwFW-0000Ci-OL
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:48:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57869599ed5so940026a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716900496; x=1717505296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zcol2jmXKa9f1VEV+cxuSqXh63Fmp1Jcz/riDhFlBa8=;
 b=s4OcXNaXYLr5N7I+R5GpU09ynysdrEhNGdLZibQ2bL0G1jWYg1wzyldgvE0V76qLaI
 Ek5jSL6DQIPnS+rmprQHy2GWIp9tDE3DfPju8iKWNBePB4M6A65hQ2zOwf/I2yDjyjXT
 QVEp76b/YUypi1csYT3Y1AxTzIOLmVfa9c3oSGerZ3r9bJ+8Zzc/5ZN2IiTtBa9STYKA
 W0AB6XcVf4u8wrz5bWJMUZz1cy9D5rUrJel+WSLYtE2wTeZg08rPtjmExVA+GOuwJlO3
 2KkZQ0pupugcbrwWvenAaebsL5uS1D2BAgGdJlgBQ/KLhSP6frugfGVgN1qOlqCXtzGy
 cOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716900496; x=1717505296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zcol2jmXKa9f1VEV+cxuSqXh63Fmp1Jcz/riDhFlBa8=;
 b=sKdtmXLRu399xzHbN9Re9SzG8rYuMcRrSfDOF46j28bC4tYR7rPDRdOZwiZFnGxgcj
 Jiy7d+14CXXE46SEJ+VBUlVN33AcFMwMpFuKFoKu7PUDwc0vU+pFvI/6JceRouwcLA2Q
 7DcjR/HzpFJDsP3ivYUEHpEc6Tw9Zf0Qyt+mU/d4FhMU14HYBzEPC3URp1LYHWrzndet
 J+StncsRSWiBh2/DdmkCYbHfnSaMWNtc1fowWBL+iOfw3xxl3AHYBlG6iMjC7p52YZvd
 NqlZhvlqakaxJZCq1beJrv50NCZUQip7iUTM+uXQHOmJR5SHHQhygyd2IwctOkyUmqM1
 lorw==
X-Gm-Message-State: AOJu0YyijMBykw4vCD0iMoNs7L/sj0t8iudf2qGhDFuUahI6q6ZHGhhd
 tK0ehMeAwavOxWFYMpV7O+LZ28Nn7mfft2G/85wzPIWFhv+MuoBeJX232OLhUtbYvU9X5FDSRxd
 6sgGHldxUBKhv6xrYFT9t0PV4i298BQMQG7gTKg==
X-Google-Smtp-Source: AGHT+IHaozM7SCg0ldQV0oLaVnUtzzwnp9LyaeOXkbfSrmzHEi2KlZSdhw548wnDHPCH+Cyp9HAqaGwy7QQVodqeQ4Y=
X-Received: by 2002:a50:9b0d:0:b0:570:374:fbf5 with SMTP id
 4fb4d7f45d1cf-57851a23abfmr9212037a12.39.1716900496602; Tue, 28 May 2024
 05:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-5-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 13:48:05 +0100
Message-ID: <CAFEAcA-EEaKCGsdURrLqTcJj5p=NuSGyU4YCF5ppRVvQfZ0-kw@mail.gmail.com>
Subject: Re: [PATCH v2 04/67] target/arm: Zero-extend writeback for fp16
 FCVTZS (scalar, integer)
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

On Sat, 25 May 2024 at 00:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fixes RISU mismatch for "fcvtzs h31, h0, #14".
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 4126aaa27e..d97acdbaf9 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -8707,6 +8707,9 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
>              read_vec_element_i32(s, tcg_op, rn, pass, size);
>              fn(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
>              if (is_scalar) {
> +                if (size == MO_16 && !is_u) {
> +                    tcg_gen_ext16u_i32(tcg_op, tcg_op);
> +                }
>                  write_fp_sreg(s, rd, tcg_op);
>              } else {
>                  write_vec_element_i32(s, tcg_op, rd, pass, size);
> --
> 2.34.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

