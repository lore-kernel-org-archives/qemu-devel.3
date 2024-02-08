Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC0CC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY76w-0003Cj-7U; Thu, 08 Feb 2024 11:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY76t-00034D-Se
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:18:47 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY76p-0002mt-Tq
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:18:45 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so69773a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707409122; x=1708013922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/kgdJeQt4MBqghYPonWPma9RVweCOkevn0geEFBQVuY=;
 b=crTZIcevXUWPv9nTbzfjRzyM4Yo3/lzoM2ras5YGRecxBG8lOlmLQ/oz2al7QEoYcE
 8Wxu/e93rEgv3XBoUhA/RI0pbGkTQg1DhDxCZaPeOmnqFQCbgvIOMX9xBlhzzHfNbTHa
 RuXV5nuIN0L/U7+CTsBw8GGyGoSQRW08Y6lB3BKbmRBBJjekHyiFKGNmJIFqTA4HCsk4
 NL3EZqPgMqFmaQ+uRTkMXOCD3BhK1Hvi8rTuk2GxXhWiYhsh6L3giiJEo36yLzfD9Ick
 yJAJf8qZ2s5WaAWHB/jWPajveNORkwlf+gA8EGh5vUi53rfrTRoYMk0/+W4hMGfnmBd4
 debQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707409122; x=1708013922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/kgdJeQt4MBqghYPonWPma9RVweCOkevn0geEFBQVuY=;
 b=omFZ583dSyp1wDGlcfgsZ3I3KM4OKgsBGNAYhy7uXXFcttNYEoD9YTBaUJ8VlSpNzd
 tzhYrV2GjKTUHTvgxDUpYuBY5sm7vEF3eF6jGCHpml1ojUdV7MkJDviQpxIAicMZFOQz
 Q6YhrpcifO9T9cqjUlzAVNPmiMD6PcWDXLQqdw/UzlComITM46lvIEDPew9vczmmyX8+
 itGqXkmcVTV94gfa2rDaozrI+CprFF415kiJaAWB/d60Ydhoq9VBtM5jgADJbyr7VO/1
 GE0L3DlrN3BCQelVLY63ifeazIWpZQXM7+6QT7Q/d49bOn4noJI/k+2q+Tcp35N2QYh6
 Bb7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvdTI3Fj/vm5xjlkdxY1+8d5LyEtX2fnZYa69hBcnpcqWAtBxJvoai26JLA1SE6TMHW9FYIJ+PNGoL98+MxI/j1VDYrpY=
X-Gm-Message-State: AOJu0Yw90xILKUXTCi2TnoYwIYR05a1bfGihGAwateT87Cfm1fN1ClRc
 8B7X1wg7b/A+f6jHFeTqd6fk5cdFoAsunH0JOGWZ5leQyeW7lJNIoYk+gIGqXcdXw7HVTZreyrq
 j4sJHk8jPCrMtqgDq0RS6W7bZyRMcBGs45IJdIA==
X-Google-Smtp-Source: AGHT+IGfGxNzjHYdq/meM1lPW+Maez4XTqgKAyEx+dBNwG1Gp1HwTGTasoAUE0nBmahlMwYLK/gleZYpaVY4aRgRuXg=
X-Received: by 2002:aa7:c886:0:b0:55f:1728:3b33 with SMTP id
 p6-20020aa7c886000000b0055f17283b33mr5648305eds.40.1707409122298; Thu, 08 Feb
 2024 08:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20240207025210.8837-1-richard.henderson@linaro.org>
 <20240207025210.8837-2-richard.henderson@linaro.org>
 <2ba0228b-fec3-0710-11a1-18825bc1476d@linaro.org>
In-Reply-To: <2ba0228b-fec3-0710-11a1-18825bc1476d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 16:18:31 +0000
Message-ID: <CAFEAcA-8bejJb+Ch=_SWhgNKi_xJkMmvtQs_G=bev9_QH_y_aA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] linux-user/aarch64: Choose SYNC as the preferred
 MTE mode
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, 7 Feb 2024 at 20:04, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
>
> On 2/6/24 11:52 PM, Richard Henderson wrote:
> > The API does not generate an error for setting ASYNC | SYNC; that merely
> > constrains the selection vs the per-cpu default.  For qemu linux-user,
> > choose SYNC as the default.
> >
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   linux-user/aarch64/target_prctl.h | 29 +++++++++++++++++------------
> >   1 file changed, 17 insertions(+), 12 deletions(-)
> >
> > diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
> > index 5067e7d731..aa8e203c15 100644
> > --- a/linux-user/aarch64/target_prctl.h
> > +++ b/linux-user/aarch64/target_prctl.h
> > @@ -173,21 +173,26 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
> >       env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
> >
> >       if (cpu_isar_feature(aa64_mte, cpu)) {
> > -        switch (arg2 & PR_MTE_TCF_MASK) {
> > -        case PR_MTE_TCF_NONE:
> > -        case PR_MTE_TCF_SYNC:
> > -        case PR_MTE_TCF_ASYNC:
> > -            break;
> > -        default:
> > -            return -EINVAL;
> > -        }
> > -
> >           /*
> >            * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> > -         * Note that the syscall values are consistent with hw.
> > +         *
> > +         * The kernel has a per-cpu configuration for the sysadmin,
> > +         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> > +         * which qemu does not implement.
> > +         *
> > +         * Because there is no performance difference between the modes, and
> > +         * because SYNC is most useful for debugging MTE errors, choose SYNC
> > +         * as the preferred mode.  With this preference, and the way the API
> > +         * uses only two bits, there is no way for the program to select
> > +         * ASYMM mode.
> >            */
> > -        env->cp15.sctlr_el[1] =
> > -            deposit64(env->cp15.sctlr_el[1], 38, 2, arg2 >> PR_MTE_TCF_SHIFT);
> > +        unsigned tcf = 0;
> > +        if (arg2 & PR_MTE_TCF_SYNC) {
> > +            tcf = 1;
> > +        } else if (arg2 & PR_MTE_TCF_ASYNC) {
> > +            tcf = 2;
> > +        }
> > +        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
> >
> >           /*
> >            * Write PR_MTE_TAG to GCR_EL1[Exclude].
> >
>
> ok, so no ASYMM in QEMU user-mode, plus if both SYNC and ASYNC flags are
> specified by the user SYNC is selected. Contrary to what happens by default
> on Linux, because of the mte_tcf_preferred value, which is ASYNC, and the
> final value selected is define by:
>
> resolved_mte_tcf = (mte_ctrl & pref) ? pref : mte_ctrl;

Yes; the kernel default mte_tcf_preferred is 'async', but as the comment
notes we do the equivalent of the sysadmin having set mte_tcf_preferred
to 'sync'. (The idea of the tunable is that you can set it to whatever
is a good balance between performance and debugging precision depending
on what your CPU implementation happens to be; for QEMU since there is
no performance gain from 'async' or 'asymm' we might as well act like
the sysadmin set the tunable to 'sync'.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

