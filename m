Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0BAF436B4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkVf-0004xe-5n; Fri, 17 Apr 2026 10:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVc-0004vX-TI; Fri, 17 Apr 2026 10:49:28 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVb-0007Cr-Cy; Fri, 17 Apr 2026 10:49:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIxtnGUcV3R3HxTFXZTp22GjH3XfWeE0RrkHlUMCAOTZAMDWJmrwcqg8Y9Xc3MSHxqroh9EO4QzvsAtNiJ1z1SsTRmnJkUCsaCSErae+FPFOJLDb4nEyzp45W4jFobNsj81NJr7vFcfYF52x8WiehF0f+DQgA086KJJNNN4oEpGTpn1Kn14IaNGdYppvn5vTUpPs47hm3gLGqGb4f02WGC8q2mnP2iu3ddKPsCEF6ZDJBZ6RHq0wAPAvejjGZTrokvAuG/wsLz5qAc3+2J7tEzR2oIjsNqghg3jRgySVzmCch2veYhv4UcUSYMfRdarjHrbtPc132ucgVV/IMXT4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=LhmiXBoRiLOiHTY3QW1x3fBifP7bxoTfFkig7LRLQaH168AX9HLb3bEY0uBQ5o0sRtH7WFGUjgRZcToWCqs/j2QUMNSucRGzQzS8yIZ12n/gLjERprNn6CwrttQd0N9kEFgt1t0JUEcnUDHEakvGjRW1Wsx0RMMnjPfH3JWZZQYPLeQcnW5NfcE2+slFnL6BlBsOGJ6LDZHftcFgAHWPirFX42UXizm5nmofWI9RNXTHJuF6/ICkA1brOq9E1ViX1sl+1tMNegmPvJLjMz5UbCyry9HPM8RV5ujgk3UqFdrc50gjpxDitcH5ZBxOHp7GmkKv6or63Gi6Cs/GMlDfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=DXTSTKTeVvdNlKI8WDJj2j/GDOnMy1FvMEdX7tUJHGkDIHr1PTTuUNvSX2nfUcbo7rD16v7aOg/OhYW5HVjr7h3LC1hVsWits/H3Jjh6ykbzGLVHArUQQ84p2qiNYFJlPPaH9op7jkvAqa1+3ZcfocuuuZTuf6VgQrPHWnn5QhFbPtZtJdNnk/XqvvVt0X6UMbNkk1LrkH7FDitER7MJfs+lZJAjnbaaQCO3ornnWmjm19Jwe4PpIxX0Hluwa4hQ1QVkbpvWjQhjDsb0kCBIOPaHTow6616y4h6ytGS/F0/280mrSSoy1O83blfmPpw9neu3mtOlKQC9bFrDO7vtkw==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB8150.eurprd09.prod.outlook.com (2603:10a6:800:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:49:14 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:49:14 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 5/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Topic: [PATCH v8 5/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Index: AQHcznlbFaOs6yoF8ke8J7vJguSfcA==
Date: Fri, 17 Apr 2026 14:49:13 +0000
Message-ID: <20260417144905.178056-6-djordje.todorovic@htecgroup.com>
References: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|VI0PR09MB8150:EE_
x-ms-office365-filtering-correlation-id: 19218b47-d457-442b-7cb9-08de9c907e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: o4p/cpZ/wY9vdNlK0KwA0FuER2sC5KGHnCuxphaRJ2cubPeiS/AYDuEOA1Ai5i3CzdMeaHT3eH5dhOLzJTOQO9C6pN8gkhyALtU20lcrD587niMGHtwgCVI1s7VN9H6Lm9cpV5GrE1AUniuGIDDuUTV24RrPf9Ra5C0g/Z4VcgEq4Z1j+gfWTMl78GhbNil4jxZhXMbnUfYnXY3QaGc12J+KR7ZM6gwbxtgJ5us6E+d8fSoBP2Rc04xoDwAQGu1R+MrQVKopD96YPm2NbRwCyVwZyJ5PNGZe3NpA0lm05vKRTFf+HVmrcToF4cvqhuiOdBT6d5SfXc2profTpxWCqCFaRneHDveX3/wO0FR5Lx2+mPTvETUdIdM1paGFhJ3dwvpoukyodpwWXBQH+gzyJHbznIM8FA6Ag72XoT7LmmHb0NgsbDvJeacDQAswR5Z78ZlUa44+1iX0NLNhpYOCpTl6v2XIHP55Sxu2EDM/PYSlAolFpJSUU8+aeXBbRadumCkUpdMoP+avCaLiOSyzO5mkFLWsOeYP9dDbbx/B05dJVlK35Q9PGfJqRMwowESlbs5geYucwWTZZjT38MSC2utnEFrpnElMdT/AtfudG7kTrcj2SRU02niWfGhL1AmiM1AX9Cdr4dmAfua6kYyNoX+1oKex37FAC2eN1j5TD1nka6Bod1URwD9V3dpn/uifKED5JCg7t7VL8zlrgQ8ovEdNZ3AMyRf8kj7XIPmQHLiSCOq7vrgAC/CP2lXLhFQEiy+aXOYjpkCzCLCuIixMjCMg8HLMY2qeJQFgf8ZxLgk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW9WTm44bzRoMzJBR0FQZGhiS2NjWGZPY0UwbXBFMmsrakNNend4c1diZ2hZ?=
 =?utf-8?B?YTRPbHdQa1ZYUVR4bVhsSEUvY3VzZFFoZXA3dXF0YVY3a0tZbk9tV1EwdXhz?=
 =?utf-8?B?bUYzRURsUzl4VGRJa2VPdTc5UGpTc1ZUSDNOUWt5d3VGZUxBTXgwcnh2L3Z0?=
 =?utf-8?B?Y295S3E0bkVRT2NUSGxsRzVnamRVUS9jS3dSdlhZWE5Rblp4a3hadmtuUFJj?=
 =?utf-8?B?bG92dXhCcVNRNktuVTMrSEk3L3RweDl4QkorL3krRWV5QzNBaVZ5NS9SSkVi?=
 =?utf-8?B?SHovK2V3RDFiRTJHZXl0ZENSc1V2K2ozYk9SMUVNUzlqMkpxVnAwUTM5K21N?=
 =?utf-8?B?L2VqZzFMUTMzYmlMV1hwbDhWMzJWaTZvNVpYZ04ybFI4RC9Id0tpTVpObU5F?=
 =?utf-8?B?TFBKQUZTbmdDa29hdTU4OEFyYjdrb01rUThJVjlzenpHaXE5OGsreVZRSUpF?=
 =?utf-8?B?QUpoa3B4NHQxVk8raWwrMDdvTVB0RkdGMGFjTGFySDV0ZGwxMGg1bllqSitV?=
 =?utf-8?B?L3Nvd2JkYW1MWlFReEkwNXduN2lkT2FucDRtWWdNNFY2bmFmTkZheHM4Smxw?=
 =?utf-8?B?MWVyWEdqZGw3YjFHbUxpZEJMSUFSZ3FHdjVGVDljYlZHYXhkV0xrNXZXNWxS?=
 =?utf-8?B?TUVaZFVsQi90bkF1T2Q3YS81ZUNyQU8zSTlWM3JqbXpiVEZvYUhnLzhqNE1N?=
 =?utf-8?B?M3RObzVLeXlJTkJrUytEdHFzT3ZIa0dNY2tYeEpML0ZaK1VTUm01Z1pvL09o?=
 =?utf-8?B?QnNFemMyVitLcjF6azk3T2FnMjEvVEJQQU9JU1MwdElWcGxNYS92Zkx0eERD?=
 =?utf-8?B?RVBEYjRZUmVNMU1QRWVFR2QrRkFOc05MSXF2a2NMVlZXUkRsdkZOZmFHeHJw?=
 =?utf-8?B?UHRjZmZJN3dWMXZyUEdzWWN4bkR4N3Z2K29CQktiUFAzcDBJTWZjSUlSTC9a?=
 =?utf-8?B?OEdpLzIyRHQrcHk1T1Q5Q0VEUTl6eVU2UUdGYzZXUy9LLzAzQVdoM2FJNDJV?=
 =?utf-8?B?aXpyb0NtZHNtRld1ZVRtYTlBK1lWYVlxMndQZlg1YzByTWFrQXhwTDJKK1k2?=
 =?utf-8?B?REU5T0NOZzhNL3c5eEU5ZFBpd1g5THJKaVdwUFpXVGZ6dXJYVWlRcmlNdHVr?=
 =?utf-8?B?NW15K215ckJnNnd6TDFMUlJGeUdmeG9sNndnaUJ2UDFKU2NjVDRaV3BCMEQ0?=
 =?utf-8?B?cVdIbHZ1VU5heDcvdFAyb3BJUFh4TTNPQWNHdWZQMldqTHhzRkZhRlcrMk5i?=
 =?utf-8?B?MXpQb0hEZk1VaVhWbXdDRDY0YUFZdENvb1hDYVh3VFFKVlEzbDcvenFSSjNt?=
 =?utf-8?B?NkF2eTVGZ0NJZWgzTmc0MFlTVjFPOEdlWjBaMGV5U0twcEM5UStuRlpNM1g2?=
 =?utf-8?B?Y3BUeXBEait3eURXaUVLNENxWitBMU5ISFFxMCtkbHo2TThpT0t2K05mdDZJ?=
 =?utf-8?B?ZmVabW5YMVZvcTBjS1JKSzd1NEp1OEt0QWVsdTM5blFaTVZsQ3Z0eGZoVmRD?=
 =?utf-8?B?YTdzU0V6SVhON3k0ajFGY0NpcXh0WERJVE5Nd1Bvb1VWazdvbUtPOGthVGM5?=
 =?utf-8?B?STRMTHBKdlVXSUpnb0VKMnlvQmh6TlE0c0lHY2dZa21jQkpId25GdEptNUZr?=
 =?utf-8?B?M1U5TEVEVzlVSm80c05QOUd2NkxhM21XMDNMOUNuTmhEMEhMc0ZBZDVlZytv?=
 =?utf-8?B?bllGYW5rb1lJc3h4VzFIcjI3Sm96NnJDaUsxUndnS1lDK0dVbHBhbjVsYVN1?=
 =?utf-8?B?TEN2NE5VWnhma09LTnpiQTk1aTlyY2hLQTZjeC92U1gwWjN4SkcxMGJyM0pN?=
 =?utf-8?B?cTlZM1J0MFA5NlJabkMvU1hkTlRNMmVBZFAxS3BvTlFPYTdJbXR2SEt3MVRW?=
 =?utf-8?B?SUsxbXZaM1ZFUDYvYy9ibjg0N2JSZWJjWW5KQ0RvQjhIUGdEbU80SlZTcng5?=
 =?utf-8?B?L1N3QTE2TGRWa1hzQ1d2YXd0K3NsdnFidjBkQmlBeTFHeWIxNDlVNDFIS0o5?=
 =?utf-8?B?Y3BXY1ZZSmsyVG14Z2YxYlJtcEowT3ozMkk5UVJVTTNNQ09yc2N4djZOT3Y0?=
 =?utf-8?B?ZlVuR0FrTUppcnpBTHJpVmgwTTFYYUlhQXJFbEIzWkN4QWNFT0FKa2d1WHNh?=
 =?utf-8?B?MHBWRWo1ZjNsMFE3ekhhSDFwTUsrckxXYlpUMmJHd1UyS0E2bFJOVjMwNzFr?=
 =?utf-8?B?Rm5YaGtjdEJxcDVJY1pqREVWWm1wNHoyNm1QMXcybjBBRFhsZm1ObVkzWFdE?=
 =?utf-8?B?WGc5QTJSdHNBcW81RzFTelkvU0xxQ0ZPZWRGaTZTOS9Mdlk2Mmo5VXBzTTdD?=
 =?utf-8?B?N1V4TFkvTGRVWFRnNmpSV1NMNm1PY01VSVNwbS9LQkxPSDlpc1d6NWZPWCtF?=
 =?utf-8?Q?kp/DfCVrBqUVXh8CCN7r7GFH/HidLOHVQfSx9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84FD844A31FCF04FB44BB770CDF8E204@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19218b47-d457-442b-7cb9-08de9c907e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:49:13.9997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3C/s8D7C2vnruzOsIAOaNB6th6qOPlYR+2j8yVC4RTzFZEFs6x376YHLdZVSmYwp1FEnAz12ys63smJeFZRPuiUXKjrkhNDiUI2JVu0rEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8150
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

VGhlIHBhZ2UgdGFibGUgd2Fsa2VyIHJlYWRzIFBURXMgdXNpbmcgYWRkcmVzc19zcGFjZV9sZGwv
bGRxIHdoaWNoIHVzZQ0KY29tcGlsZS10aW1lIG5hdGl2ZSBlbmRpYW5uZXNzIChhbHdheXMgTEUg
Zm9yIFJJU0MtVikuIEhvd2V2ZXIsIHdoZW4gYQ0KYmlnLWVuZGlhbiBrZXJuZWwgd3JpdGVzIFBU
RXMgdmlhIG5vcm1hbCBzdG9yZSBpbnN0cnVjdGlvbnMsIHRoZXkgYXJlDQpzdG9yZWQgaW4gYmln
LWVuZGlhbiBieXRlIG9yZGVyLiBUaGUgd2Fsa2VyIHRoZW4gbWlzaW50ZXJwcmV0cyB0aGUgUFRF
DQp2YWx1ZXMsIGNhdXNpbmcgcGFnZSBmYXVsdHMgYW5kIGEgaGFuZyB3aGVuIHRoZSBrZXJuZWwg
ZW5hYmxlcyB0aGUgTU1VLg0KDQpUaGUgUklTQy1WIHByaXZpbGVnZWQgc3BlY2lmaWNhdGlvbiBz
dGF0ZXMgdGhhdCBpbXBsaWNpdCBkYXRhIG1lbW9yeQ0KYWNjZXNzZXMgdG8gc3VwZXJ2aXNvci1s
ZXZlbCBtZW1vcnkgbWFuYWdlbWVudCBkYXRhIHN0cnVjdHVyZXMgZm9sbG93DQp0aGUgaGFydCdz
IGVuZGlhbm5lc3Mgc2V0dGluZyAoTVNUQVRVUyBTQkUvTUJFIGJpdHMpLg0KDQpGaXggYm90aCBQ
VEUgcmVhZHMgYW5kIGF0b21pYyBBL0QgYml0IHVwZGF0ZXMgdG8gdXNlIHRoZSBleHBsaWNpdCBf
bGUNCm9yIF9iZSBtZW1vcnkgYWNjZXNzIHZhcmlhbnRzIGJhc2VkIG9uIHRoZSBoYXJ0J3MgcnVu
dGltZSBlbmRpYW5uZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpv
cmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4IGMy
ODgzMmUwZTMuLmIzZDMzZGExM2UgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBl
ci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtMTM2NSw5ICsxMzY1LDEz
IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBo
d2FkZHIgKnBoeXNpY2FsLA0KICAgICAgICAgfQ0KIA0KICAgICAgICAgaWYgKHJpc2N2X2NwdV9t
eGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nfc3BhY2Vf
bGRsX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAgICBwdGUg
PSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAgICAgPyBh
ZGRyZXNzX3NwYWNlX2xkbF9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykNCisgICAg
ICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkbF9sZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRy
cywgJnJlcyk7DQogICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nf
c3BhY2VfbGRxX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAg
ICBwdGUgPSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAg
ICAgPyBhZGRyZXNzX3NwYWNlX2xkcV9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykN
CisgICAgICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkcV9sZShjcy0+YXMsIHB0ZV9hZGRy
LCBhdHRycywgJnJlcyk7DQogICAgICAgICB9DQogDQogICAgICAgICBpZiAocmVzICE9IE1FTVRY
X09LKSB7DQpAQCAtMTU2NiwxMiArMTU3MCwyNCBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9h
ZGRyZXNzKENQVVJJU0NWU3RhdGUgKmVudiwgaHdhZGRyICpwaHlzaWNhbCwNCiAgICAgICAgIGlm
IChtZW1vcnlfcmVnaW9uX2lzX3JhbShtcikpIHsNCiAgICAgICAgICAgICB0YXJnZXRfdWxvbmcg
KnB0ZV9wYSA9IHFlbXVfbWFwX3JhbV9wdHIobXItPnJhbV9ibG9jaywgYWRkcjEpOw0KICAgICAg
ICAgICAgIHRhcmdldF91bG9uZyBvbGRfcHRlOw0KKyAgICAgICAgICAgIGJvb2wgYmUgPSByaXNj
dl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudik7DQogICAgICAgICAgICAgaWYgKHJpc2N2X2Nw
dV9zeGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgICAgICBvbGRfcHRlID0gcWF0
b21pY19jbXB4Y2hnKCh1aW50MzJfdCAqKXB0ZV9wYSwgY3B1X3RvX2xlMzIocHRlKSwgY3B1X3Rv
X2xlMzIodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9IGxlMzJfdG9f
Y3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCBjbXAgPSBiZSA/IGNwdV90
b19iZTMyKHB0ZSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9f
bGUzMihwdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWwgPSBiZSA/IGNwdV90b19i
ZTMyKHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGNw
dV90b19sZTMyKHVwZGF0ZWRfcHRlKTsNCisgICAgICAgICAgICAgICAgb2xkX3B0ZSA9IHFhdG9t
aWNfY21weGNoZygodWludDMyX3QgKilwdGVfcGEsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY21wLCB2YWwpOw0KKyAgICAgICAgICAgICAgICBvbGRfcHRlID0g
YmUgPyBiZTMyX3RvX2NwdShvbGRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
OiBsZTMyX3RvX2NwdShvbGRfcHRlKTsNCiAgICAgICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAg
ICAgICAgICBvbGRfcHRlID0gcWF0b21pY19jbXB4Y2hnKHB0ZV9wYSwgY3B1X3RvX2xlNjQocHRl
KSwgY3B1X3RvX2xlNjQodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9
IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB0YXJnZXRfdWxvbmcgY21w
ID0gYmUgPyBjcHVfdG9fYmU2NChwdGUpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA6IGNwdV90b19sZTY0KHB0ZSk7DQorICAgICAgICAgICAgICAgIHRhcmdldF91bG9u
ZyB2YWwgPSBiZSA/IGNwdV90b19iZTY0KHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9fbGU2NCh1cGRhdGVkX3B0ZSk7DQorICAgICAg
ICAgICAgICAgIG9sZF9wdGUgPSBxYXRvbWljX2NtcHhjaGcocHRlX3BhLCBjbXAsIHZhbCk7DQor
ICAgICAgICAgICAgICAgIG9sZF9wdGUgPSBiZSA/IGJlNjRfdG9fY3B1KG9sZF9wdGUpDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA6IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KICAgICAg
ICAgICAgIH0NCiAgICAgICAgICAgICBpZiAob2xkX3B0ZSAhPSBwdGUpIHsNCiAgICAgICAgICAg
ICAgICAgZ290byByZXN0YXJ0Ow0KLS0gDQoyLjM0LjENCg==

