Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8FFC54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooOn-0000Jq-5w; Tue, 28 Jul 2026 16:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wooOV-0000AL-Dm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:27:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wooOS-0006ZK-3P
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YBLDrSjz4kor2DZ/8DGQQ1BNQ3yfAGM69kG0pnVpoX0=; b=y57nwxhGjglonL8RIOnEBLvgEB
 uKzMHr6NawujMa7zbuZ7+qtGAY/u7If2sT6RaZf7BTr8cs41KqxE/9P9frZFdGcwiZUF5rUqvcxki
 A5gO8VMtPvCzdXfyUK9SW1zFKq/jysKHozgnv/Sm9gLvrGy2Y+Tg4Lg/qCZ9XAIeuohhjWVdmpyGK
 OaU7z/nNzlUKpGFlVLfX/YfJX3fseYM1fpA6SqCesyx5FoCuaSuu/5XYRRR4veptH/jVCQrpXQbxp
 wG5RqmuqFAenTkR0Jb3QZb6ZRIFMYbiU0ncfzLyPCCBoqYtCwhGQuqmBHQ6SPiD5w2M/Hj++vKJrB
 setUQYULjz68ZOxLKOl4FjJ2Okb3nz1no+D3x49v25Qs+bkmKUvtAjdC8xpeh/z1R5niixqXf79zA
 ifpEwFPV5GhmhS4IBVh6tgl6ISX5fy+wRe2fJCi3wbtRyHmF+EJzcliCDd4Us3Io65JbsayxDFaCW
 BRbBlxto34P+ewG+s7xhHs8mKP9XV8vRB3yPygaji6/oeTKP7lNxDLDsK6cdfeNt+MyTuh53CESu0
 nEaxkMFv/haXOiMup2nGijTITcU42pCvNcreQHbr0mMsRwCaUzaCWeMly7sJBIVuZEMObBjDp1wte
 t+CfMwlohYUWYJk5IYZJCRuHb5habf9W7pCD1PwAg=;
Received: from [2a02:8012:2f01:0:3af8:8e54:1be9:9c94]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wooOC-0057OX-Od; Tue, 28 Jul 2026 21:27:01 +0100
Message-ID: <c6bf0bc3-353b-4d61-a6bc-d84e10f7d811@ilande.co.uk>
Date: Tue, 28 Jul 2026 21:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nathan Chancellor <nathan@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
 <20260722011530.GA2116566@ax162>
 <f4be0cc9-68ae-4f83-a40b-9af84109c54f@ilande.co.uk>
 <4b6f6450-74ce-497f-b487-71fadf97dc3c@ilande.co.uk>
 <20260727231441.GB3783405@ax162>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20260727231441.GB3783405@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:3af8:8e54:1be9:9c94
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 0/1] qemu-openbios queue 20260707
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 28/07/2026 00:14, Nathan Chancellor wrote:

> On Sun, Jul 26, 2026 at 09:53:13PM +0100, Mark Cave-Ayland wrote:
>> I've tried to reproduce this, however I cannot get your vmlinux above to
>> work here with either the old or new OpenBIOS. Is there anything else about
>> your environment needed to reproduce this?
> 
> Are you giving it enough time to boot with the old OpenBIOS? I have
> tested it on two different machines running Arch Linux and Fedora (each
> running mainline or -next Linux) so it seems unlikely to be environment
> related? On both of those machines, it takes two minutes or more to
> finish booting and shutdown.

Ah I see the issue now: you're passing -nodefaults on the command line which tells 
QEMU not to plug any default cards into any bus, however the firmware is still trying 
to access the VGA card upon startup causing the failure. Possibly this may have only 
worked before by accident.

What you also need to do is use -nographic which leaves the machine as-is, but 
configures the NVRAM such that the console is redirected to the serial port. The 
following modified command line works for me, and avoids the large pause during boot:


$ qemu-system-ppc \
       -nodefaults \
       -no-reboot \
       -machine mac99 \
       -append console=ttyS0 \
       -kernel ./vmlinux \
       -initrd ./rootfs.cpio \
       -m 128m \
       -serial mon:stdio \
       -nographic

 >> =============================================================
 >> OpenBIOS 1.1 [Sep 24 2024 19:56]
 >> Configuration device id QEMU version 1 machine id 1
 >> CPUs: 1
 >> Memory: 128M
 >> UUID: 00000000-0000-0000-0000-000000000000
 >> CPU type PowerPC,G4
milliseconds isn't unique.
Welcome to OpenBIOS v1.1 built on Sep 24 2024 19:56
 >> [ppc] Kernel already loaded (0x01000000 + 0x00ed2410) (initrd 0x01fd3000 + 
0x004fb000)
 >> [ppc] Kernel command line: console=ttyS0
 >> switching to new context:
OF stdout device is: /pci@f2000000/mac-io@c/escc@13000/ch-a@13020
Preparing to boot Linux version 7.2.0-rc4+ (nathan@ax162) (powerpc-linux-gcc (GCC) 
16.1.0, GNU ld (GNU Binutils) 2.46) #1 PREEMPT Tue Jul 21 16:59:50 MST 2026
Detected machine type: 00000400
command line:
memory layout at init:
   memory_limit : 00000000 (16 MB aligned)
   alloc_bottom : 024ce000
   alloc_top    : 08000000
   alloc_top_hi : 08000000
   rmo_top      : 08000000
   ram_top      : 08000000
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x024cf000 -> 0x024ce0a4
Device tree struct  0x024d0000 -> 0x07de7ec0
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x01000000 ...
Hello World !
Total memory = 128MB; using 256kB for hash table
Activating Kernel Userspace Access Protection
Activating Kernel Userspace Execution Prevention
Linux version 7.2.0-rc4+ (nathan@ax162) (powerpc-linux-gcc (GCC) 16.1.0, GNU ld (GNU 
Binutils) 2.46) #1 PREEMPT Tue Jul 21 16:59:50 MST 2026
OF: reserved mem: Reserved memory: No reserved-memory node in the DT
Found initrd at 0xc1fd3000:0xc24ce000
ioremap() called early from pmac_feature_init+0xf0/0xb10. Use early_ioremap() instead
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x07
Mapped at 0xff3bf000
ioremap() called early from probe_one_macio+0x13c/0x26c. Use early_ioremap() instead
Found a Keylargo mac-io controller, rev: 0, mapped at 0x(ptrval)
PowerMac motherboard: PowerMac G4 AGP Graphics
ioremap() called early from udbg_scc_init+0x1a4/0x3cc. Use early_ioremap() instead
boot stdout isn't a display !
ioremap() called early from find_via_cuda+0xb8/0x400. Use early_ioremap() instead
Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
printk: legacy bootconsole [udbg0] enabled
-----------------------------------------------------
phys_mem_size     = 0x8000000
dcache_bsize      = 0x20
icache_bsize      = 0x20
cpu_features      = 0x000000000401a00a
   possible        = 0x00000000277de14a
   always          = 0x0000000000000000
cpu_user_features = 0x9c000001 0x00000000
mmu_features      = 0x00000201
   possible        = 0x0000000000010601
   always          = 0x0000000000000000
Hash_size         = 0x40000
Hash_mask         = 0xfff
-----------------------------------------------------
ioremap() called early from pmac_setup_arch+0x110/0x274. Use early_ioremap() instead
ioremap() called early from pmac_nvram_init+0x164/0x588. Use early_ioremap() instead
nvram: Checking bank 0...
Invalid signature
Invalid checksum
nvram: gen0=0, gen1=0
nvram: Active bank is: 0
nvram: OF partition at 0xffffffff
nvram: XP partition at 0xffffffff
nvram: NR partition at 0xffffffff
Zone ranges:
   DMA      [mem 0x0000000000000000-0x0000000007ffffff]
   Normal   empty
   HighMem  empty
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
Kernel command line: console=ttyS0
printk: log buffer data + meta data: 16384 + 51200 = 67584 bytes
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 32768
mem auto-init: stack:all(zero), heap alloc:off, heap free:off
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 1 CPUs
mpic: ISU size: 64, shift: 6, mask: 3f
mpic: Initializing for 64 sources
GMT Delta read from XPRAM: 0 minutes, DST: on
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 
7645041785100000 ns
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x5c40939b5, max_idle_ns: 
440795202646 ns
clocksource: timebase mult[28000000] shift[24] registered
Console: colour dummy device 80x25
printk: legacy console [ttyS0] enabled
printk: legacy console [ttyS0] enabled
printk: legacy bootconsole [udbg0] disabled
printk: legacy bootconsole [udbg0] disabled
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
VFS: Finished mounting rootfs on nullfs
Memory: 108176K/131072K available (10508K kernel code, 1004K rwdata, 2180K rodata, 
1232K init, 178K bss, 21680K reserved, 0K cma-reserved, 0K highmem)
Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
PCI host bridge /pci@f2000000 (primary) ranges:
   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000
posixtimers hash table entries: 512 (order: 0, 2048 bytes, linear)
futex hash table entries: 256 (3072 bytes on 1 NUMA nodes, total 3 KiB, linear).
NET: Registered PF_NETLINK/PF_ROUTE protocol family

PCI: Probing PCI hardware
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff]
pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
pci 0000:00:0b.0: [106b:001f] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:0c.0: [106b:0022] type 00 class 0xff0000 conventional PCI endpoint
pci 0000:00:0c.0: BAR 0 [mem 0x80000000-0x8007ffff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
pci_bus 0000:00: resource 4 [io  0x0000-0x7fffff]
pci_bus 0000:00: resource 5 [mem 0x80000000-0x8fffffff]
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
vgaarb: loaded
clocksource: Switched to clocksource timebase
NET: Registered PF_INET protocol family
IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 4096 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
TCP bind hash table entries: 1024 (order: 1, 8192 bytes, linear)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp-with-tls transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 32
Initialise system trusted keyrings
Trying to unpack rootfs image as initramfs...
workingset: timestamp_bits=30 (anon: 25) max_order=15 bucket_order=0 (anon: 0)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler mq-deadline registered
io scheduler kyber registered
Freeing initrd memory: 5100K
Non-volatile memory driver v1.3
brd: module loaded
loop: module loaded
MacIO PCI driver attached to Keylargo chipset
0.00013020:ch-a: ttyS0 at MMIO 0x80013020 (irq = 37, base_baud = 230400) is a Z85c30 
ESCC - Serial port
0.00013000:ch-b: ttyS1 at MMIO 0x80013000 (irq = 36, base_baud = 230400) is a Z85c30 
ESCC - Serial port
Macintosh Cuda and Egret driver.
mesh: configured for synchronous 5 MB/s
st: Version 20160209, fixed bufsize 32768, s/g segs 256
Detected ADB keyboard, type ANSI.
input: ADB keyboard as /devices/virtual/input/input0
input: ADB mouse as /devices/virtual/input/input1
pata-macio 0.00020000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 0
scsi host0: pata_macio
ata1: PATA max MWDMA2 irq 16 lpm-pol 0
pata-macio 0.00021000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 1
scsi host1: pata_macio
ata2: PATA max MWDMA2 irq 18 lpm-pol 0
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
usbcore: registered new interface driver appletouch
rtc-generic rtc-generic: registered as rtc0
rtc-generic rtc-generic: setting system clock to 2026-07-28T20:23:46 UTC (1785270226)
APM Battery Driver
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
Initializing XFRM netlink socket
NET: Registered PF_PACKET protocol family
PFKEY is deprecated and scheduled to be removed in 2027, please contact the netdev 
mailing list
NET: Registered PF_KEY protocol family
Key type dns_resolver registered
Loading compiled-in X.509 certificates
Freeing unused kernel image (initmem) memory: 1232K
This architecture does not have kernel memory protection.
Run /init as init process
mount: mounting devtmpfs on /dev failed: No such device
Saving 256 bits of non-creditable seed for next boot
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Starting network: OK
Linux version 7.2.0-rc4+ (nathan@ax162) (powerpc-linux-gcc (GCC) 16.1.0, GNU ld (GNU 
Binutils) 2.46) #1 PREEMPT Tue Jul 21 16:59:50 MST 2026
Stopping network: OK
Stopping klogd: OK
Stopping syslogd: OK
Seeding 256 bits without crediting
seedrng: can't open '/dev/urandom': No such file or directory
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
reboot: Restarting system



ATB,

Mark.


