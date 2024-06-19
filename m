Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0693CC2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJuuf-0008Og-EX; Wed, 19 Jun 2024 08:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1sJuud-0008No-RL
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1sJuuc-0001nf-10
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718801980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndgKULfHbBt7KqzR0WHBvj2CUdfnVHZDXVN3f2R9o8I=;
 b=hQwjQeM+FCSqFfP5oJPz2KqgHKt+I8X4iOAK+9QYa6zgFT8l8SnLdn/Xgk60ars2uP4TM1
 iPCcJ5o9yfdK53lSV/GdncFo0UFeEo89XKlHaEcxQMT0AZedtdIaC79L7NJG/l6+EAgIqC
 q8GHSl7qrKN84zyASVGgzavQLEXypAA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-ETm-Dl1ZPKmasLqRzXAvOA-1; Wed, 19 Jun 2024 08:59:39 -0400
X-MC-Unique: ETm-Dl1ZPKmasLqRzXAvOA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44055f6d991so15892671cf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 05:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718801979; x=1719406779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndgKULfHbBt7KqzR0WHBvj2CUdfnVHZDXVN3f2R9o8I=;
 b=vALNZpTFbVZPt7/UWOvVLv0QJEaKkfr6XgqvvBiXkMmTfZaTo4tlE00+qA3F7PYbbk
 4rKlD2I+zqsKjYEQNPL0xdh8ePx74jvRf/+KyeLo2PqLe514p6vNBckzbF06RSzEiNwO
 bgN384Kj6BrHkOsOD/KKAarCCN2Vr4xicPDhfim809PNiOuZY+028TzfSAJ02xLTKLYa
 f+uku9CX6HfaY+jseQifeuv/soXQbaQlHnXwt6b48DIqsSdjYXTSlDdcBw22V0y8Vduy
 nAmCxXIVxkZ5TsrWswbajpUKxO13dgc/hc3VIlvXLljruPSvuqRMDLMtUsmn2fF+LagP
 plKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRfmjeZBkqSNOvWID5/GIwX5RbyKY8nSYVIXd1IyGPTsC55LRJxtqqRAGSiN+Ln6ZSm5h9znN3P2OnNyxEMjNT+ncGbz0=
X-Gm-Message-State: AOJu0YxI0fdYICVkhdbwap0L/rj9qb/2jIZmpSaKW882kf6o3XPVnfIr
 jZWb1KNqdlvYGDpCZ8ORrgHWiawGAuScfFyYtGmBta6CD4BIPATh+3iNlZk2VC50uRJAID19iYl
 4KEw5Rtk9+ZAxR+XvuLuMKMNdjXww6k9A/hMAnHl80TJY7DN7u1bB
X-Received: by 2002:a05:622a:144e:b0:444:a0b9:2ca3 with SMTP id
 d75a77b69052e-444a0b97bccmr74751621cf.7.1718801978813; 
 Wed, 19 Jun 2024 05:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHebZEnDoy3lYSlOcAlXN7Si4PSFWnkTkc+4+0FriTphhOcn+lN53wV0O2F2bFL6EBj84oGpA==
X-Received: by 2002:a05:622a:144e:b0:444:a0b9:2ca3 with SMTP id
 d75a77b69052e-444a0b97bccmr74751361cf.7.1718801978482; 
 Wed, 19 Jun 2024 05:59:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441f2ffb37bsm64689611cf.90.2024.06.19.05.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 05:59:38 -0700 (PDT)
Message-ID: <de7fd33e-b076-4743-80ae-99c146b42171@redhat.com>
Date: Wed, 19 Jun 2024 14:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt-acpi-build: Drop local iort_node_offset
To: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240619001708.926511-1-nicolinc@nvidia.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240619001708.926511-1-nicolinc@nvidia.com>
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

On 6/19/24 02:17, Nicolin Chen wrote:
> Both the other two callers of build_iort_id_mapping() just directly pass
> in the IORT_NODE_OFFSET macro. Keeping a "const uint32_t" local variable
> storing the same value doesn't have any gain.
> 
> Simplify this by replacing the only place using this local variable with
> the macro directly.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt-acpi-build.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index ee6f56b410..05af407bbd 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -277,7 +277,6 @@ static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      int i, nb_nodes, rc_mapping_count;
> -    const uint32_t iort_node_offset = IORT_NODE_OFFSET;
>      size_t node_size, smmu_offset = 0;
>      AcpiIortIdMapping *idmap;
>      uint32_t id = 0;
> @@ -423,7 +422,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
>              /* output IORT node is the ITS group node (the first node) */
>              build_iort_id_mapping(table_data, range->input_base,
> -                                  range->id_count, iort_node_offset);
> +                                  range->id_count, IORT_NODE_OFFSET);
>          }
>      } else {
>          /* output IORT node is the ITS group node (the first node) */


