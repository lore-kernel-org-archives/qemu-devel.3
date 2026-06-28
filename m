Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DF4C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 17:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdtAF-0005uK-4d; Sun, 28 Jun 2026 13:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wdtAD-0005u6-GO; Sun, 28 Jun 2026 13:19:25 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wdtAA-0007MT-46; Sun, 28 Jun 2026 13:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 To:From; bh=YGoMThrGnzsbFBIr2iEmNoTrHu5hVEwXR6zblTv6BWY=; b=fNHp
 ruM4sTkgXfS0xl0Bwvea7v5LO3cPtrLnEQZ6zrRDDQ7Nqa+qtWVRnTalTYg/H9Qn
 LfyITmwhHKdImIug2kE4UVYp/aueVpyVHczvUEOnhbpgAq5MQLdvkrGeBS17QGio
 CEFaXMp1NNiAmdbe4231Qp4gFT+6AyoS1AFPjs0=
Received: from [IPV6:2408:8266:ba01:2c71:9574:80f2:d34c:e71b] (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wCHz_e_VkFqOZAyGQ--.19957S2; 
 Mon, 29 Jun 2026 01:15:44 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------dxeTPaRfZye9NJxNO9CDamnO"
Message-ID: <45d3f7c3-0969-4cab-95c4-9f44b94412f0@163.com>
Date: Mon, 29 Jun 2026 01:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fixed sdma boundary bug
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260617155857.7451-1-dingtao0430@163.com>
 <20260617155857.7451-2-dingtao0430@163.com>
 <CAEUhbmVGrfD8WndBXNFJhZK3iVug-TXiQ3uQK6PvE0+z_wqqhA@mail.gmail.com>
From: Tao Ding <dingtao0430@163.com>
In-Reply-To: <CAEUhbmVGrfD8WndBXNFJhZK3iVug-TXiQ3uQK6PvE0+z_wqqhA@mail.gmail.com>
X-CM-TRANSID: _____wCHz_e_VkFqOZAyGQ--.19957S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW3tFWUXw15Jw15trWkJFb_yoWrKw1rpF
 W2yr4fKrs3AF1rAF1kC3W8GFyUuwsrZa43tryFyrnYvan8uFnYqw43K3WY9rWUXrWxXw13
 Aws8XryYva4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR9IDcUUUUU=
X-Originating-IP: [2408:8266:ba01:2c71:9574:80f2:d34c:e71b]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-gGw7mpBVsGovAAA3J
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
--------------dxeTPaRfZye9NJxNO9CDamnO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for suggestion.
If post a patch in qtest, I have some doubts about where to place the code.

The bug fixed by this patch is related to generic sdhci. Currently,
qos-test includes a file named sdhci-test.c, which seems to be more appropriately placed here.
qos-test conducts tests on many machines, but the way some machines load SD cards varies greatly.
Is it possible to target only a specific board, such as xilinx-zynq-a9, and skip the other machines.
Another way is to create a new file named xilinx_zynq_sdhci-test.c (similar to npcm7xx_sdhci-test.c).

Thanks,
Tao

On 6/28/2026 8:12 PM, Bin Meng wrote:

> On Thu, Jun 18, 2026 at 12:01 AM Tao Ding<dingtao0430@163.com> wrote:
>> During SDMA transfers, the controller raises an interrupt at buffer boundaries
>> to request a system address update. But the emulation fails to clear the
>> SDHC_DOING_READ/WRITE flags after DMA completion, so writes to SDHC_SYSAD are
>> ignored. Clear these flags when the transfer ends.
>> (according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf section 2.2.1)
>>
> The commit message could end here, and the following can be put below
> --- so that they don't go into the commit message while it could still
> provide useful information for people to understand the issue.
>
>> This is a QTest in npcm7xx_sdhci-test that exercises this boundary condition and
>> validates the fix.
>>
>> QTest steps:
>>    1. Replace npcm7xx_sdhci-test.c with the updated version (full code
>>       available at:https://pastebin.com/AWVp2wFi).
> Please post a qtest patch instead.
>
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
>>      1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (MMC_SDHCI_SDMA=y).
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
> Overall this patch LGTM.
>
> Regards,
> Bin
--------------dxeTPaRfZye9NJxNO9CDamnO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>Thank you for suggestion.  
If post a patch in qtest, I have some doubts about where to place the code.

The bug fixed by this patch is related to generic sdhci. Currently, 
qos-test includes a file named sdhci-test.c, which seems to be more appropriately placed here. 
qos-test conducts tests on many machines, but the way some machines load SD cards varies greatly. 
Is it possible to target only a specific board, such as xilinx-zynq-a9, and skip the other machines.
Another way is to create a new file named xilinx_zynq_sdhci-test.c (similar to npcm7xx_sdhci-test.c).

Thanks,
Tao

</pre>
    <pre class="moz-cite-prefix">On 6/28/2026 8:12 PM, Bin Meng wrote:
</pre>
    <blockquote type="cite"
cite="mid:CAEUhbmVGrfD8WndBXNFJhZK3iVug-TXiQ3uQK6PvE0+z_wqqhA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Thu, Jun 18, 2026 at 12:01 AM Tao Ding <a class="moz-txt-link-rfc2396E" href="mailto:dingtao0430@163.com">&lt;dingtao0430@163.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
During SDMA transfers, the controller raises an interrupt at buffer boundaries
to request a system address update. But the emulation fails to clear the
SDHC_DOING_READ/WRITE flags after DMA completion, so writes to SDHC_SYSAD are
ignored. Clear these flags when the transfer ends.
(according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf section 2.2.1)

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The commit message could end here, and the following can be put below
--- so that they don't go into the commit message while it could still
provide useful information for people to understand the issue.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This is a QTest in npcm7xx_sdhci-test that exercises this boundary condition and
validates the fix.

QTest steps:
  1. Replace npcm7xx_sdhci-test.c with the updated version (full code
     available at: <a class="moz-txt-link-freetext" href="https://pastebin.com/AWVp2wFi">https://pastebin.com/AWVp2wFi</a>).
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please post a qtest patch instead.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">  2. Build with:
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
    1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (MMC_SDHCI_SDMA=y).
    2. ./qemu-system-aarch64 -M xilinx-zynq-a9 -machine boot-mode=sd -m 1024 -display none -serial null -serial stdio -monitor none \
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
Overall this patch LGTM.

Regards,
Bin
</pre>
    </blockquote>
  </body>
</html>

--------------dxeTPaRfZye9NJxNO9CDamnO--


