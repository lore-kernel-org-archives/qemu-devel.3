Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A78CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApk1-0008GX-Fb; Mon, 20 Oct 2025 09:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApjv-0008EC-UV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:15:59 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApjs-0007Zd-RY
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:15:55 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-78356c816fdso45701847b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760966150; x=1761570950; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GM7GED3n/P7S3vUkd63Gj+weMu9tTWPMhi++YGczBgY=;
 b=BsosYHDel+SNYWr4jDbPz82uv1OJxvtxoeKoblWXtuzAKsVqmMuar9vcLwjVhFX+Nv
 dQC2x8OWWunshkho6P5HLMb4uMGQqFUd1A7KlT1gjdj9RCtGdyjRx3P1JZ0aUWVj+ByW
 DJ1UUEGjwYgZNRlUbqqJXIwVokdyzSV3y+BlPVvXf66nHxOqH2kHGr1lW1uoUBODiqpZ
 dbHv5NqOpsL7Wh+h9Aj3LxYWglrUUHul/YMTgz++BEqVu+PFjkaLYYk0s7krX2hvUZ+J
 zwSKgtsatc9Yocbm82ifi/q373J0MoJGLaZuI75EnqSAz8xRXB2oUE7TpDu3tQz2iWVa
 RdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760966150; x=1761570950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GM7GED3n/P7S3vUkd63Gj+weMu9tTWPMhi++YGczBgY=;
 b=ejcWzxdbgtrH858hs1AcltEwZndDHDehIfBnCl7+eQXdBkkd3XX/Mck+TyHT/2kF2V
 ClE73RZFSEp6c1/hnSVtksykSi9bOirPLORFFstRRQnPdTY/g9EfdfEoRz+4WvjUFi+i
 38idgADLEc9OTw3WIbLflK7piS0o1D9GxftbWBu+ZKUOpwEK4E3V/57PNxrCrUdhozwm
 fqoPjF/VW2yQLwnmihNW+v/r2oWw5vOoB+E+aOfaOZPVHYsvsmeXDMiFzGUJqhTHl2uX
 0KZDSXLjGQt7lkEwjQfN1cVaEpQHGxlN2tKw80P79LlsOq9LGOJpyOjpHeGpvpJeURax
 OSdQ==
X-Gm-Message-State: AOJu0YzYiLiUArmS5Tghi32U78knO83JurjVB9332MIYhUN4B7V8Ms5w
 yur+KKi3hPd3sMyazS0+24WvOZeR/woEycRwOzfyHD5QIX6xy2Ej2x0+6YMUVlATqiVet2av/LJ
 aA5E543B5cgNHBQGCAdz8V8UbpTD6/7mETK0NkKGV2Q==
X-Gm-Gg: ASbGncv62nH5Eb5lQ9yc4sAfeZYOgb1n60Lok5Kbjli6NdtSr+maK5MChhy3fpoSTBU
 QuLkTLm24kKsVlHZiU7GYjgQxesxs0kcAYY1Etqj64UHSzgDrW0AWwtF0hW6ZJZcHGGeJHRP2xI
 o/L7PCwIMHzFlt5s8Is+Ma4p+8tgFJGDGS32yrA5ZaTc3kePzn4ajYq6Nqe5tIBvky98AjkSenB
 EQGUnbqnS4maCEBxces+aMgycL1xh2Pxja8uO0sENaFbgsFl+b1hXjIH+EZQjKoSScy/cUu
X-Google-Smtp-Source: AGHT+IGqQiKlQUH1YcHNtcy+q6dnltoHufsu67kvKo2QHyspm9KboWQynj7cDz7W9dMoWXjUJxoLV5owlJ45Quc6nus=
X-Received: by 2002:a53:a0cc:0:b0:63c:f5a7:3fe with SMTP id
 956f58d0204a3-63e1620cf7cmr7612294d50.66.1760966149540; Mon, 20 Oct 2025
 06:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-20-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 14:15:38 +0100
X-Gm-Features: AS18NWCPQSvhpfOjpzPziTxHzNawVRvsWmYXH-iSJVthG90ng2awJZH0acOUisU
Message-ID: <CAFEAcA-_Hcg=4+_3uNez3ebFPjNF6etTZHyqy1jDgU1GWPUwGw@mail.gmail.com>
Subject: Re: [PATCH v2 19/37] target/arm: Implement MRRS, MSRR, SYSP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 14 Oct 2025 at 21:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 01b1b3e38b..c76757ed01 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -302,9 +302,15 @@ MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
>  # same instruction as far as QEMU is concerned.
>  # NB: op0 is bits [20:19], but op0=0b00 is other insns, so we have
>  # to hand-decode it.
> -SYS             1101 0101 00 l:1 01 op1:3 crn:4 crm:4 op2:3 rt:5 op0=1
> -SYS             1101 0101 00 l:1 10 op1:3 crn:4 crm:4 op2:3 rt:5 op0=2
> -SYS             1101 0101 00 l:1 11 op1:3 crn:4 crm:4 op2:3 rt:5 op0=3
> +&sys            l op0 op1 op2 crn crm rt
> +SYS             1101 0101 00 l:1 01 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=1
> +SYS             1101 0101 00 l:1 10 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=2
> +SYS             1101 0101 00 l:1 11 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=3
> +
> +# MRRS, MSRR
> +SYS128          1101 0101 01 l:1 10 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=2
> +SYS128          1101 0101 01 l:1 11 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=3
> +SYSP            1101 0101 01 0   01 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=1 l=0

I think we should decode the L bit here, and allow handle_sys() to
deliver the UNDEF, same as we do for 64-bit SYS. I know that
currently there are no 128-bit "system instruction with result"
insns, but there also weren't any 64-bit "system instruction
with result" insns until FEAT_GCS added GCSPOPM and GCSSS2...

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

