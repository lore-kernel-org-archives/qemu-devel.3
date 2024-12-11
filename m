Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E677E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 11:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLKyx-0003g8-Aa; Wed, 11 Dec 2024 06:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLKyu-0003fc-7E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 06:34:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLKys-0000P9-NE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 06:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733916853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JNLuI8EL+wwou0tA97sIT4lGkO89puA/6Br1SCvopJ0=;
 b=hsO+zgJZTRwa5TRaiF8tlNziaP1MrLxMiObuTj8bFBeOxjq3IWctQ0UQ1d7HnCrht1GvLC
 TF5x2CLXl9HkrDL7nt4Iv+oNslX1hIafyQN5uzcQi+A27MnVjpUcHqa4bGLbIp/9RJrkKB
 KaJaUVlfIjJMS9ZArK7zw8ZwbAWdZUI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-cmwyl4pANweZC5jHWP6V4w-1; Wed, 11 Dec 2024 06:34:08 -0500
X-MC-Unique: cmwyl4pANweZC5jHWP6V4w-1
X-Mimecast-MFC-AGG-ID: cmwyl4pANweZC5jHWP6V4w
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8f94518c9so95116736d6.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 03:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733916847; x=1734521647;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JNLuI8EL+wwou0tA97sIT4lGkO89puA/6Br1SCvopJ0=;
 b=qUPSF5TUb5VvQahLZIUz4t7BJZmCxjc2LZMh+Ay/8BBknodUQQVn4vA/v7Vy23VRvY
 Qr0/yr6fmcG2/pPtCMma2+V8peUpv3pVSew+2dcu/ijTLjSNvrLasyd1C4D71Oa/EuID
 NMlB7gm3K4uD01A87dqdw3roNG/n3cHj+5Br52EAJKjTEALwDuWz3OFaHCG1r0s9xoGP
 suAI/oDYyFekg1nn1MPgZV9eGcKVdGrH4hWCotyLZvRh6UccuQ6E1BeiuUJ0BymhbVrm
 n7xZW9kDJPhdGZroo30DMxcipuPg8zJAhVQ2uE46Q5p1HdB3Spi8MZ2Lz7p2t3sBDhAJ
 RSRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqHIUpOpEeWkp6ra2ihvgszpGScb2Hu1diQGPWxPSZG9HMvMxnlgaBQB68osi5OquQEC6TbwVz1CKw@nongnu.org
X-Gm-Message-State: AOJu0YxZVAp17jadSf+yeG4M4DGvikUgLl78e319SvRkh2H4T4U+necA
 8Y5Xln7hPPIaITw8AV8iLaz/KBYldNSKA6wUoNuzfLJrIESB86vwTl33f5Z33nVb50KM8f/iGKf
 NUtNaP/lwYe2nQtdnK5VQ8H+ZCeg2Vc5CCYN0lu3SC/+MA5jQyse5
X-Gm-Gg: ASbGncvl6NE5f7fYk8Nb3zgV7t+zaZMIc78d18UZdtvNMir7NZxyvhJWydKeqrR7Fzr
 QObpHGE1/1vRdC4b6Ux91s89fSTRg/qo/CmgJcjImFuul+cuknk8h5cXjlfZ/P3/WGXlfERCYmK
 R5U+BvVojrhnC3E14edDNVMvLhK7C86IAJWH/vcTzD8ia4e68EZeO6ATfO0O1YZlDtO88X0179P
 9m9KXZdCIzryVelLRVJtqx/J2JDFgeC6aiXPJ0LOLErK4AWQf9JjerDP9M37TdwIXlAFyRZezCx
 6XHDDGY=
X-Received: by 2002:a05:6214:20e8:b0:6d8:b3a7:75ba with SMTP id
 6a1803df08f44-6d934bb0ff3mr51091816d6.45.1733916847691; 
 Wed, 11 Dec 2024 03:34:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvL8+Usf3KBBkI4jvr0XQGL0QLL2mGNZtbwIXOl73ob+L4W9+SR6jtSoaDVexA2mO4r2Hktw==
X-Received: by 2002:a05:6214:20e8:b0:6d8:b3a7:75ba with SMTP id
 6a1803df08f44-6d934bb0ff3mr51091116d6.45.1733916847183; 
 Wed, 11 Dec 2024 03:34:07 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d907713550sm38628846d6.6.2024.12.11.03.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 03:34:06 -0800 (PST)
Message-ID: <b68fd77a-b7f5-4284-84f7-e1768af6b20e@redhat.com>
Date: Wed, 11 Dec 2024 12:34:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, clegoate@redhat.com, qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241209192927.107503-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 09/12/2024 20.29, Matthew Rosato wrote:
> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
> bit set, treat this as a request to perform direct mapping instead of
> address translation.  In order to facilitiate this, pin the entirety of

s/facilitiate/facilitate/

> guest memory into the host iommu.
...
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    /*
> +     * For direct-mapping we must map the entire guest address space.  Because
> +     * the mappings are contiguous we are not restricted to individual 4K
> +     * mappings via vfio, so let's not worry about the DMA limit when
> +     * calculating the range.
> +     */
> +    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);

FWIW, you could use g_autofree to get rid of the g_free() at the end of the 
function.

> +    memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
> +                             TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
> +                             name, iommu->pba + ms->ram_size);
> +    iommu->enabled = true;
> +    iommu->direct_map = true;
>       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>       g_free(name);
>   }

  Thomas


