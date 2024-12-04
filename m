Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFABEE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgPv-0007Z5-0N; Tue, 03 Dec 2024 22:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgPq-0007Yi-Vr; Tue, 03 Dec 2024 22:51:06 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgPo-0005T5-Jx; Tue, 03 Dec 2024 22:51:05 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4af4575ec4cso1896509137.2; 
 Tue, 03 Dec 2024 19:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733284262; x=1733889062; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZzsZb8oq/FdI0wJd/2dX+WStWtRyD8eFDxKXtdyUsc=;
 b=mvi1I92EpbTo9OkvHozV3Oj+lpZBvxcIRcogltIWS8nkz+seMMKtD+CGcn6ra2zpQV
 EVWp4wx6ScVMEDLuX6md/n//dzKyO7FiLQ2Vw5ToLlfuINUHlyqbr+pCIARkXYHJUgm7
 9vDwcI+Gotwk0LJLDO/Zgmdstqzm+TL6KRysU4tjQVqGT260p0difQXgElMBUpoLd05H
 6iZWQQImyOgAV6trfv+GYDCVstH0TA2eTzbU4L8V9W0qgOKMaVtEi0Q6Ey7IZsCWV41A
 nZWqULZzsnq6GfsAZLD9pWhy4na6miCHJ59Yei/iW8gWuuH6CTecnfwGR2ZyK96zYFlt
 sTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733284262; x=1733889062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZzsZb8oq/FdI0wJd/2dX+WStWtRyD8eFDxKXtdyUsc=;
 b=gEqha3Gz5oCOwo/9gTqIojCiET1zS5veTsQfsEtN5PaoiInUOxvVZhHS4i0F2hQbtN
 ztfJATqv6+RYqF6h0w3kKarM1gX8H9Em2qO8FXDYcFOuU3LGsCjAa+tKrV/KkPPRlDnf
 XrHK/CBvQ8b97mOe8ZhFGu37TOGbH4BidfOf8EHAKyiQVedzjvmNJrDSS+x74a8e4kmE
 1vvDacxXNJMCo6MHSfGYIDmvJCPg67/cPAWJNbJYCbAy3Af3fFI6/j6yN6nZMdMA/xMe
 lC7wGMY3GAaS7chL4RCSuWWdW9q+tW3EU6UkRSWwlG3zsa9QYI+9v0HADg1/6XkNaw13
 Yo2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU29BY9kZyOPfOCKZaXFKw2S0e0gDAZ4rlIUjsEawGhW/4h0/pB2IGDR+eB8t89xH4nZgDU5klC67iN@nongnu.org
X-Gm-Message-State: AOJu0Yy/xX5AHEKHVlbCFpSqs6qhmqcfUpcZzQwdw25BpN+FtVSbapor
 Pt5R1D1iwyblMimxROi2blaD7/rBS5xngyzfxJbu8w85padTTUq/sMgGmcxk8NTRrFi0/dGiaWo
 7XbGpEYwF9BkwdPz8WT0C8nzh+TQ=
X-Gm-Gg: ASbGncviHH5tRwC5YBPFs21+FZEzDSC4RJTTX5gxBKnfl8d1B02sdUSaJtqHqoVaLob
 OTaTSFf57mYtZhIp5zr1SBWUeeGfPdO9v
X-Google-Smtp-Source: AGHT+IFnkMHwpKts5GZn0FfLElxosrFnjl8U7Kd/Q6Vep0huv1wGyDW2asrb0LcqXgw2JgCm04XZ/OMQTGnLQ0p0Y9s=
X-Received: by 2002:a05:6102:370a:b0:4af:30c3:6a2c with SMTP id
 ada2fe7eead31-4af9723e314mr7111355137.10.1733284262043; Tue, 03 Dec 2024
 19:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-6-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 12:50:35 +0900
Message-ID: <CAKmqyKMKVvKhSSotgJSo8xsKQf458YAWgzNEX8y16zwNA2rfPw@mail.gmail.com>
Subject: Re: [PATCH for-10.0 5/9] target/riscv: add shtvala
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Thu, Nov 14, 2024 at 2:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> shtvala is described in RVA22 as:
>
> "htval must be written with the faulting guest physical address
> in all circumstances permitted by the ISA."
>
> This is the case since commit 3067553993, so claim support for shtvala.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 11a0d2d04a..7b54c50794 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
> --
> 2.47.0
>
>

