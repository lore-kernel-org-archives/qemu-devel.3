Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A07C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 01:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Oq2-0001aX-Pk; Tue, 22 Apr 2025 21:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7Opu-0001Xo-Oy; Tue, 22 Apr 2025 21:23:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7Opo-0002aR-Hk; Tue, 22 Apr 2025 21:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6/A2cP2tGljpz0NwwJbO4kULV0CJ8IflOdYNJWqab77wJomo1hnxcCZ2wzrvs/WDSab3oE0W/b3DcZN6ZKZK9NZwXIxINft5Nh05cXtg0J67weZefyKPMaycMOkwcg+oSCCwFEBCHMzvBrnFOkh5Ink5JDlStwG3VhW7Iy8eu8aZe0q+hbPfizlOmAwHUSi6Zup835sNcgkXQjqR1nySl4qUkGQ3BNc9VcQVtOEf0dfHjtt8pTmZypXhwuDF1S/gY76pmCDkraXi+fzkofyWQa9QLYX9DzHbC7WmDU8nXTuK0I3wYgUdE6WQS0bJTDlofaFNXYy7o/aN349UwmqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nyKVyOlZV9lg41ryJcGLKHMiIDBDSrAwId+EM9ou/s=;
 b=EIB5JIYWnDeD39oNoQGDpYJFFoAlIVm3ViPPnFJvVRpTDWu0P9CHHF5aC0Kv0/VLryOSyJ0rOShhfFzKsu4KUJSO7nLyXQRCwp9GJPgd+38VLZPXiwSzC26m1UMmaeDN3qIpsK1p6yaX0SHu2idhz11wGG5bp8YMEi60MyaTHR+eFD8qhnlaV48RDu5+SLN40DqCrKT43M8Ln1GJelPxI+gD60RStLwqPrMM6KAXFizyG9L8oRkrXl2mODTS2YkiesEhWNfhK4aO26kbz62Mklgx4wkoPAP+aD/BAsOvgi6bmSFIGUQA5pcq+aYK0iVywwohdVqqS8TWI+f+38jMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nyKVyOlZV9lg41ryJcGLKHMiIDBDSrAwId+EM9ou/s=;
 b=cg0aXi+PEihroK2odihKJAbx0YCMnyznJtAxlWQV5UU4Chb39rfvsG4v4hZ8TDaNvKfAAV/rGym+tQvvmEBbAvLzNeLhKhUsFZ3c2DGeGmxcOVmIm+AaoYB83VUjxfd6W76G/blr3ZH6ByXdPBH2Pyq8qBazRLdAMU2Amx1mnYc7EVPDraijsUiMCTvyFDRJI972+dZGPtmUefdiwgBDNLkESXVmTvMPnyZ42JMMdlfPgrmZ35Pgu15FUnsDdOqvtCkZsuFetRbwckiatHveS7hnPl5nUD+lRZC1XyVu0Kt0HU+n1tQke3HAlhllG1n03KzJn68jU3v7Mx+jHRtlng==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5392.apcprd06.prod.outlook.com (2603:1096:101:67::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.36; Wed, 23 Apr 2025 01:23:18 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 01:23:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 3/3] tests/functional/aspeed: Update test ASPEED SDK
 v03.00 for AST1030
Thread-Topic: [PATCH v1 3/3] tests/functional/aspeed: Update test ASPEED SDK
 v03.00 for AST1030
Thread-Index: AQHbs2cxXEyhnwElTEaB9ImYcAIeCLOvlPoAgADfTDA=
Date: Wed, 23 Apr 2025 01:23:18 +0000
Message-ID: <SI2PR06MB5041C15FA2F41BC534CC57EBFCBA2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250422091504.3666464-1-jamin_lin@aspeedtech.com>
 <20250422091504.3666464-4-jamin_lin@aspeedtech.com>
 <96075887-ed11-4a58-a57c-899646d9ce3f@kaod.org>
In-Reply-To: <96075887-ed11-4a58-a57c-899646d9ce3f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5392:EE_
x-ms-office365-filtering-correlation-id: 5131fc34-cd6a-402a-b655-08dd82056dce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZEdxMmVYdGVWN21ZVWNjVitaWXJ5TVBvVmcwVXhXVXZYUGhBbHJqUWkycWRj?=
 =?utf-8?B?TG9WdHcycEhzbmJvcFVlUm94MUhoYjc2RFcxMkhheGdrK3pOL2dJa0RkblNo?=
 =?utf-8?B?QTZiejljVlEvRDhtMXY5ZUMrdERBc2wyUVNHaGJLcXZpdEVKU29aRXpzT3VM?=
 =?utf-8?B?eUtiZFpHalFjR2RNSWxBODNydDVrOXVHYk1pTlh5UzhCbXpLVWRZZkR2aXNu?=
 =?utf-8?B?Mk90N1pxYXl3MlBaUXdNQnQya1RpYjdqdTJVM2FRWkNOaFYwbGNzM2NYeEFt?=
 =?utf-8?B?NWtDTmhlMk56V3J2NElsNlNlNGRRRmxWTjFGRDZuKzliTlh5TFdQeGVtSzcz?=
 =?utf-8?B?K1BJWldtM2xtVnduNFBUNWNIZm95ZG5BQ29ndEFiN3BwS3ZXREhwTXZxRi93?=
 =?utf-8?B?TDFKa1JPQjQ4TG9iN1NMTFIzSXkyZk9qazVkKzNVbFVwbDVqanFtdFBWSXZW?=
 =?utf-8?B?Z2hVeTNxdTBDejFIR3ZuTzZGVENuakZOQ0N1OXpiWWszbkRsaGVOSElvQXUv?=
 =?utf-8?B?WVloUmJvVVQyYWJhbTF4Vk53RXZOdzlXSkVjdjlUSlJXdVQ2V2hRQnZYZU1P?=
 =?utf-8?B?WVFFcTBFZE9wRWFtemQ1VUowTGlaSktFb3BOa0gyL2FLTlZvaVBNT09WOG1n?=
 =?utf-8?B?Mm11OHdNWmc5SmRDQk5paDU1Q1grS1BUVk44TlNFRXJ2L0MzeDg3VlViR01S?=
 =?utf-8?B?YmM3VDR4QmdwYXdvYldtWUptcFFmSjE3b1B0cDhpd3kycWVmUmlhVjVKYU5B?=
 =?utf-8?B?T3poL3dWeW1JWUQyNGJyWUZOZUlLSFJzVkRJQVBpY3d4bjZBUDFlSk5iWm5V?=
 =?utf-8?B?VXR4Ui9FNGZrenRWcDIwV3Bwbm5MNTNwbkpLRVh1cDRDVVp1TXhHSjUzT2Nk?=
 =?utf-8?B?YS82N3lsQU1GOGtveFNVaWlJVHNqbkZETEZTQlh1b3hQQlFteDlBejVzc2lk?=
 =?utf-8?B?RzRrMlhVRWNtTXV0TnE1OW5QOEZjQS9rRloyNDl3WUo5OGdnWG5pKzM4dVRI?=
 =?utf-8?B?Z0JrRnFkUzRVekNNOXMzY0VxeEtXZnk2S2pxcGllWFc1TURkcWZ4L3NaOWh4?=
 =?utf-8?B?QWFGc0x4SllZZWpDRUhsZnhUQ1JJQXNicjBPVzhwVFMrMVZQeEFtVytDUUht?=
 =?utf-8?B?eVBNVG9oUnZoVE1WdmhUdmk0N2VlSktVczRVRkl1TnJ6c1dPbHhEZk9OajZ1?=
 =?utf-8?B?ZnVKTHhmemZXY1BTaWU3MzdpYnpiN3hKL0p6WTVVcGdXaVBGUTI0M1NIUFNs?=
 =?utf-8?B?bkxGcTZ3MW1CQ0o1SFFJcGZGbnRwZlY3Y3VUZGdRYTF5ejdQZDNnWC9ESDVY?=
 =?utf-8?B?c1J3dlhhcFVvRXMxeURTbnBhUDdlUUhjUXJKM2FlcG10VUFsTSt0dmlSTWVy?=
 =?utf-8?B?MTZyYkIvYmZ1YUdzRHpjMnRuNnBNKzJyUDBkanpDak9FR2FSK041UnhFbXFC?=
 =?utf-8?B?MmNEMlZUWUhtSnhPMWdJSk1DcW82d1QwQkNZZC9QUVFTbGVoSWlFaVUzaytT?=
 =?utf-8?B?Y2FjSXBYVENuQUQ2eDJJREJnMFJ0WUtEYUhYZkdDSGhZaHprUWRWNkxtM1RP?=
 =?utf-8?B?MklkVWlXcDhYMFl1dlRTL1RTMWJBSGUzVE8zUWFqTUsxamFZTmt4UUIzek9t?=
 =?utf-8?B?ZXRjUmpoeFRubFg5RTd3Z1FRc2h4RDhpWFJZU3VoZUt1TjQvbHpLOWs4WEEr?=
 =?utf-8?B?V3R3SnJ5ZUxwME1ic0k5N2dZRXlIZHFGblNFK0lpaU5ia3U5QjZ4Vmpxd0xv?=
 =?utf-8?B?WTdMck9uTjBMeFBCbE55UTNiYXl1MFpLa0IxN0U5RGFJc2pwSThJQzEvL28z?=
 =?utf-8?B?OGVjYk96RlA4T0F4eUp1Z2Y3SUdDeWZqR0RmeXBqZGNvUVk3SnlxaEd2b0JO?=
 =?utf-8?B?cWpDTEVSYlNPb2xSSzNJcktYNys5cnlVSFNEdlJGd1duZjlHWXpUOGlvN0RK?=
 =?utf-8?B?K01GMXBSZktEUFExQXRCdXE4Sm5SdUc4eE1wWkl1dWNqL0VzTGNvZ1BEaStt?=
 =?utf-8?Q?vz0dC189pWuMLAm+Cof9Xnzp2UIRUY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW9sV0NDTTNaazhxamk2azhtVE82aEkveGJoV2YvMEZlWmR1ckVsV1FZODFN?=
 =?utf-8?B?YWZNN29XMGxPclkvak54VXZ4ZzdhWHEwYmN4Z1FPMWNtV1lubmszRWZOdE96?=
 =?utf-8?B?bmIxR1Fzd3lJT2Q0QTgvTVE3YldwWlI1YTNNL1A0SVZwZWovWEl3WGVvdjRm?=
 =?utf-8?B?T1JDY2pVd29hK0J2Mk9IcU5mM3BVQmd5T0JoWnQ2ZURhNzhveDlnV1ZabXVB?=
 =?utf-8?B?Qk04OXpoVnd1VkZWL3lBdVEwTVBEdHhSL0tVMXIvUThXYXQ5TW1iUC8zUk5D?=
 =?utf-8?B?KzhLZWFqMmxFVmpKZmRSY2s5Q252Y0lncHNsUEl2K1NCTk5LN0RvQXVzVXds?=
 =?utf-8?B?dUgzSXdIalV2elVxQ3B2WEFYcElVNXZvb0h4Zm45K2luRjNIT28ybyt3SFhw?=
 =?utf-8?B?Y2NTVFhvV1lxcm5qbFJoOGsyK1g1aENveVNoR28rYnVmbTRTdDlDMjgvK3JI?=
 =?utf-8?B?QXAraFAwclJFc2J5RnFmUHJBV0pDSkxvYnVaRFhadXhVRTE4NHZVclIvZHAv?=
 =?utf-8?B?a3YzcE82WTMybk4wdmFFcEMxSklaUWViOUZXeUwrZ3pFUVFudnBUT1Z4cHlt?=
 =?utf-8?B?UmV1Y2NqNXBzUGlzcTlWY2I2NTlrUVhRdHJ6blBCQS9waElwQlhKWUtFdzFS?=
 =?utf-8?B?dEEwbWZHWnV4eG5lZitmQVUwbWgzR2V3MStGZkptcCs5Y2tkK2IyMGk5YTdZ?=
 =?utf-8?B?MVhvTTc5a054aC91Vld0Mm1UaHE5M3BuODE2VGJPMWhkd1Z6Z2ZSVk9sMG02?=
 =?utf-8?B?ejJ0bmdkVjRCSkxPYXBHOVRZWFdLTkRvNit0UXFlYnVwUmo2a255US8rbkVH?=
 =?utf-8?B?L3M4QTJPQnJFUzFmdEFVRkhIeDVBZ0J1V28rbndCVktScDEzOHE2dGRtTFdS?=
 =?utf-8?B?NlhvVStqYndJMmU0VnkrdEVkb20rUlRDTlhQZzVET3FZRUNZV3dmNlZEUnJ1?=
 =?utf-8?B?VWd5V1dlUXJnTi9OZGN4L3hyYUQ1cjdRam1GMDZRYnZVU1U5ZEpPRUM4YWcv?=
 =?utf-8?B?bmF2WHRIaFNOdmVlZzZHbkZySUQzN1VscDNRSkEzTCt0b3E5RTFna2tqZFFM?=
 =?utf-8?B?TjBTSXVsemFTR1o3VWVzUHdBb01vQjdoQjF0UndjWHkxRW95Zzk4bVlrb0gr?=
 =?utf-8?B?M05kcy9xYzVzaTVCVE41bXhESGpFMS9YWXMvUE8yUGpBM0lZY2g0bWlhbm5t?=
 =?utf-8?B?cEJOR3dFZTRUNGluQWdtZnVwV2RlUWdpMnNwanJoRWRGRjdVRkVDejF1bHBR?=
 =?utf-8?B?VzhKSHFuY2JhQ211eEkrb3I2cFlZYlptMkVlMW8wM1VDUWxuazVsUWlVcWQr?=
 =?utf-8?B?Ky9jdFFJN05XMTZlaDNxb0JTeCtueW91bmhOclkvOEhndXBxcmRZbUoveU1M?=
 =?utf-8?B?cGpNSmU0RkxyUzdkMVRpWVlZd1pJUXI2WWVGZkxDeXpLY0syclE3NjdVT01M?=
 =?utf-8?B?NGVvU1poZlVESTg2bTMwdklsUDJWZTFDMGd2Tmc3MUdkakpvTFNzdVEzTTA2?=
 =?utf-8?B?TDBKb0x5THlrUG10UW9JdG05MEl2ZW9BL0tRdWRncDF5UW12QVpTSVAzOEZj?=
 =?utf-8?B?OENQY1VmM0tpN21POFNWUkxXMGNsTEV4ajVIMlFlR2lPZHkzS3VOeVRXQk5K?=
 =?utf-8?B?MXhrTFRGOTYzYTFqU2QwZG14TmI5Y2dBNFVvbmR3ajdXbytPOEtxSzZETWls?=
 =?utf-8?B?N3FKZGVSdHV3ZzZ6cVFtcUtCT2NpZndWQWJFYXVORVQrU0FocXZSOTdoVGw4?=
 =?utf-8?B?VXl6bW8wdzNMWmhXcGR3UmNCZnF5MjMwOWxPc2tDWWVra0YyOThzRTRhTVli?=
 =?utf-8?B?TURwZW0zeUowZkhjR2tEYmFMS0pyRDA3UGN1cVhta29OUTdZT0JTQjhhNnhM?=
 =?utf-8?B?RnM2UmFPWE5xa3pHaGdiS1ZXcmt2SExGMzA3VTVuTEFUYXhnZ0RPSk5pUFRP?=
 =?utf-8?B?YmxKSXgxdEl3aUlOa1BkSU5vVnordGZxaC9hNklYU3VNTnpVME9xOFBCaWxo?=
 =?utf-8?B?U3E5eVNPUTRyR3RDNWFJWDRtTVFLYnlubEh1YTV4c0REcEU1R21QcEZwNllG?=
 =?utf-8?B?QUtMaTFqUU8vVzlyTTNhT3NObWxvU3ozK051dnJtbXlMMG9wTWxzTWRzRVVr?=
 =?utf-8?Q?BTy9mjmhbyVRHteceekrftpo5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5131fc34-cd6a-402a-b655-08dd82056dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 01:23:18.4648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHADTcxGLBelDSFkvEPLMf+k6M8uBYlOTScoj5GpqZUiwlEit82J1mxFD+g67WGD2ZvOnN44umkVmbNC5RBg1QkTkOzl9fC1DO2ERa62310=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5392
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

SGkgUGhpbGlwLCBDZWRyaWMsIA0KDQo+IA0KPiBPbiA0LzIyLzI1IDExOjE1LCBKYW1pbiBMaW4g
d3JvdGU6DQo+ID4gVXBkYXRlZCB0ZXN0IHRvIHRhcmdldCBTREsgdmVyc2lvbiB2MDMuMDAuDQo+
ID4gUmVtb3ZlZCByZWR1bmRhbnQgdGVzdCBjYXNlIHRvIHNpbXBsaWZ5IHZhbGlkYXRpb24uDQo+
ID4gQ2xlYW5lZCB1cCB1bnN1cHBvcnRlZCBzaGVsbCBjb21tYW5kcy4NCj4gDQo+IFdlcmUgc29t
ZSBjb21tYW5kcyByZW1vdmVkIGZyb20gU0RLIHYwMy4wMCA/IFRlc3RpbmcgZGlmZmVyZW50IHpl
cGh5cg0KDQpUaGFua3MgZm9yIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NClllcywgc29tZSBjb21t
YW5kcyBoYXZlIGJlZW4gcmVtb3ZlZCBpbiB0aGUgcHJlLWJ1aWx0IGltYWdlIG9mIFNESyB2MDMu
MDAuDQpUaGUgY2hhbmdlcyBpbiB2MSByZWR1Y2UgdGhlIG92ZXJhbGwgdGVzdCBjb3ZlcmFnZS4N
Ckkgd2lsbCBzZW5kIGEgdjIgcGF0Y2ggdG8gcmV0YWluIHRoZSB0ZXN0X2FzdDEwMzBfemVwaHly
b3NfMV8wNyB0ZXN0IGNhc2UgYW5kIA0KdXBkYXRlIHRlc3RfYXN0MTAzMF96ZXBoeXJvc18xXzA0
IHRvIHVzZSBTREsgdjAzLjAwLg0KDQpUaGFua3MtSmFtaW4NCg0KPiB2ZXJzaW9ucyBtaWdodCBi
ZSBpbnRlcmVzdGluZyBpbiB0aGF0IGNhc2UsIGxpa2UgaXQgd291bGQgYmUgZm9yIExpbnV4IHRv
by4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+IA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gICB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYXJtX2FzcGVlZF9hc3QxMDMwLnB5IHwgNDAg
KysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAzMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlv
bmFsL3Rlc3RfYXJtX2FzcGVlZF9hc3QxMDMwLnB5DQo+ID4gYi90ZXN0cy9mdW5jdGlvbmFsL3Rl
c3RfYXJtX2FzcGVlZF9hc3QxMDMwLnB5DQo+ID4gaW5kZXggZDQ1ZDlmN2MxYy4uZGFmYTFkMjRj
YiAxMDA3NTUNCj4gPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYXJtX2FzcGVlZF9hc3Qx
MDMwLnB5DQo+ID4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FybV9hc3BlZWRfYXN0MTAz
MC5weQ0KPiA+IEBAIC0xMiwzNiArMTIsMTcgQEANCj4gPg0KPiA+ICAgY2xhc3MgQVNUMTAzME1h
Y2hpbmUoTGludXhLZXJuZWxUZXN0KToNCj4gPg0KPiA+IC0gICAgQVNTRVRfWkVQSFlSXzFfMDQg
PSBBc3NldCgNCj4gPiArICAgIEFTU0VUX1pFUEhZUl8zXzAwID0gQXNzZXQoDQo+ID4gICAgICAg
ICAgICgnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DJw0KPiA+IC0gICAgICAgICAn
L3plcGh5ci9yZWxlYXNlcy9kb3dubG9hZC92MDAuMDEuMDQvYXN0MTAzMC1ldmItZGVtby56aXAn
KSwNCj4gPiAtDQo+ICc0YWM2MjEwYWRjYmM2MTI5NDkyNzkxODcwN2M2NzYyNDgzZmQ4NDRkZGU1
ZTA3ZjNiYTgzNGFkMWY5MTQzNGQzJykNCj4gPiArICAgICAgICAgJy96ZXBoeXIvcmVsZWFzZXMv
ZG93bmxvYWQvdjAwLjAzLjAwL2FzdDEwMzAtZXZiLWRlbW8uemlwJyksDQo+ID4gKw0KPiA+ICsN
Cj4gJzM3ZmUzZWNkNGExYjlkNjIwOTcxYTE1Yjk2NDkyYTgxMDkzNDM1Mzk2ZWVhYzY5YjZmM2Uz
ODQyNjJmZjU1NWYnKQ0KPiA+DQo+ID4gLSAgICBkZWYgdGVzdF9hc3QxMDMwX3plcGh5cm9zXzFf
MDQoc2VsZik6DQo+ID4gLSAgICAgICAgc2VsZi5zZXRfbWFjaGluZSgnYXN0MTAzMC1ldmInKQ0K
PiA+IC0NCj4gPiAtICAgICAgICBrZXJuZWxfbmFtZSA9ICJhc3QxMDMwLWV2Yi1kZW1vL3plcGh5
ci5lbGYiDQo+ID4gLSAgICAgICAga2VybmVsX2ZpbGUgPSBzZWxmLmFyY2hpdmVfZXh0cmFjdCgN
Cj4gPiAtICAgICAgICAgICAgc2VsZi5BU1NFVF9aRVBIWVJfMV8wNCwgbWVtYmVyPWtlcm5lbF9u
YW1lKQ0KPiA+IC0NCj4gPiAtICAgICAgICBzZWxmLnZtLnNldF9jb25zb2xlKCkNCj4gPiAtICAg
ICAgICBzZWxmLnZtLmFkZF9hcmdzKCcta2VybmVsJywga2VybmVsX2ZpbGUsICctbm9ncmFwaGlj
JykNCj4gPiAtICAgICAgICBzZWxmLnZtLmxhdW5jaCgpDQo+ID4gLSAgICAgICAgc2VsZi53YWl0
X2Zvcl9jb25zb2xlX3BhdHRlcm4oIkJvb3RpbmcgWmVwaHlyIE9TIikNCj4gPiAtICAgICAgICBl
eGVjX2NvbW1hbmRfYW5kX3dhaXRfZm9yX3BhdHRlcm4oc2VsZiwgImhlbHAiLA0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQXZhaWxhYmxlIGNvbW1hbmRz
IikNCj4gPiAtDQo+ID4gLSAgICBBU1NFVF9aRVBIWVJfMV8wNyA9IEFzc2V0KA0KPiA+IC0gICAg
ICAgICgnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DJw0KPiA+IC0gICAgICAgICAn
L3plcGh5ci9yZWxlYXNlcy9kb3dubG9hZC92MDAuMDEuMDcvYXN0MTAzMC1ldmItZGVtby56aXAn
KSwNCj4gPiAtDQo+ICdhZDUyZTI3OTU5NzQ2OTg4YWZhZWQ4NDI5YmY0ZTEyYWI5ODhjMDVjNGQw
N2M5ZDkwZTEzZWM2ZjdiZTQ1NzRjJykNCj4gPiAtDQo+ID4gLSAgICBkZWYgdGVzdF9hc3QxMDMw
X3plcGh5cm9zXzFfMDcoc2VsZik6DQo+ID4gKyAgICBkZWYgdGVzdF9hc3QxMDMwX3plcGh5cm9z
XzNfMDAoc2VsZik6DQo+ID4gICAgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ2FzdDEwMzAtZXZi
JykNCj4gPg0KPiA+ICAgICAgICAgICBrZXJuZWxfbmFtZSA9ICJhc3QxMDMwLWV2Yi1kZW1vL3pl
cGh5ci5iaW4iDQo+ID4gICAgICAgICAgIGtlcm5lbF9maWxlID0gc2VsZi5hcmNoaXZlX2V4dHJh
Y3QoDQo+ID4gLSAgICAgICAgICAgIHNlbGYuQVNTRVRfWkVQSFlSXzFfMDcsIG1lbWJlcj1rZXJu
ZWxfbmFtZSkNCj4gPiArICAgICAgICAgICAgc2VsZi5BU1NFVF9aRVBIWVJfM18wMCwgbWVtYmVy
PWtlcm5lbF9uYW1lKQ0KPiA+DQo+ID4gICAgICAgICAgIHNlbGYudm0uc2V0X2NvbnNvbGUoKQ0K
PiA+ICAgICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCcta2VybmVsJywga2VybmVsX2ZpbGUsICct
bm9ncmFwaGljJykgQEANCj4gPiAtNDksMTcgKzMwLDEwIEBAIGRlZiB0ZXN0X2FzdDEwMzBfemVw
aHlyb3NfMV8wNyhzZWxmKToNCj4gPiAgICAgICAgICAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3Bh
dHRlcm4oIkJvb3RpbmcgWmVwaHlyIE9TIikNCj4gPiAgICAgICAgICAgZm9yIHNoZWxsX2NtZCBp
biBbDQo+ID4gICAgICAgICAgICAgICAgICAgJ2tlcm5lbCBzdGFja3MnLA0KPiA+IC0gICAgICAg
ICAgICAgICAgJ290cCBpbmZvIGNvbmYnLA0KPiA+IC0gICAgICAgICAgICAgICAgJ290cCBpbmZv
IHNjdScsDQo+ID4gICAgICAgICAgICAgICAgICAgJ2h3aW5mbyBkZXZpZCcsDQo+ID4gICAgICAg
ICAgICAgICAgICAgJ2NyeXB0byBhZXMyNTZfY2JjX3ZhdWx0JywNCj4gPiAtICAgICAgICAgICAg
ICAgICdyYW5kb20gZ2V0JywNCj4gPiAtICAgICAgICAgICAgICAgICdqdGFnIEpUQUcxIHN3X3hm
ZXIgaGlnaCBUTVMnLA0KPiA+IC0gICAgICAgICAgICAgICAgJ2FkYyBBREMwIHJlc29sdXRpb24g
MTInLA0KPiA+IC0gICAgICAgICAgICAgICAgJ2FkYyBBREMwIHJlYWQgNDInLA0KPiA+IC0gICAg
ICAgICAgICAgICAgJ2FkYyBBREMxIHJlYWQgNjknLA0KPiA+IC0gICAgICAgICAgICAgICAgJ2ky
YyBzY2FuIEkyQ18wJywNCj4gPiAtICAgICAgICAgICAgICAgICdpM2MgYXR0YWNoIEkzQ18wJywN
Cj4gPiArICAgICAgICAgICAgICAgICdqdGFnIGp0YWdAN2U2ZTQxMDAgc3dfeGZlciBoaWdoIFRN
UycsDQo+ID4gKyAgICAgICAgICAgICAgICAnaWljIHNjYW4gaTJjQDdlN2IwMDgwJywNCj4gPiAg
ICAgICAgICAgICAgICAgICAnaGFzaCB0ZXN0JywNCj4gPiAgICAgICAgICAgICAgICAgICAna2Vy
bmVsIHVwdGltZScsDQo+ID4gICAgICAgICAgICAgICAgICAgJ2tlcm5lbCByZWJvb3Qgd2FybScs
DQoNCg==

