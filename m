Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE292E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 04:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUeWZ-0000IT-Gf; Sun, 05 Jan 2025 23:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUeWW-0000I6-IJ; Sun, 05 Jan 2025 23:15:28 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUeWT-0004xW-MH; Sun, 05 Jan 2025 23:15:28 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5189105c5f5so7365119e0c.0; 
 Sun, 05 Jan 2025 20:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736136921; x=1736741721; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+YijuvzLvlveQNj1qwA5YO1o47C5PYOZoInl2EJRBk=;
 b=EBYMK0gNgH8dpyN5pKzJpXZjtrf/hPgqPA09q2Dh/KbQ4GRp9WanAI9nXetuxacp6j
 PZ+VRnADY/UQtGMghuonLizE3KUpgB053OfCKF6gIfKtyorekS+pVxUYdMxgGbw/nEvx
 KsgX/7a4vDtcuxeRwk+X9JfyP2nvlD7+0EIOn0MvxWebKfBJyAdZgdNl7R/zeAhiw10Z
 TjeM1PyfbsfX5BEruqtaVHG1Vm9Kmxf7WQw0bQMbFPDlULrAXzUG3x4zjGDsE1GcxlAU
 AN3HJLSnKYlLrmIy3EIW9VKYKpwChNpUp2FBekCYD9W6A8lyJHxzRzI+pbCD8BKoIQzh
 Kw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736136921; x=1736741721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+YijuvzLvlveQNj1qwA5YO1o47C5PYOZoInl2EJRBk=;
 b=TsPai8LYcZjRYkWR1JcWuDgWSI1jZ/pVeYIRJKKxQhDflwoQv3LknUbB5g4QXZIJbf
 V66X183hKYGjQhP/ehQffiDL3YA5HqHdE7QFioh1MNBqmZr023ASm9ZHVfSy2LM6VS3H
 UAhBQT2GX1hopgOlD2G46eLd0Q1hk/SVtza7soYGma326p4Gzix26+8qvZRgHJjwuy4f
 Z4NGQrFXlCa0oR4xnlBips3i/Fxb25F/auItzwmReOoY1QKW9nXemB4+IH1sMhNvGFjM
 PES3CrjAWEY4CwWfvfGN+vBmwHs5IxVRtPJadhNC+yLH5H/ogcf/BvKv9cs8tIhn0lZq
 zhlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpSVOhs9iZgVsSVtZo/R1Bo0mcDDs3D6JYhIHs3DqzcjrGVu3S6fnAWtiTV+nh5hi4ZlvrZ/ZESiBt@nongnu.org
X-Gm-Message-State: AOJu0Yw6k66nQ6gxlGew1BW9cC/cuXnN5LEtGcNlDIzYWHOlsot82QtK
 xJIWOF0TXZYRrvAxVl5jVl84nMBocFChmRLMVmtF65133zxGnSlVv4jIaEadrREy2qRBO3oB/cx
 c2571Za+s7evGWZXHB4pboN3frac=
X-Gm-Gg: ASbGncscGyd9aErfXJuD/hk3J8qVQhTLahXeJuDQRjDv4vCPEotLNu3DeUFgk3GvcI9
 o9/nA/VqmgaI2849JBUNKvT1xnR24c0fIRr/z+5tIMjTe9wZOXb4WbjFjjbLk/HHV+cg=
X-Google-Smtp-Source: AGHT+IFsb1UPIJgkjyNXgOfIabTOd55I0AvVhcpTojVCWqlYlZO51YnOdEn9q7z7GVosTVkCps6UBeXhnregWZoZRMQ=
X-Received: by 2002:a05:6102:26c8:b0:4b1:16f8:efcb with SMTP id
 ada2fe7eead31-4b2cc44cb38mr46706018137.17.1736136921215; Sun, 05 Jan 2025
 20:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-6-frank.chang@sifive.com>
In-Reply-To: <20241231032654.133039-6-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 14:14:55 +1000
Message-ID: <CAKmqyKOUnh-iDiN7_H1rtRq_dmXT2b=5qN9iVDf-JeD7X7OGOw@mail.gmail.com>
Subject: Re: [PATCH v11 5/6] target/riscv: Add Smrnmi cpu extension
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Tommy Wu <tommy.wu@sifive.com>
>
> This adds the properties for ISA extension Smrnmi.
>
> Also, when Smrnmi is present, the firmware (e.g., OpenSBI) must set
> mnstatus.NMIE to 1 before enabling any interrupts. Otherwise, all
> interrupts will be disabled. Since our current OpenSBI does not
> support Smrnmi yet, let's disable Smrnmi for the 'max' type CPU for
> now. We can re-enable it once OpenSBI includes proper support for it.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 2 ++
>  target/riscv/tcg/tcg-cpu.c | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6c46a2f076..b0d9e93170 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -186,6 +186,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
> @@ -1614,6 +1615,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> +    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>      MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>      MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index cbf2cf1963..c4070c948e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1421,6 +1421,12 @@ static void riscv_init_max_cpu_extensions(Object *=
obj)
>      if (env->misa_mxl !=3D MXL_RV32) {
>          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
>      }
> +
> +    /*
> +     * ext_smrnmi requires OpenSBI changes that our current
> +     * image does not have. Disable it for now.
> +     */
> +    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);

Should we log this to users so they know?

Alistair

>  }
>
>  static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> --
> 2.34.1
>
>

