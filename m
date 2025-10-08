Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D02FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 01:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6IcY-0005Yz-Pv; Tue, 07 Oct 2025 21:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6IcU-0005YV-Uz; Tue, 07 Oct 2025 21:05:31 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6IcK-0004wZ-Ex; Tue, 07 Oct 2025 21:05:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xL0r0EwDh73g4nkpa4T/7TKGePOPTScvZ0UgajVqJLs4Ho5yh5fDESOIQjchMe+K7Bxi3SvJd2eRPCMaE8l4zqMINyNbHruP/dcXQe2v7CL36iO8oVibgwtzrYMYkoURNqT098eg0h18BQLRvSvUs1sdwlJ1nSApcOsheMle6Ttfsjgy7iNHr5HbMJU5WFSft1RnBj7rc4JM5mhKKqmg83tKl+wRoqWQNjusUzqvL0pPRq2rAX3iJN5H2xciu6Z8TsInIGkq/mKnaSLIHf9W5tFciXv+RGUA8HOJe4JQdy9ZIe01gojLV78esCmX9/2+znMc89LwtYDc+/CImR5oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GdMx0XTiP2sRtYqxv8Cpst8sVp76sx+34ZSvdytY7I=;
 b=W5c1Br2uxHAWQ53rfbAatphyVdj+dQgU26ObvDe1VvpIUJpRJq20NQ1j7qz6Fj6Zwjx+SdYbmNvnwHswEUI/Pzlf8tYzrXFoWpKuoYKOCD9NGJrNzpU7LoOXhjxLRUW2BOoXF8W5PXsDQfqA8jmLnnpgiKC/1ZD6NGKs648yxuTW3wx2dKcfBel23uOS048C91Y3pGIV1Z+l9eq7fhsVm2FqcFQtV6U4HR86RPouukFuTJmv8bSqWw03K0XHtiC1GQz5+1MIVS0hBZpJhAXlh2Nj8qFScTt8KSMDD/JDbFApMC+PO/38XaGQSnRnHOeNorDnyLVA3t/Eiq+JaDPc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GdMx0XTiP2sRtYqxv8Cpst8sVp76sx+34ZSvdytY7I=;
 b=k8RiayX4uJejxpi1qRb3LnAIIn2CVsH8Ig3kRHR5p2zDDwW3x9HmAcC3AkuLOgcd5GlCNZezyeSFHIVmFubzjDL2sCLZ6828yR80p1y6bb8y/ve9SlIJqyjIge2hcthC/bhJP08J90F/8IMXMBBpLgrZ4+2+jfHFv5t65nDWxgvSmAgp70up91UjntWUX0yc4gSI6Zj4ron+J0mlpOcpGttou/PrEG9SclTrHNlf1rpII5VqLidrf+mL3Gy40A4q6EAxu1DRtXthcjqfbYbP2PKnlIDfHwyS9LOycR8zeWP5olIkR+yB0nsVZbfLOQT2izt8JGlRw6GDu5sunfhJuQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7063.apcprd06.prod.outlook.com (2603:1096:405:40::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Wed, 8 Oct 2025 01:05:00 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 01:05:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Thomas Huth
 <thuth@redhat.com>
Subject: RE: [PATCH 4/5] test/functional/aarch64: Remove test for the
 ast2700a0-evb machine
Thread-Topic: [PATCH 4/5] test/functional/aarch64: Remove test for the
 ast2700a0-evb machine
Thread-Index: AQHcN5UKqWRud9dd+kGg6M07kdSKZbS3b7Vg
Date: Wed, 8 Oct 2025 01:05:00 +0000
Message-ID: <SI2PR06MB5041DC12325C487C9C17564EFCE1A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20251007141604.761686-1-clg@redhat.com>
 <20251007141604.761686-5-clg@redhat.com>
In-Reply-To: <20251007141604.761686-5-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7063:EE_
x-ms-office365-filtering-correlation-id: 4f28d335-86f0-4ef3-38aa-08de0606b48c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TmNBVm1kYXlsWld1U0xaamQ5cUVpOWlnTHhMQUhHUjZrWm1wMGV0Yk5zNjJh?=
 =?utf-8?B?R01BeTJZcWpIT2NPeWNTamNuRFo1aUZxREdyN0owM21ETkFxMGNaRWh5YkIw?=
 =?utf-8?B?SVBNaVlHdHV4Q0gwSDR2ZEs5NnYzY1krRlplb29QTzNOcXJScWczdlJzQytr?=
 =?utf-8?B?cStKNDBSRm05Y21BUUh0ZUZlcENnRm5wakszeWptZXRyRmpZRkxxWEFtK2x5?=
 =?utf-8?B?d2hBVXNRZTZKQjlhdzZKcWY0ZHltd29CdThEbTN3UWJlUmpWdndXUmxoTFFV?=
 =?utf-8?B?K002MWlUclVuMlNNTjJpZm1oQjZFRzh0T29WOFZSWVVNM0I4YXJLYXdXdDRH?=
 =?utf-8?B?dTBneFd4WXNNYmo0Y2oySHFZdUFmeWZ4Q2VHakdsdDE3bTAwL0c2dXBUQndu?=
 =?utf-8?B?eTRMYk5KdUJCUGRkVlRobk1CU0liNXVkWWlaSU8xd1habUMyRWNaTldxd3JL?=
 =?utf-8?B?N240SFZiSUpSWDhWbUxWYTRyUmNsTTZoU3FVZlJwWGRYVTVyWHA3VThweW1P?=
 =?utf-8?B?eWpuTHJlQURFbDZMNDVZclZ6c0FITDkzZGozKzVKdFJtUGt2dXc4b21SZS9R?=
 =?utf-8?B?Wk83OTNHdC9acEtqZWlvYzhtYVJiRGR0VitKQy9nWGpQT3BqT3VpMm5xTTVy?=
 =?utf-8?B?aldacktpeUNIVzB6OU1qcVBmWVlwQ1pmS1FxZ28rM0U1dEF1bGdUVlZ2K1I3?=
 =?utf-8?B?TG9iMXJ5anR0ZXpzdzZKaGg1SHpTYkZZVnVlbE5xNmdXSlBiQ3AzRm5JbmNW?=
 =?utf-8?B?VTdxcG1JYm1jUXRWb3Q0R3MwTVVKays2T1k3Vkl6TUQ1WGMwaUx6YTJTT1RE?=
 =?utf-8?B?VnNKYzZHendwdkxIczFtZnRrYzJUd1ltN3dML1hUT0wzS1JUdlBvR2VFdDZD?=
 =?utf-8?B?YkkyMGtaSDZKTjBOVzFKRnVJVGhsVnpmVEhlZWp3Tmc2aG5YUjRUMHRNazN3?=
 =?utf-8?B?a1M1bUZCVUdjcFJ5WGdDSkhueEtkNERVeHNOdk5IQko0VmN5TjhieWdNUkFK?=
 =?utf-8?B?YVJpczY5RVVVbUhVVTUrcEF4a3M2K3hHSmdsQVU0VFpSU3YxL1lSSm9PdHpx?=
 =?utf-8?B?V01tM3NsMG1mc0VHemRkUlY4eFlLMGFyWUR1Mjdab1Q3TzhtSERYcFJ6dHZz?=
 =?utf-8?B?TXVOVlhQLzlwOWpiMytlaERwMGRpMndVdjhSQy93elp3Kzhmanl1REczVERJ?=
 =?utf-8?B?UFN0c3E1dDRXWWZveVhBd053a1NYZVBGcTRRWVRkdWtZUHgzM0o3ZE1hSFBY?=
 =?utf-8?B?WEN3Z1hKSkg2aW0yQU9ycHhTb29tbEI3emlmTWs5SzBhQVZhQlZEL0pyVG1L?=
 =?utf-8?B?dW13c1NDcEdaME5IS0ZzRVN2bHdQby9JRXJPcUs3WDkySXNpdUhIRWdqdzlv?=
 =?utf-8?B?Ty9FRHNVZ0VPSmJVT2tkUTJQWFNodTdKeVdpc1I1WUdyQUp3ZVRxczB1eHZ2?=
 =?utf-8?B?R2NGbDVwTHBwYlFRTXM5TUY0L2hkUUx0Qk9QS2kwUmdsQjNHempYMXRES2tr?=
 =?utf-8?B?a0ZPWVEvL1QvRDdVUTRoQU50TU1VS2lQRWhja3ByQlI2dGNCdXhWSTREZG9G?=
 =?utf-8?B?VWNuRU5oMmR6cVIvWHAxV2lNMHQzVUxtWHZlL09QWTJxaVY2Y0RuWFpLcGk0?=
 =?utf-8?B?Ylo2YTJXdDlobHpBY2R5TVVUM05aNzhSRlBUSVdJY3crbXRaRG44ZzBmWGJa?=
 =?utf-8?B?amx6QVplQjR2NHl3VmJxWjU5dVVhQTQ4a0d5c0xIck5OZ1RXT28ybXB3cUVD?=
 =?utf-8?B?MGtDNS96TkNNM0JpR0lYZU1UZ2VGOFptOFMrZ3ZqRi84aTZ1R3Y4a2V0SzZC?=
 =?utf-8?B?MHA5cjY3M1VEZWM5K2cxZVZOZ3hSZGd6bURrcFgvQ2lIL21lWklBSEVzM0hM?=
 =?utf-8?B?aE12L3k3YWY2RDloejBjbVV3RVg3eGdRQzNWU1hSYVRsY1pLamRxSmJmaFJa?=
 =?utf-8?B?R2h6UE13T2p2b2Juam9ycldyNVEwdmdaRGFGcy9oekxneWlxQ29tSHJneC9p?=
 =?utf-8?B?UnBUZTZTWmdiMTJlL0tsVi9pTzdRekd3K00wYXNMemU3SDZ0TEVORmQweFR0?=
 =?utf-8?B?dzdrRkVUbWFGT1g0Y3ZUenBxelhwZ3JBT0xhUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkFlcG1GUjJ5VEJ3cndrY1hwYllkNzhmK2NBb0ZJOVE0MnBzcWZzRGhUR2Fz?=
 =?utf-8?B?bTc5YmZCVlVRTTF3djd0SFRrR1ZMY0dkcWZObnFzZlovbHpTdzBRVG5rUEhl?=
 =?utf-8?B?OHFoODZKRlhKaFZsNi9Nb3BTZ2pOcjFNb1A3K3U0SmxIL0VPM0ttYmJVREFq?=
 =?utf-8?B?bHpwNEVoRFA1MW5BaVVSTzZwdkxRakVSclp0RmZoY2JBUnJ1R2VqZ05rUnY4?=
 =?utf-8?B?RGxIdThuNnozcktteFJUSWU2d0FHMWNOeG5QZjY2d3FlajlMNzZkeDRnMzFW?=
 =?utf-8?B?eVNETFIxNk52a21yOHhvNnhqZnkvYm9nSGZ6SlpxdGFZcnhHL2RBWFZ5OGJD?=
 =?utf-8?B?dWlpenZ1Q2VpaUtGL2tGRmh5ZDhld3c0Y0U1VjQyMENjMlA0NzNvMUxXMmpm?=
 =?utf-8?B?VGVZUW9PZjlpNnNpODBQMERtczVOQ2xjVmRXVk9ZSUwxdWdweVQ3WWNkY05o?=
 =?utf-8?B?bXBpZXUzMDl6MndhWGdic0NxbWJDRmZYeVY5YW0rNU1Ca2NUQ1FYcytSaklh?=
 =?utf-8?B?ZW1yREhDR0o3MnM3SUZtV2VDT2l0TGtiMXh5dHBYZEdac1FjVTJFbWJNZFZ0?=
 =?utf-8?B?MXlXL0JoQVZNdXhGTkU4N1JpVHR2V0p2RlI1c2lEUWtpeGZrTjZXWTVLc2x5?=
 =?utf-8?B?QXduOC9XSDAvRm1VNlZBWEt0a0dQU1JLZkJQSldCa2F5aXRDdDdFV3lkNG1s?=
 =?utf-8?B?dldTMlJSU0l3d1JYeVRUNG1yY0tnZzkwN01PQ29XOUdYVHF3dDVhcHhpaDdq?=
 =?utf-8?B?bnhJSC9xS1Y2bHhmRlcvM3VTZVpJR3J1VUI4dmhheTRYZWVuRDhlcTBvQ01G?=
 =?utf-8?B?T29CRmxOSG5qaDVZYXRNVzh2allRZDVZYzBBL3NyR0VBQkgvd2xXM0JjYkRp?=
 =?utf-8?B?cjBZckgzTkV6dldvdW9xd050TU9YK0U5THA3TDdIaThXN0tDc2xnQUJreVRy?=
 =?utf-8?B?akJFTzZVWFhMVWVKQWlhdFdta3FBbVdMWkRWSTRhdHBoMG5lcGU1ZFV0QUFs?=
 =?utf-8?B?VE9wYTVWeUJSdkR4bkxITlBjM3hFWjFWazY5KzU2bUwxdXErSEV3R2RzclN4?=
 =?utf-8?B?NDk3Ti9vNDlmRGNFUnA5Y2xGNHlVUmFkL0gydGNmQ1ZFN2dFckRVT3VIaDB5?=
 =?utf-8?B?RFB5dE1iaXR4em9wdHRPdHhwaXFrK2R1eDFBNUFKd0Rab1J3L2RCTnNVZjlQ?=
 =?utf-8?B?d2ZPU1Z5MS9NMHRybTNaeTJkYXZDRVpRRVdWK3N3ZzRndzlrSmpwTittSTdW?=
 =?utf-8?B?WkM4bkhDQjlwcjNMR3FqZUdhQVEwVkpYcmJJTUdGSmtVSzRJMGJtRS8rSElR?=
 =?utf-8?B?NU9odWlZNmVjZ3crU2hITkN4QktLODBxNzNDa09UN2VZODg2UEQ4UmZYaVFM?=
 =?utf-8?B?bVQxdjJPR01ocWhBYVduMFh0TE12endYaGdDVllJT2pUQ3lYVWFXeU8ralFi?=
 =?utf-8?B?Q1RaYjhTTzRrUm9ndmpHMkVtTlZad2xJN081VTRYR0grNENyTEk2VGZtam8w?=
 =?utf-8?B?dnFla1Z1WGFmOVAyS0N4anZTZ1BqeGFaSVpDaXBwWHhqZGphNUVTWVhDY3li?=
 =?utf-8?B?N0JvazVlZ2xaZ1NRVlVoWkFjS0Nwb2FrckoxdjBRbjNvMjdYb1NXME45bjF6?=
 =?utf-8?B?NHRjdWx1OHgwMFY2ci9uajlqUkp4bDZMQmkzT3ZUQzYydytGRGI5QUhVL0cv?=
 =?utf-8?B?MG5EbWR4dzJOOEFuMEUyeGRWNWx5U2VGdmtaRS9TaHlLQ2doa1YzSGJSZEov?=
 =?utf-8?B?TWdVSUE5dUVFeW5lbUR6VDE1TkgwSVg0V3ZOUExLYmxqRDQ4MVVrUXpvU21L?=
 =?utf-8?B?R1pFMS9kZWRpcWNISmJoQVdYQjVuRFNnMDR0U20yM0QrRWYxMjNnM3hWOTRC?=
 =?utf-8?B?M3NabFQ5UkROZCtYaDA4YzFGekIzZytJS3pDZXhseVlHZml0RlpDVnBLR2xy?=
 =?utf-8?B?MGU1SGRKUGhXRnFUbkYveEhISC8zN2pxSGxDT2hYUEZzdERmaVhpcGhuM2pq?=
 =?utf-8?B?MCt1N0dCdk1XVnpjUTRvTVpGWnRubkdvVDZva29NYVBPL3VGeWlGcFlYSCtC?=
 =?utf-8?B?OGNhenIvMGMxWlNzZjNIQWNKL1I2UWx4aSt0dWlCRllrVCszK1ozejZYd1Zl?=
 =?utf-8?Q?167Y60qOYS3U0eY2891w7XhsM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f28d335-86f0-4ef3-38aa-08de0606b48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 01:05:00.1287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvUea1iZ5KsKrQ1MDzsvcCRpnX6MJWq7BI79bLisBbzI/A+mPhsppWsoVAh+k9TAbagOWT0BXjTe57RV1XlV/e3l1Wzmw2WEbJUaRBFDt3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7063
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

PiANCj4gVGhlICdhc3QyNzAwYTAtZXZiJyBtYWNoaW5lIHdhcyBkZXByZWNhdGVkIGluIGNvbW1p
dCA2ODg4YTRhOWM4NjAgYW5kDQo+IHJlbW92YWwgaXMgc2NoZWR1bGVkIGluIHRoZSBRRU1VIDEx
LjAgcmVsZWFzZS4gVGhpcyBjaGFuZ2UgcmVtb3ZlcyB0aGUNCj4gY29ycmVzcG9uZGluZyB0ZXN0
cyBhaGVhZCBvZiB0aW1lIHRvIHNhdmUgQ0kgcmVzb3VyY2VzLg0KPiANCj4gQ2M6IFRob21hcyBI
dXRoIDx0aHV0aEByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rl
c3RfYXNwZWVkX2FzdDI3MDAucHkgfCAxMiAtLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2Fh
cmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMC5weQ0KPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2
NC90ZXN0X2FzcGVlZF9hc3QyNzAwLnB5DQo+IGluZGV4IGVmN2VkNTIyYWZjMy4uYTYwZGMxMjU5
ZjY5IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRf
YXN0MjcwMC5weQ0KPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRf
YXN0MjcwMC5weQ0KPiBAQCAtNDYsMTAgKzQ2LDYgQEAgZGVmIHZlcmlmeV9vcGVuYm1jX2Jvb3Rf
YW5kX2xvZ2luKHNlbGYsIG5hbWUpOg0KPiAgICAgICAgICBleGVjX2NvbW1hbmRfYW5kX3dhaXRf
Zm9yX3BhdHRlcm4oc2VsZiwgJ3Jvb3QnLCAnUGFzc3dvcmQ6JykNCj4gICAgICAgICAgZXhlY19j
b21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsICcwcGVuQm1jJywNCj4gZidyb290QHtu
YW1lfTp+IycpDQo+IA0KPiAtICAgIEFTU0VUX1NES19WOTA2X0FTVDI3MDAgPSBBc3NldCgNCj4g
LQ0KPiAnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMv
ZG93bmxvYWQvdjA5LjA2L2FzdA0KPiAyNzAwLWEwLWRlZmF1bHQtb2JtYy50YXIuZ3onLA0KPiAt
DQo+ICc3MjQ3YjZmMTlkYmZiNzAwNjg2ZjhkOWY3MjNhYzIzZjNlYjIyOTIyNmMwNTg5Y2I5YjA2
YjgwZDFiNjFmM2NiJykNCj4gLQ0KPiAgICAgIEFTU0VUX1NES19WOTA4X0FTVDI3MDBBMSA9IEFz
c2V0KA0KPiANCj4gJ2h0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3Jl
bGVhc2VzL2Rvd25sb2FkL3YwOS4wOC9hc3QNCj4gMjcwMC1kZWZhdWx0LW9ibWMudGFyLmd6JywN
Cj4gDQo+ICdlYWMzZGM0MDliN2VhM2NkNGIwM2Q0NzkyZDNjZWJkNDY5NzkyYWQ4OTNjYjUxZTFk
MTVmMGZjMjBiZDFlMmNkJykNCj4gQEAgLTEyNCwxNCArMTIwLDYgQEAgZGVmIHN0YXJ0X2FzdDI3
MDBfdGVzdF92Ym9vdHJvbShzZWxmLCBuYW1lKToNCj4gICAgICAgICAgc2VsZi5kb190ZXN0X2Fh
cmNoNjRfYXNwZWVkX3Nka19zdGFydCgNCj4gICAgICAgICAgICAgICAgICBzZWxmLnNjcmF0Y2hf
ZmlsZShuYW1lLCAnaW1hZ2UtYm1jJykpDQo+IA0KPiAtICAgIGRlZiB0ZXN0X2FhcmNoNjRfYXN0
MjcwMGEwX2V2Yl9zZGtfdjA5XzA2KHNlbGYpOg0KPiAtICAgICAgICBzZWxmLnNldF9tYWNoaW5l
KCdhc3QyNzAwYTAtZXZiJykNCj4gLQ0KPiAtICAgICAgICBzZWxmLmFyY2hpdmVfZXh0cmFjdChz
ZWxmLkFTU0VUX1NES19WOTA2X0FTVDI3MDApDQo+IC0gICAgICAgIHNlbGYuc3RhcnRfYXN0Mjcw
MF90ZXN0KCdhc3QyNzAwLWEwLWRlZmF1bHQnKQ0KPiAtICAgICAgICBzZWxmLnZlcmlmeV9vcGVu
Ym1jX2Jvb3RfYW5kX2xvZ2luKCdhc3QyNzAwLWEwLWRlZmF1bHQnKQ0KPiAtICAgICAgICBzZWxm
LmRvX2FzdDI3MDBfaTJjX3Rlc3QoKQ0KPiAtDQo+ICAgICAgZGVmIHRlc3RfYWFyY2g2NF9hc3Qy
NzAwYTFfZXZiX3Nka192MDlfMDgoc2VsZik6DQo+ICAgICAgICAgIHNlbGYuc2V0X21hY2hpbmUo
J2FzdDI3MDBhMS1ldmInKQ0KPiAgICAgICAgICBzZWxmLnJlcXVpcmVfbmV0ZGV2KCd1c2VyJykN
Cj4gLS0NCj4gMi41MS4wDQoNClJldmlld2VkLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3Bl
ZWR0ZWNoLmNvbT4NCg0KVGhhbmtzLA0KSmFtaW4NCg0K

