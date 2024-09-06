Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8D9CE7AB1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 03:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smQ1v-0004ke-Lg; Thu, 05 Sep 2024 23:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smQ1u-0004jg-78; Thu, 05 Sep 2024 23:53:02 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smQ1p-0000jd-PE; Thu, 05 Sep 2024 23:53:01 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-846bdc20098so318295241.3; 
 Thu, 05 Sep 2024 20:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725594776; x=1726199576; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86kNlzDgKPAueMptMHZsOAqJs9w2PV+QLgT+6ZStDWY=;
 b=J52kRM6VgP2MsHNjXljR+OLnKvLu3jI/BfaW8kAVWHPQHzpzpLOlsM4/Xl5imC4CAq
 /UdWZMpkVNpRGQkKgf97+tKYfBNNPxymI2zH4biJMxsc+3QcpqkW5R3HfugJed7UeAeI
 +S0NopGIKRbXIYURDpTAF94Ul9Xzf/ZUDnsrP3sKn2rZUQPw///zBATFAyyJtNOrEml+
 95EgE39xhrZofBA/Fvkm4n/8Ywc84x5+xdz1+sPhVB80E2OOkSL/pzTmnXKkQd0lURX7
 oZdVOVqHVfSGwhV5O9vqVsF/BFiOL5K6EYkO9v3K65H2FaBgFBioZ/3MfOWj990cDF0l
 jYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725594776; x=1726199576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86kNlzDgKPAueMptMHZsOAqJs9w2PV+QLgT+6ZStDWY=;
 b=nDGpB6PrTaSCy4r0IpRVsfXnMfjrybPvNW/YU3ZbkGPOAz4PBcNUTmY+dvTQlDEWa8
 7XY4y+PIICJCL91RFB8GX6YB0igqtDjlfKQBGi0VHaP6rm4Af3FcIGTivhzPO3yaXtYO
 oYLZQLfuiKMB7Us/tmpMbBoedUZ1CDlqXZiendGMb916vz7+Iazlh1KZ4VCqwRhtIwT9
 lVJFuzmJqxisF9aRv4fdscPzBkDLXslSEaiAo7NNpgsyj6qfs+52QsYPWILGhD310g1I
 N2KDEbOs1lF3/zzVf3vNdlirypLZtP5UXYBYakXjdyFklSzjCjZS+eZc8Ew2xBrTX3ox
 Xryw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpjnoGZR/+YzocLM6eXDLv5dhE5hl4tFKSW30mJcsRcPJ5fNhShAtWB30TSPtW+ITFd6Hql6F2/BU2@nongnu.org
X-Gm-Message-State: AOJu0YwESJilyJMhoX7GNJvAl4ghrkpPNE7GtLtv+7ef2GdKyW+e5Phc
 /s2oAOPG7pjJKk5IyHWnSpgDJQBRYRQVTZzOyF/418e9EvlXXlfGxtiZuZAZh7JZzv46T/AEFK+
 958i5EgvgLhT4iKCU9UUisSurEnU=
X-Google-Smtp-Source: AGHT+IFMCLB6+btF1kgkalz6jLXgHmCgGAx4tahriHoRl7JhXx66hf1PpEgNnI4T5taqf9XuNP2tgKFbDQUuPaZU7NI=
X-Received: by 2002:a05:6102:390c:b0:494:560b:6c07 with SMTP id
 ada2fe7eead31-49bde1c58cfmr1354179137.16.1725594775774; Thu, 05 Sep 2024
 20:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
 <20240819160742.27586-15-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-15-Ian.Brockbank@cirrus.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 13:52:29 +1000
Message-ID: <CAKmqyKOvk8c5U9hZey_vL2p-n3wNWyFMV_fapN6S-jDTx0vurA@mail.gmail.com>
Subject: Re: [PATCH 11/11 v2] tests: add riscv clic qtest case and a function
 in qtest
To: Ian Brockbank <Ian.Brockbank@cirrus.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Troy Song <wb-szh830103@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Tue, Aug 20, 2024 at 2:13=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirrus=
.com> wrote:
>
> This adds riscv32-clic-test.c, containing qtest test cases for configurin=
g
> CLIC (via virt machine) and for triggering interrupts.
>
> In order to detect the interrupts, qtest.c has been updated to send inter=
rupt
> information back to the test about the IRQ being delivered. Since we need=
 to
> both trigger and detect the interrupt, qtest has also been updated to all=
ow
> both an input and an output GPIO to be intercepted.
>
> Signed-off-by: Troy Song <wb-szh830103@alibaba-inc.com>
> Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
> ---
>  hw/intc/riscv_clic.c            |    4 +
>  include/sysemu/qtest.h          |    2 +
>  system/qtest.c                  |   72 +-
>  tests/qtest/libqtest.c          |    9 +
>  tests/qtest/libqtest.h          |    9 +
>  tests/qtest/meson.build         |    3 +-
>  tests/qtest/riscv32-clic-test.c | 1928 +++++++++++++++++++++++++++++++

Wow! Lots of tests.

The general qtest changes should be split into their own patches so
the qtest maintainers can easily review/ack them without worrying
about the CLIC

Alistair

>  7 files changed, 2010 insertions(+), 17 deletions(-)
>  create mode 100644 tests/qtest/riscv32-clic-test.c
>
> diff --git a/hw/intc/riscv_clic.c b/hw/intc/riscv_clic.c
> index 1800e84dfd..155ba65492 100644
> --- a/hw/intc/riscv_clic.c
> +++ b/hw/intc/riscv_clic.c
> @@ -174,6 +174,10 @@ static void riscv_clic_next_interrupt(void *opaque)
>                  clic->clicintip[active->irq] =3D 0;
>              }
>              /* Post pending interrupt for this hart */
> +            if (qtest_enabled()) {
> +                qemu_set_irq(clic->cpu_irq, qtest_encode_irq(active->irq=
, 1));
> +                return;
> +            }
>              clic->exccode =3D active->irq |
>                              mode << RISCV_EXCP_CLIC_MODE_SHIFT |
>                              level << RISCV_EXCP_CLIC_LEVEL_SHIFT;
> diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
> index c161d75165..1a34d27c6d 100644
> --- a/include/sysemu/qtest.h
> +++ b/include/sysemu/qtest.h
> @@ -34,6 +34,8 @@ void qtest_server_init(const char *qtest_chrdev, const =
char *qtest_log, Error **
>  void qtest_server_set_send_handler(void (*send)(void *, const char *),
>                                   void *opaque);
>  void qtest_server_inproc_recv(void *opaque, const char *buf);
> +
> +int qtest_encode_irq(int irqn, int level);
>  #endif
>
>  #endif
> diff --git a/system/qtest.c b/system/qtest.c
> index 12703a2045..0ba6e0fcbe 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -49,7 +49,8 @@ struct QTest {
>
>  bool qtest_allowed;
>
> -static DeviceState *irq_intercept_dev;
> +static DeviceState *irq_intercept_dev_in;
> +static DeviceState *irq_intercept_dev_out;
>  static FILE *qtest_log_fp;
>  static QTest *qtest;
>  static GString *inbuf;
> @@ -61,6 +62,14 @@ static void *qtest_server_send_opaque;
>
>  #define FMT_timeval "%.06f"
>
> +/*
> + * Encoding for passing the specific IRQ information from an interrupt h=
andler
> + * to QTest. This needs to support CLIC, which has a 12-bit interrupt nu=
mber.
> + */
> +#define QTEST_IRQN              0x0fff
> +#define QTEST_IRQN_SHIFT        0
> +#define QTEST_IRQ_LEVEL_SHIFT   12
> +
>  /**
>   * DOC: QTest Protocol
>   *
> @@ -311,6 +320,18 @@ void qtest_sendf(CharBackend *chr, const char *fmt, =
...)
>      va_end(ap);
>  }
>
> +/* Encode the IRQ number and level for QTest */
> +int qtest_encode_irq(int irqn, int level)
> +{
> +    return (irqn & QTEST_IRQN) | (level << QTEST_IRQ_LEVEL_SHIFT);
> +}
> +
> +static void qtest_decode_irq(int value, int *irqn, int *level)
> +{
> +    *irqn =3D value & QTEST_IRQN;
> +    *level =3D value >> QTEST_IRQ_LEVEL_SHIFT;
> +}
> +
>  static void qtest_irq_handler(void *opaque, int n, int level)
>  {
>      qemu_irq old_irq =3D *(qemu_irq *)opaque;
> @@ -320,6 +341,16 @@ static void qtest_irq_handler(void *opaque, int n, i=
nt level)
>          CharBackend *chr =3D &qtest->qtest_chr;
>          irq_levels[n] =3D level;
>          qtest_send_prefix(chr);
> +        if (level > 1) {
> +            int delivered_irq_num, pin_level;
> +            qtest_decode_irq(level, &delivered_irq_num, &pin_level);
> +            qtest_sendf(chr, "IRQ %s %d\n",
> +                        "delivered", delivered_irq_num);
> +            qtest_send_prefix(chr);
> +            qtest_sendf(chr, "IRQ %s %d\n",
> +                        pin_level ? "raise" : "lower", n);
> +            return;
> +        }
>          qtest_sendf(chr, "IRQ %s %d\n",
>                      level ? "raise" : "lower", n);
>      }
> @@ -369,6 +400,7 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
>          bool is_named;
>          bool is_outbound;
>          bool interception_succeeded =3D false;
> +        bool interception_duplicated =3D false;
>
>          g_assert(words[1]);
>          is_named =3D words[2] !=3D NULL;
> @@ -386,38 +418,46 @@ static void qtest_process_command(CharBackend *chr,=
 gchar **words)
>              return;
>          }
>
> -        if (irq_intercept_dev) {
> -            qtest_send_prefix(chr);
> -            if (irq_intercept_dev !=3D dev) {
> -                qtest_send(chr, "FAIL IRQ intercept already enabled\n");
> -            } else {
> -                qtest_send(chr, "OK\n");
> -            }
> -            return;
> -        }
> -
>          QLIST_FOREACH(ngl, &dev->gpios, node) {
>              /* We don't support inbound interception of named GPIOs yet =
*/
>              if (is_outbound) {
> +                if (irq_intercept_dev_out) {
> +                    if (irq_intercept_dev_out =3D=3D dev) {
> +                        interception_succeeded =3D true;
> +                    } else {
> +                        interception_duplicated =3D true;
> +                    }
> +                }
>                  /* NULL is valid and matchable, for "unnamed GPIO" */
> -                if (g_strcmp0(ngl->name, words[2]) =3D=3D 0) {
> +                else if (g_strcmp0(ngl->name, words[2]) =3D=3D 0) {
>                      int i;
>                      for (i =3D 0; i < ngl->num_out; ++i) {
>                          qtest_install_gpio_out_intercept(dev, ngl->name,=
 i);
>                      }
> +                    irq_intercept_dev_out =3D dev;
>                      interception_succeeded =3D true;
>                  }
>              } else {
> -                qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
> -                                      ngl->num_in);
> -                interception_succeeded =3D true;
> +                if (irq_intercept_dev_in) {
> +                    if (irq_intercept_dev_in =3D=3D dev) {
> +                        interception_succeeded =3D true;
> +                    } else {
> +                        interception_duplicated =3D true;
> +                    }
> +                } else {
> +                    qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
> +                                          ngl->num_in);
> +                    irq_intercept_dev_in =3D dev;
> +                    interception_succeeded =3D true;
> +                }
>              }
>          }
>
>          qtest_send_prefix(chr);
>          if (interception_succeeded) {
> -            irq_intercept_dev =3D dev;
>              qtest_send(chr, "OK\n");
> +        } else if (interception_duplicated) {
> +            qtest_send(chr, "FAIL IRQ intercept already enabled\n");
>          } else {
>              qtest_send(chr, "FAIL No intercepts installed\n");
>          }
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 1326e34291..754c78dad7 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -83,6 +83,7 @@ struct QTestState
>      int expected_status;
>      bool big_endian;
>      bool irq_level[MAX_IRQ];
> +    bool is_delivered[MAX_IRQ];
>      GString *rx;
>      QTestTransportOps ops;
>      GList *pending_events;
> @@ -499,6 +500,7 @@ static QTestState *qtest_init_internal(const char *qe=
mu_bin,
>      s->rx =3D g_string_new("");
>      for (i =3D 0; i < MAX_IRQ; i++) {
>          s->irq_level[i] =3D false;
> +        s->is_delivered[i] =3D false;
>      }
>
>      /*
> @@ -696,6 +698,8 @@ redo:
>
>          if (strcmp(words[1], "raise") =3D=3D 0) {
>              s->irq_level[irq] =3D true;
> +        } else if (strcmp(words[1], "delivered") =3D=3D 0) {
> +            s->is_delivered[irq] =3D true;
>          } else {
>              s->irq_level[irq] =3D false;
>          }
> @@ -988,6 +992,11 @@ bool qtest_get_irq(QTestState *s, int num)
>      return s->irq_level[num];
>  }
>
> +bool qtest_irq_delivered(QTestState *s, int num)
> +{
> +    return s->is_delivered[num];
> +}
> +
>  void qtest_module_load(QTestState *s, const char *prefix, const char *li=
bname)
>  {
>      qtest_sendf(s, "module_load %s %s\n", prefix, libname);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index c261b7e0b3..6bd0ada1b2 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -366,6 +366,15 @@ void qtest_module_load(QTestState *s, const char *pr=
efix, const char *libname);
>   */
>  bool qtest_get_irq(QTestState *s, int num);
>
> +/**
> + * qtest_irq_delivered:
> + * @s: #QTestState instance to operate on.
> + * @num: Interrupt to observe.
> + *
> + * Returns: Is @num interrupt delivered or not.
> + */
> +bool qtest_irq_delivered(QTestState *s, int num);
> +
>  /**
>   * qtest_irq_intercept_in:
>   * @s: #QTestState instance to operate on.
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 2f0d3ef080..3170c1b386 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -258,7 +258,8 @@ qtests_s390x =3D \
>     'migration-test']
>
>  qtests_riscv32 =3D \
> -  (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-wa=
tchdog-test'] : [])
> +  (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-wa=
tchdog-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_RISCV_CLIC') ? ['riscv32-clic-test=
'] : [])
>
>  qtests_riscv64 =3D \
>    (unpack_edk2_blobs ? ['bios-tables-test'] : [])
> diff --git a/tests/qtest/riscv32-clic-test.c b/tests/qtest/riscv32-clic-t=
est.c
> new file mode 100644
> index 0000000000..7b0102142f
> --- /dev/null
> +++ b/tests/qtest/riscv32-clic-test.c
> @@ -0,0 +1,1928 @@
> +/*
> + * QTest testcase for the RISC-V CLIC (Core Local Interrupt Controller)
> + *
> + * Copyright (c) 2021 T-Head Semiconductor Co., Ltd. All rights reserved=
.
> + * Copyright (c) 2024 Cirrus Logic, Inc
> + *      and Cirrus Logic International Semiconductor Ltd.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this program; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "libqtest-single.h"
> +
> +/*
> + * Standard arguments to qtest_start.
> + * This finishes with the machine so that machine parameters can be pass=
ed
> + * by appending the string with them. E.g. QEMU_BASE_ARGS ",clic-mode=3D=
m".
> + * QEMU_ARGS makes use of this to give more normal-looking code.
> + */
> +#define QEMU_BASE_ARGS  "-bios none -cpu rv32 -d guest_errors " \
> +                        "-machine virt,clic=3Don"
> +#define QEMU_ARGS(_machine_params) QEMU_BASE_ARGS _machine_params
> +
> +/*
> + * CLIC register addresses.
> + * The spec doesn't define a memory layout, other than to say that each
> + * CLIC should be on a 4KiB boundary if memory-mapped.
> + * This implementation makes all the CLICs contiguous, in the order M, S=
, U,
> + * and assumes the worst-case size. If there is only PRV_M and PRV_U, th=
e PRV_U
> + * registers will appear instead of the PRV_S.
> + */
> +#define VIRT_CLIC_MAX_IRQS      0x1000
> +#define VIRT_CLIC_CONTEXT_BASE  0x1000
> +#define VIRT_CLIC_INT_SIZE(_irq_count) ((_irq_count) * 4)
> +#define VIRT_CLIC_BLOCK_SIZE \
> +    (VIRT_CLIC_CONTEXT_BASE + VIRT_CLIC_INT_SIZE(VIRT_CLIC_MAX_IRQS))
> +
> +#define VIRT_CLIC_MMODE_BASE 0x2000000
> +#define VIRT_CLIC_SMODE_BASE (VIRT_CLIC_MMODE_BASE + VIRT_CLIC_BLOCK_SIZ=
E)
> +#define VIRT_CLIC_UMODE_BASE (VIRT_CLIC_SMODE_BASE + VIRT_CLIC_BLOCK_SIZ=
E)
> +
> +#define MCLICCFG_ADDR (VIRT_CLIC_MMODE_BASE + 0)
> +#define MCLICINFO_ADDR (VIRT_CLIC_MMODE_BASE + 4)
> +#define SCLICCFG_ADDR (VIRT_CLIC_SMODE_BASE + 0)
> +#define SCLICINFO_ADDR (VIRT_CLIC_SMODE_BASE + 4)
> +#define UCLICCFG_ADDR (VIRT_CLIC_UMODE_BASE + 0)
> +#define UCLICINFO_ADDR (VIRT_CLIC_UMODE_BASE + 4)
> +
> +/*
> + * Generate control register addresses for an irq
> + *
> + * @param   irq_num     IRQ to generate the addresses for
> + *
> + * Defines symbolic names for the clicintip, clicintie, clicintattr and
> + * clicintctl registers for interrupt irq_num.
> + */
> +#define GEN_CLIC_IRQ_REG(irq_num) \
> +    uint64_t clicint##irq_num##_addr =3D                                =
      \
> +    VIRT_CLIC_MMODE_BASE + 0x1000 + 4 * irq_num;                        =
   \
> +    uint64_t clicintip##irq_num##_addr =3D                              =
      \
> +    VIRT_CLIC_MMODE_BASE + 0x1000 + 4 * irq_num;                        =
   \
> +    uint64_t clicintie##irq_num##_addr =3D                              =
      \
> +    VIRT_CLIC_MMODE_BASE + 0x1001 + 4 * irq_num;                        =
   \
> +    uint64_t clicintattr##irq_num##_addr =3D                            =
      \
> +    VIRT_CLIC_MMODE_BASE + 0x1002 + 4 * irq_num;                        =
   \
> +    uint64_t clicintctl##irq_num##_addr =3D                             =
      \
> +    VIRT_CLIC_MMODE_BASE + 0x1003 + 4 * irq_num;                        =
   \
> +    uint64_t clicint##irq_num##_addr_s =3D                              =
      \
> +    VIRT_CLIC_SMODE_BASE + 0x1000 + 4 * irq_num;                        =
   \
> +    uint64_t clicintip##irq_num##_addr_s =3D                            =
      \
> +    VIRT_CLIC_SMODE_BASE + 0x1000 + 4 * irq_num;                        =
   \
> +    uint64_t clicintie##irq_num##_addr_s =3D                            =
      \
> +    VIRT_CLIC_SMODE_BASE + 0x1001 + 4 * irq_num;                        =
   \
> +    uint64_t clicintattr##irq_num##_addr_s =3D                          =
      \
> +    VIRT_CLIC_SMODE_BASE + 0x1002 + 4 * irq_num;                        =
   \
> +    uint64_t clicintctl##irq_num##_addr_s =3D                           =
      \
> +    VIRT_CLIC_SMODE_BASE + 0x1003 + 4 * irq_num;                        =
   \
> +    uint64_t clicint##irq_num##_addr_u =3D                              =
      \
> +    VIRT_CLIC_UMODE_BASE + 0x1000 + 4 * irq_num;                        =
   \
> +    uint64_t clicintip##irq_num##_addr_u =3D                            =
      \
> +    VIRT_CLIC_UMODE_BASE + 0x1000 + 4 * irq_num;                        =
   \
> +    uint64_t clicintie##irq_num##_addr_u =3D                            =
      \
> +    VIRT_CLIC_UMODE_BASE + 0x1001 + 4 * irq_num;                        =
   \
> +    uint64_t clicintattr##irq_num##_addr_u =3D                          =
      \
> +    VIRT_CLIC_UMODE_BASE + 0x1002 + 4 * irq_num;                        =
   \
> +    uint64_t clicintctl##irq_num##_addr_u =3D                           =
      \
> +    VIRT_CLIC_UMODE_BASE + 0x1003 + 4 * irq_num;
> +
> +/* test variable for configure case and we use 12 irq to test */
> +GEN_CLIC_IRQ_REG(12)
> +
> +/* test variable for interrupt case we use irq 25 and irq 26 to test */
> +GEN_CLIC_IRQ_REG(25)
> +GEN_CLIC_IRQ_REG(26)
> +
> +/*
> + * Register decodes
> + */
> +#define INTIP_SHIFT     0
> +#define INTIE_SHIFT     8
> +#define INTATTR_SHIFT   16
> +#define INTCTL_SHIFT    24
> +
> +/* CLICCFG field definitions */
> +#define MNL_MASK        0x0000000f
> +#define MNL_SHIFT       0
> +#define NMBITS_MASK_1   0x00000000      /* Only PRV_M mode */
> +#define NMBITS_MASK_2   0x00000010      /* PRV_M plus either PRV_S or PR=
V_U */
> +#define NMBITS_MASK_3   0x00000030      /* PRV_M, PRV_S and PRV_U */
> +#define NMBITS_SHIFT    4
> +#define SNL_MASK        0x000f0000
> +#define SNL_SHIFT       16
> +#define UNL_MASK        0x0f000000
> +#define UNL_SHIFT       24
> +
> +/* The bits available in the different privilege modes */
> +#define MCFG_MASK_1     (MNL_MASK | NMBITS_MASK_1)
> +#define MCFG_MASK_2     (MNL_MASK | NMBITS_MASK_2)
> +#define MCFG_MASK_3     (MNL_MASK | NMBITS_MASK_3)
> +#define MCFG_MASK       MCFG_MASK_1
> +#define SCFG_MASK       SNL_MASK
> +#define UCFG_MASK       UNL_MASK
> +#define SUCFG_MASK      (SCFG_MASK | UCFG_MASK)
> +#define MUCFG_MASK      (MCFG_MASK_2 | UCFG_MASK)
> +#define MSCFG_MASK      (MCFG_MASK_2 | SCFG_MASK)
> +#define MSUCFG_MASK     (MCFG_MASK_3 | SCFG_MASK | UCFG_MASK)
> +
> +/* CLICINTATTR field definitions */
> +#define INTATTR_SHV            0x1
> +enum INTATTR_TRIG {
> +    TRIG_LEVEL =3D 0b00,
> +    TRIG_EDGE =3D 0b01,
> +    TRIG_POS =3D 0b00,
> +    TRIG_NEG =3D 0b10,
> +
> +    TRIG_HIGH =3D TRIG_LEVEL | TRIG_POS,
> +    TRIG_LOW =3D TRIG_LEVEL | TRIG_NEG,
> +    TRIG_RISING =3D TRIG_EDGE | TRIG_POS,
> +    TRIG_FALLING =3D TRIG_EDGE | TRIG_NEG,
> +};
> +enum INTATTR_MODE {
> +    PRV_U =3D 0,
> +    PRV_S =3D 1,
> +    PRV_M =3D 3
> +};
> +#define INTATTR_TRIG_MASK      0x06
> +#define INTATTR_TRIG_SHIFT     1
> +#define INTATTR_MODE_MASK      0xC0
> +#define INTATTR_MODE_SHIFT     6
> +
> +/* Convert the byte register definitions to the 32-bit register */
> +#define REG_INTIP       0x00000001
> +#define REG_INTIE       0x00000100
> +#define REG_SHV         (INTATTR_SHV << INTATTR_SHIFT)
> +#define REG_TRIG_MASK   (INTATTR_TRIG_MASK << INTATTR_SHIFT)
> +#define REG_TRIG_SHIFT  (INTATTR_TRIG_SHIFT + INTATTR_SHIFT)
> +#define REG_MODE_MASK   (INTATTR_MODE_MASK << INTATTR_SHIFT)
> +#define REG_MODE_SHIFT  (INTATTR_MODE_SHIFT + INTATTR_SHIFT)
> +#define REG_INTCTL_MASK (0xff << INTCTL_SHIFT)
> +
> +/*
> + * Some test values, based on nmbits (_nmb)
> + */
> +#define TEST_CFG(_nmb)      ((7 << UNL_SHIFT) | (7 << SNL_SHIFT) |      =
      \
> +                             (7 << MNL_SHIFT) | ((_nmb) << NMBITS_SHIFT)=
)
> +#define TEST_CFG_M(_nmb)    (TEST_CFG(_nmb) & MCFG_MASK)    /* PRV_M onl=
y */
> +#define TEST_CFG_S(_nmb)    (TEST_CFG(_nmb) & SCFG_MASK)    /* PRV_S in =
MS */
> +#define TEST_CFG_U(_nmb)    (TEST_CFG(_nmb) & UCFG_MASK)    /* PRV_U */
> +#define TEST_CFG_SU(_nmb)   (TEST_CFG(_nmb) & SUCFG_MASK)   /* PRV_S in =
MSU */
> +#define TEST_CFG_MU(_nmb)   (TEST_CFG(_nmb) & MUCFG_MASK)   /* PRV_M in =
MU */
> +#define TEST_CFG_MS(_nmb)   (TEST_CFG(_nmb) & MSCFG_MASK)   /* PRV_M in =
MS */
> +#define TEST_CFG_MSU(_nmb)  (TEST_CFG(_nmb) & MSUCFG_MASK)  /* PRV_M in =
MSU */
> +
> +/*
> + * Generate a test function
> + *
> + * This writes to the given register, reads it back, and checks it has t=
he
> + * expected value (which may be different from the write).
> + *
> + * @param   CASE_NAME   test case name
> + * @param   WIDTH       register access width - one of b, w, l or q
> + * @param   WIDTH_BITS  value width in bits
> + * @param   reg_addr    register to write and read
> + * @param   set_value   value to write to the register
> + * @param   expected    expected value to read back from the register
> + */
> +#define GEN_CHECK_REG_MMIO(CASE_NAME, WIDTH, WIDTH_BITS, reg_addr,      =
    \
> +                           set_value, expected)                         =
    \
> +static void test_configure_##CASE_NAME(void)                            =
    \
> +{                                                                       =
    \
> +    uint##WIDTH_BITS##_t _set_value =3D set_value;                      =
      \
> +    uint##WIDTH_BITS##_t _expected =3D expected;                        =
      \
> +    write##WIDTH(reg_addr, _set_value);                                 =
    \
> +    uint##WIDTH_BITS##_t result =3D read##WIDTH(reg_addr);              =
      \
> +    g_assert_cmpuint(result, =3D=3D, _expected);                        =
        \
> +}
> +
> +/* test function for an 8-bit value */
> +#define GEN_CHECK_REG_MMIO_B(CASE_NAME, reg_addr, set_value, expected) \
> +    GEN_CHECK_REG_MMIO(CASE_NAME, b, 8, reg_addr, set_value, expected)
> +/* test function for a 16-bit value */
> +#define GEN_CHECK_REG_MMIO_W(CASE_NAME, reg_addr, set_value, expected) \
> +    GEN_CHECK_REG_MMIO(CASE_NAME, w, 16, reg_addr, set_value, expected)
> +/* test function for a 32-bit value */
> +#define GEN_CHECK_REG_MMIO_L(CASE_NAME, reg_addr, set_value, expected) \
> +    GEN_CHECK_REG_MMIO(CASE_NAME, l, 32, reg_addr, set_value, expected)
> +/* test function for a 64-bit value */
> +#define GEN_CHECK_REG_MMIO_Q(CASE_NAME, reg_addr, set_value, expected) \
> +    GEN_CHECK_REG_MMIO(CASE_NAME, q, 64, reg_addr, set_value, expected)
> +
> +
> + /* test case definitions */
> +
> +/*
> + * cliccfg tests
> + *
> + * Layout:
> + * 31:28    reserved (WPRI 0)
> + * 27:24    unlbits
> + * 23:20    reserved (WPRI 0)
> + * 19:16    snlbits
> + * 15:6     reserved (WPRI 0)
> + *  5:4     nmbits
> + *  3:0     mnlbits
> + */
> +
> +/*
> + * Set the minimum mnlbits
> + * set nmbits =3D 0, mnlbits =3D 0, snlbits =3D 0, unlbits =3D 0
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_min_mnlbits, MCLICCFG_ADDR, 0x0, 0x0)
> +
> +/*
> + * Set the max supported mnlbits
> + * set nmbits =3D 0, mnlbits =3D 8, snlbits =3D 0, unlbits =3D 0
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_supported_max_mnlbits, MCLICCFG_ADDR, 0x8, =
0x8)
> +
> +/*
> + * Set mnlbits to an unsupported value
> + * set nmbits =3D 0, mnlbits =3D 10, snlbits =3D 0, unlbits =3D 0
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_unsupported_mnlbits, MCLICCFG_ADDR, 0xA, 0x=
8)
> +
> +/*
> + * Set the minimum snlbits
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 0, unlbits =3D 0
> + * Requires PRV_S mode
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_min_snlbits_s, MCLICCFG_ADDR, 0x00004, 0x00=
004)
> +
> +/*
> + * Set the max supported snlbits
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 8, unlbits =3D 0
> + * Requires PRV_S mode
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_supported_max_snlbits_s, MCLICCFG_ADDR,
> +                     0x80004, 0x80004)
> +
> +/*
> + * Set snlbits to an unsupported value
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 10, unlbits =3D 0
> + * Requires PRV_S mode
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_unsupported_snlbits_s, MCLICCFG_ADDR,
> +                     0xA0004, 0x80004)
> +
> +/*
> + * Set snlbits with no PRV_S support
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 8, unlbits =3D 0
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_snlbits_no_s, MCLICCFG_ADDR, 0x80004, 0x000=
04)
> +
> +/*
> + * Set the minimum unlbits
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 0, unlbits =3D 0
> + * Requires PRV_S mode
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_min_unlbits_u, MCLICCFG_ADDR, 0x0000004, 0x=
0000004)
> +
> +/*
> + * Set the max supported unlbits
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 0, unlbits =3D 8
> + * Requires PRV_U mode
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_supported_max_unlbits_u, MCLICCFG_ADDR,
> +                     0x8000004, 0x8000004)
> +
> +/*
> + * Set unlbits to an unsupported value
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 0, unlbits =3D 10
> + * Requires PRV_U mode
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_unsupported_unlbits_u, MCLICCFG_ADDR,
> +                     0xA000004, 0x8000004)
> +
> +/*
> + * Set unlbits with no PRV_U support
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 0, unlbits =3D 8
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_unlbits_no_u, MCLICCFG_ADDR, 0x8000004, 0x0=
000004)
> +
> +/*
> + * Set all modes
> + * set nmbits =3D 0, mnlbits =3D 4, snlbits =3D 2, unlbits =3D 2
> + * Requires PRV_S + PRV_U mode
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_xnlbits, MCLICCFG_ADDR, 0x2020004, 0x202000=
4)
> +
> +/*
> + * nmbits =3D 0
> + * set nmbits =3D 0, mnlbits =3D 8
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_nmbits_0, MCLICCFG_ADDR, 0x08, 0x08)
> +
> +/*
> + * nmbits =3D 1 needs PRV_S or PRV_U
> + * set nmbits =3D 1, mnlbits =3D 8
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_nmbits_1, MCLICCFG_ADDR, 0x18, 0x18)
> +GEN_CHECK_REG_MMIO_L(cliccfg_unsupported_nmbits_1, MCLICCFG_ADDR, 0x18, =
0x08)
> +
> +/*
> + * nmbits =3D 2 needs PRV_S and PRV_U
> + * set nmbits =3D 2, mnlbits =3D 8
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_nmbits_2, MCLICCFG_ADDR, 0x28, 0x28)
> +GEN_CHECK_REG_MMIO_L(cliccfg_unsupported_nmbits_2, MCLICCFG_ADDR, 0x28, =
0x08)
> +
> +/*
> + * nmbits =3D 3 is not supported
> + * set nmbits =3D 3, mnlbits =3D 8
> + */
> +GEN_CHECK_REG_MMIO_L(cliccfg_unsupported_nmbits_3, MCLICCFG_ADDR, 0x38, =
0x08)
> +
> +/*
> + * clicintie tests
> + *
> + * Layout:
> + *  [0]     enable: 1 =3D enabled, 0 =3D disabled
> + */
> +
> +/* set clicintie[i] =3D 0x1 and compare */
> +GEN_CHECK_REG_MMIO_B(clicintie_enable, clicintie12_addr, 0x1, 0x1)
> +
> +/* set clicintie[i] =3D 0x0 and compare */
> +GEN_CHECK_REG_MMIO_B(clicintie_disable, clicintie12_addr, 0, 0)
> +
> +/*
> + * clicintattr tests
> + *
> + * Layout:
> + *  [7:6]   mode        b00 =3D U, b01 =3D S, b10 =3D reserved, b11 =3D =
M
> + *  [5:3]   reserved
> + *  [2:1]   trig        trig[0]: 0 =3D level, 1 =3D edge; trig[1]: 0 =3D=
 pos, 1 =3D neg
> + *  [0]     shv         0 =3D non-vectored, 1 =3D vectored
> + */
> +
> +/* Mode tests - note these deliberately use different trig and int setti=
ngs */
> +/*
> + * Set mode 3 - PRV_M
> + * mode =3D b11, trig =3D b11, shv =3D b1
> + * clicintattr[i] =3D 0xc7
> + * expected
> + * mode =3D b11, tri =3D b11, shv =3D b1
> + * clicintattr[i] =3D 0xc7
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_prv_m, clicintattr12_addr,
> +                     0xc7, 0xc7)
> +
> +/*
> + * Set mode 1 - PRV_S
> + * mode =3D b01, trig =3D b10, shv =3D b0
> + * clicintattr[i] =3D 0x44
> + * expected
> + * mode =3D b01, tri =3D b10, shv =3D b0
> + * clicintattr[i] =3D 0x44
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_prv_s_supported, clicintattr12_addr,
> +                     0x44, 0x44)
> +
> +/*
> + * Set mode 0 - PRV_U
> + * mode =3D b00, trig =3D b01, shv =3D b1
> + * clicintattr[i] =3D 0x03
> + * expected
> + * mode =3D b00, tri =3D b01, shv =3D b1
> + * clicintattr[i] =3D 0x03
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_prv_u_supported, clicintattr12_addr,
> +                     0x03, 0x03)
> +
> +/*
> + * WARL: clicintattr should return PRV_M for PRV_S if PRV_U and PRV_S ar=
e
> + * both unsupported or nmbits =3D 0.
> + *
> + * mode =3D b01, tri =3D b10, shv =3D b0
> + * clicintattr[i] =3D 0x44
> + * expected
> + * mode =3D b11, tri =3D b10, shv =3D b0
> + * clicintattr[i] =3D 0xc4
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_prv_s_to_m_warl, clicintattr12_addr,
> +                     0x44, 0xc4)
> +
> +/*
> + * WARL: clicintattr should return PRV_U for PRV_S if PRV_S is unsupport=
ed and
> + * nmbits =3D 1.
> + *
> + * mode =3D b01, tri =3D b10, shv =3D b0
> + * clicintattr[i] =3D 0x44
> + * expected
> + * mode =3D b11, tri =3D b10, shv =3D b0
> + * clicintattr[i] =3D 0x04
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_prv_s_to_u_warl, clicintattr12_addr,
> +                     0x44, 0x04)
> +
> +/*
> + * WARL: clicintattr should return PRV_M for PRV_U if PRV_U and PRV_S ar=
e
> + * both unsupported or nmbits =3D 0.
> + *
> + * mode =3D b00, tri =3D b01, shv =3D b1
> + * clicintattr[i] =3D 0x03
> + * expected
> + * mode =3D b11, tri =3D b01, shv =3D b1
> + * clicintattr[i] =3D 0xc3
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_prv_u_to_m_warl, clicintattr12_addr,
> +                     0x03, 0xc3)
> +
> +/*
> + * WARL: clicintattr should return PRV_S for PRV_U if PRV_U is unsupport=
ed and
> + * nmbits =3D 1.
> + *
> + * mode =3D b00, tri =3D b01, shv =3D b1
> + * clicintattr[i] =3D 0x03
> + * expected
> + * mode =3D b01, tri =3D b01, shv =3D b1
> + * clicintattr[i] =3D 0x43
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_prv_u_to_s_warl, clicintattr12_addr,
> +                     0x03, 0x43)
> +
> +/*
> + * Mode 2 is invalid
> + * mode =3D b10, trig =3D b00, shv =3D b0
> + * clicintattr[i] =3D 0x80
> + * expected
> + * mode =3D b11, tri =3D b00, shv =3D b1
> + * clicintattr[i] =3D 0xc1
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_unsupported_mode_10, clicintattr12_addr=
,
> +                     0x81, 0xc1)
> +
> +/*
> + * set positive edge-triggered, vectored
> + * mode =3D b11, tri =3D b01, shv =3D b1
> + * clicintattr[i] =3D 0xc1
> + * expected
> + * mode =3D b11, tri =3D b01, shv =3D b1
> + * clicintattr[i] =3D 0xc1
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_positive_edge_triggered, clicintattr12_=
addr,
> +                     0xc3, 0xc3)
> +
> +/*
> + * set negative edge-triggered, vectored
> + * mode =3D b11, tri =3D b11, shv =3D b1
> + * clicintattr[i] =3D 0xc7
> + * expected
> + * mode =3D b11, tri =3D b11, shv =3D b1
> + * clicintattr[i] =3D 0xc7
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_negative_edge_triggered, clicintattr12_=
addr,
> +                     0xc7, 0xc7)
> +
> +/*
> + * set positive level-triggered, vectored
> + * mode =3D b11, tri =3D b00, shv =3D b1
> + * clicintattr[i] =3D 0xc1
> + * expected
> + * mode =3D b11, tri =3D b00, shv =3D b1
> + * clicintattr[i] =3D 0xc1
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_positive_level_triggered, clicintattr12=
_addr,
> +                     0xc1, 0xc1)
> +
> +/*
> + * set negative level-triggered, vectored
> + * mode =3D b11, tri =3D b10, shv =3D b1
> + * clicintattr[i] =3D 0xc5
> + * expected
> + * mode =3D b11, tri =3D b00, shv =3D b1
> + * clicintattr[i] =3D 0xc5
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_negative_level_triggered, clicintattr12=
_addr,
> +                     0xc5, 0xc5)
> +
> +/*
> + * set non-vectored
> + * mode =3D b11, tri =3D b11, shv =3D b0
> + * clicintattr[i] =3D 0xc6
> + * expected
> + * mode =3D b11, tri =3D b11, shv =3D b0
> + * clicintattr[i] =3D 0xc6
> + */
> +GEN_CHECK_REG_MMIO_B(clicintattr_non_vectored, clicintattr12_addr,
> +                     0xc6, 0xc6)
> +
> +/*
> + * clicintctl tests
> + *
> + * Layout depends on mnlbits/snlbits/unlbits in mcliccfg.
> + *
> + */
> +
> +/*
> + * Test with 0 intctlbits - mask 0xff
> + * Everything rounds up
> + * clicintctl[i] =3D 0xFF
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_0_bits, clicintctl12_addr,
> +                     0x00, 0xff)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_0_bits, clicintctl12_addr,
> +                     0x21, 0xff)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_0_bits, clicintctl12_addr,
> +                     0x58, 0xff)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_0_bits, clicintctl12_addr,
> +                     0x80, 0xff)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_0_bits, clicintctl12_addr,
> +                     0xcc, 0xff)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_0_bits, clicintctl12_addr,
> +                     0xf0, 0xff)
> +
> +/*
> + * Test with 1 intctlbit - mask 0x7f
> + * The top bit is used, everything else rounds up
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_1_bits, clicintctl12_addr,
> +                     0x00, 0x7f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_1_bits, clicintctl12_addr,
> +                     0x21, 0x7f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_1_bits, clicintctl12_addr,
> +                     0x58, 0x7f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_1_bits, clicintctl12_addr,
> +                     0x80, 0xff)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_1_bits, clicintctl12_addr,
> +                     0xcc, 0xff)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_1_bits, clicintctl12_addr,
> +                     0xf0, 0xff)
> +
> +/*
> + * Test with 2 intctlbits - mask 0x3f
> + * The top 2 bits are used, everything else rounds up
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_2_bits, clicintctl12_addr,
> +                     0x00, 0x3f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_2_bits, clicintctl12_addr,
> +                     0x21, 0x3f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_2_bits, clicintctl12_addr,
> +                     0x58, 0x7f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_2_bits, clicintctl12_addr,
> +                     0x80, 0xbf)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_2_bits, clicintctl12_addr,
> +                     0xcc, 0xff)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_2_bits, clicintctl12_addr,
> +                     0xf0, 0xff)
> +
> +/*
> + * Test with 3 intctlbits - mask 0x1f
> + * The top 3 bits are used, everything else rounds up
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_3_bits, clicintctl12_addr,
> +                     0x00, 0x1f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_3_bits, clicintctl12_addr,
> +                     0x21, 0x3f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_3_bits, clicintctl12_addr,
> +                     0x58, 0x5f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_3_bits, clicintctl12_addr,
> +                     0x80, 0x9f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_3_bits, clicintctl12_addr,
> +                     0xcc, 0xdf)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_3_bits, clicintctl12_addr,
> +                     0xf0, 0xff)
> +
> +/*
> + * Test with 4 intctlbits - mask 0x0f
> + * The top 4 bits are used, everything else rounds up
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_4_bits, clicintctl12_addr,
> +                     0x00, 0x0f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_4_bits, clicintctl12_addr,
> +                     0x21, 0x2f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_4_bits, clicintctl12_addr,
> +                     0x58, 0x5f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_4_bits, clicintctl12_addr,
> +                     0x80, 0x8f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_4_bits, clicintctl12_addr,
> +                     0xcc, 0xcf)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_4_bits, clicintctl12_addr,
> +                     0xf0, 0xff)
> +
> +/*
> + * Test with 5 intctlbits - mask 0x07
> + * The top 5 bits are used, everything else rounds up
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_5_bits, clicintctl12_addr,
> +                     0x00, 0x07)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_5_bits, clicintctl12_addr,
> +                     0x21, 0x27)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_5_bits, clicintctl12_addr,
> +                     0x58, 0x5f)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_5_bits, clicintctl12_addr,
> +                     0x80, 0x87)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_5_bits, clicintctl12_addr,
> +                     0xcc, 0xcf)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_5_bits, clicintctl12_addr,
> +                     0xf0, 0xf7)
> +
> +/*
> + * Test with 6 intctlbits - mask 0x03
> + * The top 6 bits are used, everything else rounds up
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_6_bits, clicintctl12_addr,
> +                     0x00, 0x03)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_6_bits, clicintctl12_addr,
> +                     0x21, 0x23)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_6_bits, clicintctl12_addr,
> +                     0x58, 0x5b)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_6_bits, clicintctl12_addr,
> +                     0x80, 0x83)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_6_bits, clicintctl12_addr,
> +                     0xcc, 0xcf)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_6_bits, clicintctl12_addr,
> +                     0xf0, 0xf3)
> +
> +/*
> + * Test with 7 intctlbits - mask 0x01
> + * The top 7 bits are used, everything else rounds up
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_7_bits, clicintctl12_addr,
> +                     0x00, 0x01)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_7_bits, clicintctl12_addr,
> +                     0x21, 0x21)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_7_bits, clicintctl12_addr,
> +                     0x58, 0x59)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_7_bits, clicintctl12_addr,
> +                     0x80, 0x81)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_7_bits, clicintctl12_addr,
> +                     0xcc, 0xcd)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_7_bits, clicintctl12_addr,
> +                     0xf0, 0xf1)
> +
> +/*
> + * Test with 8 intctlbits - mask 0x00
> + * All bits are used
> + */
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_0_8_bits, clicintctl12_addr,
> +                     0x00, 0x00)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_33_8_bits, clicintctl12_addr,
> +                     0x21, 0x21)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_88_8_bits, clicintctl12_addr,
> +                     0x58, 0x58)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_128_8_bits, clicintctl12_addr,
> +                     0x80, 0x80)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_204_8_bits, clicintctl12_addr,
> +                     0xcc, 0xcc)
> +GEN_CHECK_REG_MMIO_B(clicintctl_set_240_8_bits, clicintctl12_addr,
> +                     0xf0, 0xf0)
> +
> +/*
> + * read clicintip[i] to result
> + * set cliccfg =3D 0x11, clicintattr[i] =3D 0x31, clicintip[i] =3D 0x1
> + * check the value of clicintip[i] that is changed or not
> + */
> +static void test_configure_clicintip_level_triggered_read_only(void)
> +{
> +    /* configure level-triggered mode */
> +    writeb(clicintattr12_addr, 0xc1);
> +    g_assert_cmpuint(readb(clicintattr12_addr), =3D=3D, 0xc1);
> +
> +    uint8_t orig_value =3D readb(clicintip12_addr);
> +    writeb(clicintip12_addr, 0x1);
> +    uint32_t result =3D readb(clicintip12_addr);
> +
> +    g_assert_cmpuint(orig_value, =3D=3D, result);
> +}
> +
> +static void boot_qemu_m(void)
> +{
> +    global_qtest =3D qtest_start(QEMU_ARGS(",clic-mode=3Dm"));
> +}
> +
> +static void boot_qemu_ms(void)
> +{
> +    global_qtest =3D qtest_start(QEMU_ARGS(",clic-mode=3Dms"));
> +}
> +
> +static void boot_qemu_mu(void)
> +{
> +    global_qtest =3D qtest_start(QEMU_ARGS(",clic-mode=3Dmu"));
> +}
> +
> +static void boot_qemu_msu(void)
> +{
> +    global_qtest =3D qtest_start(QEMU_ARGS(",clic-mode=3Dmsu"));
> +}
> +
> +#define GEN_BOOT_QEMU_INTCTL(_nbits)                                    =
    \
> +static void boot_qemu_##_nbits##_bits(void)                             =
    \
> +{                                                                       =
    \
> +    global_qtest =3D qtest_initf(QEMU_BASE_ARGS                         =
      \
> +                               ",clic-mode=3Dmsu,clic-intctlbits=3D%d", =
        \
> +                               _nbits);                                 =
    \
> +}
> +
> +static void shut_down_qemu(void)
> +{
> +    qtest_quit(global_qtest);
> +}
> +
> +/*
> + * test vectored positive level triggered interrupt
> + * test points:
> + * 1. we use interrupt 25 and 26 to test arbitration in two situation:
> + *    same level, different level.
> + * 2. within level triggered mode, we can only use device to clear pendi=
ng.
> + * 3. within positive level triggered mode, set gpio-in rise
> + *    to trigger interrupt.
> + */
> +static void test_vectored_positive_level_triggered_interrupt(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_BASE_ARGS);
> +    /* intercept in and out irq */
> +    qtest_irq_intercept_out(qts, "/machine/unattached/device[1]");
> +    qtest_irq_intercept_in(qts, "/machine/unattached/device[1]");
> +
> +    /* configure */
> +    qtest_writeb(qts, MCLICCFG_ADDR, 0x1);
> +    qtest_writeb(qts, clicintattr25_addr, 0xc1);
> +    qtest_writeb(qts, clicintattr26_addr, 0xc1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set pending */
> +    /* arbitration will be made and 26 will be delivered */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_true(qtest_irq_delivered(qts, 26));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    /*
> +     * level trigger wouldn't auto clear clear pending,
> +     * so we need to manually do it.
> +     */
> +    qtest_writeb(qts, clicintie25_addr, 0);
> +    qtest_writeb(qts, clicintie26_addr, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 0, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set interrupt 25 level 255, interrupt 26 level 127 */
> +    /* arbitration will be made and 25 will rise */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintctl25_addr, 0xbf);
> +    qtest_writeb(qts, clicintctl26_addr, 0x3f);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_true(qtest_irq_delivered(qts, 25));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * test vectored negative level triggered interrupt
> + * test points:
> + * 1. we use interrupt 25 and 26 to test arbitration in two situation:
> + *    same level, different level.
> + * 2. within level triggered mode, we can only use device to clear pendi=
ng.
> + * 3. within negative level triggered mode,
> + *    set gpio-in lower to trigger interrupt.
> + */
> +static void test_vectored_negative_level_triggered_interrupt(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_BASE_ARGS);
> +    /* intercept in and out irq */
> +    qtest_irq_intercept_out(qts, "/machine/unattached/device[1]");
> +    qtest_irq_intercept_in(qts, "/machine/unattached/device[1]");
> +
> +    /* configure */
> +    qtest_writeb(qts, MCLICCFG_ADDR, 0x1);
> +    qtest_writeb(qts, clicintattr25_addr, 0xc5);
> +    qtest_readb(qts, clicintattr25_addr);
> +    qtest_writeb(qts, clicintattr26_addr, 0xc5);
> +    qtest_readb(qts, clicintattr26_addr);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set pending */
> +    /* arbitration will be made and 26 will be delivered */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_true(qtest_irq_delivered(qts, 26));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    /*
> +     * level trigger wouldn't auto clear clear pending,
> +     * so we need to manually do it.
> +     */
> +    qtest_writeb(qts, clicintie25_addr, 0);
> +    qtest_writeb(qts, clicintie26_addr, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 0, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set interrupt 25 level 255, interrupt 26 level 127 */
> +    /* arbitration will be made and 25 will rise */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintctl25_addr, 0xbf);
> +    qtest_writeb(qts, clicintctl26_addr, 0x3f);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_true(qtest_irq_delivered(qts, 25));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * test vectored positive edge triggered interrupt
> + * test points:
> + * 1. we use interrupt 25 and 26 to test arbitration in two situation:
> + *    same level, different level.
> + * 2. within vectored edge triggered mode, pending bit will be
> + *    automatically cleared.
> + * 3. within positive edge triggered mode, set gpio-in from
> + *    lower to rise to trigger interrupt.
> + */
> +static void test_vectored_positive_edge_triggered_interrupt(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_BASE_ARGS);
> +    /* intercept in and out irq */
> +    qtest_irq_intercept_out(qts, "/machine/unattached/device[1]");
> +    qtest_irq_intercept_in(qts, "/machine/unattached/device[1]");
> +
> +    /* configure */
> +    qtest_writeb(qts, MCLICCFG_ADDR, 0x1);
> +    qtest_writeb(qts, clicintattr25_addr, 0xc3);
> +    qtest_writeb(qts, clicintattr26_addr, 0xc3);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set pending */
> +    /* arbitration will be made and 26 will be delivered */
> +    qtest_writeb(qts, clicintip25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintip26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_true(qtest_irq_delivered(qts, 26));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    /* vectored edge trigger will auto clear clear pending */
> +    qtest_writeb(qts, clicintie25_addr, 0);
> +    qtest_writeb(qts, clicintie26_addr, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 0, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set interrupt 25 level 255, interrupt 26 level 127 */
> +    /* arbitration will be made and 25 will rise */
> +    qtest_writeb(qts, clicintip25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintip26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintctl25_addr, 0xbf);
> +    qtest_writeb(qts, clicintctl26_addr, 0x3f);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_true(qtest_irq_delivered(qts, 25));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * test vectored negative edge triggered interrupt
> + * test points:
> + * 1. we use interrupt 25 and 26 to test arbitration in two situation:
> + *    same level, different level.
> + * 2. within vectored edge triggered mode, pending bit will be
> + *    automatically cleared.
> + * 3. within negative edge triggered mode, set gpio-in from
> + *    rise to lower to trigger interrupt.
> + */
> +static void test_vectored_negative_edge_triggered_interrupt(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_BASE_ARGS);
> +    /* intercept in and out irq */
> +    qtest_irq_intercept_out(qts, "/machine/unattached/device[1]");
> +    qtest_irq_intercept_in(qts, "/machine/unattached/device[1]");
> +
> +    /* configure */
> +    qtest_writeb(qts, MCLICCFG_ADDR, 0x1);
> +    qtest_writeb(qts, clicintattr25_addr, 0xc7);
> +    qtest_writeb(qts, clicintattr26_addr, 0xc7);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set pending */
> +    /* arbitration will be made and 26 will be delivered */
> +    qtest_writeb(qts, clicintip25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintip26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_true(qtest_irq_delivered(qts, 26));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    /* vectored edge trigger will auto clear clear pending */
> +    qtest_writeb(qts, clicintie25_addr, 0);
> +    qtest_writeb(qts, clicintie26_addr, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 0, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set interrupt 25 level 255, interrupt 26 level 127 */
> +    /* arbitration will be made and 25 will rise */
> +    qtest_writeb(qts, clicintip25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintip26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintctl25_addr, 0xbf);
> +    qtest_writeb(qts, clicintctl26_addr, 0x3f);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_true(qtest_irq_delivered(qts, 25));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * test unvectored positive level triggered interrupt
> + * test points:
> + * 1. we use interrupt 25 and 26 to test arbitration in two situation:
> + *    same level, different level.
> + * 2. within level triggered mode, we can only use device to clear pendi=
ng.
> + * 3. within positive level triggered mode, set gpio-in rise to
> + *    trigger interrupt.
> + */
> +static void test_unvectored_positive_level_triggered_interrupt(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_BASE_ARGS);
> +    /* intercept in and out irq */
> +    qtest_irq_intercept_out(qts, "/machine/unattached/device[1]");
> +    qtest_irq_intercept_in(qts, "/machine/unattached/device[1]");
> +
> +    /* configure */
> +    qtest_writeb(qts, MCLICCFG_ADDR, 0x1);
> +    qtest_writeb(qts, clicintattr25_addr, 0xc0);
> +    qtest_writeb(qts, clicintattr26_addr, 0xc0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set pending */
> +    /* arbitration will be made and 26 will be delivered */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_true(qtest_irq_delivered(qts, 26));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    /*
> +     * level trigger wouldn't auto clear clear pending,
> +     * so we need to manually do it.
> +     */
> +    qtest_writeb(qts, clicintie25_addr, 0);
> +    qtest_writeb(qts, clicintie26_addr, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 0, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set interrupt 25 level 255, interrupt 26 level 127 */
> +    /* arbitration will be made and 25 will rise */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintctl25_addr, 0xbf);
> +    qtest_writeb(qts, clicintctl26_addr, 0x3f);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    g_assert_true(qtest_irq_delivered(qts, 25));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * test unvectored negative level triggered interrupt
> + * test points:
> + * 1. we use interrupt 25 and 26 to test arbitration in two situation:
> + *    same level, different level.
> + * 2. within level triggered mode, we can only use device to clear pendi=
ng.
> + * 3. within negative level triggered mode, set gpio-in lower
> + *    to trigger interrupt.
> + */
> +static void test_unvectored_negative_level_triggered_interrupt(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_BASE_ARGS);
> +    /* intercept in and out irq */
> +    qtest_irq_intercept_out(qts, "/machine/unattached/device[1]");
> +    qtest_irq_intercept_in(qts, "/machine/unattached/device[1]");
> +
> +    /* configure */
> +    qtest_writeb(qts, MCLICCFG_ADDR, 0x1);
> +    qtest_writeb(qts, clicintattr25_addr, 0xc4);
> +    qtest_writeb(qts, clicintattr26_addr, 0xc4);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set pending */
> +    /* arbitration will be made and 26 will be delivered */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_true(qtest_irq_delivered(qts, 26));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    /*
> +     * level trigger wouldn't auto clear clear pending,
> +     * so we need to manually do it.
> +     */
> +    qtest_writeb(qts, clicintie25_addr, 0);
> +    qtest_writeb(qts, clicintie26_addr, 0);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 0, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set interrupt 25 level 255, interrupt 26 level 127 */
> +    /* arbitration will be made and 25 will rise */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintctl25_addr, 0xbf);
> +    qtest_writeb(qts, clicintctl26_addr, 0x3f);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_true(qtest_irq_delivered(qts, 25));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * test unvectored positive edge triggered interrupt
> + * test points:
> + * 1. we use interrupt 25 and 26 to test arbitration in same level
> + * 2. within unvectored edge triggered mode, pending bit can be
> + *    cleared by using nxti instruction which can't be tested in qtest.
> + * 3. within positive edge triggered mode, set gpio-in
> + *    from lower to rise to trigger interrupt.
> + */
> +static void test_unvectored_positive_edge_triggered_interrupt(void)
> +{
> +   QTestState *qts =3D qtest_start(QEMU_BASE_ARGS);
> +    /* intercept in and out irq */
> +    qtest_irq_intercept_out(qts, "/machine/unattached/device[1]");
> +    qtest_irq_intercept_in(qts, "/machine/unattached/device[1]");
> +
> +    /* configure */
> +    qtest_writeb(qts, MCLICCFG_ADDR, 0x1);
> +    qtest_writeb(qts, clicintattr25_addr, 0xc2);
> +    qtest_writeb(qts, clicintattr26_addr, 0xc2);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set pending */
> +    /* arbitration will be made and 26 will be delivered */
> +    qtest_writeb(qts, clicintip25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintip26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_true(qtest_irq_delivered(qts, 26));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * test unvectored negative edge triggered interrupt
> + * test points:
> + * 1. we use interrupt 25 and 26 to test arbitration in same level
> + * 2. within unvectored edge triggered mode, pending bit can be cleared
> + *    by using nxti instruction which can't be tested in qtest.
> + * 3. within positive edge triggered mode, set gpio-in from
> + *    rise to lower to trigger interrupt.
> + */
> +static void test_unvectored_negative_edge_triggered_interrupt(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_BASE_ARGS);
> +    /* intercept in and out irq */
> +    qtest_irq_intercept_out(qts, "/machine/unattached/device[1]");
> +    qtest_irq_intercept_in(qts, "/machine/unattached/device[1]");
> +
> +    /* configure */
> +    qtest_writeb(qts, MCLICCFG_ADDR, 0x1);
> +    qtest_writeb(qts, clicintattr25_addr, 0xc6);
> +    qtest_writeb(qts, clicintattr26_addr, 0xc6);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 1);
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 26, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 0);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 0);
> +
> +    /* set pending */
> +    /* arbitration will be made and 26 will be delivered */
> +    qtest_writeb(qts, clicintip25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintip26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintip26_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie25_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie25_addr), =3D=3D, 1);
> +    qtest_writeb(qts, clicintie26_addr, 1);
> +    g_assert_cmpuint(qtest_readb(qts, clicintie26_addr), =3D=3D, 1);
> +    /* trigger arbitration */
> +    qtest_set_irq_in(qts, "/machine/unattached/device[1]", NULL, 25, 0);
> +    g_assert_true(qtest_irq_delivered(qts, 26));
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * Test that PRV_S is a filtered view of PRV_M.
> + *
> + * IRQs configured as PRV_M in the mode field of intattr are not visible=
 via
> + * the PRV_S registers, and all registers appear as hard-wired zeros.
> + */
> +static void test_prv_s_access(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_ARGS(",clic-mode=3Dms"));
> +    int default_intattr =3D INTATTR_SHV | (TRIG_LEVEL << INTATTR_TRIG_SH=
IFT);
> +    int default_reg_value =3D (default_intattr << INTATTR_SHIFT) |
> +                            (PRV_M << REG_MODE_SHIFT) | (0x7 << INTCTL_S=
HIFT);
> +    int reg_value_2 =3D (TRIG_FALLING << REG_TRIG_SHIFT) |
> +                      (PRV_S << REG_MODE_SHIFT) | (0x5 << INTCTL_SHIFT);
> +    int value;
> +
> +    /*
> +     * Make sure of our base state using the PRV_M registers
> +     */
> +    qtest_writel(qts, MCLICCFG_ADDR, TEST_CFG(1));
> +    /* No PRV_U, so no UNLBITS */
> +    g_assert_cmpuint(qtest_readl(qts, MCLICCFG_ADDR), =3D=3D , TEST_CFG_=
MS(1));
> +
> +    qtest_writel(qts, clicint12_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint25_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    /*
> +     * Now check the PRV_S view
> +     */
> +
> +    /* We should only see the PRV_S part of CLICCFG */
> +    g_assert_cmpuint(qtest_readl(qts, SCLICCFG_ADDR), =3D=3D , TEST_CFG_=
S(1));
> +
> +    /* These are all PRV_M mode so reading via PRV_S should see them all=
 as 0 */
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr_s), =3D=3D , 0);
> +
> +    /* Writing should leave them unchanged */
> +    qtest_writel(qts, clicint12_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint25_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    /*
> +     * If we change IRQ 12 to PRV_S mode, we should now be able to see i=
t
> +     */
> +    value =3D (default_reg_value & ~REG_MODE_MASK) | (PRV_S << REG_MODE_=
SHIFT);
> +    qtest_writel(qts, clicint12_addr, value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , value)=
;
> +
> +    /* ...but not the others */
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr_s), =3D=3D , 0);
> +
> +    /* We should also be able to write to it */
> +    qtest_writel(qts, clicint12_addr_s, reg_value_2);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , reg_valu=
e_2);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , reg_va=
lue_2);
> +
> +    /* ...but not the others */
> +    qtest_writel(qts, clicint25_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * Test that PRV_U is a filtered view of PRV_M.
> + *
> + * IRQs configured as PRV_M in the mode field of intattr are not visible=
 via
> + * the PRV_U registers, and all registers appear as hard-wired zeros.
> + */
> +static void test_prv_u_access(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_ARGS(",clic-mode=3Dmu"));
> +    int default_intattr =3D INTATTR_SHV | (TRIG_LEVEL << INTATTR_TRIG_SH=
IFT);
> +    int default_reg_value =3D (default_intattr << INTATTR_SHIFT) |
> +                            (PRV_M << REG_MODE_SHIFT) | (0x7 << INTCTL_S=
HIFT);
> +    int reg_value_2 =3D (TRIG_FALLING << REG_TRIG_SHIFT) |
> +                      (PRV_U << REG_MODE_SHIFT) | (0x5 << INTCTL_SHIFT);
> +    int value;
> +
> +    /*
> +     * Make sure of our base state using the PRV_M registers
> +     */
> +    qtest_writel(qts, MCLICCFG_ADDR, TEST_CFG(1));
> +    /* No PRV_S, so no SNLBITS */
> +    g_assert_cmpuint(qtest_readl(qts, MCLICCFG_ADDR), =3D=3D , TEST_CFG_=
MU(1));
> +
> +    qtest_writel(qts, clicint12_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint25_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    /*
> +     * Now check the PRV_U view. Note we only have one additional mode, =
so we
> +     * use the xxx_addr_s register bank.
> +     */
> +
> +     /* We should only see the PRV_U part of CLICCFG */
> +    g_assert_cmpuint(qtest_readl(qts, SCLICCFG_ADDR), =3D=3D , TEST_CFG_=
U(1));
> +
> +    /* These are all PRV_M mode so reading via PRV_S should see them all=
 as 0 */
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr_s), =3D=3D , 0);
> +
> +    /* Writing should leave them unchanged */
> +    qtest_writel(qts, clicint12_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint25_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    /*
> +     * If we change IRQ 12 to PRV_U mode, we should now be able to see i=
t
> +     */
> +    value =3D (default_reg_value & ~REG_MODE_MASK) | (PRV_U << REG_MODE_=
SHIFT);
> +    qtest_writel(qts, clicint12_addr, value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , value)=
;
> +
> +    /* ...but not the others */
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr_s), =3D=3D , 0);
> +
> +    /* We should also be able to write to it */
> +    qtest_writel(qts, clicint12_addr_s, reg_value_2);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , reg_valu=
e_2);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , reg_va=
lue_2);
> +
> +    /* ...but not the others */
> +    qtest_writel(qts, clicint25_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * Test that PRV_S and PRV_U are filtered views of PRV_M.
> + *
> + * IRQs configured as PRV_M in the mode field of intattr are not visible=
 via
> + * the PRV_S or PRV_U registers, and all registers appear as hard-wired =
zeros.
> + */
> +static void test_prv_su_access(void)
> +{
> +    QTestState *qts =3D qtest_start(QEMU_ARGS(",clic-mode=3Dmsu"));
> +    int default_intattr =3D INTATTR_SHV | (TRIG_LEVEL << INTATTR_TRIG_SH=
IFT);
> +    int default_reg_value =3D (default_intattr << INTATTR_SHIFT) |
> +                            (PRV_M << REG_MODE_SHIFT) | (0x7 << INTCTL_S=
HIFT);
> +    int reg_value_2 =3D (TRIG_FALLING << REG_TRIG_SHIFT) |
> +                      (PRV_S << REG_MODE_SHIFT) | (0x5 << INTCTL_SHIFT);
> +    int reg_value_3 =3D (TRIG_RISING << REG_TRIG_SHIFT) |
> +                      (PRV_U << REG_MODE_SHIFT) | (0x2 << INTCTL_SHIFT);
> +    int reg_value_4 =3D INTATTR_SHV | (TRIG_HIGH << REG_TRIG_SHIFT) |
> +                      (PRV_U << REG_MODE_SHIFT) | (0x3 << INTCTL_SHIFT);
> +    int value;
> +
> +    /*
> +     * Make sure of our base state using the PRV_M registers
> +     */
> +    qtest_writel(qts, MCLICCFG_ADDR, TEST_CFG(2));
> +    g_assert_cmpuint(qtest_readl(qts, MCLICCFG_ADDR), =3D=3D , TEST_CFG_=
MSU(2));
> +
> +    qtest_writel(qts, clicint12_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint25_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr, default_reg_value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    /*
> +     * Now check the PRV_S view
> +     */
> +
> +     /* We should only see the PRV_S and PRV_U parts of CLICCFG */
> +    g_assert_cmpuint(qtest_readl(qts, SCLICCFG_ADDR), =3D=3D , TEST_CFG_=
SU(2));
> +
> +    /* These are all PRV_M mode so reading via PRV_S should see them all=
 as 0 */
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr_s), =3D=3D , 0);
> +
> +    /* Writing should leave them unchanged */
> +    qtest_writel(qts, clicint12_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint25_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    /*
> +     * If we change IRQ 12 to PRV_S mode, we should now be able to see i=
t
> +     */
> +    value =3D (default_reg_value & ~REG_MODE_MASK) | (PRV_S << REG_MODE_=
SHIFT);
> +    qtest_writel(qts, clicint12_addr, value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , value)=
;
> +
> +    /* ...but not the others */
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr_s), =3D=3D , 0);
> +
> +    /* We should also be able to write to it */
> +    qtest_writel(qts, clicint12_addr_s, reg_value_2);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , reg_valu=
e_2);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_s), =3D=3D , reg_va=
lue_2);
> +
> +    /* ...but not the others */
> +    qtest_writel(qts, clicint25_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr_s, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    /*
> +     * Now check the PRV_U view
> +     */
> +
> +     /* We should only see the PRV_U part of CLICCFG */
> +    g_assert_cmpuint(qtest_readl(qts, UCLICCFG_ADDR), =3D=3D , TEST_CFG_=
U(2));
> +
> +    /* These are all PRV_M or PRV_S so reading via PRV_U should see them=
 as 0 */
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_u), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_u), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr_u), =3D=3D , 0);
> +
> +    /* Writing should leave them unchanged */
> +    qtest_writel(qts, clicint12_addr_u, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , reg_valu=
e_2);
> +    qtest_writel(qts, clicint25_addr_u, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , default_=
reg_value);
> +    qtest_writel(qts, clicint26_addr_u, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    /*
> +     * If we change IRQ 25 to PRV_U mode, we should now be able to see i=
t
> +     * in both PRV_S and PRV_U modes
> +     */
> +    value =3D (default_reg_value & ~REG_MODE_MASK) | (PRV_U << REG_MODE_=
SHIFT);
> +    qtest_writel(qts, clicint25_addr, value);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , value)=
;
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_u), =3D=3D , value)=
;
> +
> +    /* ...we can't see the others in PRV_U */
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr_u), =3D=3D , 0);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr_u), =3D=3D , 0);
> +
> +    /* We should also be able to write to it from both PRV_S and PRV_U *=
/
> +    qtest_writel(qts, clicint25_addr_s, reg_value_3);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , reg_valu=
e_3);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , reg_va=
lue_3);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_u), =3D=3D , reg_va=
lue_3);
> +    qtest_writel(qts, clicint25_addr_u, reg_value_4);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr), =3D=3D , reg_valu=
e_4);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_s), =3D=3D , reg_va=
lue_4);
> +    g_assert_cmpuint(qtest_readl(qts, clicint25_addr_u), =3D=3D , reg_va=
lue_4);
> +
> +    /* ...but we still can't write to the others in PRV_U */
> +    qtest_writel(qts, clicint12_addr_u, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint12_addr), =3D=3D , reg_valu=
e_2);
> +    qtest_writel(qts, clicint26_addr_u, 0x55555555);
> +    g_assert_cmpuint(qtest_readl(qts, clicint26_addr), =3D=3D , default_=
reg_value);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Test configuration in PRV_M-only mode */
> +static void clic_configure_reg_mmio_test_case_m(void)
> +{
> +    /* Start QEMU */
> +    qtest_add_func("virt/clic/prv_m/boot_qemu_m",
> +                   boot_qemu_m);
> +
> +    /* cliccfg configure case */
> +    qtest_add_func("virt/clic/prv_m/cliccfg_min_mnlbits",
> +                   test_configure_cliccfg_min_mnlbits);
> +    qtest_add_func("virt/clic/prv_m/cliccfg_supported_max_mnlbits",
> +                   test_configure_cliccfg_supported_max_mnlbits);
> +    qtest_add_func("virt/clic/prv_m/cliccfg_unsupported_mnlbits",
> +                   test_configure_cliccfg_unsupported_mnlbits);
> +    /* snlbits and unlbits should not work */
> +    qtest_add_func("virt/clic/prv_m/cliccfg_snlbits_no_s",
> +                   test_configure_cliccfg_snlbits_no_s);
> +    qtest_add_func("virt/clic/prv_m/cliccfg_snlbits_no_u",
> +                   test_configure_cliccfg_unlbits_no_u);
> +    /* clicintip configure case */
> +    qtest_add_func("virt/clic/prv_m/clicintip_level_triggered_readonly",
> +                   test_configure_clicintip_level_triggered_read_only);
> +
> +    /* clicintie configure case */
> +    qtest_add_func("virt/clic/prv_m/clicintie_enable",
> +                   test_configure_clicintie_enable);
> +    qtest_add_func("virt/clic/prv_m/clicintie_disable",
> +                   test_configure_clicintie_disable);
> +
> +    /* clicintattr mode configure cases are all PRV_M WARL - nmbits =3D=
=3D 0*/
> +    qtest_add_func("virt/clic/prv_m/cliccfg_nmbits_0_m",
> +                   test_configure_cliccfg_nmbits_0);
> +    qtest_add_func("virt/clic/prv_m/intattr_prv_m",
> +                   test_configure_clicintattr_prv_m);
> +    qtest_add_func("virt/clic/prv_m/intattr_prv_s_to_m_warl",
> +                   test_configure_clicintattr_prv_s_to_m_warl);
> +    qtest_add_func("virt/clic/prv_m/intattr_prv_u_to_m_warl",
> +                   test_configure_clicintattr_prv_u_to_m_warl);
> +    qtest_add_func("virt/clic/prv_m/intattr_unsupported_mode_10",
> +                   test_configure_clicintattr_unsupported_mode_10);
> +
> +    /* unsupported nmbits */
> +    qtest_add_func("virt/clic/prv_m/cliccfg_unsupported_nmbits_1_m",
> +                   test_configure_cliccfg_unsupported_nmbits_1);
> +    qtest_add_func("virt/clic/prv_m/cliccfg_unsupported_nmbits_2_m",
> +                   test_configure_cliccfg_unsupported_nmbits_2);
> +    qtest_add_func("virt/clic/prv_m/cliccfg_unsupported_nmbits_3_m",
> +                   test_configure_cliccfg_unsupported_nmbits_3);
> +
> +    /* clicintattr TRIG and SHV */
> +    qtest_add_func("virt/clic/prv_m/intattr_positive_edge_triggered",
> +                   test_configure_clicintattr_positive_edge_triggered);
> +    qtest_add_func("virt/clic/prv_m/clicintattr_negative_edge_triggered"=
,
> +                   test_configure_clicintattr_negative_edge_triggered);
> +    qtest_add_func("virt/clic/prv_m/clicintattr_positive_level_triggered=
",
> +                   test_configure_clicintattr_positive_level_triggered);
> +    qtest_add_func("virt/clic/prv_m/clicintattr_negative_level_triggered=
",
> +                   test_configure_clicintattr_negative_level_triggered);
> +    qtest_add_func("virt/clic/prv_m/clicintattr_non_vectored",
> +                   test_configure_clicintattr_non_vectored);
> +
> +    /* Shut down QEMU */
> +    qtest_add_func("virt/clic/prv_m/shut_down_qemu_m",
> +                   shut_down_qemu);
> +}
> +
> +/* Test configuration in PRV_M + PRV_S mode */
> +static void clic_configure_reg_mmio_test_case_ms(void)
> +{
> +    /* Start QEMU */
> +    qtest_add_func("virt/clic/prv_ms/boot_qemu_ms",
> +                   boot_qemu_ms);
> +
> +    /* cliccfg configure cases */
> +
> +    /* mnlbits should be unaffected */
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_min_mnlbits_ms",
> +                   test_configure_cliccfg_min_mnlbits);
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_supported_max_mnlbits_ms",
> +                   test_configure_cliccfg_supported_max_mnlbits);
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_unsupported_mnlbits_ms",
> +                   test_configure_cliccfg_unsupported_mnlbits);
> +    /* snlbits should work*/
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_min_snlbits_s_ms",
> +                   test_configure_cliccfg_min_snlbits_s);
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_supported_max_snlbits_s_ms"=
,
> +                   test_configure_cliccfg_supported_max_snlbits_s);
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_unsupported_snlbits_s_ms",
> +                   test_configure_cliccfg_unsupported_snlbits_s);
> +    /* unlbits should not work */
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_unlbits_no_u_ms",
> +                   test_configure_cliccfg_unlbits_no_u);
> +
> +    /* clicintattr mode configure cases with nmbits =3D 1 */
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_nmbits_1_ms",
> +                   test_configure_cliccfg_nmbits_1);
> +    qtest_add_func("virt/clic/prv_ms/intattr_prv_m_nmbits_1",
> +                   test_configure_clicintattr_prv_m);
> +    qtest_add_func("virt/clic/prv_ms/intattr_unsupported_mode_10_nmbits_=
1",
> +                   test_configure_clicintattr_unsupported_mode_10);
> +    qtest_add_func("virt/clic/prv_ms/intattr_prv_u_to_s_warl_nmbits_1_pr=
v_m",
> +                   test_configure_clicintattr_prv_u_to_s_warl);
> +    qtest_add_func("virt/clic/prv_ms/intattr_prv_s_supported_nmbits_1",
> +                   test_configure_clicintattr_prv_s_supported);
> +    qtest_add_func("virt/clic/prv_ms/intattr_prv_u_to_s_warl_nmbits_1_pr=
v_s",
> +                   test_configure_clicintattr_prv_u_to_s_warl);
> +
> +    /* clicintattr mode configure cases with nmbits =3D 0 - PRV_M only *=
/
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_nmbits_0_ms",
> +                   test_configure_cliccfg_nmbits_0);
> +    qtest_add_func("virt/clic/prv_ms/intattr_prv_m_nmbits_0",
> +                   test_configure_clicintattr_prv_m);
> +    qtest_add_func("virt/clic/prv_ms/intattr_unsupported_mode_10_nmbits_=
0",
> +                   test_configure_clicintattr_unsupported_mode_10);
> +    qtest_add_func("virt/clic/prv_ms/intattr_prv_u_to_m_warl_nmbits_0",
> +                   test_configure_clicintattr_prv_u_to_m_warl);
> +    qtest_add_func("virt/clic/prv_ms/intattr_prv_s_to_m_warl_nmbits_0",
> +                   test_configure_clicintattr_prv_s_to_m_warl);
> +
> +    /* unsupported nmbits */
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_unsupported_nmbits_2_ms",
> +                   test_configure_cliccfg_unsupported_nmbits_2);
> +    qtest_add_func("virt/clic/prv_ms/cliccfg_unsupported_nmbits_3_ms",
> +                   test_configure_cliccfg_unsupported_nmbits_3);
> +
> +    /* clicintattr TRIG and SHV */
> +    qtest_add_func("virt/clic/prv_ms/intattr_positive_edge_triggered",
> +                   test_configure_clicintattr_positive_edge_triggered);
> +    qtest_add_func("virt/clic/prv_ms/clicintattr_negative_edge_triggered=
",
> +                   test_configure_clicintattr_negative_edge_triggered);
> +    qtest_add_func("virt/clic/prv_ms/clicintattr_positive_level_triggere=
d",
> +                   test_configure_clicintattr_positive_level_triggered);
> +    qtest_add_func("virt/clic/prv_ms/clicintattr_negative_level_triggere=
d",
> +                   test_configure_clicintattr_negative_level_triggered);
> +    qtest_add_func("virt/clic/prv_ms/clicintattr_non_vectored",
> +                   test_configure_clicintattr_non_vectored);
> +
> +    /* Shut down QEMU */
> +    qtest_add_func("virt/clic/prv_ms/shut_down_qemu_ms",
> +                   shut_down_qemu);
> +}
> +
> +/* Test configuration in PRV_M + PRV_U mode */
> +static void clic_configure_reg_mmio_test_case_mu(void)
> +{
> +    /* Start QEMU */
> +    qtest_add_func("virt/clic/prv_mu/boot_qemu_mu",
> +                   boot_qemu_mu);
> +
> +    /* cliccfg configure cases */
> +
> +    /* mnlbits should be unaffected */
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_min_mnlbits_mu",
> +                   test_configure_cliccfg_min_mnlbits);
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_supported_max_mnlbits_mu",
> +                   test_configure_cliccfg_supported_max_mnlbits);
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_unsupported_mnlbits_mu",
> +                   test_configure_cliccfg_unsupported_mnlbits);
> +    /* snlbits should not work */
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_snlbits_no_s_mu",
> +                   test_configure_cliccfg_snlbits_no_s);
> +    /* unlbits should work*/
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_min_unlbits_u_mu",
> +                   test_configure_cliccfg_min_unlbits_u);
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_uupported_max_unlbits_u_mu"=
,
> +                   test_configure_cliccfg_supported_max_unlbits_u);
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_unsupported_unlbits_u_mu",
> +                   test_configure_cliccfg_unsupported_unlbits_u);
> +
> +    /* clicintattr mode configure cases with nmbits =3D 1 */
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_nmbits_1_ms",
> +                   test_configure_cliccfg_nmbits_1);
> +    qtest_add_func("virt/clic/prv_mu/intattr_prv_m_nmbits_1",
> +                   test_configure_clicintattr_prv_m);
> +    qtest_add_func("virt/clic/prv_mu/intattr_unsupported_mode_10_nmbits_=
1",
> +                   test_configure_clicintattr_unsupported_mode_10);
> +    qtest_add_func("virt/clic/prv_mu/intattr_prv_s_to_u_warl_nmbits_1_pr=
v_m",
> +                   test_configure_clicintattr_prv_s_to_u_warl);
> +    qtest_add_func("virt/clic/prv_mu/intattr_prv_u_supported_nmbits_1",
> +                   test_configure_clicintattr_prv_u_supported);
> +    qtest_add_func("virt/clic/prv_mu/intattr_prv_s_to_u_warl_nmbits_1_pr=
v_u",
> +                   test_configure_clicintattr_prv_s_to_u_warl);
> +
> +    /* clicintattr mode configure cases with nmbits =3D 0 - PRV_M only *=
/
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_nmbits_0_ms",
> +                   test_configure_cliccfg_nmbits_0);
> +    qtest_add_func("virt/clic/prv_mu/intattr_prv_m_nmbits_0",
> +                   test_configure_clicintattr_prv_m);
> +    qtest_add_func("virt/clic/prv_mu/intattr_unsupported_mode_10_nmbits_=
0",
> +                   test_configure_clicintattr_unsupported_mode_10);
> +    qtest_add_func("virt/clic/prv_mu/intattr_prv_u_to_m_warl_nmbits_0",
> +                   test_configure_clicintattr_prv_u_to_m_warl);
> +    qtest_add_func("virt/clic/prv_mu/intattr_prv_s_to_m_warl_nmbits_0",
> +                   test_configure_clicintattr_prv_s_to_m_warl);
> +
> +    /* unsupported nmbits */
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_unsupported_nmbits_2_ms",
> +                   test_configure_cliccfg_unsupported_nmbits_2);
> +    qtest_add_func("virt/clic/prv_mu/cliccfg_unsupported_nmbits_3_ms",
> +                   test_configure_cliccfg_unsupported_nmbits_3);
> +
> +    /* clicintattr TRIG and SHV */
> +    qtest_add_func("virt/clic/prv_mu/intattr_positive_edge_triggered",
> +                   test_configure_clicintattr_positive_edge_triggered);
> +    qtest_add_func("virt/clic/prv_mu/clicintattr_negative_edge_triggered=
",
> +                   test_configure_clicintattr_negative_edge_triggered);
> +    qtest_add_func("virt/clic/prv_mu/clicintattr_positive_level_triggere=
d",
> +                   test_configure_clicintattr_positive_level_triggered);
> +    qtest_add_func("virt/clic/prv_mu/clicintattr_negative_level_triggere=
d",
> +                   test_configure_clicintattr_negative_level_triggered);
> +    qtest_add_func("virt/clic/prv_mu/clicintattr_non_vectored",
> +                   test_configure_clicintattr_non_vectored);
> +
> +    /* Shut down QEMU */
> +    qtest_add_func("virt/clic/prv_mu/shut_down_qemu_mu",
> +                   shut_down_qemu);
> +}
> +
> +/* Test configuration in PRV_M + PRV_S + PRV_U mode */
> +static void clic_configure_reg_mmio_test_case_msu(void)
> +{
> +    /* Start QEMU */
> +    qtest_add_func("virt/clic/prv_msu/boot_qemu_msu",
> +                   boot_qemu_msu);
> +
> +    /* cliccfg configure cases */
> +
> +    /* mnlbits should be unaffected */
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_min_mnlbits_msu",
> +                   test_configure_cliccfg_min_mnlbits);
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_supported_max_mnlbits_msu"=
,
> +                   test_configure_cliccfg_supported_max_mnlbits);
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_unsupported_mnlbits_msu",
> +                   test_configure_cliccfg_unsupported_mnlbits);
> +    /* snlbits should work*/
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_min_snlbits_s_msu",
> +                   test_configure_cliccfg_min_snlbits_s);
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_supported_max_snlbits_s_ms=
u",
> +                   test_configure_cliccfg_supported_max_snlbits_s);
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_unsupported_snlbits_s_msu"=
,
> +                   test_configure_cliccfg_unsupported_snlbits_s);
> +    /* unlbits should work*/
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_min_unlbits_u_msu",
> +                   test_configure_cliccfg_min_unlbits_u);
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_uupported_max_unlbits_u_ms=
u",
> +                   test_configure_cliccfg_supported_max_unlbits_u);
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_unsupported_unlbits_u_msu"=
,
> +                   test_configure_cliccfg_unsupported_unlbits_u);
> +    /* all bits should work */
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_xnlbits_msu",
> +                   test_configure_cliccfg_xnlbits);
> +
> +    /* clicintattr mode configure cases with nmbits =3D 2 =3D> all modes=
 */
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_nmbits_2_ms",
> +                   test_configure_cliccfg_nmbits_2);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_m_nmbits_2",
> +                   test_configure_clicintattr_prv_m);
> +    qtest_add_func("virt/clic/prv_msu/intattr_unsupported_mode_10_nmbits=
_2",
> +                   test_configure_clicintattr_unsupported_mode_10);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_s_supported_nmbits_2",
> +                   test_configure_clicintattr_prv_s_supported);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_u_supported_nmbits_2",
> +                   test_configure_clicintattr_prv_u_supported);
> +
> +    /* clicintattr mode configure cases with nmbits =3D 1 =3D> PRV_M and=
 PRV_S */
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_nmbits_1_ms",
> +                   test_configure_cliccfg_nmbits_1);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_m_nmbits_1",
> +                   test_configure_clicintattr_prv_m);
> +    qtest_add_func("virt/clic/prv_msu/intattr_unsupported_mode_10_nmbits=
_1",
> +                   test_configure_clicintattr_unsupported_mode_10);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_u_to_s_warl_nmbits_1_p=
rv_m",
> +                   test_configure_clicintattr_prv_u_to_s_warl);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_s_supported_nmbits_1",
> +                   test_configure_clicintattr_prv_s_supported);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_u_to_s_warl_nmbits_1_p=
rv_s",
> +                   test_configure_clicintattr_prv_u_to_s_warl);
> +
> +    /* clicintattr mode configure cases with nmbits =3D 0 - PRV_M only *=
/
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_nmbits_0_ms",
> +                   test_configure_cliccfg_nmbits_0);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_m_nmbits_0",
> +                   test_configure_clicintattr_prv_m);
> +    qtest_add_func("virt/clic/prv_msu/intattr_unsupported_mode_10_nmbits=
_0",
> +                   test_configure_clicintattr_unsupported_mode_10);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_u_to_m_warl_nmbits_0",
> +                   test_configure_clicintattr_prv_u_to_m_warl);
> +    qtest_add_func("virt/clic/prv_msu/intattr_prv_s_to_m_warl_nmbits_0",
> +                   test_configure_clicintattr_prv_s_to_m_warl);
> +
> +    /* unsupported nmbits */
> +    qtest_add_func("virt/clic/prv_msu/cliccfg_unsupported_nmbits_3_ms",
> +                   test_configure_cliccfg_unsupported_nmbits_3);
> +
> +    /* clicintattr TRIG and SHV */
> +    qtest_add_func("virt/clic/prv_msu/intattr_positive_edge_triggered",
> +                   test_configure_clicintattr_positive_edge_triggered);
> +    qtest_add_func("virt/clic/prv_msu/clicintattr_negative_edge_triggere=
d",
> +                   test_configure_clicintattr_negative_edge_triggered);
> +    qtest_add_func("virt/clic/prv_msu/clicintattr_positive_level_trigger=
ed",
> +                   test_configure_clicintattr_positive_level_triggered);
> +    qtest_add_func("virt/clic/prv_msu/clicintattr_negative_level_trigger=
ed",
> +                   test_configure_clicintattr_negative_level_triggered);
> +    qtest_add_func("virt/clic/prv_msu/clicintattr_non_vectored",
> +                   test_configure_clicintattr_non_vectored);
> +
> +    /* Shut down QEMU */
> +    qtest_add_func("virt/clic/prv_msu/shut_down_qemu_msu",
> +                   shut_down_qemu);
> +}
> +
> +#define GEN_INTCTL_TEST(_nbits)                                         =
    \
> +GEN_BOOT_QEMU_INTCTL(_nbits)                                            =
    \
> +static void clic_configure_clicintctl_test_case_##_nbits##_bits(void)   =
    \
> +{                                                                       =
    \
> +    g_autofree char *prefix =3D g_strdup_printf("virt/clic/clicintl_%d_b=
its", \
> +                                              _nbits);                  =
    \
> +    g_autofree char *path;                                              =
    \
> +                                                                        =
    \
> +    path =3D g_strdup_printf("%s/boot_qemu", prefix);                   =
      \
> +    qtest_add_func(path, boot_qemu_##_nbits##_bits);                    =
    \
> +                                                                        =
    \
> +    path =3D g_strdup_printf("%s/intctl_0_%d_bits", prefix, _nbits);    =
      \
> +    qtest_add_func(path,                                                =
    \
> +                   test_configure_clicintctl_set_0_##_nbits##_bits);    =
    \
> +    path =3D g_strdup_printf("%s/intctl_33_%d_bits", prefix, _nbits);   =
      \
> +    qtest_add_func(path,                                                =
    \
> +                   test_configure_clicintctl_set_33_##_nbits##_bits);   =
    \
> +    path =3D g_strdup_printf("%s/intctl_88_%d_bits", prefix, _nbits);   =
      \
> +    qtest_add_func(path,                                                =
    \
> +                   test_configure_clicintctl_set_88_##_nbits##_bits);   =
    \
> +    path =3D g_strdup_printf("%s/intctl_128_%d_bits", prefix, _nbits);  =
      \
> +    qtest_add_func(path,                                                =
    \
> +                   test_configure_clicintctl_set_128_##_nbits##_bits);  =
    \
> +    path =3D g_strdup_printf("%s/intctl_204_%d_bits", prefix, _nbits);  =
      \
> +    qtest_add_func(path,                                                =
    \
> +                   test_configure_clicintctl_set_204_##_nbits##_bits);  =
    \
> +    path =3D g_strdup_printf("%s/intctl_240_%d_bits", prefix, _nbits);  =
      \
> +    qtest_add_func(path,                                                =
    \
> +                   test_configure_clicintctl_set_240_##_nbits##_bits);  =
    \
> +                                                                        =
    \
> +    path =3D g_strdup_printf("%s/shut_down_qemu", prefix);              =
      \
> +    qtest_add_func(path, shut_down_qemu);                               =
    \
> +}
> +
> +GEN_INTCTL_TEST(0)
> +GEN_INTCTL_TEST(1)
> +GEN_INTCTL_TEST(2)
> +GEN_INTCTL_TEST(3)
> +GEN_INTCTL_TEST(4)
> +GEN_INTCTL_TEST(5)
> +GEN_INTCTL_TEST(6)
> +GEN_INTCTL_TEST(7)
> +GEN_INTCTL_TEST(8)
> +
> +static void clic_irq_test_case(void)
> +{
> +    /* interrupt test case */
> +    qtest_add_func("virt/clic/vectored_positive_level_triggered_interrup=
t",
> +                   test_vectored_positive_level_triggered_interrupt);
> +    qtest_add_func("virt/clic/vectored_negative_level_triggered_interrup=
t",
> +                   test_vectored_negative_level_triggered_interrupt);
> +    qtest_add_func("virt/clic/vectored_positive_edge_triggered_interrupt=
",
> +                   test_vectored_positive_edge_triggered_interrupt);
> +    qtest_add_func("virt/clic/vectored_negative_edge_triggered_interrupt=
",
> +                   test_vectored_negative_edge_triggered_interrupt);
> +    qtest_add_func("virt/clic/unvectored_positive_level_triggered_interr=
upt",
> +                   test_unvectored_positive_level_triggered_interrupt);
> +    qtest_add_func("virt/clic/unvectored_negative_level_triggered_interr=
upt",
> +                   test_unvectored_negative_level_triggered_interrupt);
> +    qtest_add_func("virt/clic/unvectored_positive_edge_triggered_interru=
pt",
> +                   test_unvectored_positive_edge_triggered_interrupt);
> +    qtest_add_func("virt/clic/unvectored_negative_edge_triggered_interru=
pt",
> +                   test_unvectored_negative_edge_triggered_interrupt);
> +}
> +
> +static void clic_mode_access_test_case(void)
> +{
> +    qtest_add_func("virt/clic/test_prv_s_access", test_prv_s_access);
> +    qtest_add_func("virt/clic/test_prv_u_access", test_prv_u_access);
> +    qtest_add_func("virt/clic/test_prv_su_access", test_prv_su_access);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_set_nonfatal_assertions();
> +
> +    /* test cases */
> +    clic_configure_reg_mmio_test_case_m();
> +    clic_configure_reg_mmio_test_case_ms();
> +    clic_configure_reg_mmio_test_case_mu();
> +    clic_configure_reg_mmio_test_case_msu();
> +    clic_configure_clicintctl_test_case_0_bits();
> +    clic_configure_clicintctl_test_case_1_bits();
> +    clic_configure_clicintctl_test_case_2_bits();
> +    clic_configure_clicintctl_test_case_3_bits();
> +    clic_configure_clicintctl_test_case_4_bits();
> +    clic_configure_clicintctl_test_case_5_bits();
> +    clic_configure_clicintctl_test_case_6_bits();
> +    clic_configure_clicintctl_test_case_7_bits();
> +    clic_configure_clicintctl_test_case_8_bits();
> +    clic_irq_test_case();
> +    clic_mode_access_test_case();
> +
> +    /* Run the tests */
> +    int ret =3D g_test_run();
> +
> +    return ret;
> +}
> --
> 2.46.0.windows.1
> This message and any attachments may contain privileged and confidential =
information that is intended solely for the person(s) to whom it is address=
ed. If you are not an intended recipient you must not: read; copy; distribu=
te; discuss; take any action in or make any reliance upon the contents of t=
his message; nor open or read any attachment. If you have received this mes=
sage in error, please notify us as soon as possible on the following teleph=
one number and destroy this message including any attachments. Thank you. C=
irrus Logic International (UK) Ltd and Cirrus Logic International Semicondu=
ctor Ltd are companies registered in Scotland, with registered numbers SC08=
9839 and SC495735 respectively. Our registered office is at 7B Nightingale =
Way, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cir=
rus.com
>

