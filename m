Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA95C54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 00:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhew3-0004AU-MQ; Tue, 05 Mar 2024 19:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhew1-0004A1-S8; Tue, 05 Mar 2024 19:15:01 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhew0-0000Vk-5Z; Tue, 05 Mar 2024 19:15:01 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7dae66def19so2410081241.0; 
 Tue, 05 Mar 2024 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709684098; x=1710288898; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DdQBYrMrB8e8MCNnDxxYQ7R+aOnmnZ6e9O3nDxZdxU=;
 b=jqJFMDUsTy6LYDaaefyr9lEIqnoqtT1snPkorijNVLai7mzNIesRKLoiTFqQcowZy1
 8h4a4UWp26Czb15T36cxejUvrjoblERYRgT3D9oskJar3TZpjzh9bkBTsWbzg3kGB5Mm
 VvHhtRm2K+Dm3gQsxoczCs/U9PNl493VkzdMEUfRvOf56ArRmU2ZXtM3AUBqEhK6ynLj
 RhDxM6W8FOr0wq6LMfwt0BAO4MYBEG09v+gNKn+H9YOBefHQDWba+dAMxaBM9wYvFis1
 rdLfx5CANnmWLi/KstaL28uIzTic3cV8NxHeYjfMl+MbrYX0BisdtJicxdMMmgfD99Dy
 dAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709684098; x=1710288898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DdQBYrMrB8e8MCNnDxxYQ7R+aOnmnZ6e9O3nDxZdxU=;
 b=n3kredN72fe/VS0WEpySSvqL780xs9Axpape4VZMic/aNC3/Psv7bIj0NMCYF0n4i/
 NWlzxGmcTh/HB3oyl4uvls1mv6iKoGnuEUibHNwpyUKf68QNqv3zcPGPJmXI//C8thct
 Egc3BOFsff7NknivavBpQeZnTM23Rs0b904s0WotVvlNKXsRLUWOgcWChS18P3bLXBuk
 1z/DGpWzgh2aESvuRhp1rKKaamL6OvlRKH+Yu7fDPJbUpQBLzinnon537ZqbRXVcevxh
 e0tTnU/vLt8FwJGoYydtPhPGaD3coe87aSeBPrvzZbDntDut/wrcQbyoMpkh/ltBjlK+
 ZY0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCnhilFXrEraEUDNkbmUJ24FKfLT3J9sCZxBS1SfjVtxjnyhizl+zUslWqN1Oe15ZGz/9KejRO7BDZHkQK5iOYkWyl5xo=
X-Gm-Message-State: AOJu0YxoFmbU9ylSXL7kI6Dw1WjYVV/IKeL1NMIos91/+KNwTOT5sMCn
 T642XVjMgg4j5B9d4Mqcgwtb5uZ/WtdMWFaE71ILTHaZ9EOSYFW5b7rafRNtqHbdCqoTBqlvzX4
 9RDjw3/s4Zkr3w2qL2GB1NqsiymE=
X-Google-Smtp-Source: AGHT+IFd52yFaersRW47Y4UYU4+Qk2K9EeRi4JBrEhZakESlc/m5wT65/l3F/3auQVR5m343V1tKUCY/cg1ztC/wQbY=
X-Received: by 2002:a05:6102:190a:b0:472:6162:41c7 with SMTP id
 jk10-20020a056102190a00b00472616241c7mr3166009vsb.9.1709684098127; Tue, 05
 Mar 2024 16:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20240304191337.3101411-1-alex.bennee@linaro.org>
 <20240304191337.3101411-5-alex.bennee@linaro.org>
In-Reply-To: <20240304191337.3101411-5-alex.bennee@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 10:14:31 +1000
Message-ID: <CAKmqyKM17uFQKmV9vYQFVnwsg2athgs-2w5-O8y3ye+tsmupxA@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/riscv: honour no_raw_bytes when disassembling
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, 
 Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Tue, Mar 5, 2024 at 5:15=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> This makes the output suitable when used for plugins.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 8a546d5ea53..86028efea85 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -5192,19 +5192,21 @@ print_insn_riscv(bfd_vma memaddr, struct disassem=
ble_info *info, rv_isa isa)
>          }
>      }
>
> -    switch (len) {
> -    case 2:
> -        (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
> -        break;
> -    case 4:
> -        (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
> -        break;
> -    case 6:
> -        (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
> -        break;
> -    default:
> -        (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
> -        break;
> +    if (!info->no_raw_bytes) {
> +        switch (len) {
> +        case 2:
> +            (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
> +            break;
> +        case 4:
> +            (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
> +            break;
> +        case 6:
> +            (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
> +            break;
> +        default:
> +            (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
> +            break;
> +        }
>      }
>
>      disasm_inst(buf, sizeof(buf), isa, memaddr, inst,
> --
> 2.39.2
>
>

