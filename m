Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721E4C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0zy1-0003Ke-Dq; Mon, 31 Aug 2026 07:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x0zxz-0003EX-N1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:14:19 -0400
Received: from smtpout10.mo540.mail-out.ovh.net ([51.210.91.59])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x0zxs-0003ed-BF
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:14:18 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hYRFr4Qd1z44lM;
 Mon, 31 Aug 2026 11:14:08 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 31 Aug 2026 11:14:07 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.168])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYRFq6snnz6GrT; Mon, 31 Aug 2026 11:14:07 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 A4DFA2403FCF; Mon, 31 Aug 2026 11:14:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0067c340bd9-e64f-47f1-8006-12aba91b76da,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <463ed44f-4f40-4e49-9dae-e4f1f2ef721b@kaod.org>
Date: Mon, 31 Aug 2026 13:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hw/misc/aspeed_sbc: Derive secure boot state from
 OTP config straps
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831053658.462203-1-kane_chen@aspeedtech.com>
 <20260831053658.462203-3-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260831053658.462203-3-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 7061362744860322827
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE/sE9c0CZySgCJR978j52jRRUAwg3V2UjdhKxDeYDQ4LRB42n5sjCFRWBsNYphkHDIpy4J+BwzaPHOwidZf9jg2DuaEih2W+fQO9tJTOJqS2pfjTtrJN66rBjTuEkzz2nvOJIEagdmdIbF4g0YczZwhfCJiJ3scpJg3Mg2PBYZFka3w9cGv4/fVU7k7/ddmYHa/N/bOH0ibUU57SoSjAOH4CdYPuC8NRqqlG7SKkdgVjJhIFoa7/OajNTaTn2EwpavQvdiJb4n0wRFcXjSk8mk/dYQTEvZCNfVjlc49OvopS0m+j89pmjD4JTv9nP3c+7omDJp+N7EkfTDh/6RrNkFtxfShvhFjSctOwxN63/gAAm5qffMkq2PW8B8oaNpfZW2dxz7kINK5bkcU78XfzO8UjWwjwwwvLCucP+YutRfG+EMhXAvOVFn4Z8vndl398ZHElc5yv/TGzIGSPl72tTIlVsc562TWMngnXoFXORAKFCxPPPKEaNhEOgpAu3uoUsKuDaya7QFPpUq9hsPBeyD+DVeTc0x60832sYsN3oJBlZVo3LmH+nns1oTL/iotKIWMC6FqbjGs8lJOxoXHpR0fTvwPYYrygpcjctUvCDAdBkXmktJXk+nsx+L5wwoGJnMdNv0FCHTEdfQHM6MywLcaCVq5gM+BCHWAulCtc0HIA
DKIM-Signature: a=rsa-sha256; bh=TSlSS0BctMlt8Ba7lIj34UNuKuXkbWo0cVsDfqWiwtI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788174849; v=1;
 b=oKRPbDk93bi3iJE0OVsmOtzvSSaWM2taS2JpDNPtjeA7FtvCcI8gv55Tu/p4a0qzoAonb1bD
 Y+TYSkc0hBL8DGFzeb6IZLwXDWx618oXB7PqE/DLPoBHFyS33n0rhK2dC93wNycTL//BYCLsdFo
 N0FfivvGvB6WzoUixfr/ZyiUV9VW9DmI7nbfDNDoq0+zEj0f5Mksw7IqldZ+YMTiEREIcE+FN8Y
 cQfteOxfSz+BJY00l3GN/E091Xb3ddygmwaF1Ot/9TU9WDPI+KabY7AF9qcKWWDwHDEcHYkksWy
 GPCWc6iCHIhk4dxuIQurlvzMjG/XnFDTxm7Nt348V+iCA==
Received-SPF: pass client-ip=51.210.91.59; envelope-from=clg@kaod.org;
 helo=smtpout10.mo540.mail-out.ovh.net
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

On 8/31/26 07:37, Kane Chen wrote:
> The secure boot enable bit in R_STATUS and the R_QSR signing settings
> were both driven by a fixed "signing-settings" machine property, but
> the two ended up inconsistent: the logic guarding the R_STATUS enable
> bit was broken and never actually set it, while R_QSR still reported
> the configured signing settings, so a machine could show secure boot
> configured in R_QSR while R_STATUS said it was disabled.
> 
> Instead of relying on the property, read the relevant OTP
> configuration bits directly and derive both the R_STATUS secure boot
> enable state and the QSR value from them, matching how the real
> hardware determines these settings. The now-unused "signing-settings"
> property is removed.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_sbc.h |  2 --
>   hw/misc/aspeed_sbc.c         | 34 ++++++++++++++++++++++++----------
>   2 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 7152497b2a..474922cbd2 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -32,8 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
>   struct AspeedSBCState {
>       SysBusDevice parent;
>   
> -    uint32_t signing_settings;
> -
>       MemoryRegion iomem;
>   
>       uint32_t regs[ASPEED_SBC_NR_REGS];
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index 5d4da39d30..ce03f717a9 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -63,6 +63,19 @@
>   /* OTP Address */
>   #define OTP_CFG0                (0x800)
>   
> +static bool aspeed_sbc_otp_read(AspeedSBCState *s, uint32_t otp_addr);
> +
> +static uint32_t aspeed_otp_read_cfg0(AspeedSBCState *s)
> +{
> +    uint32_t value = 0;
> +
> +    if (aspeed_sbc_otp_read(s, OTP_CFG0)) {

This call is clobbering s->regs[R_CAMP1]. Let's see how we can improve
patch 1 first.

Thanks,

C.


> +        value = s->regs[R_CAMP1];
> +    }
>> +    return value;> +}
> +
>   static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
>   {
>       AspeedSBCState *s = ASPEED_SBC(opaque);
> @@ -76,7 +89,12 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
>           return 0;
>       }
>   
> -    return s->regs[addr];
> +    switch (addr) {
> +    case R_QSR:
> +        return aspeed_otp_read_cfg0(s);
> +    default:
> +        return s->regs[addr];
> +    }
>   }
>   
>   static bool aspeed_sbc_otp_read(AspeedSBCState *s,
> @@ -291,6 +309,7 @@ static bool aspeed_get_abr_state(AspeedSBCState *s)
>   static void aspeed_sbc_reset_hold(Object *obj, ResetType type)
>   {
>       AspeedSBCState *s = ASPEED_SBC(obj);
> +    uint32_t value;
>       bool abr;
>   
>       memset(s->regs, 0, sizeof(s->regs));
> @@ -304,11 +323,11 @@ static void aspeed_sbc_reset_hold(Object *obj, ResetType type)
>           s->regs[R_STATUS] |= ABR_EN;
>       }
>   
> -    if (s->signing_settings) {
> -        s->regs[R_STATUS] &= SECURE_BOOT_EN;
> -    }
> +    value = aspeed_otp_read_cfg0(s);
>   
> -    s->regs[R_QSR] = s->signing_settings;
> +    if (value & BIT(1)) {
> +        s->regs[R_STATUS] |= SECURE_BOOT_EN;
> +    }
>   }
>   
>   static void aspeed_sbc_instance_init(Object *obj)
> @@ -352,10 +371,6 @@ static const VMStateDescription vmstate_aspeed_sbc = {
>       }
>   };
>   
> -static const Property aspeed_sbc_properties[] = {
> -    DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
> -};
> -
>   static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -364,7 +379,6 @@ static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
>       dc->realize = aspeed_sbc_realize;
>       rc->phases.hold = aspeed_sbc_reset_hold;
>       dc->vmsd = &vmstate_aspeed_sbc;
> -    device_class_set_props(dc, aspeed_sbc_properties);
>   }
>   
>   


