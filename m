Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B53DCD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snU0n-00072q-2u; Sun, 08 Sep 2024 22:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1snU0k-00072F-HX
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 22:20:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1snU0h-00024w-Nl
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 22:20:14 -0400
Received: from loongson.cn (unknown [10.20.42.17])
 by gateway (Coremail) with SMTP id _____8AxbepTW95mhWcCAA--.5707S3;
 Mon, 09 Sep 2024 10:20:03 +0800 (CST)
Received: from [10.20.42.17] (unknown [10.20.42.17])
 by front1 (Coremail) with SMTP id qMiowMDx_9dSW95mLAgCAA--.12255S3;
 Mon, 09 Sep 2024 10:20:03 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Remove default enable with VIRTIO_VGA device
To: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20240823073050.2619484-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <12848a4f-212b-f29f-c181-d967c294ad86@loongson.cn>
Date: Mon, 9 Sep 2024 10:19:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240823073050.2619484-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_9dSW95mLAgCAA--.12255S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GrW8urWftFWkKr1UZr13Awc_yoWkGwb_Wa
 s2vw1rWFW5Ar9ruwnYv3yrJw15Wan7WF1fAFWDXw4kX34aqw1fXa17C3sIvF1jq3yUuan8
 ZrW0qrsYkrySkosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8I38UUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.046, SPF_HELO_NONE=0.001,
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



ÔÚ 2024/8/23 ÏÂÎç3:30, Bibo Mao Ð´µÀ:
> For virtio VGA deivce libvirt will select VIRTIO_VGA firstly rather than
> VIRTIO_GPU, VIRTIO_VGA device supports frame buffer however it requires
> legacy VGA compatible support. Frame buffer area 0xa0000 -- 0xc0000
> conflicts with low memory area 0 -- 0x10000000.
> 
> Here remove default support for VIRTIO_VGA device, VIRTIO_GPU is prefered
> on LoongArch system. For frame buffer video card support, standard VGA can
> be used.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks
Song Gao
> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index 0de713a439..9c69170968 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -5,7 +5,6 @@ config LOONGARCH_VIRT
>       select DEVICE_TREE
>       select PCI
>       select PCI_EXPRESS_GENERIC_BRIDGE
> -    imply VIRTIO_VGA
>       imply PCI_DEVICES
>       imply NVDIMM
>       imply TPM_TIS_SYSBUS
> 
> base-commit: 407f9a4b121eb65166375c410e14d7b704bc1106
> 


