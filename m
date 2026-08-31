Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17161C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0zuR-0001CX-Mx; Mon, 31 Aug 2026 07:10:39 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x0zuP-000191-TC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:10:37 -0400
Received: from smtpout2.mo536.mail-out.ovh.net ([51.210.91.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x0zuL-0002t4-Bm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:10:37 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hYR9c25y8z88kF;
 Mon, 31 Aug 2026 11:10:27 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 31 Aug 2026 11:10:27 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.171])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYR9b45Sfz6GrV; Mon, 31 Aug 2026 11:10:27 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 63E59941BCC; 
 Mon, 31 Aug 2026 11:10:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006776fafc3-9b89-4419-a60c-87c73a25996e,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f60d0cb7-5981-4dd5-b65b-4a6e9b8a30ed@kaod.org>
Date: Mon, 31 Aug 2026 13:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP
 config straps
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831053658.462203-1-kane_chen@aspeedtech.com>
 <20260831053658.462203-2-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260831053658.462203-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 6999438247581428747
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGgy4wAOF82O17Mm7/H5tH6PgiMI81Z7V3R3eHKVxnj7A/oucwg17jKXLBPhiAIu8ExUo3w9a0vy0xpCWKyIzXPtMaML03vkrmKqLZilyBWJSnWr9tfLBQQDU5z8hpu40q7OCNGhRfL29zV3viKBN1rqsOZ6Lp6AX1D7EA9ciC9jS0tbzgGb5Lv2bzzcDXA+Mk9fdmzaUMvj901nMDJHPAatwr/khCQnnVRfLvxqPXQn4SZUpPRKhRt6vixMMXfINOa5CxMC4LReVlX0mv4qKlwsX4eZQvgCS9E5Z1sXGzmL84l3/guWqHShZ8vMj/W6UXh7JX+uvUEU2srjjlP03BWPUPJk2ra7jrMU/mQAAnU8HUpMI55alj3w4WXnRxOBXmFoIdNrR6yOVuJNT0lN0B7jZ8Sa/Mw4DkhxdzjzwEzL/7d+z3FPpg2l8IW5EkFviTvcJUvGM5MBmIsEy+uU9DXVSly43cKlckIYEl84ei6j/QDHeGuqqAq62W3lVmw7jNymkFFaQiaicUlC2Y7xnpsaabndFOq5VIfmu6QG1ZW/k3XntTee4v3jsZfS6pVvoeGXjmku58dYPzU+s23WUhtOzouFVyQ1qyUvw72DAwpIpAGayS5syKDwC0a0nmWXYUhJ6Zj2cSAeAW6d2jQcLtWh9yK/5bDWV5O8+MMyreF2w
DKIM-Signature: a=rsa-sha256; bh=g6rj9toCi95jLgo12wFjmYKZ7TzGJLty6MFcri8UdsE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788174629; v=1;
 b=Pbb2v+IoyGtxRsu4t9ReDPR9QR1GLU65mnkeMp6DArRgjI9SLxmAcmeSWOYbqo7jr5S+ebzz
 PvfWjB04vCzHtOh29VmVNEosXuvEksQiWXHuE94Cm+9x8PeXKXYhz0PGpgbwEP0lVaUOK2ssEPH
 YIi1jR/XrQi99f3TWVxg1JHtCVlVOcK54s3lHHuBK+wKZyQMX6yBOBhM4v4upJM2KPJp/Gfo1wf
 0UVLcKGItBESe5dn6pGIAr/A1lCD2soUFRAA0uzMN8FS1Bjr/1BqZbGYJfaSJ/ZM5HE5TBJs3Wi
 8BRVo00lXDGrpFmS26u0KQtLkQL/0kMy/oIyBSygWMFlQ==
Received-SPF: pass client-ip=51.210.91.11; envelope-from=clg@kaod.org;
 helo=smtpout2.mo536.mail-out.ovh.net
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
> The eMMC ABR (Alternate Boot Recovery) enable state was controlled by
> a fixed "emmc-abr" machine property, and the logic reflecting it in
> R_STATUS was broken so ABR could never actually be reported as
> enabled.
> 
> Instead of relying on the property, read the ABR strap value directly
> from the OTP configuration space and derive the enable state from it,
> matching how the real hardware determines ABR. The now-unused
> "emmc-abr" property is removed.

This is an ABI breakage. It was never used and broken. I guess we are fine.

> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_sbc.h |  1 -
>   hw/misc/aspeed_sbc.c         | 35 ++++++++++++++++++++++++++++++++---
>   2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 07c7c22a86..7152497b2a 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -32,7 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
>   struct AspeedSBCState {
>       SysBusDevice parent;
>   
> -    bool emmc_abr;
>       uint32_t signing_settings;
>   
>       MemoryRegion iomem;
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index 1dfcf14e5b..5d4da39d30 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -60,6 +60,9 @@
>   #define MODE_REGISTER_A             (0x3000)
>   #define MODE_REGISTER_B             (0x5000)
>   
> +/* OTP Address */
> +#define OTP_CFG0                (0x800)
> +

I think that several OTP defines describing the OTP address space
would be better placed in aspeed_otp.h :

     #define OTP_MEMORY_SIZE 0x4000

     #define OTP_DATA_DWORD_COUNT        (0x800)
     #define OTP_TOTAL_DWORD_COUNT       (0x1000)

     /* OTP Address */
     #define OTP_CFG0                (0x800)

Please explain the various regions.

also, does this test makes sense :

     if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Invalid OTP addr 0x%x\n",
                       otp_addr);
         return false;
     }

since the transaction on the address_space should fail. Or it could be

Please rework aspeed_sbc_otp_read() which duplicate the same code twice.


   static bool aspeed_otp_read_raw(AspeedSBCState *s, uint32_t otp_addr,
                                   uint32_t *value)
   {
       uint32_t otp_offset = otp_addr << 2;

       if (address_space_read(&s->otp.as, otp_offset, MEMTXATTRS_UNSPECIFIED,
                              value, sizeof(*value)) != MEMTX_OK) {
           qemu_log_mask(LOG_GUEST_ERROR,
                         "Failed to read OTP memory, addr = %x\n", otp_addr);
           return false;
       }

       return true;
   }
>   static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
>   {
>       AspeedSBCState *s = ASPEED_SBC(opaque);
> @@ -261,17 +264,44 @@ static const MemoryRegionOps aspeed_sbc_ops = {
>       },
>   };
>   
> +static bool aspeed_get_abr_state(AspeedSBCState *s)

aspeed_sbc_otp_get_abr_state()

Shouln't this be done in the OP model instead.

> +{
> +    uint32_t value;
> +    int i;
> +    bool enable = false;
> +    int config_offset;
> +
> +    /*
> +     * ABR is a strap setting, and each strap setting consists of six
> +     * sub-values. Read all sub-values to retrieve the latest setting.
> +     */
> +    for (i = 17; i < 28; i += 2) {

sigh. What are these magic values ... ?  Please explain.

> +        config_offset = OTP_CFG0; 
> +        config_offset |= (i / 8) * 0x200;
> +        config_offset |= (i % 8) * 0x2;
> +
> +        aspeed_sbc_otp_read(s, config_offset);

May be introduce a aspeed_sbc_otp_read_config() helper.

> +        value = s->regs[R_CAMP1];
> +        enable ^= (value >> 11) & 0x1;
> +    }
> +
> +    return enable;
> +}
> +
>   static void aspeed_sbc_reset_hold(Object *obj, ResetType type)
>   {
>       AspeedSBCState *s = ASPEED_SBC(obj);
> +    bool abr;
>   
>       memset(s->regs, 0, sizeof(s->regs));
>   
> +    abr = aspeed_get_abr_state(s);

This creates an implicit ordering dependency: works because OTP is
a QOM child of the SBC, so its reset runs first.

So, can't we do that at OTP realize time instead ? OTP content is
non-volatile and doesn't change across resets, so reading it once
at realize time is sufficient.

> +
>       /* Set secure boot enabled with RSA4096_SHA256 and enable eMMC ABR */
>       s->regs[R_STATUS] = OTP_IDLE | OTP_MEM_IDLE;
>   
> -    if (s->emmc_abr) {
> -        s->regs[R_STATUS] &= ABR_EN;
> +    if (abr) {
> +        s->regs[R_STATUS] |= ABR_EN;
>       }
>   
>       if (s->signing_settings) {
> @@ -323,7 +353,6 @@ static const VMStateDescription vmstate_aspeed_sbc = {
>   };
>   
>   static const Property aspeed_sbc_properties[] = {
> -    DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
>       DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
>   };
>   


