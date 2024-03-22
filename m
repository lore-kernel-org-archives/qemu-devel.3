Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF70C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 05:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnXAW-0001xP-Pk; Fri, 22 Mar 2024 01:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnXAT-0001x0-H9; Fri, 22 Mar 2024 01:10:13 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnXAQ-00089o-Uk; Fri, 22 Mar 2024 01:10:13 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4d523586a59so714574e0c.2; 
 Thu, 21 Mar 2024 22:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711084209; x=1711689009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjilqN5ludifmJa+srAwbBrAavb2Ps3qBifRhpTPOhQ=;
 b=Z3XYWeFkrApgq+fNAfgIupoSPbEBhWMvzvH9MTS0S/+WZayS7D3lJ7NQ3WbXa4hJTM
 ofRsOu1QLYS4poqDLg81kI2y9oXuwYr6hoqvDa618/rnJrxOg4otCTsykTWXjBwUVBjU
 6yay2aaSD9GbPmozacxKRbwTVTN5CQipubIgDyaaUeMiYQH6BpYIeQpAbzTpf+wUsv6+
 bN7LQFE6lQmschRoGGsvX8JE8jsH+pviCLhRpIZndqY/iir7e79iwRGeVyu6c0FE4UPk
 q+tj6y7/968No0BnVWpG5Qiec3SAVchOd8ehUDFHu9RvFdG+LcjTs25u6l5VjolP9VGO
 EMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711084209; x=1711689009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjilqN5ludifmJa+srAwbBrAavb2Ps3qBifRhpTPOhQ=;
 b=jU1R3fJHN3j+V0Myyqbt2qR08OujpL/zD+xx6Y+jZs9Jr0ZIIc0BDFa1FUnJYsEqzP
 sFjPeWS6sXO1dbkAAPyUwg120LBjZ5gqZg0ujBO/LkozwZcDiocKCangF33cyqW2WJWj
 386DzhgsGxuqORx/V9TEa+m/m+LUK/kLsQspQ05tfDempRMa5q9ouZA27KDS4RwbHrHq
 moVJq7ecKabRor3KDoSaJp8aOU836URWDo0k+fQRtzaN8CV2ga+rxVLUTiX5EOtzOOEg
 p579ge0ncaQVvdqDSQm/LvQu4LMaF5T9XDpt8o9zPbIrPcfV/JFlSw+xHntbU0ff9Iw5
 XYIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc1nK+vD4J8MruPm/QL6hVw+kAGIQvyhYDD2j3vvik1mXZQi54SMMfSnAGjMpz81G8m7+v1etWx/u0Zwt/09p4oHR333w=
X-Gm-Message-State: AOJu0YxUsbG7HrFpGUz//z1NiCAmqhzD1XI33Ap+D5wInG+dv5wL3wp+
 YIXaTwbUrIhqKiRKASqnAJD88430eF+s+L7jQV0IYeqfnT5VChhGqatIdE1CmwnbKk83YGqaj/c
 LP3X10i6XQqhtIg+sM4WWHJkDDMY=
X-Google-Smtp-Source: AGHT+IG3188v2mkFQ1pD33an1VRxDwetGs07tu6pbZSqt0ETsU9RYOglp2KGYujvtEi5fYphdWjxshjCrb7df+iA2iY=
X-Received: by 2002:a05:6122:32ca:b0:4d3:37d1:5a70 with SMTP id
 ck10-20020a05612232ca00b004d337d15a70mr1576238vkb.7.1711084209495; Thu, 21
 Mar 2024 22:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240321104951.12104-1-frank.chang@sifive.com>
In-Reply-To: <20240321104951.12104-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 15:09:00 +1000
Message-ID: <CAKmqyKNEkhr16cpG_9hrEX2rqdQ8Q5=wFQLDA7fSWk-ONNiUpw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: Update APLIC IDC after claiming iforce register
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Jim Shu <jim.shu@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Thu, Mar 21, 2024 at 8:50=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Currently, QEMU only sets the iforce register to 0 and returns early
> when claiming the iforce register. However, this may leave mip.meip
> remains at 1 if a spurious external interrupt triggered by iforce
> register is the only pending interrupt to be claimed, and the interrupt
> cannot be lowered as expected.
>
> This commit fixes this issue by calling riscv_aplic_idc_update() to
> update the IDC status after the iforce register is claimed.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/intc/riscv_aplic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 6a7fbfa861..fc5df0d598 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -488,6 +488,7 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICStat=
e *aplic, uint32_t idc)
>
>      if (!topi) {
>          aplic->iforce[idc] =3D 0;
> +        riscv_aplic_idc_update(aplic, idc);
>          return 0;
>      }
>
> --
> 2.43.2
>
>

