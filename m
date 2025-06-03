Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1220CC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 03:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMIka-0004Bn-3P; Mon, 02 Jun 2025 23:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uMIkY-0004BS-VR
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:55:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uMIkX-0004Nn-9j
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:55:42 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxvnI6cj5oxqIJAQ--.33304S3;
 Tue, 03 Jun 2025 11:55:38 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzxs4cj5onSMGAQ--.35352S3;
 Tue, 03 Jun 2025 11:55:38 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: inform guest of kvm
To: Qiang Ma <maqianga@uniontech.com>, maobibo@loongson.cn,
 jiaxun.yang@flygoat.com
Cc: qemu-devel@nongnu.org
References: <20250603031813.31794-1-maqianga@uniontech.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <6af7b893-3282-13cb-aa81-4f227de7d5be@loongson.cn>
Date: Tue, 3 Jun 2025 11:58:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250603031813.31794-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzxs4cj5onSMGAQ--.35352S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFW8Cw18JF1UCr15WFW5twc_yoWfZrcE9r
 12ywnakr45XF1kW3Zaqa45Aa15Gay8J3Z5ZFnIgFn5Ga43Jrn3AF42gwnxuanFqr40vwsx
 A3yvqr1ayryagosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8czVUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.054, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2025/6/3 ÉÏÎç11:18, Qiang Ma Ð´µÀ:
> Commit bab27ea2e3 ("hw/arm/virt: smbios:
> inform guest of kvm") fixes the same issue
> on arm.
>
> without this patch:
> [root@localhost ~]# virt-what
> qemu
>
> with this patch:
> [root@localhost ~]# virt-what
> kvm
>
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>   hw/loongarch/virt.c | 4 ++++
>   1 file changed, 4 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 1b504047db..a3d449ca8b 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -136,6 +136,10 @@ static void virt_build_smbios(LoongArchVirtMachineState *lvms)
>           return;
>       }
>   
> +    if (kvm_enabled()) {
> +        product = "KVM Virtual Machine";
> +    }
> +
>       smbios_set_defaults("QEMU", product, mc->name);
>   
>       smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,


