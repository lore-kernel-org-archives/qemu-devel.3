Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBF4D58E49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwu56-0001dM-47; Sun, 01 Mar 2026 22:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwu54-0001dA-EY; Sun, 01 Mar 2026 22:36:26 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwu52-0001UQ-0q; Sun, 01 Mar 2026 22:36:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJs7jbWFwkVYLNUFDhH3kG7TNB2zpCaadcOv7reNns5DqA3HfRKhsnIqbuzDlR27omZQUz1E1JK1xPGfUSlR/3tQCwILjWkLzxs0QZC/cM+O7D7M2c7vIIsN4afQhLtQjsxHUhPY/4vHszuECAApJIDnPP0C80mc/0quamqomNET4LaCneX2MaZIcodlpZ3NfFmIZyEdhk3M20lMRblJruGH7I6yUhaA2O7sJIm/2swg1qXEj13kgirSf4nxNSPBLNdY3DZFYMHfMOopFDsaUMA4eodaVEYRPluRV8PaNwu43dL8LXGOmiYyF/4eJyTR/njAf0L7bH9H6Kzb+SLdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PXHZOkEv5bsLIZxCo7RME8LdPMahXAgJVCRVysrY9o=;
 b=AoAbQp+WbuebDL+WWadp0EeBo6kGFqGXR7zJOEHjMSeyuDy4mti2DXMwn/bv9SO+lD9+yskfJqezhr87EeZUF5P1vrPxG412AQD7vMT8O+hlUvWxCx9BYjWcj/bMPX/DzcuvboP5urtBHKcDU9Hz8EG8GJYJVH3LbxJYs8Zrxsp/wiefhdWX09QUBF9nwJXcqItRhq5TvKHQonN9HgPy1CxpweOanM8EZF4iRDoU/A18jam/aTWgI2XMz//Ka6jlTFCiNSPLE1gdXBOu/xJLMDy6QVZlYOUmsjwwcyw/AQNrD/KLFfOBkSBrB8y5pMvbHYhMowYN7+B9sWpqywn6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PXHZOkEv5bsLIZxCo7RME8LdPMahXAgJVCRVysrY9o=;
 b=dz+GQpC3KExBPwKIpfaQ7jfkDy+hEj6nAdxfk9U3qAGypGlRHV6aMPLOgH8JzFs2d0JQEoL/aNL6DJJG4e2zhp4uBsXOY/3FPOnXAO7aA4ka0nJwbkullViyEP535JyTJJ7U0UAVqPwki7tU8Zi7noZXGZMB0ZDSLC3icVqGc21+v6NaaqukyIS47SHrUgP/fndP78CQMZft26b0ecjDnK9p1oxeLvx5wFc7TnJxMePGwIgHWm8ZhzU9eXxjtzkoWQBATa8HLYkHuR3KoszbiHKEy/2Z/ct6nxO+Tqgdw+HNASu+uW6PC8OU5fghBSkeLxQYKRcvZFOM1vyoHYd6ow==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5372.apcprd06.prod.outlook.com (2603:1096:400:203::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 03:36:17 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:36:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>, Patrick Venture <venture@google.com>, Titus Rwantare
 <titusr@google.com>
Subject: RE: [PATCH v7 03/22] hw/i3c: Add bus support
Thread-Topic: [PATCH v7 03/22] hw/i3c: Add bus support
Thread-Index: AQHcpfwi5VafA3jlwE6dtS68OuS5+7WV1CAAgATLLRA=
Date: Mon, 2 Mar 2026 03:36:17 +0000
Message-ID: <TYPPR06MB82063381BDC99674F6A6BF81FC7EA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-4-jamin_lin@aspeedtech.com>
 <ad58c432-8c9e-4cd8-847a-df4bd6a45d6d@oss.qualcomm.com>
In-Reply-To: <ad58c432-8c9e-4cd8-847a-df4bd6a45d6d@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5372:EE_
x-ms-office365-filtering-correlation-id: d4cfdd06-84bd-4d3d-2917-08de780cdcd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: 9ZX5srEQTFAvPkmA5mUhyDgN22Ll9DLWFZIO9zvBZ2NHyZo7kCwaxts9TOEIJXR2XIXl2JSBn1XmrVXIwK+IwAV5dny7MocYGMUz/515+ob9jz6mOaXW0nq/Np24/Pu0QqkPbauqpmxR3Lhs0LuZQLe4IdIV4l9IXB7DY1/rIzk4aDiCtIYZB51EBP6DZ8iCi0lniZwHVBVJ95JM88wYU/jopSV0jVqrCv9PyJnnxqSGgfJbjYR0e5K4HzI6eYCww9LxaV2vNdZMwrMIf0aB6EHfL+qID882tE+tANJb0raOBlpEoXvcVZq8tNuhJTLy6MoND9grKRPkchmj33o64CKqAN9B2M5R4/Cgt/lp7BJCloAJk9AzqDo73BjqwSnN5lQxzeC43OL+Ltpg9uGA+qvEhmG0y3f35plfwbfxdw763S+ndJ383XSAVeOcEmqcoGj8cddCYPBUWYrbTFikiSCzK6uJepFo7m0RD11wfso7+ehbNscABtBjYRo6LsLKI8trKTgJxDRKM2lcknXPmtC/B25oyzCaSDS7iR++1lzboICA2H1GGAuSnebt62vy8dI1u/fAIVDfSYBS3o5m9YAKcTh8dyiAP6o2H2ZRn7XNE+3xHCqhOwDfdGWquB+g1bfnqZMvZaNmgC6Kus34Ad5w0YCr/GJA9JEnklwLX2XwIl/5t8gEjPhxbyRBNpQA34JFrIlFSK1UU2ov4Wp5sxkM+uNxceVE3XO4mQwDlpORjFsYWWK5MxOF3cxl5vBJlv1bioPI24DE0C+CUqRNDf0p26UDS0zVh2emwcanShGDEUcRf5IdW79tyEjR87O7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NStPZmlNcWdqcGZVUlhia3pKQ2VVYXBzUnBITnQzNGtEWkw5VU5xYk4yNFNv?=
 =?utf-8?B?RDZyNjlubXZFSzZteVVwY2RKWTRjbUJUNGhJd0pJbURyb1NTUlZRZzFITjJz?=
 =?utf-8?B?VlhSOGZoMElGYjAwZ3BCaUd2dm95RTFrd1IwSUdBTFZYaExSL2JQY2U5R0Fp?=
 =?utf-8?B?UGpOdEtWZFhRbkFiQVBXUkhKSU5JK3NSTjFmay8xUnBRanZ6d09CZzFrMEF3?=
 =?utf-8?B?Tzh4NHNTdXVVOUhYcjkrME1nd1VnbUd6NWRtQzh0S3huMUgrK1VFOTYxdFRR?=
 =?utf-8?B?V0tRWGJ2SzNvd2g0eEYyU29uNVU5VWFYQ25IZUlrOUJsMUhxS3dPeHo3VjU0?=
 =?utf-8?B?WGVQV1FhOGRrQnhCeGF2NGNCQ0VCNVNmUEd4blFZYVVOS2NQZnpqR3MxbFlz?=
 =?utf-8?B?REVXRnh1TGFsN3ltUmg3KzlpMEIxNUtWZGp2Q04zRnQ2K3ZNQjVYdkJCZXFF?=
 =?utf-8?B?V2R5dVFydXdRMWZnUnZ0ZEIzRVljRDdzTVU4Uk0yYU1aT3pjOHYybEdzTHJD?=
 =?utf-8?B?Y3h4NklQUjdKMy9obWkvaUpRbW5aSlRnRmYxanhWOHBjbVJWeVdrdDgwNVhk?=
 =?utf-8?B?SGdrUVNBZzJmR3orUzAyVTZVZEZ6UzJ3UlZDbUxkVEhPSEpycVlwL29XcjVj?=
 =?utf-8?B?NkZWdVQ3L3UvNnRsN1VWZDR3MG5uYkpBOS9lSTdXbzM4dDBYMGRJRm9uNVVP?=
 =?utf-8?B?bFJ3SWxBM3cvTVcxYTA4RkJCZ3F0NTJaNVFBMU1WWHRUdUtxNndzZ25kL3BG?=
 =?utf-8?B?d2xxM2Y0VEc4d1FZUFlhSTlJRTNzYWJxRFdHT1JNRzg3QW9HYVJZK0w5Z3Bu?=
 =?utf-8?B?bXprWVNPbzB0UEhEYWRkZzF0Zk1VcndtWk5KUFhyeUdObDMxNGhTTGdodkQ1?=
 =?utf-8?B?SThqM1BoeDJyMCtOVWIyMGJBSXlWT1NNMVJrdjQvOTdDdGx0K3JCTEMydnU1?=
 =?utf-8?B?NkdHNDN1dU5HZzlNMk83eDc0aVJvZzY0YSt2MkVtZEhGdU5Faml3TUdMaEw2?=
 =?utf-8?B?dWZ2MlJuSGJPT2k3aFdXVWw5MmQrYkR4RDZsNkpBejBrd04xOTNGL21YUTRB?=
 =?utf-8?B?ZlB2WGhPcUNXYUI4bXNQd0ZZSzVPT1c0akt0eElpODVzMjVrY0t0NUxoWmsx?=
 =?utf-8?B?WEhKOVlQdUphanNRaHhyRGRXWXJNRVdSdzNvdnBxSk1mT0Z6dG51U1dvWFpq?=
 =?utf-8?B?Q2xkMUtPdUpld2F1RW1uSGI1NnlnT1lSNDMrWXFNMHR0b3hFN0RaSm9aNW02?=
 =?utf-8?B?cjUyZVUyTHZCODY0UndxdUtjM2gweWwzVWt3V2JEaWxhVk9NNzRUaFVSL2d5?=
 =?utf-8?B?bHpMdmhHN3VvWUNVc08zQWVrQzh4R1QydWpjV3hoWnVPNGZaQ25EaWxwUWlL?=
 =?utf-8?B?b2NDQ1RybUlsNlM2VVJBaVhML3FQSkpadDZSQnRQWjJGdWFKQ1ZTR0dpemps?=
 =?utf-8?B?N3pBZ0NCK0ZRZG9UT0p0RGxDNkhmaWlUL3BmS1RhZTJVYTVxRkpZZlpWS0RE?=
 =?utf-8?B?NWxDQWozOW9uL2xHdWc0VGdZL25IcGRWSVNIMVoxamtNSHBNODhSc0hOOTRq?=
 =?utf-8?B?NEZYVFZXQUs0V0hSRklSaDhxRk52eEVSdXRSRFgyTGp1bldiS0JFZ0pqK0RL?=
 =?utf-8?B?Tlo5M1NzaUFUNWROQXBCNE9qbUtrS1U1T2phTExpMmp5aTI4TkYycmlFcVFz?=
 =?utf-8?B?eXNjU0wyWkJZZlNjOE1YNkcwbEcxaXhkQko5cmhCcUV4ZEFkZzNRTk5hc3Jt?=
 =?utf-8?B?WEkyRVVEbENGQTE5Rk90aDlWWHYvT2hEQkF5cDdIclJFcTl3NE5FRC9jL2l6?=
 =?utf-8?B?RFZlWi8zRmRtVktoaU10a2w3RExMZVhiS2hWRTB3OFVtRTZIbGlXVzFTeWFj?=
 =?utf-8?B?UTJwS3A5cmVrMzhhTWQ3VWxFWWprMzMwNzBkdHRReXZSZU1jbUZBbHh1d0VZ?=
 =?utf-8?B?bXNjb0tqQkxESkoyMk1YK2hsZ25kLzZrUTMvWUJld2VGZ3ZkRUErZkQ1dTha?=
 =?utf-8?B?SU51Y2VhUWgzMFl4VFpDd3FMY0RDVXB4dDNpOTRnTndUeDRPdHpyd0d0TDU5?=
 =?utf-8?B?UkFNdjZ1Ny9JeVY3OGZHajUvbjdUK1FJcStqWVpHNGtLZDBqTGM2WFJEWUtN?=
 =?utf-8?B?VkhFMTl1dERSUUZtUjhsL3lLQzgvUlBySEhFSkVyYVAxZUlDTDc1UnZUWkd2?=
 =?utf-8?B?dUU2MXpHajJ4UjFOUjhtRHhVaXl2RGVRMDlXWUk0KzZiUlpoUXZ4K0x0Q1k3?=
 =?utf-8?B?d2dwVkNXNW1oejNpQUlqdzJZem1CMzRsMTJ1cHUxT251UlF5dWwvZVllQ0VP?=
 =?utf-8?B?eStib0RQMk8xRDd3Ukswa0FEc3lRVm91elFnNUsxR01rNDgxOVEzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HqleM1nPBc7vqjTI9KI06jj79+91xwKsrs3ICCPDKNvYPX/7JuSCa3NMA4aHgsJzWC27a5I8L4zevhPiMNIdAsX3lxDqOFielouanUJdmxaouIZJUtiLaLPzSEFd5vvLEUvMwKXZyGspMqGHImmknNVYYLlElM38oGczgvR3FolmOZ3T0eomadTNyeZHgZ0mDhrb4a3HAM+x7eEPGq9Kwhjv7HY/+bymMaKZhTY2JaaBjK0DYw1Llz9RgYRMBbulyPMH9V1DytFKkEFsCQYbTQfHIUTuHpBGe+3fxAEuHEgtV/Bt60nIR83MvLWNSMHdOZGqlrMrGkmSB8ERXbVIQQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cfdd06-84bd-4d3d-2917-08de780cdcd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:36:17.2757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrLtWVohCtj6eYXUq1MAQqwxMpAquNm/wguw3TkCt8fZR5LOrTNC7ldnG7twHdZIzCyK4KBMk1ul4NrncGKrhe96/VdgfqzPElTq8fDqxbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5372
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgSml0aHUgSm9zZXBoDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwMy8yMl0gaHcvaTNj
OiBBZGQgYnVzIHN1cHBvcnQNCj4gDQo+IA0KPiBBbm90aGVyIG1pbm9yIGNvbW1lbnQgd2hpY2gg
dG9vIGNhbiBiZSBhZGRyZXNzZWQgbGF0ZXINCj4gDQo+IE9uIDIvMjQvMjAyNiA2OjEyIFBNLCBK
YW1pbiBMaW4gd3JvdGU6DQo+ID4gQWRkcyBhbiBJM0MgYnVzIGFuZCBhIHRhcmdldCBjbGFzcy4N
Cj4gPiBUaGUgYnVzIHN1cHBvcnRzOg0KPiA+IC0gSTNDIGRhdGEgdHJhbnNtaXNzaW9uIGFuZCBy
ZWNlcHRpb24NCj4gPiAtIENDQ3MgKGluY2x1ZGluZyBFTlREQUEpDQo+ID4gLSBJQklzDQo+ID4g
LSBsZWdhY3kgSTJDIHRyYW5zYWN0aW9ucw0KPiA+DQo+ID4gR2VuZXJhbCB1c2FnZSBvZiB0aGUg
YnVzIGlzIHNpbWlsYXIgdG8gSTJDLiBVc2VycyBhcmUgZXhwZWN0ZWQgdG8NCj4gPiBpbml0aWFs
aXplIGEgYnVzIHZpYSBpM2NfaW5pdF9idXMsIGFuZCB1c2UgdGhlIGJ1cyByZXR1cm5lZCBmcm9t
IHRoZQ0KPiA+IGluaXQgZnVuY3Rpb24gdG8gZG8gdHJhbnNhY3Rpb25zIG9uIHRoZSBidXMuDQo+
ID4NCj4gPiBJbiBvcmRlciB0byBoYW5kbGUgSUJJcywgdGhlIGNvbnRyb2xsZXIgcHJvdmlkZXMg
Y2FsbGJhY2tzIHRvIGhhbmRsZQ0KPiA+IHJlY2VpdmluZyBhbiBJQkkgZnJvbSBhIHRhcmdldCwg
cmVjZWl2aW5nIChvcHRpb25hbCkgYWRkaXRpb25hbCBJQkkNCj4gPiBieXRlcyBmcm9tIGEgdGFy
Z2V0LCBhbmQgaGFuZGxpbmcgd2hlbiBhIHRhcmdldCBpcyBkb25lIHdpdGggaXRzIElCSS4NCj4g
Pg0KPiA+IFNpbWlsYXJseSwgdGFyZ2V0IGNyZWF0aW9uIGlzIGRvbmUgdmlhIGkzY190YXJnZXRf
Y3JlYXRlX3NpbXBsZSBhbmQNCj4gPiB1c2VycyB1c2UgdGhlIHByb3ZpZGVkIEkzQ1RhcmdldCB0
byBoYW5kbGUgdHJhbnNhY3Rpb25zLg0KPiA+IFRoZSB0YXJnZXQgaGFzIGZ1bmN0aW9ucyBwcm92
aWRlZCB0aGF0IGl0IGNhbiB1c2UgdG8gaW52b2tlIGFuIElCSSBhbmQNCj4gPiBzZW5kIGFkZGl0
aW9uYWwgYnl0ZXMuDQo+ID4NCj4gPiBBbG9uZyB3aXRoIHRoZSBzZW5kLCByZWN2LCBhbmQgZXZl
bnQgY2FsbGJhY2tzIHRoYXQgYXJlIGV4cGVjdGVkIG9mIGFuDQo+ID4gSTNDIHRhcmdldCwgd2hp
Y2ggYXJlIHNpbWlsYXIgdG8gSTJDLCB0aGVyZSBpcyBhIHNlcGFyYXRlIGNhbGxiYWNrIGZvcg0K
PiA+IENDQyBoYW5kbGluZy4NCj4gPiBUaGlzIGlzIHRvIGhlbHAgZW5jYXBzdWxhdGUgQ0NDIGhh
bmRsaW5nIGFuZCBrZWVwIGl0IHNlcGFyYXRlIGZyb20NCj4gPiB0YXJnZXQtc3BlY2lmaWMgcmVh
ZC93cml0ZSBmdW5jdGlvbmFsaXR5Lg0KPiA+DQo+ID4gVG8gYXZvaWQgcmVwaXRpb24gZm9yIHJl
cXVpcmVkIENDQ3MgYW1vbmcgSTNDIHRhcmdldHMsIHRoZXJlIGlzIHNvbWUNCj4gPiBjbGFzcy1s
ZXZlbCBDQ0MgaGFuZGxpbmcgYWRkZWQuIFRoZSBDQ0MgaXMgdGhlbiBwYXNzZWQgdG8gdGhlIHRh
cmdldA0KPiA+IGluIGNhc2UgaXQgbmVlZHMgdG8gaGFuZGxlIGl0IGluIHNvbWUgd2F5Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT4NCj4g
PiBSZXZpZXdlZC1ieTogUGF0cmljayBWZW50dXJlIDx2ZW50dXJlQGdvb2dsZS5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IFRpdHVzIFJ3YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+
ID4gIGluY2x1ZGUvaHcvaTNjL2kzYy5oIHwgMjc3ICsrKysrKysrKysrKysrKysrKw0KPiA+ICBo
dy9pM2MvY29yZS5jICAgICAgICB8IDY0Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIGh3L2kzYy9tZXNvbi5idWlsZCAgIHwgICAxICsNCj4gPiAg
aHcvaTNjL3RyYWNlLWV2ZW50cyAgfCAgMTYgKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA5NDEg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9pM2MvaTNj
LmggIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGh3L2kzYy9jb3JlLmMNCj4gPg0KPiANCj4gLi4u
DQo+IA0KPiA+ICsNCj4gPiAraW50IGkzY19zZW5kX2J5dGUoSTNDQnVzICpidXMsIHVpbnQ4X3Qg
ZGF0YSkgew0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIElnbm9yZWQsIHRoZSBjYWxsZXIgY2Fu
IGRldGVybWluZSBob3cgbWFueSB3ZXJlIHNlbnQgYmFzZWQgb24gaWYNCj4gdGhpcyB3YXMNCj4g
PiArICAgICAqIEFDS2VkL05BQ0tlZC4NCj4gPiArICAgICAqLw0KPiA+ICsgICAgdWludDMyX3Qg
bnVtX3NlbnQ7DQo+IA0KPiBudW1fc2VudCBpcyB1bmluaXRpYWxpemVkIGhlcmUuIEV2ZW4gdGhv
dWdoIGkzY19zZW5kX2J5dGUgaWdub3JlcyBpdCBhZnRlciB0aGUNCj4gY2FsbCwgaXQgZ2V0cyBw
YXNzZWQgYnkgcG9pbnRlciBpbnRvIGkzY19zZW5kKCkgd2hlcmUgaXQgaXMgdXNlZCBpbiB0aGUN
Cj4gdHJhY2VfaTNjX3NlbmQoKSBjYWxsLg0KPiBJZiB0aGUgc2VuZCBjYWxsYmFjayBkb2VzIG5v
dCB3cml0ZSAqbnVtX3NlbnQgKGFzIGlzIHRoZSBjYXNlIHdpdGgNCj4gbW9ja19pM2NfdGFyZ2V0
X3R4LCByZWZlciBteSBwcmV2IGNvbW1lbnQgZm9yIHBhdGNoIDE4LzIyKSwgdGhlIHRyYWNlIG1p
Z2h0DQo+IHNob3cgZ2FyYmFnZS4gSW5pdGlhbGl6aW5nIGl0IHRvIHplcm8gbWlnaHQgcmVkdWNl
IHRoZSBjb25mdXNpb24NCj4gDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rp
b24uDQpJIHNlbmQgdjEgaGVyZSwgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L3FlbXUtZGV2ZWwvbGlzdC8/c2VyaWVzPTEwNTk3NTcgIGFuZCByZWFkeSBmb3IgcmV2aWV3Lg0K
DQpUaGFua3MsDQpKYW1pbg0KDQo+ID4gKyAgICByZXR1cm4gaTNjX3NlbmQoYnVzLCAmZGF0YSwg
MSwgJm51bV9zZW50KTsgfQ0KPiA+ICsNCj4gPiAraW50IGkzY19zZW5kKEkzQ0J1cyAqYnVzLCBj
b25zdCB1aW50OF90ICpkYXRhLCB1aW50MzJfdCBudW1fdG9fc2VuZCwNCj4gPiArICAgICAgICAg
ICAgIHVpbnQzMl90ICpudW1fc2VudCkNCj4gPiArew0KPiA+ICsgICAgSTNDVGFyZ2V0Q2xhc3Mg
KnRjOw0KPiA+ICsgICAgSTNDVGFyZ2V0ICp0Ow0KPiA+ICsgICAgSTNDTm9kZSAqbm9kZTsNCj4g
PiArICAgIGludCByZXQgPSAwOw0KPiA+ICsNCj4gPiArICAgIC8qIElmIHRoaXMgbWVzc2FnZSBp
cyBhIGJyb2FkY2FzdCBhbmQgbm8gQ0NDIGhhcyBiZWVuIGZvdW5kLCBncmFiIGl0LiAqLw0KPiA+
ICsgICAgaWYgKGJ1cy0+YnJvYWRjYXN0ICYmICFidXMtPmluX2NjYykgew0KPiA+ICsgICAgICAg
IGJ1cy0+Y2NjID0gKmRhdGE7DQo+ID4gKyAgICAgICAgYnVzLT5pbl9jY2MgPSB0cnVlOw0KPiA+
ICsgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICogV2UgbmVlZCB0byBrZWVwIHRyYWNrIGlmIHdl
J3JlIGN1cnJlbnRseSBpbiBFTlREQUEuDQo+ID4gKyAgICAgICAgICogT24gYW55IG90aGVyIEND
QywgdGhlIENDQyBpcyBvdmVyIG9uIGEgUkVTVEFSVCBvciBTVE9QLCBidXQNCj4gRU5UREFBDQo+
ID4gKyAgICAgICAgICogaXMgb25seSBvdmVyIG9uIGEgU1RPUC4NCj4gPiArICAgICAgICAgKi8N
Cj4gPiArICAgICAgICBpZiAoYnVzLT5jY2MgPT0gSTNDX0NDQ19FTlREQUEpIHsNCj4gPiArICAg
ICAgICAgICAgYnVzLT5pbl9lbnRkYWEgPSB0cnVlOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAg
IH0NCj4gPiArDQo+ID4gKyAgICBRTElTVF9GT1JFQUNIKG5vZGUsICZidXMtPmN1cnJlbnRfZGV2
cywgbmV4dCkgew0KPiA+ICsgICAgICAgIHQgPSBub2RlLT50YXJnZXQ7DQo+ID4gKyAgICAgICAg
dGMgPSBJM0NfVEFSR0VUX0dFVF9DTEFTUyh0KTsNCj4gPiArICAgICAgICBpZiAoYnVzLT5pbl9j
Y2MpIHsNCj4gPiArICAgICAgICAgICAgaWYgKCF0Yy0+aGFuZGxlX2NjY193cml0ZSkgew0KPiA+
ICsgICAgICAgICAgICAgICAgcmV0ID0gLTE7DQo+ID4gKyAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICByZXQgPSBpM2NfdGFyZ2V0
X2hhbmRsZV9jY2Nfd3JpdGUodCwgZGF0YSwgbnVtX3RvX3NlbmQsDQo+IG51bV9zZW50KTsNCj4g
PiArICAgICAgICAgICAgLyogVGFyZ2V0cyBzaG91bGQgb25seSBOQUNLIG9uIGEgZGlyZWN0IEND
Qy4gKi8NCj4gPiArICAgICAgICAgICAgaWYgKHJldCAmJiAhQ0NDX0lTX0RJUkVDVChidXMtPmNj
YykpIHsNCj4gPiArICAgICAgICAgICAgICAgIHJldCA9IDA7DQo+ID4gKyAgICAgICAgICAgIH0N
Cj4gPiArICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICBpZiAodGMtPnNlbmQpIHsN
Cj4gPiArICAgICAgICAgICAgICAgIHJldCA9IHJldCB8fCB0Yy0+c2VuZCh0LCBkYXRhLCBudW1f
dG9fc2VuZCwgbnVtX3NlbnQpOw0KPiA+ICsgICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAg
ICAgICAgICAgICAgcmV0ID0gLTE7DQo+ID4gKyAgICAgICAgICAgIH0NCj4gPiArICAgICAgICB9
DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgdHJhY2VfaTNjX3NlbmQoKm51bV9zZW50LCBu
dW1fdG9fc2VuZCwgcmV0ID09IDApOw0KPiANCj4gVGhpcyB0cmFjZSBtaWdodCBwcmludCBnYXJi
YWdlIGlmIHRoZSB0YXJnZXQgc2VuZCBjYWxsYmFjayBkb2VzbnQgc2V0IGl0DQo+IA0KPiA+ICsN
Cj4gPiArICAgIHJldHVybiByZXQgPyAtMSA6IDA7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBUaGFu
a3MNCj4gSml0aHUNCg==

