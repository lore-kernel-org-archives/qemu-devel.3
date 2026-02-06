Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC29EB28C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETb-0003U6-Rv; Fri, 06 Feb 2026 00:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETY-0003TM-Vd; Fri, 06 Feb 2026 00:33:53 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETV-0007Vv-W4; Fri, 06 Feb 2026 00:33:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsTnHIKdELU3GMBAIxh0AiUnalQyahBGHg5L1toqhsaCB8OzVNoJgm8cZWFFq6IzCJ1KMEJt6SR9WfNWRoG6E/uQG7/qEJ4Q1l1CqpkLfUIVoRWI4drjpCrTlhmw9D/BZy7oZWN1eBjB/rI9/TkygZKX5n9mMacUrp75/IXUfzjVcRuMQk1CJtb36TVV435lkdNwMnvNhgpoR/UFSHQi3k2RE2cNWwNZkdR6JeQT4Ccwgvm3+oh9TR7G6fY2L8evPCZkErP7ETQv6Fh2auAqflPFvM6FcrjMl1M7OjAQkZhEqAAcFnhernB0xYuqi1hSenC2MBwuD2c3+QVGZeYxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr/qxde3ZydKElB3sZXn2Z2i6aTbK+RJLcmv6aSzZOs=;
 b=YHwrHi1LDJ73CEqlmm/OQYC0qzuFoi0qXHy5x4d8iz6SB8HM2FVKITh+FdJTdhNE2kgQIovy1IuWnDuOr2fNehfipICndfq/1Am/olUlPjPDp94Gd8o6lx0S7jr4xqqICU4XvUrpovcnD0SDrtDORFddE3Pi3V46N7iCC4ZcggFWZsRzRlrBNNyUad13LNCFNW1jgr6SEf1vmHHaXqUVfoMmOt/yIJfY1bfxtQ+/f9DQ1bIVBEc7KM01eaGlZtCeSv6vO7czNUiyXchDYhOwgw/ayHHb9ZDw9c4aadnKexVKB/uWNMH3+wV8LcX6OXyHJuoEZEy2/55CjOq9i/ZWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fr/qxde3ZydKElB3sZXn2Z2i6aTbK+RJLcmv6aSzZOs=;
 b=qiWu+2ucjDjBod5wbV8KjZo9rgNgSZnaK1uIZBeiGw7kV/qU510Sb6z8TD8bIHg/jnbq+1Q4+2kOoUOYv+NBcSkeYcqmPbvJ7R1Y5gtDBd6pPD2gv9ilFtCdR1wkMxZUMq3gmuSdBNcJ8sL6ed9w0I8U/t5IXS6Rj7+SY/wi5sq+DbNaeMFaErcpMFCP2jXydKMfE0oQ6AjTOhAi6bcpjs/TNue4f+MRJZvNgKQ8AgNfHcB+3+KBX8S9hxLhwFxha5H0+CdLjRgwI8tE3u8aYBvb0fub/XO/RtjJCJljsBTieq7oD/CiXE/uDSsRe0NCxgNg7rsSV+vp4cDCWC96Cw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5504.apcprd06.prod.outlook.com (2603:1096:101:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:42 +0000
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
Subject: [PATCH v1 01/10] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by using
 dynamic register array
Thread-Topic: [PATCH v1 01/10] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by
 using dynamic register array
Thread-Index: AQHclyongCEX2lqhb0KrtIuPjBKYfg==
Date: Fri, 6 Feb 2026 05:33:42 +0000
Message-ID: <20260206053340.3716041-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 9ceaee7a-f6eb-4fe0-701c-08de65414a41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QqiuDkgqptEDu5aRfq9/Pu9Q7axpgd5p6gu33XBN4MAIje+YllA/4dGm+B?=
 =?iso-8859-1?Q?KfaVAF5nMQGQ5IC6Un6fN6f1ZcqXx5dMPerycAady25uEsumwGyjMdAgpW?=
 =?iso-8859-1?Q?Sgds0d7tflKqUgelBAhUGx//aLl5z4plPu7lfJ8z3Begpxzobo7yalT9gR?=
 =?iso-8859-1?Q?mCOoZkaajdWtT3FYxup7x+Fhqkj4puNEFVCeC/nBVFDBdF7FSU/h+c4itA?=
 =?iso-8859-1?Q?md8T2b7Ug9mYoOxmGMiWKvRFaUqCKn39oL4dQJ4PWzyEd1eMIIqQt38P55?=
 =?iso-8859-1?Q?MBhMrm3RlnUt6AMezWrAVr/bUyT3kt2D3yM8cs8ZB4E2h2ty1KO0TpHsj4?=
 =?iso-8859-1?Q?1ftXyhiia3EBFkaJvyegNrXNdrqQEn/N+I3m+d47aT5L+0L7NyxdMgnS/i?=
 =?iso-8859-1?Q?I4v5DtcJtDvGFgrsrGsYtjUC1CromGGeOmnR6vEv+o2p2Zc17FoAd2T5Xi?=
 =?iso-8859-1?Q?/z84d8w6C7c3JZ/AFattG2nDJ2rtHWlrRoIHCGltY0I2VXieSrrWs7v9zd?=
 =?iso-8859-1?Q?gExpluvWSxZonsxZd3z+AVsabS6aOCshyrN3GJxVFyikmlDQE7Phywaxvw?=
 =?iso-8859-1?Q?v9FVSmnbz2vACK50ixqRNQlOz5xJAtyvlJy3PCK8qj+PVwrqpgcc3MTZyV?=
 =?iso-8859-1?Q?V6BIjltPWUhB1pBgLE4qVOf4+Rjprt5WYI2gP3cF56tU4TObLZcF1FK2hf?=
 =?iso-8859-1?Q?T+4ktr+JyKoYRrz09MjCxgzP/qWL8I77C/sLdMZJZl9snaTD25Fg3/EXoP?=
 =?iso-8859-1?Q?ZKDvg8pHk+6ZYWrDNkmwFDWPUiozN8SgvcktTulkbCH0OibMGzniP7xHMP?=
 =?iso-8859-1?Q?aoPYHgsNVyZm92nASNrOXAdrqIJoa6cyrjp68QK5FHcyiMhfsm9CB4aMGU?=
 =?iso-8859-1?Q?ZXEXE/iBB/RP0hxdMykkytmFZVWz0C0EtXSYarCBzk2jdiIefMRqvb6YZ8?=
 =?iso-8859-1?Q?5pYb4ILXOAn4yXlU9Ljp/PzGg9Mzry24OshSzjYkiq2FcMC11zZidFaNRo?=
 =?iso-8859-1?Q?A7KaI4LwTh/7xIUL679h2Qj26toKMer27lyZSZbDHfrOe6mCDT6XuMhPDY?=
 =?iso-8859-1?Q?EZYeJwbrm8ACtNuUg19IU7vTAXckkEMYKp9uZnWGthR9Avp50jBipibsy/?=
 =?iso-8859-1?Q?ckPVOUSYjf1Tub528Uvp3UD59U2lyE16IRH5baoYpeXbmgEUXOpvasNDYQ?=
 =?iso-8859-1?Q?fuV0w2XdT+oMnYvFRpL/CeIBECv4vF2qzcFfuOZrTQjnV4gMKPuD+F5eB7?=
 =?iso-8859-1?Q?Vy/5S+uia2gIqz7qRJudE0LW2Yvazs5FKirp8Fz/p9LH8tPRXVNtNwb7+T?=
 =?iso-8859-1?Q?7T5kKpVIuM//w2kslRMO/Padcv4uK3SicoyMbgoqczIGx8mQR/A7LPsCQD?=
 =?iso-8859-1?Q?12HjHQoh/isF5msJm6eGc3fslwGZwbOVrGx2+DATa1tWw9l8lp7kJZEOUS?=
 =?iso-8859-1?Q?mQZFZz99Csm/Zp/9mMWWRa1FyKoXtfiAqbJmmD/Pkepzqb+JvAy7Dec2XH?=
 =?iso-8859-1?Q?KOmKovbw6767Hfr4lJSPLmOEOx+/IcCr9VkX/MY3ibp5fcaN5rbv3VVJi8?=
 =?iso-8859-1?Q?Q2WGb67Q3tFSp44ksMFSXvWucFuY97yqCCDecC4tw1CyoBK9qNG8uC3pfi?=
 =?iso-8859-1?Q?24d9bBeeH4Yr714jv2cL3mZ7zgePJJVdcy0Wv8AjsPMNmJDPW4H1Doawcc?=
 =?iso-8859-1?Q?i/A7SbiZm1U1GldhIYpWdzHcfbNAyQKqRxShV3dF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I6X9ahHwjqCP57QpbkQhqu57I78mawVQIxjbhYqPcTf/EUnulDzUGYnqdf?=
 =?iso-8859-1?Q?MlSaSJUQ2Ax7cmszmjWx3V064lzw1OxcYsUTuRNcM2HnOQOxLIogco2viu?=
 =?iso-8859-1?Q?kWj0F511+1bXHXCeTTbeZbX9RPalp7NX7t/pkkp0LrX14MymxDT2SV2IHH?=
 =?iso-8859-1?Q?XRQUyCgEQ303TrEk/049+zGW94hCVpWcsGuefiR1QhOhB1GJb4dtIyxVOI?=
 =?iso-8859-1?Q?k6dlYJNqtJC5AlmmOvHpUTtTyE7xHsJiL9MTh40cXKUN70ZCJM+9Mis/zt?=
 =?iso-8859-1?Q?fgR+8/dNvQfj200MiMDbytG+b4hwsq9fwI5z0496PAQ79t5E4oKdWu5PpW?=
 =?iso-8859-1?Q?LrSigX59b8HmW43TgGArHGuoUsfxHInLqsiBkjdKrmxPE9xv98geyqoSUT?=
 =?iso-8859-1?Q?4u6cfrOMUL495alc4qTWbLnd0cRVNGQoby+zH6m+ga3WUhSNzhgyMp3dWg?=
 =?iso-8859-1?Q?ng80xRlZcfefercz9mSwtTjLQ6EEu8Hv5J2cotslRxZEIoP+c+O3awUxCG?=
 =?iso-8859-1?Q?r40ZNhJ2hKSUwYjpvzUiFJxA2S8J9DKDEveKG6QyLLETpekM2gssQ1xS8f?=
 =?iso-8859-1?Q?2hd0RR5frgNWvFpwNTupeZQ11Rx18GirIsDd0lg02HRuA8Vkixm2BBavfH?=
 =?iso-8859-1?Q?Pxs2o2kmV9vGeck+TMNO9uDMrMgv3BztbEm5L0sDdEffV3i46gf/a6IRkX?=
 =?iso-8859-1?Q?Tk2pg5yFvRM9E4zYc8umA+1kfnmPfynFVv8ijHV0cNFixz9tDEu+H2xhH+?=
 =?iso-8859-1?Q?wyQhtu/ZnVYQjkqQC840edxxWNqTB51qKhby5a6Ww2Fu5cPbVkuYJIDdd6?=
 =?iso-8859-1?Q?w+nEzVVtraUl+nPAUFCARDDib+jNjj3Sv91bufResHz8grhGHPNqvhpjSD?=
 =?iso-8859-1?Q?EzkfDMt01iA40FjNjK5zhoOxvnAwmv3qcKh27Y00dVDp5N1/1+D22KhTL7?=
 =?iso-8859-1?Q?DkIDUBhT8k/WcwaLGv7JKzUxgQIdxJAAlLhE6Mz0pcBKMZW6j4iGUcILRE?=
 =?iso-8859-1?Q?MqoLXv9PU5oy804e6FG3MNlqhGBRDC7bQQM7jXoEIIC3siiUj5zvUY5/xo?=
 =?iso-8859-1?Q?HjQkU8EmU+vQofuvU0EfrY0hqgEpPcNkJsmhox2lVi26B/bXknmklncP7L?=
 =?iso-8859-1?Q?5GCAYLGqlgImyRNFaud5vHDpGvmZcCXNsnozf1SRge6Ai/SFqGoTFMkiTR?=
 =?iso-8859-1?Q?wdb8ykjh/fwpBo0Z3ZmhL6Tq2GAt+p/Kp5AqceLN/+knNDelV3bp7WoI/V?=
 =?iso-8859-1?Q?QBoETRdSZWe1sB697Vy4Np6c50UDjZD0+u2FRuFba0wVcsUnofh/njbudw?=
 =?iso-8859-1?Q?Af/UvLtmtCGmR8C5EXmZ3ModLcvE1v8bx5p0xB8TP3DYBAKoa182Kjts9y?=
 =?iso-8859-1?Q?CZFpcClcjeWPZNcBQXKElTXZ/dv+Co8rU5X3cXTnpXR/0/Kl59HbLy6CvD?=
 =?iso-8859-1?Q?6WgyoTmvqamJmp29JV/SG1y3kGzCFB96TODzRSC0I8TueIu9rcrGXtNjpm?=
 =?iso-8859-1?Q?cDqsKh3Ix/cldL/mPn0GlV7m6R1VetA1MHwzK5UONUNAl4cGJ5LUDuKjKC?=
 =?iso-8859-1?Q?6uPNt5GYXOda+eq2rcsYl2zFLK3Nw+kftNBrjnFChekxHWc441jW4HUyXA?=
 =?iso-8859-1?Q?nRM1KCSYfIiFj7naRNGmXEXezh/C/QH+tEBUs65Q7Hte6HCMfGVLK+XPAf?=
 =?iso-8859-1?Q?uNpzoscHVO/x2eFp1lYGS3e++BFPmHg0YmzM4j882DhlFGcIeDPWDpNwE8?=
 =?iso-8859-1?Q?5oCcUgP5UmTwCQ2p4qjXv6RzgOQ3viLk0lYMtBbceXvvhEzm5ieJDkh/tg?=
 =?iso-8859-1?Q?K0KevFixSA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceaee7a-f6eb-4fe0-701c-08de65414a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:42.5701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3O/ve0EcSJCSLRc7K8iLrLEUeEXqbDmuFeteNs6J2EC3xcC5ou4A3Sf9UY5lm7YXdYU8ikAaFChYj+TJ3EqQfXMl4lkbL9p/hGksyGiHzrE=
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

The ASPEED I2C controller emulation used a fixed-size register array=0A=
(28 dwords) for all SoC variants, while multiple ASPEED SoCs=0A=
(AST2600, AST1030, AST2700) expose a larger MMIO register window=0A=
(e.g. reg_size =3D 0x80).=0A=
=0A=
This mismatch allows MMIO accesses beyond the allocated register=0A=
array, leading to out-of-bounds reads in the I2C controller model.=0A=
=0A=
Fix this by converting the register storage to a dynamically allocated=0A=
array sized according to the controller class reg_size. The register=0A=
array is now allocated during bus realize and free on unrealize,=0A=
ensuring safe access across different ASPEED SoC implementations.=0A=
=0A=
This change eliminates I2C register out-of-bounds access caused by=0A=
SoC-specific register size differences.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3290=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  4 +---=0A=
 hw/i2c/aspeed_i2c.c         | 18 ++++++++++++++----=0A=
 2 files changed, 15 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 68bd138026..205f0a58d2 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -36,8 +36,6 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEE=
D_I2C)=0A=
 #define ASPEED_I2C_NR_BUSSES 16=0A=
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800=0A=
 #define ASPEED_I2C_BUS_POOL_SIZE 0x20=0A=
-#define ASPEED_I2C_OLD_NUM_REG 11=0A=
-#define ASPEED_I2C_NEW_NUM_REG 28=0A=
 =0A=
 #define A_I2CD_M_STOP_CMD       BIT(5)=0A=
 #define A_I2CD_M_RX_CMD         BIT(3)=0A=
@@ -256,7 +254,7 @@ struct AspeedI2CBus {=0A=
     uint8_t id;=0A=
     qemu_irq irq;=0A=
 =0A=
-    uint32_t regs[ASPEED_I2C_NEW_NUM_REG];=0A=
+    uint32_t *regs;=0A=
     uint8_t pool[ASPEED_I2C_BUS_POOL_SIZE];=0A=
     uint64_t dma_dram_offset;=0A=
 };=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index fb3d6a5600..cf3a003978 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1091,10 +1091,9 @@ static const MemoryRegionOps aspeed_i2c_bus_pool_ops=
 =3D {=0A=
 =0A=
 static const VMStateDescription aspeed_i2c_bus_vmstate =3D {=0A=
     .name =3D TYPE_ASPEED_I2C,=0A=
-    .version_id =3D 6,=0A=
-    .minimum_version_id =3D 6,=0A=
+    .version_id =3D 7,=0A=
+    .minimum_version_id =3D 7,=0A=
     .fields =3D (const VMStateField[]) {=0A=
-        VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),=
=0A=
         VMSTATE_UINT8_ARRAY(pool, AspeedI2CBus, ASPEED_I2C_BUS_POOL_SIZE),=
=0A=
         VMSTATE_UINT64(dma_dram_offset, AspeedI2CBus),=0A=
         VMSTATE_END_OF_LIST()=0A=
@@ -1465,8 +1464,9 @@ static const TypeInfo aspeed_i2c_bus_slave_info =3D {=
=0A=
 static void aspeed_i2c_bus_reset(DeviceState *dev)=0A=
 {=0A=
     AspeedI2CBus *s =3D ASPEED_I2C_BUS(dev);=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(s->controller);=0A=
 =0A=
-    memset(s->regs, 0, sizeof(s->regs));=0A=
+    memset(s->regs, 0, aic->reg_size);=0A=
     i2c_end_transfer(s->bus);=0A=
 }=0A=
 =0A=
@@ -1492,6 +1492,7 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, =
Error **errp)=0A=
     s->slave =3D i2c_slave_create_simple(s->bus, TYPE_ASPEED_I2C_BUS_SLAVE=
,=0A=
                                        0xff);=0A=
 =0A=
+    s->regs =3D g_new(uint32_t, aic->reg_size >> 2);=0A=
     memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,=0A=
                           s, s->name, aic->reg_size);=0A=
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);=0A=
@@ -1501,6 +1502,14 @@ static void aspeed_i2c_bus_realize(DeviceState *dev,=
 Error **errp)=0A=
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr_pool);=0A=
 }=0A=
 =0A=
+static void aspeed_i2c_bus_unrealize(DeviceState *dev)=0A=
+{=0A=
+    AspeedI2CBus *s =3D ASPEED_I2C_BUS(dev);=0A=
+=0A=
+    g_free(s->regs);=0A=
+    s->regs =3D NULL;=0A=
+}=0A=
+=0A=
 static const Property aspeed_i2c_bus_properties[] =3D {=0A=
     DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),=0A=
     DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_ASPEED_I=
2C,=0A=
@@ -1514,6 +1523,7 @@ static void aspeed_i2c_bus_class_init(ObjectClass *kl=
ass, const void *data)=0A=
 =0A=
     dc->desc =3D "Aspeed I2C Bus";=0A=
     dc->realize =3D aspeed_i2c_bus_realize;=0A=
+    dc->unrealize =3D aspeed_i2c_bus_unrealize;=0A=
     device_class_set_legacy_reset(dc, aspeed_i2c_bus_reset);=0A=
     device_class_set_props(dc, aspeed_i2c_bus_properties);=0A=
 }=0A=
-- =0A=
2.43.0=0A=

