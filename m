Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBE2CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUAX-00060i-G6; Thu, 30 Oct 2025 11:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vEUAS-0005yu-Uw; Thu, 30 Oct 2025 11:02:25 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vEUAI-00041B-KV; Thu, 30 Oct 2025 11:02:24 -0400
Received: from [192.168.71.4] (unknown [114.88.97.170])
 by APP-01 (Coremail) with SMTP id qwCowAAnj2nlfQNpJTxqAA--.2776S2;
 Thu, 30 Oct 2025 23:01:57 +0800 (CST)
Message-ID: <ab8161b3-d4e9-4573-b13f-e13b9c6b322e@isrc.iscas.ac.cn>
Date: Thu, 30 Oct 2025 23:01:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dbarboza@ventanamicro.com
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 wu.fei9@sanechips.com.cn, zhiwei_liu@linux.alibaba.com
References: <20250528200129.1548259-3-dbarboza@ventanamicro.com>
Subject: Re: [PATCH v3 2/4] target/riscv: Add server platform reference cpu
From: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <20250528200129.1548259-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAnj2nlfQNpJTxqAA--.2776S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UtF43trW5urW5JFy5urg_yoW5ZFyfpr
 48KFWqk34kJ39FkayftF4DXr4kZws3Ww43Gwn3ZwsFyrWYqrWUWryDKFyUC3ZFvF1xG3WS
 yw1UCr95Jrs8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2wIDUUUUU
X-Originating-IP: [114.88.97.170]
X-CM-SenderInfo: pfkd0hholxh2hlvf4qplvuuh5lvft2wodfhubq/1tbiCRALAGkDL2ftMwAAsu
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=chao.liu.riscv@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 28, 2025 at 05:01:29PM -0300, Daniel Henrique Barboza wrote:
>rom: Fei Wu <wu.fei9@sanechips.com.cn>
>
>he harts requirements of RISC-V server platform [1] require RVA23 ISA
>rofile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
> virt CPU type (rvsp-ref) as compliant as possible.
>
>1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>
>igned-off-by: Fei Wu <fei2.wu@intel.com>
>igned-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>--
>target/riscv/cpu-qom.h |  1 +
>target/riscv/cpu.c     | 11 +++++++++++
>2 files changed, 12 insertions(+)
>
>iff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>ndex 1ee05eb393..70978fd53c 100644
>-- a/target/riscv/cpu-qom.h
>++ b/target/riscv/cpu-qom.h
>@ -55,6 +55,7 @@
>#define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>#define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>#define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
>#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>#define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>
>OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>iff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>ndex 4a30cf8444..ec2fbc0e78 100644
>-- a/target/riscv/cpu.c
>++ b/target/riscv/cpu.c
>@ -3166,6 +3166,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>        .cfg.max_satp_mode = VM_1_10_SV39,
>    ),
>
>    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSP_REF, TYPE_RISCV_VENDOR_CPU,

I'm not sure the parent type TYPE_RISCV_VENDOR_CPU is right here.

To be on the safe side, I tested this CPU type using an openEuler image that
can boot on a virtual machine. This image supports rva23s64, and my command is
as follows:

cmd="$QEMU_SYSTEM_RISCV64 \
   -nographic -machine virt,pflash0=pflash0,pflash1=pflash1,acpi=off \
   -cpu rvsp-ref \
   -smp "$vcpu" -m "$memory"G \
   -blockdev node-name=pflash0,driver=file,read-only=on,filename="$fw1" \
   -blockdev node-name=pflash1,driver=file,filename="$fw2" \
   -drive file="$drive",format=qcow2,id=hd0,if=none \
   -object rng-random,filename=/dev/urandom,id=rng0 \
   -device virtio-vga \
   -device virtio-rng-device,rng=rng0 \
   -device virtio-blk-device,drive=hd0 \
   -device virtio-net-device,netdev=usernet \
   -netdev user,id=usernet,hostfwd=tcp::"$ssh_port"-:22 \
   -device qemu-xhci -usb -device usb-kbd -device usb-tablet"

This process gets stuck at the initialization stage:

```
     Loading Linux 6.6.0-102.0.0.5.oe2509.riscv64 ...
     Loading initial ramdisk ...
```

If I use the parameter `-cpu rva23s64`, the system can boot normally.

I tried changing TYPE_RISCV_VENDOR_CPU to TYPE_RISCV_BARE_CPU and found that
the system then boots normally.

However, I haven’t conducted an in-depth analysis yet, so the issue might be
with my system image.

Thanks,
Chao

>        .misa_mxl_max = MXL_RV64,
>        .profile = &RVA23S64,
>
>        /* ISA extensions */
>        .cfg.ext_zkr = true,
>        .cfg.ext_svadu = true,
>
>        .cfg.max_satp_mode = VM_1_10_SV57,
>    ),
>


