Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128E1E77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 01:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUbzT-0000ak-0A; Sun, 05 Jan 2025 20:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUbzQ-0000aU-Cq; Sun, 05 Jan 2025 20:33:08 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUbzO-00026X-Gj; Sun, 05 Jan 2025 20:33:08 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-518ae5060d4so4158854e0c.0; 
 Sun, 05 Jan 2025 17:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736127185; x=1736731985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBTLDcdGbJ5W0EhibDgXXb1cXQuybmP2U9BnOZPnjyA=;
 b=OEWJF6c+OfrXbigXrdvZqaeWyflqN/dwYgaMPbn9jjURE+l9Fn3wsIrs/8pWMnhREt
 Sthq4y2G0EjLeq36OkriX/WDbnVLIPsrLl58C666Ogma86+nPiX9Jyf8ZbJIZe8DP0F9
 bdgdbEJe5QlR4s2eDs7gauD4cKXMFxLwuB8fvyDwcDExklCYi5sMZLXiKihhohaOazgH
 88bu2oWxDN2wo36WaPdGaQRgFfmf89WaNJy9o4l6ZVuz+RUVGqgU8dEm+kr3GcuqwKtT
 skYQY89SRPiH52O527X/V2aafoK1oRs/zV8KEz2RBiRAljaaOAJ7ng5UHKNXJib/lzlk
 SRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736127185; x=1736731985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBTLDcdGbJ5W0EhibDgXXb1cXQuybmP2U9BnOZPnjyA=;
 b=fOlPjuiecTdaVEP6SyrAS8JhIAqe0sdgt2WAPk/80TWyQyeGEKqZKyCBqGWB2AAVA7
 KbX9Y9/jO6A6gNyIoi1n+YMpFiPE9tUD26I72Db+lbK1kD3zt/CTh4hz1iQARBah0Lx3
 p7WdXDL84j1rRmeEMuPgNKwiV2gozG5SmVG0Ik1X08lfLX3FE6scUo3IQt+Ie+HlikDY
 NT/njcDsZaNdUL+M5Alcy8oQoS4IMMPkQuEdBxXUK7LpzzJEyFDlZEpNGfnqXkwmita5
 ptTFFYxk0BQxIccIo+GxMDXwE/6KXS1KMHFcMIJZF9ZybG+eLbN7uRjemJanKMo9Hoa2
 YR8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWbDhOUMNTjefrbxA3pTRsOh8je9/UNOzumTZ53OUkFyQ5MXGWm1B3RmF6SB+GWlr15e8eD11sXl9p@nongnu.org
X-Gm-Message-State: AOJu0YzPIFDthBIKy+6QoMCETwO33+IZGDt1O4o7oLAUK7l1aexqiRPj
 uBUqKFaNwMwuINugLG2rxwF8LmGE237PFTGiDpScq4HYKE+vIf9k+dX7euZ7wlGxSx9sNcg1nAV
 jTfweC73hJCqo4kroEPMdldiRSeQ=
X-Gm-Gg: ASbGncv+GVizaUcB24i9nMqC4wDc88Wy76LB78IZUfy/TP2ALd/ZnRqZgkEYRMHSq94
 1V8fU+FJcd94WcSJN4PRQR6taEuUCGavKe4Iy06qFRs4d8QFT8v39jh2ssOZK2Rmph38=
X-Google-Smtp-Source: AGHT+IFl6ib3z3NDsXbqt7Q3I3G9g9gwHXBGAcSaVsodnZidFYd90THZHl2sOZHaWwlT7e4eY9DcN1BGXB79dM1mvgk=
X-Received: by 2002:a05:6122:a17:b0:518:a0ac:1f42 with SMTP id
 71dfb90a1353d-51b75c3f4aamr34778271e0c.1.1736127185022; Sun, 05 Jan 2025
 17:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20241225123718.45991-1-ivan.klokov@syntacore.com>
 <20241225123718.45991-2-ivan.klokov@syntacore.com>
In-Reply-To: <20241225123718.45991-2-ivan.klokov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 11:32:39 +1000
Message-ID: <CAKmqyKNBYHjuQFdm=p97jLQ5oWFutBS-1HaGU4yKvLaGWWbkyg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] target/riscv: Add RISC-V CSR qtest support
To: Ivan Klokov <ivan.klokov@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Wed, Dec 25, 2024 at 10:38=E2=80=AFPM Ivan Klokov <ivan.klokov@syntacore=
.com> wrote:
>
> The RISC-V architecture supports the creation of custom
> CSR-mapped devices. It would be convenient to test them in the same way
> as MMIO-mapped devices. To do this, a new call has been added
> to read/write CSR registers.
>
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> Acked-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv_hart.c  | 56 ++++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqtest.c | 27 ++++++++++++++++++++
>  tests/qtest/libqtest.h | 14 +++++++++++
>  3 files changed, 97 insertions(+)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index bc9ffdd2d4..b8151682c0 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -22,6 +22,9 @@
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "system/reset.h"
> +#include "qemu/cutils.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/reset.h"
>  #include "hw/sysbus.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/qdev-properties.h"
> @@ -41,6 +44,55 @@ static void riscv_harts_cpu_reset(void *opaque)
>      cpu_reset(CPU(cpu));
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *v=
al)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(cpu_num));
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    int ret =3D RISCV_EXCP_NONE;
> +    if (strcmp(cmd, "get_csr") =3D=3D 0) {
> +        ret =3D riscv_csrr(env, csrno, (target_ulong *)val);
> +    } else if (strcmp(cmd, "set_csr") =3D=3D 0) {
> +        ret =3D riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
> +                MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
> +    }
> +
> +    g_assert(ret =3D=3D RISCV_EXCP_NONE);
> +}
> +
> +static bool csr_qtest_callback(CharBackend *chr, gchar **words)
> +{
> +    if (strcmp(words[0], "csr") =3D=3D 0) {
> +
> +        uint64_t cpu;
> +        uint64_t val;
> +        int rc, csr;
> +
> +        rc =3D qemu_strtou64(words[2], NULL, 0, &cpu);
> +        g_assert(rc =3D=3D 0);
> +        rc =3D qemu_strtoi(words[3], NULL, 0, &csr);
> +        g_assert(rc =3D=3D 0);
> +        rc =3D qemu_strtou64(words[4], NULL, 0, &val);
> +        g_assert(rc =3D=3D 0);
> +        csr_call(words[1], cpu, csr, &val);
> +
> +        qtest_send_prefix(chr);
> +        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
> +
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void riscv_cpu_register_csr_qtest_callback(void)
> +{
> +    static GOnce once;
> +    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback)=
;
> +}
> +#endif
> +
>  static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>                                 char *cpu_type, Error **errp)
>  {
> @@ -58,6 +110,10 @@ static void riscv_harts_realize(DeviceState *dev, Err=
or **errp)
>
>      s->harts =3D g_new0(RISCVCPU, s->num_harts);
>
> +#ifndef CONFIG_USER_ONLY
> +    riscv_cpu_register_csr_qtest_callback();
> +#endif
> +
>      for (n =3D 0; n < s->num_harts; n++) {
>          if (!riscv_hart_realize(s, n, s->cpu_type, errp)) {
>              return;
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 8de5f1fde3..4bc9643aad 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1218,6 +1218,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char=
 *name,
>      return 0;
>  }
>
> +static void qtest_rsp_csr(QTestState *s, uint64_t *val)
> +{
> +    gchar **args;
> +    uint64_t ret;
> +    int rc;
> +
> +    args =3D qtest_rsp_args(s, 3);
> +
> +    rc =3D qemu_strtou64(args[1], NULL, 16, &ret);
> +    g_assert(rc =3D=3D 0);
> +    rc =3D qemu_strtou64(args[2], NULL, 16, val);
> +    g_assert(rc =3D=3D 0);
> +
> +    g_strfreev(args);
> +}
> +
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         uint64_t *val)
> +{
> +    qtest_sendf(s, "csr %s 0x%"PRIx64" %d 0x%"PRIx64"\n",
> +                    name, cpu, csr, *val);
> +
> +    qtest_rsp_csr(s, val);
> +    return 0;
> +}
> +
>  void qtest_add_func(const char *str, void (*fn)(void))
>  {
>      gchar *path =3D g_strdup_printf("/%s/%s", qtest_get_arch(), str);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index f23d80e9e5..cd35e11d4c 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -600,6 +600,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *=
name,
>                           uint32_t nargs, uint64_t args,
>                           uint32_t nret, uint64_t ret);
>
> +/**
> + * qtest_csr_call:
> + * @s: #QTestState instance to operate on.
> + * @name: name of the command to call.
> + * @cpu: hart number.
> + * @csr: CSR number.
> + * @val: Value for reading/writing.
> + *
> + * Call an RISC-V CSR read/write function
> + */
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         unsigned long *val);
> +
>  /**
>   * qtest_bufread:
>   * @s: #QTestState instance to operate on.
> --
> 2.34.1
>
>
>

