Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B24CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1biM-0003lZ-RT; Wed, 24 Sep 2025 22:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1bi9-0003iZ-Je; Wed, 24 Sep 2025 22:27:58 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1bi3-0003gV-U6; Wed, 24 Sep 2025 22:27:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBOhm2phJr5qBfXCOm3Fg4dBgQB3Q9KGNPZ6SCuv6Ctmc1Ly7q7uAkAW225tC8/GvzZhmqJZc17kDl+GnQICpYJ5q2ZIB3nTSUOzpgi9x9QUvWyLqjfNVHe7PpCWXkY5rXekKMYVx4u7zd1r8NLUAk5n6XbdtfSf1vKNpStWmASW2yJdUV75Ys1Msf87Qb6B3oaBYzAg0xqilEJnx5xsTJkL5/k7KmqX4IlR2X31F+uWMvLDSuY6q8BzRMwyZu/t56VFxsHhgf+6USzaIV2lg+8dlnBATKQkQUIzRrOSlAqESiLQ54Spvxcoaz6t7L08EMiLQi7rzYEGgswu8O4mMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4MLywOxp/795Y59HgkB7aLs+qUxl/L/rmXLxHWKsIk=;
 b=HXERq/lNnI6gE5XAb0ccYX9MP/wA9ArNHO8aZNgnQDeZeJgz9eRR1koAgOB14jyLp4Q8b/z407A5i/6deIzO1+36y6hFfqrtxKMsxu+oNJ16p1ZhHLsWTa0QBTBUbAXhZFA7cC4zo1TaKbdp/cg0HPazImgCHJSsAaJn/CYg6KWwKSQOtV1gmJnHFSd37R8hZje4oBPv9/pu8L/5wx5Orfeq6mMqI2PFvpUg8wyw6J9wlzPwJuFf0J7YvYcF1hVTnAcLrwcT3JJ78B8QdgiqyfATuMYJ826zcTH3j2Z1YjZvIRBNxXKNZk0v6KkEnmc8I5w8uy983NEcIwXfs7nYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4MLywOxp/795Y59HgkB7aLs+qUxl/L/rmXLxHWKsIk=;
 b=iOC4yt5PHWfZ95mMMVd/g4zCon4jbVNH9IkUSMZCMI8M1eCitZQ83EOFV75Lm0IA9ss5Fl0iH18ZPg6zvBRWgNBK3cMEVBpwHNXozAm3CINfAiQAqLNJWB2z6zCQQckkrluSvgpjzgEnVYq+0D5BxqW9KKS30mLb1LTnRdL2WpXhv1kX/ML3nFt75IRGi2ZB+g5fFmK6Zzg9PZFvwhrRETp+L69JsfUVyRrFyM5zt0OMbE0OdB+0GROjJIiHc3p6/huI7fQOcdCOn2I2UFCSuzx8d6JCKFZ70KYqQkxwUjLAJuIHZIMmHeMUg0vK+/+yUE67fqVJVIJDKfyZ0ZaWwg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5660.apcprd06.prod.outlook.com (2603:1096:400:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 02:27:39 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Thu, 25 Sep 2025
 02:27:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 6/7] hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents
 into CA35 boot ROM
Thread-Topic: [PATCH v2 6/7] hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents
 into CA35 boot ROM
Thread-Index: AQHcLRfw8vXqwUuPp0ucK0XrWs3fCbSiHsYAgAELN3A=
Date: Thu, 25 Sep 2025 02:27:39 +0000
Message-ID: <SI2PR06MB50417B26704FD2FAD0BB8105FC1FA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
 <20250924055602.294857-7-jamin_lin@aspeedtech.com>
 <eb5dc6d2-29d9-451e-9588-6a3de03a952e@kaod.org>
In-Reply-To: <eb5dc6d2-29d9-451e-9588-6a3de03a952e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5660:EE_
x-ms-office365-filtering-correlation-id: 5f4e871c-1e45-4e48-3500-08ddfbdb1945
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S0FxREd6ZXVnOHlVME8wbVFqVGRiSTNPUCtkRzFFMzlUWE8vOFo1bkF2OWVU?=
 =?utf-8?B?Zm45RUVXUS9SVmpwRlBXdS9YODBvODZsVnhBMExPbTJKNXNqYmp4cmFyN3dV?=
 =?utf-8?B?VlFUWDVTRXVPaVFvakx2bGJSblp6U25vRVBtRjd4Q2F2QTh6ejNZZzQrdFZM?=
 =?utf-8?B?VVpVSThwckxZOVU0Y1hTYnFHRm1rUTJ3N3ZPK3hGV0t5bi9JQmpvRURzQ1Ex?=
 =?utf-8?B?KzlZaTJYMWRCQTljZHl2Zy8yN3ZEZi9ZenRFY2NJMGxIL05Xb1VLNEJ0bE9O?=
 =?utf-8?B?Sk9DNXlVUEwyNTJ3Z3VPbUh2aWFZY3ArMlIzbTF2cmdkSE1IUzZlL2RRTzdN?=
 =?utf-8?B?SzIyRE5vclFVUXVQWGtCdFcwbWNtbFU4U3pxeHZZaXlRR3VOd0xoeVNLQ3Fi?=
 =?utf-8?B?VVJUOWN2NjFtSUNDeVkvek5aTHFoOER0UGlBd0hjVTZmV0p0T3RhSWIvTEVO?=
 =?utf-8?B?bEVSN0RzdUJOVjRBYVJadnBkMDl0Rjd0a2pVeUovVy9MaGNPNTJ6b2dsdmRq?=
 =?utf-8?B?ZWhBNi9EZW1qSmkvQXRzaVlSSFBkV2RIYUVTTTdwSDFVUGdIdFU5Q2Q3bUpM?=
 =?utf-8?B?Y2xCTnBxTXd5RC9nSWc4azl2SmZaNXMzUEpBYTBwamF5Sy9OdWJQSnVUTWxY?=
 =?utf-8?B?ZEhpa0NXeGp5MW5sd3RGU1B4SGFKNGZQWHhNOUpKUHRGcFJkdnR3OEN3anMr?=
 =?utf-8?B?Y24vQWxPWWZqclZYKzZ4R3dmRGkxZkl4Z2V5ZW9BY2pzdHBvczFQVEFXYzJn?=
 =?utf-8?B?Q2FaS1RKZUFaaUVIbVhVb3N5RFBaa3AwdmtJb2pUbEQrNUhGT3poYThrOWZM?=
 =?utf-8?B?THJBZkZHZUdHS2FzRk5ncGdFTzkxTElDTlVudGtIZzNhWEhZdlRJL0wrb1FT?=
 =?utf-8?B?UHl3VDVlUzRUM25Oc1h3eldnODNIOGtYbGo1djJFQk9CUzZOMWk2QklmTEw2?=
 =?utf-8?B?Q25LRHZIaUc0aDZnYWN3UnlabDRZRVlHalA0UUV3TlFEcHdIWTluTEpzVjBo?=
 =?utf-8?B?Um8yd003T2xBejdXcXFLS0diNWJaWE8zdGE0cVdkbE1FTmRLa1MvQVBNMkNP?=
 =?utf-8?B?c2VYTGtlcWd0YTB4Kyt6NDJoVzhpbE5iTlhTN0I0Sk85Lzc0VVc4MkhhTndi?=
 =?utf-8?B?c2p2YUVub21uRlFZZDRKNmo1cGllRGFicFlwQUNKQ2xrNElmUDRFeUFyMG1v?=
 =?utf-8?B?bzg5SGRIQkI4YlNzcXR3UlpraTV0Y3ltMmp2dFRHejhrSmJDeVk2dW96UFcy?=
 =?utf-8?B?WkZCMThyRWwvSW1uV1VzbjFGWVZ5VzRGNS9mWkVEdUpJOWphTVArMW1jazBI?=
 =?utf-8?B?WjNiQVI4M1AyUXlBck9lRStOS1BOY244NHQvNzNHYXBwak5iZGk0MUpBUzcx?=
 =?utf-8?B?NWZnMWVwU3kraHdweUFXYmNlUFVxTGh0UnFmTWF1REY0VzJXeUN2UHlPdVFy?=
 =?utf-8?B?SHdIcEI5TUpTckRibkpJWFhWelpTYU9CZmVnbEhiSEFCZUl6R1p0dkpodGwz?=
 =?utf-8?B?QUpoU0IraFQ0YUJPOHdGUnY1QkFvRmo4MjhPKzFDMm5WRHZVVzBWakwzYndR?=
 =?utf-8?B?bmtqVVVsaE9IeGhxYWh3dXdXaStXVVlpNkJIQ0pmWlZyT1NmMkhISkI2N0xO?=
 =?utf-8?B?ZnMyZWZYbXkzWUhKSVlUUXcwRmFHSVRNbFRxRGRQd2hVanN2U2drb2prb1Z5?=
 =?utf-8?B?RVpnZ0xKWkNKTTA2d0Q3eC9hS0JKUjl4TlJCT1F3a0R6SS9vNElmaytSVEdE?=
 =?utf-8?B?dUxaTWVUdm1RY2JpWjFmRXIxNUFnc0dpVEpQZXZKTHhiSVhoNFdYYkhzVy9u?=
 =?utf-8?B?MnBHZnBtRytIbVBVNFM1SitNY1F0RUIrQmpWQzFHbmJqa3hEZ0VOWWt0MWpj?=
 =?utf-8?B?SnFidDUyUzcxTlRMdWJwekoxRGcvVERYYnRibmNYendvc094R2tFU3laL2lQ?=
 =?utf-8?B?Tmk4N2NuM2lBSnBzNEpRME5NWVRNRG9lYU1VbnErSnVWV1E1TGJSM1haSjlP?=
 =?utf-8?B?SXVTckVCSkp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUpQOHFUTXphKzM4RGRJaVUwTG1OWXo5QVRqb1NTM0UxeHlQY3o0MCswdG1x?=
 =?utf-8?B?d0FiTG93dDVPQkxMd1hoOXByVEVMa3dWNTUxaVJRVDcvQmtHdU95L25zdHlF?=
 =?utf-8?B?TmtlM2xmbzRPWStWTVorUU1jZlJqMzdWS08ra2dqa2RkU2c0L0FCL0tCSnVO?=
 =?utf-8?B?akpzQldtWmxhWHUzTFJJZWthZmFWVEhBNTE4dS9GeFFtSCtqVlQ1YVFjS09n?=
 =?utf-8?B?c3ZPVS83QnozUnp6ZXBXbXFTM0tENXlJQVI3cXFSaC9CSjEveXFNelZOdE81?=
 =?utf-8?B?SDVraU5VTEc4MktkVmZWRXFIb1FOcHFoQ0tDK29yNXBsd2N4MG96V3FyQUxn?=
 =?utf-8?B?R1pucmVRS3VGUmlwVnc3MFlEZnhqRjhoanh6MHk2UmJJaTl4RlFSS29Oc2Vu?=
 =?utf-8?B?U0hZU04weGExNkZvUVhFMVZqbmxWTEN4eHVURUdwVnhRNnlrU0JuRVZVTTlr?=
 =?utf-8?B?cGppd29vUkYvbFBiTk5Eb0o1UjdRUkNya0k4VHgzOFNMTkFnNDNkd1h6NURL?=
 =?utf-8?B?NGphem82dm4vTzc3NzRaSkllTW52a0d5RE54N25MaDRNU2VoMlJNcGhRbWlu?=
 =?utf-8?B?QXFEeVZGM2VWMEQ4MXZvVFRkYW4vWnNZYlA0NHJUeHo1QzZmMTdHVG9QWEpC?=
 =?utf-8?B?azl0d2dpTWlJTXFKWFI0UTdjZURVNExhVW1yL3JmVHM3amdiaGhqOUFFNXBW?=
 =?utf-8?B?ZWxNT2YvWmZISGlid1phMHNDY25acHhGTjA0UG9VMERLb0ZYTG11bFhrWXNJ?=
 =?utf-8?B?enhjeFZCWENleDAxTE5pdnhlN2c3N2hRbjlXblZXVUMwbUJaUlM3UlA0VFQz?=
 =?utf-8?B?bDlzVnB0cGNwOVhTeFI3WitWOWh0MXNvTXF4TTEveXhyKzFycTVyTXY3MFAy?=
 =?utf-8?B?aTBsNnY2YU1FQWJVTzZCK1RXeU43bG0yRHoxVGpmL3g2bU44MjJoOURTMStB?=
 =?utf-8?B?NS9nRkRCZ1hwczJYMnBBMjZEcmg3eGR4ZXJVdENacVp0SnV4NUdhLy9rQ2pl?=
 =?utf-8?B?U3lzbllwM1ZuWkl6ek9TVCszMGJsd0MzQUJUNzIrSFpGcHBWblJRWmV2bm5U?=
 =?utf-8?B?eFB4dDR6TWJTdHZvWHYxd1hJS1NTUHlrUGFaNENTMzFrQmZiNG5iRHZ3bGRM?=
 =?utf-8?B?OEhvbFJ3UlZscllNdnMwV1I0N2ExVGxIMUFPQndaSG9CQ215YUNxWS9adWRy?=
 =?utf-8?B?WWo3U01uYTB0MStaSldqWDVKQTRPc0dPdER2YlRrNElYUTdlMEtLcFliNzBF?=
 =?utf-8?B?ekcrQ21reE5XTFZpcjJ0WjlLTVhRNmhuMlJSVWo4Zllrd1NOK0h3dCtMdTgr?=
 =?utf-8?B?MWVMM1FmRTdnQmhmcktFYkdWYkhxMC9OZmk5VzhKUERwZGZKUmJTN2xuaDl2?=
 =?utf-8?B?dmRQVGhNNnlkNmlwb3JUU1RwZWRKaUhGK21hM2FjbXZUZmMwbyt0dExzaGl0?=
 =?utf-8?B?dkZBN0pLdnNKUnMwMlI1Z1l1Nm1TRWdOVVVwVjFBbkduQVJrb2JXbG1XMTVQ?=
 =?utf-8?B?SXB4RUdRNTBtSGdnVkVXMjFlRExsT21MeXAxOSsyeUpXZ3liRjZaa09lYzNj?=
 =?utf-8?B?RVdwR1I5R0JPSXRMaGlUTHM3OXc5VU5RLzB1N3NrRzlYWTFwK2pwMGU4dHNw?=
 =?utf-8?B?bDBnTkFpSElSY3k0eHlLVkhTSzVxcWJVSkhQbENEYUU5dGNMVkZJOEJhNHhO?=
 =?utf-8?B?VUltRXhZYTBHem50dWp4L2xQNTdadTM5MTJwOFF2RCsvcldVSkxnTmVmSzI5?=
 =?utf-8?B?RGcwcW9BNnNUcUFQYkVIdjBia0lHWityWlhnSVlITkVtcVpmSTROcDlNNS9F?=
 =?utf-8?B?TjZiTVdkc3Fja2UvVUtvYzBuZmdma3NjUk8ramxPQkgxVG40WW5sdEFwZmlh?=
 =?utf-8?B?S0NJN05RL1VPbWphK25KM2V6akEzbFl3WENKYmFBSzJPT3dVbGNTV0g1RDJl?=
 =?utf-8?B?Rk1uamxMNDhFWjlvVWNWbEEvWXZYS3VNS1c2bzdhdVpNRG15c096YXZBOXVB?=
 =?utf-8?B?cjZ2eWM0aDh1K1ZFMjRLdEhFcGR0bEg0Rm1KVHFKRFVvclUyZ2gvZm5QVzY5?=
 =?utf-8?B?dGlHaHNHaGpFalA1c1gzNHlUakx3MVRqbnF6dzJVTGpTNUtGbjVqQXhabWI3?=
 =?utf-8?Q?f4alpQNTH/lPbv6w0xW5f7JRq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e871c-1e45-4e48-3500-08ddfbdb1945
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 02:27:39.6801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcO5j5z9XuGYGuVpRBKD2lrNlvqAhukgTh14dR34UpIsIAkaKkWILN5kkWn4oByYHCCU3KskcFrk/wN9AKQWlaAu8QzmnGFK1n81bBkpPNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5660
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNi83XSBody9hcm0vYXNwZWVk
X2FzdDI3eDAtZmM6IE1hcCBGTUMwIGZsYXNoDQo+IGNvbnRlbnRzIGludG8gQ0EzNSBib290IFJP
TQ0KPiANCj4gT24gOS8yNC8yNSAwNzo1NiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoaXMgcGF0
Y2ggaW50cm9kdWNlcyBhIGRlZGljYXRlZCBjYTM1X2Jvb3Rfcm9tIG1lbW9yeSByZWdpb24gYW5k
DQo+ID4gY29waWVzIHRoZSBGTUMwIGZsYXNoIGRhdGEgaW50byBpdCB3aGVuIG1taW9fZXhlYyBp
cyBkaXNhYmxlZC4NCj4gPg0KPiA+IFRoZSBtYWluIHB1cnBvc2Ugb2YgdGhpcyBjaGFuZ2UgaXMg
dG8gc3VwcG9ydCB0aGUgdXBjb21pbmcgVkJPT1RST00gLA0KPiA+IHdoaWNoIGNhbiBkaXJlY3Rs
eSBmZXRjaCBkYXRhIGZyb20gRk1DMCBmbGFzaCBhdCB0aGUgU1BJIGJvb3QgUk9NIGJhc2UNCj4g
PiBhZGRyZXNzICgweDEwMDAwMDAwMCkgd2l0aG91dCByZXF1aXJpbmcgYW55IFNQSSBjb250cm9s
bGVyIGRyaXZlcnMuDQo+IA0KPiBUaGF0J3MgdGhlICdleGVjdXRlLWluLXBsYWNlJyBjYXNlIGJ1
dCB0aGUgcHJvcGVydHkgYWN0aXZhdGluZw0KPiAnZXhlY3V0ZS1pbi1wbGFjZScgaXMgYWx3YXlz
IGZhbHNlIGluIHRoaXMgbWFjaGluZS4gQ291bGQgeW91IGV4cGxhaW4gd2h5DQo+IGJvb3Rpbmcg
ZnJvbSB2Ym9vdHJvbSBuZWVkcyB0aGUgZm1jMCBjb250ZW50cyB0byBiZSBtYXBwZWQgaW4gbWVt
b3J5DQo+IHRvbyA/DQo+IA0KVGhlIG1haW4gZ29hbCBvZiB2Ym9vdHJvbSBpcyB0byByZXBsYWNl
IGJvb3RtdWMgKFJJU0MtViAzMikuDQpPdXIgY3VycmVudCBib290bXVjIGZpcm13YXJlIGlzIFNQ
TC4NClRoZSBTUEwgcmVhZHMgZmxhc2ggZGF0YSAoaW1hZ2UtYm1jKSB2aWEgRk1DX0NTMCBhbmQg
bG9hZHMgdGhlIGZvbGxvd2luZyBjb21wb25lbnRzIGludG8gZGlmZmVyZW50IERSQU0gYWRkcmVz
c2VzOg0KVHJ1c3RlZCBGaXJtd2FyZS1BDQpPUC1URUUgT1MNCnUtYm9vdC1ub2R0Yi5iaW4NCnUt
Ym9vdC5kdGINCg0KQWZ0ZXIgbG9hZGluZywgaXQoQk9PVE1DVSkgcmVsZWFzZXMgdGhlIENBMzUo
UFNQKSByZXNldCBzbyB0aGF0IENBMzUgY2FuIHJ1biBUcnVzdGVkIEZpcm13YXJlLUEuDQoNClRo
ZSB2Ym9vdHJvbSBwZXJmb3JtcyB0aGUgc2FtZSBzZXF1ZW5jZTogaXQgcmVhZHMgZmxhc2ggZGF0
YSAoaW1hZ2UtYm1jKSwgcGFyc2VzIHRoZSBGSVQgaW1hZ2UsDQphbmQgbG9hZHMgZWFjaCBpbWFn
ZSBpbnRvIGl0cyBkZXNpZ25hdGVkIERSQU0gYWRkcmVzcy4gRmluYWxseSwgaXQganVtcHMgdG8g
VHJ1c3RlZCBGaXJtd2FyZS1BLg0KDQpodHRwczovL2dpdGh1Yi5jb20vZ29vZ2xlL3Zib290cm9t
L2Jsb2IvbWFzdGVyL2FzdDI3eDAvaW5jbHVkZS9pbWFnZS5oI0wyMQ0KaHR0cHM6Ly9naXRodWIu
Y29tL2dvb2dsZS92Ym9vdHJvbS9ibG9iL21hc3Rlci9hc3QyN3gwL2ltYWdlLmMjTDMwIA0KaHR0
cHM6Ly9naXRodWIuY29tL2dvb2dsZS92Ym9vdHJvbS9ibG9iL21hc3Rlci9hc3QyN3gwL2ltYWdl
LmMjTDQ1Nw0KaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZS92Ym9vdHJvbS9ibG9iL21hc3Rlci9h
c3QyN3gwL2ltYWdlLmMjTDQ4OC1MNTA1DQoNClRoYXQgaXMgd2h5IEkgbmVlZCB0byBjb3B5IEZN
QzAgZGF0YSBpbnRvIHRoZSBpdHMgbWVtb3J5IHJlZ2lvbiB0byBtYWtlIHZib290cm9tIHdvcmsg
Y29ycmVjdGx5Lg0KDQo+IA0KPiANCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2Fz
dDI3eDAtZmMuYyB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4
MC1mYy5jIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4gPiBpbmRleCBiMTVjYjk0YzM5
Li4yZTYwMzZiMTkyIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5j
DQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4gPiBAQCAtMzUsNiArMzUs
NyBAQCBzdHJ1Y3QgQXN0MjcwMEZDU3RhdGUgew0KPiA+DQo+ID4gICAgICAgTWVtb3J5UmVnaW9u
IGNhMzVfbWVtb3J5Ow0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBjYTM1X2RyYW07DQo+ID4gKyAg
ICBNZW1vcnlSZWdpb24gY2EzNV9ib290X3JvbTsNCj4gPiAgICAgICBNZW1vcnlSZWdpb24gc3Nw
X21lbW9yeTsNCj4gPiAgICAgICBNZW1vcnlSZWdpb24gdHNwX21lbW9yeTsNCj4gPg0KPiA+IEBA
IC02MSw3ICs2MiwxMCBAQCBzdGF0aWMgdm9pZCBhc3QyNzAwZmNfY2EzNV9pbml0KE1hY2hpbmVT
dGF0ZQ0KPiAqbWFjaGluZSkNCj4gPiAgICAgICBBc3QyNzAwRkNTdGF0ZSAqcyA9IEFTVDI3MDBB
MUZDKG1hY2hpbmUpOw0KPiA+ICAgICAgIEFzcGVlZFNvQ1N0YXRlICpzb2M7DQo+ID4gICAgICAg
QXNwZWVkU29DQ2xhc3MgKnNjOw0KPiA+ICsgICAgQmxvY2tCYWNrZW5kICpmbWMwID0gTlVMTDsN
Cj4gPiArICAgIERldmljZVN0YXRlICpkZXYgPSBOVUxMOw0KPiA+ICAgICAgIEVycm9yICoqZXJy
cCA9IE5VTEw7DQo+ID4gKyAgICB1aW50NjRfdCByb21fc2l6ZTsNCj4gPg0KPiA+ICAgICAgIG9i
amVjdF9pbml0aWFsaXplX2NoaWxkKE9CSkVDVChzKSwgImNhMzUiLCAmcy0+Y2EzNSwgImFzdDI3
MDAtYTEiKTsNCj4gPiAgICAgICBzb2MgPSBBU1BFRURfU09DKCZzLT5jYTM1KTsNCj4gPiBAQCAt
MTE5LDYgKzEyMywxNiBAQCBzdGF0aWMgdm9pZCBhc3QyNzAwZmNfY2EzNV9pbml0KE1hY2hpbmVT
dGF0ZQ0KPiAqbWFjaGluZSkNCj4gPiAgICAgICBhc3QyNzAwZmNfYm9hcmRfaW5mby5yYW1fc2l6
ZSA9IG1hY2hpbmUtPnJhbV9zaXplOw0KPiA+ICAgICAgIGFzdDI3MDBmY19ib2FyZF9pbmZvLmxv
YWRlcl9zdGFydCA9DQo+ID4gc2MtPm1lbW1hcFtBU1BFRURfREVWX1NEUkFNXTsNCj4gPg0KPiA+
ICsgICAgaWYgKCFzLT5tbWlvX2V4ZWMpIHsNCj4gDQo+IGJvb2wgJ21taW9fZXhlYycgaXMgYWx3
YXlzIGZhbHNlIGluIHRoaXMgbWFjaGluZS4gU2hvdWxkIHdlIGtlZXAgaXQgPw0KPiANCg0KV2ls
bCByZW1vdmUgaXQuDQoNClRoYW5rcy1KYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4g
DQo+IA0KPiA+ICsgICAgICAgIGRldiA9IHNzaV9nZXRfY3Moc29jLT5mbWMuc3BpLCAwKTsNCj4g
PiArICAgICAgICBmbWMwID0gZGV2ID8gbTI1cDgwX2dldF9ibGsoZGV2KSA6IE5VTEw7DQo+ID4g
Kw0KPiA+ICsgICAgICAgIGlmIChmbWMwKSB7DQo+ID4gKyAgICAgICAgICAgIHJvbV9zaXplID0g
bWVtb3J5X3JlZ2lvbl9zaXplKCZzb2MtPnNwaV9ib290KTsNCj4gPiArICAgICAgICAgICAgYXNw
ZWVkX2luc3RhbGxfYm9vdF9yb20oc29jLCBmbWMwLCAmcy0+Y2EzNV9ib290X3JvbSwNCj4gcm9t
X3NpemUpOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICAgYXJt
X2xvYWRfa2VybmVsKEFSTV9DUFUoZmlyc3RfY3B1KSwgbWFjaGluZSwNCj4gJmFzdDI3MDBmY19i
b2FyZF9pbmZvKTsNCj4gPiAgIH0NCj4gPg0KDQo=

