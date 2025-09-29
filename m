Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1A3CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 07:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v38ef-0000SY-K3; Mon, 29 Sep 2025 03:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v38ee-0000SA-AM
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 03:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v38eR-0008Fs-T3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 03:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759132212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DDJMD36QROm3jLsWGcKhljg0RMZ7que1CxnMxeb0l/g=;
 b=bQF1/Ydff0JXoUonggbVqp8VvF2uShSztvt4FJr7ATDelt6cUH/+lqa0An5PgmH4y0QMnC
 Ew6spI4f3XhCvV1U8kGsBdZD6v6K15ZOpLsyAEnos0FiRmPV1UP6aECwf+Mm5eE4YseIKD
 FuwWYuQyqMqjN8NorZWr6svrZb2JVkY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-q-meVBpJNtK6SaSN1kdoig-1; Mon, 29 Sep 2025 03:50:10 -0400
X-MC-Unique: q-meVBpJNtK6SaSN1kdoig-1
X-Mimecast-MFC-AGG-ID: q-meVBpJNtK6SaSN1kdoig_1759132209
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee10a24246so2461138f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 00:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759132209; x=1759737009;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DDJMD36QROm3jLsWGcKhljg0RMZ7que1CxnMxeb0l/g=;
 b=xJ9veM7aB/yD3oTU2xHTqs2pZcuZjyFgSOLT8o2hTyhTpe2RDwf/uQcvWF57/0FXV7
 wl2AFp2o9Eh3Qx2JrbeXMzaq8JmSeh/5vYtPQwyZBDhK+A6rX+y0BpdN+7XJ7keHlZ5g
 CEk1rT4yWOCMgyRH8zhEFUfuwvIlqCPaFNgV5bk6zXxacP0Q5oopKh34kBcXI9JzWGi3
 uWBTh84Rqe4FluHbEUKevnjUDmS2mll18vVJPNZaPnbuSJRmbVvIHX8U3lBrON8ZZpEs
 XX5lQy/BaIGLfG2Q5uh2OnRlmN0k1NGNSXEvfj3jvlXdLVT0lCbohMR+2+ynfEZb2d7d
 dv9Q==
X-Gm-Message-State: AOJu0YzReMi+g2a2/7rC4qj+jFxwIe1bI6cN0eCNYitpMUGhTjkcNpDb
 X6lQMa6VlBgW8XTlpx7ttqnvScw0ZHKN32FhONrxs7QMML7Ekc6qdcJ8eo4856SmoJq/vHEr8Ns
 ycxZM0GkF8sY8cAvM7xziwS0oDLx6Lo5IOtN3w7axdqrY5wlX8fUYSDVCq4yC2LQeAnU62h5elf
 Z6U74jOXMDVoKOxKxt6ck15ppZKljeKVkh8w==
X-Gm-Gg: ASbGncsGFqwKDzd5LVQM+9ISiOiO7DdgCzPHWsYxcSIaKe1BQiSKhMwvlfLokPQGNDg
 sps85Z3Xn5q4zOlR3AKFLCJnZYXwIU5ZmMuvE7duwsba6RROtIIkJMyg4Nqz0pNiVzVuPo/y4ja
 dVGrWVznVqzBzFletrksIx+gUHze1fN1/yZrpF0U8V/jyRyINbcmIafbCz77Fafe1fG3ngq4Iyh
 6HM2jz0aSOLnGQgt8EQNt8SL2KOFd54LYRVPvmcHQBohHTDjZ6mpuhSpaJSD0RPKnMlQX4I0poj
 GK9SPIibYFlGVb36XnLd6OcW7NyrJMUDRqmYDEDThF/IsDhgSO27RXjIOTY+m1oIFTVKGXiyjgC
 G908=
X-Received: by 2002:a05:6000:290f:b0:3f2:41c4:c7d5 with SMTP id
 ffacd0b85a97d-40e4ba39b75mr14220003f8f.36.1759132208770; 
 Mon, 29 Sep 2025 00:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjh5/G1490ypYSXDU4GnSN/TW+LBm99UbCGozZQrFjR4FO/mecl36Bue4saP3drVNChItDxw==
X-Received: by 2002:a05:6000:290f:b0:3f2:41c4:c7d5 with SMTP id
 ffacd0b85a97d-40e4ba39b75mr14219970f8f.36.1759132208224; 
 Mon, 29 Sep 2025 00:50:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e354e07f2sm82406445e9.9.2025.09.29.00.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 00:50:07 -0700 (PDT)
Message-ID: <29f56a9a-025d-458d-b37e-828150f8255d@redhat.com>
Date: Mon, 29 Sep 2025 09:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Remove workaround for kernel DMA unmap overflow bug
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250926085423.375547-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250926085423.375547-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


Applied to vfio-next.

Thanks,

C.



