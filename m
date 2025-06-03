Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A070C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTWV-0007tc-Ft; Tue, 03 Jun 2025 11:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTWT-0007tI-EZ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTWO-0007yu-BR
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748964346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yBfv8PCJq2gBz9dcdltqo7tJI46Xxm4a4FHcW/YXY5s=;
 b=idnzBWRxonbQH5U1Qj7Y8174eeVeuCbGxTvYdhmUfLvC+ufXDrdMqzeuS3SInTS4IRnamO
 jhJ4lkTbPFjnse+hgfdvwIEXom1jpgZKRaebPgJ3fBG1HCtUFP4iM2g5AnlIVBKjcLAtBL
 KrlH+FpPARD657CDcTlLhXxeXytEdNo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-aIiLm9RgPramYlC0qlf67Q-1; Tue, 03 Jun 2025 11:25:44 -0400
X-MC-Unique: aIiLm9RgPramYlC0qlf67Q-1
X-Mimecast-MFC-AGG-ID: aIiLm9RgPramYlC0qlf67Q_1748964343
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f55ea44dso2536902f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964343; x=1749569143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBfv8PCJq2gBz9dcdltqo7tJI46Xxm4a4FHcW/YXY5s=;
 b=KD3beGhRR83d6NgIpOXZNqvccUwbJadAcuYnAkJ8O0kKf7Ittq3xdONNgUO5BhT2OX
 vCxkHb4aJo9j/0NdoTrMp8u9CE8O7opRLh5X889/F+F5EYblYg5L6ya689ZJHRKbLA6D
 prs+Z0cmNpzkNpZmzCiPjjlhX+CxtTjnovjy/H9jhmVk6mIhhhJlZvjre/xb2UclwwdJ
 nPJhgkEVt1DYb6pkDjKm8o+uptR32JKIc5xtIHPAZ31VELxJEEfXyRW+e2HPtACj0Xqp
 2UtV9w+fH2AGl/3CbVUCmUMCfZg3Ub/zGjXoNR3uIoV2ygsQ6g0AuQfeOCmWCxiD/t/O
 kqVQ==
X-Gm-Message-State: AOJu0Yy9HNKeU/gittoo9SenOTvnPROzIOj91kA65rahxNHthw+nG+Z5
 lw8aLn+2xPdc6gMGVJ1/0hC9MCcVdk8atFbtORJ8WtN3HA++gljJcYL+o+nCtQW0697DxnWPrJa
 l1EMLRJQMo27DrJmC0doxexue/XqVkLbmugZb7Mq1hbLA5lTJMaipMBri
X-Gm-Gg: ASbGncvFN0iCZpUfSzC5B0cxXujGvUGcvrJvky/YVlcd/ldfPu7WlDsd8vkRIgwwZGy
 CC/XIB/gu93DuCVJjC7gqSB+HP+HhX6d+3DJqZvdGPqAxaFso7NkswPWC12Uwr4KXlqG4jEtSuM
 POaqPstL/RJSRblRhZlj7wn+slG6JPU5a+2dDJa8DRbLrvZVUr1zNWTkUV+Ik41ajTZYXIYRsuW
 uEPnRspX002X02+DguNe+iRWUP+ggxung9g02UGLwpYLjprsWiekQvRM8AcSNwLK8sOlyHt7SXF
 cmdHxcUKyUJf6/zfyS9zzZXkt8PrdHNE
X-Received: by 2002:a05:6000:310e:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a4fe1617e1mr10054401f8f.8.1748964343374; 
 Tue, 03 Jun 2025 08:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW/kuAY4IWVd7G9BfdKU5LwduHTGLEZIlgZ/MuytQyGOYuiztMRSecNoZPQ8kreMMNJZa/BQ==
X-Received: by 2002:a05:6000:310e:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a4fe1617e1mr10054375f8f.8.1748964342919; 
 Tue, 03 Jun 2025 08:25:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe74111sm19070985f8f.56.2025.06.03.08.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:25:42 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:25:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 03/18] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
Message-ID: <20250603172540.74edac96@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-4-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu,  1 May 2025 23:04:41 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
> in the pc_compat_2_8[] array, via the 'x-smi-broadcast=3Doff'
> property. We removed all machines using that array, lets remove
> that property and all the code around it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/southbridge/ich9.h |  1 -
>  hw/acpi/ich9.c                |  6 ++----
>  hw/isa/lpc_ich9.c             | 22 +++-------------------
>  3 files changed, 5 insertions(+), 24 deletions(-)
>=20
> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
> index 1e231e89c92..4764c03ac2d 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -244,7 +244,6 @@ struct ICH9LPCState {
>  #define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
> =20
>  /* bit positions used in fw_cfg SMI feature negotiation */
> -#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
>  #define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
>  #define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
> =20
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index c7a735bf642..40564605735 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -477,8 +477,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          uint64_t negotiated =3D lpc->smi_negotiated_features;
> =20
> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> -            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
> +        if (!(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
>              error_setg(errp, "cpu hotplug with SMI wasn't enabled by fir=
mware");
>              error_append_hint(errp, "update machine type to newer than 5=
.1 "
>                  "and firmware that suppors CPU hotplug with SMM");
> @@ -526,8 +525,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler =
*hotplug_dev,
>                 !lpc->pm.cpu_hotplug_legacy) {
>          uint64_t negotiated =3D lpc->smi_negotiated_features;
> =20
> -        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> -            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
> +        if (!(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
>              error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
>                               "by firmware");
>              error_append_hint(errp, "update machine type to a version ha=
ving "
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 71afb45b631..c57a06e0dde 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -400,15 +400,6 @@ static void smi_features_ok_callback(void *opaque)
>      guest_cpu_hotplug_features =3D guest_features &
>                                   (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT=
) |
>                                    BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_=
BIT));
> -    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
> -        guest_cpu_hotplug_features) {
> -        /*
> -         * cpu hot-[un]plug with SMI requires SMI broadcast,
> -         * leave @features_ok at zero
> -         */
> -        return;
> -    }
> -
>      if (guest_cpu_hotplug_features =3D=3D
>          BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)) {
>          /* cpu hot-unplug is unsupported without cpu-hotplug */
> @@ -470,14 +461,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, void=
 *arg)
> =20
>      /* SMI_EN =3D PMBASE + 30. SMI control and enable register */
>      if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
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
>          }
>      }
>  }
> @@ -830,8 +816,6 @@ static const Property ich9_lpc_properties[] =3D {
>      DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
>      DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
>      DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
> -    DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
> -                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
>      DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_featur=
es,
>                        ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
>      DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_feat=
ures,


