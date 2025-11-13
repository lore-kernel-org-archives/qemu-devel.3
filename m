Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17C4CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPXr-0001x7-RJ; Thu, 13 Nov 2025 00:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJPXm-0001vH-2W; Thu, 13 Nov 2025 00:06:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJPXj-0003XB-7h; Thu, 13 Nov 2025 00:06:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcIQvjb3GMt14hQh9/GO9SNI49rbPABFvRJ2mt1ONldOI4rBox0WpsaIoNH+GlMmGByLGkqGiTMKzZHFCFff9b2gnQrJczOIzGhEwnGjhz1UQIvQk8j+DXOrrsCRp6kU8dd0QTdZnGCSaZVhbrlZePGy/yuyRtomkPmlN6+Cu6AZV1IrT+O0uDFMasnmUyBA0HKMlQYr+l0z/T0oP+wyYLefLi2gGCqLtUd3fFDrgHgD6cGX6wF3jElVawJxZtTKwbPtOQBAiT09dgDdbOVd4KJV+Lr8ejHlvzzCYM56k/bNfp/QxAbd5yy7+pRHyYPpqlKYRvBHkv5oI/nrEA+apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vq63AMNjvWFlxkurQwO/LU/7rhltf3G35Marp50lsik=;
 b=wsQeYQe5WNDcm5q5njEXu48KCP1x8pkQung4jGKlkh4jvWxNU9x7RTy0z/yx0wQcz7tpSZfMkOlVm6+Kd5gxbb1+LXS8X32IHTQYnP+uYHAYWb157Z0RlMtATYdEyoW2NW6oalmRv72R5AF9EO/0kEwiz9yKbz+Ht+Fqa2FCJ9Mvs3eMNIwpzrpM+ETXMtsZagOR8agbk3j9Si0mTuYu5MpS9GrzDkxn+GY8fPCFq5/y1JiNHm7aQ/lo9HTDBPoTldfFFvN3SCZxWH2s3n8w6c08gigruHnMibGqrWU2XLF7yVRRnDUPs68902q0wtG/UKori53FgzK343WnDSHGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq63AMNjvWFlxkurQwO/LU/7rhltf3G35Marp50lsik=;
 b=OXy8/1YY1Q/B4ge0l76RH7nfnM9XqVYfaevxSvHItkegsElZN/RXtz3lUamCdpuCDWEcibdbjnQ8/llZrp2q8D76YmOTylhbg7zalTl4wPQOj99mzeD2XCD0HEeU51JLYEGbxcw4vMhyMG3+MyO5ImUM9LbqL8DcfOCkNqMRYtL9Zvjng3jbuZnHcSp7fH62Q2d2jEyRk9Kblhbp43Zw1TDFB7l3SGLMsbH8NNIZC0bqNUo3iHF7kyQXRktxkcxohwkIdxacffFH1Pj52+79BK4jd46m/3xzOgno5NoBx7C34leYBRByMXEOhIknJ+e7CEzI1EybeK/XUMRT4xnMyA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by PUZPR06MB5904.apcprd06.prod.outlook.com (2603:1096:301:113::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 05:06:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 05:06:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Hao Wu
 <wuhaotsh@google.com>, Patrick Venture <venture@google.com>
Subject: RE: [PATCH v2 0/3] Add drive-backed EEPROM support to quanta-q71l
Thread-Topic: [PATCH v2 0/3] Add drive-backed EEPROM support to quanta-q71l
Thread-Index: AQHcVDaR/hxbHLEzF0aWbfAKfbjFbrTwDSww
Date: Thu, 13 Nov 2025 05:06:35 +0000
Message-ID: <TYPPR06MB82066E9E2A137135A76935A4FCCDA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251113-quanta-q71l-eeproms-v2-0-e72451b974b0@google.com>
In-Reply-To: <20251113-quanta-q71l-eeproms-v2-0-e72451b974b0@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|PUZPR06MB5904:EE_
x-ms-office365-filtering-correlation-id: 3a906ede-8d1f-4eb5-c63d-08de22726ba3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZGZ5dExpZVljRlUxWklkcG1lbDNGWE1PUlR6VHRxRjEvUkhWWVU4dzQya2Zs?=
 =?utf-8?B?WWpjTzVPMitJTGlmSWl1Vm9HeDRnb1lCQXkxbHlYZi9FZDlOMndBc3NvZ3J5?=
 =?utf-8?B?VUlqUU5LUjlQR3NUbWlFbzhoVkorcjR6RWlKemVDLzN2bTRVS1ljTDVEbHVq?=
 =?utf-8?B?V0RJdnYzeXMrbHJ4WTJEM2liQklDTkxYVkJ0QTdIN2Jwb0dZWldSckFBbGVa?=
 =?utf-8?B?ZVp4NkNqNkd3aStSTjJsY0tMVUlOYWdtV3NoWEhvLzNiREU0NmZ1QWRlQ0F2?=
 =?utf-8?B?SUthb3psSUxmVFpMa1F3UnhCK0oxT3h5amV6SFpaeFMxaWtoM0RoYjhYY0FZ?=
 =?utf-8?B?Sy9IZ0dGV3ZtVjhuYlhyMFRaZXhBUHlFSnFOZkhyUXE2T0FYb3o4Rmw5ckpE?=
 =?utf-8?B?R2l6NXdWYVdoT0pvWGFzQ1BFQVVjcjBOL2tKL2tkZFJ3bHZEcUJJeS9LcElm?=
 =?utf-8?B?QzhKckdrbVFNK21sTzgxK2tXaGJWMVd1OTlRYzJlWjgzdjBRZy9sWlVON3hG?=
 =?utf-8?B?MVRxaCtJQ1MveTBMRGUyMkxoTWJBR09aNXgyS3d4MUZJNE1NRmppVkNqcitU?=
 =?utf-8?B?RWtSeXFOSG91Y21ZcE5RcGIwNkN0Zmk3a0JVQmJvVitrSmdPZnN3cWN4UDBI?=
 =?utf-8?B?OHZBKzN2MjlMYysyUWd1b3ZQaWlReHVGdEJ0K2xIa1Mvelk2a0xvNXFwbncv?=
 =?utf-8?B?WGJPUVp2aWtWWjlMMFZVeVNoMzFDUG92cG9rcmoxbkNQYnBrSkZ5MWtyeDQv?=
 =?utf-8?B?T21LaU8xaTZKektReFZDYTg3d2tpRnVtVWlPM01LQzk1b0szbTBXWmJ1dnRG?=
 =?utf-8?B?aVN2dkZlYXdFV21nYk5McXlmQjRJMnBlY2p1a0hVSDBUcUZJdEV2cytaVGxw?=
 =?utf-8?B?RUN5dVhoVHJqN2tFdFFTUHlxbkMvWjFsM0lEL2hJNk9rMkFodXNwZkt4dkVQ?=
 =?utf-8?B?OFN4cDdPMDIxdFRYdHllZFV2OWltRmtFM0IxT0s1akYvMWdWSE1oZFlNLzhN?=
 =?utf-8?B?bGlreGo2RWF5RlAxelJjOXJucjM3cm4yZG1IdSszSGRDK1NwZWkzL3NKQ05Y?=
 =?utf-8?B?RnBNN21Ccm1yVExEeXFsY1RPdytnb3Jrb3dXam5zWlAzYldIMUhLbEVBMTZa?=
 =?utf-8?B?UFNYWE9paFFNRXV6MkFFNFF1R01yOC9HdEtIcUtFQ2RrZlRtNU9lQTZwbmhH?=
 =?utf-8?B?WG5kQnNZQ3J5cG9sNFJkekZOWUVjLzF5OTg5Wlp0Wk14dEJKOVQzdDVnRm81?=
 =?utf-8?B?N0cwa3Z5dWgyeGNXOE1PYVg2bXZRNEJUb05pM1FVWW5ISE44dS9VcnpRUVow?=
 =?utf-8?B?dHhxRHhGYmJHTHE1VXFVb2VpUE5sdGRtNmN3SEVlVXZ1Rm5IVHpXN2pPV0VZ?=
 =?utf-8?B?QkdFWmdwMTRZVi9vNE51S2VzdTJ6UHpadGlrUUVDVXFHOStQWGdjSlQ0REFa?=
 =?utf-8?B?YmFUcHQySWtxK1ZJZ0pwOXRNTzNUM2M2Smp2a1JPVTRsVUNObFVQRGUrNE5V?=
 =?utf-8?B?N0R5QkZBeUV4UUJLTUNUbXlFa05JN1hpbmFOMzdaK3hKalIwWTgyT3kvVzE3?=
 =?utf-8?B?YkFPTXMyTUppMVVPeEhnaVk1eGpqUGJiWUtXUFNydU9GSFBoblJZVFYzUGNv?=
 =?utf-8?B?aTdaU1NzcWUyWU5WRjF0S0gxTEJTR3B0SG4xTE9qVUcraVhHR3dTa0JhejBn?=
 =?utf-8?B?ZHdZUHpkVEZkRVM0SjVwQzFUcUpRaWhlNEZsYVJCVnEvM3QrKzEzblgrY1RC?=
 =?utf-8?B?eFRSczlnZlVOZ3JiSFhzemR3anBVaDUxWVlWc3ZzQ1Q5S2UzMnkxM1gzb2Rm?=
 =?utf-8?B?U2xscGNPNVhEcjdSb0h5WWJ4UTN0eExBRGFsUVZuSnprUHlMQ2tpNzNNeWJ2?=
 =?utf-8?B?VGFlSXZsRXduZEZpK1lGUFJIdlUvdmx2Yi9UTmlDRDQyZGtyZ3owSFdFQSt5?=
 =?utf-8?B?dHcvS0ZtQ2dGNXM0Q0JGK3Y5U3NHQ01mVEI2THNVNGp1NnZ0d1lMRzJqMUt5?=
 =?utf-8?B?Yi83RWdIYXp6RzB4cWlMM0I2MnhBQVhIa2RlMHVaS3JnOWdDOUxrQmYraHZR?=
 =?utf-8?B?YTNKc1VYeEVFRDNpeFpXR1ErSmtVWFlTaHk4Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2Q5THRtNExobXZteHovQitrY2dTcEFYMTNZYVNldzMrMFQ5eGpaS0VNNFhP?=
 =?utf-8?B?OHVEOWU0bFBYeUhQc1BnbGhOZU5sUS8vaGhXNmhJZUhqUEg5QnlTdXQzT1o3?=
 =?utf-8?B?R0h5bUVqQ2R5blkvZTI1eFozb01qSlY0THNOdllySWRUMTdMN3pOWlU1Qy9j?=
 =?utf-8?B?TkVVMERsa2tRM1QvQVJMc2VuUWo1M1l1b1gwcmdHSGkxdEJYRkZlZkgwU2VY?=
 =?utf-8?B?b1Z2MWpHcTNPandlMUh6STU0NHZBdzdBUjJCU2wraXpucWt6NmFRUnF5cU5y?=
 =?utf-8?B?c0ZRaGN2eHNCSjB2Z2dKejNnbmZGVFViejhaVktpQ1ZxWGNyVHJxWUZieWNV?=
 =?utf-8?B?M3BuQ29sUlF3OFV1MWN2dmZGbXl1STZPSDNtV0I3UmJvQ3JBNDNkVFlvK09y?=
 =?utf-8?B?dlpWQ1NUNndQTG8vRWVIdW1FNmdwOTdSYXVybERDeHRiVFhoM0tYcHVHWWsw?=
 =?utf-8?B?OGhYQm85Uk9ZRUc3VzJxVmZvd2pweURyY0pTZmdEdnMxcGxTOXQvc1dzc0pn?=
 =?utf-8?B?SXBvYjNrQVovWnNQMUYxc3VRTTdaUWxFNCtjWEcrRktDQUFtWGMwQVhXUXhr?=
 =?utf-8?B?M3NFTS80eFlzUGgzWjN0ZGovdmtUYWIrUzNCRVFmMDhYcTFkTW9aRmROMWUw?=
 =?utf-8?B?NFZsbXFaemJtSG9TVlRyeHhFZWU4blRhV2ZYR0l2N2pzM21uSDRNQnRnOHAx?=
 =?utf-8?B?cUhQbEFUNXc5OG9xZm1vc1BVZXMvWUZIN3g0aVhxclV5ZkV5VkxKaFEyelYw?=
 =?utf-8?B?RWtKWWkwV0txUVFxNHplbkRzbExzMlY2MjBVN2tCNTlXYWtBS0Zmem5Va0wv?=
 =?utf-8?B?UFc5NEVuWTdXV3IvWll6ajB3RWN3dGdYTityRzduY2VpTzhBbk1tcTl6TzRP?=
 =?utf-8?B?STFpZ1U0eXptREhVa0FmTVNVTmJ1UG5QZGNUL3ZocHFYQ3lFUDR0VU95aWRB?=
 =?utf-8?B?U2ZLeGxEU0s0VnZpLzJXVHdHNjdrcm1RRUUyZmFCTUd3ZGw3REhzQXppL0F3?=
 =?utf-8?B?eTJKelI0alBFc1B4VWlROS8yR2U2azZHRXRqYmVZaUpiNElPcTZIZWFKQWdX?=
 =?utf-8?B?NzFoZDJzaTRVcElqK1ZmWVFuY29KUGI5K3VGN21idm9TcFJORC8zL0s4eTd0?=
 =?utf-8?B?KzczaWtSbmI5S3M3Z1dvNFhMQVBUNVNITUpTU2pyQ2ZvVWJIczA5emt3Ym1G?=
 =?utf-8?B?c1ljM254bHIrWHJuSDc4R3NRdWtIRjFUcmZiOUZXY3R2UnkwQWlKVnl0ckFx?=
 =?utf-8?B?VUltYnRhc0YrMlJsTThBVHp1T2w2eUNqRGQ3TzBhSm1wZFgybXRqenczaWIr?=
 =?utf-8?B?MGNPblBPWWw4cXhMZlN4aUJxaHFMZWVLTXZWSHlCYnh3UTRWK2E3aHdQd1do?=
 =?utf-8?B?cHowSlY4Rzg3cUFMS29jdHl2Nk00cDhlYVlJVDlOTzNiRXRHUzFnSFVobVhN?=
 =?utf-8?B?WkhlRFVPYUZXcEU1akxLbHdnZTJpY05JN2lRNVZCQkgrL2ZSUGdoUTRRWGZ4?=
 =?utf-8?B?OFZ6RStMdStZS00zUnIyYUQ2Yk9JdCtCMElqbUdpaTJNcUdISWxaaUZXTmVX?=
 =?utf-8?B?SmUxY0FwQlV3TlI1RWs2WHQvVDdORllwNnllOW9ZZ3RtNU9WTk0rS1hOenh4?=
 =?utf-8?B?bTNDc3BoVGZrcHBSbWVTU3pUOXViQ3lSbmpWL0YxVDFpOG1Gcmw4b2xUaFBD?=
 =?utf-8?B?aU1QWkg5RUJtR1QrbTZIYXBPZitFMVFvOTBhUnFSSUtHMUtscFB5b3M5OGND?=
 =?utf-8?B?amlsWEJ5dFVtVHdGZjRqNk9KVktGNFd5eHBCcUE2QUZmZnp3SkFzcFlZSjNV?=
 =?utf-8?B?LzVmcExUMnFja1krUlZVNWlBZ0F5cU5YUkpnc3NJNnJ3ajRxVk1tQjRkVEcy?=
 =?utf-8?B?K25OM29SSS9qOVdmVjFnL1VSemg4SDFIWkRhZXVHRTcxWEdxUHpSaHBXc0dL?=
 =?utf-8?B?ZWlYNkZBam8vbjhXOGRuQzBIbHQ0QkdnbFlhcExxTEU3NlhBalMzU0xLY2xn?=
 =?utf-8?B?NHVqL3hWNS9QV2xTdkdMa3lvVmpFUnpybjBReEN0Nk13SGczM0ZXd3JnMDNH?=
 =?utf-8?B?OGZDL28zRS9qeXRqTExTWUVncFo4aXZvWmVNdWlvWlFNRFJGNkNnSkFEWDF2?=
 =?utf-8?Q?GZ3RXE55ZkIoyJzZbsZy0KyFv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a906ede-8d1f-4eb5-c63d-08de22726ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 05:06:36.0267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mTZjM/ja6a2/lcjBOsnYBKNyb0FZFY7Bwgajsj14LBmnTE/vDQ66y2JlZcMcN8EwLNvMziRDRyelxMALWfeQKdhPTYYhoa6PENDYObD6Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5904
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgWXViaW4sDQoNCj4gT3ZlcnZpZXcgb2YgQ2hhbmdlczoNCj4gVGhpcyB0d28tcGF0Y2ggc2Vy
aWVzIGludHJvZHVjZXMgSTJDIEVFUFJPTSBkZXZpY2VzIChBVDI0QzY0KSB0byB0aGUNCj4gcXVh
bnRhLXE3MWwgbWFjaGluZSBtb2RlbCwgcmVwcmVzZW50aW5nIHRoZSBCYXNlYm9hcmQsIEZyb250
cGFuZWwsIEJJT1MsDQo+IFBEQiwgYW5kIEJNQyBGUlVzLg0KPiANCj4gSW1wcm92ZW1lbnQgdG8g
UUVNVToNCj4gVGhlc2UgY2hhbmdlcyBlbmhhbmNlIHRoZSBzaW11bGF0aW9uIGZpZGVsaXR5IG9m
IHRoZSBxdWFudGEtcTcxbCBib2FyZC4NCj4gQnkgbW9kZWxpbmcgdGhlIEZSVSBFRVBST01zIGFu
ZCBhbGxvd2luZyB0aGVtIHRvIGJlIGJhY2tlZCBieSBkcml2ZXMuDQo+IA0KPiBJbXBhY3QgKEJl
Zm9yZS9BZnRlcik6DQo+IEJlZm9yZToNCj4gVGhlIHF1YW50YS1xNzFsIG1hY2hpbmUgbW9kZWwg
ZGlkIG5vdCBpbmNsdWRlIHRoZSBJMkMgRUVQUk9NcyBmb3IgRlJVDQo+IGRhdGEgc3RvcmFnZS4N
Cg0KUGxlYXNlIHJlYmFzZSB5b3VyIGNvZGViYXNlLg0KVGhlIHF1YW50YS1xNzFsIGJvYXJkIGhh
cyBiZWVuIG1vdmVkIGludG8gYXNwZWVkX2FzdDI0MDBfcXVhbnRhLXE3MWwuYw0KWW91IGNhbiBm
aW5kIGl0IGhlcmU6DQpodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Jsb2IvbWFzdGVyL2h3
L2FybS9hc3BlZWRfYXN0MjQwMF9xdWFudGEtcTcxbC5jDQoNClRoYW5rcy1KYW1pbg0KDQo+IA0K
PiBBZnRlcjoNCj4gVGhlIEVFUFJPTXMgYXJlIGFkZGVkIHRvIHRoZSBhcHByb3ByaWF0ZSBJMkMg
YnVzZXMgYXQgdGhlaXIgcmVzcGVjdGl2ZQ0KPiBhZGRyZXNzZXMuIEVhY2ggZWVwcm9tIG5vdyBj
YW4gYmUgYXNzb2NpYXRlZCB3aXRoIGEgUUVNVSBkcml2ZXIgYmFja2VuZA0KPiBieSB1c2luZyB0
aGUgYC1kcml2ZWBvcHRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdWJpbiBab3UgPHl1Ymlu
ekBnb29nbGUuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gSW5jbHVkZSBhIHBhdGNo
IHRvIGFkZCBhIGF1eGlsaWFyeSBmdW5jdGlvbiBpbiB0aGUgYXQyNGMgZWVwcm9tIG1vZHVsZSB0
bw0KPiBhc3NpZ24gdW5pcXVlIHVuaXQgbnVtYmVycyBmb3IgZWFjaCBlZXByb21zIGluIGVhY2gg
Ym9hcmQNCj4gDQo+IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDI1MDkxNi1xdWFudGEtcTcxbC1lZXByb21zLXYxLTAtMzY0OA0KPiA2OTJjYzQ0
MUBnb29nbGUuY29tDQo+IA0KPiAtLS0NCj4gSGFvIFd1ICgxKToNCj4gICAgICAgaHcvbnZyYW06
IEFkZCBhIG5ldyBhdXhpbGlhcnkgZnVuY3Rpb24gdG8gaW5pdCBhdDI0YyBlZXByb20NCj4gDQo+
IFBhdHJpY2sgVmVudHVyZSAoMik6DQo+ICAgICAgIGh3L2FybTogYWRkIGVlcHJvbXMgdG8gcXVh
bnRhLXE3bDEgYm9hcmQNCj4gICAgICAgaHcvYXJtOiBlbmFibGUgZWVwcm9tcyBmb3IgcXVhbnRh
LXE3MWwNCj4gDQo+ICBody9hcm0vYXNwZWVkLmMgICAgICAgICAgICAgICAgIHwgMTUgKysrKysr
KysrKy0tLS0tDQo+ICBody9udnJhbS9lZXByb21fYXQyNGMuYyAgICAgICAgIHwgMTcgKysrKysr
KysrKysrKysrKysNCj4gIGluY2x1ZGUvaHcvbnZyYW0vZWVwcm9tX2F0MjRjLmggfCAgNCArKysr
DQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
IC0tLQ0KPiBiYXNlLWNvbW1pdDogMTkwZDVkN2ZkNzI1ZmY3NTRmOTRlOGUwY2JmYjY5ZjI3OWM4
MmI1ZA0KPiBjaGFuZ2UtaWQ6IDIwMjUwOTE2LXF1YW50YS1xNzFsLWVlcHJvbXMtMGViYzZlMDQ4
NmQ3DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFl1YmluIFpvdSA8eXViaW56QGdvb2ds
ZS5jb20+DQoNCg==

