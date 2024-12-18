Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C5BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 08:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNpqy-0002yU-2o; Wed, 18 Dec 2024 03:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tNpqw-0002y7-08
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 03:56:22 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tNpqs-0006iR-MF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 03:56:21 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxMK8njmJnXhhYAA--.17247S3;
 Wed, 18 Dec 2024 16:56:07 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxYMYijmJn7_4AAA--.6995S3;
 Wed, 18 Dec 2024 16:56:05 +0800 (CST)
Subject: Re: [PULL 00/18] loongarch-to-apply queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>
References: <20241216015607.1795880-1-maobibo@loongson.cn>
 <CAJSP0QV84ssXWHQrrWQrpwZS7Ko90eRnR46WS+jvNn5_3Zss=Q@mail.gmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <0c492742-7451-6aa2-1a8b-3e80435e85a5@loongson.cn>
Date: Wed, 18 Dec 2024 16:55:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV84ssXWHQrrWQrpwZS7Ko90eRnR46WS+jvNn5_3Zss=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxYMYijmJn7_4AAA--.6995S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr48ZF1DAFyUuw48Kw1DXFc_yoWrtw4xpr
 W3Cr1a9r4UJr17Xwn3tw1UXFy5Ars7Wry2qFy3KFyxCrsxAr1rWw18Xw1FqFyUW34rGr1q
 qr15Gws8W3WDCwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.107,
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



On 2024/12/17 上午3:19, Stefan Hajnoczi wrote:
> On Sun, 15 Dec 2024 at 20:56, Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> The following changes since commit ca80a5d026a280762e0772615f1988db542b3ade:
>>
>>    Merge tag 'hw-misc-20241214' of https://github.com/philmd/qemu into staging (2024-12-14 08:42:53 -0500)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20241216
>>
>> for you to fetch changes up to efada537c6c49e414ae87ce66803d6d8543ad140:
>>
>>    hw/intc/loongarch_extioi: Code cleanup about loongarch_extioi (2024-12-16 09:05:14 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20241216
>>    v1 .. v2: Push patch again since forgot to push to upstream
> 
> Please take a look at following qtest failure from the
> x64-freebsd-14-build CI job:
> 
> 8/730 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/qom-test ERROR
> 0.84s killed by signal 6 SIGABRT
> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
> stderr:
> Broken pipe
> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from
> signal 11 (Segmentation fault) (core dumped)
> (test program exited with status code -6)
> TAP parsing error: Too few tests run (expected 2, got 0)
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8656122662/viewer
> 
> You can reproduce the FreeBSD 14 environment using `make
> vm-build-freebsd`. See `make vm-help` for more options.
> 
> Here is the merge tag where this happened. It probably also happens on
> your pull request tag:
> https://gitlab.com/qemu-project/qemu/-/commit/466535ecb37d28ef79aecc4550b7cd1160c6beac
> 
> If you find that there was an issue with the commits in your pull
> request, please send a new pull request revision. If you find that the
> issue was not caused by a commit in your pull request, please reply
> here so we can discuss how to solve it.
Sorry, there is problem on FreeBSD and it can be reproduced on my 
FreeBSD VM. Will fresh the patch.

Regards
Bibo Mao
> 
> Thanks,
> Stefan
> 
>>
>> ----------------------------------------------------------------
>> Bibo Mao (18):
>>        include: Add loongarch_pic_common header file
>>        include: Move struct LoongArchPCHPIC to loongarch_pic_common header file
>>        hw/intc/loongarch_pch: Merge instance_init() into realize()
>>        hw/intc/loongarch_pch: Rename LoongArchPCHPIC with LoongArchPICCommonState
>>        hw/intc/loongarch_pch: Move some functions to file loongarch_pic_common
>>        hw/intc/loongarch_pch: Inherit from loongarch_pic_common
>>        hw/intc/loongarch_pch: Add pre_save and post_load interfaces
>>        hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic
>>        include: Add loongarch_extioi_common header file
>>        include: Move struct LoongArchExtIOI to header file loongarch_extioi_common
>>        include: Rename LoongArchExtIOI with LoongArchExtIOICommonState
>>        hw/intc/loongarch_extioi: Rename LoongArchExtIOI with LoongArchExtIOICommonState
>>        hw/intc/loongarch_extioi: Add common realize interface
>>        hw/intc/loongarch_extioi: Add unrealize interface
>>        hw/intc/loongarch_extioi: Add common file loongarch_extioi_common
>>        hw/intc/loongarch_extioi: Inherit from loongarch_extioi_common
>>        hw/intc/loongarch_extioi: Add pre_save interface
>>        hw/intc/loongarch_extioi: Code cleanup about loongarch_extioi
>>
>>   hw/intc/loongarch_extioi.c                | 110 +++++++++--------------------
>>   hw/intc/loongarch_extioi_common.c         | 113 ++++++++++++++++++++++++++++++
>>   hw/intc/loongarch_pch_pic.c               | 106 +++++++++-------------------
>>   hw/intc/loongarch_pic_common.c            |  97 +++++++++++++++++++++++++
>>   hw/intc/meson.build                       |   4 +-
>>   hw/loongarch/virt.c                       |   2 +-
>>   include/hw/intc/loongarch_extioi.h        |  84 +++-------------------
>>   include/hw/intc/loongarch_extioi_common.h |  98 ++++++++++++++++++++++++++
>>   include/hw/intc/loongarch_pch_pic.h       |  70 ++++--------------
>>   include/hw/intc/loongarch_pic_common.h    |  82 ++++++++++++++++++++++
>>   10 files changed, 488 insertions(+), 278 deletions(-)
>>   create mode 100644 hw/intc/loongarch_extioi_common.c
>>   create mode 100644 hw/intc/loongarch_pic_common.c
>>   create mode 100644 include/hw/intc/loongarch_extioi_common.h
>>   create mode 100644 include/hw/intc/loongarch_pic_common.h
>>


