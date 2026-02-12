Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFDCEE36B8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqb2I-0000ND-VL; Thu, 12 Feb 2026 13:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqb2F-0000J0-DC
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqb2D-0007L1-2f
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770919403;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nb798t5II4q+7FZcVBNVmqsGNZmfk7fAxkAlqZXdi1A=;
 b=fpJKZEUD0iKcoIeU8VA5xmbAODVgfpmUONclZzOtATPZAAhbr3plyJlY7bcizP9xAoBs53
 1OQ9Y9XU1hCldUWQil18X6eF6JXgrEGPMxhdApSjgUvFpDV5jUf8tjZcIfNwD30ju8t37D
 xRGJ4Ho0xAV45Kn8Qhtz47m1VSAbigI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-cMV-7ozoM5q6phsaGTeSKA-1; Thu, 12 Feb 2026 13:03:22 -0500
X-MC-Unique: cMV-7ozoM5q6phsaGTeSKA-1
X-Mimecast-MFC-AGG-ID: cMV-7ozoM5q6phsaGTeSKA_1770919401
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso745205e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 10:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770919401; x=1771524201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nb798t5II4q+7FZcVBNVmqsGNZmfk7fAxkAlqZXdi1A=;
 b=N/6UahjKZfexKvQ3LfCoNgF6zcKN7V3LCZMVw5+8j+2AW1KKEsLliViJ3DjzyXwLc4
 HtQMoVjY/4H25iLaVHVgDB8aV+TwseHAM20F3uaqewHGG0e81CrugQFnaubqYi7iaVLi
 E2ARcm/91iO57p8fjd4HHTaPgRTPIkyN30sLu91+d4WMH6jpx9D78khviKr11yf9mg3Z
 aPtnnxXmAUK95cLi7YGolxJq8ScqsOoOgec37aXTxfA8ACzY/UOGtgj8oc1WLj/pj5H0
 kt2Sh2OzgAi1sL8/2eULmB5KtFfEQGKXGikXyTpf6Ms1xL+mnOsNk/URLFpDkRhPnrFL
 5KEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4yJo6IeXxWdQPOvxyA3H2c6OSeyax8v0UzrrI5kAk9XaX4f5W/sSaZ9X1IcgUdmG4/J0nBgUb1EgA@nongnu.org
X-Gm-Message-State: AOJu0YyWR+JB4tFQNnfeV0o8Ksix1sXG61U3QySk78dRdBg/oFyK910A
 eCZc2nscO4BrmvjzYtlGXMb7FP+Rd+dARBIpSZIjtvicgqYX+KKFR64nCcQpRAP6ziCPToK7MlW
 zKiNsupdRttfMo/nNTjdqfX90Ha7pcJL0LHFGj0jE6ZsGMTbDGL0XjKY2
X-Gm-Gg: AZuq6aLYd48YkzLHlnSdcPFzIrvFDX3TwMVyy/hJddLlwhy5kHrIDUvQddnNv/JSdLL
 Sbx2AzJse71L/xYhISH3pQGLJb/js0NrSZcR84Kj/Zz2nRsc6Q4Eo7GbJQl6hWLhB9ds8qpK/X6
 I+Ah3fWksAJvDA8p+leUlVvRnelB+TH/v2cLhpoxXSBD5+C80otYBwmJ8L/O+OIkbiqAetZsiea
 9aD/vl/t77D1KjrBkJ9m+do5eysJve7drrg6d698hX+SOzK6G0z3/8wzVyK7a1wyuaizdmInhqh
 h31czmNMydIdgZqUABgzOtx4jfAX9zef2BrSfTs05OumP8k3xVOaPRmRNtpjyhBWed+7g06L3f+
 Blm00MCxw6GiJap55anRZSsFyhd5IoDhr53nEqfVxbf4LJrReoplhoOsgBgC2i+M8VRbEzw==
X-Received: by 2002:a05:600c:1d86:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-4836571faf9mr57287315e9.35.1770919400929; 
 Thu, 12 Feb 2026 10:03:20 -0800 (PST)
X-Received: by 2002:a05:600c:1d86:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-4836571faf9mr57286525e9.35.1770919400398; 
 Thu, 12 Feb 2026 10:03:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483709f7da8sm658005e9.12.2026.02.12.10.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 10:03:19 -0800 (PST)
Message-ID: <b96ecd22-192e-4414-9d2b-b5a010fe006d@redhat.com>
Date: Thu, 12 Feb 2026 19:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/24] virt-acpi-build: Rename AcpiIortSMMUv3Dev to
 AcpiSMMUv3Dev
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-22-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-22-skolothumtho@nvidia.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,

On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> Rename struct AcpiIortSMMUv3Dev to AcpiSMMUv3Dev so that it is not
> specific to IORT. Subsequent Tegra241 CMDQV support patch will use the
> same struct to build CMDQV DSDT support as well.
>
> No functional changes intended.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/virt-acpi-build.c | 44 ++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c145678185..ae3b4aac52 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -339,24 +339,28 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>      return idmap_a->input_base - idmap_b->input_base;
>  }
>  
> -typedef struct AcpiIortSMMUv3Dev {
> +typedef struct AcpiSMMUv3Dev {
>      int irq;
>      hwaddr base;
> +
> +    /*
> +     * IORT-only fields.
> +     * These are used when building IORT SMMUv3 nodes.
> +     */
>      GArray *rc_smmu_idmaps;
> -    /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
> -    size_t offset;
> +    size_t offset; /* Offset of the SMMUv3 node within the IORT table */
>      bool accel;
>      bool ats;
accel and ats seem to be only used by IORT too. So it is a bit weird to
have a so-called generic datatype which is half iort specific. Why don't
use keepAcpiIortSMMUv3Dev and flat encapsulate another object inside
with irq and base and id? Eric
> -} AcpiIortSMMUv3Dev;
> +} AcpiSMMUv3Dev;
>  
>  /*
> - * Populate the struct AcpiIortSMMUv3Dev for the legacy SMMUv3 and
> + * Populate the struct AcpiSMMUv3Dev for the legacy SMMUv3 and
>   * return the total number of associated idmaps.
>   */
>  static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> -    AcpiIortSMMUv3Dev sdev = {0};
> +    AcpiSMMUv3Dev sdev = {0};
>  
>      sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>      object_child_foreach_recursive(object_get_root(), iort_host_bridges,
> @@ -376,8 +380,8 @@ static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
>  
>  static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
>  {
> -    AcpiIortSMMUv3Dev *sdev_a = (AcpiIortSMMUv3Dev *)a;
> -    AcpiIortSMMUv3Dev *sdev_b = (AcpiIortSMMUv3Dev *)b;
> +    AcpiSMMUv3Dev *sdev_a = (AcpiSMMUv3Dev *)a;
> +    AcpiSMMUv3Dev *sdev_b = (AcpiSMMUv3Dev *)b;
>      AcpiIortIdMapping *map_a = &g_array_index(sdev_a->rc_smmu_idmaps,
>                                                AcpiIortIdMapping, 0);
>      AcpiIortIdMapping *map_b = &g_array_index(sdev_b->rc_smmu_idmaps,
> @@ -388,7 +392,7 @@ static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
>  static int iort_smmuv3_devices(Object *obj, void *opaque)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> -    AcpiIortSMMUv3Dev sdev = {0};
> +    AcpiSMMUv3Dev sdev = {0};
>      GArray *sdev_blob = opaque;
>      AcpiIortIdMapping idmap;
>      PlatformBusDevice *pbus;
> @@ -421,7 +425,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>  }
>  
>  /*
> - * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
> + * Populate the struct AcpiSMMUv3Dev for all SMMUv3 devices and
>   * return the total number of idmaps.
>   */
>  static int populate_smmuv3_dev(GArray *sdev_blob)
> @@ -442,10 +446,10 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
>  {
>      AcpiIortIdMapping *idmap;
>      AcpiIortIdMapping next_range = {0};
> -    AcpiIortSMMUv3Dev *sdev;
> +    AcpiSMMUv3Dev *sdev;
>  
>      for (int i = 0; i < smmuv3_devs->len; i++) {
> -        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>          /*
>           * Based on the RID ranges that are directed to the SMMU, determine the
>           * bypassed RID ranges, i.e., the ones that are directed to the ITS
> @@ -479,7 +483,7 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
>  static void
>  build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
>  {
> -    AcpiIortSMMUv3Dev *sdev;
> +    AcpiSMMUv3Dev *sdev;
>      AcpiIortIdMapping *idmap;
>      int i;
>  
> @@ -487,7 +491,7 @@ build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
>          uint16_t rmr_len;
>          int bdf;
>  
> -        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
> +        sdev = &g_array_index(smmuv3_devices, AcpiSMMUv3Dev, i);
>          if (!sdev->accel) {
>              continue;
>          }
> @@ -544,13 +548,13 @@ static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      int i, nb_nodes, rc_mapping_count;
> -    AcpiIortSMMUv3Dev *sdev;
> +    AcpiSMMUv3Dev *sdev;
>      size_t node_size;
>      bool ats_needed = false;
>      int num_smmus = 0;
>      uint32_t id = 0;
>      int rc_smmu_idmaps_len = 0;
> -    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
> +    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiSMMUv3Dev));
>      GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>  
>      AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
> @@ -581,7 +585,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>          /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
>          for (i = 0; i < num_smmus; i++) {
> -            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +            sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>              if (sdev->ats) {
>                  ats_needed = true;
>              }
> @@ -620,7 +624,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      for (i = 0; i < num_smmus; i++) {
> -        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>          int smmu_mapping_count, offset_to_id_array;
>          int irq = sdev->irq;
>  
> @@ -699,7 +703,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          AcpiIortIdMapping *range;
>  
>          for (i = 0; i < num_smmus; i++) {
> -            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +            sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>  
>              /*
>               * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
> @@ -742,7 +746,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_table_end(linker, &table);
>      g_array_free(rc_its_idmaps, true);
>      for (i = 0; i < num_smmus; i++) {
> -        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>          g_array_free(sdev->rc_smmu_idmaps, true);
>      }
>      g_array_free(smmuv3_devs, true);


