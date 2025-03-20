Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B563C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvBmB-0005Uc-EO; Thu, 20 Mar 2025 05:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvBmA-0005UT-6X
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvBm7-0006hR-QR
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742461274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IDOatFb6lw73PavCBgnjnPB86MPsvDAk8PosacfTSmc=;
 b=eVFX6sikzjHgICJKRQDrnNLy+ykqZABhGnNJCJTVqwe7gZMsGFpYBRnRbwUGy7IPwn6Gau
 0qhbxflG2+t3bCOMgU1A9VpE6EfsCuDu9Kn+OxJvjoaEAtUBOt98/u6UUakcWQAN/YH0dI
 Oarc823SZaSvCGfuQEe5TpnKSy1BMtg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-Y4EmJELTPuupTBtOoXkUrw-1; Thu, 20 Mar 2025 05:01:08 -0400
X-MC-Unique: Y4EmJELTPuupTBtOoXkUrw-1
X-Mimecast-MFC-AGG-ID: Y4EmJELTPuupTBtOoXkUrw_1742461267
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so3123425e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 02:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742461267; x=1743066067;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDOatFb6lw73PavCBgnjnPB86MPsvDAk8PosacfTSmc=;
 b=fEfBYZ9mbzZF7+2ziW+QktumPOIdPU9o7Q63YkinJlHQyYYON2VsrhZ7j8tSE+9laP
 4aeX2hwH7+V416EcZgqE9Stx37l0Oj6hVzfYE09ZXLPK8cExlz1d9cGXgOrO4wR+fap1
 YjvF7rxM2GuzN1+7UBPl41rSZvGg6FCzOAwFvqipgmGx0eJpXilVIwDGwXQNqVUgUQcA
 hZ9m8ea7tJpFRk9lsTgaQMEjp6Z1YVOJsouHSoG9DJD00fz8wW51WIO03Z8VE2L/g1wc
 TaJVIfa02K+Vkuixxwyey5IlEIpdq2SKT9rfrQu2teh9acTYzrYuYaXwOUtrCK7qiSWH
 TbQQ==
X-Gm-Message-State: AOJu0YykwexQlYFMD8itji3dknMDqIPjj1LKlbsS4QHW3x2kvHsKLEby
 GQWeV5up+9PWlLcu1N7XbboBqzCLrh+fOXeVeo6qwe4HvFmK1YjeQrFixUGHN5TmP2ZmUffSwni
 9zBptYy8MEchhnY68N4jLcV1ylpZGsJ2XRI7fVeWFs1qraRqWg9h0
X-Gm-Gg: ASbGncsbQplbIPufUYaI5IyRw/tlqAG5J7lT78JNCDQq+oDb02zjcy+7RKRABGtbuOr
 sO1LH9eSzlmLun27+WmKDHaPvJgf8BvPB9FuMnbmQnIvGouiEsF2tnMgBj0aL6Y9i9nsat8b+ZW
 IxeqdOp0RRWKFKNngZiAyLIkO9KHqu72FNoU/8gLkCCI0TkUNWm0Pw3JlRfrvVo4s02i9bSA7JI
 MGH/sP1halwN+ZYKT/AZhdMv6+qnMvFKB63qjtW3Yawizjb2geuGKH5TYQ/7kqmmhTwQM3eqKJL
 J/ytBpOmSOBPWvltJ9qusDAT5ddKTPU6F5XPQMdCepzQI01L/p9gEA==
X-Received: by 2002:a05:600c:1e1b:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-43d49539900mr19508335e9.10.1742461266814; 
 Thu, 20 Mar 2025 02:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTXJd++fK85W4AY5kohptNGRfsdJOtyutWqeujZxOPH1o3SLeY4MpwbqeuaRsvmhCPu+AaOg==
X-Received: by 2002:a05:600c:1e1b:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-43d49539900mr19507855e9.10.1742461266394; 
 Thu, 20 Mar 2025 02:01:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f32fb3sm41867445e9.2.2025.03.20.02.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 02:01:05 -0700 (PDT)
Message-ID: <abc8172f-612f-43d0-bb32-86830a7c9d8f@redhat.com>
Date: Thu, 20 Mar 2025 10:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 19/32] vfio: Introduce a new file for VFIODevice
 definitions
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-20-clg@redhat.com>
 <Z9r0EVytYjj+n1FE@movementarian.org>
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
In-Reply-To: <Z9r0EVytYjj+n1FE@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/19/25 17:42, John Levon wrote:
> On Tue, Mar 18, 2025 at 10:54:02AM +0100, Cédric Le Goater wrote:
> 
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..daa5bae59ca9c65ef23aa193d4e63976fcefdde0
>> --- /dev/null
>> +++ b/hw/vfio/device.c
>> @@ -0,0 +1,331 @@
>> +/*
>> + * low level and IOMMU backend agnostic helpers used by VFIO devices,
>> + * related to regions, interrupts, capabilities
> 
> This same comment is still at the top of helpers.c - and I'm not sure what
> *does* belong still in helpers.c ?
After this series, mostly low level stuff analyzing vfio_region/device_info
and KVM device related services:

vfio_bitmap_alloc
vfio_get_cap
vfio_get_device_info
vfio_get_device_info_cap
vfio_get_info_dma_avail
vfio_get_iommu_type1_info_cap
vfio_get_region_info_cap
vfio_kvm_device_add_fd
vfio_kvm_device_del_fd
vfio_kvm_device_fd



Thanks,

C.



