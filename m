Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99261E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 01:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUyip-0003qf-CR; Mon, 06 Jan 2025 20:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUyih-0003pb-Pc; Mon, 06 Jan 2025 20:49:24 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUyic-000482-UA; Mon, 06 Jan 2025 20:49:22 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-85bc7d126b2so6026844241.1; 
 Mon, 06 Jan 2025 17:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736214557; x=1736819357; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XAnie/5s2gCMWKjVU+TjJ4QF4swVw/ZPMzW0uwmFCA=;
 b=ap/CQoV+jsxMDs9ZYGs0h7DJhvLZNfmmOBOdFlRg5mj+KwqhA/RycYAY0xnYitkG72
 d5Bw8/9ui8oKxSMTOB/it3+sbrgNMwfAL8+2L1Mdwd0PYQBjEmH+rw9n9AQbLHLrFIu9
 0vXHQ70UDP8RDfjyEqBNUTqY1SBEgm3u5TO/uLRrvnAvicpKEU3k8DaP532z6iootAUZ
 bYhADk6At1buxysnQshYgZdqT5qKLUXN77N9NlZc9ny+ybPNdpFlFZoaBL2l2q9z4Evg
 nweA4tUUnIyGGLX5JI0Gz7yBL6fsFToESlpDGwA4nULd5O3HSFlUCH+/cRdj5kCeWfmp
 Z6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736214557; x=1736819357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XAnie/5s2gCMWKjVU+TjJ4QF4swVw/ZPMzW0uwmFCA=;
 b=v1+99KbwJeXRjSSnVwX504RRIrWkPTqNU7vq1BXk5H2mKuhx92WJurH3uBTUhp8Nto
 XZGt09IidZQzZq763zfkIiUawDiNp56WdGqkY5+zGcLuFqHqAjbD1RqiPkfYkx2TzWvb
 OqGdMrj7+xQkFKlp4hSLqc0N0CcnIfDMI+p7WwArHniaeXD1JwAFHQKkpGIC8onzZQaF
 QXiDdrd2Hyfr6vSgsil9TLitmEE0gA1THvf+EmYCykh4GAjNufnvBxy9xSOckPWfsILg
 179ja8ina0UR/OkdzkMp4HvfZ3QtTo7XpUEjwx4VhI5Wv/s/Pr4xCNwy62mIhZ047n6k
 0N0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFxQYOzNXG9EL0iQDRFMMu+7RHj45QWx7L/e94CxzgSJceVXk2/EyeLuD4mtnz6EIbrEnQsJZSV10G@nongnu.org
X-Gm-Message-State: AOJu0Yxwkv0fE11I8UXpEBGRs40bJ9zAKLcHKb+D2tVuWA91gFOtUtCX
 SSY85lgyf/FmDMy6noeaRhe7kaUkrvuPP8HixPkE75m/nzGBXq7ll2FCjRzhx2L2i0MjhUV8bq2
 aJ4yB6+8z7LRcaXNismoXvHsMlPKquSGC
X-Gm-Gg: ASbGncsYxeLAZwi1ILwPIrH3fj6OiQbfanqpvYLC9aTOlnHxNnz08OpQ5Qto3TZ1elA
 8qedXSbdx47UJeosgFmIlwZ3BEDTzQolD6FSbuO8=
X-Google-Smtp-Source: AGHT+IEaiW57mfH7Y3Gf5z5tuEB/dZwhiEmTTMTokc0HjZAXox53nWvZIfucmk/GbI/gbOBiUdWpatX+lIT9A7QR2n0=
X-Received: by 2002:a05:6102:26c2:b0:4b1:340a:ce5e with SMTP id
 ada2fe7eead31-4b2cc488b3cmr47234287137.26.1736214557361; Mon, 06 Jan 2025
 17:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20250106054336.1878291-1-frank.chang@sifive.com>
 <20250106054336.1878291-6-frank.chang@sifive.com>
In-Reply-To: <20250106054336.1878291-6-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jan 2025 11:48:51 +1000
X-Gm-Features: AbW1kvb_e-zBCT7gY6lDzm-Ak14RinTLgQF3YC5RelSeudAoBMjAye8OVymoaoE
Message-ID: <CAKmqyKNBbB3QMbcTov7FABNUt2yffGhDVp_n+ZeYNfiTof8ZqA@mail.gmail.com>
Subject: Re: [PATCH v12 5/6] target/riscv: Add Smrnmi cpu extension
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Mon, Jan 6, 2025 at 3:46=E2=80=AFPM <frank.chang@sifive.com> wrote:
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 2 ++
>  target/riscv/tcg/tcg-cpu.c | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 29d530ad85..d9bc0d124e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
> @@ -1621,6 +1622,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> +    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>      MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>      MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index e03b409248..9cfdd68fdc 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1431,6 +1431,15 @@ static void riscv_init_max_cpu_extensions(Object *=
obj)
>      if (env->misa_mxl !=3D MXL_RV32) {
>          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
>      }
> +
> +    /*
> +     * ext_smrnmi requires OpenSBI changes that our current
> +     * image does not have. Disable it for now.
> +     */
> +    if (cpu->cfg.ext_smrnmi) {
> +        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
> +        qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
> +    }
>  }
>
>  static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> --
> 2.34.1
>
>

