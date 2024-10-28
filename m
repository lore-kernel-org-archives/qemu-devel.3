Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB446D13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 07:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5KL6-0005I4-S2; Mon, 28 Oct 2024 03:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t5KL4-0005HY-9J
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 03:38:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t5KL1-00052E-Mc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 03:38:58 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxmeGBPx9n6W4YAA--.51501S3;
 Mon, 28 Oct 2024 15:38:42 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxnsJ9Px9np9MhAA--.49621S3;
 Mon, 28 Oct 2024 15:38:39 +0800 (CST)
Subject: Re: [PATCH v3 1/3] linux-headers: Add unistd_64.h
To: Bibo Mao <maobibo@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241028023809.1554405-1-maobibo@loongson.cn>
 <20241028023809.1554405-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b5f4a39a-278a-1918-29f2-b9da197ce055@loongson.cn>
Date: Mon, 28 Oct 2024 15:39:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241028023809.1554405-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxnsJ9Px9np9MhAA--.49621S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWDWrW7WFWUJF1fWFW8Xwc_yoW8Ww1kpa
 sF9rn5Gr98Gas3tw1qk3W29r4DtFs8CFnFgFyUGFyvy3s0yr1Iq397Gr1q9rsrtay5Aay0
 9F4fCw1DCas3ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.811,
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

在 2024/10/28 上午10:38, Bibo Mao 写道:
> since 6.11, unistd.h includes header file unistd_64.h directly on
> some platforms, here add unistd_64.h on these platforms. Affected
> platforms are ARM64, LoongArch64 and Riscv. Otherwise there will
> be compiling error such as:
>
> linux-headers/asm/unistd.h:3:10: fatal error: asm/unistd_64.h: No such file or directory
>   #include <asm/unistd_64.h>
Hi,  Bibo

Could you help tested this patch on ARM machine? I don't have an ARM 
machine.

Thanks.
Song Gao
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   scripts/update-linux-headers.sh | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index c34ac6454e..203f48d089 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -163,6 +163,7 @@ EOF
>       fi
>       if [ $arch = arm64 ]; then
>           cp "$hdrdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
> +        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-arm64/"
>       fi
>       if [ $arch = x86 ]; then
>           cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
> @@ -185,6 +186,11 @@ EOF
>       fi
>       if [ $arch = riscv ]; then
>           cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
> +        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-riscv/"
> +        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-riscv/"
> +    fi
> +    if [ $arch = loongarch ]; then
> +        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-loongarch/"
>       fi
>   done
>   arch=


