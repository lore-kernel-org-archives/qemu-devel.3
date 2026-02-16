Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C3FEDF142
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruGa-0006Dt-9k; Mon, 16 Feb 2026 03:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vruGX-0006D8-O3; Mon, 16 Feb 2026 03:47:37 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vruGU-0000a2-2G; Mon, 16 Feb 2026 03:47:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfZfcFJ3wszHDtVCN8daTL9tTvoW7kMIsELkGGTXQ8SXlZJC15/E8WOsWOOZg8X07LoIQIvGd491kbZmiqz8HvC1v/z0k+kEblqm11T3Po+o7j6OypsKeh+bLjtzAmkjDYCpeesrxoWKH1aVFWPNtf0LIH78inr33oT+LN3SbTLubLVcm6bikKSrdUXHt4i/C9H8pLrqEBkJBT75+xfZSgabuU7mAfbxxX0zs0/lADPMzyr1mA4QcGPT5lzMb2zzJ34Y4jBQvjVwnbLnXdQ/bWCaDauZCWWUFZhcJEdRLPbCita56bsOMSjth9ayZgZ9OXxJ8dz0vGlHH+bOS81Qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6rkIkoo52B/CNPOc9OGd+ubClSYH+uMa67aXJO8l8M=;
 b=vl+x4g5d8jPKmd6MUU6uOJNe9S0CzjY+1AMck3P5XOwRurCO4+uvi0UCT4lW8Qno9RJm8w931ZeMZIGymwFlv3QJZab4QHdASJ+3WQNAVdHNm+36Z1YZJsagcvORfjlXP6wqZQH8yxnIp7AII+rSP8VxgQi2+HAHWYPXuOBRPVyjFfNaPrjgKoc+qPFFH6yHjU1IW9htjUjhRmtJDrgHHqqkQMZW67MBRH6P1T66vnfWw+B/0/dU/PoC1HilqVNE776fa0z6VmLQeYBQKoYX6i0WSGUqKm3q+tfU727Mfskj73WvM47Nub7HzFJepLtlIpiDIBQ+mYqLH2AQ0wXpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6rkIkoo52B/CNPOc9OGd+ubClSYH+uMa67aXJO8l8M=;
 b=eiZKU//5R8SmmKxz/eahxscb5FCISLwXW8OUzAF82QnIG0JQeO3+s3150HTxFXjJ8a0tOwmyU9tSREOrI7OBX+ETC9YsL9YFJMVKrBKoUVmb8oD6HHUacfAVlUK5t0QdE9SIuhAmbqy876hLQUIk+irh3YV2X+sfqm9Krr+0+9sZBe816vnN2sbYyIhd0Da/gnbYsrt6G84LQTvnJsINv+T9qBNIz0H3eHP5IP32m+gXC5W2L3Avr0ztqgkS6z8tgH69bdfva8UGZnCEXLbEGG2iWW/gWE1hAIkK//YFfXzKGenn710M5coujLGbdMylCWtq+mnRZLyiyI1jScYYbQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:47:28 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 08:47:28 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v2 18/24] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Thread-Topic: [PATCH v2 18/24] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Thread-Index: AQHcl3f9y+i+U9/QGkSwr+6DL/lxT7WBUi2AgAO/QXA=
Date: Mon, 16 Feb 2026 08:47:27 +0000
Message-ID: <CH3PR12MB7548181422C31426CC4ED295AB6CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-19-skolothumtho@nvidia.com>
 <aY+zx++9jISoKBiR@nvidia.com>
In-Reply-To: <aY+zx++9jISoKBiR@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB7985:EE_
x-ms-office365-filtering-correlation-id: 65812e4e-4c41-4539-bd27-08de6d38039f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gQVNSpPbaha5I0642RoxBNA3qtLNiYCreorpNetpPVpKWw7/+vrKV13XtplN?=
 =?us-ascii?Q?V+XpYETy1ruWkRauv6/NeVIGHj+m1raLnz/PyHITXHPH1/V0/LJjraBnMfdi?=
 =?us-ascii?Q?uBhIZof2qRXW9m9B8U8SSyXdQ9vDtMJPPZsVptB/h8MrQIl+HIhfwmt25wA9?=
 =?us-ascii?Q?hOZbxVeCkfuUPF7fScylxCaFtN4OjePA58mbI86fkj0Cir0XQAD8rgsT3qXV?=
 =?us-ascii?Q?gDXM8IEAjH4aVvsWdQMRGPsjCVvsIxw0QF42vpE8FpKEUMYBVgvqJzxgjRQY?=
 =?us-ascii?Q?D8pdhq04UEs02yplg96olmuj/KiOdko4lUa4z5wsY+V7nTL0JRNMRUHzGHAv?=
 =?us-ascii?Q?bZeegfx2okJ9dj04rk9yUz/nlIRD0CGyoh26lzgKYryhF9SWNHpQzt1ckhzM?=
 =?us-ascii?Q?uj3HiLQAu0ZPy87FEsceKa8AdpcjWO+zTAF0h2b8fR4I+P5khq8UDNIXvabo?=
 =?us-ascii?Q?+pJkK2l8+ZDxbA7ZV/U8jQlMJOtgX0C2dwsJE4/YI1ofk2+Lby49l8RFIKnd?=
 =?us-ascii?Q?NONH0Y67mBpFpUWTLTGYy1IBrXagyN4zS0JtokqtqNCtD9hMhjPnSUOTvzKE?=
 =?us-ascii?Q?pCPV93aIh+cJOrhrYL0USIsshrE7yN/CZ/gQ/IIdFcV2/FJqnzI1KJqoQAMQ?=
 =?us-ascii?Q?YCpcYjSEfvTXT/lgk6D3ca8I6TfzoO8HlopaNgpHaVCFm0o6J/p14I6PHszf?=
 =?us-ascii?Q?CSPuy89KoM/P8iJ5ATnrnizU2bGSYQyNBM1lip/kCSJJRFSRr3MhGQZX/bNW?=
 =?us-ascii?Q?WpbCrdcJrrBX+mKlDAxYNLzk+4vvyczaiKDw5oXOsb8Y8AaKgzzm5G1poA7W?=
 =?us-ascii?Q?M0OHBFpC0blJW6pnvAokyLrmB1ME7GXHgoZ1zDRVNRJQ8PCNQI4ST+R+K3yj?=
 =?us-ascii?Q?qEfbhp/HlDzBCz2Trd4zXR/w0PNTFfUfaDPp6vpvnQiBgylYJ1QguEaLoBe+?=
 =?us-ascii?Q?6vBgLO5XgGmV0A/w/U3fck1OA2YyCZt1ePBcVt6kdCqOIvUx5b1Tn2WMQyl8?=
 =?us-ascii?Q?sK7PhNm7F5x+wB8HIWBNxpj6QSpE8SVjuclb1DAUM2KRHMLdlLmrRvz8CbYx?=
 =?us-ascii?Q?AoyQfPMfAWsgw1EsUrAat6Mlp9Sdkz4upXNJrS9xWkgZI5we9dre8jjS8q49?=
 =?us-ascii?Q?7FgBDYm56Rvp/P+DsU/3PSbK9TTZnqkJwVmwBlFKpOOSuIFxknbcckCIOFku?=
 =?us-ascii?Q?BzrsUUX87qeV6NRv6IuNJfLISn/ffBvXGiqaSO90LiImhTStukvrxo30FZCC?=
 =?us-ascii?Q?c7bsfe8Ow9MI6fTEaXoeJ95raECU2O9I0LCrhHVhpGfoT0xON+r/4Oay/kti?=
 =?us-ascii?Q?ZwZxjwWFrqjhG4pZby8rgTKGBU/dH2jJKxpJ/8kbsAQNn0VmLlLfcQiUYD60?=
 =?us-ascii?Q?22SvFPrNreVQXZXY2ozu0TDk2g3VHEbhHhekwMuRcICIGZMMoSi1ckEQmNhU?=
 =?us-ascii?Q?oevAb7fKPvE+BeRPUazMBtCa6InvBOdQJcAVwosowLCuLqDpO8rrytJiRdWh?=
 =?us-ascii?Q?3BKUgwWTed8A42NLNKkM1ox18p+zOBFiKwYHo9MPIVA28qknAYETXbm9uEkY?=
 =?us-ascii?Q?agQktv7ymY5pjAAtCPnlE0rocvomVseVAxuzaNqGlxXH8/VZidD30BqeHFwz?=
 =?us-ascii?Q?ZEsVh+PpKacbtMevaP52MEw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QRTjNxV2awhlcECn8R6tGdYyrn/Qxr9eFqANZXeO6tHtQ6lUcYGcL84KZgO0?=
 =?us-ascii?Q?AI3fii5Yyd6laWFMH8s2KcwmecOIC8pbEz48w+eUUuLTYLMmmTBlV7d7ioMH?=
 =?us-ascii?Q?RLoZpsByPrMmFvXWDRdb3ZjND2913/0aqsTOOBOEpC9Akgfc3hm6R4w3KZBB?=
 =?us-ascii?Q?kyNDz1T+l7mrNRkoNmjUw+ma6Ob8eAsw1uGRXuIbl9xggzaBy3v7TOAN0qU3?=
 =?us-ascii?Q?PD/W+EDQlBJ8sIQauFspQIaAVFzrs+lr8VbQeNXNRPjU3iaSv3j5IAmkkoL+?=
 =?us-ascii?Q?PCep5i9XnhW+J0GFbH1RwJ5hnF+FY8G6EvF06EHsc618MGpe/IzH++388BNc?=
 =?us-ascii?Q?toR0oqSEfb58moyGNjBryPDT24oQr3uzX7bM//ecynJY55Y8sCByR8oOwGod?=
 =?us-ascii?Q?cxgLf6Be2RJrWW8RgSn7HB256zI4aHpgGUGxuQECWGtvUeuwL76j73kuU1ke?=
 =?us-ascii?Q?SP0xQKC83uvJ4e0P4TBVfQzdUUk6zD59WUauW0v4w3Pgfs8h1OXbafVNt7Vq?=
 =?us-ascii?Q?TfXWCvcw8YGKRT92qhDu97OIfRehcL1Vj+zZjTajyWEiOvKSp1WeBOBZ9njp?=
 =?us-ascii?Q?94scUkxzA2Q9hGZ1QieqGdw35TsZtwoxSXl8Y2eoQjlSAWGtN9b/1gVdScdQ?=
 =?us-ascii?Q?FTxTl7D+ka1MhFgTUUZ2AsewiHbx0kXalvctoC9v5AD+ROe+KcXvT/stCcZf?=
 =?us-ascii?Q?Sqzaj7CKGVsPfmFBfe0SNypjuCWcy/KU5+HphdGY33wra/HKQxV1R53zhDKH?=
 =?us-ascii?Q?5GFwZG6LkmdrnY2k1s3ITHmJVqI3tFx8rAXiLKSOcz27Mzu42Hu5L8OTXpk4?=
 =?us-ascii?Q?9rmhj0h2cUEntZjQU8pEtF6Yi9ffcVGQgpE40z99w7xywKvQWHyGQzIg5T4p?=
 =?us-ascii?Q?vMFiqdP6oqJ+kajFvKyzW36BIz6/StzpWYXiwwBAXXkbsBfjACbcdMNet7Hg?=
 =?us-ascii?Q?XK+RdKt8wcoTQtkB8iRACuGL/K/ellyKjtUSYhR5e7cq4QrvvOzkP6vE+O1U?=
 =?us-ascii?Q?U7fQjJaRAzjrvZuC807McBAOGYEbTR5OV9/PACQ/yFwbSqDYoAI4YbRzVXEO?=
 =?us-ascii?Q?Iw+DluVfVu4tPlM1i4bQpWupS3wqFG0LkblBNPh6tUqlpE4hsUSHhujR2JET?=
 =?us-ascii?Q?OpaM2Aq/t5E75l5J7CrPypLGd1wnf17AR4cIcJZfWKxFCdYiraFA/tAMzXFV?=
 =?us-ascii?Q?NGzrqPPuu1A2rciB2tu2uXRMCmHi95bqHWWgrA6s+AB4RHhgeesqyvpHxAdH?=
 =?us-ascii?Q?RnXa0wVLHlfKtL2DjnjUAGki3g0cEHmEOZe6zfLzkzookFk74+qUsF6EcScW?=
 =?us-ascii?Q?lAyJH2ffOxLPB+hKLQZ0xrw1n4Lwk7SWO2yisKNwnWvn3lFOcQ9d7WO1fYAj?=
 =?us-ascii?Q?MmKsj/2dYEoyuAFsQVmO5vFzahPJ+pVltcDdCJqPrGbRxrJhMNs+UvBkwpwP?=
 =?us-ascii?Q?jUEeQ4mIl17FIfXoIoilXE74I11cFM9T4pNMkY6ALjIUQI0ze1POoOKya777?=
 =?us-ascii?Q?zBaJKVqgI70fugqQ4cOsRDxBVRBiBkG1glvljUphKEWyB3ja55T3mLpVqKIo?=
 =?us-ascii?Q?uF91MvkZY+EYzbPx2lFCTNtx3O39diFDiYY+UEwRDRIfqL6cOL+4SMr2S90a?=
 =?us-ascii?Q?e5PCpRzk93Y9lrFejOZ8UK7X5PH/Q4AxpHMPsnN9DLDItxRi5JtSU1IWebsL?=
 =?us-ascii?Q?VqoyEqxVrsFVAfGn358w4nkuGVJsPDO/g+bVQrS3MUUni1CTZMfjafRfyHFy?=
 =?us-ascii?Q?YpQX33w3Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65812e4e-4c41-4539-bd27-08de6d38039f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 08:47:27.9446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8dgjDOez5BS7usGWYn0g02YprwSYNID4oEA/dgIr5uAseD2Jx/E7Dtjoj/5q8VBey3uXKb72fDrqwgOJecWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 13 February 2026 23:29
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 18/24] hw/arm/tegra241-cmdqv: Read and propagate
> Tegra241 CMDQV errors
>=20
> On Fri, Feb 06, 2026 at 02:48:17PM +0000, Shameer Kolothum wrote:
> > +static void tegra241_cmdqv_event_read(void *opaque)
> > +{
> [...]
> > +    bytes =3D read(cmdqv->veventq->veventq_fd, &buf, sizeof(buf));
> > +    if (bytes <=3D 0) {
> > +        if (errno =3D=3D EAGAIN || errno =3D=3D EINTR) {
> > +            return;
> > +        }
> > +        error_report_once("Tegra241 CMDQV: vEVENTQ: read failed (%m)")=
;
> > +        return;
> > +    }
> > +
> > +    if (bytes =3D=3D sizeof(buf.hdr) &&
> > +        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
> > +        error_report_once("Tegra241 CMDQV: vEVENTQ has lost events");
> > +        return;
> > +    }
> > +
> > +    if (bytes < sizeof(buf)) {
> > +        error_report_once("Tegra241 `CMDQV: vEVENTQ: incomplete read
> (%zd/%zd bytes)",
> > +                          bytes, sizeof(buf));
> > +        cmdqv->event_start =3D false;
> > +        return;
> > +    }
> > +
> > +    /* Check sequence in hdr for lost events if any */
> > +    if (cmdqv->event_start && (buf.hdr.sequence - last_seq !=3D 1)) {
> > +        error_report_once("Tegra241 CMDQV: vEVENTQ: detected lost %u
> event(s)",
> > +                          buf.hdr.sequence - last_seq - 1);
> > +    }
>=20
> It shares the exact same routine with smmuv3_accel_event_read().
> Can we put these into a common helper?

Yes. I think you had the same comment in RFC as well. I have noted that as =
a
TODO in the cover letter for this. Will do.

> I also suggested in the veventq series that event_start/last_seq
> could be moved into the common structure.

Yes. I see that.
=20
> >      veventq =3D g_new(IOMMUFDVeventq, 1);
> >      veventq->veventq_id =3D veventq_id;
> >      veventq->veventq_fd =3D veventq_fd;
> >      veventq->viommu =3D viommu;
> >      cmdqv->veventq =3D veventq;
> >
> > +    /* Set up event handler for veventq fd */
> > +    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL,
> s);
>=20
> Should pass in "cmdqv" instead of "s".

Ah..Right.

Thanks,
Shameer

