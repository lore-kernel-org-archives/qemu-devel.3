Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B85F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OK-0003Wz-0b; Tue, 24 Feb 2026 21:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O7-0003Po-Ds; Tue, 24 Feb 2026 21:12:31 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O5-0008Ty-Aq; Tue, 24 Feb 2026 21:12:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3J2MYuU3lXVP0ZbioHYhwdIx30QZY9OtQI4lEBzg0Xb6Veea8vqZarir9b1LzjdUxHFCPWjJAxM0mHOsC2tOKukvANRT5ctW/mppnhuxn4kWSvzHT21gNNmBf760gagXi9DaMzQziC3nsm74QOtyvOK+0Udfm8PmIrKTQPLI78YkZt4yrIFvWH0E+2WvX653FoSy0OUqd/nVW/tqwbg5WrcT49zRK5UWffCBspK23yaVLWnGIh9d0JqgI9HJvgWtrKVd5SVkjsKEfuPD/YDbaqgPrCTXOLIqv3wMPpsfnsy44wK9t6J88gBWFWCocvm2v+i3KOAJjdbi6VbeN8Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMxAsAYfx53AKhxN5W20oAsMBn07pjlGkco4igIC93I=;
 b=aljADYWGB4Wi2SmHRy/FQb0CPw+o469yQ0FiGApVcp5J/j4g6QfXhurHw/a3ak0xHCy7ogGQEcUZLrLHIJlD+V4GtSiDfGHqv/IpKdqC/nSsoqxuYOepxXQX+/zHr7DV3Ru4Cei5zp7w7PqF/z1d+tEUlqszPLeVs2j/uwFcYWwi7OQQtXnupeSbiVbDFrxqf4KnHtU/wYhmeEPtwYORD4tPJltAM5N6EOSRD3UmfhGJxc23HudOduCfhY/TzoQyNXPleKLFG99mhl2yp6irWLKi0lPj5XGXZzNI7FFeVR/a7st4eeky/if31jNjosM0RngW3xnn9h1p2TMOB4fTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMxAsAYfx53AKhxN5W20oAsMBn07pjlGkco4igIC93I=;
 b=mC2BcAgyO2irnhn5kpi2qvkv+lyfSfzoL559XvXnTAKp1rZ/31jtMiZwxELwx86st9U/Ozlu1GUEwdzIMuz7CqbBZ4ukqbXjmgHf36Yv4KJZDfEX91YKM70l5jTwXxR2OyuLpq2Us8jG6cx2fFU1FArJpcJJFTS9L1AxGDz9umLItZNdnI2HPZkdmT8LzE8y1EX9lR3+3UaMEjWvVnw0SrQAcCWTYfKZjUVml1QCgWNCteKcGPNrxHiA1RR49R8SlxegUdXJCMYNNC7AapwIAA1unMqYXziGwZNp1EwDltUkYRgNY49l5n9hVvO2v4EP5s7Ig9Rnel5oRZaaAdxzkA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:19 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>, Titus Rwantare <titusr@google.com>
Subject: [PATCH v7 11/22] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Topic: [PATCH v7 11/22] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Index: AQHcpfwrlv+meYUEOUeWigzYiQJI5g==
Date: Wed, 25 Feb 2026 02:12:19 +0000
Message-ID: <20260225021158.1586584-12-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8468:EE_
x-ms-office365-filtering-correlation-id: 7d482979-ba99-40d0-63d3-08de74134dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?J3sQvfXt5xjT0/8sRPcya0b0DLFbrLrlBrD6kbIgq8jsRMlHNb2L0//8jo?=
 =?iso-8859-1?Q?B48DlvQdetWs9jN+lFxufeQFQUXzaFK0aFn8ld1Pd0g9U1UxYVXNsj/RPX?=
 =?iso-8859-1?Q?UDuPjnO2bkvv2kfV2hQGwKoDV0rvSfcDQo6Wj6SEE5HBT7i62VamCRJ+CR?=
 =?iso-8859-1?Q?O296bA2d/0r4nYB09lom+QPY0NO4w5mJXX6b9I/WKUCq/+wKyIiDJv6T+L?=
 =?iso-8859-1?Q?LElnguv/6v9a6s/dMrP/aI9FIqb7sZxngrq1l/c3OH6uDGBZw/2slnFou+?=
 =?iso-8859-1?Q?dNfpkEgLukuGBIahf16EqII4qkBfJi6wQLJgrtVy9ORRg3cPwNB7efKkDN?=
 =?iso-8859-1?Q?HyWzz+49LJYRvy1vmsFWJ/VIIdQSh8jIic+zjIRhbhloOodzEsq0uFMBZS?=
 =?iso-8859-1?Q?bOtzXVs+Nmn5h9IAb1v2YVSg5uQB2M3HtlIrUiInXzQjLxx9+EIee7CA/y?=
 =?iso-8859-1?Q?w9Z3Zi9h+T07H6k6N2zXWAECaz++9NpIC54nRuYHJCdRfEL0NdrWFXHYoi?=
 =?iso-8859-1?Q?I92pXTEsnWVGyamv+V/3k/vn/CzpLC0Bv4FfhTlEvylj1Qb7CK/ijXNeQV?=
 =?iso-8859-1?Q?yUUdAQtS9uuLFQ7kfowQMR0TpWOPmCCnjlm+VcvtvQgOam9kZMeL9WYtNJ?=
 =?iso-8859-1?Q?sowWXXRVBM3Bx5Z7HS5WeRS1CR+pHtMWYhLnfiB48diKGahMTlAuXg2hAo?=
 =?iso-8859-1?Q?Hz0gY1Wpt7H7clrhzuHq6ty4erd/EHvrjRzohMNnVx5pNSAb8EhmN/91+u?=
 =?iso-8859-1?Q?1f5j1haBja8Ob7v6NM5kca3ig20lzCm6l/ZkmPergTes4BkA/LjcVWsgLp?=
 =?iso-8859-1?Q?IKnmr0jf0H3vhCqU/iw+/5HGWTnkPOgU9mgdG9Qcs2vg8q2U9bv5YZS49H?=
 =?iso-8859-1?Q?+83RCaeYEzVXpSKCwbk53rPZmdgV9mecqGloFnIs478DDsTEbbZfe5MiGa?=
 =?iso-8859-1?Q?1OYy4AkhcRIoRBPLwucDvpa0QEg43HIfcMhkcUVghV6OG/vQzNIxAl123c?=
 =?iso-8859-1?Q?i1mAAx/Ue5NCS8hKJiaZo2NZPiHqg1lQgDHnqPhrrfBc6gC2c7v6Ii7eyZ?=
 =?iso-8859-1?Q?nN9ZpLs+HOu4kzwEu/EkdIGd713lJr3D/fYxWZ9HU2/JkYvqM5UGqXo+cg?=
 =?iso-8859-1?Q?PAS8AYPldKDQHZ23wZPwhcJdHeZmbLv1QKrsk4thvL8Ni8caZnwlEwjfrp?=
 =?iso-8859-1?Q?S1bffZjFOi6fVska8mkdx5Z6fHMEBg0MNfl81p0wiOUGUKKeorCbnMoBY2?=
 =?iso-8859-1?Q?ASmsm9MzfikMv2mr4xvXgtXs7r97a4F1RPaPIonPa5SbE72WLYVjS4Dfzx?=
 =?iso-8859-1?Q?xXTUZ6H2Yy6ii94bNq4KVZroGh4qxKSLlGypp5O6AmsOPiBk4KC36NMDS6?=
 =?iso-8859-1?Q?+Hp/NaLCqWWSF29uX2koKiX6Pnna7C4rmQ7pZHBvghFdAE/JHxfm3S3FyC?=
 =?iso-8859-1?Q?jHgHJq69A8ODIcOUNAb+s8DufGMwZldUzeTCIO8eFMD5SAF4nPSV8BCs9V?=
 =?iso-8859-1?Q?Y5znCLnunXyiIuwIXMmEi3sS2NNbvHdeWAfRo4V7e0IU96LyFQ7Nabrs3L?=
 =?iso-8859-1?Q?dZehs65ZFYjVH6ZfeLsPWVJ9w07eAu2Amla1107O3iQH8DJFmgy9v8ERcr?=
 =?iso-8859-1?Q?vIjyJDPLKOrV8HTKwNKgU34Yjy+tC/VLKgYfVJPIjutdSpGTn8DfGFCS45?=
 =?iso-8859-1?Q?/ausSjUek/YuKc48/ZI+aRwU2zGRLocctWz2bmH+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?McqBnLMyjtuWbzQICs78TPIxjV3ofci3I42xPYuZzRy4x5a1V2jYoa2Vah?=
 =?iso-8859-1?Q?AQ0rYtoEQ7easewSXCJA13ukBy2tsMbb3iK241qoZbbhwrIBr4zNAq8Hng?=
 =?iso-8859-1?Q?y4A3vPfxdvL6YQsd64JJ/6aa8/md3x2xM7bRF12WMntOK+ZGe6KygzVo8x?=
 =?iso-8859-1?Q?/HLL1ymSDzBlzbP0PSZpaCCPgWwwJ3ZG3hieln4N3bBKSZCTM9BBECi0Ya?=
 =?iso-8859-1?Q?SA3OInJ+OiDa3m692DXcVwdvGiaDvA6XLPdGg34ly/oymS18E9FH4KnUud?=
 =?iso-8859-1?Q?u9fInyCzm4zDVqOSBZci5QVmNkiJ+57rmfZDncfQWLirt8coF7dEYBHenS?=
 =?iso-8859-1?Q?7Ld+DhaEPW14xPeaEKC4CS5eU1BEqPwDOEmEN0oSAD9IvCS0DjNJBTBtE/?=
 =?iso-8859-1?Q?v/xFqFWgmc83ackUA90GchUVfoHs9RWSL3YZj2amNhSA2powSvRtwk1+tG?=
 =?iso-8859-1?Q?W5YpoKjhrNvZjzzjPxMT9vdcBDeIOn70fSLuiGHqc2G+moDIz8kXd6IHEX?=
 =?iso-8859-1?Q?Gy0kJmbiy0zNAf5BrBbdPCrODiYroiIVI9AYou0Tnlbiuq9PEi01rKV3uH?=
 =?iso-8859-1?Q?1+Cvb3ytNeZjM/mhS2Erifi8Lpj4YA1jrBjYluQnrGM5hZTFfMl1XIjQ2I?=
 =?iso-8859-1?Q?QpGHErk6NKOj+Lj2Ffz4stEJnRJRTWOGDX0Iua8wO24pSHYlXzwmN3seXH?=
 =?iso-8859-1?Q?6X/cSPl7ZxgKkZAxHBNTH9nosKlazhEEScYUEvKeoTuldX3l65FbGm6aU7?=
 =?iso-8859-1?Q?kBidZYxzXwF5WCZW5CjkIlCkfsvyLlU+5kFb604n2zxSbOsL3M/D1wnmVI?=
 =?iso-8859-1?Q?0DLn8Cp5HWbOWzGsbLSwr0sWo+1IKvrFAXkwGwPsiBS1ZLeguwir61/L1J?=
 =?iso-8859-1?Q?U1dNk0mUEdLR1jGeDXk9ieANK9LXkYBM+ldkjT8L0ZN2pQZCyXngrODvji?=
 =?iso-8859-1?Q?+1T8keSlRMJceX760ILMff7Y01M51+psY/+kwxtnQes0PGuovjiGNM/Wo6?=
 =?iso-8859-1?Q?E4jL7lWRRCY9rBFLv09zyNOIisJYp5A0OIjii5Vp1H7ZXmMCTUvwfM/pj5?=
 =?iso-8859-1?Q?MK0p2UjbQt0oQRxV8IzTP4Z12cL56TYrwJeIpCxUg9DXgDAGagLdMabvVK?=
 =?iso-8859-1?Q?d/5l1nT8xXL4sOh0Oe334AadEwKVBYhhqaKyF1cO0FmA55sEzyBi/vrd4S?=
 =?iso-8859-1?Q?RRSVLRzmnfQKok5EhlFl6QGRekjmWRdMGWLvLooeZY7pO02Lggj3OWnSfk?=
 =?iso-8859-1?Q?N44m4WgN/iiQNafVkK7y3scrJ8o/QSZUcAcRb6T1on5ouFFNbrFVQ+gxqh?=
 =?iso-8859-1?Q?XSiIuv1HH8gp6kO9N070fCpL5TCnnmVmtL8Xue5LpLCPdvIeHEFonus41e?=
 =?iso-8859-1?Q?b4ATLPg4oKnaV+5RbJN/pAJCc/FTojqVzbtJKJnZd6NIo/ERNUqeI7Pttl?=
 =?iso-8859-1?Q?8bzVc4n94Dv3vgS25tvBwRrBi3XKIYT0QLAwPC+n2MjWjNWUGAKGkIdM0i?=
 =?iso-8859-1?Q?OHLYo+EVC+hZnQO6r7o1i+sJsXVi+JQoLunbxbw3i3hYYxFvznIUweHgMd?=
 =?iso-8859-1?Q?K3aFE6yg1b+PKtA6muUUVCHxdMBmDA3yTIGZm6M+ZNfoaWnLIlTbQSF8JT?=
 =?iso-8859-1?Q?f1kMKNi1AqWUDVzewkzCqb4chhGLn9vxk2tdnWjhnFd5NV/zrpe8o94uPC?=
 =?iso-8859-1?Q?QKB++C3FYmUxKLgSQc/h6ctjz4B48fEk4cHJSpfRA/cjPzkDbNt5bhIWav?=
 =?iso-8859-1?Q?C5ai/AXk3RjzWspwtZXw44vJExMVqmioeySyCtcx7gdi3Uh1SiadKRijhX?=
 =?iso-8859-1?Q?ZhhegXtUaQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d482979-ba99-40d0-63d3-08de74134dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:19.1784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWnJZJ7dXaKcILo7TMv7CLSgorBgm7D1WUwJHpTR/akMF4kkqmTKpAS+iAWxP5Wr+voH8oV6pUlFiC9nga7BnSaMSn1rrNpb5srwSneQbyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

The registers are only 32 bits wide, so we should cast the 64-bit value=0A=
passed in to only be 32 bits wide.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index eeaf1125e4..7ca99fb87e 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -363,10 +363,11 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
     uint32_t addr =3D offset >> 2;=0A=
+    uint32_t val32 =3D (uint32_t)value;=0A=
 =0A=
     trace_dw_i3c_write(s->id, offset, value);=0A=
 =0A=
-    value &=3D ~dw_i3c_ro[addr];=0A=
+    val32 &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
     case R_HW_CAPABILITY:=0A=
     case R_RESPONSE_QUEUE_PORT:=0A=
@@ -392,7 +393,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, u=
int64_t value,=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
     default:=0A=
-        s->regs[addr] =3D value;=0A=
+        s->regs[addr] =3D val32;=0A=
         break;=0A=
     }=0A=
 }=0A=
-- =0A=
2.43.0=0A=

