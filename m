Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026F4C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 01:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7m3Z-00064M-4Z; Thu, 16 May 2024 21:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s7m3W-00064B-Vp
 for qemu-devel@nongnu.org; Thu, 16 May 2024 21:06:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s7m3T-0000to-Sd
 for qemu-devel@nongnu.org; Thu, 16 May 2024 21:06:42 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bxc+qXrUZmmr4NAA--.20763S3;
 Fri, 17 May 2024 09:06:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx57mVrUZmm7MjAA--.3982S3; 
 Fri, 17 May 2024 09:06:31 +0800 (CST)
Subject: Re: [PULL 0/5] loongarch-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
References: <20240516091120.1021435-1-gaosong@loongson.cn>
 <CAFEAcA_UHCYEbpk+V4qS7NpPP_-2kL2XEHM9M_SywfkPZrpsjA@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <03218f2d-9285-9f15-9835-8f317d3694b2@loongson.cn>
Date: Fri, 17 May 2024 09:06:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_UHCYEbpk+V4qS7NpPP_-2kL2XEHM9M_SywfkPZrpsjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx57mVrUZmm7MjAA--.3982S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Jr1DXw1xGw13ZFy5tw17twc_yoW8JrW7pr
 Wak3Z7Gr1kJF17JrsrJ34jqr1Utrn7Gr1xXFn8Xry8CF4DZr15Xr18Jr1rury7A34xCr10
 qr18J3WDXF1DJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.033,
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

在 2024/5/16 下午5:28, Peter Maydell 写道:
> On Thu, 16 May 2024 at 10:12, Song Gao <gaosong@loongson.cn> wrote:
>> The following changes since commit 922582ace2df59572a671f5c0c5c6c5c706995e5:
>>
>>    Merge tag 'pull-hppa-20240515' of https://gitlab.com/rth7680/qemu into staging (2024-05-15 11:46:58 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240516
>>
>> for you to fetch changes up to d55d16700a2e2b36c7e34724d4d77f4a75c5243a:
>>
>>    target/loongarch/kvm: fpu save the vreg registers high 192bit (2024-05-16 16:32:35 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20240516
>>
>> ----------------------------------------------------------------
>> Bibo Mao (3):
>>        hw/loongarch: Add compat machine for 9.1
>>        hw/loongarch: Remove minimum and default memory size
>>        tests: Add migration test for loongarch64
> RTH: I had a comment about adding the versioned machine type, so we
> should hold off on applying this until that is resolved, I think.
Agreed,   We will try resolved it.   Thanks for your explanation.

Thanks.
Song Gao
> thanks
> -- PMM


