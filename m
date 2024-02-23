Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A72C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdMSJ-0000Vp-Px; Thu, 22 Feb 2024 22:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rdMSH-0000VZ-6V
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:42:33 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rdMSE-0007ml-AD
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:42:32 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxF+ggFNhlf4cQAA--.22816S3;
 Fri, 23 Feb 2024 11:42:24 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx_c4cFNhlbHQ_AA--.34684S3; 
 Fri, 23 Feb 2024 11:42:22 +0800 (CST)
Subject: Re: [PATCH 1/3] linux-user/loongarch64: Remove TARGET_FORCE_SHMLBA
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, iii@linux.ibm.com, richard.purdie@linuxfoundation.org, 
 mjt@tls.msk.ru
References: <20240223030309.458451-1-richard.henderson@linaro.org>
 <20240223030309.458451-2-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <4eb92926-763c-3260-f2a9-d32bd9e196e4@loongson.cn>
Date: Fri, 23 Feb 2024 11:42:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240223030309.458451-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx_c4cFNhlbHQ_AA--.34684S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw1rWw4DZr4rWw48Xw4fJFc_yoWkuFgEga
 yIyw1DKr4kWF1IvanYqry5ZF15tF45AF42va1vgrW2g3W2q395J348u3yUZF1a9FW8Zrs8
 A3yvqF4fuw13ZosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.172,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

在 2024/2/23 上午11:03, Richard Henderson 写道:
> The upstream linux kernel does not define __ARCH_FORCE_SHMLBA.
>
> Cc: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
>
> Did this definition come from the port before it was merged upstream?
Yes,

The patch [1]  dropped it .
     [1] 
https://patchew.org/linux/20240106145501.3370364-1-chenhuacai@loongson.cn/


Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> Or was it incorrectly copied from MIPS?
> ---
>   linux-user/loongarch64/target_syscall.h | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/linux-user/loongarch64/target_syscall.h b/linux-user/loongarch64/target_syscall.h
> index 8b5de52124..39f229bb9c 100644
> --- a/linux-user/loongarch64/target_syscall.h
> +++ b/linux-user/loongarch64/target_syscall.h
> @@ -38,11 +38,4 @@ struct target_pt_regs {
>   #define TARGET_MCL_FUTURE  2
>   #define TARGET_MCL_ONFAULT 4
>   
> -#define TARGET_FORCE_SHMLBA
> -
> -static inline abi_ulong target_shmlba(CPULoongArchState *env)
> -{
> -    return 64 * KiB;
> -}
> -
>   #endif


