Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44500C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDA6-0006QZ-Tw; Tue, 21 Jul 2026 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wmDA2-0006QA-KI; Tue, 21 Jul 2026 12:17:38 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wmD9z-0007P6-10; Tue, 21 Jul 2026 12:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sx
 dsnNk/PbNT1Fg74+0TcDiAssvy53AGnv+mMgSP2dg=; b=b71REtt7fSK1IHX/48
 fslMSJ7NRQImbGGJnEEjR0QyB/jeBXMkWa6ahblcowhrzcqS2N22i4WL+1N2jqBr
 q1a/TLMppED+sEX+BBuZEEPcieNA3UAevSBvxYs4mmMI4H5UsqjgG4IbhIdjNzAh
 JjWuazwp5MbAO3Qxe2XSdokOE=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3F6+wml9qkr5qKg--.58375S9; 
 Wed, 22 Jul 2026 00:13:41 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 7/7] hw/riscv: k230: add a noc stub region in K230 board
Date: Wed, 22 Jul 2026 00:13:35 +0800
Message-ID: <20260721161335.73872-8-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721161335.73872-1-dingtao0430@163.com>
References: <20260721161335.73872-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3F6+wml9qkr5qKg--.58375S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyUJF1UArWUJr4fKw13CFg_yoW8Kr1UpF
 42kan0k3y8JF45Xa1v9rWDWryjqan5Z3ZxJw18Z34j9r48AFyDtwnak3yrJFW5Xr1fJ347
 CF9IyryI9r1UG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pElkshUUUUU=
X-Originating-IP: [101.204.18.42]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4hVGhGpfmrVpMwAA31
Received-SPF: pass client-ip=220.197.31.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The NOC address was accessed in the k230_unzip driver, but it is currently not in k230.
This commit uses create_unimplemented_device to preset the region.

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
Steps to decompress in uboot:
1. Prepare uboot and k230_sdk
     u-boot (https://github.com/zevorn/k230-boot-assets)
     k230_sdk (https://github.com/kendryte/k230_sdk)
2. Compress image (in sh file, modify ROOT and K230_SDK_ROOT)
     ROOT=k230-boot-assets
     K230_SDK_ROOT=k230_sdk
     DST=$ROOT/buildroot/uboot-boot
     cd $DST
     $K230_SDK_ROOT/tools/k230_priv_gzip -n8  -f -k Image
     sed -i -e "1s/\x08/\x09/"  Image.gz
     cd -
3. Launch qemu (in sh file, modify ROOT and QEMU)
     ROOT=k230-boot-assets
     QEMU=qemu/build/qemu-system-riscv64
     COMMON=$ROOT/common
     DST=$ROOT/buildroot/uboot-boot
     INITRD_END=$(printf "0x%x" $((0x0a100000 + $(stat -c %s "$DST/rootfs.cpio.gz"))))

     echo "Use this U-Boot initrd end: $INITRD_END"

     $QEMU -M k230 \
          -bios "$COMMON/u-boot" \
          -device loader,file="$COMMON/fw_jump.uImage",addr=0xc100000,force-raw=on \
          -device loader,file="$DST/Image.gz",addr=0xd000000,force-raw=on \
          -device loader,file="$DST/rootfs.cpio.gz",addr=0xa100000,force-raw=on \
          -device loader,file="$DST/k230-qemu.dtb",addr=0xa000000,force-raw=on \
          -nographic -no-reboot \
          -d guest_errors \
          -D qemu.log
4. Input in uboot
     k230_unzip 0xd000000 0x6c354f 0x8200000
     setenv bootargs console=ttyS0,115200 earlycon=sbi cma=0
     fdt addr 0xa000000
     fdt resize 8192
     fdt set /chosen linux,initrd-start <0x0 0xa100000>
     fdt set /chosen linux,initrd-end <0x0 0xba2d5fe>
     bootm 0xc100000 - 0xa000000

 hw/riscv/k230.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 7fd1ec4c25..ff834d6724 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -234,6 +234,9 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&s->decomp_gzip), i));
     }
 
+    /* Noc stub, the k230 decomp_gzip driver in uboot will access this region */
+    create_unimplemented_device("noc-stub", 0x91302000, 0x1000);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
-- 
2.43.0


