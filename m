Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE75C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wzx-0002HH-Fc; Mon, 31 Aug 2026 04:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x0wzq-0002Gf-5l
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:04:03 -0400
Received: from smtpout10.mo539.mail-out.ovh.net ([51.210.91.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x0wzn-0002tP-Ll
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:04:01 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hYM2P0Ng7z41xm;
 Mon, 31 Aug 2026 08:03:57 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 31 Aug 2026 08:03:56 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.129])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYM2N6J2tz1xv1; Mon, 31 Aug 2026 08:03:56 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 0437E941BCE; 
 Mon, 31 Aug 2026 08:03:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00586932015-059f-40bb-a56c-9c0d6a7860b0,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <7d141b4c-8f72-4414-b2ee-316711a1a26f@kaod.org>
Date: Mon, 31 Aug 2026 10:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] hw/misc/aspeed_sbc: Increase register space to
 0x1000
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
 <20260831034153.192916-8-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260831034153.192916-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 3849451782853798957
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFsqCKVDCrq+AJDwjAG6zTpVQ1I1Zq/Vxy1uQLlt5jEHVxapc3EMiHRQo+n1VF4/YzjbgmbhMWMRed5QvtZ0MDlSE0FcRTF5ZvEQpNdtZHGv7mdcZurSGdYADSw5njf1gT1oqch5Qj6A1MXX/gptvaiVZHTHdVS/B1Xom54tNmUVPBerUjnA8TUCcUmcaLmvaa35q/hyxaRZadYZsHcOZYQO/QCGuMjRQNgg0X2CFCwm36XSwur6OJ2cUKJ4sIBTrD1O05cPg96c/96NhBVzXn7aPAo6MBOTqx7SvYWFKOvcTwESPQAd+zD3M8yljl4FmdIS/atMes0NIoZCIjRkbrKSIsmjaN7+kEOtrfkqgQiNHlYBeTM3KsJyfgk6eL3yjfC0A6LlD7p7UnZV/qrXelduXOC2royvj6fhVnMxvci5D1WgAB5XvBouwFXgtVWT1YqYiXFr8khpCWGDxIHIGMFKGFcFNg+RYmb2Z375oe/ZHKTPV/ecZ/C6/uyn6umilSY/5z2Y/1z5pDRZ3qfoZPyy0cHUKVfLdCImHLvbyS2uyDTh9SA0WmSn4Z9NHnWpm1ZHkFgLAWn2vST8/q4tT7O7jxfFyY41Pcn8vMu5UEwB6tzGFef7EIieuCIggoRN1xvpCznKNDUXwPTfyznIZc0YCqAKxKycGAXKP9PH46upA
DKIM-Signature: a=rsa-sha256; bh=PFpipJLBeSdILC6t0pkAsFVuVnwACi0GX+3uRYEOCpM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788163437; v=1;
 b=JfjrXQchHaTIRr7GwvyhOXW9kvkq/aKVyqTiuJFFyLD/UW5QVikEGPRb5LiIZSah1JLcCeY+
 1uz279GrzB0db3mqZtBozOsf/maNAypGmCWDUfUbTK3aC4zVdBWcnjettx8EQ7DpsG99xhs+ZOR
 HX8J/aG0eOhpgw2jYuwc3y8bzbU8hAAcnGg3ZLP7/qIQemWdj607Lqh6x5P7cfnIBCXHTF695S6
 v8V5F5wM3sZ+ccgad7y/Dl3+AQVOyBE9oLNe9F0Bo3dcD+o7n86LrjSI6pHyQJCZK3qcZSxgj1L
 OqzzsZvadP7NATamTWx2SOJ5HId2iQxja/Q6V/9vx8LbQ==
Received-SPF: pass client-ip=51.210.91.49; envelope-from=clg@kaod.org;
 helo=smtpout10.mo539.mail-out.ovh.net
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/31/26 05:42, Jamin Lin wrote:
> The SBC controller register space is 0x1000.
> Increase ASPEED_SBC_NR_REGS accordingly to cover the
> full register space.
> 
> Bump the VMState version to 2.

Which means QEMU cannot load a migration stream from any older QEMU
version. Just add that migration compatibilty is broken.

That's ok, Aspeed machines are not intended for virtualization use
case.

Thanks,

C.

> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_sbc.h | 2 +-
>   hw/misc/aspeed_sbc.c         | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 8d3f9207fc..756c612356 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -17,7 +17,7 @@
>   #define TYPE_ASPEED_AST10X0_SBC TYPE_ASPEED_SBC "-ast10x0"
>   OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
>   
> -#define ASPEED_SBC_NR_REGS (0x93c >> 2)
> +#define ASPEED_SBC_NR_REGS (0x1000 >> 2)
>   
>   #define QSR_AES                     BIT(27)
>   #define QSR_RSA1024                 (0x0 << 12)
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index aa167be4c0..5c193d9086 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -456,15 +456,15 @@ static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
>       }
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
> -            TYPE_ASPEED_SBC, 0x1000);
> +            TYPE_ASPEED_SBC, ASPEED_SBC_NR_REGS << 2);
>   
>       sysbus_init_mmio(sbd, &s->iomem);
>   }
>   
>   static const VMStateDescription vmstate_aspeed_sbc = {
>       .name = TYPE_ASPEED_SBC,
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, AspeedSBCState, ASPEED_SBC_NR_REGS),
>           VMSTATE_END_OF_LIST(),


