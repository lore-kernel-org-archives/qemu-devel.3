Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5A0C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEIRW-0006Em-JH; Mon, 03 Jun 2024 20:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIRU-0006EU-LM; Mon, 03 Jun 2024 20:54:24 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIRT-0004xm-5O; Mon, 03 Jun 2024 20:54:24 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-48bd11d0656so591075137.1; 
 Mon, 03 Jun 2024 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717462462; x=1718067262; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IGID+Jq6WZFUuxcCo107fbTfbvyfW4EzHJdGBuV8oE=;
 b=DlLQxwHr7Av4R9OVOd872nnWPldlZ46bNgXPEyoW98uQvs3VxJiYc2+tjM5n4B82Bz
 xMZWcdHOzhc9+CeLOkpvJzK5XTuBW5ioebJhLIe07Pe0g/ZhEGG9MLkuRTsNvDgTIhnq
 fyiI/R9L1N70X5tq+brMk9Zkjn7R2vXw8Medyqd+WIoTMnSnIGXl1DBsOFJE3/WShzP9
 qV8x+9zi8sXs7yIf5lzEQvOu2AAmGovGWPnvCBRMREeriAQKou9bABKr5rvoGD+kEkHO
 kWVGz2DpbzpfwPVwT1qlU6t4xgGuzJCgjPsZx54fRhx2cgjuWOwJX5m4Yc3QFViI4W/7
 q79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717462462; x=1718067262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IGID+Jq6WZFUuxcCo107fbTfbvyfW4EzHJdGBuV8oE=;
 b=eDiLkeMmlmSH0l+OATpe4EuusjPiXkWhVnfC65gPj8vKJ5oh9sVnDCuDJVe0FF0dcW
 NkAo4J9L36a1gjEpH6BkyNhvkKwpda/Po/ILxaUQvKvngjRAHfW+QixJvgQxSq76nShO
 SrMQm0LsptAlcvM1IoC8T0stRsPbuL48raHp7P4DzisdrdXxpBZOFXBGaqBRf9KRLJ03
 B8UfKvO2DtpMeJGqKs6ewiZiTXGliprxtMONG/RQ/a+j/NYF38cKCT/7oX4T5+92BQZd
 DmVfv1xyN6DF0qULg07ZwbBhEAHXl0ouHs/eeYgJGgDK1WBJAd0jXosuQRy66FO9VK3E
 EksQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlFR2qAt5Xce3WZIOLoVt8MJ/3ztTAJuukETiPkdDOR1vncMgWj/HCuKBrofY39QBkL0S3ctdE9VqfmFM12IheJESuq3o=
X-Gm-Message-State: AOJu0Yypvndm+Z4zXYMFmlrEAnKJ6fy2fQwrrUKVE1b/8Ya2qSuEDkq0
 xMEKknLiQfwFLZ7//8yV/5CtxYd3ZB6bD68PuIOxFnDWr2BMFWtSw+QGes5rn7A+zp2uAk5bOJ+
 u/1v3IuV/EBH44ejr09SmAeQzCok=
X-Google-Smtp-Source: AGHT+IGGGsQLbNcBaQYX8Jce/cjQlTgMKrc9Gzn00/V/5ItiE1bQCQxHSo6wefkNxK2F4O32HPynzUjf9F53r3+z+w4=
X-Received: by 2002:a67:ad18:0:b0:48b:8df1:f500 with SMTP id
 ada2fe7eead31-48bc20f686dmr9336274137.6.1717462461637; Mon, 03 Jun 2024
 17:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <20240515080605.2675399-5-fea.wang@sifive.com>
In-Reply-To: <20240515080605.2675399-5-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:53:55 +1000
Message-ID: <CAKmqyKOMiLASugn3vS41t7q5H9T9RbxG-VYmQXdhK47zd1+bPA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 4/5] target/riscv: Add MEDELEGH, HEDELEGH csrs
 for RV32
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Wed, May 15, 2024 at 6:03=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Based on privileged spec 1.13, the RV32 needs to implement MEDELEGH
> and HEDELEGH for exception codes 32-47 for reserving and exception codes
> 48-63 for custom use. Add the CSR number though the implementation is
> just reading zero and writing ignore. Besides, for accessing HEDELEGH, it
> should be controlled by mstateen0 'P1P13' bit.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h |  2 ++
>  target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 28bd3fb0b4..f888025c59 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -156,6 +156,8 @@
>
>  /* 32-bit only */
>  #define CSR_MSTATUSH        0x310
> +#define CSR_MEDELEGH        0x312
> +#define CSR_HEDELEGH        0x612
>
>  /* Machine Trap Handling */
>  #define CSR_MSCRATCH        0x340
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index bdbc8de0e2..c5ff40eed8 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3225,6 +3225,33 @@ static RISCVException write_hedeleg(CPURISCVState =
*env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
> +                                   target_ulong *val)
> +{
> +    RISCVException ret;
> +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Reserved, now read zero */
> +    *val =3D 0;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
> +                                    target_ulong val)
> +{
> +    RISCVException ret;
> +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Reserved, now write ignore */
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
>                                      uint64_t *ret_val,
>                                      uint64_t new_val, uint64_t wr_mask)
> @@ -4672,6 +4699,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>
>      [CSR_MSTATUSH]    =3D { "mstatush",   any32, read_mstatush,
>                            write_mstatush                                =
   },
> +    [CSR_MEDELEGH]    =3D { "medelegh",   any32, read_zero, write_ignore=
,
> +                          .min_priv_ver =3D PRIV_VERSION_1_13_0         =
     },
> +    [CSR_HEDELEGH]    =3D { "hedelegh",   hmode32, read_hedelegh, write_=
hedelegh,
> +                          .min_priv_ver =3D PRIV_VERSION_1_13_0         =
     },
>
>      /* Machine Trap Handling */
>      [CSR_MSCRATCH] =3D { "mscratch", any,  read_mscratch, write_mscratch=
,
> --
> 2.34.1
>
>

