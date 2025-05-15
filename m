Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85876C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFSlE-0001Dh-SJ; Thu, 15 May 2025 03:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFSlC-0001DU-DL; Thu, 15 May 2025 03:12:06 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFSl7-0002VX-Iv; Thu, 15 May 2025 03:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5IIcpmx2oALq0ROe+SrwDa1LpavmYoU1AZIiljgNAh864LI5RuXTYDYG9iTk8M0vA34AU5ZOiTYWbLqAZ+zLtLtrVs1L5gIFbOiuySoFWnlm5cISAWyeOwrcZPXxSvY5CIlYF7MfDr4LJtSNHo5/jjcZiQsjUYVkFTSy2z9WNy2Oqx1myfQ+XGm+UXX/eBpaPomUSqzyHkVPtOeD0MVWU81fUHfcUIPr8yKry2A5orTbg/6pk7JXEnQ8AxBBUQuVwIZQiqizDb+1WeeNyH+6D/XbYkSxJz1jF50fMb+tDm3oWHf1fu5uAbMuYKOI4mklaxvJoDb36K4PAYIfcVqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo/Br6mBsYdcNNfj7feG/xGh99hDjgAmmOyvMuD0AmE=;
 b=aG9X5gJ4yhxKT/qtiu2Rv55Z9WxoNGrcYLXWPId9fnIEeprmo99NfGO7iDwOiiVtSrpteHs9r6SqqQe6cQY+wp7x1VXxy9eOSpcDZOL5mWos0puCY0z+Xx0rnimj25ED6Oep7Z647/ZzyyeZZJSX3DWr4x7beRo/SNWVEMeUKaauto3mFhAV5Z7l0Q163N3c9SKRCRUfASX8OByxOtEuURbAaSXs2g3nwQ8syK9xflSTyt8WER07w17ZsXd0kFZ+FB/GrkqY/16KN1aa6TcZ/x2d0175+2zZKSbIza6N/+WEwwplUl4C2sVPT0gDwfE3XVzMQY1wpjgmBQzIBzfwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo/Br6mBsYdcNNfj7feG/xGh99hDjgAmmOyvMuD0AmE=;
 b=hYMPBCJodHZXlpNhgzH6o/v/SqYKFJNKbId8NI4UkYHUpLofZ8VGvmlavgim8nJu8Nsrzoom/K/HViPKK0ZH2IQqKC9GNReAiMSJu0o8+mNwphyqoXnyQ/5fYg7uAbvXA6R2UyehOXXCVXykGS9m9HAkDoygbpmwVWwvTDkdHWKp3/9g0VXfD3SFO/qiCqKlsASwZCHofuCi1kXqziCHBlvnwp3F2YE1lp/n8BEqQ7YKVSoisHr4JerGONYDOmveqsHNvo5n52IxWaMOjXHS7iLW40BoliPbs05HKAvqCv9ciLn/sFErao4xgd7458fMGFG5n5noUv3WUKLeNpie9Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SE1PPF1BDA05984.apcprd06.prod.outlook.com (2603:1096:108:1::40c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 15 May
 2025 07:11:49 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 07:11:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
Thread-Topic: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
Thread-Index: AQHbmkNXc4tSzAUgS0eQdreGXV1+FbOQEMwAgDoaPGCAAYZDAIADS7lggASaaSA=
Date: Thu, 15 May 2025 07:11:49 +0000
Message-ID: <SI2PR06MB5041D40F9C8FE86EAD69FA67FC90A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-9-jamin_lin@aspeedtech.com>
 <ff5e84c5-4714-4897-90b6-40df76746443@kaod.org>
 <SI2PR06MB504194D74CCFCBB9403B7214FC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ba12c8bd-2d9e-46f1-a89e-fa3692e1098a@kaod.org>
 <SI2PR06MB5041A336D11A710AB57F057FFC97A@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041A336D11A710AB57F057FFC97A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SE1PPF1BDA05984:EE_
x-ms-office365-filtering-correlation-id: b865c2ce-7838-4748-3071-08dd937fc2c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?RjMzb3habSsvdmo5dXlFNmQ1ODV2cnEvcGMyWUpSYU5Cd0lWcDNiSWJjUFRr?=
 =?utf-8?B?NzVjQTczWFdMa2JDUWRaUUZqUVg1QnNaQmk2QUI3WjczQ29nQldscGFjeGtL?=
 =?utf-8?B?S09OczBPWDZIamFNZnBGM2JINTZ5d2NEbnhpZW9Db3hUdDNPQXVhWDhtWVBC?=
 =?utf-8?B?cFg3czd2SFltWi8vTHBJNmFUK3pXZlF1aGQ1Nkh1SmxGSUYrditCdTlSeUFH?=
 =?utf-8?B?Y0J1VXBISlRSdDBwZVlMZWRNR2p0WWhtc2krL290cEkrdXlzUkpZNVJnSHBT?=
 =?utf-8?B?OFdrdnBIanFva3EzNFVPd1pwRWlCOHd0eXZrWWJlRVoxVkgwL2xWRyszcDUx?=
 =?utf-8?B?K2wweittN2o3WVhBYWhXMDJMOTYxNTRFSmNkVTJtc2NBUG15VW40QU5IVUQ2?=
 =?utf-8?B?RmdSWGlRVFhwZzJHOHEveXNzNEI0eWxUSWRwb0ovb1U3NXRYWHEreFkrSUYv?=
 =?utf-8?B?Z3BBdCtXTHFpLzV6RkY5Z05QVWIyL21uc05tL08vOHFCUVFuQ3U4anFDUTlW?=
 =?utf-8?B?anpBNG13RUdLUldTRUhBTGhjTFRNUHdWL2RmU1N6RStxdXJqSjV2dXhBd0k0?=
 =?utf-8?B?alFiV2lGQnNaSnpmaG80VkJUYytlQkhwdjVvQUJWWnZoTnNjMmxvaTE4SkNK?=
 =?utf-8?B?QTYxRXUzdUZiMEFFUk9SbGxtV0tINnl3U3NMeDd6bkNnOHdaR0ZNQlJLZHhI?=
 =?utf-8?B?YzNqUXFnU3QrM3BFRHBiQURIOUxsMHJMOGhGSFlmZHJyRlUrVXZaeitPVEdj?=
 =?utf-8?B?M0ZPclhpM2M1Z3ZSbStjb1BHMWR5cHdIai9RK09NVjZKQWs5T3JoOWQyeEhP?=
 =?utf-8?B?VDJ3Z2JwUW80STE5NE15MVNQekRJaDBZVVJBVmxYQTNGVGFFeVkyRk9jMFRy?=
 =?utf-8?B?WWJQSjRXTWt5emE4NnNQRGJSWFk1Z1N3UDl4bHQxdDFDZmQrWHhKempPakFz?=
 =?utf-8?B?OTRGSUNsUmNzTFV3b2s3bWtQR2V3MlB1c0VEOXlGMExhME5jK0NvbFJuWS9t?=
 =?utf-8?B?cGxTcmgwbnV6OG5YeGx2WEY0ZXduZGlsZ25tdnNlbnlXRlExOFlYNFZncTFV?=
 =?utf-8?B?SE5hS0t2YUVUTDF1bVZWNmZaWnkzaHdqUTlXc0pzSFhvbkNERnFzRGhmWXcr?=
 =?utf-8?B?ZkhuOVVZUElMd0Z2Y1RIYjNLZlB3STBJQkpZdW4zRmlJRXllRkpRWit5SnQ0?=
 =?utf-8?B?YStSekJaeExWMHJwRVB6My9CaklndE1XbW5uMlRoSWhDU2JScWJmYzBUSEF5?=
 =?utf-8?B?ay9wYzdKb0tYc3VnZXVMY1RMMWxoRlpaa24ycXh5WXRWdlVJQ3JtOFpMejVD?=
 =?utf-8?B?ZFh6RmtUUmtYS0I5SnlxUzRJYkR5VFloUmpzVTRRY1g3M2ZjZ09pUTRpcU45?=
 =?utf-8?B?amZSa2Z2RGlQQnh1NDJhZXVrZGlJTnJyTUhiTmd5cFUxRTVGN2JLRi94c0Nu?=
 =?utf-8?B?VnZ3aU1TMTlqY1VCSU9zR0F6Qi92L0phQzN2ZG9CSU5OdkhROS85djFUUXpS?=
 =?utf-8?B?WFUwbW9vQVFPcXdlYStkK21oZTF5UGw3blg0Zno1b2h6QzcxNmFMbmxQSkRT?=
 =?utf-8?B?eFlzVTJBRCtzSXRDYjRwaUJIVnZ6WDNPTTY5Ym9UL1hBd3A3ZnFpbmE2OWdB?=
 =?utf-8?B?VmRQd2NqUWZuRXVOODBaemdqNGZJQXhIcXh6dmd5d0VSK1VuUnBKQjZXTnlp?=
 =?utf-8?B?dzVYcW1tRkVOM0p5UHJYUlc3bndPUmV6eW5sQng1ZTZUS05lY0R4VEtySWJ2?=
 =?utf-8?B?WHZlSWJLeGVkaFVFSnpYRSthdXMrN3N5ZldteDBvSU50bmM0UTVNb3VwWnJa?=
 =?utf-8?B?TGY1dUlEVXJTV2NkdTVXaDVjQVppMW1ZYjlzSWJhMDVzNHpDbENlQWZ1SFRL?=
 =?utf-8?B?eHpaYVd6MU9qUVhBc2EwVHR5UUNxeWJhU2hubGszMmFnV2h5cjdSQ1dTYmVI?=
 =?utf-8?Q?guzU4d08M8SHRSL9W5IA1Bes/6Us0FuI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXcwV1MvdnVTRzNia3JmaldzSHJ0My94RXI0ZEZnQkVlUzROZnp3OGduYXg5?=
 =?utf-8?B?ZVFrRTFMb2l2SzRjeFErMDlDOHlMZzRJa214VVNXU1NXenRTVWZXd21ERU5o?=
 =?utf-8?B?aXBkTmx0TGdRenE3RWZicWcwN0twWXk1aUUrc052bGROdWpGVDZxWmVGY24r?=
 =?utf-8?B?eU1ZUVRWdVpNNFhRQUs1dXQ0L0piSjhxbEhRWlJ0VlRmMU5XdEM5MFhTQmVS?=
 =?utf-8?B?V1VPblJpenhsV0ZJUmFSTXFRNnIxUGY5ajkxTGEzbzVubTRucW9pdTQxME5J?=
 =?utf-8?B?SWMxc0xrb0FQZDNsTll5cDNFNk1JVE1LUnBVZjI1b25ZRHNGTDljRTdCOXR2?=
 =?utf-8?B?ZHRyQzNBOStYMkJaZGxQU0I4cXArWHFYNUgzSnRKc1JVNHdFVXJwM1lFMnc2?=
 =?utf-8?B?WlVrdjdTU2pzWjVvamJteEhFME8xVDFoVGRoRnZPT3h3amRiU2VPWXBFTDZ1?=
 =?utf-8?B?ekc5Qkl6MTVpZ3k0bVVXV3Azd0luYjFaQ2l6UWNpM1V0dlJ0akpFeGd1Mlpj?=
 =?utf-8?B?MW93L3R6N0ZBRERoM3A2OXZYWmcwSkkrRjIwWFpod1h0Rk1MWU5JenJVRC9q?=
 =?utf-8?B?ZHBKdlloWlFtaWxObkZ5VU5iRkI4YzRBVFhOMXRkbTJES1pMYnZ2d0p2MzVl?=
 =?utf-8?B?WWthOWp2c0dlUFluVCtTOHZuZitxZHpPMytsalladDFtdjNSNmFKTityd0pX?=
 =?utf-8?B?Q2s0NG1CSXpUalExak96SitnQk4yMnlpNzFvVFFNQUNVUDZGN3VxYXVKTWp1?=
 =?utf-8?B?c0ZXN2twTmZOZTYzZks0SmVIL1JPaWFKLzZkZmhwQ0xuZHl5eis3Z0EwYk9Q?=
 =?utf-8?B?OVU2WnE4eUdkSUoyT3dNcGhEMDRaakJSVTVNY05zb2ViNGJndFlKVDlidHAx?=
 =?utf-8?B?MXNVUjJsaWVhaTJmVFFtazRsZFJzSDR5RThReEU4bkxxeUNXNEUzZldPZEM1?=
 =?utf-8?B?UGZvb3VKVDNzT1diamlzdGtQQ2NPS3FRWTc3MzRNeEFBVC9FVzF2UlFCUDIr?=
 =?utf-8?B?UE92b05yOU1OeHg1YUZ6cXIwMXdVck84dVBKVVhGMzFkMWlDOGlSMzZPUE9w?=
 =?utf-8?B?N3FIQkRHUXFCRG54d2JSVnVHWEJWOG1tUWJLV0pidGVBK0VXTWd5eGlac3lW?=
 =?utf-8?B?UWo2RS9acWljY28zK2tpSFFQUFJLaEEvTlRsZkZlNWIzL0h4QTdXUWRTdWpX?=
 =?utf-8?B?M1V2T2hFTEdNRUFuUjBlMWhJTGVQWThwczZqZklINUJ4LzZhT01xcXF1N2ll?=
 =?utf-8?B?YkhZbVNJay9qRWJYeldSelozaWJ2N1FxMk56V3RzTFc2M0hRM2t5SEQxWUls?=
 =?utf-8?B?ZHR0MFMvb0lxWU9kZEExZldscUhHTkVERkVqa2hpUXhZN1lodzVVN1ZyVSt2?=
 =?utf-8?B?SW9DUlNGVGQzUVpCL3dYWFdKRG5wZWwyaFJqWFd3cXo0WUd0SnRFUkVUZTB5?=
 =?utf-8?B?SUlDZWFNS2ExZXdjM3g0UEM1MmIrU2FockdhUGtGTDUvZUZSS1ZFYThtd1FZ?=
 =?utf-8?B?NTZWK1FaMEVRWG4waGpOTWlaeTd2bGV4aFF4YjRuaFJCZXNjNVVPVXp6T1Fj?=
 =?utf-8?B?aHQvcDMxRHEvZWpvWThuY2NDMjNEWTF3OXBWczRma1ZuTkdNc3FZb0tRUjVI?=
 =?utf-8?B?MDJRUzRVdW4reUgwdEwwbmt1dk12eThMeVdDa0ZmdXRqOXJxRU1XRFhNbUwy?=
 =?utf-8?B?b3AzZzBaS1c1YUQ2TXdtc3lwQk9NUHgxMWR2SmhUWnZiOSs5ZDAwK3VRN0h3?=
 =?utf-8?B?NzJSUkdvV3hTNm1vQ3FObW9mY1V3RmI1Wk9vektIQ283b0dLOFN0Vm1JVXVB?=
 =?utf-8?B?Q3JQeDI0KytOT0h4YlJxQlI0Ly9qMW04VS9ycFU1QWc0ejZYYzlUcG55ZTlw?=
 =?utf-8?B?QlNueDM5bC9LSnFoc0NEQWszdWRnRnFMajhOckFScHlieTMxUEN1V0ZEN21u?=
 =?utf-8?B?MlNEUEFmTDhRbkxjOCtuM2ZjWmNEU2I2c0l2UGFvYnpVeEc0bkxEK0tXMHNL?=
 =?utf-8?B?RG9sUUVvWCtTTUY3Rm5zWVV4WkFObjBZVXVtSkFDcjdwMVhtNlVOZWx4S3p4?=
 =?utf-8?B?MFJmWENHK1hZdlR3d2pGV2VCNktveHl1MTFGdFo3WG9XOWtiaHB1Mll5Sm85?=
 =?utf-8?Q?X5cUaAQxSt5Pv3PJIF7jksTqB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b865c2ce-7838-4748-3071-08dd937fc2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 07:11:49.3931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMvLszwkxH3gb8pswUsYVsAidxbGVGvY4lFuUD+jo9KnnIoelIElV2PFjY0gIQgblxpPJee9p9R+m1g8ai/cepB+/f5YnJGxesbM0HHdaCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF1BDA05984
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+ID4gPg0KPiA+ID4+IFRoZSBTR19MSVNUX0FERFJfTUFTSyBuZWVkcyBh
biB1cGRhdGUgdGhvdWdoLiBBRkFJQ1QsIGl0J3MgYmlnZ2VyDQo+ID4gPj4gb24gQVNUMjcwMC4N
Cj4gPiA+DQo+ID4gPiBUaGUgdmFsdWUgb2YgU0dfTElTVF9BRERSX01BU0sgd2FzIHdyb25nIGZv
ciBBU1QyNzAwLCBBU1QyNjAwIGFuZA0KPiA+IEFTVDEwMzAuDQo+ID4gPiBUaGUgY29ycmVjdCB2
YWx1ZSBzaG91bGQgYmUgMHg3RkZGRkZGOC4NCj4gPiA+IFdpbGwgY3JlYXRlIGEgbmV3IHBhdGNo
IHRvIGZpeCBpdC4NCj4gPiA+IFBsZWFzZSBzZWUgcGF0Y2ggNCBjb21tZW50cy4NCj4gPiA+IEJ5
IHRoZSB3YXksIEFTVDI1MDAgZG8gbm90IHN1cHBvcnQgU0cgbW9kZS4NCj4gPg0KPiA+IFNob3Vs
ZCB3ZSBpbnRyb2R1Y2UgYSBjbGFzcyBhdHRyaWJ1dGUgdGhlbiA/DQo+ID4NCj4gQ2FuIEkgbW9k
aWZ5IFNHX0xJU1RfQUREUl9NQVNLIGRpcmVjdGx5Pw0KPiANCj4gSW4gdGhpcyBtb2RlbCwgaGFz
aF9tYXNrIGlzIHNldCB0byAweDAwMDAwM2ZmIGZvciBBU1QyNTAwLCB3aGljaCBkaXNhYmxlcw0K
PiBzdXBwb3J0IGZvciBTRyBtb2RlIGFuZCBTSEE1MTI6DQo+IEFzIGEgcmVzdWx0LCB0aGUgbW9k
ZWwgZG9lcyBub3QgaGFuZGxlIFNHIG1vZGUgZm9yIEFTVDI1MDAuDQo+IA0KPiBodHRwczovL2dp
dGh1Yi5jb20vcWVtdS9xZW11L2Jsb2IvbWFzdGVyL2h3L21pc2MvYXNwZWVkX2hhY2UuYyNMNTI5
DQo+IGFoYy0+aGFzaF9tYXNrID0gMHgwMDAwMDNmZjsgLyogTm8gU0cgb3IgU0hBNTEyIG1vZGVz
ICovDQo+IA0KDQpJIHdvdWxkIGxpa2UgdG8gY29ycmVjdCBteSBwcmV2aW91cyBpbnZlc3RpZ2F0
aW9uLg0KDQpBY2NvcmRpbmcgdG8gdGhlIGRhdGFzaGVldCwgdGhlIHNvdXJjZSBidWZmZXIgYWRk
cmVzcyBsaXN0IG11c3QgYmUgOC1ieXRlIGFsaWduZWQuIFRoZXJlZm9yZSwgdGhlIGRlZmluaXRp
b24gb2YgSEFDRTIwIHNob3VsZCBiZSBhcyBmb2xsb3dzOg0KQml0IDMxOiBSZXNlcnZlZCAwDQpC
aXQgMzA6MyBiYXNlIGFkZHJlc3Mgb2Ygc2cgbGlzdA0KQml0IDI6MCBSZXNlcnZlZCAwDQoNCklu
IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIFNHIG1vZGUsIHRoZSAibG9jYWwgc3JjIiB2
YXJpYWJsZSByZXByZXNlbnRzIHRoZSBidWZmZXIgYWRkcmVzcywgYW5kIGVhY2ggc2NhdHRlci1n
YXRoZXIgZW50cnkgaGFzIGEgc2l6ZSBvZiA4IGJ5dGVzIChTR19MSVNUX0VOVFJZX1NJWkUpLg0K
QXMgYSByZXN1bHQsIHdlIG9ubHkgbmVlZCB0byBlbnN1cmUgdGhhdCB0aGUgImxvY2FsIHNyYyB2
YXJpYWJsZSBpdHNlbGYgaXMgOC1ieXRlIGFsaWduZWQiLg0KVGhlIGFjdHVhbCBidWZmZXIgYWRk
cmVzc2VzIHJlZmVyZW5jZWQgYnkgdGhlIFNHIGxpc3QgZW50cmllcyBkbyBub3QgbmVlZCB0byBi
ZSA4LWJ5dGUgYWxpZ25lZC4NCg0KYGBgDQpzcmMgPSBzLT5yZWdzW1JfSEFTSF9TUkNdICsgKGkg
KiBTR19MSVNUX0VOVFJZX1NJWkUpOw0KYGBgDQoNCldlIG9ubHkgbmVlZCB0byBlbnN1cmUgdGhh
dCB0aGUgc3RhcnRpbmcgc3JjIGFkZHJlc3MgaXMgYWxpZ25lZCB0byA4IGJ5dGVzLg0KDQpgYGAN
CiAgbGVuID0gYWRkcmVzc19zcGFjZV9sZGxfbGUoJnMtPmRyYW1fYXMsIHNyYywNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIE5V
TEwpOw0KDQogICBhZGRyID0gYWRkcmVzc19zcGFjZV9sZGxfbGUoJnMtPmRyYW1fYXMsIHNyYyAr
IFNHX0xJU1RfTEVOX1NJWkUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTUVNVFhBVFRSU19VTlNQRUNJRklFRCwgTlVMTCk7DQogICBhZGRyICY9IFNHX0xJU1RfQURE
Ul9NQVNLOw0KYGBgDQoNClRoZSBsb2NhbCBhZGRyIHZhcmlhYmxlIHJlcHJlc2VudHMgdGhlIGJ1
ZmZlciBhZGRyZXNzIGFuZCBkb2VzIG5vdCBuZWVkIHRvIGJlIDgtYnl0ZSBhbGlnbmVkLg0KSSB0
cmllZCByZW1vdmluZyB0aGlzIGxpbmUoYWRkciAmPSBTR19MSVNUX0FERFJfTUFTSyksIGJ1dCBl
bmNvdW50ZXJlZCBhIGZhaWx1cmUgaW4gdGhlIEFTVDI2MDAgdGVzdC4NClRoaXMgaXMgYmVjYXVz
ZSB0aGUgQVNUMjYwMCBEUkFNIGJhc2UgYWRkcmVzcyBpcyAweDgwMDAwMDAwLCBhbmQgdGhlIG9y
aWdpbmFsIGNvZGUgYXBwbGllcyAiYWRkciAmIDB4N0ZGRkZGRkYiIHRvIGNvbnZlcnQgdGhlIGJ1
ZmZlciBhZGRyZXNzIHRvIDB4MCwgd2hpY2ggY29ycmVzcG9uZHMgdG8gdGhlDQoiRFJBTSBvZmZz
ZXQgMCIuIEluIHRoaXMgY2FzZSwgdGhlcmUgaXMgbm8gbmVlZCB0byBwZXJmb3JtIChhZGRyIC0g
MHg4MDAwMDAwMCkgdG8gY29tcHV0ZSB0aGUgRFJBTSBvZmZzZXQgb24gQVNUMjYwMC4gDQoNCkFz
IGEgcmVzdWx0LCBJIHdpbGwgbm90IG1vZGlmeSBTR19MSVNUX0FERFJfTUFTSyBpbiB0aGlzIHBh
dGNoLg0KSWYgeW91IHN0aWxsIHdpc2ggdG8gaW1wcm92ZSB0aGlzIHBhcnQsIEkgY2FuIGNyZWF0
ZSBhIHNlcGFyYXRlIHBhdGNoIHNlcmllcyB0byBhZGRyZXNzIGl0LCBzaW5jZSB0aGUgY3VycmVu
dCBwYXRjaCBzZXQgaGFzIGFscmVhZHkgYmVjb21lIHF1aXRlIGxhcmdlICgyOSBwYXRjaGVzIHdp
bGwgYmUgcmUtc2VudCBpbiB2MykuDQoNClRoYW5rcy1KYW1pbg0KDQo+IFRoYW5rcy1KYW1pbg0K
PiA+IFRoYW5rcywNCj4gPg0KPiA+IEMuDQo=

