Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9DBCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 03:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9F7C-0000y0-Ni; Wed, 15 Oct 2025 23:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9F7B-0000xb-1t
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:57:21 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9F78-0000rT-5E
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:57:20 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-639fb035066so377818a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 20:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760587036; x=1761191836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQo8QxU31WExo92KOPA8Ute1JF2mwln81IPJ/0BnwNE=;
 b=lYwlhSrPJBgHBdFWnBZ8ayVYjgWaTXsxwryNvXeHljWpVmKxSXdDlp9NDyPcL6y38N
 DrrPVH1gO/M+0lv98RXNEWAGcXQMTG8orOg0mZ1YX/cGzgDJRfAVPyQQpH7eI+lnzZ76
 JjDjWp99ZPVBseFDmlkwhCOKm8d7uxOeLZ+fbMKKWfAmMwC4L0+PsVFE7EUzyPpYF/u+
 GnbR5oPUCtQSFiR7wWwChA+veO7EVq1Pi784EQyy0SwGbn8lNts2nVplvOj8gPg10Gil
 8E29Hl04cvk2b/dFWs/GAWzkA+xFRvYFbXlmguksLEvJdrw45klig6NChqeO/jD1hOeY
 G1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760587036; x=1761191836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQo8QxU31WExo92KOPA8Ute1JF2mwln81IPJ/0BnwNE=;
 b=sEr65HgGX6Q/nN7QaUxsH0NCLPFDy2k1Ocq9LfVVNch30vRou3BiD6DFJzY6wbf4MK
 jVtGce2kWNUX2zWRYdch2F468Hyktv6MtRJUaMOXfMKPCL6I+aox2zyn8WP0YpBHFytI
 BrYg6AJ+vynL0sERv7JSlarBsJOEXF++gaNELo8TjMCdJVNvgBx8RlUPsT5wL2z8bKVK
 1aD2p8Af8dnXP5tbgIeBJNtO5HaUl/jrXlNJ4HttojtK+IPeJvzXVuNdEDu5IZdQaLx2
 cqdfMyrLu6CtFtjiK1n4jslB9Wc2EQD5TxzxGKnDd9xKJ6rFzqkowWLVJvn8PT3zOrQY
 dbxg==
X-Gm-Message-State: AOJu0YwOYUgAm1fI5OV3pHO9EmNhn7xx6aMWqKM/wDY7nDp5uctq6KiW
 9/fpsleroYvFgJMYpsmAUEdI7xcP1G3FdkSfIYkK8xPlAI99o/6AqwZypnCoG9/qk0ch5wGfLzh
 8XCRbMNIOxxDO1Bvg/zaKWGn0ByIDIhU=
X-Gm-Gg: ASbGncu5ABZ3HwSFwKCoHvy/xgqkfNjrtLmAtHYez8OoHXpuV0r9W+uR5A/25XsX8NJ
 Nzkd7mKJNZhWm1jEA/rTIVajD8kYq7Z6p4Oh0G8jNiYAisTCqrYIyhJiAibhPe0s6iQmFe4iere
 KSYKftT5dStiOCDbTd5VhTusLuKtY76QKGCJFqdRhTswzXoKWMu3os58W1Y/n9RhjK08iGzUGXs
 TBw5fh6mFsnvM5gJO2RrnZEF1L1POkAsSCIF/gIZcJAmbIANN7ig1VfzqnUDNLywie5BsheUW0E
 Q/mDO6wnTZAl/15XPB9LJBbNpA==
X-Google-Smtp-Source: AGHT+IFLUylw2HZqzilk4M+ogE7z9ZKTbXgxugbJdMBYN87SH0LnOpNt2XOeVZxHYwGURSasLufRzNrhjll2dsDRZwk=
X-Received: by 2002:a05:6402:2791:b0:63b:ede0:240d with SMTP id
 4fb4d7f45d1cf-63bede028c7mr4410862a12.4.1760587035790; Wed, 15 Oct 2025
 20:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-4-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-4-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 13:56:49 +1000
X-Gm-Features: AS18NWCP0ukh-B_afbpwqxMs9e1hntCx70BkWjVYsaZiiKiVPVZAwx0-ew1Zt1w
Message-ID: <CAKmqyKOn11JeXpTJ5ywWq5MCxxJMH31-n_Eq75fuebNO4DYkew@mail.gmail.com>
Subject: Re: [PATCH v3 03/34] target/riscv: Fix size of mhartid
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Wed, Oct 15, 2025 at 6:35=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> and update formatting in log.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         | 2 +-
>  target/riscv/cpu_helper.c  | 2 +-
>  target/riscv/machine.c     | 2 +-
>  target/riscv/tcg/tcg-cpu.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4b291dbf81..25f996985b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -279,7 +279,7 @@ struct CPUArchState {
>      target_ulong geilen;
>      uint64_t resetvec;
>
> -    target_ulong mhartid;
> +    uint64_t mhartid;
>      /*
>       * For RV32 this is 32-bit mstatus and 32-bit mstatush.
>       * For RV64 this is a 64-bit mstatus.
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 3479a62cc7..9d0683f200 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -2278,7 +2278,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                       riscv_cpu_get_trap_name(cause, async));
>
>      qemu_log_mask(CPU_LOG_INT,
> -                  "%s: hart:"TARGET_FMT_ld", async:%d, cause:"TARGET_FMT=
_lx", "
> +                  "%s: hart:%"PRIu64", async:%d, cause:"TARGET_FMT_lx", =
"
>                    "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=
=3D%s\n",
>                    __func__, env->mhartid, async, cause, env->pc, tval,
>                    riscv_cpu_get_trap_name(cause, async));
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index f6ca017211..ab0bc32e1f 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -450,7 +450,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINTTL(env.priv, RISCVCPU),
>          VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
>          VMSTATE_UINT64(env.resetvec, RISCVCPU),
> -        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
> +        VMSTATE_UINT64(env.mhartid, RISCVCPU),
>          VMSTATE_UINT64(env.mstatus, RISCVCPU),
>          VMSTATE_UINT64(env.mip, RISCVCPU),
>          VMSTATE_UINT64(env.miclaim, RISCVCPU),
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1150bd1469..db3cbc1625 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -487,7 +487,7 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISC=
VCPU *cpu)
>                  continue;
>              }
>  #ifndef CONFIG_USER_ONLY
> -            warn_report("disabling %s extension for hart 0x" TARGET_FMT_=
lx
> +            warn_report("disabling %s extension for hart 0x%" PRIx64
>                          " because privilege spec version does not match"=
,
>                          edata->name, env->mhartid);
>  #else
> --
> 2.51.0
>
>

