Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B2CC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHeZL-0001wI-96; Wed, 21 May 2025 04:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHeZJ-0001w4-R6
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHeZH-0007Nu-P3
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rE3g3DSj6d+bA+SOSIChPIAmNWZ42TwCc3HtMavE+FI=;
 b=LQm6xyhFzyOEqW5Q8++vQbz8e1i6nrR0Z9dH5N7fR1MR6yI4IVbwiu4lFAvBfDPM6zfIvh
 gOlkzrM0LUlJiLz7JIid53ZspRqSfiItR87FngOr4L0035Miw2IFyYfjFJ7ohgqdmCHpO0
 36wgiExqzBGl8u3esH4ChIzV02Ji3f4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-S746mvYfMsqqVvmgeqTSiA-1; Wed, 21 May 2025 04:12:48 -0400
X-MC-Unique: S746mvYfMsqqVvmgeqTSiA-1
X-Mimecast-MFC-AGG-ID: S746mvYfMsqqVvmgeqTSiA_1747815167
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a367b3bb78so2609855f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815167; x=1748419967;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rE3g3DSj6d+bA+SOSIChPIAmNWZ42TwCc3HtMavE+FI=;
 b=BLjPxRqNBoK1/tmCwSniGZHUhWNj7a2TQExLswPdIwE/o/adztfy2Btshos8XaCIPD
 kmKDrdJ9nKWdiAFiFE0M4HFuygFmohOJanl2vwakzjs+zU1AZKA6euTH08Laz/7wYgmm
 Kr0i/rJE2YnJnQ++1zFyQS5hA9eBfAh3x8OydI3FICsGqdbnAr09+UeP6pAbajRA7w8a
 JuRX5ZgI4+beYXm3TGMj1Flc+mNvvCHGwVIsVCloLJaAomN6ivOZKEzKxez+zSKoIIkO
 EXeJVuX1SSEXZorLg5qMxuj3vEqS+c/t77cWV2nyMj1j0XdFj+4MmF2PBMGNHOU2I0DE
 KSJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzGPMYabBt6kBQUE6eZakxOWqBz2SjHWF5TyddnyDmLzNmFopT2jESo/sf10DjUTiolS/aB5PwkGyl@nongnu.org
X-Gm-Message-State: AOJu0Yw1Pob066mXiekanfYDDjv5ZOkMXsDH3kPp5cx+JNrAzjn6xqIq
 GBMcIWlGIra2tWphiw9UXn7UXo+gwPQorVMcobmCt0fs1mBfH8AG3CynnGerdqkXFGf+Vj6O9ii
 YRUr2QM9gUbBCLaQ95Fp/wNAybCnDlOu3UutE+WjN0o6TdA9kGj/2K6wF
X-Gm-Gg: ASbGncthhYhc9eFqbvoC2EfIPx/3FtBfrvqclh3cpQ6w6Grdz+n6Rc2iByOaGwflu/e
 nSkxIpjWcqf1trL9sFC69dae3Kdg0HBHlgkWdKkAa6DC7JhQ1mTfSaLejjJXAi5Snt3WnmJIUbc
 CYneojKgnst66uE+o/TcU2ZnUjQdh/91oS93TT1Zl22+LMstk+Uoxzvhm3tBbs9g00JPKq7nadB
 rhQ5P099FQDlXuVvBprluOxhAqz9eagfYWOFdDJwNqhrPSjvcwG17NPs7BzhFQG+TZsn8BVmJPD
 04Np2JVU5jbWjsChQ6rf5WAckr6DbGZDvqM+SW6zr0nmCPXA4Q==
X-Received: by 2002:a05:6000:18a7:b0:3a3:6af1:cc92 with SMTP id
 ffacd0b85a97d-3a36af1cdafmr12126545f8f.7.1747815167280; 
 Wed, 21 May 2025 01:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuLuGgikuZQofIx6eoosm0lYlfpYi3DcqOGIapgocgPYQzZUK335JRB0jGM7yEfEfm6hHP7Q==
X-Received: by 2002:a05:6000:18a7:b0:3a3:6af1:cc92 with SMTP id
 ffacd0b85a97d-3a36af1cdafmr12126512f8f.7.1747815166795; 
 Wed, 21 May 2025 01:12:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d224sm19515793f8f.12.2025.05.21.01.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 01:12:46 -0700 (PDT)
Message-ID: <a1bd108b-02a3-4802-b2f5-c6eb464e92e1@redhat.com>
Date: Wed, 21 May 2025 10:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/29] vfio: mark posted writes in region write
 callbacks
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-9-john.levon@nutanix.com>
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
In-Reply-To: <20250520150419.2172078-9-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/20/25 17:03, John Levon wrote:
> For vfio-user, the region write implementation needs to know if the
> write is posted; add the necessary plumbing to support this.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-device.h | 4 ++--
>   include/hw/vfio/vfio-region.h | 1 +
>   hw/vfio/device.c              | 3 ++-
>   hw/vfio/pci.c                 | 5 ++++-
>   hw/vfio/region.c              | 3 ++-
>   5 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 5cb817fd6a..a23ef4ea13 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -207,10 +207,10 @@ struct VFIODeviceIOOps {
>        * @region_write
>        *
>        * Write @size bytes to the region @nr at offset @off from the buffer
> -     * @data.
> +     * @data; if @post, the write is posted.
>        */
>       int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
> -                        void *data);
> +                        void *data, bool post);
>   };
>   
>   void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
> index 80e83b23fd..f1ae5125ba 100644
> --- a/include/hw/vfio/vfio-region.h
> +++ b/include/hw/vfio/vfio-region.h
> @@ -30,6 +30,7 @@ typedef struct VFIORegion {
>       VFIOMmap *mmaps;
>       uint8_t nr; /* cache the region number for debug */
>       int fd; /* fd to mmap() region */
> +    bool post_wr; /* writes can be posted */
>   } VFIORegion;
>   
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 41db403992..cb1a212b8f 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -572,7 +572,8 @@ static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
>   }
>   
>   static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
> -                                       off_t off, uint32_t size, void *data)
> +                                       off_t off, uint32_t size, void *data,
> +                                       bool post)
>   {
>       struct vfio_region_info *info;
>       int ret;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ef38b4692a..3d1dbdac38 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1016,7 +1016,7 @@ static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
>   {
>       return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
>                                                  VFIO_PCI_CONFIG_REGION_INDEX,
> -                                               offset, size, data);
> +                                               offset, size, data, false);
>   }
>   
>   static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
> @@ -1820,6 +1820,9 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
>       bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
>                                            ~PCI_BASE_ADDRESS_MEM_MASK);
>       bar->size = bar->region.size;
> +
> +    /* IO regions are sync, memory can be async */
> +    bar->region.post_wr = (bar->ioport == 0);
>   }
>   
>   static void vfio_bars_prepare(VFIOPCIDevice *vdev)
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 3c93da91d8..936502b37a 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -66,7 +66,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
>       }
>   
>       ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
> -                                         addr, size, &buf);
> +                                         addr, size, &buf, region->post_wr);
>       if (ret != size) {
>           error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
>                        ",%d) failed: %s",
> @@ -200,6 +200,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>       region->size = info->size;
>       region->fd_offset = info->offset;
>       region->nr = index;
> +    region->post_wr = false;
>       if (vbasedev->region_fds != NULL) {
>           region->fd = vbasedev->region_fds[index];
>       } else {


