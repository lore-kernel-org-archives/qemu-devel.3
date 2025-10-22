Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19F0CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYNH-0000lg-Pk; Wed, 22 Oct 2025 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBYNG-0000lY-Sl
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBYNE-0002ib-FL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761137727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t+7xKVR7fHAoVkfJT9gJOfAj2KYGzzlOHZQDLE3uKkE=;
 b=GHHjbAWqGLJFVBbFYTzyY5+Eb9QkMQrn130jNOrqqgZFicg0QDmSMQOSYfggt02hwI2pbH
 4aSg82agTN0ub5vIMVmEoeZ/PiSO+LOHs16IHjkASaxKHO1aSxepc6EKNPT4CSWEGgTjj7
 2K47/zx7HdGNltyWL8tQIFaVHILkpu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-iRWVM1HMN0qj1TleY2OD0A-1; Wed, 22 Oct 2025 08:55:24 -0400
X-MC-Unique: iRWVM1HMN0qj1TleY2OD0A-1
X-Mimecast-MFC-AGG-ID: iRWVM1HMN0qj1TleY2OD0A_1761137724
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4721b4f3afbso18916575e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 05:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761137723; x=1761742523;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t+7xKVR7fHAoVkfJT9gJOfAj2KYGzzlOHZQDLE3uKkE=;
 b=uIMpN9AAPbEhaJNdY1kFaUXiHvSJ2C8fQxuUgBede06U/sKUdwZHbdyUNSghgwz3tT
 0ll9YqWMP8Ss6Xjnk4tw8pw2SNZHagjpU2Xu1t28iSV+VSNvunERlEVNctdEwC0iVQyC
 JnAxwJFfRfMKAL+RcehYyjDeM3T+CT/Tq1S7cszehHqQ3Eg+7PZf/jzfiCVaGsdXtRFe
 KfB+dZ1C3i86DKMg6iu9h/u5paYLi0YIpw5zJQ8ch8SSqp3WLLzeUS8zDDBqHRO3ROry
 HYvxTsyXxJcDfO4WRr9l26/ROouMvKI2PmqyHfYKBsXFZup1DDXdS1D/+Yls2EernWvG
 zh2A==
X-Gm-Message-State: AOJu0Yxx2c0e6kXadSHfCI7VWFZaD4H9PNjjNf9osrsJx4TyskBURckc
 xSPmTVKHy1kTyaSQoIDW+eQ3s6DieVu1pWyvfCRdjRpqi2Ko4pUg5t5l+XtZCLKKIg9r7IvemLl
 o6SH22fEneoC98Tgua5Fjvh0TEgjJFYl8d+agCbv+L8PC0glAScKfGKjv5cPxukE1L/xDgl3zag
 HgqMBvDeRw1IfaHP9nQuLzF2tni1dKCN5ynQ==
X-Gm-Gg: ASbGncvw7OMeqjPBdUcq+RFZkrLGvyNpMStBrKexTeMsWlw6U6vegve4IdexxgpLigy
 oNEl5RgkvRKJEohoTyTl3fWe36JdzHA31LzkNltY4sdZZj6Cp7IsIKU5GUloL1qCiGB377RYr+s
 by1vCom9CqSIoNRAMAosQ0Nunp6nc8vvmk7A0k6u3fIEFQWZ4R7WCiJlzegdTkTFgojHwAxkSFu
 Pm7HOdxeWHsCdhVJi84Q1EN7Bk76Wd8DxLQIPYGJEr2vjyAOQr7B71Q2EDgAYSaZx7T9tPCs0oF
 vvbtBs28oudUP3KkBFB2tD1Xy5Z1B67qi/xg6iLXFNlPbB49CYrdtAA9ObAOcX25yVuwB/LWYxP
 HQQFLljgs89CgVRc4Krcbv3t1i9Y6pCxRDzkHpA==
X-Received: by 2002:a05:600c:458b:b0:471:1702:f41a with SMTP id
 5b1f17b1804b1-47117919f1bmr160594365e9.33.1761137723288; 
 Wed, 22 Oct 2025 05:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG71rr4K/PV8BS5tB5Oog4fWy3wy7Lw385AVCenQso38OGtcPzbzY9gDtUtFbJjpg4hqGKIfw==
X-Received: by 2002:a05:600c:458b:b0:471:1702:f41a with SMTP id
 5b1f17b1804b1-47117919f1bmr160594165e9.33.1761137722787; 
 Wed, 22 Oct 2025 05:55:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b5esm50158365e9.15.2025.10.22.05.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 05:55:22 -0700 (PDT)
Message-ID: <09fddc7e-685e-4853-a352-87737cf30b26@redhat.com>
Date: Wed, 22 Oct 2025 14:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] vfio queue
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20251022121846.874152-1-clg@redhat.com>
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
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Michael,

On 10/22/25 14:18, Cédric Le Goater wrote:
> The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:
> 
>    Merge tag 'pull-request-2025-10-21' of https://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20251022
> 
> for you to fetch changes up to ecbe424a63c9f860a901d6a4a75724b046abd796:
> 
>    vfio: only check region info cache for initial regions (2025-10-22 08:12:52 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fix CPR transfer
> * Add support for VFIO_DMA_UNMAP_FLAG_ALL
> * Fix vfio-user documentation
> * Update Alex Williamson's email address
> * Fix for vfio-region cache for the vGPU use case
> 
> ----------------------------------------------------------------
> Alex Williamson (1):
>        MAINTAINERS: Update Alex Williamson's email address
> 
> John Levon (3):
>        docs/system/devices/vfio-user: fix formatting
>        vfio: rename field to "num_initial_regions"
>        vfio: only check region info cache for initial regions
> 
> Zhenzhong Duan (8):
>        vfio/container: Remap only populated parts in a section
>        vfio/cpr-legacy: drop an erroneous assert
>        vfio/iommufd: Set cpr.ioas_id on source side for CPR transfer
>        vfio/iommufd: Restore vbasedev's reference to hwpt after CPR transfer
>        accel/kvm: Fix an erroneous check on coalesced_mmio_ring
>        vfio/container: Support unmap all in one ioctl()
>        vfio/iommufd: Support unmap all in one ioctl()
>        vfio/listener: Add an assertion for unmap_all
> 
>   MAINTAINERS                             |  4 ++--
>   docs/system/devices/vfio-user.rst       |  2 +-
>   include/hw/vfio/vfio-container-legacy.h |  1 +
>   include/hw/vfio/vfio-cpr.h              |  2 +-
>   include/hw/vfio/vfio-device.h           |  2 +-
>   accel/kvm/kvm-all.c                     |  3 ++-
>   hw/vfio-user/device.c                   |  2 +-
>   hw/vfio/ccw.c                           |  4 ++--
>   hw/vfio/container-legacy.c              | 38 ++++++++++++++++++--------------
>   hw/vfio/cpr-legacy.c                    | 22 +++++++++++++------
>   hw/vfio/device.c                        | 39 +++++++++++++++++++++------------
>   hw/vfio/iommufd.c                       | 26 ++++++----------------
>   hw/vfio/listener.c                      |  5 +++--
>   hw/vfio/pci.c                           |  4 ++--
>   .mailmap                                |  1 +
>   15 files changed, 86 insertions(+), 69 deletions(-)


Patch 11-12 are candidates for the stable-10.1 and patch "vfio: rename
field to "num_initial_regions" needs to be extended.

See https://github.com/legoater/qemu/commits/staging-10.1-vfio/

Thanks,

C.




