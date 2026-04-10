Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D00E9905D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB8Iq-0000mv-AX; Fri, 10 Apr 2026 05:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wB8In-0000mh-Ur
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 05:37:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wB8Ik-00021S-VG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 05:37:25 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxFMG+xNhpg_IjAA--.52717S3;
 Fri, 10 Apr 2026 17:37:02 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxHMKsxNhpP0RqAA--.4348S3;
 Fri, 10 Apr 2026 17:36:52 +0800 (CST)
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, bibo mao <maobibo@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
Date: Fri, 10 Apr 2026 17:38:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxHMKsxNhpP0RqAA--.4348S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF48GrWkZF43Cw4DJry7urX_yoW8ury3pF
 WxCay2krW5JrW3Ca1DKFy7uFWYgrn3J345WrWjgr4Y9as0vry5tr40g3y5uFyDZayxCF4Y
 9r47C3sxWFWqyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xu
 ctUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.135,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

在 2026/4/9 下午8:14, Gyorgy Tamasi 写道:
> Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
>
> Additional independent testing (bug + fix cases) is documented here -
> see comments by sourav/@kishu279:
> https://gitlab.com/qemu-project/qemu/-/work_items/3371

Hi.
Please note that QEMU is not compatible with ABI 1.0.

If you absolutely must use ABI 1.0, the branch below is the version we use.
https://github.com/loongson/qemu/commits/9.2-tcg-old/
  
However, this branch is quite far from the mainline.
The QEMU mainline follows the kernel mainline, and
I believe this is the case for other architectures as well.

Thanks.
Song Gao
> On Wed, Apr 8, 2026 at 8:21 PM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
>>> In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
>>> TARGET_LOONGARCH64 are defined!) we can not use the struct
>>> target_stat64 for data-transfer, since this struct target_stat64 is
>>> defined for 32bit environments with its int-sized (4byte) st_*time
>>> sec/nsec components.
>>> The user side compiler headers of the LoongArch64 env uses long-sized
>>> (8byte) st_*time sec/nsec components.
>>>
>>> (This is similar to the case of 32bit vs. 64bit RISCV: the original
>>> code does not use struct target_stat64 in 64bit RISCV env, when both
>>> TARGET_RISCV and TARGET_RISCV64 are defined.)
>>>
>>> This fix is important for LoongArch64 ABI1.0, where stat() is using an
>>> fstatat syscall with this struct target_stat64, if its usage is
>>> enabled.
>>> (In case of LoongArch64 ABI2.0 stat() uses statx syscall, where this
>>> problematic struct target_stat64 is not used, struct statx is correct
>>> in the LoongArch64 env.)
>>> See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371
>>>
>>> Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
>>> ---
>>>    linux-user/syscall_defs.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


