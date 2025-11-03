Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89606CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFraB-0006QJ-Je; Mon, 03 Nov 2025 05:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vFra7-0006P4-Qh
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:36 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vFrZx-00032h-En
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:35 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.198])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d0S9V2RVHz5yNQ;
 Mon,  3 Nov 2025 10:14:06 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 3 Nov
 2025 11:14:01 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002d0b5348c-599b-4a22-b30c-9a89a23502c5,
 25720A756895FCE40C516A1A344E2045610AA209) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a4c3ebb7-a189-493c-a60c-6e51d4d02aff@kaod.org>
Date: Mon, 3 Nov 2025 11:14:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 04/30] hw/arm/aspeed: Rename and export
 create_pca9554() as aspeed_create_pca9554()
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251103092801.1282602-1-jamin_lin@aspeedtech.com>
 <20251103092801.1282602-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251103092801.1282602-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: e6b278a0-6938-408c-bde8-5ca3cf5b865b
X-Ovh-Tracer-Id: 9253208386508786610
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFPH3mapZWBF5xMOjMVRdrKpHhd4hodaHZE2u2Zk3eWq74ZWB25x/Z7nDAdtTQoLA+mLzRfsdmxRSngZ7B0XiAvgizlA4gX61dReej8Aa18P3kW1GEWZDCickeQHP4ZxUPxz2+kyb+4zcgTcYm2t18TblVObTS8rBi8O6pTgvFWfjDlVDkmLlNgcHM0YXwJ5/9UeX8ByzCIiaFsBULYQAjNrMg3Nc0cU60CpvavtoG7xaNAfNlYV2NbithVOKHbEFz2WFQaErXkB5Db7z6HZR3ScwaGCNL+ag4yPq7lH55sSrZ0MKMzix+8siM0PqGitTFUDsM9v20q6nsKYdt7gYiEXgjNhOwgotUlF2kYvoPgM5+scSmy9T6KGXTEdWtG2iZtOKi2wD6Saor380ESebXMp9tFv91InlquT4phFROiQfodCRTnkna/MWYMVbGqX3gDRwoMax3uRaej1Zi3dkd2z015j2Hovqcg2ufLYszCcYjwnUP+5QPhywt4RVbzvHgZ5va7WtK3NDmxqrBQneX+mueSf64Unc7ZuDLblL4MkNtZKNmBf+3eDMxCE4+XgaZxDH1WKR16QSzu/5dQI9mwIvQZLLLq28rBshAyewKmEVn/5U5VIj1X1bTKryQGRPWo6UXmjNuoxOKP3AepUKELyLb/kGRojlFJpxDEUpUjjA
DKIM-Signature: a=rsa-sha256; bh=4gvJSErS0fRnC9WWrFz+Qr2xdS5rkoP01KCi9rK7trQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762164856; v=1;
 b=CXl6SQBdzpCUm7C8w8kKVMmasDVM/yQJaU6yx1+WwrtwnvCLhZhvzvafmMHJjd/8QYTRzRRk
 MveF+7UX8WQMHTTcSmozQnx7wCE8SWkggz49b0bzoJxg7+v/bP3gcZtHm2PNG5vYYyYJGBg15dq
 3b/2u4wjDnPzHCFHvU1p+BSWtaatGWlDMQXGtfDCud4EpUj1JsNfdVQX/HLsthJNHpdJuNSlyBq
 9T7dwVlwJlYlnb2m/J0EG+xtK9k+AOO0zYeJhMBAdgOa3v4vptu6LMRCm6ia0hYYcaLQ85Lo5Mf
 pdDTqhDN0lIZTFNdKR79Kweouyf80d2MZ4PfXRGds97tg==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/3/25 10:27, Jamin Lin wrote:
> The helper function create_pca9554() has been renamed to
> aspeed_create_pca9554() and made globally available.
> 
> Previously, the function was declared static inside aspeed.c, restricting
> its visibility to that file. As more Aspeed machine implementations
> require PCA9554 I²C expander setup, it makes sense to rename it with the
> aspeed_ prefix and export its declaration in aspeed.h for shared use.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed.h | 14 ++++++++++++++
>   hw/arm/aspeed.c         |  8 ++++----
>   2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 3afb964088..d2d9e49a39 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -80,4 +80,18 @@ void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
>    */
>   void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
>   
> +/*
> + * aspeed_create_pca9554:
> + * @soc: pointer to the #AspeedSoCState.
> + * @bus_id: the I²C bus index to attach the device.
> + * @addr: the I²C address of the PCA9554 device.

I will change I²C to I2C.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.





> + *
> + * Create and attach a PCA9554 I/O expander to the specified I²C bus
> + * of the given Aspeed SoC. The device is created via
> + * i2c_slave_create_simple() and returned as an #I2CSlave pointer.
> + *
> + * Returns: a pointer to the newly created #I2CSlave instance.
> + */
> +I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr);
> +
>   #endif
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index c6f272d986..59416eb5ae 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -543,7 +543,7 @@ void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
>                               TYPE_PCA9552, addr);
>   }
>   
> -static I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
> +I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
>   {
>       return i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
>                               TYPE_PCA9554, addr);
> @@ -1142,7 +1142,7 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
>       }
>   
>       /* Bus 5 Expander */
> -    create_pca9554(soc, 4, 0x21);
> +    aspeed_create_pca9554(soc, 4, 0x21);
>   
>       /* Mux I2c Expanders */
>       i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
> @@ -1153,12 +1153,12 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
>   
>       /* Bus 10 */
> -    dev = DEVICE(create_pca9554(soc, 9, 0x20));
> +    dev = DEVICE(aspeed_create_pca9554(soc, 9, 0x20));
>   
>       /* Set FPGA_READY */
>       object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
>   
> -    create_pca9554(soc, 9, 0x21);
> +    aspeed_create_pca9554(soc, 9, 0x21);
>       at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
>       at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
>   


