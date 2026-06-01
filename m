Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771CCCD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU28J-0001Et-JY; Mon, 01 Jun 2026 08:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU280-00016L-DV
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 08:52:27 -0400
Received: from smtpout6.mo540.mail-out.ovh.net ([51.210.91.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wU27y-0007XP-NI
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 08:52:24 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYl851yvz43Ry;
 Mon,  1 Jun 2026 12:52:20 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon,  1 Jun 2026 12:52:20 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.3])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYl84JSgz1yb8;
 Mon,  1 Jun 2026 12:52:20 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5BC7012E3044;
 Mon,  1 Jun 2026 12:52:19 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0032b1432b8-a328-4cfa-8b7c-3b268eab283a,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f65c4a77-bbaf-4496-a4ad-707fe2745f89@kaod.org>
Date: Mon, 1 Jun 2026 14:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260529064243.2064188-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9260526736789449739
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGAN+b8wkfvbTGMBPi8a2WQOObvUKsUDnqgUH20JqZ10lepCv3bXB3lhBGLgm3zU4jsFEpuSpDOFvvdp80XasyOjFFKATIBowXv/tqUnfbWDfWgNHTdKyYlObJzTWDo/j5rLu3zhDdLsMSoXVZDUR+TmiD1l6kw15jlWcfiwhjlOfWUV4AZiMNid6Q/mM3cF9odfYttUZy8AyYQeexP0vVJ5CIN0/gRA2LG5wSJcM3NgsDOY0IgFCl9ZjBoAMJXbCJriqVDykKSWYlTuIDLvjGEGfdnXIHjrl4VTdWE+n3ZTz474RIzkokKhZihQ2MHCDAP3StUOXEOIPDLgUoZcGC5lcVPrQUFZ39iuv31DXYvNtdMXEHZv0emM5s9IMlJN1N1mwYLsTL9fEd2HF3fOpIfoaHPeyKCa3ieXf2pL+G+ZHupt0O5r4L3FBjMBGTawQpR+E/tmze66zv+8pP28VWB6d/z7MiH4blHqcmLXUruVZY1sI6s2YnmW4Y9N8WgSXwfSHzqbS58LIkppI+oZfX3XDvIHomeBOPQ4dVHX84pa6o4FwretlCKTP4BWZUwY7AUeEQ3VjjbhRW5Ru5BTvQbN7JC9urxGg9VL11iWyP8oW227MZ+XaKAS8/tHofbEPdWLaCFlcQhg9geaHVnBfh0zO/qLXzq1LCpeEUvkkAZPw
DKIM-Signature: a=rsa-sha256; bh=CiwmULgr2n301p5zZW4LFu/V3EFyTOp5hpHE/f9GX98=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780318341; v=1;
 b=nXaAOFItqrleGG0xlvI38MXIY4JiGvk96IO3bgFF3vO1tm1KEfwdmqLkjHUDe5Fr6R379MD/
 UA/QEt3O6MtNGIuSRgaguePkOgoJ+tSd6XMYNvklea9J0+UrXzSGRL+dJHQuR++FbeRJDMzimZ5
 Bijz6ivBx7z/oUzrRqIYQZi3mjSxOOAQ4bvHahJs9Gn6VibqsL6AWB2Y38bpYRxg/gpITdjTN8r
 L0ktKF1VAU+7SAh0axAPUzIbrQKdI4AFV449bNvOKSzqDzO7hD92noaoKivoFMkzuXz7chvdjAB
 foMjY6zXywrc0A0x04w+qlFQBtq14GJx1c7n2WkSHryZA==
Received-SPF: pass client-ip=51.210.91.55; envelope-from=clg@kaod.org;
 helo=smtpout6.mo540.mail-out.ovh.net
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

On 5/29/26 08:42, Jamin Lin wrote:
> Instead of introducing a dedicated TYPE_ASPEED_1040_ADC model,
> initialize the existing AST2700 ADC device directly for AST1040.
> This avoids unnecessary duplication and keeps the codebase simpler
> and easier to maintain.
> 
> Add ADC device initialization and realization support to the
> AST1040 SoC model using TYPE_ASPEED_2700_ADC.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
> index 8efcdad8f6..b736e690e5 100644
> --- a/hw/arm/aspeed_ast1040.c
> +++ b/hw/arm/aspeed_ast1040.c
> @@ -107,6 +107,8 @@ static void aspeed_soc_ast1040_init(Object *obj)
>           object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
>       }
>   
> +    object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);
> +
>       object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
> @@ -188,6 +190,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
>                              aspeed_soc_ast1040_get_irq(s, uart));
>       }
>   
> +    /* ADC */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
> +                    sc->memmap[ASPEED_DEV_ADC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
> +                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));
> +
>       /* Unimplemented peripherals */
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
>                                     "aspeed.pwm",

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


