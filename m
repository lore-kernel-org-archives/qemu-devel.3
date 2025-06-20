Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A5AC7115A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 01:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSQen-0002SX-8L; Thu, 19 Jun 2025 21:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uSQeY-0002Qa-F8
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 21:34:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uSQeT-0007Y4-Ok
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 21:34:50 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxNHCuulRoHSEaAQ--.59110S3;
 Fri, 20 Jun 2025 09:34:38 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMDxH+WoulRotsshAQ--.36109S3;
 Fri, 20 Jun 2025 09:34:36 +0800 (CST)
Subject: Re: [PULL 00/14] loongarch-to-apply queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250619082817.1517996-1-gaosong@loongson.cn>
 <CAJSP0QWsFx8qcR4k4nb2fBH0Q1aFWwCUU4JEs+NFCGHKhSphMA@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <779a15f9-49ad-79c9-b50a-209fd55a925c@loongson.cn>
Date: Fri, 20 Jun 2025 09:37:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWsFx8qcR4k4nb2fBH0Q1aFWwCUU4JEs+NFCGHKhSphMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMDxH+WoulRotsshAQ--.36109S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1fJryxKFy7Zr18AFyxWFX_yoWrJr48pr
 W3ur1a9r4rGrsrJrnaq34UXF9xJFn7Wry2v3W3tFyxCrW5Zr1Fvr10yr93WFyUK348Gryj
 qF1rWw1jg3WDAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.648,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2025/6/20 上午4:39, Stefan Hajnoczi 写道:
> On Thu, Jun 19, 2025 at 4:51 AM Song Gao <gaosong@loongson.cn> wrote:
>> The following changes since commit 6e1571533fd92bec67e5ab9b1dd1e15032925757:
>>
>>    Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-06-16 13:47:19 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250619
>  From https://github.com/gaosong715/qemu
>   * tag                     pull-loongarch-20250619 -> FETCH_HEAD
> gpg: Signature made Thu 19 Jun 2025 04:49:38 EDT
> gpg:                using RSA key CA473C44D6A09C189A193FCD452B96852B268216
> gpg: Can't check signature: No public key
>
> Why has the GPG key changed? Your previous pull request was signed
> with key B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF.
Yesterday I realized that the key I had been using was registered to my 
other email address,
so I changed it back.

> If you would like to change keys, please sign your new key using your
> old key and upload the new key to the key servers again. That way I
> know that the new key really belongs to you.
Got it.

Thanks.
Song Gao
> Thanks!
>
>> for you to fetch changes up to c2a2e1ad2a749caa864281b1d4dc3f16c3f344f6:
>>
>>    target/loongarch: fix vldi/xvldi raise wrong error (2025-06-19 15:57:31 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20250619
>>
>> ----------------------------------------------------------------
>> Bibo Mao (13):
>>        hw/intc/loongarch_extioi: Add kernel irqchip realize function
>>        hw/intc/loongarch_extioi: Add kernel irqchip save and restore function
>>        hw/intc/loongarch_ipi: Add kernel irqchip realize function
>>        hw/intc/loongson_ipi: Add load and save interface with ipi_common class
>>        hw/intc/loongarch_ipi: Add kernel irqchip save and restore function
>>        hw/intc/loongarch_pch_msi: Inject MSI interrupt to kernel
>>        hw/intc/loongarch_pch: Add kernel irqchip realize function
>>        hw/intc/loongarch_pch: Add kernel irqchip save and restore function
>>        hw/intc/loongarch_pch: Inject irq line interrupt to kernel
>>        hw/loongarch/virt: Add reset support for kernel irqchip
>>        target/loongarch: Report error with split kernel_irqchip option
>>        hw/loongarch/virt: Disable emulation with IOCSR misc register
>>        hw/loongarch/virt: Add kernel irqchip support
>>
>> Song Gao (1):
>>        target/loongarch: fix vldi/xvldi raise wrong error
>>
>>   hw/intc/loongarch_extioi.c                      |  49 +++++++--
>>   hw/intc/loongarch_extioi_kvm.c                  | 140 ++++++++++++++++++++++++
>>   hw/intc/loongarch_ipi.c                         |  29 +++++
>>   hw/intc/loongarch_ipi_kvm.c                     |  85 ++++++++++++++
>>   hw/intc/loongarch_pch_msi.c                     |  10 ++
>>   hw/intc/loongarch_pch_pic.c                     |  45 +++++++-
>>   hw/intc/loongarch_pic_kvm.c                     |  89 +++++++++++++++
>>   hw/intc/loongson_ipi_common.c                   |  33 ++++++
>>   hw/intc/meson.build                             |   6 +
>>   hw/loongarch/virt.c                             |  65 +++++++----
>>   include/hw/intc/loongarch_extioi.h              |   5 +
>>   include/hw/intc/loongarch_ipi.h                 |   5 +
>>   include/hw/intc/loongarch_pch_pic.h             |   5 +
>>   include/hw/intc/loongarch_pic_common.h          |   1 +
>>   include/hw/intc/loongson_ipi_common.h           |   2 +
>>   target/loongarch/cpu.h                          |   1 +
>>   target/loongarch/kvm/kvm.c                      |  23 +++-
>>   target/loongarch/tcg/insn_trans/trans_vec.c.inc |  13 ++-
>>   18 files changed, 563 insertions(+), 43 deletions(-)
>>   create mode 100644 hw/intc/loongarch_extioi_kvm.c
>>   create mode 100644 hw/intc/loongarch_ipi_kvm.c
>>   create mode 100644 hw/intc/loongarch_pic_kvm.c
>>


