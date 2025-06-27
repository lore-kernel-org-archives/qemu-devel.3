Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B942C7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 15:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVB0J-0007qN-8W; Fri, 27 Jun 2025 11:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uVB0H-0007pt-P7
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uVB0E-0001kP-Rh
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751038113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQV5TtIlKVpVHoY5q6hFUB/cVQO58vzVnNbm5lxm68E=;
 b=R+E60U0Moz2dq5zN8L5Bo4SRrJlyqS0jk2C7W4GvsThFHv9gAfcaJNhJBT+hvX+4/T2oGE
 H9boGWVGefUDsOGS3QouhEWwgAonsGftBH0zUxqz3/D7FI2OzYme/S+vs/87jvzOP8lgIW
 unN1bXOTkoJV7wyVZJIZbiZhaPh5RJo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-mcmUiNIvPdC9ayfpyf0brg-1; Fri, 27 Jun 2025 11:28:31 -0400
X-MC-Unique: mcmUiNIvPdC9ayfpyf0brg-1
X-Mimecast-MFC-AGG-ID: mcmUiNIvPdC9ayfpyf0brg_1751038110
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so12085965e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 08:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751038110; x=1751642910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nQV5TtIlKVpVHoY5q6hFUB/cVQO58vzVnNbm5lxm68E=;
 b=EzCX0CBVUqgWnkGfzpTa/RwmqTkWXqPtJwTiZL7Pe2xbsSIxizLO/497lvvzzpkGYH
 POkCjxQtISGS7lzJswctO66FKptqNve+GgSJlVXKfB6dfQv07aEbUHQz36CFTJRuiHge
 8T8oz551uei2LhgZsTPooX/117aYQ9lbW6SMsaK0vwsan4BvTt5QBBmJGsEB+J3Me76R
 7VJ3yiwCz8Us5/Cgvzdhg2PP/bV1zEEMBWqtHbhMLr+oWe12v2NJG2wexC2N0MtT9P9C
 QEDw5NcKA3hn7CGRUFUsWFYTRkGHVhWssLsKov7DEKWkcyws/hVmf5Q5Xn4XNUo0ZnVD
 65fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpHhQMuU9EcsCNff51pbkWePvqCZ1RWOhnpsdXLw3/ONOeNoWANWSbqnhNhyalFhjAErkZsQukWwGD@nongnu.org
X-Gm-Message-State: AOJu0YxzoLuFYbESYuzMI4psfum5flIn16bxeFw6qb57YCC8mx2zGRbm
 L0utHscJ2IcyQavvRmOFuOnYVGhaNaYxJO6D59AJ4oygseI4MVIV0gAHJrV3LzLQo0gvCMtTs8B
 ZwtjUB8uOh5YJ8cv/DLbCx231AF4yO3BkcbD9Cwvolczt6Hoy2eGwmild
X-Gm-Gg: ASbGnct+CKr4EpuN+4vfOaHY96cqCqFOgfVNK3JVbag0liyIcBzOGEJepGCr+xDnUy4
 Ar43Mt8zkiUkYAglQLUwupGlPeOumz9AKsloFmF6g1UDnbKice5OBUi2O+u8RIFDTPAzACHzCcu
 iZwWKIy6ezu2UH0lIHmPIKarnwz89q9KBW8RZZD2xo7Xd5Jeo5N9JE7VCyB+dOE/g3QKEUFkfcc
 Njt9BtRNJ/sIPa6J32MzjAxJ2SZ8se6eAUQzf+mRN379pAeaV6fMkRH4a95RrCBP7zeRtb74i36
 XWsp+0NxPxhjchb6/FPiaSjYpovcKYAGLO2A8telhH/cpQsS9nJBKjtmKiGSVBqjnmfxaA==
X-Received: by 2002:a05:600c:c172:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-4538ee3458amr49038405e9.10.1751038109788; 
 Fri, 27 Jun 2025 08:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEilt7/lRyC6x0ngjzi5IxCBRXaioPc9zF2A1H+reLmWtHNovOp9QQEUWskxgFr6+lRf+nT0A==
X-Received: by 2002:a05:600c:c172:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-4538ee3458amr49037855e9.10.1751038109019; 
 Fri, 27 Jun 2025 08:28:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234b30dsm83759025e9.12.2025.06.27.08.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 08:28:28 -0700 (PDT)
Message-ID: <6990669d-7750-4f30-a11f-6ac06ffb266c@redhat.com>
Date: Fri, 27 Jun 2025 17:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] hw/arm/virt-acpi-build: Factor out
 create_its_idmaps
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
 <20250623135749.691137-6-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623135749.691137-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 6/23/25 3:57 PM, Gustavo Romero wrote:
> Factor out a new function, create_its_idmaps(), from the current
I would call it build_rc_its_idmap() to be clearer on what relationship
we build.
> build_iort code. Add proper comments to it clarifying how the ID ranges
> that go directly to the ITS Group node are computed based on the ones
> that go to the SMMU node.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c | 64 +++++++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e9cd3fb351..40a782a498 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -266,6 +266,42 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>      return idmap_a->input_base - idmap_b->input_base;
>  }
>  
> +/* Compute ID ranges (RIDs) from RC that do directly to the ITS Group node */
s/do/go
Ior use the spec terminology: that are directed to the ITS Group node
> +static void create_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
> +{
> +    AcpiIortIdMapping *idmap;
> +    AcpiIortIdMapping next_range = {0};
> +
> +    /*
> +     * Based on the RID ranges that go to the SMMU, determine the bypassed RID
same here
> +     * ranges, i.e., the ones that go directly to the ITS Group node, by
> +     * subtracting the SMMU-bound ranges from the full RID range, 0x0000–0xFFFF.
substracting
> +     */
> +     for (int i = 0; i < smmu_idmaps->len; i++) {
> +        idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> +
> +        if (next_range.input_base < idmap->input_base) {
> +            next_range.id_count = idmap->input_base - next_range.input_base;
> +            g_array_append_val(its_idmaps, next_range);
> +        }
> +
> +        next_range.input_base = idmap->input_base + idmap->id_count;
> +    }
> +
> +    /*
> +     * Append the last RC -> ITS ID mapping.
> +     *
> +     * RIDs are 16-bit, according to the PCI Express 2.0 Base Specification, rev
> +     * 0.9, section 2.2.6.2, "Transaction Descriptor - Transaction ID Field",
> +     * hence, the end of the range is 0x10000.
> +     */
> +    if (next_range.input_base < 0x10000) {
> +        next_range.id_count = 0x10000 - next_range.input_base;
> +        g_array_append_val(its_idmaps, next_range);
> +    }
> +}
> +
> +
>  /*
>   * Input Output Remapping Table (IORT)
>   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> @@ -276,7 +312,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      int i, nb_nodes, rc_mapping_count;
>      size_t node_size, smmu_offset = 0;
> -    AcpiIortIdMapping *idmap;
>      uint32_t id = 0;
>      GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>      GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> @@ -287,34 +322,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_table_begin(&table, table_data);
>  
>      if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> -        AcpiIortIdMapping next_range = {0};
> -
>          object_child_foreach_recursive(object_get_root(),
>                                         iort_host_bridges, smmu_idmaps);
>  
>          /* Sort the smmu idmap by input_base */
>          g_array_sort(smmu_idmaps, iort_idmap_compare);
>  
> -        /*
> -         * Split the whole RIDs by mapping from RC to SMMU,
> -         * build the ID mapping from RC to ITS directly.
> -         */
> -        for (i = 0; i < smmu_idmaps->len; i++) {
> -            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> -
> -            if (next_range.input_base < idmap->input_base) {
> -                next_range.id_count = idmap->input_base - next_range.input_base;
> -                g_array_append_val(its_idmaps, next_range);
> -            }
> -
> -            next_range.input_base = idmap->input_base + idmap->id_count;
> -        }
> -
> -        /* Append the last RC -> ITS ID mapping */
> -        if (next_range.input_base < 0x10000) {
> -            next_range.id_count = 0x10000 - next_range.input_base;
> -            g_array_append_val(its_idmaps, next_range);
> -        }
> +	/*
> +	 * Knowing the ID ranges from the RC to the SMMU, it's possible to
> +	 * determine the ID ranges from RC that go directly to ITS.
are directed to
> +	 */
> +        create_its_idmaps(its_idmaps, smmu_idmaps);
>  
>          nb_nodes = 3; /* RC, ITS, SMMUv3 */
>          rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
Thanks

Eric


