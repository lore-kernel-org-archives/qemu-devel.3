Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D667F8D74A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDNZj-0005lm-AR; Thu, 16 Apr 2026 10:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wDNZY-0005jy-Tu; Thu, 16 Apr 2026 10:20:01 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wDNZX-00053k-BI; Thu, 16 Apr 2026 10:20:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2xNuIO1/ICRimkXm/8Tzf6mBaU+39bbDN5kok8349zT/9+uDGBtXrCdlrYHAryVEolLIPjDAkXEtd3MwbuZC+LSxpGtocBLfbl+8mSxbETzIG+E9lZoi9/pliZi6A5Hz33P10kbAY4ymEJfdH3oUfeZWfnMM7KNhmW3z5iTV8JNhpuzRWDeFEjouq2bS8MBnUglDyM15PJh83M9Hkz1WCuN7SYUICPClxoTxYlt0xCyg1Y6borZUyEyVRb86DynFjGeTnEdYY72yUPcF3pXo2OCNvcpL1ExoCd9NK0p4L6EK4KOoKsNL/sIM4qzZFYcTYTjbGRahkInsNexycN77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNRcSK5gT0Gwu3uFmK1NAe6qqQOUQBeZycg/AsT6tCs=;
 b=tWyI9rMwRd5Q9HhrVjp+PW29gXBfpBi7/HtrIKvxyRYmmsOyEI51e5/sPnNENMNsDpY+eNcHGFuQtm9PVOgEnvSPc8xYaG8xR/7rMiIsOY+bQ/BZOHMfWJmkuRuyzPvP7MsKtQJ6ZhOXDWmSrSoEXK63C7IlS76ngxUtliGYcdQUyXZ0yfEBLWkf4LDUEo5/50usbUuIiod7dYv3TUI5WY7GZt4vXhAE3NQAFCQ4xM+mK9PSsIHdIPvF9KJLiX4PS+uNcOHx7wyKInHFDQdfwMGktmiNg+oRPJ6mlKXbR48rP6ka9on92cDSiEaSmnwvf1uighvKR8J2aVZUbEYIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNRcSK5gT0Gwu3uFmK1NAe6qqQOUQBeZycg/AsT6tCs=;
 b=D5oT1wgVXj+9dq4xONMGi+7r/vAfxLucMG8kvrYlh5N/NsiN9RqZYJtn6ziU1fb7z34C8xFU0gwlrhYNyVlpm8pEpouP521JUja6TX9/75/jSsv6vD4y/1sLWLZjUPs7jvD3XfVxjb1Mz0+0ndtvmnQJFOC5Hm52JgJ4LkenNNqQkj/UXHZaBmlyJFcU9wE+zWohqP6e5CmVViwddkaq6ODuxYVosMql/ni5PuBNsysmlfm2SQiaBEbCyV06dJ9H6+7AorKpYUG5I1+XC2JEjlxxohkgGjwxR8ZSxPE74fv2VPFyLOhRrIYsWB84YlMa3rDg+/x3hzK6EjW74cVF3w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 14:19:53 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:19:53 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 11/11] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Thread-Topic: [PATCH 11/11] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Thread-Index: AQHcwXNIzYS2AqSNVUi3Yct77bJ5ULXh036A
Date: Thu, 16 Apr 2026 14:19:52 +0000
Message-ID: <CH3PR12MB7548054E649B96F63DF1E56AAB232@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-12-nathanc@nvidia.com>
In-Reply-To: <20260401010231.4166776-12-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PPF73BED5E32:EE_
x-ms-office365-filtering-correlation-id: 0ac745dc-c03c-4352-e9fb-08de9bc33a2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: E4E6qs3SE4RaoQwfb2Mc4882gqkT2fTneat1mLV10uu6uxaA/3z2KXpJup1wNskgtdyIw8SVOEoEc7am/NtwNfMzFGZVjsfrxkrjIqIaGFN3j8ulCfyWc1ZXhr9zfu/RKHpr2bghBp/K5l0q2x3SGEBGnjF+DL4EK+FIYlRn4vd4GHVnUl19WvQuF1whipQxhumrsfhDOuzL0PjVvdyd4QjfHs8TPKqCG5T451RMmdF23Jf7xMIWdoJPlIY+opaH+hk9ZDmv8CCl9omWZl1bYRwDP1KCIJKWrjD3MMf3Ejj1Zfh+AqKQKLjyju1SLaEowsKRUA/pOjWtOzXy9HZZ+SUFiQqC0+jSLdmVySX7dDiLr3wdLyvsfY8p041stMflYeF60R27Hu1159O6hr2SB8r5eXf5twiboYzLFNpFspHMcEE5U4ON2Jhu7nz97j80VHbHAPLVer7dqU8Tb2Lb36sOvoBusNn/NVBebLPikENP4XoqvAsnrUX4LuDt90Hf36B1HlXZ7UflH8bptZeRUSfnbg+ZOS5anm+/yNhoeXIybiCQStizzFwLrrmYWitxKAD3xivsTnwx/RlRC6D/WMzR7CFlXVma4ANin1eAjTqTWkFN0jAWdC98UJArfCo03tZ4A9mM29Pc8TXvOYmK77BksCbRR847vV6A3QWKulOLHR/HxzmYIxnVEGFlbCYsfQKOUgUyLlziAK4cUuyoFHPjXe49bbytqJybmRfWYKRXKJ56WJSC4TWTZLl4fmy9e5XtMwno1Ur7Hm68K3GJBJ1AJ/o7229f/Thcj2vyRAk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lPkxevRypxY4pxrKhPvKJb7/N/r+7dlCjupm7G6VvWwL7znMTDPzUFYCVl?=
 =?iso-8859-1?Q?V9FV/7A5DXBxSilb69u+o5gfsBy5SjC3qThCNvPFuGsgMftfyxUqbhad9Q?=
 =?iso-8859-1?Q?gyiThnyn48cZz6mGGNRQVBdIZty4Sm3Kg5yJwVyS+r1MJz4WynY5eAtGO3?=
 =?iso-8859-1?Q?m+GSAmutgdv8y+++wACPrMpTzNNwU4ws8nxr8cbxtID9O7Gz58eOFh1CA1?=
 =?iso-8859-1?Q?fHnC0AbEnEiFQWSzFmi0OIFT916B0FQ8qMfPd4XFp/wgzuRKMjKlJT58qk?=
 =?iso-8859-1?Q?SnR0fjrk9QTOR1F7CQjpQs9z+dFDGKJ+LpgSfLds9JmVhHsHqVb8mL2a7q?=
 =?iso-8859-1?Q?XWJM3XzpxwDCfw1XIXh+GNx8YV30wnMCJEPr6KhMWaDIDQoQ2xHKBmG6IB?=
 =?iso-8859-1?Q?E3GSXLck+qh65Uvn/RyOCLjjJtmdzskgPhvT5MTAQyVPe8IvzUmOK4EUu3?=
 =?iso-8859-1?Q?iF+Vyav1Vt8c8kBHBoqhAL5zRLJUsW8QmVT8UjgDxYBrvkg95XDw+aGpKC?=
 =?iso-8859-1?Q?sg61v/5t/5bkGTIdL1oTamwVDZfq0QxgiIBrSYaXJ9V3uIJlOW+JFpq1aL?=
 =?iso-8859-1?Q?dQZUyE8Hqlq7mSjDNvH2tqApaH+zyXDj2SPdRG9NL9mUKqZN5yOIXejZ6g?=
 =?iso-8859-1?Q?erwVsiLvmYeHJIARrrABDWCQlGnd+RWgDSKyfrWCC95pzPuWtgeQeqi3Pi?=
 =?iso-8859-1?Q?tOcG5KsDAJxU9WtLEpjC+HZs8KIhBf4tEoMELVB5Q6HIodND53tTQYq0of?=
 =?iso-8859-1?Q?J0GUqxOASNJgXuQdgSnTbAHHAsGRQLSxU8o6K5zzeWyi5D9W0Tmsi9fNps?=
 =?iso-8859-1?Q?CTblWuO3BQ4wV3zJLyF0U4yHWN8hfB2NVIX6XByJgLsepGrYoUHpJSNFIN?=
 =?iso-8859-1?Q?dbG0aFNVAl2wRtSlMRxA/hTsp522fwWhwBVoZufjPO2wAkcYhmKQqPlSFO?=
 =?iso-8859-1?Q?39sdJjjk13IdNjUK3mqxvQ5Ix2eeLKuP1eXquNRN5eo+3jZ0EXgxRfJ3Ve?=
 =?iso-8859-1?Q?hdzbolCOa7Sg9pFrQsyVUmhkU52wcJc8uk7m6tyDPmDal2OyQS2OWE3xmA?=
 =?iso-8859-1?Q?h6VDT1sOF4jJwj5vgQ4D87NgwsEEdR4S2c5ElQo2xhUYqRheN0UhuXVqJM?=
 =?iso-8859-1?Q?lwKBGs0s0Oa60FfC1LeP5BUugb1zDq8H62pgWTXdZFLozZhgxVJwPQ/Yyo?=
 =?iso-8859-1?Q?cJhnDjkE8fICLa8KV/BM/H0UFVduJ7ykIB2yKSN4fSKFK+tAp8JFlvkrX5?=
 =?iso-8859-1?Q?v6QXulphOD3r4TlKxoxAyEwH4Vc68ddqV12TUUWrqC0fnfxLIUZIreGqkS?=
 =?iso-8859-1?Q?Lqii1SGDIB+kQ/R8xX+7gZgKUdvVfjq17I9xhR3uIyG46l2yHJ8O+C6LA0?=
 =?iso-8859-1?Q?o97uJf8kp/aV5EhxdqLi35I+2hi2MzVTYOiu2G4I7mO6C+aVeDnz+iSVHN?=
 =?iso-8859-1?Q?IiCApixo+JswDbuYak4tw7H/7mSLV0wDn7z0b3QeU25bRU2JX0/2hP2DpQ?=
 =?iso-8859-1?Q?t07dvxYRNo87I/7wW0kEw1+R1mgBa85pd9ofg65gWa2EcGUkAY2EyiEoI1?=
 =?iso-8859-1?Q?AMYM5uvt14BXlNGbGycjNAp4FoDSB5p/0nVDorsP0x+DnZpdN2cK35MD7G?=
 =?iso-8859-1?Q?I+oLAouCf7Fvy6UZ49G25ezGqERv7rnMFDoSmRjqNmCqylV0ZqjyGe66wC?=
 =?iso-8859-1?Q?GMICmcJJX3/LWoeZeqsZALiRg35jNs1IdYF6CtGdqQOrYuoFbX3nXPeEUy?=
 =?iso-8859-1?Q?nKYHmrx96UK8tibrcJ/2Svhz8HZPgeft7D6po/PLJLjKZ8oypc4xubl1++?=
 =?iso-8859-1?Q?7LjJJImHOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac745dc-c03c-4352-e9fb-08de9bc33a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 14:19:52.9748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WU8gNW8f59Fax7lK4GozbYLRB52u6mL3x3oRiQzIhQELdR6gsHJS6kW6vyZIUK8gvGutOq27K0YVrXXVhMB7AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 01 April 2026 02:03
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
> Zhenzhong Duan <zhenzhong.duan@intel.com>; Peter Maydell
> <peter.maydell@linaro.org>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daud=E9
> <philmd@linaro.org>; Yanan Wang <wangyanan55@huawei.com>; Zhao Liu
> <zhao1.liu@intel.com>; Alex Williamson <alex@shazbot.org>; C=E9dric Le Go=
ater
> <clg@redhat.com>; Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> Matt Ochs <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH 11/11] qemu-options.hx: Support "auto" for accel SMMUv3
> properties
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Update documentation now that "auto" is supported for accelerated
> SMMUv3 properties.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  qemu-options.hx | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx index
> 21972f8326..bd43258445 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1292,7 +1292,6 @@ SRST
>          vfio-pci passthrough.
>=20
>       The following options are available when accel=3Don.
> -     Note: 'auto' mode is not currently supported.
>=20
>      ``ril=3Don|off`` (default: on)
>          Support for Range Invalidation, which allows the SMMUv3 driver t=
o

default: auto ?

This applies to all other properties as well.=20
=20
Also, it may be useful to clarify the "auto" behaviour, something like:

When set to auto, the value is derived from the host SMMUv3
capabilities via IOMMU_GET_HW_INFO. This requires at least one
cold-plugged   vfio-pci device; if none is present at machine init,
QEMU will abort.

Thanks,
Shameer


