Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C65CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24G4-0001DD-J5; Fri, 26 Sep 2025 04:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v24G2-0001C4-33
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v24Fo-0001Zb-Jw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758876990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CG+kqXV/nhBWeEb4XcGIaqV92qh3xDH9bOURKiO0l30=;
 b=gsiQtVkUTfd+jnMpnLd60PrmACukYOLOdGGVzNu0Qz0yMtxJLLdOmpFoh3vJp8VATtkUUS
 8WgEiTRL+wvB60K6j3wp8KWhnVrsEfWVqK1OfwxZFsPqCCZRphFbZT0xW/x1UZhRKpR7LZ
 2HrFtGX9E78+p/zEny8qqt4Y9rnLVqc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-myLecGSxN_uvqzoIaSaHKA-1; Fri, 26 Sep 2025 04:56:27 -0400
X-MC-Unique: myLecGSxN_uvqzoIaSaHKA-1
X-Mimecast-MFC-AGG-ID: myLecGSxN_uvqzoIaSaHKA_1758876987
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3fba0d9eb87so824719f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 01:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758876986; x=1759481786;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CG+kqXV/nhBWeEb4XcGIaqV92qh3xDH9bOURKiO0l30=;
 b=HXHKAQ+wMZmXyQtsqmptkW/ui6OrlblJVnRRT47nBkxk/tzCjRQU+mtmEQE0/7i209
 mM6vp08U2CQPDnZTeVPN9C8dOXccuRtygVB1PSRhWvtTOZdj35WULOZJ8w58+/vmQkIG
 B4LnzGuHwH9+q1NNLUe90Gx6X0AfHyVkl3h+hKYdwAVd5hs9TE3VXK46mQPCVb6/hfrX
 eZuI3ukrUbEZXS2tyFua/izyKPxwmRn0q86HzBIPfmvdjuy8U0JSyPUREFmQ1ruSluZP
 b2yA+r+e2sDfmJHzQBtoIfc0QGMo1KU1qjFHHao3pD/igau81kqBHl8ZiLuWwZQq0hFV
 t+hA==
X-Gm-Message-State: AOJu0Yw3W4gcxj6QjDUFc4P1Ln8fmea4SZi4PMCtzsuy3Lsgbdg6l4C2
 P8TZNavP9HVe2RIdHVnTZumzyaXNXNOj3CzHAqub7CAGV3VBHUl9cJbHcpVUTTqGNeapOIsLSB6
 bAaso6nwTc1X4eNAdWcuI2jl9DYxCUndxlSa0Lcr853qubGMM14Gf5o1Da4llWf6v2Hy0bnA8T+
 HPo2FSmnSiUE4YfRBMM/C4Vb2c1y/5FqO3mQ==
X-Gm-Gg: ASbGnctysCt1l5lmayztadh5i4lGFbzj4r9TVDl79z/vH9+9HKPMf5K1heUr8EJdM9d
 sWUZ6BVHZe4uRScps0zjDNItHd3CD9idPxQEZFiDQfQIBGQ6VRF9xWGbZcj9Eq+1XfMzcuvdVtN
 B1ksn1vcza5FXFUZoEYnHBZTgboXULfTzxT7IJLbU5agWtE9ueaNFQnNdZYk+5mfun5wAp1JrmM
 LsJpVU9LdF7PwrItQ9DAkR3I/HL+up5GevTV84AAwJRbIBHRrjkpDNTgOKzDJv+Lj6X3NZ+H+uc
 oLlNJ4KEn+VHot9yDkuhN4ZRKT3XEu1NlUs9mbd2atpgiD9WTEGIEOHL90xt0xGhjZ/tvrvGC8u
 3V8Y=
X-Received: by 2002:a05:6000:2507:b0:3e4:64b0:a776 with SMTP id
 ffacd0b85a97d-40e4bf00f46mr5639368f8f.52.1758876986131; 
 Fri, 26 Sep 2025 01:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg7A94Rq4YAPw72CoVHImBhkRGMUstU7KLdCtkcWi48UvwOn+PfEI3ERmfuMmQbs+f3ALclQ==
X-Received: by 2002:a05:6000:2507:b0:3e4:64b0:a776 with SMTP id
 ffacd0b85a97d-40e4bf00f46mr5639343f8f.52.1758876985543; 
 Fri, 26 Sep 2025 01:56:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb2eesm6412149f8f.12.2025.09.26.01.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 01:56:25 -0700 (PDT)
Message-ID: <24530964-0b37-4e44-84dc-172596e9ef44@redhat.com>
Date: Fri, 26 Sep 2025 10:56:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Remove workaround for kernel DMA unmap overflow bug
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
References: <20250926085423.375547-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250926085423.375547-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

+ Zhenzhong

On 9/26/25 10:54, Cédric Le Goater wrote:
> A kernel bug was introduced in Linux v4.15 via commit 71a7d3d78e3c
> ("vfio/type1: Check for address space wrap-around on unmap"), which
> added a test for address space wrap-around in the vfio DMA unmap path.
> Unfortunately, due to an integer overflow, the kernel would
> incorrectly detect an unmap of the last page in the 64-bit address
> space as a wrap-around, causing the unmap to fail with -EINVAL.
> 
> A QEMU workaround was introduced in commit 567d7d3e6be5 ("vfio/common:
> Work around kernel overflow bug in DMA unmap") to retry the unmap,
> excluding the final page of the range.
> 
> The kernel bug was then fixed in Linux v5.0 via commit 58fec830fc19
> ("vfio/type1: Fix dma_unmap wrap-around check"). Since the oldest
> supported LTS kernel is now v5.4, kernels affected by this bug are
> considered deprecated, and the workaround is no longer necessary.
> 
> This change reverts 567d7d3e6be5, removing the workaround.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/container-legacy.c | 20 +-------------------
>   hw/vfio/trace-events       |  1 -
>   2 files changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index c0f87f774a00805cab4a8f3b3386ddd99c3d9111..25a15ea8674c159b7e624425c52953240b8c1179 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -147,25 +147,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
>           need_dirty_sync = true;
>       }
>   
> -    while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> -        /*
> -         * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
> -         * v4.15) where an overflow in its wrap-around check prevents us from
> -         * unmapping the last page of the address space.  Test for the error
> -         * condition and re-try the unmap excluding the last page.  The
> -         * expectation is that we've never mapped the last page anyway and this
> -         * unmap request comes via vIOMMU support which also makes it unlikely
> -         * that this page is used.  This bug was introduced well after type1 v2
> -         * support was introduced, so we shouldn't need to test for v1.  A fix
> -         * is queued for kernel v5.0 so this workaround can be removed once
> -         * affected kernels are sufficiently deprecated.
> -         */
> -        if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
> -            container->iommu_type == VFIO_TYPE1v2_IOMMU) {
> -            trace_vfio_legacy_dma_unmap_overflow_workaround();
> -            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
> -            continue;
> -        }
> +    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>           return -errno;
>       }
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e3d571f8c845dad85de5738f8ca768bdfc336252..7496e1b64b5de0168974a251eab698399a6a1d54 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -112,7 +112,6 @@ vfio_container_disconnect(int fd) "close container->fd=%d"
>   vfio_group_put(int fd) "close group->fd=%d"
>   vfio_device_get(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
>   vfio_device_put(int fd) "close vdev->fd=%d"
> -vfio_legacy_dma_unmap_overflow_workaround(void) ""
>   
>   # region.c
>   vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"


