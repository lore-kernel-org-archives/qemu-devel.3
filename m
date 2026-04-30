Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0260CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVFi-0000Ql-1f; Thu, 30 Apr 2026 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wIVFW-0000ER-Dp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:32:33 -0400
Received: from 9.mo533.mail-out.ovh.net ([188.165.47.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wIVFS-0007Pj-BN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:32:28 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4g61T25SP3z61Nx;
 Thu, 30 Apr 2026 17:32:22 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 30 Apr 2026 17:32:22 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.90])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g61T232tbz7trq; Thu, 30 Apr 2026 17:32:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id EA5D09416C6; 
 Thu, 30 Apr 2026 17:32:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0018f7417ea-e8db-4db6-b72f-26738ce481e9,
 9F47DE0B15482FF6BC55B1CE858CC0DAC5AE7A4F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <261f2311-225f-4895-b1d8-0f0cf8811a60@kaod.org>
Date: Thu, 30 Apr 2026 19:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/41] hw/arm/aspeed: free fmc_model and spi_model on
 finalization
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-31-c413f3605311@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260427-qom-tests-v1-31-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10531104782745971739
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFTIkxvobcF6oSVoAzrTjLrjV+nnpqae9MtzyUEVPscw4wrQh7sVN/1k2tD0Xu7TGr6f6rOJQC6krZ2CSSR6OckswrRFcbtgeirYgDjb+hMtB17EroG1aXMbBFBOM9lvQBngZwVZfDwX54Yp1crO9wpsWCeac4fTM6vv4iy/azjsjVN9kHrVomkmZA3F+u/X+nq0cKhRn0fc+CuEeBqLXKlGZRtodFckvrwyint9+9sPqA4+ixvd4OtcFKGG45IhqmFLdKmf1BFdazqBELi2a1xRf+h4mGleTSvMyLLq+l8++iVyhBuWhVZItxESDxM4N+B5a6umI2Gej+iWwBMLqJSlXJ24H/bW4pbKmr2qofR7emxwbggbCPpFcgyWWs9t74pvyVrFH5fb8R9Zz6fadXC63napkjbCbVF6PdDfmh1psz76kZAlcDChxk8zA+bXdz6QynpnLoyRLKK7O74YxCBGNSWlpdIHtcnzs6Kxf/+pc9ZEZ0UcFvYdlzASFJTqS1KTTRJzT43G6lbS7CCB1lmp06Tzh6xwvGMm8jCJdoJSB1yqSKHIm2NP23nYfRiDtdc4rhi4ZA5nKAkR6UKhGc++NGNhYvocEu2ePRBwTIHMfiglTKeHib8kGsbE08B8s7DLGOVZtsYWeyZGm7nm7GFn1xIbJDZxi6lX2Qddvsd9w
DKIM-Signature: a=rsa-sha256; bh=Sl/KtSdQZKCGH0M8LhZHZBhUD+ERC5eTzHmT46PZ7BY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777570343; v=1;
 b=DY7ogC9pU4UYGy4s15bkLsCKm/wNzqTIkVdgN9zXQtV/Rd5w9TPmm5KqbJ7gbJpVpVNxZN4d
 74xkpsdTYyBYRD2JG0w6CWK7gcSuiam8m1wR5tXTBiAYpcTBI3mk0svO2tcZzQNxFA8fQ3OpaTs
 YurTGu+FMw3ceDShev1OoaVbptPoS06IYRqVeHkhrjBPWAsGooLSbJmwDwlqJBDE9brWR4Fyljr
 tb/5l1hJCscBq4JW2c6p9XCT+vQdw1CObhAwfubsEek0qaw6aIDRFPOhLGM+LulmOgvK2y5Gghq
 sTax6/1xYP5n+FlDhmyE/A1d8aV32ig0NuthXz/jy4QMQ==
Received-SPF: pass client-ip=188.165.47.174; envelope-from=clg@kaod.org;
 helo=9.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 4/27/26 21:42, Marc-André Lureau wrote:
> The fmc_model and spi_model strings are allocated via g_strdup in
> property setters but never freed when the machine object is destroyed.
> 
> Fixes: 9820e52fbef7 ("hw/arm/aspeed: Add machine properties to define the flash models")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/arm/aspeed.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index a3db3406c5f..a48c4420583 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -419,12 +419,21 @@ static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
>       aspeed_machine_class_props_init(oc);
>   }
>   
> +static void aspeed_machine_instance_finalize(Object *obj)
> +{
> +    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
> +
> +    g_free(bmc->fmc_model);
> +    g_free(bmc->spi_model);
> +}
> +
>   static const TypeInfo aspeed_machine_types[] = {
>       {
>           .name          = TYPE_ASPEED_MACHINE,
>           .parent        = TYPE_MACHINE,
>           .instance_size = sizeof(AspeedMachineState),
>           .instance_init = aspeed_machine_instance_init,
> +        .instance_finalize = aspeed_machine_instance_finalize,
>           .class_size    = sizeof(AspeedMachineClass),
>           .class_init    = aspeed_machine_class_init,
>           .abstract      = true,
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



