Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2FCF4BB99
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvCR0-00024b-DB; Wed, 25 Feb 2026 05:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvCQx-00023T-HC
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:48:00 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvCQu-0000Ig-Rg
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:47:59 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.158])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4fLWWs2W3Hz68wf;
 Wed, 25 Feb 2026 10:47:52 +0000 (UTC)
Received: from kaod.org (37.59.142.112) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 11:47:51 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006f6eae99f-349d-4cc0-b764-710a72c73ceb,
 C59C41ABD0014BFD9FF8970E1C3D3014408A4F94) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <a97ceb77-11ca-4010-b11e-02579587750e@kaod.org>
Date: Wed, 25 Feb 2026 11:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/22] hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and
 align parent_obj naming
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260225021158.1586584-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.112]
X-ClientProxiedBy: DAG17EX1.mxp5.local (172.16.2.171) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 51afafc6-4e6d-4e5c-917c-78a59abc4cce
X-Ovh-Tracer-Id: 15228922143432280964
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGCWqxcYpsEoCeniVXbJaV60epsjA9WPTNgrGHcavmY2cQl7eKP21Y6ScYG4fzDR0DgjnPzAixARXQoi6ySxxuTQ687aQXWoIDIum5YB9daF9h7n+Z6MOevIMs3hNkGPtZX4YhaUMbVxVw7Lt5p+2PTYMIxmCvaOAsXoNwE62D6JmtFSWdqCBKBrvG5sdxbx6NiNQjmLLeK1hxRU4V36BEYtUrZ7DP73DYKqBaUvzJ98ygCcC3sw2q1ZLovN+kYi+A6ul8f8/6Y/QMIKl7dk44j6kFqoKcnRt8mkMwaOeUIRMTPsYAuxuy2xB+exkM0JUPuxcj6h1GSvayvHhI52pF6Hlr/hZClZSVi7AqIzLPuAhKN7wk41gdFgSaU2EuQIfbamJO0F9Uf+D46DWLEbId6aBxqYA2jHEJZRbs1aizIFVZfGWPE7E+M/uTAnW80O7D7SmfTRGaeckvOa2vcEXjrBubdVQQmQ2RSPU8kWTsdu59Twg1NTAEhsyqSa9KzQkRmITejL31S8hOvjDwBXR7724Lyttrb8AtYlkR6Y5PnsTYrimKSAGmV5/caLZXGhQNgj42M0socEbCDJhcfgbQAO2QfQr3ICDhdLXMJeYtelywYPWzGyLd09COSbOzirwH7c7PcZhPW8tOneuYE28tOt1Ho5LHsD5qcoHat/3N2mA
DKIM-Signature: a=rsa-sha256; bh=3DMW+YhOC+SmSWPUYYzqdp6wOQcTFVJGj7gMDr9aKdg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772016474; v=1;
 b=PM2bE1D4XaHwkVpRxZYovvap4eMUleSspKDW6YrirMMSuNm55nUgwDj8wvwBZkIXtl4EkDpM
 +fDObCrMWEGPCv7eBQA6Jfa9YJQaow2fFTAykPaXFYY9qeIX7ctXyfh+NxL3UgRcVUDBQfNMk5r
 siBwZqxqKSlnR+i2WiEER75FvCo5q8sWvS/8UhOwtOb4de4R0IMAbD623INrqLW9ofOn0kBsARU
 JO0wDI/6+tJKg6vRVl8oxC767qHnG+ekSl0lU6kVpx6QldP0FwUrZ6imFnJkZW8PpaZRZed782e
 Pl4hV5J07I28/jff7beE4FH5gpsrkTsAgIFnlXgr25NHw==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/25/26 03:12, Jamin Lin wrote:
> Following review feedback, update the Aspeed I3C device to use the
> DEFINE_TYPES() macro instead of an explicit type registration function.
> 
> DEFINE_TYPES() is the currently recommended approach in QEMU for
> registering multiple TypeInfo entries and avoids boilerplate
> type_init() code.
> 
> Additionally, rename embedded SysBusDevice fields from "parent" to
> "parent_obj" to comply with the QEMU coding style guidelines for QOM
> objects.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/i3c/aspeed_i3c.h | 16 ++++++----------
>   hw/i3c/aspeed_i3c.c         | 35 +++++++++++++++--------------------
>   2 files changed, 21 insertions(+), 30 deletions(-)
> 
> diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
> index 7a984e1f01..bd0ffc84ea 100644
> --- a/include/hw/i3c/aspeed_i3c.h
> +++ b/include/hw/i3c/aspeed_i3c.h
> @@ -21,28 +21,24 @@ OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)
>   #define ASPEED_I3C_NR_DEVICES 6
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)
> -typedef struct AspeedI3CDevice {
> -    /* <private> */
> -    SysBusDevice parent;
> +struct AspeedI3CDevice {
> +    SysBusDevice parent_obj;
>   
> -    /* <public> */
>       MemoryRegion mr;
>       qemu_irq irq;
>   
>       uint8_t id;
>       uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];
> -} AspeedI3CDevice;
> +};
>   
> -typedef struct AspeedI3CState {
> -    /* <private> */
> -    SysBusDevice parent;
> +struct AspeedI3CState {
> +    SysBusDevice parent_obj;
>   
> -    /* <public> */
>       MemoryRegion iomem;
>       MemoryRegion iomem_container;
>       qemu_irq irq;
>   
>       uint32_t regs[ASPEED_I3C_NR_REGS];
>       AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];
> -} AspeedI3CState;
> +};
>   #endif /* ASPEED_I3C_H */
> diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
> index fff259ff66..e7cdfbfdbd 100644
> --- a/hw/i3c/aspeed_i3c.c
> +++ b/hw/i3c/aspeed_i3c.c
> @@ -337,13 +337,6 @@ static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *data)
>       device_class_set_props(dc, aspeed_i3c_device_properties);
>   }
>   
> -static const TypeInfo aspeed_i3c_device_info = {
> -    .name = TYPE_ASPEED_I3C_DEVICE,
> -    .parent = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(AspeedI3CDevice),
> -    .class_init = aspeed_i3c_device_class_init,
> -};
> -
>   static const VMStateDescription vmstate_aspeed_i3c = {
>       .name = TYPE_ASPEED_I3C,
>       .version_id = 1,
> @@ -366,18 +359,20 @@ static void aspeed_i3c_class_init(ObjectClass *klass, const void *data)
>       dc->vmsd = &vmstate_aspeed_i3c;
>   }
>   
> -static const TypeInfo aspeed_i3c_info = {
> -    .name = TYPE_ASPEED_I3C,
> -    .parent = TYPE_SYS_BUS_DEVICE,
> -    .instance_init = aspeed_i3c_instance_init,
> -    .instance_size = sizeof(AspeedI3CState),
> -    .class_init = aspeed_i3c_class_init,
> +static const TypeInfo aspeed_i3c_types[] = {
> +    {
> +        .name = TYPE_ASPEED_I3C,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_init = aspeed_i3c_instance_init,
> +        .instance_size = sizeof(AspeedI3CState),
> +        .class_init = aspeed_i3c_class_init,
> +    },
> +    {
> +        .name = TYPE_ASPEED_I3C_DEVICE,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(AspeedI3CDevice),
> +        .class_init = aspeed_i3c_device_class_init,
> +    },
>   };
>   
> -static void aspeed_i3c_register_types(void)
> -{
> -    type_register_static(&aspeed_i3c_device_info);
> -    type_register_static(&aspeed_i3c_info);
> -}
> -
> -type_init(aspeed_i3c_register_types);
> +DEFINE_TYPES(aspeed_i3c_types)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



