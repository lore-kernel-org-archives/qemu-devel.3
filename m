Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5F5F4BB62
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwAC-0008Cu-Dn; Tue, 24 Feb 2026 12:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vuwA9-0008Ai-3l; Tue, 24 Feb 2026 12:25:33 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vuwA6-0001EX-1F; Tue, 24 Feb 2026 12:25:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 562965969F6;
 Tue, 24 Feb 2026 18:25:26 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rwa40_B4xNIU; Tue, 24 Feb 2026 18:25:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C76C2596A0B; Tue, 24 Feb 2026 18:25:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C502F5969FD;
 Tue, 24 Feb 2026 18:25:23 +0100 (CET)
Date: Tue, 24 Feb 2026 18:25:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, artem_mygaiev@epam.com, 
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, 
 Ruslan_Ruslichenko@epam.com, philmd@linaro.org, wangyanan55@huawei.com, 
 zhao1.liu@intel.com, pbonzini@redhat.com, 
 Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH v2 19/33] hw/core/machine: add '-hw-dtb' option for machine
In-Reply-To: <CAN-aV1Ezvu1VnQJYiMDrNceaRAG32-DKtV85v2w58R4bpkL=KA@mail.gmail.com>
Message-ID: <0bfb8cfc-a793-30cd-72c6-98b7a8177d32@eik.bme.hu>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
 <dd8a92cc-51d6-4404-bd09-75b1798f925a@redhat.com>
 <87y0kj4mr3.fsf@draig.linaro.org>
 <CAN-aV1H0_4LviryDEmDSN0TfdSit-uN31H8g87sRBkJAHYbrdQ@mail.gmail.com>
 <d2d16e2b-d86a-633f-b32a-e063746658d8@eik.bme.hu>
 <CAN-aV1Ezvu1VnQJYiMDrNceaRAG32-DKtV85v2w58R4bpkL=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1681850486-1771953923=:78977"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1681850486-1771953923=:78977
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 24 Feb 2026, Ruslan Ruslichenko wrote:
> On Tue, Feb 24, 2026 at 12:55 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Mon, 23 Feb 2026, Ruslan Ruslichenko wrote:
>>> On Mon, Feb 23, 2026 at 2:23 PM Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>>  Hi!
>>>>>
>>>>> On 19/02/2026 15.48, Ruslan Ruslichenko wrote:
>>>>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>>>>> Add new '-hw-dtb' command-line option and corresponding
>>>>>> MachineState property.
>>>>>> The 'hw-dtb' option allows to specify a Device tree
>>>>>> binary with hardware description which Qemu should
>>>>>> emulate.
>>>>>> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>>>>> ---
>>>>>>   hw/core/machine.c        | 19 +++++++++++++++++++
>>>>>>   include/hw/core/boards.h |  1 +
>>>>>>   qemu-options.hx          |  9 +++++++++
>>>>>>   system/vl.c              |  3 +++
>>>>>>   4 files changed, 32 insertions(+)
>>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>>> index d4ef620c17..affd24cd49 100644
>>>>>> --- a/hw/core/machine.c
>>>>>> +++ b/hw/core/machine.c
>>>>>> @@ -363,6 +363,20 @@ static void machine_set_dtb(Object *obj, const char *value, Error **errp)
>>>>>>       ms->dtb = g_strdup(value);
>>>>>>   }
>>>>>>   +static char *machine_get_hw_dtb(Object *obj, Error **errp)
>>>>>> +{
>>>>>> +    MachineState *ms = MACHINE(obj);
>>>>>> +
>>>>>> +    return g_strdup(ms->hw_dtb);
>>>>>> +}
>>>>>> +
>>>>>> +static void machine_set_hw_dtb(Object *obj, const char *value, Error **errp)
>>>>>> +{
>>>>>> +    MachineState *ms = MACHINE(obj);
>>>>>> +
>>>>>> +    ms->hw_dtb = g_strdup(value);
>>>>>> +}
>>>>>> +
>>>>>>   static char *machine_get_dumpdtb(Object *obj, Error **errp)
>>>>>>   {
>>>>>>       MachineState *ms = MACHINE(obj);
>>>>>> @@ -1145,6 +1159,11 @@ static void machine_class_init(ObjectClass *oc, const void *data)
>>>>>>       object_class_property_set_description(oc, "dtb",
>>>>>>           "Linux kernel device tree file");
>>>>>>   +    object_class_property_add_str(oc, "hw-dtb",
>>>>>> +                            machine_get_hw_dtb, machine_set_hw_dtb);
>>>>>> +    object_class_property_set_description(oc, "hw-dtb",
>>>>>> +                "A device tree binary used to describe the hardware to QEMU");
>>>>>
>>>>> Do the hardware dtbs differ from the ones that are passed to the Linux
>>>>> kernel? If not, I think you likely could use the existing "dtb"
>>>>> property for your new feature?
>>>>
>>>> They have to - the normal DTB cannot define the whole system because its
>>>> only concerned with reporting what the kernel can see to the kernel and
>>>> not defining the whole system including what the firmware sees.
>>>>
>>>
>>> Yes, Indeed.
>>> Normal DTB was explored, but there is not enough information to create
>>> QEMU models from it.
>>> Thus we need to have a separate device tree.
>>
>> What additional data is needed that's not present in dtb from firmware and
>> what if that additional data is passed to the kernel? I think the kernel
>> would just ignore the additional data that it doesn't need so one dtb
>> might be enough even if it has to be more detailed than what the kernel
>> normally gets. If that works we don't need a separate option.
>>
>
> Here are few specific examples:
>
> 1. DTS compatibles and QOM type names are all different.
> Using Linux device tree would require to maintain some massive hardcoded mapping
> even for devices that otherwise don't require any special handling.

Bernhard's patches had the same issue and solved it by adding subclasses 
with names matching the dtb. I think that would not work but a better 
approach is to allow alias names for devices (we already have machine name 
aliases I thought something similar for devices) that would solve this 
issue without too much additional complexity. Then the device would just 
need an additional line registering an alias name to match the dtb name 
(or more of different machines have different compatible names).

> 2. Object properties. We would probably need to make sure there is no conflicts
> and all properties are either ignored by Linux drivers or have exactly
> the same meaning.
>
> 3. Devices mapped to Secure Firmwares only. Those are not accessible by Linux
> and trying to initialize them from the Linux kernel would cause memory aborts.
>
> 4. Connecting devices to backends such as serial, block devices, etc.
> We need to specify corresponding 'chardev' and 'driver' properties.

This is probably not part of the machine but a specific invocation so 
these should be specified on the command line and not in the machine 
definion.

> 5. Interrupt wiring. Some hardware lines are transparent to Linux, but need be
> wired by QEMU. For example, interrupt controllers are wired to CPUs, etc.
> If we would want to initialize it from dts eventually, this would need to be
> passed somehow.
>
> Overall, my understanding is Device models typically need to support
> booting existing
> OS images and device trees from regular platform builds.
> And at least due points 2-4, we cannot use them directly.

Some of the points may be solved other than modifying dtb but some may 
indeed need extensions so a separate hw-dtb may be needed in more complex 
cases.

> Since we still need to modify the device tree for QEMU anyway, having support
> for unified DTS doesn't really make sense.

However it may be worthwile to try keeping the modifications minimal so 
for simple machines like the e500-ppc that has no secure world or other 
things not described by the normal dtb it could just use the regular dtb 
and the hw-dtb option would be optional for more complex machines that 
need it.

>> This series seems to be more complex than Bernhard's e500-fdt experiment
>> (I've linked to that in
>> <https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg05470.html>)
>> Bernhard's patch only added minimal support for creating devices from fdt
>> and then put additional logic in the devices instead of handling them in
>> generic code. Would such an approach lead to simpler fdt handling? If not
>> why is the additional complexity needed?
>
> Most devices can be created from generic code. Supporting one common
> approach to initialize some specific device class would be simpler and more
> maintainable than writing a custom FDT handler logic within each device model.

I think putting device specific knowledge in generic code is against the 
object oriented design of QEMU and would be less maintainable because it 
would not belong to the device maintainers that way. If you have common 
code for some device classes then those devices probably have a superclass 
where this code could be put. The problem of mapping property names to 
device specific properties could also be done easier within a device model 
which has better knowledge of the device and then we would not need a 
global table mapping these. So while at first look it may seem more 
fragmented putting some logic in devices instead of a central place it's 
better fits the object model and groups device specific logic in the 
device model which is more maintainable than a global mapping that does 
not belong to any device but touches several unrelated devices.

Regards,
BALATON Zoltan
--3866299591-1681850486-1771953923=:78977--

