Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2615D3B7CA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 03:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFPse-0000hQ-Jj; Sun, 24 Nov 2024 22:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tFPsd-0000hF-PR; Sun, 24 Nov 2024 22:35:19 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tFPsc-0006sc-5m; Sun, 24 Nov 2024 22:35:19 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4af07a8d444so374149137.1; 
 Sun, 24 Nov 2024 19:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732505716; x=1733110516; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mqVRXfF2lEyuk7g4aN6G4po242Z2AWrnlUQfn9CGDE=;
 b=aezGFEue7DyVP0c0OHgnFKV9SS7FEfFbeinlxB7gbDA83QudA3u2/p+im8j+/wOkCi
 czkK16D5jLDPb1399acrZE3l3bohQvROI3rwzHK2w7mD1BKKIAfTRgAz8pJeJzjwFf4y
 wr7BdJ9mg2X9z+lhoYinK6xDmCx4ufW4IT+d4jxG9frTIky5OxPIkEpyO1O+S6uDvAtb
 TcciCk4nT+pMqcXHl0DJlmgLlcf1yFj3JMxrvH06a22A0on1jVIX82wo9s23dh5MHf9u
 IGn/8EBlxnDArpdZQU2lKJBRCv8qgGH54/TLtvOmB9HhGYbsKE3WAmxouWu3/UWAdnMb
 JubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732505716; x=1733110516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mqVRXfF2lEyuk7g4aN6G4po242Z2AWrnlUQfn9CGDE=;
 b=MjHze1Q/txLS3j/S81KgIBx/MxG8JugyKxwmJ5XnPDbVMDayAHpbSke6GzbiSeJDuq
 3TqBXrkQUwKMhWjOEQr0x6XNbEYusl7Y8djHvAkUoHsFD21UWWsfDf48PU1onOVDn+0N
 fEp1xGsOXm0SJpZVH2+Xgnfvyr7kVZjLX4PRgHihYcl39z23Hxv4mZDQ3ayV0VYrOpVk
 rR1LqHaB35hVWTMjlaSv8TD4Fo6S/eely/UY/iwDk1X9ELbvcMkJVinbSUgoaqjmG/O9
 2ic1OjPzP0iBssd9CFrLfRCkbQVghJvKJnHfZVJhxkiqnU8QvAVwkfJLNKAosxfQycqm
 oxKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2yUHh0tZjWNc6JMCx2kMFyMTr43x7DDTLYb5VDfObHjRmx2ByoxkjHn0fp7WDT6GJn1bhtyKnS5ii@nongnu.org
X-Gm-Message-State: AOJu0YzmybByeKIBjgbFBGep5mG9PowfBTOHB8MR2a7xA9JcKXI1PhuQ
 a9zwtonr/oyMzhbJwMX2HsIRjjwIHJf2gXOK+jAdk8j/8g/ECqFAt+bCgXx8bnUlIvSPlzayVJk
 m9FhICiqFyiIVsI6JCnwZ7oouti4=
X-Gm-Gg: ASbGncsZ6yVKnmLpxUbr8I6mys9zexsmecDbNbTwNZbr1RU3wqdVKawy5o0kcuJ5K6F
 Mh7kZZPgVb6/7LSZ5W6AP/3avM+ZdeM1AtBXvOnxToqvjUwc1f0YXOhtk1h5jGw==
X-Google-Smtp-Source: AGHT+IFHFksXu6PBerAejXG5Slg5ms2ckK+IF09F8GZC5NXKpMkd+Yl4cT/f1eOUlMAyMNGVQO6L6n2ajq46BliegZQ=
X-Received: by 2002:a05:6102:5091:b0:4af:1683:aeaf with SMTP id
 ada2fe7eead31-4af1683afdfmr2050060137.9.1732505716242; Sun, 24 Nov 2024
 19:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20241119144956.728384-1-sai.pavan.boddu@amd.com>
In-Reply-To: <20241119144956.728384-1-sai.pavan.boddu@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 25 Nov 2024 13:34:50 +1000
Message-ID: <CAKmqyKNBepMhGEP7grV0Ay1=VZcRyvRujO5cSAg2JAY29eciCg@mail.gmail.com>
Subject: Re: [PATCH v4] hw/riscv: Add Microblaze V generic board
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Simek Michal <michal.simek@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Iglesias Francisco <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Wed, Nov 20, 2024 at 12:50=E2=80=AFAM Sai Pavan Boddu
<sai.pavan.boddu@amd.com> wrote:
>
> Add a basic board with interrupt controller (intc), timer, serial
> (uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
> (configured via command line eg. -m 2g).
> This is basic configuration which matches HW generated out of AMD Vivado
> (design tools). But initial configuration is going beyond what it is
> configured by default because validation should be done on other
> configurations too. That's why wire also additional uart16500, axi
> ethernet(with axi dma).
> GPIOs, i2c and qspi is also listed for completeness.
>
> IRQ map is: (addr)
> 0 - timer (0x41c00000)
> 1 - uartlite (0x40600000)
> 2 - i2c (0x40800000)
> 3 - qspi (0x44a00000)
> 4 - uart16550 (0x44a10000)
> 5 - emaclite (0x40e00000)
> 6 - timer2 (0x41c10000)
> 7 - axi emac (0x40c00000)
> 8 - axi dma (0x41e00000)
> 9 - axi dma
> 10 - gpio (0x40000000)
> 11 - gpio2 (0x40010000)
> 12 - gpio3 (0x40020000)
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> Changes for V2:
>     Make changes to support -cpu switch
>     Remove setting of default board
>     Include doc to toctree
>     Remove setting of 'imac' extensions as they are available by
>     default.
> Chages for V3:
>     Replace virt with generic
>     Update doc with supported riscv extensions
>     Change base CPU to TYPE_RISCV_CPU_BASE
> Changes for V4:
>     Improved the doc based on comments
>     Disabled support for Double-Precision and Hypervisor extensions
>     Updated Maintainers file at riscv machine space.
>
>  MAINTAINERS                                |   6 +
>  docs/system/riscv/microblaze-v-generic.rst |  42 +++++
>  docs/system/target-riscv.rst               |   1 +
>  hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
>  hw/riscv/Kconfig                           |   8 +
>  hw/riscv/meson.build                       |   1 +

It looks like this needs a rebase, do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next and
sending a new version

Alistair

