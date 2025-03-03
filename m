Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8024C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 03:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1towiQ-0003YA-AL; Sun, 02 Mar 2025 22:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1towiO-0003Xo-Rg; Sun, 02 Mar 2025 22:43:36 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1towiM-0000Od-Sy; Sun, 02 Mar 2025 22:43:36 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86b6be2c480so296106241.0; 
 Sun, 02 Mar 2025 19:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740973413; x=1741578213; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28AC1fBDKxY/fJTTILDr8dPcCjflFZGc79yht7xB8J4=;
 b=T7Szoim6TqMSfJmOZaOrci6L5fJVErTG8lfAENPDX1gOJnt+Mm3XfE4eXtTYjlnN3a
 py3JKYvwjspkHTmiLwTU0JtS7HHwh023HIrvVu7yzMykzifKqBLku09jdAF/+62lQ4qa
 jQFOLQurb+ULjRj6fzj7EUlyDtN+E1pVR1QhnCuFrBBJ2x3Kj9+rzidPLBeGoATEqB9b
 /QNlt6Tq3y2xpbCChWIbsXmVmgwUeBIUH0ugDupluB2ziYplFtPYfowgXV1i7ZFLNKQ1
 Og4zxRwRIoeluXd5laKb6+aOsUu5sFYkr+G0ZRY84lIOA++tjRb4B4y9h8qTx7lDSMdp
 eiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740973413; x=1741578213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=28AC1fBDKxY/fJTTILDr8dPcCjflFZGc79yht7xB8J4=;
 b=NRRFtVb5XBmOZ4leuwnrbZRd4h+5/O1Ev8EQGCH7BvW6qn+/jOqTtFZbdM8DsSb2xZ
 XN9qfFqb3s0Y215p6euW4fGPyzyQzP0VFbMaU+mO1RZ0epsQi6WLJdggqafsUeMhQ+bn
 2jpIFSK45Y5HvydPEibPi2X/fKmskM6FsHntjRdHjc0E2ORiJRhinKLcAXMK/RzcXfDU
 zWq+0iAVQDifszw/cTQSqDRewwaO72vj4vbbIPjvhHEH9pozpRYGf9nr1vncTuWdbhDg
 r3d5pvh9UfR/r0h5rPzPA4mPDUw/P4UeeKPyZKjvOJS3QU8/Q/ZvS+nMWmVziOaIqk1a
 3abg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNpW8bzoqL+34QYjHPYPG7xho2u5NmWob9iGS4BjbZKvsQDqLOet/qMWiJf3CrHVJiOtFkQ1nnp4ts@nongnu.org
X-Gm-Message-State: AOJu0Ywo5SmYUP5jfkNcDFD+YJln8o96kQcCSk4HWOZmS0MIEZ2Bi/4e
 R01Zax6rsxLOuS/bf46sQsqITBcaomWtQH7mJyDwSPmJ7+CcPWQhfBrQuqX1WdFOxMrBn5y7BuH
 NYut/D/snPN1bwCOU89iUo3NBmqQ=
X-Gm-Gg: ASbGnct/w7C49yjlcwY6AJeJGSFNdI8iFp2sMZrAhTvmlApdhBbbKV71b1V1PNmE2WU
 YByRlKlMgOfsC6asBYvW6r8pnx1pueSd9pHc/dy5ptcRLfoGyAe6i/b2kcEyF2YYQaaqr66ZDv9
 zlhBR8A4iFsv/5hMDurJpE8nl9C4MEejIpDrxBCBWb5VmcjjH1evRDItLa
X-Google-Smtp-Source: AGHT+IHIGbNvD5bpw56hJyiHZuFgw6QdG6qh3nkN6R5ZRdAO7aYWFLsS+h3B07RTU+1yzHOQLXb1gyT9EzKuf/x1hTI=
X-Received: by 2002:a05:6102:3c92:b0:4c1:963b:64e8 with SMTP id
 ada2fe7eead31-4c1963b6c38mr1168495137.23.1740973412803; Sun, 02 Mar 2025
 19:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
 <20250224123120.1644186-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250224123120.1644186-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Mar 2025 13:43:05 +1000
X-Gm-Features: AQ5f1Jqx5eEXo1rGEMqCbMYmpLVT28eQoFmXjRosHMT-vxFHhszPzbObOLWUaoI
Message-ID: <CAKmqyKNnFwBHQDtHE4=9qoHv5uiDTEK4m15Y8sma8ucJvqShFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/riscv/cpu: remove unneeded !kvm_enabled()
 check
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Mon, Feb 24, 2025 at 10:33=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Remove the !kvm_enabled() check in kvm_riscv_reset_vcpu() since the
> function is already being gated by kvm_enabled() in
> riscv_cpu_reset_hold().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 471fd554b3..19bb87515b 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1606,9 +1606,6 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>      CPURISCVState *env =3D &cpu->env;
>      int i;
>
> -    if (!kvm_enabled()) {
> -        return;
> -    }
>      for (i =3D 0; i < 32; i++) {
>          env->gpr[i] =3D 0;
>      }
> --
> 2.48.1
>
>

