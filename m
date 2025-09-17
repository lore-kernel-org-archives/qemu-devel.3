Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A7CCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 06:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uylfJ-00012Q-8z; Wed, 17 Sep 2025 02:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uylfF-00011D-Pu; Wed, 17 Sep 2025 02:29:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uylfA-0007kD-43; Wed, 17 Sep 2025 02:29:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhP+Yj4SoXrcbLXeEuH2RdS4quFKYcA/dFbwXA9UvvykiUc2mlscdXS7wlq/n5iqrtdwn0l6YRVqVeWKpjbDktVOlV893fnICXrscCMFUGkkrQf+jUbvXJMloJ1IoxFNImNS2nGmfUg5zevhVVWYEYdtIK6KzxUVaF4BnBZys7TA5eEadz7eK8w+wevoSH302V2DIF2wOAYKMFCq8tpqlAfcO15RDfZ8Vs6xSmlia6dEpgaGeBBsdsFUveflXbw9MyrMKlFso9ARR1Qwv/MzCpESojhWGTWUUb+/B7Kl9KibW4ZP6bWU73BFPO5+RPO60F4DqIzHS9Bkn+HltF0o4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwq1SMECaKKiGrob7FtqPHEvHDfN1d70TC8YXktd7T0=;
 b=ZKfD1XXlTPIbGxz8a+zN9E0ccwywXRPYQEivmrrZI5ZHUFQ0NkwGdx5fnIBThpcKT7CIv9xZbM/EKGPJXGoXm4mA5ocorI1VV1xS5hdb0h8J4FC2QD/HOZHbGNg6jPqKYYOVZSWI7pFFeT3BL7NEImUDvckVgjEi8dgtE4eug60jcvnqgS0JUCKAQ2Q3FUyhS6xyU5HJ89u3a5qcH316M0YWOotNy4RzK3mXAuD+6PY5yXcc40yfRP16vm32nCVXmecvXiaJ0u42giI4fFMgAWWE6ROAjrVJ297CD3pw3ffsLg+6cAvOGXLsD3ZhtrCaIi8pvadNZBuLNBa1rvYwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwq1SMECaKKiGrob7FtqPHEvHDfN1d70TC8YXktd7T0=;
 b=nkHmBiJWbqtlmVyhCpsLlUqlsfKauCHEE12zYoca3cTp8xf1Fq4tcWdJZmPLvinOvdLuhotbOosWbVQwSyRWQlUwh7ciSsKgpz1BQOcc+tsDQnkhSGyXgR+XDNoyMo8T0grab7NNzH54ugoBqN9w9h8GIqgxTqo5tx5UZMpCxO65P5Z2uOq6cQaDmJith8GsAns6vYbH1+sl/xvtuJLbPLs7LfVQdEOD3Ojhpbx8psTbqoGenKPFhCC8+c4Mf1Bul4nZqgHSWjm8HOhYEPtuIb/TucFS+60zPG/P5KACF6mv2hpkHTzWCJ/OnoCo/43/1kgze1KxP8OQPx4aW/sOFA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB5734.apcprd06.prod.outlook.com (2603:1096:400:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 06:28:58 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 06:28:57 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "thuth@redhat.com" <thuth@redhat.com>
Subject: RE: [SPAM] [PATCH v2 0/3] tests/functional/arm: Add OTP functional
 test
Thread-Topic: [SPAM] [PATCH v2 0/3] tests/functional/arm: Add OTP functional
 test
Thread-Index: AQHcJ4d0+uIw5HIgfEOjKRnaVC9G17SW5/6AgAABcnA=
Date: Wed, 17 Sep 2025 06:28:57 +0000
Message-ID: <SI6PR06MB76313F14F6E87AA0C8DC05E6F717A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250917035917.4141723-1-kane_chen@aspeedtech.com>
 <fb768cd0-24cf-41aa-ba4d-1314a5a29644@kaod.org>
In-Reply-To: <fb768cd0-24cf-41aa-ba4d-1314a5a29644@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB5734:EE_
x-ms-office365-filtering-correlation-id: 841a6e73-5311-4168-e80d-08ddf5b37b8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?WGFPYm9LekZxbWR1cUkrdWJUcmFyeWhnSG1TNVJqVDFYdFNmL2lZcUZjTFFz?=
 =?utf-8?B?amU3K3ppN2pPVzhQdkRzQlBmc2pSakZVWGNKckVCMmdWT0dIUDVoTytGSlBj?=
 =?utf-8?B?STFCb09hMkNockJDZVg4MVplc3luREZXYTBnV3VYVUtFaVhHbzJvVlc1YTZ0?=
 =?utf-8?B?b1I0UnI5a0pGYmFQaUZNdy9RTWpSQU5ldnNrd2hiNkEvRUVWSks5VUNkVTFC?=
 =?utf-8?B?eEowbUZMMzBKUzh6TCtFc3FETHd0aExLcjZDRE5LZnpodTI4VTZqZ1J0cEN2?=
 =?utf-8?B?T29VMjRXWEtsWEIzdjE0SVZ6SnlDcVltck1IQk4wZzJHSWJvM1VIaDJrVkU2?=
 =?utf-8?B?SUJzK3hYNklvNHlIbks2eVRjWlRETktYNDZmV0dGVHpnek9rbStuUVYzUEVF?=
 =?utf-8?B?YlRycm9MS2d1bjNFcmdRUGRUbzFnZC93Y2dUUWJsNFFsYzA2T2xSZTl6cnQr?=
 =?utf-8?B?RUhsNFI5amt5YlZGckptWit4clkrWVlpMjlUZG5zNjNmSzlpSTBremN6RkRX?=
 =?utf-8?B?Qk5Vd1ZUTjNtbGJ2eHF1bXNyNWhiQjVIemdFbUhuSUh5UGFTNXBMS2tsM0N5?=
 =?utf-8?B?THZvZmFPTXZ6ektPWjJ1aTZTVmNTNy8vZllHNEpnQ1ozWnd4b0hjK0tLSzZM?=
 =?utf-8?B?UVJTT24xc1loOGpSWWZObVZjVHVTRVVnTHJLZXVobXNINWYxRkI3TjZtLzA0?=
 =?utf-8?B?OGxnc01pbktwZVF0emszdzFrSkp6T2lUN3pSSkdlQzI2SkRqb0V2YzNldXZO?=
 =?utf-8?B?bW4yQWw5R0I3WnArSHA3VDhJVTNHTzFwdHl1cG0rbEJqck9RcDNGTTZQTER3?=
 =?utf-8?B?Znl2emZJUzVLL3dBZDNvL3pmYmc1QW81SXkvLzNYWGNtUVppVW0zNGhpMjZn?=
 =?utf-8?B?SUtFRnhwaEFYaVlaZlFYV3R3SjIzbUFnb3RTUDBWREFBdEp3YUswWnVNNWdQ?=
 =?utf-8?B?bS9BTDRjNG1DK0xiTTMyaTMxNnovRzlHeFMxbW13dDMrZXlOenVFOHp4SW5E?=
 =?utf-8?B?d0M0VGF5RnZzVENkalNQTVN5cjAzR0VqWHErdDBmVzMxUkQ5bmJyUHdsNUZH?=
 =?utf-8?B?WFNYeWRRTGdCcitZS3dMc1B4dE5tbm1hZG9jUTlHV21EblZUYVltTklmbTVx?=
 =?utf-8?B?MUdqQTIyQmhzZGZSYll2SmRqdi95cGJhMWdGOVh0ZSt6WFd3Z1dRWDRKQmxH?=
 =?utf-8?B?eGY3WnpVT2RQTWRNRnR4aE1RdG0zUU1hb2RNK3FSajZhSU8zZ0o1ZjRrb1J4?=
 =?utf-8?B?ZUpRU2o4S09nQUUvNDk0SEFRZ3R4SHJRYlNqVnhYeGZpS09wa3dXTzBvSXFN?=
 =?utf-8?B?ZnY2amJrNyszZUxsZmdjZ0RWVFI4RmxuY2ZSNHdlZks5aG1CWWpkS1NuVWQ1?=
 =?utf-8?B?aGNpNjVGMjB1b3pROEhqK1J4eVRKR3Bva0RWSUFhSHliMHhCSDdvZndvc2R3?=
 =?utf-8?B?N2kyN2FXMVdRZWZaelY1T0pTaXh1cEFJYUh4cVZTVW5BSVpka0pySlZsdWQ2?=
 =?utf-8?B?M243YmVoNDhzaFdVUzJZTVV5dkZCL0ZVaGtKc20xaFVONnZ4bVVxZjIwVnNi?=
 =?utf-8?B?dUZNZzNYdEVzTU55MDFHS2dwWGlZYVVKbDljcTlpY3ZjTWk4K010TWNtU09L?=
 =?utf-8?B?aC9FMGxERHBnZEZMdFhldnJZZktDeHFqcjgwZFlBV3pXUm95WW5vWm4rQkhO?=
 =?utf-8?B?Z0tGNlk2WHZPS3dqaE93cTBkSE5nRXVEcjNremNBY21lRmRrNi9IZDBDTGZh?=
 =?utf-8?B?d1d5dE5sYnJKcmNadnd3ZUhhQlNFd1RXSVFFNmpteUtoMGRtSHJBUjN0TS96?=
 =?utf-8?B?ZmFBVzBGMUtNaCs4b1R5QXJRUzd2Zm16MWw5YlhoNTVVcjcwYm5TbGhTcERG?=
 =?utf-8?B?WTBTeGhJOHJUemE3Y1pqcEcyTjFEV0xnMFpINUNSSEp5SzNPNHFRWnNxMk5H?=
 =?utf-8?B?WFFyQ3BFMGVRNWdEeXdobWJYamJkbjYvUkx6V2g4L0NFSHBMQmxMSHFPclky?=
 =?utf-8?B?Wms2Z0s5VHJKSWNxRnRJOFd3ZGFMY3dHSkN6YldPazlweVcvUmJUSlVHSVBU?=
 =?utf-8?Q?LeSbTM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDJETk1tV0J4ckt5dGpnY1M4YVNBVjNZRUc4SWswRnBFcDFHVDFtbmJiV3lV?=
 =?utf-8?B?UmZpV3RaSFhId0xveUQ2R1puM2lFUDlNN0JFTTRzbXV3RlBXRkdyNndyMnVF?=
 =?utf-8?B?amhha1JqNXdZSWthMzVvMXU3RGgzVEVXeVlqSWVNM2p6OFR2WUlZb0Z6aDdU?=
 =?utf-8?B?ZHRla2ZoTlNVeFdJeUVRL3I1SDE4L0k2VFltSGVrSStoNGpOWDZ5aC9KUHZE?=
 =?utf-8?B?ZVZhWnVZblVKWGRaWGFzaUU3bjRxTEE1d0pvWkdkZmIxaW94UzJGRzZxTkxK?=
 =?utf-8?B?UUZOV0RNUmhzdjUrSXJGWHQwUENPTUJvWkhBOWhTWmFjOXk5bnpUbWxVN0xW?=
 =?utf-8?B?TzhBdGd3MVgxZkFWUnNKajlBL2dURm1zRytQTmdlVStwcm02Y3J4cytybk92?=
 =?utf-8?B?czYxN1pFRUZ1bFBETTJWekUyVnNsdUgyWktSRDJINGxKTzdhSm9iZnZvamY2?=
 =?utf-8?B?cWtxYW56a1RpSHF2QTA2NVdjUnp4amdZM0RIZDZaTmV2a1o0UHlkWGlESjRK?=
 =?utf-8?B?Wk9GRGI2RXFZeWZQOCtyQUFLVFVZYU9VMUloT1EwMmpqdXR3aHZtVFZnZ0E0?=
 =?utf-8?B?bVlhZlNlVkllNkpDL0hyTDBVR1JKcUZaUENlaWVWVWtpWVMxZ3Z4N0lQUkNT?=
 =?utf-8?B?aGZ4Ymk1UWVSMi9jYVhLTWg1SGY2Z2xWQ25QZWcwOWhveGRSaDZ1VlV1Q2FM?=
 =?utf-8?B?ZXQ5UDdoMVFWZ1M0S2VQN1BlWkdFRmM2YUNxSnJvNGhnUW9QangrUWtIbGlR?=
 =?utf-8?B?Qi9KaW4vdXcyUzA2Q1N4YUNSQytCN0tKVUdrSDhFYTFNZXBSYnNuWTFDV2lX?=
 =?utf-8?B?TlI5VEpIRTdPcy8zcWoyUlppTlFFK0h3djRXdSswYkpJRzZWQWhnYWV3dm42?=
 =?utf-8?B?N1lISWdQcjlMeEJHNE5HaEpTT0N2dHVJNjRVb0g0Zkh2YzdWU1dJZFJYb3Nn?=
 =?utf-8?B?R2M0OWcySXdOR1A3QnJ4c3Z5K2w5QVhoMVY2ZVgzMzhEN3BRelZzYTcwZ0Fo?=
 =?utf-8?B?U0s4WXkrajlaWVVGOC8zR3lSZXNWNDJuYnA5QWVtTFNRZlVwdEQ4bjdFckhm?=
 =?utf-8?B?L3pSUUY4SXg2Z2dFTFJhVVV4Z1gyRkZTNFlwNGpJMVdVRDQxZEdwNnB0S3Fv?=
 =?utf-8?B?SVo3aTZQK3AzUTBMMWNleG5MRy9WZlFaZ1NJVlg0S1g4K0dEazk0dTdRcW5Q?=
 =?utf-8?B?Mmp3cllFVTE1dFluY0J6WHpyQ0dOd2pQalVJemdaM2gvblpEdVgzcmtxK0w1?=
 =?utf-8?B?N1dKdldHMzEvOVlUUXNKWWxoQW5FUUl1alJrajhmQWdWUFdkeWFZbmVVMENr?=
 =?utf-8?B?VElFdU02NmEzbFR0UmZIM3E0bTJQVUNiWUdaRWtldTJhbHpXdXBDMFpsOGNJ?=
 =?utf-8?B?VkxqbHNkN2p4eEY3d2dHSkJlSUN0SDNJelBFa29qVURRYS83WTVMWHFQN2pS?=
 =?utf-8?B?YlRxQit0UGNrRCtLNmlia2Z4ZkdGTnp6Z3hNU2JGT0J5bkhwOTlJVFowUUh4?=
 =?utf-8?B?UlpOaWF1WUMvVFJEcUp1SU9NTHVtQVBMSjd3c3RyUk43RzNGTlBLT0VaZVly?=
 =?utf-8?B?bGx6c3ZVVExMdXlNRGk5ejNjWXl5QThiTXZxWlZyRm5HZkdScnF0NHRVOEti?=
 =?utf-8?B?dWZHeTNwQWl3THBhYW1YOXA4S1QzQUF5S1ZlOUp1R1JGUjhHbHljZnRVbUxB?=
 =?utf-8?B?SmR2MG1wMGFjcW5HYmFXemMwNFY0SnJDV1NhVHlFSVdKTmEzQnlpQjgrQ1Zx?=
 =?utf-8?B?aHRoTDI3cm5DUUdxQzIybGxVaGJNeTRBZ0x5MXZadEw5SVhZeElzTFhJbm9Z?=
 =?utf-8?B?cXBSRTVLOUgvalNwVVppSHE4TXJ3RlZCSjRmdFkwQlkvTEUycC9FNUhxN0Fv?=
 =?utf-8?B?SW1CREtLdXJXZ052SWdNRWU0ckJCcGNtSUNNem1nYktqR21yVFljcjRrWkE3?=
 =?utf-8?B?VzF2OHl3UUhlQ0ZORkMyWFRRaWxlbk9iL0NoUnBJWWFnbEcrVWswZG1CUnlh?=
 =?utf-8?B?UUc2a2NZTFV1VGd1N0JrQy9uWmhvWE1mTDM0eTRzVEQxVWQ2ODF5aGVzSmJy?=
 =?utf-8?B?MFFHSjF0d1JqQnhKVlNPZ3RhRy9FWnIzMExzTE0yYTB0M1FjcXFLcncwdGFa?=
 =?utf-8?Q?4EZiN48rD+gP0yBcfdCjYsy8v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a6e73-5311-4168-e80d-08ddf5b37b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 06:28:57.6556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZHYSCM/kCn2aCHulRNoP1f48qSxSMo4k3VO7JaN7n7+OeZMsbu8Bd2Kf4q0nDhGhovaGvZs+Qxs3NIjDtkN5YsorGkz1aiCxdDXf88EqUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5734
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpCZXN0IFJlZ2FyZHMsDQpL
YW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDE3LCAyMDI1
IDI6MjMgUE0NCj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0
ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3Rl
dmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47
IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQu
YXU+Ow0KPiBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVu
IGxpc3Q6QWxsIHBhdGNoZXMgQ0MNCj4gaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBD
YzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgdGh1dGhAcmVkaGF0LmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1NQQU1dIFtQQVRDSCB2MiAwLzNdIHRlc3RzL2Z1bmN0aW9uYWwvYXJt
OiBBZGQgT1RQIGZ1bmN0aW9uYWwNCj4gdGVzdA0KPiANCj4gT24gOS8xNy8yNSAwNTo1OSwgS2Fu
ZSBDaGVuIHdyb3RlOg0KPiA+IEZyb206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRl
Y2guY29tPg0KPiA+DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4gRHVyaW5nIGVhcmx5IGJvb3QsIFNv
QyBmaXJtd2FyZSByZWFkcyBmcm9tIHRoZSBPVFAgcmVnaW9uIHRvIG9idGFpbg0KPiA+IHRoZSBj
aGlwIElEIGFuZCBkZWZhdWx0IGNvbmZpZ3VyYXRpb24uIFRoaXMgc2VyaWVzIGFkZHMgZnVuY3Rp
b25hbA0KPiA+IHRlc3RzIHRoYXQgYm9vdCB3aXRoIGEgZ2VuZXJhdGVkIE9UUCBpbWFnZSBhbmQg
dmVyaWZ5IHRoYXQgdGhlDQo+ID4gZmlybXdhcmUgcmVhZHMgdGhlc2UgY29udGVudHMgY29ycmVj
dGx5IGR1cmluZyBpbml0aWFsaXphdGlvbi4NCj4gPg0KPiA+IEFueSBmZWVkYmFjayBvciBzdWdn
ZXN0aW9ucyBhcmUgYXBwcmVjaWF0ZWQuDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gS2Fu
ZQ0KPiA+IC0tLQ0KPiA+IENoYW5nZSBsb2c6DQo+ID4gdjI6IEZpbmUtdHVuZSB0ZXN0IHNjcmlw
dHMNCj4gPg0KPiA+IHYxOiBJbml0aWFsIHZlcnNpb24NCj4gPiAtLS0NCj4gPiBLYW5lLUNoZW4t
QVMgKDMpOg0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9uYWwvYXJtOiBBZGQgaGVscGVyIHRvIGdlbmVy
YXRlIE9UUCBpbWFnZXMNCj4gPiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FybTogQWRkIEFTVDEwMzAg
Ym9vdCB0ZXN0IHdpdGggZ2VuZXJhdGVkIE9UUCBpbWFnZQ0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9u
YWwvYXJtOiBBZGQgQVNUMjYwMCBib290IHRlc3Qgd2l0aCBnZW5lcmF0ZWQgT1RQDQo+ID4gaW1h
Z2UNCj4gPg0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MTAzMC5w
eSB8IDI0DQo+ICsrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC9h
cm0vdGVzdF9hc3BlZWRfYXN0MjYwMC5weSB8IDE0ICsrKysrKysrKysrKw0KPiA+ICAgdGVzdHMv
ZnVuY3Rpb25hbC9hc3BlZWQucHkgICAgICAgICAgICAgICAgICB8ICA4ICsrKysrKysNCj4gPiAg
IDMgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiANCj4gRm9yIHRoZSBzZXJpZXMsDQo+IA0KPiBSZXZpZXdlZC1ieTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoNCg==

