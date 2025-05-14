Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D44C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 14:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFCte-0001OI-In; Wed, 14 May 2025 10:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uFCtT-0001Mc-Kq
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:15:38 -0400
Received: from mail-am0eur02on2110.outbound.protection.outlook.com
 ([40.107.247.110] helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uFCtR-0003yB-7l
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFeN5gXRxp45Pe7Yc5879wA8RxOCH9PtdK0iOSMzlbtaUwfxYKuvhaE85MNRx/Qdoj0RM54JHiUmXc3P9z1bVeDqF6fAaGFldC745b1wX45x+u5uctuwGD+6mugGjXK4TRm+SJV86PYviq7jxjkOKvL8elg0j1g10p2Mfvj8yG9leDJyr9J3ZuAHL0SfEmZQJjeeF3HkvtFCeFFxz/dmUWGXfKF5Uy75mDFeyQXAPsvLWdj+w/sD8eEy/uRnMk6YgrX6X9S/z3WSXc35yf9Hlu7SwEnHiFzbMHJbyVEHVFCiRe4U6UE5NLt5oAu+arRTQWZkUmU8aeiW4cBPG+z1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjYblLukaodqWo7/CcS+76/nNWnT8rFc/XAtYDY0IIQ=;
 b=TAhP4knVZrNUyAujctiWEj3KddwcOuaGZ003NFK0Gugbk8+s7Jns37fMniNboXGejnGrxl1E1P+a1QXHw3BhzgVUhZTb81aYdPB8/MaspPTmG83oOi1amyQWLqh5dJA42jJGT6puU7rMqhMbBYYtVy958+CdYfhcjXNLIYk/NEzERT4ZoXAJLJY0mgcZ3nsjje2Hp+wHCXE3OW47GE+pCDfCkdR/UoopTpXhM9+FMsE/RqZNx7LyZO8iK4KojiFith9kD39AphZ2JDCYQF7uEhC/JSEv0YGY3duUCBe3ZVqVCDOAKDxfG8LgbJ2weS8m9PKg4MoLFZH8vhv/GAehoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjYblLukaodqWo7/CcS+76/nNWnT8rFc/XAtYDY0IIQ=;
 b=glMBJvyAUQJIqg1CJN+vCNAFOfFxUkt4X8rPV3EwUFvdkciWeAB8uVouY1umJkb+CxOCuRD3xp68lyjs1UE0r8i2eIywdj/k1hu997hciFxlnx+DAgPimxblSjunI1HhMfMjOCSXggmA7XMpItmVm3nEHRI/IoSPdNpOsqFcb4DDerEbE0sj4UEHMJipmUji+lAuFFZfQRg6zWIxY+BxzTppKZVdKCrVO1j0m3VQ0faB6es19GWt1V4AQo5cPYeb20f4swoa40zLcXBnvnwVTX/bsR34NAEaFcC8mI7puMmyaGq+AGZ0iuYbcalitGw6f5oY6TlG6LXmpzlYI4ICwg==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI2PR09MB6967.eurprd09.prod.outlook.com (2603:10a6:800:229::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 14:10:26 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 14:10:26 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "cfu@mips.com" <cfu@mips.com>
Subject: Re: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Index: AQHbiHBMKhjxNs/1dk+vCUF69yvpRrNvpGeAgAlizQCADH3GgIAsCEIHgCEVE58=
Date: Wed, 14 May 2025 14:10:26 +0000
Message-ID: <PA4PR09MB4864BA648EA8F2BBBE2999478491A@PA4PR09MB4864.eurprd09.prod.outlook.com>
References: <20250318134542.585521-1-aleksandar.rakic@htecgroup.com>
 <20250326123059.1268756-1-aleksandar.rakic@htecgroup.com>
 <PA4PR09MB4864D472FB32302BC1BD162584BA2@PA4PR09MB4864.eurprd09.prod.outlook.com>
In-Reply-To: <PA4PR09MB4864D472FB32302BC1BD162584BA2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Enabled=True;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SiteId=9f85665b-7efd-4776-9dfe-b6bfda2565ee;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SetDate=2025-05-14T14:10:25.881Z;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Name=HTEC
 Public; MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_ContentBits=0;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI2PR09MB6967:EE_
x-ms-office365-filtering-correlation-id: f17f6f95-ed04-43f7-38a9-08dd92f11326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+cyVDffo0ezTCBBlQcBcLFCm05R6KnkTWLh6BCrbsqbrpvuDXCxdEfs2O7?=
 =?iso-8859-1?Q?RwJGqpKkcpRL4ppNDtSj0e5YvCm9YktaAyUmEFOTMOGcNxael3hQAbLeI4?=
 =?iso-8859-1?Q?N4Q8SF2wbe4v3PpKIysWxVAzwwBweP6FHcLrbOfudq7wUdKCZSGVWDCUMP?=
 =?iso-8859-1?Q?Z/zaucoaDh+SyGY5mGGh3CpG4bwcyb5v4lsdagjPrJpCLwM6cqLezhHMNf?=
 =?iso-8859-1?Q?TLNcA8eqxUSEay/1piaSmF7BDOUDcxU4MaruFxm0V7ijTpjs3k8DBdqFZC?=
 =?iso-8859-1?Q?gaXvlWVyTZtv9XQU2b2NHyDtB68SxIYmrz0y741ohN+4c49EbrUzEMly3L?=
 =?iso-8859-1?Q?8EQqJKsxxTUH6FvelnubBCL/+AZIICf7gFpKNDlDzNfaW876TUUVpNgweE?=
 =?iso-8859-1?Q?wgG08lV19KNzDa5Td9PIEUDywkNuCDwcrbs4oP1nC8cxSSyM9IJcHr/4kN?=
 =?iso-8859-1?Q?TndlH8LOe6tgvjVHkZa2SakSuy9wMKMNbrOEnQdkI/bO8a83Us/A9B2q8z?=
 =?iso-8859-1?Q?g2+ORVOsAFXsJSCFnKvD4BsmYWRaZWalQZ4GGvKKlMKPw2v1DwEK8bK+6z?=
 =?iso-8859-1?Q?bzubmUQNcBkCLGBH6snWbAzM7EM/QY1IqRPK6ZxGi2Jo4wzuwyrJtwWKtF?=
 =?iso-8859-1?Q?L5pvum2IgRknK3uI2mC24VCcsUwd1yWPiq4bUqWMrVDwOG2qJTjrzONTpH?=
 =?iso-8859-1?Q?P0q6xI+9YYuUvRVKnAOVLQRMFF0l1CZh/uMDZJ+oq8nQtrXVgnz0MKDQfX?=
 =?iso-8859-1?Q?rXVsz+SjOAz+08+G0javVzTXUdcOckO40taOp40xkSHUA18ht6P/6oWIX+?=
 =?iso-8859-1?Q?lGAgrIwnpl6rsjznIIKrVZJgKdCFv88tBqPzjVJEsqlPDkcWKnw6t//2Bp?=
 =?iso-8859-1?Q?0wuYq5GG996a4E9VPYNh8XPvSWAIMbljO2C1iU/TUQecVp7EUVkBZMQ4Uy?=
 =?iso-8859-1?Q?XmrQ1srm7PWR18XxNys89THhdxqWkq/cw698wsTByHU4PYbv6AvvVno2zn?=
 =?iso-8859-1?Q?k/0CJhr3p3eZSc0kzM7fHhuZEKtQta8xfTOo7pTlz8D0trWiyrkOkqnOqb?=
 =?iso-8859-1?Q?Q/gvMITqOVZ0y6QEDKnimdr2PVGpCjbsHh2tvojgJxHg3kQTfvnKJ8ObVl?=
 =?iso-8859-1?Q?1XbmdKX7idSyNH/zi+3SnRFJJl0swcqm75Yw8/9MKOWKjINI3J/z3oO5fs?=
 =?iso-8859-1?Q?q6IU08Iy/qrpsDzVzxcUruMr+ayYb/F0QrV8nHXoWnXANiKE3Ktwpk+5ve?=
 =?iso-8859-1?Q?n77Lm0DK/NsJrenwjunsqmF/Hpuairk6MaJ1uuj1GQipnsyf4IYjhIB1gL?=
 =?iso-8859-1?Q?bDo4JdA2lTIE03p19FTIjSuSnpIJqJJQ10STPbIftruJDqvJD/u3tUS6Tg?=
 =?iso-8859-1?Q?EouYUXM3yqlRD8sJqF/4feGrOpSt0/SoP6Sag8E7zrqamy2eZZqItJqewA?=
 =?iso-8859-1?Q?dDZ4+byueVKHkNRTeUXfiKDa7l5QEmHZtj+uu4FI9Lvx5BTTxij48nCnmX?=
 =?iso-8859-1?Q?/b3jeBCzkI78bMlf05dfnJV8P2+5PucC7bZGMEeFVj1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yrgA+OXKGaoRfv9rmmMq6IYc0x/meGIiVsjNSl6hKjzUvRt6k8HzjqPgBP?=
 =?iso-8859-1?Q?jYJsoUVQufdeEpKyeH4e0wFyytF70b1JzCITMZ4toIEBrU6gTiL+0Iz5ry?=
 =?iso-8859-1?Q?DYDTU/O7jWvmHf3/+RPh17fdBPwwincRi0sntK+kVZi0kW0cKSiU2UktTv?=
 =?iso-8859-1?Q?ggXi9k7ViYlTykl1fx0VZsYblzhGe5ktD6J5J0BuiXWChltUgcNS3YQDKP?=
 =?iso-8859-1?Q?yFpvfUOhKG2LKc8ANzNbtkF3gmFWmDn5BYu2TU3pU/6/i6nwPfEOKSNCii?=
 =?iso-8859-1?Q?wZ+yAgq5hNJpqx4F/WbiR9EJ3WJAGYQ4Q8VbYjmSvCd6xNnWgkSJL1jd9q?=
 =?iso-8859-1?Q?ApZ/n3HGJD1Jx+hohn6obBkmvftQeQkt3b9oOtJm2Yo83iyixCfHusCiBJ?=
 =?iso-8859-1?Q?qyYj8BKeHaQOKNW0sO2pxx/aXEb5vcN3SSN8k/IRysmYmpLMMM6WTs3jTW?=
 =?iso-8859-1?Q?HJIgtTQjM1A8iB+UPVU8+K/rajYLxUAoSpdlzYOAxTJIxZCRwUo1VCeAMF?=
 =?iso-8859-1?Q?a9RZ8DicC+IB0jmpQQyUnpHxLjmxfwE3aqzBBrYS8oxgVdiEjBfGaBzTp9?=
 =?iso-8859-1?Q?W2vJwkoqw+mahIsYGfHzGSy0U+Zd2MsCl+Tvzh2YZoAEACN/KOyN5mT/TK?=
 =?iso-8859-1?Q?X1m7qtq7ASD0Bex00Z3OuOAmwXp8z2INFMpQI8wwJhUvAWs4hVOn1Xk6+c?=
 =?iso-8859-1?Q?zausgb+85RQdKwVtHWwqryZifO2xt0qZXh0rQaXe2LQXd4MTB6+CEtNHhf?=
 =?iso-8859-1?Q?ipjLtq4yTw4TbjqKiRxMHalyv3Vl/tfsXzC3DocBdc4E4SvWqk70a4o3vx?=
 =?iso-8859-1?Q?N2oYr/LY7XYU4TI1rXo65HTXDEIoseDVmJSXJ4ub5XTI2D+rXqAx6IxxHO?=
 =?iso-8859-1?Q?5+cRsCz/orHufibIgPlNViA7fdekx4mrmWFWH77wXxIu39H4evilAcR4Q7?=
 =?iso-8859-1?Q?dlE6unqMIqbVEcUj/WpiLmYmYdQsY48DpBSpbVtCeWJL7XGvpg9VjEXBQh?=
 =?iso-8859-1?Q?87KGPMyLCLAGq5FHkrckkpqLQN66nAVIjLPTddFqOPSFLrXJgOYefFMb5D?=
 =?iso-8859-1?Q?du2lsBF5Gou1/XW6eVkpmBZptYcsscGAtZgyrb7q2GnFb2Q17xfA4m/A8s?=
 =?iso-8859-1?Q?4f0AHksW0t+RNbBf0yTqnjEqeCvCVbttQVGlR2yApCga7xNz7alkP0xu7J?=
 =?iso-8859-1?Q?zAvzl0OkWlspCkr7A65U7/QzgS368si/MvePHnIMFntCXUpKK8xTzyCkWO?=
 =?iso-8859-1?Q?uuWMUNcod7+UzbkJ4DRjRkwKkU6ybLpHr35VIlFET5zFewwOYuq1GG/dxE?=
 =?iso-8859-1?Q?12SIdf7iGbaeA9WERgRuw4eCnKcmu23UOJ/szXUi6wyFSbnzSqp24OZHkC?=
 =?iso-8859-1?Q?cdpFQnQ2M55db6NrP0O4/8/yZVljMRQetR5frAjxQpAP786qNK5VCJSGYU?=
 =?iso-8859-1?Q?wSEdxL5IzEQdwRPrAKlrfFiubQiuka+fYD29sIE+4/zLw1hICtHoQd99U/?=
 =?iso-8859-1?Q?8bLOlyfxyUaOO1Yp8UdVIav/b66oJwliNPoKQrVlTZHzm3Z4QyUN1Bi7+/?=
 =?iso-8859-1?Q?7k3H7+vQc67lv/is9h6e7EpnvMgeqS0Nv7fsj5zjsmxLU/lFnZypGWGbt4?=
 =?iso-8859-1?Q?XC1Q4ZRf2NUj4ExVn/uKO+CKszc8IJCRbGdRXuTTcEqSyKA+SrbPhqFQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17f6f95-ed04-43f7-38a9-08dd92f11326
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 14:10:26.2267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hGUzT+46rGelxwzg0q/WQfuMzljNgZbF5onO46B5T6SI+mip6ppuaaJHUJfjZK2B2BSZNP3SWWtJID9Cun8y5AdNGjfSNkEknHPKoCsfjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB6967
Received-SPF: pass client-ip=40.107.247.110;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

HTEC Public

Hi,

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic

