Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC937D46C06
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 21:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlDIG-0007Kw-1T; Wed, 28 Jan 2026 16:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlDID-0007Js-LZ; Wed, 28 Jan 2026 16:41:41 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlDIA-0002j3-TG; Wed, 28 Jan 2026 16:41:41 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E4073596A38;
 Wed, 28 Jan 2026 22:41:32 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id a9rIj2aupGtP; Wed, 28 Jan 2026 22:41:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BB7B9596A29; Wed, 28 Jan 2026 22:41:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B976C596A13;
 Wed, 28 Jan 2026 22:41:30 +0100 (CET)
Date: Wed, 28 Jan 2026 22:41:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, 
 Ruslan_Ruslichenko@epam.com
Subject: Re: [PATCH 00/27] hw/arm: Add generic FDT-based machine and
 infrastructure
In-Reply-To: <87ecn9aas7.fsf@draig.linaro.org>
Message-ID: <c2224358-ed7e-1bb9-5eaa-7ae1bafdb37a@eik.bme.hu>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
 <CAN-aV1EjYwSRfV87YQdtfqU5CH8Bsssr3EvStPWL2_VFOs4N4w@mail.gmail.com>
 <87ecn9aas7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1703265738-1769636490=:8425"
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

--3866299591-1703265738-1769636490=:8425
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 28 Jan 2026, Alex Bennée wrote:
> Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:
>> On Tue, Jan 27, 2026 at 11:03 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On Mon, 26 Jan 2026 at 17:43, Ruslan Ruslichenko
>>> <ruslichenko.r@gmail.com> wrote:
>>>>
>>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>>>
>>>> This patch series introduces new ARM machine model, arm-generic-fdt, and the underlying infrastructure required to instantiate a QEMU machine from a Device Tree.
>>>
>>> I'm afraid this has been a feature that has been suggested from
>>> time to time, but which I don't think is workable in general.
>>>
>>> Device tree files are designed to provide enough information to
>>> the guest kernel to allow it to find non-probeable hardware. They
>>> are not designed to provide enough information to QEMU to allow
>>> it to create and wire up all the hardware present on the system.
>>>
>>> There are specific niches where it can be made to work -- I think
>>> Xilinx have or had a setup where they were generating an FPGA
>>> model and a device tree and a guest kernel all from the same
>>> single data source, so they could put everything necessary into
>>> the dtb, for example -- but I don't think it works in the
>>> general case. As one simple example, the DTB doesn't generally
>>> have any information about how the Secure world works in an Arm
>>> system, because Linux doesn't care about the Secure world. It
>>> also doesn't usually have information that the guest OS can
>>> probe for itself at runtime.
>>>
>>> There has been periodic discussion of more flexible user-driven
>>> board creation, but that has generally been with the idea of using
>>> the QMP monitor to orchestrate creation and connection of device
>>> models.
>>>
>> I agree that a guest Device Tree is insufficient for describing a
>> complete QEMU machine model.
>> However, we separate the guest configuration from the machine
>> definition. The -hw-dtb option allows the user to provide a
>> QEMU-specific system description.
>> Those hw-dtb would not be passed to Linux Guest VM.
>>
>> The fact that this workflow has been successfully used in production
>> by AMD/Xilinx demonstrates that FDT is a feasible format.
>
> Where are the extensions to the FDT used for hw-dtb documented? How does
> it deal with PCI devices and the Secure world?

PCI devices don't need to be included in a machine description as they are 
not part of the machine only the PCI host is. PCI devices are plugged into 
the host with -device as with boards defined in C. For PCI devices that 
are instantiated by default on some machines including a node below the 
PCI host should likely work. I know nothing about secure world, that may 
need some extensions but fdt is basically describing objects and their 
properties so if it's one or a hierarchy of QOM objects that needs to be 
instantiated with defined properties it should be possible to describe it 
in fdt.

>> In contrast, QMP usage may end up even more complex and less
>> maintainable for the task of full system modeling.
>> To my understanding, this would need to generate too long configs,
>> which may eventually require some intermediate format by itself.
>>
>> I am proposing to use FDT as a serialization format to describe a
>> machine configuration. Theoretically we can use other formats, like
>> XML, but in my opinion FDT perfectly matches the requirements.
>
> The QMP interface is self-documenting and introspectable and used for
> the management of QEMU including things like hotplug. It is also QOM
> aware so a natural fit for dealing with the underlying QOM machinery.

QOM seems to be more about operating a machine rather than defining it for 
which fdt is an already established common way.

> Previous discussions have entertained the idea of making the parsing of
> hw-dtb an external script which would then translate into QMP commands
> to build up the machine.

That would be possible but it seems that directly parsing fdt in QEMU 
could be done with very few code and with some additional support from 
devices the latter of which is probably also needed when trying to 
interactively define a machine from command line, monitor or QMP.

Regards,
BALATON Zoltan
--3866299591-1703265738-1769636490=:8425--

