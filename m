Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546FFCCD199
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 02:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9wob-0003ej-5f; Fri, 17 Oct 2025 22:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v9woY-0003eW-Ef
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 22:37:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v9woV-0001ih-D2
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 22:37:02 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxK9I+_fJok5MXAA--.49042S3;
 Sat, 18 Oct 2025 10:36:46 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxH8I6_fJo9afwAA--.16023S3;
 Sat, 18 Oct 2025 10:36:44 +0800 (CST)
Subject: Re: [PATCH 4/5] target-info: Introduce runtime
 TARGET_PHYS_ADDR_SPACE_BITS
To: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 Song Gao <gaosong@loongson.cn>, Helge Deller <deller@gmx.de>
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-4-8b416eda42cf@rev.ng>
 <673e3c7b-b8ef-4908-b74d-62203b131229@linaro.org>
 <7jzcbl2yqkssu5lshz4umayaesoxwg3gcskrrkobc37df2p4z2@s26yst4mfxoe>
 <8f0db5c1-f20b-4b7a-8d6c-76ce7ec7b4e0@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <187c699e-eefa-1d62-34a7-6fd689c10feb@loongson.cn>
Date: Sat, 18 Oct 2025 10:34:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8f0db5c1-f20b-4b7a-8d6c-76ce7ec7b4e0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8I6_fJo9afwAA--.16023S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GrW3KFyfuF17XFyrKw1xZwc_yoW7Wr1kpF
 n3tr1jyrZY9rZYvFW5ur1DJryUAr1fKa1UXFn3GFWrZw45JrnFqr1v9r4a9FnxJr48CrW2
 vF15Jr43uFWDAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.367,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2025/10/18 上午2:47, Richard Henderson wrote:
> On 10/17/25 09:11, Anton Johansson wrote:
>> Hmm you're right looking at git grep -C1 TARGET_PHYS_ADDR_SPACE_BITS
>> (output below excluding the hw/riscv change in the following patch),
>> there are really aren't that many uses left and none in common code.
>>
>> We still got to move it to a runtime value somewhere though, what
>> would be a more suitable location?  Maybe as a field in CPUArchState or
>> some parent QOM machine as only i386, hppa, loongarch, riscv, alpha
>> actually use the definition.
> 
> A fair few of these are arguably wrong.
> 
> 
>>    hw/loongarch/boot.c:    return addr & MAKE_64BIT_MASK(0, 
>> TARGET_PHYS_ADDR_SPACE_BITS);
>>    --
>>    hw/loongarch/boot.c-    *kernel_entry = 
>> extract64(le64_to_cpu(hdr->kernel_entry),
>>    hw/loongarch/boot.c:                              0, 
>> TARGET_PHYS_ADDR_SPACE_BITS);
>>    hw/loongarch/boot.c-    *kernel_low = 
>> extract64(le64_to_cpu(hdr->load_offset),
>>    hw/loongarch/boot.c:                            0, 
>> TARGET_PHYS_ADDR_SPACE_BITS);
> 
> This is cpu_loongarch_virt_to_phys, and some repetitions.
> 
> This should probably use a loongarch-specific runtime function to find 
> the address space range supported by the chosen cpu.  Or perhaps just a 
> target-specific constant mask.
> 
> 
>>    linux-user/alpha/target_proc.h-            "L3 cache\t\t: n/a\n",
>>    linux-user/alpha/target_proc.h:            model, TARGET_PAGE_SIZE, 
>> TARGET_PHYS_ADDR_SPACE_BITS,
>>    linux-user/alpha/target_proc.h-            max_cpus, num_cpus, 
>> cpu_mask);
> 
> This is the alpha-linux-user implementation of /proc/cpuinfo.
> 
> Ideally this should be a target-specific function; see
> 
> /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
> #define TARGET_PHYS_ADDR_SPACE_BITS  44
> 
> It's certainly not generic, and it's also not really important.
> 
>>    --
>>    target/hppa/mem_helper.c:    
>> QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 54);
>>    target/hppa/mem_helper.c:    return sextract64(addr, 0, 
>> TARGET_PHYS_ADDR_SPACE_BITS);
>>    --
>>    target/hppa/mem_helper.c:        addr |= -1ull << 
>> (TARGET_PHYS_ADDR_SPACE_BITS - 4);
>>    --
>>    target/hppa/mem_helper.c-    /* Ignore the bits beyond physical 
>> address space. */
>>    target/hppa/mem_helper.c:    ent->pa = sextract64(ent->pa, 0, 
>> TARGET_PHYS_ADDR_SPACE_BITS);
> 
> Similarly
> 
> /* ??? PA-8000 through 8600 have 40 bits; PA-8700 and 8900 have 44 bits. */
> # define TARGET_PHYS_ADDR_SPACE_BITS  40
> 
> While we don't actually name concrete cpu models, bios advertises the 
> (32-bit) HP B160L machine, which originally had a 7300LC, and the 
> (64-bit) which had a 8700.
> 
> I can't find definitive documentation, but I suspect the 7300LC has only 
> 32 physical address bits.  And according to our own comment we get the 
> 8700 value wrong.
> 
> In either case, it's not exposed to generic code.
> 
>>    --
>>    target/i386/cpu.c-        if (cpu->phys_bits &&
>>    target/i386/cpu.c:            (cpu->phys_bits > 
>> TARGET_PHYS_ADDR_SPACE_BITS ||
>>    target/i386/cpu.c-            cpu->phys_bits < 32)) {
>>    --
>>    target/i386/cpu.c-                             " (but is %u)",
>>    target/i386/cpu.c:                             
>> TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
>>    --
>>    target/i386/kvm/kvm.c:        
>> QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
>>    target/i386/kvm/kvm.c:        assert(cpu->phys_bits <= 
>> TARGET_PHYS_ADDR_SPACE_BITS);
> 
> All of these are simply making sure that cpu->phys_bits is "in range", 
> which is now irrelevant because TARGET_PHYS_ADDR_SPACE_BITS itself is no 
> longer in use.  They can all be removed.
> 
>>    --
>>    target/i386/tcg/helper-tcg.h:QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > 
>> TARGET_PHYS_ADDR_SPACE_BITS);
> 
> Likewise.
> 
> 
>>    target/loongarch/internals.h:#define TARGET_PHYS_MASK 
>> MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)
> 
> This is used by target/loongarch/tcg/tlb_helper.c.
> 
> I'm not sure what the implications are.
It is to convert it to physical address for compatible issue. With page 
directory table, HW discards bits higher than 
TARGET_PHYS_ADDR_SPACE_BITS for compatible issue since SW has already 
used in this way.

SW sets higher bit and treats it as virtual address, software can use it 
directly with set_pXd() and needs not convert to physical address. In 
future SW can use page directory table with physical address method, 
however there is no obvious benefits and motivation :(

Regards
Bibo Mao

> Should it be using a common function with the loongarch boot virt-to-phys?
> Is it re-using TARGET_PHYS_ADDR_SPACE_BITS just because it was convienient?
> 
> In either case, it's not exposed to generic code.
> 
> 
> r~


