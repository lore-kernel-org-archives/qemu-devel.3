Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674D3CD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 01:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snTaK-00066L-Jw; Sun, 08 Sep 2024 21:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1snTaH-00065l-Rv
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 21:52:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1snTaF-0007yA-GB
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 21:52:53 -0400
Received: from loongson.cn (unknown [10.20.42.17])
 by gateway (Coremail) with SMTP id _____8Bxb+vtVN5mTF8CAA--.6151S3;
 Mon, 09 Sep 2024 09:52:45 +0800 (CST)
Received: from [10.20.42.17] (unknown [10.20.42.17])
 by front1 (Coremail) with SMTP id qMiowMBxn+TsVN5m6QQCAA--.12330S3;
 Mon, 09 Sep 2024 09:52:45 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: virt: pass random seed to fdt
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de,
 xry111@xry111.site, maobibo@loongson.cn
References: <20240905153316.2038769-1-Jason@zx2c4.com>
 <73975d81-763b-fe04-5aa9-626a7767a3f0@loongson.cn>
 <CAHmME9q3CeJ0tPW3QbSEuvRFgQLpgFstEhif5qLGqbMi-R_Ehw@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <73c35a79-93ec-ccee-d942-6e51d24dea6a@loongson.cn>
Date: Mon, 9 Sep 2024 09:52:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHmME9q3CeJ0tPW3QbSEuvRFgQLpgFstEhif5qLGqbMi-R_Ehw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+TsVN5m6QQCAA--.12330S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW7AFy5Cr45ZFyfKF1Utwc_yoW8Wr4kpa
 4xGayYkF4kGr4xAwnrK340qr13Ka93Xr42qasIqry8Zr98X3Z3XFsFvrW7Wa4kArWfWr4U
 GF1SkrWavrWDJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07j1q2_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.046,
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



在 2024/9/9 上午9:41, Jason A. Donenfeld 写道:
> On Mon, Sep 9, 2024 at 3:38 AM gaosong <gaosong@loongson.cn> wrote:
>>
>>
>>
>> 在 2024/9/5 下午11:33, Jason A. Donenfeld 写道:
>>> If the FDT contains /chosen/rng-seed, then the Linux RNG will use it to
>>> initialize early. Set this using the usual guest random number
>>> generation function.
>>>
>>> This is the same procedure that's done in b91b6b5a2c ("hw/microblaze:
>>> pass random seed to fdt"), e4b4f0b71c ("hw/riscv: virt: pass random seed
>>> to fdt"), c6fe3e6b4c ("hw/openrisc: virt: pass random seed to fdt"),
>>> 67f7e426e5 ("hw/i386: pass RNG seed via setup_data entry"), c287941a4d
>>> ("hw/rx: pass random seed to fdt"), 5e19cc68fb ("hw/mips: boston: pass
>>> random seed to fdt"), 6b23a67916 ("hw/nios2: virt: pass random seed to fdt")
>>> c4b075318e ("hw/ppc: pass random seed to fdt"), and 5242876f37
>>> ("hw/arm/virt: dt: add rng-seed property").
>>>
>>> These earlier commits later were amended to rerandomize the RNG seed on
>>> snapshot load, but the LoongArch code somehow already does that, despite
>>> not having this patch here, presumably due to some lucky copy and
>>> pasting.
>>>
>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>> ---
>>>    hw/loongarch/virt.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
> 
> Do you generally queue these up in
> https://gitlab.com/gaosong/qemu/-/commits/loongarch-next/?ref_type=heads
> ? 

Yes, PRs are usually submitted on Thursdays.

Thanks
Song Gao


