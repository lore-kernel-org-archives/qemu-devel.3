Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA792C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkONc-0008VK-Nq; Thu, 16 Jul 2026 11:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkONW-0008Rc-Jf; Thu, 16 Jul 2026 11:52:05 -0400
Received: from smtpout10.mo539.mail-out.ovh.net ([51.210.91.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkONU-00034Y-Hf; Thu, 16 Jul 2026 11:52:02 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4h1Hbb5VmYz4WXv;
 Thu, 16 Jul 2026 15:51:55 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 16 Jul 2026 15:51:55 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.253])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h1HbZ5ktXz7tHh; Thu, 16 Jul 2026 15:51:54 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id AED41203DD2; 
 Thu, 16 Jul 2026 15:51:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006cb6671ea-5763-4a37-8f6d-56574d01a4fc,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f393b33d-dfaf-4745-b3ed-75da83b078ed@kaod.org>
Date: Thu, 16 Jul 2026 17:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/29] hw/arm: catalina: add NIC and FIO temperature
 sensors
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
 <20260709-catalina-upgrade-v1-25-82a63fead90c@free.fr>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260709-catalina-upgrade-v1-25-82a63fead90c@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 18309947236095274029
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFa3s3m0WSS7+q7LELJAwqjpoPbxPABklSbKLecTV2QTfrjNqVlEGSIAUCIBSqnleyu/b6pAqlB3FpkgtpV77gESSAt7NAteDxNDYgTYU7X1vuR86XEVC1Ty3xkrgOzsTTP0BZBd2DWzHkntnTCicoblkJ22HDBQbg6fISczPUzYQkPvfHmkiVNC7bNyFQ332sWV385wkSnY5jk6JB1GiVSwR14Au2jVipdqsqHaXrwJhB9H9FUXkOXisSe7w9yajtjMjTa2MapwWB7kbnjAt4hoZsLuiOaIm3sW5/c4IOULpjWpcE/EamGA2txubS2ATcMu1CUhygfPwMScBydlyHOPVs4myTEFGqM+Ljqi2LSyAVHSR73azd1EXDMtkWPF9QL0lkT1rkQZzhqMaZoFdIT96rADXJMQJk/Ak5P4S4pe3TW8m8JIcM4JIAgQFz76gO96ibWbi4fbjwXccuNNcZ9HyxrtRGWe7vmHDJuDd7RPFjkIyYbnJv5LtzhlUc+maf47Wm6QYek9tV1468x9rJ92whoChrZp3TrC0NamP97gs/mG6ZHPa9NlP4HGBskpabq75Wobv7HbRAlJ2gM/CTzJpzh0ZLot+8GSMDifHWyPcgQ4VuRojm3D0oiuI1tY89NeSegixW8vhFOlq+Wf0QZCFFpo03z9klOrhnSUngH8w
DKIM-Signature: a=rsa-sha256; bh=yH3qfi+B4FvtDtL8yFnAei/vKDaQEQWzGjflJJItJYE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784217117; v=1;
 b=NfEoHiyJvNumbnqxZ+NA/wqWQHqch/97UXJVz/eaNSSoLQfAzVERDNl7DCOjys6qTj41A/Fb
 vajW5S5ICb+MNJzha1qOidWKqBKxHI4EKD9nHXKG1u1JTEojFTaNdX/hBUNzsvv9GeMN6lTT69x
 gUrPBJkuvwFDb0LgXLcOQ5+Xc+bpqDgcTefmyTrJSNK9lZrWXoiGl8hRPM3ECzy4L0Lw7n9K6ft
 WCw6JXkIZJolVKg5MnH9uxzFCdlNKQkcHPJAoniN9oqIr2mfztZDKsa4Gsc4IQJG3odcvEydz2N
 SUcABnGOAssIikY0azj/jY0mZ5Rn1VCH44RceLPsTd4Og==
Received-SPF: pass client-ip=51.210.91.49; envelope-from=clg@kaod.org;
 helo=smtpout10.mo539.mail-out.ovh.net
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

On 7/9/26 17:23, Emmanuel Blot wrote:
> Model the temperature sensors described by the Catalina device tree that
> have existing QEMU device models but were not yet instantiated: the four
> IOB NIC TMP421 sensors behind the i2c0 PCA9546 muxes at 0x71 and 0x75, and
> the FIO remote TMP75 sensor at 0x4f on the i2c1 mux.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/arm/aspeed_ast2600_catalina.c | 30 +++++++++++++++++++++++-------
>   1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
> index f3b22e9aa9..f714c9d1b3 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -472,7 +472,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>   
>       /* &i2c0 */
>       /* i2c-mux@71 (PCA9546) on i2c0 */
> -    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
> +
> +    /* i2c0mux0ch0 */
> +    /* IOB0 NIC0 temperature-sensor@1f - tmp421 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> +                            TYPE_TMP421, 0x1f);
> +    /* i2c0mux0ch2 */
> +    /* IOB0 NIC1 temperature-sensor@1f - tmp421 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
> +                            TYPE_TMP421, 0x1f);
>   
>       /* i2c-mux@72 (PCA9546) on i2c0 */
>       i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
> @@ -489,7 +498,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
>   
>       /* i2c-mux@75 (PCA9546) on i2c0 */
> -    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
> +
> +    /* i2c0mux3ch0 */
> +    /* IOB1 NIC0 temperature-sensor@1f - tmp421 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> +                            TYPE_TMP421, 0x1f);
> +    /* i2c0mux3ch2 */
> +    /* IOB1 NIC1 temperature-sensor@1f - tmp421 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
> +                            TYPE_TMP421, 0x1f);
>   
>       /* i2c-mux@76 (PCA9546) on i2c0 */
>       i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
> @@ -544,6 +562,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>                             fio_eeprom, fio_eeprom_len);
>       /* temperature-sensor@4b - tmp75 */
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
> +    /* temperature-sensor@4f - tmp75 (FIO remote) */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4f);
>   
>       /* &i2c2 */
>       /* io_expander0 - pca9555@20 */
> @@ -564,11 +584,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>       /* eeprom@52 */
>       at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB,
>                             hdd_eeprom, hdd_eeprom_len);
> -    /* i2c5mux0ch7 */
> -    /* ina230@40 - no model */
> -    /* ina230@41 - no model */
> -    /* ina230@44 - no model */
> -    /* ina230@45 - no model */
> +    /* i2c5mux0ch7 - empty */
>   
>       /* &i2c6 */
>       /* io_expander3 - pca9555@21 */
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


