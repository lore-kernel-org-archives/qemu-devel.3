Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10044C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 14:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJw6H-0000kX-8p; Wed, 19 Jun 2024 10:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1sJw6F-0000jY-8V
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1sJw6C-00089E-00
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718806542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMkg0L7ModefSYrrZeLbSqC61xXKlvilxyq3Scu0Bt4=;
 b=WH0Ec10pLzjuxBHx6BAanMDZmGaHXa1M+JYQuQR4ilzGYvmDI1HLCZNOZt0sSsdxGetFS6
 KQHFhJRwzWNC5YBxSqLxoJKFWZ+ZezGxhQKe23qDP8lkzOIG9bUuUfSrkhE7wO2ulUSs40
 z5a2XEV6vd4XN8m3KjObI0tBVJ/plVw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-uJqgWrFZNACx-tcDgfbuOA-1; Wed, 19 Jun 2024 10:15:40 -0400
X-MC-Unique: uJqgWrFZNACx-tcDgfbuOA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6f97385286bso7969660a34.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718806540; x=1719411340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vMkg0L7ModefSYrrZeLbSqC61xXKlvilxyq3Scu0Bt4=;
 b=UVVHtVIMhxShEufGMTXeynl8hEQvRAMJTwqR/7fWDBYzOQRx+3OSZppyicTB1h1aGd
 DYOry2YExZIjbHkTPtvsIjYxiUZEutPPAdS2Z6pvC4/e5z7lGXczIGfo/oYe9YKONyh7
 SKTzjJ7KEA/LWG4dby4EEGBU/I5fLwGDLPKlT3WGEHzA1a0FomjIdUQEnpmXZaj1PEVb
 +TdKGoHMoEDP2083u1W/VeT+Kd4WO4hp4uPOtxXRVq2pUXBqYkzV7cSgM2pgIMn0IEOa
 50BGQhuD8RHK9AJHJbqVxIf04a3qquVPcLzbbNTN5Xpc1hxWaKuX08HEOKECBlYT1asm
 68dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxZQeihlPVEdemtaf8OWuctwMkXK4O1S1oSF4z6chGuyRhbM6pyiT/y4hQhrNFTOsSZACpILIoh6rR/3B4jXuLnFat6Zw=
X-Gm-Message-State: AOJu0Yw7L99QuUsQBKJ266kDT0N5CRi6vWy3Lzfl5uaniSLGJJaEe75g
 fBYvuKB/Babvchq9R36uJE/2/vFCKO0hHaWcHDG0xib3HvcX93iJXXNNgClTNyJH1xpfERvwK/O
 R7N2esbrWJ6GzjY4kvCnGVLmwcewQ3QJK+5AFsVO9q2Wwyxt6aAj4
X-Received: by 2002:a9d:69c1:0:b0:6f9:eb37:b49a with SMTP id
 46e09a7af769-70076dfa554mr2668256a34.36.1718806539615; 
 Wed, 19 Jun 2024 07:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXv6X2OUzDO2SGOrMROmdVcYYHDfrQBqaorcvbXXxiwJsiNTX2ajiLbzzjlu3ISFH6PkQDKA==
X-Received: by 2002:a9d:69c1:0:b0:6f9:eb37:b49a with SMTP id
 46e09a7af769-70076dfa554mr2668234a34.36.1718806539159; 
 Wed, 19 Jun 2024 07:15:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm77026346d6.68.2024.06.19.07.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 07:15:38 -0700 (PDT)
Message-ID: <aa27c94c-099b-4383-a93f-30ffdf5cfd54@redhat.com>
Date: Wed, 19 Jun 2024 16:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 wangxingang5@huawei.com, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240618211110.922809-1-nicolinc@nvidia.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240618211110.922809-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Nicolin,

On 6/18/24 23:11, Nicolin Chen wrote:
> It's observed that Linux kernel booting with the VM reports a "conflicting
> mapping for input ID" FW_BUG.
> 
> The IORT doc defines "Number of IDs" to be "the number of IDs in the range
> minus one", while virt-acpi-build.c simply stores the number of IDs in the
> id_count without the "minus one". Meanwhile, some of the callers pass in a
> 0xFFFF following the spec. So, this is a mismatch between the function and
> its callers.
> 
> Fix build_iort_id_mapping() by internally subtracting one from the pass-in
> @id_count. Accordingly make sure that all existing callers pass in a value
> without the "minus one", i.e. change all 0xFFFFs to 0x10000s.
> 
> Also, add a few lines of comments to highlight this change along with the
> referencing document for this build_iort_id_mapping().
> 
> Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v3:
>  * Added "-1" internally in build_iort_id_mapping() instead
>  * Added comments to highlight this and referencing doc
> v2:
>  https://lore.kernel.org/all/20240617223945.906996-1-nicolinc@nvidia.com/
>  * Moved "-1" to the same line of id_count calculation
>  * Added "+1" to the next_range.input_base calculation
> v1:
>  https://lore.kernel.org/all/20240613234802.828265-1-nicolinc@nvidia.com/
> 
>  hw/arm/virt-acpi-build.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c3ccfef026..ee6f56b410 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -209,12 +209,20 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>  #define ROOT_COMPLEX_ENTRY_SIZE 36
>  #define IORT_NODE_OFFSET 48
>  
> +/*
> + * Input Output Remapping Table (IORT) -- Table 4 ID mapping format
> + * Conforms to "IO Remapping Table System Software on ARM Platforms",
> + * Document number: ARM DEN 0049E.b, Feb 2021
I would rather explain what the function does, ie append an ID mapping
entry as desribed in Tabble 4 ID Mapping format.

Also while at it you may use a more recent revision
There is DEN0049E_IO_Remapping_Table_E.f.pdf available

Besides:

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric



> + *
> + * Note that @id_count will be internally subtracted by one, following
> + * the IORT spec.
> + */
>  static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
>                                    uint32_t id_count, uint32_t out_ref)
>  {
> -    /* Table 4 ID mapping format */
>      build_append_int_noprefix(table_data, input_base, 4); /* Input base */
> -    build_append_int_noprefix(table_data, id_count, 4); /* Number of IDs */
> +    /* Number of IDs - The number of IDs in the range minus one */
> +    build_append_int_noprefix(table_data, id_count - 1, 4);
>      build_append_int_noprefix(table_data, input_base, 4); /* Output base */
>      build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
>      /* Flags */
> @@ -306,8 +314,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>  
>          /* Append the last RC -> ITS ID mapping */
> -        if (next_range.input_base < 0xFFFF) {
> -            next_range.id_count = 0xFFFF - next_range.input_base;
> +        if (next_range.input_base < 0x10000) {
> +            next_range.id_count = 0x10000 - next_range.input_base;
>              g_array_append_val(its_idmaps, next_range);
>          }
>  
> @@ -366,7 +374,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          build_append_int_noprefix(table_data, 0, 4);
>  
>          /* output IORT node is the ITS group node (the first node) */
> -        build_iort_id_mapping(table_data, 0, 0xFFFF, IORT_NODE_OFFSET);
> +        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>      }
>  
>      /* Table 17 Root Complex Node */
> @@ -419,7 +427,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>      } else {
>          /* output IORT node is the ITS group node (the first node) */
> -        build_iort_id_mapping(table_data, 0, 0xFFFF, IORT_NODE_OFFSET);
> +        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>      }
>  
>      acpi_table_end(linker, &table);


