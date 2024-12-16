Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0894DE7716A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 00:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMzRN-0007bc-TG; Sun, 15 Dec 2024 19:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tMzRM-0007ZJ-2Y
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:58:28 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tMzRI-0008N3-Vx
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:58:27 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dx_64je19nGDlXAA--.257S3;
 Mon, 16 Dec 2024 08:58:11 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxpsAge19n6MOEAA--.14728S3;
 Mon, 16 Dec 2024 08:58:08 +0800 (CST)
Subject: Re: [PULL 00/18] loongarch-to-apply queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
References: <20241213094027.1732484-1-maobibo@loongson.cn>
 <CAJSP0QWwaqbA26mDEM+-y0-rGicFgrSDH0n+EAN8d9LTWsbm0w@mail.gmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <101115df-8c1e-6728-645c-d43650faa05c@loongson.cn>
Date: Mon, 16 Dec 2024 08:57:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWwaqbA26mDEM+-y0-rGicFgrSDH0n+EAN8d9LTWsbm0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxpsAge19n6MOEAA--.14728S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyUZrW3uFWkCFykZFWxXwc_yoW8tr17pr
 W3uF1akr4DJr17Xrn3tw1UWFs5Jrn7Wry2vF13KryxCrsxAr1rXr18JryfuFyUG3yUGr1j
 qF1rtr1UW3WUJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
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
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.641,
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



On 2024/12/14 下午9:39, Stefan Hajnoczi wrote:
> On Fri, 13 Dec 2024 at 04:42, Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> The following changes since commit a5ba0a7e4e150d1350a041f0d0ef9ca6c8d7c307:
>>
>>    Merge tag 'pull-aspeed-20241211' of https://github.com/legoater/qemu into staging (2024-12-11 15:16:47 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/bibo-mao/qemu.git pull-loongarch-20241213
> 
> This tag is not in the repository. Did you forget to push it?
Sorry for that.
Yes, I forget to push it :(, will submit the second version.

Regards
Bibo Mao
> 
> Thanks,
> Stefan
> 
>>
>> for you to fetch changes up to 78aa256571aa06f32001bd80635a1858187c609b:
>>
>>    hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic (2024-12-13 14:39:39 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20241213
>>
>> ----------------------------------------------------------------
>> Bibo Mao (8):
>>        include: Add loongarch_pic_common header file
>>        include: Move struct LoongArchPCHPIC to loongarch_pic_common header file
>>        hw/intc/loongarch_pch: Merge instance_init() into realize()
>>        hw/intc/loongarch_pch: Rename LoongArchPCHPIC with LoongArchPICCommonState
>>        hw/intc/loongarch_pch: Move some functions to file loongarch_pic_common
>>        hw/intc/loongarch_pch: Inherit from loongarch_pic_common
>>        hw/intc/loongarch_pch: Add pre_save and post_load interfaces
>>        hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic
>>
>>   hw/intc/loongarch_pch_pic.c            | 106 +++++++++++----------------------
>>   hw/intc/loongarch_pic_common.c         |  97 ++++++++++++++++++++++++++++++
>>   hw/intc/meson.build                    |   2 +-
>>   hw/loongarch/virt.c                    |   2 +-
>>   include/hw/intc/loongarch_pch_pic.h    |  70 +++++-----------------
>>   include/hw/intc/loongarch_pic_common.h |  82 +++++++++++++++++++++++++
>>   6 files changed, 230 insertions(+), 129 deletions(-)
>>   create mode 100644 hw/intc/loongarch_pic_common.c
>>   create mode 100644 include/hw/intc/loongarch_pic_common.h
>>
>>


