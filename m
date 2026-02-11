Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5BAEB5954
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 09:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq6oq-0004IA-S9; Wed, 11 Feb 2026 04:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vq6on-0004HW-RG
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:47:33 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vq6ok-0007l4-SB
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:47:33 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxvsMrUIxpYqwRAA--.56484S3;
 Wed, 11 Feb 2026 17:47:24 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxacEoUIxpf2tEAA--.48551S3;
 Wed, 11 Feb 2026 17:47:23 +0800 (CST)
Subject: Re: [PATCH 3/3] target/loongarch: Add property set with
 query-cpu-model-expansion
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20260119100702.1214764-1-maobibo@loongson.cn>
 <20260119100702.1214764-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <c7a78fae-d805-9ec1-4481-7aa30ee6b4dd@loongson.cn>
Date: Wed, 11 Feb 2026 17:48:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260119100702.1214764-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxacEoUIxpf2tEAA--.48551S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGrW7ur17KF43WrWkCryrZrc_yoW5XF4Upa
 43XrsxJrW8tryxCF1kJ3Z5Wr15tr97Ga12g3ZIkr1UJr90vr1a9w1rK3yDAFW7A3yIgay8
 XF48Cw4qqa18X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.384, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2026/1/19 ÏÂÎç6:07, Bibo Mao Ð´µÀ:
> On LoongArch with QMP command query-cpu-model-expansion, property
> setting is not supported witch command such as:
>    query-cpu-model-expansion type=static model={"name":"max","props":{"lasx":false}}
>
> Here add property setting support with QMP command.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/loongarch-qmp-cmds.c | 40 +++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 12 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
> index 6a95080fe4..f053f22bb8 100644
> --- a/target/loongarch/loongarch-qmp-cmds.c
> +++ b/target/loongarch/loongarch-qmp-cmds.c
> @@ -50,7 +50,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                        Error **errp)
>   {
>       Visitor *visitor;
> -    bool ok;
>       CpuModelExpansionInfo *expansion_info;
>       QDict *qdict_out;
>       ObjectClass *oc;
> @@ -64,30 +63,47 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>           return NULL;
>       }
>   
> +    oc = cpu_class_by_name(TYPE_LOONGARCH_CPU, model->name);
> +    if (!oc) {
> +        error_setg(errp, "The CPU type '%s' is not a recognized LoongArch "
> +                         "CPU type", model->name);
> +        return NULL;
> +    }
> +
> +    obj = object_new(object_class_get_name(oc));
>       if (model->props) {
> +        Error *err = NULL;
> +        const QDict *qdict_in;
> +
>           visitor = qobject_input_visitor_new(model->props);
>           if (!visit_start_struct(visitor, "model.props", NULL, 0, errp)) {
>               visit_free(visitor);
> +            object_unref(obj);
>               return NULL;
>           }
>   
> -        ok = visit_check_struct(visitor, errp);
> +        qdict_in = qobject_to(QDict, model->props);
> +        i = 0;
> +        while ((name = cpu_model_advertised_features[i++]) != NULL) {
> +            if (qdict_get(qdict_in, name)) {
> +                if (!object_property_set(obj, name, visitor, &err)) {
> +                    break;
> +                }
> +            }
> +        }
> +
> +        if (!err) {
> +            visit_check_struct(visitor, &err);
> +        }
>           visit_end_struct(visitor, NULL);
>           visit_free(visitor);
> -        if (!ok) {
> +        if (err) {
> +            error_propagate(errp, err);
> +            object_unref(obj);
>               return NULL;
>           }
>       }
>   
> -    oc = cpu_class_by_name(TYPE_LOONGARCH_CPU, model->name);
> -    if (!oc) {
> -        error_setg(errp, "The CPU type '%s' is not a recognized LoongArch CPU type",
> -                   model->name);
> -        return NULL;
> -    }
> -
> -    obj = object_new(object_class_get_name(oc));
> -
>       expansion_info = g_new0(CpuModelExpansionInfo, 1);
>       expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
>       expansion_info->model->name = g_strdup(model->name);


