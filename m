Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADF4FCA173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfFk-00023j-8x; Mon, 09 Mar 2026 14:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzfFf-00023D-Fe
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzfFd-000143-Qh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773080565;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjbYeyc/RS0ynaHNNkgIqKc7uJ/XrSLoGAdZK6ETemY=;
 b=BJAlDh3v2yEGy0hYFOrueKMtmXbZdfbkQy9jNs2o+xggmv6R1UBYdi0YHHCgoiFWvIGGbL
 zwEV8IFt1PfZeq0E3NP96KUir658RqxiMVsmSZlMoShtdf9+Oj9Nh/UP8Zfo9LXIyaspsm
 gKkCAIENYe+1wtrE8sFPTfUu3n1jugA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-GV08TLfiOo6mSlcP12aHwg-1; Mon, 09 Mar 2026 14:22:44 -0400
X-MC-Unique: GV08TLfiOo6mSlcP12aHwg-1
X-Mimecast-MFC-AGG-ID: GV08TLfiOo6mSlcP12aHwg_1773080563
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853ac455b2so13692265e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773080563; x=1773685363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjbYeyc/RS0ynaHNNkgIqKc7uJ/XrSLoGAdZK6ETemY=;
 b=wAUVGkrg1NGCFM4jao8HtSgl+96drMvo1AnQsp1fqOMUN7ezqG7VDoGIiaH3mkSOy9
 5yJkwFgkOwgV6bM262dtFT1RM0yTvFMH/pWGpbOIBPdKn7aWoX9DLS8RmlEOkEx/JzqI
 CilC85H6RVxgsrfpIKu5wDDPjCUrtA4y2knERrcCARX+myLomQLkmN9D8CrDF+ojrroL
 NeYOgiKwyMqnFDnScLdePikjAYk0NtHl4snnRUS7tSD/sUrCIefC9p26yM1pIYdo3/FX
 /TIU37VwkU1xk/1ByCXcGQTiG2hM+vLjLNiEdAQTFYvtJ8uSZT5ITx8jcdrH5UIC6vgE
 zl/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV4fb94p2qjEm7odu/mYPAyXoxVa8V9+eyEqzMOT1SKRQIzn9xNgAND38y8a4edsRweGbkEKacvjE0@nongnu.org
X-Gm-Message-State: AOJu0YzkeWV9AwPRX+VHnjZFL5KL140I0Y0OM9IrBARYw+MB3Nf5PcDH
 nguvu/JS3WONfx3wUKVftEaR0b13I1nnR58jbjs1j9Jf1yzjm53dJtIDQSWQSEn3wTG7wu8+ipo
 7yxK6OQWJX7BWlFttWIWFE5/yLGTL5N2nIKkFoTVcA7pq/27fA42jgcxO
X-Gm-Gg: ATEYQzxIJ/WGOMvxptkKQSNeCsv6noMPV8q0v/U6faMf8w1ipPrbG0/wFQsurg7v4mu
 q2J8qx/cWD1xPWE57ohMjfeFpTYkhoQT1zuRMoxJgbvrgBhdn06MOsoDAcCCA4mfVuIKJXUvy9N
 11lfCx6rdGV85WGfPtR4rGbdyLEAJQPqB49TRWA/P8zLlxmCgMRn+3Cs0aBnjMu7vcrmc8pX28O
 5kHHNmK3eZ52z0Vcq1iiKMvWME39+OFex5BIlgRoae1kBbw6HpzNyuyjV+HgmqKuB9gPKQTcxpc
 Bw7XSiTc05Fa90zzdkX/fYrZXiAUHtMRCjbiqE2J3Vx8YqOnhq+zL1TpLAPv+4zAZxLnD8vABrr
 Qtswrw5DoJrqEGe+Aay8UVtW9C0zF947ju5fOnehOkBi7u5Bmfxfh5I5fy5N2jU4QQXCHeQ==
X-Received: by 2002:a05:600c:b95:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-48526951b71mr216046025e9.17.1773080562618; 
 Mon, 09 Mar 2026 11:22:42 -0700 (PDT)
X-Received: by 2002:a05:600c:b95:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-48526951b71mr216045435e9.17.1773080562065; 
 Mon, 09 Mar 2026 11:22:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485358cd26bsm90133205e9.8.2026.03.09.11.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 11:22:41 -0700 (PDT)
Message-ID: <fb8c82d1-38e7-446a-9b04-8b2879eb181e@redhat.com>
Date: Mon, 9 Mar 2026 19:22:38 +0100
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Hum actually I see that previously the id scope was shared by all nodes,
including ITS, SMMU, RC.
So now can have its and smmu node having both id=0. And this is why you
have a change in the IORT table for its=off test.
Is it legal?

IORT spec says:

Unique identifier for this node that can be used to locate it in the
parent table. This identifier enables other ACPI tables and DSDT objects
to locate this node. This field serves in the same capacity as the _UID
object associated with ACPI device objects. Note IMPLEMENTATION NOTE: In
the simplest scheme, the Identifier might be set to the node’s index in
the array of IORT nodes in the parent IORT table. Other schemes are also
possible and permitted.

So I don't think this is valid

Eric
 

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


