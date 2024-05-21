Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0817C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 03:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9GRl-0003KE-8q; Mon, 20 May 2024 23:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9GRj-0003K4-0L
 for qemu-devel@nongnu.org; Mon, 20 May 2024 23:45:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9GRf-0004Bq-Vr
 for qemu-devel@nongnu.org; Mon, 20 May 2024 23:45:50 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxiurhGExmxiABAA--.199S3;
 Tue, 21 May 2024 11:45:37 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPMfeGExmOr4CAA--.9940S3; 
 Tue, 21 May 2024 11:45:35 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: Fix FDT memory node address width
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20240520-loongarch-fdt-memnode-v1-1-5ea9be93911e@flygoat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <54cdb99c-be33-02d7-254d-43e4ba54dcbf@loongson.cn>
Date: Tue, 21 May 2024 11:45:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240520-loongarch-fdt-memnode-v1-1-5ea9be93911e@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxPMfeGExmOr4CAA--.9940S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Xw4UKw1DArWDJr1xKF1UXFc_yoW8JF1UpF
 WxCan5G3yUJr1vkrZ2vryY9w1DAr17Kr12qF17urW8CrZrXw1aqF4xC395tryj934rAF1Y
 vF45GF95XanYvFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.405,
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

在 2024/5/21 上午5:06, Jiaxun Yang 写道:
> Higher bits for memory nodes were omitted at qemu_fdt_setprop_cells.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> This should be stable backported, otherwise DT boot is totally broken.
> ---
>   hw/loongarch/virt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
Thank you.

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index f0640d2d8035..f97626bacf65 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -463,7 +463,8 @@ static void fdt_add_memory_node(MachineState *ms,
>       char *nodename = g_strdup_printf("/memory@%" PRIx64, base);
>   
>       qemu_fdt_add_subnode(ms->fdt, nodename);
> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, 0, size);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", base >> 32, base,
> +                           size >> 32, size);
>       qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memory");
>   
>       if (ms->numa_state && ms->numa_state->num_nodes) {
>
> ---
> base-commit: 85ef20f1673feaa083f4acab8cf054df77b0dbed
> change-id: 20240520-loongarch-fdt-memnode-e36c01ae9b6e
>
> Best regards,


