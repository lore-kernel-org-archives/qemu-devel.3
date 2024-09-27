Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D50CEBF78
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4U0-0004UW-B6; Fri, 27 Sep 2024 02:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su4Tw-0004Hg-TZ; Fri, 27 Sep 2024 02:29:37 -0400
Received: from mail-sgaapc01on20722.outbound.protection.outlook.com
 ([2a01:111:f400:feab::722]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su4Tu-0005Mo-DX; Fri, 27 Sep 2024 02:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWw3Rz6++75hchz7WL5SrgOOVdbX9FpEiIrqAXkpcLBFMdgeVNJ2eUU0iz/HjbcL5DFAUR7x5cCaQ39vJ3RJibTq6y6LwwIDhv9PL4+IabpXH2llCsTB0z/AJZ9VBz33IZ0uPpr5EEFtxh6fcqdd0zFc9TjTxVOupFJHLSWvbtcNR+7BYB4s8gET2S/stIC4c+B4/TiMo/FTpLb4LBhK55HaIXigrfvgHoH+OZ+XjfGkdeIT2uKb4MH8RdZMtTUW2OyddBdJPNQc/iD78dyU5UW1C5t+PfxaUa7e/nnVnL5nibVAxP3zKpWg+E7zLTtNEO5sQUZFdxu8SVCCmjiBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVTp0sIAuglZAdPr/9P81hcxSjpXBZp3VkcwCGrYpyI=;
 b=nF/FG8JW63N1LK9/VObPA+qYnNmDe2tlF3rvDjONgV+gs7/4VaBX7Ln7Oj37EMBsfFNIxTB0FIFkCX6Agc/3UdGQApK01Y/K/amSPjXmcG93mMFGZKU50OT0VlX7Nn1+ZO4NEHQl1FwOsglVtFB1rIrsu9tMtj7O+9Duotsvx8Hyarz4qlo4abtfKhrK8b8pOFljiUd5NPGXIlCDP5HbIEfzhuntSZeIAoRlt5c0xDKC8Fy0LSW+Kial/6NEZBVtqmBloc0wUH3u7i/Brjx7F2QsaGKPtFDdSwY2zG9V082MN0HiJV+JM/fo/WzoLUpd9djHPm3H9n+3dgaIzrBMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVTp0sIAuglZAdPr/9P81hcxSjpXBZp3VkcwCGrYpyI=;
 b=BIg9tPOMZ2aBtiUHchxGHttbvPwVH4XRgqmP2xchOPHdpBH5gPBOZMLAsrChuHtJHBl1k1n5ImLQK1KptUGh7uQv9AgE5OPf28q3nivlqLAJOv3ZVJp06nToAW3mceiNmWS9fs1bHZpfLmnsTy/h0+9r7aoUY/zTW9/vYkWRaVpg200ra80SdjGBUuXlq/L9WzcoE38/juo57MTDiQ+lxT0+fr/otLYytcPCT30WhUheU205090JrhU6cWtXdFt6nNgEZWEnCPCLjqaVrGI6bESpbK8r603+NIIXCXvQ3H32E+Opk066sK5aLBjDiza+9/Ecrg3peQhotkCEuNKlwQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 OSQPR06MB7153.apcprd06.prod.outlook.com (2603:1096:604:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 27 Sep
 2024 06:29:22 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Fri, 27 Sep 2024
 06:29:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 0/6] Support GPIO for AST2700
Thread-Topic: [PATCH v3 0/6] Support GPIO for AST2700
Thread-Index: AQHbD+gVwmQ29c/aREKHLSGeVLq1VLJqPfuAgACof6CAAEMygIAAAy6A
Date: Fri, 27 Sep 2024 06:29:22 +0000
Message-ID: <SI2PR06MB5041632B8C7403F6B4B9D4F6FC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <e1076f8e-2e32-41ba-adf4-8e28aae8e526@kaod.org>
 <SI2PR06MB5041AC649E5F76F2700A42D9FC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <1f517713-bb9c-420d-8dce-9423123a3eab@kaod.org>
In-Reply-To: <1f517713-bb9c-420d-8dce-9423123a3eab@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|OSQPR06MB7153:EE_
x-ms-office365-filtering-correlation-id: 507d73d0-bc96-46a0-bb8c-08dcdebdb996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L3puV1hnLzdBOHJxSmJ0ZHdnVHdReUJoRHVuZHZZcWdOeThFa3FIK1VZK0pU?=
 =?utf-8?B?eVY2L1k2L0UveDdXb1hMWlhiZjgxTlhqT3p0UFBXcisvMmhWblJ0d1JvWVZi?=
 =?utf-8?B?dCttdjkzcU1FcmlzUjdZbUJ3TS82c0EzQThwNHM5WUY2bThXcnFiYVI1b3Rn?=
 =?utf-8?B?UlRMQjA0QTNOWDYzYUx4N2JRWUVEekRyaE1vRlU5ZmhJOUpSbktoMisyZW55?=
 =?utf-8?B?NjBTcERtN3g0aVdBQ2Z3TWN2elBMVGpWaEowQS8zeGFkcUpsRFVCS3lBM1Iv?=
 =?utf-8?B?Z1RRQVdsTlFuSGlFeTNMVzBhaXIyNkFZazlHVnd0ZFZVSDhucDM2RjFMeGJC?=
 =?utf-8?B?Q1Vhekt2WjhHNythbmE3RHpxK0N0SEtMNnEvemdoZzJaRmc1MEEwaWhHWm1J?=
 =?utf-8?B?TnlwZ0JnU1Brb3p3MVRQZ0ZPU09BWkdsRndIUFVPb3hUYkY3MzF1Vi9XVEtW?=
 =?utf-8?B?S1pRM1JrV0VmWndGV0lXUFVIZVRKb1NMQ0hUNTFEaHFtL0NQeG5YOVVCMjIy?=
 =?utf-8?B?MzRoQ2ZUNk0zSG5hOWVvSkdqaGVXYUorb2hzcnhmMERVTXhQcDk3elJZakEx?=
 =?utf-8?B?cmI3Wi9YWkI2aithTS9wNkRXMkRsbmdBQTVzeU9UVnRhUXovVCszTjdBTnhF?=
 =?utf-8?B?N1p2eDRFLytMQVp6T2JMUEl3K3dqYzVBVmhJTjVpL2RMVlY5Rjg3Z3VuRjc1?=
 =?utf-8?B?SzVRS2taTm9xZkNhTng1bEdPU1pSTlNtd2JaTVNQNnVyQUJ5aGdzM284U3Fr?=
 =?utf-8?B?SkhtdVg5b0N4T0htWFR2eDlaeDBqRGswb1p0UjFqaW83Z1R5RVkycFNUTGJq?=
 =?utf-8?B?cllldDZJZUpQZlpBYS9rREFZVFFoS2JheUtSQTBVTkpPYXBJekFDbEZZSi9i?=
 =?utf-8?B?NHhvcVB4MHlmQSs5N0xZZXhaazA0SFNSS0JaQlNJbytCcnRkYnNFQWtwbzVP?=
 =?utf-8?B?eStaOHdUdTdTSlorZ3JBZGVKWVlxeUlSVVpxOWNjVktPR1dJTjFQSXVBOTNE?=
 =?utf-8?B?UXhFcWJ4NmJCMVlhQVVucUVmMVZpK3Rva2Q0dlNoc1dNR2N2WmdEajB3T0Vh?=
 =?utf-8?B?U1V6dHdWc2ZMNTUwQmhkdDRKbXNxT3J2VlBJZzZFT0JZdFhrZVRlZjk1NjhI?=
 =?utf-8?B?TWozZ3Z4YnZCN3BJWnBHZWRONDZWK1Z6OGJiVnNvOGgyV2JYeURUdUJSMGFx?=
 =?utf-8?B?WmozMFNDeTdocXhVZmJLVUNHaWMzK2JINXhPbWNLUmlRSjNQMldhU3k5Zndw?=
 =?utf-8?B?WWJTYXNDTlR1d1gzSUlwd0VjeFlGN2ZTNTRaS2tkbVlYb0FTd2RKQ0FtZ05y?=
 =?utf-8?B?WiszT0E4QkdVbUFTTzgzdGtJYytkZ1ZtOGdQTFFxVUE0VXZqRFdUV29kMldH?=
 =?utf-8?B?V1A1U09oSlNjUDZFSjdpckFQdm0zQThhQ21MaDVqdW9qdHFkNW9LT1duRkZq?=
 =?utf-8?B?QmdEQzJIM29EV2o5cThnYzJqNmhCeVhTSzdRQzlLTEUyZlU5MEc4U2l0a3NR?=
 =?utf-8?B?Q0tDTzRVVGFXQzJDZVBvNUJiZjNxWTA5Y05PcUw2VXRsTkJ6OW8rQ3R1aDYz?=
 =?utf-8?B?VUNxNUFtMmUzWGxoSGRhS1hzTkNjVi92dkNGUG02NmVtSlJ1em1MNWRrVVVC?=
 =?utf-8?B?SDZ0V2lJMXBvRjdMU00vNExMMFpEVU9yeSs5YUpuMUw5T2VkQTR2bkJidDZN?=
 =?utf-8?B?bWNIcUxqZytnekVpYWE5bXR5d21TUDV4NXBRaEhKa1ArbW5PZk9UWXNTN0Jz?=
 =?utf-8?B?QlhvaUpQZDdmQlFhSVJRYklxNDMxSUNIUzAvZThFbUg5b01iV2N2YzkvZW1y?=
 =?utf-8?B?M0cyUEVEdlRWQTB3TGk5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmc4OWNaakhXNm5wM09PZDh1QzJ0RkdDU2RCTmkvOWZMYTBzeDdqRXRzZTBh?=
 =?utf-8?B?d3hNMFhQZUlmRlY1MnJCUy9lSzFzR09ydXA4TmRYdENjcDQ1ZXl0dnVTY1RU?=
 =?utf-8?B?RkVsaFl6VEhPb25XSC85N3h6OHQ4MnVnVFlxVjhYVzNHeFlLQ3pueHhWWkp6?=
 =?utf-8?B?aStGdnF4K0Z1R1ZEUTlIN2FCUGhNUGNpRi9sQTBSOFlnaWgzZTJPWTErQ0Zq?=
 =?utf-8?B?amFJSmdQbmlaR0Zmek82TzlxVzF5YXJBbXBza3cyZ0VIY0lXVERhQ0YxOFla?=
 =?utf-8?B?OUE3dERxK01KRW9RUFRxRzZzc3hOQTdVOTNhTVArNXJibDltZ3czcVFKN0x0?=
 =?utf-8?B?eUwwM0xzSTFFc1lNQUdTK2lya1AwZzdka1dJUGFKdUxmNG5ZZDcxQ3hwOHZn?=
 =?utf-8?B?NUo0YWpmbkZTbzFOWWdjdGJSS3FSODVJTmR2T3ZSdEM3dm9NbFlTQktFMXJo?=
 =?utf-8?B?VmR2Tnhwb2hTYjVRQmtNdlB2TmdlQ012Q1llQmtHV3VzT0JRMUFyaGNPMHhM?=
 =?utf-8?B?YUxPRCtibkxteVEyRGlxaGVBODhadGY1anlXd2FMRW5pdC8zTkRPRkpTR2V6?=
 =?utf-8?B?ZDJoKzl6ajAxcG9MLzkvMElaOVNnNmViVEZmek1lQTVaWTNqQitWcU0yenY1?=
 =?utf-8?B?SlJyUkFWdWZZcHA5MjdvWFdCL2swTVFhRjFHZElqSngzQ1Q5LzVCNjlNZmhp?=
 =?utf-8?B?WE1xVUhmQlgyWDB3UXYvdGl0VE1uYkV5OWVnUldtMmhWQldUVUVJMndRNW5F?=
 =?utf-8?B?aW45TFM1Rmh4R1Y0U3JSUktlV0I1SUZyeGFNdEdwYlllZnFaY24yeVFGWW5B?=
 =?utf-8?B?K2phcUJDNUplRU92YVNpRm5aZmlrYWR4ZVVUTHN3dlp4aVVRcnRhVStjZk1l?=
 =?utf-8?B?Z05ZZFRmdGU4R3ZlUkFqeEphdmFLWm5ld0M0MEtPcFdMMndWQWFkazVNR1VL?=
 =?utf-8?B?NlcrUmxOK2FIYlRacXJkZ3VnK3hGRlpjRmVkcFYyNHREYU9JTU9oWVdUSFV3?=
 =?utf-8?B?QTRldGk3Q2xBRzM3WUI2OWtXU1VKcXIrbTVsc2IwTnNhWDZMbUUwRDF5aE9u?=
 =?utf-8?B?cG1qNndxWThUZG84UzB2WTUycEJZZFViMmVWVGZ2azBSNzZ6ZGdreG45dlZQ?=
 =?utf-8?B?K3ZLTllnRkFWeWs2VnE1azhiU1dabk1pVDhsUW1BdEJDRVlHOVA4ZEx4OUkz?=
 =?utf-8?B?TUtoaCs4NVhoVmJjeEt6RkxaaVRBNVZDODNUTno3cFkyM3Yra1pkMHBqVE5R?=
 =?utf-8?B?cXM2T1ViMW9uR0RUVmIrUU5ucjBnRU16MjFjYjBmd0JhL2J1OWdwZnI0K3gv?=
 =?utf-8?B?V252ZzV5NUhuNXM1b042ckRITDRRN3R1dGQzRHJ6bzZvMzlXbTdDQUd1MlBL?=
 =?utf-8?B?b2FwS1pqWExhMUJ1MXJDRjhqTy9lakVGMk00c1lUVjlneVBHYXdQRlFSZG1i?=
 =?utf-8?B?RXhMdlRZejN5dU5TckJEYjZSbFJsRmxkOUdFNWYyb0RaOFNDaE4zbEpGd2Iz?=
 =?utf-8?B?aE5mKzNhSG83ZE5QaUJKd2FMTHd4eGFLODlVTGUwVkt0MU1LQmkxb1hPZHQw?=
 =?utf-8?B?WER1SFVZT285STZVWUNNR2J1ZXg5ZlNYNlM5ZW9XYm1kdi91eGpNNXExMXUy?=
 =?utf-8?B?WHNmbVRaNkVDREdkMHBQU2NwNDAzekVwY096d0Z5bWNaUGNJUzhPYjJnSjl5?=
 =?utf-8?B?ODNZb3IwMnhMRmk0UFEzL205eWxJYlFjRUcwNXJSK21LUmVBQ0pNaWVINHBi?=
 =?utf-8?B?YjQrbkVEOThMdnNxYk1YRnFqMHlpd093WXpzaVNyMU1YK1RmMUNhc2xCQnE2?=
 =?utf-8?B?aGdCREpFSE1mdUZDMlgwODVRTW0zMlEyZEw0ZkdTZ0ZRRWx3bkk5aGlUU005?=
 =?utf-8?B?dGxyOXZtK3N3YnUyY21JdUVOaXE0My93THl3anEzdVNQZjBMRWdJNUovZDZx?=
 =?utf-8?B?NGZhRmFRVGY2Zjlyanh2RTMxaXBENlUyY0lmOWx3VUNnbTcyZVBJWDJpaW43?=
 =?utf-8?B?czN4USs3YklGcnNEY2c2Z0RqY1hpQzBiOVNsYVo0NWlNblB4c3ZNWHY1YjJK?=
 =?utf-8?B?bVhMaWx3aUdqOFdsY0MvMUQ2MUZlVEZFZUtZbDFJYm1PUUtOU0x1Uk9wTFpq?=
 =?utf-8?Q?k4sgF8ebKsZoKD5WD+5cfMsVF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507d73d0-bc96-46a0-bb8c-08dcdebdb996
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 06:29:22.3558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lr7+Tcaky/d9ZStEVf84TZPqX0eMriHufU3LXlNVns6xgxLFzjEjfTR1/nEwD6CqU9YI+AUtZ9t6OAjhuwXBLnpwY/ISr42Z06hOkHV1bs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7153
Received-SPF: pass client-ip=2a01:111:f400:feab::722;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC82XSBTdXBwb3J0IEdQSU8g
Zm9yIEFTVDI3MDANCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gPj4gQ291bGQgeW91IHBsZWFz
ZSB0byBhZGQgdGVzdHMgaW4gdGVzdHMvcXRlc3QvYXNwZWVkX2dwaW8tdGVzdC5jIGZvcg0KPiA+
PiB0aGlzIGNoYW5nZXMgPyBBdCBsZWFzdCBvbmUgd2l0aCB0aGUgYXN0MjcwMC1ldmIgbWFjaGlu
ZSBpZiBwb3NzaWJsZS4NCj4gPj4NCj4gPg0KPiA+IFdpbGwgYWRkDQo+IFRoYW5rcyBmb3IgdGhl
IGVmZm9ydC4gSSBhcHByZWNpYXRlLg0KPiANCj4gQWxzbywgeW91ciBlbWFpbHMgaGF2ZSBhbiBp
bnZhbGlkICJGcm9tIiBmaWVsZCBzZXQgdG8NCj4gInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIgd2hl
biByZXRyaWV2ZWQgd2l0aCB0aGUgYjQgY29tbWFuZC4NCj4gSSBoYXZlIGJlZW4gZml4aW5nIHRo
ZW0gZm9yIGEgd2hpbGUuIENvdWxkIHlvdSBwbGVhc2UgdGVsbCB1cyBob3cgeW91IHNlbmQgdGhl
DQo+IHBhdGNoc2V0cyA/DQo+IA0KPiANCkNvbW1hbmQgdG8gc2VuZCBteSBwYXRjaGVzIGFzIGJl
bG93Lg0KZ2l0IHNlbmQtZW1haWwgLWNjIGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbSAtY2MgdHJv
eV9sZWVAYXNwZWVkdGVjaC5jb20gLWNjIHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tIC0tdG8t
Y21kICIuL3NjcmlwdHMvZ2V0X21haW50YWluZXIucGwgLi4vdjMtcGF0Y2gvKi5wYXRjaCIgLi4v
djMtcGF0Y2gvKi5wYXRjaCAtLW5vLXNtdHAtYXV0aA0KDQpKYW1pbg0KDQo+IEMuDQo+IA0KPiAN
Cj4gDQoNCg==

