Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918AFC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmu8Y-0001CL-3s; Tue, 25 Feb 2025 07:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmu8I-0001A9-QO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:33:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmu8E-0002PF-RO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:33:53 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxC3KouL1nzRuCAA--.26826S3;
 Tue, 25 Feb 2025 20:33:44 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxHcWluL1nKe4nAA--.15111S3;
 Tue, 25 Feb 2025 20:33:43 +0800 (CST)
Subject: Re: [PATCH v2 0/9] target/loongarch: LoongArch32 fixes 1
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
 <3fd27fd1-b976-2705-7093-aecc6ffa0438@loongson.cn>
 <23d25d66-07f4-454b-903a-f5704e1e686c@app.fastmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <baa9614a-a216-58bb-3bce-d56da0c7f287@loongson.cn>
Date: Tue, 25 Feb 2025 20:33:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <23d25d66-07f4-454b-903a-f5704e1e686c@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHcWluL1nKe4nAA--.15111S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Wr1DWF17ZF4DZFyxKw4UGFX_yoWDKFc_ur
 42vay8CryDJFsrCwsY9FsYyr9xta18tFyDt395Xr1xJasxJrs8Wwn5tryxXasaqFZxZrsx
 Wr9Fyr1FyryxuosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
 oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
 0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_
 Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
 xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
 Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
 AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
 cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
 IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
 Ja73UjIFyTuYvjxU2DUUUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.498,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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



On 2025/2/25 下午8:08, Jiaxun Yang wrote:
> 
> 
> 在2025年2月25日二月 上午8:50，bibo mao写道：
>> On 2025/2/25 上午8:40, Jiaxun Yang wrote:
>>> Hi all,
>>>
>>> This series is a collection of small fixes I made to TCG for
>>> LoongArch32.
>>>
>>> There are still many thing broken, especially on CSRs. More
>>> series following. However this is sufficient to boot 32bit
>>> kernel.
>> Is there any product introduction about LoongArch32 board? such as MMU
>> type, memory type(DDR or SRAM), interrupt controller type.
> 
> Sure, for LoongArch32 the most accessible board at the moment is chiplap FPGA [1].
> 
> There are also some ASIC designs (BaiXing Project) based on chiplab.
> 
> Long in short:
> 
> - MMU: PG style
> - Mmeory: DDR
> - Interrupt controller: custom (Loongson-1C like) connected to CPU's
>                          int pin.
Thanks for the information, Would you like to emulate LoongArch32 
chiplap FPGA board in qemu side or other LoongArch32 boards?

Regards
Bibo Mao
> 
> Thanks
> 
> [1]: https://gitee.com/loongson-edu/chiplab
> 
>>
>> Regards
>> Bibo Mao
>>>
> 
> 


