Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C939FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESbB-0006Cs-97; Thu, 30 Oct 2025 09:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vER1H-0004st-Fq; Thu, 30 Oct 2025 07:40:43 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vER1A-00080A-TA; Thu, 30 Oct 2025 07:40:42 -0400
Received: from [192.168.71.4] (unknown [114.88.97.170])
 by APP-01 (Coremail) with SMTP id qwCowAC3H2qdTgNpiNo0AA--.1692S2;
 Thu, 30 Oct 2025 19:40:13 +0800 (CST)
Message-ID: <9d373320-f90e-4a33-9d32-8a069046d545@isrc.iscas.ac.cn>
Date: Thu, 30 Oct 2025 19:40:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dbarboza@ventanamicro.com
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com
References: <20250528200129.1548259-5-dbarboza@ventanamicro.com>
Subject: Re: [PATCH v3 4/4] hw/riscv/server_platform_ref.c: add riscv-iommu-sys
From: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <20250528200129.1548259-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowAC3H2qdTgNpiNo0AA--.1692S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWUAFyDKrW8CFW5Wr1rWFg_yoW8Cw1xpF
 4DGF45Cr4rJFnaqFy3Kr43Gr15Xan3uFW5C34xZF1UAw47JrWUXwnrtw18WFy8GFWqy34Y
 9Fyv9F1akF4jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jYlksUUUUU=
X-Originating-IP: [114.88.97.170]
X-CM-SenderInfo: pfkd0hholxh2hlvf4qplvuuh5lvft2wodfhubq/1tbiDAULAGkDNAZbRwAAsG
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=chao.liu.riscv@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 Oct 2025 09:21:41 -0400
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
>Add an always present IOMMU platform device for the rvsp-ref board.
>
>The IRQs being used are similar to what the 'virt' board is using: IRQs
>36 to 39, one IRQ for queue.
>
>Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>---
> hw/riscv/Kconfig               |  1 +
> hw/riscv/server_platform_ref.c | 78 ++++++++++++++++++++++++++++++++--
> 2 files changed, 75 insertions(+), 4 deletions(-)
>
>diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>index f626774c52..cd70095687 100644
>--- a/hw/riscv/Kconfig
>+++ b/hw/riscv/Kconfig
>@@ -82,6 +82,7 @@ config SERVER_PLATFORM_REF
>     select RISCV_ACLINT
>     select RISCV_APLIC
>     select RISCV_IMSIC
>+    select RISCV_IOMMU
> 
> config SHAKTI_C
>     bool
>diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>index 5102286103..9740b395f6 100644
>--- a/hw/riscv/server_platform_ref.c
>+++ b/hw/riscv/server_platform_ref.c
>@@ -31,6 +31,8 @@
> #include "hw/riscv/riscv_hart.h"
> #include "hw/riscv/boot.h"
> #include "hw/riscv/numa.h"
>+#include "hw/riscv/iommu.h"
>+#include "hw/riscv/riscv-iommu-bits.h"
> #include "hw/intc/riscv_aclint.h"
> #include "hw/intc/riscv_aplic.h"
> #include "hw/intc/riscv_imsic.h"
>@@ -94,6 +96,7 @@ enum {
>     RVSP_MROM,
>     RVSP_RESET_SYSCON,
>     RVSP_RTC,
>+    RVSP_IOMMU_SYS,
>     RVSP_ACLINT,
>     RVSP_APLIC_M,
>     RVSP_APLIC_S,
>@@ -112,6 +115,7 @@ enum {
>     RVSP_UART0_IRQ = 10,
>     RVSP_RTC_IRQ = 11,
>     RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
>+    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
> };
> 
> /*
>@@ -141,6 +145,7 @@ static const MemMapEntry rvsp_ref_memmap[] = {
>     [RVSP_MROM] =           {     0x1000,        0xf000 },
>     [RVSP_RESET_SYSCON] =   {   0x100000,        0x1000 },
>     [RVSP_RTC] =            {   0x101000,        0x1000 },
>+    [RVSP_IOMMU_SYS] =      {    0102000,        0x1000 },
This might be a typo:
      0102000 -> 0x102000

Thanks,
Chao


