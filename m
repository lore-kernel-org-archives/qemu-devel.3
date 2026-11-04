Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF9607031A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I6R7P6wB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOitT-0002aP-5w; Wed, 04 Nov 2026 16:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xOitQ-0002Zj-NI
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 16:51:40 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xOitN-0006fo-VF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 16:51:40 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3ab3b29a210so687071fa.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 13:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793829095; cv=none;
 d=google.com; s=arc-20260327;
 b=Mml8Z1R9QNI7ocQ8smTX7/qsKLeqUEry2GcYmMFmGGW4qCQmFSANXszEjuNEpej087
 DtSDJOumtS6HxLVxsv5XmeSZe3F2h/8obzYRKb9MyKD3Vm9cA7L9IVQJNtqKqbAJaECZ
 m/ezcIN4Ff6fEfPlc0oOUI2JDjnQj9KH+Nx9uw9K02ridE6SndB4BAYoxuFgtUmaVU58
 y0xBlYQs3WjAhScs7wNBjlEoDCw1NzmQIjHpS8nGUjpN6RQxf0bUfWqOyVkKRLtNmAvw
 JlM4RGgZQkOKCWfQZ4qpOFlOPJASXTcAV8XylVJkJEp7fm+sdcA6RBwO0V9ZNzC3txAL
 5xbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mIXiVF4Uhb+RzjZrt54REqKywF2+TmowveWyNU8pn50=;
 fh=i7lf7t6r8skpcjnHSKQrzD6JESO6GykblVqpdqfnq+U=;
 b=R+ctp7NHj4eqbMfW4MFMGGCoAzWYNgueWUOsEp7IAaPMxyIGhDp27ABCBrcnp8qLkZ
 OhcarWiVYdkmLHgopj2lJ2JV1pbsjTWDKoL9uHPLrVlERlvjqNXLDDpfHVvkrf0GXpdS
 66UCm7kIZABjJMDCR9SuTH1UvRBos6JN3fjD0DE39cF6dTrot3Rvt+MLzJo3wzfqZOl0
 AcmOF6/Us6RqVvGcThskjoI0XDotkV5LJ8c4xFeuG8WPVzOuA6gfjdnAon7hq68X40dI
 XCatraWI9f/M/3Wi8NHsN1gIIS4bg4MRkwhoTMW8xiM9J17ud1PTrhJ4JdgE2vqzQYgf
 3RTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793829095; x=1794433895; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mIXiVF4Uhb+RzjZrt54REqKywF2+TmowveWyNU8pn50=;
 b=I6R7P6wBEgZcSJbSCtbjOVDfG/kKp7IveZevOmm1WpDPotgyg+NFGfAA7LXevEuU3N
 OVU3CDUEQGtp5+GcxxyQ2xQiHEm7xh4dvacLOMW7z2DruYWJ/7myOgbQq3Z7aWokrlL8
 bK12sF9MCAQDDPXIdgDUKCzh61eKnfO3MaVTOWLEJBx7naUrZSCw0ohfMa7cqEtaTrdq
 RVSNymXvbU2tWzqTFPAjcFBnhjBKGQXGSOAJ04tMR3KSqBrAJ/YFpSp6UB72O/flYHHg
 CqfrfY2G3uATN49fRooQxOyZDeJqxZ63GPcgMVWBod73vBmUbOSWGlIs2taqRqIBCv9k
 7xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793829095; x=1794433895;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mIXiVF4Uhb+RzjZrt54REqKywF2+TmowveWyNU8pn50=;
 b=s9u6S+98CniPTGMWRsJR2pQcQDAwFCQ1roC7AYd0cmR1iEWN3oJg1IwuuAwGdarWuZ
 PUf9hZTQel4lt6BjQaj0nnx5RlRpuFuKJkndYlfbfho75/tuJHRNIEuUl1dFqjKCk3/j
 kQJheagrAdO+jaL33+OCXudJyIBNvfk/TZXqTNyH7+jsfAfNEXm1nkT0D4/3OSQ7nGg0
 7TnBjKHrwgqZLjICRzwd3/ip+RZ2mCQcWvHrcnpRF/SS6dWtj1MTrgnEsdw64G9dcWy1
 pOK6DdJPQQvtcQfmhMfcUJlZDurDnUkj4bpViW61I9QTA2zXPlgiPo7l8JqxUsEdIIQ+
 d5ow==
X-Gm-Message-State: APuU4Z89r4MaXuD7XTzVbvgEzL5dJx6k9P+12Wn7+dNgHRVd1MAulFpS
 0FEGtiHeC56mOFmyaxg/8tnJoNutCCIZYZzmWV9W4+l5VTcCrKOMhP8/X3qtTbr2oqK2X6zWhYd
 ggFnJRd6401QcBeK4Qj1ZsZVqabxZyPM=
X-Gm-Gg: AYBFou0gHRJBmq7vJg2cSp6W7cjWUjT2KJ3LxmwRab/mttYrsuH7fhoAupeEeX2alum
 ErGeq9mPJgbu97xDK90kEKB+YZ53tlGW5iRlAeP2RRNB2VCfCSJ2yRMHQXSsodyq0rXUnELdSo1
 DPCt2AQ2Ol/dxHhkwCum4jtCBQQ3L8F/uslf3TXBuGnhQQIopY5Mdwu6TrAzIeig6nsETs+kiE1
 07jqquvaNlhIaPOpKm9ikqMx/7Qv0I/wfdhxcUPMxmMT8CDwW4HIZ9SBjnJEaOWNwGC4101UVDv
 1DFFAMfLizBwRNbju9bCDGTh9FLLXU0ubwjBhTg0Vhddm7QJDgtBHVOf1Bgto9oalopeBBfgy76
 JK0HUmSjMODytjO5EaSGR749Oo5YiSaVF+wMg4YLBTyVq5D3wcXm1YPYk9eXTLOgs1YZZgSn+s8
 pChPhaaE5ipVvU4gWp3xh5Isukb6ZVe21VMuq+emX5IiTsTu5/GfPS
X-Received: by 2002:a05:651c:19ac:b0:3a3:61ec:43c7 with SMTP id
 38308e7fff4ca-3ace319a73emr1154631fa.24.1793829094569; Wed, 04 Nov 2026
 13:51:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104163854.87398-1-richard.henderson@linaro.org>
In-Reply-To: <20261104163854.87398-1-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 4 Nov 2026 16:51:21 -0500
X-Gm-Features: AclHuK9-WKiLKNmX4en8UtUE_4e-bvomD3EVbMIicxZOUKD7cifyA3njY2C_A6A
Message-ID: <CAEdQ38GBOnPuqbyA4X3oj4xKYHH-c2WdQovav33zdxwr3Rh0LA@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Fix pmu_count_insns test in
 gen_lookup_and_goto_ptr
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com, 
 milesg@linux.ibm.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 11:38=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> CF_NO_GOTO_PTR is in cflags, not flags.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 46d396bde98 ("target/ppc: enable PMU instruction count")
> Reported-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 467b8f3d4e..dfd09b66ff 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2645,7 +2645,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *c=
tx)
>           * tcg_gen_lookup_and_goto_ptr will exit the TB if
>           * CF_NO_GOTO_PTR is set. Count insns now.
>           */
> -        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
> +        if (ctx->base.tb->cflags & CF_NO_GOTO_PTR) {
>              pmu_count_insns(ctx);
>          }

The same check is in ppc_tr_tb_stop() under DISAS_CHAIN, from the
same commit. That one needs fixing too.

But I'm not sure the condition should be there at all. With the
correct flag, we only count when CF_NO_GOTO_PTR is set, which is
just cpu_exec_step_atomic() and gdb single-step. When goto_ptr
actually chains to the next TB, nothing counts the instructions in
this one, so PMC5 still comes up short for every TB that ends in an
indirect branch.

Counting before tcg_gen_lookup_and_goto_ptr() looks safe either way:
if the lookup fails we exit through the epilogue after the count has
been added. gen_goto_tb() already counts unconditionally before
goto_tb. So I think both sites should just be:

        pmu_count_insns(ctx);
        tcg_gen_lookup_and_goto_ptr();

For what it's worth, the old test checked bit 10 of hflags, which is
HFLAGS_SE. With that set, singlestep_flags is nonzero and we take the
gen_debug_exception() path first, so the count was never emitted in
either place.

Am I missing a reason for the conditional?

