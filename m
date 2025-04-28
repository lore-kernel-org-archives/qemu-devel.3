Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED0EC369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9FCs-0001yX-59; Sun, 27 Apr 2025 23:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9FCp-0001wL-FL
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:30:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9FCn-0007Zg-4W
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:30:55 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxaeFq9g5o9PXHAA--.25642S3;
 Mon, 28 Apr 2025 11:30:50 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxDcVp9g5oxmKaAA--.58193S3;
 Mon, 28 Apr 2025 11:30:49 +0800 (CST)
Subject: Re: [PATCH v2 2/2] hw/loongarch/virt: Allow user to customize OEM ID
 and OEM table ID
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20250304074134.1782295-1-maobibo@loongson.cn>
 <20250304074134.1782295-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <01e32995-9bd5-254d-2c37-577c72e0b679@loongson.cn>
Date: Mon, 28 Apr 2025 11:33:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250304074134.1782295-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxDcVp9g5oxmKaAA--.58193S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF47XryruFWUKF13Cw43twc_yoW5Ww4DpF
 4fZr95WFyUXF17GwsxJ3WkCFn8Grs2ka4jgFs7Zr1xCF98ur1DGr1xCw47tFy8A34qqF4F
 9w1v9rZxWayxJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jo
 sjUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.279, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

ÔÚ 2025/3/4 ÏÂÎç3:41, Bibo Mao Ð´µÀ:
> On LoongArch virt machine, the default OEM ID and OEM table ID is
> "BOCHS " and "BXPC    ". Here property x-oem-id and x-oem-table-id
> is added on virt machine to set customized OEM ID and OEM table ID.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

thanks,
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 59533b058b..ff28e57e32 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -770,6 +770,48 @@ static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
>       visit_type_OnOffAuto(v, name, &lvms->acpi, errp);
>   }
>   
> +static char *virt_get_oem_id(Object *obj, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +
> +    return g_strdup(lvms->oem_id);
> +}
> +
> +static void virt_set_oem_id(Object *obj, const char *value, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +    size_t len = strlen(value);
> +
> +    if (len > 6) {
> +        error_setg(errp,
> +                   "User specified oem-id value is bigger than 6 bytes in size");
> +        return;
> +    }
> +
> +    strncpy(lvms->oem_id, value, 6);
> +}
> +
> +static char *virt_get_oem_table_id(Object *obj, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +
> +    return g_strdup(lvms->oem_table_id);
> +}
> +
> +static void virt_set_oem_table_id(Object *obj, const char *value,
> +                                  Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +    size_t len = strlen(value);
> +
> +    if (len > 8) {
> +        error_setg(errp,
> +                   "User specified oem-table-id value is bigger than 8 bytes in size");
> +        return;
> +    }
> +    strncpy(lvms->oem_table_id, value, 8);
> +}
> +
>   static void virt_initfn(Object *obj)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> @@ -973,6 +1015,22 @@ static void virt_class_init(ObjectClass *oc, void *data)
>   #ifdef CONFIG_TPM
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>   #endif
> +    object_class_property_add_str(oc, "x-oem-id",
> +                                  virt_get_oem_id,
> +                                  virt_set_oem_id);
> +    object_class_property_set_description(oc, "x-oem-id",
> +                                          "Override the default value of field OEMID "
> +                                          "in ACPI table header."
> +                                          "The string may be up to 6 bytes in size");
> +
> +
> +    object_class_property_add_str(oc, "x-oem-table-id",
> +                                  virt_get_oem_table_id,
> +                                  virt_set_oem_table_id);
> +    object_class_property_set_description(oc, "x-oem-table-id",
> +                                          "Override the default value of field OEM Table ID "
> +                                          "in ACPI table header."
> +                                          "The string may be up to 8 bytes in size");
>   }
>   
>   static const TypeInfo virt_machine_types[] = {


