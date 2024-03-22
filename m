Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA2CC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWhk-0001HY-Hi; Fri, 22 Mar 2024 00:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWhg-0001Gz-6x; Fri, 22 Mar 2024 00:40:28 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWhd-0002Z9-Va; Fri, 22 Mar 2024 00:40:27 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-47651248841so623701137.2; 
 Thu, 21 Mar 2024 21:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711082424; x=1711687224; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDHl2yauJqt1d48HLbyKqzmBYTK/zQq/CJxEkazNqR8=;
 b=ZJasr2Ak7KAWjnvAYAhdjtND2oiAvA+WC0vZIbKrb/6jrTsvHre0AZxWHUw8V0vgtQ
 7KG27QGbOsY26DYLzhPywuFEh1p+ZPfcQwFOnZcQJ84wz64Sfq/wFEKVipwgzJHz5Iad
 pb7jMKCn/SHh99AFNGr4m/eM/qg6VKWSqSGAG/hfTthjr73FpiSlpw7AMvnKLqT4S6iJ
 9PMStMTW8gqWlYGu4p16lZMWiPgi0Z5O3AI4UtzSccC7F57bNT+24uXq0sUDvzeosESj
 qSqQfvMIp35R2z0DMgwGVVxzgdVmcxIDwayYSgx22Fa737lqzLPocXXeZVMuv6nsyfZR
 NprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711082424; x=1711687224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDHl2yauJqt1d48HLbyKqzmBYTK/zQq/CJxEkazNqR8=;
 b=anXwkwwyxNUWBmdz4kI69+7/78muinzVTMqYnXCLtTaFItijRjve5WIeu+6YwgeLxD
 ncwPplJpyTyVZ/32WWr6x5ALeALmE/EcsP4Mm9ms65POaaKjP83SjPrD7WGVSFzdQhKR
 s1tz2GgkzVwKcZMnGVhCjSC54DYSr1oxfaI8/8jhs5Qu7EYW65XUarrc+aYN9pHCBphB
 Ou75kLCzNiqb7LFjM2Bw1EJk5z/gj/E9fN+qbajc6HEmfEPFdbnEDaqzI2EYjx0oEe+L
 VDsMYr5bQRAYIwHc7Ez4u8YDFiWA6O6a+QhAzPqxWoGX5j6qc/2sajO+o/ssWqJ5br36
 ni2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJW32DEcog6WDcafzshQzakKO+9AKL4/Gg/DpD3QsHIwVhvi4VIU4Fosg8odjmC/SR9KLYO8XlX83CGXHWkbsvwizEqPc=
X-Gm-Message-State: AOJu0YzBzt+UlMG7/C8BUXxxKCPuIgqszBKOAOdewuJUzOAcRmB0miqy
 vlZKa68h1mbza0oBij/5S+/CP6ER2KBgM4aMfrlD5zHHxNtWjdQxzcG8cZC+ynftc5xoMNdjExi
 kysOPBg6Rpvt4dXpIegN0ublKl5E=
X-Google-Smtp-Source: AGHT+IH/Yo+haxcOpuUE86rnV96uUnOFcNEdispDpywSONOhVHgW2BW1eOot8xAZGrg9VLtpeZipXQSxS7eU6cZ6LaI=
X-Received: by 2002:a05:6102:116f:b0:476:a1aa:2894 with SMTP id
 k15-20020a056102116f00b00476a1aa2894mr1209893vsg.35.1711082423041; Thu, 21
 Mar 2024 21:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240320172828.23965-1-irina.ryapolova@syntacore.com>
In-Reply-To: <20240320172828.23965-1-irina.ryapolova@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:39:56 +1000
Message-ID: <CAKmqyKO9Dm1nc5yPXVR2vK1fJHzrcecp6qmzsNzJpzwYhPfpYw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix mode in riscv_tlb_fill
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Thu, Mar 21, 2024 at 3:29=E2=80=AFAM Irina Ryapolova
<irina.ryapolova@syntacore.com> wrote:
>
> Need to convert mmu_idx to privilege mode for PMP function.
>
> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index ce7322011d..fc090d729a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1315,7 +1315,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>      bool two_stage_lookup =3D mmuidx_2stage(mmu_idx);
>      bool two_stage_indirect_error =3D false;
>      int ret =3D TRANSLATE_FAIL;
> -    int mode =3D mmu_idx;
> +    int mode =3D mmuidx_priv(mmu_idx);
>      /* default TLB page size */
>      target_ulong tlb_size =3D TARGET_PAGE_SIZE;
>
> --
> 2.25.1
>
>

