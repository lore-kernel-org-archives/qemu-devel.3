Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C237FC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJdN-0001IU-2c; Tue, 04 Feb 2025 09:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfJdG-0001Gv-U1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:10:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfJdC-0002ZL-Rc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738678224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jlXq2yvAHsnVgDXcyd5BU2jCWPM85um7luLR2XbYeo4=;
 b=DFCf6kUQm5IXdssQlheE4dkocG/hmpzBLz4y6OfAiBZOnpY5y39+whdGycYZg9ZQ95Q0ZB
 WAMTST5igKr3/9ParzFeoRmu88n9IZT5TEvqqjX9YIXUHxx3VdEUgagLfp2CeBaLO+rx1A
 +RodnP+/q5ZhfdAmS9WcMuZDJXADFkE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-_iMxuXHhPBKnGXlUSJRUrw-1; Tue, 04 Feb 2025 09:10:20 -0500
X-MC-Unique: _iMxuXHhPBKnGXlUSJRUrw-1
X-Mimecast-MFC-AGG-ID: _iMxuXHhPBKnGXlUSJRUrw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-467be89d064so61178701cf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738678220; x=1739283020;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlXq2yvAHsnVgDXcyd5BU2jCWPM85um7luLR2XbYeo4=;
 b=FkJGSKajUNwfKpQkUaNV5V6WOFpTg0w8JM718iONV4wUgbc3+iTeXHKf9xLFSvpCFk
 W9aKgRogG5Zpn1Al/GniVtTLonciEk7EMKO2b5RX5+TrxBwN3oc3z6tGalN0cEnFATgh
 fbFBKsHHqE9lhaWCnMPpQouhh+g34Z/QuBrHa+SAJ3/XkyXUTDOM6w5TtSmersCCbKAb
 8YrTMzMKL+Sj0Cie+HG3ODog6am8j/kXY93JWYTi1Wy8w+dfFGhnuVqrlUFDX/x1h5rQ
 JNrI7Zihc5txMXkaPqAcP5W5ZvOXL+lE+OyTkMSMoounwO+JY0aB7MjMFURp2wKjBLVm
 JSmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbvWAiPMOMgiQi8Xs/sj7V6amW680mApIG+5cuQT8WH3E0rZACoSxo6PtdITm+BD0PBjtc02UHRl0A@nongnu.org
X-Gm-Message-State: AOJu0Yy9Ek7smEaMYy3YUca7VzuZYZLqRelFrx5N66/7gQqJi2AV/XJh
 1Cv7f/fTLA6/tYQiNHCaIgGB5VR//yUSPoWWAOPncezKGuV26SeyZAppa7a/UMvyCwqQPmKBqu6
 6v3yyE8ncKlvwHkCNvCmjqarRpr9n4Ee91kHVDB0SZcMT8STx/XkU
X-Gm-Gg: ASbGnctth+fcS8SMzkYHHSKNr13p8PgCyBvZ4k8PzyZP8s17Rk2qGTB4tO932V0aQ3K
 IgK2uVspbD1a6AlVYxSH4xoO5YaWj7/qLvqlttVjaAhV51lxjOxd3lsNb9Kt0LJMi/zJWvKrhzR
 z6lJ3RvyNU98fa2u28mooDd6bZbCwbO/On/3+KeSqVrxdHab/mBX9hHQoNe87v2RyJuRKBOM0O/
 hHRaWz7fmGneTFbr8j4Aqy+sXxPjxFGxVIQipttCStd4eDqa6RpjKIBZaDPegmsDis5EpbQcnte
 2QvdiqkEeo2Vq6Ylz7U1ohB3CK9lr6v0YkehehokHgc=
X-Received: by 2002:ac8:5d52:0:b0:467:86fa:6b72 with SMTP id
 d75a77b69052e-46fd0a6486cmr369232831cf.12.1738678219527; 
 Tue, 04 Feb 2025 06:10:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTT+rqf3Q64cVWFREB0c7R2N8Kw2lBXW0p7p+oDU/K9Bp4483/1ZY7YNowmPW+cBoUd7wAhg==
X-Received: by 2002:ac8:5d52:0:b0:467:86fa:6b72 with SMTP id
 d75a77b69052e-46fd0a6486cmr369230281cf.12.1738678217212; 
 Tue, 04 Feb 2025 06:10:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e0c20sm61099291cf.42.2025.02.04.06.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 06:10:16 -0800 (PST)
Message-ID: <a5a4a10a-88d6-478b-b5a9-00f744bf08de@redhat.com>
Date: Tue, 4 Feb 2025 15:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 07/26] vfio/container: recover from unmap-all-vaddr
 failure
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-8-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
In-Reply-To: <1738161802-172631-8-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> If there are multiple containers and unmap-all fails for some container, we
> need to remap vaddr for the other containers for which unmap-all succeeded.
> Recover by walking all address ranges of all containers to restore the vaddr
> for each.  Do so by invoking the vfio listener callback, and passing a new
> "remap" flag that tells it to restore a mapping without re-allocating new
> userland data structures.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/common.c              | 47 ++++++++++++++++++++++++++++++++++++++++++-
>   hw/vfio/cpr-legacy.c          | 44 ++++++++++++++++++++++++++++++++++++++++
>   include/hw/vfio/vfio-common.h |  6 +++++-
>   3 files changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7370332..c8ee71a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -580,6 +580,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
>   {
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
> +    vfio_container_region_add(bcontainer, section, false);
> +}
> +
> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
> +                               MemoryRegionSection *section,
> +                               bool remap)
> +{

vfio_container_region_add() is already complex enough. Please consider
doing an initial refactoring before adding a new code path. It would be
welcome !

>       hwaddr iova, end;
>       Int128 llend, llsize;
>       void *vaddr;
> @@ -614,6 +621,30 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           int iommu_idx;
>   
>           trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
> +
> +        /*
> +         * If remap, then VFIO_DMA_UNMAP_FLAG_VADDR has been called, and we
> +         * want to remap the vaddr.  vfio_container_region_add was already
> +         * called in the past, so the giommu already exists.  Find it and
> +         * replay it, which calls vfio_dma_map further down the stack.
> +         */
> +
> +        if (remap) {
> +            hwaddr as_offset = section->offset_within_address_space;
> +            hwaddr iommu_offset = as_offset - section->offset_within_region;
> +
> +            QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
> +                if (giommu->iommu_mr == iommu_mr &&
> +                    giommu->iommu_offset == iommu_offset) {
> +                    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
> +                    return;
> +                }
> +            }
> +            error_report("Container cannot find iommu region %s offset %lx",
> +                memory_region_name(section->mr), iommu_offset);

error_report() are not welcomed. We need to find a way to propagate
this error.

> +            goto fail;
> +        }

Please introduce a vfio_cpr helper for the section above and move it
under the hw/vfio/cpr* files.


>           /*
>            * FIXME: For VFIO iommu types which have KVM acceleration to
>            * avoid bouncing all map/unmaps through qemu this way, this
> @@ -656,7 +687,21 @@ static void vfio_listener_region_add(MemoryListener *listener,
>        * about changes.
>        */
>       if (memory_region_has_ram_discard_manager(section->mr)) {
> -        vfio_register_ram_discard_listener(bcontainer, section);
> +        /*
> +         * If remap, then VFIO_DMA_UNMAP_FLAG_VADDR has been called, and we
> +         * want to remap the vaddr.  vfio_container_region_add was already
> +         * called in the past, so the ram discard listener already exists.
> +         * Call its populate function directly, which calls vfio_dma_map.
> +         */
> +        if (remap)  {
> +            VFIORamDiscardListener *vrdl =
> +                vfio_find_ram_discard_listener(bcontainer, section);
> +            if (vrdl->listener.notify_populate(&vrdl->listener, section)) {
> +                error_report("listener.notify_populate failed");
> +            }
> +        } else {
> +            vfio_register_ram_discard_listener(bcontainer, section);
> +        }

idem.

>           return;
>       }
>   
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index f3a31d1..3139de1 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -26,9 +26,18 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>           error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
>           return false;
>       }
> +    container->vaddr_unmapped = true;
>       return true;>   }
>   
> +static void vfio_region_remap(MemoryListener *listener,
> +                              MemoryRegionSection *section)
> +{
> +    VFIOContainer *container = container_of(listener, VFIOContainer,
> +                                            remap_listener);
> +    vfio_container_region_add(&container->bcontainer, section, true);
> +}
> +
>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>   {
>       if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
> @@ -88,6 +97,37 @@ static const VMStateDescription vfio_container_vmstate = {
>       }
>   };
>   
> +static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
> +                                  MigrationEvent *e, Error **errp)
> +{
> +    VFIOContainer *container =
> +        container_of(notifier, VFIOContainer, cpr_transfer_notifier);
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
> +        return 0;
> +    }
> +
> +    if (container->vaddr_unmapped) {
> +        /*
> +         * Force a call to vfio_region_remap for each mapped section by
> +         * temporarily registering a listener, which calls vfio_dma_map
> +         * further down the stack. Set reused so vfio_dma_map restores vaddr.
> +         */
> +        container->reused = true;
> +        container->remap_listener = (MemoryListener) {
> +            .name = "vfio recover",
> +            .region_add = vfio_region_remap
> +        };
> +        memory_listener_register(&container->remap_listener,
> +                                 bcontainer->space->as);
> +        memory_listener_unregister(&container->remap_listener);
> +        container->reused = false;
> +        container->vaddr_unmapped = false;
> +    }> +    return 0;
> +}
> +
>   bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   {
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> @@ -104,6 +144,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
> +    migration_add_notifier_mode(&container->cpr_transfer_notifier,
> +                                vfio_cpr_fail_notifier,
> +                                MIG_MODE_CPR_TRANSFER);
>       return true;>   }
>   
> @@ -114,4 +157,5 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>       vfio_cpr_unregister_container(bcontainer);
>       migrate_del_blocker(&container->cpr_blocker);
>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
> +    migration_remove_notifier(&container->cpr_transfer_notifier);
>   }
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1e974e0..8a4a658 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -86,6 +86,9 @@ typedef struct VFIOContainer {
>       unsigned iommu_type;
>       Error *cpr_blocker;
>       bool reused;
> +    bool vaddr_unmapped;
> +    NotifierWithReturn cpr_transfer_notifier;
> +    MemoryListener remap_listener;

There are 5 attributes related to CPR, please add a CPR struct to hold
them all.



Thanks,

C.


>       QLIST_HEAD(, VFIOGroup) group_list;
>   } VFIOContainer;
>   
> @@ -311,7 +314,8 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>   
> -void vfio_listener_register(VFIOContainerBase *bcontainer);
> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
> +                               MemoryRegionSection *section, bool remap);
>   
>   /* Returns 0 on success, or a negative errno. */
>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);


