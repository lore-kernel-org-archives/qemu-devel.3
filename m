Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1942EC61CE3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUHd-0000Xw-Ud; Mon, 24 Aug 2026 09:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUHa-0000RY-U6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUHZ-0006t8-0z
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787576408;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvm8v3i+XgnteFyBnFT7BPk71UD+tdwGIox8fqc9Cao=;
 b=WNho3lgA8RV29Qlf2PMJsmLDcie1FEZzuTRoMiz5NVqzqXVcsj0nq+me2q/+U2awPA/Its
 lrgGrTiT2Geu0141NjwLet36C1M71TcHtajkyMZ4SCndbnGkPl/awOZ2+1UNQXACiZj9BX
 6fDJuTMjYcNN5FlMAwNeyfhhejqNJ+E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-KAleOBGwOwyZTS6M6yKLSw-1; Mon,
 24 Aug 2026 09:00:03 -0400
X-MC-Unique: KAleOBGwOwyZTS6M6yKLSw-1
X-Mimecast-MFC-AGG-ID: KAleOBGwOwyZTS6M6yKLSw_1787576402
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF813185FCE7; Mon, 24 Aug 2026 13:00:01 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ACE47D5; Mon, 24 Aug 2026 12:59:55 +0000 (UTC)
Date: Mon, 24 Aug 2026 13:59:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 11/16] hw/acpi/ich9.c: convert object props in
 ICH9_LPC_DEVICE to class props
Message-ID: <aoxASVcLT03dVwCj@redhat.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-12-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821111550.276011-12-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 21, 2026 at 12:14:23PM +0100, Mark Cave-Ayland wrote:
> ACPI_PM_PROP_TCO_ENABLED, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE and x-keep-pci-slot-hpc
> properties can be converted to use object_class_property_add_bool_ptr(). Remove
> the now unused ich9_pm_add_properties() function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/acpi/ich9.h |   3 +-
>  hw/acpi/ich9.c         | 111 ++++++++++++++++-------------------------
>  hw/isa/lpc_ich9.c      |   3 +-
>  3 files changed, 44 insertions(+), 73 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

but...


> @@ -436,6 +368,47 @@ void ich9_pm_add_class_properties(ObjectClass *oc)
>                                                  ACPI_PM_PROP_GPE0_BLK_LEN,
>                                                  &gpe0_len,
>                                                  OBJ_PROP_FLAG_READ);
...it'd read nicer with

  #define REG_FIELD(n) \
    (pm_offset + offsetof(ICH9LPCPMRegs, n))

> +    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
> +                                         pm_offset +
> +                                         offsetof(ICH9LPCPMRegs,
> +                                                  pm_io_base),
> +                                         OBJ_PROP_FLAG_READ);


....

    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
                                         REG_FIELD(pm_io_base),
                                         OBJ_PROP_FLAG_READ);

...

> +    object_class_property_add_link(oc, "bus",
> +                                   TYPE_PCI_BUS,
> +                                   pm_offset +
> +                                   offsetof(ICH9LPCPMRegs,
> +                                            acpi_pci_hotplug.root),
> +                                   object_property_allow_set_link,
> +                                   OBJ_PROP_LINK_STRONG);
> +    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
> +                              ich9_pm_get_gpe0_blk,
> +                              NULL, NULL, NULL);
> +    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
> +                                        pm_offset +
> +                                        offsetof(ICH9LPCPMRegs, disable_s3),
> +                                        OBJ_PROP_FLAG_READWRITE);
> +    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_DISABLED,
> +                                        pm_offset +
> +                                        offsetof(ICH9LPCPMRegs, disable_s4),
> +                                        OBJ_PROP_FLAG_READWRITE);
> +    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_VAL,
> +                                        pm_offset +
> +                                        offsetof(ICH9LPCPMRegs, s4_val),
> +                                        OBJ_PROP_FLAG_READWRITE);
> +    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_TCO_ENABLED,
> +                                       pm_offset +
> +                                       offsetof(ICH9LPCPMRegs, enable_tco),
> +                                       OBJ_PROP_FLAG_READWRITE);
> +    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
> +                               pm_offset +
> +                               offsetof(ICH9LPCPMRegs,
> +                                   acpi_pci_hotplug.use_acpi_hotplug_bridge),
> +                               OBJ_PROP_FLAG_READWRITE);
> +    object_class_property_add_bool_ptr(oc, "x-keep-pci-slot-hpc",
> +                                       pm_offset +
> +                                       offsetof(ICH9LPCPMRegs,
> +                                                keep_pci_slot_hpc),
> +                                       OBJ_PROP_FLAG_READWRITE);

...

  #undef REG_FIELD

>  }
>  
>  void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index d3f1358887..b55b5136a3 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -689,7 +689,6 @@ static void ich9_lpc_initfn(Object *obj)
>                               IOAPIC_NUM_PINS);
>  
>      ich9_pm_reset_properties(&lpc->pm);
> -    ich9_pm_add_properties(obj, &lpc->pm);
>  }
>  
>  static void ich9_lpc_realize(PCIDevice *d, Error **errp)
> @@ -920,7 +919,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
>                                                 &acpi_disable_cmd,
>                                                 OBJ_PROP_FLAG_READ);
>  
> -    ich9_pm_add_class_properties(klass);
> +    ich9_pm_add_class_properties(klass, offsetof(ICH9LPCState, pm));
>  }
>  
>  static const TypeInfo ich9_lpc_info = {
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


