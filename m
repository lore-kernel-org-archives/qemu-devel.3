Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CACCAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 01:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v485B-00037F-8v; Wed, 01 Oct 2025 21:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4859-000371-0b
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:26:07 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v484o-0002KR-Ci
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:26:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6228de280a4so955372a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 18:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759368331; x=1759973131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0d6xTVVaGa0O7F06UlJ0sV6NonZt+8NWQ/iOUNgRuz0=;
 b=H2syL/bvXiFNxznHBpEMn5HVXBS4fCXBdRiIc56KEIXDvv3XLnQz3Hsz6Zho+Xgus2
 qb6uycE26CHj6LYUJoQLIKe26exmgSgQgWXOHjV4jkf8he+i2LWbpbtoMwVHGcewPzmU
 tQMVjO0KG0m+hciI5t4ROU2SMxxWCtZu9THXHE2F48fNplfFS/yDFWRz7qFRHBkCRN16
 BgCLWdEmyH4Sw4tDhYtc4OR3AeSNlpdRjnu29+ZGTxh+rROWBj6xUMyUoEEGqHcuhrc2
 sN7jZmJK1Y75xfjxcNvkV2b4UOq6egLCZ3gAq3v6GQMVPqrLItQiNpDuhRekfLGU8OIy
 u7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759368331; x=1759973131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0d6xTVVaGa0O7F06UlJ0sV6NonZt+8NWQ/iOUNgRuz0=;
 b=TMJdADHslRW3/oD5A0YMuV35hP1+9/B91Wks85uxNyg4p80Pk3qEnfMF7+K0NEvYsY
 iliQ1pcjhfhCF8VRMxQtehXLOTuHEyzgWE1bQyoWblM6VZa+i+UTntuX3nSsWQO1KTzn
 KgYYH2kEr4lod/mYsR1giFFDhQPEpldhl/D2h4OyEM073X9PizLM/8M9BeqrXtkpxGuk
 6r8DFEsrky8i4e9p8ZYirsbD9RKDCngu0Vq1SlUiAEBM80KudWcVdGraiRCqaYZf86LT
 uVyPe+UEwjO5YnceeuzcNIpUmDUWIb44mrqkQaP03Q/kPw6yLAr0Fx59PB0tqBXKEVuV
 rfZw==
X-Gm-Message-State: AOJu0Yw5fYbOLYQJw5ve/DsaDfnqveafUOdhAbk2eutdvFiMgeH/6qXB
 euPpJdXpCbu+v8WnZ39wzZtlpZZzoqEuiRnUo9loFGM4Q4yL2D+CD6pzG83/cv3vpu9E3I2+w4A
 7rQqKXjG7W68TGYy0j6DlzJotk1Tl7aU=
X-Gm-Gg: ASbGncvIPBvXWRKhYcLCQXn8WFUk8icLP3zuLNIiaBUFn52MKOrh3t51Fw8kAMk4I6T
 xhg96vxb+tIyQnUsleaFkE4v5bqMiIhGm3kXN3f1jpERjpS3Nlxnd26Iw5bQ1omhb7WROzckkwC
 r2UIuX35pM1QWsg4j42645sW9UVWyhRIaEKfKq6og+KaXSMTLwZlIDNXxetlt71gtzauOphDTPZ
 YzLRq3QbvPLliLIQPG3PAVh4E4iMPUY5HEeirgZvrm6PMssqExLW63Bbb+S10/AQUoeUZkJ
X-Google-Smtp-Source: AGHT+IEENBqKXl7/QJqg+J4VPgf5B2VccI8HWKF395sdDp+ixKGuC/xLUDsM9f1UseQj9xOGAgJBvmF4aS8rq3r+eTU=
X-Received: by 2002:a17:906:8f07:b0:b40:8954:a8bf with SMTP id
 a640c23a62f3a-b46e0ea1cccmr509471366b.2.1759368330595; Wed, 01 Oct 2025
 18:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
 <20251001094859.2030290-3-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-3-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Oct 2025 11:25:04 +1000
X-Gm-Features: AS18NWCWdi9llyalL4EjQGXU9hZZQOIk1N6p8JUpwb_BnpwXvDYDau9Z2iLW8YI
Message-ID: <CAKmqyKNvLrdgXFe9Tu-f6V70Cv5piNwNVT8nQZGLt35vAfOGbw@mail.gmail.com>
Subject: Re: [PATCH v9 02/13] target/riscv: Add cpu_set_exception_base
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Oct 1, 2025 at 7:49=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add a new function, so we can change reset vector from platforms
> during runtime.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 14 ++++++++++++++
>  target/riscv/cpu.h |  4 ++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..74728c5371 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -73,6 +73,20 @@ bool riscv_cpu_option_set(const char *optname)
>      return g_hash_table_contains(general_user_opts, optname);
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address)

This should probably have some documentation saying that it's only for
runtime usage

Alistair

> +{
> +    CPUState *cpu_state =3D qemu_get_cpu(vp_index);
> +    if (cpu_state =3D=3D NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cpu_set_exception_base: invalid vp_index: %u",
> +                      vp_index);
> +    }
> +    RISCVCPU *vp =3D RISCV_CPU(cpu_state);
> +    vp->env.resetvec =3D address;
> +}
> +#endif
> +
>  static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConf=
ig *src)
>  {
>  #define BOOL_FIELD(x) dest->x |=3D src->x;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..34751bd414 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -672,6 +672,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState =
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

