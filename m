Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA366C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 01:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5Jk-0006Js-Vh; Thu, 11 Jul 2024 21:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5Jj-0006EC-Io; Thu, 11 Jul 2024 21:43:23 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5Jh-0002tW-TV; Thu, 11 Jul 2024 21:43:23 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-80fe89eaa4dso1164441241.1; 
 Thu, 11 Jul 2024 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720748598; x=1721353398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpRrwkAnk8cN+bLZuLnPeMf5sAnCIyoO32O0ueibdJM=;
 b=RFR29MBv+hu8BgrT829k1OWdijwMOh4wGeRdmh2ZB6DwnR1+gmTXEq6wOUiOL2nUV2
 5eVGnKWeMdfbzZIxapK7Q7h9Rm4fFbaD6WxwyPCLbNu3ogIxgwMoUlZcabWbfxyueZOH
 ila8v2dm+ZNqDsF7YiJkHogrMWSMEwyhAkw0pAKLlblIkSClmczv1awxro/Ff9GCsmpS
 /X9zQUgBK+0bnxpJ1H7Dj7BMOejWtGc07LcmPY3FH6K3Jw0UgYpN7nGaJq6CyIZhOc5H
 9xyE3ik7PAe+VdQmDDtBi69kpgtBLREOoW/r3ddgNXO+l/NCbt3tYPt4kvAc+YQfg1wx
 WGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720748598; x=1721353398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpRrwkAnk8cN+bLZuLnPeMf5sAnCIyoO32O0ueibdJM=;
 b=OWwP6lDplLCBtgks2tA6xvuP6vt5i+l16iE9fKbLaCjuuq361eP2m4cXdKPS+yLRUS
 44E8+R8SRYw5LnPeormjXTijJnjbYfZ2/85y3dglmcBUgCXGuXn0DQjSOqoYMZGVcqxd
 QmBJDdBSLAhtzFInhyOIhMMvctH8PoQlhWWGri70lU2N04MKhPrp2eenjRrL+Vd5F8mp
 W20n9RLCBswvF2vjNVXIo3h0qZuw5cIhGoE9coPIxormN1fzBx8XbKvaE5MlvKxQ3pJV
 eiShd0WmxUvl1SiXDaRLcCRyo6VV9UpjxZQ6yBiUwvTfAxnO75+ALNEy5v21We6okPnH
 2MJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMIR92ic3sVn2wlBJcDKhYx294nULNtUqGgUqzk1+iW8Q14NY3rHVBZ7al62tjrJDv4yKZYWn1zQuuoY1eH8a7ZcuTGMCCGZgI65wVk3rkgNsLu8AdwTIJSXmxIaiLs0gNf5wMADbbsG9ax3xVWkkfUb8zvM0sUlLdn7NvRKoFsQYg49gZhA==
X-Gm-Message-State: AOJu0Yy38OfkvAuvfbPct2nMnY6VwVhTnGrgrmRfa6Pm+oX3746EhwkS
 NVRYbB0Zm8tmXHTemXZfXP75ZVZxrYyzUtRF9doePX5cYMtKK114iKvq2tGeTyHZdjDj1sSWqjC
 dGWRVuxdA8fvEub1/fq2z53xmHv4H0dwC
X-Google-Smtp-Source: AGHT+IGWi9qkgJ4qVCHVQVD245e+aV0K3MPuGuqBmO0MXqphtj9L3juc6TtHXNuxds/SazQ02FbCsXmt+pMl1PQv3bI=
X-Received: by 2002:a05:6102:b0a:b0:48f:62bb:357c with SMTP id
 ada2fe7eead31-4911f4d8d47mr24241137.3.1720748597993; Thu, 11 Jul 2024
 18:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240612081416.29704-1-jim.shu@sifive.com>
 <20240612081416.29704-6-jim.shu@sifive.com>
In-Reply-To: <20240612081416.29704-6-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jul 2024 11:42:52 +1000
Message-ID: <CAKmqyKMPp6kq1dnzDHOx-BhJxy6K2KpFysif1DCDCBKCCEKy5A@mail.gmail.com>
Subject: Re: [RFC PATCH 05/16] target/riscv: Add CPU options of WorldGuard CPU
 extension
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Wed, Jun 12, 2024 at 6:17=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> We define CPU options for WG CSR support in RISC-V CPUs which
> can be set by machine/device emulation. The RISC-V CSR emulation
> will also check this feature for emulating WG CSRs.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  target/riscv/cpu.c         |  8 ++++++++
>  target/riscv/cpu_cfg.h     |  3 +++
>  target/riscv/tcg/tcg-cpu.c | 11 +++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 69a08e8c2c..d70eedf957 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -204,6 +204,9 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmem=
pair),
>      ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
>      ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentan=
aCondOps),
> +    ISA_EXT_DATA_ENTRY(smwg, PRIV_VERSION_1_12_0, ext_smwg),
> +    ISA_EXT_DATA_ENTRY(smwgd, PRIV_VERSION_1_12_0, ext_smwgd),
> +    ISA_EXT_DATA_ENTRY(sswg, PRIV_VERSION_1_12_0, ext_sswg),
>
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -1595,6 +1598,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>
> +    /* RISC-V WorldGuard v0.4 */
> +    MULTI_EXT_CFG_BOOL("x-smwg", ext_smwg, false),
> +    MULTI_EXT_CFG_BOOL("x-smwgd", ext_smwgd, false),
> +    MULTI_EXT_CFG_BOOL("x-sswg", ext_sswg, false),

We want to add the functionality then expose the properties, as this
is user accessible and we want to maintain bistability.

I understand this doesn't break the build, but it's a bit strange to
allow users to enable something when at this point it doesn't yet work

Alistair

> +
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e1e4f32698..23e779ae08 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -120,6 +120,9 @@ struct RISCVCPUConfig {
>      bool ext_ssaia;
>      bool ext_sscofpmf;
>      bool ext_smepmp;
> +    bool ext_smwg;
> +    bool ext_smwgd;
> +    bool ext_sswg;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 683f604d9f..dc86e6e1d5 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -726,6 +726,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->pmu_avail_ctrs =3D 0;
>      }
>
> +    /* RISC-V WorldGuard */
> +    if (cpu->cfg.ext_sswg && !cpu->cfg.ext_smwg) {
> +        error_setg(errp, "Sswg extension requires Smwg extension");
> +        return;
> +    }
> +
> +    if (cpu->cfg.ext_smwgd !=3D cpu->cfg.ext_sswg) {
> +        error_setg(errp, "Smwgd/Sswg extensions should be enabled togeth=
er");
> +        return;
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> --
> 2.17.1
>
>

