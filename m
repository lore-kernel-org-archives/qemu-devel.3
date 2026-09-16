Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D368C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6k1O-0000mv-2H; Wed, 16 Sep 2026 03:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1x6k1M-0000mX-SC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:25:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1x6k1L-0002UB-2Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:25:32 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8Cx+9FoRKpqS4cMAA--.36758S3;
 Wed, 16 Sep 2026 15:25:28 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJDxBc1lRKpqJFUhAA--.44042S2;
 Wed, 16 Sep 2026 15:25:25 +0800 (CST)
Subject: Re: [PATCH v2 2/3] target/loongarch: Rename filename constant_timer.c
 with timer.c
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org
References: <20260910074613.3486127-1-maobibo@loongson.cn>
 <20260910074613.3486127-3-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <0f479aa7-aaf7-7e58-8076-65db2c2b938e@loongson.cn>
Date: Wed, 16 Sep 2026 15:23:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260910074613.3486127-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxBc1lRKpqJFUhAA--.44042S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF17uF43Xw1fKw4rtFy5GFX_yoWDKrc_WF
 4xJF1kCrsrW3WIq3yYyrykJrs8Jr10kFnIyFWDWF4xGas0ga1Fkr4qg3WkCFyYvw4rZFs8
 Aa93tryruF1YyosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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


> For simplity rename filename constant_timer.c with timer.c on LoongArch.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/meson.build                   | 2 +-
>   target/loongarch/tcg/{constant_timer.c => timer.c} | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename target/loongarch/tcg/{constant_timer.c => timer.c} (100%)
>
> diff --git a/target/loongarch/tcg/meson.build b/target/loongarch/tcg/meson.build
> index b7adfe46f1..0b013875cc 100644
> --- a/target/loongarch/tcg/meson.build
> +++ b/target/loongarch/tcg/meson.build
> @@ -13,7 +13,7 @@ loongarch_ss.add(files(
>   ))
>   
>   loongarch_system_ss.add(files(
> -  'constant_timer.c',
> +  'timer.c',
>     'csr_helper.c',
>     'iocsr_helper.c',
>     'tlb_helper.c',
> diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/timer.c
> similarity index 100%
> rename from target/loongarch/tcg/constant_timer.c
> rename to target/loongarch/tcg/timer.c
  Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>


