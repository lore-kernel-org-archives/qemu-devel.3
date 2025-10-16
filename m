Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A7CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9FxS-00023s-1k; Thu, 16 Oct 2025 00:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9FxP-000220-9P
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:51:19 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9FxK-0007PS-OA
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:51:18 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63bd822b007so398112a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 21:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760590272; x=1761195072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2/Mm3BGJkea9gkIMjLqRjS8NYnBoJgs/2CkzViE15c=;
 b=cDFzBfHQ2K5ImS+ChrWYTtFM1wbE4N/30gdsox7AINkP8c7PrKy5QTUsUcdyiZiNpn
 azzh2bfDIT5yE23VjEW1DtOTIjjDqdayql7KADgipJ3qpV7zzz7x4LjvGCCA+dxfyUEU
 FfWffAIbxfafOv9FUlXFARU9G8saFwzTbzrnqTYfDdj39GTKgZakGXu4xiqTgwKBVDcf
 93CTU9dkB21bU+B5sNFHlB7DzGzUsBrZ0Udy0FSYjt0yHr1VUAJT1YeLSwwogPKa9wL3
 M5ajI5vLsymkMJtRYgqquSIJ1Nix+thsWp0cGvNu1YV43alQwkAS0YvXvf4LkEArdm9/
 cjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760590272; x=1761195072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2/Mm3BGJkea9gkIMjLqRjS8NYnBoJgs/2CkzViE15c=;
 b=FagpyumlpkKJZErFpJ10Syw0SGNqKCy5nQrcwI/DJsip6pfVa7gxG2oXkdTU9QKebg
 eLV/ObYjpBuNvK6P+1efzHpUtU4azYWurtI592Glz8TVx6Fx0+OhuzOngr81+9jXRmne
 UCz4B5KF7uDS/XjSWnmSN8hEOQRcKZamXL/B3x5FN+fcg1LBdzRi6nNYkX86OhHsdmBe
 s8nPOaNs18/qjqN16EG/HtvOZVfM2JrWvviufEy/ybuEa97mByHzLFYx2tphs+vgNYCe
 7XY6mdBT0mIl8AqhVEYVobNbJopBK782DIus6dgw3TilcLVJcLWOilUl9NR0dGZgduI2
 wNZg==
X-Gm-Message-State: AOJu0YyMHdnUmStxSbJGvvG/7JgkpzJaFn1tft+lHU/WmYXf19b+8iMi
 YxeBdokU/qivitSWYMoLZbWyS0Bxv91cnPnB/EOwqR0/ET4Q6lsrEq2Da1wKzQVM4JsIN8RlpZ4
 jzQkXTKZ6lIa0GBqHf8KmqFEOAaucNAA=
X-Gm-Gg: ASbGnctbh1eso15zRcsq+Nb9By12A/rcZx4fWB9RbmHLJFeES9cg86MZ8pNcYZIUP34
 FWxC+5PI0Dv/UngpwJFneih8ts57EjOo36c8kEE/g6z9Io4wlau+8ExaeLyJ6RtP3xry2aV0HJv
 ZgXc0C+4NPvjFOxYczyTZhKWE0Hsj4hAFw/UkZpQX1EKhZ2dG42zFZhyfwCeLZsfSiq0DZO415p
 lBtHg5MXqCJSqGDYaiQo/jrzKOU1GLINoQ5GSgQiiwNEFwKW1+NiW+T2XOet5vSEgmW+vEko1Bm
 lz3bpMs+iLbIMMbZlprUdFQ9qg==
X-Google-Smtp-Source: AGHT+IHTzS5x6MdA7Lil7Y/uHEZlp0ftn8/YC18FGpTuUnh1RVj8n+0zbOeWvZ/K30e/4Cj8bRvcvirAf4mIWdNLWPk=
X-Received: by 2002:a05:6402:84d:b0:632:67ba:f9b3 with SMTP id
 4fb4d7f45d1cf-639d5b6ae4dmr27133067a12.11.1760590272406; Wed, 15 Oct 2025
 21:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-16-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-16-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 14:50:46 +1000
X-Gm-Features: AS18NWC-P5xENnL1PxqW93x-jrLASX9S2qQ7O9sMSujkyMzXaVRgqdVCyWfYesU
Message-ID: <CAKmqyKMkyyp_P1S4rfAgc9ytTt=53ib-D1uMxbPcwgSCfegcGg@mail.gmail.com>
Subject: Re: [PATCH v3 15/34] target/riscv: Fix size of guest_phys_fault_addr
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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
> Widen to 64 bits, and use hwaddr as argument to get_physical_address().
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 2 +-
>  target/riscv/cpu_helper.c | 3 +--
>  target/riscv/machine.c    | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8c93030b1c..bcf10a4c8b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -236,7 +236,7 @@ struct CPUArchState {
>      uint64_t badaddr;
>      uint64_t bins;
>
> -    target_ulong guest_phys_fault_addr;
> +    uint64_t guest_phys_fault_addr;
>
>      target_ulong priv_ver;
>      target_ulong vext_ver;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 5a20596f1f..7790244d93 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1186,7 +1186,7 @@ static bool check_svukte_addr(CPURISCVState *env, v=
addr addr)
>   */
>  static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>                                  int *ret_prot, vaddr addr,
> -                                target_ulong *fault_pte_addr,
> +                                hwaddr *fault_pte_addr,
>                                  int access_type, int mmu_idx,
>                                  bool first_stage, bool two_stage,
>                                  bool is_debug, bool is_probe)
> @@ -1787,7 +1787,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>          ret =3D get_physical_address(env, &pa, &prot, address,
>                                     &env->guest_phys_fault_addr, access_t=
ype,
>                                     mmu_idx, true, true, false, probe);
> -
>          /*
>           * A G-stage exception may be triggered during two state lookup.
>           * And the env->guest_phys_fault_addr has already been set in
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index b047321073..27034180c4 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -438,7 +438,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINT64(env.load_val, RISCVCPU),
>          VMSTATE_UINT8(env.frm, RISCVCPU),
>          VMSTATE_UINT64(env.badaddr, RISCVCPU),
> -        VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
> +        VMSTATE_UINT64(env.guest_phys_fault_addr, RISCVCPU),
>          VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
>          VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
>          VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
> --
> 2.51.0
>
>

