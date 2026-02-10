Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47299EA3F1C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpikt-0003cN-OD; Tue, 10 Feb 2026 03:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpikr-0003b1-0w
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:05:53 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpiko-0000iF-EX
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 03:05:52 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.108])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f9Ddk2tVWz5vSF;
 Tue, 10 Feb 2026 08:05:46 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 10 Feb
 2026 09:05:44 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002acd1057f-cd6d-4aac-a42a-23d0a0fe0777,
 013E132ABECAD38B5622F7607EFF7317793E1520) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <12795885-9b28-44fe-8f58-a297ee628a9c@kaod.org>
Date: Tue, 10 Feb 2026 09:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/i2c/aspeed_i2c: Increase I2C device register
 size to 0xA0
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260210024331.3984696-1-jamin_lin@aspeedtech.com>
 <20260210024331.3984696-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260210024331.3984696-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: f2406f3d-0563-44a8-956c-35a6b92687d3
X-Ovh-Tracer-Id: 16634608174881016754
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEqyOpHY0Si6HC+jYGeoz6Q626+nyx/AxkmTAmaWS0WdYPEabQUNXiJoI4+OTFhjiQYHYzV8Fc6W3AFUxFes2jce2xiMnVTqvmPCwI6v/R9bTT/9QqVFrxhUBEDS95UdHhWl3YcvOOfg3QWWOsT3ZMdM2XfPxwtZccACkISzcWicbU073aLYATRiLjJigPYw/ipIG5jUxqNk0MtDLoKXiAsAe4PV4wem0UQ3vrt6BTHfbvCcWbteulLYP58RWKNaME9/WnLuBR4cq9EATb6q829M68mGmiRLnrlYkYlDxU2cevypsuVcXuh8jxrILDhWvr1pbkJW8X1G9NQEZJh0D8bWwzNtiUtM5xoVybJ2g8puwhmWNLRk/Wd9IBdZW+RTPCn1+ZjYk6fZkUA1Cfmh6jAF3tYthe8S/5wWAlp8Zq9NBmRgsGaFQeqYjb3zx2vvt21x5MeWnWwuXboH/M3Z35OuEz22Fzg9fmwrdbYhYF7KfNpgon+WRlSoNoZm4PSiusgKDlJlVeyYorCOzHOAv+tjTNDzZjdX+3uyBCEMsIrpUi3ZPjzXvQKNvgn6qJSZ6pHmIXkrjkgTMfIAHnRbpTIH/83lEdTNroNGUUZIDMoPwGfWLQ04JJwtGjybC7Uyb0jsiRIXO016V6SQ4UZoLiydcjv839zVxBgaFI/69IjPw
DKIM-Signature: a=rsa-sha256; bh=UVhCk1VpBLSW7AbTqRE+heTse0/z2+okpVFVetD/7zw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770710746; v=1;
 b=gz4dR6HB9H/e5W0O1/OePtCUzKLFgBRYXFPq0UeEb1elwU3NmSKPc4L9Hc6NU0fBdRZrO+Hv
 /KzkHNs9Qzz9dCvK/xbmHklFdW5Au7jy8Rz03F9aq5zj39CjjDft7/LoT3F5jgYUjglViZh3heH
 vq5lfeEkW9/TrLItRkrCeVQC7/55V8UBBgYBhlqevNu+oVCVF9NrzMCis3TzAbigMJR0KK4uZQk
 3LR4A/7184ZePd6JlrdSJXHEB3OI/2vs/l4hIBIwrimOMP1QglQ/PC7K+7pTUj/VvIr3lm+OE5o
 HSoXHwzenbvQ4ZwXcPZ+cmPNHXTooeQ4SiwnEPhHiU+JA==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=clg@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/10/26 03:43, Jamin Lin wrote:
> According to the AST2700 A1 datasheet, the register space for each I2C
> device instance has been expanded from 0x80 bytes to 0xA0 bytes.
> 
> Update the AST2700 I2C controller configuration to reflect the new
> register layout by increasing the per-device register size to 0xA0
> and adjusting the register gap size accordingly.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Fixes: 4f53de2f103d6dfb5ad0498995d91a9694f40dd2 ("hw/arm/aspeed_ast27x0: Remove ast2700-a0 SOC")
> ---
>   include/hw/i2c/aspeed_i2c.h |  2 +-
>   hw/i2c/aspeed_i2c.c         | 36 ++++++++++++++++++------------------
>   2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 1ba0112cef..53a9dba71b 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -36,7 +36,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
>   #define ASPEED_I2C_NR_BUSSES 16
>   #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
>   #define ASPEED_I2C_BUS_POOL_SIZE 0x20
> -#define ASPEED_I2C_NEW_NUM_REG (0x80 >> 2)
> +#define ASPEED_I2C_NEW_NUM_REG (0xa0 >> 2)
>   
>   #define A_I2CD_M_STOP_CMD       BIT(5)
>   #define A_I2CD_M_RX_CMD         BIT(3)
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 741c7a7297..122bfdd63d 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1205,37 +1205,37 @@ static void aspeed_i2c_instance_init(Object *obj)
>    *
>    * Address Definitions (AST2700)
>    *   0x000 ... 0x0FF: Global Register
> - *   0x100 ... 0x17F: Device 0
> + *   0x100 ... 0x19F: Device 0
>    *   0x1A0 ... 0x1BF: Device 0 buffer
> - *   0x200 ... 0x27F: Device 1
> + *   0x200 ... 0x29F: Device 1
>    *   0x2A0 ... 0x2BF: Device 1 buffer
> - *   0x300 ... 0x37F: Device 2
> + *   0x300 ... 0x39F: Device 2
>    *   0x3A0 ... 0x3BF: Device 2 buffer
> - *   0x400 ... 0x47F: Device 3
> + *   0x400 ... 0x49F: Device 3
>    *   0x4A0 ... 0x4BF: Device 3 buffer
> - *   0x500 ... 0x57F: Device 4
> + *   0x500 ... 0x59F: Device 4
>    *   0x5A0 ... 0x5BF: Device 4 buffer
> - *   0x600 ... 0x67F: Device 5
> + *   0x600 ... 0x69F: Device 5
>    *   0x6A0 ... 0x6BF: Device 5 buffer
> - *   0x700 ... 0x77F: Device 6
> + *   0x700 ... 0x79F: Device 6
>    *   0x7A0 ... 0x7BF: Device 6 buffer
> - *   0x800 ... 0x87F: Device 7
> + *   0x800 ... 0x89F: Device 7
>    *   0x8A0 ... 0x8BF: Device 7 buffer
> - *   0x900 ... 0x97F: Device 8
> + *   0x900 ... 0x99F: Device 8
>    *   0x9A0 ... 0x9BF: Device 8 buffer
> - *   0xA00 ... 0xA7F: Device 9
> + *   0xA00 ... 0xA9F: Device 9
>    *   0xAA0 ... 0xABF: Device 9 buffer
> - *   0xB00 ... 0xB7F: Device 10
> + *   0xB00 ... 0xB9F: Device 10
>    *   0xBA0 ... 0xBBF: Device 10 buffer
> - *   0xC00 ... 0xC7F: Device 11
> + *   0xC00 ... 0xC9F: Device 11
>    *   0xCA0 ... 0xCBF: Device 11 buffer
> - *   0xD00 ... 0xD7F: Device 12
> + *   0xD00 ... 0xD9F: Device 12
>    *   0xDA0 ... 0xDBF: Device 12 buffer
> - *   0xE00 ... 0xE7F: Device 13
> + *   0xE00 ... 0xE9F: Device 13
>    *   0xEA0 ... 0xEBF: Device 13 buffer
> - *   0xF00 ... 0xF7F: Device 14
> + *   0xF00 ... 0xF9F: Device 14
>    *   0xFA0 ... 0xFBF: Device 14 buffer
> - *   0x1000 ... 0x107F: Device 15
> + *   0x1000 ... 0x109F: Device 15
>    *   0x10A0 ... 0x10BF: Device 15 buffer
>    */
>   static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
> @@ -1658,8 +1658,8 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
>       dc->desc = "ASPEED 2700 I2C Controller";
>   
>       aic->num_busses = 16;
> -    aic->reg_size = 0x80;
> -    aic->reg_gap_size = 0x80;
> +    aic->reg_size = 0xa0;
> +    aic->reg_gap_size = 0x60;
>       aic->gap = -1; /* no gap */
>       aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
>       aic->pool_size = 0x20;

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


