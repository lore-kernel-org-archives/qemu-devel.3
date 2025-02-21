Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0735C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 05:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlLpK-00005d-Oc; Fri, 21 Feb 2025 00:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlLpF-00005G-6e; Fri, 21 Feb 2025 00:43:50 -0500
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlLpD-0006Su-4u; Fri, 21 Feb 2025 00:43:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYaC1ZZm7DcRj52V/2/R/jQriNjNR5ez5Mhfy/dfolHY8pwMwYHRWlosptwxMY8pmQqO/dJfN+FWQjIyFNnpxGbWUIEhYSQj8HYda/Tx6o36zVKS3AEmFw3VN/Ud728AjcQziXaw1kwLYCqQPFinqnnuuVZrLm8COI+milf3CCWQgTx0c5/Dk3BorX1KUrfBx5J7O4PTLdmnhmnazoDEgEqxQLSjs/4uhuMGx0HiIstLX0k6xbquGIcXzK/EqMg1sLJEsdTv5PVkcfzhsY5Na2NrX0eILoO+PAXbScFLg3MpsO7XK1R9gtvh9MVp/TVm+PGQxJVcgqPWebU4DChKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGCwpYraI92t6EHRr43j7otQrpDm+VfwTr9/7kX9OsQ=;
 b=HVhizBm1L/+/CHlzx/ZP5U7kCY6iQDIHooVWwn7KSYO87py7jJZNgdTYwDaGGRyYFNUuLWyHQXrFAeFDkhPCDF9lprJ7R95PAQSypX5lLTLtDQTwW1ikjh0G3a0XDdoAQoU2oIUZmXcnPRat0fGGBoCEVK+EmKodNCJV4/0ABFCXlJ2lIVWd7MgGoVExj9G9wa+CXecddoCxuGC3ZqoVmvIdH3r1z7hSJwnFUHu+MBbxKmA1oaSXKNQPKLb2KAYgEbLIaBVygCBFce/bqZ4+eok/T4PtGHQt86wMEF8k3U1lT4qZDSTAfTrwQML00DO6k3VDLmKzQkn3Rqe0eF8r8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGCwpYraI92t6EHRr43j7otQrpDm+VfwTr9/7kX9OsQ=;
 b=KUrNNDDY2sGUfqf1WEgUH6h4TDuXwfYZDwc6wMtABrAOrwV9FstEEPtJg3mp+UwAhX/6qcB6lTFG/dzmcmYyKGPii+/8buT8G5hKkpm6vjY1JQ8JDZL6W/9oMGN71pSXf6HNKW0H5kN/50IZ9NROSrFMcVgRyK3wL2SCbKkmuSZiTYvUOUvR1k+jLObcXFezfHyuGPpEtdw0X8n6wo2u+YjpYeU0vBXF/lavDNiBBA4sFQY1MG1Zx3sxS9KfZgzNgIasG1mGpHjNZLndDydXqeipD1JeaKhgtMS7gkyUvXGDy1KgNKvf8xg0DTS/T63ZmjWfhYn3xWG02s020uJvtQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB5873.apcprd06.prod.outlook.com (2603:1096:400:345::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Fri, 21 Feb
 2025 05:43:34 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 05:43:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 21/28] hw/misc/aspeed_hace: Fix boot issue in the
 Crypto Manager Self Test
Thread-Topic: [PATCH v3 21/28] hw/misc/aspeed_hace: Fix boot issue in the
 Crypto Manager Self Test
Thread-Index: AQHbfchky6ROwLofhkuIiNhSbOQHZrNMoGUAgASp1uA=
Date: Fri, 21 Feb 2025 05:43:33 +0000
Message-ID: <SI2PR06MB5041F4186411EE60CB26CC44FCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-22-jamin_lin@aspeedtech.com>
 <51b4d012-db0c-42b1-ae0e-2b28751bc2a4@kaod.org>
In-Reply-To: <51b4d012-db0c-42b1-ae0e-2b28751bc2a4@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB5873:EE_
x-ms-office365-filtering-correlation-id: e8cd2be2-851a-4e7d-14f9-08dd523aae1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZG4rVVp2MTJOYjNmWERNSU1RY0VUNkVIaVU4VjlmRzkwU2JiN2Z0akt0akJm?=
 =?utf-8?B?TCtWL1kxSy8zRWJuSWVsSDlnOEcrNllvYWlKWXArYXRMQ3B1UXA5dXNYWmpa?=
 =?utf-8?B?TUhQbEkwMmVPQWxqVUNCSkp2NGxvT1Z4cFd5eWdZSlhTT1BNUGtUM2RNSnBT?=
 =?utf-8?B?dm9UR3RURnBnakNSdG9EcHpUOWorUFlCWHdGa0NUMGxHQTJYWkxsVHZPTEZR?=
 =?utf-8?B?ZDhzZDhzeTNaYmkybGk4WktSRzg5azZQTGZnK0RmYTJyOERnNytDU0J1cGxL?=
 =?utf-8?B?TTlZNGVhK0tqT1l5di9EQURoZW5FYjZWSDRITndYOFZ1S2JMWWtpY1lMSmEw?=
 =?utf-8?B?Z1QyV1ZIRVpCSm9wZ2QrM2NJMVd2eFlWUGdJYlVQVUZoM3VCY1d0U2ljbFlE?=
 =?utf-8?B?dUd3Tll3N0JXSko1aVM2VWNzSmtaMk5OdDNDSVR2dzNRTDZLVks5MGY3NHZR?=
 =?utf-8?B?VDIzbTh0bnNmV2dNdm9XczE5dzhGZ2pVTVVialdweVlIS05BamxJclZ4V0Np?=
 =?utf-8?B?TEVWM3p1eTA1SHhaaWhoako5SllvamNPY1lTOXhaeU1pUDVHMTZTZGsxano2?=
 =?utf-8?B?czM4c3BhSzh0YnV6MmZDZzZScG40aUpaOXBSV2Z1YWk3cUFOdmsyVE03akNK?=
 =?utf-8?B?Mmw3TTkyS01FOENoZE90dlVvVnZSRXdlK1JWYWpMck5OWXdpd0RBc0dLZEhO?=
 =?utf-8?B?UDBvS0NjdWVIcHN3dHE4Z3BSYkVVZzNscmd4MEVmSGtjUnhKSGdMMUM2U0l2?=
 =?utf-8?B?RjBvSlZsMnhxcXlVbnhvdVBkbFhtUnRERmIyVzRabkpOd08xNjJPZllRS20z?=
 =?utf-8?B?VGtGekJwRm8zWGRYelFZV1RjU3RuT29nSDhWeDZqT1JVY1FJUjdMRnpVMC9o?=
 =?utf-8?B?WXF4SUJ2RElFUUNrZ1NDMEQ1eTVTRDBWbkhJdDI2cTFwVXcvbU9uSTN4RVFu?=
 =?utf-8?B?WU5Xd2w0bytFcUE0LzFwR1c2cDQ0WG5kckRyZkpsU2Jia1pMNjdNVnpOU3E3?=
 =?utf-8?B?a3kxSGI0ZUlPWkRZb3haa3o1QlpLNGt5WmkvYlpDY1M5dzVGSndkMmRuMTEw?=
 =?utf-8?B?NlpNK1ozS2FxbVpaWlR0bThUUS9vejJQYkRxTmxzcXVLUFRhQS9CelpyQ0hV?=
 =?utf-8?B?ckp2Y3BsamVlbW9xSEdxMnJtdGFBTVFUcnFSSG54VXhvWVlRYWxIOTZWZGhv?=
 =?utf-8?B?Y1d6Z2ZzSWpUZXg3MjNnM0dXQmhqUUxWTXBxaWxTcWpQRk8waWlkb2RMWVRT?=
 =?utf-8?B?amdvQXpubUpYODdMdE9PWWpReXZqVW9ma2ladGxEdWpZcmo5RnFJUXRUbFJJ?=
 =?utf-8?B?Z25rM2xrNnA5ZUEyWnJUazhGR2IrYTZpZ0xGUGswaThkSnFUa1FJZitCQVdk?=
 =?utf-8?B?aGg1bXZxZWcxU1VEeHhpNERrZzIycnR2WVdleFliZlEwdHVaOS9LUmNFU2NH?=
 =?utf-8?B?bGZ1QXBrRzhwVWV4d1hFV1JXLzhOOFBuZkJWUXh1enNrUk0yYTlZcFF4NzJL?=
 =?utf-8?B?U0JoOGFyTFlha3dKSVNJb3BJUHllRCtNMUQybytObFlGWngyeGl5Skl6Y1lY?=
 =?utf-8?B?WVErakQzeDlSRXI1QTV6WVoxREE3YUhMZFRGZWNpUGJ4UjJxWG9laklTaTZZ?=
 =?utf-8?B?UmJvR0gzVXdWT1ByQjVncUJvQkJKbHoyTVNNREx0LzFQRjd2dXBjWGc4ZDZK?=
 =?utf-8?B?WXgvNFVXczEwQzEwWnN2VTBiWEQ0ZTRiZlgrTElmR0RKYVpyR0xTZ2xWR0tN?=
 =?utf-8?B?bmJUOGRjakk3MW1KUXRhbktndm9PUzdFRE9qNGpINll3YmtYcGt6em14eGlG?=
 =?utf-8?B?TWhIdnRnbW00NlMrZWdob0ZpQzBuYkxHekpsWWFCRTJobUNad00wbVpRbWY1?=
 =?utf-8?B?ck0wY0pXVHRjZmM0YW15bWhld0VKbk90bUw1V3pmMEFXa2tGc1JGakk3U3JW?=
 =?utf-8?Q?mv0qVb6qxel0KqEoB8sbQE/UKtqeFuNR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wlkzb0VwZCsyaXJmamZPMWRsTlF2UEE2bHZrRUFMNXpYaEV6aENQNFpnZzJ2?=
 =?utf-8?B?bldXOVYvTjIzK1Qxc3ZPWmgxSVI4UXVRRlhyanQ5MVprQ0V6M2dJYXZRMjN0?=
 =?utf-8?B?RlZJVEluZzk0NHoyS2lPSVZCdTRUVlJkUml5Q0dxQ3NFbHJmckpYWC8vRXJQ?=
 =?utf-8?B?Ykx2c1lCTmt0RjdXYzlyaStCd041djl6VUtUVFRKbWd1Qm1iOUtZRnhxL3ll?=
 =?utf-8?B?NkJlbmpjUjBBeExWVDlvWEZqMmJaQ2VtczVXZFNSSC82UEswbTA4dk5EMmwz?=
 =?utf-8?B?WkxWcWlOa1U3K051K0R0MjV3cDlRRVRrTk5jUjRWNXFFQ1JiZnRuYktneEVE?=
 =?utf-8?B?UlJqUUR2ZEtnVVp2cVR3c2xhWVVUVSt4ZjVlTzUxdnhraE1IZ3Voem1XWUpi?=
 =?utf-8?B?OXpiTlR4RWZWR3NPdTR4TDRMNzU1TzRPWEJoZmFtRlBNQllQLzBEaFhicmFl?=
 =?utf-8?B?SzBTWVVmcWJuOTJzQnAybXBBdStTUFpRdlhMVUZJS0krbGxpbG1jZVY1TXYv?=
 =?utf-8?B?YmppSFNOQ21TajdNblYzK2g4Q1greDhtSFE5S2ZMbEVWNWZWazBCSUpPZ1VH?=
 =?utf-8?B?dHhmTmlFTis0dFRLL2JqRTljT3FiTFlYcGk2WlpvMkE3aGtFaEVmd3JWYmJS?=
 =?utf-8?B?NGc4alBwM28rbmo3TGJacnl5MVFrRFd5M3Y4cVJiR091cUxqUnhFYWJJYlVU?=
 =?utf-8?B?Y0tRYmF6aEtvRWtYU1ZUd29wNnVxNmtGSU1rV1lGSFIrWUhuaEpIbU1sdnNT?=
 =?utf-8?B?SW9mQ1hPYzVxSjFpWDRDbTg1REJJTnEyRGx1WkRId3IwTlB1a3JnZ1JKeERW?=
 =?utf-8?B?R0s5Qmw0bkFMNnZDUjlUZWVBbDdkb2hraHMxV01zMWRIQ0xFenFMY3YxbEpq?=
 =?utf-8?B?TXpDR0NxQ3JETmlVM2RsYXU1bWpvcUdGSnhJeVladjJpVUxKbTFSZzNSWFpq?=
 =?utf-8?B?YXNOYXNLdU55Y1pEOVNMZGNYRm1PRVlvMDVSdnA4YlpTOThYbVV2TnlFeW56?=
 =?utf-8?B?dm91WXVKZ2J6KzcxMGhXd0xqcjRmNVhnNllFZXhxWUFRcHBMVS93UVpmUStP?=
 =?utf-8?B?aGg0VnBYOE1sblJzZGdMNDZuYndWWjJVWUpkSFVDZDRyaERna1V1T0ZwOHV4?=
 =?utf-8?B?OW9OZU9rZFhwN1U2aEJlQ3ZrMWF6cE1HTGpjdlZSazJXamNxZ2puOWp6aTZM?=
 =?utf-8?B?SHdiYU5QYWZLVGs1dVRmWWZ3ZThDWjQyejMyOGd0YU1HWEFFY0ZsRld5Nk9N?=
 =?utf-8?B?RlluWTFxU1huczZwTzV5THBYWXRTSHZRVmZGckYvcDlndVpyOFlOczc3YnpG?=
 =?utf-8?B?R1QvaFdqTEZiTzQ3K3FnN2RBYmRtamU2eVBiUWNpUVFRbk5wRE13d1dyVURh?=
 =?utf-8?B?S0YwYlNlN0lkcXNLcE9UVExTZDZqMDhoMHBpZTlpQ0VVSldFS1lWZU9NZWxo?=
 =?utf-8?B?UmJRV0hoK2VVRGV3b3FOYzVCVnJ0dFJwT0MyTzJCcjF1dFdsTVNKNDVPNnhG?=
 =?utf-8?B?Z2gxbk5zYlJDM0FPZGNNcWdpTExOK0tKREZQaGw3dTJFU0hJYlBjaERGcUNB?=
 =?utf-8?B?VS9hRHJrVDlWWG5JUTR3TnlDbUhZTjBLSlpVSWpFK3BLVDZqK05LYTN0ODQv?=
 =?utf-8?B?a1gxSTcrNUFmQ1NHL2tMMTFxeldldFErM0pRaVRQd3JSZmZLcE55UjB6d0VU?=
 =?utf-8?B?RmcrOVB6KzEzQ0w5eUowTkRaUEJHL2FRbGdFR2NSek5ld1k1SDBicm5FYXRZ?=
 =?utf-8?B?bUE5dlQxRFM4dW9vSmJSTEVwQkZmTXFwSkVlU1ZCUTYxQmp0U3pqWHRnZGI2?=
 =?utf-8?B?bFVWUkhJRC96bmFib0ZiTlpjVEwrUVlHcDkxNXRsZVVtWmx0S3FLanV5dytV?=
 =?utf-8?B?SVUzRHVlZXV2YjRVeGtJMmZqaHpKdEU4ZHRMRnk1SnZPVGg3L2ZxSmtTLzM4?=
 =?utf-8?B?Ky9Gc1V5NXNUMVZYQ085RE1qUmVQcUY4L3M1SVNGdGRIN21qRW1jZStuUXNE?=
 =?utf-8?B?T1V6VTAyMkI2V2VvTnljaFQwdldLcGZCQW9tSzhpR2NhYmlIVnM0NHQySW5D?=
 =?utf-8?B?RTZnek96NGlTeEU4cHRMektLYXorMUwxby9GbVdtbHN4ZTFPQ2RQeGd5L2lD?=
 =?utf-8?Q?VbxTxKiSVxxEZXwi7G+lTcHcK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cd2be2-851a-4e7d-14f9-08dd523aae1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 05:43:33.8400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2XcDraYw7f5J5KPxH4t5S50oPraVTTX8GV4SyCujo3m5lGHXZctz/nuT+rxWJqnoWrTZ7pQzDsMSFxbfoxYJmpJTXHgdkEbYsMayqWBHXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5873
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMjEvMjhdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IEZpeCBib290IGlzc3VlIGluIHRoZQ0KPiBDcnlwdG8gTWFuYWdlciBTZWxmIFRl
c3QNCj4gDQo+IE9uIDIvMTMvMjUgMDQ6MzUsIEphbWluIExpbiB3cm90ZToNCj4gPiBDdXJyZW50
bHksIGl0IGRvZXMgbm90IHN1cHBvcnQgdGhlIENSWVBUIGNvbW1hbmQuIEluc3RlYWQsIGl0IG9u
bHkNCj4gPiBzZW5kcyBhbiBpbnRlcnJ1cHQgdG8gbm90aWZ5IHRoZSBmaXJtd2FyZSB0aGF0IHRo
ZSBjcnlwdCBjb21tYW5kIGhhcw0KPiBjb21wbGV0ZWQuDQo+ID4gSXQgaXMgYSB0ZW1wb3Jhcnkg
d29ya2Fyb3VuZCB0byByZXNvbHZlIHRoZSBib290IGlzc3VlIGluIHRoZSBDcnlwdG8NCj4gPiBN
YW5hZ2VyIFNlbGYgVGVzdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFt
aW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiANCj4gUGxlYXNlIGFkZCBhbiBBc3BlZWRIQUNFQ2xh
c3MgY2xhc3MgYXR0cmlidXRlIChib29sKSB0byBoYW5kbGUgdGhpcw0KPiB3b3JrYXJvdW5kIGFu
ZCBhIGNvbW1lbnQgaW4gdGhlIGNvZGUgbWVudGlvbmluZyB0aGUgaXNzdWUuDQo+IA0KVGhhbmtz
IGZvciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpJIHdpbGwgYWRkIHRoZSB1c2VfY3J5cHRfd29y
a2Fyb3VuZCBhdHRyaWJ1dGUgdG8gdGhlIEFzcGVlZEhBQ0VDbGFzcyBhbmQgaW50cm9kdWNlIHRo
ZSB1c2UtY3J5cHQtd29ya2Fyb3VuZCBwcm9wZXJ0eS4NCkRvIHlvdSBoYXZlIGFueSBjb25jZXJu
cywgb3IgZG8geW91IGhhdmUgYSBwcmVmZXJyZWQgbmFtaW5nIGNvbnZlbnRpb24/DQpUaGFua3Mt
SmFtaW4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPiAtLS0NCj4g
PiAgIGh3L21pc2MvYXNwZWVkX2hhY2UuYyB8IDEyICsrKysrKysrKysrKw0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9taXNj
L2FzcGVlZF9oYWNlLmMgYi9ody9taXNjL2FzcGVlZF9oYWNlLmMgaW5kZXgNCj4gPiA4NjQyMmNi
M2JlLi40ZDA5OTllN2U5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYw0K
PiA+ICsrKyBiL2h3L21pc2MvYXNwZWVkX2hhY2UuYw0KPiA+IEBAIC01OSw2ICs1OSw3IEBADQo+
ID4gICAvKiBPdGhlciBjbWQgYml0cyAqLw0KPiA+ICAgI2RlZmluZSAgSEFTSF9JUlFfRU4gICAg
ICAgICAgICAgICAgICAgIEJJVCg5KQ0KPiA+ICAgI2RlZmluZSAgSEFTSF9TR19FTiAgICAgICAg
ICAgICAgICAgICAgIEJJVCgxOCkNCj4gPiArI2RlZmluZSAgQ1JZUFRfSVJRX0VOICAgICAgICAg
ICAgICAgICAgIEJJVCgxMikNCj4gPiAgIC8qIFNjYXR0ZXItZ2F0aGVyIGRhdGEgbGlzdCAqLw0K
PiA+ICAgI2RlZmluZSBTR19MSVNUX0xFTl9TSVpFICAgICAgICAgICAgICAgIDQNCj4gPiAgICNk
ZWZpbmUgU0dfTElTVF9MRU5fTUFTSyAgICAgICAgICAgICAgICAweDBGRkZGRkZGDQo+ID4gQEAg
LTM0Myw2ICszNDQsMTMgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2hhY2Vfd3JpdGUodm9pZCAqb3Bh
cXVlLA0KPiBod2FkZHIgYWRkciwgdWludDY0X3QgZGF0YSwNCj4gPiAgICAgICAgICAgICAgICAg
ICBxZW11X2lycV9sb3dlcihzLT5pcnEpOw0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAg
ICAgICB9DQo+ID4gKyAgICAgICAgaWYgKGRhdGEgJiBDUllQVF9JUlEpIHsNCj4gPiArICAgICAg
ICAgICAgZGF0YSAmPSB+Q1JZUFRfSVJROw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgaWYgKHMt
PnJlZ3NbYWRkcl0gJiBDUllQVF9JUlEpIHsNCj4gPiArICAgICAgICAgICAgICAgIHFlbXVfaXJx
X2xvd2VyKHMtPmlycSk7DQo+ID4gKyAgICAgICAgICAgIH0NCj4gPiArICAgICAgICB9DQo+ID4g
ICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIGNhc2UgUl9IQVNIX1NSQzoNCj4gPiAgICAgICAg
ICAgZGF0YSAmPSBhaGMtPnNyY19tYXNrOw0KPiA+IEBAIC0zODgsNiArMzk2LDEwIEBAIHN0YXRp
YyB2b2lkIGFzcGVlZF9oYWNlX3dyaXRlKHZvaWQgKm9wYXF1ZSwNCj4gaHdhZGRyIGFkZHIsIHVp
bnQ2NF90IGRhdGEsDQo+ID4gICAgICAgY2FzZSBSX0NSWVBUX0NNRDoNCj4gPiAgICAgICAgICAg
cWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICIlczogQ3J5cHQgY29tbWFuZHMgbm90DQo+IGltcGxl
bWVudGVkXG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXyk7DQo+ID4g
KyAgICAgICAgcy0+cmVnc1tSX1NUQVRVU10gfD0gQ1JZUFRfSVJROw0KPiA+ICsgICAgICAgIGlm
IChkYXRhICYgQ1JZUFRfSVJRX0VOKSB7DQo+ID4gKyAgICAgICAgICAgIHFlbXVfaXJxX3JhaXNl
KHMtPmlycSk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICAgICAgICAgICBicmVhazsNCj4gPiAgICAg
ICBkZWZhdWx0Og0KPiA+ICAgICAgICAgICBicmVhazsNCg0K

