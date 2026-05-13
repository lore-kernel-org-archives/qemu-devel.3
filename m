Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ABACD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 01:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMy6a-0000I9-R1; Tue, 12 May 2026 21:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wMy6Y-0000Ha-J5
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:09:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wMy6V-00005o-Vg
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:09:42 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx3sBNzwNq4VYJAA--.4808S3;
 Wed, 13 May 2026 09:09:33 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxacFJzwNq1bOAAA--.34041S3;
 Wed, 13 May 2026 09:09:32 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch/kvm: Include missing exec/cpu-defs.h
 header
To: Qiang Ma <maqianga@uniontech.com>
Cc: maobibo@loongson.cn, philmd@linaro.org, qemu-devel@nongnu.org
References: <20260512131107.2388663-1-maqianga@uniontech.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <24783c35-9a09-2f45-3ddf-0c743c13752a@loongson.cn>
Date: Wed, 13 May 2026 09:11:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260512131107.2388663-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxacFJzwNq1bOAAA--.34041S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZryUGFy3Jr1UJF17JF4rCrX_yoWDWFX_Ca
 47Aw1kW3yUW3Wvyw42vFZxAwn8tr18GFs0vFW3Xr4xK3Z8Jrs8Zwsrt3Z8ZFWj9rWqqr45
 Zrs7JanIkw1YgosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2nYFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.97, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ÔÚ 2026/5/12 ÏÂÎç9:11, Qiang Ma Ð´µÀ:
> After commit 71cab1a42d2 removed the indirect include of
> exec/cpu-defs.h from target/loongarch/cpu.h, the TARGET_FMT_lx
> macro is no longer visible in kvm.c, causing build failures:
>
>    error: expected ')' before TARGET_FMT_lx
>
> Add the missing #include exec/cpu-defs.h to restore the
> TARGET_FMT_lx definition.
Hi,
The commit message does not match the changes.
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>   target/loongarch/kvm/kvm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 9d844c4905..4af4ab2ed0 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "exec/target_long.h"
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   #include <sys/ioctl.h>
>   #include <linux/kvm.h>
>   #include "asm-loongarch/kvm_para.h"


