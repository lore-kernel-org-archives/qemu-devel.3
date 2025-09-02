Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2CDCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 14:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utRZh-0001BG-MB; Tue, 02 Sep 2025 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utRZ4-0000wO-V5; Tue, 02 Sep 2025 10:00:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utRYz-0003RC-KW; Tue, 02 Sep 2025 10:00:50 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cGS7S66Qzz4w9g;
 Wed,  3 Sep 2025 00:00:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cGS7L47H3z4w2Q;
 Wed,  3 Sep 2025 00:00:30 +1000 (AEST)
Message-ID: <51323a4b-b0a0-4515-a028-adf72e897b3d@kaod.org>
Date: Tue, 2 Sep 2025 16:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 00/11] Support PCIe RC to AST2600 and AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250819090141.3949136-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250819090141.3949136-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Jamin,

On 8/19/25 11:01, Jamin Lin wrote:
> v1:
>   1. Add PCIe PHY, CFG, and MMIO window support for AST2600.
>      Note: Only supports RC_H.
>   2. Add PCIe PHY, CFG, and MMIO window support for AST2700.
>      Note: Supports 3 RCs.
> 
> Testing PCIe RC model with e1000e PCIe device model
> 
> AST2600
> 
> The AST2600/ASPEED PCIe driver treats root bus 0x80 specially:
> Only two device addresses are usable on the root bus:
> addr 0: ASPEED host bridge
> addr 8: usable for attaching a PCIe root port
> 
> To attach endpoints without driver changes, the test places a QEMU PCIe root
> port at 0x80:08.0 and attaches an e1000e NIC behind it.
> The endpoint then enumerates on bus 0x81.
> 
> QEMU command line additions
> -device pcie-root-port,id=root_port0,slot=1,addr=8,bus=pcie.0
> -device e1000e,netdev=net0,bus=root_port0
> -netdev user,id=net0
> 
> Verification with lspci:
> 0001:80:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
> 0001:80:08.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> 0001:81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
> Connection
> 
> This is a temporary solution that allows attaching multiple PCIe
> devices while the ASPEED drivers does not support placing endpoints directly
> on bus numbers 0x80.

Could we try to model the real HW topology ? On an ast2600a3 EVB
with a PCI serial adapter plugged in the available slot :

   root@ast2600-default:~# lspci
   80:00.0 Host bridge: ASPEED Technology, Inc. Device 2600
   80:08.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
   81:00.0 Serial controller: MosChip Semiconductor Technology Ltd. MCS9922 PCIe Multi-I/O Controller
   81:00.1 Serial controller: MosChip Semiconductor Technology Ltd. MCS9922 PCIe Multi-I/O Controller

What is blocking us from modeling "Device 2600" ?


Thanks,

C.

  



> Reference:
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/drivers/pci/controller/pcie-aspeed.c#L309
> 
> Test Image: ASPEED SDK v09.07. It okay to use ASPEED SDK v09.06.
> https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz
> 
> The e1000e driver is built into this image.
> After booting, users should see the e1000e Ethernet interface.
> With this setup, RC_H on AST2600 can be tested using e1000e endpoints in QEMU.
> 
> Example system output:
> root@ast2600-default:~# lspci
> 80:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
> 80:08.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> 81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> root@ast2600-default:~# ifconfig eth4
> eth4      Link encap:Ethernet  HWaddr 52:54:00:12:34:5A
>            inet addr:169.254.160.167  Bcast:169.254.255.255  Mask:255.255.0.0
>            inet6 addr: fe80::5054:ff:fe12:345a/64 Scope:Link
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:19 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:54 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:4896 (4.7 KiB)  TX bytes:8079 (7.8 KiB)
>            Interrupt:81 Memory:70040000-70060000
> 
> root@ast2600-default:~# dmesg | grep "e1000e"
> [    2.901955] e1000e: Intel(R) PRO/1000 Network Driver
> [    2.902346] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   15.366727] e1000e 0000:81:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [   15.431884] e1000e 0000:81:00.0 0000:81:00.0 (uninitialized): registered PHC clock
> [   15.508477] e1000e 0000:81:00.0 eth4: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:5a
> [   15.509301] e1000e 0000:81:00.0 eth4: Intel(R) PRO/1000 Network Connection
> [   15.510768] e1000e 0000:81:00.0 eth4: MAC: 3, PHY: 8, PBA No: 000000-000
> [   49.781217] e1000e 0000:81:00.0 eth4: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> 
> AST2700:
> 
> The ASPEED PCIe driver only supports bus 0 with a single device at slot 0,
> which is reserved for the internal bridge. All endpoint devices must therefore
> reside on bus 1 to be discovered.
> See the ASPEED PCIe driver implementation here:
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/drivers/pci/controller/pcie-aspeed.c#L512
> 
> By default, the ASPEED SDK enables only PCIe RC2, so initial testing covers RC2 only.
> 
> To attach e1000e devices and test all three RCs, I created a new test image
> with driver modifications. This is a temporary solution. A better approach is
> still needed to allow placing e1000e directly under bus 1.
> 
> Test release: https://github.com/jamin-aspeed/openbmc/releases/tag/qemu-test-0907
> Image download: https://github.com/jamin-aspeed/openbmc/releases/download/qemu-test-0907/ast2700-default-pcie-qemu.tar.xz
> This image includes the following changes:
> Kernel patch (AST2700 RC mode + PCIe driver updates):
> https://github.com/jamin-aspeed/openbmc/releases/download/qemu-test-0907/0001-PCI-aspeed-Enable-AST2700-RC-mode-support-and-adjust.patch
> 
> OpenBMC patch (installs e1000e modules into rootfs for testing):
> https://github.com/jamin-aspeed/openbmc/releases/download/qemu-test-0907/0001-packagegroup-aspeed-Add-Intel-e1000-e1000e-kernel-mo.patch
> 
> QEMU Test Command
> 
> Each PCIe RC bus adds a pcie-root-port with an e1000e NIC behind it:
> 
>   -device pcie-root-port,id=root_port0,multifunction=on,slot=0,addr=1,bus=pcie.0 \
>   -device e1000e,netdev=net0,bus=root_port0 \
>   -netdev user,id=net0,hostfwd=:127.0.0.1:3222-:22,hostname=qemu0 \
>   -device pcie-root-port,id=root_port1,slot=1,addr=2,bus=pcie.1 \
>   -device e1000e,netdev=net1,bus=root_port1 \
>   -netdev user,id=net1,hostfwd=:127.0.0.1:4222-:22,hostname=qemu1 \
>   -device pcie-root-port,id=root_port2,slot=2,addr=3,bus=pcie.2 \
>   -device e1000e,netdev=net2,bus=root_port2 \
>   -netdev user,id=net2,hostfwd=:127.0.0.1:5222-:22,hostname=qemu2 \
> 
> Expected Results
> 
> With lspci, each RC should show the internal bridge, root port, and e1000e endpoint:
> 
> root@ast2700-default:~# lspci
> 0000:00:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
> 0000:00:01.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> 0000:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 0001:00:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
> 0001:00:02.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> 0001:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 0002:00:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
> 0002:00:03.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 
> Load the e1000e driver:
> Kernel logs confirm device initialization and link-up at 1 Gbps Full Duplex on eth2/eth3/eth4.
> root@ast2700-default:~# modprobe e1000e
> [   59.181623] e1000e: Intel(R) PRO/1000 Network Driver
> [   59.181926] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   59.183508] e1000e 0000:01:00.0: enabling device (0000 -> 0002)
> [   59.188808] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [   59.252590] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): registered PHC clock
> [   59.330877] e1000e 0000:01:00.0 eth2: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:56
> [   59.331990] e1000e 0000:01:00.0 eth2: Intel(R) PRO/1000 Network Connection
> [   59.333211] e1000e 0000:01:00.0 eth2: MAC: 3, PHY: 8, PBA No: 000000-000
> [   59.334881] e1000e 0001:01:00.0: enabling device (0000 -> 0002)
> [   59.341616] e1000e 0001:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [   59.394712] e1000e 0001:01:00.0 0001:01:00.0 (uninitialized): registered PHC clock
> [   59.456674] e1000e 0001:01:00.0 eth3: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:57
> [   59.457487] e1000e 0001:01:00.0 eth3: Intel(R) PRO/1000 Network Connection
> [   59.458033] e1000e 0001:01:00.0 eth3: MAC: 3, PHY: 8, PBA No: 000000-000
> [   59.460037] e1000e 0002:01:00.0: enabling device (0000 -> 0002)
> [   59.466403] e1000e 0002:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [   59.533361] e1000e 0002:01:00.0 0002:01:00.0 (uninitialized): registered PHC clock
> [   59.654491] 8021q: adding VLAN 0 to HW filter on device eth2
> [   59.662100] e1000e 0002:01:00.0 eth4: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:58
> [   59.662966] e1000e 0002:01:00.0 eth4: Intel(R) PRO/1000 Network Connection
> [   59.663527] e1000e 0002:01:00.0 eth4: MAC: 3, PHY: 8, PBA No: 000000-000
> root@ast2700-default:~# [   59.814984] 8021q: adding VLAN 0 to HW filter on device eth3
> [   59.938859] 8021q: adding VLAN 0 to HW filter on device eth4
> [   59.954690] e1000e 0000:01:00.0 eth2: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [   60.116790] e1000e 0001:01:00.0 eth3: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [   60.237622] e1000e 0002:01:00.0 eth4: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> After loading, users should see:
> eth2: PCIe0
> eth3: PCIe1
> eth4: PCIe2
> 
> Example ifconfig output shows all interfaces (eth0-eth4) active, with eth2-eth4 bound to the e1000e NICs.
> With this setup, all three PCIe RCs on AST2700 can be tested using e1000e endpoints in QEMU.
> 
> root@ast2700-default:~# ifconfig
> eth2      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
>            inet addr:169.254.120.135  Bcast:169.254.255.255  Mask:255.255.0.0
>            inet6 addr: fe80::5054:ff:fe12:3456/64 Scope:Link
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:19 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:51 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:5227 (5.1 KiB)  TX bytes:8551 (8.3 KiB)
>            Interrupt:42 Memory:60040000-60060000
> 
> eth3      Link encap:Ethernet  HWaddr 52:54:00:12:34:57
>            inet addr:169.254.237.52  Bcast:169.254.255.255  Mask:255.255.0.0
>            inet6 addr: fe80::5054:ff:fe12:3457/64 Scope:Link
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:16 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:47 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:4786 (4.6 KiB)  TX bytes:8175 (7.9 KiB)
>            Interrupt:45 Memory:80040000-80060000
> 
> eth4      Link encap:Ethernet  HWaddr 52:54:00:12:34:58
>            inet addr:169.254.84.173  Bcast:169.254.255.255  Mask:255.255.0.0
>            inet6 addr: fe80::5054:ff:fe12:3458/64 Scope:Link
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:16 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:47 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:4786 (4.6 KiB)  TX bytes:8191 (7.9 KiB)
>            Interrupt:48 Memory:a0040000-a0060000
> 
> Jamin Lin (11):
>    hw/pci/pci_ids Add PCI vendor ID for ASPEED
>    hw/pci-host/aspeed: Add AST2600 PCIe PHY model
>    hw/pci-host/aspeed: Add AST2600 PCIe config and host bridge
>    hw/pci-host/aspeed: Add MSI support and per-RC IOMMU address space
>    hw/arm/aspeed: Wire up PCIe devices in SoC model
>    hw/arm/aspeed_ast2600: Add PCIe RC support (RC_H only)
>    tests/functional/test_arm_aspeed_ast2600: Add PCIe test via root port
>      and e1000e
>    hw/pci-host/aspeed: Add AST2700 PCIe PHY
>    hw/pci-host/aspeed: Add AST2700 PCIe config with dedicated H2X blocks
>    hw/arm/aspeed_ast27x0: Introduce 3 PCIe RCs for AST2700
>    tests/functional: Add PCIe presence test for AST2700
> 
>   include/hw/arm/aspeed_soc.h                   |  14 +
>   include/hw/pci-host/aspeed_pcie.h             | 125 +++
>   include/hw/pci/pci_ids.h                      |   2 +
>   hw/arm/aspeed_ast2600.c                       |  69 +-
>   hw/arm/aspeed_ast27x0.c                       |  61 ++
>   hw/pci-host/aspeed_pcie.c                     | 955 ++++++++++++++++++
>   hw/arm/Kconfig                                |   3 +
>   hw/pci-host/Kconfig                           |   4 +
>   hw/pci-host/meson.build                       |   1 +
>   hw/pci-host/trace-events                      |  11 +
>   .../functional/test_aarch64_aspeed_ast2700.py |   7 +
>   .../test_aarch64_aspeed_ast2700fc.py          |   6 +
>   tests/functional/test_arm_aspeed_ast2600.py   |  14 +
>   13 files changed, 1269 insertions(+), 3 deletions(-)
>   create mode 100644 include/hw/pci-host/aspeed_pcie.h
>   create mode 100644 hw/pci-host/aspeed_pcie.c
> 


