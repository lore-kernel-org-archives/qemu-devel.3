Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE7BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 08:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHI2U-0005Eh-Ac; Fri, 07 Nov 2025 03:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vHI2R-0005C6-Uo; Fri, 07 Nov 2025 03:41:44 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vHI2O-0002IP-V9; Fri, 07 Nov 2025 03:41:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1NA6ys9mfy1vYJXmF/pZJibyctewanzaaHHJ52xxGPTvaHaL/Re1Yn5z3mYfXtysF9MKDr7rKwFz1EaiLW5eKSllHOB/mAo3wou0cCPfx8nIu8iZIEs46I4QDpvVZZ1k1i39/Q1D3oHvBan4D1CJUT55UquflJoSXXPRnCa02gnbeLyQF/O3lmH6C3IgTrkq7jmK07BN3WcbFxpQ9v9BybcmN95Cv/NIOJjafmX4GLzwUvo1jtFmFLCKUslkgswikbne064TY18fjVa/rcjeja9Vco0URsb1xkHqVYof2b8gyE19hff+lADIr00zArMxi+4U/5sgibeu/4hEKB7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jmnoIDlk04IQCN0e2qV+5hjCtFw1uVgd8HtQIHwy+c=;
 b=IDTB95qnQx9TZodYmH/2F29Evd+z9Tv1ZJbBCUFWxYd4WvT3ibmjnSeWuHa73p8aD2cP/dQLHVgdAHKUNmHnFlZx6A4VnAr0Pfmr4+afRZ3HO8jChEzscqSrOatAHSyGBKG6+X42v8HYW2mrrjhVgpiCiFrLuaT4kPPJ256FXzDSnHqMBrtQKRGBszQHirmIEd+2RZXpPuJbO3Vrl4kKk+QL4hM5P4+10kX/Rs3Nfr0x8U/b+ksC3ML6NADnIfLihMYfVCbD+Erjm5nD+M4FgroXvjcpb6RjQk1VwCSVn2dfZGJzgX8TD71RE6kNd94HfPmmpPBluWS1gg6e9ur5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jmnoIDlk04IQCN0e2qV+5hjCtFw1uVgd8HtQIHwy+c=;
 b=Cz5e2uMvKCseNC6Dtf6klWdys+wztjvPTjnl96/uKvUdxxaIJ/Lt4Y+Zztr+SuydoqAPQeQPeJ5aYkYBrsUmEhhsUv6I3B6nYPabRQQ3IE0SLBJmRXqsCUX35S6QY7h8WeJUB6yPMnUoa7T7Qr1TqABuqPzbHzzcLdLO6EIdEBavd2FT6sxhRpcTfwrAkt4sZvxE+ARyy3i1obwzAwAyQIO1TaCYc1pMkdB77sNy1EhRBlk8tqYwfYe1HrRtEayO5f85cu88418PDY4xpKVTdcKE0ZUtVEJzgAzgPeH7lnnNyMyS60GdAUVlUfTgA16kMmUkqDzthykequR/fJXFYA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by OSNPR06MB8211.apcprd06.prod.outlook.com (2603:1096:604:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 08:41:32 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 08:41:32 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Joe Komlodi <komlodi@google.com>, Patrick Leis
 <venture@google.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 15/17] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
Thread-Topic: [PATCH v2 15/17] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
Thread-Index: AQHcTgiR3LW4AMN6mE+ghUwwqx9ZTbTm3qsAgAAF7CA=
Date: Fri, 7 Nov 2025 08:41:32 +0000
Message-ID: <SI6PR06MB76313FD0A33D0430B52014B3F7C3A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-16-kane_chen@aspeedtech.com>
 <987ff09c-7b9d-49a5-8e81-38144fee1b4f@kaod.org>
In-Reply-To: <987ff09c-7b9d-49a5-8e81-38144fee1b4f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|OSNPR06MB8211:EE_
x-ms-office365-filtering-correlation-id: 29d5bd4a-9dc5-4221-55a3-08de1dd97400
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?b1VoMkE4b2JOTG9ybllnaVdWQ3o5MVJDQ1NYaUkzV3FoeUQ2aWsyV2xPWmh4?=
 =?utf-8?B?OTdZc2FpZzlzQWEweStoMzQzZDhjOXZBV1RjYU82OGpkMXRRZStIZmJxbEZs?=
 =?utf-8?B?YnNZTUdDOXdNK1JzMkxEUC9uTFQvUnl2d2FjWGNPQzlzWlZoT0YvR2tOM05O?=
 =?utf-8?B?K2pWZi9Hc0VzUHZuMkFwTENBS0lGOGxFMVNCbi9BTUdGSGNmeUxJZmxJRHUv?=
 =?utf-8?B?V1REVXRkam9naWdteG4rc2djZ21OeVlKeThodWpPZGYzd3ZQM3ZkcEVpVjRT?=
 =?utf-8?B?bEFiMWgyM2dCSXF2cGpnWHJlNCsrTGVRVVV6TTBNdkNzaktycWFTNlREajd1?=
 =?utf-8?B?MzJ2ZG84Q1k5TXVWeHo5R2RqRnY1Y2NRdnR5K3VHTzhFQjZqVzByL1EwVHlI?=
 =?utf-8?B?NmY3Z1lub0crUUJHR28wb2YrK2QwMjZqNDcwbUJmR3RNYUF4T1lOVjY5b2Qy?=
 =?utf-8?B?NDE3VCtlNTBkM3VkTnRBR0pNN3Ard3lkK1BkUXRlNmRGajFxSndWV3J1L1JH?=
 =?utf-8?B?eGdJU2dXUmlCTTc4N29OMnNKbXdRN2srd3ZVTzhKUDd2LzlhY0hDYzlHTHBK?=
 =?utf-8?B?T1d3NXYzbFBXL1J6SENlc2ZLa1VGOVoxdmtQYUNTRk80TDdRZ2txcGhpeFBN?=
 =?utf-8?B?WjE3MFlORHJlUVVVWm10M0NpVG1wZWJYamFVTnVnQ2UydG1LM1FDU0s4QmMr?=
 =?utf-8?B?SzJQSEkrN2FGL0RkbklEeUFZUTBaeTkxby9hdmg5NlNxTndpSzRpakttZUEv?=
 =?utf-8?B?Z2FNdGdmWWJHNWs5bitDcmdXenUzNUlzK1hLTFFQSklDYXJENmQ5Rm04WFFT?=
 =?utf-8?B?aGd6Qm9GcDladzNKRktoKzkyd0NDSXVWWkdremlEd2hzVlhTdzlnSDZPbjZx?=
 =?utf-8?B?c213L3A4dVl2RXRTK3BoZnFVaVNwaHExcjk5eVkvcmUya2Y5Zk0yU2IxTkVC?=
 =?utf-8?B?MUJjM3Bwd2JaVXF3RHdtdHBQVGZsMmZ0R1l3NEdYblNmSUp1WUROU1BKKzhz?=
 =?utf-8?B?QWNObzZhREhxeUROVmdvd0tIak4zSytDQU54R084bFhQOE42eUc2R2ExZTlt?=
 =?utf-8?B?dUlZMjJseWs2TjBNbXJhSE9IeFVWQzBqZHBGKzJKTFNWeGdsclBrOTZoaS82?=
 =?utf-8?B?V0FmbVVIUzNwL1JkVks1SGxPYlFrTlNuRm0xM0ZZR2tyeXZvTHZuUTIzZE9k?=
 =?utf-8?B?b1BXUktwUjk1U0EzaWdqcEhaTEw4eFdsc1hIM1QvUGNuMVJMS2RpOSszNi9P?=
 =?utf-8?B?L1BBcUF5ZG1xSGxkWGloQmRwbHhSMVlSVTA4c3NDRExuY2kzUEZmZ3ZOc2Ex?=
 =?utf-8?B?V2liaTRvbUxBcHRhMTUrZ0dTU2J4TTk0c3BYTmhlaFJtVnlaNGFlVEs5QUVr?=
 =?utf-8?B?WEw2bkErWmUyRStXQzhNNXhVY0FETFBZanFQMDFsQ3NReEZneHZpN2hrbTBU?=
 =?utf-8?B?M2wrZ2pXdm5xbmtIK0JWNGNrUGZIV1Foanl5K21ITWFTUnVpQWxYbHJxRzFz?=
 =?utf-8?B?ci9IdjVhemV1bUtQM0VkL1dlOTJVOGdST0FmT2xVdm8wTE1scHpzT3F3b01i?=
 =?utf-8?B?enAwRmt3SmxaOHh5TFRkalFuRFRXOUFIb3dvckFMVndpOEpnV1JjazRWK2wr?=
 =?utf-8?B?bmJPRWVOSlVvdEVwUlJxRVZtNGhOUU1yd1doRGgvN2dNZmtiSGZacUhVRW50?=
 =?utf-8?B?QWt5Z2RLSHBjSFhCWk9wZlhZUktzTlJnSkpmelZERTVkQ3pmRW1ZSVN4ZlFG?=
 =?utf-8?B?ZkRtYzd6WXhINHdKeGEvR3VCYmlsQ3UyRmxIenVaUUp0QkdDZlFmdlEyWkVn?=
 =?utf-8?B?QVdFM1JjRmM5MWI2TW9CMmxGZWg0bHBsZkJ5M21zOUJJaDFkVUpWTzZyTE83?=
 =?utf-8?B?bVRzOGhzdHNMV0NzbTUzS0JGRWFJbHRZRGZmSnEwdlRPUis1cjc1ZDNaSWto?=
 =?utf-8?B?SDRpeTBNMDBpQmdDcWZwWWxGVE1seXJzV2RHQjluMktmMEljdUdBaGVZK1Jx?=
 =?utf-8?Q?nhtkoEtUjfGzz64leJ9t+XFqlR/n54=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnZkQUE2RU0rcTAxajJMTFZoT2FKNGNrVWg3cmdXck5FdjVkZmFiajBIdTJQ?=
 =?utf-8?B?OGcyZ0NyTlJuUVBwVlZkV2hmYVQxOFR2TWU2QXhKUy9yOGlCb0JGMG1NeDlX?=
 =?utf-8?B?OWdRSGhZblVPbFVMQXBNT2JBbVk5VXhtK0dvbk4yUmlhUGJyNzRib0ZzZFpJ?=
 =?utf-8?B?L0ZqcGU3M0hxUXJyUkdINE5pWUFwUUlVVUlGRkRoSHA4UXRXbmxmQk8xa1pX?=
 =?utf-8?B?cUV2RTgvNlRGZDYvekgvbi9hL1VjRHozdFY4dGN6VUptaFRIOGF4bUt4c1pt?=
 =?utf-8?B?Uk54bTNuVzB2ODlCRTZ2aUYvMVZFdHFESFBQYk1TT216YWhFUFJrYTAycVc2?=
 =?utf-8?B?clo0bkViRFYyTnFnc0JWRkcwT2NFNzEvbUZiU1Z2am50dmdoZXBBTHZVUFhS?=
 =?utf-8?B?clZrbWIrUTBOTmUrdFpSbWNHVVg4Ni9oczZxNWZINlN2a3BkcE1zSktOQ2to?=
 =?utf-8?B?cVp5VEEvRzdVZWMwcEFmM3J0S2RhSVFvK1ZUZlA5cGFHeGljWWZxU21oeWNk?=
 =?utf-8?B?Ui9HTkxPYUFiSWxQRnJLVjg5YzJ0dkNqelowSUxkeVVRRHgvU1c5eUR5T3hV?=
 =?utf-8?B?S2VMRi9QU0lxb2phZ1kvczJEMGx0NVVhd2ltbHhER29GL1NZZnYvb1Y1dmxX?=
 =?utf-8?B?YjV2TnFmREdlaGloQm9QV212d0t0eEg0bDFRcXRzTkYwODg4OE1FSFFveWVX?=
 =?utf-8?B?dzRoK1JwTzVIS3BYbGZxL083MHZaa21WajhST3F3aGtnYXczSHdVdlE3TU9w?=
 =?utf-8?B?Vjl5akx5NWljWXV0UWNvazBYWWUwR2kwaUdQRHkwNEdma3RlSUo2TE9WN1Ra?=
 =?utf-8?B?YkR1N2FFVmF5UWJsa3JZWEhWKzYxbk9OL0xsVnNjZXN4ajE2WUlOYmVGalBt?=
 =?utf-8?B?QVlMTUg2NGFNbUlVR00zaXFXSC9YWmhKOWozQ3Rsa041NDFOaUh4N3FPbFhZ?=
 =?utf-8?B?VDVmMXpHYVQxWkl0VHFjUWhqbXpQRzJZSGRXeUlvZ2pXdlozT2ZIbHROcnZV?=
 =?utf-8?B?RVl2Q2NZdG8zWlhHajJxTjk3alBGeGJ0RWJFVjZyR1ZlRlhjVTV3K2Y3Wk0x?=
 =?utf-8?B?N0V4WGM0K3FJWFhYRjc3NUh5LytHa25QcS9TS0lDMXJyK3lyYVRscGtqMFk3?=
 =?utf-8?B?UzVYUkVzWUduM3VFMVl2VzR4TjVhWktVM3RCcVlOcDduV1FvS052YUdHWGtD?=
 =?utf-8?B?NEkvK1BVWE5wQTkvU01yQmZ4aVRQa3p6WDNTYWN0eXRqeWxJSFQ1Ylp0VlFo?=
 =?utf-8?B?L2hEN2MrUFJoYWlsVXZ0SlVQRldOWnF2ZHRzNmhjTzBTZDhiMnQxNExNUTNh?=
 =?utf-8?B?SWhmRVlCeFI2RmYvN0FkS0cyWEhnRzlYY3NUa1piSGZpaFZrUGdPME9RemJI?=
 =?utf-8?B?b0R3RUFYQy92UUVXaldVbjZyOXFNZlhHYmdtbno0Zk9KRE8xSVQ5akFDMytG?=
 =?utf-8?B?UGZSdHNGdDcyTENiRFhnZXNLUGdrRFRCOVV6d2RBd3Q2dmd5a3Y5cUNmZTli?=
 =?utf-8?B?TkgvNm1QcDMyR3ViWUl4MFQ5KzNGZzM4NitiNWZQbkMyV3hCOW9YTmFsbC95?=
 =?utf-8?B?TTE5dW50U1lGQWFDZWZZK1V2M3ZINXdxc3dpSzVtbXhzNDQzWGl6bmhXaWk4?=
 =?utf-8?B?MHNwSEtpdE9JN3NsV2RUMWVvYTlUQXhwNDdBQ0dKb0h1RDlrYmF2OWcvd3pS?=
 =?utf-8?B?RWt5UjNCQjIzUmhIWmNoblNqSUQweFdyOTJwdUFLQjNFNCttOEovaTlhV1Za?=
 =?utf-8?B?RnhVbkNnWi9aSU9DVDBFaGpWUVR2NjNzdXpwN0JsT3BCSG1ZbmgvVzB6QVRM?=
 =?utf-8?B?Z25RMTVCQ1NsSFpYSG10Q1ZXUHkzbnQzcGNYWUlwWEQxVk42TjlDQzVadE50?=
 =?utf-8?B?dmg0VXZ5d0wrbW9sTE9paE5OT0YrL09oNEdJTCt2ZDZSUVhNM2hJV3FBd0o5?=
 =?utf-8?B?bFI2Y01ST0NjSDBKOUlVT3cyUjgyWjdSSElmRXA0dHFSWjVoOWRWaTAxdU1C?=
 =?utf-8?B?WWZzQTR6U2pVV1hzbXRYQ3RLbm42eUpSSXo3dWxkQ2U2c1hTTlVKZ3Jtc3VF?=
 =?utf-8?B?TW1oaHozWlZ0aEdPRWlMblhMWWNLT1hOMXR4VGp1b3NIQTcwL3VwQlFIbVgv?=
 =?utf-8?Q?UCH9BkC+hFilCHMiGxQXD860q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d5bd4a-9dc5-4221-55a3-08de1dd97400
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 08:41:32.4292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ld3dQOZ/DqJcvJ+2DQiBe4k+P5cT6Sa5B8e6jp9YQUiwdB8/f9Ar3YHYOmBTNFy1kxBZ3zjsIsFhmJnGLJ1BXh+GEKuyBtH/n7nY0MugT9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8211
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KSWYgSSB1c2UgdGhlIGN1cnJlbnQgSTNDIG1vZGVsLCBpdCBjYXVzZXMg
YSBrZXJuZWwgY3Jhc2ggYmVjYXVzZSB0aGUgdmFsdWUgb2YNCkFTUEVFRF9JM0NfTlJfREVWSUNF
UyBpcyBzbWFsbGVyIHRoYW4gd2hhdCBBU1QxNzAwIHN1cHBvcnRzOg0KaHR0cHM6Ly9naXRodWIu
Y29tL3FlbXUvcWVtdS9ibG9iL21hc3Rlci9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX2kzYy5oI0wy
MQ0KDQpUaGUgQVNUMTcwMCBjYW4gc3VwcG9ydCB1cCB0byAxNiBJM0MgYnVzZXMuIEluIHRoZSBj
dXJyZW50IEkzQyBtb2RlbCAoYW5kIGluIEpvZSdzIHBhdGNoZXMpLA0KdGhlIHZhbHVlIG9mIEFT
UEVFRF9JM0NfTlJfREVWSUNFUyByZW1haW5zIDYsIHNvIEkgd291bGQgZW5jb3VudGVyIHRoZSBz
YW1lIGlzc3VlIGlmDQpJIHVzZWQgdGhlbSBkaXJlY3RseS4NCg0KSSBwbGFuIHRvIGVpdGhlciBp
bmNyZWFzZSB0aGUgdmFsdWUgb2YgQVNQRUVEX0kzQ19OUl9ERVZJQ0VTIG9yIGFkZCBhIGNvbmZp
Z3VyYWJsZSBtZXRob2QNCnRvIHNldCB0aGUgbnVtYmVyIG9mIEkzQyBidXNlcyBhZnRlciBKb2Un
cyBwYXRjaGVzIGFyZSBtZXJnZWQuDQpBZnRlciB0aGF0LCBJJ2xsIHVwZGF0ZSB0aGUgQVNUMTcw
MCBJM0MgbW9kZWwgdG8gdXNlIHRoZSBuZXcgSTNDIGZyYW1ld29yay4NCg0KSWYgeW91IGhhdmUg
YW55IGNvbW1lbnRzIG9yIHN1Z2dlc3Rpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCkJlc3Qg
UmVnYXJkcywNCkthbmUNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8Op
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA3
LCAyMDI1IDQ6MDYgUE0NCj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29t
PjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExl
ZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWls
LmNvbT47IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEpl
ZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBq
bXMuaWQuYXU+Ow0KPiBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+
OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MNCj4gaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PjsgSm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT47DQo+IFBhdHJpY2sgTGVpcyA8dmVu
dHVyZUBnb29nbGUuY29tPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDE1LzE3XSBody9hcm0vYXNwZWVkOiBNb2RlbCBB
U1QxNzAwIEkzQyBibG9jayBhcw0KPiB1bmltcGxlbWVudGVkIGRldmljZQ0KPiANCj4gSGVsbG8s
DQo+IA0KPiArIEpvZSwgUGF0cmljaw0KPiANCj4gT24gMTEvNS8yNSAwNDo1OCwgS2FuZSBDaGVu
IHdyb3RlOg0KPiA+IEZyb206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29t
Pg0KPiA+DQo+ID4gQVNUMTcwMCBleHBvc2VzIG1vcmUgSTNDIGJ1c2VzIHRoYW4gdGhlIGN1cnJl
bnQgZHVtbXkgSTNDIG1vZGVsDQo+ID4gcHJvdmlkZXMuIFdoZW4gTGludXggcHJvYmVzIHRoZSBJ
M0MgZGV2aWNlcyBvbiBBU1QxNzAwIHRoaXMgbWlzbWF0Y2gNCj4gPiBjYW4gdHJpZ2dlciBhIGtl
cm5lbCBwYW5pYy4gTW9kZWwgdGhlIEkzQyBibG9jayBhcyBhbiB1bmltcGxlbWVudGVkDQo+ID4g
ZGV2aWNlIHRvIG1ha2UgdGhlIG1pc3NpbmcgZnVuY3Rpb25hbGl0eSBleHBsaWNpdCBhbmQgYXZv
aWQgdW5leHBlY3RlZA0KPiA+IHNpZGUgZWZmZWN0cy4NCj4gPg0KPiA+IFRoaXMgd2lyZXMgdXAg
dGhlIEkzQyBpbnRlcnJ1cHQgbGluZXMgZm9yIHRoZSBJTyBleHBhbmRlcnMgYW5kIGFkZHMNCj4g
PiB0aGUgY29ycmVzcG9uZGluZyBkZXZpY2UgZW50cmllcyBmb3IgdGhlIEFTVDE3MDAgbW9kZWwu
DQo+ID4NCj4gPiBObyBmdW5jdGlvbmFsIEkzQyBlbXVsYXRpb24gaXMgcHJvdmlkZWQgeWV0OyB0
aGlzIG9ubHkgcHJldmVudHMNCj4gPiBjcmFzaGVzIGFuZCBkb2N1bWVudHMgdGhlIG1pc3Npbmcg
cGllY2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBh
c3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2Mu
aCAgICAgIHwgIDIgKysNCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5oIHwg
IDIgKysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICAgICAgIHwgMTkgKysrKysr
KysrKysrKysrKystLQ0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5jICAgICAgICAgfCAx
NyArKysrKysrKysrKysrKysrKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gSm9lIHNlbnQgKHR3aWNlKSBjaGFuZ2VzIGFkZGlu
ZyBJM0Mgc3VwcG9ydCBbMV0uDQo+IA0KPiBJ4oCZdmUgYmVlbiBtYWludGFpbmluZyBpdCBpbiBt
eSBicmFuY2gsIGFuZCBmcm9tIGJvdGggYSBjb2RlIGFuZCB0ZXN0aW5nDQo+IHBlcnNwZWN0aXZl
LCBpdCBsb29rcyBzb2xpZC4gSSBiZWxpZXZlIGl04oCZcyByZWFkeSB0byBiZSBtZXJnZWQuIFdl
IG5vdyBqdXN0IG5lZWQNCj4gbWFpbnRhaW5lcnMgYW5kIHJldmlld2VycyB0byBzdGVwIGluLg0K
PiANCj4gV291bGQgaXQgYmUgdXNlZnVsIGZvciB0aGlzIG1vZGVsID8gSWYgc28sIHRoYXQgd291
bGQgYmUgYW4gYWRkaXRpb25hbCByZWFzb24uDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiAN
Cj4gWzFdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTA2MTMwMDA0
MTEuMTUxNjUyMS0xLWtvbWxvZGlAZw0KPiBvb2dsZS5jb20vDQo=

