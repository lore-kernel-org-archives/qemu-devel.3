Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2F7CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhui-0002gL-8B; Fri, 16 Oct 2026 09:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHhug-0002fs-Kq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHhud-0007qH-Dp
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792157034;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SE9V4G/G/hYgWtus+HDIk8cYxijfE4z5gZCyCIy9Vw4=;
 b=PkVDstdOS301iYWVEYiaK60QDnr3IYgxRLrTxZgAnpX4DCJIaxLUn37A9Ay9HJ9lpoqCbW
 27opKFhFs0rxd1mkCmnDSE/7PfFEClzsMXr+74NIinBsW4LHOTd30jtvdBxcRCieagl34Z
 rBDoR7wPi1qDP79CcwTNEhuKUi1Cd48=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-31LaIH8INZqcQmq_T2PHRQ-1; Fri, 16 Oct 2026 13:23:53 +0000
X-MC-Unique: 31LaIH8INZqcQmq_T2PHRQ-1
X-Mimecast-MFC-AGG-ID: 31LaIH8INZqcQmq_T2PHRQ_1792157032
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1d15e7bfaso4272705e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792157032; x=1792761832;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SE9V4G/G/hYgWtus+HDIk8cYxijfE4z5gZCyCIy9Vw4=;
 b=zE1lKMgNAS8k2U5w2RQ75OAV+2iNzXYp+/dyggZ6u/6I4B20nQ8TlqycJC9cRiOvBL
 +nuLmPK/7+A7PQFQBin7/dJIKE7MMytTI1YTTZz0wKsN7IzKBQ6ruTQeX5LnAk9+2RC3
 I5MTsJBAQbJ1JPioeZUyJioOIUZHUdMAqVsS6NMrbjWN5fk72YVeKsxmLRA1EBeV4QHc
 2ypx4fEtdWrjwhFEMu4OZlc+0T3uq2uBDfyycRotiHO8UWfjYELjmzZsck+SaSWPPIMW
 dZVPkTUEAL8RFt8lRMDSvbUli/zUKW2r3dZvCIIHljkt04YpXxNwaurxhjiMRlSpkMaM
 /bEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztE4ux0Rj9VqN8El8ABE87s/V1s+t9kiPXtxw4AMxk2bOZ8rJSATda9hQGMZ+wnBDYp4wdaNJ/tA+o@nongnu.org
X-Gm-Message-State: AFq9FYLgWyVj5f/8vIow13FP3x9OZLF4EJK8VyDiAfxnQ10y+oScsIE2
 eTDj4nM6majfOOe1pTrli6/+nZ47LWsLpZXpRpks1FcVegRdEaWyEmygH8JOBbaTgrQ2OIpZb84
 7/ZNgUH9S9FuqgyZzxkyB//SVTtYPM6BKvxMjJ1mEzpTvWyS4LSkmYR2g
X-Gm-Gg: AYBFou2FJRGRkEVZiAqfQZmI6+SCydMdcOMzwU/JFAqiEFJjaDj5brIP+ySg5/Zk89A
 LUMEyK8bXYPsZepKVuQNpQ+f1hpc97m2aB6lpt6G2Lcnxd5fmUpniGGtX+2MiPSQX8ohhcEdAEi
 lWInQf2FfZd2HB5c/PxiMisOZ46b9NsYYafatisY+7UM3+WYBp7rd2z6q1OCfNIq1J7yDiL8XHV
 fNfpdW3nvuWtmPqpQJ5k9J1WJ4owxv23ymhSe6Emy3R0n9laGN3Uuyc+n8qWgo6C22UEospSDoZ
 NrRbtC6kdGOQT3swzWgMYrzPKAFuiyGsPZoaud0EgkzKAdmX94Tq3Sl6HFBbq1smTWqFBoc0oWi
 fAxaSO+bW4YR6T72ITLEJWDTGXIsO8GKbUidg4DEta4iRJ1rM
X-Received: by 2002:a05:600c:c113:b0:4a1:985b:83a9 with SMTP id
 5b1f17b1804b1-4a1985b87f5mr280530235e9.4.1792157031795; 
 Fri, 16 Oct 2026 06:23:51 -0700 (PDT)
X-Received: by 2002:a05:600c:c113:b0:4a1:985b:83a9 with SMTP id
 5b1f17b1804b1-4a1985b87f5mr280529705e9.4.1792157031375; 
 Fri, 16 Oct 2026 06:23:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b8b5fsm164077725e9.9.2026.10.16.06.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 06:23:50 -0700 (PDT)
Message-ID: <1dcb8628-2b99-4af1-92f4-08dcae197e82@redhat.com>
Date: Fri, 16 Oct 2026 15:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 24/25] target/arm/qmp: implement
 query-cpu-props-info for KVM
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-25-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-25-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/21/26 2:32 PM, Khushit Shah wrote:
> Implement query-cpu-props-info for ARM64/KVM by creating and finalizing
> a temporary "host" CPU object and then walking its QOM properties.
side note: the new qmp command shall be documented in
docs/system/arm/cpu-features.rst

Eric
>
> For numeric SYSREG_ properties, report the host-supported value ranges
> computed by kvm_arm_field_get_supported_values(). For boolean
> properties, report false as always supported and true as supported when
> the QOM property value is true.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/arm-qmp-cmds.c | 84 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 0940285af1..ba488d5c01 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -84,6 +84,90 @@ static const char *cpu_model_advertised_features[] = {
>      NULL
>  };
>  
> +CpuPropertyInfoList *qmp_query_cpu_props_info(Error **errp)
> +{
> +    CpuPropertyInfoList *head = NULL;
> +    const ARMISARegisters *host_isar;
> +    ObjectPropertyIterator iter;
> +    ObjectProperty *prop;
> +    Error *err = NULL;
> +    ObjectClass *oc;
> +    Object *obj;
> +
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "query-cpu-props-info requires KVM");
> +        return NULL;
> +    }
> +
> +    oc = cpu_class_by_name(TYPE_ARM_CPU, "host");
> +    if (!oc) {
> +        error_setg(errp, "The 'host' CPU type is not available");
> +        return NULL;
> +    }
> +
> +    host_isar = kvm_arm_get_host_isar();
> +
> +    /* Spin up a scratch "host" vCPU object and walk its QOM properties. */
> +    obj = object_new_with_class(oc);
> +    arm_cpu_finalize_features(ARM_CPU(obj), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        object_unref(obj);
> +        return NULL;
> +    }
> +
> +    object_property_iter_init(&iter, obj);
> +    while ((prop = object_property_iter_next(&iter))) {
> +        CpuPropertyInfo *info;
> +
> +        if (g_str_has_prefix(prop->name, "SYSREG_")) {
> +            const ARM64SysRegField *field = prop->opaque;
> +            CpuPropertyValueRangeList *ranges = NULL;
> +            ArmFieldValueSet *vs = NULL;
> +
> +            info = g_new0(CpuPropertyInfo, 1);
> +            info->name = g_strdup(prop->name);
> +            info->type = CPU_PROPERTY_TYPE_NUMBER;
> +
> +            kvm_arm_field_get_supported_values(field, host_isar, &vs);
> +            for (size_t k = 0; k < vs->n_ranges; k++) {
> +                CpuPropertyValueRange *r = g_new0(CpuPropertyValueRange, 1);
> +                r->min = vs->ranges[k].min;
> +                r->max = vs->ranges[k].max;
> +                QAPI_LIST_PREPEND(ranges, r);
> +            }
> +            info->u.number.supported_values = ranges;
> +
> +            g_free(vs->ranges);
> +            g_free(vs);
> +        } else if (g_strv_contains(cpu_model_advertised_features, prop->name)) {
> +            bool cur = object_property_get_bool(obj, prop->name, &error_abort);
> +            boolList *values = NULL;
> +
> +            info = g_new0(CpuPropertyInfo, 1);
> +            info->name = g_strdup(prop->name);
> +            info->type = CPU_PROPERTY_TYPE_BOOLEAN;
> +
> +            /*
> +             * "off" is always supported. "on" is only supported when the
> +             * host already has the feature enabled.
> +             */
> +            QAPI_LIST_PREPEND(values, false);
> +            if (cur) {
> +                QAPI_LIST_PREPEND(values, true);
> +            }
> +            info->u.boolean.supported_values = values;
> +        } else {
> +            continue;
> +        }
> +
> +        QAPI_LIST_PREPEND(head, info);
> +    }
> +
> +    object_unref(obj);
> +    return head;
> +}
> +
>  CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                       CpuModelInfo *model,
>                                                       Error **errp)


