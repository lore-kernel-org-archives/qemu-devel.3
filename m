Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BC2C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsO2-0003E1-6j; Wed, 05 Jun 2024 11:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sEsO0-0003D1-Hx
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:17:12 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sEsNw-0004Q1-Ik
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:17:12 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dfa727cde2dso5641304276.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717600626; x=1718205426;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jlb7ESxOsRm5KDgEYeQVXYTQfK40jOTSEa/j09EcSOQ=;
 b=ToGPbICOyeYS5+aIPuzjjnnFWfx0nvJby3575Fgmw4O0yXyd+QR7UaBb9V6czmOTDR
 /2ytQ/tT4epObUFvLIvLrgdyfzk9/sfTWbbn3wLzpmJ79CKqAhfPtbsM9Ow3MX8uCRoN
 phnPfE6azfjyur7m9ljMB9UFP/yMbDMveRGGIVwF9THnHCo9bfycbzjLMcdWfQAiUB1x
 JoeyFKLPP1DnYuRtQhbxc0P2g30sWHbcjZvazRDmZvDhX1+wkzWvzIoiBkus1nKRzEKG
 va6Kz3Ry6W6REyYw4JjcIllwi6/Gey/sbjCTsXX0JAYnOOirU+sHOQerbVwDpChmF3Hd
 UxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717600626; x=1718205426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jlb7ESxOsRm5KDgEYeQVXYTQfK40jOTSEa/j09EcSOQ=;
 b=btYm/yw/1G/Q7JHNsQW+e4WXLPD7BV8tUNt073UqNQweHzaOnyfJ0rSeYPE6drZj48
 QVkNFodnDBSIDs1EjqD9/EE/h/bvIgxCf6e7aS71rsJgjTGbS1WPvh6moJkzrn9hzESB
 1EnSCShk7v/ARCQ3jsTL6oaqrXrsxwve1iyoBy9NUreTAyhBdQPGxfWU7HgdIf06j2DA
 9I2nz8xiEZ9nsTxkhkF8bMOmFOVCfmb7FCgqwWkOggad6g8+4RtKOmNm9aLqXRWaGcvE
 /ct2PNKTOcyUTHRf3jiWqQa34jlsnoepncOdpCmJDD9QO4dseV17vrM6nyOjd2A6bbVp
 Ho8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlQM9v1Y3MUuW+iRrtvLiYRR1rK672l+CGXlmXaubMGxt7C9b+jHv7i2fZWVfgfkmW6bFXMBK3RHyRLZZEsfGHD/nITes=
X-Gm-Message-State: AOJu0Yzr7t66S6AsmS2s0KH6zc2ifIpdF4rRLlxAV/pEwHaNCDoTx+2d
 H73yquG2iRqLXXZ8btjmQzl7THOB/qtpqRnGlWjrgxKq0cQfJKRENot4Poilgr15gbAKre36o9r
 r4Z8jmnFh4MIgaCWdcr/hUpFd8GwGUE3JM9Iz8Q==
X-Google-Smtp-Source: AGHT+IGucXdZ/GTRJNvz8GzD9tUz4SV5iqoz7G997laSxYtLInu9UDA6Y+qpm40kt6aLeiAdxfVdf438KfqLfDKQ6JU=
X-Received: by 2002:a25:dc93:0:b0:df7:94d3:5555 with SMTP id
 3f1490d57ef6-dfacacf8cf7mr2931997276.41.1717600625685; Wed, 05 Jun 2024
 08:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-6-rkanwal@rivosinc.com>
 <71bc36b9-cc17-4036-91b2-e7ddd81f0c07@sifive.com>
 <CAP55G9AAF9wwPEkNdG60Mnie8p=f-+ZzcjDBJU_RCSL+KSU77w@mail.gmail.com>
 <7a32916e-00f5-4244-8f4a-a39388136573@sifive.com>
In-Reply-To: <7a32916e-00f5-4244-8f4a-a39388136573@sifive.com>
From: Beeman Strong <beeman@rivosinc.com>
Date: Wed, 5 Jun 2024 08:16:53 -0700
Message-ID: <CAP55G9CDnz41wusJT-xxbs5=9F0b6tcdO97-uqNQYGYPdvnn=Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/riscv: Add CTR sctrclr instruction.
To: Jason Chien <jason.chien@sifive.com>
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, 
 apatel@ventanamicro.com, tech-control-transfer-records@lists.riscv.org
Content-Type: multipart/alternative; boundary="0000000000002932fc061a260ff8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=beeman@rivosinc.com; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000002932fc061a260ff8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 11:28=E2=80=AFPM Jason Chien <jason.chien@sifive.com=
> wrote:

> Chapter 5 describes the CTR behavior when Smstaten is enabled, but it doe=
s
> not talk about the CTR behavior when Smstateen is disabled, that is, ther=
e
> is no mstateen0 and hstateen0 CSR.
>
If Smstateen is not implemented then chapter 5 can be ignored, and the
behavior is as described in the other chapters.

> The spec states:
>
>    - Attempts to access sctrdepth from VS-mode or VU-mode raise a
>    virtual-instruction exception, unless CTR state enable access restrict=
ions
>    apply.
>
>
>    - sctrdepth is not included in the above list of supervisor CTR state
>    controlled by hstateen0.CTR since accesses to sctrdepth from VS-mode r=
aise
>    a virtual-instruction exception regardless of the value of hstateen0.C=
TR.
>
> Below is my understanding:
>
>    - If Smstateen is enabled:
>       - If mstateen0.CTR=3D0:
>          - Attempts to access sctrctl, vsctrctl, sctrdepth, or sctrstatus
>          raise an illegal-instruction exception for privilege modes less =
privileged
>          than M-mode.
>          - Attempts to access sireg* when siselect is in 0x200..0x2FF, or
>          vsireg* when vsiselect is in 0x200..0x2FF raise an illegal-instr=
uction
>          exception for privilege modes less privileged than M-mode.
>          - Execution of the SCTRCLR instruction raises an
>          illegal-instruction exception for privilege modes less privilege=
d than
>          M-mode.
>          - If mstateen.CTR=3D1:
>          - Attempts to access sctrctl, vsctrctl, sctrdepth, or sctrstatus
>          raise an illegal-instruction exception for U-mode.
>          - Attempts to access sireg* when siselect is in 0x200..0x2FF, or
>          vsireg* when vsiselect is in 0x200..0x2FF raise an illegal-instr=
uction
>          exception for U-mode.
>          - Execution of the SCTRCLR instruction raises an
>          illegal-instruction exception for U-mode.
>          - If H extension is enabled:
>             - If hstateen0.CTR =3D 0:
>             - Attempts to access sctrctl, vsctrctl, sctrdepth, or
>                sctrstatus raise an virtual-instruction exception for VU-m=
ode and VS-mode.
>                - Attempts to access sireg* when siselect is in
>                0x200..0x2FF, or vsireg* when vsiselect is in 0x200..0x2FF=
 raise an
>                virtual-instruction exception for VU-mode and VS-mode.
>                - Execution of the SCTRCLR instruction raises an
>                virtual-instruction exception for VU-mode and VS-mode.
>             - If hstateen0.CTR =3D 1:
>                - Attempts to access sctrctl, vsctrctl, sctrdepth, or
>                sctrstatus raise an virtual-instruction exception for VU-m=
ode.
>                - *Attempts to access sctrdepth raise an
>                virtual-instruction exception for "VS-mode".*
>                - Attempts to access sireg* when siselect is in
>                0x200..0x2FF, or vsireg* when vsiselect is in 0x200..0x2FF=
 raise an
>                virtual-instruction exception for VU-mode.
>                - Execution of the SCTRCLR instruction raises an
>                virtual-instruction exception for VU-mode.
>             - If Smstateen is disabled:
>       - Attempts to access sctrctl, vsctrctl, sctrdepth, or sctrstatus
>       raise an illegal-instruction exception for U-mode.
>       - Attempts to access sireg* when siselect is in 0x200..0x2FF, or
>       vsireg* when vsiselect is in 0x200..0x2FF raise an illegal-instruct=
ion
>       exception for U-mode.
>       - Execution of the SCTRCLR instruction raises an
>       illegal-instruction exception for U-mode.
>       - If H extension is enabled:
>          - Attempts to access sctrctl, vsctrctl, sctrdepth, or sctrstatus
>          raise an virtual-instruction exception for VU-mode.
>          - *Attempts to access sctrdepth raise an virtual-instruction
>          exception for "VS-mode".*
>          - Attempts to access sireg* when siselect is in 0x200..0x2FF, or
>          vsireg* when vsiselect is in 0x200..0x2FF raise an virtual-instr=
uction
>          exception for VU-mode.
>          - Execution of the SCTRCLR instruction raises an
>          virtual-instruction exception for VU-mode.
>
> If there is any misunderstanding, please let me know. Also Sstateen0 does
> not involve in CTR. Am I correct?
>
That all looks correct.  sctrdepth gets that special treatment in VS-mode
(bold and underlined above) because it is expected that a hypervisor will
wish to limit the depth options available to a guest, for the purposes of
VM-migration.

And yes, there is no U/VU-mode access to CTR, so Ssstaten does not apply to
CTR.


> Thanks in advance.
> Beeman Strong =E6=96=BC 2024/6/5 =E4=B8=8A=E5=8D=88 02:46 =E5=AF=AB=E9=81=
=93:
>
>
>
> On Tue, Jun 4, 2024 at 10:19=E2=80=AFAM Jason Chien <jason.chien@sifive.c=
om>
> wrote:
>
>>
>> Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=
=81=93:
>> > CTR extension adds a new instruction sctrclr to quickly
>> > clear the recorded entries buffer.
>> >
>> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
>> > ---
>> >   target/riscv/cpu.h                             |  1 +
>> >   target/riscv/cpu_helper.c                      |  7 +++++++
>> >   target/riscv/insn32.decode                     |  1 +
>> >   target/riscv/insn_trans/trans_privileged.c.inc | 10 ++++++++++
>> >   target/riscv/op_helper.c                       |  5 +++++
>> >   5 files changed, 24 insertions(+)
>> >
>> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> > index a294a5372a..fade71aa09 100644
>> > --- a/target/riscv/cpu.h
>> > +++ b/target/riscv/cpu.h
>> > @@ -572,6 +572,7 @@ void riscv_cpu_set_mode(CPURISCVState *env,
>> target_ulong newpriv, bool virt_en);
>> >   void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask);
>> >   void riscv_ctr_add_entry(CPURISCVState *env, target_long src,
>> target_long dst,
>> >                            uint64_t type, target_ulong prev_priv, bool
>> prev_virt);
>> > +void riscv_ctr_clear(CPURISCVState *env);
>> >
>> >   void riscv_translate_init(void);
>> >   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> > index e064a7306e..45502f50a7 100644
>> > --- a/target/riscv/cpu_helper.c
>> > +++ b/target/riscv/cpu_helper.c
>> > @@ -704,6 +704,13 @@ void riscv_ctr_freeze(CPURISCVState *env, uint64_=
t
>> freeze_mask)
>> >       }
>> >   }
>> >
>> > +void riscv_ctr_clear(CPURISCVState *env)
>> > +{
>> > +    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
>> > +    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
>> > +    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
>> > +}
>> > +
>> >   static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
>> >   {
>> >       switch (priv) {
>> > diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>> > index 9cb1a1b4ec..d3d38c7c68 100644
>> > --- a/target/riscv/insn32.decode
>> > +++ b/target/riscv/insn32.decode
>> > @@ -107,6 +107,7 @@
>> >   # *** Privileged Instructions ***
>> >   ecall       000000000000     00000 000 00000 1110011
>> >   ebreak      000000000001     00000 000 00000 1110011
>> > +sctrclr     000100000100     00000 000 00000 1110011
>> >   uret        0000000    00010 00000 000 00000 1110011
>> >   sret        0001000    00010 00000 000 00000 1110011
>> >   mret        0011000    00010 00000 000 00000 1110011
>> > diff --git a/target/riscv/insn_trans/trans_privileged.c.inc
>> b/target/riscv/insn_trans/trans_privileged.c.inc
>> > index 339d659151..dd9da8651f 100644
>> > --- a/target/riscv/insn_trans/trans_privileged.c.inc
>> > +++ b/target/riscv/insn_trans/trans_privileged.c.inc
>> > @@ -69,6 +69,16 @@ static bool trans_ebreak(DisasContext *ctx,
>> arg_ebreak *a)
>> >       return true;
>> >   }
>> >
>> > +static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
>> > +{
>> > +#ifndef CONFIG_USER_ONLY
>> If both of smctr and ssctr are not enabled, it is an illegal instruction=
.
>> > +    gen_helper_ctr_clear(tcg_env);
>> > +    return true;
>> > +#else
>> > +    return false;
>> > +#endif
>> > +}
>> > +
>> >   static bool trans_uret(DisasContext *ctx, arg_uret *a)
>> >   {
>> >       return false;
>> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>> > index c8053d9c2f..89423c04b3 100644
>> > --- a/target/riscv/op_helper.c
>> > +++ b/target/riscv/op_helper.c
>> > @@ -461,6 +461,11 @@ void helper_ctr_branch(CPURISCVState *env,
>> target_ulong src, target_ulong dest,
>> >       }
>> >   }
>> >
>> > +void helper_ctr_clear(CPURISCVState *env)
>> > +{
>>
>> There should be some checks here.
>> The spec states:
>> SCTRCLR raises an illegal-instruction exception in U-mode, and a
>> virtual-instruction exception in VU-mode, unless CTR state enable access
>> restrictions apply.
>>
>> I don't quite understand "unless CTR state enable access restrictions
>> apply" though.
>>
>
> The next sentence says "See Chapter 5", which states that execution of
> SCTRCLR raises an illegal instruction exception if mstateen0.CTR=3D0 and =
the
> priv mode is not M-mode, and it raises a virtual instruction exception if
> mstateen0.CTR=3D0 && hstateen0.CTR=3D1 and the priv mode is VS-mode.
>
> When mstateen0.CTR=3D0, hstateen0.CTR is read-only 0. I guess you meant
> "mstateen0.CTR=3D1 && hstateen0.CTR=3D0" here.
>

You're right, thanks.

>
>
>>
>> > +    riscv_ctr_clear(env);
>> > +}
>> > +
>> >   void helper_wfi(CPURISCVState *env)
>> >   {
>> >       CPUState *cs =3D env_cpu(env);
>>
>

--0000000000002932fc061a260ff8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 11:28=E2=80=AF=
PM Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com">jason.chien@si=
five.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><u></u>

 =20
   =20
 =20
  <div>
    <p>Chapter 5 describes the CTR behavior when Smstaten is enabled,
      but it does not talk about the CTR behavior when Smstateen is
      disabled, that is, there is no mstateen0 and hstateen0 CSR.</p></div>=
</blockquote><div>If Smstateen is not implemented then chapter 5 can be ign=
ored, and the behavior is as described in the other chapters.=C2=A0<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div>
    <p>The spec states:<br>
    </p>
    <ul>
      <li>Attempts to access sctrdepth from VS-mode or VU-mode raise a
        virtual-instruction exception, unless CTR state enable access
        restrictions apply.</li>
    </ul>
    <ul>
      <li>sctrdepth is not included in the above list of supervisor CTR
        state controlled by hstateen0.CTR since accesses to sctrdepth
        from VS-mode raise a virtual-instruction exception regardless of
        the value of hstateen0.CTR.</li>
    </ul>
    <p>Below is my understanding:<br>
    </p>
    <ul>
      <li>If Smstateen is enabled:</li>
      <ul>
        <li>If mstateen0.CTR=3D0:</li>
        <ul>
          <li>Attempts to access sctrctl, vsctrctl, sctrdepth, or
            sctrstatus raise an illegal-instruction exception for
            privilege modes less privileged than M-mode.</li>
          <li>Attempts to access sireg* when siselect is in
            0x200..0x2FF, or vsireg* when vsiselect is in 0x200..0x2FF
            raise an illegal-instruction exception for privilege modes
            less privileged than M-mode.</li>
          <li>Execution of the SCTRCLR instruction raises an
            illegal-instruction exception for privilege modes less
            privileged than M-mode.<br>
          </li>
        </ul>
        <li>If mstateen.CTR=3D1:</li>
        <ul>
          <li>Attempts to access sctrctl, vsctrctl, sctrdepth, or
            sctrstatus raise an illegal-instruction exception for
            U-mode.</li>
          <li>Attempts to access sireg* when siselect is in
            0x200..0x2FF, or vsireg* when vsiselect is in 0x200..0x2FF
            raise an illegal-instruction exception for U-mode.</li>
          <li>Execution of the SCTRCLR instruction raises an
            illegal-instruction exception for U-mode.</li>
          <li>If H extension is enabled:</li>
          <ul>
            <li>If hstateen0.CTR =3D 0:<br>
            </li>
            <ul>
              <li>Attempts to access sctrctl, vsctrctl, sctrdepth, or
                sctrstatus raise an virtual-instruction exception for
                VU-mode and VS-mode.</li>
              <li>Attempts to access sireg* when siselect is in
                0x200..0x2FF, or vsireg* when vsiselect is in
                0x200..0x2FF raise an virtual-instruction exception for
                VU-mode and VS-mode.</li>
              <li>Execution of the SCTRCLR instruction raises an
                virtual-instruction exception for VU-mode and VS-mode.</li>
            </ul>
            <li>If hstateen0.CTR =3D 1:</li>
            <ul>
              <li>Attempts to access sctrctl, vsctrctl, sctrdepth, or
                sctrstatus raise an virtual-instruction exception for
                VU-mode.</li>
              <li><b><u><i>Attempts to access sctrdepth raise an
                      virtual-instruction exception for &quot;VS-mode&quot;=
</i>.</u></b></li>
              <li>Attempts to access sireg* when siselect is in
                0x200..0x2FF, or vsireg* when vsiselect is in
                0x200..0x2FF raise an virtual-instruction exception for
                VU-mode.</li>
              <li>Execution of the SCTRCLR instruction raises an
                virtual-instruction exception for VU-mode.</li>
            </ul>
          </ul>
        </ul>
      </ul>
      <li>If Smstateen is disabled:</li>
      <ul>
        <li>Attempts to access sctrctl, vsctrctl, sctrdepth, or
          sctrstatus raise an illegal-instruction exception for U-mode.</li=
>
        <li>Attempts to access sireg* when siselect is in 0x200..0x2FF,
          or vsireg* when vsiselect is in 0x200..0x2FF raise an
          illegal-instruction exception for U-mode.</li>
        <li>Execution of the SCTRCLR instruction raises an
          illegal-instruction exception for U-mode.</li>
        <li>If H extension is enabled:</li>
        <ul>
          <li>Attempts to access sctrctl, vsctrctl, sctrdepth, or
            sctrstatus raise an virtual-instruction exception for
            VU-mode.</li>
          <li><b><i><u>Attempts to access sctrdepth raise an
                  virtual-instruction exception for &quot;VS-mode&quot;.</u=
></i></b></li>
          <li>Attempts to access sireg* when siselect is in
            0x200..0x2FF, or vsireg* when vsiselect is in 0x200..0x2FF
            raise an virtual-instruction exception for VU-mode.</li>
          <li>Execution of the SCTRCLR instruction raises an
            virtual-instruction exception for VU-mode.</li>
        </ul>
      </ul>
    </ul>
    <p>If there is any misunderstanding, please let me know. Also
      Sstateen0 does not involve in CTR. Am I correct?<br></p></div></block=
quote><div>That all looks correct.=C2=A0 sctrdepth gets that special treatm=
ent in VS-mode (bold and underlined above) because it is expected that a hy=
pervisor will wish to limit the depth options available to a guest, for the=
 purposes of VM-migration.</div><div><br></div><div>And yes, there is no U/=
VU-mode access to CTR, so Ssstaten does not apply to CTR.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div><p>
    </p>
    <p>Thanks in advance.<br>
    </p>
    <div>Beeman Strong =E6=96=BC 2024/6/5 =E4=B8=8A=E5=8D=88 02:46 =E5=AF=
=AB=E9=81=93:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr"><br>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at
            10:19=E2=80=AFAM Jason Chien &lt;<a href=3D"mailto:jason.chien@=
sifive.com" target=3D"_blank">jason.chien@sifive.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
            Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=
=AF=AB=E9=81=93:<br>
            &gt; CTR extension adds a new instruction sctrclr to quickly<br=
>
            &gt; clear the recorded entries buffer.<br>
            &gt;<br>
            &gt; Signed-off-by: Rajnesh Kanwal &lt;<a href=3D"mailto:rkanwa=
l@rivosinc.com" target=3D"_blank">rkanwal@rivosinc.com</a>&gt;<br>
            &gt; ---<br>
            &gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 1 +<br>
            &gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7
            +++++++<br>
            &gt;=C2=A0 =C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
            &gt;=C2=A0 =C2=A0target/riscv/insn_trans/trans_privileged.c.inc=
 | 10
            ++++++++++<br>
            &gt;=C2=A0 =C2=A0target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5
            +++++<br>
            &gt;=C2=A0 =C2=A05 files changed, 24 insertions(+)<br>
            &gt;<br>
            &gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
            &gt; index a294a5372a..fade71aa09 100644<br>
            &gt; --- a/target/riscv/cpu.h<br>
            &gt; +++ b/target/riscv/cpu.h<br>
            &gt; @@ -572,6 +572,7 @@ void
            riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv,
            bool virt_en);<br>
            &gt;=C2=A0 =C2=A0void riscv_ctr_freeze(CPURISCVState *env, uint=
64_t
            freeze_mask);<br>
            &gt;=C2=A0 =C2=A0void riscv_ctr_add_entry(CPURISCVState *env,
            target_long src, target_long dst,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t type, target_ulong
            prev_priv, bool prev_virt);<br>
            &gt; +void riscv_ctr_clear(CPURISCVState *env);<br>
            &gt;=C2=A0 =C2=A0<br>
            &gt;=C2=A0 =C2=A0void riscv_translate_init(void);<br>
            &gt;=C2=A0 =C2=A0G_NORETURN void riscv_raise_exception(CPURISCV=
State
            *env,<br>
            &gt; diff --git a/target/riscv/cpu_helper.c
            b/target/riscv/cpu_helper.c<br>
            &gt; index e064a7306e..45502f50a7 100644<br>
            &gt; --- a/target/riscv/cpu_helper.c<br>
            &gt; +++ b/target/riscv/cpu_helper.c<br>
            &gt; @@ -704,6 +704,13 @@ void
            riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask)<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            &gt;=C2=A0 =C2=A0}<br>
            &gt;=C2=A0 =C2=A0<br>
            &gt; +void riscv_ctr_clear(CPURISCVState *env)<br>
            &gt; +{<br>
            &gt; +=C2=A0 =C2=A0 memset(env-&gt;ctr_src, 0x0,
            sizeof(env-&gt;ctr_src));<br>
            &gt; +=C2=A0 =C2=A0 memset(env-&gt;ctr_dst, 0x0,
            sizeof(env-&gt;ctr_dst));<br>
            &gt; +=C2=A0 =C2=A0 memset(env-&gt;ctr_data, 0x0,
            sizeof(env-&gt;ctr_data));<br>
            &gt; +}<br>
            &gt; +<br>
            &gt;=C2=A0 =C2=A0static uint64_t riscv_ctr_priv_to_mask(target_=
ulong
            priv, bool virt)<br>
            &gt;=C2=A0 =C2=A0{<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (priv) {<br>
            &gt; diff --git a/target/riscv/insn32.decode
            b/target/riscv/insn32.decode<br>
            &gt; index 9cb1a1b4ec..d3d38c7c68 100644<br>
            &gt; --- a/target/riscv/insn32.decode<br>
            &gt; +++ b/target/riscv/insn32.decode<br>
            &gt; @@ -107,6 +107,7 @@<br>
            &gt;=C2=A0 =C2=A0# *** Privileged Instructions ***<br>
            &gt;=C2=A0 =C2=A0ecall=C2=A0 =C2=A0 =C2=A0 =C2=A0000000000000=
=C2=A0 =C2=A0 =C2=A000000 000 00000 1110011<br>
            &gt;=C2=A0 =C2=A0ebreak=C2=A0 =C2=A0 =C2=A0 000000000001=C2=A0 =
=C2=A0 =C2=A000000 000 00000 1110011<br>
            &gt; +sctrclr=C2=A0 =C2=A0 =C2=A0000100000100=C2=A0 =C2=A0 =C2=
=A000000 000 00000 1110011<br>
            &gt;=C2=A0 =C2=A0uret=C2=A0 =C2=A0 =C2=A0 =C2=A0 0000000=C2=A0 =
=C2=A0 00010 00000 000 00000 1110011<br>
            &gt;=C2=A0 =C2=A0sret=C2=A0 =C2=A0 =C2=A0 =C2=A0 0001000=C2=A0 =
=C2=A0 00010 00000 000 00000 1110011<br>
            &gt;=C2=A0 =C2=A0mret=C2=A0 =C2=A0 =C2=A0 =C2=A0 0011000=C2=A0 =
=C2=A0 00010 00000 000 00000 1110011<br>
            &gt; diff --git
            a/target/riscv/insn_trans/trans_privileged.c.inc
            b/target/riscv/insn_trans/trans_privileged.c.inc<br>
            &gt; index 339d659151..dd9da8651f 100644<br>
            &gt; --- a/target/riscv/insn_trans/trans_privileged.c.inc<br>
            &gt; +++ b/target/riscv/insn_trans/trans_privileged.c.inc<br>
            &gt; @@ -69,6 +69,16 @@ static bool
            trans_ebreak(DisasContext *ctx, arg_ebreak *a)<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
            &gt;=C2=A0 =C2=A0}<br>
            &gt;=C2=A0 =C2=A0<br>
            &gt; +static bool trans_sctrclr(DisasContext *ctx,
            arg_sctrclr *a)<br>
            &gt; +{<br>
            &gt; +#ifndef CONFIG_USER_ONLY<br>
            If both of smctr and ssctr are not enabled, it is an illegal
            instruction.<br>
            &gt; +=C2=A0 =C2=A0 gen_helper_ctr_clear(tcg_env);<br>
            &gt; +=C2=A0 =C2=A0 return true;<br>
            &gt; +#else<br>
            &gt; +=C2=A0 =C2=A0 return false;<br>
            &gt; +#endif<br>
            &gt; +}<br>
            &gt; +<br>
            &gt;=C2=A0 =C2=A0static bool trans_uret(DisasContext *ctx, arg_=
uret
            *a)<br>
            &gt;=C2=A0 =C2=A0{<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
            &gt; diff --git a/target/riscv/op_helper.c
            b/target/riscv/op_helper.c<br>
            &gt; index c8053d9c2f..89423c04b3 100644<br>
            &gt; --- a/target/riscv/op_helper.c<br>
            &gt; +++ b/target/riscv/op_helper.c<br>
            &gt; @@ -461,6 +461,11 @@ void
            helper_ctr_branch(CPURISCVState *env, target_ulong src,
            target_ulong dest,<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            &gt;=C2=A0 =C2=A0}<br>
            &gt;=C2=A0 =C2=A0<br>
            &gt; +void helper_ctr_clear(CPURISCVState *env)<br>
            &gt; +{<br>
            <br>
            There should be some checks here.<br>
            The spec states:<br>
            SCTRCLR raises an illegal-instruction exception in U-mode,
            and a <br>
            virtual-instruction exception in VU-mode, unless CTR state
            enable access <br>
            restrictions apply.<br>
            <br>
            I don&#39;t quite understand &quot;unless CTR state enable acce=
ss
            restrictions <br>
            apply&quot; though.<br>
          </blockquote>
          <div><br>
          </div>
          <div>The next sentence says &quot;See Chapter 5&quot;, which stat=
es that
            execution of SCTRCLR raises an illegal instruction exception
            if mstateen0.CTR=3D0 and the priv mode is not M-mode, and it
            raises a virtual instruction exception if mstateen0.CTR=3D0
            &amp;&amp; hstateen0.CTR=3D1 and the priv mode is VS-mode.</div=
>
        </div>
      </div>
    </blockquote>
    When mstateen0.CTR=3D0, hstateen0.CTR is read-only 0. I guess you
    meant &quot;mstateen0.CTR=3D1 &amp;&amp; hstateen0.CTR=3D0&quot; here.<=
br></div></blockquote><div><br></div><div>You&#39;re right, thanks.=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            &gt; +=C2=A0 =C2=A0 riscv_ctr_clear(env);<br>
            &gt; +}<br>
            &gt; +<br>
            &gt;=C2=A0 =C2=A0void helper_wfi(CPURISCVState *env)<br>
            &gt;=C2=A0 =C2=A0{<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<b=
r>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </div>

</blockquote></div></div>

--0000000000002932fc061a260ff8--

