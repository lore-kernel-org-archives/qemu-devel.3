Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E94EFCE20
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxptn-0007No-SX; Wed, 04 Mar 2026 12:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vxptm-0007NY-Fr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vxptk-0000pk-PT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772644835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UTcEJWOgix4/7szYPpki0DCFtfPOnTbEl3TDBgFLKtk=;
 b=NlbA1k9+uX0YEY1P9Rh+qbj6TZZZj6n2V/Gh0fA4eZb4KTb6ZHYsYuTlWb0hQAguU6zQB/
 ihri3RUtrwz9Nrkc0Uqi5iEYNHOkTIj3Ab01cCQLN5A7QSuxHRgpYAuqnW2ZKdKCBkZf/V
 aFAn5jIsh/rdtQa+I85PZWcpImpDj9s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-1uJGCka0Mv2q9Ppa3Li4DQ-1; Wed,
 04 Mar 2026 12:20:33 -0500
X-MC-Unique: 1uJGCka0Mv2q9Ppa3Li4DQ-1
X-Mimecast-MFC-AGG-ID: 1uJGCka0Mv2q9Ppa3Li4DQ_1772644833
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDE0E1800245; Wed,  4 Mar 2026 17:20:32 +0000 (UTC)
Received: from [10.45.224.194] (unknown [10.45.224.194])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4D4918002A6; Wed,  4 Mar 2026 17:20:29 +0000 (UTC)
Message-ID: <061e1cc4-7099-4e2e-a164-04c34a6a0c10@redhat.com>
Date: Wed, 4 Mar 2026 18:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/16] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, philmd@linaro.org, kraxel@redhat.com
References: <20260225092024.794595-1-thuth@redhat.com>
 <20260303140058.2423099-1-imammedo@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260303140058.2423099-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 03/03/2026 15.00, Igor Mammedov wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> v2:
>     - do not check for SMI features if hotplug happens when
>       SMI is not enabled. (matters for qtest and possibly seabios)
>     - removing property also removes default ICH9_LPC_SMI_F_BROADCAST_BIT
>       put default back in place only set it initfn() instead
> 
> The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
> in the pc_compat_2_8[] array, via the 'x-smi-broadcast=off'
> property. We removed all machines using that array, lets remove
> that property and all the code around it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/acpi/ich9.c    |  4 ++--
>   hw/isa/lpc_ich9.c | 23 ++++-------------------
>   2 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index bbb1bd60a2..87afe86bcc 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -432,7 +432,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>       if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>           uint64_t negotiated = lpc->smi_negotiated_features;
>   
> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> +        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
>               !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
>               error_setg(errp, "cpu hotplug with SMI wasn't enabled by firmware");
>               error_append_hint(errp, "update machine type to newer than 5.1 "
> @@ -476,7 +476,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>           uint64_t negotiated = lpc->smi_negotiated_features;
>   
> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> +        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
>               !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
>               error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
>                                "by firmware");
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 51dc680029..04169ffa24 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -404,15 +404,6 @@ static void smi_features_ok_callback(void *opaque)
>       guest_cpu_hotplug_features = guest_features &
>                                    (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT) |
>                                     BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT));
> -    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
> -        guest_cpu_hotplug_features) {
> -        /*
> -         * cpu hot-[un]plug with SMI requires SMI broadcast,
> -         * leave @features_ok at zero
> -         */
> -        return;
> -    }
> -
>       if (guest_cpu_hotplug_features ==
>           BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)) {
>           /* cpu hot-unplug is unsupported without cpu-hotplug */
> @@ -474,14 +465,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
>   
>       /* SMI_EN = PMBASE + 30. SMI control and enable register */
>       if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
> -        if (lpc->smi_negotiated_features &
> -            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
> -            CPUState *cs;
> -            CPU_FOREACH(cs) {
> -                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> -            }
> -        } else {
> -            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> +        CPUState *cs;
> +        CPU_FOREACH(cs) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>           }
>       }
>   }
> @@ -685,6 +671,7 @@ static void ich9_lpc_initfn(Object *obj)
>   
>       static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
>       static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
> +    lpc->smi_host_features = BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT);

Shouldn't that rather be a "|=" instead of the "=" so that we don't lose the 
other bits?

  Thomas



>       object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
>   
> @@ -834,8 +821,6 @@ static const Property ich9_lpc_properties[] = {
>       DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
>       DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
>       DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
> -    DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
> -                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
>       DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
>                         ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
>       DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,


