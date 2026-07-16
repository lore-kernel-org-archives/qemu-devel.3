Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AC9C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkONP-0008Ok-U6; Thu, 16 Jul 2026 11:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkONK-0008Mr-36; Thu, 16 Jul 2026 11:51:50 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkONG-00031F-Lz; Thu, 16 Jul 2026 11:51:49 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4h1HbJ3z2sz41nt;
 Thu, 16 Jul 2026 15:51:40 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 16 Jul 2026 15:51:40 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.201])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h1HbJ2jl3z1xrC; Thu, 16 Jul 2026 15:51:40 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 08F5920349F; 
 Thu, 16 Jul 2026 15:51:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006db879c3f-7d12-4ec9-9f4b-76f6aba7a5f4,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <824a00d7-fc8e-461d-933d-e1a4810633e5@kaod.org>
Date: Thu, 16 Jul 2026 17:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/29] hw/arm: catalina: model PCA9555 IO expanders with
 their own type
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Corey Minyard <cminyard@mvista.com>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-24-82a63fead90c@free.fr>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260709-catalina-upgrade-v1-24-82a63fead90c@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 18306006587989929005
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFQA0eJ7BQdgCWdbH2iMlpUzrkb5oufim0aFw9pDDMRkzPUx9bW6CrcNhcQz0Sz+BxJm7APoiN+VkxlZ7JE6eMmiPZMofW+bObOsGKKaHmES9BKgVd2hHWZeAXx/ogWSyvFPbSzG7lZe3z2/gwnXulifE2qpsuwvZV/z3pSqt7LxD63U4e9OJW3Lb6cfNMnw+hNjg3Px6uHPSQ+lSUpToB3RZAeoLOq0rC0jo9t8QP4bR5QgcG+OMpr7gupZlzdV+196JStB++LQKhMfksdJo13Bxp7RCC+XsJpcf3NCUltVLn1T6k9Fh+QUHuExr1UVRYtQD6hCv7C0F0lnAcAUxDapv/uviq0zCKTmbtXj7PBdr3hUkHL+d6qkwiS7KWpdtd52CmRO+jnpvhqm8XD5ZgD16uODQ31R8kq7m/NbvrkOluOVek3pBdaeUnHg8xzLzaYp35ATfyUUh6uArO+vs+JSbAquLHwNvAI/OcD/bl4rg+5UoF5+CIW+zPABv2EaZPo6YdZqCIC64sIt1fTxV9VvQcjXFmdPCCpAXImZLIauMpNZPFKsqBk/icPJfGGSNLp4TZP/nxAjyoQI8vN6toWRaNDiG4f6+k2wykiXHE+3QZxfRVvpbcvM5nPZebrrbodpwh6Ugxz6eILhxPBf1HtLwHBFKJ5j5nf+9X0tnFu9A
DKIM-Signature: a=rsa-sha256; bh=dfYTTY4qJVndh7naddomplWf1Na3ADdl1NVHxbI+PPs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784217102; v=1;
 b=juKHrFeR0AV82LUlAb32iZr6u2240afYygk/Vhd1j/ZN/FwOQ7ngTuaipf3n3doizCaVaqm6
 BK7zmUXVRljKbXpBBO266sEjm6hEIFvYFKT9wV+9tcsFrkcDDRW/dihUlIFA7PUFeoJkRGeLq3d
 VKPkzGYSPOfuMUYMOjeYS/FBrIGXiV6BxuRHJNGHJtXzC5Ua+QoYK0TBU+pbmJhKXkuOu6sGveJ
 7+IBgYChfOVtAmm5QIHzbu51wNz/eKPZxsEm+v5DyuSfrPemJsI+0z/hxgaB1TN9Q0m88kDsPpd
 Z6em5SB/7sVddqSaYxWdL34FSqF4d7gW30YJ7BZX9BD7w==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/9/26 17:23, Emmanuel Blot wrote:
> The Catalina BMC device tree describes several IO expanders as nxp,pca9555.
> These were previously instantiated as PCA9552 devices as no PCA9555 model
> existed. Now that a dedicated PCA9555 device is available, use it so the
> emulated IO expanders match the hardware.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/arm/aspeed_ast2600_catalina.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
> index 65495a524ea..f3b22e9aa9a 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -533,7 +533,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>                               TYPE_PCA9554, 0x27);
>       /* io_expander6 - pca9555@25 */
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
> -                            TYPE_PCA9552, 0x25);
> +                            TYPE_PCA9555, 0x25);
>       /* eeprom@51 */
>       at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB,
>                             osfp_eeprom, osfp_eeprom_len);
> @@ -547,11 +547,11 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>   
>       /* &i2c2 */
>       /* io_expander0 - pca9555@20 */
> -    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x20);
>       /* io_expander0 - pca9555@21 */
> -    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x21);
>       /* io_expander0 - pca9555@27 */
> -    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x27);
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x27);
>       /* eeprom@50 */
>       at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
>       /* eeprom@51 */
> @@ -572,13 +572,13 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>   
>       /* &i2c6 */
>       /* io_expander3 - pca9555@21 */
> -    i2c_slave_create_simple(i2c[6], TYPE_PCA9552, 0x21);
> +    i2c_slave_create_simple(i2c[6], TYPE_PCA9555, 0x21);
>       /* rtc@6f - nct3018y */
>       i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
>   
>       /* &i2c9 */
>       /* io_expander4 - pca9555@4f */
> -    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x4f);
> +    i2c_slave_create_simple(i2c[9], TYPE_PCA9555, 0x4f);
>       /* temperature-sensor@4b - tpm75 */
>       i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
>       /* eeprom@50 */
> @@ -615,17 +615,17 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>   
>       /* &i2c14 */
>       /* io_expander9 - pca9555@10 */
> -    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x10);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x10);
>       /* io_expander10 - pca9555@11 */
> -    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x11);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x11);
>       /* io_expander11 - pca9555@12 */
> -    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x12);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x12);
>       /* io_expander12 - pca9555@13 */
> -    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x13);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x13);
>       /* io_expander13 - pca9555@14 */
> -    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x14);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x14);
>       /* io_expander14 - pca9555@15 */
> -    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x15);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x15);
>   
>       /* &i2c15 */
>       /* temperature-sensor@1f - tmp421 */
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


