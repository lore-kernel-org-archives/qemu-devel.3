Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C7FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW2XO-00020j-Gd; Mon, 22 Jul 2024 19:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sW2XM-0001uz-IA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:33:48 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sW2XK-00087o-Ak
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:33:48 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5846f799dso573399eaf.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721691225; x=1722296025;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hT7MlqZ5AaRuqDebjgpCuaxPw7ec43i1jGDC4q7j0rU=;
 b=WCykGJitauQC8AaXStGVML2b7YR2bqwcWu1Lak2L7mDEqXkavw5QuewRT93S20CoQr
 3xM7tUsFpsMpctEM/snL47uQ+2cIDL/6LgBpbI9HXcWgaNoJ5AYbArhRdqzi7JMhHkTM
 IllrHICOsmdAgUmAa7QBz+pHcJFBlJz4XsqJpsL1yeBdY2ycqYimk7n/mKvcMbGrlCbW
 TonfgaK0+C9fyNB4pNim8Wt7nxqf/juzvCeDVItkhrUXxXH7tl5t6kfTLQMgzcHrCgBe
 oo/Kp+i11hNKZUGx6sT3hbL9SA4RPFsNnylH2w8bKxNhe3yCQ8Y4YslV2x0gIDRm/4MG
 8Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721691225; x=1722296025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hT7MlqZ5AaRuqDebjgpCuaxPw7ec43i1jGDC4q7j0rU=;
 b=geAspXHjd+jr1/Q/Db08krtQq98lCasXUirzPn62AhV7BtLlyL36UPJ/q3fxA6ZpFD
 ujVBpW4auS/xQ8im/xHaeeqwe7d8uEAPiTIoFqY6dTTnJyTZTkaQRgqAVFeNGqbBTFtC
 Vg0GIrNNwJxgRdEGCki1nflGDvcdqP7ym7iMq2fhzajuN+BJsDa13q8yfz7NI+yECs0n
 IrXNbYZ/RAzR75hTMJVQH0iJZgDnsSK+hgYCp87OXDnCl6UYiqasrf0xCyXxI+PB5VNm
 12BgYxZxJ5r6tnFof8r5AUwqh5bHJ2C5242lAT1DNK5YDU77F8v3K9+YyCpsQhqH4eVY
 OItw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsV0IT34Tt+omwYtK/OOnF+XSCGD5U2pZ3qo1X+oSOEBUyZbslLJZTSeGZDGH9/1Soo2lGLZUUMT9G9HK8JZAMStF+D+0=
X-Gm-Message-State: AOJu0Yzp/0XrQ/RZX4DAYeYKSs7KHrThJE+uuFNPsV+A5yIw1d93wQ55
 C/iX7hWx895FxtCTXvzEHoeGe3pUdAONpIZ252neL/oNcxWjnXxVZ5Kx7hPt3c7oWj1wOW0TyHN
 KNS+CWydWqTbNrdHM927fbfv3WwParBu3xI2f+Q==
X-Google-Smtp-Source: AGHT+IEoJjAj43igifRS0yDqQIg1j4fdre39Uy6fAtNBWDJJheMpxiyO/oWQwqFNVCBhbVZBxegkIp77EHuloOP3hZM=
X-Received: by 2002:a05:6870:4723:b0:250:7dba:9501 with SMTP id
 586e51a60fabf-2612169af82mr8731511fac.41.1721691224928; Mon, 22 Jul 2024
 16:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-27-alistair.francis@wdc.com>
 <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
In-Reply-To: <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 22 Jul 2024 16:33:33 -0700
Message-ID: <CAHBxVyHZ1_zgg-V2aKMcYsZjWHwcfndt-rbTa0h8mp_Ufe7hjw@mail.gmail.com>
Subject: Re: [PULL 26/30] target/riscv: Do not setup pmu timer if OF is
 disabled
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=atishp@rivosinc.com; helo=mail-oo1-xc31.google.com
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

On Sat, Jul 20, 2024 at 8:19=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 18 Jul 2024 at 03:15, Alistair Francis <alistair23@gmail.com> wro=
te:
> >
> > From: Atish Patra <atishp@rivosinc.com>
> >
> > The timer is setup function is invoked in both hpmcounter
> > write and mcountinhibit write path. If the OF bit set, the
> > LCOFI interrupt is disabled. There is no benefitting in
> > setting up the qemu timer until LCOFI is cleared to indicate
> > that interrupts can be fired again.
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Message-ID: <20240711-smcntrpmf_v7-v8-12-b7c38ae7b263@rivosinc.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/pmu.c | 56 ++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 44 insertions(+), 12 deletions(-)
> >
> > diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> > index a4729f6c53..3cc0b3648c 100644
> > --- a/target/riscv/pmu.c
> > +++ b/target/riscv/pmu.c
> > @@ -416,14 +416,49 @@ int riscv_pmu_update_event_map(CPURISCVState *env=
, uint64_t value,
> >      return 0;
> >  }
>
> Hi; I was looking at an issue Coverity flagged up with this code (CID
> 1558461, 1558463):
>
> > +static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_id=
x)
> > +{
> > +    target_ulong mhpmevent_val;
> > +    uint64_t of_bit_mask;
> > +
> > +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > +        mhpmevent_val =3D env->mhpmeventh_val[ctr_idx];
> > +        of_bit_mask =3D MHPMEVENTH_BIT_OF;
> > +     } else {
> > +        mhpmevent_val =3D env->mhpmevent_val[ctr_idx];
> > +        of_bit_mask =3D MHPMEVENT_BIT_OF;
>
> MHPMEVENT_BIT_OF is defined as BIT_ULL(63)...
>
> > +    }
> > +
> > +    return get_field(mhpmevent_val, of_bit_mask);
>
> ...but we pass it to get_field(), whose definition is:
>
> #define get_field(reg, mask) (((reg) & \
>                  (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
>
> Notice that part of this expression is "(mask) << 1". So Coverity complai=
ns
> that we took a constant value and shifted it right off the top.
>
> I think this is probably a false positive, but why is target/riscv
> using its own ad-hoc macros for extracting bitfields? We have
> a standard set of extract/deposit macros in bitops.h, and not

Thanks for pointing those out. I checked the get_field usage from the
beginning of riscv support 6 years back.
There are tons of users of get_field in a bunch of riscv sources. I
guess it was just added once and everybody kept using it
without switching to generic functions.

@Alistair Francis : Are there any other reasons ?

If not, I can take a stab at fixing those if nobody is looking at them alre=
ady.

> using them makes the riscv code harder to read for people who
> are used to the rest of the codebase (e.g. to figure out if this
> Coverity issue is a false positive I would need to look at these
> macros to figure out what exactly they're doing).
>
> thanks
> -- PMM

