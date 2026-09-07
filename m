Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9FEC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3UgS-0000vF-RV; Mon, 07 Sep 2026 04:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3UgQ-0000uk-CW; Mon, 07 Sep 2026 04:26:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1x3UgN-0008Ax-Pq; Mon, 07 Sep 2026 04:26:30 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxUNErdZ5qymEJAA--.26993S3;
 Mon, 07 Sep 2026 16:26:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxf88qdZ5q_GgcAA--.61987S2;
 Mon, 07 Sep 2026 16:26:18 +0800 (CST)
Subject: Re: [PULL 0/3] loongarch queue
To: Michael Tokarev <mjt@tls.msk.ru>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Cc: QEMU Stable <qemu-stable@nongnu.org>
References: <20260827012811.1008381-1-gaosong@loongson.cn>
 <ea555c0f-1e4e-4bd0-8aad-a8c0b27b9c17@tls.msk.ru>
 <54dfc7c2-ef9c-695d-f481-dfe6bd7f5e85@loongson.cn>
 <f1a35d39-3746-4d64-b576-5d86df13f6ab@tls.msk.ru>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <13d48814-eca4-901f-6e03-dc8be7d0024b@loongson.cn>
Date: Mon, 7 Sep 2026 16:26:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f1a35d39-3746-4d64-b576-5d86df13f6ab@tls.msk.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxf88qdZ5q_GgcAA--.61987S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFykuryxAFyfJFWDKF47Jrc_yoWDJFb_Ww
 4UZ34ku3s7W3y8Ja1qvFy8Wwn7Jr1Dtas8t3W5Zr4Iga43Jr98JFy3Was3ZF92gFWqqrn8
 ZryqgF43u34UKosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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



On 2026/9/7 下午3:14, Michael Tokarev wrote:
> On 8/28/26 04:58, Bibo Mao wrote:
>> On 2026/8/28 上午1:25, Michael Tokarev wrote:
>>> On 8/27/26 04:28, Song Gao wrote:
>>>
>>>> Bibo Mao (3):
>>>>        hw/loongarch/boot: Check memory boundary in init_boot_rom()
>>>>        hw/loongarch/virt: Add bootargs and initrd to device-tree
>>>>        target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
>>>
>>> Is it qemu-stable material?
>>> (Currently active stable branches: 10.0, 11.0, 11.1).
>> I think it should be applied to qemu-stable, currently it can apply to 
>> 11.0 and later, there is big conflict on 10.0.
> 
> I'm sorry for not being explicit here.
> 
> My question was about this whole pull request, not about this
> particular change :)
> 
> Should I pick all 3 or just one (or two)? :)
I think that just the single patch3 need be applied to qemu-stable since 
there is Fixes tag.

Regards
Bibo Mao
> 
> Thanks,
> 
> /mjt


