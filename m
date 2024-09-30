Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B82DCF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 06:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv9T0-0000Us-97; Mon, 30 Sep 2024 02:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sv9SP-0000P6-LO; Mon, 30 Sep 2024 02:00:31 -0400
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sv9S5-0002YH-9P; Mon, 30 Sep 2024 02:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzHk0vcDYZTWYcIt0ySgavBfWMq6XVZGRTGrTJ6QCGlOlIcBMZv7RLwbeJ2P9XLnR/MScrc+MXrykE7kibVvs9oOtvRfJ5nv/W9V5tiz7RusyOyHBDr3Z5OWeguI70vacBMHYU2rsAzAh1jscDQcOPWQQbIgNV9btMr+arM9LDZd24TJ/ciynTj5On9aeh5VN2YeZVvLHRlDg1DYSnPyas8Pc9aqKU0uZZy2q/conLv7etkJmcdRCdBUHl6KvPfDD6b2znkRsHT/FU+IdGp49nFqCglJh0Dn6Fsm5yO1ThIxXIIeKz+7q2MAbGp+nSaVD3pCYlkqj6HBn2NU6AWvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM/iun4QMiuYG5THXdo4n17wz6Mz2gQOcLr1ZoZIxhU=;
 b=F+DaDR77IkatvUfVmOT1RFkXhMZVkigiFfuryJjK/tqDf6KncS6C0bvW77LhmSc+zhRV8rZF76ztj1pDU2HD+JqufmtArFkCLoTuLQyICvIYh/U/v3KcUK9DF0PgyXUK/OeGsZwVQ7weZnUGzZh6rpjAW2Yu1Bn+WTMpUmNgEg9EYmOUinxzPp88vHwh4A2viX0ATw7quTc3obaigxrUaEGHDAVRaT5ZXrVqnWa7E+RRRk0+9r9VWzCbWoX8yIil4NV2qSh4XA/8EYulnSG/XznxNDNtAl4y6p7O6O8snr3O9zddtLp5m3efHg6R9G9KHE85z39s3GET4kEvE5Av9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM/iun4QMiuYG5THXdo4n17wz6Mz2gQOcLr1ZoZIxhU=;
 b=mKLH5oe40PMurVMjzt9GGQ/nMPvliz5D6DZktf2Z/puM8UQ/ct1ssTByxZS02uBEK3JbgMAv5gkG6Zs9j7PYoTwwAHVKJi+e+I2QSwNAMOaLJD/DBmozN8smiNz34aUuoqHgzkOj5z1IIA7emGW8HZ4/Gy8PDb3AvCjO9HPVN8QSm+lBX368oSj6jX6hvChLxYS82IJgP+cvxpnRYEQC7u9GaL5mlnepzBDgk4glIX+2De2IOWHsn8WQl5uTRwDDViws4xoCPY3qatY7aar4RgqUDIieeo+CmiBoiB2U93XRuIkeTS/hMj8O4XiWojyxr3IJ+BtMA6fZa9a1ggaMMg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5012.apcprd06.prod.outlook.com (2603:1096:4:1c4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 06:00:01 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Mon, 30 Sep 2024
 06:00:01 +0000
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 0/6] Support GPIO for AST2700
Thread-Topic: [PATCH v3 0/6] Support GPIO for AST2700
Thread-Index: AQHbD+gVwmQ29c/aREKHLSGeVLq1VLJqPfuAgACof6CAAEMygIAAAy6AgACDmoCABCsjAA==
Date: Mon, 30 Sep 2024 06:00:01 +0000
Message-ID: <SI2PR06MB5041A8A56045D5473DA4162AFC762@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <e1076f8e-2e32-41ba-adf4-8e28aae8e526@kaod.org>
 <SI2PR06MB5041AC649E5F76F2700A42D9FC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <1f517713-bb9c-420d-8dce-9423123a3eab@kaod.org>
 <SI2PR06MB5041632B8C7403F6B4B9D4F6FC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <20240927-nondescript-fat-ringtail-e13a10@lemur>
In-Reply-To: <20240927-nondescript-fat-ringtail-e13a10@lemur>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5012:EE_
x-ms-office365-filtering-correlation-id: dab2c519-c674-4032-180a-08dce1151f16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3JsVVFuOHhXNWQvOStuYmtrS0svSzVhOCs0WlN4SVJLUEZMaC80WEswNnR3?=
 =?utf-8?B?ZnpsQWN0UHBoUHJpS3p3Z3FidngvSXl2ZHV6UEJhb3kxQmRnL2ZVRFpFWlFh?=
 =?utf-8?B?dzhVcUhnd0xuNlZHWTlSS3g2dncvV3JielgwaXRIcTRtZ2x6VExWM1VmRm5k?=
 =?utf-8?B?ZE9RUkNuanhNcmNWOGF2Ny9tdlluN1dKOWhoS1NQTGxlNjFqYlRtYmVuQ1BW?=
 =?utf-8?B?L0VvKzNRVlI1dWhDL1E2REJPeGMvZjdBY1M1T0JFVThwaDlJNVh2eE9sR1Uz?=
 =?utf-8?B?amFsVlhPc0JSblkvN0dYNXFOWDB5SUhrZml6NE45eUVzUmJKaVk5c3NHaGV0?=
 =?utf-8?B?YlJlODUyRzBjREtEMzA4R3Zkek94ekxOayttTExqeUpIRlRXQlNaNHFvSDFG?=
 =?utf-8?B?eDRaMS9kRHZIZnZ4UCtyUW1ldzBRT1BTYnJXOWZGOVRQTkJqNkFneTZoMG4v?=
 =?utf-8?B?Ry8ySGlYWWhydnZxcFZZRXE2MHFmRm55R09rU2pOYjNONUJYN2x1b1IxYVl5?=
 =?utf-8?B?dkhtVTlFRGUreHdYK1BKNUtKTC8zRDBjNkozZFZLYmp2cGx1OXpDaWtNcHJt?=
 =?utf-8?B?QkpQN3JWWmp5TFBYb2dNSDhpRDhxL25VMGxVa0pjczFhdStVOTNHZE1hSGY3?=
 =?utf-8?B?UVhBYkJKejVVbVl2RE5GeGZTQVJHbjg0czQ1NSsyS2Rvd1A3dWFuV2dsS1JN?=
 =?utf-8?B?cERmUkJrWFJMMkxoaEhtRjVMcnIxOWxGVnBPSTJ3Nk5MZS8zekU1dVJhUG05?=
 =?utf-8?B?UWcvU1Rrb1lZZXF1MXRyNGc2bDNHcnRjdWhvM25neHFwbHdCZXFFcmc2T3JV?=
 =?utf-8?B?cjVWSTBjWFdGNUU4TUdvcFN3M2tpeXFZcHhIcmdmYVlnRlFoTkcrQ2RjQ1hT?=
 =?utf-8?B?SHRSRTQ5UUlva0NUK2dYc0J1TXBod1VSbnMvTllkQ2k2WFVsMG5JeW9NQy9K?=
 =?utf-8?B?Rmp1Z0ZjbVJqSUxvRldDYkV0Y2RTRW95aGFGMHZvZkU3M2xCK1BRNDVrYnEz?=
 =?utf-8?B?QmExT3ZUZTFoOElZNlZHY0tpc1lHVWJKY2ZpMlZmcE82U3RRZVV4TjBNOE1D?=
 =?utf-8?B?WENyVjNjTmlTRjJyYTczS3EvYXF2OGRXejQ4ZlhwWnBjbE85ME9nb0FUSEFK?=
 =?utf-8?B?TVFGdFZ1NVVNMHZDN2tHcldDMVl4LzFZUUtDbm9WU1pqaTFYQlFFZ1hmYlJr?=
 =?utf-8?B?L3FqNXQ0VnJmdVFkeWhwamh5RFJuSUdFZm1qOXQ2MmI0TWRwQVB6WVRzY21G?=
 =?utf-8?B?M3BNaEhWcTJ3WlZPcjkxUm1rbkU5RThrS2tlUlc5TVJDNFMwNnpGcWl6TXlq?=
 =?utf-8?B?MmQyVkZKcVVQWTBLOU9Ob3VEY3NKQm84RXlzUGdXNzhyQkg5QjdrdkQ2dWlM?=
 =?utf-8?B?MVhuZUVJcFlNMGRKVVJuVWt3SFdMTy9PcDNFcVIzN0JQZU1wSDFvWExST2pF?=
 =?utf-8?B?VGJQam1sN0wxSHBxa0JhS0FNNm5ndktPRDhaUStuSHl4aDE3ckxMWkxjVU5u?=
 =?utf-8?B?UWx3eVpib283TnJpeXd4bDNLUzJKZ0ptNWovbHp0Z0dBbk1HU3ZiSHNDbzJp?=
 =?utf-8?B?Z1BOTnJzUHZaRHRoZndVUWw4MEFLREsySTdLK2RiT3dpdkk5SzJUOGMvckxR?=
 =?utf-8?B?TWNMTHFadUVRSEhBa0RFNmZ2REF0OUdqQm9nTUhmK2krbmsyb3NXdlVYOGJH?=
 =?utf-8?B?NWN3cjI1a3B1cU1OQUJ3RnRqNlVvYUt2NTR4eitYejVOV0VnUXZkU1lJYmRO?=
 =?utf-8?B?cjZ3QlpsUXJ3RDN1SVRvVzVjWkN3aENWSWdkeHVJUnpQY1RIOGJrMm9yd3Yx?=
 =?utf-8?B?eUJzYTZwS2FYOG5WNjZ4UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGJVYmZ0NHlEL2lKcEtGdm42WUpDZlVWcVR6MHZ5ZVV0cStKSnRJTDhoSW9y?=
 =?utf-8?B?N3JyS0hjR0t4SitIbnhhcnd6YTJKc3N6d2JFUzhkelJGbFlGZWhtZ0JQNnRL?=
 =?utf-8?B?eDJvayszZzRRSEtXbVpFZFlzRld6OXdTbEppRmpiNjlIUjNKR2VsOWlFVlUr?=
 =?utf-8?B?RndMWE9hbEFMTTgyR2J0TUpld3pDWHdpL2FzNE1jSWVtS1k1NGFIbkFGcVUr?=
 =?utf-8?B?a0tRWkk3T0RjbWhJbVpmR3VRay93a2ZjbzZLa2ZhSEZxV3M3MklodWswZlZU?=
 =?utf-8?B?N3NGRndaMGRvSytUbGQ1V1JWTlBTemp4eUY1Rk05ZkNjUWc4RjhHMGxUWStM?=
 =?utf-8?B?Qm9OUExEV0ZLUk1hUGM0Zm84NEErcE5PNEJXTWdJaXE2UWxpeWNpQW5Mdk1J?=
 =?utf-8?B?cmNwR2xCbHVwNGdyOUJQVGRWVHZwL3d1NmkvK3FWck53dzZTMjZmckdaanNT?=
 =?utf-8?B?S0s5RUhTWEtua29qTlhrV3ozK3lRc0F6UVZkTlM2a2xiRDNKMlJKczlxaTFY?=
 =?utf-8?B?YWJqVmF2OXpxb2gwYjlOR0tHL1ZwTGVXbVo5MlV3NVBEZ0JhQW9COThDSENC?=
 =?utf-8?B?bFlWYmNIaG1mSmlPeHZXK2VuU2t2aGdnRFZONHRnV2NFclZIakY1UEFSYjhS?=
 =?utf-8?B?UTBFL3V1aFREc2hLK2phdzYxaDhPb3hvZTVzZzVmK3UyWC9uOW5CcmtHc3BD?=
 =?utf-8?B?czNSYWIxQU5OamV4d1NQeGgzeTZFR2NBem9KektPSUxWVkNpSXA3TUFQNzBr?=
 =?utf-8?B?Z3N6cGZkaHJuU3Zwd3gwVzdNSHFUQzljTnY0cTdFRksyZXZidVRNZDAra1I0?=
 =?utf-8?B?ZVIrQ0FxWExNMnN6d2haV0dUeHkvK2szcnZyUm9ha2NjYWtxK2dIdC9qMS9w?=
 =?utf-8?B?RC9JTmJCTFFOb1dmdDhPaDBFbHdjRGJvM0RuRzNuMWNsVmozQjRteXc0ZlRJ?=
 =?utf-8?B?eE9KQThtdlpQMGNCSk9oS3VwSzErTGdSemh0ckdrQVBUdVBNc09uN21LSUdM?=
 =?utf-8?B?Sm9VWXJpWk8xMnZ0MzluV2NRNnliNXFod1ZJVk0wTEgzZjBmZHZHRmZqNFU1?=
 =?utf-8?B?Q2o2Skx6Q0hoWm5PTVZ0MFhWRE1TYThWVmlsRmpmQ2ZxOU9aZE1FWFZGallh?=
 =?utf-8?B?Yzh3VElJYzllSXVqTzNvRWdwd1YrZFF2QlpEOEJReFBxakgzRUhJaXpISGxZ?=
 =?utf-8?B?eDJ6N29jKzFsNXhOeGFJMEhtSDRPVzJXcFM0OE5TbmtXWWowS0FDcnpxcGNi?=
 =?utf-8?B?YTBvWi91M1VSK0tpMFpUUTdOTGJIZ1FINUpyanI3TmQrWWJRU1JxN0hpN21H?=
 =?utf-8?B?K1BNb0tNTGtVQzlnR3ZSNVRjVFJBNldOYVJNKzVDYmdCWUxTeTM5VFcvYzZ0?=
 =?utf-8?B?VFF0ZHhNWlR6K2VvalVEd3VtUFR1ZVQ2bjd2REpzQmpsZzJqWWpBcXZhQjBT?=
 =?utf-8?B?Q3d4Q1ozbmpZcWg0WXRJdTVaRzZha0pIMDRZTEN4WEpNVXhwSUNwalN5NXBY?=
 =?utf-8?B?dkdPeUgxdG5aSU1CdjRCcGdLODBLbFk0Znd6N2s4dE1Bamw3VmVhZVlvNzVX?=
 =?utf-8?B?aFFuTCtZdklPRFRMT21ZdUllekNQbnpaTEtZdnFtZ0k1NlplZmsvZ3NzWVJ5?=
 =?utf-8?B?STFoNFVrVURpTmlUSjRtbzg0ZmIrZGJrTWtUYUdsZXpoUDJhb29zUlR3Y3l0?=
 =?utf-8?B?OFJKREZVNytkb0xBTDY3MWpxYUNiSk1ON0FVdVRrVVl1bmhzYW1yeTh5TTNx?=
 =?utf-8?B?OFhERm5sUVUrenRXTUM2RXFWMlBMRnBDR0xnMlJyWkNVOXU4ejBHb2ZvbU1l?=
 =?utf-8?B?dFQ1bnd1dW1LbGI0VTc0YXEyMVpVb2tsVVR3aUxIME42cEVzL25tcW1JaVZZ?=
 =?utf-8?B?RXg4dlhOS2ZtM1lnK2RKQ09FK2JVcXgyakI4SG1RV3JYN2Q1M0ZqaW9Bc2hB?=
 =?utf-8?B?THJpUitsQ2IxV1hLb2E0R2haT2oyVld0cEovcHdqSEZwNC9ZTnNjcUFZZGRX?=
 =?utf-8?B?MEs1RXByenJyT3F2L0hMQnROcTZzaEkvRERmd2U2b3F3WGNXQkY4YVpkR1dM?=
 =?utf-8?B?K0NIWm5YNXlZdUdFakVta3JFeHg4WmFQMXJFUTVCcGUxMEpCRG5FUHk1L1dN?=
 =?utf-8?Q?L8xs1Dp5J7dIzu/X1psE9wX6E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab2c519-c674-4032-180a-08dce1151f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 06:00:01.1404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipKZS2DRFNYrd31SwDD7bwLy+0j8VZ+ttKFqS9fWHG1hPyWh65DwhSx0qf8udhFsZ2uG48nrLS7BsbeWz8UBGQZrXdwGG2gwgxBH2oup7Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5012
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgS29uc3RhbnRpbg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC82XSBTdXBwb3J0IEdQ
SU8gZm9yIEFTVDI3MDANCj4gDQo+IE9uIEZyaSwgU2VwIDI3LCAyMDI0IGF0IDA2OjI5OjIyQU0g
R01ULCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gPiBBbHNvLCB5b3VyIGVtYWlscyBoYXZlIGFuIGlu
dmFsaWQgIkZyb20iIGZpZWxkIHNldCB0bw0KPiA+ID4gInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIg
d2hlbiByZXRyaWV2ZWQgd2l0aCB0aGUgYjQgY29tbWFuZC4NCj4gDQo+IFRoaXMgaXMgYWxtb3N0
IGNlcnRhaW5seSBkb25lIGJ5IHRoZSBtYWlsbWFuIGxpc3QgcnVubmluZyBvbiBub25nbnUub3Jn
LiBJdCdzIGENCj4gdmVyeSBwYXRjaC1ob3N0aWxlIHNldHRpbmcsIHNvIEknbSBzdXJwcmlzZWQg
aXQncyB0dXJuZWQgb24gYXQgYWxsLg0KPiANCj4gPiA+IEkgaGF2ZSBiZWVuIGZpeGluZyB0aGVt
IGZvciBhIHdoaWxlLiBDb3VsZCB5b3UgcGxlYXNlIHRlbGwgdXMgaG93DQo+ID4gPiB5b3Ugc2Vu
ZCB0aGUgcGF0Y2hzZXRzID8NCj4gPiA+DQo+ID4gPg0KPiA+IENvbW1hbmQgdG8gc2VuZCBteSBw
YXRjaGVzIGFzIGJlbG93Lg0KPiA+IGdpdCBzZW5kLWVtYWlsIC1jYyBqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20gLWNjDQo+ID4gdHJveV9sZWVAYXNwZWVkdGVjaC5jb20gLWNjIHl1bmxpbi50YW5n
QGFzcGVlZHRlY2guY29tIC0tdG8tY21kDQo+ID4gIi4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5w
bCAuLi92My1wYXRjaC8qLnBhdGNoIiAuLi92My1wYXRjaC8qLnBhdGNoDQo+ID4gLS1uby1zbXRw
LWF1dGgNCj4gDQo+IEkgc3VnZ2VzdCB5b3UgZ2VuZXJhdGUgeW91ciBwYXRjaGVzIHdpdGggLS1m
b3JjZS1pbi1ib2R5LWZyb20gKG9yIHNldA0KPiBmb3JtYXQuZm9yY2VJbkJvZHlGcm9tIGluIHlv
dXIgLmdpdC9jb25maWcgZm9yIHRoYXQgcmVwb3NpdG9yeSkuDQoNClRoYW5rcyBmb3Igc3VnZ2Vz
dGlvbi4NCg0KV2lsbCB1c2UgdGhpcyAiLS1mb3JjZS1pbi1ib2R5LWZyb20iIGNvbW1hbmQgdG8g
Z2VuZXJhdGUgbXkgcGF0Y2hlcy4NCldpbGwgc2VuZCB2NiBwYXRjaCBmb3IgQVNUMjcwMCBHUElP
IGFuZCB0ZXN0IHRoaXMgaXNzdWUgd2l0aCBteSBuZXcgcGF0Y2ggZm9ybWF0Lg0KDQpKYW1pbg0K
DQo+IA0KPiAtSw0K

