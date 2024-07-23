Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1A2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Rj-0003aQ-9T; Tue, 23 Jul 2024 02:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sW9Rg-0003UP-Vj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:56:24 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sW9Re-0007ym-F6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:56:24 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52f01ec08d6so2686932e87.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721717779; x=1722322579; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSeZsR/zaG1TI5fyB6D5J5Z++8OL1hLqur9S1OD07Xw=;
 b=ItXFUshCh1oFPBBUgH+9P+GvUUFCGIfA1iPteNZqbCVafJ4KBJ4AoGF4pgS8L/GaP/
 XW9K9/6XGmR4ZUYwY54/wg7a7R6TBenR7nK2QfoGFa+Sve3JhTXNNd92ZGkMf7QAkkEj
 5R1AUonJtJb1cKQo4OGftQrnq7M/qXNT1G3XeStjWgZKU22scWMmyohxzTY+/QwUvDaF
 xl6qs5nLikMxCirxoDrfF/oWtdQj+7w8rOf85YhZ69vi+UmIhj2TVNFbTEwWLgh+m0Hr
 O3Iv9tPKisfgOkodCIbpD0JNUerYULuFtq/doiOdqBGh989rRfS4re3N6jdzkrZfkDPg
 TvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721717779; x=1722322579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSeZsR/zaG1TI5fyB6D5J5Z++8OL1hLqur9S1OD07Xw=;
 b=b/9luC4zPjUej9VsBFWeY7SPXtjeeacD3wMqNjRI7wp9KCF9kd1gEJRWA+Z0XEfgP6
 SfJA5bj4RZhjHu5md9ao061MoiJ99qrl2CT5fjbNENhxafIGFD5RBlSYSk/ybTOe3f/M
 eLQbG+wKwvy9c7KS0QQ6r3Eacs9JgKAwgY3Lno5JgoPlb62FcijRWThdMvNELv0fHBgF
 W/vgrI78HCpEY2MHtRAhNJYTlGRNV4i3DP0Yr+X0cHG2jod4QEsFQ60ad1WgL1SUhlsO
 /9UTrlME4n7nBNCD4uNKbbeBXm9FjOG7olKSXz6VM8Bs3jvGN2ODM0UJoaFEamGBT1T8
 G/sg==
X-Gm-Message-State: AOJu0YxPuOIWhU2MByfVu8cYF6aevKrQE6Sb4sZqZhhvIyJ1XaAB8uYN
 TGzpftHCvZxzn7EhxbAlKyf/JMXbdDD4LAw8ZzwYgevc0cdyZYTmkm2nlbnWRAmjz00cREDwzRy
 xhn0Jen7mbMFsdUF9Ix3KMVeCNtcxS1X0y+HGEtDWaVg/RCeWzSlGYLCkcJIx507g7GBK/kHAnK
 6exX3zTWlCx0x4l1vLdz/rwGdsCnNUK4xpQlAjWvbk/w==
X-Google-Smtp-Source: AGHT+IEkpspkicCyCs72PVOynJk524h991pdMEVZYly1g6pG7maHS1JKMtWz6zeZUEvspytopBSFAw==
X-Received: by 2002:a05:6512:684:b0:52e:9670:e40b with SMTP id
 2adb3069b0e04-52fc404f3f7mr1414713e87.39.1721717779035; 
 Mon, 22 Jul 2024 23:56:19 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com.
 [209.85.167.52]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ef55781f6sm1481107e87.293.2024.07.22.23.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 23:56:18 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-52f01ec08d6so2686904e87.2; 
 Mon, 22 Jul 2024 23:56:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWszTN+/ggZzEMaqi0ZTyEb3INc+wPt7S8bWrzTquyfi3NVijTq+xF4vie8YH7Xs+YMqz7o1mWbYVT+nF3rPloFjDn1Trk=
X-Received: by 2002:a05:6512:2215:b0:52c:d13e:3785 with SMTP id
 2adb3069b0e04-52fc404de47mr1452596e87.30.1721717778466; Mon, 22 Jul 2024
 23:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240722175004.23666-1-jason.chien@sifive.com>
In-Reply-To: <20240722175004.23666-1-jason.chien@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 23 Jul 2024 14:56:07 +0800
X-Gmail-Original-Message-ID: <CANzO1D1S3ZJ20zFVDFPKJ_9R6ezWy6tzUEUzzW0Hkq_JdfmumA@mail.gmail.com>
Message-ID: <CANzO1D1S3ZJ20zFVDFPKJ_9R6ezWy6tzUEUzzW0Hkq_JdfmumA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add a property to set vl to ceil(AVL/2)
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Jason Chien <jason.chien@sifive.com> =E6=96=BC 2024=E5=B9=B47=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> RVV spec allows implementations to set vl with values within
> [ceil(AVL/2),VLMAX] when VLMAX < AVL < 2*VLMAX. This commit adds a
> property "rvv_vl_half_avl" to enable setting vl =3D ceil(AVL/2). This
> behavior helps identify compiler issues and bugs.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---
>  target/riscv/cpu.c           | 1 +
>  target/riscv/cpu_cfg.h       | 1 +
>  target/riscv/vector_helper.c | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..8f21171ffa 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2687,6 +2687,7 @@ static Property riscv_cpu_properties[] =3D {
>
>      DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false=
),
>      DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false=
),
> +    DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, f=
alse),
>
>      /*
>       * write_misa() is marked as experimental for now so mark
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8b272fb826..96fe26d4ea 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -127,6 +127,7 @@ struct RISCVCPUConfig {
>      bool ext_smepmp;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
> +    bool rvv_vl_half_avl;
>
>      uint32_t mvendorid;
>      uint64_t marchid;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 1b4d5a8e37..825312552b 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -75,6 +75,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_=
ulong s1,
>      vlmax =3D vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
>      if (s1 <=3D vlmax) {
>          vl =3D s1;
> +    } else if (s1 < 2 * vlmax && cpu->cfg.rvv_vl_half_avl) {
> +        vl =3D (s1 + 1) >> 1;
>      } else {
>          vl =3D vlmax;
>      }
> --
> 2.43.2
>
>

