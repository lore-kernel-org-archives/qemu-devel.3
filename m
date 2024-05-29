Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA5CC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJlq-0002q9-Nw; Wed, 29 May 2024 09:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJlk-0002jy-Nh
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJli-0003ak-0L
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716990904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qi4/rcZJOICMUryoomhA4Mf3QTbBBGvVeA/urA4Q8Ek=;
 b=TnM3AdH44qmiTnB9oRQXVPOYVS0fjOB/LV3EKMDN4W5y0IrrsUDRUVR48y2KHyqqRORDbc
 nPF321oZxLUFk3jHMbZaqnVBxzJETSoAZij68QKHWQMp5vLuBDOpHdWDk6qQCLY5EUHDsn
 wD+7UOof15C/MZPH4GNpxAfDZ9mqnKI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-eduUrVbmMqm6cZSIQK_r5A-1; Wed, 29 May 2024 09:55:03 -0400
X-MC-Unique: eduUrVbmMqm6cZSIQK_r5A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42114e7ec89so12902725e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990899; x=1717595699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qi4/rcZJOICMUryoomhA4Mf3QTbBBGvVeA/urA4Q8Ek=;
 b=HMELjfo3/tn1I1X/GDMWYZRIAqd05LcSNAX+HCixkaPfdPxa0cIXT36GoeemSItPw2
 NBLVLETQh5Kz0TbjhiixLt4fsAlzaz8fU8lksNM4PatX/eEMeT9j0D2p+FAHr9co7h6T
 uRhkX7UKz/ww54fXnszQ19KH5s8AQXT4Kucqrq0n9YJdyKp+JVGsHrx2zYkVdjK5dFs4
 AMTMaEo41JKVzrz4CUKqtvDgQQ3q1a4TlhsrJyIIr4bgCm+jbOteDLS2yrcQmHivlHJT
 TEfxGDvZ7RGdoyKXEVesg5VZCLN8Di4kI1ntfJIVMseNPmED7+sBbC0xSm5leHgI6kA9
 MSmg==
X-Gm-Message-State: AOJu0YzurNx9/UXpiXJsaWDY/6+JcAort9VohzGteKzEFcEhXynHfNZv
 X9LzHA3exoKtfQUuKJvB2yuLdKWirz1ieelcoYQUdVws4IiRdmeDOKAkAwuQkhy9tCBpXkr/tBr
 x2eZ1IWVwtJ36NFqeRY7FQa6jv2pMKhoanXkGZ8i/sjvYRa1/qwpX
X-Received: by 2002:a05:600c:4746:b0:416:2471:e102 with SMTP id
 5b1f17b1804b1-42108a271fcmr119196905e9.37.1716990899493; 
 Wed, 29 May 2024 06:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIesY2djrgEFx+ySPckTwjBCjiNTDA3rHEwlmaQCax+KF3y5CGU/Xbf/uS51W7P0eXMsaBCQ==
X-Received: by 2002:a05:600c:4746:b0:416:2471:e102 with SMTP id
 5b1f17b1804b1-42108a271fcmr119196765e9.37.1716990899087; 
 Wed, 29 May 2024 06:54:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089cd6f7sm180892345e9.46.2024.05.29.06.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 06:54:58 -0700 (PDT)
Date: Wed, 29 May 2024 15:54:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 07/23] hw/acpi/ich9: Remove dead code related to
 'acpi_memory_hotplug'
Message-ID: <20240529155457.6ab87d3a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-8-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-8-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 29 May 2024 07:15:23 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> acpi_memory_hotplug::is_enabled is set to %true once via
> ich9_lpc_initfn() -> ich9_pm_add_properties(). No need to
> check it, so remove now dead code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ich9.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 9b605af21a..02d8546bd3 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -153,17 +153,10 @@ static int ich9_pm_post_load(void *opaque, int vers=
ion_id)
>       .offset     =3D vmstate_offset_pointer(_state, _field, uint8_t),  \
>   }
> =20
> -static bool vmstate_test_use_memhp(void *opaque)
> -{
> -    ICH9LPCPMRegs *s =3D opaque;
> -    return s->acpi_memory_hotplug.is_enabled;
> -}
> -
>  static const VMStateDescription vmstate_memhp_state =3D {
>      .name =3D "ich9_pm/memhp",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .needed =3D vmstate_test_use_memhp,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_MEMORY_HOTPLUG(acpi_memory_hotplug, ICH9LPCPMRegs),
>          VMSTATE_END_OF_LIST()
> @@ -335,11 +328,9 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs =
*pm, qemu_irq sci_irq)
>      legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
>          OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
> =20
> -    if (pm->acpi_memory_hotplug.is_enabled) {
> -        acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(l=
pc_pci),
> -                                 &pm->acpi_memory_hotplug,
> -                                 ACPI_MEMORY_HOTPLUG_BASE);
> -    }
> +    acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_p=
ci),
> +                             &pm->acpi_memory_hotplug,
> +                             ACPI_MEMORY_HOTPLUG_BASE);
>  }
> =20
>  static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *na=
me,
> @@ -460,12 +451,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> -        !lpc->pm.acpi_memory_hotplug.is_enabled) {
> -        error_setg(errp,
> -                   "memory hotplug is not enabled: %s.memory-hotplug-sup=
port "
> -                   "is not set", object_get_typename(OBJECT(lpc)));
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          uint64_t negotiated =3D lpc->smi_negotiated_features;
> =20
>          if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> @@ -509,8 +495,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler =
*hotplug_dev,
>  {
>      ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(hotplug_dev);
> =20
> -    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
> -        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_request_cb(hotplug_dev,
>                                        &lpc->pm.acpi_memory_hotplug, dev,
>                                        errp);
> @@ -545,8 +530,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>  {
>      ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(hotplug_dev);
> =20
> -    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
> -        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_cb(&lpc->pm.acpi_memory_hotplug, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                 !lpc->pm.cpu_hotplug_legacy) {


