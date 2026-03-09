Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA01FCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzf5H-00030V-Km; Mon, 09 Mar 2026 14:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzf5A-0002Qe-My
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzf56-0007kk-Fs
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773079910;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mj3P97yb9RRx48ItIGxujBywEF12DLHwJ6aUKmQbRlY=;
 b=JTKzaf9ZKJjlCY/XHwUu9TPuzf9Otp0gFBLz6UHUUf0sEGbh0PfWlcBf9JCzW8Pt7roURI
 N9eWFMWcvX5oEaEcbmS7Zjo2zfxvp5rV3NlXSJJBPe3R8VVNx4puBN8Aj9NVBVJmg81qhh
 REPJyHmMUh0i+Sm0odWofuJ3I1ZTLX8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-yYV8rqYgOnCd1y7UDVG9Dw-1; Mon, 09 Mar 2026 14:11:49 -0400
X-MC-Unique: yYV8rqYgOnCd1y7UDVG9Dw-1
X-Mimecast-MFC-AGG-ID: yYV8rqYgOnCd1y7UDVG9Dw_1773079908
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439ae2cba40so7027432f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773079908; x=1773684708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mj3P97yb9RRx48ItIGxujBywEF12DLHwJ6aUKmQbRlY=;
 b=OrQlgruxVZjuPngirOTl+ISziNjQjMOrbcKz+y4xtotsU0/esDC6oUtqe46XXf6wGK
 vNsmgBTTMbOjKOEtS8M7GB+r3hSbovel5ZVG/YNPCGw0rVwNHBDe7OT0Z3Ewlwcyofwl
 r3sk+XwKZjGg6j/S+rHzXiZoP4189PAVBBMLg/o63JBkt0+DK3Tbo8tjO4H6ubBdo0cj
 GRFTIowB6LwHpzEtB+GhtNNuXv9pWAZZRVg3LDh1FKySHfkpQnCus5TkAsNiby6IPQmK
 6LtxkGEjgSyERksHTOFbBtbzVJeMrltUL2zCPkShpEjPLFlS4UPYB3Gx/88FutIyNWF6
 0FFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUkntEiShq3IXZ82e+kpumHfeGECn+KRdUdraFK3HCf/Wk/gBZ9toNqsbsLtzPTEElMM8mDnRK/DFA@nongnu.org
X-Gm-Message-State: AOJu0YxaRRvnPIViMTK+iQY/D/F+Dg9cz+nRBJvSsBCRzyW8qykbhXsi
 bsD3x/0Gx3hkGuQ/VFDI3UbRz7hP18MmGkgBmmCgawhKHbgZCQkLczqD9fIeAn7OoEWGGLASc7L
 cBp5vyx+9KC2iO+gMonAtXQYoFqWjOJ5qpTB4VTva93FDyuHpxddwHuHC
X-Gm-Gg: ATEYQzyKPWy2RUC1KlNSZzjEb5fep0s/qrO5Lvdy6/aOH3fECRlRK9YiaCTQ4hfu8Dw
 zLL3kpoiJsGVvcVJT2exlLhwZrRC8YYwIPLnlUifnPV0jzE+Dhmx8/qAazndptCQN9DXcRWtEV+
 B+hqEUnpZU5RiIsm+uw8blyVcQ1+4CvMlXoOxJFcgbxe9Z8juOSob6OyC7ChMXeobpDo/xJ3FBv
 IChoR7DjGPHG6CrY4KhKkjyX00lew59La0IJhm8W4MTcV9RmX7bVvspslFIW4Ro39Vo9OiddHz7
 oPknre8nh8XN1iDVO15lgpyWoE63YXWIjaADrLvamXqT7i8m1hWFGQ+njFHHCdsWAZoMMmCIJ4G
 +PzxS0Z3IzW/UzNrApdyR6/tzOxKEn/iexAnS1mfCsfZ27xjt+H+9a9B4J+KGQHKmJbBppg==
X-Received: by 2002:a05:600c:3109:b0:485:3c05:24dc with SMTP id
 5b1f17b1804b1-4853c05278amr61794035e9.33.1773079907679; 
 Mon, 09 Mar 2026 11:11:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3109:b0:485:3c05:24dc with SMTP id
 5b1f17b1804b1-4853c05278amr61793615e9.33.1773079907172; 
 Mon, 09 Mar 2026 11:11:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73easm8520175e9.3.2026.03.09.11.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 11:11:46 -0700 (PDT)
Message-ID: <2e990df5-4b9b-49ff-b479-2317e60fdc3a@redhat.com>
Date: Mon, 9 Mar 2026 19:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/32] hw/arm/smmuv3: Add per-device identifier property
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-29-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-29-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Shameer,

On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> Add an "identifier" property to the SMMUv3 device and use it when
> building the ACPI IORT SMMUv3 node Identifier field.
>
> This avoids relying on device enumeration order and provides a stable
> per-device identifier. A subsequent patch will use the same identifier
> when generating the DSDT description for Tegra241 CMDQV, ensuring that
> the IORT and DSDT entries refer to the same SMMUv3 instance.
>
> No functional change intended.
besides changes the IORT table
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  include/hw/arm/smmuv3.h  | 1 +
>  hw/arm/smmuv3.c          | 2 ++
>  hw/arm/virt-acpi-build.c | 4 +++-
>  hw/arm/virt.c            | 3 +++
>  4 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 648412cafc..73b8f39aaa 100644
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
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 468135bb24..c1f84bedd4 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2109,6 +2109,8 @@ static const Property smmuv3_properties[] = {
>       * Defaults to stage 1
>       */
>      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> +    /* Identifier used for ACPI IORT SMMUv3 (and DSDT for CMDQV) generation */
> +    DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index ae78e9b9e0..20605185c5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -342,6 +342,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>  typedef struct AcpiIortSMMUv3Dev {
>      int irq;
>      hwaddr base;
> +    uint8_t id;
>      GArray *rc_smmu_idmaps;
>      /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
>      size_t offset;
> @@ -404,6 +405,7 @@ static int populate_smmuv3_dev(GArray *sdev_blob, VirtMachineState *vms)
>                                                 &error_abort));
>          sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
>          sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
> +        sdev.id = object_property_get_uint(obj, "identifier", &error_abort);
>          pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>          sbdev = SYS_BUS_DEVICE(obj);
>          sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> @@ -630,7 +632,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                       (ID_MAPPING_ENTRY_SIZE * smmu_mapping_count);
>          build_append_int_noprefix(table_data, node_size, 2); /* Length */
>          build_append_int_noprefix(table_data, 4, 1); /* Revision */
> -        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
> +        build_append_int_noprefix(table_data, sdev->id, 4); /* Identifier */
>          /* Number of ID mappings */
>          build_append_int_noprefix(table_data, smmu_mapping_count, 4);
>          /* Reference to ID Array */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c75a8d6e9e..44c6b99c96 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3138,6 +3138,7 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>      }
>  }
>  
> +static uint8_t smmuv3_dev_id;
nit: I would rather put that at the top of the file
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                              DeviceState *dev, Error **errp)
>  {
> @@ -3196,6 +3197,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                       OBJECT(vms->sysmem), NULL);
>              object_property_set_link(OBJECT(dev), "secure-memory",
>                                       OBJECT(vms->secure_sysmem), NULL);
> +            object_property_set_uint(OBJECT(dev), "identifier", smmuv3_dev_id++,
> +                                     NULL);
>          }
>          if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
>              hwaddr db_start = 0;
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


