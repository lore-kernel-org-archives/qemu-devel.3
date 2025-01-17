Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E6EC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYka5-0001F6-6E; Fri, 17 Jan 2025 06:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYka1-0001EV-J9; Fri, 17 Jan 2025 06:32:02 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYkZt-0006QT-L8; Fri, 17 Jan 2025 06:32:00 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5189105c5f5so1030335e0c.0; 
 Fri, 17 Jan 2025 03:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737113509; x=1737718309; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IxqJ/YBTeMJnAa+/fX7AsIbdUqiQKXNCWM3hm+e3Z8=;
 b=bF7Hf8K6ROBcVFA4B5WtFR/UNrWZKorBM7O8FdtDMcRXEdbsSuK6RHQYa+wnwTs3SK
 +fIYXn5xq11jFrK+sxHq87FzZEo2VbWFoN4aZMyuvUXmXx7rFGW740cCEwvcEXlFAx9X
 HxXzfj7M/35Bbn07eJdpmcg2J0N9tvGtiEysXyslq+hlk8eWvW8V1+nXlljBMxMG1Kss
 BycSnLQjGZ8+G8Giswt+FibmgIVvJH0/639t6IRiDUg7ZAeeT6dJJ/S057i+Hn9qHSJF
 iZSIcJJtqWUjQz7XU1+eGVQgmzsQKiUHPbqNfDzm2zVWWLR6NymciqX4aXZo1EFXdyYP
 9zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737113509; x=1737718309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4IxqJ/YBTeMJnAa+/fX7AsIbdUqiQKXNCWM3hm+e3Z8=;
 b=SMPblqZP2vkHrIJdooJDsQAFUHP9R9x7cTVjamWF5y8vcJRkknH4V2LAgUUwAAwbo7
 LvhDs6LAhGQPU74KE2u8PecAwYQtERPU0U2fXrgKGpaLf9ir5AkIZpMkVragB/kwvxzB
 gHU5IXa++3pnnisdHdHKn+R12kUBGVXbdzAP1ttK7Ur0D2YLhSrBVIvD6Fv06O1abaFr
 3ZcFjFJhafPOPVv2opU9/3mqXnhnYkWqUWNb5NH5Ifn2+u5TuMQbirmA6j8LSNaGnDMX
 bJQ3whkYqicfOjuHAN9bxooxk45Hfik622VKyp9R/dgUsKVNt7DZwdELy5bIqvBZSY5s
 cZpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ5rYAG6AjmQoa9gbfJQtFx3FLngBe6PZ2cwIAXrOjsuW4ZLdAcSdonl2Fo3L66g43J7vBmAImYdTc@nongnu.org
X-Gm-Message-State: AOJu0YyREtIaMD5yPiiOnKjvQGTdLh1X6/BXAm3tr5BqUSky2aSkc5gD
 1DRhme+/zJfCOVPwcRh5gY8l9dmOnLthmUdmbqcyZZnBvZpo413vBAITIKEgAMJ4Vy3y8iNJ8ch
 XyzOJ4lXWVLyBP+zSRDTT/wwMOcM=
X-Gm-Gg: ASbGncv1MfviOm83gzgYMDKqlnLyO1sv5TOWDVF46ZFBwz0z7g0ux2gxvHxSFQifBiT
 RdZtpB1LaBJ6rSewkcL+O7v/FhLSoamsdDnWFpSjc74BupVOoDPQpfwq5s/itenNZoBsf
X-Google-Smtp-Source: AGHT+IHDvkH1hyoSoJLt226V05FltJsAty5G0qrxDk50xU7o+I9JbwjXbwA1TEg5D9E65dMWxbEabl3KIigfW+/o6XQ=
X-Received: by 2002:a05:6122:3c90:b0:516:1ab2:9955 with SMTP id
 71dfb90a1353d-51d5b2fd549mr1363083e0c.6.1737113509035; Fri, 17 Jan 2025
 03:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20250116131539.2475785-1-cleger@rivosinc.com>
In-Reply-To: <20250116131539.2475785-1-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Jan 2025 21:31:22 +1000
X-Gm-Features: AbW1kvZUjnWlmdiVAM1g-A9yVG5KQWmCN-rELM1yKwPLoWr_Qf0-hvphN0UhImw
Message-ID: <CAKmqyKOvWVzrsaWVnrnMcWuvL7BAbbNXZaOA9fPw15nWZ_0aWg@mail.gmail.com>
Subject: Re: [PATCH v9] target/riscv: Add Smdbltrp ISA extension enable switch
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Thu, Jan 16, 2025 at 11:17=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> Add the switch to enable the Smdbltrp ISA extension and disable it for
> the max cpu. Indeed, OpenSBI when Smdbltrp is present, M-mode double
> trap is enabled by default and MSTATUS.MDT needs to be cleared to avoid
> taking a double trap. OpenSBI does not currently support it so disable
> it for the max cpu to avoid breaking regression tests.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Note: this is a resend of patch 9/9 from the double trap series which
> disables this extension for the max cpu. It can be cherry-picked as a
> direct replacement of previous commit.
>
>  target/riscv/cpu.c         |  2 ++
>  target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e3ed11b0fd..bddf1ba75e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
> +    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> @@ -1626,6 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
>
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> +    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 48be24bbbe..0a137281de 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1439,6 +1439,16 @@ static void riscv_init_max_cpu_extensions(Object *=
obj)
>          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
>          qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
>      }
> +
> +    /*
> +     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startu=
p to
> +     * avoid generating a double trap. OpenSBI does not currently suppor=
t it,
> +     * disable it for now.
> +     */
> +    if (cpu->cfg.ext_smdbltrp) {
> +        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false)=
;
> +        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
> +    }
>  }
>
>  static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> --
> 2.47.1
>
>

