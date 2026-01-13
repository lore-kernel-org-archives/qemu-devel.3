Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ED7D2F33D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 16:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfhGv-0006L9-Mh; Tue, 13 Jan 2026 11:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfhGm-0006K2-T7
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:29:27 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfhGk-0008Ka-Uj
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:29:24 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-640e065991dso7124327d50.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768321761; x=1768926561; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSLdwiDU4yVQpL4aTNzPqzVgLs8eVM1Z5dTEZW3JqSk=;
 b=xBYUo8JRL3V+v7HA2EmW5G9rkVWQnTLMUCKmW+dSIKF23qOiYk9xFl0kAzL4nbdiF2
 KYF6pjEZcpZ11bKQYsCyJI+gRb0sXg/1wpvMCYVOHZICyVpZ2JzgAdSV3drGMr4JkWFy
 3/vBWrAmKRWW4lwouImags2/pHbSvP2wJ7RVY00J+cyMdIXWD/VNBuv9808pgXWSZ0Yo
 RooflZFqWlaq68PZmQDa2RH4AUZ/1lUXZmSukT7q4QRsg4D+TRPrywu9tRGOpweLVUMQ
 Obtzk/ndj20Mnsb3b8KP4HJlfMM32KO5pYG3kpIXqO5EcxM3/QzWjshMNpxCTku8gco/
 nNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768321761; x=1768926561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kSLdwiDU4yVQpL4aTNzPqzVgLs8eVM1Z5dTEZW3JqSk=;
 b=R/ivuOUSo80/VyJ35jUS1GSG/nuW0uZSHoqDaRC1PPcXAZlgjrQy1peS5B0coQrEDM
 7xiRwaDaYoZPEcRdY3mQTsQLYxgxW+7Po4sO3mR3CClfiMB0v7w9lv2ohtU4Y/iTb+k1
 7PuX/zGvSv2yRCnXLdVdmmFtdQyVbUs5PRQXVCMEYGhTk0U26r29aUTqp1XDAxCZmsvH
 dSI1migr+K2L3FIZt0Ft3Xeog914it6azknPbG/zMegSBuojVDBvL+EW+oaIuxbFlBZj
 Fj8BTupvzh+HAAHR7D5RtVlZEEj2zZOaKSMe1zf0suSUVHetGwQYUeVtreL+Hi2FNj+m
 RlNA==
X-Gm-Message-State: AOJu0YwGP4yYOD9Foyxo/uJDMw7N2Wpw0Rsbsb6HTrgzW2M3FVHLza5v
 zCP1eDuGMXmXRaUl78YVjNP9TJJm81R1CVbvl/cSYvpsyFMtsdoh1NmZ75hfQtM3tQcZ/Y9GA+o
 IQsPrVCf/M02jDoeS+PdewQGAIJNwfU5YT64WIA95NA==
X-Gm-Gg: AY/fxX56w4uYckvO1Ol4Rh3/zWLZ1JSlmO+fHbuQNkDRowOvd+XkB81/GKUSkZmaqho
 tJzVE2qWjQ3uLygMx6rnwj4MJNIvRzruPVwuYffXydwUItTEjk4hNMOXqgX5+NthtbFg8N/ba7z
 sWQ7cweWjirJgMRqM6gqjirPAa/mfOKVTIGPatIRTXzP+qxWWQmNyVuWrLbVW3u2ft2b3ZyrfME
 qfaWdqtXxjg4v07qTGxMfltvuSflvOg6Eoffr2172+EvD6Eg+eBU7leWSW79DyYKbZNtpws/68u
 yluBzQFbf7TNz0GjrrdxlKj6mXk8iaREdw==
X-Google-Smtp-Source: AGHT+IGrCDabUpYJ0OYirO0vRvKugND7Nhsxxxl88ke6J65N8WBZB5IQv4QamVpRx65tQcjgxlHeLhnFtZi0rhJHo88=
X-Received: by 2002:a05:690e:169e:b0:644:7933:ae8a with SMTP id
 956f58d0204a3-64716ac409fmr18584281d50.16.1768321760652; Tue, 13 Jan 2026
 08:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-9-alex.bennee@linaro.org>
In-Reply-To: <20260108143423.1378674-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 16:29:09 +0000
X-Gm-Features: AZwV_QiliWCCvA3bhIzSjjkxB_BcQQY1weBiagwXf6o5VfvJ2OlJtR3LnvdhzW0
Message-ID: <CAFEAcA8KQ5vsfVWw6_Z5JrXVxZYLBATFJg+3yOuCwMkdiDHidw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/12] hw/mips: defer finalising gcr_base until reset
 time
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 8 Jan 2026 at 14:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Currently the cpu_reset() in mips_cpu_realizefn() hides an implicit
> sequencing requirement when setting gcr_base. Without it we barf
> because we end up setting the region between 0x0-0x000000001fbfffff
> which trips over a qtest that accesses the GCR during "memsave 0 4096
> /dev/null".
>
> By moving to the reset phase we have to drop the property lest we are
> admonished for "Attempting to set...after it was realized" but there
> doesn't seem to be a need to expose the property anyway.
>
> NB: it would be safer if I could guarantee the place in the reset tree
> but I haven't quite grokked how to do that yet. Currently I see this
> sequence when testing:
>
>   =E2=9E=9C  env MALLOC_PERTURB_=3D43 G_TEST_DBUS_DAEMON=3D/home/alex/lsr=
c/qemu.git/tests/dbus-vmstate-daemon.sh UBSAN_OPTIONS=3Dhalt_on_error=3D1:a=
bort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 QTEST_QEMU_IMG=3D.=
/qemu-img QTEST_QEMU_BINARY=3D./qemu-system-mips64el SPEED=3Dthorough MESON=
_TEST_ITERATION=3D1 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:pri=
nt_summary=3D1:print_stacktrace=3D1 PYTHON=3D/home/alex/lsrc/qemu.git/build=
s/debug/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-dae=
mon/qemu-storage-daemon ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1=
:print_summary=3D1 G_TEST_SLOW=3D1 RUST_BACKTRACE=3D1 /home/alex/lsrc/qemu.=
git/builds/debug/tests/qtest/test-hmp --tap -p /mips64el/hmp/boston
>   TAP version 14
>   # random seed: R02S89554f0dc696ece515363e554b13b7f9
>   # Start of mips64el tests
>   # Start of hmp tests
>   # starting QEMU: exec ./qemu-system-mips64el -qtest unix:/tmp/qtest-883=
372.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-883372.qmp,=
id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -r=
un-with exit-with-parent=3Don -S -M boston -accel qtest
>   mips_cpu_reset_hold: dbg
>   mips_gcr_init: 0x5600f2160050 - 0
>   main_cpu_reset: dbg
>   mips_cpu_reset_hold: dbg
>   mps_reset: 000000001fbf8000
>   mips_cpu_reset_hold: dbg
>   ok 1 /mips64el/hmp/boston
>   # End of hmp tests
>   # End of mips64el tests
>   1..1
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/mips/cps.c        | 22 +++++++++++++---------
>  hw/misc/mips_cmgcr.c |  1 -
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 620ee972f8f..c91243599e0 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -55,6 +55,18 @@ static void main_cpu_reset(void *opaque)
>      cpu_reset(cs);
>  }
>
> +static void mps_reset(void *opaque)
> +{
> +    DeviceState *dev =3D opaque;
> +    MIPSCPSState *s =3D MIPS_CPS(dev);
> +    hwaddr gcr_base;
> +
> +    /* Global Configuration Registers - only valid once the CPU has been=
 reset */
> +    gcr_base =3D MIPS_CPU(first_cpu)->env.CP0_CMGCRBase << 4;
> +    memory_region_add_subregion(&s->container, gcr_base,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gc=
r), 0));
> +}
> +
>  static bool cpu_mips_itu_supported(CPUMIPSState *env)
>  {
>      bool is_mt =3D (env->CP0_Config5 & (1 << CP0C5_VP)) || ase_mt_availa=
ble(env);
> @@ -65,7 +77,6 @@ static bool cpu_mips_itu_supported(CPUMIPSState *env)
>  static void mips_cps_realize(DeviceState *dev, Error **errp)
>  {
>      MIPSCPSState *s =3D MIPS_CPS(dev);
> -    target_ulong gcr_base;
>      bool itu_present =3D false;
>
>      if (!clock_get(s->clock)) {
> @@ -144,16 +155,11 @@ static void mips_cps_realize(DeviceState *dev, Erro=
r **errp)
>      memory_region_add_subregion(&s->container, 0,
>                              sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gi=
c), 0));
>
> -    /* Global Configuration Registers */
> -    gcr_base =3D MIPS_CPU(first_cpu)->env.CP0_CMGCRBase << 4;
> -
>      object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
>      object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0x800,
>                              &error_abort);
> -    object_property_set_int(OBJECT(&s->gcr), "gcr-base", gcr_base,
> -                            &error_abort);
>      object_property_set_link(OBJECT(&s->gcr), "gic", OBJECT(&s->gic.mr),
>                               &error_abort);
>      object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
> @@ -161,9 +167,7 @@ static void mips_cps_realize(DeviceState *dev, Error =
**errp)
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
>          return;
>      }
> -
> -    memory_region_add_subregion(&s->container, gcr_base,
> -                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gc=
r), 0));
> +    qemu_register_reset(mps_reset, s);

Adding calls to qemu_register_reset() is adding more uses of
an API we'd ideally like to get rid of. It's particularly
non-ideal here where we're in an implementation of a sysbus
device, which has a perfectly good reset method we could
implement.

>  }
>
>  static const Property mips_cps_properties[] =3D {
> diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
> index 3e262e828bc..9e1c8d26ea5 100644
> --- a/hw/misc/mips_cmgcr.c
> +++ b/hw/misc/mips_cmgcr.c
> @@ -214,7 +214,6 @@ static const VMStateDescription vmstate_mips_gcr =3D =
{
>  static const Property mips_gcr_properties[] =3D {
>      DEFINE_PROP_UINT32("num-vp", MIPSGCRState, num_vps, 1),
>      DEFINE_PROP_INT32("gcr-rev", MIPSGCRState, gcr_rev, 0x800),
> -    DEFINE_PROP_UINT64("gcr-base", MIPSGCRState, gcr_base, GCR_BASE_ADDR=
),
>      DEFINE_PROP_LINK("gic", MIPSGCRState, gic_mr, TYPE_MEMORY_REGION,
>                       MemoryRegion *),
>      DEFINE_PROP_LINK("cpc", MIPSGCRState, cpc_mr, TYPE_MEMORY_REGION,

Something in these devices seems to be very weirdly modelled
and could probably do with being straightened out. Notably,
the GCR device itself has functionality for moving the
address of its memory region around when the guest writes
to the GCR_BASE register, so perhaps it should itself have
the job of making sure the MR is in the right place on reset?

If you have the GCR look at the CMGCRBase value of the CPU
and set the MR position in its reset exit phase method, then
you will probably find that sorts out your ordering issues,
because the CPU will set/reset its state in the 'hold' phase,
and then the GCR can look at it in the 'exit' phase.

thanks
-- PMM

