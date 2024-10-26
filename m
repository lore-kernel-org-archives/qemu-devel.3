Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4EED10BF0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 10:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4dd3-000239-F7; Sat, 26 Oct 2024 06:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=RVB+=RW=kaod.org=clg@ozlabs.org>)
 id 1t4dd0-00022k-AX; Sat, 26 Oct 2024 06:02:38 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=RVB+=RW=kaod.org=clg@ozlabs.org>)
 id 1t4dcv-0002BQ-NS; Sat, 26 Oct 2024 06:02:37 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XbFYy1MKhz4x8C;
 Sat, 26 Oct 2024 21:02:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XbFYt1QbKz4wbr;
 Sat, 26 Oct 2024 21:02:09 +1100 (AEDT)
Message-ID: <1bce4c22-9281-44c5-8acb-860881dc271c@kaod.org>
Date: Sat, 26 Oct 2024 12:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, qemu-block <qemu-block@nongnu.org>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
 <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
 <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
 <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
 <600baa43c3dd3547338934717cfb57c5e12b0d23.camel@pengutronix.de>
 <84c32f2d-7d9a-4e5a-8b67-1f954dd493f6@roeck-us.net>
 <b67f302a11a679c3fdb02318eb9ef0be559d14ce.camel@pengutronix.de>
 <53cbb597-e7f2-4742-bf85-928c704ddbcf@linaro.org>
 <443f1b0c-8184-4bf4-9f68-c23d7de3bc36@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <443f1b0c-8184-4bf4-9f68-c23d7de3bc36@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=RVB+=RW=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/26/24 07:54, Guenter Roeck wrote:
> On 10/25/24 21:47, Philippe Mathieu-Daudé wrote:
>> On 25/10/24 12:25, Jan Lübbe wrote:
>>> On Fri, 2024-10-25 at 06:59 -0700, Guenter Roeck wrote:
>>>> On 10/25/24 02:57, Jan Lübbe wrote:
>>>>> On Fri, 2024-10-25 at 08:55 +0200, Cédric Le Goater wrote:
>>>>>> On 10/24/24 19:59, Philippe Mathieu-Daudé wrote:
>>>>>>> Cc'ing Jan.
>>>>>>>
>>>>>>> On 22/10/24 12:04, Guenter Roeck wrote:
>>>>>>>
>>>>>>>> I have no idea how this is supposed to work, and I don't think it works
>>>>>>>> as implemented. I'll revert commit e32ac563b83 in my local copy of qemu.
>>>>>>>> Jan, can you have a look at this bug report please? Otherwise I'll
>>>>>>>> have a look during soft freeze.
>>>>>
>>>>> Guenter, just to make sure: In your case [1], you had "boot-emmc" (see
>>>>> aspeed_machine_ast2600_class_emmc_init) enabled, right? Otherwise the
>>>>
>>>> I tried both enabled and disabled.
>>>>
>>>>> boot partition size would be 0, meaning that the eMMC has no boot
>>>>> partitions.
>>>>
>>>> That is what I would have expected, but it does not reflect reality.
>>>>
>>>>> In that configuration, your backing file needs to have space for the
>>>>> boot partitions at the start (2*1MiB) and the rootfs starts at the 2
>>>>> MiB offset.
>>>>>
>>>>
>>>> boot-emmc doesn't make a difference, because
>>>>
>>>>           if (emmc) {
>>>>               qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
>>>>               qdev_prop_set_uint8(card, "boot-config",
>>>>                                   boot_emmc ? 0x1 << 3 : 0x0);
>>>>           }
>>>>
>>>> in hw/arm/aspeed.c sets the boot partition size independently of the
>>>> boot-emmc flag.
>>>
>>> Ah, yes. :/
>>>
>>> So you can have SD, eMMC with boot from boot partition *disabled* or
>>> eMMC with boot from boot partition *enabled*.
>>>
>>>> I suspect that the expectation is that I always provide
>>>> an emmc image with a 2 MB gap at the beginning, but in my opinion that is
>>>> really hyper-clumsy, and I simply won't do it, sorry.
>>>
>>> I was surprised that the boot partitions' contents are stored in the
>>> same backing file as the main area (instead of being separate files).
>>> But I've not researched why it was designed this way.
>>
>> Yeah I'd have preferred separate files too, but when it seemed
>> to be simpler for the single user case:
>> https://lore.kernel.org/qemu-devel/d48b6357-c839-4971-aa28-bdbd5b1bab53@kaod.org/
>>
> 
> I don't mind a single file. What bothers me is that the partitioning is made
> mandatory for ast2600 even if not used.

Our only use case, in 2019, was to boot QEMU ast2600 machines from an
eMMC device using an OpenBMC FW image like the ones we find on IBM
Power10 Rainier systems. I agree we only focused on this scenario.
Most of the support should be there for other use cases, and it's now
a question of finding the right tunables for the user.

I did a quick experiment using 2 patches,

one on hw/sd/sd.c to fix c8cb19876d3e ("hw/sd/sdcard: Support boot
area in emmc image")

     @@ -826,7 +826,9 @@ static void sd_reset(DeviceState *dev)
              sect = 0;
          }
          size = sect << HWBLOCK_SHIFT;
     -    size -= sd_bootpart_offset(sd);
     +    if (sd_is_emmc(sd)) {
     +        size -= sd->boot_part_size * 2;
     +    }
      
          sect = sd_addr_to_wpnum(size) + 1;

and another on hw/arm/aspeed.c to remove the setting of the eMMC
device properties when it is not bootable :
   
     @@ -338,7 +338,7 @@ static void sdhci_attach_drive(SDHCIStat
                  return;
              }
              card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
     -        if (emmc) {
     +        if (emmc && boot_emmc) {
                  qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
                  qdev_prop_set_uint8(card, "boot-config",
                                      boot_emmc ? 0x1 << 3 : 0x0);
   
(I am not saying this is correct)

I then generated an eMMC image from a raw disk image, and without the
extra 2M for the boot areas (for U-Boot binaries) :

     $ fdisk -l   obmc-phosphor-image-rainier.wic
     Disk obmc-phosphor-image-rainier.wic: 14.13 GiB, 15167689728 bytes, 29624394 sectors
     Units: sectors of 1 * 512 = 512 bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/O size (minimum/optimal): 512 bytes / 512 bytes
     Disklabel type: gpt
     Disk identifier: DB9A8B4B-4BB8-4D5E-83A3-67A3D4F64614
     
     Device                              Start      End  Sectors Size Type
     obmc-phosphor-image-rainier.wic1       40     2087     2048   1M Microsoft basic data
     obmc-phosphor-image-rainier.wic2     2088   133159   131072  64M Linux filesystem
     obmc-phosphor-image-rainier.wic3   133160   264231   131072  64M Linux filesystem
     obmc-phosphor-image-rainier.wic4   264232  2361383  2097152   1G Linux filesystem
     obmc-phosphor-image-rainier.wic5  2361384  4458535  2097152   1G Linux filesystem
     obmc-phosphor-image-rainier.wic6  4458536 19138599 14680064   7G Linux filesystem
     obmc-phosphor-image-rainier.wic7 19138600 29624359 10485760   5G Linux filesystem

and used that to boot an ast2600-evb from flash with an emmc device.
   
     /path/to/qemu-system-arm -M ast2600-evb -net nic,netdev=net0 -netdev id=net0,... \
       -drive file=./flash-ast2600-evb,format=raw,if=mtd \
       -drive file=./ast2600-evb.pnor,format=raw,if=mtd \
       -drive file=mmc-ast2600-evb.qcow2,format=qcow2,if=sd,id=sd2,index=2 \
     -nographic -snapshot -serial mon:stdio

See the run below.

Thanks,

C.



U-Boot 2019.04-00234-g2ac7fde7b0-dirty (Oct 23 2024 - 17:43:49 +0200)

SOC: AST2600-A3
eSPI Mode: SIO:Enable : SuperIO-2e
Eth: MAC0: RGMII, MAC1: RGMII, MAC2: RGMII, MAC3: RGMII
Model: AST2600A1 EVB
DRAM:  1008 MiB (capacity:1024 MiB, VGA:64 MiB, ECC:off)
RC Bridge phy@1e6ed200 : Link up
MMC:

sdhci_slot0@100: 1, sdhci_slot1@200: 2, emmc_slot0@100: 0
Loading Environment from SPI Flash... SF: Detected mx66u51235f with page size 256 Bytes, erase size 4 KiB, total 64 MiB
OK
In:    serial@1e784000
Out:   serial@1e784000
Err:   serial@1e784000
Model: AST2600A1 EVB
Net:   eth0: ftgmac@1e660000
Warning: ftgmac@1e680000 (eth1) using random MAC address - 0e:95:58:4b:71:2b
, eth1: ftgmac@1e680000
Warning: ftgmac@1e670000 (eth2) using random MAC address - 5e:60:24:2d:46:b6
, eth2: ftgmac@1e670000
Warning: ftgmac@1e690000 (eth3) using random MAC address - 4e:32:35:b8:f2:62
, eth3: ftgmac@1e690000
Hit any key to stop autoboot:  0
ast# printenv
baudrate=115200
bootargs=console=ttyS4,115200n8 root=/dev/ram rw dyndbg="file drivers/spi/* +p" loglevel=10
bootcmd=bootm 20100000
bootdelay=2
ethaddr=c0:ff:ee:00:00:04
fdtcontroladdr=bcf6c258
stderr=serial@1e784000
stdin=serial@1e784000
stdout=serial@1e784000
verify=yes

Environment size: 273/65532 bytes
ast# setenv bootargs "console=ttyS4,115200n8 root=/dev/ram rw"
ast# boot
## Loading kernel from FIT Image at 20100000 ...
    Using 'conf-1' configuration
    Trying 'kernel-1' kernel subimage
      Description:  Linux kernel
      Type:         Kernel Image
      Compression:  uncompressed
      Data Start:   0x201000f0
      Data Size:    4174872 Bytes = 4 MiB
      Architecture: ARM
      OS:           Linux
      Load Address: 0x80001000
      Entry Point:  0x80001000
      Hash algo:    sha256
      Hash value:   347b1c70a8c23e643b32a0806697992106cc75fc8769ff4f53512c18506f55ad
    Verifying Hash Integrity ... sha256+ OK
## Loading ramdisk from FIT Image at 20100000 ...
    Using 'conf-1' configuration
    Trying 'ramdisk-1' ramdisk subimage
      Description:  obmc-phosphor-initramfs
      Type:         RAMDisk Image
      Compression:  uncompressed
      Data Start:   0x205068a4
      Data Size:    2063220 Bytes = 2 MiB
      Architecture: ARM
      OS:           Linux
      Load Address: unavailable
      Entry Point:  unavailable
      Hash algo:    sha256
      Hash value:   41b330cff12982e4f39907cdb8b35c6849a1f5d1e96e7e5427dab00a5720fe6b
    Verifying Hash Integrity ... sha256+ OK
## Loading fdt from FIT Image at 20100000 ...
    Using 'conf-1' configuration
    Trying 'fdt-1' fdt subimage
      Description:  Flattened Device Tree blob
      Type:         Flat Device Tree
      Compression:  uncompressed
      Data Start:   0x204fb608
      Data Size:    45519 Bytes = 44.5 KiB
      Architecture: ARM
      Hash algo:    sha256
      Hash value:   82eabb92e1ca0c2cd7540088990ecba1c82b1960518c2963b441ce56954c2a04
    Verifying Hash Integrity ... sha256+ OK
    Booting using the fdt blob at 0x204fb608
    Loading Kernel Image ... OK
    Loading Ramdisk to 8fe08000, end 8ffffb74 ... OK
    Loading Device Tree to 8fdf9000, end 8fe071ce ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0xf00
[    0.000000] Linux version 6.6.57-00318-g7b7fd0ac7dc1-dirty (legoater@alder) (arm-none-eabi-gcc (Fedora 12.4.0-1.el9) 12.4.0, GNU ld (Fedora 2.43-1.el9) 2.43) #800 SMP Wed Oct 23 11:43:23 CEST 2024
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: AST2600 EVB
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Reserved memory: created CMA memory pool at 0xbb000000, size 64 MiB
[    0.000000] OF: reserved mem: initialized node video, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0xbb000000..0xbeffffff (65536 KiB) map reusable video
[    0.000000] Reserved memory: created CMA memory pool at 0xba000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node framebuffer, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0xba000000..0xbaffffff (16384 KiB) map reusable framebuffer
[    0.000000] Reserved memory: created DMA memory pool at 0x9e770000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node pci_msi_memory, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x9e770000..0x9e7700ff (0 KiB) nomap non-reusable pci_msi_memory
[    0.000000] cma: Reserved 16 MiB at 0xb9000000 on node -1
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000080000000-0x00000000beffffff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009e76ffff]
[    0.000000]   node   0: [mem 0x000000009e771000-0x00000000beffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000beffffff]
[    0.000000] On node 0, zone Normal: 1 pages in unavailable ranges
[    0.000000] percpu: Embedded 13 pages/cpu s21204 r8192 d23852 u53248
[    0.000000] Kernel command line: console=ttyS4,115200n8 root=/dev/ram rw
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 256031
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] stackdepot: allocating hash table via alloc_large_system_hash
[    0.000000] stackdepot hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] Memory: 906472K/1032188K available (9216K kernel code, 555K rwdata, 2284K rodata, 1024K init, 1889K bss, 27412K reserved, 98304K cma-reserved, 0K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 1200.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1fffffffffffffff max_cycles: 0x114c1bbbeec, max_idle_ns: 440795229572 ns
[    0.000122] sched_clock: 61 bits at 1200MHz, resolution 0ns, wraps every 2199023255551ns
[    0.000269] Switching to timer-based delay loop, resolution 0ns
[    0.004541] Calibrating delay loop (skipped), value calculated using timer frequency.. 2400.00 BogoMIPS (lpj=12000000)
[    0.004655] CPU: Testing write buffer coherency: ok
[    0.005791] pid_max: default: 32768 minimum: 301
[    0.015945] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.016005] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.048544] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.049148] Setting up static identity map for 0x80100000 - 0x80100078
[    0.050194] rcu: Hierarchical SRCU implementation.
[    0.050223] rcu: 	Max phase no-delay instances is 1000.
[    0.055498] ASPEED AST2600 rev A3 (05030303)
[    0.056887] smp: Bringing up secondary CPUs ...
[    0.063247] smp: Brought up 1 node, 2 CPUs
[    0.063318] SMP: Total of 2 processors activated (4800.00 BogoMIPS).
[    0.063361] CPU: All CPU(s) started in SVC mode.
[    0.076322] devtmpfs: initialized
[    0.121627] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
[    0.139892] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.140492] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.146864] pinctrl core: initialized pinctrl subsystem
[    0.158505] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.170489] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.177969] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.178056] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.253146] AST2600 secure boot disabled
[    0.254852] usbcore: registered new interface driver usbfs
[    0.255167] usbcore: registered new interface driver hub
[    0.255369] usbcore: registered new device driver usb
[    0.256011] mc: Linux media interface: v0.10
[    0.256227] videodev: Linux video capture interface: v2.00
[    0.256475] EDAC MC: Ver: 3.0.0
[    0.267571] mctp: management component transport protocol core
[    0.267602] NET: Registered PF_MCTP protocol family
[    0.272183] vgaarb: loaded
[    0.278743] clocksource: Switched to clocksource arch_sys_counter
[    0.295844] NET: Registered PF_INET protocol family
[    0.297068] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.301957] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.302110] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.302173] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.302333] TCP bind hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.302502] TCP: Hash tables configured (established 8192 bind 8192)
[    0.303413] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.303578] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.304874] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.305268] PCI: CLS 0 bytes, default 64
[    0.312589] Unpacking initramfs...
[    0.318913] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    0.329112] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.331161] jffs2: version 2.2. (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    0.333508] NET: Registered PF_ALG protocol family
[    0.357212] aspeed-pciecfg 1e770000.pciecfg: can't get pcie reset: -517
[    0.360696] aspeed-pcie 1e7700c0.pcie: host bridge /ahb/apb@1e6e0000/pcie@1e7700C0 ranges:
[    0.361398] aspeed-pcie 1e7700c0.pcie:       IO 0x0000018000..0x000001ffff -> 0x0000018000
[    0.361841] aspeed-pcie 1e7700c0.pcie:      MEM 0x0070000000..0x007fffffff -> 0x0070000000
[    0.365013] aspeed-pcie 1e7700c0.pcie: Parsing DT failed
[    0.377054] Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
[    0.390043] printk: console [ttyS4] disabled
[    0.415131] 1e784000.serial: ttyS4 at MMIO 0x1e784000 (irq = 33, base_baud = 1500000) is a 16550A
[    0.417346] printk: console [ttyS4] enabled
[    0.445888] timeriomem_rng 1e6e2524.hwrng: 32bits from 0x(ptrval) @ 1us
[    0.464386] random: crng init done
[    0.466579] loop: module loaded
[    0.531428] spi-nor spi0.0: mx25u51245g (65536 Kbytes)
[    0.563190] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]
[    1.052071] Freeing initrd memory: 2016K
[    1.127789] 5 fixed-partitions partitions found on MTD device bmc
[    1.128074] Creating 5 MTD partitions on "bmc":
[    1.128530] 0x000000000000-0x0000000e0000 : "u-boot"
[    1.132732] 0x0000000e0000-0x000000100000 : "u-boot-env"
[    1.135435] 0x000000100000-0x000000a00000 : "kernel"
[    1.137924] 0x000000a00000-0x000002a00000 : "rofs"
[    1.140689] 0x000002a00000-0x000004000000 : "rwfs"
[    1.143835] spi-nor spi0.1: unrecognized JEDEC id bytes: 00 00 00 00 00 00
[    1.150726] spi-nor spi1.0: mx25u51245g (65536 Kbytes)
[    1.209269] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
[    1.227015] spi-nor spi2.0: unrecognized JEDEC id bytes: 00 00 00 00 00 00
[    1.277325] ftgmac100 1e660000.ethernet: Read MAC address c0:ff:ee:00:00:04 from chip
[    1.279250] RTL8211E Gigabit Ethernet 1e650000.mdio-1:00: attached PHY driver (mii_bus:phy_addr=1e650000.mdio-1:00, irq=POLL)
[    1.281528] ftgmac100 1e660000.ethernet eth0: irq 34, mapped at 79751e15
[    1.282860] ftgmac100 1e680000.ethernet: Read MAC address 0e:95:58:4b:71:2b from chip
[    1.283363] RTL8211E Gigabit Ethernet 1e650008.mdio-1:00: attached PHY driver (mii_bus:phy_addr=1e650008.mdio-1:00, irq=POLL)
[    1.284870] ftgmac100 1e680000.ethernet eth1: irq 35, mapped at 3dc7362d
[    1.285697] ftgmac100 1e670000.ethernet: Read MAC address 5e:60:24:2d:46:b6 from chip
[    1.286179] RTL8211E Gigabit Ethernet 1e650010.mdio-1:00: attached PHY driver (mii_bus:phy_addr=1e650010.mdio-1:00, irq=POLL)
[    1.287413] ftgmac100 1e670000.ethernet eth2: irq 36, mapped at da2d312c
[    1.288442] ftgmac100 1e690000.ethernet: Read MAC address 4e:32:35:b8:f2:62 from chip
[    1.288946] RTL8211E Gigabit Ethernet 1e650018.mdio-1:00: attached PHY driver (mii_bus:phy_addr=1e650018.mdio-1:00, irq=POLL)
[    1.290191] ftgmac100 1e690000.ethernet eth3: irq 37, mapped at 045a874a
[    1.290646] e1000e: Intel(R) PRO/1000 Network Driver
[    1.290767] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.291109] usbcore: registered new interface driver cdc_ether
[    1.291329] usbcore: registered new interface driver cdc_eem
[    1.291551] usbcore: registered new interface driver rndis_host
[    1.291772] usbcore: registered new interface driver cdc_subset
[    1.291998] usbcore: registered new interface driver r8153_ecm
[    1.293432] platform-uhci 1e6b0000.usb: Detected 2 ports from device-tree
[    1.293643] platform-uhci 1e6b0000.usb: Enabled Aspeed implementation workarounds
[    1.304773] platform-uhci 1e6b0000.usb: Generic UHCI Host Controller
[    1.305371] platform-uhci 1e6b0000.usb: new USB bus registered, assigned bus number 1
[    1.306869] platform-uhci 1e6b0000.usb: irq 38, io mem 0x1e6b0000
[    1.319480] ehci-platform 1e6a3000.usb: EHCI Host Controller
[    1.319796] ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 2
[    1.325447] ehci-platform 1e6a3000.usb: irq 39, io mem 0x1e6a3000
[    1.327363] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.06
[    1.327680] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.327944] usb usb1: Product: Generic UHCI Host Controller
[    1.328284] usb usb1: Manufacturer: Linux 6.6.57-00318-g7b7fd0ac7dc1-dirty uhci_hcd
[    1.328585] usb usb1: SerialNumber: 1e6b0000.usb
[    1.333949] hub 1-0:1.0: USB hub found
[    1.334617] hub 1-0:1.0: 2 ports detected
[    1.352324] ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
[    1.353520] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
[    1.353739] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.353919] usb usb2: Product: EHCI Host Controller
[    1.354048] usb usb2: Manufacturer: Linux 6.6.57-00318-g7b7fd0ac7dc1-dirty ehci_hcd
[    1.354228] usb usb2: SerialNumber: 1e6a3000.usb
[    1.355837] hub 2-0:1.0: USB hub found
[    1.356145] hub 2-0:1.0: 6 ports detected
[    1.361440] aspeed_vhub 1e6a0000.usb-vhub: Initialized virtual hub in USB2 mode
[    1.364590] g_ether gadget.0: HOST MAC 92:2c:b1:d8:ef:d6
[    1.364864] g_ether gadget.0: MAC 26:cd:b2:66:3d:c6
[    1.370159] g_ether gadget.0: Ethernet Gadget, version: Memorial Day 2008
[    1.370573] g_ether gadget.0: g_ether ready
[    1.371708] gadgetfs: USB Gadget filesystem, version 24 Aug 2004
[    1.372347] file system registered
[    1.373323] Mass Storage Function, version: 2009/09/11
[    1.373725] LUN: removable file: (no medium)
[    1.374475] no file given for LUN0
[    1.375010] udc 1e6a0000.usb-vhub:p2: failed to start g_mass_storage: -22
[    1.375216] g_mass_storage: probe of gadget.1 failed with error -22
[    1.375497] Mass Storage Function, version: 2009/09/11
[    1.375633] LUN: removable file: (no medium)
[    1.375774] no file given for LUN0
[    1.375893] udc 1e6a0000.usb-vhub:p3: failed to start g_mass_storage: -22
[    1.376055] g_mass_storage: probe of gadget.2 failed with error -22
[    1.376307] Mass Storage Function, version: 2009/09/11
[    1.376438] LUN: removable file: (no medium)
[    1.376572] no file given for LUN0
[    1.376684] udc 1e6a0000.usb-vhub:p4: failed to start g_mass_storage: -22
[    1.376846] g_mass_storage: probe of gadget.3 failed with error -22
[    1.377073] Mass Storage Function, version: 2009/09/11
[    1.377209] LUN: removable file: (no medium)
[    1.377346] no file given for LUN0
[    1.377459] udc 1e6a0000.usb-vhub:p5: failed to start g_mass_storage: -22
[    1.377625] g_mass_storage: probe of gadget.4 failed with error -22
[    1.377861] Mass Storage Function, version: 2009/09/11
[    1.377996] LUN: removable file: (no medium)
[    1.378387] no file given for LUN0
[    1.378545] udc 1e6a0000.usb-vhub:p6: failed to start g_mass_storage: -22
[    1.378712] g_mass_storage: probe of gadget.5 failed with error -22
[    1.378999] Mass Storage Function, version: 2009/09/11
[    1.379129] LUN: removable file: (no medium)
[    1.379264] no file given for LUN0
[    1.379373] udc 1e6a0000.usb-vhub:p7: failed to start g_mass_storage: -22
[    1.379532] g_mass_storage: probe of gadget.6 failed with error -22
[    1.379780] UDC core: g_mass_storage: couldn't find an available UDC
[    1.382150] aspeed-rtc 1e781000.rtc: registered as rtc0
[    1.382371] aspeed-rtc 1e781000.rtc: hctosys: unable to read the hardware clock
[    1.383125] i2c_dev: i2c /dev entries driver
[    1.388271] aspeed-i2c-bus 1e78a080.i2c: i2c bus 0 registered, irq 41
[    1.390585] aspeed-i2c-bus 1e78a100.i2c: i2c bus 1 registered, irq 42
[    1.392585] aspeed-i2c-bus 1e78a180.i2c: i2c bus 2 registered, irq 43
[    1.394340] aspeed-i2c-bus 1e78a200.i2c: i2c bus 3 registered, irq 44
[    1.396073] aspeed-i2c-bus 1e78a280.i2c: i2c bus 4 registered, irq 45
[    1.397777] aspeed-i2c-bus 1e78a300.i2c: i2c bus 5 registered, irq 46
[    1.401396] aspeed-i2c-bus 1e78a380.i2c: i2c bus 6 registered, irq 47
[    1.409287] at24 7-0050: 1024 byte 24c08 EEPROM, writable, 16 bytes/write
[    1.409732] aspeed-i2c-bus 1e78a400.i2c: i2c bus 7 registered, irq 48
[    1.411983] aspeed-i2c-bus 1e78a480.i2c: i2c bus 8 registered, irq 49
[    1.416524] aspeed-i2c-bus 1e78a500.i2c: i2c bus 9 registered, irq 50
[    1.418837] aspeed-i2c-bus 1e78a680.i2c: i2c bus 12 registered, irq 51
[    1.420850] aspeed-i2c-bus 1e78a700.i2c: i2c bus 13 registered, irq 52
[    1.422600] aspeed-i2c-bus 1e78a780.i2c: i2c bus 14 registered, irq 53
[    1.424342] aspeed-i2c-bus 1e78a800.i2c: i2c bus 15 registered, irq 54
[    1.456554] aspeed-video 1e700000.video: irq 57
[    1.457116] aspeed-video 1e700000.video: assigned reserved memory node video
[    1.459470] aspeed-video 1e700000.video: alloc mem size(24576) at 0xbb000000 for jpeg header
[    1.463628] Driver for 1-wire Dallas network protocol.
[    1.465558] adt7475 7-002e: Error configuring attenuator bypass
[    1.467012] adt7475 7-002e: ADT7490 device, revision 2
[    1.467206] adt7475 7-002e: Optional features: in4 pwm2
[    1.467367] adt7475 7-002e: Bypassing attenuators on: in1 in3 in4
[    1.470797] lm75 8-004d: hwmon0: sensor 'lm75'
[    1.473632] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    1.475222] sdhci: Secure Digital Host Controller Interface driver
[    1.475383] sdhci: Copyright(c) Pierre Ossman
[    1.475546] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.477140] usbcore: registered new interface driver usbhid
[    1.477340] usbhid: USB HID core driver
[    1.487275] sdhci-aspeed 1e750100.sdhci: Configured for slot 0
[    1.493430] fsi-master-aspeed 1e79b000.fsi: hub version e0050101 (1 links)
[    1.493886] fsi-master-aspeed 1e79b000.fsi: mmode set to 70040110 (divisor 1)
[    1.523565] NET: Registered PF_INET6 protocol family
[    1.531816] Segment Routing with IPv6
[    1.532210] In-situ OAM (IOAM) with IPv6
[    1.533314] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.536435] NET: Registered PF_PACKET protocol family
[    1.536666] 8021q: 802.1Q VLAN Support v1.8
[    1.537326] Registering SWP/SWPB emulation handler
[    1.551759] mmc0: SDHCI controller on 1e750100.sdhci [1e750100.sdhci] using ADMA
[    1.580102] kmemleak: Kernel memory leak detector initialized (mem pool available: 15783)
[    1.580182] kmemleak: Automatic memory scanning thread started
[    1.593456] aspeed-pciecfg: probe of 1e770000.pciecfg failed with error 1
[    1.594472] aspeed-pcie 1e7700c0.pcie: host bridge /ahb/apb@1e6e0000/pcie@1e7700C0 ranges:
[    1.594823] aspeed-pcie 1e7700c0.pcie:       IO 0x0000018000..0x000001ffff -> 0x0000018000
[    1.595114] aspeed-pcie 1e7700c0.pcie:      MEM 0x0070000000..0x007fffffff -> 0x0070000000
[    2.096859] aspeed-pcie 1e7700c0.pcie: PCIE- Link up
[    2.099914] aspeed-pcie 1e7700c0.pcie: PCI host bridge to bus 0001:80
[    2.100337] pci_bus 0001:80: root bus resource [bus 80-ff]
[    2.100789] pci_bus 0001:80: root bus resource [io  0x0000-0x7fff] (bus address [0x18000-0x1ffff])
[    2.101071] pci_bus 0001:80: root bus resource [mem 0x70000000-0x7fffffff]
[    2.104803] PCI: bus128: Fast back to back transfers enabled
[    2.109460] printk: console [netcon0] enabled
[    2.109696] netconsole: network logging started
[    2.110876] clk: Disabling unused clocks
[    2.147407] Freeing unused kernel image (initmem) memory: 1024K
[    2.176818] Checked W+X mappings: passed, no W+X pages found
[    2.177212] Run /init as init process
[    2.181933] mmc0: new high speed MMC card at address 0001
[    2.185019] mmcblk0: mmc0:0001 QEMU!! 16.0 GiB
[    2.208621] GPT:Primary header thinks Alt. header is not at the end of the disk.
[    2.208884] GPT:29624393 != 33554431
[    2.209017] GPT:Alternate GPT header not at the end of the disk.
[    2.209192] GPT:29624393 != 33554431
[    2.209303] GPT: Use GNU Parted to correct GPT errors.
[    2.210018]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
Saving 256 bits of creditable seed for next boot
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Starting network: [    2.856576] ftgmac100 1e660000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
udhcpc: started, v1.36.1
udhcpc: broadcasting discover
udhcpc: broadcasting select for 192.168.199.4, server 192.168.199.1
udhcpc: lease of 192.168.199.4 obtained from 192.168.199.1, lease time 3600
deleting routers
adding dns 192.168.199.1
OK
Starting crond: OK
Starting dropbear sshd: OK

Aspeed AST2600 EVB
ast2600-evb login: [   12.652131] sdhci-aspeed 1e740100.sdhci: Configured for slot 0
[   12.655905] sdhci-aspeed 1e740200.sdhci: Configured for slot 1
[   12.735134] mmc1: SDHCI controller on 1e740100.sdhci [1e740100.sdhci] using ADMA
[   12.785076] mmc2: SDHCI controller on 1e740200.sdhci [1e740200.sdhci] using ADMA

Aspeed AST2600 EVB
ast2600-evb login: root
Password:
# fdisk -l /dev/mmcblk0
Found valid GPT with protective MBR; using GPT

Disk /dev/mmcblk0: 33554432 sectors,     0
Logical sector size: 512
Disk identifier (GUID): 00000000-0000-0000-0000-00004d9b9ef0
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 29624360

Number  Start (sector)    End (sector)  Size Name
      1              40            2087 1024K primary
      2            2088          133159 64.0M boot-a
      3          133160          264231 64.0M boot-b
      4          264232         2361383 1024M rofs-a
      5         2361384         4458535 1024M rofs-b
      6         4458536        19138599 7168M rwfs
      7        19138600        29624359 5120M hostfw
# for i in 2 3 4 5 6; do mount /dev/mmcblk0p
mmcblk0p1  mmcblk0p2  mmcblk0p3  mmcblk0p4  mmcblk0p5  mmcblk0p6  mmcblk0p7
# for i in 2 3 4 5 6 7; do mount /dev/mmcblk0p$i /mnt; ls -l /mnt/; umount /mnt
; done
[   96.295287] EXT4-fs (mmcblk0p2): mounted filesystem f85bf458-5b4f-4785-bc9a-8a343798855c r/w with ordered data mode. Quota mode: disabled.
total 7942
-rw-r--r--    1 1000     1001       8120290 Jun 18  2024 fitImage
drwx------    2 root     root         12288 Apr  5  2011 lost+found
[   96.348707] EXT4-fs (mmcblk0p2): unmounting filesystem f85bf458-5b4f-4785-bc9a-8a343798855c.
[   96.391201] EXT4-fs (mmcblk0p3): mounted filesystem 815b73b7-d5c4-46e4-ba06-46dae5312632 r/w with ordered data mode. Quota mode: disabled.
total 7942
-rw-r--r--    1 1000     1001       8120290 Jun 18  2024 fitImage
drwx------    2 root     root         12288 Apr  5  2011 lost+found
[   96.429335] EXT4-fs (mmcblk0p3): unmounting filesystem 815b73b7-d5c4-46e4-ba06-46dae5312632.
[   96.523967] EXT4-fs (mmcblk0p4): mounted filesystem 6f526507-e73b-4094-8f08-f310b5da5b3a r/w with ordered data mode. Quota mode: disabled.
total 68
lrwxrwxrwx    1 root     root             7 Mar  9  2018 bin -> usr/bin
drwxr-xr-x    2 root     root          4096 Mar  9  2018 boot
drwxr-xr-x    2 root     root          4096 Mar  9  2018 dev
drwxr-xr-x   35 root     root          4096 Mar  9  2018 etc
drwxr-xr-x    4 root     root          4096 Mar  9  2018 home
lrwxrwxrwx    1 root     root             7 Mar  9  2018 lib -> usr/lib
drwx------    2 root     root         16384 Apr  5  2011 lost+found
drwxr-xr-x    2 root     root          4096 Mar  9  2018 media
drwxr-xr-x    2 root     root          4096 Mar  9  2018 mnt
dr-xr-xr-x    2 root     root          4096 Mar  9  2018 proc
drwxr-xr-x    2 root     root          4096 Mar  9  2018 run
lrwxrwxrwx    1 root     root             8 Mar  9  2018 sbin -> usr/sbin
drwxr-xr-x    2 root     root          4096 Mar  9  2018 srv
dr-xr-xr-x    2 root     root          4096 Mar  9  2018 sys
drwxrwxrwt    2 root     root          4096 Mar  9  2018 tmp
drwxr-xr-x   11 root     root          4096 Mar  9  2018 usr
drwxr-xr-x   11 root     root          4096 Mar  9  2018 var
[   96.632275] EXT4-fs (mmcblk0p4): unmounting filesystem 6f526507-e73b-4094-8f08-f310b5da5b3a.
[   96.734976] EXT4-fs (mmcblk0p5): mounted filesystem b6a31322-040c-46db-8519-38fb5658ec3e r/w with ordered data mode. Quota mode: disabled.
total 68
lrwxrwxrwx    1 root     root             7 Mar  9  2018 bin -> usr/bin
drwxr-xr-x    2 root     root          4096 Mar  9  2018 boot
drwxr-xr-x    2 root     root          4096 Mar  9  2018 dev
drwxr-xr-x   35 root     root          4096 Mar  9  2018 etc
drwxr-xr-x    4 root     root          4096 Mar  9  2018 home
lrwxrwxrwx    1 root     root             7 Mar  9  2018 lib -> usr/lib
drwx------    2 root     root         16384 Apr  5  2011 lost+found
drwxr-xr-x    2 root     root          4096 Mar  9  2018 media
drwxr-xr-x    2 root     root          4096 Mar  9  2018 mnt
dr-xr-xr-x    2 root     root          4096 Mar  9  2018 proc
drwxr-xr-x    2 root     root          4096 Mar  9  2018 run
lrwxrwxrwx    1 root     root             8 Mar  9  2018 sbin -> usr/sbin
drwxr-xr-x    2 root     root          4096 Mar  9  2018 srv
dr-xr-xr-x    2 root     root          4096 Mar  9  2018 sys
drwxrwxrwt    2 root     root          4096 Mar  9  2018 tmp
drwxr-xr-x   11 root     root          4096 Mar  9  2018 usr
drwxr-xr-x   11 root     root          4096 Mar  9  2018 var
[   96.846820] EXT4-fs (mmcblk0p5): unmounting filesystem b6a31322-040c-46db-8519-38fb5658ec3e.
[   97.229572] EXT4-fs (mmcblk0p6): mounted filesystem 6dc9b0da-2b0f-4822-9eac-df4dd782ddfc r/w with ordered data mode. Quota mode: disabled.
total 16
drwx------    2 root     root         16384 Jun 18  2024 lost+found
[   97.269409] EXT4-fs (mmcblk0p6): unmounting filesystem 6dc9b0da-2b0f-4822-9eac-df4dd782ddfc.
[   97.551223] EXT4-fs (mmcblk0p7): mounted filesystem 1552b5da-c1d9-4835-84c5-f92c376744ec r/w with ordered data mode. Quota mode: disabled.
total 16
drwx------    2 root     root         16384 Apr  5  2011 lost+found
[   97.588958] EXT4-fs (mmcblk0p7): unmounting filesystem 1552b5da-c1d9-4835-84c5-f92c376744ec.




