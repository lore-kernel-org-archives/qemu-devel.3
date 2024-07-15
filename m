Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E29C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 00:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT9yb-0003uw-Mp; Sun, 14 Jul 2024 20:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9ya-0003u2-MG; Sun, 14 Jul 2024 20:54:00 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9yZ-0004ti-6g; Sun, 14 Jul 2024 20:54:00 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-48febcc8819so1226176137.3; 
 Sun, 14 Jul 2024 17:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721004838; x=1721609638; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFr5tSMBgkRgew4bgNgkwYzTcAm3plis1ERhv3xioGA=;
 b=C4S8ISirFNdBxpZYYnr21ZMBSktoX7OPdQs2H38cAdGmN26UYqkGvg5IE+Q7yRJb57
 hKW/XrQBNQbK7uZgtHiqJVuy7IbRv1pSHC4pY0oRoXMi8iMO4Ak6lTewVZWunguyG96n
 HQl46Qu/SjPV9uDx+Dkb6HlYIaA0zORsIuedOQ3Df7wbiiPvVq80KL4AuO4D2cJQB4l1
 YPx0GPLSWSo0pcNHh5hgWz74O6ezlIce/+78rGEbTbOlI2Xq4WwlJdIC7VBho7rjmMd1
 qIuMlhS2qTpiJIk7iTUkwaErQKZQ5fYmhooqc2N8ZLm8aYzXchR6+64+1m4MJFSnm5ek
 Gjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721004838; x=1721609638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFr5tSMBgkRgew4bgNgkwYzTcAm3plis1ERhv3xioGA=;
 b=kVTvLiSWpgKwrJPEtNpfm5yaIbxdVEh9vcMbiTZPDuROWTzT9BneD5lr8CRR+F2HOw
 Tz8Z/npIwoTJkBIhRLc6tFHuTg4yuedldrYWdMjnpsVXeOLw4Rrncn3Ndk08NorhLvtZ
 dXVJJzK0oJ+nYMP5brss2f2hh5z04VUXK0xDYZaXHQgDLxH6rHGwlLRETk/hYNh5bLgA
 BacC8OFcYllfPp7hlEQPL6wH8fDX76rz3CzHTCizK2jgRKDJU8gE7MayQcT0XUa27OAr
 MRTqqYt7PkHG0xcgftgzc2ckomsK+/vLgYumF9/FYqgZMpUAioP2HtINrI2OMHAtWJt3
 9iMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJeat9JnyDKq/FoW+8YLkWap4ENf3HprGLb90CR0YbNZLaofhOyibVYMB0axKLjmtQZf2DQ4bQKBZfNZiqH/16NRi1iU0=
X-Gm-Message-State: AOJu0YwitbZnjoHNP/lnIHCpzRdOlDsqst4DQKEiSMGXpqGXxe0bmD3U
 84+vnNi3buirmzN7jepQtzoDaIkcE7t1ni5EwfyAkYFqSpyypAPykIdAqvNdqdmfr/sJyEB2xqh
 ar4hhtbuH8mCQcWuxA2u30MGoBaI=
X-Google-Smtp-Source: AGHT+IGifPX2Nj/QBSfAD2pOSGEBjZozwVZsmR4DL2GJogfkgqS/oKzPN/bpYY53mJtzgugWd6HAvEfPAN74Fw8FqkM=
X-Received: by 2002:a05:6102:3906:b0:48f:143a:d8e9 with SMTP id
 ada2fe7eead31-490321597afmr20745703137.20.1721004837650; Sun, 14 Jul 2024
 17:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
 <20240711-smcntrpmf_v7-v8-13-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-13-b7c38ae7b263@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jul 2024 10:53:31 +1000
Message-ID: <CAKmqyKO7_a8xXPq-KxauE6koc6Kwq3HRKvXfUp1VwBkTP_UOpg@mail.gmail.com>
Subject: Re: [PATCH v8 13/13] target/riscv: Expose the Smcntrpmf config
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Fri, Jul 12, 2024 at 8:34=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Create a new config for Smcntrpmf extension so that it can be enabled/
> disabled from the qemu commandline.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 63f553c92b00..ef50130a91e7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1468,6 +1468,7 @@ const char *riscv_get_misa_ext_description(uint32_t=
 bit)
>  const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D {
>      /* Defaults for standard extensions */
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> +    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>
> --
> 2.34.1
>
>

