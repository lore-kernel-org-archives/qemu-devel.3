Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F61E77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 01:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUc1E-0001Rq-Pc; Sun, 05 Jan 2025 20:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUc1D-0001Rc-Hh; Sun, 05 Jan 2025 20:34:59 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUc1B-0002GS-TD; Sun, 05 Jan 2025 20:34:59 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5174d53437eso8329549e0c.2; 
 Sun, 05 Jan 2025 17:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736127295; x=1736732095; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsCBQLekdYyhgVJb6uWj5kFsaL2lZHZmv9dXTfKtMz0=;
 b=PUhSzWICQyzTl4edDKc90U94b9Vi0FwI+2t09y9YBIK1I48OvSlykhisRpFYmII/Hm
 hadYRTHiluoyFihU390oCdkWqLZSUSPGHrjEgI9vXeEZ0FiQOmPbsfgYUeb6pdDkcIr+
 fPFx+i8peMduvvMpyV9XsHmPmBYmk/eMOyg64yHkCLrKRzHMIIS93rPOuPuEDQBMCzqE
 RQvWpJ/3GdiLNnTaibGNBFhNdzIS/66FswpJqufGlfUqlhY1XuFKLIHaQWp5s02Aoa/B
 4YtiFT9Vz/xuxcL6xpB6bW01jA5OEX2Q4FyALcADrsBpgSzjBjruHWNcxlaLbtXY0nR0
 fQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736127295; x=1736732095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hsCBQLekdYyhgVJb6uWj5kFsaL2lZHZmv9dXTfKtMz0=;
 b=ccW2Yn8drlZGigrxeP2gLAT9PIxGkX3ovENRcZlqM6shjSgJG9qK7Wcc4nBaTd2KAn
 KAflaLhjD8nErbO0V2CwsSdcIYsXEOgg5lxlSqVMlHoRcVEd+licc6UJ42uWNZYNdpe4
 TCwaGpRg1sGj4zjuWD7W0WHmr5PaAU4CU7me4G3vZdVJ80Ob0NgfbzF1YT9m5WR5O/Ye
 QP8a54WB/+0ptkiWDitcXFFKQlAe34Xg4blHehhkDYXnjiWjYxr3ZlLDwZ66DOixTAT6
 GdXBsYh6/GKfvm2DXiLHm5Cu3Z6TXMnATHFFCJoKECmEoAiM5qhwE0TuYZl+ZZdfuten
 7lqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcxLYwzW4GSH95qZ+lrf/WMgBNfCFhKkuHpYP+/SAf3Zz6RwUPt3YsQkej20uB0qBiMX/1J/Mmk8ag@nongnu.org
X-Gm-Message-State: AOJu0YyEDUCTFUZ2+fuzVc5/SVlZ2Quk4FVJrp3SXyyoe0JgW+pTmyq3
 baSwrB89GAeAl7yvlVOVo/dqxitbb7d/gVvf/SUN3u3X/xnYZfjLvHojpXc67c25Ww78mamfA7c
 cZaTPnm+NmfOXjKDX0T6ByzJlvsQ=
X-Gm-Gg: ASbGncsqAHk48r6g6SgzJSOdsCNLvK+iwxs6g2cZY/xRiK3TU6E3BTbbV9Gx1BwsfSO
 F/H5OHVHpm0tQ/L0Uak8Sob8Avsp5y61pSyYY6VDezIY4N9sjh/z9aTcGaU9sS9xqm8s=
X-Google-Smtp-Source: AGHT+IGAUAMxQpLoPBYPcjWiSo62JBlrZoUTugZfKnPgIB3igbiPgMjJGNlAwodVjsBT0LBCtNlbRRLlsL+Ta/JIKQA=
X-Received: by 2002:a05:6122:4884:b0:518:89d9:dd99 with SMTP id
 71dfb90a1353d-51b75c2a515mr45171107e0c.3.1736127295525; Sun, 05 Jan 2025
 17:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20241225123718.45991-1-ivan.klokov@syntacore.com>
 <20241225123718.45991-3-ivan.klokov@syntacore.com>
In-Reply-To: <20241225123718.45991-3-ivan.klokov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 11:34:29 +1000
Message-ID: <CAKmqyKOHW1OhgqUAAZypmggYZNsskoqGbENbVpdTsLGU2YwGbg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] tests/qtest: QTest example for RISC-V CSR register
To: Ivan Klokov <ivan.klokov@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com
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

On Wed, Dec 25, 2024 at 10:39=E2=80=AFPM Ivan Klokov <ivan.klokov@syntacore=
.com> wrote:
>
> Added demo for reading CSR register from qtest environment.
>
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/meson.build      |  2 +-
>  tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/riscv-csr-test.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c5a70021c5..7eb1199d91 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -273,7 +273,7 @@ qtests_s390x =3D \
>  qtests_riscv32 =3D \
>    (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-wa=
tchdog-test'] : [])
>
> -qtests_riscv64 =3D \
> +qtests_riscv64 =3D ['riscv-csr-test'] + \
>    (unpack_edk2_blobs ? ['bios-tables-test'] : [])
>
>  qos_test_ss =3D ss.source_set()
> diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
> new file mode 100644
> index 0000000000..ff5c29e6c6
> --- /dev/null
> +++ b/tests/qtest/riscv-csr-test.c
> @@ -0,0 +1,56 @@
> +/*
> + * QTest testcase for RISC-V CSRs
> + *
> + * Copyright (c) 2024 Syntacore.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +#define CSR_MVENDORID       0xf11
> +#define CSR_MISELECT        0x350
> +
> +static void run_test_csr(void)
> +{
> +    uint64_t res;
> +    uint64_t val =3D 0;
> +
> +    QTestState *qts =3D qtest_init("-machine virt -cpu veyron-v1");
> +
> +    res =3D qtest_csr_call(qts, "get_csr", 0, CSR_MVENDORID, &val);
> +
> +    g_assert_cmpint(res, =3D=3D, 0);
> +    g_assert_cmpint(val, =3D=3D, 0x61f);
> +
> +    val =3D 0xff;
> +    res =3D qtest_csr_call(qts, "set_csr", 0, CSR_MISELECT, &val);
> +
> +    g_assert_cmpint(res, =3D=3D, 0);
> +
> +    val =3D 0;
> +    res =3D qtest_csr_call(qts, "get_csr", 0, CSR_MISELECT, &val);
> +
> +    g_assert_cmpint(res, =3D=3D, 0);
> +    g_assert_cmpint(val, =3D=3D, 0xff);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/cpu/csr", run_test_csr);
> +
> +    return g_test_run();
> +}
> --
> 2.34.1
>
>
>

