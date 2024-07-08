Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5303C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 01:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQdDN-0007qM-4t; Sun, 07 Jul 2024 21:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdDM-0007pn-0T
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 21:30:48 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdDK-00016X-DW
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 21:30:47 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-48fde375918so676712137.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 18:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720402243; x=1721007043; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUAsrnG2zBlfGXNtNQ7IEvf7WUzmBGMcnhOfaa9DpBA=;
 b=nDnT8rwtQ8XVCiSzVv2uYFrHpodk2HJ5/Im0/5hufqJxYVcJVg1EBTzBld9m2Q6jum
 aI/dlHwe3K4UPEcF3I2WCW44vm1hAVl0IKw46BDfiFgyhXqN4T6j1oJ+Am+pAhAp/Z83
 tXk9ornmpoK9uyUpzoqshPad3UVcXCSoBiOx3zKjeRVdQBB29u3RrOkQWOjmboMH4GJu
 hbnEK5pos8eBuonIeUNlHRsworidrqoh9oQ5MDqgsQuazwmHhrGl8JhejRh3GciBC22D
 q/NMmb2r8ClOfhRR/wWAIn93gJH2uRO6rT6//rLxnigArMXZpJO/KauAWSfC3tF7QPZi
 c27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720402243; x=1721007043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUAsrnG2zBlfGXNtNQ7IEvf7WUzmBGMcnhOfaa9DpBA=;
 b=p1C9d9J1FrxUgj7Jf5YzWwxOBGkiH1MU9e8oIQmomlB/1XNCTxkKLa0LVn0N9UF6D4
 IMkgd63MzOkLWONbxQ0z3kNiqhmzO/nX/9YlE8kg5iaYNrwC0mYHi1+RE3BJmZhzV5RL
 EADI6vHdyfcPXGYz4Rqy1vf0ZGQX92u6CGg8u+DEjCVir6XlV8Suv4m86JIKaU7QJr2Q
 JIfQIjE+GcCS4RmRYRNHLrcm5WLEwvg4txcEloI63rdCKgKCdT+VmfBMSv2BT/4/aDmi
 3QgCVsA3yFz/MaoRRf8jipqAJEdwgoEVXwYBf6h45HdTUWkYZtmDh257BYOt79XT9n3V
 lBSQ==
X-Gm-Message-State: AOJu0YxyuM36WagWUAHStFn/nXwmOlHxoWCjW5BD0xeco1vNOSqo25MW
 /l9Rw4C7Uuh0mGlcU28/VDNYUjr6i89agKZ17LCI5XGyEBfZ75B1SQF4wkfACsiPb13JgXiFbkq
 hfRtyjUf65Zr/iv9Qrg/Q4CM+HJA=
X-Google-Smtp-Source: AGHT+IGrWB3uFsZporOdMdKg9RPmf3GB1GHQgRpzo1Wc3+thoVoOJX9NKBg1XSW4IZbYf7wd0MbxbRS/FT705l9qbew=
X-Received: by 2002:a67:b308:0:b0:48f:4d5c:69cc with SMTP id
 ada2fe7eead31-48fee6d98bfmr6736520137.11.1720402242069; Sun, 07 Jul 2024
 18:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240701022553.1982-1-lijiayi@eswincomputing.com>
In-Reply-To: <20240701022553.1982-1-lijiayi@eswincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 11:30:15 +1000
Message-ID: <CAKmqyKMX_5rJu2b49LBdrUiP+oshUVz1Rb=3ipr2TB9+yKotPQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Validate the mode in write_vstvec
To: Jiayi Li <lijiayi@eswincomputing.com>
Cc: qemu-devel@nongnu.org, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 luweu1518@gmail.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Mon, Jul 1, 2024 at 3:42=E2=80=AFPM Jiayi Li <lijiayi@eswincomputing.com=
> wrote:
>
> Base on the riscv-privileged spec, vstvec substitutes for the usual stvec=
.
> Therefore, the encoding of the MODE should also be restricted to 0 and 1.
>
> Signed-off-by: Jiayi Li <lijiayi@eswincomputing.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 432c59dc66..f9229d92ab 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3791,7 +3791,12 @@ static RISCVException read_vstvec(CPURISCVState *e=
nv, int csrno,
>  static RISCVException write_vstvec(CPURISCVState *env, int csrno,
>                                     target_ulong val)
>  {
> -    env->vstvec =3D val;
> +    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D rese=
rved */
> +    if ((val & 3) < 2) {
> +        env->vstvec =3D val;
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "CSR_VSTVEC: reserved mode not supporte=
d\n");
> +    }
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.25.1
>
>

