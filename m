Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07816C48260
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 23:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX8aX-0003jG-Ci; Mon, 05 Feb 2024 18:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rX8aV-0003ik-FP; Mon, 05 Feb 2024 18:41:19 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rX8aT-0005VO-Rd; Mon, 05 Feb 2024 18:41:19 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4c025d5329dso685518e0c.1; 
 Mon, 05 Feb 2024 15:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707176476; x=1707781276; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l631vf8xZS1+JW9c5VmJSrqI0rgAHOnJ7cf/Hlkog+g=;
 b=Mkud4UupQqY8l28Hqi2DEniiJaHvEvYS9y35mQXAvdVJxEbfV/BLM0xrn/oeEgC2Rb
 K3s9AKj584xrN1nKLL/ixPiRR3utrnSULpseJ/7c2VtNaD9WtBOLzQj6vf+Ac8SFEvWV
 0izW07aehrCJdF32mwM8RbGWN5ROhVs7UG8GVYeeDrAH9mFlmdKYj2Y/LNtRgwE/i3GT
 CUJlzr3Cij3keqTvml+bGBl7JhjwU6M+HCPysctvGm9AETQcT6PpKqkBeJq4T/scnn+k
 gGVLvFAgDzWzR+9yEfyGGIgRRgiBzHjbdhI/F4UUDHNmR0bsNoVM4JWyOIoiTD+Vl5i5
 BMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707176476; x=1707781276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l631vf8xZS1+JW9c5VmJSrqI0rgAHOnJ7cf/Hlkog+g=;
 b=Vf73TthZMAQHXs7hiXSYcVG3l51rgicknpZ5928NQmKEKlaKC2SYxNKYTuJXBNPPJd
 cl9ayrnwu89q9c9NcSjRbpoabwedyJwxB0eRwctK9LU6WZ38x4/GRfSZIrN02rOqG8KK
 Em6Ebp//b7SMqfLhsSlZsya7bZxeSpoxM/C23a8RNCfVlRJyfIGAYmrMegv4CkxOcn1U
 4jckmKkNeXu7M6uQWyi0pBMRbSv9jhScRZ8SnqNC/C5yC5gmIi3vsz9EJ6IFeDzTrMqF
 Q0K716iD1l0AE8GF46ZaePibZGMLwyUjOhbP853PihjRB7HJQkhj85R/fC/MQCTIpLbE
 TdIw==
X-Gm-Message-State: AOJu0YxlHHUMPP86hsRwTxbXTheDNR6amqTzUdXd1LsADXH1osoVfvBj
 +WEpeKlQAYq6UPWicwQpRrA1orSWHX20KjNujTpdRGOVRjrjFT+IeGGrK2KH4ql0ewh36IeI9mL
 vCsGg8XEXmpw1w1534ebBd6nehQQ=
X-Google-Smtp-Source: AGHT+IF6FrWh0g2p8t1oJ3c31X+JtH6/XPdDs0YYsolz3Oe/vrU+wAWVZ9YR2uAK9Ta/DVISsG1La2H3oVMhW8i+G0E=
X-Received: by 2002:a05:6122:a0c:b0:4c0:3d4e:774b with SMTP id
 12-20020a0561220a0c00b004c03d4e774bmr626747vkn.9.1707176476056; Mon, 05 Feb
 2024 15:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20240122123348.973288-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240122123348.973288-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Feb 2024 09:40:49 +1000
Message-ID: <CAKmqyKO3=CdPSSMcpf8NBEiFzxTTU-dSdtpWiMUwNs3iZ2OXQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] riscv: add rv32i,rv32e and rv64e CPUs
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Mon, Jan 22, 2024 at 10:34=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This v3 has the same patches from v2 rebased with a newer
> riscv-to-apply.next branch (@ 096b6b07298).
>
> No other changes made. All patches acked.
>
> v2 link: https://lore.kernel.org/qemu-riscv/20240108161903.353648-1-dbarb=
oza@ventanamicro.com/
>
> Daniel Henrique Barboza (2):
>   target/riscv/cpu.c: add riscv_bare_cpu_init()
>   target/riscv: add rv32i, rv32e and rv64e CPUs

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu-qom.h |  3 ++
>  target/riscv/cpu.c     | 64 ++++++++++++++++++++++++++++++++----------
>  2 files changed, 52 insertions(+), 15 deletions(-)
>
> --
> 2.43.0
>
>

