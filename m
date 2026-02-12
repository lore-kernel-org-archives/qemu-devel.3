Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E183EEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbkh-0001vu-DQ; Thu, 12 Feb 2026 13:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqbkf-0001vT-RP
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:49:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqbkY-0002ft-WA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922151;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6N520W3Q1fRnhdfCL74Yg5xWPz9v0Vp0DazZJcBcic=;
 b=I2Oiym6JsI0qQj5n32KcLdL7pgfkXVVGysZU9dIKfLjC5zpW1PagZjfFg/LjgkuJR+el/8
 O2F328yPHKKvnh1sUfSOVnV1X2OgNVGz5lPQFy0q9BgP+OjiZqSvqMaxiJl6VZiWLwCVnU
 ub18KSoKFzFZ+cj6kk5/Svf5pOkxh14=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Y8cWQNx8M2y7N2fRtsB3YA-1; Thu, 12 Feb 2026 13:49:10 -0500
X-MC-Unique: Y8cWQNx8M2y7N2fRtsB3YA-1
X-Mimecast-MFC-AGG-ID: Y8cWQNx8M2y7N2fRtsB3YA_1770922149
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so1483685e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 10:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770922149; x=1771526949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6N520W3Q1fRnhdfCL74Yg5xWPz9v0Vp0DazZJcBcic=;
 b=G8RStR/YS9l032/svEOSmP9op8DyMXCQuCbLhZh2FhCZzAMkjr61Rrmqz10oGETaMw
 xRbiiMfz1TnVoPSShEv7/N8Igs7owgpIrnUMGr6wjhGnN9HBV3KlEuOdWi+fiLclznbS
 MXvsqT7JuqCoaEhVO6QpwzvEtN2Utim3PnmZUn46zYoFwBQVDEg+at6dl/bmqxgT3RJs
 qI2AubGi5K4FSPPUihGEmBWQHLfC1NqQ7UGAdIDopt7eK/DvAE6JCMYFyRDrLpK1qSW3
 yhjH1/OgdvfO+CrPC/4Uo1/CMftoO6hvhJaoybsbh+S2v/t1wuD8ANQNy8gxxLsC3V9d
 +eZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV98HfKE/7aBTNl0H4EhzmWr89+HLm44jLWzHFuop5C9ysUoGI9f7K7+MzQzg/8uP4GLLaRG4FwWWPy@nongnu.org
X-Gm-Message-State: AOJu0YzI/D/Zsk9P9CD3cdPr4xYS7G8SArlD4a2Xd87L8Fp1XsbEavDd
 kMirP67sy9w90j7PxGZe5R8iNwVMnK59YQq8JfB2syuCnDWAnL7evbYhpcI7tmUkapt8emt28+F
 2N2Kf/TTN90+FQgTsl96f37ygHG14/Pr6U5avkMaAvIB6M3NvjWmG++dt
X-Gm-Gg: AZuq6aIwRy6YaNSVE3IEsq4Ej5eDxnZos8qsSFuMVaUkCtCOj6aLUT3OWaZxoivTY47
 sxM/hqnzOQRNIvMNuI+a2BvEYTiF4RcOvZuNiItOgdPLmBSOTilcVXt+Wc3n5wW0WwN76r/5GI8
 zt9b8zaE7UmIje+uhrs+pQVjcg1NLqmm6F7Iktr4cTeiSzZw9ui4Ujyxc9BiLRjoqv5q6SNRP0M
 8Xo0TMSzsFIan24QwLStGy9QUNX43vMBSenS0sKyY8i0u0431blYmv9jzmQpyglJcm8yU09R5z8
 lOfeuXCF//lasZqB+iBpnKTWSD4sXf1ANcSNOh4HvlLMsnSQhEndt7sHr3qAdKx7Ph4kJxZf6Qu
 bIjGNlPoInqIu8eHAXwmtkiUiXt1AbhZ+t0cSBtEQo04FwKxmRj/LhMcGxrxwv951vlF11g==
X-Received: by 2002:a05:600c:46d3:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-48370e18901mr2142145e9.2.1770922148927; 
 Thu, 12 Feb 2026 10:49:08 -0800 (PST)
X-Received: by 2002:a05:600c:46d3:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-48370e18901mr2141735e9.2.1770922148431; 
 Thu, 12 Feb 2026 10:49:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a4e62dsm1032345e9.4.2026.02.12.10.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 10:49:08 -0800 (PST)
Message-ID: <e4589c56-6628-4aa2-811a-c03ce17b5cf5@redhat.com>
Date: Thu, 12 Feb 2026 19:49:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier
 poroperty
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-23-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-23-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> Add an "identifier" property to the SMMUv3 device and use it when
> building the ACPI IORT SMMUv3 node Identifier field.
>
> This avoids relying on enumeration order and provides a stable
> per-device identifier. This is useful when we add support for
> Tegra241 CMDQV DSDT in subsequent patch.
>
> No functional change intended.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3.c          | 1 +
>  hw/arm/virt-acpi-build.c | 4 +++-
>  hw/arm/virt.c            | 3 +++
>  include/hw/arm/smmuv3.h  | 1 +
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7858bf2c33..7f84c87a46 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2114,6 +2114,7 @@ static const Property smmuv3_properties[] = {
>       * Defaults to stage 1
>       */
>      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> +    DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index ae3b4aac52..046e930ca5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -342,6 +342,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>  typedef struct AcpiSMMUv3Dev {
>      int irq;
>      hwaddr base;
> +    uint8_t id;
>  
>      /*
>       * IORT-only fields.
> @@ -407,6 +408,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>      bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
>      sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
>      sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
> +    sdev.id = object_property_get_uint(obj, "identifier", &error_abort);
>      pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>      sbdev = SYS_BUS_DEVICE(obj);
>      sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> @@ -642,7 +644,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                       (ID_MAPPING_ENTRY_SIZE * smmu_mapping_count);
>          build_append_int_noprefix(table_data, node_size, 2); /* Length */
>          build_append_int_noprefix(table_data, 4, 1); /* Revision */
> -        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
> +        build_append_int_noprefix(table_data, sdev->id, 4); /* Identifier */
Would that keep the same ordering for existing qtests?

Eric
>          /* Number of ID mappings */
>          build_append_int_noprefix(table_data, smmu_mapping_count, 4);
>          /* Reference to ID Array */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 390845c503..22ee5c4a41 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3059,12 +3059,15 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                         (vms->legacy_smmuv3_present) ?
>                         "iommu=smmuv3" : "virtio-iommu");
>          } else if (vms->iommu == VIRT_IOMMU_NONE) {
> +            static uint8_t id;
> +
>              /* The new SMMUv3 device is specific to the PCI bus */
>              object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
>              object_property_set_link(OBJECT(dev), "memory",
>                                       OBJECT(vms->sysmem), NULL);
>              object_property_set_link(OBJECT(dev), "secure-memory",
>                                       OBJECT(vms->secure_sysmem), NULL);
> +            object_property_set_uint(OBJECT(dev), "identifier", id++, NULL);
>          }
>          if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
>              hwaddr db_start = 0;
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 87926f8cb3..39cb43506e 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -63,6 +63,7 @@ struct SMMUv3State {
>      qemu_irq     irq[4];
>      QemuMutex mutex;
>      char *stage;
> +    uint8_t identifier;
>  
>      /* SMMU has HW accelerator support for nested S1 + s2 */
>      bool accel;


