Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D5BFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 05:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJmID-0003p5-IY; Mon, 04 May 2026 01:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wJmHt-0003nv-BN; Mon, 04 May 2026 01:56:13 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wJmHp-00008C-Em; Mon, 04 May 2026 01:56:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkiKySUk2nyqdwnQNtAAxaeowVgKh0H6klzk6Jr6Zc7l+jQqq0V4Kvn+9NlwDAowvASYQZL4QSaEWRyjeLKfe+wylrbqSWPlRrIcza5EXiC4NkxtRyLafxOnvB1WQSXuFih9E2AHBM48arLguEr9HI2ACt9UdVTjrdp4V7dnIC4IhZlO5uWnBIEUqJnU2hu4QofHH9Zh/EKRlPiPMYt1/bZzML6fDclz+PoiI2TSeqUb0ryHtN7LogHwtsL3dWXVXoOfKQ3N07EtrAH10IMvOeNUbRip9bZw9CGWWATr5pDVTVHQiLqbbuCrXDhRJB0gigsbxvFH6Ib83viLV9kY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FffI19gxhbgLQWLln5hp0ioUy86OX5ZhUZ1RP+WWMFE=;
 b=aTZRUgtQKZU4I4YnXgvBgIjrlegz58ZoZ3muwGeXyqbJOb8mDHyP+YGy2SM8HYRXk8d337NyzJBntsIE9tMw8E9sbM3/qXhlTcb9BA7J6Asa5ZvHRlQjIiJV7MHrzbOG00jqXgi+F1Yr5aJ5RBjq5B+JaNX/otyVdn6iZMAcC/rnb+nBWR7kVZDec5E0N567SnVN9I7wdrVWsbmllzwIyeet129fyi+QwUKshxtEJwGLjAJ4ITiMuD1XmMmLoLp/VHhjY/29P/1t6azMPsPMVYSI6Qqs7K0iKY6S7nOO6/jRujHW2UFciRRXySfZd7oH2yH+6jTSPOHzJBbv92fmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FffI19gxhbgLQWLln5hp0ioUy86OX5ZhUZ1RP+WWMFE=;
 b=pzj/5KK312ymzI2/9ScVcTQrvN/OqXdyLq4sKuYuzeVrjaQLhZiNWkymKknVPXvDPGXHgd2NfOBwZCAAtTOJQeyzTcMkWcRO9RXz9ET5I1DE/LTGx+Mltf8lexGSX9QGqn2K5+QeB/XmumdTXIe8Fo3cd1jRhMlrkUG+1igTn4j4RS0YmNPmxTioP3RGLOsSQ3gdiFeTT+loIFkmqhw8U4bgfw5mRnCcFgfBYbq4iDF8XhhyAiUPMae2uoDdZVfP6lrlB2My+AmaQP/o6t7QrAjOQ5TYM7mWUweI5DsS2UGG7K/7ZIDBG0pOztrDBJKRVhH2iDcrqLdpYWxbfrz47Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SE3PR06MB8477.apcprd06.prod.outlook.com (2603:1096:101:329::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 05:56:00 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 05:56:00 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
Subject: RE: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
Thread-Topic: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
Thread-Index: AQHc1tNDVtPV7xe+NUODvFad+2ZigrX3dGEAgABzboCABUpvwA==
Date: Mon, 4 May 2026 05:56:00 +0000
Message-ID: <SI6PR06MB7631C4943ADA88FA276FF703F7312@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260428055254.76581-1-kane_chen@aspeedtech.com>
 <20260428055254.76581-2-kane_chen@aspeedtech.com>
 <CAFEAcA8i+v_7KVPBMHGkjf=tuGuVCW_d-XUBb1cr-ezmD_F7xg@mail.gmail.com>
 <0e8d1755-3354-4e81-ac80-24d3b65247ae@kaod.org>
In-Reply-To: <0e8d1755-3354-4e81-ac80-24d3b65247ae@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SE3PR06MB8477:EE_
x-ms-office365-filtering-correlation-id: 56242105-9ccf-460f-97ac-08dea9a1d168
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: i8iT1Pg+JNXDN0W/pmxyHLaM9i6qR8LTysUkNSGiEcGjJt5EvGq63meWQQ3el9yCaeYC9351xPdJXW0bN3O+5p7qbhEU/ZT02/uZEDslRPdZGCwcxlYytbElZ3GTyMlp59ELRoT7hO6mXraCLTZKGgw/Zm8Eaw56i/uIBPfoyJ3LUDOf2G0/s1HCfUvTUjr/Fkrn8Qf+HujY1xZUNUCm5mEz6Yn+09UrvRLmvkmAWLVUizp5oEPtm+RZ8T42bv6CLTnNDbwjnBe4vw4esiF1L3Ev/nPuJwBoufJ7OTSI/gpylqCxcs7hl/jO1CEmGDTyqAffiOS6kWy6gyfvPsM3//jqz886MtDQg6+/wpp5pvDs8GwHJj51jelsPrvw4C9mtWJJpOEsFnaGthb2dXvPhcoPyylMaRkNxm1BpkIwlkeUtEFDfEbX6G8VG0Sj2oMMKiL8QDhrWHtd4jl5669u1HzDoP7TxgpHDb0KC+RiZ6D1nK8RVjxFedcOHQqk9qKzlvEkFDzu+OydRyRSevb9iGZ805hoZ43dImUgnIL6w69emVmKCQDwmvU/rGt35wvUso8AelE503xKZNUxolsTs2k0MoNAPhjvMfz2z82A/qogVAKiknyTD5R83MlLWF9sv5fg+FL5CIlI7cxHy/QlMySmbpHPlgSLLVJnmyM41Yt1k+MAC80GwVv/HAqfwlXyJtJEKZWXIpjEwxn+QceSEPEehgkMgr1VuNy9rr4fxwwZk0sCA/AejQEQTI6Ve6QU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTQxVUhaRTlUUXZ6b0kva2huQjNYcENZUVpiYm1kcCtWK1YySHVOeTlUVkpE?=
 =?utf-8?B?QTlkYW56SmZGWDE5WTVBUklsR0RFbm1jbkxvUWNCNmlSSWlqaUdhdGhiVnBs?=
 =?utf-8?B?SUNVUjY2N2M4citwN1NvTlREQlBHalN4ajBMZXIwM2Q1UlV5TmpMeTRXS0R0?=
 =?utf-8?B?WXd1UDhUTkhlcm1HRE04c2ZxS2x4MS8wMVRNN2hvdWtIbFJ0U1YrclBrSnJz?=
 =?utf-8?B?ZHlWQ1dJSTRTR3d5bEt4ZE9sS3FJMFMvVmZGbVM3NEFsbkVmYVZ0UkQrWktQ?=
 =?utf-8?B?UTNWNGN6Q1RiRnk0Q1RXTjUvSDZCeEZ4V0prWjBwcG91cytqaEZMcGIrZlRw?=
 =?utf-8?B?azh3cmYzdVJRSEFZQXhtZlZNY243OEdWeGpNVk9Za1lveXpkeVRBdWhlL3pl?=
 =?utf-8?B?M1NWSVI4dkZTVjNQdVVEY0dwYXF6cGVJc0M2amowb2swUWxRemFtNVlPYXUz?=
 =?utf-8?B?bExkQUh1RjdJQ0ZlMlJvWTlyUS9PaDNhNEY2amVnZWhaTmUxYkdqN3paZlNx?=
 =?utf-8?B?cXhOcFRVcFZ2QkpNWHhNb0xSOXp5NEZ3U0Rvc0cvY3dieHJaSGhqbmJwVGdT?=
 =?utf-8?B?eE5nejZPOFhvdDRtSSt6bVRLNFVsbGJFWjYrb0pSSFA2Q2lJcWJtOHNzWWFM?=
 =?utf-8?B?SndxdXl4YXg3ZWo4OHVkbGdmamx2M2xOdkkrR1U1cU5iS21qNnF5b0p5cG02?=
 =?utf-8?B?WUI3aThDeXFjZEk1Z0FsaTdCcEVrNHVsZGJXckt5Rnk2T0YrQUpmSjlmMWJC?=
 =?utf-8?B?OEs0WFdreWhLNFQ2TEtYTU0raTErb1VHa0owWEViRHBITEk0MW16dURGc2hV?=
 =?utf-8?B?YmVGTHFJU1JOYWdxK0dGbjNOT0QzZG5hYnJFRXpLenBXd0xKc2QzRTMwNnJs?=
 =?utf-8?B?NWFOWW5NQW1kLzNFQjNoNlc0NVhHUVZkV0lnY3hlelJSTWt5cmxqM1pkdVN4?=
 =?utf-8?B?TG9UZnE0T25DUnZQeXAwR1FidUNwSW1aOEkzMytobHI3TzlkNkU4T2NGay80?=
 =?utf-8?B?bGJCY0tvbi9iSGo0eXhLbmp1dk5vVGlYMklWOHNUS1o0YmdPWkpoQ0lveWtr?=
 =?utf-8?B?QUJFSkhUY0R0OTNJZFVPSkkzYUJoZ2hrZEthTUpqQit2WTI0QURWUEVrM28w?=
 =?utf-8?B?cE5BbWl1WWNXYWtrMEVJcnVHUEh5dmVQeFFjKytVWU1NZ3NDa3hJMnVqQWhB?=
 =?utf-8?B?NkN4QWQxeSt2WjkzTFdvL0dpUDNBY1pKYjRuQkZpMlVsUGRERWsrU016MVc1?=
 =?utf-8?B?M3IvYjRkWkI3dXhnK1NkdFY2UmhrcFZ3VDVEcEttVFJidGo2cHpJdlZIUDEy?=
 =?utf-8?B?TlViMENpT2JuU0lKajQzYkcxdjArcXhEeEpGUFVqb3U2VjJ3dzI5WnVmQlI1?=
 =?utf-8?B?SUpDV1F6WWF1UEJFNk40VjBYcVhwOTdkTjN4c3c0Sm1YV1YxTXBwTERMaFZj?=
 =?utf-8?B?cTVKZ09lZlg4cmU3V21BdThNYmd0S0FsMzZFYUN5S2FaUHZoMDl6TEZ5enM5?=
 =?utf-8?B?VmJURS9MK3FlTzdvNGY5M25sWmxURStBWTU3SXJLeVJzNEdwUGxJVlNpMlZZ?=
 =?utf-8?B?bHJCSDJ2Uk1zV0tMdzltOFBGMFhJYzRQY1NXZDgrcWlxTHlIeXQyNzBPTFZq?=
 =?utf-8?B?b2kxWUFrVURpdnp4Nk40dmJJOWhrYmNlWnk2dlF0UEtFRnZTY0FsYVdqa2dt?=
 =?utf-8?B?SUo2dG1GN2hKWFlxcEN5aEZaS0E4bElOdEJxNTg5azFwKzkwdnMxd0hLRkJu?=
 =?utf-8?B?bEFBa2svY1VSdXlBR29FaTVwUU52b0cyNHkvYVhBTXVGVGVDNjZUcnFadEY5?=
 =?utf-8?B?M2E2RWI5dTQvS2xaejBla0RuYXRQeHBEdHlxRjNVWDhJVUpwN0t0T2EzQk1o?=
 =?utf-8?B?aGZFZjRUZ3ZKSHduWFkzWnd3QVozUUdEbkI1bmZUaUloT2NzU282K2FMdGtR?=
 =?utf-8?B?SVlXdGhiRXU0Sm8zMnhBRGlNaVNWTE5SN3ZHNG9Dekt5dmtwZkRHS1pUV2JI?=
 =?utf-8?B?ekRLZmtkcFk3YStjTmVGMUpnaUlFTVc3LzQvamkrQTJ4NFZrUXZtTEdYc2E4?=
 =?utf-8?B?Y3lQOG9UNmVBNHVWK2ZodVNMajYwOTFVL2dteXJ5dHR2bXZRQlo0d3A0a0Iw?=
 =?utf-8?B?emJpckZScFRPdDh3RDBiTEdEV2poVDVVak9WSytJWm5rbXI0bzVZMjJPL1hh?=
 =?utf-8?B?QmFhUGFaZGU3NEZqY3E4Y1NFb3lXcmhETmZXdmcrdHY1ZDU5c1hWZDIwT2NS?=
 =?utf-8?B?NGVxMUwyVXQ3MWNYUnNldXR6TDFza1Y0dGRHOUVUSlRNcTZtUnE2cUpMSDAz?=
 =?utf-8?B?VEVweWVxWk5oNW54dzlLdmNMSzZYVVY5VXgwOFpkb24vVkxkL0s4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Epr1/INNRe0NMb9M0Hqas2lfsmFwp6Jv+iHspMjWPd1fA0fjpnhkJuYKIfn98CMYfuJXXYs3H93iha02cvJg3es6VoBlbNGq6BHYBfbRyhTL1YmOSvVnOwmgMpekd4oaibt28aPjBk9k8smZDTZISaAv4nfNuNTY3BqznfEVe6OAtraganb7xZ07Ub5XR0RqvmJjiD3WQJrrEOwvSkc+jXppAgveJabavSjFCW3iBaQp0pW4T7BfKcJ/jIntA+wQPcstXEwZXgFvUaCaeFSA99mW2iweGdicTErKwRw3KKK09sf4Eq+I/l1y8BnkqWEceKL12HOzdXRtZdlVLIHJCw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56242105-9ccf-460f-97ac-08dea9a1d168
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 05:56:00.0863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huy+ot1TuQkfwsbliDWqCZ3d/FvvmFKnMOhvp7zWamqT+t2yb8tF42WIny0Qjp7MUMEiaUwXVe8iqUPF02Sj/0MetevVV9KcNIE+xB7wJVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8477
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAxLCAyMDI2IDE6NTcgQU0NCj4gVG86
IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEthbmUgQ2hlbg0KPiA8
a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiBDYzogU3RldmVuIExlZSA8c3RldmVuX2xlZUBh
c3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlDQo+IDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExp
biA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJld0Bj
b2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBvcGVu
DQo+IGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxs
IHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgVHJveSBMZWUgPHRy
b3lfbGVlQGFzcGVlZHRlY2guY29tPjsNCj4gcWVtdS1zdGFibGVAbm9uZ251Lm9yZzsgQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEv
MV0gaHcvbWlzYy9hc3BlZWRfc2JjOiBBZGQgYm91bmRzIGNoZWNraW5nIGZvciBPVFANCj4gd3Jp
dGUgb3BlcmF0aW9ucw0KPiANCj4gT24gNC8zMC8yNiAxMzowMywgUGV0ZXIgTWF5ZGVsbCB3cm90
ZToNCj4gPiBPbiBUdWUsIDI4IEFwciAyMDI2IGF0IDA2OjUzLCBLYW5lIENoZW4gPGthbmVfY2hl
bkBhc3BlZWR0ZWNoLmNvbT4NCj4gd3JvdGU6DQo+ID4+DQo+ID4+IFRoZXJlIGlzIGEgbWlzbWF0
Y2ggYmV0d2VlbiB0aGUgQXNwZWVkIE9UUCBtb2RlbCBhbmQgdGhlIEFzcGVlZCBTQkMNCj4gPj4g
bW9kZWwgaW4gaG93IHRoZSBndWVzdC1wcm92aWRlZCBhZGRyZXNzIGlzIGhhbmRsZWQuDQo+ID4+
IGFzcGVlZF9zYmNfb3RwX3Byb2coKSBwYXNzZXMgYSB3b3JkLWluZGV4ZWQgYWRkcmVzcyBkaXJl
Y3RseSB0bw0KPiA+PiBhZGRyZXNzX3NwYWNlX3dyaXRlKCkgd2l0aG91dCBjb252ZXJ0aW5nIGl0
IHRvIGEgYnl0ZSBvZmZzZXQsIHdoZXJlYXMNCj4gPj4gYXNwZWVkX290cF93cml0ZSgpIGV4cGVj
dHMgYSBieXRlIG9mZnNldCBhbmQgYXBwbGllcyBhbiBhZGRpdGlvbmFsDQo+ID4+IHNoaWZ0IChv
dHBfYWRkciA8PCAyKS4gVGhpcyBkb3VibGUtc2hpZnQgY29uZnVzaW9uIG1lYW5zIHRoYXQgYW4N
Cj4gPj4gb3V0LW9mLXJhbmdlIHdvcmQgYWRkcmVzcyBjYW4gbGVhZCB0byBhIHdyaXRlIGJleW9u
ZCB0aGUgYWxsb2NhdGVkDQo+ID4+IHN0b3JhZ2UuDQo+ID4+DQo+ID4+IEZpeCB0aGlzIGJ5IGFk
ZGluZyBib3VuZHMgY2hlY2tpbmcgb24gdGhlIHdvcmQgb2Zmc2V0IGJlZm9yZQ0KPiA+PiBjb252
ZXJ0aW5nIHRvIGJ5dGUgb2Zmc2V0IGFuZCBwYXNzaW5nIHRvIGFkZHJlc3Nfc3BhY2Vfd3JpdGUo
KS4NCj4gPj4gVGhpcyBtYXRjaGVzIHRoZSBleGlzdGluZyBib3VuZHMgY2hlY2sgaW4gYXNwZWVk
X3NiY19vdHBfcmVhZCgpLg0KPiA+Pg0KPiA+PiBDYzogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5A
YXNwZWVkdGVjaC5jb20+DQo+ID4+IENjOiBxZW11LXN0YWJsZUBub25nbnUub3JnDQo+ID4+IEZp
eGVzOiAxYTAwNzU0Y2NmMTUgKCJody9taXNjOiBBZGQgQXNwZWVkIFNlY3VyZSBCb290IENvbnRy
b2xsZXINCj4gPj4gbW9kZWwiKQ0KPiA+PiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3Fl
bXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy8zNDM2DQo+ID4+IFJlcG9ydGVkLWJ5OiBQZXRl
ciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
S2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAg
IGh3L21pc2MvYXNwZWVkX3NiYy5jICB8IDE0ICsrKysrKysrKysrLS0tDQo+ID4+ICAgaHcvbnZy
YW0vYXNwZWVkX290cC5jIHwgMTMgKysrKysrLS0tLS0tLQ0KPiA+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1n
aXQgYS9ody9taXNjL2FzcGVlZF9zYmMuYyBiL2h3L21pc2MvYXNwZWVkX3NiYy5jIGluZGV4DQo+
ID4+IDA2NWU4MjJlNzAuLjhiNzRkY2ExM2MgMTAwNjQ0DQo+ID4+IC0tLSBhL2h3L21pc2MvYXNw
ZWVkX3NiYy5jDQo+ID4+ICsrKyBiL2h3L21pc2MvYXNwZWVkX3NiYy5jDQo+ID4+IEBAIC0xNTks
MTMgKzE1OSwyMSBAQCBzdGF0aWMgYm9vbA0KPiBhc3BlZWRfc2JjX290cF9wcm9nKEFzcGVlZFNC
Q1N0YXRlICpzLA0KPiA+PiAgICAgICBNZW1UeFJlc3VsdCByZXQ7DQo+ID4+ICAgICAgIEFzcGVl
ZE9UUFN0YXRlICpvdHAgPSAmcy0+b3RwOw0KPiA+PiAgICAgICB1aW50MzJfdCB2YWx1ZSA9IHMt
PnJlZ3NbUl9DQU1QMV07DQo+ID4+ICsgICAgdWludDMyX3Qgb3RwX29mZnNldCA9IG90cF9hZGRy
IDw8IDI7DQo+ID4+DQo+ID4+IC0gICAgcmV0ID0gYWRkcmVzc19zcGFjZV93cml0ZSgmb3RwLT5h
cywgb3RwX2FkZHIsDQo+IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsDQo+ID4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAmdmFsdWUsIHNpemVvZih2YWx1ZSkpOw0KPiA+PiArICAgIGlmIChvdHBf
YWRkciA+PSBPVFBfVE9UQUxfRFdPUkRfQ09VTlQpIHsNCj4gPj4gKyAgICAgICAgcWVtdV9sb2df
bWFzayhMT0dfR1VFU1RfRVJST1IsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIkludmFs
aWQgT1RQIGFkZHIgMHgleFxuIiwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICBvdHBfYWRk
cik7DQo+ID4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPj4gKyAgICB9DQo+ID4+ICsNCj4g
Pj4gKyAgICByZXQgPSBhZGRyZXNzX3NwYWNlX3dyaXRlKCZvdHAtPmFzLCBvdHBfb2Zmc2V0LA0K
PiBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJnZhbHVlLCBzaXplb2YodmFsdWUpKTsNCj4gPj4gICAgICAgaWYgKHJldCAhPSBNRU1U
WF9PSykgew0KPiA+PiAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsDQo+
ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8gd3JpdGUgT1RQIG1lbW9yeSwg
YWRkciA9ICV4XG4iLA0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgIG90cF9hZGRyKTsNCj4g
Pj4gKyAgICAgICAgICAgICAgICAgICAgICBvdHBfb2Zmc2V0KTsNCj4gPg0KPiA+IEkgd291bGQg
c3RpY2sgdG8gcmVwb3J0aW5nIG90cF9hZGRyIGhlcmU6DQo+ID4gICAtIGl0J3MgdGhlIHZhbHVl
IHRoZSBndWVzdCBhY3R1YWxseSB3cml0ZXMNCj4gPiAgIC0gaXQgbWF0Y2hlcyB0aGUgbG9nZ2lu
ZyBmb3IgImludmFsaWQgT1RQIGFkZHIgYWJvdmUiDQo+ID4gICAtIGl0IG1hdGNoZXMgd2hhdCBh
c3BlZWRfc2JjX290cF9yZWFkKCkgbG9ncyBpbiB0aGUgZXF1aXZhbGVudCBjYXNlDQo+ID4NCj4g
PiBPdGhlcndpc2UNCj4gPiBSZXZpZXdlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnPg0KPiANCj4gDQo+IA0KPiBBcHBsaWVkIHRvDQo+IA0KPiAgICAgIGh0dHBz
Oi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11IGFzcGVlZC1uZXh0DQo+IA0KPiB3aXRoIHRoaXMg
Y2hhbmdlLg0KPiANCj4gUGV0ZXIsDQo+IA0KPiBGZWVsIGZyZWUgdG8gcGljayB0aGUgY2hhbmdl
IGlmIG5lZWRlZC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCkhpIEPDqWRyaWMvUGV0ZXIs
DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIGNvbW1lbnRzLg0KDQpDdXJyZW50bHksIHRo
ZSBuYW1pbmcgb2Ygb3RwX2FkZHIgYW5kIG90cF9vZmZzZXQgaXMgaW5jb25zaXN0ZW50LCBhcyBi
b3RoIGFyZSB1c2VkIHRvIHJlcHJlc2VudCB0aGUgdXNlci1wcm92aWRlZCBhZGRyZXNzLiBGb3Ig
ZXhhbXBsZSwgd2hlbiBpbXBsZW1lbnRpbmcgdGhlIE9UUCBtb2R1bGUsIEkgZm9sbG93ZWQgdGhl
IG5hbWluZyBjb252ZW50aW9uIHVzZWQgaW4gdGhlIHdyaXRlIG9wZXJhdGlvbiAoc2VlIHRoZSBs
aW5rIGJlbG93IGZvciByZWZlcmVuY2UpOg0KaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gt
Qk1DL3plcGh5ci9ibG9iL2FzcGVlZC1tYWluLXYzLjcuMC9kcml2ZXJzL21pc2MvYXNwZWVkL290
cF9zaGVsbC5jI0wyMzkNCg0KSG93ZXZlciwgaW4gdGhlIHJlYWQgcGF0aCwgdGhlIGNvZGUgdXNl
cyB0aGUgdGVybSBvZmZzZXQgaW5zdGVhZCAoc2VlIGJlbG93KToNCmh0dHBzOi8vZ2l0aHViLmNv
bS9Bc3BlZWRUZWNoLUJNQy96ZXBoeXIvYmxvYi9hc3BlZWQtbWFpbi12My43LjAvZHJpdmVycy9t
aXNjL2FzcGVlZC9vdHBfc2hlbGwuYyNMMTUwDQoNClRvIGltcHJvdmUgY29uc2lzdGVuY3ksIHdl
IGNvdWxkIGFsaWduIHRoZSBuYW1pbmcgd2l0aCBvdHBfb2Zmc2V0LCBmb2xsb3dpbmcgdGhlIHJl
YWQgcGF0aCBjb252ZW50aW9uLiBIb3dldmVyLCBJJ20gbm90IGNlcnRhaW4gaWYgdGhpcyB3b3Vs
ZCBiZSBtb3JlIGludHVpdGl2ZS4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFueSBm
dXJ0aGVyIHN1Z2dlc3Rpb25zIHJlZ2FyZGluZyB0aGUgb3RwX2FkZHIgLyBvdHBfb2Zmc2V0IG5h
bWluZy4NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

