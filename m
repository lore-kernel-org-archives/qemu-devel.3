Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65463D3C53F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 02:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1cgM-0001jg-PJ; Thu, 17 Oct 2024 22:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1cgL-0001jN-0n; Thu, 17 Oct 2024 22:25:37 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1cgJ-0005QF-7Q; Thu, 17 Oct 2024 22:25:36 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4a47dc2ef46so498078137.3; 
 Thu, 17 Oct 2024 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729218333; x=1729823133; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJYQJRNcOdeLTOo+e4YEVwrRsjPitb/Y2wd1ZQxv/5Q=;
 b=GvsbqAGEnhVJ+JeUHnnf9n++QLrgowVa2psJWnhHEkT4jXcdxAUMPAFFgvqdZvAupn
 erhYVM331epLH8LjJzN8qCyrPF4lOArVg+dz9wfdQGQ8MS9tSwPRaxlLi69TTz7/r/F5
 POpVVgSpUxiH5C8klj3PELuCQabL0/RVUkaSvP0ljWb7QH7q4+z70t0c9ioZRq58TY+O
 rNb4bNuvgkqTTetifZX/Pfo5sndLCPbTx8+OdhFBtozfDWynL6CfXBmGHkVVzTrp19a9
 FkU7A/lObdTX+xSkSPozkdnpQqi0wnfjb8VEZOoTEBNbUF5qZeqqWQ1DvZJy9M8zF2ur
 gb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729218333; x=1729823133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJYQJRNcOdeLTOo+e4YEVwrRsjPitb/Y2wd1ZQxv/5Q=;
 b=QTaUMu5TH9iuigyof516KEsjnQFx7rQlw6/OGSTtAIzbSHOEn4SIla1h9Jr3Pjam5I
 1FiaSLR/dVTyewEYuly6/eV4F6wkpqytKfc76b/A59+DHQC2JadqtYW9WypboGaF6lPo
 9xJUM3dGK8r7BJADohTpo2AokjxtaQjtYI4hovqSvr4vs4XqgVqKVdGVSy/YF8iFxhOM
 QfntY5sUDtG9kNXx84qihdEMi2Mr/zj/Y7u0lrL710fSFrORmV+V71WBpxC4Rcsf09zL
 icxsiV6TTw05HbPhsVgFQaiafW16qjLBYG3vm4O2LCVVcJIe6kPKHlTv7Cr9dVC/Zqah
 p/1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAPx92091mkI9PchASk/vjNBa0je6bG59iOY/NL/WXoBTPh8oyIUAB9cUiLyEqRAU7s++/9bbKaUun@nongnu.org
X-Gm-Message-State: AOJu0YxEK9plIulxKnRR4vr2opZJrbfzk8mVQNcOf/LvdMoOe9KbWtql
 jvXPCiPZBiKkp5g4gkkL7wb6DmMzeba3Goy1QygLDErPMbUR3xBPS+9zzSWiX3tt8tSj65M3pZB
 zyt23iyLVim8tUs/cQrBE03LPFB8=
X-Google-Smtp-Source: AGHT+IGPT3DljHbB4p/s3M+6pV0knefIwgBQklU9clnGVMu65AATIyVQRkjj7x7yLDZrCCf7WXfmW0ywmbSxZ6kA6rI=
X-Received: by 2002:a05:6102:3914:b0:4a5:b543:ee64 with SMTP id
 ada2fe7eead31-4a5d6a8c680mr898954137.11.1729218333509; Thu, 17 Oct 2024
 19:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-4-cleger@rivosinc.com>
 <CAKmqyKNYJjudgxA6z4dF5AP31NFn3ZOePMadjiVumja29oti5w@mail.gmail.com>
 <109e3df4-416a-48a3-ae0b-b2a92f11c893@rivosinc.com>
 <CAKmqyKPUrCw8xrTW_g5Sh3JWOkgjrkjCUNO28AXhGfFUfx1Y1A@mail.gmail.com>
 <bd7ed74e-0ed6-4868-a05d-71c0bcaf6278@rivosinc.com>
In-Reply-To: <bd7ed74e-0ed6-4868-a05d-71c0bcaf6278@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 18 Oct 2024 12:25:06 +1000
Message-ID: <CAKmqyKPGKuCQ4-+2YAbqC6GSxvug-tq9UufBAQ0y_pT9skj5pA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] target/riscv: Implement Ssdbltrp exception handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Thu, Oct 17, 2024 at 5:45=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 17/10/2024 06:29, Alistair Francis wrote:
> > On Mon, Oct 14, 2024 at 5:43=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> >>
> >>
> >>
> >> On 11/10/2024 05:22, Alistair Francis wrote:
> >>> On Wed, Sep 25, 2024 at 9:59=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleg=
er@rivosinc.com> wrote:
> >>>>
> >>>> When the Ssdbltrp ISA extension is enabled, if a trap happens in S-m=
ode
> >>>> while SSTATUS.SDT isn't cleared, generate a double trap exception to
> >>>> M-mode.
> >>>>
> >>>> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> >>>> ---
> >>>>  target/riscv/cpu.c        |  2 +-
> >>>>  target/riscv/cpu_bits.h   |  1 +
> >>>>  target/riscv/cpu_helper.c | 47 ++++++++++++++++++++++++++++++++++--=
---
> >>>>  3 files changed, 43 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >>>> index cf06cd741a..65347ccd5a 100644
> >>>> --- a/target/riscv/cpu.c
> >>>> +++ b/target/riscv/cpu.c
> >>>> @@ -284,7 +284,7 @@ static const char * const riscv_excp_names[] =3D=
 {
> >>>>      "load_page_fault",
> >>>>      "reserved",
> >>>>      "store_page_fault",
> >>>> -    "reserved",
> >>>> +    "double_trap",
> >>>>      "reserved",
> >>>>      "reserved",
> >>>>      "reserved",
> >>>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> >>>> index 3a5588d4df..5557a86348 100644
> >>>> --- a/target/riscv/cpu_bits.h
> >>>> +++ b/target/riscv/cpu_bits.h
> >>>> @@ -699,6 +699,7 @@ typedef enum RISCVException {
> >>>>      RISCV_EXCP_INST_PAGE_FAULT =3D 0xc, /* since: priv-1.10.0 */
> >>>>      RISCV_EXCP_LOAD_PAGE_FAULT =3D 0xd, /* since: priv-1.10.0 */
> >>>>      RISCV_EXCP_STORE_PAGE_FAULT =3D 0xf, /* since: priv-1.10.0 */
> >>>> +    RISCV_EXCP_DOUBLE_TRAP =3D 0x10,
> >>>>      RISCV_EXCP_SW_CHECK =3D 0x12, /* since: priv-1.13.0 */
> >>>>      RISCV_EXCP_HW_ERR =3D 0x13, /* since: priv-1.13.0 */
> >>>>      RISCV_EXCP_INST_GUEST_PAGE_FAULT =3D 0x14,
> >>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >>>> index 395d8235ce..69da3c3384 100644
> >>>> --- a/target/riscv/cpu_helper.c
> >>>> +++ b/target/riscv/cpu_helper.c
> >>>> @@ -575,7 +575,9 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVStat=
e *env)
> >>>>          mstatus_mask |=3D MSTATUS_FS;
> >>>>      }
> >>>>      bool current_virt =3D env->virt_enabled;
> >>>> -
> >>>> +    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
> >>>> +        mstatus_mask |=3D MSTATUS_SDT;
> >>>> +    }
> >>>>      g_assert(riscv_has_ext(env, RVH));
> >>>>
> >>>>      if (current_virt) {
> >>>> @@ -1707,6 +1709,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >>>>      CPURISCVState *env =3D &cpu->env;
> >>>>      bool virt =3D env->virt_enabled;
> >>>>      bool write_gva =3D false;
> >>>> +    bool vsmode_exc;
> >>>>      uint64_t s;
> >>>>      int mode;
> >>>>
> >>>> @@ -1721,6 +1724,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >>>>          !(env->mip & (1 << cause));
> >>>>      bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
> >>>>          !(env->mip & (1 << cause));
> >>>> +    bool smode_double_trap =3D false;
> >>>> +    uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
> >>>>      target_ulong tval =3D 0;
> >>>>      target_ulong tinst =3D 0;
> >>>>      target_ulong htval =3D 0;
> >>>> @@ -1837,13 +1842,35 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >>>>                  !async &&
> >>>>                  mode =3D=3D PRV_M;
> >>>>
> >>>> +    vsmode_exc =3D env->virt_enabled && (((hdeleg >> cause) & 1) ||=
 vs_injected);
> >>>> +    /*
> >>>> +     * Check double trap condition only if already in S-mode and ta=
rgeting
> >>>> +     * S-mode
> >>>> +     */
> >>>> +    if (cpu->cfg.ext_ssdbltrp && env->priv =3D=3D PRV_S && mode =3D=
=3D PRV_S) {
> >>>> +        bool dte =3D (env->menvcfg & MENVCFG_DTE) !=3D 0;
> >>>> +        bool sdt =3D (env->mstatus & MSTATUS_SDT) !=3D 0;
> >>>> +        /* In VS or HS */
> >>>> +        if (riscv_has_ext(env, RVH)) {
> >>>> +            if (vsmode_exc) {
> >>>> +                /* VS -> VS */
> >>>> +                /* Stay in VS mode, use henvcfg instead of menvcfg*=
/
> >>>> +                dte =3D (env->henvcfg & HENVCFG_DTE) !=3D 0;
> >>>> +            } else if (env->virt_enabled) {
> >>>> +                /* VS -> HS */
> >>>> +                dte =3D false;
> >>>
> >>> I don't follow why this is false
> >>
> >> Hi Alistair,
> >>
> >> It's indeed probably lacking some comments here. The rationale is that
> >> if you are trapping from VS to HS, then at some point, you returned to
> >> VS using a sret/mret and thus cleared DTE, so rather than checking the
>
> s/DTE/SDT
>
> >
> > Why not just clear it at sret/mret? Instead of having this assumption
>
> It has been cleared but since registers were swapped to enter virt mode,
> hypervisor SDT value is stored in mstatus_hs rather than mstatus. So I
> could have wrote it this way:
>
> +            } else if (env->virt_enabled) {
> +                /* VS -> HS */
> +                sdt =3D (env->mstatus_hs & MSTATUS_SDT);
>
> Since this is always 0 better assume it is 0 (but should be sdt =3D 0
> instead of dte =3D 0). But if you prefer using mstatus_hs for clarity, I
> can use that of course.

We should use the register directly. That way if it is accidently not
cleared it's easier to catch and it makes the code easier to read

Alistair

>
> Cl=C3=A9ment
>
> >
> > Alistair
> >
> >> value of mstatus_hs, just assume it is false.
> >>
> >> Thanks,
> >>
> >> Cl=C3=A9ment
> >>
> >>>
> >>> Alistair
> >>
>

