Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E3ED24468
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6Mp-0006iO-5V; Thu, 10 Oct 2024 23:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6Mm-0006i7-Kr; Thu, 10 Oct 2024 23:31:01 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6Mk-00042E-UW; Thu, 10 Oct 2024 23:31:00 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-84fa2fccc2dso505812241.0; 
 Thu, 10 Oct 2024 20:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728617457; x=1729222257; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIXAdZT3HyEIcwWWAzMpgKP0leZWPUnxrpGw/x2AzCQ=;
 b=UWyvL7JUBWjTgB64Syfa3vim+log0Tw4nW354QAa5stvfZ/HjnIQXCTQ9CnqpQ602V
 zdBxqwJ+WEJWhL3oHa9lHYKiHZ3/OIp6RM+5vHAsi+LRAskr+uQTYZJcY44SV5ZYzNT/
 S6Xv6+JYVUjjX6XGwCYD+NnExxqgs//uNAeimhK+l6OcbLnLhvObGzF/xwN3ODMFq6QZ
 otECmnw8ZhCf2uRN/XhPPSE9t8RgPWOwKqGuRyaVrgoNfjovm06mfWe51bBlc3sEU7Gb
 0KhvCIvHxke8IJCTBE6tuC8UObaZ6eERYOFrVGyEAuZXtulcAikIYDoKQhxgaN4Rc9J+
 qK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728617457; x=1729222257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIXAdZT3HyEIcwWWAzMpgKP0leZWPUnxrpGw/x2AzCQ=;
 b=DjNOue9aS2/6EU/El15tMyWLtoYSLwU57WfPh+pXr3LVmkDVEx4bI5njxhiisoJ5l9
 MnjVZc7j+hPLMwT//BdMrpAldlVLWTtitS9Ec0d/3VQgapejZF//Ad4hnJf/Hc58jy10
 CUocgmsbUmndAvhdb02LFjiP+BZPgp4kXrr0AEzkg/dCFFtZ+vk/+OzrFLmrAzAdH0At
 kJayulonodHmAQ30eyuqzc5ECRsL9ueohR3qFSS08kYU9tGHo9TGQNc13vgn6/Ov0T6/
 f3jCtpIhEvvs2BybMbPL274xCXibUiTusBK6jDXqxtefOAXuRCguhrzKLJaO41u0sc8Z
 ehWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA3ZyLfIbj/f+qNtPuSr9VOlfZsvdBKC3in1o4h6HTsjTN4G5rgTIf3/oK4GPQWAtWTnfLGGKfLPxq@nongnu.org
X-Gm-Message-State: AOJu0YzmyiQs1tqq6NhcRGULHlCO14xXxGlA4h/2UWgSPdzKCfVQlPpQ
 VHDZsvf2TGlB2uSOCPWoVCd2lwuk2CR8ShzeZKebM7iSyv6VDhaay5L6BvX+fYPVS8oJ1VzkV2n
 5AzZPB0dyH29RWc1SOT9/OXSc92I=
X-Google-Smtp-Source: AGHT+IHuC3BXvwCoDx+VelqXtrowoG7emfuAOksY/RiPNgwm5iM0zMbS9mjmn56InWsHiPsTWIhCAKdpfSBu5l/U5Eo=
X-Received: by 2002:a05:6102:a4e:b0:4a3:d434:de03 with SMTP id
 ada2fe7eead31-4a465a6af47mr800498137.23.1728617457589; Thu, 10 Oct 2024
 20:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-6-cleger@rivosinc.com>
In-Reply-To: <20240925115808.77874-6-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 13:30:31 +1000
Message-ID: <CAKmqyKP0ZX7C+grozW2y=YGeQAJZ0Thm5L7Q=GwiCQ=4-Dz2=A@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] target/riscv: Add Smdbltrp CSRs handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Wed, Sep 25, 2024 at 10:02=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/cpu_bits.h |  1 +
>  target/riscv/cpu_cfg.h  |  1 +
>  target/riscv/csr.c      | 15 +++++++++++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 5557a86348..62bab1bf55 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -561,6 +561,7 @@
>  #define MSTATUS_SDT         0x01000000
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> +#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
>
>  #define MSTATUS64_UXL       0x0000000300000000ULL
>  #define MSTATUS64_SXL       0x0000000C00000000ULL
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index dd804f95d4..4c4caa2b39 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -78,6 +78,7 @@ struct RISCVCPUConfig {
>      bool ext_sstc;
>      bool ext_smcntrpmf;
>      bool ext_ssdbltrp;
> +    bool ext_smdbltrp;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d8280ec956..cc1940447a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1617,6 +1617,14 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>          }
>      }
>
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +        mask |=3D MSTATUS_MDT;
> +        if ((val & MSTATUS_MDT) !=3D 0) {
> +            mstatus &=3D ~MSTATUS_MIE;
> +            val &=3D ~MSTATUS_MIE;
> +        }
> +    }

This should also be set to 1 on reset

Alistair

> +
>      if (xl !=3D MXL_RV32 || env->debugger) {
>          if (riscv_has_ext(env, RVH)) {
>              mask |=3D MSTATUS_MPV | MSTATUS_GVA;
> @@ -1655,6 +1663,13 @@ static RISCVException write_mstatush(CPURISCVState=
 *env, int csrno,
>      uint64_t valh =3D (uint64_t)val << 32;
>      uint64_t mask =3D riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GV=
A : 0;
>
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +        mask |=3D MSTATUS_MDT;
> +        if ((val & MSTATUS_MDT) !=3D 0) {
> +            env->mstatus &=3D ~MSTATUS_MIE;
> +            val &=3D ~MSTATUS_MIE;
> +        }
> +    }
>      env->mstatus =3D (env->mstatus & ~mask) | (valh & mask);
>
>      return RISCV_EXCP_NONE;
> --
> 2.45.2
>
>

