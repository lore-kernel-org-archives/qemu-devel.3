Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43136C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXi4-0003Xk-Sn; Mon, 10 Mar 2025 03:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trXi2-0003WV-MF
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trXi0-000557-Mz
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741592275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sMCwxi4oqEg2aDVfEhF+u35D/4iuGDnhOX5TVHZZxXU=;
 b=hr5gWJdBHyy8957d6kH8DMU+JcHUqnFUEkOZTo5pKAr6PP1u8Cps6mqs7VzYBqbO0Y6Grg
 h6jog6eCE9i/IJcdVr+AdpYKJdLMvBTeBVf8wAPMPzmLYISjciUtPfDu2uz7TLBbZlbmnG
 p8adwBIKlg6dcYsoyxAOmm9AQGMNApI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-TjnWQckMOHe0oq3K2_PN0w-1; Mon, 10 Mar 2025 03:37:53 -0400
X-MC-Unique: TjnWQckMOHe0oq3K2_PN0w-1
X-Mimecast-MFC-AGG-ID: TjnWQckMOHe0oq3K2_PN0w_1741592272
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43bd0586b86so26289865e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 00:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741592272; x=1742197072;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMCwxi4oqEg2aDVfEhF+u35D/4iuGDnhOX5TVHZZxXU=;
 b=mxCXCRtdzja4UJXBpWkNJdok6EvaEqqIiG+EmzSmneRczpSuJ3SdMghPRY45xHNKZG
 2ch6jlg+btVRzfBkc83fCMu78fNsOCGaqJmJWSeC8j3aUuqP0x3T3+zN26N4cUwktzKi
 w4o6wD3tvBfiFdrXmFe6/FkxUhWeL2bo5+vnWETo4xG/rzEsjsw9uh0HLUMldUIX6pDV
 CGWs6hnSoL9SkfwVeGHlT/koBFLtoHKTpgjMwoc3W9RQ0jX+m3Ds0SAmpavv6TBlUQC8
 PJ8inGIUIPFX2kLeOyxY6oToHSRQvO+lYt+aivZRUdPGZduW1puvw32PbXGNjionQHnz
 8pyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgyIdk40XlLh9n7ZgUTysWqqH77sSlnO4fwFCgoDeZl6CQtmkPr+XlofAEhLZsDZUWVktVFRfGfYax@nongnu.org
X-Gm-Message-State: AOJu0YxRRXb54cHz0r5D71Vl0o5TB4oNHfGSvClqFqwAxIDbctYIOL4N
 XiqSpKDH9RSe+J9KcXm9Acdepa88caajciWps2sM4BXHoTAGxvg3Ue2QKqPgzBWti7Ac3KaMA+w
 xtYfy9aFUt2HYWFkzWs8IpN7ugPBnSgb4StiY62RKSfUxsBmAugKH
X-Gm-Gg: ASbGncv0yXqb69PIOhDm2Sjs9RxXHgrTK+aNK/yt+/tlasg7wYQpCHYRfBk5bpnENZ9
 IPkWXueI9jibkRzn/wqgBqjRNXxEqwWixk8doAuebF8vgYQUk2HXK6DsXPR/r6KU+1i6dgmtulr
 Uz1CrASQPlBOeL48dVg8vqmcRLjZrefEzBIgmtXkbeSxBf42xA9iWaRbxJQ4+M/KqqiG1e4lrlg
 8HSZ6veG1ve7ymoe8xL8DfCTNShwPWuLjmafgfocIkmySjE7yKr7MTHh67ROGjEN1nlMn7iHBvZ
 2vb7K0CII++SMk3LuCikogDVBnvAduUh1J9YaQz7YjP8uDG+ZkoyzQ==
X-Received: by 2002:a05:600c:444d:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-43cfe154379mr2716625e9.15.1741592272116; 
 Mon, 10 Mar 2025 00:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0srL6ClQbw24aDHYv2dVWgkXh+JPH04ci+BWOkV8mVfq/7veXu6PGHViDtDsb+PYl3QA6tQ==
X-Received: by 2002:a05:600c:444d:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-43cfe154379mr2716335e9.15.1741592271730; 
 Mon, 10 Mar 2025 00:37:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfaf6892csm14788515e9.24.2025.03.10.00.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 00:37:50 -0700 (PDT)
Message-ID: <415339c1-8f83-4059-949e-63ef0c28b4b9@redhat.com>
Date: Mon, 10 Mar 2025 08:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime
 using vfio_igd_builtin()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-13-philmd@linaro.org>
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
In-Reply-To: <20250308230917.18907-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/9/25 00:09, Philippe Mathieu-Daudé wrote:
> Convert the compile time check on the CONFIG_VFIO_IGD definition
> by a runtime one by calling vfio_igd_builtin(), which check
> whether VFIO_IGD is built in a qemu-system binary.
> 
> Add stubs to avoid when VFIO_IGD is not built in:

I thought we were trying to avoid stubs in QEMU build. Did that change ?


Thanks,

C.


> 
>    /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_vfio_pci-quirks.c.o: in function `vfio_bar_quirk_setup':
>    /usr/bin/ld: ../hw/vfio/pci-quirks.c:1216: undefined reference to `vfio_probe_igd_bar0_quirk'
>    /usr/bin/ld: ../hw/vfio/pci-quirks.c:1217: undefined reference to `vfio_probe_igd_bar4_quirk'
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/vfio/pci-quirks.h |  6 ++++++
>   hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
>   hw/vfio/pci-quirks.c |  9 ++++-----
>   hw/vfio/meson.build  |  3 +++
>   4 files changed, 33 insertions(+), 5 deletions(-)
>   create mode 100644 hw/vfio/igd-stubs.c
> 
> diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
> index fdaa81f00aa..dcdb1962600 100644
> --- a/hw/vfio/pci-quirks.h
> +++ b/hw/vfio/pci-quirks.h
> @@ -13,6 +13,7 @@
>   #define HW_VFIO_VFIO_PCI_QUIRKS_H
>   
>   #include "qemu/osdep.h"
> +#include "qom/object.h"
>   #include "exec/memop.h"
>   
>   /*
> @@ -71,4 +72,9 @@ extern const MemoryRegionOps vfio_generic_mirror_quirk;
>   
>   #define TYPE_VFIO_PCI_IGD_LPC_BRIDGE "vfio-pci-igd-lpc-bridge"
>   
> +static inline bool vfio_igd_builtin(void)
> +{
> +    return type_is_registered(TYPE_VFIO_PCI_IGD_LPC_BRIDGE);
> +}
> +
>   #endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */
> diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
> new file mode 100644
> index 00000000000..5d4e88aeb1b
> --- /dev/null
> +++ b/hw/vfio/igd-stubs.c
> @@ -0,0 +1,20 @@
> +/*
> + * IGD device quirk stubs
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (C) Linaro, Ltd.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "pci.h"
> +
> +void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
> +{
> +    g_assert_not_reached();
> +}
> +
> +void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index c53591fe2ba..22cb35af8cc 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -11,7 +11,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include CONFIG_DEVICES
>   #include "exec/memop.h"
>   #include "qemu/units.h"
>   #include "qemu/log.h"
> @@ -1213,10 +1212,10 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
>       vfio_probe_nvidia_bar5_quirk(vdev, nr);
>       vfio_probe_nvidia_bar0_quirk(vdev, nr);
>       vfio_probe_rtl8168_bar2_quirk(vdev, nr);
> -#ifdef CONFIG_VFIO_IGD
> -    vfio_probe_igd_bar0_quirk(vdev, nr);
> -    vfio_probe_igd_bar4_quirk(vdev, nr);
> -#endif
> +    if (vfio_igd_builtin()) {
> +        vfio_probe_igd_bar0_quirk(vdev, nr);
> +        vfio_probe_igd_bar4_quirk(vdev, nr);
> +    }
>   }
>   
>   void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index a8939c83865..6ab711d0539 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -17,6 +17,9 @@ specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
>   
>   system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
> +system_ss.add(when: 'CONFIG_VFIO_IGD', if_false: files(
> +  'igd-stubs.c',
> +))
>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>     'helpers.c',
>     'container-base.c',


