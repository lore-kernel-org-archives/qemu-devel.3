Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03FAEE369D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYkq-0004Z4-BJ; Thu, 12 Feb 2026 10:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqYkk-0004Y7-8e; Thu, 12 Feb 2026 10:37:14 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqYki-0003W5-KH; Thu, 12 Feb 2026 10:37:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2XqHqBwDoloWk3COJN8EyujU0BJhESwEIuqwT+cUPaJDGA6wJtda4GQAroWJH7+aNTbh1y1HZdyZhfjN9e58pRdCVD1JVwpKlgRIvOkNHoliQsEqA18s9P99mB6gAzKTlJe7uUFGU5cicvqtSimUQUNEp7GBG4mo12QntKA3jB7LBO0fynNxSIhsxVhlmrqEOv3LSRtPo69ztbgou0rFNLY00zBoS5Ncs7l4y72a+p7qnHniX9fMZKO+8kluxWelvIMXIqnp42ji5qpT4+W7aBTmADhTXo/C2344pp/CwlHiFWmCAUqcX8xSGKXtJH64duFDbdE6zQ9WUGRvdYklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvmc6xrlYdIuDTH5nj/7YN4UpeHEj6zo/0DtZN8u/kI=;
 b=SY4pLHuq398HV5/c/gd3ARNGnvu1j3uoGNcdNq0ninmOYb4rVw6tdqGYullf9CMbRAhrONGpQfVLBeKL5mlVSRrXQ6qxREgD0Sxl/1KfHyfobgS4Lxs9RuFbZ17Bmtk6XkvLkWOdbDkEN/jP+hIhwawWVDjzhVRB3G7iwl4TT4sn9EnDnCGHbtLU/JhSlUf48ItF9g4Pqmc9vy8BQEllI7Oaa1r0SEhAgrbPtXR7gQWnyoXfqDzML4eBA8T4DOVLToFrfBe4RTV0oGeVYq7/wAkzNebWSkCxGpDNoIeuwAToJtgILOsSeWLREgmFHUJXmRSSMsB4Pfy36jrA9HmWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvmc6xrlYdIuDTH5nj/7YN4UpeHEj6zo/0DtZN8u/kI=;
 b=pJuWrDVrOFBPuRrFx/HDwMwrNc6xzCq7NtrGElXti8EdSI+5AWEqxLduYYmrSRuuiuIX9K3ZiWT7H/fWzOgEsJIHUI2DhUoDoJJObpApHuHBLKlVNHaEAUiz0z3Rk6DZHQHKgyQfucjmhLCtmRl2vWttJ+hpilIMMWjg/FYj6ksT5JM2IZTrAVRjp1hIWPPnG1c5Qt7qAtUoLxOKiSSA0wm9/h3PDMRqviBSS6PKoI2uT4H/AXX5g2l6EyVx6UVNBoWkb4Bz/eiTZXcK4Pgg4aGIzWBPIcwF5MB+MaL9NODr4P6XNd3n0dPdB0C0NQkKxiQJ5SfQvsxFqcKOe+kNHg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 15:37:05 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 15:37:03 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Topic: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Index: AQHcl3fclJVY+/1eUEyrJW1egg4NVbV6yXyAgADQx/CAA5IqgIAAAY3ggAACz4CAAABycIAACJUAgAAAjNA=
Date: Thu, 12 Feb 2026 15:37:03 +0000
Message-ID: <CH3PR12MB75488377B8B9A76BC3D0B255AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
 <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <dcde8f24-7523-4e2c-8ce6-4048d3ca9c7c@redhat.com>
 <CH3PR12MB7548A87A5BC62C6D90501947AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <c9f728a3-1bd9-48c8-93e3-463fba94e130@redhat.com>
In-Reply-To: <c9f728a3-1bd9-48c8-93e3-463fba94e130@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW4PR12MB6825:EE_
x-ms-office365-filtering-correlation-id: 27e042cd-a7df-45cd-a36c-08de6a4c9235
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Fl/bAOpwzPHpSOzGOaRoKVa03cWFyihRvHNANgcCVXNmWGLSjXrltg5++4uz?=
 =?us-ascii?Q?Gt44xmWlBBJUZaGpM75k4LLAkOfr2kL3HbpJg3jV13fI/mO5AxzIscIEZgPJ?=
 =?us-ascii?Q?e+7+mQIV4TXx0cc6/ev7q38liS9/ImIUGI2wuuy25rsvmZ1RRU6moUUupVBr?=
 =?us-ascii?Q?1dHGmCC9PgQwRkVkt/scfdOVOM0E9ejTBZxNG9sfnsapUGqPW3GLe1huqVXP?=
 =?us-ascii?Q?kJaJlWql3hKZ+XYCPY/E7CunJtjr3vgCnZG/YwDae3+O3jTGkOXIpjKxVyl3?=
 =?us-ascii?Q?Lbf4EBtQJcAFmznvn82x+fnx2w349UvYN+ShMACaME9tOdBzCvWTAFHlprcX?=
 =?us-ascii?Q?tmzHfEBwkNyhGOeCUHK/X+bQZU5AJrBdlh1AuGKGWyG3cSeFtB3g/BbUm08O?=
 =?us-ascii?Q?3RciJKbsfCCKp8Ifc/MUZYfS27Qn3AWaAbiROGb7a5rbryxuuH3+raA6DwNq?=
 =?us-ascii?Q?5OBxfGo9s7X//H8k0HDzvt6Ddf7MqpokGUK2928au0y3aUU+idWekO8cyaB1?=
 =?us-ascii?Q?yxFw3p6jme7+9I2txK9wM76X/KkUhETSw+HSv/Hn1rtWi912r93e46giQlCu?=
 =?us-ascii?Q?bJbOrV1GtLljdsIukgfy9wj2/xDOeeJoXgPe3MhyYnYRkqspftkht/SHllwp?=
 =?us-ascii?Q?EHb8BvdKBstC9wFcZxC2ZwkNfkNsBjuSoaVqGdef/AqmWizF9IWQiuenuC0R?=
 =?us-ascii?Q?hHgSB0FgE0Y5l0Mx3C7M8AaHK6eQyCI0EmhqVKS+hqgsMAjpaLY3JEEZFG0a?=
 =?us-ascii?Q?Pve0RSkiGP8x29ugYQDRwIiU6sDJncqZSWVol4lICPlnERyYyYabEIO++Tbj?=
 =?us-ascii?Q?7YUxlpG3drMWodE3Nr/KVJlxluvnvipBFRykFp695SrdLA4LXUlRWVDhHL/R?=
 =?us-ascii?Q?PAhclCTiFJ/U762J5NQKMMWW1jjTz11YePljEpF4acYlkpQF9ccQqi7ToT8+?=
 =?us-ascii?Q?JUKJ0npxgs5ZHTeYPxVIMIB9RntNop5Ewai52BnI4rcWS9os9rcjm6ipatcx?=
 =?us-ascii?Q?79ugs5Ni9x+YI2kUdLfOedh8d/Q+e5foS2/Tjf5gbi5JcWjxke9DQwykxjTO?=
 =?us-ascii?Q?+mPvf/c7dQtqrOJCzLqAQs39WUlYpMmgWlbWY4OqLmYdBY6mszAk4ux0vYZO?=
 =?us-ascii?Q?Vs5BkPGdMonXU3MbTD4XFyY1B3oDfNWFxB9zwUVbyZGi4cwUFM7FDMOsSkdG?=
 =?us-ascii?Q?UmUdx4IcCXqICx/Yv8uebgO1h9NNJ9qaycNM1JKJMYpSQJ45fEuJOY3rtZ68?=
 =?us-ascii?Q?ehrkmfpNW/8KRIwrUXanicakJeHaveuvUrNuYj78gMkOC8c5D3mENmeCzPUr?=
 =?us-ascii?Q?g2CCEfiecZwqpxm+WJzERupOQ6bs0tT6M1nRSKFzzCErReagiOFA2B0RemGn?=
 =?us-ascii?Q?lxfX6PtTHmy8GpRlpvKTJ7Qz0vybAvnCKKJ1U1f7XrzaSKgo/qhSCcK1UIP+?=
 =?us-ascii?Q?rokf57uUK7P27M//Tw5X9qQbvEX0H2EvTBHKyVZPtYM6qNayRTTZhqE4q+Qk?=
 =?us-ascii?Q?NL5qR+ji/k3/pBPezpzrXAyVdfZ0uz6LXUYjSPoNQRO96STNvZGzAcP1d0bO?=
 =?us-ascii?Q?tAUrFCe19CeJdV2HSG82uTfcZTbmo30nKF1WFNn88r+lhZWCe+zusTGRLzMU?=
 =?us-ascii?Q?n9iSh09tge1vRWyq2d7haec=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f1RXEWs7V/7cY5A17omJhP1GulA5HyWFYM/80giUMTx/td/2tpZZ3zOyBMIl?=
 =?us-ascii?Q?Z59HJ6mQ588whBzJfn4SKStKjYT47JNkZCAXTLRHrVjWXW7vXzNMFWaI03aE?=
 =?us-ascii?Q?otyJqlBGgXjdz/Gkli+t59bJrv51ABn7+IFaypGm3QCLc9mZKZUnzm/9297J?=
 =?us-ascii?Q?xFdF9X4zhN1BxDEfiU5OTT9E0M9gytR2p4OA04AkqUAOxWmIDQfFRGFoclbd?=
 =?us-ascii?Q?fKc2YANbgAwBgMwknANsfWotXRM3hpGa8c75AEuPrWydAM5arFb9/KPmHf09?=
 =?us-ascii?Q?gTD+TJwlrNcOJOwjL/TKmL6UXMYKc43bTFQbkn+NUGdNQqqvNy3ZwNIDbbpu?=
 =?us-ascii?Q?H6XQNKI9JIgDzeshoyEkrWWEkgySpVLgZ16GkG5jWp51tADHjIfEVND6ASrq?=
 =?us-ascii?Q?o9i0LUh1rLea2B6BUwIFQjVGzUbbk7n8VitDdkllFft1kcwYbrh9eofAFh7K?=
 =?us-ascii?Q?lqkRPlX8FzcxWVruqghP2BYBfWlPrJC2xlJi+GFX9XL/j8NR/mNXnSBBw5JN?=
 =?us-ascii?Q?oJhXDDYK3f8KVhA2dTvUHRszuVOY85mVylIH5R0k9SS7PaDvt1t4bOglvQfl?=
 =?us-ascii?Q?Fp0JfRLn9TEkK7gnWrfrj/RbtG2VfbekJ6suqlavUieGR5+J8Q9ta7HIDkFp?=
 =?us-ascii?Q?wUGYRUkmTv6MCPElYucTspJPc1Kap95+ohoUX7W2BmZH0gUjBqFyIENxd1e9?=
 =?us-ascii?Q?baEbakzRu6kd/MfMJ4GHXP8nP2i0mnURLPhyue2fMS3YfqPW+URzCEYELYdf?=
 =?us-ascii?Q?Qf0jZiA7H7HX7Dk3lVRBxClQvBOLZqpgOKDyoNPu+25BWrQNRDPXp/63RxKO?=
 =?us-ascii?Q?nFBcTgE9mMKdACNjFXIRg3FQNEDI1Gsc/xjORwypzFdIA9SUeBtX+T9q0Z8c?=
 =?us-ascii?Q?TsANSxUSU/+kntyr7YkB8dEeB7FX4SFzkaSRm6deOKJS66QU+YPUh3xUWvF+?=
 =?us-ascii?Q?q3DuppyQaTSQotpnHSvOIT2PyOW3vuARvcf9vISddK2nN6Uid0UOilBkWR+J?=
 =?us-ascii?Q?49bDRh6A0cNJb6bBXA4ySZ3ExrlbbeKAQ5mT3S45PxS+NDwBelkH2XO8TAwV?=
 =?us-ascii?Q?Srjt46wqc08wGb8c/H9P9c3Jju0njXNVIb4QoLnry7WET2kvtXLZz9ikuZPC?=
 =?us-ascii?Q?CN8TRsDuOMEEyQslvnV9qX5cKSJUdJXiFN5QaThz16SfAsjYkLbT1mUOc/Ch?=
 =?us-ascii?Q?qDoVKNZY45FhkZnxW5DHhtlk/Ea2GFhzMipMQVffbMPgagVtMbPxNvRWDY+6?=
 =?us-ascii?Q?nWpApdMgmP/86WCHY+LZm6yaLBytAu+yy+EWgExS0HR7WX2fW86ZBCARZ3PV?=
 =?us-ascii?Q?qrrG/JiDOgKbmKZvvuruQblq9lk5fNY4pZ1SOdIJtPyqZhxknR53gKVS11L5?=
 =?us-ascii?Q?1GbB9o6pTjiGd6ZStNTzEmvly7QNJMBe4ZLeXnVkFglgzUZ+XWEhZN2+BWg+?=
 =?us-ascii?Q?r065ifZQF8VezmdBFeW7eAGcFavz3pilYnsvtOe60HZ3KmSZjqnlEh2CBPjJ?=
 =?us-ascii?Q?K71HDa6ruOxQOZRClezL1A9j+4Ih5HDEJ+dCN8eX++BM58o++bX4Kxi3Jj0y?=
 =?us-ascii?Q?kDXA3xaL4NkOS0wZp/8vbRQQtMFQ/+P8a7+N5VpHuJ7VbjXFEOmGKCyLSU9A?=
 =?us-ascii?Q?4PzbaIQxZZvXWNNMDOlXrbCUZ3yxlZ3VrX3uGqnqOdz/HrFDedV+XesoSlZc?=
 =?us-ascii?Q?E5+hLnMPp5XMptu9xYJt9qX1XtyWh87WsGZhZjPVdw8hi8iW8+IOn4XcLAzp?=
 =?us-ascii?Q?au39pbt17Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e042cd-a7df-45cd-a36c-08de6a4c9235
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 15:37:03.6203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4IQsWQcibRsMrqeQw8K86YlWR4aBUlI07fhjeCeUTPb8B2b/1vTqCIU+hVKHbMdUdkKYVgW+XRrMYuF93L4Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 12 February 2026 15:29
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Nicolin Chen
> <nicolinc@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
> interface
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On 2/12/26 4:05 PM, Shameer Kolothum Thodi wrote:
> >
> >> -----Original Message-----
> >> From: Eric Auger <eric.auger@redhat.com>
> >> Sent: 12 February 2026 14:57
> >> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Nicolin Chen
> >> <nicolinc@nvidia.com>
> >> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> >> peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nathan
> Chen
> >> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
> >> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> >> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> >> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> >> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV
> ops
> >> interface
> >>>> I had
> >>>> the impression you reverted to a fallback impl. If there is
> >>>> specialization, I still think ops are relevant. Eric
> >>> There is no fallback implementation. So just to confirm, you are sugg=
esting
> >>> to remove the ops completely or just keep the ops for reset/init only=
?
> >> Depends on the code to come next. If your reset and init really differ=
s
> >> between normal accel SMMU and vcmdq enhanced accel SMMU, to me it is
> >> still relevant to have separate implementations in different callbacks=
.
> > It is not an either/or case.
> >
> > The vCMDQ path does not replace the normal accelerated SMMU init/reset.
> > Instead, it requires additional init/reset steps on top of the regular =
accel flow.
> >
> > if (accel)
> >     accel_init();
> >
> > if (accel && cmdqv)
> >     cmdqv_init();
> >
> > So the vCMDQ logic is an extension of the accelerated mode, not a fallb=
ack
> > or alternative implementation.
> >
> > I think the later patches in the series make this clearer.
> > Please let me know if you still feel the ops necessary.
>=20
> Well I am concerned by the lack of scalability overall. Until now this
> was more or less generic. Now we may have several implementors coming
> with their own implementations of even a vendor will come with several
> generations: today it is tegra241_cmdq, tomorrow we will have
> tegraxxx_cmdq, arm_cmdq, ... How to get prepared for this mess? Will we
> have a property for each one?

Agree. But at the same time, it is hard to design without knowing the detai=
ls of
other implementations. As a middle path I would propose to keep the ops but
just have the additional init/reset callbacks there. This gives an opportun=
ity to
extend it in future without over engineering now.

For having separate property for every implementation, that looks like the =
way it
is going to be now. Unless kernel provides us a way to probe the extension =
type.

Thanks,
Shameer



