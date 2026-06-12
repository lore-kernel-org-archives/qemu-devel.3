Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93825CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwr2-0005Rb-DU; Fri, 12 Jun 2026 04:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwqu-0005RI-TZ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwqs-0000S5-R3
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781251373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GlzQV7YLA+n/h3baoVoug+EbvWWC6oAkD7Z86NJNEVg=;
 b=VLk7xjzttZk8uQi3rtLYNfAaTLtV1gdKCCGEyiFte0koRXMPFGsFssIy+dgifRvJ8p66ml
 rUx1nFBBctM87UPMQjxBM50e+OuKtbdkikBXauZWUPvYvWE6XCLvHOBiVq6QF3TyhD5NFO
 H4DjWRnI/boPWm9btO4MqOXzAhEFLaE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-Je5035QINJmE5FqfkO1P5g-1; Fri, 12 Jun 2026 04:02:52 -0400
X-MC-Unique: Je5035QINJmE5FqfkO1P5g-1
X-Mimecast-MFC-AGG-ID: Je5035QINJmE5FqfkO1P5g_1781251371
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef5e38a18so292577f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781251371; x=1781856171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GlzQV7YLA+n/h3baoVoug+EbvWWC6oAkD7Z86NJNEVg=;
 b=V4rG8no5Qds4MkazrV0fvH1OwppOUGAPR5uqwLshtzjrbAKKBRvzUbZzKF3/pK2c77
 CzMFe8Bwlo1G8W+PUsL6EZ4yHqCmm7eu9mzZ7ZBPgOBWbxHQ0yrisX7JOToe0rbltwQ2
 Xixd+UOJWyhad8SQ4SRXpUMFbqeopN1t6FiWrwXCl19vjdel4TSSnPtCRqHKUzXDkcPW
 hglJum2NWYyaKLwVhRsob+5dZJx8G7xiJ6qUqz550m5O3tmewpM70UCyTD/9TyR85wHA
 /M8TRhWUe3X9zIwDuNSjRB7y/Duh4oufPYr6e5GcdObuZ/AT5iaznxOdmG0XgbYNMQIF
 RcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781251371; x=1781856171;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlzQV7YLA+n/h3baoVoug+EbvWWC6oAkD7Z86NJNEVg=;
 b=rhxna5NUDBoLqI2V41R98TU6nrpjH4wBVuWdOvPL4To5k3W49TvcnJzWrTN+/80YOH
 3V+F7WTJeoT72/ucKKh7iYcWo2QHZ66AXn/wkCdgGJwOMzyeImjGksVyev8RNvBQFkGx
 bXJRPFKgMOz66ho58wehnHqpJ/Z+IN/WQDqEmnQHIe8Z4VlJD3CpIgm7V8aCpmedN/Mw
 ZNePoJrWzUjSXxw9LYUpkSWhNfRGj3XzrBI6EB2w+phkuHf2HZT3sJJ5zE0J9iDnGf6/
 Qy2CM4VoGaQZ77UWbuB1E+niTB++tAldmsaT0OhtPq9Hro/DIX4xBnFVKicC6aFArDeG
 HFPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+d5iV+UGDjLdroDS8He5GuLW5dFErC6p08+Qmxubje3uva7Knr6EDPBOWWjcklbK5ihpiSfBUmE1pI@nongnu.org
X-Gm-Message-State: AOJu0YxhOw94TiJLMvjGsGSVnD20f9z+vYRwOLiE/K5TcqFV9RNNkx/A
 06WGaohIJpeTHUE6kMIQqtHjkJnsC3arRbYB+1sbyuOerO8A/UIWT45nWBfg2ECcO6hEAOCCOaH
 9iVEIMSg8ivPfUAXSZWjCIGC3uweUrCMTAD/jxY6S41PfuR7OSALDHCHI
X-Gm-Gg: Acq92OGCu51klM7bFNj0CMe7HD8ul3ohj0rqcPDdYNlebdMsGT3C2CPy7T2LdCFfkkB
 JVSRaJQ1TZl17zSx92xyNZYpdTZvjWxCZvybG0DC2KFz42vdcEUkuEwARIAz7zrOmXHAY2N4NnY
 gUPB9Da8JzT4L5sjtZnHihAoz3qXBXg2WyDsmMQvzkqJKVUJqyu1wi0slvMb2+3RdUE7c80A3Nv
 5bjyWaaZN8G6ilOaIU5BnoGOkqB1kiWBnUdu/agRaJjVIHQnQmLRc9HIfXJ29qEo5VM+j8gMXtk
 kI5HoIQvzWyqeZpo/xdhIoO8jCw32CApZGcViZfY/6sRbsHG43h/NkfFMz1bAy/N9n9qvJ9njgZ
 8639gpkMq9/hDyhEz6K2BYHYgZiszd+r+EM4ZkKSD7NlKg2ZHG3rxv6wEd2pN
X-Received: by 2002:a05:6000:400c:b0:460:3233:f992 with SMTP id
 ffacd0b85a97d-4606dbc110amr2299659f8f.41.1781251370884; 
 Fri, 12 Jun 2026 01:02:50 -0700 (PDT)
X-Received: by 2002:a05:6000:400c:b0:460:3233:f992 with SMTP id
 ffacd0b85a97d-4606dbc110amr2299597f8f.41.1781251370380; 
 Fri, 12 Jun 2026 01:02:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f4f6sm3608796f8f.16.2026.06.12.01.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 01:02:49 -0700 (PDT)
Message-ID: <b2ab0072-c7de-45d4-920b-4fce5645f329@redhat.com>
Date: Fri, 12 Jun 2026 10:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/pci: Add ats property
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <20260612014322.2918836-3-nathanc@nvidia.com>
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
In-Reply-To: <20260612014322.2918836-3-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/12/26 03:43, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
> 
> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
> extended capability in config space but we should not expose it (ats=off,
> or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
> the capability so the guest does not see it.
> 
> If ATS is explicitly requested but not supported by the kernel, fail
> device realize.
> 
> This aligns with the kernel's per-device effective ATS reporting and allows
> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
> 
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>   hw/vfio/pci.h |  1 +
>   hw/vfio/pci.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c3a1f53d35..b48138870e 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -191,6 +191,7 @@ struct VFIOPCIDevice {
>       VFIODisplay *dpy;
>       Notifier irqchip_change_notifier;
>       VFIOPCICPR cpr;
> +    OnOffAuto ats;

I would move this new property field close to the other property fields
in VFIOPCIDevice.

>   };
>   
>   /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e63..6edb3bf5db 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2546,7 +2546,49 @@ static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> +/*
> + * Determine whether ATS capability should be advertised for @vdev, based on
> + * whether it was enabled on the command line and whether it is supported
> + * according to the kernel's IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED bit.
> + *
> + * Store whether ATS capability should be advertised in @ats_needed.
> + *
> + * Returns false only when ats=on is explicitly requested but the kernel
> + * reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. Returns true in all other cases.
> + */
> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
> +                                                 bool *ats_needed, Error **errp)
> +{
> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
> +    HostIOMMUDeviceClass *hiodc;
> +    bool ats_supported;
> +
> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
> +        *ats_needed = false;

Why not set '*ats_needed' to false by default here too. I see it is done in
vfio_pci_add_capabilities() but it looks safer.


> +        return true;
> +    }
> +
> +    *ats_needed = true;
> +    if (!hiod) {
> +        return true;
> +    }
> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    if (!hiodc || !hiodc->support_ats) {
> +        return true;
> +    }
> +
> +    ats_supported = hiodc->support_ats(hiod);
> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
> +        error_setg(errp, "vfio: ATS requested but not supported by kernel");

  "vfio-pci: ..."

> +        *ats_needed = false;
> +        return false;
> +    }
> +
> +    *ats_needed = ats_supported;
> +    return true;
> +}
> +
> +static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
>       bool pasid_cap_added = false;
> @@ -2635,7 +2677,18 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>            */
>           case PCI_EXT_CAP_ID_PASID:
>               pasid_cap_added = true;
> -            /* fallthrough */
> +            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> +            break;
> +        case PCI_EXT_CAP_ID_ATS:
> +            /*
> +             * If ATS is requested and supported according to the kernel, add
> +             * the ATS capability. If not supported according to the kernel or
> +             * disabled on the qemu command line, omit the ATS cap.
> +             */
> +            if (ats_needed) {
> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> +            }
> +            break;
>           default:
>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>           }
> @@ -2657,6 +2710,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>   bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
> +    bool ats_needed = false;
>   
>       if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>           !pdev->config[PCI_CAPABILITY_LIST]) {
> @@ -2667,7 +2721,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>           return false;
>       }
>   
> -    vfio_add_ext_cap(vdev);
> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) {
> +        return false;
> +    }
> +
> +    vfio_add_ext_cap(vdev, ats_needed);
>       return true;
>   }
>   
> @@ -3815,6 +3873,7 @@ static const Property vfio_pci_properties[] = {
>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
>       DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>                          vpasid_cap_offset, 0),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, ON_OFF_AUTO_AUTO),
>   };
>   
>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
> @@ -3973,6 +4032,15 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>                                             "a vIOMMU. A value of 0 (default) places the capability at the "
>                                             "end of the extended configuration space. The offset must be "
>                                             "4-byte aligned and within the PCIe extended configuration space");
> +   object_class_property_set_description(klass, /* 11.1 */
> +                                          "ats",
> +                                          "Control guest visibility of the ATS PCIe extended capability. "
> +                                          "Valid values are on, off, and auto (default). "
> +                                          "'off' always masks ATS. "
> +                                          "'on' requires ATS support for the device and fails realize if the "
> +                                          "host kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. "

Again, IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is a kernel UAPI bit and it is
a bit too low-level/internal a QEMU for property documentation.

What about :

   "'on' requires ATS support for the device and fails realize if the "
   "host kernel reports ATS as unavailable for this device. "
   "'auto' masks ATS only when the host kernel reports ATS as unavailable."

?

Thanks,

C.

> +                                          "'auto' masks ATS only when the host kernel reports "
> +                                          "IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED.");
>   }
>   
>   static const TypeInfo vfio_pci_info = {


