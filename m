Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06C0CD6E45
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGbH-0007n1-V5; Wed, 27 May 2026 11:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGbG-0007mf-QM
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGbF-0002np-33
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779897316;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9xue6t6Y2IH3Dy0p/6rrAI0rQmnyMyM6T6+NiRWyUY=;
 b=hr4eZ0l+iPhNPlo5LTg2goPrpTEP5BPxuWs7Tnrq45PBqxUecLUqB68jeVxIV3ev+D0G7i
 TrleHqyTByIT/5fuEqCa3/WlcJtYPbiPVWBTL8Ol7OFFAijIkWGj6RGGnKKZiZ4ed3byk2
 JMVqRDPRZn2/ArMqeOoPjtwTcpJJ+Hc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-O1m-vG6dOc6FusLErqTf4Q-1; Wed, 27 May 2026 11:55:14 -0400
X-MC-Unique: O1m-vG6dOc6FusLErqTf4Q-1
X-Mimecast-MFC-AGG-ID: O1m-vG6dOc6FusLErqTf4Q_1779897313
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44f56d5523eso10382788f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779897312; x=1780502112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9xue6t6Y2IH3Dy0p/6rrAI0rQmnyMyM6T6+NiRWyUY=;
 b=M7EeUaPygRvJe1xLclIIlDV8aeeGOCceU5BgLCpB54C+qFNpHRe6/bwoxkU/zOairi
 VySI+FhD8Aw2nWu5r/wfJQ3RhjhhnCgdmtLV7TvAP0kN9lWYJ2hpR82oFQ2VCGx5nhUc
 kmCB+vO0lWq9d4hZQKe108OCTyv6Y3oX1IweEVaNJ9MEluup+E6neFZPg9uy6C9u9QFC
 AKTsgT8HPqmQznau0Yo7EZjQNEGrM2FZHvc3IMHl7zyTZlJtej2BT4tFUriiw4hmP3LP
 ghPWwgCi14Rq976Qj3WD7g6A9LN+ky6SssiyAMTcoxBOSYj3h1puTY9jy4Paot5dJh4u
 MXUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CcXL6rddhoytEYegfI8CNqqPIEi1OAJyjJ5B2t20Vq4H+NJhUnGy5fvDtfNsC7jo89fNmGfprQM7e@nongnu.org
X-Gm-Message-State: AOJu0YzcHsYQ+CwMbaHo2nGxh7CDCxLM6uWZ8GYXETEU0fnyQeI5wn5e
 fTZlvadJ+/Q+TdY5F273uRhYAd1czHPNl48WZOXf4r+u4i6dXaOJXCOVPaLVwvGCOImURVF5hse
 eaC6o8hOLhW/F9hdTUToMUfs6xNjBg7og9Vx3yhmJmvLrTrs/pUgHglMr
X-Gm-Gg: Acq92OGeDzvkWZDSCkcu5aUcwC85IySasUDJ4YyzXJ9NmpHUm4oEuoOwpjs6r2sdFtS
 Merh4e0VQrtnQyxIlq9OLUJqVM+ZvHfQjZOvFJNbuqxlX0/NrHrYkm12ivOZ7+9TV+lt+0MsAmN
 hCVD76+leYw7fNOObgIazaCHo0b8y6tD9PcWC9itT4NtxFNeO9F6C54rjH5+d4lnaAJcF9F15zM
 ik/BUWIOoecv6AvYx7KnZ2LBBLMZnMYNW1R34JstZaDlqhsvae4rSZDYayqUvpp+3d1nSoTCCe1
 Sn4i4RUFNXB0z/IJSZbhJOzGeqah7YWkdnkorlB+47jun7WYcWTeL7I/3BhHbLpANEKjQ70qCvJ
 rwY4gdoIS+95Iq8k0O2JtnPqSgl22Mq/NOi9XPT5PeUbZjieDFO8pm0YXmPmhxI6zsE3ZWQ==
X-Received: by 2002:a05:600c:530c:b0:490:5527:3be2 with SMTP id
 5b1f17b1804b1-49055273be6mr306169795e9.32.1779897312453; 
 Wed, 27 May 2026 08:55:12 -0700 (PDT)
X-Received: by 2002:a05:600c:530c:b0:490:5527:3be2 with SMTP id
 5b1f17b1804b1-49055273be6mr306169135e9.32.1779897311991; 
 Wed, 27 May 2026 08:55:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb548dfasm6528455f8f.4.2026.05.27.08.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:55:11 -0700 (PDT)
Message-ID: <a72e17f4-0afa-4aab-9fbb-8ed5d806619a@redhat.com>
Date: Wed, 27 May 2026 17:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/18] arm-qmp-cmds: introspection for ID register props
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-18-eric.auger@redhat.com>
 <36063617-EE1B-493A-929F-E8EC8655FC8A@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <36063617-EE1B-493A-929F-E8EC8655FC8A@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/27/26 5:17 PM, Khushit Shah wrote:
>
>> On 19 May 2026, at 6:57 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Implement the capability to query available ID register values by
>> adding SYSREG_* options and values to the cpu model expansion for the
>> host model, if available.
>>
>> Excerpt:
>> (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
>> {"return": {"model": {"name": "host", "props":
>> {"SYSREG_ID_AA64PFR0_EL1_EL3": 1224979098931106066,
>> "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0,
>> ../..
>>
>> So this allows the upper stack to detect available writable ID
>> regs and the "host passthrough model" values.
>>
>> [CH: moved SYSREG_* values to host model]
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>>
>> TODO: Add the moment there is no way to test changing a given
>> ID reg field value. ie:
>>
>> (QEMU) query-cpu-model-expansion type=full model={"name":"host", "prop":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x13}}
>> ---
>> target/arm/arm-qmp-cmds.c | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>
>> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
>> index 83ec95c290..e6c717a872 100644
>> --- a/target/arm/arm-qmp-cmds.c
>> +++ b/target/arm/arm-qmp-cmds.c
>> @@ -21,6 +21,7 @@
>>  */
>>
>> #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> #include "qemu/target-info.h"
>> #include "hw/core/boards.h"
>> #include "kvm_arm.h"
>> @@ -190,6 +191,24 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>         }
>>     }
>>
>> +    /* If writable ID regs are supported, add them as well */
>> +    if (ARM_CPU(obj)->writable_map) {
>> +        ObjectProperty *prop;
>> +        ObjectPropertyIterator iter;
>> +
>> +        object_property_iter_init(&iter, obj);
>> +
>> +        while ((prop = object_property_iter_next(&iter))) {
>> +            QObject *value;
>> +
>> +            if (!g_str_has_prefix(prop->name, "SYSREG_")) {
>> +                continue;
>> +            }
>> +            value = object_property_get_qobject(obj, prop->name, &error_abort);
>> +            qdict_put_obj(qdict_out, prop->name, value);
>> +        }
>> +    }
>> +
>>     if (!qdict_size(qdict_out)) {
>>         qobject_unref(qdict_out);
>>     } else {
>> -- 
>> 2.53.0
>>
>
> Why also not add support to set these properties? Like the function does for
> legacy properties?

Tbh I have not tested it yet in write mode. One problem we may encounter
is setting one ID reg value may change the value of others or at least
their visibility. So if my understanding is correct we should set each
if reg one at a time and each time read the whole set before applying
the next value. But I may be wrong

Thanks

Eric
>
> Warm Regards,
> Khushit
>


