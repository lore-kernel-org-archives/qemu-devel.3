Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8938C61CE8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 02:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOp24-0000g5-KT; Mon, 09 Jun 2025 22:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOp23-0000fm-Bv
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 22:48:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOp21-0000c1-Ic
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 22:48:11 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxGHHmnEdoPkASAQ--.47868S3;
 Tue, 10 Jun 2025 10:48:06 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxXsXlnEdowqETAQ--.60667S3;
 Tue, 10 Jun 2025 10:48:05 +0800 (CST)
Subject: Re: [PATCH 0/2] hw/loongarch/virt: Small enhancement about big endian
 host
To: Alireza Sanaee <alireza.sanaee@huawei.com>, Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20250604065502.1114098-1-maobibo@loongson.cn>
 <20250604100547.00000739.alireza.sanaee@huawei.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3b5021da-be7c-9963-7487-b850b006ea7f@loongson.cn>
Date: Tue, 10 Jun 2025 10:50:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250604100547.00000739.alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxXsXlnEdowqETAQ--.60667S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jry3ZrWrXr1Utw4xAFyrAFc_yoWfGrb_WF
 12yr97C34UXanrZF40gFn8A3ZrXa1rXFn3Ar9FqrW8C345AFWkGr4xuwn3Z3WktrsYgrn5
 Wa1kArn8uw1xXosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.915,
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

在 2025/6/4 下午5:05, Alireza Sanaee 写道:
> On Wed, 4 Jun 2025 14:55:00 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
>
>> On big endian host machine such as S390, bios-table-test fails to run.
>> And also linux kernel fails to boot.
>>
>> This patches solves these two issues.
>>
>> Bibo Mao (2):
>>    hw/loongarch/virt: Fix big endian support with MCFG table
>>    hw/intc/loongarch_pch: Convert to little endian with ID register
Reviewed-by: Song Gao <gaosong@loongson.cn>

Applied to  loongarch. next

thanks.
Song Gao

>>   hw/intc/loongarch_pch_pic.c    | 2 +-
>>   hw/loongarch/virt-acpi-build.c | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>>
>> base-commit: 6322b753f798337835e205b6d805356bea582c86
> Hi Bao,
>
> Thanks for the fix.
>
> In that case, I will put a DEPEND-ON tag and resend my patchset.
>
> Alireza


