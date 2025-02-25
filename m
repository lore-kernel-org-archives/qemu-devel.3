Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D36C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmptu-0005IM-Mn; Tue, 25 Feb 2025 03:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tmptt-0005I5-5Z; Tue, 25 Feb 2025 03:02:45 -0500
Received: from mail-tyzapc01on20716.outbound.protection.outlook.com
 ([2a01:111:f403:2011::716]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tmptp-0002hs-9K; Tue, 25 Feb 2025 03:02:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVJEpKU7h53xfLrKzxQRGteTgmfOdhcug5ohG8uqxmneG5XxQLifUFDlFfDBc2j2J7iZTzNnRPBhPUBYnmTYzH8+HzYTZIIVz8GbEmHw0YaiH+SzaVA8y/LTT5wvHPrXm9A8g4PZhNjKTLKu9ecYiVhVEOdKJtrn1OGK3khw1NK5A9Ox475CuIcvHx6Z2f84l1VGSHXcADNH/TaHXhbqcN+3vBpA0DfoB1oR2kQ2MtgqjL4EPm/oGn+pF0VMv1ZmhFYGRf7EfpRUwoCd4CurEtKpMDIZYNlRNF5Top8FnTsLlNhYAjNEBJGLh2SFi7NI1SVfjR6o2gNiTt59rggceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atz1vfE4QlW/hLPGUzTgu/TDkwJoWVwVNmN8n2MKvck=;
 b=WMq6d0uIv+0p2rWB0kK42lTYGh+6M68+ILmojit+a1KCJwEtRghZRTh1yAUV3BQ8kwG9mb69ehrvCK8vea5oSISciATTgPQEaIdpSgj1qBca7qHkiYmRoMo6N8g8fgrVA2ji+JgxcZ9fdt05H2ddDBHRJFfb8TySXnZQkHShX4E1JsD3npg62DZ1O2a38uapyUdK3PPoE2bm9/dFBW0mXeNrUwit7FEI6oubgHdYbqieIjzTHqlOBWOFoPh5cL+3mMbRxZMyFozlNvvnByysDYWUtipH3gZhD0vZ+8viyBLBYN8Uf0EdY742t46TDHWCT5KCmWQFTZhl6bz6p0BiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atz1vfE4QlW/hLPGUzTgu/TDkwJoWVwVNmN8n2MKvck=;
 b=G+ZOjEvpQiMw2v74lV0hGcBvAtYzIJkq+kR2n4F5aoHZcCTYPnq0lO+6+jMJ5oPtkpgBMkWRjt97bXQ8OfmiGn1yjVwhKpaX5NdQCy4kRx/E9uHV9p7kgqDnh8FuE+J9nGHjeL3TJtrqSTmEUA3BbpKgG9RbTgsRGmAVDr5zIXTc9lxNm6GKBNujnCaOyvo4aOTTIgRiWp2lZnyKaFymg8BxIWKDzmZB/SS2zUrUlGnp4sQWfT4NurQudYvSp4RKxj+fiUMq3iM74YUBs7JRauIETaUXa2DU3XGaJsRzKKAjoF+NAQ50Wjv8rwzLzgxvX8QsyTOLji5Fbi1DW7brvA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7141.apcprd06.prod.outlook.com (2603:1096:405:b7::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Tue, 25 Feb 2025 08:02:27 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 08:02:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 00/28] Support AST2700 A1
Thread-Topic: [PATCH v3 00/28] Support AST2700 A1
Thread-Index: AQHbfchZ2DVXsd5AV0G4GwgEpHk/17NM0p0AgALZSbCAAmN4gIAFrBGw
Date: Tue, 25 Feb 2025 08:02:27 +0000
Message-ID: <SI2PR06MB5041014DFFCC19F90FF88832FCC32@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <4bbd5a9e-934e-4535-b829-1d4fe070d63d@kaod.org>
 <SI2PR06MB5041D7BFF0F491FFA7CE3159FCC42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <06b4ab70-5fa4-4b46-9461-f03eb0b5cbd8@kaod.org>
In-Reply-To: <06b4ab70-5fa4-4b46-9461-f03eb0b5cbd8@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7141:EE_
x-ms-office365-filtering-correlation-id: 52248dee-a99e-436f-d39c-08dd5572beeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?N2N4QjFKbyt4Zjk1QUVsOEFTVlhDUFJ4VDZxZXhmNEFyN3k3eXF1Q0xKNGE1?=
 =?utf-8?B?TnB3ME1IUEVoNFpOY0ZMY3VIcEN3UmYyKzVZU3hsa2lLYUlyYjVQdXhZRVhM?=
 =?utf-8?B?b0dzOUQwdXZNMTRhb0ZTNXR2UVpSMzNFcktaVnN6aHFHQVg0NUxTUXhIVjRK?=
 =?utf-8?B?Mjc3YTNVSHdrSlhPbWJCaDFmdk1JeFhBdnl6Y1p3bkZqdUkyMHVKenZ5M0pX?=
 =?utf-8?B?Ny9nWkFtc0hPcm5wSEphUFBtakpQWGRSL1JRdHBDRVk2TDB1ZGhhdUV5Yk1Y?=
 =?utf-8?B?bm4xRllrd3YwYi9zVjcyOWhCVlEyQkdCYUhqVEw2QnJtQWZxSHgwRnMxaHZH?=
 =?utf-8?B?Y2Z1Y1NGcTZDMUUydWNBam12S3dlS3RJL09ydFNJT0IyNlJtU0dVWEM2ZlFu?=
 =?utf-8?B?VGxZU0NWZ0VGR1Zpcm1HT21mOTBDYVBWS0M2T2VsZUZSc0J6OXZyTTduNGFG?=
 =?utf-8?B?ZUtQemQ2RkFmS2sxbks3b1lNR1JZRVpQd1NtTE5SbmpJb0NiQU1TQWdBcmJr?=
 =?utf-8?B?MlMzZEg0YWZvZFFNSC9KNzd6dWxZRldYUnA4dDVzY0VuVFM5NzhOaUYwclVt?=
 =?utf-8?B?MUY0UU1Ca2lCN21McFFXeU5pdCtjSkxxTnNWWGxBZUp6R29MRUR4eStRcHh4?=
 =?utf-8?B?b2doRVhuWGRwMHRENXNjU0pMY2NzQ2M5aS9oaVd3RUtCU3RsTlFuRlM4dmFl?=
 =?utf-8?B?SG40YUNjd2xBem9OZlM1Nkg2VjFYSEtDVk9RWlpHWTFZakRNWmQ5ZjlCcmd4?=
 =?utf-8?B?VUVjWlluRHJPYkcrbmZMUkFwRCs2SXpMUTErQlBMYi9qdDlsRU9XZjFBSFV4?=
 =?utf-8?B?UU5kQVFPM0Z5eU9OS0kxZm1QdFlNc3FFY1N4azJmRmZuN3R5NkVXNEJLcE1k?=
 =?utf-8?B?VGoraU5JMTRhNVBTT0IvKytPbng2MUJiY29aLytEcHozZVNOajc2bWFHcHFi?=
 =?utf-8?B?ME9Nb2pFc3crSi9raTVDaTgzQ3lKSDRpWnpKaTMyNUplV0VsU05QalNJYXBv?=
 =?utf-8?B?VHUrbDcvdWdpbVEwRlBjWXVsa3NYcFk2OU1uVEFXUi9ubW80RmxtVUZhbEp4?=
 =?utf-8?B?c1VrUnNNOG82KzUzcnI0SkRFMWZET1VVMkFwQ3lRaVM3WmtNMUs1RktNdlc1?=
 =?utf-8?B?STZNNkxTd01WL05ES1lHMnlpak95Z2FTNjBTMm1QVlRuZ09TY3lUejEyV1Va?=
 =?utf-8?B?eEozMWhFdldQcEQ5UEpHbmpxK056WWRvcGJSbFhMZUNVcko0YmlSdFIweVZB?=
 =?utf-8?B?c0VKV0dFLzBnSDczUTNrNG4rNndJN0VuV3lxQStMTUNkd3czd2xxdjFGTFBQ?=
 =?utf-8?B?KzdtdDJnbXAxOHpuaE5FOGN5c3JnNm9DWFlBWHduWXJ1OE5lZlNwYWt4cHRm?=
 =?utf-8?B?ZGxUUkRTRjd0M21XMXhndUV2T2xIU2d4SW1EOWIrNk54bmZ2Z3M0bzFvWXJp?=
 =?utf-8?B?TDlNVVc4UXoxdHJIYU8reEZqcnZXR0o4dTJ1NDNQOHVUTU9VSnB2bTVWTEwv?=
 =?utf-8?B?Z00yWEt3czBjN1JxSWVFUERPaXk2dmNPd25sNkhGQUZQeVZBejZnWFg3NHVE?=
 =?utf-8?B?UitEM2JHdkNHQzg2M1ZldlUzcHJGRDEwTGVpMm1VZWxIeWFzaXJ0RTlWWFhs?=
 =?utf-8?B?dVJkNjNla3hocERmQ2lIckUwYnZ6UEx1ZjRYNGdEa0Y0NCtSN05XVktURHpu?=
 =?utf-8?B?aFlKcERsV1RZS2NOK0dXYnI4czFPR3o4L2hzWXV5c1dRaEs1bzlsRVZCOTUr?=
 =?utf-8?B?KzBzU3JJTnQ5K2VDYis0VGZpdGVKUk5GVXYwbmNrcDd1dGFYVSt6eUw2a2ZR?=
 =?utf-8?B?L0RaSUQ4TGlUN25WYlk4amhvdXduRUZVMEQ5OGhoVGx2Q05UNmtuVjNYRWRD?=
 =?utf-8?B?aGlMVndzRFhvS0JoaG9kUWZOSzhxOTZ5R24rU2M1TmpNc3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amZvMENkTURmLzFwYzk1bUVTTnVueEU3MmpLb29MODF5Ykp2Rkc2cmt6Y1Ni?=
 =?utf-8?B?emh4RXlmWTF6M3RORGlTamlzaUtWVG9VYTVNb3g1YlNxeVJ4ZG5ZOExyeWtE?=
 =?utf-8?B?S0kzZU9NUCtEYitoVU52alVCcGx2ay9oQW1FZHZYL3dSdDUrTmFLSUF5eVUw?=
 =?utf-8?B?dUpRU1NlNDlCREJLNVdCMmR3TmtwamVCdktrTHc1LzFid2RnamFRSmltUTl3?=
 =?utf-8?B?aUFrTVpmWURQWjg2VXpXcWYvcFQ5R09WNkFGcVkrMjVnZitFRUQrUUt5RkpD?=
 =?utf-8?B?T0JPeUNYaVgwbGxPanVTRm13WTF2Lzd6ZXVQYWttVXFkM2Q0dEV1QTErRk1R?=
 =?utf-8?B?aFFBMHAzcnF0WU5LMmNNM3JWZ3hUNWZHU1JrRWpyWklhYmNPZ3NKQktWTnBn?=
 =?utf-8?B?blZIUTJsRC9JcnlzMSswOFVUazBMSTZyc0xQRENVZ0IwWWN3OXBVMmozSWR4?=
 =?utf-8?B?TUFKZmJsbzlmcGw4emR4NTA4ZGVpUEdIamdRYWJQM3JBQm5QWTFNVjhIcVNz?=
 =?utf-8?B?d1pnZ2ZFbmZHZFc4S3Y2dXczb2tUVmlPS0ZpdWllcCtmc3cxQ3hnWVhXWk9s?=
 =?utf-8?B?clZxUmJzSXkyVCtnRnhtcm1FQmRZeE9yWnBXK1dVb2RyaGkrT3ZTRCtydmxy?=
 =?utf-8?B?ay91ZmdVNzVMcURlQzNRcVZlNzViTjVsc0ZBQ2N3WXM0cnFwN1VNaGQ4RHo4?=
 =?utf-8?B?Vzl5UENTZ2hzaHUvNGpwb1ViTnlnVGc1aWM4a3dwTHFWVXpvbmV1TzlGVVJn?=
 =?utf-8?B?cjRrV1FNeXVzSHkwZ3lHOXdoa1Q3NUdmTVVsZithdFJ6TVYrYWt5MUY3SHFj?=
 =?utf-8?B?VzNXeW5XSStjd1M1NFJveDN4cGNZZDNkaDJNWGg3MEJraE9YWnZONDlYUmow?=
 =?utf-8?B?S3BINlVLWTNsZGw0TlJFM2lOWndwaGZqZTFEbXUxT3g0K2grRFZlYU93VXha?=
 =?utf-8?B?Y0tyazdVUSttN1cwWFVVSW5WQXZWVEJOWHlMTGdhbk1uSlZhWGRzcFA4SWh5?=
 =?utf-8?B?enFTQ2UwZDFRdzY4Ris1SXViWmhRSVJ6RVhuRFBTcnozOXRnUXpBUTByd1E5?=
 =?utf-8?B?Sjk3R1o5dEdhTVp2YkdOSENEZ2NGbEExRGRrdGdXTjlwWWRaSEZLb1M3bzMx?=
 =?utf-8?B?Q3BKRm9SQWJIMFJtSHZBMngrajZNdXV2cDdhV0xkZ1lYQ2xGMTllQ1ErbVBB?=
 =?utf-8?B?dGkxMWxqU29IblQyRnRTWFg4Q2dpWk9tcnZLVmZ0aHkvZU5xV3dkd0VTNm5p?=
 =?utf-8?B?b0h6Q1BWWkdMajk4NFFLdndHZWl4THV4SjVMdjhYZXhveGJLWFRFQ2NMMTFz?=
 =?utf-8?B?aEg5bnRsS2RuWkZ2SlU5YmM0RmZTL2habE0xbFJHTFhZeVRxbXc2N1Mzc0Vx?=
 =?utf-8?B?Q1JRTHNYZU1ocjJRMVVWRHl0cVJKREU0QWtZbFlDWmJqcU9hVVBvbyt6Rmkz?=
 =?utf-8?B?cllaa0xWZjdmTzVRR1Nja1NIUVZXSEtOMUkxN09MenNPbklOWDUxdXhaZUs2?=
 =?utf-8?B?alpxcnZCZDJnVXk2UmFQK1Z1Q3VGeDAwMVI5SWdzZ3RIcllITUR6aGtWdFh6?=
 =?utf-8?B?ZmtSeUduNE1KLzh2T0c4SkVLNzdyUWEzYmh5Ky9jSE41Q1BqdC85alRrNHht?=
 =?utf-8?B?Y3hyMzU0cnMyZHFqeXIwcDRPMCt5NUxHRzFQSGRRMUpOV3IvdlR2ZFhDMzAv?=
 =?utf-8?B?eW1CVHJLSVZNQ3ZVOFZZdGZsZUZCdmlSU1JNVEkvQjh1MlA1aUJoeitLck9Y?=
 =?utf-8?B?TzZxRE9nd2sxWlBrdmFrWDFxNE9Oa0JrU2UwTnpJbUkvL2llUzBocDZhNEpv?=
 =?utf-8?B?Ym5ZK3pKM1FsMStlUlJqa0FMNFl3SVg5a2YwdWJCODQzaGdBNlR1QysyeUFy?=
 =?utf-8?B?WS9UNmVlMW8zaGcvUEpJZVhPUERSa2p3SGRYM2pyYjduMFJLL0xpNkZBc2RJ?=
 =?utf-8?B?WHpCdk5Ga3dvT2hPS1pGWjQyekV6ek9wNmhZM2w0WXZqY1BEd25Udmp5ci93?=
 =?utf-8?B?ZGNNVHRxcDV2SHZXWW80cGIzNzFoenpxZzBNN3V5TnAzZ05ZSW9sZytOWUsx?=
 =?utf-8?B?ZEdCWmpHaTVoczNlMjBsY1hrbGVxRTF3V1JVVkh0R0hmczhPK0w1cnkxNWMz?=
 =?utf-8?Q?Q2RX5Mvz6QzemSsdMan2juqXj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52248dee-a99e-436f-d39c-08dd5572beeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 08:02:27.4167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwA+3phzPJFIl0iCpKgEzYFFGgpQM1bSdZm0NP1bpAkGa0ZNjoB+3aDwfds8cgijZp/8lvvZEugUqfVjBAifmpIc/YJnU71wxb5yx61bjAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7141
Received-SPF: pass client-ip=2a01:111:f403:2011::716;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLCANCg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAwLzI4XSBTdXBwb3J0IEFTVDI3MDAgQTENCj4gDQo+
IE9uIDIvMjAvMjUgMDY6MTEsIEphbWluIExpbiB3cm90ZToNCj4gPiBIaSBDZWRyaWMsDQo+ID4N
Cj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwMC8yOF0gU3VwcG9ydCBBU1QyNzAwIEExDQo+
ID4+DQo+ID4+IEhlbGxvIEphbWluLA0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyLzEzLzI1IDA0OjM1
LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+PiB2MToNCj4gPj4+ICAgIDEuIFJlZmFjdG9yIElOVEMg
bW9kZWwgdG8gc3VwcG9ydCBib3RoIElOVEMwIGFuZCBJTlRDMS4NCj4gPj4+ICAgIDIuIFN1cHBv
cnQgQVNUMjcwMCBBMS4NCj4gPj4+ICAgIDMuIENyZWF0ZSBhc3QyNzAwYTAtZXZiIG1hY2hpbmUu
DQo+ID4+Pg0KPiA+Pj4gdjI6DQo+ID4+PiAgICAgVG8gc3RyZWFtbGluZSB0aGUgcmV2aWV3IHBy
b2Nlc3MsIHNwbGl0IHRoZSBmb2xsb3dpbmcgcGF0Y2ggc2VyaWVzIGludG8NCj4gPj4+ICAgICB0
aHJlZSBwYXJ0cy4NCj4gPj4+DQo+ID4+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9xZW11LWRldmVsL2NvdmVyLzIwMjUwMTIxMDcwNDI0Lg0KPiA+PiAyNDYNCj4gPj4gNTk0
Mi0xLWphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbS8NCj4gPj4+ICAgICBUaGlzIHBhdGNoIHNlcmll
cyBmb2N1c2VzIG9uIGNsZWFuaW5nIHVwIHRoZSBJTlRDIG1vZGVsIHRvDQo+ID4+PiAgICAgZmFj
aWxpdGF0ZSBmdXR1cmUgc3VwcG9ydCBmb3IgdGhlIElOVENfSU8gbW9kZWwuDQo+ID4+Pg0KPiA+
Pj4gdjM6DQo+ID4+PiAgICAxLiBVcGRhdGUgYW5kIGFkZCBmdW5jdGlvbmFsIHRlc3QgZm9yIEFT
VDI3MDANCj4gPj4+ICAgIDIuIEFkZCBBU1QyNzAwIElOVEMgZGVzaWduIGd1aWRhbmNlIGFuZCBp
dHMgYmxvY2sgZGlhZ3JhbS4NCj4gPj4+ICAgIDMuIFJldGFpbmluZyB0aGUgSU5UQyBuYW1pbmcg
YW5kIGludHJvZHVjaW5nIGEgbmV3IElOVENJTyBtb2RlbA0KPiA+Pj4gdG8NCj4gPj4gc3VwcG9y
dCB0aGUgQVNUMjcwMCBBMS4NCj4gPj4+ICAgIDQuIENyZWF0ZSBhc3QyNzAwYTEtZXZiIG1hY2hp
bmUgYW5kIHJlbmFtZSBhc3QyNzAwYTAtZXZiDQo+IG1hY2hpbmUNCj4gPj4+ICAgIDUuIEZpeCBz
aWxpY29uIHJldmlzaW9uIGlzc3VlIGFuZCBzdXBwb3J0IEFTVDI3MDAgQTEuDQo+ID4+Pg0KPiA+
Pj4gV2l0aCB0aGUgcGF0Y2ggYXBwbGllZCwgUUVNVSBub3cgc3VwcG9ydHMgdHdvIG1hY2hpbmVz
IGZvciBydW5uaW5nDQo+ID4+IEFTVDI3MDAgU29DczoNCj4gPj4+IGFzdDI3MDBhMC1ldmI6IERl
c2lnbmVkIGZvciBBU1QyNzAwIEEwDQo+ID4+PiBhc3QyNzAwYTEtZXZiOiBEZXNpZ25lZCBmb3Ig
QVNUMjcwMCBBMQ0KPiA+Pj4NCj4gPj4+IFRlc3QgaW5mb3JtYXRpb24NCj4gPj4+IDEuIFFFTVUg
dmVyc2lvbjoNCj4gPj4+DQo+ID4+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29t
bWl0L2ZmYWY3ZjAzNzZmODA0MGNlOTA2OGQ3MWFlOWFlODcyDQo+ID4+IDI1DQo+ID4+PiAwNWM0
MmUNCj4gPj4+IDIuIEFTUEVFRCBTREsgdjA5LjA1IHByZS1idWlsdCBpbWFnZQ0KPiA+Pj4gICAg
ICBodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy90YWcv
djA5LjA1DQo+ID4+PiAgICAgIGFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neiAoQVNUMjcwMCBB
MSkNCj4gPj4+DQo+ID4+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVu
Ym1jL3JlbGVhc2VzL2Rvd25sb2FkL3YwOS4wNS9hcw0KPiA+PiB0DQo+ID4+IDI3MDAtZGVmYXVs
dC1vYm1jLnRhci5neg0KPiA+Pj4gICAgICBhc3QyNzAwLWEwLWRlZmF1bHQtb2JtYy50YXIuZ3og
KEFTVDI3MDAgQTApDQo+ID4+Pg0KPiA+Pj4NCj4gPj4NCj4gaHR0cHM6Ly9naXRodWIuY29tL0Fz
cGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjA5LjA1L2FzDQo+ID4+IHQN
Cj4gPj4+IDI3MDAtYTAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+Pg0KPiA+PiBUaGUgcGFydCBh
ZGRpbmcgbmV3IGZ1bmN0aW9uYWwgdGVzdHMgbmVlZHMgYSByZXdvcmsuIFNlZSBjb21tZW50Lg0K
PiA+Pg0KPiA+Pj4gS25vd24gSXNzdWU6DQo+ID4+PiBUaGUgSEFDRSBjcnlwdG8gYW5kIGhhc2gg
ZW5naW5lIGlzIGVuYWJsZSBieSBkZWZhdWx0IHNpbmNlIEFTVDI3MDAgQTEuDQo+ID4+PiBIb3dl
dmVyLCBhc3BlZWRfaGFjZS5jKEhBQ0UgbW9kZWwpIGN1cnJlbnRseSBkb2VzIG5vdCBzdXBwb3J0
IHRoZQ0KPiA+PiBDUllQVE8gY29tbWFuZC4NCj4gPj4+IFRvIGJvb3QgQVNUMjcwMCBBMSwgSSBo
YXZlIGNyZWF0ZWQgYSBQYXRjaCAyMSB3aGljaCB0ZW1wb3JhcmlseQ0KPiA+Pj4gcmVzb2x2ZXMg
dGhlIGlzc3VlIGJ5IHNlbmRpbmcgYW4gaW50ZXJydXB0IHRvIG5vdGlmeSB0aGUgZmlybXdhcmUN
Cj4gPj4+IHRoYXQgdGhlIGNyeXB0b2dyYXBoaWMgY29tbWFuZCBoYXMgY29tcGxldGVkLiBJdCBp
cyBhIHRlbXBvcmFyeQ0KPiA+Pj4gd29ya2Fyb3VuZCB0byByZXNvbHZlIHRoZSBib290IGlzc3Vl
IGluIHRoZSBDcnlwdG8gTWFuYWdlciBTZWxmVGVzdC4NCj4gPj4+DQo+ID4+PiBBcyBhIHJlc3Vs
dCwgeW91IHdpbGwgZW5jb3VudGVyIHRoZSBmb2xsb3dpbmcga2VybmVsIHdhcm5pbmcgZHVlIHRv
DQo+ID4+PiB0aGUgQ3J5cHRvIE1hbmFnZXIgdGVzdCBmYWlsdXJlLiBJZiB5b3UgZG9uJ3Qgd2Fu
dCB0byBzZWUgdGhlc2UNCj4gPj4+IGtlcm5lbCB3YXJuaW5nLCBwbGVhc2UgYWRkIHRoZSBmb2xs
b3dpbmcgc2V0dGluZ3MgaW4geW91ciBrZXJuZWwgY29uZmlnLg0KPiA+Pj4NCj4gPj4+IGBgYA0K
PiA+Pj4gQ09ORklHX0NSWVBUT19NQU5BR0VSX0RJU0FCTEVfVEVTVFM9eQ0KPiA+Pj4gYGBgDQo+
ID4+DQo+ID4+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHNlbmQgdGhlIGhhY2UgY2hhbmdlcyBp
biBpdHMgb3duIHNlcmllcyA/DQo+ID4+DQo+ID4+DQo+ID4gQ3VycmVudGx5LCB0aGUgSEFDRSBI
VyBlbmdpbmUgYW5kIGNyeXB0byBzZWxmLXRlc3RzIGFyZSBlbmFibGVkIGJ5DQo+ID4gZGVmYXVs
dCBpbiBTREsgdjA5LjA1IEZXLiBUbyBib290IFFFTVUgZm9yIEFTVDI3MDAgQTEgd2l0aCB0aGUg
U0RLDQo+ID4gdjA5LjA1IHByZS1idWlsdCBpbWFnZSwgYSBDUllQVE8gd29ya2Fyb3VuZCBwYXRj
aCBpcyByZXF1aXJlZC4NCj4gDQo+IGNhbiB3ZSB1cHN0cmVhbSB0aGUgSEFDRSBjaGFuZ2VzIGJl
Zm9yZSBoYXZpbmcgZnVsbCBBU1QyNzAwIEExIHN1cHBvcnQgPw0KPiANCg0KSSBzZW5kIEhBQ0Ug
cGF0Y2ggaGVyZSwgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2
ZWwvY292ZXIvMjAyNTAyMjUwNzU2MjIuMzA1NTE1LTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29t
Lw0KVGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gDQo+
ID4NCj4gPiBUaGUgQVNUMjcwMCBBMSBwYXRjaCBzZXJpZXMgaW5jbHVkZXMgZnVuY3Rpb25hbCB0
ZXN0cy4gVG8gbWFrZSB0aGUNCj4gPiBmdW5jdGlvbmFsIHRlc3RzIHBhc3MgZm9yIEFTVDI3MDAg
QTEsIEkgaGF2ZSBpbmNsdWRlZCB0aGUgSEFDRSBwYXRjaCBpbiB0aGUNCj4gc2FtZSBwYXRjaCBz
ZXJpZXMuDQo+ID4NCj4gPiBUaGVyZSBhcmUgdHdvIHdheXMgdG8gc3BsaXQgdGhpcyBwYXRjaCBz
ZXJpZXM6DQo+ID4NCj4gPiBTb2x1dGlvbiBBOg0KPiA+DQo+ID4gMS4gQ3JlYXRlIHNlcmllcyAx
IHRvIHN1cHBvcnQgQVNUMjcwMCBBMS4NCj4gPiAyLiBDcmVhdGUgc2VyaWVzIDIgdG8gc3VwcG9y
dCBIQUNFLg0KPiA+IDMuIENyZWF0ZSBzZXJpZXMgMyB0byBzdXBwb3J0IEFTVDI3MDAgQTEgZnVu
Y3Rpb25hbCB0ZXN0cy4NCj4gPg0KPiA+IFNlcmllcyAzIHNob3VsZCBkZXBlbmQgb24gc2VyaWVz
IDEgYW5kIDIuDQo+ID4NCj4gPiBTb2x1dGlvbiBCOg0KPiA+DQo+ID4gMS4gUGxhY2UgYSBwcmUt
YnVpbHQgaW1hZ2UgY2FsbGVkICJhc3QyNzAwLWExLXFlbXUtZGlzYWJsZS1zZWxmLXRlc3QiIGlu
IHRoZQ0KPiBTREsgdjA5LjA1IEdpdGh1YiByZXBvc2l0b3J5Lg0KPiA+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVhc2VzL3RhZy92MDkuMDUNCj4gPiAyLiBD
cmVhdGUgb25lIHBhdGNoIHNlcmllcyB0byBzdXBwb3J0IEFTVDI3MDAgQTEgd2l0aCBpdHMgZnVu
Y3Rpb25hbCB0ZXN0cy4NCj4gPiAzLiBDcmVhdGUgc2VyaWVzIDIgdG8gc3VwcG9ydCBIQUNFLg0K
PiA+DQo+ID4gQ291bGQgeW91IHRlbGwgbWUgd2hpY2ggc29sdXRpb24geW91IHByZWZlciBvciBj
b3VsZCB5b3UgcGxlYXNlIGdpdmUgbWUgYW55DQo+IHN1Z2dlc3Rpb24/DQo+ID4NCj4gPiBUaGFu
a3MtSmFtaW4NCj4gPg0KPiA+Pj4NCj4gPj4+IEphbWluIExpbiAoMjgpOg0KPiA+Pj4gICAgIGh3
L2ludGMvYXNwZWVkOiBTdXBwb3J0IHNldHRpbmcgZGlmZmVyZW50IG1lbW9yeSBhbmQgcmVnaXN0
ZXIgc2l6ZQ0KPiA+Pj4gICAgIGh3L2ludGMvYXNwZWVkOiBJbnRyb2R1Y2UgaGVscGVyIGZ1bmN0
aW9ucyBmb3IgZW5hYmxlIGFuZCBzdGF0dXMNCj4gPj4+ICAgICAgIHJlZ2lzdGVycw0KPiA+Pj4g
ICAgIGh3L2ludGMvYXNwZWVkOiBBZGQgb2JqZWN0IHR5cGUgbmFtZSB0byB0cmFjZSBldmVudHMg
Zm9yIGJldHRlcg0KPiA+Pj4gICAgICAgZGVidWdnaW5nDQo+ID4+PiAgICAgaHcvYXJtL2FzcGVl
ZDogUmVuYW1lIElSUSB0YWJsZSBhbmQgbWFjaGluZSBuYW1lIGZvciBBU1QyNzAwDQo+IEEwDQo+
ID4+PiAgICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBTb3J0IHRoZSBJUlEgdGFibGUgYnkgSVJR
IG51bWJlcg0KPiA+Pj4gICAgIGh3L2ludGMvYXNwZWVkOiBTdXBwb3J0IGRpZmZlcmVudCBtZW1v
cnkgcmVnaW9uIG9wcw0KPiA+Pj4gICAgIGh3L2ludGMvYXNwZWVkOiBSZW5hbWUgbnVtX2ludHMg
dG8gbnVtX2lucGlucyBmb3IgY2xhcml0eQ0KPiA+Pj4gICAgIGh3L2ludGMvYXNwZWVkOiBBZGQg
c3VwcG9ydCBmb3IgbXVsdGlwbGUgb3V0cHV0IHBpbnMgaW4gSU5UQw0KPiA+Pj4gICAgIGh3L2lu
dGMvYXNwZWVkOiBSZWZhY3RvciBJTlRDIHRvIHN1cHBvcnQgc2VwYXJhdGUgaW5wdXQgYW5kIG91
dHB1dA0KPiBwaW4NCj4gPj4+ICAgICAgIGluZGljZXMNCj4gPj4+ICAgICBody9pbnRjL2FzcGVl
ZDogSW50cm9kdWNlIEFzcGVlZElOVENJUlEgc3RydWN0dXJlIHRvIHNhdmUgdGhlIGlycQ0KPiA+
Pj4gICAgICAgaW5kZXggYW5kIHJlZ2lzdGVyIGFkZHJlc3MNCj4gPj4+ICAgICBody9pbnRjL2Fz
cGVlZDogSW50cm9kdWNlIElSUSBoYW5kbGVyIGZ1bmN0aW9uIHRvIHJlZHVjZSBjb2RlDQo+ID4+
PiAgICAgICBkdXBsaWNhdGlvbg0KPiA+Pj4gICAgIGh3L2ludGMvYXNwZWVkOiBBZGQgU3VwcG9y
dCBmb3IgTXVsdGktT3V0cHV0IElSUSBIYW5kbGluZw0KPiA+Pj4gICAgIGh3L2ludGMvYXNwZWVk
OiBBZGQgU3VwcG9ydCBmb3IgQVNUMjcwMCBJTlRDSU8gQ29udHJvbGxlcg0KPiA+Pj4gICAgIGh3
L21pc2MvYXNwZWVkX3NjdTogQWRkIFN1cHBvcnQgZm9yIEFTVDI3MDAvQVNUMjc1MCBBMSBTaWxp
Y29uDQo+ID4+PiAgICAgICBSZXZpc2lvbnMNCj4gPj4+ICAgICBody9taXNjL2FzcGVlZF9zY3U6
IEZpeCB0aGUgcmV2aXNpb24gSUQgY2Fubm90IGJlIHNldCBpbiB0aGUgU09DDQo+IGxheWVyDQo+
ID4+PiAgICAgICBmb3IgQVNUMjcwMA0KPiA+Pj4gICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5j
IFN1cHBvcnQgQVNUMjcwMCBBMSBHSUMgSW50ZXJydXB0DQo+IE1hcHBpbmcNCj4gPj4+ICAgICBo
dy9hcm0vYXNwZWVkX2FzdDI3eDA6IFN1cHBvcnQgdHdvIGxldmVscyBvZiBJTlRDIGNvbnRyb2xs
ZXJzIGZvcg0KPiA+Pj4gICAgICAgQVNUMjcwMCBBMQ0KPiA+Pj4gICAgIGh3L2FybS9hc3BlZWQ6
IEFkZCBTb0MgYW5kIE1hY2hpbmUgU3VwcG9ydCBmb3IgQVNUMjcwMCBBMQ0KPiA+Pj4gICAgIGh3
L21pc2MvYXNwZWVkX2hhY2U6IEZpeCBjb2Rpbmcgc3R5bGUNCj4gPj4+ICAgICBody9taXNjL2Fz
cGVlZF9oYWNlOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4+PiAgICAgaHcvbWlzYy9hc3BlZWRf
aGFjZTogRml4IGJvb3QgaXNzdWUgaW4gdGhlIENyeXB0byBNYW5hZ2VyIFNlbGYgVGVzdA0KPiA+
Pj4gICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MDogQWRkIEhBQ0Ugc3VwcG9ydCBmb3IgQVNUMjcw
MA0KPiA+Pj4gICAgIHRlc3QvZnVuY3Rpb25hbC9hc3BlZWQ6IEludHJvZHVjZSBuZXcgZnVuY3Rp
b24gdG8gZmV0Y2ggYXNzZXRzDQo+ID4+PiAgICAgdGVzdHMvZnVuY3Rpb25hbC9hc3BlZWQ6IElu
dHJvZHVjZSBzdGFydF9hc3QyNzAwX3Rlc3QgQVBJIGFuZCB1cGRhdGUNCj4gPj4+ICAgICAgIGh3
bW9uIHBhdGgNCj4gPj4+ICAgICB0ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZDogVXBkYXRlIHRlc3Qg
QVNQRUVEIFNESyB2MDkuMDUNCj4gPj4+ICAgICB0ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZDogUmVu
YW1lZCB0ZXN0IGNhc2UgYW5kIG1hY2hpbmUgZm9yDQo+ID4+PiBBU1QyNzAwDQo+ID4+IEEwDQo+
ID4+PiAgICAgdGVzdHMvZnVuY3Rpb25hbC9hc3BlZWQ6IEFkZCB0ZXN0IGNhc2UgZm9yIEFTVDI3
MDAgQTENCj4gPj4+ICAgICBkb2NzL3NwZWNzOiBhZGQgYXNwZWVkLWludGMNCj4gPj4+DQo+ID4+
PiAgICBkb2NzL3NwZWNzL2FzcGVlZC1pbnRjLnJzdCAgICAgICAgICAgICAgfCAxMzYgKysrKysr
DQo+ID4+PiAgICBkb2NzL3NwZWNzL2luZGV4LnJzdCAgICAgICAgICAgICAgICAgICAgfCAgIDEg
Kw0KPiA+Pj4gICAgaHcvYXJtL2FzcGVlZC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIx
ICstDQo+ID4+PiAgICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgICAgICAgICAgfCAy
OTEgKysrKysrKysrLS0tDQo+ID4+PiAgICBody9pbnRjL2FzcGVlZF9pbnRjLmMgICAgICAgICAg
ICAgICAgICAgfCA1OTMNCj4gPj4gKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ID4+PiAgICBo
dy9pbnRjL3RyYWNlLWV2ZW50cyAgICAgICAgICAgICAgICAgICAgfCAgMjUgKy0NCj4gPj4+ICAg
IGh3L21pc2MvYXNwZWVkX2hhY2UuYyAgICAgICAgICAgICAgICAgICB8ICA0NCArLQ0KPiA+Pj4g
ICAgaHcvbWlzYy9hc3BlZWRfc2N1LmMgICAgICAgICAgICAgICAgICAgIHwgICA1ICstDQo+ID4+
PiAgICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggICAgICAgICAgICAgfCAgIDMgKy0NCj4g
Pj4+ICAgIGluY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5oICAgICAgICAgICB8ICAzMiArLQ0K
PiA+Pj4gICAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9oYWNlLmggICAgICAgICAgIHwgICAxICsN
Cj4gPj4+ICAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2N1LmggICAgICAgICAgICB8ICAgMiAr
DQo+ID4+PiAgICB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkgfCAgNDcg
Ky0NCj4gPj4+ICAgIDEzIGZpbGVzIGNoYW5nZWQsIDk2MyBpbnNlcnRpb25zKCspLCAyMzggZGVs
ZXRpb25zKC0pDQo+ID4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zcGVjcy9hc3BlZWQt
aW50Yy5yc3QNCj4gPj4+DQo+ID4+DQo+ID4+IFBhdGNoIDEtOSBhbmQgdGhlIGhhY2UgY2hhbmdl
cyBjb3VsZCBiZSBtZXJnZWQgcXVpY2tseS4NCj4gPj4NCj4gPj4NCj4gPj4gSSBuZWVkICBzb21l
IGhlbHAgb24gcGF0Y2ggMTAsMTIsMTYsMTcuDQo+ID4+DQo+ID4+IEFuZHJldywNCj4gPj4NCj4g
Pj4gV291bGQgeW91IGhhdmUgdGltZSBwbGVhc2UgPw0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+
DQo+ID4+IEMuDQo+ID4NCg0K

