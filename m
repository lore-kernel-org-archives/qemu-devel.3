Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED16EB28C8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETi-0003Y8-Vv; Fri, 06 Feb 2026 00:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETg-0003Wt-Ah; Fri, 06 Feb 2026 00:34:00 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETe-0007Vv-KK; Fri, 06 Feb 2026 00:33:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5JPNyU5+RXj7nOBCxF9lZx7p0tkZryb33BQzZxLU1uG9p146zYfxW42hxu1y+7rfujwIxYDGttg4MbKRvLAkxt6pHo82+KcPQKG2TXpS1pMRFWAy70w5R8/IG4DENE2xDHccK9rIc2IkUSVNDI+QECWsPOBWRaHgEkWNSEBcuTeuQKHfToKMwhM8RhJcCyT9dvOKw/Tq7iN2dpDXvd9oRakCPXyVXKVIdNeM2DRHU4B9xXnBB6LzJB7GjmGQxKI+5T/ZHHD19W6pOJidTK4DTMrJXXN1ciQPjbTRtQ6jsCkc1j/nTvTXtJMAmTRE3ZufaAlWcsdRHfF88ltMmlrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKDYCVzZyF7Qv3t6V4sYfnNFftxOd5trN15/rUEbTZE=;
 b=L6cey5OVPzeQt+9vHdpsskz3+6WfZO7rDYOC0xOQfeg9PIs2NlOT8TNKiBG0LU+4ODy3+KbjzU4w9qQ8tQJOaMwPcW50iyUyqkXev8U8AoRLNVKK3Vu5IKTntokkEpJfx9fN2buw/szXMe8PcLAzxGkz6fSOMr6fAlmMlJFWP/LibPVD0YtWuCs1dV9HXbFBvueJ6YOxAv9ZBlsikN19TK9tBGzmoOTaYPBqZX26bqosFN6uVF6mB+v91jjOWkcWF9W+x+S9HVX6cT3mGANM+e4FIm2yo/TzG7WoggHXAm3vh8T+QRb8cnOQsWK/bffn7XCZBMl6yD5rMTiVvKR74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKDYCVzZyF7Qv3t6V4sYfnNFftxOd5trN15/rUEbTZE=;
 b=KuV4jQt/zjHr+EbElgxoCbAxo7IlnXpMu6CJP7AcnY1G8ml1dj1KOCsUVr+3D9nMyH+pgX3504VUlC4FlGT9ODv3MvDWOxN0Ozi3T4w8QFsYg7wM+0ZYfEL996Coq7jK4plqz5vsGWDHvP+gLh9cOsxsyvQ3wF+8+tE4rpzBwiEcPdOcPCmkdPl4gX+vQYhbvS2zbD/4eAD8l1T4Awis/wrQtKbArwi1IdKzycFFW7K6m7kTdtASsa1FI/zC971xLL/Z6lQRMdlBSODPieWKVoi1NyREGWLSL894v7RHEFhlpk8CYbsEf7f/H+xPRIfjQfui0yrNSSEBet63q+CMPQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5504.apcprd06.prod.outlook.com (2603:1096:101:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase I2C device register size
 to 0xA0
Thread-Topic: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase I2C device register
 size to 0xA0
Thread-Index: AQHclyopCTDjMhIGHUuNVV2chvQZwA==
Date: Fri, 6 Feb 2026 05:33:45 +0000
Message-ID: <20260206053340.3716041-4-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5504:EE_
x-ms-office365-filtering-correlation-id: 4967632a-46a5-458c-3458-08de65414bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BQom2HWbtEWRg0sYdq8i7+2o4yTWSYEY8sH4o/zA+UgCe/GH3oeujsxnqn?=
 =?iso-8859-1?Q?augQbvHlNWVlSjFMRw1XoBt3Dym+jHp92+uOMo8jrlbF13s/HMQo5CxIi8?=
 =?iso-8859-1?Q?7luj5Qet9lfuOzedXvu0VIp4hnmRx5S+WwXYUTNXYobpUigPnqjb+LPxBG?=
 =?iso-8859-1?Q?sIj0ZdTiLO2p7BgiwcXolXRAeGB8ScM7CFo63TLfupD5DOcSViJwQ2Pj0l?=
 =?iso-8859-1?Q?bId7vtzyV6rcS9CMzoIvIBe1/hl7MNhnOg6WJ7F77QOn7exzeL4n4jMpzi?=
 =?iso-8859-1?Q?47qq+jSMsQVET2PoAywgJcasv+1m1aDqVjAzVdLhgG6rAmZtEotljA9Iwh?=
 =?iso-8859-1?Q?aTsRviHeIDjrICveUVxCIhcCQ18N53EvKpxNS/HpNClAm38co7ts0jbquJ?=
 =?iso-8859-1?Q?AkuWaXI5bosJ0Pc6muEjYnMqCM4FsycKbgBCDEoOr4Bw3O3rMHWsA1nfYF?=
 =?iso-8859-1?Q?uzq1/kRVUUaW+30kgs7AAIya8oWTeVbQ0zJvHGot2uRkZJpFWVWWBOfc7S?=
 =?iso-8859-1?Q?SeTE7516OeupNhnNh4oerVMp5AGJs93sRUUsX0KSTrdofuFfCQbzN2qPhL?=
 =?iso-8859-1?Q?/M81dlL7W16bSmlEPQrcMMaze3NoxqVVxIvy1m/WtK+HupthNA70LMxFow?=
 =?iso-8859-1?Q?rFOX9XthT7wozs6rkX8bfOetHJsesx1qy5sRV0/4rHqbm1jPyRysjwDY+l?=
 =?iso-8859-1?Q?KhwLZhVQwHMsuEA0DDtFAeKCo+Rc6EdJxusjEDssmjkmvn4Vll3cS3qThZ?=
 =?iso-8859-1?Q?eD/QwKF7T3Ahgzv0EjWRxh2sc1dPG/VZNdOzlOA98gobVe+Z9obngE3HWs?=
 =?iso-8859-1?Q?ZhjZMytGk4d8k3d+uxvTwTo5glltIQmL+tI9pmcDLWQyYYmT0EIkyMyR+G?=
 =?iso-8859-1?Q?/jRBitOU/QKd3oAJXclsPGYhIOX/4bcb1+7IMK/RC0SKlpKzxxcvPZyVqu?=
 =?iso-8859-1?Q?LfpB2IC9bqy1dfmDvZT1d7JsODBnJRvBe62ASw+0pikvd79fncOj9Rxd41?=
 =?iso-8859-1?Q?kzVt8wV4jcu9NVJ9CEDEGxxzgTiFv+hkSJY63ZK/3a4Sm8uLMulS7OfX1p?=
 =?iso-8859-1?Q?QWCOzoXu2rDqkyuclMOUcp8SPFrh76onGcmac9Mcr35ROO/voLwfbxB3OH?=
 =?iso-8859-1?Q?+b31+GDcP476VcL4VNWHrTty9/Wr9CfTitu8gOR//77qFyuh1S36CLsnuo?=
 =?iso-8859-1?Q?T6W3aQ8loXbIL/HEeTgTp6fcZwvQZspk1T+IoZzVPB84SqHFejqErvjbI4?=
 =?iso-8859-1?Q?tld8r9AZlwh6W7L0TDaQOKqjwDVua/iKReCWMCap5fowCvTiDJmnK4Lchv?=
 =?iso-8859-1?Q?w36bn9M99oLsXsPxXSlM2bXKknNOEvpr5GJtbe1HEujhhoLhbzoXxpzDtY?=
 =?iso-8859-1?Q?DHe0/gwKZdHYGKcfqkl/aVIrRF31VCpl70/l0Bb3Z4U0uXZTQxTnn4NmNd?=
 =?iso-8859-1?Q?NP/xLLHg++NpFnzwOvVivOmro3OT3e85WWAaFbOh4EMatPZj9JoEftyBH8?=
 =?iso-8859-1?Q?Ey7UeKDPk8HUDpnzWuQ/AyPozZEcINmwR1w8GV2sv3edyz4f3nhmDEwR4q?=
 =?iso-8859-1?Q?jU1oT0TuWdnsYTg6ugZMJS+7ck8qVrJxacf/BGuLz2QxpHfbXsc2+nbIdp?=
 =?iso-8859-1?Q?ry3LRXf9h0QE0Rq2jc3+sJnkRFdDYF/Kh+RKdl9fY6b6+xgToLZ1zJB0IJ?=
 =?iso-8859-1?Q?UtGpMmOCzPx7bhquhj/U42RHQ0z0u2JgQZ+JRoqH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qMrDQXcVaGGtkxWdr0tSjn0IGetAsoHneZ8M+wTEOyZwPciRfakxjKkrEz?=
 =?iso-8859-1?Q?Vb6nGRepdO9YyMC16+QKi++i0txokyapb6x2UF5lcafmfZZIo299WX2s2F?=
 =?iso-8859-1?Q?B9bedzZmMFJEzID1yqMa9aSBjFcMV87uJVHVwspMkO+tuocT3ZcJReeaMo?=
 =?iso-8859-1?Q?+8npAl8EEylJcQ7xeuNScCqFwzdKJRDNUW4i9UGuHFcane+vvoCFlJrM87?=
 =?iso-8859-1?Q?5vaxUB8BgYagcNBN9ClyfwpbDnsq6oDGNVvZWmJf0+dEBMZstMT2Y2cPhk?=
 =?iso-8859-1?Q?Xv/nBRCaGHPbb89IPuI3CxzQIWoazk8gZITc8E5F/Bd4as21ih1kd87O4V?=
 =?iso-8859-1?Q?uXQtTfS5UwCT1l0EjZ18VwPDEtYjpXF127711nisT08QsnZVYgcUO+y6FG?=
 =?iso-8859-1?Q?glTI0f6KZiZuJIVzzRaTxei/w02e0RWqKUMn6sdLUTDdnhstVDmhAAWo0V?=
 =?iso-8859-1?Q?ig45NsLZAZZtHacWHJ10JcYMfsLJJALNzfv77J0au/BuQeHLzZMvuTRdwH?=
 =?iso-8859-1?Q?czPJM1vO2r8pVNjgJMQzm+hgNQoQVzdaPYQlcRvrWTwA8L5Sd4GXYlCXlZ?=
 =?iso-8859-1?Q?OOLR8mALC+Hi2ymz+QJ28uUXHxVi9v74C0uoIbRNNNtaK87L3jKmaTkG6v?=
 =?iso-8859-1?Q?K26WG9TLUql4r8oG9JDC8Vyj4AHo+xukeuUJzBs+U66J7yIwB5e9mjcl0S?=
 =?iso-8859-1?Q?xKvrbM8J7+LW1YsPGi6Cf1/8nXATbFjlL4ReDhUSYYw5JY8cFxENCq+ekD?=
 =?iso-8859-1?Q?KyaurwkWwMjUHkwlwUxdCcxK0BNBfmygNzq4+ijc31F1eEQz33Co6Ydxbr?=
 =?iso-8859-1?Q?OcrTlfX/n5GyI2D5SbXhyXN/IhKsCbGzdSXEoYf86fsaOmtgkZ1Fl8GPdH?=
 =?iso-8859-1?Q?IvuThCg1OCxw0iz+2CW4B4M7xzW8Njb2nmiIAfYWWeXGv7t7YHyN7sIIWb?=
 =?iso-8859-1?Q?DHBwFQ5mPgbutKx4oE6PMHId0LSTQG/h4+iIZ2WY5bKBgpPr0ij89HVEax?=
 =?iso-8859-1?Q?t/ds107fT85+pfxeFbvEwoVg1CxCq4HrQwnobz1+G5KQZ9la9DhZ0K5+h0?=
 =?iso-8859-1?Q?rsU/x2uevVqk/nSNt2FtbNkDwq68Y8PM20LkBKhfKugmNGKz269SWd/tUm?=
 =?iso-8859-1?Q?MM0yxcZABzamtSGFro1B2/4g62POa6r7TporGTUJ81X1jV1P9WU13kF8br?=
 =?iso-8859-1?Q?A+CrN/nAfYgP4u+QKwxf0mRxA/Lv1AwP3KkBn3bTGZzgLT8XyCwuqmbkNy?=
 =?iso-8859-1?Q?eVv2C7vg4Z4XTLtUCF3qO8ILQecJITBJrrjgXUWTA78uiH6sLQBwP9IHam?=
 =?iso-8859-1?Q?qEN6UsWv635O8VPG67GSIy56DfUr1h1uEIxr/wRk0VMo1A+sL2VzWeFpjh?=
 =?iso-8859-1?Q?7i0ZPb9LYxFYnQudQQdswUQeAKkjP3wJnWpI4WRXgU7LmhEa9wLFf+on22?=
 =?iso-8859-1?Q?GNzRSVqvH7DW3I44XtgLSGlkL/PcbTKDB4x5xq7A810GPCCjdEgZMMsnkx?=
 =?iso-8859-1?Q?CIkVvhbX5xtOZRUugOqrFolbwJAUjLK0/h9SaCYElYe3fPEiaLkbso+mKr?=
 =?iso-8859-1?Q?ZEYuz2k3vxAfP1oJas5ttXSKtMRzrP8Ta/Ul7J48td4X/TABX/LuD6xoHs?=
 =?iso-8859-1?Q?8w6hluVYYSBysAKxQIjeoNSj0EGqXEP0baA0jcLfLnNcZf3/cNx8uxFWe3?=
 =?iso-8859-1?Q?+JW0fTrT5oOf+iZEujJv00g48558nGze+47SWF8v3naZ5ZVgcRXiHxbkGY?=
 =?iso-8859-1?Q?mxjiOTQoJjU8gf0USYmT9ZPoPamtaxJ6o41F7KrFatlP1lKqRp90wtTXWz?=
 =?iso-8859-1?Q?OrT5fY5N4w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4967632a-46a5-458c-3458-08de65414bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:45.0250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZDiDainTOAl6P/exXHTuWEhwfEc+5iTzOYTB23WsHrmpvQLjd8AAZ2wYD469kX6jSi6gZtYWix4SlZGeuwziO2XQGwGxmgDMGLYiDHCHrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5504
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

According to the AST2700 A1 datasheet, the register space for each I2C=0A=
device instance has been expanded from 0x80 bytes to 0xA0 bytes.=0A=
=0A=
Update the AST2700 I2C controller configuration to reflect the new=0A=
register layout by increasing the per-device register size to 0xA0=0A=
and adjusting the register gap size accordingly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i2c/aspeed_i2c.c | 36 ++++++++++++++++++------------------=0A=
 1 file changed, 18 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index cf3a003978..e1682c9bdd 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1206,37 +1206,37 @@ static void aspeed_i2c_instance_init(Object *obj)=
=0A=
  *=0A=
  * Address Definitions (AST2700)=0A=
  *   0x000 ... 0x0FF: Global Register=0A=
- *   0x100 ... 0x17F: Device 0=0A=
+ *   0x100 ... 0x19F: Device 0=0A=
  *   0x1A0 ... 0x1BF: Device 0 buffer=0A=
- *   0x200 ... 0x27F: Device 1=0A=
+ *   0x200 ... 0x29F: Device 1=0A=
  *   0x2A0 ... 0x2BF: Device 1 buffer=0A=
- *   0x300 ... 0x37F: Device 2=0A=
+ *   0x300 ... 0x39F: Device 2=0A=
  *   0x3A0 ... 0x3BF: Device 2 buffer=0A=
- *   0x400 ... 0x47F: Device 3=0A=
+ *   0x400 ... 0x49F: Device 3=0A=
  *   0x4A0 ... 0x4BF: Device 3 buffer=0A=
- *   0x500 ... 0x57F: Device 4=0A=
+ *   0x500 ... 0x59F: Device 4=0A=
  *   0x5A0 ... 0x5BF: Device 4 buffer=0A=
- *   0x600 ... 0x67F: Device 5=0A=
+ *   0x600 ... 0x69F: Device 5=0A=
  *   0x6A0 ... 0x6BF: Device 5 buffer=0A=
- *   0x700 ... 0x77F: Device 6=0A=
+ *   0x700 ... 0x79F: Device 6=0A=
  *   0x7A0 ... 0x7BF: Device 6 buffer=0A=
- *   0x800 ... 0x87F: Device 7=0A=
+ *   0x800 ... 0x89F: Device 7=0A=
  *   0x8A0 ... 0x8BF: Device 7 buffer=0A=
- *   0x900 ... 0x97F: Device 8=0A=
+ *   0x900 ... 0x99F: Device 8=0A=
  *   0x9A0 ... 0x9BF: Device 8 buffer=0A=
- *   0xA00 ... 0xA7F: Device 9=0A=
+ *   0xA00 ... 0xA9F: Device 9=0A=
  *   0xAA0 ... 0xABF: Device 9 buffer=0A=
- *   0xB00 ... 0xB7F: Device 10=0A=
+ *   0xB00 ... 0xB9F: Device 10=0A=
  *   0xBA0 ... 0xBBF: Device 10 buffer=0A=
- *   0xC00 ... 0xC7F: Device 11=0A=
+ *   0xC00 ... 0xC9F: Device 11=0A=
  *   0xCA0 ... 0xCBF: Device 11 buffer=0A=
- *   0xD00 ... 0xD7F: Device 12=0A=
+ *   0xD00 ... 0xD9F: Device 12=0A=
  *   0xDA0 ... 0xDBF: Device 12 buffer=0A=
- *   0xE00 ... 0xE7F: Device 13=0A=
+ *   0xE00 ... 0xE9F: Device 13=0A=
  *   0xEA0 ... 0xEBF: Device 13 buffer=0A=
- *   0xF00 ... 0xF7F: Device 14=0A=
+ *   0xF00 ... 0xF9F: Device 14=0A=
  *   0xFA0 ... 0xFBF: Device 14 buffer=0A=
- *   0x1000 ... 0x107F: Device 15=0A=
+ *   0x1000 ... 0x109F: Device 15=0A=
  *   0x10A0 ... 0x10BF: Device 15 buffer=0A=
  */=0A=
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)=0A=
@@ -1670,8 +1670,8 @@ static void aspeed_2700_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     dc->desc =3D "ASPEED 2700 I2C Controller";=0A=
 =0A=
     aic->num_busses =3D 16;=0A=
-    aic->reg_size =3D 0x80;=0A=
-    aic->reg_gap_size =3D 0x80;=0A=
+    aic->reg_size =3D 0xa0;=0A=
+    aic->reg_gap_size =3D 0x60;=0A=
     aic->gap =3D -1; /* no gap */=0A=
     aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;=0A=
     aic->pool_size =3D 0x20;=0A=
-- =0A=
2.43.0=0A=

