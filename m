Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F41D6E2B2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 05:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDcrQ-00011T-4w; Wed, 20 Nov 2024 00:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDcrN-00010a-L6; Wed, 20 Nov 2024 00:02:37 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDcrL-0004zS-Uw; Wed, 20 Nov 2024 00:02:37 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5146695d946so349537e0c.1; 
 Tue, 19 Nov 2024 21:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732078953; x=1732683753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T87UIYq+6zTmn1WnrFMcCyx2vI6o1NHCSD51WBsFOQs=;
 b=Mt8uK7nBTo+LdIfRS1YbfUZlVeQi2n21Sn4WtxwKlKN6zFTxkErDljBSk5P8Nyf8Ye
 IeydC2AWzyR9YZo5qv6POux7F9yzbcv1xRxGmPKO1P46f9J71T6TJbUtdJQFmv6o/maZ
 LANS7mNiW1MPuaVE/cZmk38h/pB+RcRELN7sPRQcj8lcZa07kq1DGDKdMo93iFzjDZiq
 VKJESJIQlhCMkoHoxZn2j+m1A7tn/saW5Z+AKsOJUZPLeiG2QsZ3lY86Lm3D56JEpPiH
 3A9maM6VUMgBaXz0JFADvG112dblovpiGMmXlDlCzIzTyHGyEDl6fvLavkfzvboq/Jc5
 +ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732078953; x=1732683753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T87UIYq+6zTmn1WnrFMcCyx2vI6o1NHCSD51WBsFOQs=;
 b=TSahOznwe3KtzHXc6fMHNvpjAuc+pVPjd7gXhZ2dKukxFXi9aYKNl65SFcWiIDxded
 UPTuVi6RQI1yQNBVnoJq8INy6nAmhbqtB1zjmxFpjLz+IyFG76anw2bW51C5uQrnSFB/
 XhozzyBgledHfdZ1zg6CF9spK6KyIJCdSbXKsfMV3ZiT0dYaTchje7XI9GJ1oNzBHpKl
 K9NXPXVbbLs9rfoWUNo9FTZQOb32MioUTkyz+kcJR57BVJy6NNn4o489koJKu1DXN+m6
 oreA6zRDNkYq1G/XLDTWLLTvJM2PFx1WWFNLKCvpQZ+4LHbXZCVWQxEGeObvduMQtytZ
 yWfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeIfOIZn0IZdmvQsBfXo2EQyvWavo+W/t5dnVUgAMZ4e/00p6w2RVoJAPJNYoFmzLXB7lLRHvSIeDV@nongnu.org
X-Gm-Message-State: AOJu0Yz2NVRHVD25V76GCTOOQwtLH71+jw/GCG56mDkvEqzk9uUR08VY
 CLmcGi7ct5i1/m977up2OH/VWOqtr7R+R0OwUFzpuqVJMgW85RuO69vX0HRtzn07boH3AycTgWv
 ABcTmGUIVojKdn+YjHwRcMEZLQcc=
X-Google-Smtp-Source: AGHT+IHmL4WRRKL0d3kHNemQQDn8Y+CvG4YuVpVcbW5Z7hkZWXbDJWyYENGBm12s9uCK+XLqXLiA5lkWc3NPZyLljOM=
X-Received: by 2002:a05:6122:d87:b0:50d:5095:f01c with SMTP id
 71dfb90a1353d-514cf08da18mr1368454e0c.7.1732078953139; Tue, 19 Nov 2024
 21:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20241114091332.108811-1-cleger@rivosinc.com>
 <20241114091332.108811-2-cleger@rivosinc.com>
 <CAKmqyKO+v0AyvTER4a3JMzEN=b+NSa=BYdULt6=cGmmj46b_Jw@mail.gmail.com>
 <7c88eba0-c010-4aef-ad57-ede292129aff@rivosinc.com>
In-Reply-To: <7c88eba0-c010-4aef-ad57-ede292129aff@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 Nov 2024 15:02:07 +1000
Message-ID: <CAKmqyKMH_YAgomy325ZmpGCNkDMrb5pwJU9GBgNicFAsAc0J6A@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Nov 19, 2024 at 9:27=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 19/11/2024 05:16, Alistair Francis wrote:
> > On Thu, Nov 14, 2024 at 7:14=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> >>
> >> With the current implementation, if we had the current scenario:
> >> - set bit x in menvcfg
> >> - set bit x in henvcfg
> >> - clear bit x in menvcfg
> >> then, the internal variable env->henvcfg would still contain bit x due
> >> to both a wrong menvcfg mask used in write_henvcfg() as well as a
> >> missing update of henvcfg upon menvcfg update.
> >> This can lead to some wrong interpretation of the context. In order to
> >> update henvcfg upon menvcfg writing, call write_henvcfg() after writin=
g
> >> menvcfg and fix the mask computation used in write_henvcfg() that is
> >> used to mesk env->menvcfg value (which could still lead to some stale
> >> bits). The same mechanism is also applied for henvcfgh writing.
> >>
> >> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> >> ---
> >>  target/riscv/csr.c | 40 +++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 35 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> index b84b436151..73ac4d5449 100644
> >> --- a/target/riscv/csr.c
> >> +++ b/target/riscv/csr.c
> >> @@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState=
 *env, int csrno,
> >>      return RISCV_EXCP_NONE;
> >>  }
> >>
> >> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> >> +                                    target_ulong val);
> >>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
> >>                                      target_ulong val)
> >>  {
> >> @@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVStat=
e *env, int csrno,
> >>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> >>      }
> >>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> >> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
> >>
> >>      return RISCV_EXCP_NONE;
> >>  }
> >> @@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVStat=
e *env, int csrno,
> >>      return RISCV_EXCP_NONE;
> >>  }
> >>
> >> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> >> +                                    target_ulong val);
> >>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
> >>                                       target_ulong val)
> >>  {
> >> @@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVSta=
te *env, int csrno,
> >>      uint64_t valh =3D (uint64_t)val << 32;
> >>
> >>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> >> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
> >>
> >>      return RISCV_EXCP_NONE;
> >>  }
> >> @@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVStat=
e *env, int csrno,
> >>                                      target_ulong val)
> >>  {
> >>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | H=
ENVCFG_CBZE;
> >> +    uint64_t henvcfg_mask =3D mask, menvcfg_mask;
> >>      RISCVException ret;
> >>
> >>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> >> @@ -2443,10 +2450,24 @@ static RISCVException write_henvcfg(CPURISCVSt=
ate *env, int csrno,
> >>      }
> >>
> >>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >> -        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENV=
CFG_ADUE);
> >> +        /*
> >> +         * Since henvcfg depends on a menvcfg subset, we want to clea=
r all the
> >> +         * menvcfg supported feature (whatever their state is) before=
 enabling
> >> +         * some new one using the provided value. Not doing so would =
result in
> >> +         * keeping stale menvcfg bits in henvcfg value if a bit was e=
nabled in
> >> +         * menvcfg and then disabled before updating henvcfg for inst=
ance.
> >> +         */
> >> +        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
> >> +        mask |=3D env->menvcfg & menvcfg_mask;
> >> +        henvcfg_mask |=3D menvcfg_mask;
> >>      }
> >>
> >> -    env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> >> +    /*
> >> +     * 'henvcfg_mask' contains all supported bits (both in henvcfg an=
d menvcfg
> >> +     * common bits) and 'mask' contains henvcfg exclusive bits as wel=
l as
> >> +     * menvcfg enabled bits only.
> >> +     */
> >> +    env->henvcfg =3D (env->henvcfg & ~henvcfg_mask) | (val & mask);
> >
> > Won't `env->henvcfg & ~henvcfg_mask` still contain the stale data?
> > `henvcfg_mask` isn't based on the current value of `env->menvcfg`
>
> Hey Alistair,
>
> That's the point, env->henvcfg is cleared with henvcfg_mask which
> contains the set of HENVCFG_* and MENVCFG_* "raw" bits so that the new
> value that is written does not contain any menvcfg stale bits. "mask"
> however is actually masked with menvcfg value to ensure the new bits
> that are going to be written won't contain any incoherent bits.

I'm not sure I follow...

The commit message says:

"""
- set bit x in menvcfg
- set bit x in henvcfg
- clear bit x in menvcfg
"""

Which to me means henvcfg should be cleared when a bit in menvcfg is
cleared. But env->henvcfg is instead cleared based on `henvcfg_mask`
which isn't affected by menvcfg.

So clearing a bit in menvcfg will only not allow a bit to be set, but
not clear any existing bits

Alistair

>
> I guess this still needs a few more explanations if that is not clear
> enough, sorry for that.
>
> Thanks,
>
> Cl=C3=A9ment
> >
> > Alistair

