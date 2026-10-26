Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76651606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=AO6WEs9v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJpn-0008E1-Uz; Mon, 26 Oct 2026 08:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xLJpl-0008DF-Nz; Mon, 26 Oct 2026 08:29:49 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xLJpj-0008GX-J1; Mon, 26 Oct 2026 08:29:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE7qQcSb/mpbA4tFMYjtahhZqcobTjVqnVO9Wg7h7iIRMjLvlx+zeBq0aObYVcRQp71t3VMzUyW65YhFuVrsc0/ZAWz8TmAEuFxhib6JFiqHmB9+jU6i4s6Dz/nKUGm0ezYz4/vFGbSQ1TFoF5ZWu3IC+NveHnhOm90kawVCaiaKzelCHy4X8uGsJZDZq0MeHk018EyPhCrdb+cHPXZCr8vE8iGkMMhWBM1idiUBb4hJJXAgM/Q+BAC7+zYPXfWuFvllDNrTe/09ONplk/9zba0Kq5Lbm3a/YR236qsy9xTzNI2LHjhYEchKJHfueUFsIlk6pSjXSUu4ElXQ+y5XTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3x9UpGyuupqFWZgLqfTVmb3dZAd80JOVSRXmXTo+WA=;
 b=B3pE6bPFW1SfdGXY6P9VjeGkTin6geuMW48/eMc0xyCaHJT9gYvVXOXUhD46+MTtY//0fSYzXM3Zqyv2bFWY3y5lpu6eKj8MoIHbAo5Q0eH4VImIxbmXwvpT8CAf/TIFCZr5f0Z3yPtpDJzkizMeeilNfTMYoTVK7TT+9uSpIvOkv0FEZdfDfjYsy6dKLSAaZtvA5Q3EI1Wiay+ySeO//OFwK+VPoP7VwgtCUjJVrxNWKm2y9/Dgi/M1GJQRK4Oz1gXiX95ln7C9dqXd2AT/oqjPfIsnOUALnx9NH5DnSYvwLWNjMldCcuhLEz0g/cA9dnAACH6b4WktzOzQ0Bx0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3x9UpGyuupqFWZgLqfTVmb3dZAd80JOVSRXmXTo+WA=;
 b=AO6WEs9v0lWYq81FsodPQUj0LPujLFAg5JWGhtcJXfzWk7K1pBTkEE4YAuqN+EBFEXb5ljVyyOCAWzid5GuEbt5rPJWFkD5Uyoct/PdFRt1NmLSvEMyVOBsnumIBlrjOx2HFHQu/Alq782B7wazfLuSZPOZmfCp322Bne9yJdnhyOkJaEFX63TqJMk2KhoU386sh9u3FY70qjReR1xNr2VWAJHYfzUQDQtH8f4zw4biNTo5LI9dZI5HQ4ELwsMRZLH1tT/JGC/gJLGdHRS6lkAvBkxkUQWZ/ozHmqd0ig20wiNFZsFoPIvXlHhNHeg4yZ3qO8ZFqNir3oDQVmqHAZQ==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:29:41 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 12:29:40 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: QEMU <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
Thread-Topic: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
Thread-Index: Ad1kUFII4MKnDgaKRE22YiQ/acy/SwAFsFQAADP9ZyAAApnzgAABA1Lw
Date: Mon, 26 Oct 2026 12:29:40 +0000
Message-ID: <DB8PR04MB717745592F89F86226B7E73787612@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA-dpfXTLk9KNJ0OsOEaCYppcZLLgcnOCqhUXmOVE2jfaw@mail.gmail.com>
 <DB8PR04MB7177409A95BDC85AC5446A6687612@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA_BNjFC4vEJ2h62NytzYQXKE0o4MvB2jpN74S05kHRLMg@mail.gmail.com>
In-Reply-To: <CAFEAcA_BNjFC4vEJ2h62NytzYQXKE0o4MvB2jpN74S05kHRLMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-26T12:28:23.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|VI1PR04MB6957:EE_
x-ms-office365-filtering-correlation-id: 6121379f-b5e3-4b4e-f855-08df335cceb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|23010399003|1800799024|18002099003|22082099003|3023799007|4133799003|56012099006|11063799006|4143699003|261021121427099003|10067099003|261009223027099003|261021135927099003|261022113327099003|261022075727099003|261021130227099003|261022115727099003|261022105027099003|261021123027099003|261021133027099003|38070700021;
x-microsoft-antispam-message-info: 9kmPOJlKSxHKN8vAEtKZEXPn0xM4gQuLO2Z8uEB+qAn1OwbNyTnMk/I3HwaP7AJEuFHR55RTUKY0xBpdAtZUs9Iln4cZ66GGzPjbqaG4cgiIOo01RC/D/2xXaolxclQNpHGPYcNt16Zvq4r5a3qQlOGusxm66wxqKKkSfm/gO5i9unCiDOB1+GWhuu/ziQL/QDZEkyOEnqtKuPCvlOyQ5fcu6wtvTupodg78+M/g2sWw5Su7+fDN0ba6gI+1EGCsq+3lNhThP085dWqyodFLG8u2xVSwOAYlD+9+EVXlSE1oN9U+3gb1qmtGkmviRCukQOKmnUi7IQI69eZJ4c2T8STJEIbuVPPQt5u6Z3Oy/vBYomken1Bkm+K0mA9KbJK3sZKdASoVozyeopJHupxt0c6fdbJHJgiedqsGLe7GduZ4KaBhBjsH64wwcpp1OKz8rvktr1WMLFWp+WoWl1MICUGaPQeYaw3SYWb7Q9fpMU/zkZ7fhqWCB7v3sI2HfSIGla5wHVi0BuEgD2zWEV1YfPCNt6wxrA3AseprBBpTIuxv9yjNJdcpC8wcpSQVUcWmXHEzTpJ+m3sYRiLeicBFnGUFX612cQitLj1z6X6qwqi+qF/FBBN2kdXKfxFN9brhjvfcZSeEpG4USsBp4gYSvtP/zJSYl2tVzNvnvip7pDs9kljbv2afuRp68whPUP026pg8otVp0XDFkLPDkhhEajjOUHKcr1K1yYKX4laVV04=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(4133799003)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003)(261009223027099003)(261021135927099003)(261022113327099003)(261022075727099003)(261021130227099003)(261022115727099003)(261022105027099003)(261021123027099003)(261021133027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0tQTGFPVnkyWS91LzMyMFBNUnhvQ2kwWjVwWjdSVytSZW90ZWJmejE4NjBh?=
 =?utf-8?B?b1lLOExCem1lSHdVRHpVQU5UbFErVmNNNjlLekdRSDc0eU5ydC9oRWdrTDZ2?=
 =?utf-8?B?MHQ4aXJjRzRMK0tTY1pta3hQR1dlcmZ3bGZmS0YrekhzUFIzS1pwQ2dVSko0?=
 =?utf-8?B?R2xpcTRoMG8veStZOFBUT1U3WHVwZzM0VHNDTzJhVVNSRUJyZmVFV09oYTFs?=
 =?utf-8?B?ZWRHb25VTWlXNmtoNUVRYi9aM254RTBDY0duRGNUbEtoclBrSXJBVDkzL0dM?=
 =?utf-8?B?VVV3cldESFQxZ1o5OCs0ajdpaUFoL0lUZUtsMnQyREhmbWlFdHNXN0lmY1Rj?=
 =?utf-8?B?SHJHVGh2a0l4T0J3SVJDT0UxVDhhVmVZeHZWWk1hRGk2ZTFEY2c0ODFFTXQz?=
 =?utf-8?B?TlorbXhpazAvZzZGaHdvUXRJbVZhcFFPekNoUjJld3hLSk5JSndvd3JCTnpx?=
 =?utf-8?B?czJxS1dMV2lQRWJxbFRoaFpOUWI0STNaRUI0ZGFBcXA3dGppTnNCVE5FZExq?=
 =?utf-8?B?eGJzV3ozVHJmRTNBUUZoNFpBTmJkWXVPVC90U2NRdEVZSG5DamE5UGkyMmt1?=
 =?utf-8?B?bUFia3VSdTNWTWY3WmJWYkFqNXlxcEZGcGRjNmJ2ZFRQa1ljRmRZaDFiWk55?=
 =?utf-8?B?cnlGQzVFRndOSVJCWm0yM1pCNzBUWER0dHRxbGdxbHpiYXBmc0ZwZnUxMDAz?=
 =?utf-8?B?YUNYbHIvNCtyc3Z5Um5JYkJhZysxUHkxaEgxeUhYVHJQQURyMDIyODZLdmo4?=
 =?utf-8?B?WFpjcUtJNUpMdkVVQ3ZSUmVQNVVaR0R2NGZYa0dWNXJTSVdYMmZhdSsybUl4?=
 =?utf-8?B?d2V1aGF0c0FFRVBwaUgrWEpndnpIa3BlMG5NakhJUk5YRDZjakVsZEZMSm50?=
 =?utf-8?B?NmdmYVlYVGpETG5hYUxIWS9WcGQvR1A3bmZ3c0dwT3Nhbnp5bmNFWFllbm9z?=
 =?utf-8?B?MWJGTHhMMjNEdnB0S3BYMmFLWEZxcmRmTTF3Q01WY252NlR4Sy9uQ0cvaERU?=
 =?utf-8?B?K25Mc21zVkcraE1RRDA5ejg4b0lkUnRlTTJiak05TXZ2V3VaZllaZytMcTF1?=
 =?utf-8?B?NnpSMGZRSitKL2ZGRGtOZ0FQUnF5dGJTY2w2dGl4dmNaMlliaXZxKzVRTi9C?=
 =?utf-8?B?Znd0UE95NEdybkNHeTZwcEtMRVFHYlkweURGemc0NE1RbDFyaW1ONEkzU29W?=
 =?utf-8?B?NDlUdEdVMlFkK0RKV2VBZ05odlAzb2ZYVnk0NUZocXhRU0duQjNMQ2N2RTEr?=
 =?utf-8?B?OGJ4OTFad3RVRHI0TXllU0E5d1R5U1djbElHdVZ6WGd4TGM3bkJBemhycXMw?=
 =?utf-8?B?WjJmQTRnQkJFS3J4RVRCeW1RaEk2K25TZHJNU1NERlVWcWQ5RTQ1cFZ0RFZT?=
 =?utf-8?B?OXNpOHVoWUltT2hLS1E0ZXRLTXJGbkRIclF0L05yMUN0TkJ2azdSL3lJWW5x?=
 =?utf-8?B?R0FXV2hjWFFyTFpBaDRMcVByTi9mSVhiSHFSTU95cmhNV2wvRS80MGU0RlF3?=
 =?utf-8?B?MWcweXJSSzFDbVdveC9Xc1JRKzlyUzJmNHNsMEVnbXVBS25mNDd5emNTZ3FJ?=
 =?utf-8?B?VytlNjdCTFY3NTNDR1hYUHZseEh3R092Zi9KT2hvZ0pqd2tPTjhmcnFQSk5Z?=
 =?utf-8?B?enQ2bytEK3Q1MnRqeDZDVXpwdHFrSlhqb012UFNNVS9XZlk5ZDNGZ3k2aGVV?=
 =?utf-8?B?K2liOE1JVjhTc2wyUXlMK0dUZ21CUjNOeE5kT3pBWGQ5Z3NJNlJJQWdMdXZ6?=
 =?utf-8?B?b1dYRUFyeTdhTUh2NFEwUnV5OEtodW1jWjFTeHVTWmFPdW1OQm1oWlpObG5h?=
 =?utf-8?B?UUdYVE1PSGIveWVWclVjMTNGV1BzeWxxOENuODBlb3h0WVZMYncxV3liM1ls?=
 =?utf-8?B?M2lER05NQ3pFTkhacFh0NytjQmJGeERDTVFEZlJaK3FBVUIzOGMvcHRMZjB5?=
 =?utf-8?B?NTNoNkdza2J2T2RIMTJQS3BCL2lIQXRxM0dHNTdkOUFCQm82UHBxN3Y3Q1dm?=
 =?utf-8?B?UnNxZi9OZFRxZVp6d2hWa0w5TUxYNHVhcjc5TDdsamlPbmNLRnZueXRrZnZz?=
 =?utf-8?B?Y2xQaHpvdzlYRElMTXpUV0FvV0I1Z3oxVTJxNG5DNC9OZDFuYndUTHM4Wkd0?=
 =?utf-8?B?QnpiUlJpdzBkUTR1ZmkzOE1Ha240aU40NUljeUoxL25oZi9GRnZaUnZ0ZVFk?=
 =?utf-8?B?dVgxVVI5NUU2N3QweVNzeGlCMHlMT0ZvdmRFbDB1NUx3eERnYUdwUzJHNVlT?=
 =?utf-8?B?L05JNG95SjZKMGhLT1h0ckdJM20wL2NjM1V0MVBPOEVNazVkQ3hNcWlib1N0?=
 =?utf-8?B?cmIyYmRHMFVUN2UybkEwQkprYURVeWVvKzF3c2JUM2lBdDVxVmFQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6121379f-b5e3-4b4e-f855-08df335cceb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 12:29:40.6989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zW8hq8v/g4oF9i1t7MJZpiYm6lYjBr0qRoRQcPF0gxP+EiAlZDGlajhd6wG1nSRh8+CQliFIfuUEGENQvSsgmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
Received-SPF: permerror client-ip=2a01:111:f403:c207::3;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDI2
IE9jdG9iZXIgMjAyNiAxNzoyOQ0KPiBUbzogR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83
QG54cC5jb20+DQo+IENjOiBRRU1VIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBxZW11LWFybUBu
b25nbnUub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1JGQ10gdGFyZ2V0L2FybTogQ29y
cmVjdCBNUElEUi5NVCBoYW5kbGluZyBmb3INCj4gaS5NWDk1IENvcnRleC1BNTUgQWZmMSB0b3Bv
bG9neQ0KPg0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFr
ZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hl
biBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMg
ZW1haWwnIGJ1dHRvbg0KPg0KPg0KPiBPbiBNb24sIDI2IE9jdCAyMDI2IGF0IDExOjI2LCBHYXVy
YXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gSSBpbnZl
c3RpZ2F0ZWQgd2h5IHRoZSBzZWNvbmRhcmllcyBkb24ndCBzdGFydCB3aXRoIE1QSURSX0VMMS5N
VCBjbGVhci4NCj4gPiBUaGUgZmluYWwgRFQgcGFzc2VkIHRvIExpbnV4IGhhcyBjcHVAMCAuLi4g
Y3B1QDUwMCB3aXRoIHJlZyA9IDB4MDAwIC4uLg0KPiAweDUwMCwgbWF0Y2hpbmcgdGhlIG1wLWFm
ZmluaXR5IHZhbHVlcyBvZiB0aGUgUUVNVSBDUFUgb2JqZWN0cy4gU28sIHRoaXMgaXMNCj4gbm90
IGEgRFQtdmVyc3VzLVFFTVUgYWZmaW5pdHkgbWlzbWF0Y2guDQo+ID4NCj4gPiBUaGUgTVQgZGVw
ZW5kZW5jZSBpcyBpbiBPUC1URUUuIFRoZSBpLk1YOTUgYnVpbGQgdXNlcyB0aGUgZ2VuZXJpYw0K
PiA+IGdldF9jb3JlX3Bvc19tcGlkcigpIGluDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aA0KPiA+IHViLmNv
bSUyRk9QLQ0KPiBURUUlMkZvcHRlZV9vcyUyRmJsb2IlMkZtYXN0ZXIlMkZjb3JlJTJGYXJjaCUy
RmFybSUyRmtlcm5lDQo+ID4gbCUyRm1pc2NfYTY0LlMtDQo+ICZkYXRhPTA1JTdDMDIlN0NnYXVy
YXYuc2hhcm1hXzclNDBueHAuY29tJTdDZGQ1YTMwMThmNmUNCj4gPg0KPiBmNDNiYzhlNTAwOGRm
MzM1ODliZmQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwDQo+ICU3
QzYzOQ0KPiA+DQo+IDI4NjEyNzgwMTUzNzA1NCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpG
YlhCMGVVMWhjR2tpT25SeQ0KPiBkV1VzSWxZaU9pDQo+ID4NCj4gSXdMakF1TURBd01DSXNJbEFp
T2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MNCj4gMCU3QyUN
Cj4gPg0KPiA3QyU3QyZzZGF0YT1SVHFRYkVPYThzaUNQdmViaXNzSkJUalU5d2ZwRCUyRnklMkJk
NmJ5c2VNSGNPcyUzRA0KPiAmcmVzZXJ2ZQ0KPiA+IGQ9MC4gIFNvLA0KPiA+DQo+ID4gV2l0aCBN
VCBzZXQsIE9QLVRFRSByZWFkcyBBZmYxIGFzIHRoZSBjb3JlIGFuZCBBZmYyIGFzIHRoZSBjbHVz
dGVyLg0KPiA+IFdpdGggTVQgY2xlYXIsIGl0IGFzc3VtZXMgdGhlIGNvcmUgaXMgaW4gQWZmMCBh
bmQgc2hpZnRzIGV2ZXJ5dGhpbmcgdXAgb25lDQo+IGxldmVsLCBzbyBBZmYxIGlzIHJlYWQgYXMg
dGhlIGNsdXN0ZXIuDQo+ID4NCj4gPiBXaXRoIE1UIGNsZWFyIC0gT1AtVEVFIGdldHMgdGhlIHdy
b25nIGNvcmUgcG9zaXRpb24gZm9yIENQVTIgKGV4YW1wbGUgLSA4DQo+IGluc3RlYWQgb2YgMiks
IGxvYWRzIGFuIGVtcHR5IHBhZ2UgdGFibGUsIGFuZCBmYXVsdHMgZm9yZXZlciB3aGVuIGl0IGVu
YWJsZXMNCj4gdGhlIE1NVS4NCj4gPg0KPiA+IFRoaXMgaXMgT1AtVEVFJ3MgZ2VuZXJpYyBpbXBs
ZW1lbnRhdGlvbiByYXRoZXIgdGhhbiBpLk1YLXNwZWNpZmljDQo+ID4gY29kZS4gVGhlIGltcGxl
bWVudGF0aW9uIGlzIGFwcHJvcHJpYXRlIGZvciB0aGUgY29udmVudGlvbmFsIGxheW91dHMNCj4g
PiBpdA0KPiA+IHN1cHBvcnRzOg0KPiA+DQo+ID4gICBNVD0wOiBBZmYwPWNvcmUsIEFmZjE9Y2x1
c3Rlcg0KPiA+ICAgTVQ9MTogQWZmMD10aHJlYWQsIEFmZjE9Y29yZSwgQWZmMj1jbHVzdGVyDQo+
ID4NCj4gPiBUaGVyZWZvcmUsIEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgbm90IGxpbWl0ZWQgc3Bl
Y2lmaWNhbGx5IHRvIGkuTVg5NS4gQW5vdGhlcg0KPiBwbGF0Zm9ybSBjb3VsZCBlbmNvdW50ZXIg
dGhlIHNhbWUgaXNzdWUgaWYgUUVNVSBwcmVzZW50cyBhIGNvcmUgSUQgaW4gQWZmMQ0KPiB3aXRo
IEFmZjAgZml4ZWQgYXQgemVybyB3aGlsZSBsZWF2aW5nIE1UIGNsZWFyLCBhbmQgdGhlIGd1ZXN0
IHVzZXMgdGhlIGdlbmVyaWMNCj4gT1AtVEVFIGNvcmUtcG9zaXRpb24gaW1wbGVtZW50YXRpb24u
DQo+DQo+IEJ1dCBzaG91bGRuJ3QgUUVNVSdzIEFmZjAvQWZmMSBiZSB0aGUgTVQ9MCBhcnJhbmdl
bWVudD8gVGhhdCdzIGhvdw0KPiBhcm1fYnVpbGRfbXBfYWZmaW5pdHkoKSBzZXRzIHRoZW0gdXAs
IGZvciBpbnN0YW5jZS4NCj4NCj4gSXMgeW91ciBTb0MgbW9kZWwgc3BlY2lmaWNhbGx5IG92ZXJy
aWRpbmcgdGhlIGRlZmF1bHQgdmFsdWVzIHRvIHNvbWV0aGluZyBlbHNlDQo+IHZpYSB0aGUgbXAt
YWZmaW5pdHkgUU9NIHByb3BlcnR5Pw0KDQpZZXMsIHRoZSBpLk1YOTUgbW9kZWwgZXhwbGljaXRs
eSBvdmVycmlkZXMgUUVNVSdzIGRlZmF1bHQgQ1BVDQphZmZpbml0aWVzIHRocm91Z2ggdGhlIG1w
LWFmZmluaXR5IFFPTSBwcm9wZXJ0eToNCg0KICBvYmplY3RfcHJvcGVydHlfc2V0X3VpbnQoY3B1
b2JqLCAibXAtYWZmaW5pdHkiLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgKHVpbnQ2NF90
KWNwdV9pbmRleCA8PCA4LCAuLi4pOw0KDQpUaGlzIGdpdmVzIENQVTAgdGhyb3VnaCBDUFU1IGFm
ZmluaXR5IHZhbHVlcyAweDAwMCwgMHgxMDAsIC4uLiwNCjB4NTAwLCB3aXRoIHRoZSBjb3JlIElE
IGluIEFmZjEgYW5kIEFmZjAgZml4ZWQgYXQgemVyby4gVGhpcyBtYXRjaGVzDQp0aGUgYWZmaW5p
dHkgdmFsdWVzIGluIHRoZSBEVFNJLiBUaGUgVEYtQQ0KcGxhdGZvcm0gY29kZSBhbHNvIGRlcml2
ZXMgdGhlIEE1NSBjb3JlIElEIGRpcmVjdGx5IGZyb20gQWZmMS4NCg0KPg0KPiB0aGFua3MNCj4g
LS0gUE1NDQo=

