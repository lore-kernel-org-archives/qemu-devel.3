Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDD9C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49Df-0006gj-JA; Sun, 13 Apr 2025 22:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u49DR-0006J3-OI; Sun, 13 Apr 2025 22:06:32 -0400
Received: from mail-tyzapc01on20730.outbound.protection.outlook.com
 ([2a01:111:f403:2011::730]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u49DO-0007va-Nd; Sun, 13 Apr 2025 22:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0tKxeRg2vcBqdcaasHrBIZS+1M03CMepLmEHPb/LrpS0LFiwlcHrr9YL4vxET/NMaMXdasNMwzb/PoABQQNRagtL5Mw6VHT+awCrDrCgxTWGBBVx0VAxWeOJRCzbpBhGEzi1JtjynWbVkOXwqU+LDZ3wXHlrV/l/3qd9SV6mcR4j/3rbWdetTN4A/cmWhcXC7LoEL7co76U4nwoYD3Nfyh90xqvAo6zZdHy+vtkg9BwquwPZXrqnE6uCKQ+xBbcfTjZ7yNJnGZ6yhhTPLVaYfLCE1AWRovvNQAijU5cuIs03F2LVu3oaYyrDNKuJAemyZSzqtPPdm3ToMr6MhHAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fV2wgwXd6wPRoasXB5QkQcus7peW+xBKv7AcNhj67M=;
 b=knzNQS8pWLTtfuWD2NrZjmTsykcw3VNCq0nhffnRViqwTul7xrczRe3fsjjlfd54LCnooYLDcBR6K72Udy5xiIDwPITtGJsTaoYlXcLmyRcs0QfutlKTNyzlhFwtGkiWwgKKvm9j5WVVN7fQoou9hnXSIYg0v4fZL52e/k8YNrIT+5tcF9d3LPE9tJGrV2fXkfSOm+PCEYct7tuwtaUcdfHLDo4ia2Z0dKoWc5A5KlwZpzCklngNRAC/SSLnP21FaEosFpoR/2hKUu4kuEU7vi39p6qNI4rPXGoOuZEO3Ejoh4noxnvjR7eN9kfOCDV7rpaNr30g+qnPdq+cNgMs/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fV2wgwXd6wPRoasXB5QkQcus7peW+xBKv7AcNhj67M=;
 b=EKEXaX74X4Eh+zt0taQdJpe46Vk2T+/4LK8Bz4QYeVUM8y4UZ9799SK5b8fZsihpc4mIb3xFHsfe9bH93hsvPXUYpuXPeofxx0x2DGLHSgp7kkkxh/WSqWNundJqpMKuVBY2Kxq08nF9jj6wyK9PuL6SnwHXXjyAOWTFH7HTh59WXWG4F/loVzWHSkFGUYZ42dHDfNby/kKTMjt0d+hA9H2UYZxdl3ed7cK51znXvjPr4fVf8tPw6T65eEM9MDiMuhzpXE5RfgyYwYgtHEK4pE9uZWphATK/laJanrC1hDvBvUSTsTtCBP8a+iOEb+l2DQEBvarfjzQ89shPlqHwyQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB7235.apcprd06.prod.outlook.com (2603:1096:990:97::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.35; Mon, 14 Apr 2025 02:06:15 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 02:06:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v2 09/10] tests/functional/aspeed: Update AST2700
 functional test to use vbootrom
Thread-Topic: [PATCH v2 09/10] tests/functional/aspeed: Update AST2700
 functional test to use vbootrom
Thread-Index: AQHbqcG+a86eWFY6Bk+pSImGHfTqKbOeoGUAgAPPCMA=
Date: Mon, 14 Apr 2025 02:06:15 +0000
Message-ID: <SI2PR06MB5041B26ABF074372855EE55EFCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <20250410023856.500258-10-jamin_lin@aspeedtech.com>
 <cd0a32b2-9d1a-42f4-805f-307f3e2a7bbf@kaod.org>
In-Reply-To: <cd0a32b2-9d1a-42f4-805f-307f3e2a7bbf@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB7235:EE_
x-ms-office365-filtering-correlation-id: 272c5ba0-3b32-46dd-06a3-08dd7af8efee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YzY2MHpGdzVPQmEzbkhxd3loam40enNMbE11aGw1c1BOK2taOXlhclNjbDVC?=
 =?utf-8?B?ZkF4bHVvY3ZhK2x3Z3hPWTkzQTg1ZnRDbGcxSGdGWEd5VngySVNhQnJ3eXNp?=
 =?utf-8?B?eDRmMVpIcjM5N1l1c0JZZExjQ0NNbzhmQnRwOEI3TDErS3FGU1JVYmJTR3hj?=
 =?utf-8?B?UmdEM2dLL0pvRHFiSHRkRXBEUVFVZ2doWWlsOXVpbm5DSmE2UEp6RFpoTWNp?=
 =?utf-8?B?UnFjazhHbmd3NkNhQytDWGhTdnkyQlVxQks0Mk40TGRROWI4eGdtQzIva3NB?=
 =?utf-8?B?ektBQjg4YUZHVC9TckNhQUU0YWZ1WUNLTzNXb2RhZnRrL1dwWm5pT04vbW9K?=
 =?utf-8?B?RmNNQkdQR2NNQXNmbE5PMHlHVmJ0eWpBL3gzemlmVGh0N2o3enBxZE1mVHR5?=
 =?utf-8?B?SkgwK3Z2aGNvVU12OEdSTlhKZzU0NmFKMU1FT3RaSlpMaEJRSGZ6TW8yOTRi?=
 =?utf-8?B?WWt3SjZuTlFWOGViZzkyYnFNYkhmYzdoMHV2M2ZvYXFRWU5ucEwwdFp6b3pt?=
 =?utf-8?B?OUw0L1Rnc3RyZEZGMHhoMEU2Y3BuTTY0ZVlkSWN0YTlVZWhoY24vaURhOG00?=
 =?utf-8?B?bFFtc2pGKzZhSHdGU1VQd3g2YWdlSytUZFYvUDJXdDNNbi9uYWEyMVQvTzNG?=
 =?utf-8?B?a1dEYjJBWVZ4eU85N2FwQzcyY293bE55ZlBtZ0pKTWNsODN2NUc2U2JwQ3o5?=
 =?utf-8?B?c3MvVTd3c2lxWDVFcGc1SmNKMGJFMkZxTEdXTEs0L1NXczlhMHB4RDhSZUxm?=
 =?utf-8?B?N00vb3MyelNyMHMrSlVZOXdpWXUvQTc1YWtRaTY0TUFhS1BzV2xoK2pVZkdU?=
 =?utf-8?B?dDZKVUR2cUIvSXJ2enNnVmJOTFQ0a2Z2amtMS2VuWkVTdFU5c1hmMlZ5N3d6?=
 =?utf-8?B?d1lUb1UxT2ZmQ1dPc0RGUjRWVHRxaGhrV3NUM2Ewb1VkTFhBT3ZBNWx3UG94?=
 =?utf-8?B?QmhzM3RSL1RoeitZajVjMTdwSFQrK3V0Q1gxbFRMcks4REVVYnp5RlBQVHVj?=
 =?utf-8?B?MG91RWkzZFNFUkxId3YyQ29VVDVxVlpURTc2QXRRUlgzWmpTcHJsRERkQU9r?=
 =?utf-8?B?dkpXaU4wMkFkRVJFcjV1Z0VIOXdNV2wwMHNidFFHZUNmZlR1eXhWWEZva2pU?=
 =?utf-8?B?ZmF5VGlqMDZ1Sm1nT3A1dTYxeTRKNmx4ZlhIUFFOR3U3dnZMVEcwNE9kUDlw?=
 =?utf-8?B?WHd6UWVFZHo1eHdDbW5qenpWVU1kV0w3dGRDMUIzSnpKRFBDWVdSRUtZZU14?=
 =?utf-8?B?c2tVc1BrNnhHVkNPaVAraXQ5Q3dXY0dnODUvWVJhQ2wvT01ZQUhuM2EyR3JB?=
 =?utf-8?B?RnlPSTlUMXFCV0hGcUdjRk5SRkRFbWczUWY4bDhwNmxUWW1zUFJleUE3UDVk?=
 =?utf-8?B?d2lQSUpveEZFR29hbzN0UE1FU2FQcnBqQjhEbWJ6V0E3Wm92aDNycmRlazhW?=
 =?utf-8?B?Y3RTSm1pTHduM2hxM081TDM2RndueDArNnBlRDZvV1hqY2VESWlOK2hSeThl?=
 =?utf-8?B?ams3L2tJSHlVaEN4d2ZHMStSVGI2QjBWTXdjY3MyZFUyUmNYdDFLSVVYb3dQ?=
 =?utf-8?B?bkt4ZnNSWFI1Q2p4KzRRN2NIMFl6RUNHVExaOFhDVTVuY3FkdjN5QURDSnBJ?=
 =?utf-8?B?M25nNFFBUnBJTStvTmdNMVFtV3E4aWMxZFpXOU1lbHdmZGx4VjdRb3RYVXV6?=
 =?utf-8?B?ZnBWcXJjTTBiSUJmUWpXTlNpSzFNVm9EbWFMeHRCWmwyOEYvdG9KdlRWRTUy?=
 =?utf-8?B?YVZjdWhLby9ZM01ONkhMYjl2QlhUU0RzcnJFYTh5aTdBMFEwajNaSnQyN0Zr?=
 =?utf-8?B?WUMxNFNMVjZuV00wTXdKQUpPdE1VU0pQMmtPQ0w5bmdSdjBCQmVQNjlhMysv?=
 =?utf-8?B?WnY1ZEZwQkJjRitiNkxhdnNqbkt6eGZaRzBXNFpqcy8remlENG9INVcyeDBN?=
 =?utf-8?B?bUdxQWVSYlZGamVDdmNMMytFMHFUQ0htZnhaMXJWSVhGY1Z2QlBwME9lNkV0?=
 =?utf-8?B?eTk1OWswTndBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmRCYjFxcEJOWkdIUHRmWXZBWU91bG5ZZUhFSUZMN1I3RzIrdUZydEpVRG12?=
 =?utf-8?B?WHAyWExWdXFqNFN6eVRsQm0wOFRJRWFLQUcydVM5Uk1UNjNnK2Nnd1VwQ091?=
 =?utf-8?B?dnFMNmZJTmVvL1Q4THMzemkxdEY4aG1CZVR5R3E1VHYyM2tCT01HcnA2My9X?=
 =?utf-8?B?S1VZeWJodVVlajZ5SVEwRGpSbTBUTmNWbXBVQ285dGJhU1ZKV3pQWXNyNllh?=
 =?utf-8?B?T0FPRDZHdHBmZ2FGMzUxRlVpZTMyekg5NEF1MG1MdjV0dHJ3c2J6bzJwNENU?=
 =?utf-8?B?NlpqSjJqRUp4d2Y0Z0ZmTWcyTHhSMVpITDNiNkt4emhjSkxOQ0dvV2FHTlNz?=
 =?utf-8?B?QWhDTXk5TWVCL0xyeGYrbWRvZkdQeXBVN0VkNXhSeU9Ea3JoUk5iUGR5VkV4?=
 =?utf-8?B?Sk9GN2Ftd1hITWdyb3phRDI2L1Frd2prY1VNVWF4QmdrZXBZR1FPMkRwRGJC?=
 =?utf-8?B?bkEzTGxtRXlJeXNQUlpHL3pFTDIwVDdnTUxKZTdZaW9hVWdIY0NiS2t3Mm5W?=
 =?utf-8?B?NWJabVJSSitYOHJuRWJkWU5FN0d1SkZqU25qV3JVWVgvR0tTQzhRUDJZK2wx?=
 =?utf-8?B?VSs0VlNIcDFUY21ORUFwc05ZeU5nVkJiZHF6NGlwdU1EUDh6UHkyZlBXbXJB?=
 =?utf-8?B?eEU0ZDFkeXRRZWVHN0R3SG95aU9lcXQ5WWw1bXlKK3lsN1hxYkpZd1VSSERE?=
 =?utf-8?B?cEdEcVl4Q01ZOFNFajFDSDZGWkoyeE1DNCtaNVhCSkZmVlg3ZllZeEdpWkln?=
 =?utf-8?B?cGJrRStHZHdDYzY1RlREZmdqRGoxQVZoVHcxdTBZYVczVlo4T1Jjd3o5VThH?=
 =?utf-8?B?U1cydllhcE55aHAvRW5YajVYUmtpOFRHNnR5bFh6NlZ3VEVVS3RjV3llZlJF?=
 =?utf-8?B?NjM1SE5PNTFPRVNLMDZ4dmJNY3JSbnBxYzJxb216cjNjSkFiOXVZaW1CekhF?=
 =?utf-8?B?WVU2UGZ5bXpMUmhYczJ1QURIQjFpUkVKY0kxVktmVjJJcHpHOEJjVHllM1py?=
 =?utf-8?B?NW83TEFaU3VtSDJFcE1NR29zbytrbWR0S0ZmWnpSbW9XSmNGNWcwUklacUo0?=
 =?utf-8?B?VVY1d0Rxc3E2eGFzbUoySWw1NlhtcElpT3Z1L2pRTGFDUFZWcDZDdURCaEFF?=
 =?utf-8?B?bno1MFdJcnRvOHNGeWtvcVIydTN0Qzl4d2ZnMDVsU293ck51K2tUSFBnSFFs?=
 =?utf-8?B?dVMxdnZxckthMUFxajBaQzFqOFNrRnQxMGJDMFNPK2dEamxMNnlXMGZzZnRC?=
 =?utf-8?B?d0pHVUp4ZWV4dk1SUVFxY1BIU1QyUUlmUHpYV0RBWm5sS051M1lTdUs5YlRU?=
 =?utf-8?B?a2dKaUI1ZkFUMjEyMXdsdnh6V1RDanF6YlQwWTZxcDZobzR0MUc1QkFzRzBT?=
 =?utf-8?B?aXdkOThsSzRNZWpWWVFCWjczeVVTdEFSZFg5MDEwTm51bnZ0RHF1eXpjQ3I2?=
 =?utf-8?B?Tk1Nc2ZqVEdzMVJhSnR6MHRwUFJPeGN2UFREVkdPeGJySm1JSHZHMzlseWdy?=
 =?utf-8?B?WFh1cTFGd09UeHJaWWlmYmo1RE9ubWExMUN3T0lTZk9QYW4vQjZVMW5OZldu?=
 =?utf-8?B?UGN4K2hUNHNRQ0RsTnZYN3BZb3VCKzU1Z3RMb2J0M3BXbFo3cTNvWXBhSDFx?=
 =?utf-8?B?Y0RDa2F5UHVNdThoVXlNeGlXdXpmZmpjZlZudFZDeUFZR1pnczlWS0sxTHBH?=
 =?utf-8?B?ckMvVUtiUkhDSHZiY0xpZ2xwWWs3cjQ5M1REenBGN1lXZzVBYUw3MStGakVC?=
 =?utf-8?B?TE8yamxDVWkvQU44Q0hIT25IQXQ1RktMQTVYT29UOVk5MU5FOHhxQzVEdVRI?=
 =?utf-8?B?Y3ZsWjFHUWUzb3VvNGtLUjlyU1VDaWF0UWF1c3AxbFM5c2ZXbFBReDJBYWhV?=
 =?utf-8?B?Q3QrakxtT0g3ckZ3VG9lYlhWMFE4ODdXR09hd1Vad3Q4UURKY2ZncU45SFp1?=
 =?utf-8?B?RU14NlhPVHUxbWltdEFBekVZb2hkajVsZGg3aHZ3bngrUFI1cFdKTUFDTHBq?=
 =?utf-8?B?MXhVc2JRckJrb1NqeFB6RlpPQk9QNDQwRitxSHJ4TEE0QlVORE5yU202YkRp?=
 =?utf-8?B?VFQ3M3NuWlY5b2N0Q1hISXAzM1NIcEhZSGdUVlVFM2xoYWtYdW5PM2t3R1Uy?=
 =?utf-8?Q?BTHiIOIYFIYYUmv6ZbNdn6jBs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272c5ba0-3b32-46dd-06a3-08dd7af8efee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 02:06:15.1778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSzky7227ktneekteS9o8rBK20r1JcuKhp7CuB7UZOUTjIwePJXNaMiYOFJF2fYG3jVxNaOzmfEnNJBrTdbDmHu7IAfV8nyQ/fSF0mP/0YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7235
Received-SPF: pass client-ip=2a01:111:f403:2011::730;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDkvMTBdIHRlc3RzL2Z1bmN0
aW9uYWwvYXNwZWVkOiBVcGRhdGUgQVNUMjcwMA0KPiBmdW5jdGlvbmFsIHRlc3QgdG8gdXNlIHZi
b290cm9tDQo+IA0KPiBPbiA0LzEwLzI1IDA0OjM4LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gUmVm
YWN0b3IgdGhlIEFTVDI3MDAgZnVuY3Rpb25hbCB0ZXN0IHRvIGJvb3QgdXNpbmcgdGhlIHZib290
cm9tIGltYWdlDQo+ID4gaW5zdGVhZCBvZiBtYW51YWxseSBsb2FkaW5nIGJvb3QgY29tcG9uZW50
cyB3aXRoIC1kZXZpY2UgbG9hZGVyLg0KPiA+IFRoZSBib290IFJPTSBiaW5hcnkgaXMgbm93IHBh
c3NlZCB2aWEgdGhlIC1iaW9zIG9wdGlvbiwgdXNpbmcgdGhlDQo+ID4gaW1hZ2UgbG9jYXRlZCBp
biBwYy1iaW9zL2FzdDI3eDBfYm9vdHJvbS5iaW4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHRlc3Rz
L2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weSB8IDM4ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMzcgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNo
NjRfYXNwZWVkLnB5DQo+ID4gYi90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQu
cHkNCj4gPiBpbmRleCBjMjVjOTY2Mjc4Li45NzFmNTQ4NTM0IDEwMDc1NQ0KPiA+IC0tLSBhL3Rl
c3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weQ0KPiA+ICsrKyBiL3Rlc3RzL2Z1
bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weQ0KPiA+IEBAIC0zNiw0MyArMzYsNyBAQCBk
ZWYgZG9fdGVzdF9hYXJjaDY0X2FzcGVlZF9zZGtfc3RhcnQoc2VsZiwgaW1hZ2UpOg0KPiA+DQo+
ID4NCj4gJ2MxZjQ0OTZhZWMwNjc0M2M4MTJhNmU5YTFhMThkMDMyZjM0ZDYyZjNkZGI2OTU2ZTky
NGZlZjYyYWEyMDQ2YTUnKQ0KPiA+DQo+ID4gICAgICAgZGVmIHN0YXJ0X2FzdDI3MDBfdGVzdChz
ZWxmLCBuYW1lKToNCj4gPiAtICAgICAgICBudW1fY3B1ID0gNA0KPiA+IC0gICAgICAgIHVib290
X3NpemUgPSBvcy5wYXRoLmdldHNpemUoc2VsZi5zY3JhdGNoX2ZpbGUobmFtZSwNCj4gPiAtDQo+
ICd1LWJvb3Qtbm9kdGIuYmluJykpDQo+ID4gLSAgICAgICAgdWJvb3RfZHRiX2xvYWRfYWRkciA9
IGhleCgweDQwMDAwMDAwMCArIHVib290X3NpemUpDQo+ID4gLQ0KPiA+IC0gICAgICAgIGxvYWRf
aW1hZ2VzX2xpc3QgPSBbDQo+ID4gLSAgICAgICAgICAgIHsNCj4gPiAtICAgICAgICAgICAgICAg
ICdhZGRyJzogJzB4NDAwMDAwMDAwJywNCj4gPiAtICAgICAgICAgICAgICAgICdmaWxlJzogc2Vs
Zi5zY3JhdGNoX2ZpbGUobmFtZSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJ3UtYm9vdC1ub2R0Yi5iaW4nKQ0KPiA+IC0gICAgICAgICAgICB9LA0KPiA+
IC0gICAgICAgICAgICB7DQo+ID4gLSAgICAgICAgICAgICAgICAnYWRkcic6IHN0cih1Ym9vdF9k
dGJfbG9hZF9hZGRyKSwNCj4gPiAtICAgICAgICAgICAgICAgICdmaWxlJzogc2VsZi5zY3JhdGNo
X2ZpbGUobmFtZSwgJ3UtYm9vdC5kdGInKQ0KPiA+IC0gICAgICAgICAgICB9LA0KPiA+IC0gICAg
ICAgICAgICB7DQo+ID4gLSAgICAgICAgICAgICAgICAnYWRkcic6ICcweDQzMDAwMDAwMCcsDQo+
ID4gLSAgICAgICAgICAgICAgICAnZmlsZSc6IHNlbGYuc2NyYXRjaF9maWxlKG5hbWUsICdibDMx
LmJpbicpDQo+ID4gLSAgICAgICAgICAgIH0sDQo+ID4gLSAgICAgICAgICAgIHsNCj4gPiAtICAg
ICAgICAgICAgICAgICdhZGRyJzogJzB4NDMwMDgwMDAwJywNCj4gPiAtICAgICAgICAgICAgICAg
ICdmaWxlJzogc2VsZi5zY3JhdGNoX2ZpbGUobmFtZSwgJ29wdGVlJywNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ3RlZS1yYXcuYmluJykNCj4gPiAtICAg
ICAgICAgICAgfQ0KPiA+IC0gICAgICAgIF0NCj4gPiAtDQo+ID4gLSAgICAgICAgZm9yIGxvYWRf
aW1hZ2UgaW4gbG9hZF9pbWFnZXNfbGlzdDoNCj4gPiAtICAgICAgICAgICAgYWRkciA9IGxvYWRf
aW1hZ2VbJ2FkZHInXQ0KPiA+IC0gICAgICAgICAgICBmaWxlID0gbG9hZF9pbWFnZVsnZmlsZSdd
DQo+ID4gLSAgICAgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1kZXZpY2UnLA0KPiA+IC0NCj4g
Zidsb2FkZXIsZm9yY2UtcmF3PW9uLGFkZHI9e2FkZHJ9LGZpbGU9e2ZpbGV9JykNCj4gPiAtDQo+
ID4gLSAgICAgICAgZm9yIGkgaW4gcmFuZ2UobnVtX2NwdSk6DQo+ID4gLSAgICAgICAgICAgIHNl
bGYudm0uYWRkX2FyZ3MoJy1kZXZpY2UnLA0KPiA+IC0NCj4gZidsb2FkZXIsYWRkcj0weDQzMDAw
MDAwMCxjcHUtbnVtPXtpfScpDQo+ID4gLQ0KPiA+IC0gICAgICAgIHNlbGYudm0uYWRkX2FyZ3Mo
Jy1zbXAnLCBzdHIobnVtX2NwdSkpDQo+ID4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWJp
b3MnLCAnYXN0Mjd4MF9ib290cm9tLmJpbicpDQo+ID4gICAgICAgICAgIHNlbGYudm0uYWRkX2Fy
Z3MoJy1kZXZpY2UnLA0KPiA+DQo+ICd0bXAxMDUsYnVzPWFzcGVlZC5pMmMuYnVzLjEsYWRkcmVz
cz0weDRkLGlkPXRtcC10ZXN0JykNCj4gPiAgICAgICAgICAgc2VsZi5kb190ZXN0X2FhcmNoNjRf
YXNwZWVkX3Nka19zdGFydCgNCj4gDQo+IA0KPiBJIHRoaW5rIGl0IGlzIGludGVyZXN0aW5nIHRv
IGtlZXAgYm90aCBtZXRob2QgZm9yIHRoZSB0ZXN0cywgd2l0aCBhbmQgd2l0aG91dCB0aGUNCj4g
dmJvb3Ryb20uDQo+IA0KDQpHb3QgaXQuDQpXaWxsIHVwZGF0ZSBpdC4NCg0KSmFtaW4NCg0KPiBU
aGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

