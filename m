Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5159E68940
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 01:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Jsh-0001UG-Jz; Wed, 30 Oct 2024 21:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6Jsf-0001TQ-Cm; Wed, 30 Oct 2024 21:21:45 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6Jsd-0005yY-NC; Wed, 30 Oct 2024 21:21:45 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-84fd764f6ddso231744241.1; 
 Wed, 30 Oct 2024 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730337701; x=1730942501; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=me1PbElHIFNOFiPEPF4cHrVfyBn29FNW2l/yCg+EcOE=;
 b=dzYQ+ZK3g94/eIDjG4T9z6MEHnfYSJAoTYM98fiGuEdKZHXX+OY7YTPLh3/+nxqztr
 dg0z//wRLnosU/+zKwpzBnkYV6A7ui0V4HsLu21cE6Nu0vJUiLes7P0GZc/Ht1AjAwzK
 ngaodXq19HGXa+CFzUFHOFzoB9gxRPKZXWNbpFQgNon5hU3V30T1zSZFoYnCKhRJEmMO
 D9/Au6MLaPwSbcuNKZXS4Wh6UIplK0NPHJgOzDOSGIQwdvVppUthOX1Vd2jpSAKnRK8Z
 S2RvvYGT7G6fKDtzANcL6aUk0VyvvSeW4KK4FDqpOr+uZkGMAPpeMlO1BbehO0CE0EBK
 qBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730337701; x=1730942501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=me1PbElHIFNOFiPEPF4cHrVfyBn29FNW2l/yCg+EcOE=;
 b=OewVBscLLv32dbkEd/qSqbXkWc/XbeNJdbMIdET9deh7o+3QjfHwh3heQHpke1N4RP
 2zxGe2qsqH3mWdKo/4li4n51M+VOSlfAxwmS8GFO5+aHTAO3cHE3FNP0KsblDvCHXcr3
 q7MbYjzV7vMO7GpRtBopIS4kEU9Ig5VmiFX38UeG49q9Inp+XeQmMAWk90S6Ky2YsBdM
 i/agOt/MDm+LEfE0prVN25udkbsQHRC3Ck2v6oSGYpkUUqZKVT6/v+CqlaMPYQGnZfOT
 CrhjWyTcOz+yp/3CJyIU7/wKf3qVynsrvJHxT8tGOjH4r7YmSocdg9zr1pPQudmlmlIn
 2Zvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyvq7+9lddwSzJyVqMh5Pulq8VDFCHk3rhwxc/Ew0qN+tKR+kVD/GUi1suP/i9fV0ftVnMNip30QPW@nongnu.org
X-Gm-Message-State: AOJu0YwbqwNShnvTOFRVpJRVHuLDtTMycdgNvOqoeWdSitJ9unQqiuAP
 PR/5WzEznTQVwMqvFG10nsT+b8RpNexhdHiGE6XdzcSWHW/zFqhu6Q4iVv1r9hL+pJF2mnQOdhK
 26V5u/epEalueohBVez0T7C53I/Q=
X-Google-Smtp-Source: AGHT+IF5A766HQ+YU30VPRPbzjxT2WXSK9MH6VOumIZuhev6a5kYcfc+yviKxYh3oaaOISJ63tsYT0AAeblS+wDCBVE=
X-Received: by 2002:a05:6102:cd4:b0:4a4:532:82bd with SMTP id
 ada2fe7eead31-4a956ccb44cmr532616137.4.1730337700654; Wed, 30 Oct 2024
 18:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241030043538.939712-1-antonb@tenstorrent.com>
In-Reply-To: <20241030043538.939712-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 31 Oct 2024 11:21:14 +1000
Message-ID: <CAKmqyKPb=0EVH2OzYGc45QcAimwzqYje9co0dQceiu3Bp9t_Hg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Fix vcompress with rvv_ta_all_1s
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Wed, Oct 30, 2024 at 2:37=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> vcompress packs vl or less fields into vd, so the tail starts after the
> last packed field. This could be more clearly expressed in the ISA,
> but for now this thread helps to explain it:
>
> https://github.com/riscv/riscv-v-spec/issues/796
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 072bd444b1..ccb32e6122 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5132,7 +5132,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, vo=
id *vs2,               \
>      }                                                                   =
  \
>      env->vstart =3D 0;                                                  =
    \
>      /* set tail elements to 1s */                                       =
  \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);            =
  \
> +    vext_set_elems_1s(vd, vta, num * esz, total_elems * esz);           =
  \
>  }
>
>  /* Compress into vd elements of vs2 where vs1 is enabled */
> --
> 2.34.1
>
>

