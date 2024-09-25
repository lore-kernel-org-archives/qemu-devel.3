Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC85CCF9EC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 19:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stXhD-00069D-OX; Wed, 25 Sep 2024 15:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stXh6-000659-LG; Wed, 25 Sep 2024 15:29:03 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stXh2-0001ux-QL; Wed, 25 Sep 2024 15:28:58 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c46680a71bso128109a12.2; 
 Wed, 25 Sep 2024 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727292532; x=1727897332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpNIGUqoKh3ApSswDw2WgMUn4lBLGk7X9nmAv792NQ0=;
 b=BqJgN/bcfa7u3tT+EIQohiId0USDg6SPNC6ID2HbgL4f1s0gT90sXCcBEd6fKOKKBv
 H0tuH/CtpTm/jNCcy98esdHEEyv4ghCyKTpWVTtj6X2BXCIduE1WeawHWoTasV0ZngbU
 idWDMbVIPCWT3iWMnUCSQjYe3xM/VUuNbNs4jPZlT7gPXm//9D00R36mZo0aTsqtbFow
 CA05Xez8+ksBl/pvaReQKUyWJ7y/Vn01ArcLQ6rNRPDyTZYAwOAYF16/5jmAei8ELv7Z
 k5O0wpw3ylw16q+ZukkAMxuwI8wH5S4Lis8oPEOu3T+jrlH4Nem1tV/px5zi17JHRjrm
 17JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727292532; x=1727897332;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpNIGUqoKh3ApSswDw2WgMUn4lBLGk7X9nmAv792NQ0=;
 b=nXsr0X2L7HAPP33fOzBvFHBsBvfbk8IqfPDcuhQvfx9DnAymJB7gCFZQem8dDtZR8/
 90jWfpBtcCbCrThJ/QfjEvSDYrhgGIE9MVIQWKWG9myNdrBZrK6OCeZnZJHqQnyjRV4W
 vkmd/wgi7Xhrg3+9d4XTzOsQ0yslRYtt34sHUG/g18ohGbKdIb6HZPFbz3N24dvHQClM
 IKoSmeRYO0pOG0SfMdFyDdEIxEHFX9Jw3PD5wcQ2eSsbZW5PajQ6K3Vv9AbqiUmLTC6d
 Y2DcbnRuhGynD7dEBsURPjfB1nw61iRP1F4FJznqvICXUoxaigEIkxwW3KhlCq0D/Clv
 D3NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj5jstiBD4Lphl3c4hzcF0hEnMSFdanJjzjSMTaA86KU6dLQhJF+cCcRE+dOMVyFwIciSirveoO8ON@nongnu.org,
 AJvYcCXTwVRiv+Boo3w9cG48ennhjuxk6c0BEvT0yLGtLSn0TcNJpJUIDDSEasaLB5+UkzMx1NNF6K4nYRA=@nongnu.org
X-Gm-Message-State: AOJu0YyIVj1iyuiZrTeHbkyb05B3r/wVT5fxNbkoK4Z2Qf5ClYcH6i9A
 rOien2KIavFp+K05ERr/B9eAM6zzlV11gg5QpHpy0LHBZSZyHjA8
X-Google-Smtp-Source: AGHT+IEUcFZhlWCmeCpdutgH6haBxSnNkJoLs42N0w309Gn5ImNa/rOeZM+0fk4NjYRMvaWsy4WstQ==
X-Received: by 2002:a05:6402:354a:b0:5c7:1ffc:f58c with SMTP id
 4fb4d7f45d1cf-5c720641103mr3131855a12.28.1727292531804; 
 Wed, 25 Sep 2024 12:28:51 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-049-158.77.11.pool.telefonica.de.
 [77.11.49.158]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fd8sm2246241a12.69.2024.09.25.12.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 12:28:51 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:09:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 02/23] hw/ppc/e500: Reduce scope of env pointer
In-Reply-To: <87efb774-720a-9628-9335-fbec17e68d12@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-3-shentey@gmail.com>
 <87efb774-720a-9628-9335-fbec17e68d12@eik.bme.hu>
Message-ID: <296CB8D6-C7D5-4A13-B84B-B44D437454E2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 23=2E September 2024 10:04:48 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>> The env pointer isn't used outside the for loop, so move it inside=2E A=
fter that,
>> the firstenv pointer is never read, so remove it=2E
>
>It's probably the other way arouns, you remove firstenv (which is the big=
ger part of this patch) then it's clear env is not needed outside of the lo=
op any more so can be moved there=2E The purpose of this seems to be to pre=
serve the env of the first CPU but as it's unused yet maybe it can be remov=
ed for now and readded later when needed=2E

I'll fix the commit message=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/ppc/e500=2Ec | 9 +--------
>> 1 file changed, 1 insertion(+), 8 deletions(-)
>>=20
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 75b051009f=2E=2Ef68779a1ea 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -899,7 +899,6 @@ void ppce500_init(MachineState *machine)
>>     const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(machin=
e);
>>     MachineClass *mc =3D MACHINE_CLASS(pmc);
>>     PCIBus *pci_bus;
>> -    CPUPPCState *env =3D NULL;
>>     uint64_t loadaddr;
>>     hwaddr kernel_base =3D -1LL;
>>     int kernel_size =3D 0;
>> @@ -921,7 +920,6 @@ void ppce500_init(MachineState *machine)
>>     IrqLines *irqs;
>>     DeviceState *dev, *mpicdev;
>>     DriveInfo *dinfo;
>> -    CPUPPCState *firstenv =3D NULL;
>>     MemoryRegion *ccsr_addr_space;
>>     SysBusDevice *s;
>>     PPCE500CCSRState *ccsr;
>> @@ -930,6 +928,7 @@ void ppce500_init(MachineState *machine)
>>     irqs =3D g_new0(IrqLines, smp_cpus);
>>     for (i =3D 0; i < smp_cpus; i++) {
>>         PowerPCCPU *cpu;
>> +        CPUPPCState *env;
>>         CPUState *cs;
>>=20
>>         cpu =3D POWERPC_CPU(object_new(machine->cpu_type));
>> @@ -950,10 +949,6 @@ void ppce500_init(MachineState *machine)
>>                                  &error_abort);
>>         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>>=20
>> -        if (!firstenv) {
>> -            firstenv =3D env;
>> -        }
>> -
>>         irqs[i]=2Eirq[OPENPIC_OUTPUT_INT] =3D
>>             qdev_get_gpio_in(DEVICE(cpu), PPCE500_INPUT_INT);
>>         irqs[i]=2Eirq[OPENPIC_OUTPUT_CINT] =3D
>> @@ -974,8 +969,6 @@ void ppce500_init(MachineState *machine)
>>         }
>>     }
>>=20
>> -    env =3D firstenv;
>> -
>>     if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
>>         error_report("RAM size must be multiple of %" PRIu64, RAM_SIZES=
_ALIGN);
>>         exit(EXIT_FAILURE);
>>=20

