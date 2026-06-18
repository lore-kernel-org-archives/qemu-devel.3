Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D17CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 09:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa91y-00023e-L8; Thu, 18 Jun 2026 05:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wa91l-0001yz-Qt
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 05:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wa91i-0001mg-9H
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 05:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781774825;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XZrGqbm2Ow0WjX6DNzQYXaAoRmQlfXg9mfNOE4Ri88=;
 b=bdHaJoV/IBx7Pf5UN+WtPvzr5J9ujuBS8R9upOOK9qqzlpJgnxwVOy7WUzQME4Fb2qTJhY
 nlhItHTT2o4IqsVqyAJHr6WBiwdOU9WoNLQYa120qmNafr/vfli8aWubIGUggE2TT5NE+G
 MtXNrcWLdzHtVpIvxSenPC8zzZAUO0s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-BQzRhb-uM0WOkdZ-Tw7pDQ-1; Thu, 18 Jun 2026 05:27:03 -0400
X-MC-Unique: BQzRhb-uM0WOkdZ-Tw7pDQ-1
X-Mimecast-MFC-AGG-ID: BQzRhb-uM0WOkdZ-Tw7pDQ_1781774822
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so390011f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 02:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781774822; x=1782379622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XZrGqbm2Ow0WjX6DNzQYXaAoRmQlfXg9mfNOE4Ri88=;
 b=IfphCzGEO7uj5PaO81b6b96vNR+3H4clCxjD+9E7xyqGZIL9w6zgQhafSLgjQEisNS
 biiBzbpSugvdNykCt7A0qol0NaNmElGG5kvT5cARvMZOymgk3PhWOD1JVk3A1PycKKPs
 UBbfsx9OuA35r7/UVT8JQhU/qmhxq17QtrrAychse/a2VmpgYTsFnM1UThNSN567iaE0
 TrUQGFfOU8ixh35ixrPuVgJfYU0oFAKDeoPi2YCqdiOZe7AR1QS6XysoTdIfJkFNNx1L
 3Q96tAxSC1I1ZE3mvUhCjKmZWV8CGknzgyzTk84UqDf6W17BDMPBvcNG4WgjvxT9IaXW
 EULQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SYh8pfwYhTTQEYB0ZYM7khyUDzChMDZZe8QQGdebz3he6vyLn70eXFyahhP4Q2POk41Np905/JlmL@nongnu.org
X-Gm-Message-State: AOJu0YzQYN10tYTXUYBJFfHPhBcjQLSJg8P5nEHhBQ1nBLbCQFakvRiC
 GtBM9YgOJCRjdm8craHwV//qGirYG9AQoN67beFTUq950KE69IJ+dgMl6dP8Z+G+8PfG6wzxbjJ
 itEggQem3sB/yMO35U2OGczJeeZuPMHomfg3oDxbBwduPfnoB16Tzo6zI
X-Gm-Gg: AfdE7ck8QodK6Xt7fFNZycqp/Flxh4lUA+DADtvXyr23GrtzO0tccU6s7q+L6oi+s5Y
 WH+BnRmR5La5hDtKecyIxdzK1mx1vkNjiyyNlhShm4dBZ6c6Ljk0yYdrnZ2elwDLSAO4AY6HSIo
 eqS5G8cjRYlTNpojcoQ020iB6Gpwnh+O57EfpWUogwhMsOAdLsOviUlXqVVreXRLe1tPNkGDLh9
 MGCDW6HQMY4S9ZbI8zt/PlfftiLX3hQfX0kODkvupyhPSbi/fvi6opeUuGSdDpkpuV3/GqfVYwA
 /jWn0ySnfOnOmcUC4QsnD1W8kHJHPzyTPzO0h3QG9/qzLanEqt2e4TO2Qou8NRM+AlojuVAWECh
 +wkk3IPZWF3mrJBT0mvhQhGnVen6Ic+FlFJBZzhA5Rk4Xk9P9IO4NX2PKGqs=
X-Received: by 2002:a05:6000:310f:b0:463:d9:5b35 with SMTP id
 ffacd0b85a97d-463ab328c3cmr4411208f8f.1.1781774822203; 
 Thu, 18 Jun 2026 02:27:02 -0700 (PDT)
X-Received: by 2002:a05:6000:310f:b0:463:d9:5b35 with SMTP id
 ffacd0b85a97d-463ab328c3cmr4411151f8f.1.1781774821701; 
 Thu, 18 Jun 2026 02:27:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619fb12edbsm25076966f8f.17.2026.06.18.02.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 02:27:01 -0700 (PDT)
Message-ID: <c6f663fc-93ad-4a22-b9dc-d7a4653bf348@redhat.com>
Date: Thu, 18 Jun 2026 11:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 14/17] arm-qmp-cmds: introspection for ID register
 props
Content-Language: en-US
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, yangjinqian1@huawei.com, cohuck@redhat.com,
 richard.henderson@linaro.org, sebott@redhat.com, skolothumtho@nvidia.com,
 philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
References: <20260616132625.1732031-1-eric.auger@redhat.com>
 <20260616132625.1732031-15-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260616132625.1732031-15-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 6/16/26 3:17 PM, Eric Auger wrote:
> From: Cornelia Huck <cohuck@redhat.com>
>
> Implement the capability to query available ID register values by
> adding SYSREG_* options and values to the cpu model expansion for the
> host model, if available.
>
> Excerpt:
> (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
> {"return": {"model": {"name": "host", "props": {"SYSREG_ID_AA64PFR0_EL1_EL3": 1,
> "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0, "SYSREG_CTR_EL0_L1Ip": 3,
> "SYSREG_MIDR_EL1_PartNum": 3407, "SYSREG_CTR_EL0_DminLine": 4,
> "SYSREG_ID_AA64MMFR0_EL1_PARange": 5, "SYSREG_ID_AA64MMFR1_EL1_ECBHB": 0
> ../..
>
> So this allows the upper stack to detect available writable ID
> regs and the "host passthrough model" values.
>
> It also allows to test some ID reg field values:
> (QEMU) query-cpu-model-expansion type=full model={"name":"host","props":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x13}}
> {"error": {"class": "GenericError", "desc": "idreg SYSREG_ID_AA64ISAR0_EL1_DP set value (0x13) exceeds length of field (4)!"}}
>
> (QEMU) query-cpu-model-expansion type=full model={"name":"host","props":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x2}}
> {"error": {"class": "GenericError", "desc": "idreg SYSREG_ID_AA64ISAR0_EL1_DP set value (0x2) does not match any arch valid enum value!"}}

for your info I am currently exploring ways to test set field values
against KVM. Current check only test against field size and enum values
if any.

I have a POC instantiating a scratch vcpu and it is totally feasible to
set the id reg with the modified value. What is more tricky is to build
an incremental scratch vcpu with all the set values accumulating But I
guess it should be feasible too.

If we manage to do that, I don't think you need safe rules/values
anymore because using query-cpu-model-expansion you could directly check
the enhanced cpu model can safely apply on host. I will share as soon as
I get something clean enough. Thanks Eric
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>
> ---
>
> v5 -> v6:
> - add the write capability
> ---
>  target/arm/arm-qmp-cmds.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 83ec95c290..edcfc82a25 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -21,6 +21,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu/target-info.h"
>  #include "hw/core/boards.h"
>  #include "kvm_arm.h"
> @@ -84,6 +85,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                       Error **errp)
>  {
>      CpuModelExpansionInfo *expansion_info;
> +    ObjectPropertyIterator iter;
> +    ObjectProperty *idregprop;
>      const QDict *qdict_in;
>      QDict *qdict_out;
>      ObjectClass *oc;
> @@ -145,6 +148,20 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>          }
>  
>          qdict_in = qobject_to(QDict, model->props);
> +
> +        object_property_iter_init(&iter, obj);
> +
> +        while ((idregprop = object_property_iter_next(&iter))) {
> +            if (!g_str_has_prefix(idregprop->name, "SYSREG_")) {
> +                continue;
> +            }
> +            if (qdict_get(qdict_in, idregprop->name)) {
> +                if (!object_property_set(obj, idregprop->name, visitor, &err)) {
> +                    break;
> +                }
> +            }
> +        }
> +
>          i = 0;
>          while ((name = cpu_model_advertised_features[i++]) != NULL) {
>              if (qdict_get(qdict_in, name)) {
> @@ -190,6 +207,18 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>          }
>      }
>  
> +    object_property_iter_init(&iter, obj);
> +
> +    while ((idregprop = object_property_iter_next(&iter))) {
> +        QObject *value;
> +
> +        if (!g_str_has_prefix(idregprop->name, "SYSREG_")) {
> +            continue;
> +        }
> +        value = object_property_get_qobject(obj, idregprop->name, &error_abort);
> +        qdict_put_obj(qdict_out, idregprop->name, value);
> +    }
> +
>      if (!qdict_size(qdict_out)) {
>          qobject_unref(qdict_out);
>      } else {


