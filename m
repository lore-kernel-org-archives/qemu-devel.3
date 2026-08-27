Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90CBC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbG6-0006RS-4n; Thu, 27 Aug 2026 10:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1wzbG5-0006RB-2J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:39:13 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1wzbG1-0002pC-RO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:39:12 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0758B600D2;
 Thu, 27 Aug 2026 14:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BC91F00A3D;
 Thu, 27 Aug 2026 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787841546;
 bh=SPp5v2Ff49Y/mUeynzjh0w1Ir2EPdQrn16iLhxNqWAk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=fF8rk+NRNKAeTKL+jcWMGuW0bxSonP35vSqyXi0ZYEs2/ti+CA96GmBe6ryxBV3OH
 TE9d+z2JJitx/62VqgbbiADfIACH+KxYwvRwSh823cX/kevmTzFr4qwNntpQ9i9zfA
 pRUVrOllC3xMDiRFIvJInlzQxUJ0bgcIwb+7nKp38bn0GOAWmCEk/c7omOJ9ivix+o
 hpPCKGRJJBQGPxCfxvP9IxvtXI6vbsxWGmOKeD5qucz70r6AkPFPg+aWZSUj8hesYn
 Xrwc1w4lhSXgAEZ2ccRXIKCD8BLLp3AFA3NuphhXqyFXXaSzaNgBq277hVo3lfShbE
 7L2TrUgGpJdBA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfauth.ams.internal (Postfix) with ESMTP id 6FDB31980076;
 Thu, 27 Aug 2026 10:39:04 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
 by ams-compute-02.internal (MEProxy); Thu, 27 Aug 2026 10:39:04 -0400
X-ME-Sender: <xms:BkyQarus-AbPnjU__8sqXqWv2X00qdZAXRJ8jQLsRHpe7rzFD6nvxg>
 <xme:BkyQanRhBKV3OEly3o-NumwKYLWvvlxVrdPDrbdrwMUYn4PKdopHaBKNNf6aXuqRp
 oVcHvYymLGk5fvpVclUEm4K6GOVSgg_Auy0vBjGfScSgslSsBbicBg>
X-ME-Proxy-Cause: dmFkZTFMZ8fxNLT6c+5aiMav8wHkxaSbkbWi4hhCahSIePd4hYyHy+zTnG4OBIA5fFtG4b
 HtgstLqm7OlrXpAfFYKZVEFlE1mmoSnnZ7pwWnogGTvS91x5a9TXqjl56cmzyerdCkX5hI
 24HsUBmhGxNYuJ2RFYkOPREJduRAinHeGiMcq26JL5ro1bR3koZr+44mZyzRg0PoYrXsE5
 39Eerz9gSlx3sUdQyotDN3kcko/6RXN2hhds8V/TtPC19/ZraMBcoLwF2rcekdwKCa6qTK
 cyPcajPJEBSAYk/yd4+IDYXEYEnW4aEIrwzxhn9HAjwbVa8EFibLkoC8Fpt3pzIbp1iELq
 m+sU/h4FyEc9p2rW2nf2VJYxh4AevMAn0PYP3kP0kE4MKPmEpARRdLp9hV7Cwtzv0/PIz6
 oNHdVQrHrpUjUUCRzdO8uU++HymHevjCRYD7l6kmruqnO8OgBeLC8O3Q8oygQ2ht515+He
 Z7L3nMzoCoN/F1kEl3Qfk3phUo7z7PvtCPt5rSSVWKWmGp/MiV1Ucdc2mZ2dabW8d1iuC0
 5CazODk2zh8rM7l4hatFloTlfXjOHTKRGiwbZIek6qHnK3mcjqnNCem3LUv0fdt7Bu37tn
 AvCxHpEdFiAL6zZ+Em4nQJjaR+6fwh7mFLDkDxRxo3OcTl7bhiuWdT42TiLA
X-ME-Proxy: <xmx:CEyQajaoBJVxpxTRHYraxd7t5GWPF5Ny3Lb_MGT-SFQ1RicsRnxouQ>
 <xmx:CEyQagqpXOqKgQs9TotsVG_6QlTgHMzOSkpR_E3y7w_wuz3a45r8cw>
 <xmx:CEyQavQ42YHa6r1A6t6-mQCi3eWeBN-8TpxarBdDnrL0B754Wk3JJw>
 <xmx:CEyQaspKfYIa-oDspSSPp5RzjnB11hrNt6Cygt6xVK0rSIS-bAEIdA>
 <xmx:CEyQah1vjQ70v-EQSKe9tLwF_3oW6LAVofsa_UXJHUAeVDGABJ9ieQcK>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 143C7F8007B; Thu, 27 Aug 2026 10:39:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 16:38:41 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "devel@edk2.groups.io" <devel@edk2.groups.io>,
 "Alex Williamson" <alex@shazbot.org>, "Gerd Hoffmann" <kraxel@redhat.com>
Cc: "Tushar Dave" <tdave@nvidia.com>, qemu-devel@nongnu.org,
 "Jason Gunthorpe" <jgg@nvidia.com>, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, marcel.apfelbaum@gmail.com
Message-Id: <46b4544a-6e97-4433-b3e2-60cf43e62c7b@app.fastmail.com>
In-Reply-To: <20260827074733.340aeb0c@shazbot.org>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
Subject: Re: [edk2-devel] [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR
 placement
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=ardb@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On Thu, 27 Aug 2026, at 15:47, Alex Williamson via groups.io wrote:
> On Thu, 27 Aug 2026 09:18:50 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>>   Hi,
>> 
>> > Following the feedback, RFC v2 keeps PCI enumeration and resource
>> > assignment in firmware. QEMU only validates the user-provided fixed
>> > BAR configuration and provides the required metadata to firmware
>> > through the "etc/fixed-bars" fw_cfg file.  
>> 
>> qemu already has vendor-specific pci capabilities.  They are used to
>> pass hints for the bridge window sizes of pci bridges (including pcie
>> root ports) with hotplug support.  See OvmfPkg/PciHotPlugInitDxe/ for
>> the firmware side support.
>> 
>> I'd strongly recommend to do the same for the fixed bars:  Add a pci
>> capability to pass that information.  All the logic you have today to
>> link the information in the fw_cfg file to the correct pci device is
>> simply not needed any more then.
>
> Placement of a VMM defined capability into a vfio-pci device is not
> such a trivial problem as it is for emulated devices.  Space may not be
> readily available and the capability may mask non-architected registers.
>

Is this the reason we cannot rely on the Enhanced Allocation (EA)
capability here?

> Does this suggestion relate to fixing the gap between mapping fw_cfg
> entries by vendor/device IDs or is there something fundamentally
> undesirable about using fw_cfg here?
> 

I much prefer this approach over the previous one, as the PCI resource
allocation logic remains in the firmware where it belongs.

However, the OS may still re-assign/re-balance things in some cases, and
so using a non-standard mechanism here means that the OS needs to learn
that these devices are special.

...
>
>> > On the firmware side, a new DXE driver, QemuFixedBarsDxe, installs
>> > EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL before PciBusDxe starts.
>> > When PciBusDxe calls CheckDevice() for a discovered PCI function, the
>> > driver returns ACPI address descriptors with _MIF|_MAF set for fixed
>> > BARs. Two small changes to PciBusDxe preserve these fixed addresses and
>> > program them into the BAR registers during BAR programming.  
>> 
>> Expecting PciBusDxe respecting AddrRangeMin looks sensible to me ...
>> 
>> > After PciEnumerationComplete, QemuFixedBarsDxe walks each fixed
>> > root-port hierarchy and programs the bridge memory windows to cover
>> > the fixed BAR ranges assigned to endpoint devices.  
>> 
>> ... but changing things after-the-fact in platform code is a complete
>> non-starter.  PciBusDxe needs to do that, i.e. take care that the bridge
>> window assigned actually cover the fixed pci bars.
>> 

Agreed - if the bridge windows are not programmed correctly on the first
pass, there is something in the code that needs to be fixed. I don't think
papering over it like this is the right approach.


