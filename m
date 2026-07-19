Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAA8C44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 09:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlNs8-0006fL-K5; Sun, 19 Jul 2026 05:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wlNs3-0006eR-GL
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 05:31:40 -0400
Received: from smtpout10.mo537.mail-out.ovh.net ([51.210.91.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wlNs1-0005Oy-MX
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 05:31:39 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4h2z195GmGz3wkV;
 Sun, 19 Jul 2026 09:31:25 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 19 Jul 2026 09:31:25 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.138])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h2z190SWfz1xsK; Sun, 19 Jul 2026 09:31:25 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id EACDC203DE4; 
 Sun, 19 Jul 2026 09:31:23 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0049aaf6c82-2b91-4d11-bc70-c27e64f9018f,
 927533437C4EB51202FF6C72770557251D494D3D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <72e0ec9e-23b0-4312-bb53-e11d9bcd79ed@kaod.org>
Date: Sun, 19 Jul 2026 11:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] hw/arm/ast27x0: Start TSP in powered-off state
 to match hardware behavior
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
 <20260708092023.3826159-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260708092023.3826159-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11055492661839768691
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEMd9SrojuL7+IuUtXuT/daw3Ra0LFx4zy+b7UAG5Cb7sGs+QYffKY6retFRmqNg1yTmvQRUh09z6SmAZQfmyVgmzE0L312S3UzzMSf1PFzOJorzLHa+eNaQqZWHNJl8QAl48pu7iMKyHu0T53jxewm2rlEBMlJQ3Gg2oX/g4Qzu4MHFYJNVdzzVnQHjxc5yxr5mApp+j6KZOaWfbqWpFb4HaLNkbFDZh57Jc72+HFAsufd10+hriwwIHouTJh79q89n/qsNY1pYAWVVD6ZU1YgoT/wZ3MlWlkqwQW+LqxknI6SgXOeODNNj0G4tlF6Ifxpv4a+nY9NEmbu9IMKPMY7A6tdfdbfy8Adm149af221nCvdcf1oCvYaZaKZrXnxbe9LWpiOGmk/3ixAiIvvdV5GuJQxKUUdwIMO+81oTLiy1Q+X/w1SNAYrxu5MGN7Gq4+WF5gHcsnbunIG21LlJu2KKlBFHwJhtfem7FuxXDjOKV6chGSR64mWfCELtYDzPu16iGBoW/y1uqLaSLSbUBs+vthse1psmndFxHGDm7gGGgwBUJKst5R/z+Zv+3KO4mzC9FiwcG8LYa8qsaP8EhgDKFTCkLD6UhTf0bitM7JtuYKbIslfl84vBdxJRtHy9qvjYwBVhcOSGbBiyyWkiBZ4ZhFtiaPaedU1vFENYp81w
DKIM-Signature: a=rsa-sha256; bh=XWsgPTkoNYJcLWT2Kzoo7+hQgV3eYNR6kr0hFprPTE8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784453487; v=1;
 b=f5ScJajZW1c0L2CRt+nx1rQpVVsZE1K8oZEE9jCBcq645yo6XPATFj30FYA9g9UaPZzK2qvt
 m+S8+pGxdNdEPNU6rUbadfVLQvCWxehrqU7JdTxIqj379aaR5uFT0HeSjSGNEaHmHp1u04jUxeW
 1iGoV59k3lcOD6qqfmGFXnisfGM/xQrwELAUt1JYoa93Q8pn2v06dMnYK2ofSMP3e8x7N6mjk41
 Nop1R2+YtIq7MGunaL7TqW6S3q3Plw+d47QdIpj4GF0L666q7oX7xqiX863zCtCzsKvwUnZFq+8
 3vf5//fxWaot3f5zifDJRUIgbfDxOm5feMC2odF/nO75w==
Received-SPF: pass client-ip=51.210.91.29; envelope-from=clg@kaod.org;
 helo=smtpout10.mo537.mail-out.ovh.net
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

On 7/8/26 11:20, Jamin Lin wrote:
> In the previous design, both the PSP and TSP were started together during
> SoC initialization. However, on real hardware, the TSP begins in a powered-off
> state. The typical boot sequence involves the PSP powering up first, loading
> the TSP firmware binary into shared memory via DRAM remap, and then releasing
> the TSP reset and enabling it through SCU control registers.
> 
> To more accurately model this behavior in QEMU, this commit sets the
> "start-powered-off" property for the TSP's ARMv7M core. This change ensures
> the TSP remains off until explicitly enabled via the SCU, simulating the
> real-world flow where the PSP controls TSP boot through SCU interaction.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-tsp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index 39ba062a20..4212e7bd4c 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -192,6 +192,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>       qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
>       object_property_set_link(OBJECT(&a->armv7m), "memory",
>                                OBJECT(s->memory), &error_abort);
> +    /*
> +     * The TSP starts in a powered-down state and can be powered up
> +     * by setting the TSP Control Register through the SCU
> +     * (System Control Unit)
> +     */
> +    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true,
> +                             &error_abort);
>       sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
>   
>       /* SDRAM */

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


