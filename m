Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B613ECAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aXe-0002Ob-7m; Wed, 24 Sep 2025 21:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v1aXa-0002NM-Q5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:12:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v1aXW-00018W-EO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:12:58 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxidEOl9Ro91kOAA--.30867S3;
 Thu, 25 Sep 2025 09:12:46 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxfcEMl9RoQ_etAA--.40131S3;
 Thu, 25 Sep 2025 09:12:46 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT64()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250925004327.58764-1-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <25928966-6229-b0d8-ba62-cf9ebf93a101@loongson.cn>
Date: Thu, 25 Sep 2025 09:12:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250925004327.58764-1-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxfcEMl9RoQ_etAA--.40131S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urW3GrW8Xr4DWF47Zw48Zrc_yoW8GFWkpw
 nxZF1IgFW7CrWrZa18Was5WFsxWFsrWF429a1Skr1kCa1DJr47ury8t3sFg3WfAa4Igry0
 vF4Fy34UXa1DZ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.055,
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

在 2025/9/25 上午8:43, Philippe Mathieu-Daudé 写道:
> All LoongArchCPU::pc and LoongArchCPU::gpr[] fields are of
> uint64_t type. Use the appropriate VMSTATE_UINT64() macro.
>
> There is no functional change (the migration stream is not
> modified), because the LoongArch targets are only built as 64-bit:
>
>    $ git grep TARGET_LONG_BITS configs/targets/loongarch64*
>    configs/targets/loongarch64-linux-user.mak:7:TARGET_LONG_BITS=64
>    configs/targets/loongarch64-softmmu.mak:7:TARGET_LONG_BITS=64
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/machine.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 4e70f5c8798..bead853efe8 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -171,8 +171,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
>       .version_id = 3,
>       .minimum_version_id = 3,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
> -        VMSTATE_UINTTL(env.pc, LoongArchCPU),
> +        VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
> +        VMSTATE_UINT64(env.pc, LoongArchCPU),
>   
>           /* Remaining CSRs */
>           VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),


