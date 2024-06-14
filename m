Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8E9C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 03:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHxg4-0007dO-B6; Thu, 13 Jun 2024 23:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sHxfy-0007cy-V4
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 23:32:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sHxfv-0000BB-SD
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 23:32:30 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cxe+rBuWtmwMIGAA--.27451S3;
 Fri, 14 Jun 2024 11:32:17 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxssS9uWtm_7MfAA--.761S3; 
 Fri, 14 Jun 2024 11:32:15 +0800 (CST)
Subject: Re: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <002b6625-9fed-beeb-700c-93438023d873@loongson.cn>
Date: Fri, 14 Jun 2024 11:32:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxssS9uWtm_7MfAA--.761S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur47Aw4fWF47uw45CryrXwc_yoWkKwc_Wr
 n3J34kGr48XF47ta4DtF98A345Ww48tF98Aa4xXr48KFy5JrZxJFs7Jwn8Zr98tr4UJFW5
 Jrn8Cr1rCw17GosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.395,
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


It is interesting.

How to wakeup VM if it sleeps in S3/S4, from emulated keyboard or 
ethernet magic packet or qemu monitor command in background?

Regards
Bibo Mao


On 2024/6/14 上午1:30, Jiaxun Yang wrote:
> Hi all,
> 
> This series implemented S3 and S4 sleep for loongarch virt machine
> and microvm.
> 
> For loongarch/virt a kernel patch is requried [1].
> 
> [1]: https://lore.kernel.org/loongarch/20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com/
> 
> Please review.
> Thanks
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (3):
>        acpi/ged: Implement S3 and S4 sleep
>        hw/loongarch/virt: Wire up S3 and S4 sleep
>        hw/i386/microvm: Wire up S3 and S4 sleep
> 
>   hw/acpi/generic_event_device.c         | 70 ++++++++++++++++++++++++++++++----
>   hw/i386/acpi-microvm.c                 | 18 +++++++++
>   hw/i386/microvm.c                      |  3 ++
>   hw/loongarch/acpi-build.c              | 18 +++++++++
>   hw/loongarch/virt.c                    |  3 ++
>   include/hw/acpi/generic_event_device.h | 12 +++++-
>   6 files changed, 115 insertions(+), 9 deletions(-)
> ---
> base-commit: f3e8cc47de2bc537d4991e883a85208e4e1c0f98
> change-id: 20240613-loongarch64-sleep-37b2466b8d76
> 
> Best regards,
> 


