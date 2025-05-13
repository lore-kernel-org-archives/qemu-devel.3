Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC63C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnV6-0002GD-PW; Tue, 13 May 2025 07:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uEnV4-0002FX-RI
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uEnV2-0005tk-Rd
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747134518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dOtS7Mw7fJrVauEtda538Y1B+UbnXKKO1RzShuj71ls=;
 b=BA7QCCXGOBg4+FRHlHTSDPeJKOx+vHnrnhNJjJnvN7M46VTxyTz65keNFG+IQWLIkdYqTZ
 4+fFzGD2Hrbs0m7bXQ8kiwMIvYt9TOUI/RzV91+cs3CvViX3UEjM3lU3go2O/IZkeulD2U
 ZyF+17S5gm5LGOtn1+TpzOz++zYmErk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-xjp58T3DMIyZEh76kDF-qg-1; Tue, 13 May 2025 07:08:37 -0400
X-MC-Unique: xjp58T3DMIyZEh76kDF-qg-1
X-Mimecast-MFC-AGG-ID: xjp58T3DMIyZEh76kDF-qg_1747134516
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0ba24d233so1801255f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 04:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134516; x=1747739316;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOtS7Mw7fJrVauEtda538Y1B+UbnXKKO1RzShuj71ls=;
 b=dG7SFnM7xbNHwUmdAoO39hs1brT23+uUFrlED8jqN2cVrLxw6aW/pIwXpvahxBKiLu
 11qziVtFi3N0WvxXG93sRDX9JF2s8lefD00kRxbsdbKw0MfJoqG8BMRcDyXtllfxX+1U
 DNzFU2ICC8H5oiyuf1wsf+lKvqCYwlsrSH48hgsRrIH3YmEr5f1rrU+Kvz4n4Jd571tg
 lcDU/iXYIB5vcKAsyTmSd/M+/w4Myk2UifToZVcfvZzJPvK8rL2Lm/q6dXd4soqXqiDq
 h1IO8Hcr6mKDD3UnUjd0K97ml2CyzhfkC57ttxrU1A6t3xrhOF5XfxV2hDAc51mUY+Jm
 Gt/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhzWS4rV+J9NhE+SLRzPl8wKWs5JyhYJGIid/PtXoUvcKgCDdzvu2QrYAmaSxHhrMtzuCDhQZaWiua@nongnu.org
X-Gm-Message-State: AOJu0Yw3wT+DIP+QVftRpCQ34KH347scwYjOraTgh3Jsn6z8iFdWET5n
 WmI4bea6yXvojypIzq8PHYar3DtRL6nNac6Qr3AzJ/yeNTuzu8nBOtOcwx/p1HssSf56Q6W5GSP
 waEqB5J5JRDJzWy7O21Ig6CvGOHkeHVd27g8aQjz6NeIra/YZjI3q
X-Gm-Gg: ASbGnctEXMXv1vVDBvdA/qv/J1w2uZwt4qhKzsDGC4f8Wi603kk5VFkbSZvc8PMJ35E
 WlQJPWs5d4KrwTYYQNZzTDR46aKiRrICij4Og5HB9OuC391ei1eKB/qD1ABf5GcV0VhM/G9fUIa
 5XsqSIM4ARNo1BncxrZ09+mHBOK//o+ch5aesXuvbsLgGomqpjcfQm3ADbcjrL6OrQewfLmfRuA
 EvAZjeESMkRKOJsqxoSVIHfpFrZZqgwDdKO3/eEGXFlfFdlCGPkOR/8vjcPBZr4wKnB7kqpucI5
 VF1ROEE4+uKoUhogB8xgNxSuxzqBFY1LV2iiPMbqAhWmJhxW0A==
X-Received: by 2002:a05:6000:186e:b0:39d:724f:a8f1 with SMTP id
 ffacd0b85a97d-3a1f64279e0mr13830271f8f.10.1747134516049; 
 Tue, 13 May 2025 04:08:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Oq5Qerh6T7L1wE5u2Ko1aEEuUOviYzmfHuB0yvw8X4OyWKwnhGigA63pVLNTAIFiVQUzDQ==
X-Received: by 2002:a05:6000:186e:b0:39d:724f:a8f1 with SMTP id
 ffacd0b85a97d-3a1f64279e0mr13830245f8f.10.1747134515677; 
 Tue, 13 May 2025 04:08:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2f58sm15487925f8f.49.2025.05.13.04.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 04:08:35 -0700 (PDT)
Message-ID: <e106cfed-74fb-4b11-9dfd-1b75f023e701@redhat.com>
Date: Tue, 13 May 2025 13:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 4/4] s390: implementing CHSC SEI for AP config
 change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-5-rreyes@linux.ibm.com>
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
In-Reply-To: <20250512180230.50129-5-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

On 5/12/25 20:02, Rorie Reyes wrote:
> Handle interception of the CHSC SEI instruction for requests
> indicating the guest's AP configuration has changed.
> 
> If configuring --without-default-devices, hw/s390x/ap-stub.c
> was created to handle such circumstance. Also added the
> following to hw/s390x/meson.build if CONFIG_VFIO_AP is
> false, it will use the stub file.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   MAINTAINERS           |  1 +
>   hw/s390x/ap-stub.c    | 25 +++++++++++++++++++++++++
>   hw/s390x/meson.build  |  1 +
>   target/s390x/ioinst.c | 11 +++++++++--
>   4 files changed, 36 insertions(+), 2 deletions(-)
>   create mode 100644 hw/s390x/ap-stub.c



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23174b4ca7..070c746c69 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -112,6 +112,7 @@ F: hw/intc/s390_flic.c
>   F: hw/intc/s390_flic_kvm.c
>   F: hw/s390x/
>   F: hw/vfio/ap.c
> +F: hw/s390x/ap-stub.c
>   F: hw/vfio/ccw.c
>   F: hw/watchdog/wdt_diag288.c
>   F: include/hw/s390x/
> diff --git a/hw/s390x/ap-stub.c b/hw/s390x/ap-stub.c
> new file mode 100644
> index 0000000000..e2dacff959
> --- /dev/null
> +++ b/hw/s390x/ap-stub.c
> @@ -0,0 +1,25 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/s390x/ap-bridge.h"
> +
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    return 0;
> +}
> +
> +int ap_chsc_sei_nt0_have_event(void)
> +{
> +    return 0;
> +}
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index 3bbebfd817..99cbcbd7d6 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -33,6 +33,7 @@ s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
>   ))
>   s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
>   s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
> +s390x_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
>   
>   virtio_ss = ss.source_set()
>   virtio_ss.add(files('virtio-ccw.c'))
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index fe62ba5b06..2320dd4c12 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -18,6 +18,7 @@
>   #include "trace.h"
>   #include "hw/s390x/s390-pci-bus.h"
>   #include "target/s390x/kvm/pv.h"
> +#include "hw/s390x/ap-bridge.h"
>   
>   /* All I/O instructions but chsc use the s format */
>   static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
> @@ -574,13 +575,19 @@ out:
>   
>   static int chsc_sei_nt0_get_event(void *res)
>   {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_get_event(res);
> +    }
> +
>       return 1;
>   }
>   
>   static int chsc_sei_nt0_have_event(void)
>   {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_have_event();
> +    }
> +
>       return 0;
>   }
>   


