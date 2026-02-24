Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE3AEFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 07:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLa-0002Ou-M8; Tue, 24 Feb 2026 01:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLO-0002Hx-Ob; Tue, 24 Feb 2026 01:56:32 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLL-0005Ll-EX; Tue, 24 Feb 2026 01:56:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRYoZFo0VJRyj9+R2MmXeUgMAI1WE2W7qqrRwtHNU/mLCYwywFSAtJOztJzeo5f8nnzlyxfGQN1Q5iFAO1/6q+ncvMAnGOHlh54wo8FttOJdG6gUNeYeuk+odmAqmePxjG8VmSd/lfpmC2uQ3dddh+Pc63o8cEX2czTqu8mULGv/z8V7dccp248YoLnX0/qFtdobzMYfJ1PNKh31aF6MNUEidCNL5dVt/cRbMe6xa2R6NSDd0QfHmXLFV6cKzMS6/VCGNybCVI5oKo4ia0otd0VM8ZUo5SoPyTY3Ztxb+q8mf5iwNMBuhc1xrcDnFnV3twPH+vPxr834RB/eozKckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7paKfIGTgIbpcUtllL195d4TNIwB8mNoZ621E2KpbI=;
 b=Pq76jARKAY68dKWmq+6sYjd98i5yUVOlGnvLM4oSxiEfZeCRdklNo6uIbWJ/8gBVGfplDPGFwPh9DchZcGsoxXXqiQWZlItSDMsNHOOLbGMpxhmdzidth4tCzztiUOZ7Yvhck8noRHgjN/1GzCi6x3PHyiDoBoVk0ieUAKuIit7lGruhU2f7pttPi+/L8ACs+dOKzmedt+SytdteJVFX0t8+dn6zg6SuFXhMsBSxu5S4NeMiGz7t45gLDmocmYw2A9SxceBb8Z26qAafTib6GbXgvgv8EjEBetrI8SImdBqQd6pJmSO8mNOoBcQbaJqaV0ANRJQVot6PJbZOuRaHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7paKfIGTgIbpcUtllL195d4TNIwB8mNoZ621E2KpbI=;
 b=WupHtxR8rKJP7wjdw6rGMzzGbZ0yorbjQNZ2YSpvRQgF8edmMcPq5jynb7y0afe80b/TRUndz2betWwsXg4OXEkOBC4wLxO+56mg33Rd2gce9BOm4zyEkJzxCK75Lx7OlhxvTA41wzdiUxbMcVOeNdI1It+N82wqqLW5uq73QP67rgg4MskYPn5uH9OfAuDXfyQhABHPe65xt3hyQ9b4N/yCrzP+Smx4RU6YVi2o5iwAfGhV/VbKlEj1dGO1TNYMorykBwindUBL1fDobBkUiEx17jWdTdhK+fVsrJa1Qjx+8z35dZzH44kqAUxaGS1+FzxUNdOw4GbBY59cRPKjbg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:07 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 07/15] hw/misc/aspeed_scu: Add SCU support for SSP SDRAM
 remap
Thread-Topic: [PATCH v3 07/15] hw/misc/aspeed_scu: Add SCU support for SSP
 SDRAM remap
Thread-Index: AQHcpVqmRLhwfF8aX0eQd2XkDnTYSg==
Date: Tue, 24 Feb 2026 06:56:07 +0000
Message-ID: <20260224065556.3847942-8-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: 28e57185-437b-4c90-99fa-08de7371c8d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rX3VKcdiSXfzr5nipU3nR9U+VN41g3F7n6Y6n3R461Q/JqjR1kNYdfMM37?=
 =?iso-8859-1?Q?UgbhGBKM5HZn3lEyE3YfN/Lb1YG6726fvve1MGEP0HgPyaBHEkAx2ah/17?=
 =?iso-8859-1?Q?qvM3lUY/ckfhAsBdI0pWduTfiI8lKKhpOHRSF4CK0fUV4QbKAzPgzTHH8E?=
 =?iso-8859-1?Q?9SOmQdbu1h1RD+pHSq32yGt4Fwc1JgE7QXgBJMmd0ytXprNsrKAM97TBSM?=
 =?iso-8859-1?Q?/QQUy68cjiMTQtnzi8zWuCmdo7hIKU2j8bdwYp26Zbv/Ban6WGmBd5JQIs?=
 =?iso-8859-1?Q?zzGCmPseOPdjTu2rW3vWMmNmRBE+aUkM6aECYdS2vVp/YHYmI4lhnQvW72?=
 =?iso-8859-1?Q?PkPsht62/2PVKAnj97SBYozdnKXCSsCJeqpWj3ruUzOb5nNyFyj1p7+GHt?=
 =?iso-8859-1?Q?8i3rJV3u85AInJL5Nis5lP/8JBGRD9IWL7QWl/8iP9J+bGaMWaTLX7pg/i?=
 =?iso-8859-1?Q?3V5JNN4lzCRn+JRVXdvFgrmqpGlBc4QCaauw8e6bKawROVPU1onoVBLok0?=
 =?iso-8859-1?Q?PW9KseJ6daOom+XM3UpGvdaPdv+X8nt+PDhmHg6JKcIaGEODNVIQ/x4IqD?=
 =?iso-8859-1?Q?XV40HwHp/do4CyfUGRh8G2l09PeMQYqrZR79vzaBaNu3GrvdooDbraUHQE?=
 =?iso-8859-1?Q?6W84h9wYC1UzLIrHoUcixVCmB4AMlvPOghRzRTT67n4jjIFzIYV1Weu6un?=
 =?iso-8859-1?Q?4x12cvkQQpDaO5uhi5DdFKMdwlqUcxLr7m8e+13EC2dSpcZhEiisf78o8u?=
 =?iso-8859-1?Q?eb5BBbpATL0cu8gs0Ehah49BVncMKsBiyIkl/bZl+23d6LXrha1Mo8g/S2?=
 =?iso-8859-1?Q?Xjg9ZEUYhy42GhBnsOTswsHOgtOEmUc8JWx9T1QIC7E7OkPfMkesQ8W64r?=
 =?iso-8859-1?Q?75y2eGInk9W5TcOS6fzxMjnCXFY6cggv8cuw3XdMk7c662mbPAgmU60nU2?=
 =?iso-8859-1?Q?a/HO2yZ/Uj5dRaVcy07s/dOf2NHK+QYskdr3Gqj5aHKHpt5pUkMSQgJJeO?=
 =?iso-8859-1?Q?3R65gyvaErglyvcuaF1EUHsFO5sJ6J3wvUVOLiuRwpS1XdEFhbmX44V7aT?=
 =?iso-8859-1?Q?Vjx9fnPxzPXhlgiKiVartGOgfc9A3gZ9r87+jOErUshV2dQgr8ocM8atbO?=
 =?iso-8859-1?Q?qwl/xSm05uJ163IAl1REmYtICOEv8KEqS26kJSrdfO7G8ZpmSU1PFNizOF?=
 =?iso-8859-1?Q?KpPE/pyR/8gehaoQ4eQ75pbjTQR8Iv9ZOZxMEV4z0onm0R5XiA20wt+L1X?=
 =?iso-8859-1?Q?4tp1OkcFUrcK5Fk2wqUeDX7O2d65l3OqYjOkc1uo7hmEwfDC5Hzc6/SBdq?=
 =?iso-8859-1?Q?tqobROdJnmKo6I+ySida2+eD1sfShTP3ucnQkPNNJb2W/yEbZjySK7AAkz?=
 =?iso-8859-1?Q?MuQqX9gL2l5z6pddom9vuZCR0bODF8EkBjwT9qn83fcPXDiH5fbzgtRrXP?=
 =?iso-8859-1?Q?YUiTkl44+yGq+jhMOcFB/QbId2isj+FGxo80yDWxgDxCAu4BHbGYAv1fuD?=
 =?iso-8859-1?Q?w6mLxILWbwXnjYCNbkiQdo94RSbIkwPXOP6DLpW42krlW3iBzQCHK8bV3E?=
 =?iso-8859-1?Q?zfFBJbQQTT9dg3AY/ROi6EI/hqjRkXrj8h7yAtscNbzTKXlHJchxIeT9pQ?=
 =?iso-8859-1?Q?EMzIfYqta5lAZZuPvjbu4RyOOUTuEFjLhaX3f2i2hj4bFaSiE1zycmlGJh?=
 =?iso-8859-1?Q?LkIoD0VXryuFP/wkKW5JDQGKzgNTl8DrhxP0843u?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(921020)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MF3H+k+eR6eUvOuxgj1Ym4x1ConG3QMLjeA8Eerlh2I94B0PRJNHIs3+9I?=
 =?iso-8859-1?Q?Wkto6ZOxnbK3ih1KZtSrpGc24PPnp37zzsDf+h95UG25XXDPSmA1pEA5BH?=
 =?iso-8859-1?Q?tC7LObGUVThihFZyFXmvJL7kP4m8ZoafHHexEtMzakAlVP56oaGAIf+HWY?=
 =?iso-8859-1?Q?A82SDUg8kVyDSTUPX+fX6sy7d7Iy6PPr5w3PIZy6esh07nfoPMbDUnLmuo?=
 =?iso-8859-1?Q?dcMzjOF6jntwNqVuGopOmH/E2y1ZIVrLiH+4QwqkRKDS5sE9PvRZ7gf7CW?=
 =?iso-8859-1?Q?Bb9VIFOXBcIz71CFWxrn8Z0kCyTcfSAx5vzjPVbHUr6KmE2XHpqJ0ksGhF?=
 =?iso-8859-1?Q?4V25R5yowXSPD7tCX9NpxLECzdtBuGKxQAPl0SHDRhb5wb2D1vk5VaDfNN?=
 =?iso-8859-1?Q?ml3FvpXwDyi164nxJe+Ad5YzGREcv3BIF4FsRt2DrzPQ235ynoJUTP3f6s?=
 =?iso-8859-1?Q?jQWyJKOsivXFL3thDMf2JXA0kGGpiDuRqu0uzvOZzjW/mZzSgDNFxGRaVv?=
 =?iso-8859-1?Q?N4t1RJIViHbJfOkjsF1xjNkDhLGIiCAofPT7sdeXGddGuliRKi12KsTYDd?=
 =?iso-8859-1?Q?5m8DHqHo0cJI8OkH+e0w+32+O7ff1apyLZuGQvYOltAX/qOxL56xMiybZx?=
 =?iso-8859-1?Q?e7Z3Xdepa7mb3lmJdA0JWkk5K8cm0QIkVwJQdd69Qi/0YUKZ97NlWzCNV1?=
 =?iso-8859-1?Q?PyH/im4QzjLT7aMTOOq1ysVUX7sHI5jUg9Q7akEvYomhvnGKFH7eOLxfmG?=
 =?iso-8859-1?Q?6g+a6OKUoHWXUBgqP8brawnXKmzZ57MMZJnHRRCETHAg01/vftGKdER19d?=
 =?iso-8859-1?Q?DU2I9z4XBPFrBUwxWA2sMm6LOmPwK2OnsjxyE9+70ctXOuqeD9Mete1Zi9?=
 =?iso-8859-1?Q?maHe739jlmfF7gYFrsHgSaduq5ogYlyXreU5OB/xpMrsTM97OSODEAH1is?=
 =?iso-8859-1?Q?ujzTKqUiI272rkg/G2IOv+TAmmWy3xvUK9A+ZMtmt+4tRr4dqM8Vf9o5tf?=
 =?iso-8859-1?Q?PJgeL6mQrRADwsqs4Z7rWbagwpOvh5m3OLbqalvq/K1h1x/Qy+Exv/AcRI?=
 =?iso-8859-1?Q?8/xHT9Z+MKdePp+W/Xdqo23qVTs8rIg9vfFAIBLP7RXJfV+mjAhvUfCNM/?=
 =?iso-8859-1?Q?jsJ3C+ns8ZaaTq+cKpo5Ucim+poDBrJFTGlt6lIwUQpoEnG5MNb+qF3QL7?=
 =?iso-8859-1?Q?1zDl8pMwrVtOSP6j01dKIuzJDafEBsDrmV2rPzRxwR++Jv45oKJq9HPi9X?=
 =?iso-8859-1?Q?jDquH5+2IzhlODsRhcCtQxvTb0UniNmTfEVcDqCDZEL9qxmMmjelzioyHD?=
 =?iso-8859-1?Q?Vi67Ty3a81KrZRDFDbzz70tMp2Y0PlTfK8+k6C23R93jfJ1mnwVraQYOPW?=
 =?iso-8859-1?Q?8fem4WOrXFlt6UyZoWrMb1gT/ev8++xgr16q2NSDppmnxNNbkbkotJk456?=
 =?iso-8859-1?Q?wIns+3C3Bx3zQXHNWXjjzBnpacjaniPXNJyfH6Mv38D0rwI53BpMljulrf?=
 =?iso-8859-1?Q?soTkayi/C8iaWvTrrBhnA+sz43JlmbZ50wkUS2i8ws2f6QlvpZMvuYaZUm?=
 =?iso-8859-1?Q?L0o27IEW38xS1GEIIeWQxhW/+wV1dVnYixEmgUC0XPaZY/RxIjcfnmYkDe?=
 =?iso-8859-1?Q?oKKtOPLH/Xczz0z3LppLU/LcHN0KYwGZx9Y3nqAHYGDc/1CgTgwjpFh/6t?=
 =?iso-8859-1?Q?GFozgm/oA6KnvgqrmM2FVzpGLW87W9QrLXITIyqrYpEheUxYpbZsTYJF1D?=
 =?iso-8859-1?Q?9cGCAbsVoikwiL5r7M4BNfFAP91Cxc0wNHM6AkecnXV4a4iSk796lCLYO1?=
 =?iso-8859-1?Q?iOF/q2DcUw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e57185-437b-4c90-99fa-08de7371c8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:07.0801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGrjA3GNu4WX7cRvDtGryC/R9btpghgQ3Dn61EduWPPBdvSD7br2h6xRaEiRigWZ4f4WupXTxSiQTWcJuY2hwDhghDrzcQLaWzuYHj7wXd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

This commit adds SCU register support for SSP SDRAM remap control and runti=
me=0A=
activation. It introduces logic for the PSP to dynamically configure the ma=
pping=0A=
of its own DRAM windows into SSP-visible SDRAM space, enabling shared memor=
y=0A=
communication via memory region aliases.=0A=
=0A=
- coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x400000000 (size: 32MB)=
 to SSP SDRAM=0A=
    offset 0x2000000=0A=
- coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x42c000000 (size: 32MB)=
 to SSP SDRAM=0A=
    offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_SSP_CTRL_1/2 and=0A=
AST2700_SCU_SSP_REMAP_ADDR_{1,2} / REMAP_SIZE_{1,2} allow runtime reconfigu=
ration=0A=
of alias offset, base, and size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        SSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x4_0000_0000 (SCU_124 << 4)             |     --> | 0x0000_0000         =
       |=0A=
|   remap1 base                            |---| |   |  - SCU_150: target a=
ddr    |=0A=
|   size: 32MB    (SCU_14C)                |   | |   |    remap2           =
       |=0A=
|------------------------------------------|   | |   |---------------------=
-------|=0A=
|                                          |   | |   |                     =
       |=0A=
| 0x4_2C00_0000 (SCU_128 << 4)             |-----|   | 0x0200_0000         =
       |=0A=
|   remap2 base                            |   |     |  - SCU_148: target a=
ddr    |=0A=
|   size: 32MB    (SCU_154)                |   |---> |    remap1           =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 50 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 50 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 15c8b06487..e806b95935 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -147,6 +147,12 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)=0A=
+#define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14C)=0A=
+#define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)=0A=
+#define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)=0A=
 #define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
@@ -988,6 +994,7 @@ static void aspeed_ast2700_scu_write(void *opaque, hwad=
dr offset,=0A=
                                      uint64_t data64, unsigned size)=0A=
 {=0A=
     AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
+    MemoryRegion *mr =3D NULL;=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
@@ -1045,6 +1052,37 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
         data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
         s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
         return;=0A=
+    case AST2700_SCU_SSP_CTRL_1:=0A=
+    case AST2700_SCU_SSP_CTRL_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_1) ?=0A=
+            &s->dram_remap_alias[0] : &s->dram_remap_alias[1];=0A=
+        if (s->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_1:=0A=
+    case AST2700_SCU_SSP_REMAP_ADDR_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_ADDR_1) ?=0A=
+            &s->dram_remap_alias[0] : &s->dram_remap_alias[1];=0A=
+        if (s->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_set_address(mr, data);=0A=
+        break;=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_1:=0A=
+    case AST2700_SCU_SSP_REMAP_SIZE_2:=0A=
+        mr =3D (reg =3D=3D AST2700_SCU_SSP_REMAP_SIZE_1) ?=0A=
+            &s->dram_remap_alias[0] : &s->dram_remap_alias[1];=0A=
+        if (s->ssp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_set_size(mr, data);=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (s->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1115,6 +1153,12 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SSP_CTRL_1]        =3D 0x40000000,=0A=
+    [AST2700_SCU_SSP_CTRL_2]        =3D 0x42C00000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_1]  =3D 0x02000000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_1]  =3D 0x02000000,=0A=
+    [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
+    [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x02000000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
@@ -1146,6 +1190,12 @@ static void aspeed_ast2700_scu_reset(DeviceState *de=
v)=0A=
 =0A=
     if (s->ssp_cpuid > 0) {=0A=
         arm_set_cpu_off(s->ssp_cpuid);=0A=
+        memory_region_set_address(&s->dram_remap_alias[0], 32 * MiB);=0A=
+        memory_region_set_alias_offset(&s->dram_remap_alias[0], 0);=0A=
+        memory_region_set_size(&s->dram_remap_alias[0], 32 * MiB);=0A=
+        memory_region_set_address(&s->dram_remap_alias[1], 0);=0A=
+        memory_region_set_alias_offset(&s->dram_remap_alias[1], 0x2c000000=
);=0A=
+        memory_region_set_size(&s->dram_remap_alias[1], 32 * MiB);=0A=
     }=0A=
 =0A=
     if (s->tsp_cpuid > 0) {=0A=
-- =0A=
2.43.0=0A=

