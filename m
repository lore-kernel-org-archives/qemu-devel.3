Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F7CC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYTq-0003WN-5X; Tue, 17 Jun 2025 11:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYKt-0002e1-Mf
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRWGl-0007mE-I7
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750166548;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQxF7NTyRAkBXCaya5YVXdNrm7Ywe0meZG4A7xYxS2Q=;
 b=V0L14hONlKZ4vzqNjuF9dJcYEoZRI5zFEcMNCIexlJJN61xiMSWwNZ/9Ybgkhz9bmrI2Tw
 ZfhWYTMdbP1R8XuoIsQpei2ELM0xyOBTtXZUDz/joviiMzefux9tt6ZnyzDddr8dxW/gHK
 Ah8y/s/SHIjhjxlew1RPpuvgBZ8zEmQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-hx9afYNIPjuKc7N9oivBOA-1; Tue, 17 Jun 2025 09:22:26 -0400
X-MC-Unique: hx9afYNIPjuKc7N9oivBOA-1
X-Mimecast-MFC-AGG-ID: hx9afYNIPjuKc7N9oivBOA_1750166545
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a578958000so1108977f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 06:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750166545; x=1750771345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQxF7NTyRAkBXCaya5YVXdNrm7Ywe0meZG4A7xYxS2Q=;
 b=rTndK6CNx3PbCe3dup0HozYYB7M2P1csy+Q8XE8F8vGKC0sQKSkF4TSIr9PBvj3IiZ
 zZKuJkjgZu0ysNZ7G2q30myF5ETbf/YYcqaaAf/zyxVyQx3BoLQrF4rvU/1nIVDxsQ/Z
 SCI6gOFsVi/NZbXOm8ig0X+F0h+S8eYFDH7cs4k0DiYmP7HPaT2rWIZMMp8BXY1pArvW
 322YEx73JWjyKma6bYU5OuXRiVcOX0zSApv7CbapnXRAHLFVkUlw20oeIC8y1tSSD6Ek
 jxfBWgUNWkeEwflWwl5zEXnXOHICpAdO3hL1Z2OChSOYkS35+Mf0ZEofb94O1v9lN7ub
 nbTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBBAPD1rIuG8VawPH6ejfxIqspTSwJrYh2E5BjuxV49xdJvgTJ38/pI4R4fWAl+PqJVgD//tM1gWFX@nongnu.org
X-Gm-Message-State: AOJu0YzZ51pigUHdIyLjA5HhJAupkamMsSbZT5kmRtOehGrMFxKaPo27
 09eRWSI/wY1P60++CzeDPQ5tC3AkVuSJqpZpUHdxUICnE+vw5T4wZLly3cAvc3Yor/ja8turP+1
 scEsBWlGEpaHaaJX56QHvjNV4o5FGuNIt5A44jOkfz7OMzQz+tBhZElqi
X-Gm-Gg: ASbGncuhOzX9uSeBTJkXv3+pPcjkg6I/i7t2b7cuK/ppR4AiRQ4lxTreS4xX6r9aY9q
 nTASVwz5UYmCN66zUUg8cLVIgVP5d/5BZhipFZ5yid/cTx1v9lzUWcRrjyBywN65FgWaaPbnkXE
 X0DogU4hdgQDtk6VDpN1CzpbcnDQgPlkWMKtqtyZIRtQ8r3MnaPlJJEf4SpvuzygknlgxmbauJB
 miTez0i0eKFHEMCPdmsWaFwBkd1ZzqBG74GnkAkl6js94hfox6H+nwJYPlb6kugc24nH0cDHvkI
 u9VLkf3NfzMVatWzSZFcwfzpbvQTkuMWUjYtLHUf98WX8hPqSwCXAaTsrACYhsp+rOXlOw==
X-Received: by 2002:a05:6000:4716:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3a5723aec40mr9172468f8f.24.1750166545290; 
 Tue, 17 Jun 2025 06:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaaT4vFaQPRhV8YkpkoOuQ67wDaKV+MHmPaZC12ylYY1YFBh+FtpB79o8UtT3XMl/kMEqOIQ==
X-Received: by 2002:a05:6000:4716:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3a5723aec40mr9172447f8f.24.1750166544887; 
 Tue, 17 Jun 2025 06:22:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532ddd29ffsm174874865e9.0.2025.06.17.06.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 06:22:24 -0700 (PDT)
Message-ID: <db5aa1ab-cec7-4de1-b14f-bba978e7d7f7@redhat.com>
Date: Tue, 17 Jun 2025 15:22:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] hw/arm/virt-acpi-build: Fix comment in build_iort
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-5-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250616131824.425315-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 6/16/25 3:18 PM, Gustavo Romero wrote:
> The comment about the mapping from SMMU to ITS is incorrect and it reads
> "RC -> ITS". The code in question actually maps SMMU -> ITS, so the
> mapping in question is not direct. The direct mapping, i.e., RC -> ITS,
> is handled a bit further down in the code, in the else block, and we
> take the opportunity to update that as well, adding "RC -> ITS" to the
> text so it's easier to see it's the direct map to the ITS Group node.
>
> Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9eee284c80..6990bce3bb 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -407,23 +407,27 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>          AcpiIortIdMapping *range;
>  
> -        /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
> +        /* Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3. */
yes this is what the code builds at this location.
>          for (i = 0; i < smmu_idmaps->len; i++) {
>              range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> -            /* output IORT node is the smmuv3 node */
> +            /* Output IORT node is the SMMUv3 node. */
>              build_iort_id_mapping(table_data, range->input_base,
>                                    range->id_count, smmu_offset);
>          }
>  
> -        /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
> +        /* Map DeviceIDs (input) from SMMUv3 to ITS Group nodes: SMMU -> ITS. */
But here I am confused. To me the its_idmaps matches the idmap between
RC and ITS. I understand this is built from holes left by bypassed
buses. See the build_iort() implementation. The comment at

        /*
         * Split the whole RIDs by mapping from RC to SMMU,
         * build the ID mapping from RC to ITS directly.
         */
        for (i = 0; i < smmu_idmaps->len; i++) {
            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);

            if (next_range.input_base < idmap->input_base) {
                next_range.id_count = idmap->input_base -
next_range.input_base;
                g_array_append_val(its_idmaps, next_range);
            }

            next_range.input_base = idmap->input_base + idmap->id_count;
        }

is not crystal clear but it looks like filling the holes into its_idmap.


Besides there is another "Its group" instance to be replaced by ITS Group

Eric

>          for (i = 0; i < its_idmaps->len; i++) {
>              range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
> -            /* output IORT node is the ITS group node (the first node) */
> +            /* Output IORT node is the ITS Group node (the first node). */
>              build_iort_id_mapping(table_data, range->input_base,
>                                    range->id_count, IORT_NODE_OFFSET);
>          }
>      } else {
> -        /* output IORT node is the ITS group node (the first node) */
> +        /*
> +         * Map bypassed RIDs (input) (don't go through the SMMU) to ITS Group
> +         * nodes: RC -> ITS.
> +         * Output IORT node is the ITS Group node (the first node).
> +         */
>          build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>      }
>  


