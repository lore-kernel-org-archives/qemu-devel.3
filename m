Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2C7C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 08:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta9gD-0000eC-8G; Tue, 21 Jan 2025 03:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ta9gB-0000dT-5e
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ta9g9-0002wB-6a
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737448320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BfyVSrWMHEiziEzHGs6F8vZZOIls9tuwoD7VwZmXX5o=;
 b=V8P0iYlinz7UPcZOVAyz3+qXBfm1XHct5t4lBELnlDqfW7XZYX1ecJKusM7EurVpKxS9qd
 gJp14N6qBEv2Rtt361+YFlK/hijMPxiz6Esfo5JnNrgMjVpKcCctrE3AuHIgNePVeJfr4u
 WWG3wyeGj0mNemWLk1uHDr1WVVgx02E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-ddC2ER1BO5KkwdSFd5C2DA-1; Tue, 21 Jan 2025 03:31:56 -0500
X-MC-Unique: ddC2ER1BO5KkwdSFd5C2DA-1
X-Mimecast-MFC-AGG-ID: ddC2ER1BO5KkwdSFd5C2DA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43621907030so41913655e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 00:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737448315; x=1738053115;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfyVSrWMHEiziEzHGs6F8vZZOIls9tuwoD7VwZmXX5o=;
 b=RVwVXHf4egeaZ1y+OoNS91zQxMSBRWaBCZ0aL0s4YajvqsYEeI4rYjw2FZMAL2jKAa
 sj7zYnqBusXJ6bGxNRX8gceqyNsVyJcmwj/HGdMzubvzkjgTWE26doeFUKzkWIek+1hu
 HTI+tMx5ASUasXXDETuGk+z5UNpZZ1ibM+rZvZJ+++FrSln01f+ha+FNqZSl9V+I2e6q
 znlBeH4P9QNJMZXLDHm5BTWoi90JCcWC7m+O2kNE0O7EAmy9YRojZTc7HICFnBVdyFHR
 2K0vfbFYDhbKJoa+qJErusyYZByjB7MfgnUl240xUm/U6SoP/pje/pfnT/OJbGAD/LhR
 b8Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGQqDUP07QnXBfS+vEpK25LofNsj/ui6Z9ldl9AJ4HQ5C8CZfFSqUqGzXqzTd/CE7RULP2lCos+ugJ@nongnu.org
X-Gm-Message-State: AOJu0YyicvSIlSJiDh9uj031pfhNb6+TM+LOITAw7Tyo+5G3/ULsMHHT
 zfuBDnJKrxaUAt9y7wxk6H8H8nrmyDgx7L13kK5Zk7cStlpGgEc63isyncW0lRvwWLjo5KayT5A
 rntt6yto6NicGvmM6TppLh4Jf0h6gS0325MXBjGB64scZJgemad3H
X-Gm-Gg: ASbGnctkEc/tcsZvopbCr74xOp5jf4o3h+oP1Mae/+PXIVb2IltUEUE9IGQ/an9xM3h
 i/+yGhTi14+CsumGIESRNygGKW/JSqWZDzPcbaa4ybf6e7h8Ux4bI6O4L3O+g52fjSH8PAx37yn
 LP3xw23EGsbWKQOtqSJxmcxYDZ8vjVA6cotG1TjpWSY9EyQR74gBZGGL2qevI3AXnFx+9C+888E
 A9QxK7E1fAnKeLBVj2Z1kJ9SruCDnkxsnH2nv+18wUqoL8m+4EehRh4KbU3/skMe6zzk1tR8QeK
 DwtMBB/pwbYperCtkSDwJs+V6miem9KZ
X-Received: by 2002:a05:600c:3d96:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-4389143b5dbmr137259775e9.24.1737448315294; 
 Tue, 21 Jan 2025 00:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6Zo/EnA5SV3PJWuFEu2GpdE8tNqjUIAouYuirlbpdtz7tfpdn571uqB13cMF1lIaCSzRi5Q==
X-Received: by 2002:a05:600c:3d96:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-4389143b5dbmr137259395e9.24.1737448314823; 
 Tue, 21 Jan 2025 00:31:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac712sm226732715e9.12.2025.01.21.00.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 00:31:53 -0800 (PST)
Message-ID: <3aaaf5c8-b1f0-4237-b50e-bb28fd297bb1@redhat.com>
Date: Tue, 21 Jan 2025 09:31:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 sgarzare@redhat.com
Cc: zhenzhong.duan@intel.com
References: <20250120173339.865681-1-eric.auger@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
In-Reply-To: <20250120173339.865681-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

On 20/01/2025 18:33, Eric Auger wrote:
> When a guest exposed with a vhost device and protected by an
> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
> 
> Fail to lookup the translated address ffffe000
> 
> We observe that the IOMMU gets disabled through a write to the global
> command register (CMAR_GCMD.TE) before the vhost device gets stopped.
> When this warning happens it can be observed an inflight IOTLB
> miss occurs after the IOMMU disable and before the vhost stop. In
> that case a flat translation occurs and the check in
> vhost_memory_region_lookup() fails.
> 
> Let's disable the IOTLB callbacks when all IOMMU MRs have been
> unregistered.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/virtio/vhost.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6aa72fd434..128c2ab094 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener *listener,
>               break;
>           }
>       }
> +    if (QLIST_EMPTY(&dev->iommu_list) &&
> +        dev->vhost_ops->vhost_set_iotlb_callback) {
> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
> +    }
>   }
>   
>   void vhost_toggle_device_iotlb(VirtIODevice *vdev)

I think you need the counterpart in vhost_iommu_region_del() (for instance if we have an 
add after a del that results in an empty list).
But you cannot unconditionally enable it (for instance if vhost is not started)

Perhaps you should move the vhost_set_iotlb_callback() call from 
vhost_start()/vhost_stop() to vhost_iommu_region_add()/vhost_iommu_region_del()?

Thanks,
Laurent


