Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11199606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=uucewEtg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnar-00029M-Vq; Tue, 10 Nov 2026 10:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xQnZM-0001cF-CQ
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:15:37 -0500
Received: from smtpout8.mo536.mail-out.ovh.net ([51.210.91.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xQnZG-0001n5-Hc
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:15:30 -0500
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4jP9FG2rpHz8C4C;
 Tue, 10 Nov 2026 15:15:14 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alex.bennee@linaro.org>; Tue, 10 Nov 2026 15:15:14 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.88])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4jP9FG1f72z47l0;
 Tue, 10 Nov 2026 15:15:14 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5A95212E3BDF;
 Tue, 10 Nov 2026 15:15:12 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004707169b1-522a-4526-b824-fe0310067788,
 85C0C06F94A1483D58022EF506A248ADF299C60B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <07a49049-2170-44ae-a025-35a8c58d5f03@kaod.org>
Date: Tue, 10 Nov 2026 16:15:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/28] hw/vfio: mark all VFIO object classes as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-6-berrange@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261029131241.2275706-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 3819615434873875695
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGiTvkN8UV6qOnQYp2052LqzFR9eafclJ8c1yrc6lbHbvszRInbq9lb21m93bZySRSu0cbvAuhfeb72hwinEI42Y++n1jMhWnopFsqDY73+YE6mYtvvrQIhFMY+7+hr/LiHsFBAlKcIAzDNSRCOVFxlKthHfL8Y/+pR9hZYufW8hfxkSjwRLLbrDqL3wZzLzwZZOphQ2aAIAJgZgGBQsvHMJUzHSluQWyr8P2/TAc6WvJbuo/OQpEnKF4nyqiTXNS1otc5YCIbY2CrGzgPXmYty0tGwpfKT5kT32PyGOrTrbk/i+GI7b/cyv3aQrCzaX6/jEvqlVCx49AZRs10VgU66L3I9CHpC9sax1u5a1xh3a3oo9C5y4n5mZ58jZdkYe3/F5WRjMAYhbj9hNkdO/eq4xVuSY3JIoq14Z2ZQE7hGa6rcRCmFo2Em8eio2FDYncSj5+NNZMQbEvMMMOlcqidX8OVqJmc/3oorMIYx/bdipnkhYR4mrgQAJfRomRcUh5iJpDJsIdlKFqbXezHrQQKc4w9WJpmqnteX7LDwGS8/gQU9hcRmOAJre286FRLE1lJTYkG4JHS+PqKexRvKaIYyCD2NLcISBUAtS6mXOBJ7hLeEQbmB2SGpp1pe62zvfkpi28risdMW/6Ixn5tRf6MQEM2xpoCgXC6yzwW802YqsQ
DKIM-Signature: a=rsa-sha256; bh=h+6pD3peeMFxu47KbdziNuIe6rgb845bLJ+8pVDeguk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1794323714; v=1;
 b=uucewEtglpLhMwzApl1+qwEq+3s6IiAbkAHHtnDMaEip/LZgYNRgbvHbVcDALPHgUs9+1nMr
 UDP5f2aYUaFttYtkzbzbZm++Na+ctq15WEph96oyZUhdqSkjFZvlNY4Dy8mOMw70pa8IPLsqBPG
 /KkjDzi6YIMOuwImf1HVQfmZAr4ChqkBkbGv/Gu+9hhzP7tZPmTO3iBU1fGa6IU/tNsGmYlZBON
 wOdr2QFKIzKa7iV1sJKW9+xFDAERTvqEGQJ9uskC7/MhK3fstVv9WBtJGj7BcMnh2n52BT5L0Fv
 zxIswA3sIlL4pXrMwWyw7x4cc5Fq3gUGMdR59S0m0Okpw==
Received-SPF: pass client-ip=51.210.91.17; envelope-from=clg@kaod.org;
 helo=smtpout8.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 14:12, Daniel P. Berrangé wrote:
> The VFIO subsystem is about securely passing host PCI devices
> to a guest, so all the classes should be presumed to be offering
> a security boundary.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com> #s390 types
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/vfio-user/pci.c | 1 +
>   hw/vfio/ap.c       | 1 +
>   hw/vfio/ccw.c      | 1 +
>   hw/vfio/igd.c      | 1 +
>   hw/vfio/iommufd.c  | 2 ++
>   hw/vfio/pci.c      | 2 ++
>   hw/vfio/spapr.c    | 1 +
>   7 files changed, 9 insertions(+)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index 983e1d4ad47..d8965fd02ee 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -487,6 +487,7 @@ static const TypeInfo vfio_user_pci_info = {
>       .class_init = vfio_user_pci_class_init,
>       .instance_init = vfio_user_pci_init,
>       .instance_finalize = vfio_user_pci_finalize,
> +    .secure = true,
>   };
>   
>   static void register_vfio_user_dev_type(void)
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 2926e04ad49..45d67b8ba70 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -356,6 +356,7 @@ static const TypeInfo vfio_ap_info = {
>       .instance_size = sizeof(VFIOAPDevice),
>       .instance_init = vfio_ap_instance_init,
>       .class_init = vfio_ap_class_init,
> +    .secure = true,
>   };
>   
>   static void vfio_ap_type_init(void)
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 8e29a3ae613..6d71e196ee0 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -723,6 +723,7 @@ static const TypeInfo vfio_ccw_info = {
>       .instance_size = sizeof(VFIOCCWDevice),
>       .instance_init = vfio_ccw_instance_init,
>       .class_init = vfio_ccw_class_init,
> +    .secure = true,
>   };
>   
>   static void register_vfio_ccw_type(void)
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 4c7d6545924..df70cdd9403 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -313,6 +313,7 @@ static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
>       .name = "vfio-pci-igd-lpc-bridge",
>       .parent = TYPE_PCI_DEVICE,
>       .class_init = vfio_pci_igd_lpc_bridge_class_init,
> +    .secure = true,
>       .interfaces = (const InterfaceInfo[]) {
>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>           { },
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index de482128bf1..ab466b513ec 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -1061,10 +1061,12 @@ static const TypeInfo types[] = {
>           .parent = TYPE_VFIO_IOMMU,
>           .instance_size = sizeof(VFIOIOMMUFDContainer),
>           .class_init = vfio_iommu_iommufd_class_init,
> +        .secure = true,
>       }, {
>           .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
>           .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
>           .class_init = hiod_iommufd_vfio_class_init,
> +        .secure = true,
>       }
>   };
>   
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 428ab2f0698..03ab5bd0f48 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -4110,6 +4110,7 @@ static const TypeInfo vfio_pci_info = {
>       .class_init = vfio_pci_class_init,
>       .instance_init = vfio_pci_init,
>       .instance_finalize = vfio_pci_finalize,
> +    .secure = true,
>   };
>   
>   static const Property vfio_pci_nohotplug_properties[] = {
> @@ -4146,6 +4147,7 @@ static const TypeInfo vfio_pci_nohotplug_info = {
>       .parent = TYPE_VFIO_PCI,
>       .instance_size = sizeof(VFIOPCIDevice),
>       .class_init = vfio_pci_nohotplug_class_init,
> +    .secure = true,
>   };
>   
>   static void register_vfio_pci_dev_type(void)
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 42690e4323d..1027c434c07 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -544,6 +544,7 @@ static const TypeInfo types[] = {
>           .parent = TYPE_VFIO_IOMMU_LEGACY,
>           .instance_size = sizeof(VFIOSpaprContainer),
>           .class_init = vfio_iommu_spapr_class_init,
> +        .secure = true,
>       },
>   };
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


