Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B917C282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 02:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpHlV-00013O-4Q; Mon, 03 Mar 2025 21:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpHlS-00012Q-CF; Mon, 03 Mar 2025 21:12:10 -0500
Received: from mail-tyzapc01on20707.outbound.protection.outlook.com
 ([2a01:111:f403:2011::707]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpHlQ-0002Gq-0p; Mon, 03 Mar 2025 21:12:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkAw+krBvYpeRgOVl8Q+eN7MlNfFXJQeJPWi5FNu3pV3kT02WZxFaEuYLYlUzD4jdr/DiwOqlmljp16ojbMAFhKoI8Cb26WIcZczWjy2ai8veizxo9T9PuwXTwBZQFcYNMvzHXfv0TWbmSwtaNpYGz24WTyGeHfhHVfsVhZOwVbF7sC6/iB2zd+c5rGJGdrE1mCdygDOgcfcME7xsdk+CcsPKfFW/EEvQN/aTlRip28TXMTvMMsOpp7DmZEHWJc44DHUc6BK6tdMQwq2108UILZU+l6kET9sLnnci21ayyxDmrgNJWg1bhMhvRtWP/Xn0183bnU9sd8XoS/aa/ohsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDwUJYyS8U8yTln4IP25Pj4d0L8AKTxDwsNJDCsaIUc=;
 b=fuGgfk9fDrH8CgBEUQf8Jb6Z0BaHHcv/FpZkDNmbZmyzgbUiYXZZLZLdAuwv6rltB5e6oBg1umTqbiswMiywn80bLptXPRk0MQ2HkfiqGgs78L3z4FhzA7H1zBUfxbk+tAPXuAnLfvlbMY+nyvpMO8wS0OzA0vFguM0PbW7E7gs45h6EHUIyIs323d3XzuSKMr0GB7oxQVLGKDs0ODCrE0m6b60tWcEZieShlhwN4P1HVvWGlAbZ7b4CXVUuT73SyEv2Ng4bxsu8YgUOy2yxWLZXlxb7oHkq3g7/mCA0ctSkylT0Ydcby43XZKO01HHEzJrIl6rVRzbCPalvfFH/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDwUJYyS8U8yTln4IP25Pj4d0L8AKTxDwsNJDCsaIUc=;
 b=GZ+ycoSQF8bspN3cpNN18IOLDEmOlsB9uET1DwAHL9gZ8vRq63X+nRk8QS9kaNyHxqmh1JuohapJlryn+dUoN+LsaMiOoJG1766/7XJu+gYVTlSUZVbkoWpMZc4Bi2vfQHJnjxQaL5yMgAMdMdeirUU0m/SHvLMigVkZt9iSokL9xCh8/4UvwC9xTfkk11MrOWAWPMr5Eys5hleREblY1jsET2ciwLKfoaaRyPTEQMW8rb2yuG/2Mea6USSutpsQ7/QUKIOvZc6TjRJBvOOtI0+JCpK4ERhhTieGR4sIOhyxKH7eJMOeRnfQLTRuHkBW2IqoOwiKRGLUtkETqAysSA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5341.apcprd06.prod.outlook.com (2603:1096:101:7d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 02:11:50 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:11:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 2/6] hw/misc/aspeed_scu: Fix the revision ID cannot be
 set in the SOC layer for AST2700
Thread-Topic: [PATCH v4 2/6] hw/misc/aspeed_scu: Fix the revision ID cannot be
 set in the SOC layer for AST2700
Thread-Index: AQHbjA7lSVRrbo8uA0apOgrAPON8UrNhZ1uAgADR6GA=
Date: Tue, 4 Mar 2025 02:11:50 +0000
Message-ID: <SI2PR06MB50415725A1F2CE3346FB0425FCC82@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250303073547.1145080-1-jamin_lin@aspeedtech.com>
 <20250303073547.1145080-3-jamin_lin@aspeedtech.com>
 <e5d26865-2ee7-40a5-b79b-c63067d894ee@kaod.org>
In-Reply-To: <e5d26865-2ee7-40a5-b79b-c63067d894ee@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5341:EE_
x-ms-office365-filtering-correlation-id: 75e88441-26bc-4dd2-3beb-08dd5ac1ec96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVNnOWRTaldZUVp4UVhQUFpNVzJEQjh6THZwQjR4d0dFWG04KzlTZXVJYWw2?=
 =?utf-8?B?bmk0RTF0TkF1RjVRcWgyVi81ME50UkFHZExSTk56SVhTa3U2Z0V3YjdxdHp2?=
 =?utf-8?B?aE9mTkJqNnZ2QXR6M0g3N0lzWmJLVE1DZklnUW1UVEV2cWQ4NGlyaVhFak1h?=
 =?utf-8?B?cFZmbVYxTU91UFlKTXlTdTNsT0FMZmlRMW5WOTRKME1KUUtCallFOWpraFl5?=
 =?utf-8?B?L1kzbnBUendOWW93eWVNUE5ySWM4ZDRENytQOFg2aTNHMmE3NXFJNzFPMUhT?=
 =?utf-8?B?aHoxWHFyVk1YZ0RscEFhc2grTlBHUm9wTWdISDFaM05XTG5sSjRqK3VybldU?=
 =?utf-8?B?ZEc3alZwaTBaK3p6L1dKVStoeWU1OXF3NHk3a3JlSzdPTHdMUUJtM3k5NDhZ?=
 =?utf-8?B?eHNpTW9SSHA5V3lYSTM2M3N3aHlDRmNGc3BMcDJlNnZScTVTWUxWYXpDRGJW?=
 =?utf-8?B?OVRVV2VFRFpCSHp2MVIxRnJTMnNGNlk5akNSYkkzaVdlQkFLZUI3ZlRQRG9K?=
 =?utf-8?B?UTRwQ29hWnBFcUxxVGdhdVZEemtuZnpnc21mY2wzUEtsVEl0Q3dkWDFaQzdG?=
 =?utf-8?B?VVF0elpjeTNZdlU4R00wbVhSWmlqQ1h6R3RlSm9GZ0ZJNHJYcDdzMUNmKzRX?=
 =?utf-8?B?RzBHRjJTVWl5K3BxQ2FTM0xpd0RUSlR0dDQyZERVbks2NVNWVk9kUTJQZndl?=
 =?utf-8?B?K2dWcEkyZ25zcWYrVndsVm5zVjkwNTRrdHRnaWNVZmZGZUdKd1NUWURYa2gr?=
 =?utf-8?B?ZERnUHpHcDdVVDQ2d2h5ajNWZmttSzAwTzMyeHhGTUFkWU1ka25UNFFxYjFC?=
 =?utf-8?B?VXJtVHJNN21rN3JweEF5TFZZYlBwOW5FRHhoaERQTnRaazBaOWVOZ2hPbDgy?=
 =?utf-8?B?UUhTTWszVW1zanBOV3ZDN0VybjNQSkxpcnlaM2tLZ0V2ZDJMbGx4OWVTZ01m?=
 =?utf-8?B?VFJLMytFb2pUTStSWmlpd0VlUjM0cHJrQTJkeGN5YzYwQ1IyZjU2eU9QdEtR?=
 =?utf-8?B?RG45dmNxY1Q3YlV3WE9yTXREOGpjV2U5QmNsbkQxRzRKbnBxUkNNNmhNUDBP?=
 =?utf-8?B?T25sSFluMWJBd1NKVElHMlJzTmFrL25UNUJNZEIwRjJzZzVhV3hha3hNMjB3?=
 =?utf-8?B?NzdnME9QT3JTakY2R200alc2U3dtY1phL1hadzZueTloL0RVdjBGQzVlVnZq?=
 =?utf-8?B?MzJVUXE4N3RFNmFQNUd0RTVWeU9jYVpzc1EwY0p1Wm9RZG9MdFlOZjBqTngy?=
 =?utf-8?B?SUE3dFErQ1lGTUsyV25Wcm5qRitqaG9RcFpHVVFrc3pRQ0lxTmIvSmRXMTNU?=
 =?utf-8?B?ZU52YlVBSVRqMHRXYU1GRVJhVnQrOFViVHU5Rkl6dXBSSkNrLzRXM2lXZ3ZK?=
 =?utf-8?B?STBXbEVnNk1jTFFQNExPREQvRGVKcnpWd3lxSEI0anMxc0ovbVRtSW9kYVNS?=
 =?utf-8?B?ZjBLNVEvRmtlTnkzUm9zRkxOMzJuN09qTy8wd0ptSUJPOFBhdjlTcnVCRkVN?=
 =?utf-8?B?VHdNbmpPTHhjbFpYRmp3a2JWS2hRS1lxcFVWaTkzMlRWTEpBZDRqUTBZTVVQ?=
 =?utf-8?B?NGdRTlF0R0pVY2xtWE1oSnRqYm53WXVyZmdpTEdwNGc4K2prSWlZc0FLYXFm?=
 =?utf-8?B?V3JYSkRVY0RlaGZtTGdRZUFvMTg3NGhCNmFkRVd0RHNQSDBDeDQ5Smowb2t0?=
 =?utf-8?B?ZVB2ZWlVMlJxRnphTWVzWGo2bFhkeU4raWdwbE13ZmFEaG9lalVvS0IvaUxM?=
 =?utf-8?B?eXpFRWhpVzZmbWpsNXFiZ3RvcVRsQVJuaHlpK051cUVmem1MWkJjMGRCSFBL?=
 =?utf-8?B?S1hjcmNSY0t2VUhUWVA2bDhJaU1qZ0dQQlRuL2ZmQldTc0tEdmlFTjdKQ1NF?=
 =?utf-8?B?UktZa0didXNheGh2clp5b2U3bmx6UlhVZUZnWjlVaXdGSjJhWk44ekZiOUZX?=
 =?utf-8?Q?DLDIpZS2+Q1kC0mlMz+V7wVMthpx/nLr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ni90Ykx1Ly9PNThxQVA5NU10MDZmZGoyY28yZ0NoSGlmdGd4UW5sM0F1RUxq?=
 =?utf-8?B?OGRDUUNXU1Jjb092VytZelZTYUVyT2NodnBza2hmQkJzbkpiaktkNjNJYnFi?=
 =?utf-8?B?K3R3QStXMjV4d1R5RDVhZUFpaTZ2ZGVHZnlFemM1M3hiRjR1d1dsMEV5SVEx?=
 =?utf-8?B?MnJSTllFWjRoNlBWa2VjSlJwZTN3RUY3ZWxFTE1CK01NNTI4NXRCd2ltejI1?=
 =?utf-8?B?NGpxekNIYWxYR29zeXlmMTNtYUJhbnNpQ1BmYXFYdlZnQXJldXZqTkdqWkd3?=
 =?utf-8?B?eUF0OVBYeXk2RjNpeGt6TUtBdnNQbm9zQnh0Q3dQVUc4d3Rwa000QzlaL3Ju?=
 =?utf-8?B?QXBKc2FobENHclp0WCtCWUxmTUJNV2ZFR3hQVkVsay9RaWpqNEJTL1NuNUZ2?=
 =?utf-8?B?SG9YaGovcEgyNUlWcVhoek9QLzEyVU5RNHBOdXJqUENud0dYMGhWTzRLWVpw?=
 =?utf-8?B?NFBZSDdpd0U3VEY4T0g4UXVZdE5IVjBHZHEveXJhcSt1dGk1MUFtMXVEVjJh?=
 =?utf-8?B?VzlsT0U1TXRhRERmOWNYV2dCdFJXQnU2L0VJL2FkUHZRd2hheTJLY1pjbndk?=
 =?utf-8?B?bTBaVTAvSEx5YnRHT20wZ1pqcWtUQ2FHZU93eVBsOU1nTng3VUQ2dmFNbGdF?=
 =?utf-8?B?TGw0YnF1OWRzenlHK2NwSjdDOWpSUnVIeWRLQ3pKZVg4ZUc4MFExdHJLRHFu?=
 =?utf-8?B?UXZIWDRiclhVOVdaMWdndTlMVk9KRWtTMXFKdmhSK0ZCOC9YTnZ6RS80dlpL?=
 =?utf-8?B?aThYcWFTOEV3S3c2S0w3V1dhbVIvK1VzNmRnMEJoaXZleGxRbzJ4b2lsMlpr?=
 =?utf-8?B?NXJlbzNUVWJaTEI3SHBldllQVXc2NXlqYWJHOFE1WHRwWlU2T2MrSE1UaGU4?=
 =?utf-8?B?ekJKbndLWEl5dWJxanFSYzI4WWFFM2V5NlZYR1FYNSt2T29SaC9hR2toUXd5?=
 =?utf-8?B?WjhwUlAvZkJSdkY0S3l4YkZKOUt0NHNDQUFReFpBbUM1NUM1d1dPaFhPVlRL?=
 =?utf-8?B?QVhxNUhsV25MZ25uaU4weEZkWEVvMmpmRnU2MEhVNnpycjk5bSsyVGdRQko1?=
 =?utf-8?B?WG51cVd0OFlqL2FGbmVFQU1jZk9aQU5PKysxWWVuMTVFTlFETXc3NEx3bmZX?=
 =?utf-8?B?cHhGLzdidWo0N3ZYczN4TFIyb2RxSkFNaE4vMkFRNDE0RFgzdGZheFFTZ3hZ?=
 =?utf-8?B?NVZ6eHMvc05GTDBNNkdrTjBiZ1pVS1VMUWVpOGFGSmRHZTdpcGluVDZNMUlq?=
 =?utf-8?B?UVE3S0swMHNLY1ZlaU1mWVdkMGVNUnAxdzBQVVg3WEtndk5vR1FVZzU5c29Y?=
 =?utf-8?B?V0xJSmUxZXU3TWxSMGw1NkNoMmRUaEtPaVUzWjUxT0VFck1Fa1ZRV1ZxUHAz?=
 =?utf-8?B?cG02RFNXb0Y4N1ZwQTMrYnErNUF2TVFqV1FOQXRjQ1dXKzFQWGtXdUMzeVkr?=
 =?utf-8?B?bkV4aHRnMHR0SkJTRWd2WG0xY2NvekkzZEV0dG9TUzY1dHdlWWtiN29LYWNy?=
 =?utf-8?B?V3orWFdkbi9FMk1FUUJaWTcvTUpXOUV4clA2K1dpTDF4TFBrV2UzUTBYZnVt?=
 =?utf-8?B?N2ZkNHRqUEEyaFBsNHJqbFlWRmNDNW1TMzc4Z2pQdGtJUEFjeFhuQnlSOGI3?=
 =?utf-8?B?VXpwRGIvMVNDcnBCcXkxZHJlT21NTDBxSU5CZ1MzSUdtbHF2Ri90bnlQekhB?=
 =?utf-8?B?a2JsS2Z1Smd0Y1hLLzk3cFpWMmJQU3I1YmNjTHJwRlpKUXFFeVVDaDB2dzdq?=
 =?utf-8?B?Y3pMcnZDSmtCck8ybnkwZ3VWZDRMMktFK0Raa2xXdlJtSVhHUEEvWFVSMi9Q?=
 =?utf-8?B?SFFyTk83MVc5NTBERDhXRkNzTEd3TTBqR0J0a25UOFBNaDRkZWg1SGxySkxz?=
 =?utf-8?B?aHk3NDNrcUtwbnkrV1RDRWdWN3hDZlpQODJDTm1jYVlFY0t6dG5hMlpRa25T?=
 =?utf-8?B?TGdFVmJaVUhLN3RuTU9BN050L05TQjBnb01NUWN5Y0lWTUdhdnJPaDNwS3la?=
 =?utf-8?B?YnBGOUVMTlJxL2FCVi8xbDhtOTY2UXdhRkJzRy90RjhyNExIdE83cmxCeFp5?=
 =?utf-8?B?dldxejN5NEVhbkM3dFc3SE1mRmVWb1o5WkxzdXV4RjJ0cVR2MVdaUWFoZ3dQ?=
 =?utf-8?Q?gqfIKgXvPS6rJ1E9tCcmo2D3x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e88441-26bc-4dd2-3beb-08dd5ac1ec96
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 02:11:50.0797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qw4SS1syyl0AG+TaVcTyTdKVsbLABrzuy+l3975NqoIEKhVRN0ZE3coI8EtTNhTv/x51NDypItdmvh8eEJ3LXDd+C7Ib8BwDcVrIt1UV72I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5341
Received-SPF: pass client-ip=2a01:111:f403:2011::707;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi82XSBody9taXNjL2FzcGVl
ZF9zY3U6IEZpeCB0aGUgcmV2aXNpb24gSUQgY2Fubm90IGJlDQo+IHNldCBpbiB0aGUgU09DIGxh
eWVyIGZvciBBU1QyNzAwDQo+IA0KPiBPbiAzLzMvMjUgMDg6MzUsIEphbWluIExpbiB3cm90ZToN
Cj4gPiBBY2NvcmRpbmcgdG8gdGhlIGRlc2lnbiBvZiB0aGUgQVNUMjYwMCwgaXQgaGFzIGEgU2ls
aWNvbiBSZXZpc2lvbiBJRA0KPiA+IFJlZ2lzdGVyLCBzcGVjaWZpY2FsbHkgU0NVMDA0IGFuZCBT
Q1UwMTQsIHRvIHNldCB0aGUgUmV2aXNpb24gSUQgZm9yIHRoZQ0KPiBBU1QyNjAwLg0KPiA+IEZv
ciB0aGUgQVNUMjYwMCBBMywgU0NVMDA0IGlzIHNldCB0byAweDA1MDMwMzAzIGFuZCBTQ1UwMTQg
aXMgc2V0IHRvDQo+IDB4MDUwMzAzMDMuDQo+ID4gSW4gdGhlICJhc3BlZWRfYXN0MjYwMF9zY3Vf
cmVzZXQiIGZ1bmN0aW9uLCB0aGUgaGFyZGNvZGVkIHZhbHVlDQo+ID4gIkFTVDI2MDBfQTNfU0lM
SUNPTl9SRVYiIGlzIHNldCBpbiBTQ1UwMDQsIGFuZCAicy0+c2lsaWNvbl9yZXYiIGlzIHNldA0K
PiA+IGluIFNDVTAxNC4gVGhlIHZhbHVlIG9mICJzLT5zaWxpY29uX3JldiIgaXMgc2V0IGJ5IHRo
ZSBTT0MgbGF5ZXIgdmlhDQo+ID4gdGhlICJzaWxpY29uLXJldiIgcHJvcGVydHkuDQo+ID4NCj4g
PiBIb3dldmVyLCB0aGUgZGVzaWduIG9mIHRoZSBBU1QyNzAwIGlzIGRpZmZlcmVudC4gVGhlcmUg
YXJlIHR3byBTQ1UNCj4gY29udHJvbGxlcnM6DQo+ID4gU0NVMCAoQ1BVIERpZSkgYW5kIFNDVTEg
KElPIERpZSkuIEluIHRoZSBBU1QyNzAwLCB0aGUgZmlybXdhcmUgcmVhZHMNCj4gPiB0aGUgU0NV
IFNpbGljb24gUmV2aXNpb24gSUQgcmVnaXN0ZXIgKFNDVTBfMDAwKSBhbmQgdGhlIFNDVUlPIFNp
bGljb24NCj4gPiBSZXZpc2lvbiBJRCByZWdpc3RlciAoU0NVMV8wMDApIGFuZCBjb21iaW5lcyB0
aGVtIGludG8gYSA2NC1iaXQgdmFsdWUuDQo+ID4gVGhlIGNvbWJpbmVkIHZhbHVlIG9mIFNDVTBf
MDAwWzIzOjE2XSBhbmQgU0NVMV8wMDBbMjM6MTZdIHJlcHJlc2VudHMNCj4gPiB0aGUgc2lsaWNv
bg0KPiANCj4gV2h5IGFyZSB5b3UgbWVudGlvbmluZyBiaXRmaWVsZCBbMjM6MTZdIG9mIGJvdGgg
cmVnaXN0ZXJzID8gSSB0aG91Z2h0IHRoZSBzaWxpY29uDQo+IHJldmlzaW9uIElEIHdhcyA2NC1i
aXQgdmFsdWUuDQo+IA0KWWVzLCB0aGUgc2lsaWNvbiByZXZpc2lvbiBJRCB3YXMgNjQtYml0IHZh
bHVlLiBJIHdpbGwgdXBkYXRlIGNvbW1pdCBsb2cgYXMgZm9sbG93aW5nLiBXaGF0IGRvIHlvdSB0
aGluaz8NCg0KSW4gdGhlIEFTVDI3MDAsIHRoZSBmaXJtd2FyZSByZWFkcyB0aGUgU0NVIFNpbGlj
b24gUmV2aXNpb24gSUQgcmVnaXN0ZXINCihTQ1UwXzAwMCkgYW5kIHRoZSBTQ1VJTyBTaWxpY29u
IFJldmlzaW9uIElEIHJlZ2lzdGVyIChTQ1UxXzAwMCksDQpjb21iaW5pbmcgdGhlbSBpbnRvIGEg
c2luZ2xlIDY0LWJpdCB2YWx1ZS4NCg0KVGhlIHVwcGVyIDMyIGJpdHMgcmVwcmVzZW50IHRoZSBT
Q1VJTywgd2hpbGUgdGhlIGxvd2VyIDMyIGJpdHMgY29ycmVzcG9uZCB0byB0aGUNClNDVS4gRm9y
IGV4YW1wbGUsIHRoZSBBU1QyNzAwLUExIHJldmlzaW9uIGlzIHJlcHJlc2VudGVkIGFzIDB4MDYw
MTAxMDMwNjAxMDEwMy4NClNDVUlPXzAwMCBvY2N1cGllcyBiaXRzIFs2MzozMl0gd2l0aCBhIHZh
bHVlIG9mIDB4MDYwMTAxMDMgYW5kIFNDVV8wMDAgb2NjdXBpZXMNCmJpdHMgWzMxOjBdIHdpdGgg
YSB2YWx1ZSBvZiAweDA2MDEwMTAzLg0KDQpUaGFua3MtSmFtaW4NCg0KPiA+IHJldmlzaW9uLiBG
b3IgZXhhbXBsZSwgdGhlIEFTVDI3MDAtQTEgcmV2aXNpb24gaXMNCj4gPiAiMHgwNjAxMDEwMzA2
MDEwMTAzIiwgd2hlcmUNCj4gPiBTQ1UwXzAwMCBzaG91bGQgYmUgMDYwMTAxMDMgYW5kIFNDVTFf
MDAwIHNob3VsZCBiZSAwNjAxMDEwMy4NCj4gPg0KPiA+IFJlZmVyZW5jZToNCj4gPg0KPiBodHRw
czovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvdS1ib290L2Jsb2IvYXNwZWVkLW1hc3Rlci12
MjAyMy4xMC9hDQo+ID4gcmNoL2FybS9tYWNoLWFzcGVlZC9hc3QyNzAwL2NwdS1pbmZvLmMNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KPiA+IC0tLT4gICBody9taXNjL2FzcGVlZF9zY3UuYyB8IDMgKy0tDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvaHcvbWlzYy9hc3BlZWRfc2N1LmMgYi9ody9taXNjL2FzcGVlZF9zY3UuYyBpbmRleA0K
PiA+IDUwZjc0ZmJhYmQuLjU0NWQwMDQ3NDkgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvbWlzYy9hc3Bl
ZWRfc2N1LmMNCj4gPiArKysgYi9ody9taXNjL2FzcGVlZF9zY3UuYw0KPiA+IEBAIC05MTAsNyAr
OTEwLDYgQEAgc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcw0KPiBhc3BlZWRfYXN0MjcwMF9z
Y3Vfb3BzID0gew0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IHVpbnQzMl90IGFz
dDI3MDBfYTBfcmVzZXRzW0FTUEVFRF9BU1QyNzAwX1NDVV9OUl9SRUdTXQ0KPiA9IHsNCj4gPiAt
ICAgIFtBU1QyNzAwX1NJTElDT05fUkVWXSAgICAgICAgICAgPSBBU1QyNzAwX0EwX1NJTElDT05f
UkVWLA0KPiA+ICAgICAgIFtBU1QyNzAwX0hXX1NUUkFQMV0gICAgICAgICAgICAgPSAweDAwMDAw
ODAwLA0KPiA+ICAgICAgIFtBU1QyNzAwX0hXX1NUUkFQMV9DTFJdICAgICAgICAgPSAweEZGRjBG
RkYwLA0KPiA+ICAgICAgIFtBU1QyNzAwX0hXX1NUUkFQMV9MT0NLXSAgICAgICAgPSAweDAwMDAw
RkZGLA0KPiA+IEBAIC05NDAsNiArOTM5LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDI3MDBf
c2N1X3Jlc2V0KERldmljZVN0YXRlDQo+ICpkZXYpDQo+ID4gICAgICAgQXNwZWVkU0NVQ2xhc3Mg
KmFzYyA9IEFTUEVFRF9TQ1VfR0VUX0NMQVNTKGRldik7DQo+ID4NCj4gPiAgICAgICBtZW1jcHko
cy0+cmVncywgYXNjLT5yZXNldHMsIGFzYy0+bnJfcmVncyAqIDQpOw0KPiA+ICsgICAgcy0+cmVn
c1tBU1QyNzAwX1NJTElDT05fUkVWXSA9IHMtPnNpbGljb25fcmV2Ow0KPiA+ICAgfQ0KPiA+DQo+
ID4gICBzdGF0aWMgdm9pZCBhc3BlZWRfMjcwMF9zY3VfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAq
a2xhc3MsIHZvaWQNCj4gPiAqZGF0YSkgQEAgLTEwMzIsNyArMTAzMiw2IEBAIHN0YXRpYyBjb25z
dCBNZW1vcnlSZWdpb25PcHMNCj4gYXNwZWVkX2FzdDI3MDBfc2N1aW9fb3BzID0gew0KPiA+ICAg
fTsNCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IHVpbnQzMl90DQo+IGFzdDI3MDBfYTBfcmVzZXRz
X2lvW0FTUEVFRF9BU1QyNzAwX1NDVV9OUl9SRUdTXSA9IHsNCj4gPiAtICAgIFtBU1QyNzAwX1NJ
TElDT05fUkVWXSAgICAgICAgICAgICAgID0gMHgwNjAwMDAwMywNCj4gPiAgICAgICBbQVNUMjcw
MF9IV19TVFJBUDFdICAgICAgICAgICAgICAgICA9IDB4MDAwMDA1MDQsDQo+ID4gICAgICAgW0FT
VDI3MDBfSFdfU1RSQVAxX0NMUl0gICAgICAgICAgICAgPSAweEZGRjBGRkYwLA0KPiA+ICAgICAg
IFtBU1QyNzAwX0hXX1NUUkFQMV9MT0NLXSAgICAgICAgICAgID0gMHgwMDAwMEZGRiwNCg0K

