Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF74F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OG-0003UQ-EI; Tue, 24 Feb 2026 21:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OF-0003T3-0x; Tue, 24 Feb 2026 21:12:39 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OC-0000QF-Ke; Tue, 24 Feb 2026 21:12:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xq0AXcvglKnSznQ/6d7NIDx9fuQnDx0uMl2PccSzaNDHNLyHA3MsncqVJ/7kgXFnOmPNPxA+1szAGFoz0nQjHPmNW1G37MmvzmJL3i5gqCCDKb9oiBy+snts9TR/319m9XZJsyHQsi16vIVQMi6uKp1MtTZHXXyUZ5LbXqeCQ65SIDTbecPzgUsZ7ZPx20j++bZPB1/SAJlz3TB7VcvPYAtBoLAH5K0xstBni4/yEosBejRwmyj3W6gGEeRnn/E3uMS+JCW1WpwmalCjR8pJLiRDy9QeDTor0qW2SHP9eMUuaDC2a32mfXsueTJD8NE3bUf0t4H+MnDwPM5GM29lRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TwHv/7KzfQ9FX9uU6wHs4J3dlaJJwwRwPKB8I479Jo=;
 b=NPYgBBCiI1NWycPGlB5TI3JQG0o1Ul+L0k/1xx3gZctf16Xv02JMTABsdoAjZv9acAHtqzk63tGqUal/8mea6XmZwKaBs+AfvDyqG7t8YlA5IATFLt1EE/HOD1D3irOyIEsxCITq1oEVZT3dY8njzX2PoKJO6W7b7CzYvl3mftBjnuMTHUlX4Eaml1En2TzY1yoxhgzcYfsmXPN0QYC0KveqXylzbUh/lzq+fO7xCOK+zU1x/qvj+Qh8M8zR5xr7AqtSZqNOXG+sj+cnkLADqRtHKmVnDK9uzmFMoBJMf2Ozr1K8/+c5hlfEpxXK/96YpqgwoKJv0S1mjOyIjTW8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TwHv/7KzfQ9FX9uU6wHs4J3dlaJJwwRwPKB8I479Jo=;
 b=EN3uM3UV1nsLWuaEfpOhF/HBJpfQJBgPGBmWdPue6Wl1uRHaL7DhGAJDarXPNFpqOJFBlkNDvUiDufZd5658DEbU5U8af9/6O5RzOvktiWjcprJnOfPYzKByJ56a2fHFwiDohqz9GHRrW/BEit8Nx5AbQsKQOrVNOBr6Jr78ovukcyhI1XFSQ7ASBhR4YQ2olmJelO9EdTJB/bgXn3uInkOTv1k1vk2cel2QWV9TB/h9BtwFEn0VRDqHV3mTh8Z34vYyRkA8CeaCuDBi7A4yzRhmGpsgKAULX+2ETuhMeKGKUoYgbV3RhY5syD09P7cFbvxHVE+isG+ke4nLKdHU5g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR0601MB5702.apcprd06.prod.outlook.com (2603:1096:820:b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 02:12:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:29 +0000
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
 Venture <venture@google.com>, Stephen Longfield <slongfield@google.com>
Subject: [PATCH v7 16/22] hw/i3c/dw-i3c: Add controller resets
Thread-Topic: [PATCH v7 16/22] hw/i3c/dw-i3c: Add controller resets
Thread-Index: AQHcpfwxZqY8aKxhW0iIS5Ef0Cfjqw==
Date: Wed, 25 Feb 2026 02:12:29 +0000
Message-ID: <20260225021158.1586584-17-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR0601MB5702:EE_
x-ms-office365-filtering-correlation-id: fac95f32-7e78-4e9a-14aa-08de74135401
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yGjCrQV1ADWkYIr6AJipFr8cqw4K+bHBybmhNJAydv/zG0QJE8faBL7F1E?=
 =?iso-8859-1?Q?B5FIF1/uR5HyYZPkFsMuBCwHVIl1OS+Xlp9RhEHih/pzSwCENEzF6NaxA/?=
 =?iso-8859-1?Q?yAfZ4II73RR6E9U0lO5vV5Ia+NchK61VtaugYM1nB4NiBPzwL/1JUqPj4p?=
 =?iso-8859-1?Q?krFa/+GHg6sHxNI4jRWodxBXcJLXba17Olymfm8zw8a26+pYCDv2Uk82/1?=
 =?iso-8859-1?Q?EjIgcKCAMZu9/8gCQS5Y3CQfxCsihAg12wAczZQKFupQpAen0xhQT4iEl9?=
 =?iso-8859-1?Q?kTsRQk9nkIcLKd8I8I4YotPuEUoot6D9Ei7U1MtROM45vcTg8ORlnDMk+D?=
 =?iso-8859-1?Q?FovLley7jiSd7wgzQai4uWZ1zWUyzEoVzPD1TJ++XGy+kEEAeMEYX1lkwA?=
 =?iso-8859-1?Q?zXeO/wyl4Yz5O/blo5nqgN+2t7HmKjS+xc5ymWylCnv6d8b2XFoOSrZ+ez?=
 =?iso-8859-1?Q?4zzMPOXufLGqGSq98NpLrywPNv8pxhrrrooSLdkM9gETO4uqRLmeK+HlWN?=
 =?iso-8859-1?Q?G8EJ7McinkMPnSgTJed7DZRVx1NLERjmaA/JlbCK3b3NJ8e+NeAVkH3DgK?=
 =?iso-8859-1?Q?T0Ef/wEN/SNrDdAf12j/MmE3F1mFsEjvSRcR2EVqQ7DlKHcEV/8P/SJ4eu?=
 =?iso-8859-1?Q?ULnLYRMrHk5SM6mO9FN5nnsvwXhxYI+dl8nc6TFy6PfE0sVv8kQg9Mr4Fi?=
 =?iso-8859-1?Q?18EpNoTNyDfsD3jwFdXnQ8L2RwbSs0NJq8ZcL08y74rNt6bxr7ON2DXCyp?=
 =?iso-8859-1?Q?yPYzyWA/ViJTTsjK4UDe/d6P4BVnwQIe4kEAazpv8w6VRhqp2O7IjIhbOW?=
 =?iso-8859-1?Q?zgbyhsEPv6eWVzWvv4NeyQuEG1ED/b6EqaD5GzatcwG3tamQNBz92QhH2c?=
 =?iso-8859-1?Q?6GXXU/9wjGxi5Dgo9nl5wPy6IvpMeYO3Bym7kISOjmJVuD/FWL4F2yBuvZ?=
 =?iso-8859-1?Q?hOOlkXSwL7WENRRh7pnKjEcTvs0tBevx/AMvRUVZeI11DgSN++BmoL9sG3?=
 =?iso-8859-1?Q?DzTPtmY1oZ7+tyiKW3YMYX1sLe5Tzar9c7HSIhV/MPCg4Kv9iWsqQXBmb7?=
 =?iso-8859-1?Q?2UY8MeGd6Lm7MCFQiGcgXG4GUirGwk8cJuenkM2xWAwktEZMyEfW8ANH8F?=
 =?iso-8859-1?Q?TktXYlDkGudhZc4emcjJyEwVIL9o7cz9SCvbMKEho0Fz7VkZaQ9MZEYige?=
 =?iso-8859-1?Q?4UW7kGvYqlGQ5WWPEi8RisPXvRaJq9FepmcvnbR0Ix7pYb7qRJIAGN5MAf?=
 =?iso-8859-1?Q?ZUA89tE79iZ4N7lDaGPwBZZHFPwwn0bP6c163I+jfV0+Q8tLHbcyi3Pzai?=
 =?iso-8859-1?Q?oXzdvUWJKuCp9lAzL4ZR+dRLyrWbqz8ueTX4sYIGvZ/8EpauIGu6ubxScx?=
 =?iso-8859-1?Q?ssZUApHbQ2d6y9mpCnyYIx7vEu8EMeL1gFadjHxYw8+0DrLHWEpCI0F/3G?=
 =?iso-8859-1?Q?XFBDFXrs2ZxD4x6fNm2Jr9cCjqeC/KSrvEYDenu4ibPsDjY1C7bn30khe4?=
 =?iso-8859-1?Q?2Wa8oV8ZtxpnqQsOXJF+xiyo6Y9+dcNLsY1KA4X9VXW47vSL0sm6T++19w?=
 =?iso-8859-1?Q?Wz7LNWFjUWN+aBuJ4jl93jRrQALE0YgnZ2lqoLmGIs8REeCM+noCjY6Qu7?=
 =?iso-8859-1?Q?xj6xyk9XsqrCg/Qg9JgXZs9Q0LFo7L4ozoqfnMj4Xygo3PgvZFewh2XRqC?=
 =?iso-8859-1?Q?pwc1qTUNR4a9oXrU/g6kDqUJNaKmmD1uiQ5x8jCc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?55xQknGyxzKC48QT1UEqnxJtagdXNed20CVVNswhJI2x0nb8zYPBGsmLyz?=
 =?iso-8859-1?Q?i9ve2g5GS/+tO2lGozuJwi6k8Fpx0Q+YVgEyFvVFVbqVrme6aDoqz9/tFK?=
 =?iso-8859-1?Q?UmbOrNmxO6Y6JytlhH/FHzbi92lwkPDkXhvZEsbteHQ5drInjho7oGWoSn?=
 =?iso-8859-1?Q?E8GDKzDMP00LO2gDRuuAHrF2rfv7uLrGWXwLBEj1q3bVPuKFImArI/Xac8?=
 =?iso-8859-1?Q?oPf1JTAjpAp2yDWoLFraPKzLKT2r25JSKnJXV8v6sghM/RRF/tb8WR5bVm?=
 =?iso-8859-1?Q?0rb/HJZ4EwkNU5fBhYjyaaTVEz90/A3G4FsliYzdcVzsuYLnGDdzQgUo+p?=
 =?iso-8859-1?Q?zKl7+XD2oigiTXQXLBujdUvbdB/KFH7Os85Vpxy/c+3nOXUBSzEqUziqO7?=
 =?iso-8859-1?Q?PoLOiMwKmow56VwoZo/ndjDhVxanFAecddM3NdHmki1EhNtyzkTuP/8Ah0?=
 =?iso-8859-1?Q?3oFNed7qxJr0vrW4K090j85Edm8JI+fIff8xzc1VMKe99swczxdThhEQJd?=
 =?iso-8859-1?Q?685fhVXelpxY/JtR2koGcT37X4Nov8gdA8J53mlRuVv+mhhzOYeq0doh4N?=
 =?iso-8859-1?Q?ipmXpE9vwqg2y/fGfrxhJY4qWN4p050dCBcGwDVFFitAnW2mkEm9eYg8ab?=
 =?iso-8859-1?Q?VBavKS5zzG7RRfraoP/4NF2eI4H+kyWmePFxg2JQesQB+cBv2ccWB3Y9Dj?=
 =?iso-8859-1?Q?cjblC7lEiNJ4PZr4nyAFS3Bhz2X4io3hfwRqdbdi53dGZe2RumyQrYMv12?=
 =?iso-8859-1?Q?5YkWFE5iLpoumRK+B1Rp9LB0IL8SfDKw/ptpo9gSh+WWMg2D/0QP+qmFoS?=
 =?iso-8859-1?Q?QlkVeEW9Hrv8OH0yBlK6h8zJS42BKDjM3L4+lVvhYA7cbcBbBmAq/Ip9IU?=
 =?iso-8859-1?Q?lJWzo8XYcK7Vefk8N1wHVLttmzUYHwEEloe0ZjDHI60B0usb2rdDg+Xjm+?=
 =?iso-8859-1?Q?vG3FFoaqQ6ex5jV7vKwHgS2KIpUJXG7X/xpBsLB9chQ1JObgKicxq+2reg?=
 =?iso-8859-1?Q?9K2Onagzfba3IbBvVkyPGZ79AC+d1hJltQp6fkDJE6KIlQdlMKGyAYj10x?=
 =?iso-8859-1?Q?vxGX6pZNprEkCh3h7zZ1GWQrpmBjuMtfcRdk9v6Ttwwv28a8qYsrXpbIAO?=
 =?iso-8859-1?Q?7uWc8y4vTBuMgl5E+9gmjQQStn4YzrBtiZUroI9oHgqRiKiqPmNDkuwSkb?=
 =?iso-8859-1?Q?cnFiOFNIXAR0nt8sXSRXWV7gvxLSRAry9qaJwFykiYicBHg6vT1timhBo4?=
 =?iso-8859-1?Q?M5qgjPvmEOBay2KOEz4HtVwkEG6tKsuSExS5nwTQYQSSmIgid52oDZyoAq?=
 =?iso-8859-1?Q?MzxBdQwKvoBCHUOw7JmtL16pqHNGAUAjOgEEOW7HKDoWzxyr9ktSWG+D4l?=
 =?iso-8859-1?Q?swVtkny/temHTGNPBVLYNEXBMPKUHKWte3yShjY4WhB+o1ba5qfXNYQxap?=
 =?iso-8859-1?Q?xBdiDyIocHoEg/3mxMS2S/JFkiCQG6gUbqNP9ME9sOEZeiHWFKCMdu2yei?=
 =?iso-8859-1?Q?Joy9V72CwDPCRXrz41MCkNSmSbsnBOC441HrJ4stoUTJUL2nt2km1Sq6lM?=
 =?iso-8859-1?Q?Df9WgrLpCRDYaknjm30+q+4wuj9TF/ACXBvGmjDkf1qwe1oL9cnbPagDjB?=
 =?iso-8859-1?Q?kvos1N/DqMNSIPhPCHWfWS7z1vFAYLai1/mu+WvkeCfV5UyU66tRSnImxW?=
 =?iso-8859-1?Q?2vAO+sa9nMgFSWZvU612x+RubuTxjVZPG4IKdJC8nr5TqkynhJ3CPhauPb?=
 =?iso-8859-1?Q?/tVItn01n7aMB+M2YjiLIsU5v+Jq84d/rEpPX4N8aqHHAaCCqFHK+n5lIt?=
 =?iso-8859-1?Q?y0NWoaLPpw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac95f32-7e78-4e9a-14aa-08de74135401
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:29.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TF8S/ulUyWvBKT6Qc8paPZ1j1roDpmJFzeXe7y3DaZjKIcfwrpgERJKmVJ/fQpRQ5EFSEqq5pH8NcolOD5oGIOOGBmuSuBZ35nWUtbQC3Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5702
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

Adds behavior to the device reset register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c     | 117 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/trace-events |   1 +=0A=
 2 files changed, 118 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index b6ec0d9579..d742458129 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -860,6 +860,122 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t va=
l)=0A=
     dw_i3c_update_irq(s);=0A=
 }=0A=
 =0A=
+static void dw_i3c_cmd_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->cmd_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,=0A=
+                     fifo32_num_free(&s->cmd_queue));=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                               CMD_BUF_EMPTY_THLD);=0A=
+    if (fifo32_num_free(&s->cmd_queue) >=3D empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    };=0A=
+}=0A=
+=0A=
+static void dw_i3c_resp_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->resp_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_ibi_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->ibi_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_tx_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->tx_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,=
=0A=
+                     fifo32_num_free(&s->tx_queue));=0A=
+    /* TX buf is empty, so this interrupt will always be set. */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_rx_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->rx_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_reset(DeviceState *dev)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(dev);=0A=
+    trace_dw_i3c_reset(s->cfg.id);=0A=
+=0A=
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+    /*=0A=
+     * The user config for these may differ from our resets array, set the=
m=0A=
+     * manually.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, ADDR,=0A=
+                     s->cfg.dev_addr_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, DEPTH,=0A=
+                     s->cfg.dev_addr_table_depth);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     P_DEV_CHAR_TABLE_START_ADDR,=0A=
+                     s->cfg.dev_char_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH=
,=0A=
+                     s->cfg.dev_char_table_depth);=0A=
+=0A=
+    dw_i3c_cmd_queue_reset(s);=0A=
+    dw_i3c_resp_queue_reset(s);=0A=
+    dw_i3c_ibi_queue_reset(s);=0A=
+    dw_i3c_tx_queue_reset(s);=0A=
+    dw_i3c_rx_queue_reset(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_reset_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (FIELD_EX32(val, RESET_CTRL, CORE_RESET)) {=0A=
+        dw_i3c_reset(DEVICE(s));=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, CMD_QUEUE_RESET)) {=0A=
+        dw_i3c_cmd_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, RESP_QUEUE_RESET)) {=0A=
+        dw_i3c_resp_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, TX_BUF_RESET)) {=0A=
+        dw_i3c_tx_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, RX_BUF_RESET)) {=0A=
+        dw_i3c_rx_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, IBI_QUEUE_RESET)) {=0A=
+        dw_i3c_ibi_queue_reset(s);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
 {=0A=
     if (fifo32_is_empty(&s->rx_queue)) {=0A=
@@ -1617,6 +1733,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
         dw_i3c_cmd_queue_port_w(s, val32);=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
+        dw_i3c_reset_ctrl_w(s, val32);=0A=
         break;=0A=
     case R_INTR_STATUS:=0A=
         dw_i3c_intr_status_w(s, val32);=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index a262fcce39..39f33d9a50 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -11,6 +11,7 @@ dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C D=
ev[%u] send %" PRId32 "=0A=
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
 dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI=
 byte 0x%" PRIx8=0A=
 dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] =
handle IBI from address 0x%" PRIx8 " RnW=3D%d"=0A=
+dw_i3c_reset(uint32_t deviceid) "I3C Dev[%u] reset"=0A=
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
-- =0A=
2.43.0=0A=

