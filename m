Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE79EE6424
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 10:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vat4O-0000Tw-3Z; Wed, 31 Dec 2025 05:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vat3y-0000OG-Ji
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:04:24 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vat3v-0006eP-SI
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:04:17 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxMvEa9VRpuqIEAA--.14844S3;
 Wed, 31 Dec 2025 18:04:10 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCx2+AY9VRpF9AHAA--.20010S3;
 Wed, 31 Dec 2025 18:04:10 +0800 (CST)
Subject: Re: [PATCH v2 0/3] target/loongarch: PMU enhancement in KVM mode
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20251030081724.3921563-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ab5feab2-d31d-b450-8aee-3f6e94b6b3e3@loongson.cn>
Date: Wed, 31 Dec 2025 18:04:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251030081724.3921563-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCx2+AY9VRpF9AHAA--.20010S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar4xXFyDGFWUXr47Ary8CrX_yoW8JF43pa
 yxu3WrGFWrJrZrJrn3J3W5Wwn8ZF1fGr42vayaqry8J398XrySqr1ktas0qFy5Jw17CFyI
 qF1Fkw15uF45AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.628,
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

在 2025/10/30 下午4:17, Bibo Mao 写道:
> This patchset add PMU migration support and CSR register dump support
> with debug purpose, also it removes TLB migration support in TCG mode.
>
> ---
> v1 ... v2:
>    1. Move calling with function loongarch_la464_init_csr() after CPU is
>       realized, since PMU feature is decided during realization stage.
>    2. Split origin patch #2 for better review
>    3. Add PMU event number info in structure CPUArchState rather than
>       fixed number 4, save and restore PMU registers by its event number.
> ---
> Bibo Mao (3):
>    target/loongarch: Add PMU migration support in KVM mode
>    target/loongarch: Call function loongarch_la464_init_csr() after
>      realized
>    target/loongarch: Add PMU register dump support in KVM
>
>   target/loongarch/cpu-csr.h |  4 +++
>   target/loongarch/cpu.c     | 11 +++++---
>   target/loongarch/cpu.h     |  4 +++
>   target/loongarch/csr.c     | 32 ++++++++++++++++++++++
>   target/loongarch/kvm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++-
>   target/loongarch/machine.c | 21 +++++++++++++++
>   6 files changed, 122 insertions(+), 4 deletions(-)
>
>
> base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c

For thie series
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


