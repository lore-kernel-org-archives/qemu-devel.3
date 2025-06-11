Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C37C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPFpH-0003ox-A5; Wed, 11 Jun 2025 03:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPFpF-0003oV-0f
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPFpB-0001lD-QD
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749626680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9oIOosg0KdJDzReGzX57MM2aqJfqx9FMOZT+JOdobVU=;
 b=f3wWgw3swNQx90eRlS6pfJZ6t9oiOpZTHDSZmycrUx/o0h33t5pBstYV40xAbAvyvRg1SC
 9RTWj2X7aQeyLgzWqpGtts7Qw23erpB6JHTVhIN6ZRAP/TGoLvn1cetcxqTIlzS8GuVX2n
 KoNhqrrpTzf9B3+wMahBmgAPh+AasSI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-hhRPoxLTOi6xjzmp0ivdDQ-1; Wed, 11 Jun 2025 03:24:38 -0400
X-MC-Unique: hhRPoxLTOi6xjzmp0ivdDQ-1
X-Mimecast-MFC-AGG-ID: hhRPoxLTOi6xjzmp0ivdDQ_1749626677
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d9f96f61so42055325e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 00:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749626677; x=1750231477;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oIOosg0KdJDzReGzX57MM2aqJfqx9FMOZT+JOdobVU=;
 b=MfCO0p5vghDFlc9FK+AciKXABMFgtokURtX92PG/ErE1xEZlk4u5gIVduX23LTf3Bi
 +yMhfSChhtdW5h7J3ge5JC6FPwiOnzlR8uK4bff679zbXFea2CdNFMUW5OjGn6BK9/h+
 eCy1GZr+qmNcteH2uzhwMQOSWH/oqjt7VHpEn7Qm5Luax/r7EleGSwsbrQ4ROvWaRx91
 duInXMRs53Itv4MO4FPfLzrpz36gOfR2GOvbGrUnYgN5bbdGjW01r4eE5t880VcxRLL5
 pytuXqqM5CSBPCNAfZBb+QEyqn9JVEi7a0xT6n/Omp08BmYWUMj9b1jHy7pRRitLIThr
 +Wtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuF44Kl3OWRpNAErxavpB3/X+MPFLuLOK6S5N5LeIOXHiVnIi6nyIwdtD3qZ1jWqhqyIZBAfhcNi88@nongnu.org
X-Gm-Message-State: AOJu0YzvpeBflvUxDSv8a1i2GalGFaIsAGpk/2faI2Q9VWjOitv6e91J
 I0u2GeTRoHXZdz8LElvaiBWEfptmwpi7JG8ta2AIN5C5V2SMKe8ygH9SBcJEtAl1tzjvJeATqNd
 kY+demE0iZy+MBcE1DZb+vtE+z30w8+gcQq1JqbQ3vLysVvYaKSgpUXpU
X-Gm-Gg: ASbGncuhgyvN3l2sm4Bsccx1ZuwpzY9FLAhyrXHv5V/5oPhXUZB82eSiphC+sGVmFkZ
 C2K4/xIOuRPI0x+lCxAYf5+UWyROHuchXiuccMCJVU6hKDiFrcNMw2GzonqJdkNnpdwy+kJEE6X
 D/pcW5WVtKI+EZV6c5We08w2jQFUWKlYVG4dedyQIeZWNqcZANVqjTCWN/DJdjiW/GxGD0/MOsg
 vTLTghqvMdOAExrlNnXSW2yvePwhngs89DwSdCcF08LB/a1nvMf4im0opS7H/a7fLHQRWVUFPeY
 e38KJzkKFQjME+BHtUtIUuMLtjzYVrbnWABjyIn6qcFrTJ7yplxmqdCUhSZP
X-Received: by 2002:a05:6000:2002:b0:3a5:39a8:199c with SMTP id
 ffacd0b85a97d-3a558a436e7mr1684592f8f.53.1749626677327; 
 Wed, 11 Jun 2025 00:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiK84PflpcOoiRtFwPzttSTgyASb8K7EWPaQEZ+dPYita6vHrUM+PSBAsRskBrC8tSvGudWQ==
X-Received: by 2002:a05:6000:2002:b0:3a5:39a8:199c with SMTP id
 ffacd0b85a97d-3a558a436e7mr1684569f8f.53.1749626676930; 
 Wed, 11 Jun 2025 00:24:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45325217c0bsm12074575e9.33.2025.06.11.00.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 00:24:36 -0700 (PDT)
Message-ID: <ca904039-f7bb-45c9-89c7-3bb71dc291e0@redhat.com>
Date: Wed, 11 Jun 2025 09:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
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
In-Reply-To: <20250607001056.335310-4-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 6/7/25 02:10, John Levon wrote:
> For vfio-user, each region has its own fd rather than sharing
> vbasedev's. Add the necessary plumbing to support this, and use the
> correct fd in vfio_region_mmap().
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Applied to vfio-next.

Thanks,

C.


> ---
>   include/hw/vfio/vfio-device.h |  7 +++++--
>   hw/vfio/device.c              | 29 +++++++++++++++++++++++++----
>   hw/vfio/region.c              |  9 +++++++--
>   3 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 923f9cd116..5cb817fd6a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -66,6 +66,7 @@ typedef struct VFIODevice {
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
>       bool migration_events;
> +    bool use_region_fds;
>       VFIODeviceOps *ops;
>       VFIODeviceIOOps *io_ops;
>       unsigned int num_irqs;
> @@ -84,6 +85,7 @@ typedef struct VFIODevice {
>       VFIOIOASHwpt *hwpt;
>       QLIST_ENTRY(VFIODevice) hwpt_next;
>       struct vfio_region_info **reginfo;
> +    int *region_fds;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> @@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
>       /**
>        * @get_region_info
>        *
> -     * Fill in @info with information on the region given by @info->index.
> +     * Fill in @info (and optionally @fd) with information on the region given
> +     * by @info->index.
>        */
>       int (*get_region_info)(VFIODevice *vdev,
> -                           struct vfio_region_info *info);
> +                           struct vfio_region_info *info, int *fd);
>   
>       /**
>        * @get_irq_info
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index d0068086ae..29a8d72deb 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -226,6 +226,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
> +    int fd = -1;
>       int ret;
>   
>       /* check cache */
> @@ -240,7 +241,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   retry:
>       (*info)->argsz = argsz;
>   
> -    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
> +    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
>       if (ret != 0) {
>           g_free(*info);
>           *info = NULL;
> @@ -251,11 +252,19 @@ retry:
>           argsz = (*info)->argsz;
>           *info = g_realloc(*info, argsz);
>   
> +        if (fd != -1) {
> +            close(fd);
> +            fd = -1;
> +        }
> +
>           goto retry;
>       }
>   
>       /* fill cache */
>       vbasedev->reginfo[index] = *info;
> +    if (vbasedev->region_fds != NULL) {
> +        vbasedev->region_fds[index] = fd;
> +    }
>   
>       return 0;
>   }
> @@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>       vbasedev->io_ops = &vfio_device_io_ops_ioctl;
>       vbasedev->dev = dev;
>       vbasedev->fd = -1;
> +    vbasedev->use_region_fds = false;
>   
>       vbasedev->ram_block_discard_allowed = ram_discard;
>   }
> @@ -470,6 +480,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>   
>       vbasedev->reginfo = g_new0(struct vfio_region_info *,
>                                  vbasedev->num_regions);
> +    if (vbasedev->use_region_fds) {
> +        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
> +    }
>   }
>   
>   void vfio_device_unprepare(VFIODevice *vbasedev)
> @@ -478,9 +491,14 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>   
>       for (i = 0; i < vbasedev->num_regions; i++) {
>           g_free(vbasedev->reginfo[i]);
> +        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
> +            close(vbasedev->region_fds[i]);
> +        }
> +
>       }
> -    g_free(vbasedev->reginfo);
> -    vbasedev->reginfo = NULL;
> +
> +    g_clear_pointer(&vbasedev->reginfo, g_free);
> +    g_clear_pointer(&vbasedev->region_fds, g_free);
>   
>       QLIST_REMOVE(vbasedev, container_next);
>       QLIST_REMOVE(vbasedev, global_next);
> @@ -502,10 +520,13 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
>   }
>   
>   static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
> -                                          struct vfio_region_info *info)
> +                                          struct vfio_region_info *info,
> +                                          int *fd)
>   {
>       int ret;
>   
> +    *fd = -1;
> +
>       ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
>   
>       return ret < 0 ? -errno : ret;
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 34752c3f65..cb172f2136 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -241,6 +241,7 @@ int vfio_region_mmap(VFIORegion *region)
>   {
>       int i, ret, prot = 0;
>       char *name;
> +    int fd;
>   
>       if (!region->mem) {
>           return 0;
> @@ -271,14 +272,18 @@ int vfio_region_mmap(VFIORegion *region)
>               goto no_mmap;
>           }
>   
> +        /* Use the per-region fd if set, or the shared fd. */
> +        fd = region->vbasedev->region_fds ?
> +             region->vbasedev->region_fds[region->nr] :
> +             region->vbasedev->fd,
> +
>           map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
>           munmap(map_base, map_align - map_base);
>           munmap(map_align + region->mmaps[i].size,
>                  align - (map_align - map_base));
>   
>           region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
> -                                     MAP_SHARED | MAP_FIXED,
> -                                     region->vbasedev->fd,
> +                                     MAP_SHARED | MAP_FIXED, fd,
>                                        region->fd_offset +
>                                        region->mmaps[i].offset);
>           if (region->mmaps[i].mmap == MAP_FAILED) {


