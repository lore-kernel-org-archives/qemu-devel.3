Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A4ED25030
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 05:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfAkc-0004UO-Qu; Mon, 12 Jan 2026 00:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vfAkV-0004Ct-LP
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 00:45:55 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vfAkU-00016X-0m
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 00:45:55 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8712507269so98527166b.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 21:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768196752; x=1768801552; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EZ5VjnL5Sy0UeLTO6+qBY8HVEoiMt9c2NkdSRbkZF8=;
 b=LufsJeVO4xiAAhGh6Eimtlc5Qxh+ni7glK9N6fSCNZAXGZ5sSamZQ1YAH8ZAlfmk1+
 Rhy2XCNSpzCsOeXZmru5vZ3z8lowpr849J0RE1j3mb3s41bOsMs3gwlcCzfnJhY/sMwd
 8byXZrZxIBygR8x3B+2RV+6vR3aDSHCd7td1F8wotlHXF63zkR749JMF8GLUHVw5K6S4
 pgpwIKMOT5K3zJE2hcyaiVVEg4Shoex4jo5Ann897UOqkEKOuTm7KiU3l/C/1sd4nNIO
 tcoXLSQ38RUlm2bqhZZgvG9MtF5fivUNm6yv+UJjRNjX6ZSn7tt07rc/Pg4cU69XVhDA
 jiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768196752; x=1768801552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9EZ5VjnL5Sy0UeLTO6+qBY8HVEoiMt9c2NkdSRbkZF8=;
 b=rEYp3skvsyO4DG8lPmJZJ+Yxt0Qf1ZId/HEvaaKazM8JikWJbJIbvNqhrJ3X2W0T6o
 1Cw/iwUHhyPtnmzPwW+k2A2j6uLtv4APLQHn/96fXOxQocrq5X8203IL/K3DYzvQTkYG
 LQl3Tfvllg2o40OBfH294vSfSWb1bfMuetxiMUjQVypFQlvwomCL2iOcsLhtODNp08WC
 MspQ9ooNAd0wnL3UAQ0dEfSmFk5osM1TnZZvI5GWhjs11IpPKTQfOrMChaan02ur8/FK
 sYlbwtE7V3TgbXozLhSAzYozBdDyhoaZjiVoH51WjJCbkd499chC+7zqtNY94u6EFz2z
 uvTQ==
X-Gm-Message-State: AOJu0Yxv5cKeMNxQfyh6+jOwHm5mUQFyIR1P2l0wMsVaYe+hT24UBqm+
 GMy9lOOHTanvH1a3UL9MlpvDKRMIPBSFsions8kyridGo2TVoDQqe2u1CxI5inwJP/BdNYwRHUO
 AYDSoWmoEiM1P9NzrVxGevZsQ0cMjnlA=
X-Gm-Gg: AY/fxX4LSztDSYcQ99EhiElW2/A1fM1lmTFNVsHEel/IetxvsY8oFV2EYLATzV7jGjm
 prqZVjHI4o3n+34IKU6JqGtn3F75OtlXEeSFT+4YZFp1WArv7EBFg2UxScY730euY3M0Gt3SzGe
 89D+yX2MfD4i6ssXZ5ukpHBuosPQsva7adiDKZNUaHYsrPzM0Hkz9yXa9ERE+oWrE3WRr/jpTKi
 TXzS+z3NPX7H/VbZ3v38Xtytr3g8AoyzsI3/Abx5NrXeAsLxoxPse/TEoM0wTXQvqoV3WhwuidY
 gzaj6dEY2QKVAUzuIbL9lA7tVQ==
X-Google-Smtp-Source: AGHT+IFXrOEQdyrKlsbcE/raglQhxvCz176/NUMINmmdezidARXtKUqPFNUvWktbhtu5vOxuzyvuC4LTbi9338X+tPw=
X-Received: by 2002:a17:907:6e90:b0:b87:1b2b:3312 with SMTP id
 a640c23a62f3a-b871b2b3e14mr188803566b.16.1768196752043; Sun, 11 Jan 2026
 21:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
 <20260108134128.2218102-2-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-2-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 12 Jan 2026 15:45:25 +1000
X-Gm-Features: AZwV_Qgb_M3SN67s4zXebwFZdh0X7JHBlnWih0u3btkPvameLsyDLbhhZ4vWWTk
Message-ID: <CAKmqyKMVthb6PboUen_a9qYF9sbpao3KMipni9NotdHzwLWReg@mail.gmail.com>
Subject: Re: [PATCH v16 01/12] target/riscv: Add cpu_set_exception_base
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 8, 2026 at 11:41=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add a new function, so we can change reset vector from platforms
> during runtime.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 16 ++++++++++++++++
>  target/riscv/cpu.h |  4 ++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8f26d8b8b0..39f2336a70 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -73,6 +73,22 @@ bool riscv_cpu_option_set(const char *optname)
>      return g_hash_table_contains(general_user_opts, optname);
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +/* This is used in runtime only. */
> +void cpu_set_exception_base(int vp_index, target_ulong address)
> +{
> +    RISCVCPU *cpu;
> +    CPUState *cs =3D qemu_get_cpu(vp_index);
> +    if (cs =3D=3D NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cpu_set_exception_base: invalid vp_index: %u",
> +                      vp_index);

We are missing a return here!

Coverity found the issue

*** CID 1644077:         Null pointer dereferences  (FORWARD_NULL)
/builds/qemu-project/qemu/target/riscv/cpu.c: 88             in
cpu_set_exception_base()
82         if (cs =3D=3D NULL) {
83             qemu_log_mask(LOG_GUEST_ERROR,
84                           "cpu_set_exception_base: invalid vp_index: %u"=
,
85                           vp_index);
86         }
87         cpu =3D RISCV_CPU(cs);
>>>     CID 1644077:         Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "cpu".
88         cpu->env.resetvec =3D address;
89     }
90     #endif
91
92     static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const
RISCVCPUConfig *src)
93     {


Can you send a patch to fix this

Alistair

> +    }
> +    cpu =3D RISCV_CPU(cs);
> +    cpu->env.resetvec =3D address;
> +}
> +#endif
> +
>  static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConf=
ig *src)
>  {
>  #define BOOL_FIELD(x) dest->x |=3D src->x;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 90b3e95105..decf1e69d9 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -674,6 +674,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState =
*env,
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>  void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address);
> +#endif
> +
>  FIELD(TB_FLAGS, MEM_IDX, 0, 3)
>  FIELD(TB_FLAGS, FS, 3, 2)
>  /* Vector flags */
> --
> 2.34.1

