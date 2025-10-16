Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18DFCCD185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Ffs-0005aR-2F; Thu, 16 Oct 2025 00:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Ffp-0005a2-Da
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:33:09 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Ffn-00058s-9Y
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:33:09 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63bdc7d939fso497953a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760589185; x=1761193985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEjVX264IWOErwB5vI/hxKo38hRotuf1v+O/x34iGJM=;
 b=WtOrygC+C3wFhvaJcmJXueDkQrdJOcZ15BIWPxpalPM0t3y+KIg1r4laapbuDwav+s
 ByhvrHclOqvbYl46bRb/OfuOjtq44SKmawyIa2imAKMU8H2ARzfUj8RV8ar7E0yWnJa2
 QmQ9bpfMepz523Zx1R+tbqI2DcW2BC0ExFFYe4EQXhaV5Mn54ZEO9gGqVVXmlQ5EV4YR
 E08cT07Y+h75wvxd9hxNFOrysA5+tpVuM7AoFfEUH8/4AMqAB8R3vrLs69jQI8k7ZMu8
 I+2c0uVoJnRRthexQ6GL8s+3rCI2NgRvDXYhdIcdSeiNywa+nkMzXkwOlXO4eqkSipm8
 YYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760589185; x=1761193985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEjVX264IWOErwB5vI/hxKo38hRotuf1v+O/x34iGJM=;
 b=TdaODY48shRvHl/s/RWBFZF+V1daPuDJt3dF6fxAWjmdIMOgLwzkJvWKepkK9tJ2+d
 PEzifDFXGg3QNuVxnw3zxvVHuenGPxBc8+fxtqw0afDWpJWWi3fjswLnfAzjqrzdKAD4
 tXAB4PThLIJeYL1md7ffmxVuRbLLCPlIG8lSFnQQuaTQk/r9aju0I80oxoXZR58pZQTI
 rP126tH8JPHEeFIyNBZ53sHpAI5/yhgboVRqGg+E7ZdpoQFQx7bN/Lr4izvQsk2uBf2k
 Vm4fnDF4r4BBJwIaQDpKIoJt6BHS59x2SKF+7Af1icf82LqOpwDD3/Nwp3HRiBFTacrl
 dFiQ==
X-Gm-Message-State: AOJu0YyTOFrQBpJRXDkLYrE6ZwqwKNn1ArnSk15AaWmX+WysDpujbjIv
 5mOAM+tDs+vSHfQ41pgDlbnvByttnJ7jgXl9J6QfIjULyKRz/t/xW6fEbHjD3Nz7hUmSL6EIMiB
 ffU/LVkQ4dXN+QYPNZuf9kAFzXDuk22I=
X-Gm-Gg: ASbGncubEf1fR1ViOtp1TdMSGuRzYcupylcjmaWo02tqUm24+gfbCgMHtbiOhW5yq1X
 xt45dM8XP2xouGllRzfHO+AmwhgmhumfGhcEpF/Bnv4qo5X0ocqOey5cGkTRq8V3jIqhmSZxmFe
 dEsk0qLCAEnYzZ81th1dbQ6dJ6wJYEA8G1n/OcZI74S6PfS/7W6W68WHH96sFYxbPDl9TahYc7X
 8yqIvNozOl/g7fQU+59OfjAghbgCu3PsQf0RiU5ukw6jnKR2oD6bMmKzm7bkuAMKwBgpbmtEj5j
 E5pKA8rPfM6+jeI=
X-Google-Smtp-Source: AGHT+IFrWOsv9xHqS9AfBKl8w69QR+o1LArppkbgqLa4QSfUDcb7AYtZ2F3Iic50F7ijDH+1EQKyrTBrFFmhDOa1Zbo=
X-Received: by 2002:a05:6402:440d:b0:639:dd3f:f27f with SMTP id
 4fb4d7f45d1cf-639dd3ff812mr24772918a12.4.1760589184861; Wed, 15 Oct 2025
 21:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-11-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-11-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 14:32:37 +1000
X-Gm-Features: AS18NWDluORhakQF5lY6Vnc_CHdrLPoq6buw0YBSt5uu7DU33OODikC9mK9HERU
Message-ID: <CAKmqyKOBjTHm-gvnd-USSKBNDS1gu_4FsVOGv8VpJ3rJ4XF5Zg@mail.gmail.com>
Subject: Re: [PATCH v3 10/34] target/riscv: Fix size of gpr and gprh
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Oct 15, 2025 at 6:36=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> gprh is only needed for TARGET_RISCV64 when modeling 128-bit registers,
> fixing their size to 64 bits makes sense.
>
> gpr is also fixed to 64 bits since all direct uses of env->gpr
> correctly zero extend/truncate to/from target_ulong, meaning
> !TARGET_RISCV64 will behave as expected.
>
> We do however need to be a bit careful when mapping 64-bit fields to
> 32-bit TCGv globals on big endian hosts.
>
> Note, the cpu/rv128 VMSTATE version is bumped, breaking migration from
> older versions.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h            |  4 ++--
>  target/riscv/cpu.c            |  2 +-
>  target/riscv/machine.c        |  8 ++++----
>  target/riscv/riscv-qmp-cmds.c |  2 +-
>  target/riscv/translate.c      | 17 +++++++++++++++--
>  5 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 09d9e4c33c..7573d5aa7e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -212,8 +212,8 @@ typedef struct PMUFixedCtrState {
>  } PMUFixedCtrState;
>
>  struct CPUArchState {
> -    target_ulong gpr[32];
> -    target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> +    uint64_t gpr[32];
> +    uint64_t gprh[32]; /* 64 top bits of the 128-bit registers */
>
>      /* vector coprocessor state. */
>      uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a877018ab0..b7690ac00f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -583,7 +583,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *=
f, int flags)
>  #endif
>
>      for (i =3D 0; i < 32; i++) {
> -        qemu_fprintf(f, " %-8s " TARGET_FMT_lx,
> +        qemu_fprintf(f, " %-8s %" PRIx64,
>                       riscv_int_regnames[i], env->gpr[i]);
>          if ((i & 3) =3D=3D 3) {
>              qemu_fprintf(f, "\n");
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 09c032a879..7349383eab 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -177,11 +177,11 @@ static bool rv128_needed(void *opaque)
>
>  static const VMStateDescription vmstate_rv128 =3D {
>      .name =3D "cpu/rv128",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .needed =3D rv128_needed,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINTTL_ARRAY(env.gprh, RISCVCPU, 32),
> +        VMSTATE_UINT64_ARRAY(env.gprh, RISCVCPU, 32),
>          VMSTATE_UINT64(env.mscratchh, RISCVCPU),
>          VMSTATE_UINT64(env.sscratchh, RISCVCPU),
>          VMSTATE_END_OF_LIST()
> @@ -429,7 +429,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>      .minimum_version_id =3D 11,
>      .post_load =3D riscv_cpu_post_load,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> +        VMSTATE_UINT64_ARRAY(env.gpr, RISCVCPU, 32),
>          VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
>          VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
>          VMSTATE_UINT8_ARRAY(env.siprio, RISCVCPU, 64),
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.=
c
> index c499f9b9a7..95fa713c69 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -262,7 +262,7 @@ static bool reg_is_ulong_integer(CPURISCVState *env, =
const char *name,
>                                   target_ulong *val, bool is_gprh)
>  {
>      const char * const *reg_names;
> -    target_ulong *vals;
> +    uint64_t *vals;
>
>      if (is_gprh) {
>          reg_names =3D riscv_int_regnamesh;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 6fc06c71f5..4308b7712e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -27,6 +27,7 @@
>  #include "accel/tcg/cpu-ldst.h"
>  #include "exec/translation-block.h"
>  #include "exec/log.h"
> +#include "exec/tswap.h"
>  #include "semihosting/semihost.h"
>
>  #include "internals.h"
> @@ -1428,12 +1429,24 @@ void riscv_translate_init(void)
>       */
>      cpu_gpr[0] =3D NULL;
>      cpu_gprh[0] =3D NULL;
> +    /*
> +     * Be careful with big endian hosts when mapping 64-bit CPUArchState=
 fields
> +     * to 32-bit TCGv globals.  An offset of 4 bytes is applied so the l=
east
> +     * significant bytes are correctly written to.
> +     */
> +#if HOST_BIG_ENDIAN && !defined(TARGET_RISCV64)
> +    size_t field_offset =3D 4;
> +#else
> +    size_t field_offset =3D 0;
> +#endif
>
>      for (i =3D 1; i < 32; i++) {
>          cpu_gpr[i] =3D tcg_global_mem_new(tcg_env,
> -            offsetof(CPURISCVState, gpr[i]), riscv_int_regnames[i]);
> +            offsetof(CPURISCVState, gpr[i]) + field_offset,
> +            riscv_int_regnames[i]);
>          cpu_gprh[i] =3D tcg_global_mem_new(tcg_env,
> -            offsetof(CPURISCVState, gprh[i]), riscv_int_regnamesh[i]);
> +            offsetof(CPURISCVState, gprh[i]) + field_offset,
> +            riscv_int_regnamesh[i]);
>      }
>
>      for (i =3D 0; i < 32; i++) {
> --
> 2.51.0
>
>

