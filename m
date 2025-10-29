Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B857CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE9fn-0005Ay-PW; Wed, 29 Oct 2025 13:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vE9fk-0005Ad-G8
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:09:20 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vE9fc-0006sD-Vq
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:09:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.107])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cxYcc2Mvmz5wtF;
 Wed, 29 Oct 2025 17:09:04 +0000 (UTC)
Received: from kaod.org (37.59.142.104) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 29 Oct
 2025 18:09:01 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00588959b6e-f8b2-4823-abd4-c9582f228a03,
 1C4C5A15D30C5F2C89D761F8A9BCD43732F6FBF1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 92.184.104.153
Message-ID: <b622dd42-1e36-453e-954f-c2aa07cb5d1a@kaod.org>
Date: Wed, 29 Oct 2025 18:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [SPAM] [PATCH v1 03/13] hw/arm/aspeed: Make create_pca9552()
 globally accessible for reuse
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
 <20251023100150.295370-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251023100150.295370-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 35d44691-1286-4134-83df-d1c80d63f82b
X-Ovh-Tracer-Id: 5345772759054912434
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEL1c94dUWw35AJCttRGCyFE8g7FZ+lJPS/Jg6/nJsPZ8VMj32X9T8sXsYxo4WfTYdBg/AggTQ+DEyHa+0qtZsERgapuLL5GXyB2pSw3/OLx9dPS3laF+fms3FMWnfLa5EdprHcztjH9r1Ptywt10UqVAb6J226kra558EelEV2J7t1LRqFTnEueST6syGuE8yyX6LxDlgcrPazpot87b+Opy6XzNjHOYL/KyvM7P8hexha8x7LAJa6wNoruRDgZDa8Df80jBto2rh9XuIYnWyHKOxbN6o8p41q5/gXb5ug44a8pZX9r0anLfc4m5NPRU0PCxDHHB4OJIXIKKp8geeZRpQ445+SNl8JWZ1PJyrlWEhJC+Eo7zNzypVgpuRuVSoNHs0aHPz1gTiPmX4Mfhhjj3AN/S0gtigo/egvPIslAZ1lGIB+Q98PNOn5cUlYalzkIgGknraDECfew/B1yTBRPsH/7bZU6WvR60H/E8jOStUABvhJpL8yEtjVML/pWLlkhCqi4Zb28uAq4uk4foEnRZvCZVKI60fLWxo/k5SrdVOTBsL2yxP+O/AKhXmw0VlUr8iHlPqMP33/MrLDlHQP/OxMYENxJ8ECT12WjXwbNnAcU3eQcGY5o3ehrth/MzOkayAfhZy5c8nOPTqcyet+HK2XZA4FpmKAVIot4vwJtg
DKIM-Signature: a=rsa-sha256; bh=5Yu4gAUjE68pKSigLd9Tqqo13fQxPsYiL2EAiqkjQoQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1761757746; v=1;
 b=De43PQG0CVFOZVRrO+RWtQIfYNruukR1ChDomdpsgME7caF7wQDGbJtOIwKW6C04ElRYYeko
 I7TFi1vKHIDjPI7YcYKcXLGNm1k6CvwA/Mpj52CngRik+15YI1ZEc8rAEJVl3SEKQXI49PXlJY6
 qGZobyECMuC0NCDdeMw2GUfcTkbKtAS0L9G6u3chBQEeLKVxH7Bske2bGtCnceoqiDdvguCFIVf
 lQN1D0ynzdYqPz6YXvtI3QSV/wzx95NN4alB58PnWgUoA/dj0gz0a5ZHdo7oW3IC+muPOLRB0hc
 mbHP1fvt9lAJrRlxoL3L1uPkcsfzKm4DDuM75jgP3Orpw==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/23/25 12:01, Jamin Lin wrote:
> The helper function create_pca9552() is now made globally visible
> so it can be reused by different Aspeed machine source files.
> 
> Previously, the function was declared static, limiting its scope
> to aspeed.c. Since multiple Aspeed machine implementations will
> require I²C device initialization using PCA9552 GPIO expanders,
> this function has been promoted to global visibility.
> 
> This change improves code sharing and reduces duplication across
> machine-specific initialization files.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed.h | 1 +
>   hw/arm/aspeed.c         | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 7743ad2fb0..d4d63996a6 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -60,5 +60,6 @@ struct AspeedMachineClass {
>   };
>   
>   void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
> +void create_pca9552(AspeedSoCState *soc, int bus_id, int addr);


Please add an 'aspeed_' prefix. We should start documenting the
aspeed routines too.


Thanks,

C.

   

   >
>   #endif
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 5da21a4d6a..2695f0c11b 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -536,7 +536,7 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", 0x4e);
>   }
>   
> -static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
> +void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
>   {
>       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
>                               TYPE_PCA9552, addr);



