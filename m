Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25945C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 15:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuYt4-0004yy-50; Tue, 18 Mar 2025 11:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuYso-0004pp-14
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 11:29:35 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuYsk-0003WW-J1
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 11:29:33 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e60ad903382so4029068276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742311769; x=1742916569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RzcYsby2Qz/PBO2uDcctGpE87+/O7tdb9aGwayLSNF4=;
 b=a7FuoUcqfd3GF0TDpfbOjEoYwOCnyXQtoDytqgPxCg57YY/dFcSH0vBfDCnqyvg2B5
 WFleic9yV0O4Hil3zBG8Af5DNmqD2Ut/ZO+Po3uRiszl3pjRhMpQAT1W6geVfVlg75vO
 rnp0mWNt0c4dliwKJQBg89XIhgVI9/gCeB/KFN8pGrvaLU9qvsJOs1zS4wYlhCENVnQi
 332q0TGretzTD7o7iO7LcWjYZibYr5pGRohQwZ9zLAhb3oJYK1uUbSAAwcYOM9PCvYe3
 0Pm7hDaou/gQhjYpb/Zig6ojyXPGtD7VbM/8xUkrkDVEseAUBrsSeWdRCQF2Abjk8M9O
 FMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311769; x=1742916569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzcYsby2Qz/PBO2uDcctGpE87+/O7tdb9aGwayLSNF4=;
 b=tDIaRiBAo2JOjhfpU/sFpoibWF1b6RvHbuLhwe/ZvFJjGz51DnS38mIM5lFY15wFyO
 /OlQDtuISinxJjIXlsu2C43fSktLXz76K/Se729Idq+JjsAKAtaQX1VOc+KvzxozmhH4
 oIQrK9HOPGIgx9V4VEsCtMlXW7DVvVfKmehl2r3vVpnONDYhaHRkR3gRnxjiCMby/DqH
 hbOaq3GHK7jyT0L0zdbxXGK6zk/vQEQxZJRXVzq1wtjdFQHm92/zAIVGjDVbhPL65PX5
 CKOk/o7NaRiruZAH4iT7yIKNDvxvRaPd2maVSOi9CULMGsT8fPUD+2U7WY4ay+Byntwe
 IYfQ==
X-Gm-Message-State: AOJu0YylIwzAAJ9WTxHvwysj0sGLDw6WzzfAWm/uZr6fHlcB9xm09KGK
 RmCcABAgQ2z7DhZZBI4nZKucvDqmFoy7MdckkubbUJm+QU7FowgVK8TCB8MWHhRb6y1MiOU50ry
 gt9KWON30aMczTLW2yZAQAffFKhJwyTQzTW2zyQ==
X-Gm-Gg: ASbGncuITLdJ3odYeQBaEsue19NqK5AX6R3USlbMYNzG2vD/TEaRxEAkLB5shSm7OVF
 6NcaDrBMSXgo52TpKFqdHtgKQ8v4+i6RB1DRu9JgDx86WKbrtR9yR+PhIDYMWb8PPfZDBAyiXyx
 O4lyAH2iW8zNQPHqdRLXwe+o1D9Gg=
X-Google-Smtp-Source: AGHT+IHTNkFy87nWbxHPdNAeSZH+GKHMZK8Uzh7OOoC4CDGJ4KFD8Fj6MZKlXHeAS5GWbVK9bwOFCIqBiEuP3dmHU8U=
X-Received: by 2002:a05:6902:2213:b0:e63:efc9:721c with SMTP id
 3f1490d57ef6-e63f650d07amr20959132276.16.1742311769321; Tue, 18 Mar 2025
 08:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250314183224.21822-1-shentey@gmail.com>
 <20250314183224.21822-2-shentey@gmail.com>
 <CAFEAcA8DPonw1+GsBJ079AfeSyO9=3B93P1yj3uLTBzF4uf0Ug@mail.gmail.com>
In-Reply-To: <CAFEAcA8DPonw1+GsBJ079AfeSyO9=3B93P1yj3uLTBzF4uf0Ug@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 15:29:17 +0000
X-Gm-Features: AQ5f1JqgozX_Qt0rSTlFI0R_XebNnbZswWr4Hx8WBcVJh61Tq8gbY4hWYaMypSg
Message-ID: <CAFEAcA-jbRt7x7w-gA5KEBRK8_kHgHRcX4ri+vn-umz2wAsGxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/arm/fsl-imx8mp: Derive struct FslImx8mpState
 from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Tue, 18 Mar 2025 at 15:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 14 Mar 2025 at 18:32, Bernhard Beschow <shentey@gmail.com> wrote:
> >
> > Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon machine
> > reset. It also makes the SoC implementation not user-creatable which can trigger
> > the following crash:
> >
> >   $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
> >   **
> >   ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
> >   (n < tcg_max_ctxs)
> >   Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
> >   assertion failed: (n < tcg_max_ctxs)
> >   Aborted (core dumped)
>
> > diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> > index c3f6da6322..82edf61082 100644
> > --- a/hw/arm/fsl-imx8mp.c
> > +++ b/hw/arm/fsl-imx8mp.c
> > @@ -702,7 +702,7 @@ static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
> >  static const TypeInfo fsl_imx8mp_types[] = {
> >      {
> >          .name = TYPE_FSL_IMX8MP,
> > -        .parent = TYPE_DEVICE,
> > +        .parent = TYPE_SYS_BUS_DEVICE,
> >          .instance_size = sizeof(FslImx8mpState),
> >          .instance_init = fsl_imx8mp_init,
> >          .class_init = fsl_imx8mp_class_init,
> > diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
> > index e1a7892fd7..f17d5db466 100644
> > --- a/hw/arm/imx8mp-evk.c
> > +++ b/hw/arm/imx8mp-evk.c
> > @@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
> >      s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
> >      object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
> >      object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
> > -    qdev_realize(DEVICE(s), NULL, &error_fatal);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
>
> You want sysbus_realize() here, not the _and_unref() variant,
> because the device was created with object_initialize_child().

No, that's wrong, we create it with object_new(). So
the _and_unref() *is* correct, but this is a separate bug fix
from the "should be sysbus, not qdev" bug this patch says
it is fixing. Can it be in a separate patch, please?

thanks
-- PMM

