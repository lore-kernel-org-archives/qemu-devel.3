Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6DEC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSL38-0007kB-Sx; Tue, 23 Jan 2024 12:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSL32-0007ja-Mn
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:58:57 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSL30-0001j2-8V
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:58:56 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-559f92bf7b6so8349058a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706032732; x=1706637532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7lDEw5sJ8RJslvEgx8xhus/fp/Xsse5BBqHV+Ka7yE=;
 b=qEpr8ohDDNuDuRHPVZ+zaglp0802xP2pGBWadVBypNRKof9QDvDfXl+wq2aNaj+Iqh
 WRSb7VQXohdaJsf0us08fDkKshxBNyx2115LgusSd4V/UJSDHSynTnvepVhRYUTb4zZW
 cjx0SnRI7mHGUM6wSHSoe84UudZAfskhWkBFk8aPzU8yH95lavlFpygEEEyES6DhNqnd
 9UG1e3Ah7f5DNzF/jltnTlf13w7+mKFhyZnImNcCkddgFtQgUU4XMw7AIYZ7PNp1engS
 bhLl1oRnRr+B214pZNvFFOhC8wzEoxcKcqOkizw75AiW/wL+GX/eCpZQ1ZHS8U0OoMCs
 i5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706032732; x=1706637532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7lDEw5sJ8RJslvEgx8xhus/fp/Xsse5BBqHV+Ka7yE=;
 b=HnXrQsy3RkSSef/t67IESuV6xiLUkBybIh+Sqp2ZPg1RK00P3L1FCP1ycr4mKNbaWJ
 WRYMVos64fRufVW1dKYihhrDY1JXqZR88AilEOR+nreENYeQE9K1yL9XFGtTOcHoOeF4
 OLTcvc4+HCQdR4BgkaRjWTzpidbJcSXZVnX7pie2Lz/4KGVg/iC92r/ZLrZ/bP9g+wIi
 XQXQZFT6Zo3o4ApQAAMk/vp7h5tTveu5waxF9Ofkn0ztkZ5ifu7UZiPCsr2piUgkQdqX
 NN9UZObShXefwDeBYkRYCc5d9f9vBi9ygFZ/ryN1xnfl7Fa6WdYRWhEM+GB0a1ZZweZV
 RmhA==
X-Gm-Message-State: AOJu0YwdeDY0twMjDOYrbOiebrDWlxC2gPcK2lL2hm96ljK/E2aP2CXd
 m2wiJCHbtajqnn7wwqflrpohBUx0o6G1mSy5EUptln2/UcJ/ass1UBpyQvYZ7XlcfCjscdbG/pE
 2seyuEiHTJKwaEpwcAffWVPXix/EC9UxsEy84a5l8ggaPaG8X
X-Google-Smtp-Source: AGHT+IHX17gvPAsTxI4g6tmIw7bR4Ed8sZRvGJk6b311QVva0NYsXTMwDg1D9luiaVFMl89yx/Fs5fl6oGZxhBMg5ws=
X-Received: by 2002:aa7:c45a:0:b0:55c:708b:2b53 with SMTP id
 n26-20020aa7c45a000000b0055c708b2b53mr1883346edr.28.1706032732640; Tue, 23
 Jan 2024 09:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20240119212945.2440655-1-jan.kloetzke@kernkonzept.com>
In-Reply-To: <20240119212945.2440655-1-jan.kloetzke@kernkonzept.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2024 17:58:41 +0000
Message-ID: <CAFEAcA8f5BBexmtoBHgV6o+KrHbjVvCTZ6VDV54muK_wdvgQTg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix exception syndrome for AArch32 bkpt insn
To: =?UTF-8?B?SmFuIEtsw7Z0emtl?= <jan.kloetzke@kernkonzept.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 19 Jan 2024 at 22:40, Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.co=
m> wrote:
>
> Debug exceptions that target AArch32 Hyp mode are reported differently
> than on AAarch64. Internally, Qemu uses the AArch64 syndromes. Therefore
> such exceptions need to be either converted to a prefetch abort
> (breakpoints, vector catch) or a data abort (watchpoints).
>
> Signed-off-by: Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.com>

Thanks for the patch; yes, this is definitely a bug.

> ---
>  target/arm/helper.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e068d35383..71dd60ad2d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11013,6 +11013,26 @@ static void arm_cpu_do_interrupt_aarch32(CPUStat=
e *cs)
>      }
>
>      if (env->exception.target_el =3D=3D 2) {
> +        /* Debug exceptions are reported differently on AARCH32 */

Capitalization is "AArch32".

> +        switch (syn_get_ec(env->exception.syndrome)) {
> +        case EC_BREAKPOINT:
> +        case EC_BREAKPOINT_SAME_EL:
> +        case EC_AA32_BKPT:
> +        case EC_VECTORCATCH:
> +            env->exception.syndrome =3D syn_insn_abort(arm_current_el(en=
v) =3D=3D 2,
> +                                                     0, 0, 0x22);
> +            break;
> +        case EC_WATCHPOINT:
> +        case EC_WATCHPOINT_SAME_EL:
> +            /*
> +             * ISS is compatible between Watchpoints and Data Aborts. Al=
so
> +             * retain the lowest EC bit as it signals the originating EL=
.
> +             */
> +            env->exception.syndrome &=3D (1U << (ARM_EL_EC_SHIFT + 1)) -=
 1U;

Is this supposed to be clearing out (most of) the EC field?
I'm not sure that's what it's doing. In any case I think we
could write this in a more clearly understandable way using
either some new #defines or functions in syndrome.h or the
deposit64/extract64 functions.

My suggestion is to put in syndrome.h:

#define ARM_EL_EC_LENGTH 6

static inline uint32_t syn_set_ec(uint32_t syn, uint32_t ec)
{
    return deposit32(syn, ARM_EL_EC_SHIFT, ARM_EL_EC_LENGTH, ec);
}

(you'll need to add #include "qemu/bitops.h" too)

and then these cases can be written:

    case EC_WATCHPOINT:
        env->exception.syndrome =3D syn_set_ec(env->exception.syndrome,
                                             EC_DATAABORT);
        break;
    case EC_WATCHPOINT_SAME_EL:
        env->exception.syndrome =3D syn_set_ec(env->exception.syndrome,
                                             EC_DATAABORT_SAME_EL);
        break;

> +            env->exception.syndrome |=3D (EC_DATAABORT << ARM_EL_EC_SHIF=
T)
> +                                       | ARM_EL_ISV;

I don't think we should be setting ISV here -- the EC_WATCHPOINT
syndromes don't have any of the instruction-syndrome info
and "watchpoint" isn't one of the cases where an AArch32
data-abort syndrome should have ISV set.

> +            break;
> +        }
>          arm_cpu_do_interrupt_aarch32_hyp(cs);
>          return;
>      }
> --

thanks
-- PMM

