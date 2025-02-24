Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E38DC021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPPi-00013z-9p; Sun, 23 Feb 2025 22:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPPg-00013R-6P; Sun, 23 Feb 2025 22:45:48 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPPe-0006Ak-JV; Sun, 23 Feb 2025 22:45:47 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4ba00b6821aso1230073137.2; 
 Sun, 23 Feb 2025 19:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740368745; x=1740973545; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KpLWq/64rPav57VwXj8P2tYzG2ayd0sQOAXHzzw1mo=;
 b=WWa0KPuSP0k/AvD1dqRYDULwecUtqmZ6+EO0P1AlZ1IDdWilFErsOLF6E/pY8CQShT
 AdJlnZ5ezejLgkO28VKth/wGaKGfQcR2hGVdqERCC0FNaFacwEBXUpwjy85WdCgfYCth
 FhepQ318Ij4dMB8A4l/LjIDr8eFC85m1OZ3W6qJAkyY1Ne5vkYa3xWqcwJpB6jWdTJ0m
 THW2dtCDHeHK82o9cxbYWvpo3o8OgTtBTAi3rdYPQCgDI34mq5Wto/5qSvpfgGXNpw2B
 iX5agzArnN6F8Crkj9Mlquj/gr/lpxOX7ZoAwLJcuZOfIiZnvIpq55MhotveHgIrrgZd
 I4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740368745; x=1740973545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KpLWq/64rPav57VwXj8P2tYzG2ayd0sQOAXHzzw1mo=;
 b=YhOvFiJpnOU0oV0suyAEzqJlaIat8Snic2XKyRACZqVC1JyOpi6Co7snPdxNwk5Dej
 HQ1HucjRDBnmvNvxkFkgAiIWgTH1ZSGJGNjKx3MvJ39mab1/5JORz23zwH2eeXd0dwh0
 JmI4GbmuFea9JHWSxppJ3ni+fdY7j8tF2VtmrDBLDj018jPNcDD0GWM8FipufROiAOKA
 WBdqyEX2Nvt8vmXnxJPJf0Bzu9vB1jQ5GcLml6liyiO8eSEhJ/7iIvf7v2Xj0dIWQtfv
 cJU8MFLIt0spW1uj5wyQiVylEZPdb3Ba9Bg3qXY2Yy95kEAhOO1Qj/H78Tpg22ULShXp
 kO4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK547DsKVO1J7i9V/k88FMNGEptMGJbXanIxg8gOyNQ3V7Sn3h7JBI2/cMr5vptI0kMw/B3W9F/3xq@nongnu.org
X-Gm-Message-State: AOJu0Yw7JZZyzk2TgGbbpLJG2wF8GqPAlW55aELOofqtT/ntZRqsPlBR
 BH7M3O/Ddq0JG/xgugewTCLUUlrNVkqk6Q9qJkl1MvCwlhEmVKYPs+uJb03Qu2JoURJD0ZugsoK
 5mQjvBpxrnfio0dJsybjOX/m74Q8=
X-Gm-Gg: ASbGncsMg0G32uqPomHCo9DYq2UzgrCFF9pHurjNPVcst+mFWZdpCWwefdJw4NE/SUZ
 bwvCgXflXjuvVBEu1eFWuyrcKIr+aq6ZfsN1mRITMDIOGd0enjI4x6pwijZDFGAzAOxEVH6BWk6
 ctjJU+0thdmI/Rzq7W8wQkThSpCntxibDUm6q+
X-Google-Smtp-Source: AGHT+IE4gQKAVAp+RqWzU+TjgJoiDcMUo2yNJWgTtBMPUkDqFImTroMMqGr7DbeeVokszDXtux5wbHANWpT1+8WkUrM=
X-Received: by 2002:a05:6102:e13:b0:4bb:c527:aacd with SMTP id
 ada2fe7eead31-4bfc29545f4mr5043514137.23.1740368745177; Sun, 23 Feb 2025
 19:45:45 -0800 (PST)
MIME-Version: 1.0
References: <173856049155.9683.4580810619712230382-0@git.sr.ht>
In-Reply-To: <173856049155.9683.4580810619712230382-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:45:19 +1000
X-Gm-Features: AWEUYZltmVkI2gH6_9ULR_mdD6yHOU__RJG34hgVy9_rE2ZP5GswOGfYt1s80Zw
Message-ID: <CAKmqyKOOoYpdJVDk=7+iehteoOrPsHJ4FSWqqHAeWK3HiC0GHw@mail.gmail.com>
Subject: Re: [PATCH qemu v2] target/riscv: Check ext_zca for misaligned return
 address of mret/sret.
To: "~yuming" <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Mon, Feb 3, 2025 at 3:34=E2=80=AFPM ~yuming <yuming@git.sr.ht> wrote:
>
> From: Yu-Ming Chang <yumin686@andestech.com>
>
> We only check RVC to allow 16-bit aligned return addreses. This will
> cause issues when only ext_zca is enabled without RVC: 16-bit
> instructions are allowed, but 16-bit aligned return address are not.
> We should also check ext_zca to permit 16-bit aligned return addresses.
>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
> The v2 has been updated to provide more explanation.
>
>  target/riscv/op_helper.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index eddedacf4b..891002f954 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -269,8 +269,10 @@ target_ulong helper_sret(CPURISCVState *env)
>      }
>
>      target_ulong retpc =3D env->sepc;
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +    if (!riscv_has_ext(env, RVC) && !env_archcpu(env)->cfg.ext_zca) {

You can just check ext_zca as C always implies Zca

Alistair

> +        if ((retpc & 0x3) !=3D 0) {
> +            riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC()=
);
> +        }
>      }
>
>      if (get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >=3D PRV_M))=
 {
> @@ -328,8 +330,10 @@ target_ulong helper_mret(CPURISCVState *env)
>      }
>
>      target_ulong retpc =3D env->mepc;
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +    if (!riscv_has_ext(env, RVC) && !env_archcpu(env)->cfg.ext_zca) {
> +        if ((retpc & 0x3) !=3D 0) {
> +            riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC()=
);
> +        }
>      }
>
>      uint64_t mstatus =3D env->mstatus;
> --
> 2.45.3
>

