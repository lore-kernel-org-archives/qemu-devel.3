Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8680ACDD0FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Mgb-0003sM-4R; Tue, 22 Oct 2024 17:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3MgZ-0003qJ-LC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3MgX-0007WD-8g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729633499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzMZ6MElPi0qdii/+VF7N4x3vmI6w2oOtNVQuErLgyE=;
 b=TZNnlBY09+csQ+niHFzPuEpzpB8lQSns3X9H/MB/UNqmqq+hUv0yNGBJJVVUqQf/6VpN/2
 WJUSIXmOm39sZK8QA1/fxpCxOeIS3WS1w4G4/Zj2VaAIEShUA0YqH3iPYowKkhrq7Bkj59
 xH4//feFv6Tj2lb3RYCNZjJ+1kquJas=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Yd9LaaZeOviQNt31coDofw-1; Tue, 22 Oct 2024 17:44:57 -0400
X-MC-Unique: Yd9LaaZeOviQNt31coDofw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbed928402so73949626d6.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729633497; x=1730238297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzMZ6MElPi0qdii/+VF7N4x3vmI6w2oOtNVQuErLgyE=;
 b=bK6q+hQzWW0NbBeax/bn4RVkqbfn3wbcFcQUJwgY6ZrZfRZ3gERrXwFm5ue9j7V8wq
 vJstx4dF0oL9LgWEH/aexxGfDNvek6OQFjML3Jg/ldY4/Z25YxgRBFrwKHPp7eXVbTvn
 pyKHPg4FzRjZGL43q6swXbDQvYfsNqoZCT7EYjdyNsQ8z6uRrw9EeLcXgaqQfgTFupHk
 GyzQCyniHdQY8DDxaXARLA9VHiyNE8UCt/FxN4nysuM50PfKER4VyRl+JUhdUlAXATLF
 +s+i+CiXiCEFZizMDYCdfxuROAmrb8QQtKiR+uBQnCWGlkuVkhiQ5ebabu4Qe3DWwc4K
 0klA==
X-Gm-Message-State: AOJu0Yy9xRMkWr1YJxw4GL2oSwnq+lowMlSyXHG3y5mJ/f+mh9Z2MvD6
 LEHAAZev84T71cih/8qCBQ650+ygUlDK0qOvUft4roWsSXRB7ETtDC+Ry03Tyj0sAGeASYi2BCo
 Yz+rk668PTFzC6Pupr/EzdIARuWEQ+lzyNCCvH7m85j7axk+kbiif
X-Received: by 2002:a05:6214:460f:b0:6cb:a170:68ec with SMTP id
 6a1803df08f44-6ce3424f577mr9469956d6.33.1729633497397; 
 Tue, 22 Oct 2024 14:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlgzE3WobWRkkzJMS4YgZemQ+3rCOprcQJL2juvv1f90EdvQpahL6mIvIqh5wAiF8gAIyksA==
X-Received: by 2002:a05:6214:460f:b0:6cb:a170:68ec with SMTP id
 6a1803df08f44-6ce3424f577mr9469536d6.33.1729633497053; 
 Tue, 22 Oct 2024 14:44:57 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce00999d08sm33094566d6.83.2024.10.22.14.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 14:44:56 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:44:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com
Subject: Re: [PATCH 1/2] vfio/helpers: Refactor vfio_region_mmap() error
 handling
Message-ID: <Zxgc1mKc5GKphD5d@x1n>
References: <20241022200830.4129598-1-alex.williamson@redhat.com>
 <20241022200830.4129598-2-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022200830.4129598-2-alex.williamson@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 22, 2024 at 02:08:28PM -0600, Alex Williamson wrote:
> Move error handling code to the end of the function so that it can more
> easily be shared by new mmap failure conditions.  No functional change
> intended.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/helpers.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index ea15c79db0a3..b9e606e364a2 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -395,7 +395,7 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
>  
>  int vfio_region_mmap(VFIORegion *region)
>  {
> -    int i, prot = 0;
> +    int i, ret, prot = 0;
>      char *name;
>  
>      if (!region->mem) {
> @@ -411,22 +411,8 @@ int vfio_region_mmap(VFIORegion *region)
>                                       region->fd_offset +
>                                       region->mmaps[i].offset);
>          if (region->mmaps[i].mmap == MAP_FAILED) {
> -            int ret = -errno;
> -
> -            trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
> -                                         region->fd_offset +
> -                                         region->mmaps[i].offset,
> -                                         region->fd_offset +
> -                                         region->mmaps[i].offset +
> -                                         region->mmaps[i].size - 1, ret);
> -
> -            region->mmaps[i].mmap = NULL;
> -
> -            for (i--; i >= 0; i--) {
> -                vfio_subregion_unmap(region, i);
> -            }
> -
> -            return ret;
> +            ret = -errno;
> +            goto no_mmap;
>          }
>  
>          name = g_strdup_printf("%s mmaps[%d]",
> @@ -446,6 +432,20 @@ int vfio_region_mmap(VFIORegion *region)
>      }
>  
>      return 0;
> +
> +no_mmap:
> +    trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
> +                                 region->fd_offset + region->mmaps[i].offset,
> +                                 region->fd_offset + region->mmaps[i].offset +
> +                                 region->mmaps[i].size - 1, ret);

While at it, maybe when moving we can rename s/fault/fail/ or some other
words to avoid "mmap" + "fault" being together. :) Totally not a huge deal.

Reviewed-by: Peter Xu <peterx@redhat.com>

> +
> +    region->mmaps[i].mmap = NULL;
> +
> +    for (i--; i >= 0; i--) {
> +        vfio_subregion_unmap(region, i);
> +    }
> +
> +    return ret;
>  }
>  
>  void vfio_region_unmap(VFIORegion *region)
> -- 
> 2.46.2
> 

-- 
Peter Xu


