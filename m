Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB56C3DA49
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 00:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT9uH-00036G-AK; Sun, 14 Jul 2024 20:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9uF-000347-1T; Sun, 14 Jul 2024 20:49:31 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9uC-00047M-FW; Sun, 14 Jul 2024 20:49:30 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4f2c8e99c0fso1377616e0c.1; 
 Sun, 14 Jul 2024 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721004566; x=1721609366; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8QNNAjIrktKvJw/dsE7uDiWqECIl4xrGGAAOF0VSB4=;
 b=I37e60P2aGb971MMveh5RRWkncZUPUAbb0jcGnVZnoJqmTb/W8XGp68JTCexdiZZ4R
 nUd0fSIbbjpwrk66oUen1ZLEFQcq5wgfbl5DGQErMlHsUV+UeBAfGKGnIGLtGsTcESWK
 h7X+U3k1MDegRoE6OnGmo/jSh3/wtxxTkVMNO6WnlSRD5mdSvolTkp8pcZqSRuAeu9aA
 BdQqKFSvnqrAnK6PFwglVJ78rcx3eY6uSYwoB0IOrRqMRRMAaUmMxHwJCJTZI/sZMFSo
 +HBgfxx2qMYeaBoeKa3PMzdJmteU/VMKIJ3g25rosZeECBI5X0aBoEYhrFkHHeJ+CKnA
 8X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721004566; x=1721609366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8QNNAjIrktKvJw/dsE7uDiWqECIl4xrGGAAOF0VSB4=;
 b=Pqbj53RdmA9KERoHM3KbXd9w/lWMUg9WabcquUCf0fmx8vVetnN3OL1QY72IqX+6YJ
 LBEx3XRc/QP6NIH4eKQK9O1zwt1hUv92+eqqdQyBtIdWe8KYSPJWSWB/81kAhLqrNftH
 VKWwEl/zllbMlqtVrUgx1Gtr5B3aJGFXbrJwO/o/MxKaZZGEwaZ5rvWSekDkxM7Fut9W
 maAuyGE5E57n8ts35ro66E2lqwm+mTi+wNm6tN2aMOpG6VRjVp+evhwjPJwn3pr/fax5
 gcY413ikTjc99vHHv4TbqritLG5qlORIkRPu8Kz3WRjegm5cErC5WOoSDdcmBy22X/Hd
 Za4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIRPrsd6B/O3VT6fDQTCah6PhZ5gM7C+8yyRGq8Pl4VoE+0nizWF8EIjzoHm2d5w1Qs+ic6a+RIQ3ywHzEjbywzC1Tfac=
X-Gm-Message-State: AOJu0YywGPkJEhqNlSRo5dcl3kheLiEpi5i5gVSJUzPi1Myk09UeZKoR
 a2jmmlrADTfx9eUOWdBYxPggwyOo5UDaJwsynMtYrM4+HVlTBp4LIP+WE44RcPNZTQuoCgQeu3n
 p39KA6RSATNawTXa8nlad2zrsjQA=
X-Google-Smtp-Source: AGHT+IFymZJ0AxzypY2s0fkIXdD9GfenmatZipC4N3E/l6R3orfoSdEPwGdWjkCbxLOoaMHZmwFf3WskDKrcPJRhi90=
X-Received: by 2002:a05:6122:4682:b0:4ec:f4ea:6495 with SMTP id
 71dfb90a1353d-4f33f31ca0cmr22241260e0c.11.1721004566368; Sun, 14 Jul 2024
 17:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
 <20240711-smcntrpmf_v7-v8-6-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-6-b7c38ae7b263@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jul 2024 10:49:00 +1000
Message-ID: <CAKmqyKNX1d9boEKEgpbQouekbxE35t6pstqaFk=e6W0Ak7exuQ@mail.gmail.com>
Subject: Re: [PATCH v8 06/13] target/riscv: Only set INH fields if priv mode
 is available
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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
> Currently, the INH fields are set in mhpmevent uncoditionally
> without checking if a particular priv mode is supported or not.
>
> Suggested-by: Alistair Francis <alistair23@gmail.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks!

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index b814d176cbb8..121996edab4b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -967,13 +967,24 @@ static RISCVException write_mhpmevent(CPURISCVState=
 *env, int csrno,
>  {
>      int evt_index =3D csrno - CSR_MCOUNTINHIBIT;
>      uint64_t mhpmevt_val =3D val;
> -
> -    env->mhpmevent_val[evt_index] =3D val;
> +    uint64_t inh_avail_mask;
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        env->mhpmevent_val[evt_index] =3D val;
>          mhpmevt_val =3D mhpmevt_val |
>                        ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
> +    } else {
> +        inh_avail_mask =3D ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
> +        inh_avail_mask |=3D riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH=
 : 0;
> +        inh_avail_mask |=3D riscv_has_ext(env, RVS) ? MHPMEVENT_BIT_SINH=
 : 0;
> +        inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                           riscv_has_ext(env, RVU)) ? MHPMEVENT_BIT_VUIN=
H : 0;
> +        inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                           riscv_has_ext(env, RVS)) ? MHPMEVENT_BIT_VSIN=
H : 0;
> +        mhpmevt_val =3D val & inh_avail_mask;
> +        env->mhpmevent_val[evt_index] =3D mhpmevt_val;
>      }
> +
>      riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
>
>      return RISCV_EXCP_NONE;
> @@ -993,11 +1004,21 @@ static RISCVException write_mhpmeventh(CPURISCVSta=
te *env, int csrno,
>                                         target_ulong val)
>  {
>      int evt_index =3D csrno - CSR_MHPMEVENT3H + 3;
> -    uint64_t mhpmevth_val =3D val;
> +    uint64_t mhpmevth_val;
>      uint64_t mhpmevt_val =3D env->mhpmevent_val[evt_index];
> +    target_ulong inh_avail_mask =3D (target_ulong)(~MHPMEVENTH_FILTER_MA=
SK |
> +                                                  MHPMEVENTH_BIT_MINH);
> +
> +    inh_avail_mask |=3D riscv_has_ext(env, RVU) ? MHPMEVENTH_BIT_UINH : =
0;
> +    inh_avail_mask |=3D riscv_has_ext(env, RVS) ? MHPMEVENTH_BIT_SINH : =
0;
> +    inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                       riscv_has_ext(env, RVU)) ? MHPMEVENTH_BIT_VUINH :=
 0;
> +    inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                       riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH :=
 0;
>
> +    mhpmevth_val =3D val & inh_avail_mask;
>      mhpmevt_val =3D mhpmevt_val | (mhpmevth_val << 32);
> -    env->mhpmeventh_val[evt_index] =3D val;
> +    env->mhpmeventh_val[evt_index] =3D mhpmevth_val;
>
>      riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
>
>
> --
> 2.34.1
>
>

