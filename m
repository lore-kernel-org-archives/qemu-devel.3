Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F3CC5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 02:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sillP-0007Jl-2D; Mon, 26 Aug 2024 22:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sillJ-0007Gm-PU; Mon, 26 Aug 2024 22:16:49 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sillH-0003vp-D4; Mon, 26 Aug 2024 22:16:49 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4fce352bd28so1431812e0c.2; 
 Mon, 26 Aug 2024 19:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724725004; x=1725329804; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjiQE/q9NtlThII72ksJOufgoPWNDFXj/yZYoBjS+HU=;
 b=fjx+aFp0A02ej3OAicr0vbpalW2F8ch4Z3KEXHM2V/l7nMSWNvjNe0zxy8kPFmJ2Om
 u/1pxwEEzuYYWzAs27qGEHk+lfbsOz3x2VW/v7rZkwZA7o8HYOzRTvbYFuam2G43e2gu
 J4Vna38qwf5H5gvcVP8s0BnMxFJyxuVMaQhmExBqIybayenpa0/izYmCForfRFRGyhFU
 GyGy5EX2PZjr7YUSh2EOOXfj6OlOrNMksDEQ7WzXeTOoy3c86vpdrbzqRqlC6TkxMImh
 23dBRFM2+cBcQARrJ3SDikaJNdHhxowoOCeJJ7yilx07hQUld5yPjsJlUfHHX6nAF+hN
 Clfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724725004; x=1725329804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjiQE/q9NtlThII72ksJOufgoPWNDFXj/yZYoBjS+HU=;
 b=dAeOFve9VRD4IwBoGh+hRy0+LLXeud+blqH16AifImIWHh4tIMBsHabOaR2PX3+eFs
 GfxLlH3namrLsvGZsiW08tfkB75jf4RCSIHVZhy2a8F71/PGnu2qZ+jOXpCscTXx1xsN
 EwXBen8Q1xnmvkOKDVYFQfB3Wrc1aYThPShsoRI1/voIvpV5s14Gfva3lqew0+DLmKET
 x1l2oK4MFBAM9fYqmHZfRJ5MNcjwLP8HzAX4A+5zgqoT4xjw9nLLqg507GlcRIJjHWht
 JmiK5Ekb/YpjF7OZEDsxWEEjERCfjoiRfbapsAC4qH/yzThirzpCwrWRVLV57hJ3aPqY
 G2ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgaSOVS7B8plU+SwSW7VjEk5qQwyqYH4/SWI12J4FUpOqwFZrIZv51NQ1UowKnw2HPSEi6pVOCX0kq@nongnu.org
X-Gm-Message-State: AOJu0YwcjPavbLVae2nSBZs+/dJTYhYnxCakq8PvldnGGN6oGALHxr/s
 QU3lM6NHk9UBAN/rmix5XfSgDvaFK4ySZA2BjT6RUF3CNjSPAGXyT9sJ6Dtb2/VRS6+V0OjBBrn
 yKQLUQqBNYfgfV4+olFR4qVimdcQ=
X-Google-Smtp-Source: AGHT+IGxkGl7XkY4nJ088Fnz5Ipv4rdL1UmJEyVTZkUtjzszn7Zu55F0MWJ3SZR4cGQs8h1uv8O+JHrDb1irmNoJags=
X-Received: by 2002:a05:6122:179f:b0:4f5:cd00:e492 with SMTP id
 71dfb90a1353d-4fd1ac47ea3mr13454216e0c.7.1724725003716; Mon, 26 Aug 2024
 19:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-2-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-2-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 12:16:17 +1000
Message-ID: <CAKmqyKNz=GL6YD_CK1Z7eeL38rnJC29pWKK+3jK=0s_7W3J84w@mail.gmail.com>
Subject: Re: [PATCH v9 01/17] target/riscv: Add zicfilp extension
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Tue, Aug 27, 2024 at 1:30=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfilp [1] riscv cpu extension enables forward control flow integrity.
> If enabled, all indirect calls must land on a landing pad instruction.
>
> This patch sets up space for zicfilp extension in cpuconfig. zicfilp
> is dependend on zicsr.
>
> [1] - https://github.com/riscv/riscv-cfi
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  target/riscv/cpu.c         | 2 ++
>  target/riscv/cpu_cfg.h     | 1 +
>  target/riscv/tcg/tcg-cpu.c | 5 +++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 33ef4eb795..5dfb3f39ab 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -106,6 +106,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>      ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>      ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
> @@ -1472,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      /* Defaults for standard extensions */
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> +    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),

This should be added in the very last patch (as its own patch) as it
exposes the feature to users. The idea is to add the feature then
allow users to enable it

Alistair

>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 120905a254..88d5defbb5 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -67,6 +67,7 @@ struct RISCVCPUConfig {
>      bool ext_zicbom;
>      bool ext_zicbop;
>      bool ext_zicboz;
> +    bool ext_zicfilp;
>      bool ext_zicond;
>      bool ext_zihintntl;
>      bool ext_zihintpause;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b8814ab753..ed19586c9d 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -623,6 +623,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->pmu_avail_ctrs =3D 0;
>      }
>
> +    if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
> +        error_setg(errp, "zicfilp extension requires zicsr extension");
> +        return;
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> --
> 2.44.0
>
>

