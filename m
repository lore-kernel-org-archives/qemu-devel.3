Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC525C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwaSi-0002N4-D0; Wed, 19 Aug 2026 03:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwaSg-0002Mi-0I
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 03:11:46 -0400
Received: from smtpout8.mo539.mail-out.ovh.net ([51.210.91.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwaSc-0004ca-VJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 03:11:45 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hPyRZ6c1Rz4Drm;
 Wed, 19 Aug 2026 07:11:38 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <peter.maydell@linaro.org>; Wed, 19 Aug 2026 07:11:38 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.233])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hPyRZ5Ttcz1xtS; Wed, 19 Aug 2026 07:11:38 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id F3A89203F4E; 
 Wed, 19 Aug 2026 07:11:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R00450458bad-a19e-445f-8001-af968acc8a5a,
 C24CD8B75EED539221ACEA448CE881038350F7ED) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <ba05f872-5eff-44bb-814d-c2dca6532a9d@kaod.org>
Date: Wed, 19 Aug 2026 09:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] arm/aspeed: Drop ASPEED_RAM_SIZE
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-8-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260818172012.3052821-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6280832633484455111
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFFQfOflHL5pL7h1lCIN2tY1QVsauSJe0O7J+HDb/gLpcLr5TbnbhBY760AMer0V6b5+2xh5hVyR1hx47WZFtdcIU7d/rZWll5oPbbIlLjWcVJQvjo3m+Cq6I2z2JwsRMEx0qnb/InHqgB4Mt5rhwdUZ18CrDHEcGAHLYIlG5+iZMrUbtT4TUjK4yl+0Mgr8y4Reyt9CNf98lmM+57J94lQ3IVElheEC8eAYuQwWDiEPd55elGMmFyslE1H7T4kZmFeATFMZZl/H7tJoYAOTAjJHPHSctcXp14xrzwwDtnnUMchJ4gmERNej++NreqHS9Ec4IUFNW7iYLxwnfYf0P8EnifNE9kwB5CeuW8fjK8rG3sgEsESRA/VnDYWzvbGR1ndaKZn2uQBVjIt733Gv6KTys40QmYXB+ScYqY95uZAhqEGvG4m9yQvqQK1x0ybXqJZM1MoGUJ48+UfBWtFnpx4rNDJKk1G6ZDZB9xQxaB2ZU4+Mm1d+1CHr3/2ZONO9y8dtAKy6zekXOP2+bM1CMuxDYttaU4uQX1vH4AniHWcC/aHxCUlhQUzgigRb79q462ESWceKQLHt7sPHssVfh6qIKPLmWz2T+R4LDc/r3x/lBQDkN3c0UfXU2uz+5QApO8T2NHa43uFhypAoSZl5qTdhItinFsNryTf8N9+OvCNIw
DKIM-Signature: a=rsa-sha256; bh=62l7mEuqW83dX2W9eUPz3iv5mgEdNUfO5WeL2hsucEY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787123499; v=1;
 b=I7P63LlhxedL+xy4AgvFCFOjbJtkQ0LAo7PUWpK7+FjEPxZsyHoISGShwQXuzJaN9R7xdxwb
 kDRVXzT03GsZWI5NBh2Ycxb+sUs3SG0IwZCwW5s20N/HzZ0/SKWub7fvQjmDrvNHui5tn19mk+L
 01BfCDrTOtsiBNlOCYHeLKvfd67YfnpKybTOlfidVtDsKqRAOe+QUc8PEvELz3GPmm4tyryqxVj
 NNMEkA9q6hFZky74WUc/ZxOiqCaEWG5LZfVxzXKNq/W147uTE8cBe2mguh9zSdQsIoc1Pz1xCyk
 erCmo/uare5mIKK8owCqbndWIUxblK48L6S/TkNZgI92w==
Received-SPF: pass client-ip=51.210.91.47; envelope-from=clg@kaod.org;
 helo=smtpout8.mo539.mail-out.ovh.net
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

On 8/18/26 19:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system/user emulations.  It's
> not needed anymore.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/hw/arm/aspeed.h           | 7 -------
>   hw/arm/aspeed_ast2600_anacapa.c   | 2 +-
>   hw/arm/aspeed_ast2600_bletchley.c | 2 +-
>   hw/arm/aspeed_ast2600_catalina.c  | 2 +-
>   hw/arm/aspeed_ast2600_fby35.c     | 2 +-
>   hw/arm/aspeed_ast2600_fuji.c      | 2 +-
>   hw/arm/aspeed_ast2600_gb200nvl.c  | 2 +-
>   7 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index a00238ed74..7a012d87de 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -25,13 +25,6 @@ DECLARE_OBJ_CHECKERS(AspeedMachineState, AspeedMachineClass,
>   #define ASPEED_MAC2_ON   (1 << 2)
>   #define ASPEED_MAC3_ON   (1 << 3)
>   
> -/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> -#if HOST_LONG_BITS == 32
> -#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
> -#else
> -#define ASPEED_RAM_SIZE(sz) (sz)
> -#endif
> -
>   struct AspeedMachineState {
>       MachineState parent_obj;
>   
> diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
> index 65d6b0faa2..45f7a25efd 100644
> --- a/hw/arm/aspeed_ast2600_anacapa.c
> +++ b/hw/arm/aspeed_ast2600_anacapa.c
> @@ -18,7 +18,7 @@
>   
>   #define ANACAPA_BMC_HW_STRAP1 0x00002002
>   #define ANACAPA_BMC_HW_STRAP2 0x00000000
> -#define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +#define ANACAPA_BMC_RAM_SIZE (2 * GiB)
>   
>   /*
>    * "Anacapa HPM (MB)" FRU data. Generated with frugen.
> diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
> index b7e84db143..8f9061c472 100644
> --- a/hw/arm/aspeed_ast2600_bletchley.c
> +++ b/hw/arm/aspeed_ast2600_bletchley.c
> @@ -18,7 +18,7 @@
>   /* Bletchley hardware value */
>   #define BLETCHLEY_BMC_HW_STRAP1 0x00002000
>   #define BLETCHLEY_BMC_HW_STRAP2 0x00000801
> -#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +#define BLETCHLEY_BMC_RAM_SIZE (2 * GiB)
>   
>   static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
>   {
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
> index f714c9d1b3..c328997668 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -20,7 +20,7 @@
>   /* Catalina hardware value */
>   #define CATALINA_BMC_HW_STRAP1 0x00002002
>   #define CATALINA_BMC_HW_STRAP2 0x00000800
> -#define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +#define CATALINA_BMC_RAM_SIZE (2 * GiB)
>   
>   #define TYPE_TMP75 TYPE_TMP105
>   #define TYPE_TMP421 "tmp421"
> diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
> index f624427070..1d546b1f0a 100644
> --- a/hw/arm/aspeed_ast2600_fby35.c
> +++ b/hw/arm/aspeed_ast2600_fby35.c
> @@ -17,7 +17,7 @@
>   
>   #define TYPE_LM75 TYPE_TMP105
>   #define TYPE_TMP421 "tmp421"
> -#define FBY35_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +#define FBY35_BMC_RAM_SIZE (2 * GiB)
>   
>   static const uint8_t fby35_nic_fruid[] = {
>       0x01, 0x00, 0x00, 0x01, 0x0f, 0x20, 0x00, 0xcf, 0x01, 0x0e, 0x19, 0xd7,
> diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
> index 37db252e27..cb987e2eff 100644
> --- a/hw/arm/aspeed_ast2600_fuji.c
> +++ b/hw/arm/aspeed_ast2600_fuji.c
> @@ -22,7 +22,7 @@
>   /* Fuji hardware value */
>   #define FUJI_BMC_HW_STRAP1    0x00000000
>   #define FUJI_BMC_HW_STRAP2    0x00000000
> -#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +#define FUJI_BMC_RAM_SIZE (2 * GiB)
>   
>   static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
>                                    I2CBus **channels)
> diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
> index ad9a10110b..7abd934624 100644
> --- a/hw/arm/aspeed_ast2600_gb200nvl.c
> +++ b/hw/arm/aspeed_ast2600_gb200nvl.c
> @@ -16,7 +16,7 @@
>   /* GB200NVL hardware value */
>   #define GB200NVL_BMC_HW_STRAP1 0x000000C0
>   #define GB200NVL_BMC_HW_STRAP2 0x00000003
> -#define GB200NVL_BMC_RAM_SIZE ASPEED_RAM_SIZE(1 * GiB)
> +#define GB200NVL_BMC_RAM_SIZE (1 * GiB)
>   
>   static const uint8_t gb200nvl_bmc_fruid[] = {
>       0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x1f,

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


