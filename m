Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C104BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGJ-0003vC-7h; Thu, 30 Apr 2026 10:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wIRkz-0006y4-B4; Thu, 30 Apr 2026 09:48:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wIRkv-0003Zy-Jd; Thu, 30 Apr 2026 09:48:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs1wUVsVEpF0xwm44nPtLAKm2Sh/PYzpmuSv1kqcwOAc/EEP9H67mP0jsKI0rJMlwGBv9Xk3xKxzauUIGPiiET/88PpzO+O/zgec4I/5EQJWxKXEK9nFMLmHBxmQn12Og4LovVP/95gOM0IsPm/J95JwOq+0P9Fi5QaNrmX0+JCgYuK4YP/97kgYSE6ECI0ge1nRwpgqkH6jaZ8wEyvpUhCANrw7lPK9QKjLCHXtPAOrTMpCMoiqBzqTR1cyKHgsy0tFh4uveyLMIPILWdeZ9IHUuA+ta1yyZN4owN/rKtspmG8RoCV+4hXhIYHnIP3e4HRvEDmsNF5yQtZqaHxd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6/4LtJ2N4hmLz6zgwDmQ5RldU/XB3v4fF/B0k7c+X0=;
 b=OyNzt+gMmGp0KnQA8ujNKMjGuZDoWS0OBGixHQLbO9eENrA0sqgW9krOiJ1AO4sUmsleImcCmXyTPyJsry4Mi49RC2w4LZ1dlgRN9SR+oc8wc4VP3BcLhHlkrM24T2ljL8kXiyNjwCO/9apY7m1pbKRdXvOtJc9m8+1wshMriv9A+2kMfG6qHN73WJu8BXoOa6PJu6/1vzD03t0jtB4htHEo+1GGn4dAzyC9Uhu8u+bJOigu1Z130pZQ7C6HzLfQkyuaa2nRYsYmhnpzvjB70NoT8kSNK9iY3GGWCXeB6cEKzUHgggm63JG7ViDpuouBDi9uspqX/Tbm0qJ3P9cw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6/4LtJ2N4hmLz6zgwDmQ5RldU/XB3v4fF/B0k7c+X0=;
 b=kQyLsypp7LR26sqbnKczg8UIHoQLpU3udK8hNgfNwFeKjWFAuH3efO4C2gzkw13VuqViAaP1JmPLrphNU6NV/BX1UERzyi70oB5uJy99xblF/sm+uYq7VT/b23mOwsgNVq05Vixir2hZjQ/QsT0t6T8IFGZndacERIk2o8wn5KTHBE0MLhG0sBKXNiHFE15MwCG0FFIf+gNnYur7LJ/pny4OfOEwvLYK1vYIPaADQqNxm0g4loYqQtkw6n7gUZJYRPDQgJ2erLll+/s+GNhApO/WjxehGS/SC38XkA68krlFETnCiHL7ZtOD94Aw+7DPDVRvI7/NHIL+5oIrYpm+Iw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by JH0PR06MB6937.apcprd06.prod.outlook.com (2603:1096:990:65::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 13:48:23 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 13:48:23 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?gb2312?B?Q6imZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, 
 =?gb2312?B?Q6imZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
Subject: =?gb2312?B?u9i4sjogW1BBVENIIHYxIDEvMV0gaHcvbWlzYy9hc3BlZWRfc2JjOiBBZGQg?=
 =?gb2312?Q?bounds_checking_for_OTP_write_operations?=
Thread-Topic: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
Thread-Index: AQHc1tNDVtPV7xe+NUODvFad+2ZigrX3dGEAgAAtSg0=
Date: Thu, 30 Apr 2026 13:48:23 +0000
Message-ID: <SI6PR06MB76311242178B0118E07A1368F7352@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260428055254.76581-1-kane_chen@aspeedtech.com>
 <20260428055254.76581-2-kane_chen@aspeedtech.com>
 <CAFEAcA8i+v_7KVPBMHGkjf=tuGuVCW_d-XUBb1cr-ezmD_F7xg@mail.gmail.com>
In-Reply-To: <CAFEAcA8i+v_7KVPBMHGkjf=tuGuVCW_d-XUBb1cr-ezmD_F7xg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|JH0PR06MB6937:EE_
x-ms-office365-filtering-correlation-id: c504b6de-a44b-4651-752d-08dea6bf257f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|13003099007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: z9M3RAtssjbgaS/paMp7a4zwRqX8D6b/TG1NMAmiVlWQwD4cdPItKswSF/Tlu8j+UMe8Ijl6lWhCevfUbtsFa/vsUqsk5nlKHfVfH1SX9rTHilQpGcxyNBKZETxcUh1JdoSrlZnFxMB4EBvMgOrGJvzUBu28lX2qmel9todNzRdeaAxTbPkMRAITeDZvPgL6iioVadcbM8SDV/XL7RS8zdq9P2eYLM5SjndD2H/3SncZp+qIVj7i7k0U37jYmkOEwyYErqfWDBsbiUEqaqU64V61AVMOdg9mJ+PC0hNteJSvRuZMmmIzCsc9C2YociMUn7zZRXZUW+Zk1uG28FNo05X/oQkob1XWGILWAGYcgyOuqXPjQYc4HlRSrDnybT1zzahtgmoJum5oVCIVajnzLwdFJr9b5EBRA7F8y6wBAfFdn1SjZAz3RGhpXbIdCHWt94ZdeSIMneP4Siki2OEqck6hyO8q/lPNUqVbTtGoQKe1AF3+l7wR85ObsBDXUNuW7O+RiqdbxpfUrYFMg0lBqIKcnW/FlVU/ZoSb1WFf2wgEAhUu/pS6g9kke4FGwLptQiQ/kkEvqeODz1dlAnL2ZYBuwHsDR3JZmreggEs88LjwAVQ2Opkh84A4uEBoduAN75nLnCxttw5bp3+ohmOB0sgT5SP8bHeoASuoUB63jAXA7H1zMKIeaUjNDJjggWZq0W2JTmWYTmYvxZRRV4IMeCdOO4sVfhz7kYaUHIQxASUyp6GTJNXAYnZ92bUb3a7BFDzlfK9dq//5Brw02wCOO4PPNSZqhGZw8EwkoU/Y/Ds=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(13003099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Wmw3L1pkOG9FMmVJbjFMYitlYXNnNzN6d2ZoZ2lFbG91ZnZiK2FPdDRGbHB5?=
 =?gb2312?B?NmQzUFJkbmliSW5LT1JsY2EzZkk1WXBJVzhIcHlWeHBrMkltNVZpVkFmdmw5?=
 =?gb2312?B?NDkxeDBTQk4zZXZMWXRCbC9TL2gyck82aXhFYW9OeXMwRXcxcmFjUVA4cWVC?=
 =?gb2312?B?RHVPK2ovMmZjdVR4MmphVnQza0xjS2JhVkJQaUIvbnVON1MxZFlsUlR2TCto?=
 =?gb2312?B?ejA5Um82Z2dUMndGcXZiUElNbGhFNUtFcFFsOWJwOUJUbkJkYzZnYTdNTFdG?=
 =?gb2312?B?TUF1dnE0TnBXcG90WDlFTVBnMU16OUFkaG5yYVRNNm8zZFB6dnRIeW1ZT3B0?=
 =?gb2312?B?QzdIUlgwcCtqbndEWmlHbG1BS3BKQVE0bUR1bFppR0tSRUpDUWM4clNyVFgz?=
 =?gb2312?B?YVJXQWlOcUszemY0OFk4aTgwM3VWakJIOUNQVzhqaXp1UHFKNURnWk9lL0pI?=
 =?gb2312?B?Z3lCemc3RHRWUWQ1VXdOTjBsVDNpSGdYbTRoUTdxd1dMVmY3M0piUno0NStT?=
 =?gb2312?B?UWZ4N1ZVVmg0YWNIUEFmN01qSFk3cDBFWnVSdzVpOTZBR0ZKKzBSSkUyYUUz?=
 =?gb2312?B?WDdhcUx0VCtsMmI4KzdQMmNFVjJMcTBIdUtzK2phZjRjNWNDa1czWHkrWTJy?=
 =?gb2312?B?OHJqSDljcERLdWpBVFhSRkRNNzVxRnJzTkx3M0pHVzRVdnhQK3l3eUcyTFF3?=
 =?gb2312?B?bmFBaWMySzJPcDVJcC9oNFE0eEl0RzhMM3VEVXRLRnpEWE54S2xXWCt6MmJU?=
 =?gb2312?B?Q0F2REd2ckVjeDV0M1BlYWM0Tk4wUUhqV0JHUmVod2pkUjdwRXlVUTlFTXRS?=
 =?gb2312?B?QXFCMWtGZW5neFNya0NPUGozdDIwa0c5NWFrVXZvSDFJNEZlUVFZandrYUhs?=
 =?gb2312?B?cHFETEdyNTVqem9DQW55MlVwRUQwdWVwcFBJRjlndjEzbkllTm54S0lDWHJ6?=
 =?gb2312?B?OUtESWpIS0VSQkxaakpid0dUZ3JFNDZTMkxjYmg4QlBvMGRodmJTdHI5d0dq?=
 =?gb2312?B?OHZuaXBpQXYraGhSRkZ5dGt4K0tsaTNoNVJpanZ3SnpvdFpta1I3UFpIazQ5?=
 =?gb2312?B?c1M2cEZJZDQvNUJwbGxqaDB6T0wxeU5wdVJvUzRMT2FGMERvVEd3STNHVlll?=
 =?gb2312?B?SFFYcTRheDZSU2thYjVBakpyc21MQW82WmEya1NsS3p3YVdSUXVsSlFoOGk1?=
 =?gb2312?B?OHlDSklZSVgyM1VIMGR4N0lGTWkvRThGVU9WQWJGVi9Ma280Y0lhckx3Q2w5?=
 =?gb2312?B?OXR4WVhjQ1FlQlhnVThHRytYODJwbmhXYWJPTDNoeE5VbHhjTnEzM3ZNZXR6?=
 =?gb2312?B?OGF6RDJFQS9JcFo5Ylluc0hPb2ZDcWs2Sk94cFlkd042T0JNSVZ0VEs2Nm41?=
 =?gb2312?B?YTcvb3RzSzdGRWpWUTRXM280VFJ3WkJqR3A5YUlvdE1RREY5RnJqM24vdDhh?=
 =?gb2312?B?Z1BaY1VnVExoamdMaWFMSGVEVW92eXgwRllmY01HTjlYckJ0N2tqV1Rmendp?=
 =?gb2312?B?d2tjMk96SXVvYVdpS3k5aExXV1p2MmpyUGU4WGYzZ1ZCSi9SS3ZoOVlKLzhM?=
 =?gb2312?B?RzY1ZElmQkpzYWtZRlE1WEpZTGw0blpLV1BaVHpKZVo2aE12bjFhWDg3S2w2?=
 =?gb2312?B?Y3VLREFDYU9oNERDSmh5MTJUdW1NMGhJeVAzOVlFVHp1dUVqbE9tcjliYzk2?=
 =?gb2312?B?c1p4RXE0OFN6SHF1TnJpdnppRS8xbDF4WGEvVWFTVXROYWpjYy9PNjlvMWND?=
 =?gb2312?B?c1o0ZUJ3R3d6TnFkTzYwSndIb2cyU3ZKdHBJMTVIbnhnaFZacFZJWmU4akpX?=
 =?gb2312?B?Z1J5NTdnOSttV2NZaDgvc1RtNm9yQ1hwVW9UVHEvbER2bkNwcGkxN1hSNE9Z?=
 =?gb2312?B?SkdUS0JCdVduUlREbHFBSU5BNDZ0ZnZ4L3EybjRscGJlUHpKbTYxQ3hZVVYr?=
 =?gb2312?B?SzZRN2lzMzJVaGtsQ01icGNGa09KSUliVURQSHBxVE0xbjl5QjA1eCtyVExo?=
 =?gb2312?B?aG5RajhvM2dIM0R0VEFRNHhVb2NkYU1ZRlVmWno3VFpHOWdMUVIvdndRTjBW?=
 =?gb2312?B?d1ZMZ2lNTWpwcHhpSk9xYWNiVThLVnE3UzBvY1VmdkFlTG5WcDFiZlNrVmQ1?=
 =?gb2312?B?UStwSXVheTV5a1BYSThRSm5RZ2F3dGVZNXFRQ3NtL0ozRS9keWlpb2ZHcTZk?=
 =?gb2312?B?cUZWS0dlVlY2L01qVmQvc1lsd2dSU0dGdjRFTmJLeEFTcWtOSTBSTDVodEND?=
 =?gb2312?B?UW9uZkE0VmZQcWFrODM0T0pKelpTZE9WdnhFTWIzcUZ6MVhsaG1PcUhFY1Z3?=
 =?gb2312?B?UTQrbC85TXNIclNidWRzUUNOcVpXb2tBUTBMcHVuMnhNTStrcTBVdz09?=
Content-Type: multipart/alternative;
 boundary="_000_SI6PR06MB76311242178B0118E07A1368F7352SI6PR06MB7631apcp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vxTH+QHzJkzirdjG2RifPGHqASKgjWYDwqjlJiRJYtYsgFgT1L1nXLDPGTPD9DTOYk9umsK1h2U4b0TI1sl1+oGnIlPini1bydmjvTv512cmGgvr/rvwuikzLojdvBr+uHCnWJ2pnj/Z/aHUqsqZzL3bvUejkoZqXS8jA1pPhrbbrFTfk5XxkQTLm/O1iQjM8ZgFEhR5zWtX+NCXfrQb2qJzweGfIvUi0Pb+Chk9vmdFhDK8+RftdZAZNYr30jXZ4ACm6sMwSHJvxhqkgjgwM93ri9o9+Ir82AwxeGj1Mib4Um1hrSsoZF2ZbyfZQE4/sRSBKcg6a4+V/yNMLpQ55A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c504b6de-a44b-4651-752d-08dea6bf257f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 13:48:23.0852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZZ4JmPYnUIGxCLkrOn1PtZ1+HqT8ABW3Px3cDJswUCq6LC+Pr7+K33ZTCktD4utO/VjrvaMhG7kE/sxG0x2e8VPnkTrcn3pCko1qtDsEVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6937
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: 36
X-Spam_score: 3.6
X-Spam_bar: +++
X-Spam_report: (3.6 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_SI6PR06MB76311242178B0118E07A1368F7352SI6PR06MB7631apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgUGV0ZXIsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIGZlZWRiYWNrLiBJIHdpbGwg
dXBkYXRlIHRoZSBsb2dnaW5nIGFjY29yZGluZ2x5IGFuZCBzdWJtaXQgYSB2MiBwYXRjaC4NCg0K
QmVzdCBSZWdhcmRzLA0KS2FuZQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCrzE
vP7V3zogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KvMS8/sjVxto6
IDIwMjbE6jTUwjMwyNUgz8LO5yAwNzowMw0KytW8/tXfOiBLYW5lIENoZW4gPGthbmVfY2hlbkBh
c3BlZWR0ZWNoLmNvbT4NCrixsb46IEOopmRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyBT
dGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBMZWUgPGxlZXRyb3lA
Z21haWwuY29tPjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcg
SmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2Vs
QGptcy5pZC5hdT47IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47
IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBU
cm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBxZW11LXN0YWJsZUBub25nbnUub3Jn
IDxxZW11LXN0YWJsZUBub25nbnUub3JnPjsgQ6imZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQu
Y29tPg0K1vfWvDogUmU6IFtQQVRDSCB2MSAxLzFdIGh3L21pc2MvYXNwZWVkX3NiYzogQWRkIGJv
dW5kcyBjaGVja2luZyBmb3IgT1RQIHdyaXRlIG9wZXJhdGlvbnMNCg0KT24gVHVlLCAyOCBBcHIg
MjAyNiBhdCAwNjo1MywgS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+IHdyb3Rl
Og0KPg0KPiBUaGVyZSBpcyBhIG1pc21hdGNoIGJldHdlZW4gdGhlIEFzcGVlZCBPVFAgbW9kZWwg
YW5kIHRoZSBBc3BlZWQgU0JDDQo+IG1vZGVsIGluIGhvdyB0aGUgZ3Vlc3QtcHJvdmlkZWQgYWRk
cmVzcyBpcyBoYW5kbGVkLg0KPiBhc3BlZWRfc2JjX290cF9wcm9nKCkgcGFzc2VzIGEgd29yZC1p
bmRleGVkIGFkZHJlc3MgZGlyZWN0bHkNCj4gdG8gYWRkcmVzc19zcGFjZV93cml0ZSgpIHdpdGhv
dXQgY29udmVydGluZyBpdCB0byBhIGJ5dGUgb2Zmc2V0LA0KPiB3aGVyZWFzIGFzcGVlZF9vdHBf
d3JpdGUoKSBleHBlY3RzIGEgYnl0ZSBvZmZzZXQgYW5kIGFwcGxpZXMgYW4NCj4gYWRkaXRpb25h
bCBzaGlmdCAob3RwX2FkZHIgPDwgMikuIFRoaXMgZG91YmxlLXNoaWZ0IGNvbmZ1c2lvbiBtZWFu
cw0KPiB0aGF0IGFuIG91dC1vZi1yYW5nZSB3b3JkIGFkZHJlc3MgY2FuIGxlYWQgdG8gYSB3cml0
ZSBiZXlvbmQgdGhlDQo+IGFsbG9jYXRlZCBzdG9yYWdlLg0KPg0KPiBGaXggdGhpcyBieSBhZGRp
bmcgYm91bmRzIGNoZWNraW5nIG9uIHRoZSB3b3JkIG9mZnNldCBiZWZvcmUNCj4gY29udmVydGlu
ZyB0byBieXRlIG9mZnNldCBhbmQgcGFzc2luZyB0byBhZGRyZXNzX3NwYWNlX3dyaXRlKCkuDQo+
IFRoaXMgbWF0Y2hlcyB0aGUgZXhpc3RpbmcgYm91bmRzIGNoZWNrIGluIGFzcGVlZF9zYmNfb3Rw
X3JlYWQoKS4NCj4NCj4gQ2M6IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29t
Pg0KPiBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZw0KPiBGaXhlczogMWEwMDc1NGNjZjE1ICgi
aHcvbWlzYzogQWRkIEFzcGVlZCBTZWN1cmUgQm9vdCBDb250cm9sbGVyIG1vZGVsIikNCj4gUmVz
b2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMv
MzQzNg0KPiBSZXBvcnRlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBDqKZkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29t
Pg0KPiAtLS0NCj4gIGh3L21pc2MvYXNwZWVkX3NiYy5jICB8IDE0ICsrKysrKysrKysrLS0tDQo+
ICBody9udnJhbS9hc3BlZWRfb3RwLmMgfCAxMyArKysrKystLS0tLS0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvaHcvbWlzYy9hc3BlZWRfc2JjLmMgYi9ody9taXNjL2FzcGVlZF9zYmMuYw0KPiBpbmRleCAw
NjVlODIyZTcwLi44Yjc0ZGNhMTNjIDEwMDY0NA0KPiAtLS0gYS9ody9taXNjL2FzcGVlZF9zYmMu
Yw0KPiArKysgYi9ody9taXNjL2FzcGVlZF9zYmMuYw0KPiBAQCAtMTU5LDEzICsxNTksMjEgQEAg
c3RhdGljIGJvb2wgYXNwZWVkX3NiY19vdHBfcHJvZyhBc3BlZWRTQkNTdGF0ZSAqcywNCj4gICAg
ICBNZW1UeFJlc3VsdCByZXQ7DQo+ICAgICAgQXNwZWVkT1RQU3RhdGUgKm90cCA9ICZzLT5vdHA7
DQo+ICAgICAgdWludDMyX3QgdmFsdWUgPSBzLT5yZWdzW1JfQ0FNUDFdOw0KPiArICAgIHVpbnQz
Ml90IG90cF9vZmZzZXQgPSBvdHBfYWRkciA8PCAyOw0KPg0KPiAtICAgIHJldCA9IGFkZHJlc3Nf
c3BhY2Vfd3JpdGUoJm90cC0+YXMsIG90cF9hZGRyLCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELA0K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgJnZhbHVlLCBzaXplb2YodmFsdWUpKTsNCj4gKyAg
ICBpZiAob3RwX2FkZHIgPj0gT1RQX1RPVEFMX0RXT1JEX0NPVU5UKSB7DQo+ICsgICAgICAgIHFl
bXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiArICAgICAgICAgICAgICAgICAgICAgICJJ
bnZhbGlkIE9UUCBhZGRyIDB4JXhcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgb3RwX2Fk
ZHIpOw0KPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0
ID0gYWRkcmVzc19zcGFjZV93cml0ZSgmb3RwLT5hcywgb3RwX29mZnNldCwgTUVNVFhBVFRSU19V
TlNQRUNJRklFRCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2YWx1ZSwgc2l6
ZW9mKHZhbHVlKSk7DQo+ICAgICAgaWYgKHJldCAhPSBNRU1UWF9PSykgew0KPiAgICAgICAgICBx
ZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAi
RmFpbGVkIHRvIHdyaXRlIE9UUCBtZW1vcnksIGFkZHIgPSAleFxuIiwNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICBvdHBfYWRkcik7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgb3RwX29mZnNl
dCk7DQoNCkkgd291bGQgc3RpY2sgdG8gcmVwb3J0aW5nIG90cF9hZGRyIGhlcmU6DQogLSBpdCdz
IHRoZSB2YWx1ZSB0aGUgZ3Vlc3QgYWN0dWFsbHkgd3JpdGVzDQogLSBpdCBtYXRjaGVzIHRoZSBs
b2dnaW5nIGZvciAiaW52YWxpZCBPVFAgYWRkciBhYm92ZSINCiAtIGl0IG1hdGNoZXMgd2hhdCBh
c3BlZWRfc2JjX290cF9yZWFkKCkgbG9ncyBpbiB0aGUgZXF1aXZhbGVudCBjYXNlDQoNCk90aGVy
d2lzZQ0KUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz4NCg0KdGhhbmtzDQotLSBQTU0NCg==

--_000_SI6PR06MB76311242178B0118E07A1368F7352SI6PR06MB7631apcp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Peter,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks for your review and feedback. I will update the logging accordingly =
and submit a v2 patch.</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Kane</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=BC=C4=BC=FE=D5=DF:</b> Peter M=
aydell &lt;peter.maydell@linaro.org&gt;<br>
<b>=BC=C4=BC=FE=C8=D5=C6=DA:</b> 2026=C4=EA4=D4=C230=C8=D5 =CF=C2=CE=E7 07:=
03<br>
<b>=CA=D5=BC=FE=D5=DF:</b> Kane Chen &lt;kane_chen@aspeedtech.com&gt;<br>
<b>=B8=B1=B1=BE:</b> C=A8=A6dric Le Goater &lt;clg@kaod.org&gt;; Steven Lee=
 &lt;steven_lee@aspeedtech.com&gt;; Troy Lee &lt;leetroy@gmail.com&gt;; Jam=
in Lin &lt;jamin_lin@aspeedtech.com&gt;; Andrew Jeffery &lt;andrew@codecons=
truct.com.au&gt;; Joel Stanley &lt;joel@jms.id.au&gt;; open list:ASPEED BMC=
s &lt;qemu-arm@nongnu.org&gt;;
 open list:All patches CC here &lt;qemu-devel@nongnu.org&gt;; Troy Lee &lt;=
troy_lee@aspeedtech.com&gt;; qemu-stable@nongnu.org &lt;qemu-stable@nongnu.=
org&gt;; C=A8=A6dric Le Goater &lt;clg@redhat.com&gt;<br>
<b>=D6=F7=D6=BC:</b> Re: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds chec=
king for OTP write operations</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, 28 Apr 2026 at 06:53, Kane Chen &lt;kane_c=
hen@aspeedtech.com&gt; wrote:<br>
&gt;<br>
&gt; There is a mismatch between the Aspeed OTP model and the Aspeed SBC<br=
>
&gt; model in how the guest-provided address is handled.<br>
&gt; aspeed_sbc_otp_prog() passes a word-indexed address directly<br>
&gt; to address_space_write() without converting it to a byte offset,<br>
&gt; whereas aspeed_otp_write() expects a byte offset and applies an<br>
&gt; additional shift (otp_addr &lt;&lt; 2). This double-shift confusion me=
ans<br>
&gt; that an out-of-range word address can lead to a write beyond the<br>
&gt; allocated storage.<br>
&gt;<br>
&gt; Fix this by adding bounds checking on the word offset before<br>
&gt; converting to byte offset and passing to address_space_write().<br>
&gt; This matches the existing bounds check in aspeed_sbc_otp_read().<br>
&gt;<br>
&gt; Cc: Kane-Chen-AS &lt;kane_chen@aspeedtech.com&gt;<br>
&gt; Cc: qemu-stable@nongnu.org<br>
&gt; Fixes: 1a00754ccf15 (&quot;hw/misc: Add Aspeed Secure Boot Controller =
model&quot;)<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items=
/3436">https://gitlab.com/qemu-project/qemu/-/work_items/3436</a><br>
&gt; Reported-by: Peter Maydell &lt;peter.maydell@linaro.org&gt;<br>
&gt; Signed-off-by: C=A8=A6dric Le Goater &lt;clg@redhat.com&gt;<br>
&gt; Signed-off-by: Kane-Chen-AS &lt;kane_chen@aspeedtech.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; hw/misc/aspeed_sbc.c&nbsp; | 14 +++++++++++---<br>
&gt;&nbsp; hw/nvram/aspeed_otp.c | 13 ++++++-------<br>
&gt;&nbsp; 2 files changed, 17 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c<br>
&gt; index 065e822e70..8b74dca13c 100644<br>
&gt; --- a/hw/misc/aspeed_sbc.c<br>
&gt; +++ b/hw/misc/aspeed_sbc.c<br>
&gt; @@ -159,13 +159,21 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *=
s,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MemTxResult ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AspeedOTPState *otp =3D &amp;s-&gt;otp;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D s-&gt;regs[R_CAMP1];<=
br>
&gt; +&nbsp;&nbsp;&nbsp; uint32_t otp_offset =3D otp_addr &lt;&lt; 2;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp; ret =3D address_space_write(&amp;otp-&gt;as, otp_a=
ddr, MEMTXATTRS_UNSPECIFIED,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
value, sizeof(value));<br>
&gt; +&nbsp;&nbsp;&nbsp; if (otp_addr &gt;=3D OTP_TOTAL_DWORD_COUNT) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ER=
ROR,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Invalid OTP=
 addr 0x%x\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otp_addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; ret =3D address_space_write(&amp;otp-&gt;as, otp_o=
ffset, MEMTXATTRS_UNSPECIFIED,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;value, sizeof(value));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret !=3D MEMTX_OK) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LO=
G_GUEST_ERROR,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;F=
ailed to write OTP memory, addr =3D %x\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otp_addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otp_offset);<br>
<br>
I would stick to reporting otp_addr here:<br>
&nbsp;- it's the value the guest actually writes<br>
&nbsp;- it matches the logging for &quot;invalid OTP addr above&quot;<br>
&nbsp;- it matches what aspeed_sbc_otp_read() logs in the equivalent case<b=
r>
<br>
Otherwise<br>
Reviewed-by: Peter Maydell &lt;peter.maydell@linaro.org&gt;<br>
<br>
thanks<br>
-- PMM<br>
</div>
</span></font></div>
</body>
</html>

--_000_SI6PR06MB76311242178B0118E07A1368F7352SI6PR06MB7631apcp_--

