Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9FAC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 01:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdKQC-0004YN-0l; Thu, 22 Feb 2024 20:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rdKQ6-0004Xo-IB
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 20:32:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rdKQ2-0000Wm-BI
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 20:32:09 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxSPCK9ddlp30QAA--.43441S3;
 Fri, 23 Feb 2024 09:31:54 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx_c6J9ddlSGI_AA--.34487S3; 
 Fri, 23 Feb 2024 09:31:53 +0800 (CST)
Subject: Re: [PULL 0/1] loongarch-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240221091154.3024118-1-gaosong@loongson.cn>
 <CAFEAcA8zR0dKQYbVNTbF8cwwvKUt+eJc7v3mSm58cMissO6GZg@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <743d1249-f29e-5f31-363f-d6cc857a879a@loongson.cn>
Date: Fri, 23 Feb 2024 09:31:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8zR0dKQYbVNTbF8cwwvKUt+eJc7v3mSm58cMissO6GZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx_c6J9ddlSGI_AA--.34487S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1DAF4fKF1kCFWDGryDArc_yoW5Xr1DpF
 W3AF9rCrWrXry7Grs7t3s3J3WDGr9rJ34jq3W7Zry0yrnI9a4qvr48GryruFWUZ348JF10
 gr98Gr1UXa1UA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.172,
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

在 2024/2/22 下午8:42, Peter Maydell 写道:
> On Wed, 21 Feb 2024 at 09:11, Song Gao <gaosong@loongson.cn> wrote:
>> The following changes since commit 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0:
>>
>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-02-20 10:11:08 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240221
>>
>> for you to fetch changes up to be57fd1e526e70fd55f1e87b0b70fab3c6baf089:
>>
>>    loongarch: Change the UEFI loading mode to loongarch (2024-02-21 17:06:23 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20240221
>>
>> ----------------------------------------------------------------
>> Xianglai Li (1):
>>        loongarch: Change the UEFI loading mode to loongarch
> Hi; this fails to build for mipsel:
> https://gitlab.com/qemu-project/qemu/-/jobs/6232698129
>
> ../hw/loongarch/acpi-build.c: In function ‘build_flash_aml’:
> ../hw/loongarch/acpi-build.c:327:19: error: incompatible types when
> assigning to type ‘hwaddr’ {aka ‘long long unsigned int’} from type
> ‘Int128’
> 327 | flash0_size = flash_mem->size;
> | ^~~~~~~~~
> ../hw/loongarch/acpi-build.c:331:19: error: incompatible types when
> assigning to type ‘hwaddr’ {aka ‘long long unsigned int’} from type
> ‘Int128’
> 331 | flash1_size = flash_mem->size;
> | ^~~~~~~~~
>
>
> ../hw/loongarch/virt.c: In function ‘fdt_add_flash_node’:
> ../hw/loongarch/virt.c:131:19: error: incompatible types when
> assigning to type ‘hwaddr’ {aka ‘long long unsigned int’} from type
> ‘Int128’
> 131 | flash0_size = flash_mem->size;
> | ^~~~~~~~~
> ../hw/loongarch/virt.c:135:19: error: incompatible types when
> assigning to type ‘hwaddr’ {aka ‘long long unsigned int’} from type
> ‘Int128’
> 135 | flash1_size = flash_mem->size;
> | ^~~~~~~~~
>
>
> The value you get back from pflash_cfi01_get_memory() is a
> MemoryRegion -- this should be an opaque struct to you, not
> something you can reach in and get the 'size' field from.
> (The 'size' field is an Int128, which is not necessarily an
> integer type known to the compiler -- on some platforms it is
> a struct -- which is why this doesn't compile here.)
>
> Your board code created these memory regions so typically it
> should already know how big they are.  If you really
> do need to get the size of a MemoryRegion, the function
> to use is memory_region_size(
Got it ,  I will correct it.

Thanks.
Song Gao
> thanks
> -- PMM


