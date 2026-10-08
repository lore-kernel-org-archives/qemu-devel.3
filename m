Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5859DCA6002
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEcNG-00022F-Gq; Wed, 07 Oct 2026 20:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xEcND-00021J-VN; Wed, 07 Oct 2026 20:52:39 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xEcNB-00011V-BB; Wed, 07 Oct 2026 20:52:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tesrIvTs9jxxijRwlghdYx8LOPLaCyj8fRTFp9ezBn9zAASbZmU/tOAMqOTYmAoGxpvyXnv00qkEZNF7X2VXjR99lzqvVv5XktikQpKijGoLFxxrlPEfPL9CBn3DBGkRf7D743Lr1OQ/UKlbjYtrAqFQ0wn6F/bSxCF/pBNL6cJ+8B2P8mDWlzMK5dRfkmW1ppntTf27VZGWdNj3DroHRydi9s8hZDRkDT8x0tDmEGJjAJVQciQ20Lg/anglCNIXi32Jw5IwuOx1a8Q00pwWBuEi9rdIeHuGqjuVz19Zu0wh1H1pxlIH+jSzY6utf4EB2QNRImT7tQYgJNpyGYx1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssSCkCzO7vYas+PUteOEfcj8kF1MYiBxupHGwBSvwi4=;
 b=Ed75mECJFFoOxub+nBC00XFd0tVvP/DHkdiaMQlykz1YQ/v5YonNhHSdE13/rXaG03uwbWLz+/6KaAlk/phcL6MwiugMqJq2WXnDWjKHExOhwdBP7tYVVq3w/MMQKTVLskV0enc6XpJIDhnO1N3HjAEM8/eYEt48YZq660UpfKl/bY8126AmtlGEg1HgYo/MdKihhq9lhEBgzY6T1Ot/cM0ODlRWio71V75v4ftjv6Zh26gmeqq9VpULjcL5CGbCS5cbRkTHkEt2ukog0dTk7TvQ6YvcJ1k5ld247YtjxSP52dSdro+jWeZzFzQU039KSXI674i6IvKFlBwOhiFZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssSCkCzO7vYas+PUteOEfcj8kF1MYiBxupHGwBSvwi4=;
 b=T1lDIMRZanN5rp/aeNv9RF8I8llZCHMzn59sI9wBoMaUVw6Mgb3LewME4NQ2yUCcfpxBAZhNFnvGr5W1jLrvWIHgjCOiisa3hGdlzL4as7jKSVqeDrghDLn/F1u8s4WhI0rrfg1YlcqwWjW9FAZKZxOwNcngJrcDQuFS/TcWXYOmu6m8blBBu2TNzjjxO0xAvGaD/RwuQUl7AzxDZxjs5ILmIQLHYJ5YPGiwvEDvvWZZYLYUy5xaAw4Q3nFo/DO6k4J0Q81esmFUFWB2pLLQqJM1HPcFkGAmoPAOjL4YfQuTr8h87O2ZSwQaK4PPu7KPKH/yVGQzEDyKJAU1BB4SBw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5278.apcprd06.prod.outlook.com (2603:1096:101:83::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 00:52:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 00:52:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 0/2] hw/arm/aspeed: Sort device IDs and add IO expander
 test
Thread-Topic: [PATCH v2 0/2] hw/arm/aspeed: Sort device IDs and add IO
 expander test
Thread-Index: AQHdVG3aam/kyjNjPU6o7ye/dCCf4bbyEa+AgADCa/A=
Date: Thu, 8 Oct 2026 00:52:28 +0000
Message-ID: <SEZPR06MB73628EA88DE1E9610A0AB88FFC932@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
 <809fa0e8-889c-43a6-95bd-6a536b6bae93@kaod.org>
In-Reply-To: <809fa0e8-889c-43a6-95bd-6a536b6bae93@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5278:EE_
x-ms-office365-filtering-correlation-id: a7c8dedb-e91c-4122-8dd0-08df24d66d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|4143699003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: VLz7olM395/VCwaAUhVGZoh8gEGpvL0WlGavxhE4sp/8iQGlNKuUNTu/eWzYd+RzOmSgLLo7pZRL9l6ThAmhBAb9k6T9d41iyP8PPuSc3Z09GYQ4YoqDxct+/+S4BbkVTiwesq8Nmtz4VCsBKMZiLtwKGKfPLIA7ZuXhtSZW9DXrggSHKCh5GGbe2KoKgnWz1N2LR3cP0mc040DycgPvZjJbGZQG9Yjc1PTXuVknneuxyHaFVkCOqcleLD3/EyaiAnSo9fFWi7PhmCabD/gmOPbLcs017xyj8+hi2PCLa9a8OqiCBxFglRzrN5MJuMpux4UwfZS0HiCvvLhCx6frOpNW2oP+Z1cmFtWkEbxYixVPbtDaghN/VJ9T2BQp12Ej+NS3oSFD9a++9HNSSN+oQe6as8esFqjsZS/gECK++zpNaGbVCa4kePrF3WIU2xyYGV84R/RxXua/RiRa3+PW1reCtDdIpCo8NdNSuN82ul6w4WzBEAg7rklRRT2q0P42hcU+Pd4ifAHYapvw3NYrvvzYXhxF2M7IaLRMvL49htRFlqUzebKxynMLYYGwNS7zJquxLnYMvvT1PWBaCVlOmVNTDnr4C2hD37Uz1Ic6LGT5KH8R8YrAqTTGVPRgLlOmYMV2ZcoMNpn3q1UtVLtlvC3CyHoIKY5mn2HKeMkEedc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEhDMkEwLzh3QVp3OUVnZWZoTHRGNGZ5UnQ1MzhlbGl2bDlraXpvak5tWWxX?=
 =?utf-8?B?cjhNc2xmZjlPZWxmekNOdEtLTzN3d2R6Q0VDbEpzTWNHMGR2UDloZmdtQ08v?=
 =?utf-8?B?T1VTSzZ2K2hFaGpTTDBldDdhSUcrVERsTjYzYm8rZGU2VW1QRXJoMmZvNThG?=
 =?utf-8?B?SHQxK3BBd09aWVo0andBaWlRcXU2WUNiNnZCa2cwTlNDWFFLMmU1Njh5SkdG?=
 =?utf-8?B?VVVvNC9TVUlOMzNKUnVDZ0xqMU5FcFNkbHNoZTY2aEx3UkJDdjUvcnFBemhP?=
 =?utf-8?B?QkRLa1lDN2x6TUh0OEVKdE0yM1NWdkdYTEZ5Tzk5Z1FlVHNMcFBaOWhPeFNM?=
 =?utf-8?B?bDdMSzh0ZmRVa3RhbUVrdHp5a2d6WTdtZnJ1dGR0MW5vYTJWem42cG5oVHZF?=
 =?utf-8?B?ZlZCckNWZVFLZmxDVUpRYWcwN2poN1R5WkNWam9RYU1RcHR0dXJoUjJ4VEJX?=
 =?utf-8?B?WVlEaTN1L2lpR3BHeTQzZEVoSksyQmFrWk5DSktNd1RDOFJlSCtLUjY4blNy?=
 =?utf-8?B?YStLNnJGQnplTGN4djNEam05amlGNW9RbGp3UTlxUmRNNGJTaUxrZmkvbjBV?=
 =?utf-8?B?cFEzdUFDT2VoYm9MbVpFSXhDaDdYbUR5ekpzMkpMaE9qYnpWbXBDWDd3T3pM?=
 =?utf-8?B?dVRtakJ1QkJKWm5LcW51KzlqVlIzRnQzRm1ka0pYUnRVUDlXaEk0MklzMHJS?=
 =?utf-8?B?RDBMRENRdUJtWGxSUFRDaUJERWcvQmRuVHJXY3V6c0k0U29EMDFidHZnbW9S?=
 =?utf-8?B?cGRiZUF5d1haWjgvUkxpT2NoYy9YNE1JRGtqVEZLVTdwMlc3TFUwRzR6b0U2?=
 =?utf-8?B?QUhaMXhJQ2x6ZkNyYjIzZG11d3ZFcXRpQ3krZFlwa3R1cUFjUktmMXlObmp1?=
 =?utf-8?B?dExlY2ZJV2QvOXp3K1licmlzeWxxeXc4WGJGZHozTTB3SWRFNmpUSDF3VGlH?=
 =?utf-8?B?NlZnSXdOT2FaczQ3bmRuYlJRM0Y2Rnc2a3VzcXp0bHNaTkJJcW9EWGttQS9C?=
 =?utf-8?B?Y201MHh2ZkpjZndvRW8zdlVoS1pmMzBSVWtGbEJ1YW1jL2lSYyszbUVDM3NW?=
 =?utf-8?B?ZnJsSEpFS3BBRFF0SmlwUWxpZnRjRitCaFJyaFlmR3B1cUpmUEJSNUZnaGVC?=
 =?utf-8?B?VVVxSVh4azdCUHVMQ2tMZXlJWTIyMEQxNW1wR3RQdWtROCtxV1dMVjFDQ2RB?=
 =?utf-8?B?U3dXbWc0bWk3R2Vib05zbXQwcXMvSEgveDNObWY2Qjg2c1N2T1FzR3gzQVI2?=
 =?utf-8?B?ZE5yUUVzTnNFZHVCRHY0YkRNWnZWaFlKRDJGRTV6bU5PS2hub3dLb1pJQWpv?=
 =?utf-8?B?elQyOHFsUUxVR3dVck1XWU9XbnhwM0pIb2o3UDJPZ1FsYWJZVHpUOWdLam5Q?=
 =?utf-8?B?MU55UWhkK01QME1qYlJ6VzU2RGdKK1VWSEgxYlBCRkM2aC9mSGRhOEwrRWtW?=
 =?utf-8?B?SGJUUkNGR3ZDMTNXbGlaOWNkMFFHYTRwZU81YmU0YUFFa1hNZ2VSQWl2Y3Bv?=
 =?utf-8?B?Ti9LUFQ2L3JQUmN5ejhCbDEzcnYrOHg0cG9VYTBTRVNweTNUbDRwOUcyTWov?=
 =?utf-8?B?b3JrTUtlOFYzNTdrNjlDYWFEV2RDV0JZRWk0N1VXOWFmWlRnL0FkRTlvN1gr?=
 =?utf-8?B?RG5YMWorVndQZWZCbHN6dVZmT2V6VjcxWTQ2d0hzZlF6eEhZMlhXZ1hROENI?=
 =?utf-8?B?WlN0QklyaFFUVkovM2RJZk1yQ3M0amVJSlloSmpsbTdzZnBXZTR4cjJidDZq?=
 =?utf-8?B?U3djN1VNRFY1Y0FTKzVjcUZHRXVPcTdkRk1tN0hLQlJiZFFOVmpzZjVXaXVR?=
 =?utf-8?B?a2w3d0hpNXhTZmZFQW15eGFDbDB1RVdQY1VGRkw0RXJQelJvN2xCNmxVSTVH?=
 =?utf-8?B?QTJqOHRNdDc5c3MzS0xHSmtlWm8yMk8wUWdFNUZaT29OR3Z3U2F1K2ZIL0Zv?=
 =?utf-8?B?UHgvZXMwR2Z6d2hrdm95MklJTnpHL3hQcjhhZVF0UGljbXlCcjgrYlJGTzVF?=
 =?utf-8?B?cExNbElSUUVRVjE1NXludHVYampWdEVJek03aGU1K2s4aUdMSlA5WWlWOEtH?=
 =?utf-8?B?OGxqWHBmOC91QXNJaHE5bzVXOFNKellGeWZpaGRHRGxISzh1b0NJR2gwMXhO?=
 =?utf-8?B?ZkI5VEM0MFlvVFpjeE5PSDVqaHR0ZVVyeVZtWkxYS3JlUGRubFRFK2tKa2t2?=
 =?utf-8?B?M0ZybVhIbzRwS0MzbWZOVmRGcXBPNnFxVjUwajQraUZodVpOaGkwOUpRUnla?=
 =?utf-8?B?SDhDOXlOQ1luS0Nydis5OG1DV1JOdmR6TzZDeHVEeWI5ODRTQWp1WDN5SzQz?=
 =?utf-8?B?WHNRNDdhZnBTMThtNGRwbmtnZ0E4UjYxd3NtY3VhN2E2bU9MRVZtQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AvxjCfFiB2xK0ZWVgjQGCuVf6YGKNeTq/UeElS2hM9LpRxJbT1jPI1RSdi9IoqPCkZI0D3+8RcGLwV6d0691wEcsmXP4vpP0vlAZQt4ezBaj+NhuHYtc7i6nNUwLq2shoB433Xs99nk8hxZCUv4G6hnNP4/8qSFxxnNxrWVIUEfinbzzKQS1nrdnyvsopaA++CjnJUMrjFHkoEDawM52Unq1dQNZ8mD01KKSupfa3Ej7GHnDbZLk9Fp1aPebjHyIk5Q1T8WknMbCZQ6bDGfoVdnHmhiC2DIhqE0ZVev2Sy/xJaZv3On73XaqLYxNSzsr27nJnCz6eWbLbmUC0uaigg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c8dedb-e91c-4122-8dd0-08df24d66d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 00:52:28.9791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSMUTPr+i9L2gwKE6MdCjNtujnjC8DnHj3Mq5c4PuS54uYrFBlt+G1k6iOwIIqvk9OdV0Y0Tsro0hzcgy8apCl1Fe5+9UJekBoxO3FTu3W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5278
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC8yXSBody9hcm0vYXNwZWVk
OiBTb3J0IGRldmljZSBJRHMgYW5kIGFkZCBJTw0KPiBleHBhbmRlciB0ZXN0DQo+IA0KPiBPbiAx
MC81LzI2IDA0OjA0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgaXMgc3BsaXQg
b3V0IGZyb20gIltQQVRDSCB2MSAwLzExXSBody9hcm0vYXNwZWVkOiBVc2UNCj4gPiB1bmltcCBh
cnJheSBhbmQgdGFibGUgZm9yIHVuaW1wbGVtZW50ZWQgZGV2aWNlcyIgdG8gbWFrZSB0aGUgY2hh
bmdlcw0KPiA+IGVhc2llciB0byByZXZpZXcuDQo+ID4NCj4gPiB2MQ0KPiA+ICAgMS4gc29ydHMg
dGhlIEFTUEVFRCBkZXZpY2UgSURzIGFscGhhYmV0aWNhbGx5Lg0KPiANCj4gVGhpcyBpcyBhbHJl
YWR5IGFwcGxpZWQgdG8gYXNwZWVkLW5leHQgYWxvbmcgd2l0aCA6DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MzAwNzI1MDEuMjYxMjExOS0xLWphbWluX2xpbkBh
cw0KPiBwZWVkdGVjaC5jb20vDQo+IA0KUGxlYXNlIGFwcGx5IHRoZSB2MiBwYXRjaCBpbnN0ZWFk
Lg0KDQpUaGUgdjEgdmVyc2lvbiBicmVha3MgdGhlIEFTVDI3MDAgSU8gRXhwYW5kZXIgMSBmdW5j
dGlvbmFsaXR5LiBUaGlzIGlzIGFsc28gd2h5IEkgYWRkZWQgYSBmdW5jdGlvbmFsIHRlc3QgaW4g
djIgdG8gY2F0Y2ggdGhpcyBpc3N1ZS4gDQpBcyBhIHJlc3VsdCwgdGhlIGZ1bmN0aW9uYWwgdGVz
dCBjdXJyZW50bHkgZmFpbHMgb24gYXNwZWVkLW5leHQgd2l0aCB0aGUgdjEgcGF0Y2ggYXBwbGll
ZC4NCg0KVGhlIHYxIGNoYW5nZSBpczoNCg0KQVNQRUVEX0RFVl9JT0VYUDBfSTJDLA0KQVNQRUVE
X0RFVl9JT0VYUDBfSTNDLA0KQVNQRUVEX0RFVl9JT0VYUDBfSU5UQ0lPLA0KQVNQRUVEX0RFVl9J
T0VYUDFfSTJDLA0KQVNQRUVEX0RFVl9JT0VYUDFfSTNDLA0KQVNQRUVEX0RFVl9JT0VYUDFfSU5U
Q0lPLA0KDQpUaGUgY29ycmVjdCBvcmRlcmluZyBpbiB2MiBpczoNCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL3BhdGNoLzIwMjYxMDA1MDIwNDI4LjM0OTYw
MzktMi1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQoNCisgICAgQVNQRUVEX0RFVl9JT0VYUDBf
STJDLA0KKyAgICBBU1BFRURfREVWX0lPRVhQMV9JMkMsDQorICAgIEFTUEVFRF9ERVZfSU9FWFAw
X0kzQywNCisgICAgQVNQRUVEX0RFVl9JT0VYUDFfSTNDLA0KKyAgICBBU1BFRURfREVWX0lPRVhQ
MF9JTlRDSU8sDQorICAgIEFTUEVFRF9ERVZfSU9FWFAxX0lOVENJTywNCg0KVGhhbmtzIGZvciB5
b3VyIGhlbHAgYW5kIHN1cHBvcnQuDQoNCkphbWluDQoNCj4gPiB2Mg0KPiA+ICAgMS4gU3BsaXQg
dGhlIGRldmljZSBJRCBzb3J0aW5nIGNoYW5nZSBvdXQgaW50byBhIHNlcGFyYXRlIHNlcmllcy4N
Cj4gPiAgIDIuIEZpeCB0aGUgSU8gZXhwYW5kZXIgZGV2aWNlIElEcyBpbiB0aGUgY29ycmVjdCBv
cmRlci4NCj4gPiAgIDMuIEFkZCBhIGZ1bmN0aW9uYWwgdGVzdCBmb3IgSU8gRXhwYW5kZXIgMSBJ
MkMuDQo+IA0KPiANCj4gDQo+IEFwcGxpZWQgcGF0Y2ggMiB0byA6DQo+IA0KPiAgICAgIGh0dHBz
Oi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11IGFzcGVlZC1uZXh0DQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBDLg0KPiANCj4gDQo+ID4gSmFtaW4gTGluICgyKToNCj4gPiAgICBody9hcm0vYXNwZWVk
OiBTb3J0IGRldmljZSBJRHMgYWxwaGFiZXRpY2FsbHkNCj4gPiAgICB0ZXN0cy9mdW5jdGlvbmFs
L2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGEyOiBBZGQgSTJDIHRlc3QgZm9yIElPDQo+ID4g
ICAgICBleHBhbmRlciAxDQo+ID4NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCAg
ICAgICAgICAgICAgICAgICB8IDE3Ng0KPiArKysrKysrKystLS0tLS0tLS0NCj4gPiAgIC4uLi9h
YXJjaDY0L3Rlc3RfYXNwZWVkX2FzdDI3MDBhMi5weSAgICAgICAgICB8ICAgMyArDQo+ID4gICAy
IGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKyksIDg4IGRlbGV0aW9ucygtKQ0KPiA+DQoN
Cg==

