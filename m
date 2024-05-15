Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E42C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Aq0-0002Ns-QI; Wed, 15 May 2024 05:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7Apy-0002NV-Bi
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7Apw-0006N3-5N
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715764930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhEIa3ZRu6PgoDJmzXO3iM+TRbDZSJcg34GL0pwvQB4=;
 b=eB7tFKsWcYAV57xp5OWoEKMdBIx2Djbhrmp/6lJ6r6urJQoq/xnTJZuWjvCNpgEaeUkxmP
 /EXtx5zRBBCws/Y1GtRvWDsZ8EUJ/EtHoqhh/w3Twdkm7pkcbtBb0if2wLvOjFW7EKrcl0
 HmSUzHyzKQ58jqjesuFm3v7ejk+Q+C0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-LlGyVjD4Ni2BszFBMJwTZg-1; Wed, 15 May 2024 05:22:08 -0400
X-MC-Unique: LlGyVjD4Ni2BszFBMJwTZg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-69649f1894dso113445926d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715764927; x=1716369727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhEIa3ZRu6PgoDJmzXO3iM+TRbDZSJcg34GL0pwvQB4=;
 b=pGBV/R3OfxyyxJNJGCzGqj0R8Wo2GqowuWOkPGcIixxgbRcQ9oDgvInb+xzBCjX/Nz
 wABvUhmO9pRLdUil/idb9WQ2xVqdjx8ptEuufpqrO6XQ8xoe5UhjLGmungEmk0weEhLv
 zeBmZFJ03mV6W5DswiFYZmP5VI+fHp70UvJnxsyA8R6TLOF8EcJBvepU1ZtkQT2M6lC4
 toYzDGedXpbL+7jHceMUjVv34N3WBNlp1gVEOoEaJWl41JyT0W9n6qpe03d4pGu1Ecnx
 X7fy4JcyclWGNj1qpDslT1IpXfOhdMUcHCWwpwraLWG8JBWlR7oEVyqC3rkMJOGSlKF8
 p73g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaO3+6rCP7yBaLHB4pOGWeFt725lh9JA9lXYXYmQN1JpzGEVvBMzMlTh4yfpvzkAY0fhxDvj7pUhwjqhLVYXGE3J8kcoI=
X-Gm-Message-State: AOJu0YxXn1bw4z6q/I4f08/UpCy7YiVnQ8QcGyKwB7S8TJnFNhk2NcY1
 OPO0mRM6FgteaR4nkM1LetsfDJVu7myTdCP3c+VNx2wkrG4ZACP7U+Zi8Bu3cR8uuyb4u5A8Gbi
 2lmfFaDM7FbNABjJiIVkkXLdwkr+QlFdgtE4D9tDPyA2GvSvBQAVo
X-Received: by 2002:a05:6214:5c08:b0:6a0:ebca:a151 with SMTP id
 6a1803df08f44-6a1681522a7mr132140396d6.11.1715764927336; 
 Wed, 15 May 2024 02:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoKR7GSowPDgOOReNf2U7UIxtXx5cQ2Z1n3DUJeTlkgXMeCPO7zeJ2DlcZwThU6gte540BJg==
X-Received: by 2002:a05:6214:5c08:b0:6a0:ebca:a151 with SMTP id
 6a1803df08f44-6a1681522a7mr132140236d6.11.1715764926995; 
 Wed, 15 May 2024 02:22:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd282sm61760836d6.78.2024.05.15.02.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:22:06 -0700 (PDT)
Message-ID: <30f49a40-1f34-4f7f-9d9a-f8b783429690@redhat.com>
Date: Wed, 15 May 2024 11:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] vfio: Reverse test on vfio_get_xlat_addr()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-7-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-7-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 5/14/24 17:31, Cédric Le Goater wrote:
> It will simplify the changes coming after.
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v6:
> 
>  - Modified title  (Avihai)
>  - vfio_iommu_map_dirty_notify() : Modified goto label  (Avihai)
>  
>  hw/vfio/common.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c..4e2ef3d3034e72aa6a546bcb9ea1f31a0bbd5b1b 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1224,16 +1224,20 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      }
>  
>      rcu_read_lock();
> -    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> -                                    translated_addr);
> -        if (ret) {
> -            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> -                         "0x%"HWADDR_PRIx") = %d (%s)",
> -                         bcontainer, iova, iotlb->addr_mask + 1, ret,
> -                         strerror(-ret));
> -        }
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> +        goto out_unlock;
>      }
> +
> +    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> +                                translated_addr);
> +    if (ret) {
> +        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                     "0x%"HWADDR_PRIx") = %d (%s)",
> +                     bcontainer, iova, iotlb->addr_mask + 1, ret,
> +                     strerror(-ret));
> +    }
> +
> +out_unlock:
>      rcu_read_unlock();
>  
>  out:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


