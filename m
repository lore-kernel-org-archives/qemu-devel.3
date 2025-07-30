Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F029AC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEec-0001Sk-Nx; Wed, 30 Jul 2025 17:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhEea-0001Rf-QD
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhEeZ-0007T1-Am
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753912080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBNwQcj+PwIrkQHFnWRwhSumqF5SAOAty53MCv7T+TU=;
 b=au1Q05XJGcx+sMwwlZqewsqVR9oeMyOqeHyjdXEzol8X30EZMQOqgUq5j/3Xnk+vct8Zuy
 7yc47Z+DMNsieJNWq5TZ24ak42KdwMTkLZcIpFBJklGbkXF/hNRN/ozkqwqDBAJzWeQfJ7
 mgnAQzhclzlB1tSjSMNgOJPSZ33iU2o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Z1jFdOLKMKuWkvqRNJbtww-1; Wed, 30 Jul 2025 17:47:58 -0400
X-MC-Unique: Z1jFdOLKMKuWkvqRNJbtww-1
X-Mimecast-MFC-AGG-ID: Z1jFdOLKMKuWkvqRNJbtww_1753912078
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7073b4fb53eso4216616d6.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753912077; x=1754516877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBNwQcj+PwIrkQHFnWRwhSumqF5SAOAty53MCv7T+TU=;
 b=BSXvmPta7/NlPZaj+O73lxOUGooCF6dT6HfFv+8Q32lKZ+UevLNtZe2Pra12568oMe
 cXPgO1+5yj77mEdD5a7gMlxSFCWHTLBMG/Ksa02SqI5zKgF08z9hwun4UyuXTd8Rrdo8
 LOAzQSIAa05Fy2Wywi9MJEMR1aVJ7uIeOvbqc1Vt6F5wnaYFOvVRZGh3OqkpuFWYsLfW
 XLSVlwc6wAhDaPT7BnCgQ2eecluWJZEO78HEQgp9LBtzeSHqcLgvUnzywTjgmmHPUkWj
 xTpthN1aeVJ7sBWLzo2Ju2rfzgdUqVzs5xcUKjPxGfCGnT+g46MTQQcejwGDj6I8hBt+
 VfcA==
X-Gm-Message-State: AOJu0YyrQzPtbW+lSSP+gyWJdYB9khayMQYsuAN3NY4y0zEN/Dt3rd46
 QRqnejeDRu2mapt40F4GRfj2ZHRV8nbvAk+Zkpt/5Sg3gh8uyiYX7uQiPMQe3cdteaeKrBbYJ/B
 R8fcJc8O5mJMMMelqU78Mh9w0M6E1QbWtDUH17jwcyrZ/ywVhriIpcUn0
X-Gm-Gg: ASbGncuANAxk6DcQy3HxJPmfOp2+r8YDMV8VNnTp9QTowFk7Ni5ixR4lDSWK5bn9v0v
 PxOOOsRdUJJum7ckgtJxvFNieLhdRiJhFvg93OyDUrhQVaF202GUt3zY+xscRejiyAwSiJfYJKE
 +C8N4kS3oMAg9+SqM6sFjKCd1YfbNzjh678XcEiPAT5568Me19ag+BotiMRy0x+oDwkOxEDI32P
 pOzfgeLVjbDjo0xh6J0BCUepMEYH3OxMxVKBqktjtkNjpaRbRCQmeTWyvxA3lzzUVjCa7JpUxC2
 HFw+xXrTBA5KAYo3QH/VMCfo4o940U5fszpVWBF6mTse0qsrBP77298Pk66QR9BETmuHNli6Vtp
 UAkqaEwDE7vywL80Oz0fJUw==
X-Received: by 2002:ad4:5aa3:0:b0:704:ac29:dda0 with SMTP id
 6a1803df08f44-70766e7f5damr74310316d6.18.1753912077268; 
 Wed, 30 Jul 2025 14:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBdH/7ZnkAVh6mIxEPLXsx8KBAoLXbnjJaJp1vL7Vib/diD5ZhM274B8VqQJK6alKF3kGhjQ==
X-Received: by 2002:ad4:5aa3:0:b0:704:ac29:dda0 with SMTP id
 6a1803df08f44-70766e7f5damr74310016d6.18.1753912076813; 
 Wed, 30 Jul 2025 14:47:56 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70729acdb93sm66604516d6.44.2025.07.30.14.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 14:47:56 -0700 (PDT)
Date: Wed, 30 Jul 2025 17:47:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 1/6] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <aIqTCITI84BNtWnp@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-2-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730123934.1787379-2-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 30, 2025 at 02:39:29PM +0200, Igor Mammedov wrote:
> diff --git a/system/memory.c b/system/memory.c
> index 5646547940..9a5a262112 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2546,6 +2546,12 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
>      }
>  }
>  
> +void memory_region_enable_lockless_io(MemoryRegion *mr)
> +{
> +    mr->lockless_io = true;
> +    mr->disable_reentrancy_guard = true;

IIUC this is needed only because the re-entrancy guard is not
per-transaction but per-device, am I right?

Maybe some comment would be nice here to explain how mmio concurrency could
affect this.  If my above comment is correct, it could also be a TODO so we
could re-enable this when it is per-transaction (even though I don't know
whether it's easy / useful to do..).

Thanks,

-- 
Peter Xu


