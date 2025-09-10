Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EDFCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 07:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwEym-0008Me-2q; Wed, 10 Sep 2025 03:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uwEyj-0008Lh-Tg
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uwEya-0005XG-Hv
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757488237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EKOh/mX6NZ3WIrwdJM/hsW8DVJk+7qNsHiB0kc9aMuE=;
 b=YM8Q8mU14/g7b1XsUXFVjbcM3a1VTHhQvCRCuvoq3JmKu6gIfTNsdyotgby67m8snTyQli
 32P1UyWXfHu/iHMKgC+f6s6DhHJby1A078aEwxej3aPHeePV9YTnJeiCyMse8u3sJ5k27o
 /juBjLLd0/CqGP+fkZY6tWSD1GoSI+w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-haxc7h1YO9ma5oi4lCwR6A-1; Wed, 10 Sep 2025 03:10:33 -0400
X-MC-Unique: haxc7h1YO9ma5oi4lCwR6A-1
X-Mimecast-MFC-AGG-ID: haxc7h1YO9ma5oi4lCwR6A_1757488233
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45ddbdb92dfso25246295e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 00:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757488232; x=1758093032;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EKOh/mX6NZ3WIrwdJM/hsW8DVJk+7qNsHiB0kc9aMuE=;
 b=XGzPhqAF7Ds1prwHHJkBLXoZZkMzQEHx25UN5+B7ieWJ071zv28RoL/V32fSW7cs3x
 MOv+JZ5XioulJAZuibz4jI8s/6vKdCJnnXMwvw2XeU59tnUk9zeuYjIjmPgg4IZdqi13
 ja9aHhVAB/Xgi1F2p6slraUZ2K/lIxlXPXoqQM+CCNMFGXEnGUlu9dAKdFIPM03IK+UE
 IHn6+C6Lkx1fBYnFmIMXAwW8iQleGHRixd+J+kqUD2FwuwoNZF+WuQWAOmM+ZwSZiy61
 FiYPqrJNS4Y0r4jM3pTKqnZUuCTa86yHrF+gT2wpgLolosNb0t42OluvOwD0i6hJ2O+a
 XrTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVegjaYB66u7/HPLCVRQ/KSQxe0/sN1IdKT+c3tsofwszmsbVaR6l+R+4n+6ZFrOD5Xg2DdUlMHcDNx@nongnu.org
X-Gm-Message-State: AOJu0Yz2uoIEKD93u1XoI6+MMVwANBtPliJyPg2Y0OTezRB8lOiXXSUo
 hEp5aUz324InMUm4G6TEgtqJW232dMVN2CrGJBkGio0i04cP9gQ80XY7u0hDh29gepSdyXL9THp
 EpBin0KD1X78dYHCvc9e9WFfb3ekHASuD/sArHT8Fp7FM9diSCksw2liA
X-Gm-Gg: ASbGncv2lZQMYPg/dgrUvZkvVLx1jYztpqvltxum4fL2C22T5t3hG5uCV3qdpdfPAOY
 pyezRyzVppLNDV4OfaF7eJRB6ijfRvaDaWz2oX65izqYruNyhsdMldNTPrQ9/H97rxBV7CivtMU
 Q1c4G5iGVaWWK7FfFwxpwNgvHt9PVd/kLk0UvB6Q0vWHM3eRGo/8gyRKONeDDuE6eEfPg8W+t+f
 dACrvHSqjlXlufEUHfGCoyJa7t/kKJp/dSmtT4jdLif6UqZGMsj9WFbg7vRmTKc8I5++YTLyS+A
 KQ2VU+/V6lCPqnkfw2naWnOuM/2mz+CTYE0S/geE23/vF54Q/iE2bljUDmSwErOtxm9Lri74/0Y
 F1ag=
X-Received: by 2002:a05:600c:4688:b0:45d:d2d2:f095 with SMTP id
 5b1f17b1804b1-45deb702e1dmr65277115e9.19.1757488232472; 
 Wed, 10 Sep 2025 00:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjZ34S/Y5nD7kJMYMAzgYyWeax9w+4fJia3oJkoMZWrQrovTFDZw/qPkZ2v88sLQuqyI7Pcg==
X-Received: by 2002:a05:600c:4688:b0:45d:d2d2:f095 with SMTP id
 5b1f17b1804b1-45deb702e1dmr65276685e9.19.1757488231992; 
 Wed, 10 Sep 2025 00:10:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df8259d04sm15823165e9.23.2025.09.10.00.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Sep 2025 00:10:31 -0700 (PDT)
Message-ID: <ce46413b-dab9-4ffc-9e6e-078c6b2ed6b9@redhat.com>
Date: Wed, 10 Sep 2025 09:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] hw/ppc: Add a test machine for the IBM PPE42 CPU
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 thuth@redhat.com, rathc@linux.ibm.com, richard.henderson@linaro.org
References: <20250908200028.115789-1-milesg@linux.ibm.com>
 <20250908200028.115789-9-milesg@linux.ibm.com>
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
In-Reply-To: <20250908200028.115789-9-milesg@linux.ibm.com>
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
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/8/25 22:00, Glenn Miles wrote:
> Adds a test machine for the IBM PPE42 processor, including a
> DEC, FIT, WDT and 512 KiB of ram.
> 
> The purpose of this machine is only to provide a generic platform
> for testing instructions of the recently  added PPE42 processor
> model which is used extensively in the IBM Power9, Power10 and
> future Power server processors.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
> 
> Changes from v2:
>    - Moved decrementer changes to distinct commit
>    - Introduced a specific MachineState for the ppe42 Machine
>    - Use qdev_realize to create the machine
>    - Use valid_cpu_types to determine validity of CPU
>    - Changed machine ram limit from 2GB to 512KB
> 
>   MAINTAINERS            |   6 +++
>   hw/ppc/Kconfig         |   9 ++++
>   hw/ppc/meson.build     |   2 +
>   hw/ppc/ppe42_machine.c | 102 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 119 insertions(+)
>   create mode 100644 hw/ppc/ppe42_machine.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed76..52fa303e0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1531,6 +1531,12 @@ F: include/hw/pci-host/grackle.h
>   F: pc-bios/qemu_vga.ndrv
>   F: tests/functional/test_ppc_mac.py
>   
> +PPE42
> +M: Glenn Miles <milesg@linux.ibm.com>
> +L: qemu-ppc@nongnu.org
> +S: Odd Fixes
> +F: hw/ppc/ppe42_machine.c
> +
>   PReP
>   M: Hervé Poussineau <hpoussin@reactos.org>
>   L: qemu-ppc@nongnu.org
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index ced6bbc740..3fdea5919c 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -44,6 +44,15 @@ config POWERNV
>       select SSI_M25P80
>       select PNV_SPI
>   
> +config PPC405
> +    bool
> +    default y
> +    depends on PPC
> +    select M48T59
> +    select PFLASH_CFI02
> +    select PPC4XX
> +    select SERIAL

Does the machine need all the above support ?

> +
>   config PPC440
>       bool
>       default y
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 9893f8adeb..170b90ae7d 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -57,6 +57,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_n1_chiplet.c',
>   ))
>   # PowerPC 4xx boards
> +ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> +  'ppe42_machine.c'))
>   ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
>     'ppc440_bamboo.c',
>     'ppc440_uc.c'))
> diff --git a/hw/ppc/ppe42_machine.c b/hw/ppc/ppe42_machine.c
> new file mode 100644
> index 0000000000..2cfce2503f
> --- /dev/null
> +++ b/hw/ppc/ppe42_machine.c
> @@ -0,0 +1,102 @@
> +/*
> + * Test Machine for the IBM PPE42 processor
> + *
> + * Copyright (c) 2025, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "system/address-spaces.h"
> +#include "hw/boards.h"
> +#include "hw/ppc/ppc.h"
> +#include "system/system.h"
> +#include "system/reset.h"
> +#include "system/kvm.h"
> +#include "qapi/error.h"
> +
> +#define TYPE_PPE42_MACHINE MACHINE_TYPE_NAME("ppe42_machine")
> +typedef MachineClass Ppe42MachineClass;
> +typedef struct Ppe42MachineState Ppe42MachineState;
> +DECLARE_OBJ_CHECKERS(Ppe42MachineState, Ppe42MachineClass,
> +                     PPE42_MACHINE, TYPE_PPE42_MACHINE)
> +
> +struct Ppe42MachineState {
> +    MachineState parent_obj;
> +
> +    PowerPCCPU cpu;
> +};
> +
> +static void main_cpu_reset(void *opaque)
> +{
> +    PowerPCCPU *cpu = opaque;
> +
> +    cpu_reset(CPU(cpu));
> +}
> +
> +static void ppe42_machine_init(MachineState *machine)
> +{
> +    Ppe42MachineState *pms = PPE42_MACHINE(machine);
> +    PowerPCCPU *cpu = &pms->cpu;
> +
> +    if (kvm_enabled()) {
> +        error_report("machine %s does not support the KVM accelerator",
> +                     MACHINE_GET_CLASS(machine)->name);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* init CPU */
> +    object_initialize_child(OBJECT(pms), "cpu", cpu, machine->cpu_type);
> +    if (!qdev_realize(DEVICE(cpu), NULL, &error_fatal)) {
> +        return;
> +    }
> +
> +    qemu_register_reset(main_cpu_reset, cpu);
> +
> +    /* This sets the decrementer timebase */
> +    ppc_booke_timers_init(cpu, 37500000, PPC_TIMER_PPE);
> +
> +    /* RAM */
> +    if (machine->ram_size > 512 * KiB) {
> +        error_report("RAM size more than 512 KiB is not supported");
> +        exit(1);
> +    }

In case of resend, the RAM size could be tested sooner (after kvm_enabled()).

> +    memory_region_add_subregion(get_system_memory(), 0xfff80000, machine->ram);
> +}
> +
> +
> +static void ppe42_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    static const char * const valid_cpu_types[] = {
> +        POWERPC_CPU_TYPE_NAME("PPE42"),
> +        POWERPC_CPU_TYPE_NAME("PPE42X"),
> +        POWERPC_CPU_TYPE_NAME("PPE42XM"),
> +        NULL,
> +    };
> +
> +    mc->desc = "PPE42 Test Machine";
> +    mc->init = ppe42_machine_init;
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("PPE42XM");
> +    mc->valid_cpu_types = valid_cpu_types;
> +    mc->default_ram_id = "ram";
> +    mc->default_ram_size = 512 * KiB;
> +}
> +
> +static const TypeInfo ppe42_machine_info = {
> +        .name          = TYPE_PPE42_MACHINE,
> +        .parent        = TYPE_MACHINE,
> +        .instance_size = sizeof(Ppe42MachineState),
> +        .class_init    = ppe42_machine_class_init,
> +        .class_size    = sizeof(Ppe42MachineClass),
> +};
> +
> +static void ppe42_machine_register_types(void)
> +{
> +    type_register_static(&ppe42_machine_info);
> +}
> +
> +type_init(ppe42_machine_register_types);
> +


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



