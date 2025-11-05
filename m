Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D4FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 21:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGkvo-0000cP-St; Wed, 05 Nov 2025 16:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vGkvn-0000bF-Cm
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:20:39 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vGkvl-0008TP-QV
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:20:39 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4ea12242d2eso20181cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762377635; x=1762982435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhEhkTq+LWTFHumUurvyRKjhtRaQVEgS+gmAOWh95t8=;
 b=nM7PCSUCZX6dsAosBll1kEYMuAwo/Mn8elQmhVcjqJ72mQmlix5N08L8r8+qhR/ht8
 HQJm5LXvVtpK48T0dlzMGzGO5CXxnn72jNFHdT4NykX+gz6go8Jiev0+TkCPCIAkmdQ2
 PI8VUHvJDxmWDnixi24SEtM0h/TdgTY59md7M9I6d2fAjR9LKOPWK7rC1qluJko9jhhq
 S9n4WmMydMBdmneLMA/sYlBwwfef6O5/kp+DW7HdkEdI2+HRGdnJC0LCicodAGEO1Q7O
 H+1sFoMPz2q92Te6nYTTkjLmX8pgESLLa8cMq4ETWNwuIDw4qKtt1Dw+32lpGSaIBWKD
 EvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762377635; x=1762982435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PhEhkTq+LWTFHumUurvyRKjhtRaQVEgS+gmAOWh95t8=;
 b=hzeXY7EA0it5kifAaNqKX0d5590QaERzPzcbdUt90sZsBBhv03zaCACtyrGHt7tAfO
 dYVGcKHuqV6qNY9jens4EFaRxk1O6F1VjWFKxnU4OOKPWSgn0UHuTRYBxClKd0vJNyoF
 z7+53NffYpHjFGmI8xhMWG6eP3Lo03CX6RGpwMncuXsX8u3S4v36A4XAh1WsjEW6WbOk
 LhABg2RLukVlGPhR6khcnqGbRyfdVKHo6nxk6XIbphyQl6euTgtokhJ6e3oTkHsnHNkz
 SwOyR3R/oLoi4zwLH8EJAKSlZj8tIzgB7WmY5AqtFEAbt+ENkhOulTEd5JpK7y0mrW/o
 LdiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb1T/Fp+nm66I4QqXkF4nkKGqPZPpEF3xTCv0zNZd7JbGVV+oDHH3tIl/t/bSlsG6zkkasTQccZ/z+@nongnu.org
X-Gm-Message-State: AOJu0YxTyWpP7RFLirBvX4D1DoepdH/8MtSE42ABn+bQLa6yJhCDXhwB
 MD3ucbU+yW1PBn3QR0OCTBAL4Q9AuNNZhyFlyEcMc+DcoHMVTlnEErAR7CKJTupuBwMEm6W3dVb
 mSyN1vXtukzSIgq9Rw8F5yUA6vjqSWh09etSG6Ga8
X-Gm-Gg: ASbGncuYArSZh61ImvVluoInP/C7bQBIgIYdhrMe1n6iDye2O2X6xIDnqFViTufRPdI
 PcKi1jEJOfA/p0xOIdGQacsibbQ8goVilDiJdBfoDPxclYRDx7WRsFWgzGkEG8HdI5d79dKcet8
 wrrc4SvNDZpKnPdQ9RDxGhLuzOKQs84KY83Ryk477V6xJjjpg4dF38deehHdDxjsZkbCc11IMVm
 OAqLc3BeS3OUJouryqy/7A2eb4cl0d9XgevpJSmlWy/lR4cUXiMIRHWku+uzZ1Zf5jBdbAmjOYh
 I/A6FAJpZ3nwMQE=
X-Google-Smtp-Source: AGHT+IEfM+v9iGGdx1BYEBwrRxtuS1IfwFGY7+A9Bzfd7OccCZyoCqyFApq6x9U8ocZGZEY1QDlFrRUSsgzipV8XIDA=
X-Received: by 2002:ac8:5810:0:b0:4b7:9c77:6ba5 with SMTP id
 d75a77b69052e-4ed82c07764mr197451cf.15.1762377635248; Wed, 05 Nov 2025
 13:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-10-kane_chen@aspeedtech.com>
In-Reply-To: <20251105035859.3709907-10-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 5 Nov 2025 13:20:22 -0800
X-Gm-Features: AWmQ_bnP7JNqj7KbVxp3ah6m6IwtsK35PCrb5dKXPq7p42YEX2kdxz3PVMsGt2I
Message-ID: <CA+QoejUqmspVZG=-T8TRbbc5nRXy0YQsLg6A4M54o6k=EkW6kA@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] hw/arm/aspeed: Attach SPI device to AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This patch seems to break qtest-arm
```
37/56 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test ERROR
5.18s killed by signal 6 SIGABRT
>>> QTEST_QEMU_IMG=3D./qemu-img G_TEST_DBUS_DAEMON=3D/b/f/w/src/git/qemu/te=
sts/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-arm PYTHON=3D/=
b/f/w/src/git/qemu/build/pyvenv/bin/python3 MSAN_OPTIONS=3Dhalt_on_error=3D=
1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 MESON_TEST_ITER=
ATION=3D1 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1:print_stacktrace=3D1 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-dae=
mon/qemu-storage-daemon RUST_BACKTRACE=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1=
:abort_on_error=3D1:print_summary=3D1 MALLOC_PERTURB_=3D175 /b/f/w/src/git/=
qemu/build/tests/qtest/device-introspect-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
**
ERROR:../hw/misc/aspeed_ast1700.c:113:aspeed_ast1700_instance_init:
code should not be reached
Broken pipe
../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from
signal 6 (Aborted) (core dumped)

(test program exited with status code -6)
```

Failed by running:
```
./configure \
  --target-list=3Darm-softmmu,arm-linux-user,aarch64-softmmu,aarch64-linux-=
user,i386-softmmu
\
  --cc=3Dclang-18 --extra-cflags=3D-Wno-deprecated-declarations \
  --cxx=3Dclang++-18 --extra-cxxflags=3D-Wno-deprecated-declarations
make -j 32 all check-report-unit.junit.xml
check-report-qtest-arm.junit.xml check-report-qtest-aarch64.junit.xml
check-report-qtest-i386.junit.xml

Thanks,
Nabih

Nabih Estefan (he/him) |  Software Engineer |
nabihestefan@google.com |  857-308-9574



On Tue, Nov 4, 2025 at 8:03=E2=80=AFPM Kane Chen via <qemu-devel@nongnu.org=
> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Connect the SPI device to AST1700 model.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  include/hw/misc/aspeed_ast1700.h |  1 +
>  hw/misc/aspeed_ast1700.c         | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_as=
t1700.h
> index 391c8687f5..e55deea67a 100644
> --- a/include/hw/misc/aspeed_ast1700.h
> +++ b/include/hw/misc/aspeed_ast1700.h
> @@ -33,6 +33,7 @@ struct AspeedAST1700SoCState {
>      AspeedLTPIState ltpi;
>      SerialMM uart;
>      MemoryRegion sram;
> +    AspeedSMCState spi;
>  };
>
>  #endif /* ASPEED_AST1700_H */
> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
> index 6f7ff625b5..ba44e484e8 100644
> --- a/hw/misc/aspeed_ast1700.c
> +++ b/hw/misc/aspeed_ast1700.c
> @@ -20,15 +20,19 @@
>  #define AST1700_SOC_SRAM_SIZE        0x00040000
>
>  enum {
> +    ASPEED_AST1700_DEV_SPI0,
>      ASPEED_AST1700_DEV_SRAM,
>      ASPEED_AST1700_DEV_UART12,
>      ASPEED_AST1700_DEV_LTPI_CTRL,
> +    ASPEED_AST1700_DEV_SPI0_MEM,
>  };
>
>  static const hwaddr aspeed_ast1700_io_memmap[] =3D {
> +    [ASPEED_AST1700_DEV_SPI0]      =3D  0x00030000,
>      [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,
>      [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,
>      [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
> +    [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,
>  };
>  static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>  {
> @@ -76,6 +80,20 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)
>                          aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART=
12],
>                          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart),=
 0));
>
> +    /* SPI */
> +    object_property_set_link(OBJECT(&s->spi), "dram",
> +                             OBJECT(&s->iomem), &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0=
],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), =
0));
> +
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0=
_MEM],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), =
1));
> +
>      /* LTPI controller */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>          return;
> @@ -88,11 +106,21 @@ static void aspeed_ast1700_realize(DeviceState *dev,=
 Error **errp)
>  static void aspeed_ast1700_instance_init(Object *obj)
>  {
>      AspeedAST1700SoCState *s =3D ASPEED_AST1700(obj);
> +    char socname[8];
> +    char typename[64];
> +
> +    if (sscanf(object_get_typename(obj), "aspeed.ast1700-%7s", socname) =
!=3D 1) {
> +        g_assert_not_reached();
> +    }
>
>      /* UART */
>      object_initialize_child(obj, "uart[*]", &s->uart,
>                              TYPE_SERIAL_MM);
>
> +    /* SPI */
> +    snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", 0, socname);
> +    object_initialize_child(obj, "ioexp-spi[*]", &s->spi,
> +                            typename);
>      /* LTPI controller */
>      object_initialize_child(obj, "ltpi-ctrl",
>                              &s->ltpi, TYPE_ASPEED_LTPI);
> --
> 2.43.0
>
>

