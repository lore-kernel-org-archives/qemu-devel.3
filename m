Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38704CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Xf3-0007ig-RG; Thu, 16 Oct 2025 19:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Xf2-0007iW-Oj
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:45:32 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Xez-0003Bh-7M
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:45:32 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63963066fb0so2734140a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760658327; x=1761263127; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lx1uk/60Tdxx3rNJNTS6AjXxsJQGaQPtGp1pyBNcnU=;
 b=fT77Ap9W5W4PtJUiEdIcUTUXvgKfDKYtuki1bZVmX1BLp8P0InrhJY77KLrVI17YqQ
 CtoUjhVvNqLk3622GNBzdPMpgLgu5Lq8jz/63hXN/bPIZFc9A7+udB2okP0ZkQmBSPAC
 xgT5v8wOP+zGKZ+ib18DF1I2TbmzDSxbXqIdq8dUi9U3b4ee8zvJdqooB3iqpI4TMNJD
 NfFZHVAWKtT+KdnoUtmYbbQQnQ+SjQJnou8BBf4oJrXZIWHmW6xYAcRbPEncgHu9d0O9
 CaadgQoAJgt9oYY0oXfxyPJgSv7ELIG/80S3w0/0j/lUUIwFK7cqhBWXBYux9sjhk4wW
 Goaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760658327; x=1761263127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9lx1uk/60Tdxx3rNJNTS6AjXxsJQGaQPtGp1pyBNcnU=;
 b=OhZunQngtw3qLApFmt+r8/8SjfhVnNf62yJxtQS7y+Kssxk/SD9wPZaPmH8UHTruCA
 JpIZMK3HB7SqJLsm+OAoHOPm1pjs09lOa49NSK9g2j7gyjMB+5ZsIcmMDzWl4VWbSsUu
 HknGmP24PaVJ2vC12h8jATNR0CsggaFbjJTBeku04W5ucYQvCcmrEjCyHdoyJFklQVZt
 bpak7gwdXZryjI3fCyE7vZtxN1jQR2MdpUFmiPhS5pnSQ23dIoA0mVdoosY08SBCGqn3
 o/We7V3H8hRAHXfG1K8RiQBhz9V3biWIYYS+M35YaSkxOfMbZGC2vBeMauNnxORcbJG8
 x48A==
X-Gm-Message-State: AOJu0YwJpys5yBK7Xt4bJUDFZd1U65j3pSF/CWvFwxeJj6q+juOWY6Yq
 LvFeC+rddp2CBylPhXq08uzr5unNgE3JJZ8v3rfV/9akHTnFn5079+DIPdWwGu0xPLVlwoST/jq
 VOS9gSICU76zNHxjARG0DV7wczifFQKdy7g==
X-Gm-Gg: ASbGnctTs7FqBio+hZ64kpCtW0XVI2RJIyGbKO/tNl+J8XYgck94Re25zzIXbgMh75L
 CS/lFL6pqj8eu9GyCudAKbb6TBpjfGrX+ejNYAk8L7w4N+Vy2cqYFsMynUTeceK44803pTP9EBi
 /czw1J0dNbSFIa3ExFl5IDPB/G2/DqUrCJH4sgvwlaUUw/e/JVQgqNtpKrHHyQzvFYalehjJI5o
 7qCVauqokF1gyYWJnNWhCcKADWfBIRh7GSIfss1BVw4cw7IVBEUK2WelBKHIfDNPdn9umpwWX8L
 bnUT/1W2kAaegataPISmP/khTg==
X-Google-Smtp-Source: AGHT+IErZPCmCz5vavUlVFAuGMddvALMzwnJLUqwmrtkclKQf84x3fgft0u6JOiLVDIyepnCQiIrBOi/CCmgcjajNcg=
X-Received: by 2002:a05:6402:1471:b0:62e:e722:a3c7 with SMTP id
 4fb4d7f45d1cf-63c1f6345ccmr1590116a12.9.1760658327030; Thu, 16 Oct 2025
 16:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-17-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-17-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:45:00 +1000
X-Gm-Features: AS18NWAi54mzQ8ML3l3dcDo-WCLfnuNXvgWUz4DRe8l3Lo1nKMMe13oxVigfOHQ
Message-ID: <CAKmqyKO5q2k4UPE-nq+Yi=oHnyC67yJSCG5bLyOwh0DnnWqhOA@mail.gmail.com>
Subject: Re: [PATCH v3 16/34] target/riscv: Fix size of priv_ver and vext_ver
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Wed, Oct 15, 2025 at 6:37=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Fix these fields to 32 bits, also update corresponding priv_ver field
> in DisasContext as well as function arguments. 32 bits was chosen
> since it's large enough to fit all stored values and int/int32_t is
> used in RISCVCPUDef and a few functions.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h       | 6 +++---
>  target/riscv/machine.c   | 4 ++--
>  target/riscv/translate.c | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index bcf10a4c8b..6ed912cbd1 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -238,8 +238,8 @@ struct CPUArchState {
>
>      uint64_t guest_phys_fault_addr;
>
> -    target_ulong priv_ver;
> -    target_ulong vext_ver;
> +    uint32_t priv_ver;
> +    uint32_t vext_ver;
>
>      /* RISCVMXL, but uint32_t for vmstate migration */
>      uint32_t misa_mxl;      /* current mxl */
> @@ -799,7 +799,7 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *e=
nv)
>  #endif
>
>  static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
> -                                              target_long priv_ver,
> +                                              uint32_t priv_ver,
>                                                uint32_t misa_ext)
>  {
>      /* In priv spec version 1.12 or newer, C always implies Zca */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 27034180c4..1cf744c5f0 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -439,8 +439,8 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINT8(env.frm, RISCVCPU),
>          VMSTATE_UINT64(env.badaddr, RISCVCPU),
>          VMSTATE_UINT64(env.guest_phys_fault_addr, RISCVCPU),
> -        VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
> -        VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
> +        VMSTATE_UINT32(env.priv_ver, RISCVCPU),
> +        VMSTATE_UINT32(env.vext_ver, RISCVCPU),
>          VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
>          VMSTATE_UINT32(env.misa_ext, RISCVCPU),
>          VMSTATE_UNUSED(4),
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 2770c06413..14c8f1c6a2 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -60,7 +60,7 @@ typedef struct DisasContext {
>      DisasContextBase base;
>      target_ulong cur_insn_len;
>      target_ulong pc_save;
> -    target_ulong priv_ver;
> +    uint32_t priv_ver;
>      RISCVMXL misa_mxl_max;
>      RISCVMXL xl;
>      RISCVMXL address_xl;
> --
> 2.51.0
>
>

