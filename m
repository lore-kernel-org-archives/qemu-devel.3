Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71262FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDeF-0004ir-Up; Wed, 29 Apr 2026 18:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIDeA-0004iN-FH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:44:46 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIDe9-0003Y3-2P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:44:46 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-671d60ef9c6so388037a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777502683; cv=none;
 d=google.com; s=arc-20240605;
 b=DqAGcmCAHxwJfXa7Dpv5863ipeEn+NWTYGlCj574i8SdeM8FMY70Rl/cfcp42UxSTH
 eme27XUNerKQEw03pTIab2TDpYt2aeTmPHi8m9Z7200WriHTal9ClBxyIb9ze+z+4ncy
 IP/YZkD6boPLakcOCVcnfsty2McglwMuB2OAKRAGwNcsP9AauGJHbglNrfaeGDy65U5v
 IW26jrVtZOqTQISbg5eGHkvPyA84lVzK/aclCV+79zpJEfVQpjmeA2GNzuGTxknsIkeM
 +rY85lnJBKUwps9EMZIwe5Ax1zS+maerkRA39Fu6UihvuNJ8iA4UxYylhy/g64nedk1/
 Y13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RiiQ7SkseF/vyn7oi0284dmw9O+9SWKp9s3A/x6rPaY=;
 fh=CefM2mkcbIZlauyiGchSn5p+7w/pPUSkW/+2JwnBawE=;
 b=NLApnFaTXrcGyH27CN0t3c5KCPM8QYh+bZOvCBit+pFmt9Dh24eTAR8M8rWFObAFUt
 q86rZc5sBAzGkYaxbFAEFOj1+r4qNdE42YiSZr3wySH84i55oAGrbWg9XJ20vbqK+Lfg
 6wMmODj4IOlD6hHxFfqHOSlcKgscJ1AnlhKSqiKA/B78+6mSmgax8eMR3hiU7/0jepvb
 gsZumsfPZwfU8XpuewoCVcZ12sJN6uKFwJCY19GizD7pwYFQYrJyQlDtpMZ8SfhQ/ogV
 oRR22cZCbOKNnTcDyexP+OypmKuCEmB+qx8bthlENZVrX8AaeMe4kuSecFhvvOQbNoG8
 QyJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777502683; x=1778107483; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RiiQ7SkseF/vyn7oi0284dmw9O+9SWKp9s3A/x6rPaY=;
 b=eTQC7xoQ20OdNHenvqBk92fi0AIz3g+Hrjoi9vysitMAyo39Kca+iTuSrliObbEGcA
 jGJ1TBwjDRt6TP6Y//P+IlToC9CUi793DQ1SO3S4BwAvKUrqwm6Ypb2b8+WCREBUPZ78
 QSiNRTusxddJb//kk4BF8pjcrtwndBvkL+/DCjR1UONNvmVdMHq07lACIIgHAxyb3zzA
 OKWUfrGfRnu8TK3oPujDIEDmVUyfqJxgX3l+aRMCNFNU6yX3wqY/nwf1mztwzSyXVviI
 tRy9/umgA4TulEeCYb0S5oH6/MXFtYpVgoEdZdxBVFgL8N48o/2tGpp01oYfRo5cL1K0
 z5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777502683; x=1778107483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RiiQ7SkseF/vyn7oi0284dmw9O+9SWKp9s3A/x6rPaY=;
 b=U9K/zajnt+X5abUgvPsXtPxeDRaLf4KCh0KNvj6iL74+pCNVK46QJOM4BkYvEMIGb/
 o+iHJqHNW0HBEEXJwYM4ozsUFLDTXEoiHBlgqVVqXzlbAIzeALXeNKoI5Jg8yc4mIPW2
 n1+MEgfsuHpPS/UAm0Xmwwm21VaTISqT+vGKO9NIvnVxLKgnomdmAbeLxeD+d16JlPdT
 8jLsXmvhELf0atF0s0gc+k5AyW5SNDEAevAcGRhP+2Ie1TCraqcDyb+3ToJkerbCIKVw
 UcGp7TKBsYkCxkAKwGyMCz4cTib3tJi3jVzi1ZOzYYQ5/By0tJdSraLmJorHTwVrw0eT
 pwAA==
X-Gm-Message-State: AOJu0YwTLUGqVHxDwLw7zi4zDsiXSRylpNFayM0ypm+ypy0j059UHsyt
 RZaCcHt6YtyNSCgbzQCNQVvG/zhNyuwFTdmc2+EOT98f/KY1jmvBCeVTNgpNVQs4dfKRiAVlwRZ
 oIncmZKtzAqZHMQ2L1mP8xySYkQ5ILIU=
X-Gm-Gg: AeBDieuRl9SpG8AChYSUp8xzIHG7MNckxe67CnHGY4BW+kLWMyZMscd8I6Hw1YtSQB5
 RiGHJuWXq/r0VmNf//04l2U4ChMZ+EdbbnsA3ezbJEo5xv6Elj7d38de5m1rqbYo82yyECVMhyK
 TTUE9iteTJmwdFMd6kIbqrNbKaYwyGAgU7jQhWnRFf+5YZKlw5VN8Po/5zy3jU7MQ2byklvRtgG
 zKSxdu2h1RdNtpfL0RxfUHJNz/QSO7+k6NAn1V0wAHEULF7eQd9lSd+TAlUIh/gitSh7Q7BQP8B
 8rhcmK5r0cc8mmAVXoKgdOvfOYyPiB+LOMI+gzCbtZOAKFOa
X-Received: by 2002:a17:907:788:b0:b9c:69df:4d8e with SMTP id
 a640c23a62f3a-bbac67c3a09mr35728566b.25.1777502683062; Wed, 29 Apr 2026
 15:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
 <20260428093339.2087081-2-peter.maydell@linaro.org>
In-Reply-To: <20260428093339.2087081-2-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2026 08:44:16 +1000
X-Gm-Features: AVHnY4JMvgeLa4UX5XYU4FPxq-BQ036Bb9DCcS718WyPBYE-52R61o8evfYiE2g
Message-ID: <CAKmqyKMhiaBu7TwAYZ-NgZ7TfFngs40NrimELwNqDbOw173ZNQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/riscv: iommu-trap: remove .impl.unaligned = true
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 28, 2026 at 7:35=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> From: CJ Chen <cjchen@igel.co.jp>
>
> The riscv_iommu_trap_ops MemoryRegionOps specifies that
> unaligned accesses are not valid for this device but that
> it does implement them. This doesn't make much sense, and
> we want to add an assertion that registered MRs don't specify
> this invalid combination of settings.
>
> Drop .impl.unaligned =3D true, with no behaviour change.
>
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> [PMM: reworded commit message]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c3c9ed6469..f0de264a10 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2433,7 +2433,6 @@ static const MemoryRegionOps riscv_iommu_trap_ops =
=3D {
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 8,
> -        .unaligned =3D true,
>      },
>      .valid =3D {
>          .min_access_size =3D 4,
> --
> 2.43.0
>
>

