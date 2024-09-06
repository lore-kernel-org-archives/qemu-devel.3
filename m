Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AD7CE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 03:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smPWZ-0008KP-7M; Thu, 05 Sep 2024 23:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPWY-0008JW-GV; Thu, 05 Sep 2024 23:20:38 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPWW-0008B3-TH; Thu, 05 Sep 2024 23:20:38 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-846c59979efso418101241.3; 
 Thu, 05 Sep 2024 20:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725592835; x=1726197635; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvU0x8fvjSXyCzU6F17kKTphGIL2eCV8KdiHo2GurjY=;
 b=IK0vTjUGkjflvN1pIVA4QQ50G3VRQCcDx93DdupKef4b97wDac1oGAAPKRVr9Si6VT
 IXXqO03YE/WC580kUfyyY+Y+wVgLo8Rru+Un5ZM3ZBYH5HTUmiGBBWM/EONKDVyrVebF
 /FEDyjpuTZT1ZGerNkzKHDqZ4+r+gawj2VhSDWnySWS+xGLEisrzQn9p4aN/VAWv/Ph4
 Ap97Q28/DFTTO8gwbTblvXBYXWXKYvCgxSzN9Llr13w/9HMTh2I7CIySHUUlAKuo7jB9
 NeAkfP4n4DByATl1uE35ll4PUsRhFErbBF6BS34yTMsl/QkOkkoQGD28Nn7KTv9mqhKC
 puHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725592835; x=1726197635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvU0x8fvjSXyCzU6F17kKTphGIL2eCV8KdiHo2GurjY=;
 b=Ungr8gCo93HM9J94gHv8tEyDvv9ztY/mUU6FCa+rDfvscuWhM2F7DgOl8jtTUdPwjX
 Rfvu4iokb0Vt8gF0ni7c8Vw3/qC5GBFWRKgxhpE0i42vN5rLWtoQtTz44aS5UcLhUFFN
 z36nxEvg1JAsAhWkso1kGdymS0uf2L4+HDUTy7oo7Boq/s1n/3+ZUxOplVuiPvP0DPG5
 qoyCySix+MIpaMrnMvutwCmhAoNNGRmqspx0k73NkR1jLob6FQ2BEeJ4JVudPYS1SP6V
 uj226728NbOw7O05e1G1xDXb3cYayI6Dq25XIQu2L/RJJhqiE8Pn3e+goc3PGtD6sdhZ
 Qcbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuBitYDcU8klOUatZxCVBujVWpKE2/olyiykWQ3JXZ/aKNAW3O934tZrDX+3mfPrKZbCipNRown8/8@nongnu.org
X-Gm-Message-State: AOJu0Yz6NlbWZS/RBoDtFMFMlc3h/NBoKc0ubbHMBaod5CaVqGE31kus
 73oH/bW8ydafUvpUy9Aev/j7nxE/lsJsznplZ9ycHdV3KIK4WC4xNdjkwatpBOAQJuDos9MgB61
 t0UHTFoR2pvxYgJa/Aj6FrWqGVW4=
X-Google-Smtp-Source: AGHT+IHM85rHpmK+vPpOx48eLAY5MeAqfyI+CXmY2CvLGBiM4xeqrx/X377XJ9/XFeIHrjbEm7Y6yChfIDc76MUENjs=
X-Received: by 2002:a05:6102:1622:b0:49b:d5f8:236 with SMTP id
 ada2fe7eead31-49bde31cc6emr1248132137.24.1725592834914; Thu, 05 Sep 2024
 20:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
 <20240819160742.27586-8-Ian.Brockbank@cirrus.com>
 <CAKmqyKN+emnjxdCdX9_kBEqZoo4OtdJeSearxEB3o-Ak374tQw@mail.gmail.com>
In-Reply-To: <CAKmqyKN+emnjxdCdX9_kBEqZoo4OtdJeSearxEB3o-Ak374tQw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 13:20:09 +1000
Message-ID: <CAKmqyKPxm+LFxqTUP1AfqDsNjEs66JfhQi2WBNsABOq-+x=d3A@mail.gmail.com>
Subject: Re: [PATCH 04/11 v2] target/riscv: Update CSR xie in CLIC mode
To: Ian Brockbank <Ian.Brockbank@cirrus.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Sep 6, 2024 at 12:58=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Tue, Aug 20, 2024 at 2:15=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirr=
us.com> wrote:
> >
> > From: Ian Brockbank <ian.brockbank@cirrus.com>
> >
> > The xie CSR appears hardwired to zero in CLIC mode, replaced by separat=
e
> > memory-mapped interrupt enables (clicintie[i]). Writes to xie will be
> > ignored and will not trap (i.e., no access faults).
> >
> > Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> > Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
> > ---
> >  target/riscv/csr.c | 34 ++++++++++++++++++++++------------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 9c824c0d8f..a5978e0929 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -30,6 +30,10 @@
> >  #include "qemu/guest-random.h"
> >  #include "qapi/error.h"
> >
> > +#if !defined(CONFIG_USER_ONLY)
> > +#include "hw/intc/riscv_clic.h"
> > +#endif
>
> This doesn't seem like the way to go

Urgh! Ok, it's trickier than that.

I think ideally we don't want to pull in a bunch of CLIC stuff, just
the bare minimum.

It's probably better to implement the CLIC functions for CSR access in
the target/riscv directory instead of in hw/intc

Also, to make it easier to review it would be great to add the
functions when they are used. Then patch 3 will be smaller and the
other patches easier to see what is being added

Alistair

