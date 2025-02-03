Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEF7C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 07:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ter7L-0000wW-Dl; Mon, 03 Feb 2025 02:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ter7I-0000w5-1c; Mon, 03 Feb 2025 02:43:36 -0500
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ter7F-00036q-6J; Mon, 03 Feb 2025 02:43:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lODompRoRaFZidq2LcgmWuZ3Tc1bEZWsIbI3mtBsOdE+opZ0Yh/muDY/KZuFKXeSMfKIXGcylvLrM5AAMxbk7AAQaW6pYsymvbCrnvwLLG4+Rx2rvuFIeJWNvPGcwYqYU2IlFqT7R0hbBVNUAX7eeZJJ9R/bgJbtfjOq1kAPewYDaawqr5Lz3B4jjSmg2CEn/aUmPOM5oO9W5sL5mGlxs8zLGVArxSucyFeefP+cQX5w/MJXWDsfl1UdD7gzQnjJsVN43UPw/O9kC9qvWMn05vyoTb9s6mcU5CPW5G9A4f0DEV8uI1GkN/HR4M8tS4vCrVt+t/hHQRnjFEEHiZVkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQPgdN3LuojPGAR/Q/ddsMnHTQfnxJxRxy/WRICq/CQ=;
 b=sJxoOdtZuUiTXqahwzUD40ssjuEyBnVvdsyF47b6jGj8mimOpqEfJLuyh5xi/3rHv1Gd8lwSbCtpddWgQu6+MTmednlLIYMjgB3a75EQerz5GYcsyNzqrAgAs/i6uDABRmMSkjHcif7T7vMGMcJbRjmwUzIe0xECcCGmcJWsjq8mFu5QTT0ucMN810EQRWBx0OTLYrU/wL6zmOW7MoMJfM5+Mr2hL6JG4Qn1xrwzsAqnJrwebAIpcHGgpuvKGvKVRpWpDVmZo+FsKBySes5lh0ZSrpbmnnhn2bLE9ohtDJim9h3f65eVQTDRRk+kQvHwi1J8Uccx7Nfe+1lnhpBGCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQPgdN3LuojPGAR/Q/ddsMnHTQfnxJxRxy/WRICq/CQ=;
 b=QKLnOtnblCGK6A7v22pes82YX6/o60nouymiJ4W+2ht5Sc4DvriBI9I6gE4UJ8CnFZMmhYBjygSR2hU6pLwjEh9ptNky3yUFKoYRVrjYOWO2Kkk/m8UMTppeAAiZzmm4GUOIaHnIlcGDLgsorvE8f6HTWO6Bjurihyt9mGonleuwuHP9d+bW3RRjrTGCpdewb+211PAbzUZbj58FN+i0HRER+GLR0spiYzGuNqYkcu8GlAATFzFuKHOac5zryWuQ+Sxq1ZOz/0VVScWGa++ZlPdAvcY54HzHrotQ3XjzvaHPTpsYXk3r24keIXoVxikhE0syZBipBtk4tsZqR+hoRQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6200.apcprd06.prod.outlook.com (2603:1096:101:f2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.8; Mon, 3 Feb 2025 07:43:14 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 07:43:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Jinjie Ruan <ruanjinjie@huawei.com>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
Thread-Topic: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
Thread-Index: AQHatkJWGs9xLfQ5AU+zfhhp5GQ22rMw5oUAgAXDrjCAAAX7UA==
Date: Mon, 3 Feb 2025 07:43:13 +0000
Message-ID: <SI2PR06MB50417A6E45521504224146A9FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
 <20240604054438.3424349-14-jamin_lin@aspeedtech.com>
 <ffafbec0-db25-478b-8eba-39162f9bce0d@linaro.org>
 <SI2PR06MB5041F84077718CE5A58B8F54FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041F84077718CE5A58B8F54FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6200:EE_
x-ms-office365-filtering-correlation-id: 680fcb92-9f85-4ee2-8a61-08dd44266a01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?eldHekcvNnVhaW1CZDFJWmR2b0JCNE1KdU5NVzAzSVZqMXpNU3praFJNWGtD?=
 =?utf-8?B?Tm55V0Z4VzFXemlEZXh6QlJzZTJwZGNydUZ5S25sS3NpREdRdFBlU085SmdP?=
 =?utf-8?B?QUNuQ045U0tXM1FBbWtMbmE3RjdZa2tSbDBHUURmOVFBZ3I3d3BvYSttU0Mw?=
 =?utf-8?B?M09RNi9scnpPK1pBaHJCNENyN1QyM0V6eCs3WGE5STRLTW1JdGsrOWlGelBP?=
 =?utf-8?B?STk2RHNIUU1GQVlEM2pRTzl3Z3o1cnpKVVhBajlZblJud1dVbkk0a0dYcTE2?=
 =?utf-8?B?TDMrK3R4SmVqRGY4TWh1SE80M3I0cDV4U3JWQzRKTGx5Wm9PMFN6TjAwZVd0?=
 =?utf-8?B?UkEvNXE2eHpOaDMzWFlwQjFCZ1dKVkZWMTFHcU9VYnVXKyt5ZVpmalRIZktM?=
 =?utf-8?B?RWwyTXhLVnA0WEpudlFpaExWYjJjYmgzSCtNdVcvOXpLVGxnVUFQaUlwMFVZ?=
 =?utf-8?B?Q0RuNU1Jb3BPQU05S25LakkrTUJRTkloRWlwSUZFMDU5ZmZ4emUxd2JqSSsr?=
 =?utf-8?B?RFgxaktCT3hoeVl5dXNYekl2V1docHlWaWFqR0dBSHlULzZoVjZBaWlSZ0dy?=
 =?utf-8?B?M2VmZGNTUVhRZW5idG5Xd2hBMG9YeXNPWWYvM0pPUit6aFlUb0FGTGFEZ1BL?=
 =?utf-8?B?NXB3RVdwMUN1RjZmRFhKVVc3VXUyQ2tRNXdmVlhrSndGTVFpb2RVSmVLUE92?=
 =?utf-8?B?ay9PMVRxY0FkU2lsbnJZbXNYb1ZMamZzWGdWNkNtRkVVeS9GSEpFSXM3aE0z?=
 =?utf-8?B?ZWpFOVB6WWtEOW5qbjRXQ3JtcHU1NjN4bnZVUVBFaU9CbHV2T0VueUFvRFNs?=
 =?utf-8?B?cERobG1obWdMVy9raTRkYm4rMXdQei9GUXI1a2UvWkhIbmJHOVRFeVgxSENu?=
 =?utf-8?B?RXhiRmtrVWFLK3NWV24vK2FURjNsN0xZS0hYTEVUQXV5TnZoc3ZveEU1ZjhO?=
 =?utf-8?B?bGJCU2xsQUZDODJiS1JVRVZRRHAzWWR6K25FWDIwaDVGcHhkQWgwclJiK1NY?=
 =?utf-8?B?TE10UFZ3Uzd0amlwai9pTXd5SVRnL0JoTkhHTmpQSGV0MEFKZ0tNY3l4UG1G?=
 =?utf-8?B?NitxWEhNQ1d5SGZ0R3Uxc0NEOHJ3SGVyN21scUI4QmZ0MDBTb211TVRqQmlX?=
 =?utf-8?B?ZGkwNmtNbG1WOHorb0NyTERsUVpaQTRZSDYrM01PZG9td1ZIODczdW9JcFNI?=
 =?utf-8?B?UlN3RDMrdjFHZUUzb0VuajcxS3FDelhXRE9HUHBXY1FpRStockdkeWVYSmhL?=
 =?utf-8?B?OWpaT0JpU2VHa0MrU3VkVlN0U2FjaXZHWWtvU01rUCtCeTZiNmgyTjkzdFRx?=
 =?utf-8?B?Lzk4c2RQdVFGRmxNTVFNdmFrSWhLLzhiZkNZaHhTT2FkekJUR0J2UzlUajl2?=
 =?utf-8?B?cE5hVTR2OVVTSUZ6R09SdkR5bVRlUWJaODdyK29mN3hQeXNCSGhTd3pDMXhw?=
 =?utf-8?B?Q3I3U0tWVTQ0ak5jbGFWTnYzeXBMQUJTekt4WStRTnphUWFKNTRzcjdOanlR?=
 =?utf-8?B?THE4MlZJcm0veFZaRjloYnYvMHdFbm51ZFBBdndwRStNdlliMkpVZFZJcWg4?=
 =?utf-8?B?VDhVa3F0VHNqWUNUYVJ2eFUyTHNBT0pIYk5YZkVmRHJTR1dMTmNocXJDYjRo?=
 =?utf-8?B?VG9PVjVqU3JPUWJ3aGdEbkQvZzZ4aGdLSXloS0ZBSGlubjFhWkptQXFxNVRS?=
 =?utf-8?B?blJPeVdpajVNd3ByaDNEQSsxc2J3alpjYmpTak1nRjY1UXIrOXM3cVNRRmVq?=
 =?utf-8?B?dmVJbHJ0YVlQWkhoa1g4MUVSdEF4SitTMjRab1FUSVFxbDF4SGhpRWJzZm50?=
 =?utf-8?B?WVo1cWFoWXVrczZNVUMvTEVjQ1N1cTBXZWZDbDNBR3pZcm1mengwbkR3RnAz?=
 =?utf-8?B?eDZJZFcyUkhGZGpaYjBRMmlnc0tiOU0vcXhXdXp3L3JXT1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGdNYWFOckpQcFNPTTVqR25DWFVNSEx1eFNFZ2dMS2Z0U1JKd2ROc2RKT2Jw?=
 =?utf-8?B?N3V0LzVZN2FRSU1OdmRkZCtqTDc1L011WG04V2pCSEx0dG9CSFhLd3k1eGpN?=
 =?utf-8?B?YzN0d2tJeTJrd3Exbmx6Q01HTGJFbkFrSkgvd2FXa1BLVzdpZlZSUjF2bnZP?=
 =?utf-8?B?NFp6aWlRbFVUbmpYbEhTbXc1NEI5NFIvWlVIdW5URVR2Q1FGWG45Wkw5QWN1?=
 =?utf-8?B?UE9zcTB5cUdpNHZ1SWFqK3hEbzlUZ1VNcFNxTXEvbXFnMFBPTUpkWDdqWXhW?=
 =?utf-8?B?R0JIVU1ObWFCcFUzWWI5MEpncDVmdk9CcjdMWnlveUw0ZGs3eXJhNzQ1U1RK?=
 =?utf-8?B?bzZZL2lvZ2RUM1Q5U2VNZ0kzc1FOZGZSWnQ3N0VwY2t4UjZWMWtJSFBIVnFz?=
 =?utf-8?B?R21ZazhkZ2JTZ3VhUU0vcGN1ZXZzZVNEZ2szSDZRRTRzNkhPbi9nYzVoMng5?=
 =?utf-8?B?aFJ0ekJuNGtBZ1JWeHE4cnczNi9WMjNsa0VwdzBQakR5cHBtUG9sdzA2ZGts?=
 =?utf-8?B?WUx3TUxnaThFclhpRVZGL2REQ2ljNW44M1dCdFJkeDhwTVBCaUdLZ3o4Sit6?=
 =?utf-8?B?VkoxSnoxQ25PT2hndFpMYkY2K2V6d045ZzBRdFhDdzRHajZPd2ZpSmJpbXRo?=
 =?utf-8?B?V0xsL1VxRHdDYi9EU0FMV0dNVmZaQUl3OHFYdk14SW1XYVhmNkZaTks3cDNn?=
 =?utf-8?B?c1VNYVErTWhITDE1SzJiOG1NSXZPVG1YSDBjY2E0UTZhQWxhM3RJd0g0OWxQ?=
 =?utf-8?B?eGF5UmRmZEJ0ZWFiNkZuRmVTS0F3L3h4bDBOd0xTcXVXdTZLcEttR0JnTXlK?=
 =?utf-8?B?S2xRSlhCMS9PV2hPQ3RZMTZ5K25PNlZZbXVCRzhaVXhJSDlzVEN1S3kxS3Ja?=
 =?utf-8?B?ZHhIdit0UzJOYzBqREJKZklKTm9mMnB4M281SzB4QnZ1ckFEUk8ydy9oYkFk?=
 =?utf-8?B?TEwwemlVRnVwLzNRazF6WkpIcGFnUjdWa2FNT210akZIekIvZDBya0MwdlZn?=
 =?utf-8?B?STN6WGpjNDFmRlpKVkk0RmNFSzBocm1qQkVxQkl1WlV3YXkxU1RyNkc5cHgy?=
 =?utf-8?B?Tm5EbmV6L2MzdGlSSG01UDUrVnNLVDIvNkwzSTdubHZmNzR6L0FiWEpZRmps?=
 =?utf-8?B?ajRLYU1PVUkraERwaDhhTS9NWWV1S2NQNDZnUFIzL1JGYXRnV3dWZ1JoTGhR?=
 =?utf-8?B?T2tKbW1SWWM0c09TVnl0ckZ5UEN2K3FJNzdJS3FFb1AwNVZaR2p0MmpSMUVG?=
 =?utf-8?B?OXJRY2c4dTNsWW15YTQzaWViMGJtdmlrQTV6VkpKZ3VDMWorNHRPU0xCb3g0?=
 =?utf-8?B?TVRsUGN0M2QxZ1F5N0NYTk5zV1hmRUxrYkhBTGo3SSs4NlVWSXdqVVJHbjFP?=
 =?utf-8?B?TFpFa05ic1VSZkhoQTAvejNqMDlSanFqZ1RNUlNQZDFuVVhHU0UzL3Jrak50?=
 =?utf-8?B?L1B4a29ScHNFV0treVdwazdzMjNKQ09iU2RQWkEwS2FzTTRGcmNFamxQbHRP?=
 =?utf-8?B?dm9oMmVzQml5QUhNSkhUNGJLZy9Sa1lDcmF6QXQ2Y2ZXcE1ZU3hJY2l6SzR3?=
 =?utf-8?B?NTNBbGhNYmgvTHZHZWJmQ2hBQ0VKZ0xZc0JRSkJLWFBHT0VCVUJTNHVnVWJJ?=
 =?utf-8?B?MDUra1BuV0JYQU4wdWdHZWY2Ykl0cU5pRmpWYmNtV2VWMjhXWDJDd3c4aDl5?=
 =?utf-8?B?ZU9VRTlOY3FpQmI2b2JrQmgrQm5ieUxoQ0FSbnB4d0NuWFQrREFiZUJ1cGs2?=
 =?utf-8?B?SDJpWEpKZmRFUE9IcXpXVE9SNWRmNStTYW5iTzRIWFBlanBLT0FSVUw1dndV?=
 =?utf-8?B?SjNjMmxCTXhDQjgyVmR1eVBPckNyU1hjWDhPck1yUTdhT0pCK1RjUnloSWtz?=
 =?utf-8?B?Mm4veWRCb0xSYUZaTXd2VjQwOFUzOG5oa0dNRW1PZjdnQkxwT0x6MG5jMk9X?=
 =?utf-8?B?MUlFd0Zod09YVmRtRmNNRHp6d0tOS3dkSzQ5Znp2dTdQcnBKWXNWYVkwUlFl?=
 =?utf-8?B?UUFGZ1pxaitDRjNhcFlIZWo3cW1Qa25vcFJwRlpPSkIrWXdleHZLekNNYzRR?=
 =?utf-8?B?ZFhHNk13VCtGdVk4VFNDMWZWbFhsaStYdjRaaGZtRDg5eFRGME53OWRrMnRT?=
 =?utf-8?Q?WcvGgsU1nGbgZAzGhwyGm+eV4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680fcb92-9f85-4ee2-8a61-08dd44266a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 07:43:13.3862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gT992w6qACqrI9SDNN+JmB/xIAeku7yPIBB/5LPMuHymTbkQ21eNurdUMjEtoYnC9E+BHuWwsE7JUZ1dpQhuVowob61rcmGtLvYDWSyLrSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6200
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

SGkgUGhpbGlwcGUsDQoNCj4gRnJvbTogSmFtaW4gTGluDQo+IFNlbnQ6IE1vbmRheSwgRmVicnVh
cnkgMywgMjAyNSAzOjI5IFBNDQo+IFRvOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QGxpbmFyby5vcmc+OyBDw6lkcmljIExlIEdvYXRlcg0KPiA8Y2xnQGthb2Qub3JnPjsgUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgQW5kcmV3IEplZmZlcnkNCj4gPGFu
ZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+
OyBBbGlzdGFpcg0KPiBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPjsgQ2xlYmVyIFJv
c2EgPGNyb3NhQHJlZGhhdC5jb20+OyBXYWluZXINCj4gZG9zIFNhbnRvcyBNb3NjaGV0dGEgPHdh
aW5lcnNtQHJlZGhhdC5jb20+OyBCZXJhbGRvIExlYWwNCj4gPGJsZWFsQHJlZGhhdC5jb20+OyBv
cGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+IGxpc3Q6
QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgSmluamllIFJ1YW4N
Cj4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3Bl
ZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4N
Cj4gU3ViamVjdDogUkU6IFtQQVRDSCB2NSAxMy8xN10gYXNwZWVkL3NvYzogQWRkIEFTVDI3MDAg
c3VwcG9ydA0KPiANCj4gSGkgUGhpbGlwcGUsDQo+IA0KPiA+IEZyb206IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gPiBTZW50OiBUaHVyc2RheSwgSmFudWFy
eSAzMCwgMjAyNSAxMToxNCBQTQ0KPiA+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT47IEPDqWRyaWMgTGUgR29hdGVyDQo+ID4gPGNsZ0BrYW9kLm9yZz47IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEFuZHJldw0KPiA+IEplZmZlcnkgPGFu
ZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+
Ow0KPiA+IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBDbGViZXIg
Um9zYQ0KPiA+IDxjcm9zYUByZWRoYXQuY29tPjsgV2FpbmVyIGRvcyBTYW50b3MgTW9zY2hldHRh
DQo+IDx3YWluZXJzbUByZWRoYXQuY29tPjsNCj4gPiBCZXJhbGRvIExlYWwgPGJsZWFsQHJlZGhh
dC5jb20+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4gPiA8cWVtdS1hcm1Abm9uZ251Lm9yZz47
IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+ID4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zz47IEppbmppZSBSdWFuIDxydWFuamluamllQGh1YXdlaS5jb20+DQo+ID4gQ2M6IFRyb3kgTGVl
IDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+ID4gPHl1bmxpbi50YW5n
QGFzcGVlZHRlY2guY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTMvMTddIGFzcGVl
ZC9zb2M6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gPg0KPiA+IEhpIEphbWluLA0KPiA+DQo+ID4g
T24gNC82LzI0IDA3OjQ0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gPiBJbml0aWFsIGRlZmluaXRp
b25zIGZvciBhIHNpbXBsZSBtYWNoaW5lIHVzaW5nIGFuIEFTVDI3MDAgU09DDQo+ID4gPiAoQ29y
dGV4LWEzNQ0KPiA+IENQVSkuDQo+ID4gPg0KPiA+ID4gQVNUMjcwMCBTT0MgYW5kIGl0cyBpbnRl
cnJ1cHQgY29udHJvbGxlciBhcmUgdG9vIGNvbXBsZXggdG8gaGFuZGxlDQo+ID4gPiBpbiB0aGUg
Y29tbW9uIEFzcGVlZCBTb0MgZnJhbWV3b3JrLiBXZSBpbnRyb2R1Y2UgYSBuZXcgYXN0MjcwMCBj
bGFzcw0KPiA+ID4gd2l0aCBpbnN0YW5jZV9pbml0IGFuZCByZWFsaXplIGhhbmRsZXJzLg0KPiA+
ID4NCj4gPiA+IEFTVDI3MDAgaXMgYSA2NCBiaXRzIHF1YWQgY29yZSBjcHVzIGFuZCBzdXBwb3J0
IDggd2F0Y2hkb2cuDQo+ID4gPiBVcGRhdGUgbWF4aW11bSBBU1BFRURfQ1BVU19OVU0gdG8gNCBh
bmQgQVNQRUVEX1dEVFNfTlVNIHRvIDguDQo+ID4gPiBJbiBhZGRpdGlvbiwgdXBkYXRlIEFzcGVl
ZFNvY1N0YXRlIHRvIHN1cHBvcnQgc2N1aW8sIHNsaSwgc2xpaW8gYW5kIGludGMuDQo+ID4gPg0K
PiA+ID4gQWRkIFRZUEVfQVNQRUVEMjdYMF9TT0MgbWFjaGluZSB0eXBlLg0KPiA+ID4NCj4gPiA+
IFRoZSBTRE1DIGNvbnRyb2xsZXIgaXMgdW5sb2NrZWQgYXQgU1BMIHN0YWdlLg0KPiA+ID4gQXQg
cHJlc2VudCwgb25seSBzdXBwb3J0cyB0byBlbXVsYXRlIGJvb3Rpbmcgc3RhcnQgZnJvbSB1LWJv
b3Qgc3RhZ2UuDQo+ID4gPiBTZXQgU0RNQyBjb250cm9sbGVyIHVubG9ja2VkIGJ5IGRlZmF1bHQu
DQo+ID4gPg0KPiA+ID4gSW4gSU5UQywgZWFjaCBpbnRlcnJ1cHQgb2YgSU5UIDEyOCB0byBJTlQg
MTM2IGNvbWJpbmVzIDMyIGludGVycnVwdHMuDQo+ID4gPiBJdCBjb25uZWN0IEdJQ0lOVCBJUlEg
R1BJTy1PVVRQVVQgcGlucyB0byBHSUMgZGV2aWNlIHdpdGggaXJxIDEyOCB0byAxMzYuDQo+ID4g
PiBBbmQsIGlmIGEgZGV2aWNlIGlycSBpcyAxMjggdG8gMTM2LCBpdHMgaXJxIEdQSU8tT1VUUFVU
IHBpbiBpcw0KPiA+ID4gY29ubmVjdGVkIHRvIEdJQ0lOVCBvci1nYXRlcyBpbnN0ZWFkIG9mIEdJ
QyBkZXZpY2UuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJveSBMZWUgPHRyb3lfbGVl
QGFzcGVlZHRlY2guY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9s
aW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMgICAgIHwgNTYzDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gPiAgIGh3L2FybS9tZXNvbi5idWlsZCAgICAgICAgICB8ICAgMSArDQo+ID4gPiAgIGlu
Y2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCB8ICAyOCArLQ0KPiA+ID4gICAzIGZpbGVzIGNoYW5n
ZWQsIDU5MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPg0KPiA+DQo+ID4gPiArc3RhdGlj
IGJvb2wgYXNwZWVkX3NvY19hc3QyNzAwX2dpY19yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVy
cm9yDQo+ID4gPiArKiplcnJwKSB7DQo+ID4gPiArICAgIEFzcGVlZDI3eDBTb0NTdGF0ZSAqYSA9
IEFTUEVFRDI3WDBfU09DKGRldik7DQo+ID4gPiArICAgIEFzcGVlZFNvQ1N0YXRlICpzID0gQVNQ
RUVEX1NPQyhkZXYpOw0KPiA+ID4gKyAgICBBc3BlZWRTb0NDbGFzcyAqc2MgPSBBU1BFRURfU09D
X0dFVF9DTEFTUyhzKTsNCj4gPiA+ICsgICAgU3lzQnVzRGV2aWNlICpnaWNidXNkZXY7DQo+ID4g
PiArICAgIERldmljZVN0YXRlICpnaWNkZXY7DQo+ID4gPiArICAgIFFMaXN0ICpyZWRpc3RfcmVn
aW9uX2NvdW50Ow0KPiA+ID4gKyAgICBpbnQgaTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgZ2ljYnVz
ZGV2ID0gU1lTX0JVU19ERVZJQ0UoJmEtPmdpYyk7DQo+ID4gPiArICAgIGdpY2RldiA9IERFVklD
RSgmYS0+Z2ljKTsNCj4gPiA+ICsgICAgcWRldl9wcm9wX3NldF91aW50MzIoZ2ljZGV2LCAicmV2
aXNpb24iLCAzKTsNCj4gPiA+ICsgICAgcWRldl9wcm9wX3NldF91aW50MzIoZ2ljZGV2LCAibnVt
LWNwdSIsIHNjLT5udW1fY3B1cyk7DQo+ID4gPiArICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKGdp
Y2RldiwgIm51bS1pcnEiLCBBU1QyNzAwX01BWF9JUlEpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBy
ZWRpc3RfcmVnaW9uX2NvdW50ID0gcWxpc3RfbmV3KCk7DQo+ID4gPiArICAgIHFsaXN0X2FwcGVu
ZF9pbnQocmVkaXN0X3JlZ2lvbl9jb3VudCwgc2MtPm51bV9jcHVzKTsNCj4gPiA+ICsgICAgcWRl
dl9wcm9wX3NldF9hcnJheShnaWNkZXYsICJyZWRpc3QtcmVnaW9uLWNvdW50IiwNCj4gPiA+ICsg
cmVkaXN0X3JlZ2lvbl9jb3VudCk7DQo+ID4gPiArDQo+ID4gPiArICAgIGlmICghc3lzYnVzX3Jl
YWxpemUoZ2ljYnVzZGV2LCBlcnJwKSkgew0KPiA+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0K
PiA+ID4gKyAgICB9DQo+ID4gPiArICAgIHN5c2J1c19tbWlvX21hcChnaWNidXNkZXYsIDAsIHNj
LT5tZW1tYXBbQVNQRUVEX0dJQ19ESVNUXSk7DQo+ID4gPiArICAgIHN5c2J1c19tbWlvX21hcChn
aWNidXNkZXYsIDEsDQo+IHNjLT5tZW1tYXBbQVNQRUVEX0dJQ19SRURJU1RdKTsNCj4gPiA+ICsN
Cj4gPiA+ICsgICAgZm9yIChpID0gMDsgaSA8IHNjLT5udW1fY3B1czsgaSsrKSB7DQo+ID4gPiAr
ICAgICAgICBEZXZpY2VTdGF0ZSAqY3B1ZGV2ID0gREVWSUNFKCZhLT5jcHVbaV0pOw0KPiA+ID4g
KyAgICAgICAgaW50IE5VTV9JUlFTID0gMjU2LCBBUkNIX0dJQ19NQUlOVF9JUlEgPSA5LA0KPiA+
IFZJUlRVQUxfUE1VX0lSUSA9IDc7DQo+ID4gPiArICAgICAgICBpbnQgcHBpYmFzZSA9IE5VTV9J
UlFTICsgaSAqIEdJQ19JTlRFUk5BTCArIEdJQ19OUl9TR0lTOw0KPiA+ID4gKw0KPiA+ID4gKyAg
ICAgICAgY29uc3QgaW50IHRpbWVyX2lycVtdID0gew0KPiA+ID4gKyAgICAgICAgICAgIFtHVElN
RVJfUEhZU10gPSAxNCwNCj4gPiA+ICsgICAgICAgICAgICBbR1RJTUVSX1ZJUlRdID0gMTEsDQo+
ID4gPiArICAgICAgICAgICAgW0dUSU1FUl9IWVBdICA9IDEwLA0KPiA+ID4gKyAgICAgICAgICAg
IFtHVElNRVJfU0VDXSAgPSAxMywNCj4gPiA+ICsgICAgICAgIH07DQo+ID4gPiArICAgICAgICBp
bnQgajsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgIGZvciAoaiA9IDA7IGogPCBBUlJBWV9TSVpF
KHRpbWVyX2lycSk7IGorKykgew0KPiA+ID4gKyAgICAgICAgICAgIHFkZXZfY29ubmVjdF9ncGlv
X291dChjcHVkZXYsIGosDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICBxZGV2X2dldF9ncGlv
X2luKGdpY2RldiwgcHBpYmFzZSArDQo+IHRpbWVyX2lycVtqXSkpOw0KPiA+ID4gKyAgICAgICAg
fQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgcWVtdV9pcnEgaXJxID0gcWRldl9nZXRfZ3Bpb19p
bihnaWNkZXYsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBwaWJhc2UgKw0KPiA+IEFSQ0hfR0lDX01BSU5UX0lSUSk7DQo+ID4gPiArICAgICAgICBxZGV2
X2Nvbm5lY3RfZ3Bpb19vdXRfbmFtZWQoY3B1ZGV2LA0KPiA+ICJnaWN2My1tYWludGVuYW5jZS1p
bnRlcnJ1cHQiLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAs
IGlycSk7DQo+ID4gPiArICAgICAgICBxZGV2X2Nvbm5lY3RfZ3Bpb19vdXRfbmFtZWQoY3B1ZGV2
LCAicG11LWludGVycnVwdCIsIDAsDQo+ID4gPiArICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dw
aW9faW4oZ2ljZGV2LCBwcGliYXNlICsNCj4gPiBWSVJUVUFMX1BNVV9JUlEpKTsNCj4gPiA+ICsN
Cj4gPiA+ICsgICAgICAgIHN5c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGksIHFkZXZfZ2V0
X2dwaW9faW4oY3B1ZGV2LA0KPiA+IEFSTV9DUFVfSVJRKSk7DQo+ID4gPiArICAgICAgICBzeXNi
dXNfY29ubmVjdF9pcnEoZ2ljYnVzZGV2LCBpICsgc2MtPm51bV9jcHVzLA0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4oY3B1ZGV2LA0KPiA+IEFSTV9D
UFVfRklRKSk7DQo+ID4gPiArICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEoZ2ljYnVzZGV2LCBp
ICsgMiAqIHNjLT5udW1fY3B1cywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBx
ZGV2X2dldF9ncGlvX2luKGNwdWRldiwNCj4gPiBBUk1fQ1BVX1ZJUlEpKTsNCj4gPiA+ICsgICAg
ICAgIHN5c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGkgKyAzICogc2MtPm51bV9jcHVzLA0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4oY3B1ZGV2
LA0KPiA+IEFSTV9DUFVfVkZJUSkpOw0KPiA+DQo+ID4gWW91ciBwYXRjaCB3YXMgbWVyZ2VkIGFy
b3VuZCB0aGUgc2FtZSB0aW1lIEppbmppZSBhZGRlZCBOTUkgc3VwcG9ydA0KPiA+IChzZWUgY29t
bWl0IGIzNmEzMmVhZDEgInRhcmdldC9hcm06IEFkZCBzdXBwb3J0IGZvciBOb24tbWFza2FibGUN
Cj4gSW50ZXJydXB0IikuDQo+ID4NCj4gPiBTaG91bGQgd2UgYWRkIHRoZW0gbm93Pw0KPiA+DQo+
IA0KPiBBZnRlciBJIHJlYWQgdGhpcyBjb21taXQsIGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3Fl
bXUvY29tbWl0L2IzNmEzMmVhZCwNCj4gaXQgc2VlbXMgdGhhdCBpdCBpbXByb3ZlcyB0aGUgaGFu
ZGxpbmcgb2YgQVJNX0NQVV9WSVJRIGFuZA0KPiBBUk1fQ1BVX1ZGSVEuDQo+IEkgdGVzdGVkIHRo
ZSBjaGFuZ2VzIGJ5IHJlbW92aW5nIHRoZSBmb2xsb3dpbmcgbGluZXMgYW5kIHdvcmtlZCBmb3Ig
QVNUMjcwMC4NCj4gDQo+IHN5c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGkgKyAyICogbnJf
YXB1X2NwdXMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbihj
cHVkZXYsIEFSTV9DUFVfVklSUSkpOw0KPiBzeXNidXNfY29ubmVjdF9pcnEoZ2ljYnVzZGV2LCBp
ICsgMyAqIG5yX2FwdV9jcHVzLA0KPiAgICAgICAgICAgICAgICAgICBxZGV2X2dldF9ncGlvX2lu
KGNwdWRldiwgQVJNX0NQVV9WRklRKSk7DQo+IA0KPiBBcmUgeW91IHN1Z2dlc3RpbmcgdGhhdCB0
aGVzZSBsaW5lcyBzaG91bGQgYmUgcmVtb3ZlZD8NCj4gDQo+IFRoYW5rcy1KYW1pbg0KPiANClNv
cnJ5LCBJIG1pc3VuZGVyc3Rvb2QgeW91ciBxdWVzdGlvbi4NCkkgcmVmZXJyZWQgdG8gdGhpcyBs
aW5lLCBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Jsb2IvbWFzdGVyL2h3L2FybS92aXJ0
LmMjTDkwNywgaW4gUUVNVSdzIHZpcnQuYyB0byBhZGQgTk1JIHN1cHBvcnQuDQoNCkFyZSB5b3Ug
c3VnZ2VzdGluZyBhZGRpbmcgdGhlIGZvbGxvd2luZyBsaW5lcyB0byBlbmFibGUgTk1JIHN1cHBv
cnQ/DQpJdCB3b3JrZWQgYXMgd2VsbC4NCg0KYGBgDQpzeXNidXNfY29ubmVjdF9pcnEoZ2ljYnVz
ZGV2LCBpICsgNCAqIHNjLT5udW1fY3B1cywNCiAgICAgICAgICAgICAgICAgICBxZGV2X2dldF9n
cGlvX2luKGNwdWRldiwgQVJNX0NQVV9OTUkpKTsNCnN5c2J1c19jb25uZWN0X2lycShnaWNidXNk
ZXYsIGkgKyA1ICogc2MtPm51bV9jcHVzLA0KICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dw
aW9faW4oY3B1ZGV2LCBBUk1fQ1BVX1ZJTk1JKSk7DQpgYGANCg0KVGhhbmtzLUphbWluDQoNCj4g
PiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICByZXR1cm4gdHJ1ZTsNCj4gPiA+ICt9DQo=

