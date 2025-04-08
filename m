Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F082EC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u234O-0001mg-1F; Tue, 08 Apr 2025 03:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u234K-0001l8-UT
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:08:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u234F-0008Cm-Rm
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:08:23 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx12ldy_RnYvi0AA--.38571S3;
 Tue, 08 Apr 2025 15:08:13 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMDxvhtby_RnrFZ0AA--.33453S3;
 Tue, 08 Apr 2025 15:08:13 +0800 (CST)
Subject: Re: [PATCH v7 0/2] hw/loongarch/virt: Replace destination error with
 error_abort
To: Bibo Mao <maobibo@loongson.cn>, Markus Armbruster <armbru@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250324030145.3037408-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <87e839f5-3e01-2af1-4b45-37936af8a02e@loongson.cn>
Date: Tue, 8 Apr 2025 15:10:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324030145.3037408-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMDxvhtby_RnrFZ0AA--.33453S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryfZw4UWF48Jr45tw4UZFc_yoW8tw1Dpr
 9xC3ZIkFykAryru3yvyrykJa4ayrZ7tF1FqwnI93yfGr4Ykr1vyrW7J3Wv9FWUu39Yqw18
 Xr48GF95XFn8Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.664,
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

hi, Markus,  I had pick up this series for my 'loongarch bug fix for 
10.0. 'branch

thanks.
Song Gao
在 2025/3/24 上午11:01, Bibo Mao 写道:
> In function virt_cpu_plug() and virt_cpu_unplug(), the error is
> impossile. Destination error is not propagated and replaced with
> error_abort. With this, the logic is simple.
>
> Also there is bugfix in function virt_cpu_plug(), Object cpuslot::cpu is
> set at last only when there is no any error.
>
> ---
>    v6 ... v7:
>      1. Replace dest error from parameter errp with error_abort since the
>         error is impossible.
>      2. Some patches are merged, refresh the pending two patches.
>
>    v5 ... v6:
>      1. If there is nested error report when restore from error in function
>         virt_cpu_plug(), set output Error object with &error_abort rather
>         than NULL, since it is almost impossible now.
>      2. If there is nested error report when restore from error in function
>         virt_cpu_unplug(), set output Error object with &error_abort rather
>         than NULL, since it is almost impossible now.
>
>    v4 ... v5:
>      1. Split patch2 in v4 into three small patches, two are fixup for error
>         handing when cpu plug/unplug fails so that system can continue to
>         run, one is to remove error_propagate() and refresh title.
>      2. Refresh changelog in last patch and remove fixes information
>         since it is impossible to happen.
>
>    v3 ... v4:
>      1. Add missed this cleanup with error and remove some local error
>         object.
>      2. Replace local error object with error_abort object in
>         virt_cpu_irq_init(), since its return value is not checked.
>
>    v2 ... v3:
>      1. Add missing modification replacing error_propagate() + error_setg()
>        with error_setg().
>      2. Some enhancement about error handling, handling error
>         symmetrically in many places
>
>    v1 ... v2:
>      1. Add fixes tag and change title with fix prefix in patch 1.
>      2. Replace error_propagate() with error_setg(), and return directly
>         for any error.
> ---
> Bibo Mao (2):
>    hw/loongarch/virt: Fix cpuslot::cpu set at last in virt_cpu_plug()
>    hw/loongarch/virt: Replace destination error with error_abort
>
>   hw/loongarch/virt.c | 43 +++++++++----------------------------------
>   1 file changed, 9 insertions(+), 34 deletions(-)
>
>
> base-commit: 71119ed3651622e1c531d1294839e9f3341adaf5


