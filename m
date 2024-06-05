Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4F6C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEk8Q-0007Na-I0; Wed, 05 Jun 2024 02:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEk8K-0007N5-HA
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:28:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEk8H-0006SP-Q7
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:28:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so57237445ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717568904; x=1718173704; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgxsxVOgkWC7Q37RtYD7x+F0PZSdU0FnRQIkFTQTFFs=;
 b=Mb8XcU/ViFsbG/Oaj2oJf835o9J15u8aq0ekfyCYKC8Rk3lkgqWOKsQcdbnLMRMqk/
 f/Xl+IfVxWc/TaQmCn2BJ2MNiwy/kSHNZmSXkuonpkb/svPK5RcV9wKCJKunU73SPvkS
 WvP3zn8IOKCuxr1euzgDf54xqmfV3zwRdvqtym71wTofI4ESdGYovHLVrJmVPb9BuPBX
 /2XM6lpkUksXpsJvIauzaShw3ZdjROwBB4X6/nbJspvuouV9+NkWUhgzZOs3jxz+kMMl
 C/EQSohUxkeF1NUoA479/G9MkcxhbwVfpPNwiAmHoQnvtuLi6B+9YKkwaKZCCAfr1YY0
 gV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717568904; x=1718173704;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HgxsxVOgkWC7Q37RtYD7x+F0PZSdU0FnRQIkFTQTFFs=;
 b=o/3o1pLVKQg9qA7ap4oI58qQhZPMzgTq+Prp3lKLAKKKES2KpLF071rWbN0GDL0Q4z
 HmoUbha3/S9Amqk6AOJRlF1C0RCqx8jPPQZr77qhZthJCvV3ztsZFMKU8t0kM1rgWPDL
 5mL86s5t4nh/WrAqvRteSLtxOlabAVFSSQucc7jcWjM3X8KpYl16IRTdwr+WOFTr1wJf
 Yg2MgpdQzbIWOaauk1MHrTQ6Zu+F2GIl6njr/IUFKbwcoU57m5wXiUyitJohPWYH0y9a
 IaeH91OEJVaZL29OLfPSSUjEER0Wh4WDFHBMM4CpgOi6xMBDkNjnKzQS7vT329bDCuBV
 v+xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMYhCtfXyF8xwPNsZ/A80ZGtoA/vZd6DhF5iJYlbrVSua/huYM6YOClMTXYwFgMau1/1a7V/ILlHyvr2QPWBoLPS2ghfo=
X-Gm-Message-State: AOJu0YzHaTFdkX/5pnei6VhBVBtmpvtYNB7h+yG/AaTEeEkkPOTqEtT4
 osn/b5ewUdB3mjuEl+HLgLRE3t9uX5UoM3YEfg8xnw7NX8i9mZfvsp89KeJwDSM6SUN8R3M6ySi
 fbbI=
X-Google-Smtp-Source: AGHT+IEyNGbhG2Bay57Iba5bognKnGpKQ+Zum+J6qypG+XV1Hyh1X/Pn7PHg3o/1hq8OlNcmHKVW2A==
X-Received: by 2002:a17:90b:3e86:b0:2bd:b21d:cfd6 with SMTP id
 98e67ed59e1d1-2c27db5ccc3mr1703434a91.33.1717568904034; 
 Tue, 04 Jun 2024 23:28:24 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806d2936sm613049a91.53.2024.06.04.23.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 23:28:23 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------esDCZSjtOl7U0B6dlI5nl9mD"
Message-ID: <7a32916e-00f5-4244-8f4a-a39388136573@sifive.com>
Date: Wed, 5 Jun 2024 14:28:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/riscv: Add CTR sctrclr instruction.
To: Beeman Strong <beeman@rivosinc.com>
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-6-rkanwal@rivosinc.com>
 <71bc36b9-cc17-4036-91b2-e7ddd81f0c07@sifive.com>
 <CAP55G9AAF9wwPEkNdG60Mnie8p=f-+ZzcjDBJU_RCSL+KSU77w@mail.gmail.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <CAP55G9AAF9wwPEkNdG60Mnie8p=f-+ZzcjDBJU_RCSL+KSU77w@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------esDCZSjtOl7U0B6dlI5nl9mD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Chapter 5 describes the CTR behavior when Smstaten is enabled, but it 
does not talk about the CTR behavior when Smstateen is disabled, that 
is, there is no mstateen0 and hstateen0 CSR.

The spec states:

  * Attempts to access sctrdepth from VS-mode or VU-mode raise a
    virtual-instruction exception, unless CTR state enable access
    restrictions apply.

  * sctrdepth is not included in the above list of supervisor CTR state
    controlled by hstateen0.CTR since accesses to sctrdepth from VS-mode
    raise a virtual-instruction exception regardless of the value of
    hstateen0.CTR.

Below is my understanding:

  * If Smstateen is enabled:
      o If mstateen0.CTR=0:
          + Attempts to access sctrctl, vsctrctl, sctrdepth, or
            sctrstatus raise an illegal-instruction exception for
            privilege modes less privileged than M-mode.
          + Attempts to access sireg* when siselect is in 0x200..0x2FF,
            or vsireg* when vsiselect is in 0x200..0x2FF raise an
            illegal-instruction exception for privilege modes less
            privileged than M-mode.
          + Execution of the SCTRCLR instruction raises an
            illegal-instruction exception for privilege modes less
            privileged than M-mode.
      o If mstateen.CTR=1:
          + Attempts to access sctrctl, vsctrctl, sctrdepth, or
            sctrstatus raise an illegal-instruction exception for U-mode.
          + Attempts to access sireg* when siselect is in 0x200..0x2FF,
            or vsireg* when vsiselect is in 0x200..0x2FF raise an
            illegal-instruction exception for U-mode.
          + Execution of the SCTRCLR instruction raises an
            illegal-instruction exception for U-mode.
          + If H extension is enabled:
              # If hstateen0.CTR = 0:
                  * Attempts to access sctrctl, vsctrctl, sctrdepth, or
                    sctrstatus raise an virtual-instruction exception
                    for VU-mode and VS-mode.
                  * Attempts to access sireg* when siselect is in
                    0x200..0x2FF, or vsireg* when vsiselect is in
                    0x200..0x2FF raise an virtual-instruction exception
                    for VU-mode and VS-mode.
                  * Execution of the SCTRCLR instruction raises an
                    virtual-instruction exception for VU-mode and VS-mode.
              # If hstateen0.CTR = 1:
                  * Attempts to access sctrctl, vsctrctl, sctrdepth, or
                    sctrstatus raise an virtual-instruction exception
                    for VU-mode.
                  * *_/Attempts to access sctrdepth raise an
                    virtual-instruction exception for "VS-mode"/._*
                  * Attempts to access sireg* when siselect is in
                    0x200..0x2FF, or vsireg* when vsiselect is in
                    0x200..0x2FF raise an virtual-instruction exception
                    for VU-mode.
                  * Execution of the SCTRCLR instruction raises an
                    virtual-instruction exception for VU-mode.
  * If Smstateen is disabled:
      o Attempts to access sctrctl, vsctrctl, sctrdepth, or sctrstatus
        raise an illegal-instruction exception for U-mode.
      o Attempts to access sireg* when siselect is in 0x200..0x2FF, or
        vsireg* when vsiselect is in 0x200..0x2FF raise an
        illegal-instruction exception for U-mode.
      o Execution of the SCTRCLR instruction raises an
        illegal-instruction exception for U-mode.
      o If H extension is enabled:
          + Attempts to access sctrctl, vsctrctl, sctrdepth, or
            sctrstatus raise an virtual-instruction exception for VU-mode.
          + */_Attempts to access sctrdepth raise an virtual-instruction
            exception for "VS-mode"._/*
          + Attempts to access sireg* when siselect is in 0x200..0x2FF,
            or vsireg* when vsiselect is in 0x200..0x2FF raise an
            virtual-instruction exception for VU-mode.
          + Execution of the SCTRCLR instruction raises an
            virtual-instruction exception for VU-mode.

If there is any misunderstanding, please let me know. Also Sstateen0 
does not involve in CTR. Am I correct?

Thanks in advance.

Beeman Strong 於 2024/6/5 上午 02:46 寫道:
>
>
> On Tue, Jun 4, 2024 at 10:19 AM Jason Chien <jason.chien@sifive.com> 
> wrote:
>
>
>     Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:
>     > CTR extension adds a new instruction sctrclr to quickly
>     > clear the recorded entries buffer.
>     >
>     > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
>     > ---
>     >   target/riscv/cpu.h                             |  1 +
>     >   target/riscv/cpu_helper.c                      |  7 +++++++
>     >   target/riscv/insn32.decode                     |  1 +
>     >   target/riscv/insn_trans/trans_privileged.c.inc | 10 ++++++++++
>     >   target/riscv/op_helper.c                       |  5 +++++
>     >   5 files changed, 24 insertions(+)
>     >
>     > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>     > index a294a5372a..fade71aa09 100644
>     > --- a/target/riscv/cpu.h
>     > +++ b/target/riscv/cpu.h
>     > @@ -572,6 +572,7 @@ void riscv_cpu_set_mode(CPURISCVState *env,
>     target_ulong newpriv, bool virt_en);
>     >   void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask);
>     >   void riscv_ctr_add_entry(CPURISCVState *env, target_long src,
>     target_long dst,
>     >                            uint64_t type, target_ulong
>     prev_priv, bool prev_virt);
>     > +void riscv_ctr_clear(CPURISCVState *env);
>     >
>     >   void riscv_translate_init(void);
>     >   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>     > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>     > index e064a7306e..45502f50a7 100644
>     > --- a/target/riscv/cpu_helper.c
>     > +++ b/target/riscv/cpu_helper.c
>     > @@ -704,6 +704,13 @@ void riscv_ctr_freeze(CPURISCVState *env,
>     uint64_t freeze_mask)
>     >       }
>     >   }
>     >
>     > +void riscv_ctr_clear(CPURISCVState *env)
>     > +{
>     > +    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
>     > +    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
>     > +    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
>     > +}
>     > +
>     >   static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool
>     virt)
>     >   {
>     >       switch (priv) {
>     > diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>     > index 9cb1a1b4ec..d3d38c7c68 100644
>     > --- a/target/riscv/insn32.decode
>     > +++ b/target/riscv/insn32.decode
>     > @@ -107,6 +107,7 @@
>     >   # *** Privileged Instructions ***
>     >   ecall       000000000000     00000 000 00000 1110011
>     >   ebreak      000000000001     00000 000 00000 1110011
>     > +sctrclr     000100000100     00000 000 00000 1110011
>     >   uret        0000000    00010 00000 000 00000 1110011
>     >   sret        0001000    00010 00000 000 00000 1110011
>     >   mret        0011000    00010 00000 000 00000 1110011
>     > diff --git a/target/riscv/insn_trans/trans_privileged.c.inc
>     b/target/riscv/insn_trans/trans_privileged.c.inc
>     > index 339d659151..dd9da8651f 100644
>     > --- a/target/riscv/insn_trans/trans_privileged.c.inc
>     > +++ b/target/riscv/insn_trans/trans_privileged.c.inc
>     > @@ -69,6 +69,16 @@ static bool trans_ebreak(DisasContext *ctx,
>     arg_ebreak *a)
>     >       return true;
>     >   }
>     >
>     > +static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
>     > +{
>     > +#ifndef CONFIG_USER_ONLY
>     If both of smctr and ssctr are not enabled, it is an illegal
>     instruction.
>     > +    gen_helper_ctr_clear(tcg_env);
>     > +    return true;
>     > +#else
>     > +    return false;
>     > +#endif
>     > +}
>     > +
>     >   static bool trans_uret(DisasContext *ctx, arg_uret *a)
>     >   {
>     >       return false;
>     > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>     > index c8053d9c2f..89423c04b3 100644
>     > --- a/target/riscv/op_helper.c
>     > +++ b/target/riscv/op_helper.c
>     > @@ -461,6 +461,11 @@ void helper_ctr_branch(CPURISCVState *env,
>     target_ulong src, target_ulong dest,
>     >       }
>     >   }
>     >
>     > +void helper_ctr_clear(CPURISCVState *env)
>     > +{
>
>     There should be some checks here.
>     The spec states:
>     SCTRCLR raises an illegal-instruction exception in U-mode, and a
>     virtual-instruction exception in VU-mode, unless CTR state enable
>     access
>     restrictions apply.
>
>     I don't quite understand "unless CTR state enable access restrictions
>     apply" though.
>
>
> The next sentence says "See Chapter 5", which states that execution of 
> SCTRCLR raises an illegal instruction exception if mstateen0.CTR=0 and 
> the priv mode is not M-mode, and it raises a virtual instruction 
> exception if mstateen0.CTR=0 && hstateen0.CTR=1 and the priv mode is 
> VS-mode.
When mstateen0.CTR=0, hstateen0.CTR is read-only 0. I guess you meant 
"mstateen0.CTR=1 && hstateen0.CTR=0" here.
>
>
>     > +    riscv_ctr_clear(env);
>     > +}
>     > +
>     >   void helper_wfi(CPURISCVState *env)
>     >   {
>     >       CPUState *cs = env_cpu(env);
>
--------------esDCZSjtOl7U0B6dlI5nl9mD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Chapter 5 describes the CTR behavior when Smstaten is enabled,
      but it does not talk about the CTR behavior when Smstateen is
      disabled, that is, there is no mstateen0 and hstateen0 CSR.</p>
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
        <li>If mstateen0.CTR=0:</li>
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
        <li>If mstateen.CTR=1:</li>
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
            <li>If hstateen0.CTR = 0:<br>
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
            <li>If hstateen0.CTR = 1:</li>
            <ul>
              <li>Attempts to access sctrctl, vsctrctl, sctrdepth, or
                sctrstatus raise an virtual-instruction exception for
                VU-mode.</li>
              <li><b><u><i>Attempts to access sctrdepth raise an
                      virtual-instruction exception for "VS-mode"</i>.</u></b></li>
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
          sctrstatus raise an illegal-instruction exception for U-mode.</li>
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
                  virtual-instruction exception for "VS-mode".</u></i></b></li>
          <li>Attempts to access sireg* when siselect is in
            0x200..0x2FF, or vsireg* when vsiselect is in 0x200..0x2FF
            raise an virtual-instruction exception for VU-mode.</li>
          <li>Execution of the SCTRCLR instruction raises an
            virtual-instruction exception for VU-mode.</li>
        </ul>
      </ul>
    </ul>
    <p>If there is any misunderstanding, please let me know. Also
      Sstateen0 does not involve in CTR. Am I correct?<br>
    </p>
    <p>Thanks in advance.<br>
    </p>
    <div class="moz-cite-prefix">Beeman Strong 於 2024/6/5 上午 02:46 寫道:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAP55G9AAF9wwPEkNdG60Mnie8p=f-+ZzcjDBJU_RCSL+KSU77w@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Tue, Jun 4, 2024 at
            10:19 AM Jason Chien &lt;<a
              href="mailto:jason.chien@sifive.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">jason.chien@sifive.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
            Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:<br>
            &gt; CTR extension adds a new instruction sctrclr to quickly<br>
            &gt; clear the recorded entries buffer.<br>
            &gt;<br>
            &gt; Signed-off-by: Rajnesh Kanwal &lt;<a
              href="mailto:rkanwal@rivosinc.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">rkanwal@rivosinc.com</a>&gt;<br>
            &gt; ---<br>
            &gt;   target/riscv/cpu.h                             |  1 +<br>
            &gt;   target/riscv/cpu_helper.c                      |  7
            +++++++<br>
            &gt;   target/riscv/insn32.decode                     |  1 +<br>
            &gt;   target/riscv/insn_trans/trans_privileged.c.inc | 10
            ++++++++++<br>
            &gt;   target/riscv/op_helper.c                       |  5
            +++++<br>
            &gt;   5 files changed, 24 insertions(+)<br>
            &gt;<br>
            &gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
            &gt; index a294a5372a..fade71aa09 100644<br>
            &gt; --- a/target/riscv/cpu.h<br>
            &gt; +++ b/target/riscv/cpu.h<br>
            &gt; @@ -572,6 +572,7 @@ void
            riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv,
            bool virt_en);<br>
            &gt;   void riscv_ctr_freeze(CPURISCVState *env, uint64_t
            freeze_mask);<br>
            &gt;   void riscv_ctr_add_entry(CPURISCVState *env,
            target_long src, target_long dst,<br>
            &gt;                            uint64_t type, target_ulong
            prev_priv, bool prev_virt);<br>
            &gt; +void riscv_ctr_clear(CPURISCVState *env);<br>
            &gt;   <br>
            &gt;   void riscv_translate_init(void);<br>
            &gt;   G_NORETURN void riscv_raise_exception(CPURISCVState
            *env,<br>
            &gt; diff --git a/target/riscv/cpu_helper.c
            b/target/riscv/cpu_helper.c<br>
            &gt; index e064a7306e..45502f50a7 100644<br>
            &gt; --- a/target/riscv/cpu_helper.c<br>
            &gt; +++ b/target/riscv/cpu_helper.c<br>
            &gt; @@ -704,6 +704,13 @@ void
            riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask)<br>
            &gt;       }<br>
            &gt;   }<br>
            &gt;   <br>
            &gt; +void riscv_ctr_clear(CPURISCVState *env)<br>
            &gt; +{<br>
            &gt; +    memset(env-&gt;ctr_src, 0x0,
            sizeof(env-&gt;ctr_src));<br>
            &gt; +    memset(env-&gt;ctr_dst, 0x0,
            sizeof(env-&gt;ctr_dst));<br>
            &gt; +    memset(env-&gt;ctr_data, 0x0,
            sizeof(env-&gt;ctr_data));<br>
            &gt; +}<br>
            &gt; +<br>
            &gt;   static uint64_t riscv_ctr_priv_to_mask(target_ulong
            priv, bool virt)<br>
            &gt;   {<br>
            &gt;       switch (priv) {<br>
            &gt; diff --git a/target/riscv/insn32.decode
            b/target/riscv/insn32.decode<br>
            &gt; index 9cb1a1b4ec..d3d38c7c68 100644<br>
            &gt; --- a/target/riscv/insn32.decode<br>
            &gt; +++ b/target/riscv/insn32.decode<br>
            &gt; @@ -107,6 +107,7 @@<br>
            &gt;   # *** Privileged Instructions ***<br>
            &gt;   ecall       000000000000     00000 000 00000 1110011<br>
            &gt;   ebreak      000000000001     00000 000 00000 1110011<br>
            &gt; +sctrclr     000100000100     00000 000 00000 1110011<br>
            &gt;   uret        0000000    00010 00000 000 00000 1110011<br>
            &gt;   sret        0001000    00010 00000 000 00000 1110011<br>
            &gt;   mret        0011000    00010 00000 000 00000 1110011<br>
            &gt; diff --git
            a/target/riscv/insn_trans/trans_privileged.c.inc
            b/target/riscv/insn_trans/trans_privileged.c.inc<br>
            &gt; index 339d659151..dd9da8651f 100644<br>
            &gt; --- a/target/riscv/insn_trans/trans_privileged.c.inc<br>
            &gt; +++ b/target/riscv/insn_trans/trans_privileged.c.inc<br>
            &gt; @@ -69,6 +69,16 @@ static bool
            trans_ebreak(DisasContext *ctx, arg_ebreak *a)<br>
            &gt;       return true;<br>
            &gt;   }<br>
            &gt;   <br>
            &gt; +static bool trans_sctrclr(DisasContext *ctx,
            arg_sctrclr *a)<br>
            &gt; +{<br>
            &gt; +#ifndef CONFIG_USER_ONLY<br>
            If both of smctr and ssctr are not enabled, it is an illegal
            instruction.<br>
            &gt; +    gen_helper_ctr_clear(tcg_env);<br>
            &gt; +    return true;<br>
            &gt; +#else<br>
            &gt; +    return false;<br>
            &gt; +#endif<br>
            &gt; +}<br>
            &gt; +<br>
            &gt;   static bool trans_uret(DisasContext *ctx, arg_uret
            *a)<br>
            &gt;   {<br>
            &gt;       return false;<br>
            &gt; diff --git a/target/riscv/op_helper.c
            b/target/riscv/op_helper.c<br>
            &gt; index c8053d9c2f..89423c04b3 100644<br>
            &gt; --- a/target/riscv/op_helper.c<br>
            &gt; +++ b/target/riscv/op_helper.c<br>
            &gt; @@ -461,6 +461,11 @@ void
            helper_ctr_branch(CPURISCVState *env, target_ulong src,
            target_ulong dest,<br>
            &gt;       }<br>
            &gt;   }<br>
            &gt;   <br>
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
            I don't quite understand "unless CTR state enable access
            restrictions <br>
            apply" though.<br>
          </blockquote>
          <div><br>
          </div>
          <div>The next sentence says "See Chapter 5", which states that
            execution of SCTRCLR raises an illegal instruction exception
            if mstateen0.CTR=0 and the priv mode is not M-mode, and it
            raises a virtual instruction exception if mstateen0.CTR=0
            &amp;&amp; hstateen0.CTR=1 and the priv mode is VS-mode.</div>
        </div>
      </div>
    </blockquote>
    When mstateen0.CTR=0, hstateen0.CTR is read-only 0. I guess you
    meant "mstateen0.CTR=1 &amp;&amp; hstateen0.CTR=0" here.<br>
    <blockquote type="cite"
cite="mid:CAP55G9AAF9wwPEkNdG60Mnie8p=f-+ZzcjDBJU_RCSL+KSU77w@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div> </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            &gt; +    riscv_ctr_clear(env);<br>
            &gt; +}<br>
            &gt; +<br>
            &gt;   void helper_wfi(CPURISCVState *env)<br>
            &gt;   {<br>
            &gt;       CPUState *cs = env_cpu(env);<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------esDCZSjtOl7U0B6dlI5nl9mD--

