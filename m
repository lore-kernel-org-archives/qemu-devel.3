Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3834C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7Fv-0000zA-5q; Mon, 03 Jun 2024 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE7Ft-0000yU-N1
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE7Fr-0002IF-Rz
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717419458;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvJZuIxuEPJUSu9dcM8tRPjCjWv7YhKj1hgSmVA1AoI=;
 b=GVt3jg1sbsuJR/RP25sttsJK8HSaIs3zXkQ+1Ce3SrIFMuomqfCBe4ROdZXEiLW01ydPgc
 XmYbQOj6RJzwcl4U2fNadWc5sCes8/EpCqmGMKLsIZViXb2Uh9Jy7UCPCGb9PHTdYBui9u
 /si+SY8T9WozR0Xp4zlK+RPFVHuQ2dY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-5LPzdKnMMbWSzo--dU450g-1; Mon, 03 Jun 2024 08:57:36 -0400
X-MC-Unique: 5LPzdKnMMbWSzo--dU450g-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6f8e2181c5dso5070541a34.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419456; x=1718024256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CvJZuIxuEPJUSu9dcM8tRPjCjWv7YhKj1hgSmVA1AoI=;
 b=Z/vm/J3tUozpFFeYSyK9qla7sDHoZLEV8HGTBSJGEw+c/7PFLgvlIpu8nm7TV1ympd
 ILmHzamlgeABM70aAt34pQsPiJHcvSmTJAcDbR/AX+/qygmyfXfC62Jsh6lpLkdCsR2x
 ppPiqPDHfTl0XitDWau7iV7VfrBwzwySh+Q255YRrLBX2BcPSw3RUL+nwcoW+y2577ra
 mwJNLYl26ce0/nSw2GlokGbXbXfVvMO0QamcNnkg+4HY0Ntb0ajjiImiS8Ip2nFeIciM
 QUjpNOJzBuI5pkvZK4DjurzRpCeToHgYg7Scj8lZchvanVT53/JRGLT63tvDecw3lapy
 PPOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxuHQbYHlORtxkQyp1t+Nmphj38UEjYabXdAdkU6huDijkHvLDEBdWEO1bWOtDWVJz6yMttH0Ebo9n7WdEvJupSItZgXY=
X-Gm-Message-State: AOJu0Yx1tuHxfizDGtVeqpIxQTqjeR9v8sS3h3lnnKIILr/IMpbjP8Kb
 o5xlTLoODvRaDdWsOM/dGyjwiRlZMHod7O/KxXvaapmEBd8HUAUFIYfQBUi06TlbjYBRRbJmK/a
 j/KN/bYkbQnb6L5UAH95lN13n7xB9Rh0I3GPPDgywxVJx8KcgJX91
X-Received: by 2002:a05:6830:1da2:b0:6f0:ad78:1b75 with SMTP id
 46e09a7af769-6f911f489fcmr8933248a34.22.1717419456171; 
 Mon, 03 Jun 2024 05:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC3mE3aWMWbbUry8kQc0SqWZMneqBwFIRbCv1FBtqSb/dfB5AXPFt1WXwoJMI7iwtQi3W2Qg==
X-Received: by 2002:a05:6830:1da2:b0:6f0:ad78:1b75 with SMTP id
 46e09a7af769-6f911f489fcmr8933215a34.22.1717419455574; 
 Mon, 03 Jun 2024 05:57:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23a1774sm39119931cf.11.2024.06.03.05.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:57:35 -0700 (PDT)
Message-ID: <c5b45d45-97ca-4c82-87ca-3b85fffb2795@redhat.com>
Date: Mon, 3 Jun 2024 14:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/19] range: Introduce range_get_last_bit()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-7-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/3/24 08:10, Zhenzhong Duan wrote:
> This helper get the highest 1 bit position of the upper bound.
>
> If the range is empty or upper bound is zero, -1 is returned.
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/qemu/range.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index 205e1da76d..4ce694a398 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -20,6 +20,8 @@
>  #ifndef QEMU_RANGE_H
>  #define QEMU_RANGE_H
>  
> +#include "qemu/bitops.h"
> +
>  /*
>   * Operations on 64 bit address ranges.
>   * Notes:
> @@ -217,6 +219,15 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
>      return !(last2 < first1 || last1 < first2);
>  }
>  
> +/* Get highest non-zero bit position of a range */
> +static inline int range_get_last_bit(Range *range)
> +{
> +    if (range_is_empty(range)) {
> +        return -1;
> +    }
> +    return 63 - clz64(range->upb);
> +}
> +
>  /*
>   * Return -1 if @a < @b, 1 @a > @b, and 0 if they touch or overlap.
>   * Both @a and @b must not be empty.


