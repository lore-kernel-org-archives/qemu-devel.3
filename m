Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68863C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9Wh-000527-7a; Wed, 29 Jan 2025 09:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9Wd-00051a-IJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:58:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9Wb-0003VU-8w
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738162719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YLxCHNiZuZEqkH4nDxSXBuSmKHhos6mZS0Qg9rUlAY=;
 b=MqXA90SK+w4f/5jPvL6/ZU0+VDTIvqvfD6LUc9eohtbomhofBbdIB/mILK96iGOnmDLktW
 iYH0EIWB/wJ7h47Wghhn+4ftVGYU0UlDy/7Ocf7xPOFmf+mTuA01/dee9GRrnVuvLS33/P
 irxZxA1EXvR2BqGAMo6U+oTgf2jsyMg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Kha8aCs3Mgq2tMh8dVR8qg-1; Wed, 29 Jan 2025 09:58:38 -0500
X-MC-Unique: Kha8aCs3Mgq2tMh8dVR8qg-1
X-Mimecast-MFC-AGG-ID: Kha8aCs3Mgq2tMh8dVR8qg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e49efd59so2671817f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 06:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738162717; x=1738767517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7YLxCHNiZuZEqkH4nDxSXBuSmKHhos6mZS0Qg9rUlAY=;
 b=cpWlNboW8VrH5CBEx/adkm8h0J0IFMDM1LUsaJHKr6umN0IDTLGsPv0STQ+w0kEp6E
 RmUNJBZw29HOOxo8kKATMQZI22gYOaEsadE143uLY58GDCsop8Gc0DqsuzcVEMy7jcES
 ZKIh4gwNQMU0BCQHIxMksXLNOhJ9mvj5gNoB0QdEm5+7zVIYnBBvmtbVeub+Xks+hjmz
 sbs4gDpjgkUHFcclL/JPEqGO5uaWjSCMtdXF959gv4aHZxdJ9l8I1VDoCNsCDjfhlgv7
 w/JI+gVFLuY2dMCgMKa1CYeLXyZjNcfVLwoFMdYaUyp+wM9U91AQNazTJ+6H49KorMOP
 y+9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtIZDjJBYmTtlek+tvh/bu41WX5vAWYuBHCGaANmPH1xp/NRoitDLIxz50DhQUgo9qfGCWldp8RXIu@nongnu.org
X-Gm-Message-State: AOJu0YzS0rewzCyzEniXvGfq2oUTX+/ucR+9qLcWjlbIIfMER7Pi56fO
 btSafaRGuf0iGtDtkaZz+mlYSYGVuu57yaMNm5miYwLsgTiHNqV/8LcbaF2os6P6Eel7kUpQlXb
 m88fh6FMS8jbZ6B56rEYgHUG3oXp9Us2DF6Qj/e7Iuy67U/GDZbrR
X-Gm-Gg: ASbGncu3yDx8fkBQWVxQrkNvno/hNvicaOFhj83YOp3rqOwZE5UVzYEQ1v9uCJpkB7i
 fQJWSZlcFCPaeZdmKnBvq+KGrfnuQy7F8MhnS4MUTxKWtft67pokA6j9tHf9C2fTNTceGKFgdId
 zL+nGksux/5qu5M6X9uNWNyRqsG8PNQesCqD74Gy1MZGG+Ge/BRIFtMrLrEPRdoTtwjxWLldSfX
 WNNcjV1vbgdK4slr1JVArCK0DnsgLao1f8b0kI8mPIHN7+gZPOWRty0UFywbOzNG9e+XWItmUls
 RAw3YRoOHai+vWkFQjLlOxclvTjPQWalEAuIR5EssVzn3oEd8fta
X-Received: by 2002:a5d:6da7:0:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-38c520a3857mr2398029f8f.36.1738162716861; 
 Wed, 29 Jan 2025 06:58:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMwSlfCYiiLFlh1GBXbwPXPCM4Ik7wcyzVpOdmCUsAoavAr1awCBY108KIzXWSNU2cHYsJsQ==
X-Received: by 2002:a5d:6da7:0:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-38c520a3857mr2398004f8f.36.1738162716474; 
 Wed, 29 Jan 2025 06:58:36 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d7bfsm17421061f8f.35.2025.01.29.06.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 06:58:35 -0800 (PST)
Date: Wed, 29 Jan 2025 15:58:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/13] acpi/generic_event_device: add an APEI error
 device
Message-ID: <20250129155835.77cdcfb0@imammedo.users.ipa.redhat.com>
In-Reply-To: <897c1eb4fcec527891301c9243ac8ce84a182187.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <897c1eb4fcec527891301c9243ac8ce84a182187.1738137123.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 29 Jan 2025 09:04:15 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Adds a generic error device to handle generic hardware error
> events as specified at ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> using HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the guest via ACPI APEI Generic Hardware Error Source (GHES).
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/aml-build.c                    | 10 ++++++++++
>  hw/acpi/generic_event_device.c         | 14 ++++++++++++++
>  include/hw/acpi/acpi_dev_interface.h   |  1 +
>  include/hw/acpi/aml-build.h            |  2 ++
>  include/hw/acpi/generic_event_device.h |  1 +
>  5 files changed, 28 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f8f93a9f66c8..e4bd7b611372 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2614,3 +2614,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
>  
>      return var;
>  }
> +
> +/* ACPI 5.0b: 18.3.2.6.2 Event Notification For Generic Error Sources */
> +Aml *aml_error_device(void)
> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    return dev;
> +}
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 70729b6238a5..50313ed7ee96 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -26,8 +26,15 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
>      ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_ERROR_EVT,
>  };
>  
> +/*
> + * ACPI 5.0b: 5.6.6 Device Object Notifications
> + * Table 5-135 Error Device Notification Values
> + */
> +#define ERROR_DEVICE_NOTIFICATION   0x80

drop 1-off macro as Michael suggested, and move value/comment into
the place where it's used


> +
>  /*
>   * The ACPI Generic Event Device (GED) is a hardware-reduced specific
>   * device[ACPI v6.1 Section 5.6.9] that handles all platform events,
> @@ -116,6 +123,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_ERROR_EVT:
> +                aml_append(if_ctx,
> +                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
> +                                      aml_int(ERROR_DEVICE_NOTIFICATION)));
> +                break;
>              case ACPI_GED_NVDIMM_HOTPLUG_EVT:
>                  aml_append(if_ctx,
>                             aml_notify(aml_name("\\_SB.NVDR"),
> @@ -295,6 +307,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_MEM_HOTPLUG_EVT;
>      } else if (ev & ACPI_POWER_DOWN_STATUS) {
>          sel = ACPI_GED_PWR_DOWN_EVT;
> +    } else if (ev & ACPI_GENERIC_ERROR) {
> +        sel = ACPI_GED_ERROR_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50aa..8294f8f0ccca 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>      ACPI_VMGENID_CHANGE_STATUS = 32,
>      ACPI_POWER_DOWN_STATUS = 64,
> +    ACPI_GENERIC_ERROR = 128,
>  } AcpiEventStatusBits;
>  
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index c18f68134246..f38e12971932 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -252,6 +252,7 @@ struct CrsRangeSet {
>  /* Consumer/Producer */
>  #define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
>  
> +#define ACPI_APEI_ERROR_DEVICE   "GEDD"
>  /**
>   * init_aml_allocator:
>   *
> @@ -382,6 +383,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
>               uint8_t channel);
>  Aml *aml_sleep(uint64_t msec);
>  Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
> +Aml *aml_error_device(void);
>  
>  /* Block AML object primitives */
>  Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d2dac87b4a9f..1c18ac296fcb 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -101,6 +101,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_ERROR_EVT          0x10
>  
>  typedef struct GEDState {
>      MemoryRegion evt;


