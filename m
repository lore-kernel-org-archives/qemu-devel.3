Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE94C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE69r-0002fR-AJ; Mon, 03 Jun 2024 07:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=jUUh=NF=kaod.org=clg@ozlabs.org>)
 id 1sE69o-0002dn-6o; Mon, 03 Jun 2024 07:47:20 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=jUUh=NF=kaod.org=clg@ozlabs.org>)
 id 1sE69l-0004df-4s; Mon, 03 Jun 2024 07:47:19 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VtBly3jQhz4x23;
 Mon,  3 Jun 2024 21:47:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VtBls3RCyz4wcv;
 Mon,  3 Jun 2024 21:47:04 +1000 (AEST)
Message-ID: <44a84ad3-797a-4c7e-ae6f-c80db047292f@kaod.org>
Date: Mon, 3 Jun 2024 13:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-10-jamin_lin@aspeedtech.com>
 <b641018c-e906-452b-8072-1b46f141808b@linaro.org>
 <41e59fa6-c74d-47c7-ba01-690cfaf7f5f1@kaod.org>
 <SI2PR06MB504115C43768F1DF7E9621B9FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <98886224-8de7-41d7-9ae9-77ac85818605@kaod.org>
 <SI2PR06MB5041574C3A7283A1A29B81FCFCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <747755fd-dc9d-4bbd-9b6d-eaabe398bb19@kaod.org>
 <SI2PR06MB5041FCED8D307124D1747830FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB5041FCED8D307124D1747830FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=jUUh=NF=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Thanks for your suggestion. How about these changes?
> 
> 1. aspeed_smc.h
> struct AspeedSMCClass {
>      const MemoryRegionOps *reg_ops;
> }
> 
> 2. aspeed_smc.c
> a. create new memory region opts for ast2700
> static const MemoryRegionOps aspeed_2700_smc_flash_ops = {
>      .read = aspeed_smc_flash_read,
>      .write = aspeed_smc_flash_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
>          .max_access_size = 8,
>      },
> };
> 
> b. set memory region opts in all model class init
> static void aspeed_2400_smc_class_init(ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2400_fmc_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2400_spi1_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2500_fmc_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2500_spi1_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2500_spi2_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2600_fmc_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2600_spi1_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2600_spi2_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_1030_fmc_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_1030_spi1_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_1030_spi2_class_init (ObjectClass *klass, void *data){
>      asc->reg_ops           = &aspeed_smc_flash_ops;
> }
> static void aspeed_2700_fmc_class_init(ObjectClass *klass, void *data)
> {
>    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
> }
> static void aspeed_2700_spi0_class_init (ObjectClass *klass, void *data)
> {
>    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
> }
> static void aspeed_2700_spi1_class_init (ObjectClass *klass, void *data)
> {
>    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
> }
> static void aspeed_2700_spi2_class_init (ObjectClass *klass, void *data)
> {
>    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
> }
> 
> c. update realize to use memory region opts from class reg_opts
> static void aspeed_smc_flash_realize(DeviceState *dev, Error **errp) {
>      memory_region_init_io(&s->mmio, OBJECT(s), s->asc->reg_ops,
>                            s, name, s->asc->segments[s->cs].size);
> }

LGTM,


Thanks,

C.

