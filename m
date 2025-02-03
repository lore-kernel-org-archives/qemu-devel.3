Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7FEC0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 02:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temfp-0004mo-Bk; Sun, 02 Feb 2025 21:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temfn-0004j7-4W; Sun, 02 Feb 2025 21:58:55 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temfl-0007oo-IC; Sun, 02 Feb 2025 21:58:54 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-51882748165so1211997e0c.3; 
 Sun, 02 Feb 2025 18:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738551532; x=1739156332; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSTYkm8oPD4US0klgVfMso9zCTmVZc5FFFWfpHkuFhM=;
 b=DCZAkTTLPJ4X9lI9iZGRk0J8B7EMdpePqnlAUQgg8KjcmRwG62OauI1gH+NmRSxq4A
 ROARoLedGHRc7K7Xoyx06tS+ZXKYCBukG9YoLMx6dEydUATjtlGz9JtSWgUCVsAUZflW
 1hhXyRqkUbac7dfmJslQNuZ/nTBCoMS0HxnUq+E4yrLuE4HMbDgepQG6VDKSuN/XxtWM
 9Xj1JNk5bfGGJiWBE2euaPPyZSN28BdWne/rIY9VJ2rMtgNcJQELBYOJrnQp66TBZq3z
 zVQp/vgedSJWi8ueqMoTXgIt3sohfo/jNSxp4SUDJeMZfpdbA2UPYfYtsiNVY1F6qplW
 UBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738551532; x=1739156332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSTYkm8oPD4US0klgVfMso9zCTmVZc5FFFWfpHkuFhM=;
 b=LCuM/LTmvzSQx0GbK3JH5/IJdBwTBzAVU8PPBrYqFWQPZqD9cI5USu4vZTDOOi/TqB
 o7vzg0QKvFddnu+Ol0yst6O/q5XXvai24gSomOfqR5fHCpoKDqdrG5OsK4Xjq4zOLzSh
 /Ra5axo7MAG2BAOYY8acG8mj0oh7p8AIVHX9WbSURvDCdOEaL3f4ytvxXGEOcrD7bQj2
 V26Ad2ML/k9L9kVOfyHTMeByv7e93/fl2z0KmcAB+DCpTmO7gqLrOR0SnRVxzgmXan6k
 +tNN3+VhpnZB0JJkkFDg7M9nGa0hg+jm1F6R7V73ck1t77MiNlHtx3VAa9GSkqMsrgpz
 OLlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc1AVLkeZ+CehhwWLJpyLkyVZQ2ZMJMtLlKMMFdhaNyjYbIRIg/4olRdNJxg7xtpZx9RCphZi3pjGc@nongnu.org
X-Gm-Message-State: AOJu0YzzTjRKJE//xRxW5X/XLL+boaLma0/VdwjDsc1BNPTiptturMN9
 3MYemRROvs4Nculht0JrzGOiuW9SSEg7fmt2HDAElyDoq1msyiGidtyv8Y9FO3ZdxNJpQ5JJKGO
 cgIcmEWvrIbVWGqT9fSEY/5HHcl8=
X-Gm-Gg: ASbGncvhIoiB7yNpm8Ho3zFcI+YlLBABvBGP2N5DdrtHqVTFh6zMtERxjVYlVfO5NOF
 novxjKC0SiUzGne6LhCO4+RZllY7s+p6P1CHGAMgKT9a27RM4iYpjfecdot5WUL0cbLnlXwZfGS
 WxJTn0iu6biWc7rce/zN42y8sGeA==
X-Google-Smtp-Source: AGHT+IEhI4yrP9KfFvmi4gHyG199GbTNGs6BsIJwkto0CEdxz9pMCSxCpuBN4JYYeVqlCPT6xt2rwujtYGDIq4XM9Gw=
X-Received: by 2002:a05:6122:1308:b0:51b:8949:c9ab with SMTP id
 71dfb90a1353d-51e9e426958mr15866898e0c.9.1738551532245; Sun, 02 Feb 2025
 18:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
 <20241205-b4-ctr_upstream_v3-v5-7-60b993aa567d@rivosinc.com>
In-Reply-To: <20241205-b4-ctr_upstream_v3-v5-7-60b993aa567d@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Feb 2025 12:58:26 +1000
X-Gm-Features: AWEUYZk6T5-HRGHtwFHKyi9Iza0Bzh8LYzaBxcSyBSm4uQYoKe8Ya9s1MGCSboE
Message-ID: <CAKmqyKNaGE1d2EO+2uWtrPydcMC4k+96cuxjRUVcYKE4N9AExw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] target/riscv: machine: Add Control Transfer Record
 state description
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Thu, Dec 5, 2024 at 9:36=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.com=
> wrote:
>
> Add a subsection to machine.c to migrate CTR CSR state
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index e1bdc31c7c53a8a4f539113d501c8e46f7a914e9..b67e660ef03b6053fa00d5a79=
e2ab20ecf3331b8 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -311,6 +311,30 @@ static const VMStateDescription vmstate_envcfg =3D {
>      }
>  };
>
> +static bool ctr_needed(void *opaque)
> +{
> +    RISCVCPU *cpu =3D opaque;
> +
> +    return cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr;
> +}
> +
> +static const VMStateDescription vmstate_ctr =3D {
> +    .name =3D "cpu/ctr",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D ctr_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT64(env.mctrctl, RISCVCPU),
> +        VMSTATE_UINT32(env.sctrdepth, RISCVCPU),
> +        VMSTATE_UINT32(env.sctrstatus, RISCVCPU),
> +        VMSTATE_UINT64(env.vsctrctl, RISCVCPU),
> +        VMSTATE_UINT64_ARRAY(env.ctr_src, RISCVCPU, 16 << SCTRDEPTH_MAX)=
,
> +        VMSTATE_UINT64_ARRAY(env.ctr_dst, RISCVCPU, 16 << SCTRDEPTH_MAX)=
,
> +        VMSTATE_UINT64_ARRAY(env.ctr_data, RISCVCPU, 16 << SCTRDEPTH_MAX=
),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static bool pmu_needed(void *opaque)
>  {
>      RISCVCPU *cpu =3D opaque;
> @@ -461,6 +485,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          &vmstate_jvt,
>          &vmstate_elp,
>          &vmstate_ssp,
> +        &vmstate_ctr,
>          NULL
>      }
>  };
>
> --
> 2.34.1
>
>

