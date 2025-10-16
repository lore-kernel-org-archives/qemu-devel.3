Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65A7CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9XC9-00087A-8z; Thu, 16 Oct 2025 19:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XC7-00086t-9B
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:15:39 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XC5-0008Dy-Au
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:15:39 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-634b774f135so2190765a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760656535; x=1761261335; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8iwmQfJdG0UJ70FaimHsnyJ7b2e/kcblKBr9RW4qGI=;
 b=GXHcM2xkbZEf/2qTHf1pNufbEIus8YszKVIIuD2ldRPrmB71xXdwoJH4pLJhP4eaxs
 FW1bpC3VGWynhnah9kB9KJTJsjljT7EBTYR+z0Z5O7HoV2IgAYZjCLXW5I5pLa0ML6gS
 DELzoE9SK9QfVfe0K/YAjP3oDoTvKvXjOr0jlPwVh/GRCa375posLbcLazvNX3U2PTrX
 Wk0cnecRtFm99WIK9D9dtTCNBSfQCnz1yai5Tm3TXCblsr/x7p6KpeQGLObtAP/lyGXx
 qQ+/G+pzaa0e6XeuPSN2oIqCKS+mUxh0hdTTcBE50zm+QWIYQEwh8FtS+Mpx1qgKLJBq
 6lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760656535; x=1761261335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8iwmQfJdG0UJ70FaimHsnyJ7b2e/kcblKBr9RW4qGI=;
 b=SgMXITZuSW+oeSU2XqV7pgzPtADFbAnGouJ0AVoDL1EjTf/eWubHh04tjsuAOL6EUA
 bTNaGCU+bTH9vcApSJrr23S19Z6WawQO7B2gzxTsBz6V+l56eTnItYTASn148PzTV6e7
 ZDCgyO/NXPG3/OCvGOAPOrZqJX6hQhda6syVCm1D5eO8frUBRbdXqz54l1Yk+udFm/Df
 m23fdr3HyXgwFP5XAD6WAB80r+/VQd6kA6PZWZr9fdagHXK34GvB77Uo5lVCAT8bkK7F
 xBD6cZSQ8riJwWZylBjaN4NzAxoZ4nOq1aiBoaXVfVvke0qVFTcyWnH5AHYzf6o4MLI1
 f5eQ==
X-Gm-Message-State: AOJu0YyKadz3NpSVg2GnZ0RB6NtLbD+a5vkzVPJr/YlDTTofgCEiaGrm
 m3HeylqX3iNYs+y/kgM5Ci1FBqHJwSA5Ef8T/YG2bIpC56ZbGwYUk8hZZCgV8PKjyBJ7aefvxnh
 wpQAelf67sPxkdoFwFWiR2GaJM9ikXaM=
X-Gm-Gg: ASbGnctwFjRSz9Skm4CqTsWBFHfwCsputec+7O+CWjHsDfKMpZzF90a+akDS8SjPGbc
 a3iixXLxKDNsBdCqbnPV07gV+jeVW6YdzZg3ZEX/Hn9JHuqLMJM/1bOANn5q4PYuLbOptgMkMQx
 A330sKeFqDhn7JCrYYQOlp8Eeyz7aNH7VUSkyTOs+G0O/jSV8JLpDV+1Y4LZWPCvpfhQOS2u1q5
 XRAMned+/a0RhmvR7rsFiKgg1TkgcDK+kE3QoKAUXj73tY+RKYOx3cqqJjhy6yWmiMf+xtr++P5
 gvUq8bARvI69BRhbYq0nWzMTRw==
X-Google-Smtp-Source: AGHT+IE2noZDtkEt79bnlTgJ6YUFrDjvrhYehXYanfcSL56sFCAlxOtKPVDe39uQy2TMnRV7FB9VjUiHoCq/hrtZwNE=
X-Received: by 2002:a05:6402:44da:b0:63b:fbb0:3de8 with SMTP id
 4fb4d7f45d1cf-63c1f66c61fmr1176384a12.13.1760656535406; Thu, 16 Oct 2025
 16:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-23-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-23-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:15:09 +1000
X-Gm-Features: AS18NWCYLlGENyIAOeQ63ArjBy0ws1rpZG6wjmCuNypVIYDAjBPpam-dXjIJzzs
Message-ID: <CAKmqyKMtsfT26tHiA6d7=9mAtybkixLHhfNnhjbR1eLymagngg@mail.gmail.com>
Subject: Re: [PATCH v3 22/34] target/riscv: Fix size of gei fields
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Wed, Oct 15, 2025 at 6:38=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> geilen takes the values 31 or 63, fix it to 8 bits. hgeie and hgeip are
> at most 64 bits in size, fix to 64.  Update relevant function arguments.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 10 +++++-----
>  target/riscv/cpu_helper.c |  4 ++--
>  target/riscv/machine.c    |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1d5d74f11b..f637ab476e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -278,7 +278,7 @@ struct CPUArchState {
>  #ifndef CONFIG_USER_ONLY
>      /* This contains QEMU specific information about the virt state. */
>      bool virt_enabled;
> -    target_ulong geilen;
> +    uint8_t geilen;
>      uint64_t resetvec;
>
>      uint64_t mhartid;
> @@ -355,8 +355,8 @@ struct CPUArchState {
>      uint64_t htval;
>      uint64_t htinst;
>      uint64_t hgatp;
> -    target_ulong hgeie;
> -    target_ulong hgeip;
> +    uint64_t hgeie;
> +    uint64_t hgeip;
>      uint64_t htimedelta;
>      uint64_t hvien;
>
> @@ -608,8 +608,8 @@ int riscv_cpu_mirq_pending(CPURISCVState *env);
>  int riscv_cpu_sirq_pending(CPURISCVState *env);
>  int riscv_cpu_vsirq_pending(CPURISCVState *env);
>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
> -target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
> -void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
> +uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
> +void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
>  bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 26c3c846a5..55c9e9ae29 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -662,7 +662,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *en=
v)
>      }
>  }
>
> -target_ulong riscv_cpu_get_geilen(CPURISCVState *env)
> +uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
>  {
>      if (!riscv_has_ext(env, RVH)) {
>          return 0;
> @@ -671,7 +671,7 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env)
>      return env->geilen;
>  }
>
> -void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
> +void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
>  {
>      if (!riscv_has_ext(env, RVH)) {
>          return;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index ce5e44325d..8a8f5be8d6 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -91,8 +91,8 @@ static const VMStateDescription vmstate_hyper =3D {
>          VMSTATE_UINT64(env.htval, RISCVCPU),
>          VMSTATE_UINT64(env.htinst, RISCVCPU),
>          VMSTATE_UINT64(env.hgatp, RISCVCPU),
> -        VMSTATE_UINTTL(env.hgeie, RISCVCPU),
> -        VMSTATE_UINTTL(env.hgeip, RISCVCPU),
> +        VMSTATE_UINT64(env.hgeie, RISCVCPU),
> +        VMSTATE_UINT64(env.hgeip, RISCVCPU),
>          VMSTATE_UINT64(env.hvien, RISCVCPU),
>          VMSTATE_UINT64(env.hvip, RISCVCPU),
>          VMSTATE_UINT64(env.htimedelta, RISCVCPU),
> --
> 2.51.0
>
>

