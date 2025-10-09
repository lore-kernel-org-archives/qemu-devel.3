Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4183CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6l8C-0004zD-9Z; Thu, 09 Oct 2025 03:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v6l87-0004wr-Og
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:32:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v6l82-00025U-P3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:32:03 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axjr_YZOdoYzAUAA--.41529S3;
 Thu, 09 Oct 2025 15:31:36 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxpeTVZOdoiljWAA--.12803S3;
 Thu, 09 Oct 2025 15:31:36 +0800 (CST)
Subject: Re: [PATCH 0/3] LoongArch: Align VIRT_GED_CPUHP_ADDR
To: Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <git@xen0n.name>,
 qemu-devel@nongnu.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20250923143542.2391576-1-chenhuacai@kernel.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <95543947-349b-9cea-402f-2c85bc356d24@loongson.cn>
Date: Thu, 9 Oct 2025 15:31:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250923143542.2391576-1-chenhuacai@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxpeTVZOdoiljWAA--.12803S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gry7Aw1DWr4DCF4DAry7Jwc_yoWfGrb_XF
 y2vas5JFsrZ3W8A34FvayrAw1UWanrJFn5ur95WF1xuryxJrn8tr93Zayvvr17trs5Grsx
 tw48JFW3AryfAosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
 oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
 0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_
 Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
 xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
 CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU
 =
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.729, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

ÔÚ 2025/9/23 ÏÂÎç10:35, Huacai Chen Ð´µÀ:
> Align VIRT_GED_CPUHP_ADDR to 4 bytes to avoid ACPI errors during boot.
>
> Huacai Chen (3):
>   bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
>   hw/loongarch/virt: Align VIRT_GED_CPUHP_ADDR to 4 bytes
>   tests/data/acpi/loongarch64: Update expected DSDT.*
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   include/hw/loongarch/virt.h                    |   6 +++---
>   tests/data/acpi/loongarch64/virt/DSDT          | Bin 4603 -> 4603 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.memhp    | Bin 5824 -> 5824 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.numamem  | Bin 4609 -> 4609 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.topology | Bin 4905 -> 4905 bytes
>   5 files changed, 3 insertions(+), 3 deletions(-)
> --
> 2.7.0
Applied to loongarch-next


Thanks.
Song Gao


