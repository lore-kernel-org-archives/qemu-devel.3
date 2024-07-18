Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E05DC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 17:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUUfU-0003iM-QU; Thu, 18 Jul 2024 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUUfS-0003hd-7l
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 13:11:46 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUUfP-00066Q-Q0
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 13:11:45 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ea7bdde68so685254e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721322701; x=1721927501; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/OBOfPbk42kH7Hu611jiPMGjP4hY2WibEGi6Y5Hr08=;
 b=JXCLV2rSFuIhMDs8Y//F6yWcyObRr10GDeov3+9rb4OzYhG3d3ISnq3QL04GjFHveh
 TPlD1pSPuju8Lckutcb0gHzdazmrVCDEqx/BsdDIINh6FGExQ0vTHesqu+b3RKOC7fqT
 Njwv6p2N3pnEubxkjj0Thv98fnsUHrqKzY3BRwXNPWobSxuNXqmmwbY7w0yshJl7ZYWr
 rnvQJQyJP3lJm3DkAu/rOtYs2CgJ3b7uUXGRJ8hKICKDYQ/sF1As8feVvJ4kcWqOWg6L
 tHeK/6+J87WnOOp6Un3aXoPw/3XjvtEBoRGF4O7P6IsU/139aeiW/c1jlrJKP7LSSYce
 N7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721322701; x=1721927501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/OBOfPbk42kH7Hu611jiPMGjP4hY2WibEGi6Y5Hr08=;
 b=mtMe32QHLXFIggj6jyyii9KmRiKPbtBCgVogAnpR5xH19zjt9jAVY5uuB5eRD8mOMJ
 +V9dOAvsaRl4M5rKKZLqOPMp+cO/ExZBS7jG/BrVZpfcFE3fcr+g2J7H7rh6Yo133AMs
 gTEWqNwlK6YtIFB0TcXrgh2HvTG87sgprq1nelDQv/jb4TyPknsLzYGh+17yEIBs1Ow2
 NfucVoBPUOwmMkp1qQkNs/AaEq6ms3kZvYQmpIt8iMdXTgw2m4P4irqpu9LuGRsuqe6m
 Mx5f2qDyd9fKM/77zHciCkiaUukX2n7MCrO8fb+/lDOFauSjsUG49o+4h7W9hE7sWMxX
 QiOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTmBZtOTyUarUg11EvrqnyafKq3Qy6b54oXFtxPk4b6jytHCaLL4/yaxD05ANFzM42fi0a3mWDlg/cAZU4nl73gA8xavk=
X-Gm-Message-State: AOJu0YyJCfKZCrQBY3IvDvKoinaQL4NzNWUd0WP5wVsxKHdYnfuEvTF7
 i2kMwlMvd5TLhRdF3yDtXnw6f/0fGwTfJ4il0CdZw2d8Tr9NTCuMhIX9vJaFGBPqErlP4sC0NjE
 kxa35ZDUkGawN7WGSIFKeN+So0eTd6eXZZGZ5PA==
X-Google-Smtp-Source: AGHT+IGncAufWjxouR3n9kEnq5+BKNUsFJbhBJt4K3RZSwztet0D42CN6swpBvPJ3gl6mypO4b/FBTr4e0J+oZIAF34=
X-Received: by 2002:a05:6512:1281:b0:52c:dd0c:4c57 with SMTP id
 2adb3069b0e04-52ee53f6901mr4029576e87.27.1721322700996; Thu, 18 Jul 2024
 10:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240718090753.59163-1-yaoxt.fnst@fujitsu.com>
 <20240718173614.00006d13@Huawei.com>
In-Reply-To: <20240718173614.00006d13@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 18:11:30 +0100
Message-ID: <CAFEAcA8UOwr6tuvPLZSPn8vzwpEnUrOW-2x184K2O281H7J07Q@mail.gmail.com>
Subject: Re: [PATCH] mem/cxl_type3: Fix overlapping region validation error
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>, fan.ni@samsung.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Thu, 18 Jul 2024 at 17:37, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> On Thu, 18 Jul 2024 05:07:53 -0400
> Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
>
> > When injecting a new poisoned region through qmp_cxl_inject_poison(),
> > the newly injected region should not overlap with existing poisoned
> > regions.
> >
> > The current validation method does not consider the following
> > overlapping region:
> > =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90
> > =E2=94=82a  =E2=94=82  b(a) =E2=94=82a  =E2=94=82
> > =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98
> > (a is a newly added region, b is an existing region, and b is a
> >  subregion of a)
> >
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Looks correct to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> I've queued it on my local branch.
> I need to put together an updated public one.
>
> No huge rush to queue this up though I think as the effects
> are minor.

I think you can probably write this as
   ranges_overlap(start, len, p->start, p->length)
using the utility function in include/qemu/ranges.h, which is
a bit more readable than open-coding the overlap test.

(There's another couple of open-coded overlap tests in
cxl-mailbox-utils.c.)

thanks
-- PMM

