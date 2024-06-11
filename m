Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0107C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 01:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGqlY-0008Ej-2j; Mon, 10 Jun 2024 21:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sGqlV-0008ED-Ew
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 21:57:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sGqlS-0008T7-Bc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 21:57:37 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxP_AEr2dm6ogFAA--.22676S3;
 Tue, 11 Jun 2024 09:57:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVcUBr2dm3IcbAA--.56858S3; 
 Tue, 11 Jun 2024 09:57:23 +0800 (CST)
Subject: Re: [PULL 06/10] hw/loongarch: Refine fwcfg memory map
To: Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
References: <20240523014637.614872-1-gaosong@loongson.cn>
 <20240523014637.614872-7-gaosong@loongson.cn>
 <CAFEAcA8AONDHH=zMb6ODoE58=P4BN7+bBKJqzxQWU81STG8q4Q@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <147d5eda-d83a-60c2-5e16-6147918965ef@loongson.cn>
Date: Tue, 11 Jun 2024 09:57:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8AONDHH=zMb6ODoE58=P4BN7+bBKJqzxQWU81STG8q4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxVcUBr2dm3IcbAA--.56858S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr4UZF4UWrW7Cr4fWr4rJFc_yoW5uF4rpF
 4Sgana9F4DJFyDGr4xKa4UJFy7Zrn3Kr97XFWIkF1qkr1Dur1F9r4rG3s8KryDur1xAFy0
 vFWqyrZxZ3Z0grXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.287,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/6/7 下午10:31, Peter Maydell wrote:
> On Thu, 23 May 2024 at 02:48, Song Gao <gaosong@loongson.cn> wrote:
>>
>> From: Bibo Mao <maobibo@loongson.cn>
>>
>> Memory map table for fwcfg is used for UEFI BIOS, UEFI BIOS uses the first
>> entry from fwcfg memory map as the first memory HOB, the second memory HOB
>> will be used if the first memory HOB is used up.
>>
>> Memory map table for fwcfg does not care about numa node, however in
>> generic the first memory HOB is part of numa node0, so that runtime
>> memory of UEFI which is allocated from the first memory HOB is located
>> at numa node0.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20240515093927.3453674-4-maobibo@loongson.cn>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
> 
> Hi; Coverity points out a possible issue with this code
> (CID 1546441):
> 
>> +static void fw_cfg_add_memory(MachineState *ms)
>> +{
>> +    hwaddr base, size, ram_size, gap;
>> +    int nb_numa_nodes, nodes;
>> +    NodeInfo *numa_info;
>> +
>> +    ram_size = ms->ram_size;
>> +    base = VIRT_LOWMEM_BASE;
>> +    gap = VIRT_LOWMEM_SIZE;
>> +    nodes = nb_numa_nodes = ms->numa_state->num_nodes;
>> +    numa_info = ms->numa_state->nodes;
>> +    if (!nodes) {
>> +        nodes = 1;
>> +    }
>> +
>> +    /* add fw_cfg memory map of node0 */
>> +    if (nb_numa_nodes) {
>> +        size = numa_info[0].node_mem;
>> +    } else {
>> +        size = ram_size;
>> +    }
>> +
>> +    if (size >= gap) {
>> +        memmap_add_entry(base, gap, 1);
>> +        size -= gap;
>> +        base = VIRT_HIGHMEM_BASE;
>> +        gap = ram_size - VIRT_LOWMEM_SIZE;
> 
> In this if() statement we set 'gap'...
> 
>> +    }
>> +
>> +    if (size) {
>> +        memmap_add_entry(base, size, 1);
>> +        base += size;
>> +    }
>> +
>> +    if (nodes < 2) {
>> +        return;
>> +    }
>> +
>> +    /* add fw_cfg memory map of other nodes */
>> +    size = ram_size - numa_info[0].node_mem;
>> +    gap  = VIRT_LOWMEM_BASE + VIRT_LOWMEM_SIZE;
> 
> ...but then later here we unconditionally overwrite 'gap',
> without ever using it in between, making the previous
> assignment useless.
> 
> What was the intention here ?
It is abuse about variable gap, sometimes it represents low memory size,
sometimes it represents the end address of low memory.

It can be removed at both placed, what is this patch?

--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1054,7 +1054,6 @@ static void fw_cfg_add_memory(MachineState *ms)
          memmap_add_entry(base, gap, 1);
          size -= gap;
          base = VIRT_HIGHMEM_BASE;
-        gap = ram_size - VIRT_LOWMEM_SIZE;
      }

      if (size) {
@@ -1068,15 +1067,14 @@ static void fw_cfg_add_memory(MachineState *ms)

      /* add fw_cfg memory map of other nodes */
      size = ram_size - numa_info[0].node_mem;
-    gap  = VIRT_LOWMEM_BASE + VIRT_LOWMEM_SIZE;
-    if (base < gap && (base + size) > gap) {
+    if (numa_info[0].node_mem < gap && ram_size > gap) {
          /*
           * memory map for the maining nodes splited into two part
-         *   lowram:  [base, +(gap - base))
-         *   highram: [VIRT_HIGHMEM_BASE, +(size - (gap - base)))
+         * lowram:  [base, +(gap - numa_info[0].node_mem))
+         * highram: [VIRT_HIGHMEM_BASE, +(size - (gap - 
numa_info[0].node_mem)))
           */
-        memmap_add_entry(base, gap - base, 1);
-        size -= gap - base;
+        memmap_add_entry(base, gap - numa_info[0].node_mem, 1);
+        size -= gap - numa_info[0].node_mem;
          base = VIRT_HIGHMEM_BASE;
      }

Regards
Bibo Mao


> 
> thanks
> -- PMM
> 


