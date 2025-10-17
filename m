Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551C3CCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gx1-00054b-K8; Fri, 17 Oct 2025 05:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v9gwx-00052Y-VN; Fri, 17 Oct 2025 05:40:40 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v9gwk-0005Xi-Sw; Fri, 17 Oct 2025 05:40:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujElQZ8OjDhJ60LUP3NlmNash4qKsea9zh/DnwPFsN9A1t/kc0HFtcHv5YxkX8wV03neKD2JFCaq/6M5WZTg3649MxaV2PhLREENyf7KNncTvyf1ZO/PR/uIaLne55+iDr6hdEFfzoRZkCi8krMs8Hsg8gJ02Uu2PuTWZ/h0xJnfTY7W9PuYbtNSCeAYrJIft28PWMwR9OxmzM2jv7quOjKl5vEpnElfeCzO2T3DWH/8bD/WYTGlqbFxQaRED/jjGt1vtzhRDBeYF0fbuoja/dI75xzV8963C+JE4XpY/3QNr/kjFJWNhc1u8xTFSjL1FDp+80QdudM6lSiKR13gJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4XO0g2r+ohVuOIfj2Y+wzLqX9EtTRmuPlS35lwbqHU=;
 b=lsBN9tuv/Y7N8jJYuPJfy/SdJ3CBd6O5f8MzNXn8w69FZf6Cz+QBGlu7beiAd1k3Hhw7gnElE5PKo2aoFxgSx01g2SeFgzHOsiu7fAfz6B7P/kQR5LtxL3GUVIZJ+qmJ4qqiV4zANWLe31zK2f555fNXAUx4aDu+FOB6GUonk47lvBxFD5wgAxhB5IpFgxmvFd7bC0Rcz6bkOx4AxUdFJKUKZZJ5o/5bwHOeSmKUa9Gnq6QsgdhoANGN7pXz0FVIsUlJZREC6/QMBy+j9RbQgmyyOuZs3jDHhHPGpC6htyk6x5Ku4PnzyuAlIW01qoh1c3FzRBj+noLMv8GEeG+PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4XO0g2r+ohVuOIfj2Y+wzLqX9EtTRmuPlS35lwbqHU=;
 b=J8c0wOcZafMHBLu9Ihm8nbA8WH8ijOSVNzvCDVesYUFTToqTX7UidRqC/rlruMpV3xWhGBIpGCQogdj0EwtJoYLx663K4vnKZ8OKErXv2RCGj25pSKnCSlXyg9DW8zl6b++1ZFBRgQ5ua2bf0nKCJTDH1TSo5b+KRg0u3lxqA8fH89m98Vdhi+wkbOVVQ4tZDZrl3ENIyB1gjFQ1Ys4YvwhMqSNvq9VVgj6Yc0mDyTCNSbKy3TRFY2RLT7HBYJ9z5eUNUj3s8nPUeTPx5QjuiK+uYk6gkX9b3mQArfL7+Am8X//ncgBRJL98bxD543fgxr8sTA/x42hAO736tVIZHw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 09:40:06 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 09:40:06 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
Thread-Topic: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
Thread-Index: AQHcP0LSquPhvwSsIUiyasR+jj04F7TGDEkg
Date: Fri, 17 Oct 2025 09:40:06 +0000
Message-ID: <CH3PR12MB75481CD97D4F253489F38B38ABF6A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-22-skolothumtho@nvidia.com>
 <CABQgh9EJMuVNHoi3iCW73mrC=y07djR8QoPAn8wN6+rL30iadw@mail.gmail.com>
In-Reply-To: <CABQgh9EJMuVNHoi3iCW73mrC=y07djR8QoPAn8wN6+rL30iadw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB8240:EE_
x-ms-office365-filtering-correlation-id: e7041a88-f42a-4fe7-3955-08de0d6127ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?a0kKhfRg00p8t+74+u472f1j4tUHV6z4eSdCOp+MTdPkCckAfhJjIlAQaTzy?=
 =?us-ascii?Q?cgYkarkEl2ns6y8WiCqqd5gG5oSbgsusYrNpfMXxyqPVGpNbveC1p5qM9ilZ?=
 =?us-ascii?Q?kORBkzbJi7zApWRZTYzhXH0Z4V0BcgX5qwU2ypICAx/p9KwkgOf+TsvHXWVT?=
 =?us-ascii?Q?MxgO7eTa60Bk2CPdI5+QEZzEEbDP1c/bDtNBb+Iq5x51HfCYvBL2BmEwXve9?=
 =?us-ascii?Q?eXVs4z3O4O0RQQcMtLCFd1ihNeWct63EojoeWhik8vT2sOnOgeOIBA3knR+X?=
 =?us-ascii?Q?dSf0HSvogZm0KLKvTPEpyUg1AWxUZmipA0T8RI+RbQFNjDap6yhqUOpkfNCW?=
 =?us-ascii?Q?W/eMIWb1F9+pJU0KrZbi+CMnDSNSOmReJJHTRi07v4r/z05FPJ6RRztxJF/g?=
 =?us-ascii?Q?kd6vk2WA1nQOQNPq7yKaOxTcFdAaG0xgkQxTNivmylL60THyEu2TJ/ro9Yu9?=
 =?us-ascii?Q?DuBaY4GO2IfBX4M/ZGw1VYL2QdESKtIqnEJ9EShaYWZzSNBO9RJVRjT0WZ16?=
 =?us-ascii?Q?JVIEiuOwlb4SDHCYJq9IfAFOaFmrpCvRfGRKzkOxaevFn3jY6O21izWUhora?=
 =?us-ascii?Q?mz45rF9rSuhAhC987Co5ic/wFCqcUAnQrzAHi3PaHNKF2cMl8Ks1j5Biy+sS?=
 =?us-ascii?Q?tcBnMFX20mHwjfApg4+mb5nqAFyTXpwwhecbog69KuhOdoYKSVe3/Duv0bul?=
 =?us-ascii?Q?Z04hUj7Uhgiuj4lGxdUS9bZbUbctFtSD5o1vJwfeNxHC0bIjOWGhiL+XXtr5?=
 =?us-ascii?Q?Ow3+cQ7X7Z3L1IFbo2bCOHvEuEFFEp3YJ1FMoZqJLu1PT5pAvfqWmnxuCXum?=
 =?us-ascii?Q?6D7Ywrtz5Q32bJIZ5kd95+eIvZcoKoQP+9pvGyokk/AdNLTc+HOLmwuzAwB2?=
 =?us-ascii?Q?qzT8cmzEZYa3VUIuPDFVaVKZ9iSpsVAuLdwZMS+41vJsFab3UxZc7ZIG64td?=
 =?us-ascii?Q?l0Ilz1VEP9F/1PD/Z81/37al5VVZl6k57TQwPz8nMs/WTZHp6YYlovVOQOKo?=
 =?us-ascii?Q?LGStzV39kFg8bnC7jmZ69QzUDARj1gmnjzbnXXVDQIQ6XJP4xv01YsMR5+rj?=
 =?us-ascii?Q?wR9k5Ti8Dy6BYmMY7PR/NssNHpjcmC6lt022je20jQySDz7OPhhDBB00nF1C?=
 =?us-ascii?Q?AB9S54jae/+NpWUyfktgSA33SpbehKVGpILIF+vI1d9XPqWDBTmiiu9D4Nh/?=
 =?us-ascii?Q?1OaLI1BAjVTT+XFx1XIylc07kF9aQE5SdGsQKWPYdGyNF+AUtPXkLTbqppk+?=
 =?us-ascii?Q?RZv7jEwQd0Z2LT5QWP9hd+fhP/d77e8vdcIjrNrpSoUSQ/XGh4mgCAUcS4mc?=
 =?us-ascii?Q?PQqFrU+Zf/VZVvaKEvx5T8tFXCPcycRhHHp9f+eUWqZirHuV0K8n2XQ++rG9?=
 =?us-ascii?Q?R7l0qbwCWP9ZS7eZyCCuu0b2eCq/tGA1pnsZbsnzl70lRm6zVDJu+EN4gkVQ?=
 =?us-ascii?Q?BLG+J/hOdjTbuBPiLYr41pqFhxabOhUDXlRs/lggJAwFhXet5Xb+4rGwq+uX?=
 =?us-ascii?Q?0DyThs9IaLhYv/mqwXM8HJtiZI/14PBJxzFK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pjwX/PFTOwxt50BZpsv0nxRm1qmyrlznk7/XJwx5VVkJ+R2hrtQW0mV74mZf?=
 =?us-ascii?Q?3jLnGIdnm0ZWkOv0dg4QNzTaIHfnFhjVri44fqVh5ENN/cjwuGxkDqLNYeBp?=
 =?us-ascii?Q?HIdbqSBJRqz4nswOAmpqCwp8ZjE9QItVix2C14otuKZEmpruag+caV3x0QYp?=
 =?us-ascii?Q?OnaN3l/n9gS4L0ENU+hIgcp9+uac9eKUymQ0LOgzGunQuNtxNtggySs9Pol+?=
 =?us-ascii?Q?7zqA5dLEb5tqNVK1H9w3Zs1OviKKfN0OFXdb6Dz0Fdj9VtsEOZ7dl4a+Asnu?=
 =?us-ascii?Q?oPs29rTtuWRkD7W6Cf8fMLlXFkE5oIzYQGz0kul1qCd7Heya2xv524FmZMYR?=
 =?us-ascii?Q?J2+pqR0PytxDOlyfAKlIOGq1rM0N1HEBSCJPczgBf/azpwiL/s7X0DXA3LTo?=
 =?us-ascii?Q?Nl/lyvwUNLtSmWyeZZ/muX+CB+rAdP7Pi175y2D6xjVCFPYYAJyyuHSKWoLR?=
 =?us-ascii?Q?Ao6m9TpE1udgYBR7+CgUS4ZrRs2vIArBz2U9HN7IMJtipoctOfNHSuf+sWX6?=
 =?us-ascii?Q?jm88NYVzKmSMW1Wa7RxEQjybriGr8yfRJi4N38wGnRbO+9eXeu0YL8+/SRLh?=
 =?us-ascii?Q?GvdQkIxPgHCHApHq+SduBrZV6f8sBa4IRyOQZ+JHy3xprGYUN6gBHW3EFxBq?=
 =?us-ascii?Q?Ga3IiK4ct9uUw0gZIDqvKKP72ydN80WWrczp+5YfgjsphNxHWjce5KMtnu30?=
 =?us-ascii?Q?oGoe/SETmoS9L24x1xXt1i4c8BRPnK6Ga8kz6w4PPclVb5dY/ISvDaBUP/tQ?=
 =?us-ascii?Q?OUbpVvU50jH39t21mXXxaiUWthx07BVTpQikJF0+K3LVEIRWhxJCfW6vkY6u?=
 =?us-ascii?Q?VK3g/hiH7yoozpdC4g4ZavVnAYtrXvt06jCU15AN5mku0yo4gWD1JyvzOWdH?=
 =?us-ascii?Q?wUi81Q+ca53IzYROX20BxwsrvfGLtYCxnmnjRO7VLTdnV4xB+sxEyIQ+WraT?=
 =?us-ascii?Q?inOWTiULo/UnttQBhMZ3qm2Pvh3wZds1XhzB569a+4UiGndHY4RbLYizmaP9?=
 =?us-ascii?Q?BvRYM2oMa3u1+dNb4En+6E1ewzn6LOekodtrryys4zT44k+KWJl+iPCa2Otx?=
 =?us-ascii?Q?ZGIx/QfsgLwkl+YK7YlB6IevcXiU8JBFkrBxuBSb7M8GtBiQaHUzS0cC4MVA?=
 =?us-ascii?Q?SQuihSZckTpxu9VwkBxlkpKOUE/9cErzxoKnH3BcKzQyAONI4bChc2hoBK0m?=
 =?us-ascii?Q?gmA95Tv4TCe2+jD9POybCiglHK+JVJJ8dU1rilhqGa+Sukzz38X6+aor/0Bn?=
 =?us-ascii?Q?6+AwU9JvYkMyNKDSUVrAhxfznbwWE5dR6TTCOHoXUF4GACLDRqlWkcI/8Fpd?=
 =?us-ascii?Q?pQQBe63YvrsVqpBztrq9DJKOLG/heEFy2Y3mX+Nkf5V+91B6h5gniF6PqLsE?=
 =?us-ascii?Q?mR241VQuo7V/3iWMguWRyWCRb7aT9lpZIQr12o+RzGStZT9TaXifRbIKuxb4?=
 =?us-ascii?Q?e871UlXtOImbGRPcSpkujbqUUdvfVPkOvZhcDAUYUHqIoDcvsyIaeEBvCcxJ?=
 =?us-ascii?Q?JRWW0qnki9m7VdnpbzkPlCi3PUDVYKlvghPHLrp5mUhkdzrwIe13bAxoZJmO?=
 =?us-ascii?Q?VA2duTJYrI4koGmJ6K4bNlt2UW8CXqJ04eaVJc4x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7041a88-f42a-4fe7-3955-08de0d6127ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 09:40:06.5578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pO3gkhNgly4sQP77xX9UeVMxJ9U16e2aSFS+yxwJX9a9A5twkx+WdZvfavWLN7pwZQJFZxGSkFc/tlRQK5naOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> Sent: 17 October 2025 09:49
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to
> specify RIL support
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 29 Sept 2025 at 21:40, Shameer Kolothum
> <skolothumtho@nvidia.com> wrote:
> >
> > Currently QEMU SMMUv3 has RIL support by default. But if accelerated
> > mode is enabled, RIL has to be compatible with host SMMUv3 support.
> >
> > Add a property so that the user can specify this.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>=20
> If ril=3Doff is not specified, the guest kernel will not boot up, is this=
 expected?
>=20
> Fail with log:
> qemu-system-aarch64: -device
> vfio-pci,host=3D0000:75:00.1,bus=3Dpcie.0,iommufd=3Diommufd0:
>  vfio 0000:75:00.1: Failed to set vIOMMU: Host SUMMUv3 differs in Range
> Invalidation support

It will, if the host SMMUv3 doesn't have RIL. Please check that.
This is because when a device is attached to vSMMU , a compatibility check
is performed to ensure that the SMUUv3 features visible to guest are compat=
ible
with host SMMUv3 it is tied to. By default, QEMU SMMUV3 reports RIL to Gues=
t.

The "ril" option is provided so that user can specify this in case incompat=
ibility.

Thanks,
Shameer



