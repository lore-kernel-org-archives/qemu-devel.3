Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5666BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGho-00020p-9X; Wed, 30 Apr 2025 19:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGhk-00020H-N6
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:19:04 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGhh-0000yV-JX
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:19:03 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4c4e1f16833so124777137.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746055140; x=1746659940; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlqUPiaS8swxqLxhzxQjhANIIzxQwz6aEkHL7nXuK7k=;
 b=Z0AsvplID9tIcQZu4YyCOKBOU7WkfGgUXzQLfQWO2ovHP0fFAN0pvqFrJt36Dz/7ON
 Hhi78j0DTijH/Jqa0dU8Xw6Xj0GT9HO2Na3Q06CvT4k/KubGEfxH+VZpC2n1rTZXMR+7
 Llff/FCQ8AVgnU8jqkJ88UiDexBCJSYWOi3yH46o74PmJw16KNlRFKzxo0pRUzzOnlC1
 w8ZKaiQIKevGk6FwkVT/AZpBKmLyIuU8rfejhXx2lZDrzoif9rhbG+WZEUoP8my/DKFf
 eqUx9nHyiYswBJ+q15bkdolgfVvMKIa7hafx7z2EJAodJBmywxR3R33rS4ix4R0J+aCj
 Mxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746055140; x=1746659940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlqUPiaS8swxqLxhzxQjhANIIzxQwz6aEkHL7nXuK7k=;
 b=NTYJeaaFTjQANpHWihePFfFbD60LeZhF4MY2QT46qxYbe6+gMDwzRP1avip+jTcG1L
 QcCicyDm13C8idOQgHC2SDAMp/ytmoYS9ZSysTPXq7s59J/ZSb/N3zhL04tB12LyKzdj
 oV2xxwDYiz++xlHLpm2UMNHkGOruP1h/IFDa7UR3j23ekNOX3pLQ4Xnmk0AmDiJoBrYl
 +3WZtgQn8DzTJ1j2kMahKZnpxQMu75OnvKykLseEF/4VzogSFWvsFbb+PRoncbS3OkWI
 qa6yjoBqvFu3qwTnnSA5SwMxW93peQDKavP8ZNFYSDK2fylfLEA1ol1uABEFKMxCcpZC
 bhiw==
X-Gm-Message-State: AOJu0YwvHW7Tci9ILRTV7uGM7Z3KcWIqPvzqNr/QsaICKDavfl8L9D2w
 sy2H7nbo99EwC/xW9hc1dpiQkqcpTBdHZOUBekWooGxwYdMrTFHYv9R9To/QdJpOl6qNS9LDRMX
 apJClkxiiBr7iytl9/X9bJqxR5owqMQ==
X-Gm-Gg: ASbGncujbBwgJqRaNE7H1B1ZTs+WYSRLorpKq3D/E2Al0Ly0Yp+nqEVwY6H0JAbYiOp
 2H6LFqMFUEkRH67T3lpotTSMJ8Y3FtUGJjMnDi6yfmlkB1LTBVZLu1EAaqb5np+9lc4g2PbLuYk
 SAhE3m4Hys30WO/7nCGvRHpginrBev5BRjnlaPDgXkXy7zZOhsF+sD
X-Google-Smtp-Source: AGHT+IGuoL8L5WPConSB8X1JZgzkm63IdVjFO0l8PtWGxryC8UmM6e1ZXBtl3T3DmGLNhFr7JS1fkFDJkMvvos5gI9k=
X-Received: by 2002:a05:6102:3909:b0:4bb:d062:455 with SMTP id
 ada2fe7eead31-4dae8c2acb4mr218619137.0.1746055139763; Wed, 30 Apr 2025
 16:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
 <20250429124421.223883-10-dbarboza@ventanamicro.com>
In-Reply-To: <20250429124421.223883-10-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 09:18:33 +1000
X-Gm-Features: ATxdqUHHhqytRfncIH20zTINm8crXNAaI2Nv-MLPywDfI4zPtZS_h75VW9e23Rg
Message-ID: <CAKmqyKMf+ZiFAP7+zwq-T_TtS8pAZmE_Mjya0RH4N0zHGPXnuA@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] target/riscv/kvm: add scounteren CSR
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Tue, Apr 29, 2025 at 10:47=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add support for the scounteren KVM CSR. Note that env->scounteren is a
> 32 bit and all KVM CSRs are target_ulong, so scounteren will be capped
> to 32 bits read/writes.
>
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index d55361962d..ff22ad1fb6 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -251,6 +251,7 @@ static KVMCPUConfig kvm_csr_cfgs[] =3D {
>      KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
>      KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
>      KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
> +    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
>      KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
>  };
>
> @@ -701,6 +702,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *e=
nv)
>      env->stval =3D 0;
>      env->mip =3D 0;
>      env->satp =3D 0;
> +    env->scounteren =3D 0;
>      env->senvcfg =3D 0;
>  }
>
> --
> 2.49.0
>
>

