Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C73CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxz3s-0003E4-7P; Mon, 07 Oct 2024 21:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxz3q-0003Dh-31; Mon, 07 Oct 2024 21:30:50 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxz3j-0001js-QE; Mon, 07 Oct 2024 21:30:49 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84f965407beso298621241.3; 
 Mon, 07 Oct 2024 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728351042; x=1728955842; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKifHFSpcfjlmRYnmhwnCfwktQUFaMDiwzDKEfJqBpU=;
 b=E4T++4jBh9uA5S8X+6dWOhkuqszOWG4ktNH7GZtN68E5ngqgnQkZH4a1xfX7ww6YrA
 4qzXTC/WjtouiTj1sKFtsUvj6o3/mbgrW9kEpQnyt8DSq6YqZ+VQi0AjqHj21hBh1NBN
 ocQod7tA24V3fyeUuA4/x/I8wp458oFX+VZEa+Ox4/IhTEr28kk4/iKibDTjXo9pUsY5
 HyGiTt+BUmOZlk6Nn0VxcmV3XsdsjA0KNN8Gs1FBjc27zg0wgCg2kEhcORCbGzYch0c+
 SfAvv8AcIvZfbVc4PXIR2GV0qlnEONyBGqPeWntWH2onoXXW9umpmGSNSVjjSUnuxsWY
 pMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728351042; x=1728955842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKifHFSpcfjlmRYnmhwnCfwktQUFaMDiwzDKEfJqBpU=;
 b=U9iz08wgagzRcJmTz2xR8+1lVK1qL3sDqvgpHhIdttQw+LKJ3NhixX4SHUmLP4zwvJ
 S2nhRhzFT6zDmRq5u1zmBkv+ELi3GxmZBpVbRD7556j2y5+ywAI+HM+XSaMY8mo6fa26
 ubkH7Zz8iPTH6h7SuCssMYAw3b25Ge0kOwJaRZvzNRc1fFrHf+sLCdDkxO4wTUztTQRY
 5TKVNCl5JAToZHFiypRR3IS8S2MJuT+kmeVfrWcQlERHbUnNuvtgivToeixIDs4uvqHy
 La/4AV2RnD4DB3dtkrbAQf/+UoEsndlH49dMEjxB32Tm8fc39U6pZU7TkYDDe3XXFa2w
 D2bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo8Bs7gBOMP0FeKaxBgv8rLh8c9F2NxobA2jXoT5WxJmTeLOSXd74dxc2XUkji2zPhQOijtxpiyZTz@nongnu.org
X-Gm-Message-State: AOJu0YwE0JtTOuQwwMy8DfT4kOfoH1pGHawSU3vr6Hyp2ZJPk0LJH152
 gjKYqXDrq8OaRkSidgTqApeAcdU2f51pM/b7LjqAkYs4GpIlhavuLpuzwxArPXd2i9fmdHjrZDZ
 GxDGv2P4eLOD9X5vuZImZV24QMhw=
X-Google-Smtp-Source: AGHT+IFr7gbLzlb2uL/CbydTofMcuMrjTFkL2bWCj2oY9TBFfL4DJgT8KVPbUojLVE1qhgevbJhDBLiped81EP7jIOU=
X-Received: by 2002:a05:6102:370a:b0:497:7b07:8d08 with SMTP id
 ada2fe7eead31-4a4057860dfmr7770195137.17.1728351042071; Mon, 07 Oct 2024
 18:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240930165258.72258-1-rbradford@rivosinc.com>
In-Reply-To: <20240930165258.72258-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 11:30:16 +1000
Message-ID: <CAKmqyKP-Z8MP3ijv7JhA-khNFrcQ5C3DpePtXg-nCVmQeD2zkQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Set vtype.vill on CPU reset
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Tue, Oct 1, 2024 at 2:53=E2=80=AFAM Rob Bradford <rbradford@rivosinc.com=
> wrote:
>
> The RISC-V unprivileged specification "31.3.11. State of Vector
> Extension at Reset" has a note that recommends vtype.vill be set on
> reset as part of ensuring that the vector extension have a consistent
> state at reset.
>
> This change now makes QEMU consistent with Spike which sets vtype.vill
> on reset.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4bda754b01..af602e3caf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -997,6 +997,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTy=
pe type)
>      cs->exception_index =3D RISCV_EXCP_NONE;
>      env->load_res =3D -1;
>      set_default_nan_mode(1, &env->fp_status);
> +    env->vill =3D true;
>
>  #ifndef CONFIG_USER_ONLY
>      if (cpu->cfg.debug) {
> --
> 2.46.0
>
>

