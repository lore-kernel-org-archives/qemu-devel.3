Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C9FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 01:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u72cI-0007j7-0C; Mon, 21 Apr 2025 21:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u72cG-0007iu-OV; Mon, 21 Apr 2025 21:40:04 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u72cB-0002ER-NG; Mon, 21 Apr 2025 21:40:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFBS61cb7uGfk4L+EkbK7xbjk+QTRm2P82yF2zRJdbkVouyKu0w97/yvamomg/ei4WGkDDNbxWooiK+sj+LxXw5zg/zqMA3W+TM647G9G4yjn+5Ymg0qp/vsf8TPVg6jMzuiT12uqvO4ji+x5H+ANzjY9nDIYGSz8LWHmvMQz4THn0JW/pUq4uY6VWLFEy9txS7lxeLtT3dgVqGMB4LSfjWY3gcmN6c9WmLd36G+RWHdtc2DHTrZJFmtkriq5PnHPv1mtY6n27CSDHrMT97KKvvYlwv9kiabIbBRjGdDNsKnX9fhMuEOePrqNVpNOfRYTgCnsM6BdVEx/d9t+W+/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG1HYngQLYzP/vX/5VBQFUQOq2a6XVX8K5K1VpCwuMk=;
 b=dZm3Sg2Ayaibig8txhX8OJ49/ZzKfOFTSwZJcx939QkPjHCtQfogEJPcjD87jimlomgjBIy+8m3gNt594ApCKvgvoARPBworeh6PURvMJs29h4kQD9U301URmsoAtqGNTZZ11sQeUnZWICA54LuJGgi/Jv7aKnHkKLRfygJEWinNVsMr9zB6xVngknDU4kSpBnbclF78w7UxuDwEBN/758JJtoOnC8jY3cua38leyIj/hnqYOu+Kgy2I3pB0BXrkNEGxqJn8btn9AjoKVMWh6jvbz+s6BrJRPPqlLBIE176OU7ZRBwju7mtqin+DofJk8hB9sieS3++SVoivp5RcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG1HYngQLYzP/vX/5VBQFUQOq2a6XVX8K5K1VpCwuMk=;
 b=mvD/LaoveqIga5R7yc3oYKytn+e5qBcrYjT6vdS8GpX3jfjLNSApv+1rQTXWnYjVr7BDv3IoI7wrgYKAHafnwH5rDRQ27PQik0HLkG1nv8ZuLlkZKx0kisIiJXw+a6/MR/t1n1qKOgMBQq3oM9DwTUjkHdImf/QzGbFikuZrnvV9Jt7/TBmlj+P2c5cyJnX7TYEEZPTmLVa8TfSZQwG7SzZ/Me8yIsL+DFJxfxucSZvMd5Wkr9nMgMXLzMQAop2ZrNr+52PkrLXMD/ZNEQ0HJ5PsETJeVr1odYjHlzzGGJnjPxA8Aux/GvWMa/SRjic9gZmv5iq5tc8wGM5uwnxINg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5610.apcprd06.prod.outlook.com (2603:1096:400:328::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.33; Tue, 22 Apr 2025 01:39:47 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 01:39:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 02/10] hw/arm/aspeed_ast27x0 Introduce vbootrom memory
 region
Thread-Topic: [PATCH v4 02/10] hw/arm/aspeed_ast27x0 Introduce vbootrom memory
 region
Thread-Index: AQHbr0ao2YGz73xecE2tvN8MD/lK+7Ouov4AgABNJ4A=
Date: Tue, 22 Apr 2025 01:39:47 +0000
Message-ID: <SI2PR06MB5041805F17297DDD4AAB0964FCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-3-jamin_lin@aspeedtech.com>
 <615f85af-aeb8-44b3-b6de-ed248b61e9f4@kaod.org>
In-Reply-To: <615f85af-aeb8-44b3-b6de-ed248b61e9f4@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5610:EE_
x-ms-office365-filtering-correlation-id: d2384318-1fbb-4066-04a7-08dd813e90dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Uk9hRCtlb2FwRVIvNzB5N0Z3UnpwT3lPU3lnQ05VeXdOQVgwbDJjNFhYNWsx?=
 =?utf-8?B?TWkxN1ZNb0Rqb29DdFNzUVJ1bWw5T0FyWnJrQVlvTnVGdm9xajh4TjBVbWRS?=
 =?utf-8?B?ZjE2VUI1cmNyeHEraExRdjZRQlFlS2FiNzRhRUJSMXBzN1lNd1l5OFNIRUlP?=
 =?utf-8?B?N2tMWTJrb2Eza2gvRFRSNU9hRVErSGNMQ3dpRmh4SXB0L1d2ZmtqdWN2TUVx?=
 =?utf-8?B?RXJGY0Fsb2krbGEycjlKd3pOOE1LandIcVlJd0d4NkFDN0dJenFtNGJ4Ny83?=
 =?utf-8?B?SkVKc1BnUnB0TW5jOW4wN1VTUFJIYWZ4N3pxYWhnMi9mV3I3c1ZzeEdFMFhN?=
 =?utf-8?B?TFVkdEx3WjM5bncvNnVWRGpiQU53TmgxenZZZUNaeG1nL2tDWjU1RzhueVBx?=
 =?utf-8?B?bU1SRHJ1UW5SR2VpckNSTTgvemM2ZXM5bTJhRUVLU2lSeDJTUVJZTjdPZDJi?=
 =?utf-8?B?VnNvYWlJV3dJU2dZdFUzL3YrV01UMFJNOEZ2ZG1JckJjUFlCSC84SEtILzd0?=
 =?utf-8?B?eXZ3a3ovK1loUHpBdkthQ2xHNi9INXdXN1VOVlQzR3R5Y2hpaDh4aVJrUWV4?=
 =?utf-8?B?eExGNmdNdkpqUzMrSi9XSWFGNyt3cSsrczZDT0wxZldhTWs0WEJRNzU2ZXdQ?=
 =?utf-8?B?aVVMUDlQbGVtNjN5UEV1TVlhdDB2TllRM3BvbjNkYjNGTENzbWVaN3YyK2l5?=
 =?utf-8?B?Zmk4d3NTeXRnaDB1RHNETDF5TUtVeExpcHpKVFNMU3I4bnJMUHhOdHFBZzdQ?=
 =?utf-8?B?VUxocDUzcGd5NTYyQ2N6R0JwOE5LMVV4NTBzOUg5OFB3UGluU2xrZkhOeWFt?=
 =?utf-8?B?ajNCeUllVTIyb2hWakp4Y1poMldqK0dDa0tyNGNXU0JvQnZHQU9UOFBLMFU3?=
 =?utf-8?B?YkhwSFJwUVlPanNzWDg3aXlkNENEOTFVMm5YL0liY1NudmYycnY2dS9WSHdi?=
 =?utf-8?B?dDhLbWJQT053UmM1bGdQb3FTSVQ1L0hVYWNhL0hvNWZkMEV4ZVYybWFlRkVX?=
 =?utf-8?B?N29ocFRqNithZTFEb1hoQmw3Tk5tYnRjNDJsT2RkbXZSb1RlWlVqc1k3TkZW?=
 =?utf-8?B?T3hKaXRYOGhHTk1LcVpkWlhNNHBLSnExcWs5OTJ6UEx3aS83a2lOWFFvVDlI?=
 =?utf-8?B?MGovb0l4ZkV6bzIyVzJ3OXJPZExmWXQrUXhTbDVMTHkrbnZxOHBtZWhHMzhJ?=
 =?utf-8?B?TTdXMnBnelRSb1RKdVUwVVdBQ0hId1NMSW1QMWgraTFJRm5NUUxBdkJ4d3Bs?=
 =?utf-8?B?TXZrdk4vWHhkTVF2UkxzcnJZY3J4TEZpRXNaSzhxTlV4T1FHT3Z2RFErNnNo?=
 =?utf-8?B?SHlmZ3cxckJKNXA2Yi9mbFBOV3JtbTlFOUQxajEwZ05BN2MrWmRlU25MY0t2?=
 =?utf-8?B?d2Exck96cVJxYUY1QStERDNzUVlWQXRlcXJ4bGsxMTNMdjN1NmxoeERwZ2da?=
 =?utf-8?B?VVAwMml3YzlnZC9RTnFsWmxoUjlxbmVvYndlU1h4T1B5WXpFbjhRdFpkeXJX?=
 =?utf-8?B?T2NtdDFsUUtZcVVFM2xwK1J5ZjRCRG94UGFxU2NFUDU0dkZqcllTcWRKMG9u?=
 =?utf-8?B?aGhabmFQWDM4eVdpTnAxUDNIcVAxbXJlbTBKZ3pML0ZYQkp2M01yTU1McGJS?=
 =?utf-8?B?VHE2a1BEK1EvYkZDcktjNE9HUHk0aTNxUEVSRVJDV2RXa2E3blRMcmR6M2ox?=
 =?utf-8?B?U0xCRzVnUlJOc0Y0ZGFkK21RVit6U0V0TTdybEpxOFdaN1FCMmIxdk1jdzVP?=
 =?utf-8?B?RGI3TDlhTi9nSmtlWnZJK1pqWHZDcGhhYkdBSVRqaWduT20zbkQ2aXQ5cTBB?=
 =?utf-8?B?b3djQm9wRUxmSDF3SlB1UWxSQ2lyT21GR2hmZVNSeENSNUFpL2k0RWxUUk9w?=
 =?utf-8?B?K0JSaGV3M25sR1Vmdk5SdjJuZHJYRkNZMkI2L0Y0WlRCMUFTb0VWU3RSVSt0?=
 =?utf-8?B?aDd1MTRQRkx2Q2F0MDg5OW4zTURoRE9WSlF3aFdvK1FudVlQMU1NWHgrM213?=
 =?utf-8?B?Ri9BVk5rZEF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q29zSVdoejgzY1R6cVQ0SG13YjcxeVVjWXUzQXNNTGlHSkdQby81WWdUcDQy?=
 =?utf-8?B?OGNkTE10TzFYVnRlNTdBcVk2K2JxT0RtUEttZE9ZbHJLMGFJZk5KdFc5Qk11?=
 =?utf-8?B?VkZFcCtZc3lRcFRvWjFKR3l5SGM4YW85S1gzdDJMcUhmM2R0Z2pHeEZXQ1hH?=
 =?utf-8?B?bzBzWGFUdUFOSCtZOE5oQWZxcmJQTmtVNzZTa0V1d2JHd0ErUXVtdDFjbjJE?=
 =?utf-8?B?bUd3YVNPd2NFZU4xT05YM3JVT3VVQ3hOdXFEVnZlRFpWOUtkbGdEcjZjYU13?=
 =?utf-8?B?OXd3aWtVQTJqUDRXY0FIYVhDYnFyQ1NaVmViY1dUb0YvVXk4WjhOU3lHUlNG?=
 =?utf-8?B?WFIxeEpXNVVHZXhUNFFlL2tsNGx5dHd5QitkN2gycWZzSUlNa0ZKMzF4MDNv?=
 =?utf-8?B?L2x2K1RtZEs3R1VmVzBMWjRJVHJ4R0llQjhnR2lVRVZscFhSbjNhRTZRc3NE?=
 =?utf-8?B?YzRrOHdYd3N3RldZOTk2Vld1cVRkWnFReVhYb2owcER5N0RLNk03akpQamFG?=
 =?utf-8?B?SkFBUklEa0hRNi82L2kyaDVXWWp5Z0FXRVFvOUY1UWNodUhMakNzbmJYa2Rs?=
 =?utf-8?B?VXdmSVFmOFJIbW5adzA5eUpSeEY4cTVENFpuYXVqVHowNGYweWF4R1JWdzRJ?=
 =?utf-8?B?NHVVY2x3SEM1OG9vYzVYc2ZacEhNSzBTSkpqWG1hU21CaVNYczQ3ZnA5VUpn?=
 =?utf-8?B?cDFpUWJoR0Q2RWJHcWtYampZTm0vRlJvcVpxNm5zeTBvWFFrMjZGU1M4WkZK?=
 =?utf-8?B?czFrVmRYSVVxT1pJS0RuaFdraStkVG1rSzF0Wk1CSENSdWgvd2RTUnQ4UVo5?=
 =?utf-8?B?bW5yUW9nQlhNY21ZaDQwSnloS01yRE9XR0hxRFNxWE5FbjFxY2RQTE15YVc1?=
 =?utf-8?B?UVE3Z0NGdDFTZXZyS3dYTnJQV2tubzVZK0lkMU5MeGpHUGVGcXRCS21rMnF6?=
 =?utf-8?B?a0dtOVhCalhLeHZBVVg3VnFMYjFnb21IeGU0YUY0OEt5MG4vWmhLekMyZUxs?=
 =?utf-8?B?RTFtb2lEMk82cW95cEFqUGtXOG5veFdTbUJtYzN1cFhvTkdqalFDNzNoaGdW?=
 =?utf-8?B?cGFWTWlQRXpTRkpNbzh1N05iUHpYeFR4dWM3QUFGaEZydlMrOVIwbnNlMWhW?=
 =?utf-8?B?NVByUzc4SzRwMGJ3a3liWUpUUVRkY1ZPN1ZYUWVFcmtmM29kLzdna1FQRzlB?=
 =?utf-8?B?YkNaQUtWaTFwbG8rOHZ1NXplTkg4TkpJd0pqNzVVQ1FuNDZVZE1PZXl4ZGt4?=
 =?utf-8?B?aHpEUmtZU1NqZUNYbEliZjNIa1ZvNFV4Yk5Rc0xDejRjajZobS9DazJvR2FR?=
 =?utf-8?B?b25HSm1GUy9VeGpGTEtzUGNENTNIUGMzMVRkalptVVM1b2VOSEpydW8ra01I?=
 =?utf-8?B?dkpCbFJnSkhiSnpTZFQweDVRL2hGNjVKZGhuSEJKRjlTZDVsTUNzcEQ5NnR0?=
 =?utf-8?B?a2M2VW9WMXFmZExXRUtaSUtLQ1hKZzU0ZFY3S0IzWlZFQXdZVG8xd3pTUFpv?=
 =?utf-8?B?MjVLTHBWOTZST3lsZExFY05QUDlndzNnVUJpdFJMT0t2ei94NEc4OUo5aWR1?=
 =?utf-8?B?Y1JyWDV4ZlBaZzFtaG1tbjZRZTRkWkltQXZBcmEyT0NjOHdZc2dQVVptZVFQ?=
 =?utf-8?B?QTJ2SFlhUjlqNWkrMzNJSDl2M3pOR1dKS3g2cDJPTjBNYW1BMG4rcnB1Sm54?=
 =?utf-8?B?b2F3TE5lM3NzbEN3Z2p0YVJHR29UczQvQlMwRk0vQjhJZUlOU1N1RGpCMzlI?=
 =?utf-8?B?a29ZVmJOWGR2UXVPU1dXczBzbWtQdmRPbEhRT1ovV2dHdjlVa1h1VjFjUWcw?=
 =?utf-8?B?VkQzMFplZnlQSVVldnJMMmd0d0hqUWh3TldEcGl3em5lVXkxUG1OQ0FER3ZT?=
 =?utf-8?B?cHZHQ24xbGwvcmdXbWkvSEtQelJEMjZNSzUxV1lBUjBZNEdLektoN2hidlRl?=
 =?utf-8?B?dERDc2NtbHVZRENacVlBVFV6NXBWVFRnZmkwVWlOQkxjVndsNW1sUm4wem1q?=
 =?utf-8?B?K0VvZ0VlZ3FzR0dtNU9GQ0FwRGxCWGVvZjNEQkhUeUZ1cy90T1dpa2J4L1BS?=
 =?utf-8?B?QUtvTVVIdEk4UElHNHZaaDRReXZRdXBxRjY0ZjMwMDlFY2JvWmV3WUszVUZs?=
 =?utf-8?Q?jGO03X+Qfel0YGjQVcmwQn867?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2384318-1fbb-4066-04a7-08dd813e90dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 01:39:47.4812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnbimVOO8ZT1jj2HZvQ2WW6a5ElmHrFyVpRmUlpwy45p5oiUcCsFXNwRvx3kMcEmYMqM5PcB4onBkMb4gtTnuYRGKbpVIZja8WmsRuO36K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5610
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsg
bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMi8xMF0g
aHcvYXJtL2FzcGVlZF9hc3QyN3gwIEludHJvZHVjZSB2Ym9vdHJvbQ0KPiBtZW1vcnkgcmVnaW9u
DQo+IA0KPiBPbiA0LzE3LzI1IDA1OjExLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW50cm9kdWNl
IGEgbmV3IHZib290cm9tIG1lbW9yeSByZWdpb24uIFRoZSByZWdpb24gaXMgbWFwcGVkIGF0DQo+
ID4gYWRkcmVzcyAiMHgwMDAwMDAwMCIgYW5kIGhhcyBhIHNpemUgb2YgMTI4S0IsIGlkZW50aWNh
bCB0byB0aGUgU1JBTSByZWdpb24NCj4gc2l6ZS4NCj4gPiBUaGlzIG1lbW9yeSByZWdpb24gaXMg
aW50ZW5kZWQgZm9yIGxvYWRpbmcgYSB2Ym9vdHJvbSBpbWFnZSBmaWxlIGFzDQo+ID4gcGFydCBv
ZiB0aGUgYm9vdCBwcm9jZXNzLg0KPiA+DQo+ID4gVGhlIHZib290cm9tIHJlZ2lzdGVyZWQgaW4g
dGhlIFNvQydzIGFkZHJlc3Mgc3BhY2UgdXNpbmcgdGhlDQo+ID4gQVNQRUVEX0RFVl9WQk9PVFJP
TSBpbmRleC4NCj4gPg0KPiA+IEludHJvZHVjZWQgYSAidmJvb3Ryb21fc2l6ZSIgYXR0cmlidXRl
IGluICJBc3BlZWRTb0NDbGFzcyIgdG8gZGVmaW5lDQo+ID4gdmlydHVhbCBib290IFJPTSBzaXpl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVj
aC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29n
bGUuY29tPg0KPiA+IFRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2ds
ZS5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggfCAgMyAr
KysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICB8IDEyICsrKysrKysrKysrKw0K
PiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVk
X3NvYy5oDQo+ID4gaW5kZXggZjA2OWQxN2QxNi4uOWFmOGNmYmMzZSAxMDA2NDQNCj4gPiAtLS0g
YS9pbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2FybS9h
c3BlZWRfc29jLmgNCj4gPiBAQCAtNTksNiArNTksNyBAQCBzdHJ1Y3QgQXNwZWVkU29DU3RhdGUg
ew0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBzcmFtOw0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBz
cGlfYm9vdF9jb250YWluZXI7DQo+ID4gICAgICAgTWVtb3J5UmVnaW9uIHNwaV9ib290Ow0KPiA+
ICsgICAgTWVtb3J5UmVnaW9uIHZib290cm9tOw0KPiA+ICAgICAgIEFkZHJlc3NTcGFjZSBkcmFt
X2FzOw0KPiA+ICAgICAgIEFzcGVlZFJ0Y1N0YXRlIHJ0YzsNCj4gPiAgICAgICBBc3BlZWRUaW1l
ckN0cmxTdGF0ZSB0aW1lcmN0cmw7DQo+ID4gQEAgLTE1Miw2ICsxNTMsNyBAQCBzdHJ1Y3QgQXNw
ZWVkU29DQ2xhc3Mgew0KPiA+ICAgICAgIGNvbnN0IGNoYXIgKiBjb25zdCAqdmFsaWRfY3B1X3R5
cGVzOw0KPiA+ICAgICAgIHVpbnQzMl90IHNpbGljb25fcmV2Ow0KPiA+ICAgICAgIHVpbnQ2NF90
IHNyYW1fc2l6ZTsNCj4gPiArICAgIHVpbnQ2NF90IHZib290cm9tX3NpemU7DQo+ID4gICAgICAg
dWludDY0X3Qgc2Vjc3JhbV9zaXplOw0KPiA+ICAgICAgIGludCBzcGlzX251bTsNCj4gPiAgICAg
ICBpbnQgZWhjaXNfbnVtOw0KPiA+IEBAIC0xNjksNiArMTcxLDcgQEAgc3RydWN0IEFzcGVlZFNv
Q0NsYXNzIHsNCj4gPiAgIGNvbnN0IGNoYXIgKmFzcGVlZF9zb2NfY3B1X3R5cGUoQXNwZWVkU29D
Q2xhc3MgKnNjKTsNCj4gPg0KPiA+ICAgZW51bSB7DQo+ID4gKyAgICBBU1BFRURfREVWX1ZCT09U
Uk9NLA0KPiA+ICAgICAgIEFTUEVFRF9ERVZfU1BJX0JPT1QsDQo+ID4gICAgICAgQVNQRUVEX0RF
Vl9JT01FTSwNCj4gPiAgICAgICBBU1BFRURfREVWX1VBUlQwLA0KPiA+IGRpZmYgLS1naXQgYS9o
dy9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGluZGV4DQo+
ID4gYjA1ZWQ3NWZmNC4uN2VlY2U4ZTI4NiAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVk
X2FzdDI3eDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gQEAgLTI0
LDYgKzI0LDcgQEANCj4gPiAgICNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiA+DQo+ID4gICBzdGF0
aWMgY29uc3QgaHdhZGRyIGFzcGVlZF9zb2NfYXN0MjcwMF9tZW1tYXBbXSA9IHsNCj4gPiArICAg
IFtBU1BFRURfREVWX1ZCT09UUk9NXSAgPSAgMHgwMDAwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVE
X0RFVl9TUkFNXSAgICAgID0gIDB4MTAwMDAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfSEFD
RV0gICAgICA9ICAweDEyMDcwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0VNTUNdICAgICAg
PSAgMHgxMjA5MDAwMCwNCj4gPiBAQCAtNjU3LDYgKzY1OCwxNSBAQCBzdGF0aWMgdm9pZA0KPiBh
c3BlZWRfc29jX2FzdDI3MDBfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnAp
DQo+ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKHMtPm1lbW9yeSwNCj4gPg0K
PiBzYy0+bWVtbWFwW0FTUEVFRF9ERVZfU1JBTV0sDQo+ID4gJnMtPnNyYW0pOw0KPiA+DQo+ID4g
KyAgICAvKiBWQk9PVFJPTSAqLw0KPiA+ICsgICAgbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiYXNw
ZWVkLnZib290cm9tLiVkIiwNCj4gPiArIENQVSgmYS0+Y3B1WzBdKS0+Y3B1X2luZGV4KTsNCj4g
DQo+IGNhbid0IHdlIHNpbXBseSBuYW1lIHRoZSByZWdpb24gImFzcGVlZC52Ym9vdHJvbSIgb3Ig
ImFzcGVlZC52Ym9vdF9yb20iID8NCj4gDQpUaGFua3MgZm9yIHJldmlldy4NCldpbGwgZG8NCkph
bWluDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+ICsgICAgaWYgKCFt
ZW1vcnlfcmVnaW9uX2luaXRfcmFtKCZzLT52Ym9vdHJvbSwgT0JKRUNUKHMpLCBuYW1lLD4gKw0K
PiBzYy0+dmJvb3Ryb21fc2l6ZSwgZXJycCkpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4g
KyAgICB9DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24ocy0+bWVtb3J5LA0K
PiA+ICsNCj4gc2MtPm1lbW1hcFtBU1BFRURfREVWX1ZCT09UUk9NXSwNCj4gPiArICZzLT52Ym9v
dHJvbSk7DQo+ID4gKw0KPiA+ICAgICAgIC8qIFNDVSAqLw0KPiA+ICAgICAgIGlmICghc3lzYnVz
X3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPnNjdSksIGVycnApKSB7DQo+ID4gICAgICAgICAg
IHJldHVybjsNCj4gPiBAQCAtODk4LDYgKzkwOCw3IEBAIHN0YXRpYyB2b2lkDQo+ID4gYXNwZWVk
X3NvY19hc3QyNzAwYTBfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+
ID4NCj4gPiAgICAgICBzYy0+dmFsaWRfY3B1X3R5cGVzID0gdmFsaWRfY3B1X3R5cGVzOw0KPiA+
ICAgICAgIHNjLT5zaWxpY29uX3JldiAgPSBBU1QyNzAwX0EwX1NJTElDT05fUkVWOw0KPiA+ICsg
ICAgc2MtPnZib290cm9tX3NpemUgPSAweDIwMDAwOw0KPiA+ICAgICAgIHNjLT5zcmFtX3NpemUg
ICAgPSAweDIwMDAwOw0KPiA+ICAgICAgIHNjLT5zcGlzX251bSAgICAgPSAzOw0KPiA+ICAgICAg
IHNjLT53ZHRzX251bSAgICAgPSA4Ow0KPiA+IEBAIC05MjUsNiArOTM2LDcgQEAgc3RhdGljIHZv
aWQNCj4gPiBhc3BlZWRfc29jX2FzdDI3MDBhMV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywg
dm9pZCAqZGF0YSkNCj4gPg0KPiA+ICAgICAgIHNjLT52YWxpZF9jcHVfdHlwZXMgPSB2YWxpZF9j
cHVfdHlwZXM7DQo+ID4gICAgICAgc2MtPnNpbGljb25fcmV2ICA9IEFTVDI3MDBfQTFfU0lMSUNP
Tl9SRVY7DQo+ID4gKyAgICBzYy0+dmJvb3Ryb21fc2l6ZSA9IDB4MjAwMDA7DQo+ID4gICAgICAg
c2MtPnNyYW1fc2l6ZSAgICA9IDB4MjAwMDA7DQo+ID4gICAgICAgc2MtPnNwaXNfbnVtICAgICA9
IDM7DQo+ID4gICAgICAgc2MtPndkdHNfbnVtICAgICA9IDg7DQoNCg==

