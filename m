Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F28BD6D251
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 01:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGTSi-0001QK-5q; Wed, 27 Nov 2024 20:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tGTSe-0001Q5-5i
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 20:36:52 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tGTSa-0006pc-UU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 20:36:51 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx764myUdni09KAA--.40862S3;
 Thu, 28 Nov 2024 09:36:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxPEciyUdnTslqAA--.45762S3;
 Thu, 28 Nov 2024 09:36:36 +0800 (CST)
Subject: Re: [PATCH] tests/functional: Fix the running test case causes
 loongarch64 to hang
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Song Gao <gaosong@loongson.cn>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 peter.maydell@linaro.org
References: <20241127013438.2206426-1-lixianglai@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <6eca5a68-4e3d-b64a-cde2-b275252cc59d@loongson.cn>
Date: Thu, 28 Nov 2024 09:35:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241127013438.2206426-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPEciyUdnTslqAA--.45762S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww4DGFWkAF1UJw1ktrW8AFc_yoW5JFyDpF
 1xZF4jkrnxJrWDA3y0gas29Fy0qrWrWF1xWr43trW09rZ8XFyvvr13K3W8t34UWw1ruayr
 ZF97Wry8XF15AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
 AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1tC7UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.901,
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

Hi Thomas and Philippe,

Could you do me a favor to merge this bugfix?

Gao Song is offline and cannot work on computer. I have no merge 
permission and I am applying maintainer permission.

Regards
Bibo Mao

On 2024/11/27 上午9:34, Xianglai Li wrote:
> There is a bug in the process of resolving the serial port base address
> in the fdt of the loongarch VM UEFI. When both serial port information
> and rng-seed information are chosen in the fdt, there is a probability
> that the serial port base address cannot be resolved correctly.
> This problem can be fixed by updating UEFI.
> 
> issue link:
> https://gitlab.com/qemu-project/qemu/-/issues/2686
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: <peter.maydell@linaro.org>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   tests/functional/test_loongarch64_virt.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/test_loongarch64_virt.py
> index 2b8baa2c2a..b7d9abf933 100755
> --- a/tests/functional/test_loongarch64_virt.py
> +++ b/tests/functional/test_loongarch64_virt.py
> @@ -18,16 +18,16 @@ class LoongArchMachine(QemuSystemTest):
>   
>       ASSET_KERNEL = Asset(
>           ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> -         'releases/download/2024-05-30/vmlinuz.efi'),
> +         'releases/download/2024-11-26/vmlinuz.efi'),
>           '08b88a45f48a5fd92260bae895be4e5175be2397481a6f7821b9f39b2965b79e')
>       ASSET_INITRD = Asset(
>           ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> -         'releases/download/2024-05-30/ramdisk'),
> +         'releases/download/2024-11-26/ramdisk'),
>           '03d6fb6f8ee64ecac961120a0bdacf741f17b3bee2141f17fa01908c8baf176a')
>       ASSET_BIOS = Asset(
>           ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> -         'releases/download/2024-05-30/QEMU_EFI.fd'),
> -        '937c1e7815e2340150c194a9f8f0474259038a3d7b8845ed62cc08163c46bea1')
> +         'releases/download/2024-11-26/QEMU_EFI.fd'),
> +        'f55fbf5d92e885844631ae9bfa8887f659bbb4f6ef2beea9e9ff8bc0603b6697')
>   
>       def wait_for_console_pattern(self, success_message, vm=None):
>           wait_for_console_pattern(self, success_message,
> 


