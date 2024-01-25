Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DCBC46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpRy-00081x-L6; Wed, 24 Jan 2024 21:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpRw-00081a-NK
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:26:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpRt-0001YM-QW
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706149597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TU/nds6+mCFG88ezNxpwjByjGwWxLs2NlGY55p/us0Y=;
 b=WnnV77K7DEQzNF9Jgpdxtg5ofVoRP5y2RhYNW+glMFi913bCdQt9AS/iso2CQFRVnNowQH
 q9XMHdtCCYjaUwRwePOQn08/SOlutjYq+4Yx3H48w5XzG5HuCi5IinEWeraKvuSbcASfXx
 O0VtNYfKjKnse4L9r6I8CybQQ/YnGw8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Xqfe5J0wOPmOTHV55xzhoQ-1; Wed, 24 Jan 2024 21:26:35 -0500
X-MC-Unique: Xqfe5J0wOPmOTHV55xzhoQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6ddc41f35a3so610449b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706149594; x=1706754394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TU/nds6+mCFG88ezNxpwjByjGwWxLs2NlGY55p/us0Y=;
 b=lZuBqoXT5rK6yjSzldhWEYUUqt2svDV/f29RCRNQm+uaLboXwQZ/N3LmPSNThvYh2W
 iUTuaCEg0rdpmIBquu0zjHll0omvF1wE+7ZeHKNGzheekyosbA9sORBlk/TIG8K1hq85
 gF8uU5GX5GNW+3wQvbvvHjv6S4i6B35F5Via5zVy1iTR9xmsA9LF0nOa8g8V/RZuBVKG
 VxI+51xy/F+VMDp3L40EscZ6J/v/IE/LChqLB+06NFKyWz3GvJlatu/fm+Tzc7Qzh0qA
 0w1lQpFBav3js2ltvKzy6eRmeaMYsYUdJFC8zAOnhMoqRxv4Bv0FaiYw8E9uJABcTUPF
 D7UQ==
X-Gm-Message-State: AOJu0Yx6KfFxrgqURxxpT7WHlk6uB79r9tDKs3THrBFQHcqrlsIzCpDL
 2hZNwW+6/AzVr6vswbp5wiO/1xRxgPz7QKulzoJZQ4Uuww74LNmWacmANyT4eI20sgGTAq/rCJ5
 Ttc0h2NPEJpHZZ+69MRzx4uCGZuTFyapnhbUPbMHEsfK2U7wP0w/A
X-Received: by 2002:a05:6a20:7493:b0:199:31af:9207 with SMTP id
 p19-20020a056a20749300b0019931af9207mr371475pzd.52.1706149594139; 
 Wed, 24 Jan 2024 18:26:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx0zUQUa4rFUhvBhw80h9HxB2KhnoV/EywIbr2gF9+LlUUADLMqt8ETlTrCiohW09132FQqg==
X-Received: by 2002:a05:6a20:7493:b0:199:31af:9207 with SMTP id
 p19-20020a056a20749300b0019931af9207mr371470pzd.52.1706149593801; 
 Wed, 24 Jan 2024 18:26:33 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a170902b7c100b001d75db0ae21sm4696611plz.170.2024.01.24.18.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:26:33 -0800 (PST)
Message-ID: <3aeb1471-dc88-4971-9e77-e1896e40d446@redhat.com>
Date: Thu, 25 Jan 2024 12:26:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/arm/aspeed: Init CPU defaults in a common helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-4-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123224842.18485-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Phil,

On 1/24/24 08:48, Philippe Mathieu-Daudé wrote:
> Rework aspeed_soc_num_cpus() as a new init_cpus_defaults()
> helper to reduce code duplication.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed.c | 71 +++++++++++++++++++------------------------------
>   1 file changed, 28 insertions(+), 43 deletions(-)
> 

One nit needs to be addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 5b01a4dd28..636a6269aa 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1141,10 +1141,14 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
>                                             "Change the SPI Flash model");
>   }
>   
> -static int aspeed_soc_num_cpus(const char *soc_name)
> +static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
>   {
> -   AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(soc_name));
> -   return sc->num_cpus;
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(mc);
> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
> +
> +    mc->default_cpus = mc->min_cpus
> +                     = mc->max_cpus
> +                     = sc->num_cpus;
>   }
>   
>   static void aspeed_machine_class_init(ObjectClass *oc, void *data)
> @@ -1176,8 +1180,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 1;
>       amc->i2c_init  = palmetto_bmc_i2c_init;
>       mc->default_ram_size       = 256 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
> @@ -1193,8 +1196,7 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 1;
>       amc->i2c_init  = quanta_q71l_bmc_i2c_init;
>       mc->default_ram_size       = 128 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
> @@ -1212,8 +1214,7 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
>       amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = palmetto_bmc_i2c_init;
>       mc->default_ram_size = 256 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
> @@ -1231,8 +1232,7 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
>       amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = palmetto_bmc_i2c_init;
>       mc->default_ram_size = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
> @@ -1248,8 +1248,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 1;
>       amc->i2c_init  = ast2500_evb_i2c_init;
>       mc->default_ram_size       = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
> @@ -1266,8 +1265,7 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = yosemitev2_bmc_i2c_init;
>       mc->default_ram_size       = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
> @@ -1283,8 +1281,7 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = romulus_bmc_i2c_init;
>       mc->default_ram_size       = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
> @@ -1301,8 +1298,7 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = tiogapass_bmc_i2c_init;
>       mc->default_ram_size       = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
> @@ -1318,8 +1314,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = sonorapass_bmc_i2c_init;
>       mc->default_ram_size       = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
> @@ -1335,8 +1330,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = witherspoon_bmc_i2c_init;
>       mc->default_ram_size = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
> @@ -1355,8 +1349,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
>                        ASPEED_MAC3_ON;
>       amc->i2c_init  = ast2600_evb_i2c_init;
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
> @@ -1374,8 +1367,7 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask  = ASPEED_MAC2_ON;
>       amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
> @@ -1392,8 +1384,7 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = g220a_bmc_i2c_init;
>       mc->default_ram_size = 1024 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
> @@ -1410,8 +1401,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = fp5280g2_bmc_i2c_init;
>       mc->default_ram_size = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
> @@ -1429,8 +1419,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
>       amc->i2c_init  = rainier_bmc_i2c_init;
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   #define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> @@ -1451,8 +1440,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
>       amc->i2c_init = fuji_bmc_i2c_init;
>       amc->uart_default = ASPEED_DEV_UART1;
>       mc->default_ram_size = FUJI_BMC_RAM_SIZE;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   #define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> @@ -1472,8 +1460,7 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask = ASPEED_MAC2_ON;
>       amc->i2c_init  = bletchley_bmc_i2c_init;
>       mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void fby35_reset(MachineState *state, ShutdownCause reason)
> @@ -1515,6 +1502,7 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, void *data)
>       amc->i2c_init  = fby35_i2c_init;
>       /* FIXME: Replace this macro with something more general */
>       mc->default_ram_size = FUJI_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc); //
>   }
>   

Failure from './scripts/checkpatch.pl --strict'

ERROR: do not use C99 // comments
#216: FILE: hw/arm/aspeed.c:1505:
+    aspeed_machine_class_init_cpus_defaults(mc); //


>   #define AST1030_INTERNAL_FLASH_SIZE (1024 * 1024)
> @@ -1592,8 +1580,7 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
>       amc->spi_model = "sst25vf032b";
>       amc->num_cs = 2;
>       amc->macs_mask = 0;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
> @@ -1612,8 +1599,7 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
>       amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
>       amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
> @@ -1632,8 +1618,7 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
>       amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
>       amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static const TypeInfo aspeed_machine_types[] = {

Thanks,
Gavin


