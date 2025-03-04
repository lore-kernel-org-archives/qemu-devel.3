Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFECC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 03:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpJ2b-00011h-JB; Mon, 03 Mar 2025 22:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpJ2Y-00011R-9c; Mon, 03 Mar 2025 22:33:54 -0500
Received: from mail-psaapc01on20713.outbound.protection.outlook.com
 ([2a01:111:f403:200e::713]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpJ2U-0005G3-05; Mon, 03 Mar 2025 22:33:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9U1hJGPMm44yMrslX0qID7azkfCcZ+teRSa4Z2EMaQ+YRF1LfQa+LXFpG8AhHO8x+ksAwvPWwnTOsO03EVGdOWhVxVQrulK1FT9i0jdSGrp0xDdlPlYdLs035n+Eht1iwjs3cWIoMyeKUf3UDTNCNZvuro1oqA972zvH45Ni4xCbsfq0ZKqq6LV9+mTe3+534Hr0f63D9T8HVPVME5044xCWpfsA8pDHXBD+bg/hiDh+DGwWp1nHdYbnaLorN3LNntq152mrpvI64F8SyDBPDtRvI+QIC5xw9n3Fq+wUpjTecqNV4tV6Kng10m/7peq2PQl/N9t+Aa2j3x/O3rOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLOLuZiKodSXZZMyvNmthUIdBOOXSGJli+b2y4b7A1Y=;
 b=w3dh+qneTlOfCHL6YGDHTvlnzuqDz9PpCL3GFRjp9k6u23kBAFx/Qqszg+nhnnnqhY6FR7Fl56QsCAUn0dn8Svlw1zITo/TUZBCJvHtAxUYBW7BTwrleXan7DCU9Oi3wxvTpHo/W2jPV6/vKuhhwR6PeG6hAj/JuwaooOqNSQoBTNmQU3k+/tCR8/n1IyMbEyVe802925JwqmIR3iUs5th7TKofuM9RCBeepfcBvnuX0t1CSSXt0EcLrVZ1ttUjzW+i4rar/SFrTU+85bx0IBYzDfVzkgYrdRbup9VVsec2AW8FHri6EnQhTplK090C1b6ZnEGHFwesj9C26vZFLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLOLuZiKodSXZZMyvNmthUIdBOOXSGJli+b2y4b7A1Y=;
 b=LZ3GxEPOTpUZjfv7pQR/dCS0hngq44eYHYsaIaiFzC588UYGMokYaFJB9lSS+kWjD8QrGRa1/t/7jkTKbNsVSBndNKAerCd2gpnE5WWgmQ9Sq0kfGruHITHTSZrs2CTpBWd+s1Q+tCm1OPVjWNT30fbagPeUp5cehByIKISP1TU4C4xI3abUdiwgGeFDuvHPQ8UlqrF1JmVVOgs9IOg/qhttPNlby8EBpg+Gd0ZrYag0W30BpE1yV0n5GYH/IzLJSlPfaJnqi3zsIg8rqAow0ALaX5i7ujkHLxPOHl4iX/L87yRFN8ApGgkgWMrceSAO8FmPb3LBjEb7SiLBqHseNg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5967.apcprd06.prod.outlook.com (2603:1096:101:e7::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 03:33:37 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 03:33:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 20/23] tests/functional/aspeed: Introduce
 start_ast2700_test API and update hwmon path
Thread-Topic: [PATCH v4 20/23] tests/functional/aspeed: Introduce
 start_ast2700_test API and update hwmon path
Thread-Index: AQHbjCJlGRU3j++jDUi3uN+NcsoykrNhn4eAgAC0TmA=
Date: Tue, 4 Mar 2025 03:33:37 +0000
Message-ID: <SI2PR06MB504156FA974664F592E93E4CFCC82@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-21-jamin_lin@aspeedtech.com>
 <20cb2466-4f61-4544-b8b2-c92c51bcc8a9@kaod.org>
In-Reply-To: <20cb2466-4f61-4544-b8b2-c92c51bcc8a9@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5967:EE_
x-ms-office365-filtering-correlation-id: 2412a5d2-fc33-43d3-937f-08dd5acd5967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1pEaUQ0SXB4LzRYaEh0TlpsU1FBazRtazBZUlYyTEdJTnlxL0R4aTdwLzNM?=
 =?utf-8?B?OGZacHZOcEZFZmlxejgwN1RDU3Z4RDBZbVhKeHpPQlMzbEFONzh1QkZDWUcz?=
 =?utf-8?B?Vms1OEt6cW04NzdJM0xaZndUQUIyQWZCSXZuOWpsczlXcEN0R3pPSlpsQjZQ?=
 =?utf-8?B?aVJhREpYZmJ2TkY2cnMvL3M3OGJFTFllckp0TnN3eVRPKzZEbkx2a3ZUNFVm?=
 =?utf-8?B?U0dXOEdwQkgyUFJhL1dxL1VlY0IvbGE4NGNBRkxvYkFvY1pUUlhkNWtFSlFp?=
 =?utf-8?B?YmMxZzNIU1BmdVdLYlY4RHNoR0gwM1VuU3Y3cG1jaFlDMlJSSXJDejl6cWEr?=
 =?utf-8?B?bEl2TytuT2o2THcwWDEzeWNCN3NYdS94ZVJUVXQ3OEpnWklGVGtXZHJsNjJj?=
 =?utf-8?B?cmU0eDNtcEFOSkJzT3QwOWQwRG4wdGttY2J6WDI1N012dkhGQzRpb1ZJUWFN?=
 =?utf-8?B?dTlqN2x5NlorUEhmdXMyTXhGaWxmdE9rSXRZZW5zV050R1YzQmIrNU5HL3ps?=
 =?utf-8?B?dzc2eUpsNmo5WGFpcFA3Nk1KVUtXanZOVGlHRWlzdldBUC9MVWp2OGdoL1Ay?=
 =?utf-8?B?RlAvcHZ5RlVMQnAxZ2J0TTVZUlV5NlYrT2ZjWUlWOEtkOGVhTkYrNTFlbWs0?=
 =?utf-8?B?bDlyUTNEYlZRZFZ0aHB2V05mRXVDRXNpQU1EbXdvWmNVRmtnekZxNzh0dGkz?=
 =?utf-8?B?M3VlaE9iVFJoTGgyRGVTMktxNWk4WGJQQmFPT2lXZHhoWXNZUUZxeXZ2TFJQ?=
 =?utf-8?B?ODhlc1ZrM3hTSStaNlczUXY4U0NuNHNVWmFlcUNLbXRxcVpzb3dJZ2g1VmE3?=
 =?utf-8?B?MVZjWU85U0V6eUUwdUFnMDl4OUpmNkZSVHNoanFiVnZyNGcxWHlCOTdLOURh?=
 =?utf-8?B?M1Frck5PMjZTQm1CaCs1OTNKR1VvRDZOOUtFTjYyK3Y0VGExb2NOTDRlRy9U?=
 =?utf-8?B?RUdYampkbjhET1JWeGNUd3d2aUtJV1B3cjVaRVdINXlqZEVWbXZhZE4zdXhI?=
 =?utf-8?B?QTlyMUFNM0pjRS9wS0k1SVRLTEtxUG12dk1EbWRrWFJvSUpJdjQ4ay9SY2dX?=
 =?utf-8?B?M1JDOFhkWkZQdmowRTRRZjhtSmJ5MnRqeU1oWjIxMVAweDg5eWdpOWM0U1Zh?=
 =?utf-8?B?ZTBMUzBxVlZJMXYxdTJManJJd0QzM01ZWnI2UEpRdjdKSHJtdEN1ZGt5b0F1?=
 =?utf-8?B?K1g2N1ZWcDJhc1pjKzJiVTlhQzhsSzBiK0VlaWY2Y1ZJTDhEeXlTWG1OQTkw?=
 =?utf-8?B?dUpFQmZmeXpxUnRyeDc4dTJrNzdaNEp6Q1Rab3JqaWQ3b2tnTkNwV0FZbmV1?=
 =?utf-8?B?UWpOOU9Ncjh0aWJoQnYvcSttMVJiYXkyZWNBdmRkMU16dnk2ZTJyYnQzZWFk?=
 =?utf-8?B?MGd6SkxtUldUQ1pGWC9uS2xQdkoxdTYydGM2TGdZSUlGNk9MUy9VaW83MU1r?=
 =?utf-8?B?cHFFZUVhcjNUOFc3T3FJSU8rSVRKRWF1c21LUStUZ2tSQnZLeHBPY0o3Witw?=
 =?utf-8?B?Q0FmdllkV2preTFkTzBlMXdLZGFyTmRHSStPYzlaR0FwU2tjMDVPUWFUcjgv?=
 =?utf-8?B?a3JVRlpJNG03MC9qNldEY3pEcVYyd0p6eStwYjY4cmlOOVFSUXV0Y1NxZmpX?=
 =?utf-8?B?R1JyYTZraHhjQXV3aXBHY1dlLzVMbWRLdUdsMkgweEl1VVdLL3o4emNiVUp0?=
 =?utf-8?B?Rzk4NExMTVhMRmVCRVp3WERKdUlQamt4ZFFCK21UdUlDWUxkd292YldqUGdO?=
 =?utf-8?B?bmIzNFc3WWI5Q1dpdGdlcVpLR2p2dlgvV256Uk1LcFFKTEx2M0I1SlA4U0ti?=
 =?utf-8?B?UkZ0dXNaZzhaY09aWmdVdVhHTUQwSUVkcnBaclZVK1JBMHlUTFhSOVM5T2Rq?=
 =?utf-8?B?ZFVZOFZ5NUozL2o2dldEMjVVakxnV2F6bEthbFdKTzFVMldTYUc0ZE1TY3VM?=
 =?utf-8?Q?i+Jss4PMVnLCLN2iaMSDW3RiWRO9xUVS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXlBT0w4UGFUOGFhQXJhZElScTBadEFQVnNJSVNpVzNPREhOSnFodlhzOTcx?=
 =?utf-8?B?L3hvR0ozVXlxTSt4eVpuWTVHN3dHeS8xb1Z6RmpaNE1wb1ptTU5QWStLbVcz?=
 =?utf-8?B?R2diSmJPSjhFZjRLZm1JaDNiQ1JvamtqVUdldWdMNUJOZjhCOHBvMndOSmJO?=
 =?utf-8?B?UmFlNkdibUszMTBpUUNwOE5tRnZMOG1uY3BTMDdlMm5lTEtxTXFtNTZFbEpE?=
 =?utf-8?B?MEFrVE43SmtwODJQSTVSUmhKMUU1NGtXb0k4Y1VqSFVxcTdUNUhhdTZFS1N2?=
 =?utf-8?B?L0lZNnlyWURSNURTdHBFRHRGQWpZd09BbjBKa1c4emlZTkVhVE1YcFg2MU1H?=
 =?utf-8?B?UmpweSs0bjZkbDZFUUJhSGp2V3d6djl5OExRalQveWJtS3pNeUc0K20ycXdC?=
 =?utf-8?B?Yk5mOVhtZ0tBVmlHNUNJekl3UE03M0ZkNy9FVEgrMnlOcHlsd3Z5Ukw3UFNk?=
 =?utf-8?B?c3I4QjJKSktzck1TUXJoOHVGN29veG9WUGlVdDNWdlFYaHFUYmR5dGVmaGhD?=
 =?utf-8?B?MjZtdjRVNGNSbU55eXdwVnR1VFFWWmFUUFBDTHFkT2pxWVNJR0NhRVVOQ0Vq?=
 =?utf-8?B?dUsxUHY0RWhKdFVkMm1ocUs5Nmg0Tno0aEFmR1NCbUZ6Q21DZEswYjFHZUl5?=
 =?utf-8?B?clN1VjlPQ3lKL2h2eXBmZ1NFdVp4ZmhWZWFOb2VDNzFHTzZjcm9mMWtzYVpq?=
 =?utf-8?B?Y0FwVTIxTDV6S2Q0WE5nQ1E3dmw2TlBhTmdSSEZlSXpLUFZhRWxPMmMvekVv?=
 =?utf-8?B?bmxRQnhHblVzV21LQzZWem5OWms1R0tQV2FuZnR5ekp2WVdFN21udFZ3RGJH?=
 =?utf-8?B?ZGRWWEFUZm81b3hXVnUzVUU4VnlldzVjUW5TcGdQRHpRbCtZOHpqRm9rQjNW?=
 =?utf-8?B?YTBnUForTUhIZUw2TzZEUloyeTdveXc4VXQyS0xFZTE5eG80UXFoMy9hU3VU?=
 =?utf-8?B?dUVPdTAzMzFZQVVzQjBIdElFNjFqL0gwQU5PS0dWRmJUL3YxOFpzMys2WjJn?=
 =?utf-8?B?cG9sWGs2VXJCd2d3Zk1kMkxwblVMRDdqTzY5ZEZFbXBHZXo5WTNkcFlDQ2pV?=
 =?utf-8?B?TkRzdWpvME9pNkdQa3RLYzkyMmppNkdac0d6eHo2M1RMak5zRGJLS3AzamxS?=
 =?utf-8?B?Q3Fjdm5NaVZ6R01sQm01eUIwMzU4TDJoNjJqenRMdm9McFF0ZWljc1NsUGVT?=
 =?utf-8?B?cE1ucDU3aW9SVWxsMXRGOGNKY1pmMVF3cnp5MW4rYU4xN1N4dE9nNGZ1UTFa?=
 =?utf-8?B?ZEc4YkV3T005MHoraUNKUmx6bHB1bkJYV01qSzdWc0xVK05lM2t2QXlSUmFT?=
 =?utf-8?B?VUNqMlBhem9oT1Z6UmU0MHZ0TGI5SGdOc3BPUUQ5am9QdjF5TFZmZ1I2M1Fv?=
 =?utf-8?B?c0N6UldySTR0L1BYQUorYXA5eEJxQWZrOXl2dFd1TkhhaFV2S2V1K1c2WDg0?=
 =?utf-8?B?NUd0STlxVEVmRnVFbXZQNUpLMzIweWxCcENkV0FZQUszNFdudlNxQjE4S0tI?=
 =?utf-8?B?azRkc0h6eDQyYXRHMk16bTd0V0FqWU1KMFo5OTJrZ0p1UUlrYi94eWh5aGpE?=
 =?utf-8?B?M25ERkNJVGNYS0RkWFMxRHR5M2hjc3hNZEFsY25sYTJNK0U3T2JKRFVzNE4x?=
 =?utf-8?B?NjBDRFk0N3VLZ200WUg1NnZtN0dHT0sxaDhVbkdHQ0EyM1lZM3IrNmdaa0NX?=
 =?utf-8?B?TWJER0hjTmx5Mlp4VDNPOXpxbGo4ZVlGdWROOEFMK0w2SDJPUTdCZ01Qd3lu?=
 =?utf-8?B?cmVERzdRNzNzQlgxMG44THdCc04wZ1dnRE5TNXpvY09KNFZYeW5jVzF1eFln?=
 =?utf-8?B?YmVLdXlBS1llRVpwd01yZWdOY0FxTzlBWDExRUl6UWJWUEhodllLc3NIT2xR?=
 =?utf-8?B?VWtJU3lkQzFYK2E5NGlJcm4wdmRPb2FOUFQwdmREQmN6RWhabFRJaURSZDV3?=
 =?utf-8?B?eGFKcy9aUm9Zb3IrYVhaMGZCdVF4eFh4UytCTzF3V2o3amVVWkFwclZaMG56?=
 =?utf-8?B?eEFMNFpFc3ZiaXdMbnJ2eE1kazRxMmhVZlhIODB3S0NzVlpKWkxhc04rSkpU?=
 =?utf-8?B?T21Sb0VuM0xyMmwyK3BLTWpWdHR0dysySGZCK3NqempKenQ5NEtmTVZEZDRu?=
 =?utf-8?Q?k0tQpUaTEiihtm0h1gkGuKk2S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2412a5d2-fc33-43d3-937f-08dd5acd5967
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 03:33:37.1206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8mvWhTH6SHU1XH5ZNaYHUWLjB7ZGoIaWFRTg57+i6Or2M97Bc7R8/EVi24QN7FQjYTTtufT9AB1dKpSPr+tlu5OlcTWFA/hxa1rY+r5Vs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5967
Received-SPF: pass client-ip=2a01:111:f403:200e::713;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyMC8yM10gdGVzdHMvZnVuY3Rp
b25hbC9hc3BlZWQ6IEludHJvZHVjZQ0KPiBzdGFydF9hc3QyNzAwX3Rlc3QgQVBJIGFuZCB1cGRh
dGUgaHdtb24gcGF0aA0KPiANCj4gT24gMy8zLzI1IDEwOjU0LCBKYW1pbiBMaW4gd3JvdGU6DQo+
ID4gQWRkZWQgYSBuZXcgbWV0aG9kICJzdGFydF9hc3QyNzAwX3Rlc3QiIHRvIHRoZSAiQVNUMngw
ME1hY2hpbmVTREsiDQo+ID4gY2xhc3MgYW5kIHRoaXMgbWV0aG9kIGNlbnRyYWxpemVzIHRoZSBs
b2dpYyBmb3Igc3RhcnRpbmcgdGhlIEFTVDI3MDANCj4gPiB0ZXN0LCBtYWtpbmcgaXQgcmV1c2Fi
bGUgZm9yIGRpZmZlcmVudCB0ZXN0IGNhc2VzLg0KPiA+DQo+ID4gTW9kaWZpZWQgdGhlIGh3bW9u
IHBhdGggdG8gdXNlIGEgd2lsZGNhcmQgdG8gaGFuZGxlIGRpZmZlcmVudCBTREsgdmVyc2lvbnM6
DQo+ID4gImNhdCAvc3lzL2J1cy9pMmMvZGV2aWNlcy8xLTAwNGQvaHdtb24vaHdtb24qL3RlbXAx
X2lucHV0Ii4NCj4gDQo+IFBsZWFzZSBzcGxpdCBpbiB0d28gcGF0Y2hlcy4NCj4gDQpUaGFua3Mg
Zm9yIHN1Z2dlc3Rpb24gYW5kIHJldmlldy4NCldpbGwgZG8NCkphbWluDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiBDLg0KPiANCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9s
aW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3Rf
YWFyY2g2NF9hc3BlZWQucHkgfCAzMyArKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNwZWVkLnB5DQo+
ID4gYi90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkNCj4gPiBpbmRleCA5
NTk1NDk4YWNlLi4wN2IwYzdjMWZkIDEwMDc1NQ0KPiA+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwv
dGVzdF9hYXJjaDY0X2FzcGVlZC5weQ0KPiA+ICsrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvdGVzdF9h
YXJjaDY0X2FzcGVlZC5weQ0KPiA+IEBAIC0zMSwzMyArMzEsMjkgQEAgZGVmIGRvX3Rlc3RfYWFy
Y2g2NF9hc3BlZWRfc2RrX3N0YXJ0KHNlbGYsIGltYWdlKToNCj4gPg0KPiAnaHR0cHM6Ly9naXRo
dWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjA5LjAzL2Fz
dA0KPiAyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3onLA0KPiA+DQo+ID4NCj4gJzkxMjI1ZjUwZDI1
NWUyOTA1YmE4ZDhlMGM4MGI3MWI5ZDE1N2MzNjA5NzcwYzdhNzQwY2Q3ODYzNzBkODVhNzcnDQo+
ICkNCj4gPg0KPiA+IC0gICAgZGVmIHRlc3RfYWFyY2g2NF9hc3QyNzAwX2V2Yl9zZGtfdjA5XzAz
KHNlbGYpOg0KPiA+IC0gICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ2FzdDI3MDAtZXZiJykNCj4g
PiAtDQo+ID4gLSAgICAgICAgc2VsZi5hcmNoaXZlX2V4dHJhY3Qoc2VsZi5BU1NFVF9TREtfVjkw
M19BU1QyNzAwKQ0KPiA+IC0NCj4gPiArICAgIGRlZiBzdGFydF9hc3QyNzAwX3Rlc3Qoc2VsZiwg
bmFtZSk6DQo+ID4gICAgICAgICAgIG51bV9jcHUgPSA0DQo+ID4gLSAgICAgICAgdWJvb3Rfc2l6
ZSA9IG9zLnBhdGguZ2V0c2l6ZShzZWxmLnNjcmF0Y2hfZmlsZSgnYXN0MjcwMC1kZWZhdWx0JywN
Cj4gPiArICAgICAgICB1Ym9vdF9zaXplID0gb3MucGF0aC5nZXRzaXplKHNlbGYuc2NyYXRjaF9m
aWxlKG5hbWUsDQo+ID4NCj4gJ3UtYm9vdC1ub2R0Yi5iaW4nKSkNCj4gPiAgICAgICAgICAgdWJv
b3RfZHRiX2xvYWRfYWRkciA9IGhleCgweDQwMDAwMDAwMCArIHVib290X3NpemUpDQo+ID4NCj4g
PiAgICAgICAgICAgbG9hZF9pbWFnZXNfbGlzdCA9IFsNCj4gPiAgICAgICAgICAgICAgIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAnYWRkcic6ICcweDQwMDAwMDAwMCcsDQo+ID4gLSAgICAgICAg
ICAgICAgICAnZmlsZSc6IHNlbGYuc2NyYXRjaF9maWxlKCdhc3QyNzAwLWRlZmF1bHQnLA0KPiA+
ICsgICAgICAgICAgICAgICAgJ2ZpbGUnOiBzZWxmLnNjcmF0Y2hfZmlsZShuYW1lLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ3UtYm9vdC1ub2R0Yi5i
aW4nKQ0KPiA+ICAgICAgICAgICAgICAgfSwNCj4gPiAgICAgICAgICAgICAgIHsNCj4gPiAgICAg
ICAgICAgICAgICAgICAnYWRkcic6IHN0cih1Ym9vdF9kdGJfbG9hZF9hZGRyKSwNCj4gPiAtICAg
ICAgICAgICAgICAgICdmaWxlJzogc2VsZi5zY3JhdGNoX2ZpbGUoJ2FzdDI3MDAtZGVmYXVsdCcs
ICd1LWJvb3QuZHRiJykNCj4gPiArICAgICAgICAgICAgICAgICdmaWxlJzogc2VsZi5zY3JhdGNo
X2ZpbGUobmFtZSwgJ3UtYm9vdC5kdGInKQ0KPiA+ICAgICAgICAgICAgICAgfSwNCj4gPiAgICAg
ICAgICAgICAgIHsNCj4gPiAgICAgICAgICAgICAgICAgICAnYWRkcic6ICcweDQzMDAwMDAwMCcs
DQo+ID4gLSAgICAgICAgICAgICAgICAnZmlsZSc6IHNlbGYuc2NyYXRjaF9maWxlKCdhc3QyNzAw
LWRlZmF1bHQnLCAnYmwzMS5iaW4nKQ0KPiA+ICsgICAgICAgICAgICAgICAgJ2ZpbGUnOiBzZWxm
LnNjcmF0Y2hfZmlsZShuYW1lLCAnYmwzMS5iaW4nKQ0KPiA+ICAgICAgICAgICAgICAgfSwNCj4g
PiAgICAgICAgICAgICAgIHsNCj4gPiAgICAgICAgICAgICAgICAgICAnYWRkcic6ICcweDQzMDA4
MDAwMCcsDQo+ID4gLSAgICAgICAgICAgICAgICAnZmlsZSc6IHNlbGYuc2NyYXRjaF9maWxlKCdh
c3QyNzAwLWRlZmF1bHQnLCAnb3B0ZWUnLA0KPiA+ICsgICAgICAgICAgICAgICAgJ2ZpbGUnOiBz
ZWxmLnNjcmF0Y2hfZmlsZShuYW1lLCAnb3B0ZWUnLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJ3RlZS1yYXcuYmluJykNCj4gPiAgICAgICAgICAgICAg
IH0NCj4gPiAgICAgICAgICAgXQ0KPiA+IEBAIC03NiwyMyArNzIsMjggQEAgZGVmIHRlc3RfYWFy
Y2g2NF9hc3QyNzAwX2V2Yl9zZGtfdjA5XzAzKHNlbGYpOg0KPiA+ICAgICAgICAgICBzZWxmLnZt
LmFkZF9hcmdzKCctZGV2aWNlJywNCj4gPg0KPiAndG1wMTA1LGJ1cz1hc3BlZWQuaTJjLmJ1cy4x
LGFkZHJlc3M9MHg0ZCxpZD10bXAtdGVzdCcpDQo+ID4gICAgICAgICAgIHNlbGYuZG9fdGVzdF9h
YXJjaDY0X2FzcGVlZF9zZGtfc3RhcnQoDQo+ID4gLSAgICAgICAgICAgIHNlbGYuc2NyYXRjaF9m
aWxlKCdhc3QyNzAwLWRlZmF1bHQnLCAnaW1hZ2UtYm1jJykpDQo+ID4gKyAgICAgICAgICAgIHNl
bGYuc2NyYXRjaF9maWxlKG5hbWUsICdpbWFnZS1ibWMnKSkNCj4gPg0KPiA+IC0gICAgICAgIHdh
aXRfZm9yX2NvbnNvbGVfcGF0dGVybihzZWxmLCAnYXN0MjcwMC1kZWZhdWx0IGxvZ2luOicpDQo+
ID4gKyAgICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsIGYne25hbWV9IGxvZ2lu
OicpDQo+ID4NCj4gPiAgICAgICAgICAgZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJu
KHNlbGYsICdyb290JywgJ1Bhc3N3b3JkOicpDQo+ID4gLSAgICAgICAgZXhlY19jb21tYW5kX2Fu
ZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsDQo+ID4gLSAgICAgICAgICAgICcwcGVuQm1jJywgJ3Jv
b3RAYXN0MjcwMC1kZWZhdWx0On4jJykNCj4gPiArICAgICAgICBleGVjX2NvbW1hbmRfYW5kX3dh
aXRfZm9yX3BhdHRlcm4oc2VsZiwgJzBwZW5CbWMnLA0KPiA+ICsgZidyb290QHtuYW1lfTp+Iycp
DQo+ID4NCj4gPiAgICAgICAgICAgZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNl
bGYsDQo+ID4gICAgICAgICAgICAgICAnZWNobyBsbTc1IDB4NGQgPg0KPiAvc3lzL2NsYXNzL2ky
Yy1kZXYvaTJjLTEvZGV2aWNlL25ld19kZXZpY2UgJywNCj4gPiAgICAgICAgICAgICAgICdpMmMg
aTJjLTE6IG5ld19kZXZpY2U6IEluc3RhbnRpYXRlZCBkZXZpY2UgbG03NSBhdCAweDRkJyk7DQo+
ID4gICAgICAgICAgIGV4ZWNfY29tbWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybihzZWxmLA0KPiA+
IC0gICAgICAgICAgICAnY2F0IC9zeXMvY2xhc3MvaHdtb24vaHdtb24yMC90ZW1wMV9pbnB1dCcs
ICcwJykNCj4gPiArICAgICAgICAgICAgJ2NhdA0KPiA+ICsgL3N5cy9idXMvaTJjL2RldmljZXMv
MS0wMDRkL2h3bW9uL2h3bW9uKi90ZW1wMV9pbnB1dCcsICcwJykNCj4gPiAgICAgICAgICAgc2Vs
Zi52bS5jbWQoJ3FvbS1zZXQnLCBwYXRoPScvbWFjaGluZS9wZXJpcGhlcmFsL3RtcC10ZXN0JywN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgcHJvcGVydHk9J3RlbXBlcmF0dXJlJywgdmFsdWU9
MTgwMDApDQo+ID4gICAgICAgICAgIGV4ZWNfY29tbWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybihz
ZWxmLA0KPiA+IC0gICAgICAgICAgICAnY2F0IC9zeXMvY2xhc3MvaHdtb24vaHdtb24yMC90ZW1w
MV9pbnB1dCcsICcxODAwMCcpDQo+ID4gKyAgICAgICAgICAgICdjYXQNCj4gPiArIC9zeXMvYnVz
L2kyYy9kZXZpY2VzLzEtMDA0ZC9od21vbi9od21vbiovdGVtcDFfaW5wdXQnLCAnMTgwMDAnKQ0K
PiA+ICsNCj4gPiArICAgIGRlZiB0ZXN0X2FhcmNoNjRfYXN0MjcwMF9ldmJfc2RrX3YwOV8wMyhz
ZWxmKToNCj4gPiArICAgICAgICBzZWxmLnNldF9tYWNoaW5lKCdhc3QyNzAwLWV2YicpDQo+ID4g
Kw0KPiA+ICsgICAgICAgIHNlbGYuYXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfU0RLX1Y5MDNf
QVNUMjcwMCkNCj4gPiArICAgICAgICBzZWxmLnN0YXJ0X2FzdDI3MDBfdGVzdCgnYXN0MjcwMC1k
ZWZhdWx0JykNCj4gPg0KPiA+DQo+ID4gICBpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOg0KDQo=

