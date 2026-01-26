Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7975DD13C32
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOT8-0006rE-D3; Mon, 26 Jan 2026 10:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkOT6-0006qu-Pt
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:25:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkOT5-0006qx-0v
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769441129;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aC88tyfBlD6wBcAmJYmBvqk11XST2y59jFO/H/cf2sc=;
 b=JNv2lgusqmfZnKtvShT6u3lTaqEW+3yCqvcu4xSb2ZaQkj39hz+E1NhiFsLrlJHsXZgDLM
 MCYHoS46YGyPBy1nbraOKIx7dpXPXlgc0b9jJkBN5tMht4pyfklVgJD+V8+ygYDXN60J9k
 9kxkEZS9uVAb2+zfMkdoVOYGokyZFTs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-LcgA9sE4NeyR22n4eXoPSg-1; Mon, 26 Jan 2026 10:25:28 -0500
X-MC-Unique: LcgA9sE4NeyR22n4eXoPSg-1
X-Mimecast-MFC-AGG-ID: LcgA9sE4NeyR22n4eXoPSg_1769441127
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47ee3dd7fc8so49742195e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769441127; x=1770045927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aC88tyfBlD6wBcAmJYmBvqk11XST2y59jFO/H/cf2sc=;
 b=T3YsdpXIb3Kyxsk+mkn2QzKskv0fAgCVgwVAJBy9L6RBi1tizMDLsXip/V2zcOQPIe
 6QL9f6AsJ0wgexH9bgaT/4WiK19VnkhrgRduEs2D/dQgJ5WiEtTRBGMfEspm8X0KW9J2
 vE3VWBQ4ERL1GQi7y9YLjF98l1PQIbZpLsxEcUB1fo4JW8rF0HH2oBbdmlngMkSplATb
 yG7m4Ief+IYOghonjHG8fiJnsmrQIJoLkiXrBWtSV8/KvqJME3fzEHH1g9lGNzTTExRH
 vj4HeDomHwLV+w1X7pVtyrBbuofahkePLYcU6Oagyz96W09FchI7dxwttcibMYomt6eY
 bXCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkA/PgzraPocV+BFf1k30SKJWFY0n7h16fzDrYPmdtJO+2lGLgK/+tja1bb1DRq1+DImN64koHVYfR@nongnu.org
X-Gm-Message-State: AOJu0Yz5I83VoPwZ4+VRRC7IH5Zcqo7M8NBlf/ImZbkjNOutU8WLWQ6X
 2ntlg49FMQze7VIO5e3oiY6YO1mPepTxr6tJBSFPRoTY4MJodIkfRiNQWXshYkESeiVo5c+WB0t
 +FzeKC53RK16HBiwshjK6wcC2gAu6ZIIFozqJWsFtSlBVbIiCWkfcjO9m
X-Gm-Gg: AZuq6aI2WZjUrG7tdoHZ3P12toV5XS/XpaJJhaucg4fbAxNfnf36yZbelEmElcG++Jf
 Cv2omVihEbR4JMehyltVgVoRchdcFfDHIciFgmiP3W/igEsy67gF26cOijBOoWmZ4v6mCWGUl+d
 bON+wf1M224TzNDOyO4cKY0Pd8T03ZE/ZOBKdLkImGHrGJkQZZlQt89xber2QiS4pj0ODFngclZ
 sYXjVDQakeNqKogSNbTgBWQoAPeyYSQXRP4oT1vDtklSGOn5RPV9xY8pCWuO3ozpXdOKcXOgxsf
 pW3bIKHrp1Nv96tctQnI9KRnnPo1MYa5Xed4SaU/pGeH+UGC816R6RgAbYwZpkqchenVJjlep0a
 gsWRXTdb5e06CZtk9yr858Gr8eGt/1vp5EZcEeR1/GpNZVT8aeCxSdb/g8Q==
X-Received: by 2002:a05:600c:6218:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-4805cf5ec98mr81653925e9.23.1769441126804; 
 Mon, 26 Jan 2026 07:25:26 -0800 (PST)
X-Received: by 2002:a05:600c:6218:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-4805cf5ec98mr81653555e9.23.1769441126277; 
 Mon, 26 Jan 2026 07:25:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8bebfasm336322575e9.14.2026.01.26.07.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 07:25:25 -0800 (PST)
Message-ID: <7a25f1d7-2ae9-4687-a8db-e76eb2be21c2@redhat.com>
Date: Mon, 26 Jan 2026 16:25:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/16] virt-acpi-build: Rename AcpiIortSMMUv3Dev to
 AcpiSMMUv3Dev
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-15-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> Rename struct AcpiIortSMMUv3Dev to AcpiSMMUv3Dev so that it is not
> specific to IORT. Subsequent Tegra241 CMDQV support patch will use the
> same struct to build CMDQV DSDT support as well.
>
> No functional changes intended.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/virt-acpi-build.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1e3779991e..4f8d36dae0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -339,7 +339,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>      return idmap_a->input_base - idmap_b->input_base;
>  }
>  
> -typedef struct AcpiIortSMMUv3Dev {
> +typedef struct AcpiSMMUv3Dev {
>      int irq;
>      hwaddr base;
>      GArray *rc_smmu_idmaps;
is the concept of idmap also used in DSDT?

> @@ -347,16 +347,16 @@ typedef struct AcpiIortSMMUv3Dev {
>      size_t offset;
also above offset there is
/* Offset of the SMMUv3 IORT Node relative to the start of the IORT */

Eric
>      bool accel;
>      bool ats;
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
> -    AcpiIortSMMUv3Dev sdev;
> +    AcpiSMMUv3Dev sdev;
>  
>      sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>      object_child_foreach_recursive(object_get_root(), iort_host_bridges,
> @@ -376,8 +376,8 @@ static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
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
> @@ -391,7 +391,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>      GArray *sdev_blob = opaque;
>      AcpiIortIdMapping idmap;
>      PlatformBusDevice *pbus;
> -    AcpiIortSMMUv3Dev sdev;
> +    AcpiSMMUv3Dev sdev;
>      int min_bus, max_bus;
>      SysBusDevice *sbdev;
>      PCIBus *bus;
> @@ -421,7 +421,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>  }
>  
>  /*
> - * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
> + * Populate the struct AcpiSMMUv3Dev for all SMMUv3 devices and
>   * return the total number of idmaps.
>   */
>  static int populate_smmuv3_dev(GArray *sdev_blob)
> @@ -442,10 +442,10 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
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
> @@ -479,7 +479,7 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
>  static void
>  build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
>  {
> -    AcpiIortSMMUv3Dev *sdev;
> +    AcpiSMMUv3Dev *sdev;
>      AcpiIortIdMapping *idmap;
>      int i;
>  
> @@ -487,7 +487,7 @@ build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
>          uint16_t rmr_len;
>          int bdf;
>  
> -        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
> +        sdev = &g_array_index(smmuv3_devices, AcpiSMMUv3Dev, i);
>          if (!sdev->accel) {
>              continue;
>          }
> @@ -544,13 +544,13 @@ static void
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
> @@ -581,7 +581,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>          /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
>          for (i = 0; i < num_smmus; i++) {
> -            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +            sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>              if (sdev->ats) {
>                  ats_needed = true;
>              }
> @@ -620,7 +620,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      for (i = 0; i < num_smmus; i++) {
> -        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>          int smmu_mapping_count, offset_to_id_array;
>          int irq = sdev->irq;
>  
> @@ -699,7 +699,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          AcpiIortIdMapping *range;
>  
>          for (i = 0; i < num_smmus; i++) {
> -            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +            sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>  
>              /*
>               * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
> @@ -742,7 +742,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_table_end(linker, &table);
>      g_array_free(rc_its_idmaps, true);
>      for (i = 0; i < num_smmus; i++) {
> -        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
>          g_array_free(sdev->rc_smmu_idmaps, true);
>      }
>      g_array_free(smmuv3_devs, true);


