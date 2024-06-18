Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EEAC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 09:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVTv-0001QC-WE; Tue, 18 Jun 2024 05:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJVTo-0001F8-1o
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJVTl-00077w-Dl
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718704216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LRf7y9SmTWS1O7rTRQ7LZA0XDng8aTzanJkZ6/HRnAE=;
 b=faxHAna5fo37BllvWk+rA5eszj3WEaudoE96iGuFZCdbFTIB1w951IEpzzhO7ZzVByiW/8
 f75usNtorgKHktS1Cu7Hvpf7qs5kocS9VGJdfum32RHrUDQNp5QfS6bfnbFbq+EnoZ4OIA
 3zNe450nKf4OnW3sPf5rzcm8PdrKmsA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-11uRa1FTPVuW8r6COEjjew-1; Tue, 18 Jun 2024 05:50:10 -0400
X-MC-Unique: 11uRa1FTPVuW8r6COEjjew-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35f218c9950so2770568f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 02:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704209; x=1719309009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRf7y9SmTWS1O7rTRQ7LZA0XDng8aTzanJkZ6/HRnAE=;
 b=CqR1Fv7AOYF/YaVOHXu0eBPi/tm6On63p4LI8z2ke1eRyzZ4dWhQH5pH1vY5Bzs5Ep
 QHS/RyIlmkmcne9myOVrW72Yd+3ju3/S2nuq6WsBbzl6fbupeX/dtpSp+et8on4vuPrg
 javcW/9xdM4sTRwci1CgSThusSWc99Ek9GPjm9Y8hOEFyqea+h4UDHF2eDuEKdTerGao
 EgV26xOshb8DhYbE9iQaecMtxvby0kojK99p6lDVEmHUs+6SWVwC9rnrT4gWx97oBLpa
 LMc+4w4tSF0975Aa43imrDXB6Mf1UZYJFecWBPiAuhsD4/HQcwhCpEgMdrCx9+r3CKKg
 bjSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS93p16r18MJ/LoW4+GiFjU7UDXfMqbQ06z04YNcLwYNAlue+jfj8xPSbfwNytEkbe4uKhQBhDiY3mAYDhsq4q41OuREQ=
X-Gm-Message-State: AOJu0Yz9SH8+wvtY+vFqgpgmWhw4QMdR36prOnhO3Wl5Grqmog4BUKp/
 l/7gXLYBV2icAU0qY5YJGrH3C5pVBhUxEtDcxMYPvs+8s9bNPx+2Ww9ztnr/8XGWGG1dEL/7p7G
 NdyY1g1Wq5TSXeoTGSfqw/P8iS8Q6nnU7IgXIQaCauoefQQtfAGvk
X-Received: by 2002:a5d:5452:0:b0:35f:2cd1:a394 with SMTP id
 ffacd0b85a97d-3607a745899mr10903704f8f.22.1718704209269; 
 Tue, 18 Jun 2024 02:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg7COyriIZFF3aA/r0yjVjM+eFBMhYsMQq3W7pLycdasM9f1XJ5j3uY1aItc9TYMfN6MAYaQ==
X-Received: by 2002:a5d:5452:0:b0:35f:2cd1:a394 with SMTP id
 ffacd0b85a97d-3607a745899mr10903659f8f.22.1718704208274; 
 Tue, 18 Jun 2024 02:50:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075114dcfsm13731296f8f.114.2024.06.18.02.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 02:50:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 05:49:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, wangxingang5@huawei.com,
 shannon.zhaosl@gmail.com, imammedo@redhat.com, anisinha@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/arm/virt-acpi-build: Fix IORT id_count
Message-ID: <20240618054729-mutt-send-email-mst@kernel.org>
References: <20240617223945.906996-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617223945.906996-1-nicolinc@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, Jun 17, 2024 at 03:39:45PM -0700, Nicolin Chen wrote:
> The IORT doc defines "Number of IDs" ("id_count" in the virt-acpi-build)
> to be "the number of IDs in the range minus one". Otherwise, Linux kernel
> reports "conflicting mapping for input ID" FW_BUG at the overlapped ID.
> 
> Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v2:
>  * Moved "-1" to the same line of id_count calculation
>  * Added "+1" to the next_range.input_base calculation
> v1:
>  https://lore.kernel.org/all/20240613234802.828265-1-nicolinc@nvidia.com/
> 
>  hw/arm/virt-acpi-build.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c3ccfef026..631f2c6d04 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -243,7 +243,8 @@ iort_host_bridges(Object *obj, void *opaque)
>  
>              AcpiIortIdMapping idmap = {
>                  .input_base = min_bus << 8,
> -                .id_count = (max_bus - min_bus + 1) << 8,
> +                /* id_count is the number of IDs in the range minus one */
> +                .id_count = ((max_bus - min_bus + 1) << 8) - 1,
>              };
>              g_array_append_val(idmap_blob, idmap);
>          }
> @@ -298,11 +299,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>  
>              if (next_range.input_base < idmap->input_base) {
> -                next_range.id_count = idmap->input_base - next_range.input_base;
> +                /* id_count is the number of IDs in the range minus one */
> +                next_range.id_count = idmap->input_base -
> +                                      next_range.input_base - 1;
>                  g_array_append_val(its_idmaps, next_range);


What about other places where id_count is set?


>              }
>  
> -            next_range.input_base = idmap->input_base + idmap->id_count;
> +            next_range.input_base = idmap->input_base + idmap->id_count + 1;
>          }
>  

Given this was different previously, did you actually test with multiple ranges?

>          /* Append the last RC -> ITS ID mapping */
> -- 
> 2.43.0


