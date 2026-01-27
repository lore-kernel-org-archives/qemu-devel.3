Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E52D2F038
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkk4U-0002M7-3B; Tue, 27 Jan 2026 09:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkk4R-0002Jd-QZ; Tue, 27 Jan 2026 09:29:31 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkk4P-0003sY-0s; Tue, 27 Jan 2026 09:29:31 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 61A33596A38;
 Tue, 27 Jan 2026 15:29:25 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id n3wu_5ioGm7c; Tue, 27 Jan 2026 15:29:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F0C00596A10; Tue, 27 Jan 2026 15:29:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EEDCA596A13;
 Tue, 27 Jan 2026 15:29:22 +0100 (CET)
Date: Tue, 27 Jan 2026 15:29:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, 
 Ruslan_Ruslichenko@epam.com, Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 00/27] hw/arm: Add generic FDT-based machine and
 infrastructure
In-Reply-To: <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
Message-ID: <fb56de8d-1099-2e96-c195-07720545aa97@eik.bme.hu>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Tue, 27 Jan 2026, Peter Maydell wrote:
> On Mon, 26 Jan 2026 at 17:43, Ruslan Ruslichenko
> <ruslichenko.r@gmail.com> wrote:
>>
>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>
>> This patch series introduces new ARM machine model, arm-generic-fdt, and the underlying infrastructure required to instantiate a QEMU machine from a Device Tree.
>
> I'm afraid this has been a feature that has been suggested from
> time to time, but which I don't think is workable in general.

There were another experiment by Bernhard Beschow here: 
<https://github.com/shentok/qemu/commits/e500-fdt/> which seems 
surprisingly simple (the actual change to allow fdt based creation is 
this: 
<https://github.com/shentok/qemu/commit/857b19fe4bbb0ec42c92dab48411b5b8ab2da02c>) 
and works for creating some PPC e500 based machines (still work in 
progress though). We had a discussion of this here: 
<https://lists.nongnu.org/archive/html/qemu-ppc/2025-02/msg00198.html>
I don't remember if an RFC was submitted later and there were more reviews 
on that.

> Device tree files are designed to provide enough information to
> the guest kernel to allow it to find non-probeable hardware. They
> are not designed to provide enough information to QEMU to allow
> it to create and wire up all the hardware present on the system.
>
> There are specific niches where it can be made to work -- I think
> Xilinx have or had a setup where they were generating an FPGA
> model and a device tree and a guest kernel all from the same
> single data source, so they could put everything necessary into
> the dtb, for example -- but I don't think it works in the
> general case. As one simple example, the DTB doesn't generally
> have any information about how the Secure world works in an Arm
> system, because Linux doesn't care about the Secure world. It
> also doesn't usually have information that the guest OS can
> probe for itself at runtime.
>
> There has been periodic discussion of more flexible user-driven
> board creation, but that has generally been with the idea of using
> the QMP monitor to orchestrate creation and connection of device
> models.

Whatever interface is used to instantiate the objects it would need some 
description language to describe the machine and FDT while not the most 
user friendly can do that so it can be a candidate or alternative for 
other description language which can be considered. If the fdt that comes 
with Linux does not contain everything QEMU could still use a modified 
enhanced fdt that adds the needed details as long as fdt itself can 
describe that. It's nice if QEMU does not have to supply it's own FDT 
files and can just use those from Linux but even if that would not work 
does not mean fdt is not a usable way to define a machine.

Regards,
BALATON Zoltan

