Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCB0C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 12:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcl9m-0005V6-Mv; Tue, 28 Jan 2025 07:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tcl9k-0005UU-Rb; Tue, 28 Jan 2025 07:57:28 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tcl9i-000673-Tq; Tue, 28 Jan 2025 07:57:28 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7D45F4E6029;
 Tue, 28 Jan 2025 13:57:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 3uK6LJmOcV0F; Tue, 28 Jan 2025 13:57:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 811C44E6027; Tue, 28 Jan 2025 13:57:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7E1B874577C;
 Tue, 28 Jan 2025 13:57:21 +0100 (CET)
Date: Tue, 28 Jan 2025 13:57:21 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Anthony PERARD <anthony@xenproject.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <graf@amazon.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>, 
 =?ISO-8859-15?Q?Cl=E9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 0/9] hw/sysbus/platform-bus: Introduce
 TYPE_DYNAMIC_SYS_BUS_DEVICE
In-Reply-To: <CAFEAcA-QOYcnJi=joKHbRmUCXK1UFOgQRgYP-fDq4h_1SkMGyQ@mail.gmail.com>
Message-ID: <2893a552-ca6c-01c4-dcc0-6107ccf1c7b5@eik.bme.hu>
References: <20250125181343.59151-1-philmd@linaro.org>
 <wkb53fhvfchqa4uvmifgitvcr7t7rfpc3hcohdhzczkzvktetx@yjveswjel3s4>
 <CAFEAcA-QOYcnJi=joKHbRmUCXK1UFOgQRgYP-fDq4h_1SkMGyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-275533675-1738069041=:16171"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-275533675-1738069041=:16171
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jan 2025, Peter Maydell wrote:
> On Tue, 28 Jan 2025 at 10:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> On Sat, Jan 25, 2025 at 07:13:34PM +0100, Philippe Mathieu-Daudé wrote:
>>> Some SysBus devices can optionally be dynamically plugged onto
>>> the sysbus-platform-bus (then virtual guests are aware of
>>> mmio mapping and IRQs via device tree / ACPI rules).
>>
>> Do we have some sane way to have user-pluggable sysbus devices on arm?
>
> The answer in a general sense is "no, because user pluggable
> sysbus is a weird idea". "sysbus" means "it's wired into a
> specific bit of the memory map and to specific IRQs, and whoever
> does that needs to know what IRQs and bits of memory are usable,
> and the guest OS needs to know it's there". "user-pluggable" means
> "it's all automatic and the guest can just do some kind of
> probing for what is or isn't present". All the platform bus stuff
> is a nasty mess that's working around the things people want
> to plug in not being clean devices on probeable buses :-(
> And the platform bus is only supported on the "virt" board,
> because that's the only one where QEMU is generating its
> own dtb or ACPI tables where it can tell the guest "hey,
> there's some device here".

There are some SoCs that have memory mapped devices but different versions 
in the same family have different devices. Either older ones missing some 
devices or have less USB or network ports while newer SoCs have more of 
those or they have PCIe instead of PCI. Modelling these could use 
pluggable sysbus devices so one could add the devices needed for a SoC 
version without having to write or modify a board code. I think Bernhard's 
attempt to try creating e500 SoCs from a device tree goes in that 
direction too. We could also model this by having a SoC that can 
instantiate devices based on some properties but maybe pluggable devices 
could be more generic for this. The issue seems to be how to tell the 
board or SoC where to map it and what IRQ to connect it as this is done by 
the board and not the device so properties on the device to set these does 
not really help unless the board can somehow query it and instantiate the 
devices based on that. Otherwise whatever handles the -device option to 
create the device would need knowledge about the board. (E.g. the e500 
devices are mapped in the CCSR memory region so one can't just use system 
address space for them.)

Regards,
BALATON Zoltan
--3866299591-275533675-1738069041=:16171--

