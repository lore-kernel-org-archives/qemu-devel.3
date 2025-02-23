Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C003C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 12:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmAuY-0008QM-NJ; Sun, 23 Feb 2025 07:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmAuX-0008Pb-Dy; Sun, 23 Feb 2025 07:16:41 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmAuV-0000V5-Es; Sun, 23 Feb 2025 07:16:41 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5ded6c31344so4997677a12.1; 
 Sun, 23 Feb 2025 04:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740312997; x=1740917797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyLMdX0mKTgfNlYNdKlrfBlC4EEs5GQx4Z7IGlqyMHo=;
 b=dE4IMsG5VSYrT01VFWRx7NzNtyFRx/jw93xNNzP2Ibl9Gp6ryMDnK6E+I99n6ZooeP
 TLbntMv46bKvumxQvklX1/GPGmryw7NqOjFQ8vWZWrC1cwVcmUXw0JeCRdUzWUDADl4Q
 WiM5NZ1yTGmszios5p7lp0skg3NdV5WtkPx3U7UYD8wf1R9V49jG1M68w2mEiQg1Auf5
 7uMQzn6bGWZ/o3TXMJx0Z7JJ0s7ak150ioz+JUzip+keNVyWAyVKRqBxI+4B+3295opt
 OM3W5XBvWs84eP/ww68DAt6uh9zmvOxOWUzTXDj7qh+C6rHbY7PWctDlcQS0OAYVVjkh
 EpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740312997; x=1740917797;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyLMdX0mKTgfNlYNdKlrfBlC4EEs5GQx4Z7IGlqyMHo=;
 b=FlOwWw+PRo90ESTd040Gpw3VU/hoP80OcXZb+aWYUg7I5Nnx8J02NSaGuBpl+Ow4jg
 DzvC6ZXWtlhRowFGhV/420iqjxgGITUrZ1PJEQ0OhCrYf8NdbEhmIeMa/wji8CLVNmHe
 sWfavOiBJXgnhFk1saPqA2kPkrNlCEa5z1Tc09i1LkOoLJ0zZI1UbPA90SFiENMHoe1+
 LwweP19ZolEZUGA0W4BsEu1cFcmsDYpqh/+AageqCgT4LSNbyZQV4ggZv189HC7GH71B
 ++PcprT14zVr5Y6NcWNzsw4wPQWFQjcpwElQVAnaiptkl4FjrzJsIQtSmG7Ztylts7Ep
 newA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcEsxveTIlH+R1iF9Kye6QIm0ki7mlro9L95NPLVR8azkf+tbMBbp33anNwKQEAaDUqQscyu7fyw==@nongnu.org
X-Gm-Message-State: AOJu0Yy3aKoTsQ9297KlgwALmlTout+0g4ASFArTuYROKN2Gcol9yCL6
 1kUZm//VzLFuf47L88ko9LZPSDQIKRzfEQCXT6bFj/Wzp5fV8q3N
X-Gm-Gg: ASbGnct1QnHWblwxLIkOpUzkiiMWNtIW4bHmY1IPiQRifjF+H7PWcvv1pg70IMPY2Rc
 Fb/JOdZUAEvG0rCcGy7Lwyzb7cCjHfBW6++55kN3vabVDrQx8MQHtjbYqDhDbg7KkMhG9Tq6PUi
 N2M+yShH4D2Pp5tX0NarGZ44Hpdk87LAN6buKVNIb1nB8b66zvo47Z6yci/JaFIlMxss6EmRy63
 +BNMPTh2SP8cEeTor9rRmL4PSDECCgP8tvtUVm1/XF4zZ5UG1WDFqNypTwAgaW+bV7etIzObZGF
 XhG8Tnb5JLp2fmi3zSj/CTWp2Lklh787DsFLeVFJP8VZRWJh0+IAJDsxxRZVxAQ5HyXC607VhaY
 =
X-Google-Smtp-Source: AGHT+IGAYlQdk/J8jxr7d33I50dJAzrrk6Edzp6ZGTA+ENq6UHF2eapBk/39lz6KS3m8vU2WeFCXJQ==
X-Received: by 2002:a05:6402:4304:b0:5e0:922e:527a with SMTP id
 4fb4d7f45d1cf-5e0b6fe5685mr25031115a12.0.1740312997262; 
 Sun, 23 Feb 2025 04:16:37 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-011-167-038.77.11.pool.telefonica.de.
 [77.11.167.38]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1b4f65sm16552033a12.1.2025.02.23.04.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 04:16:36 -0800 (PST)
Date: Sun, 23 Feb 2025 11:40:46 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
In-Reply-To: <CAFEAcA8qgEDAnfaQDmpUjy77KZBiqwdKSmyLE-ZwEAhMNLWn4Q@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-5-shentey@gmail.com>
 <CAFEAcA8qgEDAnfaQDmpUjy77KZBiqwdKSmyLE-ZwEAhMNLWn4Q@mail.gmail.com>
Message-ID: <80063C2F-B373-4AB3-A23A-0A5FC0E91CBB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 10=2E Februar 2025 17:30:01 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> As a first step, implement the bare minimum: CPUs, RAM, interrupt contr=
oller,
>> serial=2E All other devices of the A53 memory map are represented as
>> TYPE_UNIMPLEMENTED_DEVICE, i=2Ee=2E the whole memory map is provided=2E=
 This allows
>> for running Linux without it crashing due to invalid memory accesses=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>
>
>
>> --- /dev/null
>> +++ b/docs/system/arm/imx8mp-evk=2Erst
>> @@ -0,0 +1,56 @@
>> +NXP i=2EMX 8M Plus Evaluation Kit (``imx8mp-evk``)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The QEMU i=2EMX 8M Plus EVK board emulation is intended to emulate a p=
lain i=2EMX 8M
>> +Plus system on chip (SoC)=2E All peripherals the real board has such a=
s flash and
>> +I2C devices are intended to be added via configuration, e=2Eg=2E comma=
nd line=2E
>
>Why do this? If they're on the real hardware board, we should
>be creating them by default in the machine model in QEMU=2E
>Command line options are for devices that are optional and
>pluggable by the user on the hardware=2E

I'll rephrase the board description to be similar to the mcimx7d-sabre mac=
hine=2E In fact, I've modeled this machine like it=2E

Best regards,
Bernhard

>
>> +Supported devices
>> +-----------------
>> +
>> +The ``imx8mp-evk`` machine implements the following devices:
>> +
>> + * Up to 4 Cortex-A53 Cores
>
>"cores"
>
>> + * Generic Interrupt Controller (GICv3)
>> + * 4 UARTs
>> +
>> +Boot options
>> +------------
>> +
>> +The ``imx8mp-evk`` machine can start using the standard -kernel functi=
onality
>> +for loading a Linux kernel=2E
>> +
>> +Direct Linux Kernel Boot
>> +''''''''''''''''''''''''
>> +
>> +Probably the easiest way to get started with a whole Linux system on t=
he machine
>> +is to generate an image with Buildroot=2E Version 2024=2E11=2E1 is tes=
ted at the time
>> +of writing and involves two steps=2E First run the following commands =
in the
>> +toplevel directory of the Buildroot source tree:
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ echo "BR2_TARGET_ROOTFS_CPIO=3Dy" >> configs/freescale_imx8mpevk_d=
efconfig
>> +  $ make freescale_imx8mpevk_defconfig
>> +  $ make
>> +
>> +Once finished successfully there is an ``output/image`` subfolder=2E N=
avigate into
>> +it patch the device tree needs to be patched with the following comman=
ds which
>> +will remove the ``cpu-idle-states`` properties from CPU nodes:
>
>This sentence seems to be confused in the middle -- cut-and-paste
>error ?
>
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ dtc imx8mp-evk=2Edtb | sed '/cpu-idle-states/d' > imx8mp-evk-patch=
ed=2Edts
>> +  $ dtc imx8mp-evk-patched=2Edts -o imx8mp-evk-patched=2Edtb
>> +
>> +Now that everything is prepared the newly built image can be run in th=
e QEMU
>> +``imx8mp-evk`` machine:
>
>> +#define NAME_SIZE 20
>> +
>> +static void fsl_imx8mp_init(Object *obj)
>> +{
>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>> +    FslImx8mpState *s =3D FSL_IMX8MP(obj);
>> +    char name[NAME_SIZE];
>
>Better than fixed sized char arrays for object names
>is to use
>   g_autofree char *name =3D g_strdup_printf("cpu%d", i);
>inside the block of each for() loop etc=2E
>
>> +    int i;
>> +
>> +    for (i =3D 0; i < MIN(ms->smp=2Ecpus, FSL_IMX8MP_NUM_CPUS); i++) {
>> +        snprintf(name, NAME_SIZE, "cpu%d", i);
>> +        object_initialize_child(obj, name, &s->cpu[i],
>> +                                ARM_CPU_TYPE_NAME("cortex-a53"));
>> +    }
>> +
>> +    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
>> +
>> +    for (i =3D 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
>> +        snprintf(name, NAME_SIZE, "uart%d", i + 1);
>> +        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIA=
L);
>> +    }
>> +}
>> +
>> +static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>> +{
>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>> +    FslImx8mpState *s =3D FSL_IMX8MP(dev);
>> +    DeviceState *gicdev =3D DEVICE(&s->gic);
>> +    int i;
>> +
>> +    if (ms->smp=2Ecpus > FSL_IMX8MP_NUM_CPUS) {
>> +        error_setg(errp, "%s: Only %d CPUs are supported (%d requested=
)",
>> +                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp=2Ecpu=
s);
>> +        return;
>> +    }
>> +
>> +    /* CPUs */
>> +    for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>> +        /* On uniprocessor, the CBAR is set to 0 */
>> +        if (ms->smp=2Ecpus > 1) {
>> +            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>> +                                    fsl_imx8mp_memmap[FSL_IMX8MP_GIC_D=
IST]=2Eaddr,
>> +                                    &error_abort);
>> +        }
>> +
>> +        /*
>> +         * Magic value from Linux output: "arch_timer: cp15 timer(s) r=
unning at
>> +         * 8=2E00MHz (phys)"=2E
>> +         */
>> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
>> +                                &error_abort);
>
>This is the CNTFRQ value in Hz=2E The datasheet actually tells you
>this, so we don't need to call it a magic number (section 4=2E11=2E4=2E1=
=2E6=2E4
>of the i=2EMX 8M Plus Applications Processor Reference Manual says the
>base frequency of the system counter is 8MHz)=2E
>
>(Incidentally the memory mapped system counter is a stock Arm
>IP block and I have about 60% of a model of it, I just haven't
>needed to upstream it yet because in practice no guest software
>really tries to mess with it=2E If we turn out to need it for
>this SoC that would be a reason for me to clean it up and
>send it out=2E But I suspect we don't need it in practice=2E)
>
>thanks
>-- PMM

