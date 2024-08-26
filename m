Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE11C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNTK-0006qZ-6J; Sun, 25 Aug 2024 20:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNTH-0006p8-Gl; Sun, 25 Aug 2024 20:20:35 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNTF-0002c2-0w; Sun, 25 Aug 2024 20:20:34 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a45bso2013100a12.0; 
 Sun, 25 Aug 2024 17:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724631631; x=1725236431; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQmMC052FmJ0ZvWouc9Fla0xmn9AXnIoTBaftp6rlk8=;
 b=EvAXo6AyJ9l+Vmw3KdfZCHG4yLFiuP5PYmY7szoFLOVoKQSuRI+vQ/JRevPKSHsVFt
 Z9NY5Hy64NVY7aIE8N7l+9uJ+5SBzSG6jcZCin0inxL0LjBcDHqb29QPjdzVFCzxBXG7
 7Se6PoRaD2MN3B7/fsU98bAOcVtm8xFxvpcbhpQpWMXlG7L8aVnhn8pfwEWn+bOleq6e
 KL7vX7dRsU0AI3zEk55WkPMibxrV/RjdnptLTR2TmiK0HCfrCy9o8CtRqBW4qtFQH0zr
 AleuJBYUfpbBcqKYNeAVuaDHXyiE7tYvvHaEhgWLxpyeCJbjrdFLRTXdlK0TvDcT1Qno
 DdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724631631; x=1725236431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQmMC052FmJ0ZvWouc9Fla0xmn9AXnIoTBaftp6rlk8=;
 b=Cy1+dTVM4V4y7ZC8Qo/3tmKGVuX5JBrlWKc699R3++wVpE9P160YQ/jCVit27yL+4s
 AHIOT2lUtIbGXVKgjNV3pxKvpmf5juh7d1onoUls4wQ0ei8h0Rz9kIdLW1nkV6Xq7kOm
 5fNI1zeCiE/PBHF0UtzTDrR4cMsFhMWRAeZBiotkvUGUn/qfmqTZuf5AUSNg+GtSSaCJ
 btHJgBNaU8vrhZ/CIoVcQKmi4WCL8y/rMFNp2eUeUJA9f63qx9GDwZhxd2cZB2brVQsO
 rhnvrzIiu90MaiuLDkBQyjXUV/OM0kEPYrFT17JNjolbDtksG4ZiYb78gyquNUjlVcol
 XzSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA/aVHr/GLIC5G2zSQwT2/Eov2qTDFT5WZgXpwy6Uld2vWKMI4ryKjtsU/Mg2E+wgDYHVnXdhCzfRq@nongnu.org
X-Gm-Message-State: AOJu0Yws33kcvXPG089f9hAka7Eo4mz0SsiKXkzWWp1NGXVQvl8Oxdhv
 Wlw7wtcqybbGktwEgY7CRAcz36zmaxYGGcynCmNiggwpF4AopzpaIFgeiiuRTj0ErtwwzdG8IpQ
 8NglNrihzzSVjrn8VzkB1Nn6Fme0=
X-Google-Smtp-Source: AGHT+IHsF8zYD/qnnXWPxGgSDxnQMH3WEc4vdgEiMcInY++tsEY/+vSea1aaXRV8EQCqnabKSN+2qMj2UbwjqrDu0TI=
X-Received: by 2002:a05:6402:510f:b0:5c0:a8bb:e7f4 with SMTP id
 4fb4d7f45d1cf-5c0a8bbe83dmr1751145a12.30.1724631630707; Sun, 25 Aug 2024
 17:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240823063431.17474-1-vladimir.isaev@syntacore.com>
In-Reply-To: <20240823063431.17474-1-vladimir.isaev@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:20:03 +1000
Message-ID: <CAKmqyKNuMpc42K6rFntGiN7Utn+9zgVW3Cio6-tLJUVgB31nnA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix za64rs enabling
To: Vladimir Isaev <vladimir.isaev@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Aug 23, 2024 at 4:39=E2=80=AFPM Vladimir Isaev
<vladimir.isaev@syntacore.com> wrote:
>
> za64rs requires priv 1.12 when enabled by priv 1.11.
>
> This fixes annoying warning:
> warning: disabling za64rs extension for hart 0x00000000 because privilege=
 spec version does not match
>
> on priv 1.11 CPUs.
>
> Fixes: 68c9e54beae8 ("target/riscv: do not enable all named features by d=
efault")
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3bace..07a7af59b6d9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -115,7 +115,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> -    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> --
> 2.45.2
>
>

