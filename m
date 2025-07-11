Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AD1C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 01:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua2mw-0001yk-2x; Thu, 10 Jul 2025 21:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ua2mq-0001xi-IA
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 21:42:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ua2mn-00069z-IC
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 21:42:52 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxPuMTbHBoLNImAQ--.47267S3;
 Fri, 11 Jul 2025 09:42:43 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxQMIPbHBoHCcSAA--.32437S3;
 Fri, 11 Jul 2025 09:42:41 +0800 (CST)
Subject: Re: [PULL 0/4] loongarch-to-apply queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20250710093238.453962-1-maobibo@loongson.cn>
 <CAJSP0QXq=d5UC8vp01OB0guvaH+V5SX8PtZ5b1NT78CmGeo6UQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5582e09a-d139-167b-7302-9da6de740a97@loongson.cn>
Date: Fri, 11 Jul 2025 09:41:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXq=d5UC8vp01OB0guvaH+V5SX8PtZ5b1NT78CmGeo6UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxQMIPbHBoHCcSAA--.32437S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF18Cr45GrWDXFWUGry7CFX_yoW8KF4UpF
 WakF13KrWkGry7Jrs7ta4UZF1UKr4kGw4Iq3Wftry8Crn8Ary8Xr18J34SgFyUJa4UGw1j
 qr1UWw1DZF1UJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.606,
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



On 2025/7/10 下午8:43, Stefan Hajnoczi wrote:
> On Thu, Jul 10, 2025 at 5:34 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> The following changes since commit df6fe2abf2e990f767ce755d426bc439c7bba336:
>>
>>    Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging (2025-07-07 09:22:41 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250710
>>
>> for you to fetch changes up to 8ad757642e3a8a283edc29efec73b9bd57fdb365:
>>
>>    target/loongarch: Remove unnecessary page size validity checking (2025-07-10 16:30:25 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20250710 queue
>>
>> ----------------------------------------------------------------
>> Bibo Mao (4):
>>        hw/intc/loongarch_extioi: Move unrealize function to common code
>>        target/loongarch: Correct spelling in helper_csrwr_pwcl()
>>        target/loongarch: Fix CSR STLBPS register write emulation
>>        target/loongarch: Remove unnecessary page size validity checking
> 
> Please take a look at the following aarch64 macOS CI failure and
> resend your pull request when it has been fixed:
> 
> ../target/loongarch/tcg/tlb_helper.c:643:75: error: format specifies
> type 'long' but the argument has type 'target_ulong' (aka 'unsigned
> long long') [-Werror,-Wformat]
> 643 | qemu_log_mask(LOG_GUEST_ERROR, "Illegal huge pagesize %ld\n", ps);
> | ~~~ ^~
> | %llu
> /private/var/folders/7m/kxwv39y54d9g6lmkzwbqwk8r0000gn/T/cirrus-ci-build/include/qemu/log.h:57:30:
> note: expanded from macro 'qemu_log_mask'
> 57 | qemu_log(FMT, ## __VA_ARGS__); \
> | ~~~ ^~~~~~~~~~~
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/10637285043
Thanks for your reminder, will resend it after solving this issue.

Regards
Bibo Mao

> 
> Thanks,
> Stefan
> 
>>
>>   hw/intc/loongarch_extioi.c                |  9 ---------
>>   hw/intc/loongarch_extioi_common.c         |  9 +++++++++
>>   include/hw/intc/loongarch_extioi.h        |  1 -
>>   include/hw/intc/loongarch_extioi_common.h |  1 +
>>   target/loongarch/tcg/csr_helper.c         |  8 ++++++--
>>   target/loongarch/tcg/tlb_helper.c         | 24 ++++++++----------------
>>   6 files changed, 24 insertions(+), 28 deletions(-)
>>
>>


