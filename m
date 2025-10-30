Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7069ECCFA00
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUVJ-0005W2-L8; Thu, 30 Oct 2025 11:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vEUV9-0005RX-Ab; Thu, 30 Oct 2025 11:23:47 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vEUUx-0006ha-SY; Thu, 30 Oct 2025 11:23:46 -0400
Received: from [192.168.71.4] (unknown [114.88.97.170])
 by APP-01 (Coremail) with SMTP id qwCowABnzmjqggNplL1vAA--.2178S2;
 Thu, 30 Oct 2025 23:23:22 +0800 (CST)
Message-ID: <74d8553b-f98b-4d5d-8b47-5fe21b1c7904@isrc.iscas.ac.cn>
Date: Thu, 30 Oct 2025 23:23:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hw/riscv: Add Server Platform Reference Board
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com
References: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
 <dbbdc597-9b4d-4dd3-8143-821ac5d82a3a@zevorn.cn>
 <18dc5a20-85c6-4e85-b76f-66dca6771bc1@ventanamicro.com>
From: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <18dc5a20-85c6-4e85-b76f-66dca6771bc1@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABnzmjqggNplL1vAA--.2178S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr47KrW7Kr45tFW7CFyxGrg_yoW5Xr47pF
 WFga43KF1DJr1fArsFqw4jgr40yF4xXay5Kr4rJrykAF90v3W8Jr1qyF45ua48Jw4fCF42
 vFWYq34fZrWDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
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
 87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgcTQUUUUU
X-Originating-IP: [114.88.97.170]
X-CM-SenderInfo: pfkd0hholxh2hlvf4qplvuuh5lvft2wodfhubq/1tbiBwoLAGkDftgJuwAAs4
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

On 10/30/2025 9:33 PM, Daniel Henrique Barboza wrote:
> 
> 
> On 10/30/25 8:48 AM, Chao Liu wrote:
>> On Wed, May 28, 2025 at 05:01:29PM -0300, Daniel Henrique Barboza wrote:
>>> Hi,
>>>
>>> This is my attempt to ressurect the Server SoC Platform reference work
>>> that has been buried for an year. The last posting was made an year ago
>>> [1].
>>> Most of the changes were made due to upstream differences from one year
>>> ago. Patch 1 is an example of that.
>>>
>>> In patch 2 (former 1), the main difference is the new CPU is rva23s64
>>> compliant. This wasn't possible in May 2024 because we didn't have this
>>> support back then.
>>>
>>> Patch 3 consists mostly of code base changes rather than functional
>>> changes. There was a discussion about whether we should supply fdts in
>>> this machine back in the v2 review [2]. The answer is yes: machine mode
>>> requires fdt to work, and we want to be flexible enough to generate our
>>> own fdt instead of relying on EDK2 to supply them. Note that we can also
>>> supply an EDK2-generated fdt via command line, bypassing the fdt created
>>> by QEMU, if desired.
>>>
>>> Patch 4 adds a riscv-iommu-sys device to the board. This wasn't possible
>>> back then because we didn't have the required upstream support for it.
>>>
>>
>> Hi, Daniel.
>>
>> Do we have any plans to support virt-io on the rvsp-ref machine in the future?
> 
> Hmmm good question. In theory we're interested only in implementing the rvsp-ref
> spec but adding virt-io support doesn't hurt the spec implementation in any
> way ... I think. Drew, any comments?
> 
> 
>>
>> Recently, I have been using the RISC-V reference platform built on this set of
>> patches to support running the OpenEuler RISC-V operating system.
>>
>> I will actively feed back any test results to the upstream.
> 
> 
> This series has been stale because, as you might've read in the thread, it turns
> out we're missing a mandatory extension (sdext).
> 

I have a basic version of the sdext extension ready. I’ll improve it later and
share it with the upstream community to discuss.

Thank,
Chao

> I get emails from time to time from people asking about the status of this work
> so I'm considering pushing the patches as is, without sdext, and add documentation
> saying that this isn't a 100% rsvp-ref compliant board. The absence of sdext
> seems tolerable for the current uses ppl have for the board ATM, so upstreaming
> it as is can be beneficial for everyone. We can add sdext support later and
> then update the docs claiming 100% compliance.
> 
> At very least I'll have to send a v4 now that you pointed out a wrong memory
> address in the memmap, so I'll start with that.
> 
> 
> Thanks,
> 
> Daniel
> 
> 
>>
>> Thanks,
>> Chao


