Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BDBF3C991
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuH0-0001GA-Lj; Tue, 24 Feb 2026 10:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vuuGz-0001Fy-VT
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vuuGw-0001uQ-OY
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771946665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yd/o+Bej7VgCNqY6eL4WUDxgFFDYbjkHMYdIvZ/GS8c=;
 b=SVaTZ8TpF5oecveZezUhH40M0OD9bUG+2/RMHP61ojK+ezODEq0Q6Zuvdjb+RIW0pEbA0Y
 3/qTakTfVksnIwKwYRywGexU4MGkBTXGOWvphy6wBHMwqfQDRzB8fdT9zfab5xdibs13Ny
 RPT6ptnry7wTXB2DcJR9PlD3udSDTjI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-XggGRzkEMgWwmQLz7PfAbQ-1; Tue,
 24 Feb 2026 10:24:22 -0500
X-MC-Unique: XggGRzkEMgWwmQLz7PfAbQ-1
X-Mimecast-MFC-AGG-ID: XggGRzkEMgWwmQLz7PfAbQ_1771946660
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADAE61955F23; Tue, 24 Feb 2026 15:24:19 +0000 (UTC)
Received: from [10.44.32.191] (unknown [10.44.32.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFDC73003D85; Tue, 24 Feb 2026 15:24:11 +0000 (UTC)
Message-ID: <6cc22a39-a8de-4795-8ddc-b83caef8a17e@redhat.com>
Date: Tue, 24 Feb 2026 16:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250501210456.89071-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

On 01/05/2025 23.04, Philippe Mathieu-Daudé wrote:
> The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
> in the pc_compat_2_8[] array, via the 'x-smi-broadcast=off'
> property. We removed all machines using that array, lets remove
> that property and all the code around it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/southbridge/ich9.h |  1 -
>   hw/acpi/ich9.c                |  6 ++----
>   hw/isa/lpc_ich9.c             | 22 +++-------------------
>   3 files changed, 5 insertions(+), 24 deletions(-)

FWIW, this patch seems to break tests/qtest/cpu-plug-test ... I get the 
error message "cpu hotplug with SMI wasn't enabled by firmware".
Sounds like the guest has the enable this feature, too, so I assume we 
cannot simply assume that it is always available now?

  Thomas



> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
> index 1e231e89c92..4764c03ac2d 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -244,7 +244,6 @@ struct ICH9LPCState {
>   #define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
>   
>   /* bit positions used in fw_cfg SMI feature negotiation */
> -#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
>   #define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
>   #define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
>   
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index c7a735bf642..40564605735 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -477,8 +477,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>       if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>           uint64_t negotiated = lpc->smi_negotiated_features;
>   
> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> -            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
> +        if (!(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
>               error_setg(errp, "cpu hotplug with SMI wasn't enabled by firmware");
>               error_append_hint(errp, "update machine type to newer than 5.1 "
>                   "and firmware that suppors CPU hotplug with SMM");
> @@ -526,8 +525,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                  !lpc->pm.cpu_hotplug_legacy) {
>           uint64_t negotiated = lpc->smi_negotiated_features;
>   
> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> -            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
> +        if (!(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
>               error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
>                                "by firmware");
>               error_append_hint(errp, "update machine type to a version having "
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 71afb45b631..c57a06e0dde 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -400,15 +400,6 @@ static void smi_features_ok_callback(void *opaque)
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
> @@ -470,14 +461,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
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
> @@ -830,8 +816,6 @@ static const Property ich9_lpc_properties[] = {
>       DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
>       DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
>       DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
> -    DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
> -                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
>       DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
>                         ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
>       DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,


