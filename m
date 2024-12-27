Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613C4E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 08:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR5vB-0005EU-Aa; Fri, 27 Dec 2024 03:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tR5v5-0005Da-8l; Fri, 27 Dec 2024 03:42:07 -0500
Received: from mail-psaapc01on2070d.outbound.protection.outlook.com
 ([2a01:111:f403:200e::70d]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tR5v1-0006CG-3G; Fri, 27 Dec 2024 03:42:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMc5jQhV3zfaEeIV6YPDfz36kQ3DF2BEuEywpuwfzW/GgTbgYWMVs9abUf+mMyqFvfGQ8og1mNs7pLysLffaGzeSeFyTY21kJaQfImDlwb/gnSIo2lKnrYiVQ5G9hDesWRuRGdS6B51ypgdGVYXfY5Frs07CYIV+oATiWwVF2A8KwR+2YPCtzgxnvh48w7YsB8UDmM5FOM8h52HiIZVrqR9jdSH4ZVoPan8OOSy6CBXLNDDk2NpRm90rPwvi+3R73Y3IJBIZk9bBp7hQXynj4FkL7feGER8H3IMaeQYn4E5FmDlxCTocN14anyfM1/4aqv4caYytmZ1NuRYSL0+0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb//rhTOOI3QLW77N5uTrKFfOjjTNXeUz66l43iCO0s=;
 b=n2sDGIMtL9gDZcb9PU84ZQHWBNypgX/CtuZ4GJUJA+AHwWitv6ADRarbtXvWcQgOsx/i+EDz3cw/TSunA8O7w0/doKV1WeSr/yIFmPmbEMvqb9ahcuF2iWbO/38lD4rrvIefJr/ZsmeyRDg1NQprZpXW4lNCbVaQm+vC7PjEW1h5IWH569FI7aW63nND2+VI19XjS0JI8BizvWCt3BeR/EhpEdfImElJYmdaU0DiE2rWYNj20MExt90KODuaoiYdwf868WybxQFZSiTsn41V9OblyTXyYPwkjKJKLtFcjthF8m5dJ7ybcYAUCY9WBXCQJw0VsgIElRlDCMSvYwY2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb//rhTOOI3QLW77N5uTrKFfOjjTNXeUz66l43iCO0s=;
 b=JPSbz+rrkXc4fg6320FCYYZIu8EGTF7Kx5coMOP9xuj1uDx49PPkc5vzi3r6q4LWJT9fO1xOh6FTJW9llJwfTHtFfdbME7fkEAP3pSZmP04OLXFAjhbRsIPYZxzlSjwdJGPNTWgGOzhON4fpuNGGPwKe+ahdQufJcJ4d+K/hnwQ7gHPJtuY9egHi+vydQQBy30mvMKc9jWUh4tcn1NEcZ7Uwc1Zs7tLbS5lFkO8nrJ1PaPO1SuCyeGHJCMIaFs9ayPlIZc7K86bDD2rIU0bSjPOyfbR1OEH/1+0ebheDlMRp0MrX9nFBNpubFQX6VxncnBro2ZoF+DFZr7h0wPsXAQ==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB7290.apcprd06.prod.outlook.com
 (2603:1096:101:24f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.7; Fri, 27 Dec
 2024 08:41:52 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 08:41:51 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH 1/5] aspeed: Make sdhci_attach_drive and write_boot_rom
 public
Thread-Topic: [PATCH 1/5] aspeed: Make sdhci_attach_drive and write_boot_rom
 public
Thread-Index: AQHbVnErcGV/Sv8L9kaZNX1hkFxSKrL5vM6AgAAL4KA=
Date: Fri, 27 Dec 2024 08:41:51 +0000
Message-ID: <KL1PR0601MB4180083F3738E9DAEB8CA635850E2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-2-steven_lee@aspeedtech.com>
 <b915cf10-8b1a-428d-beb0-f3d6f9ce816a@kaod.org>
In-Reply-To: <b915cf10-8b1a-428d-beb0-f3d6f9ce816a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB7290:EE_
x-ms-office365-filtering-correlation-id: 88cbe049-ac33-439f-e719-08dd26524f50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NVdPZDJ6b1o1YWswVGdSbUdGTVFKdzNyTEk2SThpN1NLYVBITml0dEFSRWVr?=
 =?utf-8?B?dXBmMFdJQVByRUZCL2t1RnpXSVh1UjcwUjRkQllGUjNMSDFWTG9ZSkhIYTdJ?=
 =?utf-8?B?eU1MMUlzcnBhMDJlbHhlc1ltSzJSdzN2bGhoOGJqbnVVNCtTbE16b0I3a01R?=
 =?utf-8?B?VVVZVjE4VUJ6eUtVaGtkZnVNR1ZpamhET2FySjJMODJsNVlUTFYrV3AxOFpB?=
 =?utf-8?B?MXo0ZTBCbm9DVmlIZzV6Y1hnRmlKUkNIM2pPVU54NFdWSmNPK3A3TVpwOVNa?=
 =?utf-8?B?Z0NsY2JrT2FhcEpFekVZWElXWDZVZTdoRFRZd1BjN3czNkNWcGRnTDJDR0Y4?=
 =?utf-8?B?QmZzVkIwVktlcDRuWFYxTjROTXE1a0tzbUZQNzJJWElRYUw2TUM3dVFReXlJ?=
 =?utf-8?B?U2FRU0tsTzM3b3BJcW4wRDRLSk9OZjZ0a2x4Rmdzc1Q0a3RCYWNsN0xvT2xU?=
 =?utf-8?B?WnowYVlFQjB6WFBBNzM2dkN1NGN4SEtiUDcvc091YjJrU3pLSXRKeUpaMEVD?=
 =?utf-8?B?aEdIVFhtNDMxUi9xWmtGV051Vm9EbkdyQlB5SXNXZ1kvQWFrS0xxdzJCRUMx?=
 =?utf-8?B?M1F0bFFKOEs0QzFPZGdyaDZZNDZGSzJHUVZRbEJjRjFGV0YwbHlRM2ZraTA1?=
 =?utf-8?B?SzlISVhoTjBGRElUK2s5Z0xybnpaVTNRcDYzTzB3Z1BMdFo4VkVCcStSQ25k?=
 =?utf-8?B?Y3hPMFg3eENOVVIwblNRWHBXbUg3eWxuN24zTitwZ0FxSTV6amNiREFjYmhs?=
 =?utf-8?B?YVBrd1dZOTBLQkphTzRwRWZ3REJySHoydkE3cHFpOFJuSHZrZGVkUXIwa2Vw?=
 =?utf-8?B?YkRxQzk0STRxZVlKZHhqVUZwQ2MrSC9UK1NDTWQzeis3cTY2OEthMjdNMU5u?=
 =?utf-8?B?TTJoR3RCYkpFT3JtaTRCWGcxSEFwQnM1MzZVNStvRzVDOXZQdVhqaXh5MkpY?=
 =?utf-8?B?UFFJU0ZCem5GV3FlNkN5L05mbUluYmUreXJYZ095SXg3eTB1R0Z2UDRRMmFa?=
 =?utf-8?B?cUppYlhDV2phQnUxOHdtU0I3U2lvaTZZOEkrRmdBSSszb2c0QXpJS3h6RzNU?=
 =?utf-8?B?Sm9oVHV4eHNWZGIxckFzNE91bmdIUThXc2xQYjJiVlUzZHNmSUNtb3lBZ3NI?=
 =?utf-8?B?UWVxOXd3YTA3ejJzWUhKT3NlbDNYUkFZZGliYmJyN1ZhWHpoOVR5K29UWFE4?=
 =?utf-8?B?d0tLYzJyMlJDcENjMWxnU3A3V2FCOHA5YjV4WmZwT3dqWlBrakFTY0ZySjVu?=
 =?utf-8?B?MHpqVzZsdVlhVDlWajY3ekpUb0M0eXlZMDZoQ3Eyc2hNQitlazk3ajJKdldO?=
 =?utf-8?B?blVpSFlVdnpKZWc2YkduM3Ntd3Vab0lBUU9ZVTVicjZJbzJRQ1doUE9sYi9N?=
 =?utf-8?B?SFIvMktZYTR4Q3FVY2plZU1SOWczOGFEYmRoQW5peXNjYUp5UEVwZVpLbHhB?=
 =?utf-8?B?Q0M1YzhTNUxhZDJ4MGhmQjNXdktZdHJXWWdYbDVFaHJWNUFGcHZkRERiMXdS?=
 =?utf-8?B?cXZ3d2dMZDJsMktQSHhTQlF3VWpPbFQyK2MzSkpYWEdyRjBkN1FCSE5FYU5D?=
 =?utf-8?B?YW5BcWp1c1pZV1JmRVJEOXo3KzJzNG41dzFjb3d2TjMxNWNRWXdqMGJrZXhR?=
 =?utf-8?B?Z1RNNHJBV012NlNRNERXWmJFbVBtWi8xVk1HaGVIZUgva1VlcHc5UVIrNmQw?=
 =?utf-8?B?KzlHZmp1VGk2WVJxZUtMc0lyZzBlcSs0cVlBbUI2K0tGZnVQVC9peENJN2lz?=
 =?utf-8?B?NnJTK1pSMlNIL0pSQ2pTcEtuQzhiNXhpZ09LWDg1c0xEU1BENTV6RS9XdDV2?=
 =?utf-8?B?L0NaelVweDhtRzNubUlEcHFMSHhpMnF0c0hPdW05QmV4VktYbXdRdHJ6WDFE?=
 =?utf-8?B?SWVUamVKWlZRaWYyN2tFa0x3SG5yWGRNS3J1a3pNVXZEQng1Q2Zmc0hrWkdS?=
 =?utf-8?Q?16T0eHMRPomcbWP8F1Dx36u+8wBl1Eex?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkFYSnlBK0RqR0NqcWJmai9mN0V0T0tvMDNRRE5LNzFEN3UzR05kTjA0ZXYy?=
 =?utf-8?B?a3l5ODFmRjE3TmFSM2NuY3ZhQVVOTWFVOEFVY1RDMmNXcnR2RzJZSklHOTg4?=
 =?utf-8?B?dDI5eHJVUytZZ1VCOEJpa3RIcEh0QUZpUEIycHBaa1F5eTNybGJpN2ZuckNn?=
 =?utf-8?B?dGtvbTk1UklyNkVFRnJwbGJlQ3JtVmE3TEtlb1JGQ2RPbnc2VU1VcjJURGNu?=
 =?utf-8?B?WFQ3ZHNVRTg3MkQwdDZjSXhBSU5NamUyWmxyQkxucm5yVkJOdjNjUUFwaVM2?=
 =?utf-8?B?cmxRT1NwU0tPZXJsZk1abDIxYUR1K1k4WHo1OS9Gd0ZXdzEzdWt0d0svMkJ1?=
 =?utf-8?B?R1FDN3V6M0xhaGFwUzRvT0VGTFZzL2p0SGJHV0t4WjRweHorNmU1N21zSjl3?=
 =?utf-8?B?M2NLUkJ1eGJ6NVFmQlJuVFdWK25LendTTXNCOGNPT29nZTJiV2pFNVg1bzV4?=
 =?utf-8?B?Umpxb2hIYm92dDh0b21sSVgyVkJiNFkvY2VHa1RhRnM0UVZqTlNJK24vMVpW?=
 =?utf-8?B?bHpodXc4ZEtzcjJyWmZGaEtlWmMrZWxhN21aWXBHYkFlUWhEa1dPajBXcGxC?=
 =?utf-8?B?M2xTSWhJUktiM1JMOHRCMldCb2oxUnJXRzZwZzhUNGhib1JEQVNvZmp4QStl?=
 =?utf-8?B?VUZOV2ZuQnFFRTVCdExGcmdLWFE2SmF1RXljZm8xSXNYNm0yNDR6dTArRFA3?=
 =?utf-8?B?VThad2hSK25oNHNjSHZrb2F6Ukd0L2ZRdW9xb0dGZmpaTVJ5VzBYMFhlZHdP?=
 =?utf-8?B?WEF0VHVFY3crNWExM2J6Y3AzTEgxUmkxODR0YWhXa05pdWx3QksxTWt1aVJx?=
 =?utf-8?B?MnFnUlpLWld6dFBNWkxYUS9scmh3blo1Q0U4TitNZzJEcmtBL1lzU2srMG9j?=
 =?utf-8?B?U3RSTlRtb3Q4VGdOSFRBMnRjdSs3RytVRHVkUS9GUnNsUWRIbDJEWmhJb1h1?=
 =?utf-8?B?bEN4SUFiSWVTWjJSb0F5RWErYzRvWnBUV2xtL3Blb2lueGNWK2hvNzZSeXd2?=
 =?utf-8?B?M2h6VDU0KzZZUE5DQ3h1MEVtWHVYYXJtdXVEQTdpVWpiUitCd01CRG9aUkZ0?=
 =?utf-8?B?cmY1WXBxQk1hZkZ1VTFnOVI3SXk0NGUvY3FYZFZ0TzdZcDNrbUhwWnZmNlN3?=
 =?utf-8?B?cUYveThDamIrWWZsaWorUTBNMXMyTjhvVHhVWWNaUzR5dEpiVHUzc01VWjll?=
 =?utf-8?B?TTZBdjNoSzU0VEZWd29LR0x6bzhqR0JXUkh5bS93TFBJcnlRNTBYSFZvdmVi?=
 =?utf-8?B?aUZsSjk0Q1pEdlN2QzF6N1FrNlFoQ3ltYlJ2YStSUjRKeFJTUVhndkRMSmdn?=
 =?utf-8?B?Tlo4YStVZWQ1MzJycjZhVjlGVGJIU21keTltenljaVdzR3AybzBkaHQxb2pj?=
 =?utf-8?B?bGJxcjFpcTJLWmdJZUVCaXBkSk45RERZL1pGT3dtaGgwT3hwcXBEeWxtaUUz?=
 =?utf-8?B?TWszdGlsREJJZTZhR0NzUW1GRzVZRjlTUnNPaElkY0JmTWZmYnRpZnAzRzRq?=
 =?utf-8?B?K3IwYVpWWHpkVTJQL0M1VEZHWCtuKzRlaU9PMXVMeW92aC9Ca0cyelc1WHRX?=
 =?utf-8?B?THJRdXJiMytvdUxpYTBvSUVDTmh4M1RKanViS1U3V29MQUdmeUhXRjkzVDZw?=
 =?utf-8?B?dDREaDdDYUw0ZS9mNVJJUCs3SStKa3VHZ3dQaUlnMHJXbDBjVk45Z1ZDZFZW?=
 =?utf-8?B?MmtleVIwVmZ6R0o4b2NQUUovZDZMdkVNVHdaZWpzc2FTVlRkZWtDd0Q5azZO?=
 =?utf-8?B?Mk1IU1hkRGNUOTRyanhWUmdxcWRVT2E5dlV5aDY2YXEvLzU2dDl2UXRadW5G?=
 =?utf-8?B?ekRYT2RKS0hhMUdyaVIrZnJXMmJDZ2JCTE1TaFJaRnBVTnRadGt5cW1iYmM3?=
 =?utf-8?B?SDlTQ3J5MEtLRTlxTm1vT1JpMlptdXdpUTdaaHZiQzhUSWlWS3EzWFNocHJ1?=
 =?utf-8?B?dk4zdWhrdFJTeHRFVERyTUVHOXF2cTZJVFhLSWZsOVJIcHNaWlRlYTg1Zy9x?=
 =?utf-8?B?dnpWbER0YU85YnJzU3hIeEFKVGRDeVJPb0xTWlB6UzZmRVlUcWR6WGNJMzVo?=
 =?utf-8?B?UGRFVUFtV3NoT3V6WHlBZXdqMkM0d0xtVytLMkpkd0pzNkNCb1NIeXZLUCs0?=
 =?utf-8?Q?TjDGVzoY0sHhLpLCGT/aCP+xg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cbe049-ac33-439f-e719-08dd26524f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 08:41:51.6051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiI7oaFgqyc6VMuh38ulVrjHR4PJUd+4PC80gSu521+PaJyN9tXkT/8iC36IkXwWO71CQtgRvzlQS9P9+nXDWCoUyWjDq+IIhJNshB+Jd+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7290
Received-SPF: pass client-ip=2a01:111:f403:200e::70d;
 envelope-from=steven_lee@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDI3
LCAyMDI0IDM6NTcgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExl
ZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzVdIGFzcGVlZDogTWFrZSBzZGhjaV9hdHRhY2hfZHJpdmUgYW5k
DQo+IHdyaXRlX2Jvb3Rfcm9tIHB1YmxpYw0KPiANCj4gT24gMTIvMjUvMjQgMDM6MDMsIFN0ZXZl
biBMZWUgd3JvdGU6DQo+ID4gc2RoY2lfYXR0YWNoX2RyaXZlIGFuZCB3cml0ZV9ib290X3JvbSBm
dW5jdGlvbnMgbWF5IGJlIHVzZWQgYnkgdGhlDQo+ID4gYXNwZWVkIG1hY2hpbmUgc3VwcG9ydGlu
ZyBjby1wcm9jZXNzb3JzLg0KPiANCj4gSSB3b3VsZCBtb3ZlIHRoZXNlIHJvdXRpbmVzIHRvIGFz
cGVlZF9zb2NfY29tbW9uLmMgZmlsZSBhbmQgcmVuYW1lIHRoZW0NCj4gd2l0aCBhbiBhc3BlZWRf
IHByZWZpeC4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQpUaGFua3MgZm9yIHRoZSBy
ZXZpZXcuDQpJIHdpbGwgbW92ZSB0aGVtIHRvIGBhc3BlZWRfc29jX2NvbW1vbi5jYCBhbmQgYWRk
IHRoZSAnYXNwZWVkXycgcHJlZml4IHRvIHRoZXNlIGZ1bmN0aW9ucy4NCg0KUmVnYXJkcywNClN0
ZXZlbg0KDQo+IA0KPiANCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU3RldmVuIExlZSA8c3RldmVu
X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWQuYyAgICAg
ICAgIHwgNCArKy0tDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWQuaCB8IDYgKysrKysrDQo+
ID4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVkLmMgaW5k
ZXgNCj4gPiBhMThkNGVkMWZiLi42MmFjOGI3MjA2IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9h
c3BlZWQuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+IEBAIC0yNTYsNyArMjU2LDcg
QEAgc3RhdGljIHZvaWQgYXNwZWVkX3Jlc2V0X3NlY29uZGFyeShBUk1DUFUgKmNwdSwNCj4gPiAg
ICAgICBjcHVfc2V0X3BjKGNzLCBpbmZvLT5zbXBfbG9hZGVyX3N0YXJ0KTsNCj4gPiAgIH0NCj4g
Pg0KPiA+IC1zdGF0aWMgdm9pZCB3cml0ZV9ib290X3JvbShCbG9ja0JhY2tlbmQgKmJsaywgaHdh
ZGRyIGFkZHIsIHNpemVfdA0KPiA+IHJvbV9zaXplLA0KPiA+ICt2b2lkIHdyaXRlX2Jvb3Rfcm9t
KEJsb2NrQmFja2VuZCAqYmxrLCBod2FkZHIgYWRkciwgc2l6ZV90IHJvbV9zaXplLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiA+ICAgew0KPiA+ICAg
ICAgIGdfYXV0b2ZyZWUgdm9pZCAqc3RvcmFnZSA9IE5VTEw7IEBAIC0zMjUsNyArMzI1LDcgQEAg
dm9pZA0KPiA+IGFzcGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoQXNwZWVkU01DU3RhdGUgKnMsIGNv
bnN0IGNoYXIgKmZsYXNodHlwZSwNCj4gPiAgICAgICB9DQo+ID4gICB9DQo+ID4NCj4gPiAtc3Rh
dGljIHZvaWQgc2RoY2lfYXR0YWNoX2RyaXZlKFNESENJU3RhdGUgKnNkaGNpLCBEcml2ZUluZm8g
KmRpbmZvLA0KPiA+IGJvb2wgZW1tYywNCj4gPiArdm9pZCBzZGhjaV9hdHRhY2hfZHJpdmUoU0RI
Q0lTdGF0ZSAqc2RoY2ksIERyaXZlSW5mbyAqZGluZm8sIGJvb2wNCj4gPiArZW1tYywNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGJvb3RfZW1tYykNCj4gPiAgIHsN
Cj4gPiAgICAgICAgICAgRGV2aWNlU3RhdGUgKmNhcmQ7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvYXJtL2FzcGVlZC5oIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkLmggaW5kZXgNCj4gPiBj
YmVhY2IyMTRjLi5iYmEyMjRjMzU3IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvYXJtL2Fz
cGVlZC5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkLmgNCj4gPiBAQCAtMTAsNyAr
MTAsOSBAQA0KPiA+ICAgI2RlZmluZSBBUk1fQVNQRUVEX0gNCj4gPg0KPiA+ICAgI2luY2x1ZGUg
Imh3L2JvYXJkcy5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvc2Qvc2RoY2kuaCINCj4gPiAgICNpbmNs
dWRlICJxb20vb2JqZWN0LmgiDQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0vYmxvY2tkZXYuaCINCj4g
Pg0KPiA+ICAgdHlwZWRlZiBzdHJ1Y3QgQXNwZWVkTWFjaGluZVN0YXRlIEFzcGVlZE1hY2hpbmVT
dGF0ZTsNCj4gPg0KPiA+IEBAIC00MSw1ICs0Myw5IEBAIHN0cnVjdCBBc3BlZWRNYWNoaW5lQ2xh
c3Mgew0KPiA+ICAgICAgIHVpbnQzMl90IHVhcnRfZGVmYXVsdDsNCj4gPiAgIH07DQo+ID4NCj4g
PiArdm9pZCBzZGhjaV9hdHRhY2hfZHJpdmUoU0RIQ0lTdGF0ZSAqc2RoY2ksIERyaXZlSW5mbyAq
ZGluZm8sIGJvb2wgZW1tYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgYm9vdF9lbW1jKTsgdm9pZA0KPiA+ICt3cml0ZV9ib290X3JvbShCbG9ja0JhY2tlbmQgKmJs
aywgaHdhZGRyIGFkZHIsIHNpemVfdCByb21fc2l6ZSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4gPg0KPiA+ICAgI2VuZGlmDQoNCg==

