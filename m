Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEC7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTXS-0000fA-64; Tue, 18 Mar 2025 05:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tuTXP-0000ew-QK
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:47:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tuTXM-0007QB-U1
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:47:07 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxdWkOQdln53ObAA--.1214S3;
 Tue, 18 Mar 2025 17:46:55 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMDxH+ULQdln_oZRAA--.37968S3;
 Tue, 18 Mar 2025 17:46:53 +0800 (CST)
Subject: Re: [PATCH] docs/system: Add entry for LoongArch system
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250312062620.3360498-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e5cb1467-b44c-ab20-909a-fcdd8bf34c0c@loongson.cn>
Date: Tue, 18 Mar 2025 17:49:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250312062620.3360498-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMDxH+ULQdln_oZRAA--.37968S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF47JFWfCr1DAF4DKr13ZFc_yoWrWF18pF
 n3ZFWfKr47JrykCrnrWa4agr4DAr1Ikw17uFyIyw18G398Ary7Wr1rt34fXFW7J3ykCF1j
 vry8Gry5W3W8XrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.664, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2025/3/12 ÏÂÎç2:26, Bibo Mao Ð´µÀ:
> Add index entry for LoongArch system and do some small modification
> with  LoongArch document with rst syntax.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   docs/system/loongarch/virt.rst   | 31 ++++++++++---------------------
>   docs/system/target-loongarch.rst | 19 +++++++++++++++++++
>   docs/system/targets.rst          |  1 +
>   3 files changed, 30 insertions(+), 21 deletions(-)
>   create mode 100644 docs/system/target-loongarch.rst
Reviewed-by: Song Gao <gaosong@loongson.cn>

thanks.
Song Gao
>
> diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rst
> index 172fba079e..7845878469 100644
> --- a/docs/system/loongarch/virt.rst
> +++ b/docs/system/loongarch/virt.rst
> @@ -12,14 +12,15 @@ Supported devices
>   -----------------
>   
>   The ``virt`` machine supports:
> -- Gpex host bridge
> -- Ls7a RTC device
> -- Ls7a IOAPIC device
> -- ACPI GED device
> -- Fw_cfg device
> -- PCI/PCIe devices
> -- Memory device
> -- CPU device. Type: la464.
> +
> +* Gpex host bridge
> +* Ls7a RTC device
> +* Ls7a IOAPIC device
> +* ACPI GED device
> +* Fw_cfg device
> +* PCI/PCIe devices
> +* Memory device
> +* CPU device. Type: la464.
>   
>   CPU and machine Type
>   --------------------
> @@ -39,13 +40,7 @@ can be accessed by following steps.
>   
>   .. code-block:: bash
>   
> -  ./configure --disable-rdma --prefix=/usr \
> -              --target-list="loongarch64-softmmu" \
> -              --disable-libiscsi --disable-libnfs --disable-libpmem \
> -              --disable-glusterfs --enable-libusb --enable-usb-redir \
> -              --disable-opengl --disable-xen --enable-spice \
> -              --enable-debug --disable-capstone --disable-kvm \
> -              --enable-profiler
> +  ./configure --target-list="loongarch64-softmmu"
>     make -j8
>   
>   (2) Set cross tools:
> @@ -53,9 +48,7 @@ can be accessed by following steps.
>   .. code-block:: bash
>   
>     wget https://github.com/loongson/build-tools/releases/download/2022.09.06/loongarch64-clfs-6.3-cross-tools-gcc-glibc.tar.xz
> -
>     tar -vxf loongarch64-clfs-6.3-cross-tools-gcc-glibc.tar.xz  -C /opt
> -
>     export PATH=/opt/cross-tools/bin:$PATH
>     export LD_LIBRARY_PATH=/opt/cross-tools/lib:$LD_LIBRARY_PATH
>     export LD_LIBRARY_PATH=/opt/cross-tools/loongarch64-unknown-linux-gnu/lib/:$LD_LIBRARY_PATH
> @@ -74,13 +67,9 @@ Note: To build the release version of the bios,  set --buildtarget=RELEASE,
>   .. code-block:: bash
>   
>     git clone https://github.com/loongson/linux.git
> -
>     cd linux
> -
>     git checkout loongarch-next
> -
>     make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- loongson3_defconfig
> -
>     make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- -j32
>   
>   Note: The branch of linux source code is loongarch-next.
> diff --git a/docs/system/target-loongarch.rst b/docs/system/target-loongarch.rst
> new file mode 100644
> index 0000000000..316c604b91
> --- /dev/null
> +++ b/docs/system/target-loongarch.rst
> @@ -0,0 +1,19 @@
> +.. _LoongArch-System-emulator:
> +
> +LoongArch System emulator
> +-------------------------
> +
> +QEMU can emulate loongArch 64 bit systems via the
> +``qemu-system-loongarch64`` binary. Only one machine type ``virt`` is
> +supported.
> +
> +When using KVM as accelerator, QEMU can emulate la464 cpu model. And when
> +using the default cpu model with TCG as accelerator, QEMU will emulate a
> +subset of la464 cpu features that should be enough to run distributions
> +built for the la464.
> +
> +Board-specific documentation
> +============================
> +
> +.. toctree::
> +   loongarch/virt
> diff --git a/docs/system/targets.rst b/docs/system/targets.rst
> index 224fadae71..38e2418801 100644
> --- a/docs/system/targets.rst
> +++ b/docs/system/targets.rst
> @@ -18,6 +18,7 @@ Contents:
>   
>      target-arm
>      target-avr
> +   target-loongarch
>      target-m68k
>      target-mips
>      target-ppc
>
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32


