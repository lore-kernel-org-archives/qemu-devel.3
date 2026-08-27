Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A39C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaSI-0001IZ-JP; Thu, 27 Aug 2026 09:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wzaSG-0001I3-Gv; Thu, 27 Aug 2026 09:47:44 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wzaSC-0006fg-Rn; Thu, 27 Aug 2026 09:47:44 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 038297A0191;
 Thu, 27 Aug 2026 09:47:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 27 Aug 2026 09:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1787838456;
 x=1787924856; bh=cGwT4DEVg2M8EW1Yh2hp/p+ZG1i2W5kMpe+M+1QEuY0=; b=
 Ud3tcY4V7nYfjdaRNLRCVCUnw61HhWDyIHxQH4xT5HOsuH7vY1f0IZ4KY5D5taAy
 clouGkesTyezLvM0wHsYVy/6cEDXYHogTBfACyEud9nEmdXob4syeKE2KaJ3T5Xd
 fVE/RazUr4Z9U98VWlvfBg8joZwV/y4+A2MTzCg7GB5d4SlG2Pr5e6NUc7sL/Oec
 pcYwzJW2sbl2JLIDeoNtbYGFXKZpszXc7a/fEaEt/e6dB/zOR6fov/79ikw7zg49
 KaXHA3/LepM4tGf7I+FLs89qwZpUxVoeoPdpoAEOK0kBrmBR8koyRpy+i7RW6hlm
 ijYudhKbPxo2iNWxb+Zugw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787838456; x=
 1787924856; bh=cGwT4DEVg2M8EW1Yh2hp/p+ZG1i2W5kMpe+M+1QEuY0=; b=E
 hrUkQBV4l5sVqBQtzVbM03KOZaepEXPDVQedfxcsyZiNdfwHwuMolXLlV7Bugk57
 8WF5rrVO+377ejilYVvm1h+hd/Dije29oZE6L+1PVnXv0Z7sIS8mfwDr7uAU3Buk
 mXMJBUa9FMjS8awHOJ47V9TBrW5l7//6ugSAEAMToQkr7UtfjiS5xOdXSgWXZ9qH
 GinxzeXKnuR6YwZwNlhwSqtSC6EO6bwqzlfUt2arVlhzNmgpQ9tFDu5ZWyE3BQ7+
 kfnnQt0/xC7qo/n9tq+JoS9hiMtqWlErmEQz8lreUtFRBlXT2Tiz8OS+7POQI3M7
 w4oPyF94GvpyCAv7IX7Jg==
X-ME-Sender: <xms:-D-QasjHFfdn4bb3UWpS-Mz80rXpwgcyAfJTvZs07bNa-6S4T8AW_A>
 <xme:-D-QatPQlSRppriVtKezzRfhmuE1nD1rlNinVlT9ZscKKNyTtM2w6fPECQ0wpIBVg
 8rA52XqdRIDmetRHemSqpU9cAOqbAksHdqhMBDk7JPT2-VVy8tuvA>
X-ME-Received: <xmr:-D-Qavo9ZjNMn3ImdkOHG0lUPEdf5xphqKS5j0oAYGj1yepdCWaaWQcpKHAztQ>
X-ME-Proxy-Cause: dmFkZTEMuZ7veVXHtQmzYDEDfY+Mr1XAMWCgcMg2aqOVGpl226CClR0Ld7sVVfWV7GV9b5
 FDxxTLyStD0x88aqd/kSFO88zdlEm1YRvGL+y6R2ttdZrRDbZmBzMTo2AhedJb7bu4UAbC
 nSckBwJBZPAh5a45VSlbPR0E3qaECVgdlyXteE3Z9lmPgbJylieh6ciD6Bc8diSOnLFEba
 Yj/3i9EYST/rd+q26+1mx763nZG5QSpYNgCYqQ/isWCNo4o7GBWWZfmwmsEXbRWAPawn8x
 bX7X8KL3EjNAuHNx/DfjCANIsljXogoN1qB9QTVG8cM1FrMX6dXCnaVxlsEO8Vf699bRHk
 nenB0v58+hm4X59jFtaV8WqNWyCK8JYXaGcugTg/xWeDpdo/2n41xJF9vYDuaLSkEfVjwC
 DXpHDZG0yO8Jgoe20YqSoaZjnTtB1YkIpJx2i8MbpeyE5NJ/GK8tUH+uLmJTxWHVV4arPI
 nN+cTOw3Cf7xSxInUtg7gm6c3ghzIG5Z9nsBYYKya9FvB+FQGgur59XqL6yuHgX9OPLBNT
 gsJjeJHe10frONg/vv9GouIFyXH2SsG5fW5FiYKEIWSm8TSNs01/Hj0HRb5UYsZEIaaO7W
 Yd+xhKrsqwvuDxBnCwor7zobhEib5DE3b8cn/JFh0VJRTlIp62TZYv0EG4Uw
X-ME-Proxy: <xmx:-D-Qan6FJw8tHYauWqQMPsSw3f_x2FI1DGoujBW6_I7RyACp_Ba5iA>
 <xmx:-D-QalhOOUF9ACFlV5lSxBGBr2EIMB8ZlzRWCFnGb4sbFyJp1m7lcA>
 <xmx:-D-Qal4-zsHjhKMXGyZ5LxBbyRqd1SbGh0RsRzxRJioInYYm1Qu5rA>
 <xmx:-D-QaiEdTKO_OUpfpc1iC8Xw1K8qBONeWAc0rjEjpXAQ_BHG_FuCGw>
 <xmx:-D-Qagf--YS3efjgH4t71PD8FjNlANIqxY1BOFia3v9CSqm9TM3za087>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 09:47:35 -0400 (EDT)
Date: Thu, 27 Aug 2026 07:47:33 -0600
From: Alex Williamson <alex@shazbot.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: alex@shazbot.org, Tushar Dave <tdave@nvidia.com>, qemu-devel@nongnu.org,
 jgg@nvidia.com, skolothumtho@nvidia.com, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 devel@edk2.groups.io
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Message-ID: <20260827074733.340aeb0c@shazbot.org>
In-Reply-To: <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=alex@shazbot.org;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Thu, 27 Aug 2026 09:18:50 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > Following the feedback, RFC v2 keeps PCI enumeration and resource
> > assignment in firmware. QEMU only validates the user-provided fixed
> > BAR configuration and provides the required metadata to firmware
> > through the "etc/fixed-bars" fw_cfg file.  
> 
> qemu already has vendor-specific pci capabilities.  They are used to
> pass hints for the bridge window sizes of pci bridges (including pcie
> root ports) with hotplug support.  See OvmfPkg/PciHotPlugInitDxe/ for
> the firmware side support.
> 
> I'd strongly recommend to do the same for the fixed bars:  Add a pci
> capability to pass that information.  All the logic you have today to
> link the information in the fw_cfg file to the correct pci device is
> simply not needed any more then.

Placement of a VMM defined capability into a vfio-pci device is not
such a trivial problem as it is for emulated devices.  Space may not be
readily available and the capability may mask non-architected registers.

Does this suggestion relate to fixing the gap between mapping fw_cfg
entries by vendor/device IDs or is there something fundamentally
undesirable about using fw_cfg here?
 
> > * fixed-bar=on on a PCIe root port marks its subordinate hierarchy for
> >   fixed BAR placement. Every device with memory BARs in that hierarchy
> >   must provide a complete pci-bars= configuration.  
> 
> Why is this needed?

AIUI, the problem space is greatly expanded if we mix user provided
fixed-bars with firmware assigned BARs and it's possible that there is
no solution that meets the requirements.  This option both simplifies
the problem space and allows the resource windows to be audited to
generate user actionable errors in QEMU.

> > * pci-bars=barN@<addr>[,barM@<addr>]... on a PCI endpoint specifies the
> >   required address for each memory BAR. All memory BARs on the device
> >   must have an explicitly assigned address.  
> 
> fixed-bar-<nr>=<addr> ?

Could be a reasonable alternative.  I'll let Tushar or others wrestle
with the deeper edk2 comments below ;)  Thanks,

Alex

> > On the firmware side, a new DXE driver, QemuFixedBarsDxe, installs
> > EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL before PciBusDxe starts.
> > When PciBusDxe calls CheckDevice() for a discovered PCI function, the
> > driver returns ACPI address descriptors with _MIF|_MAF set for fixed
> > BARs. Two small changes to PciBusDxe preserve these fixed addresses and
> > program them into the BAR registers during BAR programming.  
> 
> Expecting PciBusDxe respecting AddrRangeMin looks sensible to me ...
> 
> > After PciEnumerationComplete, QemuFixedBarsDxe walks each fixed
> > root-port hierarchy and programs the bridge memory windows to cover
> > the fixed BAR ranges assigned to endpoint devices.  
> 
> ... but changing things after-the-fact in platform code is a complete
> non-starter.  PciBusDxe needs to do that, i.e. take care that the bridge
> window assigned actually cover the fixed pci bars.
> 
> take care,
>   Gerd
> 
> 


