Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62739C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 20:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcASL-00080a-Cq; Mon, 19 Feb 2024 15:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcASI-000802-DG
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 15:41:38 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcASF-00053W-Tc
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 15:41:37 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3ed9cae56fso111534066b.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708375293; x=1708980093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PRAtNB64fi/Ho3MFXo2ha3qxf9llUUPvZwmCKh/LoU=;
 b=FnUyXE/23n9sTc3y8Ah7OPD+iCvfZe1lOL8S+fms7rzo/eZxjRHtnDD/6DIR1emvh2
 UPQX1YMF8wxxZckPBqqUxshoTgKTQNeNGOAEJZMtcILubo08gV93vaVaIich0rRP8IE8
 vUBjdxF+cSy6nredrUR+KXJPvvF/eNVJe/NCSsaBNzyg9Dn8kY4xfFbfAepB/b6tjKSn
 8iapOC1OhgDnNm+bqBnIztI4itjMxzWwtKk7mpuuJuNFC6pAgsKqEx1yYqcdRJTj/VN5
 gmtJc4j/DYR3yJBeNVq5/cnmrgjxuSUYEdJc0i6TGSQAmZVu/o3RvldB00isrlGZ6Znl
 H21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708375293; x=1708980093;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PRAtNB64fi/Ho3MFXo2ha3qxf9llUUPvZwmCKh/LoU=;
 b=MZybQwkAwPXxDWjxBdkKMBeQO4+GyKwUl8tQ/bN+WGJdN/fRNG0UNavLA8hW/MPfh3
 C7/VfIS2nAEeQOi/MvBUGhaIyMkdoFTKd1cEYC2lx/95Z5u6L4VFWzxUjPZj6ISExR8/
 4R9gDTVhynKhpSqjLXTrMaTWgm+uv7TQi0vmhKLeQZq4FrKzAel0m22fSj96CWeJk1Qo
 ZF7cHojQaSz1fEYID8w5aMdtYF5rswmcBPbHDxGT0ifd47aZEDoCBb3xxyI+fp6D7JQq
 6wKMhNeZBMXhSulFSgPZ3lI0MUdNVE3/dzheQrZTQp9nG13rGhCU5B6YYEPcP26XpU3J
 zH4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlKoFeKxdVrEn5SiLXSI7Ff4dPbRwagUqFnha0KYnTuZbEPtgD3LdT0HVVhLYbewgKUwY5xOlXZcdg2samopQS1ZGpF/4=
X-Gm-Message-State: AOJu0YznMYIbHwCME64NozVST/Q53x7vBKcS8EHhdya+rN1X90/DHMND
 ZMG5vR4MZI5UH6zopA/MsuZfbpcDrZhPUs7dRj+smfFgwFwTr52i
X-Google-Smtp-Source: AGHT+IFT8NM+xB3nHDV+c1DB5vjL/WhS4xa9oa8VItHSHYMorB+f0jPxftEK0A3/fBLV8oogOPji1w==
X-Received: by 2002:a17:907:9483:b0:a3e:a383:3581 with SMTP id
 dm3-20020a170907948300b00a3ea3833581mr3906610ejc.24.1708375293206; 
 Mon, 19 Feb 2024 12:41:33 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-244-242.89.14.pool.telefonica.de.
 [89.14.244.242]) by smtp.gmail.com with ESMTPSA id
 w24-20020a1709067c9800b00a3ec01c4079sm874796ejo.224.2024.02.19.12.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 12:41:32 -0800 (PST)
Date: Mon, 19 Feb 2024 20:41:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/i386/pc=5Fq35=3A_Populate_interru?=
 =?US-ASCII?Q?pt_handlers_before_realizing_LPC_PCI_function?=
In-Reply-To: <cd0e13c6-c03d-411f-83a5-1d4d28ea4345@linaro.org>
References: <20240217104644.19755-1-shentey@gmail.com>
 <cd0e13c6-c03d-411f-83a5-1d4d28ea4345@linaro.org>
Message-ID: <0FFB5FD2-08CE-4CEC-9001-E7AC24407A44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 19=2E Februar 2024 08:51:07 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 17/2/24 11:46, Bernhard Beschow wrote:
>> The interrupt handlers need to be populated before the device is realiz=
ed since
>> internal devices such as the RTC are wired during realize()=2E If the i=
nterrupt
>> handlers aren't populated, devices such as the RTC will be wired with a=
 NULL
>> interrupt handler, i=2Ee=2E MC146818RtcState::irq is NULL=2E
>>=20
>> Fixes: fc11ca08bc29 "hw/i386/q35: Realize LPC PCI function before acces=
sing it"
>
>I think this commit is correct, but exposes a pre-existing bug=2E
>
>I noticed it for the PC equivalent, so didn't posted the
>pci_realize_and_unref() change there, but missed the Q35 is
>similarly affected=2E
>
>IMO the problem is how the GSI lines are allocated=2E The ISA
>ones are allocated twice!
>
>Before this patch, the 1st alloc is just overwritten and
>ignored, ISA RTC IRQ is assigned to the 2nd alloc=2E
>
>After this patch, ISA RTC IRQ is assigned to the 1st alloc,
>then the 2nd alloc wipe it, and an empty IRQ is eventually
>wired later=2E
>
>The proper fix is to alloc ISA IRQs just once=2E Either filling
>GSI with them, or having GSI take care of that=2E
>
>Since GSI is not a piece of HW but a concept to simplify
>developers writing x86 HW drivers, I currently think we shouldn't
>model it as a QOM container=2E

The qdev_connect_gpio_out_named() call below populates an internal array o=
f IOAPIC_NUM_PINS callbacks inside the LPC device=2E These callbacks trigge=
r IRQs=2E The RTC inside the LPC device relies on this array to be populate=
d with valid handlers during LPC's realize, else the RTC gets wired with no=
/invalid callbacks=2E This patch fixes this array to be populated before re=
alize=2E Before this patch, the array was populated after LPC's realize, ca=
using NULL callbacks to be assigned to the RTC there=2E

Thus, IRQ allocations don't seem like the underlying problem to me=2E

The general pattern I see here is that qdev_connect_gpio_out_*() should be=
 performed *before* realizing the device passed as the first argument=2E Th=
e reason is that this device could contain an arbitrarily deep nesting of i=
nternal devices which may want to be assigned valid IRQ callbacks during it=
s realize=2E AFAICS this pattern would work recursively, so internal device=
s which have themselves internal devices would be wired correctly=2E This p=
attern may not be immediately evident since most of the time we're wiring "=
leaf" devices which can be wired either way=2E

Furthermore, it seems that qdev_get_gpio_in_*() may need to be called *aft=
er* a device's realize because the device may need to prepare its IRQs befo=
re exposing them=2E So it looks like qdev_get_gpio_in_*() and qdev_get_gpio=
_out_*() should be treated in dual manner=2E

Note that "IRQ forwarders" like piix_request_i8259_irq() may allow qdev_co=
nnect_gpio_out_*() to be called after a device has been realized=2E This pa=
ttern comes with a small performance penalty and might add some cognitive l=
oad when trying to understand code=2E So the above pattern seems like the p=
referable solution=2E

Best regards,
Bernhard

>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/i386/pc_q35=2Ec | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>> index d346fa3b1d=2E=2E43675bf597 100644
>> --- a/hw/i386/pc_q35=2Ec
>> +++ b/hw/i386/pc_q35=2Ec
>> @@ -240,10 +240,10 @@ static void pc_q35_init(MachineState *machine)
>>       lpc_dev =3D DEVICE(lpc);
>>       qdev_prop_set_bit(lpc_dev, "smm-enabled",
>>                         x86_machine_is_smm_enabled(x86ms));
>> -    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>>       for (i =3D 0; i < IOAPIC_NUM_PINS; i++) {
>>           qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms-=
>gsi[i]);
>>       }
>> +    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>>         rtc_state =3D ISA_DEVICE(object_resolve_path_component(OBJECT(l=
pc), "rtc"));
>>  =20
>

