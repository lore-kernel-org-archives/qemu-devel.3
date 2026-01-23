Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A8BD72379
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFuQ-0003yR-3V; Fri, 23 Jan 2026 07:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjFu4-0003qB-Mq; Fri, 23 Jan 2026 07:04:49 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjFu2-00025v-SH; Fri, 23 Jan 2026 07:04:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TirXf5861aSePWIklPipChgOlMWE0Y35d0KSI9henAoc3hmtO58S88h9yfjKF+KYEv/Rny55+yMARAhbjxwD7/m+Sc8ANCW8SZC/Yyzw0sPYPcevcAuNriBqrC7AP3GApbBqKLEwwo5o9rkoxTfNJrCCoQ6io3zAsSCtBrBWxekiiEWZv5BIpOXA4OBXeOohwIBwcxV37BAQorNPhWUDs134ZX6Xcqu4vnR57nsbgxQwonF8khQbsJE31FLvHmjt2PRWk10eRz2iTY47Tk7KdeJ4qOGFpeyZrr7jnlsYueCn1ncjWedPPlqWIdmCbNADxEn0LUghHXEe/1vKVtVLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqlMayc4Qnhxe7mXfQpdn3RlNwYdDhAg00HGNUvrUgg=;
 b=I8dDncJiF/4L7BSLpWthW4uLhHBsead0kWo8gUSrTRbeQ3NNJOZLN/qGdt1DOvi+RsX5QWF30oKgWtHuSoIvZ7o2sr9mKlApIEZjmDvMEV3/MTFBtKAwNLNahKNtmBJ4eE3WV3P6D1vtj3I7ndQqZJgQCCm1CQXD+44US19r76ob8CJ367l9TQLK+ytD8uy+9sxzVfWXuGYZxfFjTHTZ/5pLO3gNKlehPa7r9wWY5XPVvVzalRSy+vPEKy5VL54//GZwFdqbP2/Paxc3AidCEvtlr+XlYJGBwTDmJhCAa4c0QfRivwSooZEhOwDuGfFr5yMgT2Z2DirGVjEu+42XIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqlMayc4Qnhxe7mXfQpdn3RlNwYdDhAg00HGNUvrUgg=;
 b=cpZxx4zrqqrjILuC5BfZR+LsJ8v5E0f8tl4Qt0T8XQ+UEqzJl9DebPlC0gFGtXm5+spLYA2l13OKkEmIj8rUrV7/52AUVbUm5Epa8YEpd+dWOwq4ZjWJt6nXBLMwnsquxvpmp5Dx1nZcoo9CHx7TuPO1azrNdyaRVAW3LCF+qKgZI91jWyVg5cLgMMApIrgQvTT1ZnPQGQLI47lr7lqpIyoDTVwkwiwzsUAaz9VFRD36omxOAcjZTRHwSy/oYJ+94SRJ0EoVsUQJM6wxcn309C7MvT1BuM/JEh7ge9QVXpfApZEdTA50pC/aTO0IUKetaH0FQSEn6EzaWoY4xaohnA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 12:04:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 12:04:29 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: Eric Auger <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHciv8RXDVv9+SEiEKA20nh1wOeY7VfZT0AgAA/SYCAAAStgIAAAURA
Date: Fri, 23 Jan 2026 12:04:29 +0000
Message-ID: <CH3PR12MB75480D0CDE889070E1F4C448AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
 <20260123114149.000065c5@huawei.com>
 <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
In-Reply-To: <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ1PR12MB6361:EE_
x-ms-office365-filtering-correlation-id: ce856ef8-91a1-41e6-22c2-08de5a778fad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BJUGpqpRVYNuHUIp9z1e8sz1/eekyD2bq4yG+y8zk8xd27AKKb3cPF9vC3wg?=
 =?us-ascii?Q?s7Pbsi88asxUsJ/t0yBV3Tp7yG3YGF7G4tOLXtFXfSi6BJQqxaXxCwqKcuji?=
 =?us-ascii?Q?sRCrO76tM/umwl9vh5eTMwSQq7W3fjHtj3sX/igPoEVoCbApJO5lPGUxlHhm?=
 =?us-ascii?Q?w1TpOJXYyyKVxymWqX4t51cN8I6Oe/ITSsNweMjHTzusgzXTA8NolRG1PnYl?=
 =?us-ascii?Q?DvrI+UbJHkO3ovPHvhdeEJfyPHWUBvQPQpYe13BAw9jVfHKgmVXHPReQaAWd?=
 =?us-ascii?Q?cVtbwUZd0z8b4JLxkewQEWfs7ty+Vks61EBIzLYFhaaLdp3RilTPhggsH4RT?=
 =?us-ascii?Q?36ePJrTwFVdkvj9Rrp/bGYMOTynUi/jQGqu4zKpe+gFhvKtC+S2C0qpXzewm?=
 =?us-ascii?Q?EaFHVdg7O4Jyjmb7ZOVoony55suTnqMtQqi9txHTmYjWrHlrGH7V3WrKe4Ms?=
 =?us-ascii?Q?1J4cP+LinB3ChnSSudWCzTSeSkVsPLG0oHLTNUTLGZp3Q1HEClXSPpzAw1a1?=
 =?us-ascii?Q?H1vAfxWkh5rz2MQaB+XBGTQ2qzzQdq0uO19zC8rSYJ5D/orklRVgYU2rxS5W?=
 =?us-ascii?Q?PF7znXgNONQq98Yrs3frfx5rSgbSjhfeKo2kKIy11Lg1p+Gw/hKYFevy7PpT?=
 =?us-ascii?Q?h9lSTY0nq3t1StzwzRV/xVmBt5uRMhSxORAbShmwm1Kq9tTJCGN9fCwPMwAo?=
 =?us-ascii?Q?zEhrAcWzB/mazpLIiHYFNWu597mapxYuZs1SWBIR3Q+O4Cq/0wPuqfY0x5wH?=
 =?us-ascii?Q?zUqB4UUxZTTL+N2FSspZArri0XimslfVyNSEVgMHZwZj4eseQsVwFkPznNy6?=
 =?us-ascii?Q?mYCjBFeUJnzScgVVirQLwA5H5SQUmxv5oHquB3YMLDJ65c4zGwkXnlY6MXGA?=
 =?us-ascii?Q?2Y9QDj92bBUiARQN8e9AcpQcSvlwVBUca0Xr51Yrote1kS5eAEE5DLJHRsKM?=
 =?us-ascii?Q?9RvbAO8gMeQ+dfG+LiOv9wwU9xY7JjbO3K4Z1KwfsaadLu2hCN70U51bHnzz?=
 =?us-ascii?Q?kHV9bnuMbHcM3IJhwNBHcx9kzifwMjgL6y9L1Bk44MwBLSmPUJKkg6UMjBaq?=
 =?us-ascii?Q?FI2cmHrSBhPZDaV0kVgzkJmATaviDBPp9se4aIvmFduof9NnSMQaq7A0peNO?=
 =?us-ascii?Q?Q42tgg/72FIJGCDiS4TuXtdx3DCWVoToPxfOmgnmm9fx42skGLa1YVDPOEoq?=
 =?us-ascii?Q?YI8uNKT65+khQkdMhtZutF1DwuSG4ejaOZ4EfwkQGt4aFkFhTeGlRtJ+mM5x?=
 =?us-ascii?Q?EspJ9PAvHdGBihE1g5/8opKFZcGK7h8X8yV+CuKK3dlevhp62o+Tuq9OFjd8?=
 =?us-ascii?Q?kVRdOaC8CnKWTl9P82NQdfk2+dWnz1Tiwg+nT/x7haP4d0qwk7kKsuNmcOIc?=
 =?us-ascii?Q?ghYN7Qg8y7PvUP+E5wbsOUmPHGkpo3AzcETxyYYWdiDduIaUcUDPvWEhbfm0?=
 =?us-ascii?Q?m2xKogSnJoGX69X8Hc14aLUDl5yxURaaFIrEJAUI4QUqfY432qNNGRHUcYJg?=
 =?us-ascii?Q?BqxHuhEfK8N8Cy067xrlA79D9KS0mlFO9lTKC1yN9XWKx61bz6lRCblZJdGZ?=
 =?us-ascii?Q?Z7jzyPk33D8n16jOJV1/oPghMhzz7QHPjrOsGPov?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L7fsk3NTt8tw9e7s8HDSikikL/Hs1Y5yg45jZERfX3vYQ7woESyGoJhecOWJ?=
 =?us-ascii?Q?UvDiS/VgCVX6BDIKi9Yv9WtNsaUKH81e1HUgFxic0SvaGh0wHDievR47oCnm?=
 =?us-ascii?Q?Chd3zyEzcz8b5KP/AkDtpQ4Po5T/YMAUftg0oP5X6j1qWnIrl67rwzR+mbpr?=
 =?us-ascii?Q?2enR4j4cNMiTYFNr4pbvYR9NrHpYFPdydPdmWF9KZ/6SeS8hVA2eqomQ/i8d?=
 =?us-ascii?Q?V0FUZDOOO6U50rlaoZpLCLgKPpXoF0Ej1I0qQOGRE4U7bnJkUjY5rMKTAEQB?=
 =?us-ascii?Q?Ra8cC8vB0kV3i7fIBG5+oTea3XCUKsYeQ0lJyDF73+ZVdx84T6Sh6cWcviuM?=
 =?us-ascii?Q?m3sqbE9+gEi9Tz407LAPWwKTCNOme/hBXwaxIkOPCySIDRSg97b5Lg4ET/vV?=
 =?us-ascii?Q?fwQDtIYY60yMJTNwolA5ERNyTm392WQkVIGnvIDUW/JCgpM27nwA4LXilXB0?=
 =?us-ascii?Q?JgYZfC1y/C3/a4AjpRL5DWYNAzDSnw1cGuYOPulxgHRPgQo58NYVNcX/eTV1?=
 =?us-ascii?Q?3DLxHRXKxX5ylGYd6xYOWQdokiCysMd6jC9p4FBfb49JBfevn8O8M2H9QovF?=
 =?us-ascii?Q?9E5OEmtWs5Z9XLWbLsgmQZrt0Sfx9X1qFbpobblmi2/+tgWJzbih3jYxUmWP?=
 =?us-ascii?Q?HNebB4FifEj3DBXGzcFZNNnLk3pD6nchMvhWAJpySPyWX7gwIok8fdd3xZGA?=
 =?us-ascii?Q?GEA/+plZ9G+vWLd5kV8SOEUcjXrtURAY18hzNI+gaPVK3e/h4QALxRGR0uVO?=
 =?us-ascii?Q?R0oeG0MelIAj2/rJIp0s6hCoYoF6aUOjcEbOAOfdN0WZhHyaZr4Y1AAwcZHq?=
 =?us-ascii?Q?bpxzPsdWyabLfyTYLXBXxaM3SLyufvIjpL/NurNZr2fD1MXmGoyDRCyC2Xho?=
 =?us-ascii?Q?bBaB2iHzY7zpiSDcwIOtGUtBS3IXEJpdCWM6YYdRKKjSOKXj1oehg8wTtAP4?=
 =?us-ascii?Q?xnjc0ouYla0yvKIIjn7gMrpdwFwZSyO2UrEdbAbp8UXycfGlQELz/hkqI1Mw?=
 =?us-ascii?Q?qhHM6xzHL1hXJ1sdQeJyv1alegfTHAE1+fW7jfER9ECgn3Uh1buumUNcJ4Lf?=
 =?us-ascii?Q?78d3m7qrLiZ9jgWKFeOAUonsz58txxz0gg1g+OZkCe1a5MoZ/kGy2bKVdeX2?=
 =?us-ascii?Q?HFnuactQUAQwrpnZsdPM4r5RKcfiwysqGZbkskLuJ+CteEJdPtwjasVn42jr?=
 =?us-ascii?Q?4baCnvzzwsYJYnn0+1L4bxaJ34ynQUb1qe74tYpaXRBW52WLZGCXcPNX8JDW?=
 =?us-ascii?Q?wAVNUO8miY0vC2w6S2dCUdjhTaCRPoH6huvbGEpOlmDOlEmeBtegjSgHTlsE?=
 =?us-ascii?Q?RVDGP58/nvATWMIIfB4Gs1KtBVTTzBiiRXhX+afcyv4hBHFI7bUxGWb5KXQF?=
 =?us-ascii?Q?VOacF8eZmGkv2iTMDfFa04W/+HAopkRuOTg31X6VleDuq40jvRi/oa/8/C4N?=
 =?us-ascii?Q?trPscADGz5wKtqDjg2xYZkRzIYjn8Ft6W6vCh/CX6P0d3AzcR/w/eedC07VQ?=
 =?us-ascii?Q?bzidb3pH6DJxqZfUH+0rdcz8LAEKQZGtptN7Tlrqu3g8/hIOxk5CgIu9rs3U?=
 =?us-ascii?Q?vs9N9SFVADsz4sIOC35qCeDpELpK2c142LG+ncazUsKew+hTusQdObHI+NWa?=
 =?us-ascii?Q?4Hyqabei7Kbx0q0AFtZB1Oja5OhtwZpq/FxApOSNfP5oKDdein10e6uJvqIN?=
 =?us-ascii?Q?CjMK0njM9Z5adkWRC1FBS6LZd0z5akipo5K99LFvcGn6ZwRrMPMcwJuvDyi+?=
 =?us-ascii?Q?OneTGAlDCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce856ef8-91a1-41e6-22c2-08de5a778fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 12:04:29.0497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GFnJuk5ff2oEO20IhuLwnP54k2YKwoOoW+a9RFksJlj+4xOtSOefJ/mN0B42LKWTGAUEidpN46A219o/EM8dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: 23 January 2026 11:59
> To: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Eric Auger <eric.auger@redhat.com>; Shameer Kolothum
> <skolothumtho@nvidia.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; Richard Henderson <richard.henderson@linaro.org>;
> Jason Gunthorpe <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> ddutile@redhat.com; berrange@redhat.com; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
> accelerated SMMUv3
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 23 Jan 2026 at 11:41, Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Fri, 23 Jan 2026 08:55:18 +0100
> > Eric Auger <eric.auger@redhat.com> wrote:
> >
> > > Hi Peter, Richard,
> > >
> > > On 1/21/26 6:52 PM, Shameer Kolothum wrote:
> > > > Hi,
> > > >
> > > > Changes since v7:
> > > >
> > > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > lore.kernel.org%2Fqemu-devel%2F20260111195508.106943-1-
> skolothumth
> > > >
> o%40nvidia.com%2F&data=3D05%7C02%7Cskolothumtho%40nvidia.com%7C4
> dc79
> > > >
> 79cc1814987fccc08de5a76c402%7C43083d15727340c1b7db39efd9ccc17a
> %7C0
> > > >
> %7C0%7C639047663322567693%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
> 0eU1hcGki
> > > >
> OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIj
> > > >
> oyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DH26lLiSX8ItkQJgPVvhVPz5aJwwVIo
> sVwSEP
> > > > NjvKjS4%3D&reserved=3D0  -Addressed comments and collected R-by and
> > > > T-by tags. Thanks!.
> > > >  -Rebased to latest master.
> > > >  -Reworked PASID support patches (patch #34, #36).
> > > >
> > > > I think this series is in good shape now and mature enough for incl=
usion.
> > > >
> > > > Patch organization:
> > > >
> > > > 1-28: Enable accelerated SMMUv3 with features aligned to the
> > > > default QEMU
> > > > SMMUv3 implementation, including IORT RMR-based MSI support.
> > > >
> > > > 29-31: Add user-configurable options for RIL, ATS, and OAS features=
.
> > > >
> > > > 32-37: Add PASID support, including required VFIO changes.
> > > >
> > > > Please take a look and let me know your feedback.
> > >
> > > This big series collected R-b's and T-bs for all patches I think.
> > > Please could you consider pulling it?
> >
> > I definitely support getting this merged now.
> >
> > I'm seeing an indent snafu in patch 18 though which either Shameer
> > needs to tidy up in a v9 or it needs a bit of hand tweaking by the
> > person queuing this up for a pull request.
>=20
> I can fix that up when I queue it into target-arm.next.
>=20
> Thanks to everybody who helped with code review on this series:
> not having to do that myself has been a big help for my personal workload=
 :-)

Thanks for sorting it while queuing.

And cheers everyone for the reviews and help!

Shameer

