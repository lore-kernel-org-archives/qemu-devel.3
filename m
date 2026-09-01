Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD84C624D2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Nci-00088N-4J; Tue, 01 Sep 2026 08:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x1Ncg-00087s-4g; Tue, 01 Sep 2026 08:29:54 -0400
Received: from smtpout6.mo536.mail-out.ovh.net ([51.210.91.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x1Ncd-0004x1-SU; Tue, 01 Sep 2026 08:29:53 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hZ4th3lJJz88t2;
 Tue,  1 Sep 2026 12:29:48 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 12:29:48 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.115])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hZ4th26r1z1xqW; Tue,  1 Sep 2026 12:29:48 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 1D63D1B43FDA;
 Tue,  1 Sep 2026 12:29:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S00856fe61b7-9bc6-45f2-baa6-075132207f28,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0237980f-b2ba-41bb-976c-beac1c7ec05d@kaod.org>
Date: Tue, 1 Sep 2026 14:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC
 model
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
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
 <20260901085238.995968-8-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260901085238.995968-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14212234525898550317
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG1ogxU9cBrkFrGiEYuYurOBKTouwxTEu0bLFuXKyHdRh+ZHyDSf54rO2Tm3WZNM0QOSqZ2H3/HrSZ6U+gnjghyZDWfucvPmYLh8VQEAQvN3/vmhkRsYUhZ5udPJ+D64mm5o1WndBqebC2pRi/MiLyOfdG0vyQBxOECc6S0PA4AaoL0rgxYvicflZy1sgtJr85H7zlPJCIGYVluqRgSEFMGjttNLIUDkc1qArPae3HskNvAT/pnSUAvKsEvgwse5zrW9e0YoeeX6sTEqsKtmpT3jp8dKvlBoBwsYvGIDCu79TF07tPBll8yy76Wq7FnnsmXn9Dv7Q0hK6iSTf72ZBt2gnkYibw4haXdJOqBy6xSV1gpmhw7QU7CPh9tTsdiN/gzj2yHyVfksIcOQ9F3AkoeHbhYFKGM5kRWeSJRTFHJEaHXhsYfurFXL6a1ZY844F76h+UaInWcCPfmQD3VoicdcfIeH34LI4wKNRPpzpqVx5nYksgYcnadRYe9kI/vyLL88PK5+mj0F8jnRpd6N0RDEMC0VCGQlGnWFUoy7gEgCBbDswOyA9o/qhtnbbhJwx90xuenWQ7BvHM1FuLYZ1HPveWtS8/OPQdG5CO2UiPaQpv0l0Cd9l4zalYgWZ+fhIp6SAzwFsAfCe92rraLbo7UtwnTlyGDFqQ++NqaKeZ+tw
DKIM-Signature: a=rsa-sha256; bh=N4MFFinttoDr60oo7Q7eTIfb2Icd0bR2i1nrJVsrS1I=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788265789; v=1;
 b=MsMBXWXEn7ZJsWRLyrN/0z64wexaXQFxpsQj3jl3acwIv7IJyqyY1XzMxE61QhSBaiUHvZUA
 L+/MMfiMAE9Tw24CzTBjvF2cHZgmim228lTGzJf/k1gVCU8PdeB6VT6D3Gg9jCHwOv1u27wFNTm
 X059vGH97B42INexyeLuDegKDRRNNp/ycsmRNpxAG8bEcoCUlRCRJBcvmZbjp1xKD14E4zSQn1Y
 jhdkkugLkWLER43e9sixHM7ayffkvklN+7DCaChPrnQVIOWVlCqvjyt4RxOH+y0lxWdcqCkq1lo
 VlxBakTr2NzmXUolsoWeOaXruO4ltHEyXG0jiIAPSyF1w==
Received-SPF: pass client-ip=51.210.91.15; envelope-from=clg@kaod.org;
 helo=smtpout6.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/1/26 10:52, Jamin Lin wrote:
> Introduce the "has_ecdsa" class attribute and enable it for the AST10x0 SBC,
> as ECDSA is only supported on this platform.
> 
> Add an "sram" link property to the SBC model and initialize a dedicated address
> space for accessing the SEC SRAM. This will be used by the ECDSA verify command
> to read the public key, signature, and digest from SRAM.
> 
> Wrap the SEC SRAM in a container mapped at offset 0. This allows the ECDSA
> engine added in a later patch to access the SRAM using relative offsets without
> requiring the SBC model to know the SRAM's system address.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_sbc.h |  4 ++++
>   hw/arm/aspeed_ast10x0.c      |  7 ++++++-
>   hw/misc/aspeed_sbc.c         | 11 +++++++++++
>   3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index eea6e2b27f..756c612356 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -40,12 +40,16 @@ struct AspeedSBCState {
>       uint32_t regs[ASPEED_SBC_NR_REGS];
>   
>       AspeedOTPState otp;
> +
> +    MemoryRegion *sram;
> +    AddressSpace sram_as;
>   };
>   
>   struct AspeedSBCClass {
>       SysBusDeviceClass parent_class;
>   
>       bool has_otp;
> +    bool has_ecdsa;
>   };
>   
>   #endif /* ASPEED_SBC_H */
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index 5165dcce59..aeb5a4423d 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -250,8 +250,11 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
>           error_propagate(errp, err);
>           return false;
>       }
> +    memory_region_init(&s->sram_container[1], OBJECT(s), "sec.sram-container",
> +                       sc->sram_size[1]);
> +    memory_region_add_subregion(&s->sram_container[1], 0, &s->sram[1]);
>       memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
> -                                &s->sram[1]);
> +                                &s->sram_container[1]);
>   
>       /* SCU */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
> @@ -350,6 +353,8 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
>       }
>   
>       /* Secure Boot Controller */
> +    object_property_set_link(OBJECT(&s->sbc), "sram", OBJECT(&s->sram[1]),
> +                             &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {
>           return false;
>       }
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index 7397d9bbf0..f10f7ac578 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -306,6 +306,14 @@ static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    if (sc->has_ecdsa) {
> +        if (!s->sram) {
> +            error_setg(errp, TYPE_ASPEED_SBC ": 'sram' link not set");
> +            return;
> +        }
> +        address_space_init(&s->sram_as, s->sram, TYPE_ASPEED_SBC ".sram");
> +    }
> +
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
>               TYPE_ASPEED_SBC, ASPEED_SBC_NR_REGS << 2);
>   
> @@ -325,6 +333,8 @@ static const VMStateDescription vmstate_aspeed_sbc = {
>   static const Property aspeed_sbc_properties[] = {
>       DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
>       DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
> +    DEFINE_PROP_LINK("sram", AspeedSBCState, sram,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>   };
>   
>   static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
> @@ -355,6 +365,7 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "AST10X0 Secure Boot Controller";
>       sc->has_otp = true;
> +    sc->has_ecdsa = true;
>   }
>   
>   static const TypeInfo aspeed_sbc_types[] = {

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


