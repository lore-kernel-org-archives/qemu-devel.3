Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79FFC44503
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 02:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wheXm-0007zi-9Y; Wed, 08 Jul 2026 22:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wheXf-0007zF-6s
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:31:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wheXc-0007dp-Ma
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:31:10 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxGOvjB09qXLEBAA--.7311S3;
 Thu, 09 Jul 2026 10:31:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxPcXjB09qcV8GAA--.10744S2;
 Thu, 09 Jul 2026 10:30:59 +0800 (CST)
Subject: Re: [PATCH 2/2] MAINTAINERS: add LoongArch's maintainers
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: lixianglai@loongson.cn
References: <20260703095538.3211983-1-gaosong@loongson.cn>
 <20260703095538.3211983-3-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9d794d45-32a4-2d7d-747e-f7cd462b71e6@loongson.cn>
Date: Thu, 9 Jul 2026 10:30:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260703095538.3211983-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxPcXjB09qcV8GAA--.10744S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw43Cr1xCw47ur1fWw4DGFX_yoWDJwc_XF
 W2y395Jr4DJF1UG3yFvF93A3W3Ww48Aa15ua1qqrs5X343KrW5tryDt3ZruasIyrW29rnx
 ta9aqrnxCr1rZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/7/3 下午5:55, Song Gao wrote:
> Add xianglai and bibo as maintainers for the loongarch architecture
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef4c3b5c5b..fe3a3c2b57 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -281,6 +281,8 @@ F: tests/tcg/hppa/
>   
>   LoongArch TCG CPUs
>   M: Song Gao <17746591750@163.com>
> +M: Bibo Mao <maobibo@loongson.cn>
> +R: Xianglai Li <lixianglai@loongson.cn>
>   S: Maintained
>   F: target/loongarch/
>   F: tests/docker/dockerfiles/debian-loongarch-cross.docker
> @@ -1362,6 +1364,7 @@ LoongArch Machines
>   Virt
>   M: Song Gao <17746591750@163.com>
>   M: Bibo Mao <maobibo@loongson.cn>
> +R: Xianglai Li <lixianglai@loongson.cn>
>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   S: Maintained
>   F: docs/system/loongarch/virt.rst
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


