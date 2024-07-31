Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0B5C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8V0-0001dR-M7; Wed, 31 Jul 2024 08:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ8Uw-0001c8-2N
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:32:06 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ8Ut-00044x-At
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:32:05 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5afa207b8bfso5743039a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722429121; x=1723033921; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PsOY+H9IgTzBmgl/ajqI0HCJu3uo8YUxMvM0GB+ieW8=;
 b=K/vCNpJiWQ9I013fevSpNP8KyADV6bPoHa45OTnrgkHS2TauvpgMxKgaJEvHPJBqL3
 au268BQX/drKuRNLxoqjFq8/k/mlvlPUKjnfh+0+J7qKjCI0Ci/azWqgnXpeTCGmIJjT
 RA5hC2BO3oDb/5iGa1zXwOJgTfvNqRKcFTeK6L+1Z3c4VxsxRPlJgNd0A8HZSF5ifQKN
 S1Jjd/Yh3WtJw5LpqLuA42fIYgYx83NMu6KqtlUjouptSi8wPJ9sdTsjxPojk4kuCaMf
 NJuIJx0fKv9CafD065rp8RlM5YyYHiRuLmySpJUprhce73ZKsAutfF/4cvFNmc9WO4Ps
 vM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722429121; x=1723033921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PsOY+H9IgTzBmgl/ajqI0HCJu3uo8YUxMvM0GB+ieW8=;
 b=WZjfjjP4jLKHELv7U2sFDJxnfjRT3sD4d/KKGdWZqxXXcMt2EU+dxem9fQg/+hqJQr
 TGjg0bmMKAi/RjY+YTmOdKiYWfcHzK62dy8ltHUZ9V1FryafE5UyEKn3WNB7Gzu0lG9y
 IyZ7tuUQukB5biHC+4cFrB2KJ/ZkTYtHFfIcB5x9Hf899eWMRslIDVGNsvz9MC4LGCTE
 oo3H+1ayiG1flsku88X8Cuu6v45eT+K7pftDYwhi6UA6btxWEH6wFh3SuYEoiDcqA7/h
 wiza24f6iwa8oI8dsvxAeCc68Iejb145o1HW5iYiWoYoCaLlNjWm8HBkSU5ogBIB/mbG
 XAQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcikLiMIjpoYl0WiPmL2Tptb3YR+6KHQVE4tsqmN51adaWcHozoRLihy2Y+ogTl+ns3C6OmSE1TipKJa4vL6mXLDEzsvM=
X-Gm-Message-State: AOJu0YxDvCZYp8qh38OTM2XkStqlXKWYcS3m77Qhmc94emxemhFqB8bo
 7XRwwsQNzThLP6w4aC6u7w2m2PRQvtHbRwMu7xtmpVtMGV97CGL915XlGLmo6KKl3j3tTIY6fli
 CQm7uV6K3xNZ26zQWGiByvRh27xD9ID55YEON+g==
X-Google-Smtp-Source: AGHT+IEfgq5l0RXUuMyO6pjukBkSdU5i72cyQxm71CEj0cBXNAt7FJ0tB2rogedjneMaRtwKjcWPJgNZB6cDnT8Oz/g=
X-Received: by 2002:a50:9f4f:0:b0:5a1:8984:977e with SMTP id
 4fb4d7f45d1cf-5b0202ef5a3mr7414957a12.8.1722429121203; Wed, 31 Jul 2024
 05:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-4-peter.maydell@linaro.org>
 <a1c3324c-6065-44cf-ac52-f7038f99680d@linaro.org>
In-Reply-To: <a1c3324c-6065-44cf-ac52-f7038f99680d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 13:31:50 +0100
Message-ID: <CAFEAcA99xqywkp7sLoKUxQVNydqUyCSMNbW2B=dOB=HjtWho0Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] target/arm: Pass env pointer through to gvec_bfdot
 helper
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 31 Jul 2024 at 02:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/31/24 02:03, Peter Maydell wrote:
> > Pass the env pointer through to the gvec_bfdot helper,
> > so we can use it to add support for FEAT_EBF16.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/helper.h             |  4 ++--
> >   target/arm/tcg/translate-a64.c  | 27 ++++++++++++++++++++++++-
> >   target/arm/tcg/translate-neon.c | 35 +++++++++++++++++++++++++++++++--
> >   target/arm/tcg/translate-sve.c  | 15 +++++++++++++-
> >   target/arm/tcg/vec_helper.c     |  3 ++-
> >   5 files changed, 77 insertions(+), 7 deletions(-)
> >
> > diff --git a/target/arm/helper.h b/target/arm/helper.h
> > index 970d059dec5..aece9fd4aa7 100644
> > --- a/target/arm/helper.h
> > +++ b/target/arm/helper.h
> > @@ -1027,8 +1027,8 @@ DEF_HELPER_FLAGS_5(gvec_ummla_b, TCG_CALL_NO_RWG,
> >   DEF_HELPER_FLAGS_5(gvec_usmmla_b, TCG_CALL_NO_RWG,
> >                      void, ptr, ptr, ptr, ptr, i32)
> >
> > -DEF_HELPER_FLAGS_5(gvec_bfdot, TCG_CALL_NO_RWG,
> > -                   void, ptr, ptr, ptr, ptr, i32)
> > +DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
> > +                   void, ptr, ptr, ptr, ptr, ptr, i32)
>
> Because env expands to TCGv_ptr in the translation context, I suspect that you can use
> that here.  Worth a try, anyway, so that
>
> > -void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
> > +void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
> > +                        void *envp, uint32_t desc)
>
> this doesn't have to use void *.

I thought I'd tried that, but obviously I didn't hit on the
right combination of types in the prototype/definition.
This does work, so I've changed the patchset to use it.

thanks
-- PMM

