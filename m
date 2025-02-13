Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7306C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiady-0005pP-KZ; Thu, 13 Feb 2025 09:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tiadk-0005lA-D9; Thu, 13 Feb 2025 09:56:32 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tiadi-0003dL-59; Thu, 13 Feb 2025 09:56:32 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F36964E602A;
 Thu, 13 Feb 2025 15:56:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id BGkFooncBxR9; Thu, 13 Feb 2025 15:56:25 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0247A4E6019; Thu, 13 Feb 2025 15:56:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F363174577C;
 Thu, 13 Feb 2025 15:56:24 +0100 (CET)
Date: Thu, 13 Feb 2025 15:56:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
In-Reply-To: <babd30e7-0434-436a-852b-7ff1599d3944@redhat.com>
Message-ID: <10b73553-4044-288e-3788-7a3ed9c41cb2@eik.bme.hu>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
 <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
 <3b3baed4-0d79-3a28-40cd-e1835e078863@eik.bme.hu>
 <6e707c7f-b94c-47ef-83ab-795605e27963@linaro.org>
 <a3608e43-79ce-403d-8ba7-6735fde66759@linaro.org>
 <e1436061-a840-0942-2c2c-4f49bfb932b8@eik.bme.hu>
 <672045c1-9b09-4b7b-9bed-fa990129ce2c@linaro.org>
 <fb7045a4-20f6-a52d-5531-2410fc803bb4@eik.bme.hu>
 <0f7ea6d6-8476-4ba6-9d4f-eeb76aed04fa@redhat.com>
 <9e121e62-8e6e-61d6-dbfb-4dfda469acc5@eik.bme.hu>
 <babd30e7-0434-436a-852b-7ff1599d3944@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 13 Feb 2025, Thomas Huth wrote:
> On 13/02/2025 14.59, BALATON Zoltan wrote:
>> On Thu, 13 Feb 2025, Thomas Huth wrote:
>>> On 12/02/2025 23.34, BALATON Zoltan wrote:
> [...]
>>>> So then can the behaviour of NATIVE_ENDIAN be changed to look at the 
>>>> machine endianness instead of replacing it with a constant?
>>> 
>>> No, that does not work. First, the machine knows about its devices, but a 
>>> device should not know about the wiring of the global machine (just like 
>>> in real life).
>> 
>> That means all devices should be either big or little endian and there 
>> should be no native endian ones. Why do we have those then?
>
> Some device can indeed be either big or little endian - think of devices that 
> are synthesized in an FPGA for example. But in most cases, it rather depends 
> on the bus wiring. Anyway, we need a config knob to allow either the one or 
> the other endianness for certain devices.
>
>> That's why this endianness property should either be removed from ops and 
>> only attached to it when added to a machine if needed or kept to show which 
>> machines it can be attached to: only big, little or both endian which is 
>> what it seems to be doing now.
>
> Again, devices should not know about machines, not the other way round. So 
> the device should offer a config switch (property) and the machine should set 
> it to the value that it needs.

That would mean this endianness in ops should be set when the memory 
region is mapped in the machine not when defining the device. So all 
device ops should really be NATIVE_ENDIAN and only assigned an endianness 
when they are mapped based on the machine/bus/cpu they are connected to.

>>> Second, imagine a board with e.g. a big endian main CPU and a little 
>>> endian service processor - how should a device know the right endianness 
>>> here?
>> 
>> How would that work with this series? So the proposed solution is to double 
>> the devices now marked as NATIVE_ENDIAN to have a big and a little endian 
>> variant for them so the board can choose?
>
> This is not doubling the devices. It just introduces a config property to let 
> the machine switch the endianness.

Yes, I've oversimpified, each ops has its own endianness config not the 
device. But since the endianness is not a property of the device or its 
regions but the bus it's connected to, this config switch may be at the 
wrong place now.

>> That does not exist in real as you wrote, there's only one device so then 
>> this is probably not the right way to model it.
>
> Some devices can exist in both, big and little endian variants. We could of 
> course create two devices for this, but that's nonsense if it can simply be 
> handled by a property instead.
>
>>>> Or would that be too much overhead? If always looking up the endianness 
>>>> is not wanted could the ops declaration keep NATIVE_ENDIAN 
>>> 
>>> IMHO we should get rid of NATIVE_ENDIAN completely since there is no 
>>> "native" endian in multi-CPU boards.
>> 
>> If we say NATIVE_ENDIAN means that the device can be attached to either big 
>> or little endian machine then we can keep this constant but when adding the 
>> ops to a memory region the board has to then decide which endianness it is 
>> and replace it with either big or little. Then we don't need two versions 
>> of the same device and NATIVE_ENDIAN means that the device can be used in 
>> both machines.
>
> Well, it's currently the devices that are calling memory_region_init_io().

That answers my question. Then it seems it's not so simple to set 
endianness when the device is mapped because it would need to be done 
somewhere else. It may still be possible but might be too much work to 
find it out.

> And since memory_region_init_io() does not copy the MemoryRegionOps struct,
> we need two implementations right now for this, one for big and one for 
> little endian. So I think Philippe's series here is fine.

It could copy the MemoryRegionOps when needed but seems it's not 
memory_region_init_io that would need to handle that. Given the current 
way it's implemented doubling the ops region may be the simplest even if 
not the correct way to do it so it's OK if there's no simple alternative 
that's more correct.

> But feel free to 
> suggest clean up patches on top if you think that the memory_region_init_io() 
> needs to be handled differently in QEMU everywhere.

I think so as I've described above but not enough to try to solve it so 
I'm OK with Philippe's series if there's no other way to make it less like 
a workaround for something that could be done clearer. Looks like other 
way might be too complex for now.

Regards,
BALATON Zoltan

