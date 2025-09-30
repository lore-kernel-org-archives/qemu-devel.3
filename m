Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03438CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ouk-0005q3-KZ; Mon, 29 Sep 2025 21:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3Oug-0005mB-GT
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:12:20 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3OuY-00046I-Of
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:12:18 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-62fc14af3fbso7816188a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759194726; x=1759799526; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrd8ELwlH9lFcMWjprrKY7/FmcY3eKsbCWFrbO1oKhw=;
 b=AAUWMrpeUTKJzCISieDXzrwxCtfp69MaYZQquceAl6+iabrLuJ3U0FueTp3rf4vwzP
 UoeT88XYTYBU6AMYj+g2aKp1J0v9UZIDyhZUn3q8L87GKHg4ANhsWYVjPuwZzFusjlmg
 RbTW4E6vbQQNfRn8DeS72V9knwQhz59zyg/YcANEaYA+xrL9YSBhxeQ4GueRy8zOa6P3
 4ae+JE1YqW3+svNZ6ZXafE73a+goigCJ+Nb0pfI6+kSjpiLDcANzYVQfEe0iVn/frZEL
 hfd/elB2EDqCgsrWzMe5e8qA/J20MnfLHxENDUbW8yLsyZQLcTW3y3NBH7KaUaJPA4fd
 cVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759194726; x=1759799526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrd8ELwlH9lFcMWjprrKY7/FmcY3eKsbCWFrbO1oKhw=;
 b=lohyg/rnE9md/DyCCff4D6FSEcOaNLJi5Cbqt7m4lNgzat5sGu2JfgIs8UOxHCw1NW
 8lmHHgRuycXIGgocsKx2pjefFXJas0tKiIwJkEoYsqzrSyALxbSQsssqGSJmR0EBdmCY
 CEwumWrKILO1o4cbVaRMurHJv4HiU+57QtHFEolbZbX0Z+VnCY6BqLsIpQKuxrbr/rkR
 D5xDnJbF6lrztCo2Wu8ZjW0UounuhBUqmTuYdiYqAOq1H/YRSdoakzng4mdr8CFIBAd/
 QK1FfPuNd9ZgJW0cFYInVE2Z0ftwkXRXMBXwmGCyaoTYNWgw1DYb+qf5EHWbqqUT+sU0
 cN5w==
X-Gm-Message-State: AOJu0YxcdiCl2olqQyJdZT8rgUaHitiLEZHRJEKgeG5k2Ux+JV1cPm/i
 bhEQD/gw7Km4FghuxdPhNKJmCQUpZQrCmIn0rxWFpMVN4ugEuMjCAwHgdGn/IX6jmPcTKZR0Rsr
 BxfVn2MueGxBhGISzQExdl9NMxsU7VSg=
X-Gm-Gg: ASbGncuc63eeu+7bZ+BNXEGvzadOD8Ebb1ePUgCM5fKQ3MxbULtXmxF40HXay3uhZki
 4ZDQT39sbAAAvay6ICIBTqJ8v2V1hztPkS9UY2VSaQfqk7iea5mmWlPssipFsuAemDMlMdE9e55
 5/yjwBXlcf8R2BXyTF0japaimJZw9lHktmJQnqiCvAdwYbgrdyubFa4gm1qvVXojpp+2cDOa5Nb
 +js85visiXwWcVpUdgBdehV3ArUVAp9YIjiK1Y8vGpOsHWd
X-Google-Smtp-Source: AGHT+IFHWqwvTEfB3zr0ae9/gZM4hkvAu9XvXinMhvYLEElF31Ac+qGBPQFbYOxUXasSDuYPF4EYMpYevv/YUQjPu0E=
X-Received: by 2002:a17:906:6a27:b0:b41:873d:e21f with SMTP id
 a640c23a62f3a-b41874d564cmr229005766b.18.1759194725681; Mon, 29 Sep 2025
 18:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-5-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-5-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Sep 2025 11:11:39 +1000
X-Gm-Features: AS18NWDh81dDEGLLFfBeOLqVL0vhZIBIkdUMURhJ_wmAtNjeU4HFaGF7eXwYJIM
Message-ID: <CAKmqyKOLB1D70dD6LZhZChoZqrY9tNpVKd68EzuF_jLwYsYD2w@mail.gmail.com>
Subject: Re: [PATCH v8 04/14] target/riscv: Add MIPS P8700 CSRs
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Sep 24, 2025 at 7:22=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Define MIPS CSRs used for P8700 CPU.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c       |   3 +
>  target/riscv/cpu.h       |   3 +
>  target/riscv/meson.build |   1 +
>  target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 224 insertions(+)
>  create mode 100644 target/riscv/mips_csr.c
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6e0bd6b798..1a1ea7fe9a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3295,6 +3295,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zbb =3D true,
>          .cfg.marchid =3D 0x8000000000000201,
>          .cfg.mvendorid =3D MIPS_VENDOR_ID,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs =3D mips_csr_list,
> +#endif
>      ),
>
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 34751bd414..234210c6b6 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -987,5 +987,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit);
>  /* In th_csr.c */
>  extern const RISCVCSR th_csr_list[];
>
> +/* Implemented in mips_csr.c */
> +extern const RISCVCSR mips_csr_list[];
> +
>  const char *priv_spec_to_str(int priv_version);
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index a4bd61e52a..fbb6c8fb45 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -32,6 +32,7 @@ riscv_system_ss.add(files(
>    'debug.c',
>    'monitor.c',
>    'machine.c',
> +  'mips_csr.c',
>    'pmu.c',
>    'th_csr.c',
>    'time_helper.c',
> diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
> new file mode 100644
> index 0000000000..4b2f4eeabd
> --- /dev/null
> +++ b/target/riscv/mips_csr.c
> @@ -0,0 +1,217 @@
> +/*
> + * MIPS-specific CSRs.
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_vendorid.h"
> +
> +/* Static MIPS CSR state storage */
> +static struct {
> +    uint64_t tvec;
> +    uint64_t config[12];
> +    uint64_t pmacfg[16];  /* Fixed: was 15, should be 16 */

I don't understand this comment?

Besides that:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +} mips_csr_state;
> +
> +/* MIPS CSR */
> +#define CSR_MIPSTVEC        0x7c0
> +#define CSR_MIPSCONFIG0     0x7d0
> +#define CSR_MIPSCONFIG1     0x7d1
> +#define CSR_MIPSCONFIG2     0x7d2
> +#define CSR_MIPSCONFIG3     0x7d3
> +#define CSR_MIPSCONFIG4     0x7d4
> +#define CSR_MIPSCONFIG5     0x7d5
> +#define CSR_MIPSCONFIG6     0x7d6
> +#define CSR_MIPSCONFIG7     0x7d7
> +#define CSR_MIPSCONFIG8     0x7d8
> +#define CSR_MIPSCONFIG9     0x7d9
> +#define CSR_MIPSCONFIG10    0x7da
> +#define CSR_MIPSCONFIG11    0x7db
> +#define CSR_MIPSPMACFG0     0x7e0
> +#define CSR_MIPSPMACFG1     0x7e1
> +#define CSR_MIPSPMACFG2     0x7e2
> +#define CSR_MIPSPMACFG3     0x7e3
> +#define CSR_MIPSPMACFG4     0x7e4
> +#define CSR_MIPSPMACFG5     0x7e5
> +#define CSR_MIPSPMACFG6     0x7e6
> +#define CSR_MIPSPMACFG7     0x7e7
> +#define CSR_MIPSPMACFG8     0x7e8
> +#define CSR_MIPSPMACFG9     0x7e9
> +#define CSR_MIPSPMACFG10    0x7ea
> +#define CSR_MIPSPMACFG11    0x7eb
> +#define CSR_MIPSPMACFG12    0x7ec
> +#define CSR_MIPSPMACFG13    0x7ed
> +#define CSR_MIPSPMACFG14    0x7ee
> +#define CSR_MIPSPMACFG15    0x7ef
> +
> +static RISCVException any(CPURISCVState *env, int csrno)
> +{
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
> +{
> +    *val =3D mips_csr_state.tvec;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
> +                                     target_ulong val, uintptr_t ra)
> +{
> +    mips_csr_state.tvec =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
> +{
> +    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
> +                                       target_ulong val, uintptr_t ra)
> +{
> +    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
> +{
> +    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
> +                                       target_ulong val, uintptr_t ra)
> +{
> +    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +const RISCVCSR mips_csr_list[] =3D {
> +    {
> +        .csrno =3D CSR_MIPSTVEC,
> +        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG0,
> +        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG1,
> +        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG2,
> +        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG3,
> +        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG4,
> +        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG5,
> +        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG6,
> +        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG7,
> +        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG8,
> +        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG9,
> +        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsco=
nfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG10,
> +        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipsc=
onfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSCONFIG11,
> +        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipsc=
onfig }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG0,
> +        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG1,
> +        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG2,
> +        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG3,
> +        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG4,
> +        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG5,
> +        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG6,
> +        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG7,
> +        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG8,
> +        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG9,
> +        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspm=
acfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG10,
> +        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipsp=
macfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG11,
> +        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipsp=
macfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG12,
> +        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipsp=
macfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG13,
> +        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipsp=
macfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG14,
> +        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipsp=
macfg }
> +    },
> +    {
> +        .csrno =3D CSR_MIPSPMACFG15,
> +        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipsp=
macfg }
> +    },
> +    { },
> +};
> --
> 2.34.1
>

