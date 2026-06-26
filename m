Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF90BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9dQ-0000XP-31; Fri, 26 Jun 2026 12:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wd9ct-0000WD-Ts; Fri, 26 Jun 2026 12:42:02 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wd9co-0006ip-V8; Fri, 26 Jun 2026 12:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 To:From; bh=EiAF24o1m+B5EgKpyLVIgBxiDo2MDQsC6aWpdvU8T8Q=; b=SZ/i
 XiTNvDog2jXMIyJ8tYtOj5wJSyRRlVQZ2IZU7natjmDUihoTo0b3+MYwVseyLCwn
 NauNMeooW/0RMXEpBhAuYTckPlVEjsEVzWay1dOkxUtGY9+8NIBVlFHb68NKSkGq
 Nun4TimFGEBRVGtvlGQTVliVxpLlrAYrQuN+i7I=
Received: from [IPV6:2408:8266:ba01:4163:f0d1:b36d:a9c8:e8d0] (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgAnvwPLqj5qWN+nDw--.26422S2;
 Sat, 27 Jun 2026 00:37:31 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------QkAUkN0bjVvzynh7hF0pYfYY"
Message-ID: <a4652ee7-ba62-4cb2-bd7e-78b54ef86160@163.com>
Date: Sat, 27 Jun 2026 00:37:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fixed sdma boundary bug
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260617155857.7451-1-dingtao0430@163.com>
 <20260617155857.7451-2-dingtao0430@163.com>
 <CAEUhbmVPJ_cAUQbTo0C_4swXUmL-DV0OwR6ZcMhgCUhXAP0QEA@mail.gmail.com>
From: Tao Ding <dingtao0430@163.com>
In-Reply-To: <CAEUhbmVPJ_cAUQbTo0C_4swXUmL-DV0OwR6ZcMhgCUhXAP0QEA@mail.gmail.com>
X-CM-TRANSID: PSgvCgAnvwPLqj5qWN+nDw--.26422S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr43uF4kXF1UAryrAF18Krg_yoWxAryDpa
 sFyrs8Kr4kCF1rZry8Ca18XryYvws3Za4ayr1FgrnYyF4YyFyvvwnIkasa9FWjqrWxXry3
 Zrn3Xr9093WUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRVbyNUUUUU=
X-Originating-IP: [2408:8266:ba01:4163:f0d1:b36d:a9c8:e8d0]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-Q0IRmo+qs3t9QAA3V
Received-SPF: pass client-ip=117.135.210.3; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a multi-part message in MIME format.
--------------QkAUkN0bjVvzynh7hF0pYfYY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

1. u-boot

I used the u-boot obtained fromhttps://github.com/u-boot/u-boot,
specifically the commit 1e80ee41441c612f05787a93bbef4e6e422e29d1.

When compiling uboot, I used xilinx_zynq_virt_defconfig and enabled the SDHCI_SDMA function.
This can be set through scripts or in manuconfig.

Below is the command I used for local compilation:

$ export ARCH=arm
$ export CROSS_COMPILE=/home/taoding/arm/gcc-arm-11.2-2022.02-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-
$ make O=/home/taoding/arm/u-boot-build-zynq xilinx_zynq_virt_defconfig
     
$ /home/taoding/arm/u-boot/scripts/config \
     --file /home/taoding/arm/u-boot-build-zynq/.config \
     --enable MMC_SDHCI_SDMA
     
$ make O=/home/taoding/arm/u-boot-build-zynq olddefconfig
$ make O=/home/taoding/arm/u-boot-build-zynq DEVICE_TREE=zynq-zc702 -j$(nproc)

The U-Boot binary used by QEMU was:
/home/taoding/arm/u-boot-build-zynq/u-boot-dtb.bin

2. linux image
I used Linux 6.6.
Below is the command I used:

$ export ARCH=arm
$ export CROSS_COMPILE=/home/taoding/arm/gcc-arm-11.2-2022.02-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-
$ make multi_v7_defconfig
$ make -j$(nproc) zImage dtbs

The resulting files were:
/home/taoding/arm/linux-6.6/arch/arm/boot/zImage
/home/taoding/arm/linux-6.6/arch/arm/boot/dts/xilinx/zynq-zc702.dtb

3. rootfs

I utilized the defconfig and enable static binary to compile and generate rootfs-arm32.cpio.gz

4. zynq-sd.img
The SD image used for testing was a FAT16 image containing:

- zImage
- zynq-zc702.dtb
- rootfs-arm32.cpio.gz

Below is the command I used:

$ truncate -s 128M /home/taoding/arm/zynq-sd.img
$ mkfs.vfat -F 16 /home/taoding/arm/zynq-sd.img

$ mcopy -i /home/taoding/arm/zynq-sd.img \
   /home/taoding/arm/linux-6.6/arch/arm/boot/zImage ::zImage

$ mcopy -i /home/taoding/arm/zynq-sd.img \
   /home/taoding/arm/linux-6.6/arch/arm/boot/dts/xilinx/zynq-zc702.dtb ::zynq-zc702.dtb

$ mcopy -i /home/taoding/arm/zynq-sd.img \
   /home/taoding/arm/rootfs-arm32.cpio.gz ::rootfs-arm32.cpio.gz

If only want to verify the issues fixed in this patch, step 3 can be ignored.
After starting qemu and entering uboot, we can manually load a file.
Please note that the driver will only actually use SDMA when the file size is greater than 0.5MB.
It is recommended to load zImage from sd instead of dtb.

Thanks,
Tao

On 6/26/2026 6:41 AM, Bin Meng wrote:

> On Thu, Jun 18, 2026 at 12:01 AM Tao Ding<dingtao0430@163.com> wrote:
>> During SDMA transfers, the controller raises an interrupt at buffer boundaries
>> to request a system address update. But the emulation fails to clear the
>> SDHC_DOING_READ/WRITE flags after DMA completion, so writes to SDHC_SYSAD are
>> ignored. Clear these flags when the transfer ends.
>> (according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf section 2.2.1)
>>
>> This is a QTest in npcm7xx_sdhci-test that exercises this boundary condition and
>> validates the fix.
>>
>> QTest steps:
>>    1. Replace npcm7xx_sdhci-test.c with the updated version (full code
>>       available at:https://pastebin.com/AWVp2wFi).
>>    2. Build with:
>>         ../configure --target-list="arm-softmmu,aarch64-softmmu" \
>>                      --disable-slirp --enable-debug --disable-werror
>>         ninja qemu-system-arm tests/qtest/npcm7xx_sdhci-test
>>    3. Run the specific test case:
>>         QTEST_QEMU_BINARY=./qemu-system-arm \
>>           ./tests/qtest/npcm7xx_sdhci-test \
>>           -p /arm/npcm7xx_sdhci/read_sd_sdma_boundary_continue
>>
>> Before the fix, the test fails with a BLKCNT assertion:
>>    ERROR:...wait_for_block_count: assertion failed (qtest_readw(...) == expected): (1 == 0)
>>
>> After applying the fix, the test passes:
>>    ok 1 /arm/npcm7xx_sdhci/read_sd_sdma_boundary_continue
>>
>> The new test case ensures the SDMA boundary handling works correctly and
>> prevents future regressions.
>>
>>
>> Uboot test:
> U-Boot
>
>>      1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (MMC_SDHCI_SDMA=y).
> Please specify which U-Boot defconfig you used for testing and how
> zynq-sd.img was generated.
>
>>      2. ./qemu-system-aarch64 -M xilinx-zynq-a9 -machine boot-mode=sd -m 1024 -display none -serial null -serial stdio -monitor none \
>>          -device loader,file=u-boot-dtb.bin,addr=0x04000000,cpu-num=0  \
>>          -drive file=zynq-sd.img,format=raw,if=sd -D qemu.log
>>
>>
>> After applying the fix, success load sd card:
>>
>> U-Boot 2026.07-rc4-g1e80ee41441c (Jun 15 2026 - 19:05:05 +0800)
>>
>> Model: Xilinx ZC702 board
>> DRAM:  ECC disabled 1 GiB
>> Core:  33 devices, 21 uclasses, devicetree: board
>> Flash: 0 Bytes
>> NAND:  0 MiB
>> MMC:   mmc@e0100000: 0
>> Loading Environment from FAT... *** Error - No Valid Environment Area found
>> *** Warning - bad env area, using default environment
>>
>> In:    serial@e0001000
>> Out:   serial@e0001000
>> Err:   serial@e0001000
>> Net:
>> ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 7, interface rgmii-id
>>
>> Warning: ethernet@e000b000 (eth0) using random MAC address - 4a:63:5a:a4:d3:6b
>> eth0: ethernet@e000b000
>> Hit any key to stop autoboot: 0
>> Zynq> fatload mmc 0 ${kernel_addr_r} zImage
>> 10838528 bytes read in 4316 ms (2.4 MiB/s)
>> Zynq> fatload mmc 0 ${ramdisk_addr_r} rootfs-arm32.cpio.gz
>> 406531 bytes read in 199 ms (1.9 MiB/s)
>> Zynq> setenv ramdisk_size ${filesize}
>> Zynq> fatload mmc 0 ${fdt_addr_r} zynq-zc702.dtb
>> 15754 bytes read in 21 ms (732.4 KiB/s)
>> Zynq> setenv bootargs console=ttyPS0,115200 earlycon ignore_loglevel rdinit=/init
>> Zynq> bootz ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr_r}
>> Kernel image @ 0x2000000 [ 0x000000 - 0xa56200 ]
>> ## Flattened Device Tree blob at 01f00000
>>     Booting using the fdt blob at 0x1f00000
>> Working FDT set to 1f00000
>>     Loading Ramdisk to 2ff9c000, end 2ffff403 ... OK
>>     Loading Device Tree to 2ff95000, end 2ff9bd89 ... OK
>> Working FDT set to 2ff95000
>>
>> Starting kernel ...
>>
>>
>>
>> Signed-off-by: Tao Ding<dingtao0430@163.com>
>> ---
>>   hw/sd/sdhci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index c86dfa281f..0d87289ca4 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -644,6 +644,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>>                   s->data_count = 0;
>>               }
>>               if (page_aligned && boundary_count == 0) {
>> +                s->prnsts &= ~SDHC_DOING_READ;
>>                   break;
>>               }
>>           }
>> @@ -669,6 +670,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>>                   }
>>               }
>>               if (page_aligned && boundary_count == 0) {
>> +                s->prnsts &= ~SDHC_DOING_WRITE;
>>                   break;
>>               }
>>           }
>> --
> Regards,
> Bin
--------------QkAUkN0bjVvzynh7hF0pYfYY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>1. u-boot</pre>
    <pre>I used the u-boot obtained from <a class="moz-txt-link-freetext" href="https://github.com/u-boot/u-boot">https://github.com/u-boot/u-boot</a>, 
specifically the commit 1e80ee41441c612f05787a93bbef4e6e422e29d1.

When compiling uboot, I used xilinx_zynq_virt_defconfig and enabled the SDHCI_SDMA function. 
This can be set through scripts or in manuconfig.

Below is the command I used for local compilation:

$ export ARCH=arm
$ export CROSS_COMPILE=/home/taoding/arm/gcc-arm-11.2-2022.02-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-
$ make O=/home/taoding/arm/u-boot-build-zynq xilinx_zynq_virt_defconfig
    
$ /home/taoding/arm/u-boot/scripts/config \
    --file /home/taoding/arm/u-boot-build-zynq/.config \
    --enable MMC_SDHCI_SDMA
    
$ make O=/home/taoding/arm/u-boot-build-zynq olddefconfig
$ make O=/home/taoding/arm/u-boot-build-zynq DEVICE_TREE=zynq-zc702 -j$(nproc)

The U-Boot binary used by QEMU was:
/home/taoding/arm/u-boot-build-zynq/u-boot-dtb.bin

2. linux image
I used Linux 6.6.
Below is the command I used:

$ export ARCH=arm
$ export CROSS_COMPILE=/home/taoding/arm/gcc-arm-11.2-2022.02-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-
$ make multi_v7_defconfig
$ make -j$(nproc) zImage dtbs

The resulting files were:
/home/taoding/arm/linux-6.6/arch/arm/boot/zImage
/home/taoding/arm/linux-6.6/arch/arm/boot/dts/xilinx/zynq-zc702.dtb

3. rootfs</pre>
    <pre>I utilized the defconfig and enable static binary to compile and generate rootfs-arm32.cpio.gz</pre>
    <pre>4. zynq-sd.img
The SD image used for testing was a FAT16 image containing:

- zImage
- zynq-zc702.dtb
- rootfs-arm32.cpio.gz

Below is the command I used:

$ truncate -s 128M /home/taoding/arm/zynq-sd.img
$ mkfs.vfat -F 16 /home/taoding/arm/zynq-sd.img

$ mcopy -i /home/taoding/arm/zynq-sd.img \
  /home/taoding/arm/linux-6.6/arch/arm/boot/zImage ::zImage

$ mcopy -i /home/taoding/arm/zynq-sd.img \
  /home/taoding/arm/linux-6.6/arch/arm/boot/dts/xilinx/zynq-zc702.dtb ::zynq-zc702.dtb

$ mcopy -i /home/taoding/arm/zynq-sd.img \
  /home/taoding/arm/rootfs-arm32.cpio.gz ::rootfs-arm32.cpio.gz

If only want to verify the issues fixed in this patch, step 3 can be ignored. 
After starting qemu and entering uboot, we can manually load a file. 
Please note that the driver will only actually use SDMA when the file size is greater than 0.5MB. 
It is recommended to load zImage from sd instead of dtb.

Thanks,
Tao

</pre>
    <pre class="moz-cite-prefix">On 6/26/2026 6:41 AM, Bin Meng wrote:
</pre>
    <blockquote type="cite"
cite="mid:CAEUhbmVPJ_cAUQbTo0C_4swXUmL-DV0OwR6ZcMhgCUhXAP0QEA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Thu, Jun 18, 2026 at 12:01 AM Tao Ding <a class="moz-txt-link-rfc2396E" href="mailto:dingtao0430@163.com">&lt;dingtao0430@163.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
During SDMA transfers, the controller raises an interrupt at buffer boundaries
to request a system address update. But the emulation fails to clear the
SDHC_DOING_READ/WRITE flags after DMA completion, so writes to SDHC_SYSAD are
ignored. Clear these flags when the transfer ends.
(according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf section 2.2.1)

This is a QTest in npcm7xx_sdhci-test that exercises this boundary condition and
validates the fix.

QTest steps:
  1. Replace npcm7xx_sdhci-test.c with the updated version (full code
     available at: <a class="moz-txt-link-freetext" href="https://pastebin.com/AWVp2wFi">https://pastebin.com/AWVp2wFi</a>).
  2. Build with:
       ../configure --target-list="arm-softmmu,aarch64-softmmu" \
                    --disable-slirp --enable-debug --disable-werror
       ninja qemu-system-arm tests/qtest/npcm7xx_sdhci-test
  3. Run the specific test case:
       QTEST_QEMU_BINARY=./qemu-system-arm \
         ./tests/qtest/npcm7xx_sdhci-test \
         -p /arm/npcm7xx_sdhci/read_sd_sdma_boundary_continue

Before the fix, the test fails with a BLKCNT assertion:
  ERROR:...wait_for_block_count: assertion failed (qtest_readw(...) == expected): (1 == 0)

After applying the fix, the test passes:
  ok 1 /arm/npcm7xx_sdhci/read_sd_sdma_boundary_continue

The new test case ensures the SDMA boundary handling works correctly and
prevents future regressions.


Uboot test:
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
U-Boot

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">    1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (MMC_SDHCI_SDMA=y).
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please specify which U-Boot defconfig you used for testing and how
zynq-sd.img was generated.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">    2. ./qemu-system-aarch64 -M xilinx-zynq-a9 -machine boot-mode=sd -m 1024 -display none -serial null -serial stdio -monitor none \
        -device loader,file=u-boot-dtb.bin,addr=0x04000000,cpu-num=0  \
        -drive file=zynq-sd.img,format=raw,if=sd -D qemu.log


After applying the fix, success load sd card:

U-Boot 2026.07-rc4-g1e80ee41441c (Jun 15 2026 - 19:05:05 +0800)

Model: Xilinx ZC702 board
DRAM:  ECC disabled 1 GiB
Core:  33 devices, 21 uclasses, devicetree: board
Flash: 0 Bytes
NAND:  0 MiB
MMC:   mmc@e0100000: 0
Loading Environment from FAT... *** Error - No Valid Environment Area found
*** Warning - bad env area, using default environment

In:    serial@e0001000
Out:   serial@e0001000
Err:   serial@e0001000
Net:
ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 7, interface rgmii-id

Warning: ethernet@e000b000 (eth0) using random MAC address - 4a:63:5a:a4:d3:6b
eth0: ethernet@e000b000
Hit any key to stop autoboot: 0
Zynq&gt; fatload mmc 0 ${kernel_addr_r} zImage
10838528 bytes read in 4316 ms (2.4 MiB/s)
Zynq&gt; fatload mmc 0 ${ramdisk_addr_r} rootfs-arm32.cpio.gz
406531 bytes read in 199 ms (1.9 MiB/s)
Zynq&gt; setenv ramdisk_size ${filesize}
Zynq&gt; fatload mmc 0 ${fdt_addr_r} zynq-zc702.dtb
15754 bytes read in 21 ms (732.4 KiB/s)
Zynq&gt; setenv bootargs console=ttyPS0,115200 earlycon ignore_loglevel rdinit=/init
Zynq&gt; bootz ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr_r}
Kernel image @ 0x2000000 [ 0x000000 - 0xa56200 ]
## Flattened Device Tree blob at 01f00000
   Booting using the fdt blob at 0x1f00000
Working FDT set to 1f00000
   Loading Ramdisk to 2ff9c000, end 2ffff403 ... OK
   Loading Device Tree to 2ff95000, end 2ff9bd89 ... OK
Working FDT set to 2ff95000

Starting kernel ...



Signed-off-by: Tao Ding <a class="moz-txt-link-rfc2396E" href="mailto:dingtao0430@163.com">&lt;dingtao0430@163.com&gt;</a>
---
 hw/sd/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c86dfa281f..0d87289ca4 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -644,6 +644,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s-&gt;data_count = 0;
             }
             if (page_aligned &amp;&amp; boundary_count == 0) {
+                s-&gt;prnsts &amp;= ~SDHC_DOING_READ;
                 break;
             }
         }
@@ -669,6 +670,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 }
             }
             if (page_aligned &amp;&amp; boundary_count == 0) {
+                s-&gt;prnsts &amp;= ~SDHC_DOING_WRITE;
                 break;
             }
         }
--
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Regards,
Bin
</pre>
    </blockquote>
  </body>
</html>

--------------QkAUkN0bjVvzynh7hF0pYfYY--


