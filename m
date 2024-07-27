Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D59C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 01:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXWLt-0004NX-4q; Fri, 26 Jul 2024 21:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sXWLr-0004KN-AM
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 21:36:03 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sXWLp-0008T8-GT
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 21:36:03 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f008aa351so2710158e87.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 18:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722044159; x=1722648959;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKIaXeGRSYuTdh4lDQvDGBsb/YVfbCXRarwsI6kRJYM=;
 b=B5nW+phlotUEl7IOoPliZ+Fff4imSg6wsQdWV+Bo2JvFOKt4Dsmu+Af1gdwe1TFQfq
 SbPQUskUZZLsRqHPhvjdg+mEtzzKJSXZzMF4MJHfi6qEwBAvGdKLPVsNvP2z3xTvKqVr
 5WQb25JCTXSqfH1xTKQF0QqiABzHHn1riWKKglUEd6xETy44A2K8IjoN19GvA/utJyjc
 1ZuUWzZr3ubIMOxKjEorMDpiyA7fKRarWM3VKSORW3hBPqtCpA6IYCTMO5A6RUqLZ83t
 0RwcRfvg0BUw92mlSindydA+rR+b8vl5mIeb0Q4FW3UPwOf0qvw0y0pIj/tzsv7cO4C5
 CvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722044159; x=1722648959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKIaXeGRSYuTdh4lDQvDGBsb/YVfbCXRarwsI6kRJYM=;
 b=Gqv31gV+HQqvjTv96UeCzX67vQ3t6Xu/efOXn2vezjzIliKjKgD7iVob+VHa6yo1iv
 M31CFnabDAxOQWNJKkC/NSDKjp2WvNY9vNmVvjK4DWDB6vmHG3nAt5vnoWSQduMqR0Ox
 Br9yzaa5Z25S2SIVT2NVKUZWGK9Pd5Qr2WEE5Va31U3S55ePj1ByMmagiJdUslYw33qj
 TSZ0Tuu1rEtfrghd85/bn4L/7BGXyU1OVOjgg2J8Inx3KG6UgOp7diM10oZ/gGzBvSt7
 IDS+aKfsVCaR9ZA+ZBjrCO6gCdU0DsV6DWL0Jyy56kbnW5K9VR6TDwecKxRRk5nbCo7L
 ud4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNu+D6eIbCww4+BlryJhFqfPTlZrftcQ7qSZPueBJrrEaE+k2Izrhu41Oxo+jyiMUfp9uU1qNeqoy3aq35QzX7D8E1WrI=
X-Gm-Message-State: AOJu0YyWuJTSYLSyRX49CuQmJzik1xkzuICJVUEDu7OxFiqaTYrhqd7j
 7njV9nt3/3MGJYmEvz9Gs/6R568yHU/2PuAaKBXKPmHs/kXwj3Rd/zFkij+JPZKEhaDdDcL6T8c
 Q4bg299xIJvYfHbkKCUUxDaT3SwDFig5AfiH7Zg==
X-Google-Smtp-Source: AGHT+IHlyd4Uaw0gSNyDHZu9jj3oGS7+MM6RfHHEloXNd4rX+FdYgqbDrqXT/TQwOicsqZrBFunhKu/j3fxsl6g9mOk=
X-Received: by 2002:a05:6512:ac8:b0:52d:8f80:6444 with SMTP id
 2adb3069b0e04-5309b27dd53mr956083e87.32.1722044159253; Fri, 26 Jul 2024
 18:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
 <CAKmqyKPhCzrYxwpBF+NQi-5KgcKkhWeVNX6nwwx3ZjeE9rWEAg@mail.gmail.com>
In-Reply-To: <CAKmqyKPhCzrYxwpBF+NQi-5KgcKkhWeVNX6nwwx3ZjeE9rWEAg@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 26 Jul 2024 18:35:48 -0700
Message-ID: <CAHBxVyHBtnhFnFYN0=_5PoKvc7DadJABH71s+wCZzPiYAmPM_g@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add asserts for out-of-bound access
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 25, 2024 at 10:12=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com> wrote:
>
> On Wed, Jul 24, 2024 at 6:33=E2=80=AFPM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > Coverity complained about the possible out-of-bounds access with
> > counter_virt/counter_virt_prev because these two arrays are
> > accessed with privilege mode. However, these two arrays are accessed
> > only when virt is enabled. Thus, the privilege mode can't be M mode.
> >
> > Add the asserts anyways to detect any wrong usage of these arrays
> > in the future.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
>
> Fixes: Coverity CID 1558459
> Fixes: Coverity CID 1558462
>

I think one of the Coverity issues was about the get_field issue in
the other thread?
This doesn't necessarily fix the coverity issue also as the issue
reported is a false positive.
But I don't mind citing the coverity issues as it is reported by that.

Is there a link to both coverity issues to know which issue describes
the out-of-bound access one ?

> > ---
> > The lore discussion can be found here
> > https://lore.kernel.org/all/CAHBxVyGQHBobpf71o4Qp51iQGXKBh0Ajup=3De_a95=
xdLF=3D=3DV_WQ@mail.gmail.com/
> > ---
> >  target/riscv/pmu.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> > index 3cc0b3648cad..e05ab067d2f2 100644
> > --- a/target/riscv/pmu.c
> > +++ b/target/riscv/pmu.c
> > @@ -204,6 +204,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVSt=
ate *env,
> >      }
> >
> >      if (env->virt_enabled) {
> > +        g_assert(env->priv <=3D PRV_S);
>
> Don't we need this assert for !env->virt_enabled as well?
>
> Alistair

