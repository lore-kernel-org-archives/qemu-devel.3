Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F061C88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x69KV-0006tR-9R; Mon, 14 Sep 2026 12:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x69KE-0006m7-3R; Mon, 14 Sep 2026 12:14:34 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x69KC-0007Ze-Ab; Mon, 14 Sep 2026 12:14:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZl/0GTV23cRE86XrBt2lQSsQ2LBYO6AhTqp3deDQ7d2vKqfv912qEkMUaiLi+fuh0f2lNLUawjsDTDu3RaK5Mo4mfE7c7Pd+SNL8j602g3PehVwpidfbigfTjIXzZBjMKFSxtKK4tlsc4MCmj0bu7FHg4OlMP0nDeW2iFwHBTwO/0QCWiilxJK+hZUhVVCpNtqohc7gYNMLnJfZMDm8UxnAQs7W3UnNwzyjraAEHLTiJCIEjOpfSiynvZ2idMZkK5mZ1ZsF25oiaTGJT3JtrqJvm8Kb4UcX388U2FMD0q7PGxGa/md0M7qBB7J3kpppkY1m9D7GJQV74msl7NzkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq0pZbd8vkGbxzJYkG0nFLrNS3VnHkGLWnWqjTFW20A=;
 b=ijE2EkNsxFwMnPUzjwHP1cUpDiGn2jUJXStBCn0wvKCTcKlkff3nQsWeKAosxgm3Xe5jzxhxbAdBVwjzxLA32hxXBB6j+/YYgWIuvfo9zVknfIiP1IE01U4M1C7q3BLDkSiBL1Y0DyH0qUxrc5KJHx9PjJrxoeIZbhp5oYdEvPh2l/c1J8wGj8Z1i5dI9OR0oi2w5kp0OCgbfCt2nxa1obj/taYCNgXyo4EuQpV8KXooZE4sGpkNxQGLfYoAOW+IizZGFJE1t8AY1nuGsuFX6ToUHRyClNuY7xiUg7QdQLQqv/quxBX6NeNItWkzQpb+skU1Jh2Cm+BuFlOjZ41U4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq0pZbd8vkGbxzJYkG0nFLrNS3VnHkGLWnWqjTFW20A=;
 b=kOwLxdmbn2DbYhYoNIkrnwZC1euI5APbaO5slTiRur1PjCZBaUnqtaHCV3jvcfxtS5nwgkmPckyCxUceeSHb/OdRG+hmEsEf0CGcSXE4prPvaXdoH+cP0Uil21N/406fUfMQzkrRKczkRkdojSEPYfIGDhg1bHni0nI5zE2BhcWRCQSlZy25BaXAsRnWsW837DWyybvlJvcUfCYGAa4tTgEIaDZGybkvdqqBCSroPZaMFJUSA27qURaaoBlU/mFGydec+P1Up1To+BTCliGuj5Aq7OAHDiaQfax3c03SOqpsQq/M0NK3RLySp/hpNd4jQFXM7a4vserr4Cbvbzjcvw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:14:25 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 16:14:24 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>, Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: RE: [PATCH v2] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Thread-Topic: [PATCH v2] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Thread-Index: AQHdQiBk3ZjokbCO0UKsogPdczqKS7bOBUCAgAA5fwCAAAIz4A==
Date: Mon, 14 Sep 2026 16:14:24 +0000
Message-ID: <SJ0PR12MB8614959FB90095651F39C894ABBB2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260911190431.4085464-1-mochs@nvidia.com>
 <CAFEAcA9ve3sdSEJ6vPts80phhfjV9BpW+Nx6cJOwH3aYQ3zafA@mail.gmail.com>
 <97C51715-99C0-4A9F-907D-C839150D753F@nvidia.com>
In-Reply-To: <97C51715-99C0-4A9F-907D-C839150D753F@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DM4PR12MB6087:EE_
x-ms-office365-filtering-correlation-id: e3633a03-de61-4256-5c61-08df127b3e4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: reXSK/ABaGmyxJuILbjicQmLIM/ZrsJgsoQVMjSP9y0F9T/B7PgdjlKg7kzgen0hBExiwZhdO8sYZF56/dKhdFDheI31FDw0OJDd0hnd8lKZAnTMec71D9zlzMlvOsRg+EIViExON+XNc63uBuzzI1YnWToPmlI9bVkk8Q3l1cUpOzS0pIn32gZLBn8PGZNhxSzu9IuRC13qeo2fa/tSicQMZMqQ6gswq5TWR+iqzjWnaeZsWicPzuP+IUGlY2RZB3qFyQadS3kuX2cHdTWSm9c7SOq+bJnP0Y5U+kgArc5di2sC0mMIcyhhvZKNvTuQMcrVpPivYhO0Lij9iIq7FweYyEbiS+b6C2/jHczJeAiruVwm/uAqL9goLuNx1XspWu6UBFYOkhHKZ2+GYNocQsRBDKkkykCOlCust9kUsH9suakyKWzM3cJjkzFqR/Qj3duTCILJscJY1y6cJC4NHgZ2syleOI2ike5mJkPJ9+cc2ZXMBUgb6EImhFn/bEkQubYGQ+0EY2R7jFuvBEsNBsGKICNFLX6geSM0neQpukuCTXWBmY6EYjhyUw4JYNwIRkgD4ANTqoO0yluIIrC1SdZ1h+/i64Ap/NKx7DsTbPtsWyTuKVdvUWtbujKGafM2ZjAT/tUL3SRDzKg1hgYdM/w3VSdOgYchtunBI0H2AKORyFLNlXG7ZY0rAh4IYFeG4Cpc3wupQGw+Irweq2FbbZGrqir81dAZ91rp6qFX7wY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JzziKky/wR1suqrqgxOJNCUIdgebbF4m2V+PwJri0Q5NjDU4gPCE9QcqX9Mw?=
 =?us-ascii?Q?jJhJWunh7vOgQhzW9P3APUkCsM/hEujCANmX6JPzUBeKQtd+Qb0lnRxsyO/c?=
 =?us-ascii?Q?RQrcSGG3IuRrG/fH9UBiBn/huYZhqdzWQLY19gQT5aO3w0N8yeHQ7c59Jcuv?=
 =?us-ascii?Q?qb3esIT9HX2TM1P+1x2gF9KTRo2H026YDtkipkw1J1Oe2vcMhnzCvOdv45zd?=
 =?us-ascii?Q?lS2hlkAON9d7QkcLhW09DcTrY6nMDYQ46RmtbM2DS6XFm1fMxyFWzuY7kh1D?=
 =?us-ascii?Q?5okG43xg+Ynr1iJQ1agB++sGWdg1ccQhxkEXm9oZK2MmJhEe5/bwn8ECtQHB?=
 =?us-ascii?Q?GOXpJQ9nQe+S+oql/Q+CqSZIdZnFM7k/fhKtdou1iaRKWYKvFTMHyu70JREr?=
 =?us-ascii?Q?QpWvFqOKAsrm02PS/6V0XszLYuZ9GZEhJkO/wPptmRSdVpUTU4J6cgzW+tBI?=
 =?us-ascii?Q?n7B95HHXqEdN0IFKOECVB/gALcw/gT+sYLPqvYTHfruvqtJFAhQ3/+veaj9t?=
 =?us-ascii?Q?JPooZNwBZ06tBrFmQvl0Pddp9adTs0aJGr8bWQP8HbRC84au2SBQM9gqYu6I?=
 =?us-ascii?Q?pYF0BBXbIBuBr23SCM4H3tTYPnzd5hCCqrMvzWaz8Ba/oUkOAkcPQJQJtVYJ?=
 =?us-ascii?Q?ClwdV+eZN/0ygfVxnc3hkreuGgeiZdVJvaINpS4jNyfZ9U8NShs9uJ0gWkJA?=
 =?us-ascii?Q?ge7tQnBODi1t3dZtHni0kJW94QxlqiAsx3o2ZmNquuwxJCAh8SBT+qntiijh?=
 =?us-ascii?Q?cx4mpU5Ru9gZBPWq9sjR2jfI9QrlCD6EXYU1mg85mf2awxvLmiTfOVXcp6hV?=
 =?us-ascii?Q?15saR1C9mEolraAD37vUiMZ4WqAjVE6xwWwviydZ47zRrOa/H+N/WTj1cdPx?=
 =?us-ascii?Q?FyP7av8dZIQZNVMUK7+okIa4khQHnPlgYf8EZVPxdAYFEXMtiB0MkG6KZoRK?=
 =?us-ascii?Q?3ciZ8B8mfPnjAPnTjdvMtF3TuiK0nzf0IwNHHyF3ngr+t6wUygn3JAD90kUQ?=
 =?us-ascii?Q?WnfXq2LoA/FNNUgaZjU/on8vyXT6dPKotF8XAk8cvfTbosopXr0UzmDNnQgO?=
 =?us-ascii?Q?2tLgjd4EajiDRx/03XW+mWbuwiVaQBgATXb0fTUM7MwknIiXFhfMrkcJsU1o?=
 =?us-ascii?Q?PIkQRPWtDAfxrzlLWeEL5mRjNZOnt/aoUe/Hq+RAtI68+yYY0qeEbUG+2dJG?=
 =?us-ascii?Q?2Jv6GRy9lccdzfx71YSoSTrRAkXJl38xQwh/wukHtEzrUrgEyd8JZlonZWEj?=
 =?us-ascii?Q?JcQ3tpy/fyh7CDXIP/tRBNotJmE7siGz3NPu8uS4whIawaIbiCWwhZGhye6N?=
 =?us-ascii?Q?4WBC81iqtiViSwkcT2oHiIcMyhkZ/1edv6pe0b1XO5eR7wh5sHiZ2vRCfurU?=
 =?us-ascii?Q?+wwFdyGevNkzEgMFHFq0j8ca996A5raTDTXqbwSQ5s2kkv/Ei86AsooazPnZ?=
 =?us-ascii?Q?nU8h2uN2MTjy9JgtcOgIN5SoDAu7d8ZYW3sk11upfNpBvEPiNeDRMjImefE0?=
 =?us-ascii?Q?HBX9s6IVbPFf1Me7FhPKVfsKFicLMdrHc3grZX0H1yC1kp9BSZp4JMtdR9Ez?=
 =?us-ascii?Q?Cdpzs96ORunHtwkpB/nNDYS+K+imm98aT/r6juxtIaLS1c09USj0D5H9KRls?=
 =?us-ascii?Q?BuNx9lHNwzeAYPwS8oLtYvIrinGjAyWQAOYcUOBcuTCiXGMn3qjm0pmu39jp?=
 =?us-ascii?Q?jsX5cYPnm8FtaNQzE4x4VLyses4CaMqaYPg5NAv4ZIEVJQGGUGf7Q0oPHqvV?=
 =?us-ascii?Q?e+816m3jJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3633a03-de61-4256-5c61-08df127b3e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 16:14:24.4963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xc/AeN1RLwT9zQf3watdRm5pDyn+Sei6LBgzTEHCxYM7u4M8WsWwnVGZp0AjP78ngSUm9bLu+XfB9R33CAqgQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
> From: Matt Ochs <mochs@nvidia.com>
> Sent: 14 September 2026 16:56
> To: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Eric Auger
> <eric.auger@redhat.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>; qemu-stable@nongnu.org
> Subject: Re: [PATCH v2] hw/arm/tegra241-cmdqv: Keep VINTF page0 region
> alive
>=20
>=20
> > On Sep 14, 2026, at 07:29, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> > On Fri, 11 Sept 2026 at 20:04, Matthew R. Ochs <mochs@nvidia.com>
> wrote:
> >>
> >>
> >>     name =3D g_strdup_printf("%s vintf-page0",
> >>                            memory_region_name(&cmdqv->mmio_cmdqv));
> >> -    cmdqv->mr_vintf_page0 =3D g_malloc0(sizeof(*cmdqv->mr_vintf_page0=
));
> >> -    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
> >> +    memory_region_init_ram_device_ptr(&cmdqv->mr_vintf_page0,
> >>                                       memory_region_owner(&cmdqv->mmio=
_cmdqv),
> >>                                       name, VINTF_PAGE_SIZE,
> >>                                       cmdqv->vintf_page0);
> >
> > ...but we don't actually initialize the MemoryRegion until here.
> >
> > I don't think you should assume that memory_region_* functions
> > will do anything sensible on a zeroed-out lump of memory.
>=20
> You're right. Although the current implementation of
> memory_region_is_mapped() only examines fields that are zero before
> initialization, using it here relies on the internal representation of
> an uninitialized MemoryRegion.
>=20
> memory_region_init_ram_device_ptr() has not yet called
> object_initialize() on the embedded region at that point. I'll restore
> the explicit initialization flag from v1 in v3 so that no MemoryRegion
> API is called before the region has been initialized.

Or we could avoid the check altogether by tying the MemoryRegion lifetime
to the vintf_page0 mmap.

- Move the initialization of mr_vintf_page0 to
   tegra241_cmdqv_alloc_viommu(), just before the successful return.
   Add it as a subregion, but disabled with memory_region_set_enabled(mr, f=
alse).

 - tegra241_cmdqv_guest_map_vintf_page0() and
   tegra241_cmdqv_guest_unmap_vintf_page0() then become just
   memory_region_set_enabled(&cmdqv->mr_vintf_page0, true/false).
=20
 - In tegra241_cmdqv_free_viommu(), remove the subregion and unparent
   the region before the munmap.=20

This way we tie the MemoryRegion lifetime to the vintf_page0
mmap/munmap, and on VINTF0_CONFIG.ENABLE set/clear we just toggle
memory_region_set_enabled().

Thoughts?

Thanks,
Shameer




