Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30015E8B384
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPk2-0004Bn-Uv; Tue, 03 Feb 2026 18:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vnPk0-0004BN-KQ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:23:28 -0500
Received: from mail-westus3azon11010032.outbound.protection.outlook.com
 ([52.101.201.32] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vnPjy-0005kf-Mh
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:23:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNuBcJCveVXgpxRDpJ2C4vAHq3kYJvslc85JoWiWxnP7N53xsoNsb6E4D5hDtTs77HHwhIYiWna3HpQszirYznYpwIFkqIj7b1gp2t3am9JOLQVN2Gk3mkNITQh0Q682rHrCkMA5i/9QmLAEHY/xiIzamGFo4/uawqcLoy4bQtonkANVt2EWpTNOWiHm1bq9lTE2uzKDKPX44wUj3BLqEZQsbfd/AIsyXeOeLqobYkfxTUaEyZn010tk8j+1gx7EDcLJ3k1m/mVhrAkgdHsUJcN1LXZt8u+WAPCrN4D0NvXI8pBfcwv6+bEbIYHwzK6fCHVEc26Vwe1EZBiVdznnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuIH5nA2rG1jhiWagJWqIf2QsddHbB57UdO6EKOdEDw=;
 b=kNF1NbZA+ihW7Y3gB9w4NARbWT5gx7oG45esrHX2NdL9m67uvB8wlLIQgpIbl5BqH/+4ToucW/+X4wTlP7smWGfjzAGtJCggBZ7ZDnG9PuNPFWUT531CyrG+d5q+JVaH135mbzsKzLjWturEGp5UdGGI18vw014cAoLcFhDSeo3Tz9kcgicVvK0n8zDq0o3rw/4/EtlW5S3+MpMPJE224JZN9kiOjSfyETNzRcK1hrKX8S/ZjVY0yyMNNwd5gK8gi62dgqGuXj87YxjuseulIBo2dYWRmJMEqLiFK7zj8aCrb+jZthFC+Nwc8ufcOETvDyZMZwoDBOtMKLLQ+2hLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuIH5nA2rG1jhiWagJWqIf2QsddHbB57UdO6EKOdEDw=;
 b=nzYxEVUlX43K2dLwtTH4SaBVOCH9p7CbMiY5T6AboXAX2Z1lkpBaBGUik4yJ4gtzY9mHGoAEYr/vYgi10KoyxzuQD1UB/c0M3CDpXwGZ/rmDKVY1ITJjR2ScelbUYbad67+xxIk/qPtGgua0ofrJk1kFvVqf7V8radV2qM8fQvSvj9ov4791noV4rFUOJ2Y1NtyRQk3KjwLQYYMAx9HrxVbmlj2xJOYuisqM+wgeSZd5iIqTJQivvEYBHeWuCezAmqYmo1ckLr/+dE0TNMYR0GnHdROpacLx+mM8l35ShlnTlMCXQyu/fhhzgkjGI4hpEeu+CSckmXx2nllpXi5cZQ==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Tue, 3 Feb
 2026 23:18:14 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 23:18:13 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex@shazbot.org>, Shameer Kolothum Thodi
 <skolothumtho@nvidia.com>
CC: Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "clg@redhat.com" <clg@redhat.com>, Aniket Agashe <aniketa@nvidia.com>, Neo
 Jia <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
Thread-Topic: [PATCH v1 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
Thread-Index: AQHckZ3m8MDuj2IO6EOt4x7IByeMB7Vqc9EAgABmcgCABsicNg==
Date: Tue, 3 Feb 2026 23:18:13 +0000
Message-ID: <SA1PR12MB7199DCEEE90F4CCA99D765DDB09BA@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260130040649.42485-1-ankita@nvidia.com>
 <20260130040649.42485-2-ankita@nvidia.com>
 <CH3PR12MB7548F8415F5FF9EED90FA376AB9FA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260130084024.5b32d910@shazbot.org>
In-Reply-To: <20260130084024.5b32d910@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|LV8PR12MB9153:EE_
x-ms-office365-filtering-correlation-id: 40a10011-861b-46fb-d3f3-08de637a8129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lKI4jyMrCko4/FdysFDKf37mnp5gL1fSGWccXlTmXTVz2LbcVWZ3O2g5Bj?=
 =?iso-8859-1?Q?G0fJjoKLOur44Bf4YpLTIXW2id5J3tkSgIfyQ1pjPTDKQXJikXmn1CUuyh?=
 =?iso-8859-1?Q?apgIHt8OIN/ES7GwIEXr+6oSI3M3eeFrDbci1nR1BBqF7T1czLqcpTJLV+?=
 =?iso-8859-1?Q?MNa+WzLr/E/gEivwLVy4InKJGVROQ/FQxbr5wYq0ebVkHcd1wnW8JMaiXh?=
 =?iso-8859-1?Q?lw1ezvPVNNxXncJk0DgvUgxEBmBS/qiOliyBmlAx2UvatuBeluPyw6v73u?=
 =?iso-8859-1?Q?9QIKed1A6orar9CxAquMBj0fumlJOBTTIovD0ebHpzqNWfdaEsIhrTlNH5?=
 =?iso-8859-1?Q?SMLTKTpapCMH28sgaa9q/m7MoR5m6fr+DFtJrZgbzy5Q6wC1reeaBEUeNR?=
 =?iso-8859-1?Q?WxUjZlUPi9RCkVNzdSLcNu94sOAaRpW8gmKFKLyaDtOg6mJRelqd8A5Riv?=
 =?iso-8859-1?Q?HkDyjBuaGXteKVcKCPrNwoL3Ir9+TMfhshaTFWbppajszTPsM1L3xiwWGb?=
 =?iso-8859-1?Q?ayQqJ7I/EZlLFRNZNsOwWfppyItLfHzKlnd66+e0QiU+QYrlnijyNtTk0i?=
 =?iso-8859-1?Q?Qf2Bg5sLwWH7OetSiR3RKCTXThM4LBVFK9xN9/JXi+hWX73Euij/OV44uy?=
 =?iso-8859-1?Q?oLDTkcTqI/0rxaCR2cleSc+bKNmPgYkO5o2Y0AYhrFikFQZujC5mzq+/1Q?=
 =?iso-8859-1?Q?EPeKypR6Z31ws0ylw0h8FN2au0x+nm5Omhac1iA8ibcHMbYDs+HWGGPZVs?=
 =?iso-8859-1?Q?sNDOwFjzISKhfZi8RWDg5aJBwRsEsPQh+pB2hq357poW2QzKf2IMA2YFkb?=
 =?iso-8859-1?Q?kYZC00GlLmPlvjNP36UGEOvE2O1f+gPNV9f6Hv8w8Z8Qmsohec8z50X7/Y?=
 =?iso-8859-1?Q?G3XYoB0zs40/7h5m++bEm2AnHm1hzxkY8GOGr/0hzt224tTnAaEpeHZ9Fu?=
 =?iso-8859-1?Q?fNJYv7Jblqyb9DaLWZ6GzzLP1HCZOmS103OasLshi6D293R3GH+oLXa/24?=
 =?iso-8859-1?Q?1MpwfVU5rywq+jJKpIXRHJT5LX3ez/pzJze/q1n5G2gE3UQjaJiYnjBroi?=
 =?iso-8859-1?Q?ADSwKDj3D7vbO/TF8NEFxbN/xLACHqH+sDNSmRQkaVlC2hmxZH7Go7oNJU?=
 =?iso-8859-1?Q?oLLYtUGJbNLK1PJwBiEfX7xLMSZzi+/qYoBZmFpc1amw96TQs/8lrZlduy?=
 =?iso-8859-1?Q?CKLL7P9Hc9I+GqTSMP5ptNEsPKsDnPiFUzULfQYeZ67atV9hyZzIxjMx65?=
 =?iso-8859-1?Q?7EyEGjhhPAnPvO29PS43A5lQ4V7t9s2L5496SiCavSSi33B5AEOZQeyOkk?=
 =?iso-8859-1?Q?CzL8YBIczluLGuIW2Dg3TiZqeXxsHweW6Ui38ZZh/7/XfZK1aBq1dIT6OP?=
 =?iso-8859-1?Q?Ek8hCObM//grWHV+4rJRKVhL/EqOnPF4m4VN5/nUmsgg5rJvX80xgmSAZL?=
 =?iso-8859-1?Q?G49L5KtAGJM8b0DxL1aCEdrLEtxDeMOQeFMRmKqkw+3enQGe68nUO5jz7Y?=
 =?iso-8859-1?Q?GO1rBJEoHJL2P5MkQ2wzCzv34z77jsOjlgwMt8DYmxpEwPrMpm7faoiuht?=
 =?iso-8859-1?Q?GWgqGGC4IhjrisJUm6yEu/N3lDZGNFnM3DVvvlEHnCwrHjj8bKtmfr+a53?=
 =?iso-8859-1?Q?rs7uYTO2bio3REplSuRqeIMmKEoDj1K45tLjb2ts3luk+kqwJD1aw2+7xd?=
 =?iso-8859-1?Q?eMSyMpNl2zaXh6lLmuU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BmEqkUuPTovIFjChXQoFgx9T37KQDNGLRBBNsiFaYryrUod/RQ8BMCwfl0?=
 =?iso-8859-1?Q?9b1QsACtDaw+46M8PkQhHrfEtgbpx7FQ+s5m10GfTQ5q8EbcS8RljGR+o1?=
 =?iso-8859-1?Q?hBR0NhrO5L3SJvna18XSGNhqv0wDGUOv8+NjXeAjo5vy8wO/7KUfWVMbzj?=
 =?iso-8859-1?Q?eC3BHFFuyBbpQ/RF65/06FGlFdXcEJ+rziuxgrfE050HK6S0hxRfzLrx/Z?=
 =?iso-8859-1?Q?1ASDYFej3y7++wNxbL9eIoT1MHtzi+GYJvNnrgp8iZX5qPQ5Sxu6nEjOMB?=
 =?iso-8859-1?Q?+cpgNxvtgXC6tt/0kQQqoRZVBVeGanq/UMRH/3vq76Kn7EB+n3Xn7QDmVz?=
 =?iso-8859-1?Q?geqTJQgBvtJcUecFiERadd2hi6nVkBp2iETwdFISyujX6E3pgE0b2UySB/?=
 =?iso-8859-1?Q?wOoKzDbh8/B4ocbHZ69sJmyhBgX0OL+LMz4Yq7yXvqxH90w2ENxavoYB69?=
 =?iso-8859-1?Q?+RG+Jxqa4IzYsviGbwmDQ9JLdttqsvB26D7ZQLIk5SVWFUqlZ2ejtRAwze?=
 =?iso-8859-1?Q?7qkfBM2XKWEr0e9nxLgfFd/QP21uEPPPvEqQhhKZDF4BX4dSF+terNa+4v?=
 =?iso-8859-1?Q?90VFTEXUdjsyZVTVwnWcHJlWTPGxmEnwBDcU0IDntoqIXXkbKzB2jLT5zz?=
 =?iso-8859-1?Q?h7dgPkxP6ueUcslc7+/pzIpRelMlF5+aadumw6mPbTsIp2xbfbccavF26T?=
 =?iso-8859-1?Q?lw9rO9TdXbU43FrjkAEj4Nz0sL2SE5+k+PDYpK1N8TM3P+/bYUy8ryh77n?=
 =?iso-8859-1?Q?oQyQ/fl9yR7OgsJq6BrpUx4oB7SPxsjESxjfTihcQXcTj+HB04MqqtojFG?=
 =?iso-8859-1?Q?g8lW4zlddqOgxvvR6LjsCxZ57xqusudZQMmbwNf2G8/e7nT8imcNAa2D7l?=
 =?iso-8859-1?Q?fo4GdKU3nrGN05D+QDKLPH4ItlwqDfcnbgyti8VargT6ClbTkAWkdGv9qo?=
 =?iso-8859-1?Q?STnDyGaarsO4JEdnjOGWKYW5glt8hwntflJrWeLeEN11LcYfGfu0jYchBZ?=
 =?iso-8859-1?Q?dna/ZzqQGJkasXjbUEFI7/O8A48Xh6mU6zNmpzjTE3Tqg299p1CxIQjHtr?=
 =?iso-8859-1?Q?O5iA7BWnJojg71Z/PF5/bwjHoaTDfrC9DHZX4x+qcjqaIepaOqRCtpq70H?=
 =?iso-8859-1?Q?bwzk6BSsfNfJhXpwCfWkHYL0+XH994AXIGaqtu3bN9u3cyKmKyve912L1z?=
 =?iso-8859-1?Q?BR9UytcZ7Dt9IhtMTYhc6mV4cmAmch65Xs6GY5fih7+Fg1o2JgGfTA2KNd?=
 =?iso-8859-1?Q?y/ctpPD7IwSJTMWbTkqjpTNZqo7jkizvX6xkpbpJghAbKA4WwyqlErW3/q?=
 =?iso-8859-1?Q?qRWFGv08hL61sGB2VIxBLXBjIOu1wHRw0lxx6/yGV1ckZtuDnYHT+EgdvD?=
 =?iso-8859-1?Q?8slt4xXcDN/K/chQ8fFjLcNmXlukf8rDWMl67PzQWqzwTV/twiUHcpFRZS?=
 =?iso-8859-1?Q?UeEh9jHtSdpumdxI7aZsVTEEzqLKeGNjXQOX2zKwm3aS3NDejTc9Jqjw7O?=
 =?iso-8859-1?Q?9KAlakLmzjSoULCvcDPunf5ImZF+XLq5MAFOGT7c9S893BhWwXvZ6PIfY5?=
 =?iso-8859-1?Q?Zfiqjrf2hTqcnPg5WEji1MAiAyp+UzfezUGoUgcj5RWq9JEaRGQ9lWo4lr?=
 =?iso-8859-1?Q?u8gNfzVfsaY0L/+kfgqSvu8Z3fQwFgWBCZJ490OiMzjw3OfNnY2lDDs3pj?=
 =?iso-8859-1?Q?YBLguwc6GAiiQh9nIiPo4+rOQlVqHa/R3oHDKxlwv8A2Wp9lvRYgFz6GCT?=
 =?iso-8859-1?Q?lac5ppEGVX/OX2qi1NuuAkRsypJTGp6O0n4wc4KVqop7CL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a10011-861b-46fb-d3f3-08de637a8129
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 23:18:13.7177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CG1C1jcdESgKf/MkM2Uv3UG2BK/vlfm9AGKdFOvGvxSIZaC5d94zd0GKig3IChWBnHmLDCqZaI1RSii0SxB8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
Received-SPF: permerror client-ip=52.101.201.32;
 envelope-from=ankita@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 region->mmaps[0].si=
ze =3D region->size;=0A=
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>>=0A=
>> Is this now returns without the trace_xxx , right?=0A=
>>=0A=
>> With that fixed:=0A=
>> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>=0A=
>=0A=
> Right, I think this was probably meant to be 'else if (ret)' so the=0A=
> newly added -EINVAL generates an error w/o trace while the non-error=0A=
> path should fall through.=A0 Thanks,=0A=
=0A=
Thanks for catching that and for the review! Will fix in v2.=

