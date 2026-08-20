Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD0C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwA9-00058X-Og; Thu, 20 Aug 2026 02:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwwA5-000581-56; Thu, 20 Aug 2026 02:22:01 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwwA1-0004Fx-3Y; Thu, 20 Aug 2026 02:22:00 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hQYHd22ryz66gb;
 Thu, 20 Aug 2026 06:21:48 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 20 Aug 2026 06:21:48 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.201])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQYHc4Jv9z1ys0; Thu, 20 Aug 2026 06:21:48 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 78A9012E3F5B;
 Thu, 20 Aug 2026 06:21:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00661074592-f8eb-4f68-bcfb-8ba6520df982,
 290C66463DCC85845983D07CBD6D5DF49C8F16C8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <4135cc6c-2358-4b82-8eec-f49132799869@kaod.org>
Date: Thu, 20 Aug 2026 08:21:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add IBM Huygens BMC machine for AST2700
To: Mikail Sadic <mikail.sadic@ibm.com>, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, ninad@linux.ibm.com, titusr@google.com,
 jeuk20.kim@samsung.com, philmd@mailo.com, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260813193040.669533-1-mikail.sadic@ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260813193040.669533-1-mikail.sadic@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 11311916366334110851
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGvX1GBrs/gm2aZdVM1fG23g7TdnevW+cVneaSX9Hj832O0dkJrHftAgucgH4CG6hJ+TcvqTNY7tT76SOPLhG7jIw7gwS1DUCLjaEiOdLnYwhRnU5kY5zaYJZEIFm81rSGejNpnR4GOCnXpwgKgBGE7ie5JIojf7SvfqblWo4o4S1cipCBpX/3UFJh5yOTfwXnqLowSDVvdtlj2EsS0u6t/NEDx9MLl/koAgDRkZ9dNdNe9IwksLi+FU/ZRq5N3smEaN0vHZuY7x2MEXwJSp0BZ62HkL+ayW6lFgVDQAxDrD6hxnRuuAJh2rROoaSv9hVtDPDmjY+XdgaZPbl8BgjuWpvdbjlX1s7h5gJdqNBWzau1vXs7IAqBS7eDIbBjkb38OJ17ruOO//bwNNs93lHY4Kuc1nrysnw8n9vFW2iYPibkLeJHbPe/VrVdCsuryurpqYMysJihKbaB1T1xVeTtWLIX22e0HI7OzGVVGlZ6Eg9MdZXwKKQ14Zg3w3H28BzepS/kkDetAGst/1WAmkZrEizO+mfEuHU4CoaAUx+bmGZoVUtX2tTeUoGdwrscn1C0Z2SfMlLw321dRxEw3KopW9tODhaGdiHoUAL2JldPxPDam4fkof+r+1f+dHyOxSXaRtmqgFOnEUKs9oRsp3lbxB4NC2EthS/LCz3xgnrv+kA
DKIM-Signature: a=rsa-sha256; bh=SY6AZKdu9/TczBJfbeVeeI8RM7hWjOSy8PS7JlRBTmM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787206911; v=1;
 b=VJg6YVLTaAw2os83l3Px/0PNgEvUc0dhmKCjaR40JJmKqhMiTrs3OL0Vrplc2rfeeJnNm2Sd
 +ye3qDQyNw2dGDroK5CF+qW0xgtwS+h/5dm+bFg2/ewzDyJb2IzKLIeICpCljgYHCoE+eekZQBB
 P0HGdbq0pWhugO5iOoaaty9QJ8H9hzbURZIL91ZlTFGQ7804Nib/gkUvKVRRKhOnXxdJsaeEsgq
 VtGtGzGkG2nQkioQrqHkIcPLCfeQ+MZPMcbMrOyh+GsK6OODr0jyEuXLldzRSdmME4O1Id+rTC0
 07dE6p/YfAZOVwBKZigvsdM3B3n0m8vlsSMMdzMvDjtzA==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mikail,

On 8/13/26 21:30, Mikail Sadic wrote:
> This series adds initial support for the IBM Huygens BMC, the baseboard
> management controller of an IBM POWER12 server platform, based on the
> ASPEED AST2700 A2 SoC.
> 
> It introduces a CFAM-S FSI responder model, wires the AST2700 FSI
> controllers to their APB-to-OPB bridges, adds a TI UCD90320 PMBus
> power-sequencer model, adds an AST2700 UFS host controller on top of the
> generic sysbus UFS device, and finally adds the huygens-bmc machine that
> ties these together to boot OpenBMC from FMC flash and a UFS root
> filesystem.
> 
> Dependencies, both on-list, neither merged yet:
> 
> 1. Jeuk Kim's UFS restructure, which patches 5 and 6 build on:
> 
>       https://lore.kernel.org/qemu-devel/cover.1786096976.git.jeuk20.kim@samsung.com/


Since this series is the primary user of the UFS restructure, would you
have time to review it ?

> 
>     The base-commit trailer below therefore names a local commit: current
>     master plus those two patches. Patches 1-4 and 7 do not need it.
> 
> 2. Jamin Lin's I2C block-read fix:
> 
>       https://patchwork.kernel.org/project/qemu-devel/patch/20260813090205.853307-1-jamin_lin@aspeedtech.com/

Same here.

Thanks,

C.


>     This one is a runtime rather than a build dependency, which is why the
>     series is not based on it. Everything compiles and every machine
>     constructs without it, but the UCD90320 in patch 4 will not probe,
>     because the ucd9000 driver identifies the device with an SMBus block
>     read and the AST2700 reports the block length from a register that
>     patch models. I have tested his patch against that driver and it works;
>     the Huygens-BMC boot was run with it applied.
> 
>     The guest also needs a kernel that reads the block length from the
>     right register on AST2700, i.e. one carrying
> 
>       https://github.com/AspeedTech-BMC/linux/commit/f9938ec5799e
> 
> Patch summary:
> 
>    1. fsi/cfam: a common CFAM model holding the slot, config table,
>       responder and local bus, with the existing cfam as its first
>       derivative. No functional change to the existing cfam.
>    2. fsi/cfam: the CFAM-S as a second derivative - its own config table,
>       the slave-ID alias window, and a v1 mailbox engine added to lbus.c
>       alongside the scratchpad.
>    3. arm/aspeed: wire the two AST2700 FSI controllers to their APB-to-OPB
>       bridges.
>    4. hw/sensor: TI UCD90320 24-rail PMBus power sequencer.
>    5. ufs: a configurable logical-block-size on ufs-lu, and an unmapped LUN
>       answering INQUIRY as "not connected". The ufs PCI device keeps its
>       current property set and geometry.
>    6. ufs/aspeed: the AST2700 UFS host controller as a subclass of
>       TYPE_SYSBUS_UFS, adding only the UFSHCI version.
>    7. arm/aspeed: the huygens-bmc machine.
> 
> Changes since v3:
> 
> * Dropped the i2c/aspeed patch (v3 4/8). Jamin Lin has posted the correct
>    implementation, which the UCD90320 now depends on instead; reviewed and
>    tested, see the dependency note above. The guest also needs the AST2700
>    kernel fix linked there.
> 
> * Rebased onto current master, which is past the 11.1.0 release. v3 was on
>    v11.1.0-rc3. The only conflict was hw/arm/Kconfig, where the UCD90320
>    select landed next to the newly added ADC128D818 one.
> 
> * No other patch changed. Patches 1-3 and 5-7 are the v3 patches with
>    only their numbering shifted.
> 
> Not addressed in this series:
> 
> * CFAM extended addressing (Miles): the mode where a single CFAM has 8MB
>    rather than four cascaded CFAMs sharing that space. This changes the
>    addressing model of the existing FSI/CFAM code rather than anything this
>    series introduces, so it's left as follow-up work. It does bear on
>    patch 2 though: the CFAM-S there aliases one 2MiB slot across the 8MiB
>    window to fold the slave-ID views together, and if extended addressing
>    is modelled properly that window is probably the wrong shape or should
>    not exist at all.
> 
> * A functional test for the machine. The v1 test depended on non-public
>    Huygens images and was dropped; it will be resent once images can be
>    published.
> 
> Testing done:
> 
> * Whole series builds, and each of the 7 patches builds standalone.
> * make check passes.
> * huygens-bmc boots OpenBMC to the login prompt and multi-user target
>    from FMC flash + UFS storage (internal images), with Jamin's I2C patch
>    applied. The UCD90320 probes, reports its device identification over an
>    SMBus block read, and the power sequencer publishes system power state.
> * PCI UFS qtests pass (13/13), unchanged by patch 5.
> * aspeed_fsi-test passes (4/4), unchanged by the CFAM patches.
> * huygens-bmc, ast2700-evb and ast2600-evb all construct successfully.
> * On huygens-bmc, the UFS version register reads 0x00000200, and the
>    ufs-lu created by the board reports a 512-byte block size and passes it
>    to its backing scsi-hd. The PCI ufs device with no property set still
>    reports 4096.
> 
> Changes since v2 (unchanged from the v3 posting, for reference):
> 
> * UFS: rebased onto Jeuk Kim's restructure, as requested. The v2 core
>    refactor (v2 patch 6) is dropped entirely, Jeuk's patch 1 supersedes it.
>    hw/ufs/aspeed_ufs.c is now a subclass of TYPE_SYSBUS_UFS whose only
>    AST2700-specific behavior is pinning the controller version register
>    to 2.0, chained after the parent realize. MMIO, IRQ, DMA address space,
>    properties, migration state and unrealize all come from the generic
>    sysbus device, and the Aspeed type adds no instance fields.
> 
>    The two behaviors Huygens needs that the restructure does not provide
>    are now their own patch, placed ahead of the Aspeed patch: the ufs-lu
>    logical-block-size property (default unchanged, so the PCI device is
>    unaffected) and the unmapped-LUN INQUIRY reporting "not connected"
>    rather than failing the request. logical-block-size now also rejects
>    non-powers-of-two, values outside 512..UFS_BLOCK_SIZE, and a drive
>    shorter than one block, which would previously have realized a
>    zero-block unit.
> 
>    The Aspeed SoC Kconfig now selects UFS_SYSBUS. It previously relied on
>    UFS_PCI being enabled via "imply PCI_DEVICES".
> 
> * CFAM: dropped the State suffix from the instance struct names (Miles).
>    FSICFAMCommonState becomes FSICFAMCommon; FSICFAMState, which predates
>    this series, becomes FSICFAM to match rather than leaving the two
>    spellings side by side in one header; FSICFAMSState becomes FSICFAMS.
>    The FSI prefix is kept. The class structs keep their suffix, as is
>    usual for QOM. Also fixed patch 1 to check the realize_engines() return
>    value.
> 
> * Machine: reworded the commit message (Miles). No code change.
> 
> Note: checkpatch reports a couple of MAINTAINERS/SPDX warnings for the
> new files; they are covered by existing wildcard entries in the ASPEED
> and FSI sections.
> 
> Thank you again for all of the feedback.
> 
> Mikail Sadic (7):
>    fsi/cfam: Add common CFAM base class
>    fsi/cfam: Add CFAM-S model
>    arm/aspeed: Wire AST2700 FSI controllers to APB-to-OPB bridges
>    hw/sensor: Add UCD90320 model
>    ufs: Make the logical block size configurable and answer absent LUNs
>    ufs/aspeed: Add AST2700 UFS host controller
>    arm/aspeed: Add AST2700 Huygens machine
> 
>   MAINTAINERS                     |   3 +
>   docs/specs/aspeed-ufs.rst       |  46 ++++++
>   docs/specs/fsi.rst              |  15 ++
>   docs/specs/index.rst            |   2 +
>   docs/specs/ucd90320.rst         |  36 +++++
>   docs/system/arm/aspeed.rst      |  50 ++++++-
>   hw/ufs/ufs.h                    |   3 +
>   include/hw/arm/aspeed.h         |   1 +
>   include/hw/arm/aspeed_soc.h     |   3 +
>   include/hw/fsi/cfam-s.h         |  40 ++++++
>   include/hw/fsi/cfam.h           |  68 ++++++++-
>   include/hw/fsi/fsi-master.h     |   4 +-
>   include/hw/fsi/lbus.h           |  11 ++
>   include/hw/ufs/aspeed_ufs.h     |  15 ++
>   hw/arm/aspeed.c                 |  25 ++++
>   hw/arm/aspeed_ast27x0.c         |  31 ++++
>   hw/arm/aspeed_ast27x0_huygens.c | 241 ++++++++++++++++++++++++++++++++
>   hw/fsi/cfam-s.c                 |  91 ++++++++++++
>   hw/fsi/cfam.c                   | 125 ++++++++++-------
>   hw/fsi/fsi-master.c             |   9 +-
>   hw/fsi/lbus.c                   |  69 +++++++++
>   hw/sensor/ucd90320.c            | 169 ++++++++++++++++++++++
>   hw/ufs/aspeed_ufs.c             |  67 +++++++++
>   hw/ufs/lu.c                     |  67 ++++++++-
>   hw/ufs/ufs.c                    |   2 +-
>   hw/arm/Kconfig                  |   2 +
>   hw/arm/meson.build              |   1 +
>   hw/fsi/meson.build              |   2 +-
>   hw/fsi/trace-events             |   2 +
>   hw/sensor/Kconfig               |   4 +
>   hw/sensor/meson.build           |   1 +
>   hw/ufs/meson.build              |   1 +
>   32 files changed, 1142 insertions(+), 64 deletions(-)
>   create mode 100644 docs/specs/aspeed-ufs.rst
>   create mode 100644 docs/specs/ucd90320.rst
>   create mode 100644 include/hw/fsi/cfam-s.h
>   create mode 100644 include/hw/ufs/aspeed_ufs.h
>   create mode 100644 hw/arm/aspeed_ast27x0_huygens.c
>   create mode 100644 hw/fsi/cfam-s.c
>   create mode 100644 hw/sensor/ucd90320.c
>   create mode 100644 hw/ufs/aspeed_ufs.c
> 
> 
> base-commit: 7a66901b243ca3b401db8a8e45245e0518339974


