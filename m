Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24BFC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6DMP-0002DA-I6; Mon, 14 Sep 2026 16:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x6DMM-0002CF-8e; Mon, 14 Sep 2026 16:33:02 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x6DMK-0003iJ-FS; Mon, 14 Sep 2026 16:33:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQLlozQEy3kD00TftfFzDhoJZk7bRt6si55QbTuVDPXLfjMo4iEKJFfRlEosj94J6A6kB8H15bFaIxMXr0DW00HAAVaVxlwXTsx20CYvzfmWJMs+BC1zR12WABToZRaGh/OwLIfqSGhNyiPLPr1J2ghn4RnluSXsdYi8uta7nZRlJhqWhADTtUvb6ArPspeB/fpEEPcwHgmYY5a47E99MK2jHwM7w6jacFmOV7klTm9srIdMe/kK6J7j7Q2ikkEI/V2GpROvfwgmUd3YgpRRiZqipmu8ArkxdBfAu1axqWWmTgCJmwGm/hAO7cMRWtZHzvrDBsG0cF4F5cEQcd4yTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wwJVDFY1BEPqKuDjTd1gPMyh5U1066fXZl8TTsDES4=;
 b=kAwQJ5YgRIytzzadR5WmunD6BaJUlQHec88bv+CkltdNsNXKSE6Gy3daSpXm8MqQm2OIpaF8jUkFMUqAcM7mDehlJIR52ghsjOLSINXxW9YRlDVA9jRuQTM4fOxx7sknJCbdJjCmL8u9rIkM/eKgG+wi40aZdJo1FrzIUZWPWV+PpC5EZGYsSLtUtyfl82Q5fhPtuFy9M5ecrV7Q4F9Zl5UpmPlUmMNmdRqb46S5T75/9KONuSyQXDSJLdPstZ1uIkgxtBRyWIyLuSqSbbimQmN49Z7E2K0cee4AqXQYd+4vGM8rR8UJEHCaWJGdlqqaaoR7r5jYPdEyjbqJOjVSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wwJVDFY1BEPqKuDjTd1gPMyh5U1066fXZl8TTsDES4=;
 b=h7uJJ28xzmR/HfKK/1dSQm9oYsnu8XMTr3B70KCK0AbMLwdsQyTbHCG+Tp4d39n2O2MyDpYKj3HlfcaJ9FkPeD3Pyp/8pb3EVdeVPlhDK1+W5AqXxE+Zcte2EW9UfSqu0h2c/X5KZfy4CGIloqVhaxIbaLk0FGpE73K0NC0V8lCAhiLHc3+/1D9ZLmhfk0P9uqBgxW6UNcDnezz9OuZdHcpsSFdtaCWX1WkWEuJVx3ndbiygSBkWuPoo+N8uYbOTHGM6+v9S5gejmJcItyS2fLTkbhbqo4ShbUox4IBR6sH0oFkgtbLvKFOFRfMvo1q+in2YpVKrXPzjwMbqmbqImg==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:32:51 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 20:32:51 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Eric
 Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Thread-Topic: [PATCH v2] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Thread-Index: AQHdQiBhHVfzSgld7kWe8/9gTceOF7bOBUCAgAA5cwCAAAVDAIAASCgA
Date: Mon, 14 Sep 2026 20:32:51 +0000
Message-ID: <DDEBF0AE-4530-4671-B0AD-045619EC8ECD@nvidia.com>
References: <20260911190431.4085464-1-mochs@nvidia.com>
 <CAFEAcA9ve3sdSEJ6vPts80phhfjV9BpW+Nx6cJOwH3aYQ3zafA@mail.gmail.com>
 <97C51715-99C0-4A9F-907D-C839150D753F@nvidia.com>
 <SJ0PR12MB8614959FB90095651F39C894ABBB2@SJ0PR12MB8614.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB8614959FB90095651F39C894ABBB2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|BY5PR12MB4322:EE_
x-ms-office365-filtering-correlation-id: 484d05ea-14fe-4093-126c-08df129f5909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|11063799006|6133799003|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: RJ/vXzkVKChoSj0yiOrI6723xkzp43IkwEp3obv8DZCoVvkwccYNKCJtZMo/OxJFuIqvf/Jxvf7jb4ifwL/5/yPuxoXqueph6uY5O6pbqrEtwz3IbCH2QCCoMRiEaxTob8su3pkEIQoaGPpnumGHWdPbdN3wT28qFBwa/ja3ZF0x6JPWu8yQhE56HrGgo3MGkf74aQvKxFBAlonOIlVSeD/5Vzf6vmQHoqz4aTgAZobcdEO0+E5L5+sq+Uu/0VtpvH6XxRSSZ/aF9d9Af4UfcmfuaaxFmSKK0r7XUyKgodPV9YMmLCXduWzNXn7AHSueeGAYWi1a3dMUpyLQy192MiTMSNcinQDRcAsLya+0YJN5u5XibcP7B9xqYOye9tSFIwnPBXuYQEmBjMekg8tptkxVP6pLXSiNJUwrAl8OeJ/1ipSqNHPPIqm8MdmhgW6tri9fmqtBchW3cF0fOLcbvI07fzy969FL7O+NJFbTbk8HF+xR0kJazW5P7J6TpZlFZnl4ZcYHOLRVPnQNYyF/QXaXh6GdkeXUsSlzwOtd92s5bPe6Zv2ma3iG7jjsZrMmB47UBKV00w+RmlT8+Tq6G87rdsMGbcfEfm0F3kJx/H+HRAARtcj2j9Q3ysWcc6s3Y1xEa+GiTfcQ7fLLlzC8J8hAIeOWGniUzUg9Sr9SqohuBfIAMxKjfOoN2OlQTnhKNVUlPif4yQChtt5BlJHKtYBlygnDyAR/BPPeQtfJcnk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r8YvjFq4QO/9v/TRC3dcgi485A5HSMyGH32hwCdKF6DmGdwd5g+99stBFoWZ?=
 =?us-ascii?Q?IyJmm8Getu0GMC7c0XkL2seNRilIg7fM8998RofTStLrVWt4BDryKXG/1oW/?=
 =?us-ascii?Q?PfkrQ0ceEK7FefSgdzmApJeuYJckh/Kh/inV5pdeSzC5PJ/tM8JWRiuzVw/C?=
 =?us-ascii?Q?4R5uWg4hyfqu60NnOzSrQj3rKM6TjPT16fflFxQJcSt0SZHta9/oSCwERf5D?=
 =?us-ascii?Q?ETBzEjroejKgg13uhIUei5wOwUhH1+xQTs4GOFFT6HzRbhU0cmCMFXfCBRbF?=
 =?us-ascii?Q?CHlV3TP2qCID+0pEPX+JvmKDR8nMjUA2gAEJ1MKsDhlHkKUqk+Clijgvqr3e?=
 =?us-ascii?Q?EwHjwJRZ5m91fzNUiNuTL6FsAwd7KUFkngAnr8zBXsVpPaHGZ7Nj+wot/zz7?=
 =?us-ascii?Q?Yq1S8bFJPS8meGxYgITVaNVgAfS0KoRbAwuat7gSL2Wmn3THTvdoCjj15cQa?=
 =?us-ascii?Q?f++ds0cj3NYZA+C6MYg6FDfQYzXbYfesHlnp3xyMRRP4pXr2x5dNTy88AFIV?=
 =?us-ascii?Q?ONP47JUDKtrQrQwmFM9dLddmdDJysMZrOKgfTN11q5EPh9sWiNHmLaUDcWde?=
 =?us-ascii?Q?4ul6fgpc0Jj1PRtBcv4SirhHvbGJApLn2y+YxY8nyCEYLW9T+/DQk25aLhML?=
 =?us-ascii?Q?lkBEJWUuBzKcXVM/ezXmP1/pzc/tMif9nWrdjlUqxZ07Lw1NAbVoII9WAZAR?=
 =?us-ascii?Q?RHJ4EKry55qRLoERssZSzkTUzaDHJWVJKgcht+gbCVTxWeIluP/IfnqTM+xs?=
 =?us-ascii?Q?MYVzXVjwoO2qBadICWIWmM/XSMnEhF6Y8QjMh3OoQgibmyB/BkcIrpHZYDgZ?=
 =?us-ascii?Q?mOL2qTEUrFU4ONXB3EsAg82RHldHWPTXWxCkMoLOtvuruW3qFp0hfNPYhwAi?=
 =?us-ascii?Q?f48RMK1XUbjdSKiuIMEGmAOltqtK0lmQdM/62cNzNI1fNzIqtQwxj6uaf8vJ?=
 =?us-ascii?Q?Gwq9teY0R4gnYKPldzFK9Q5vyuVtsLitt0G7c+AfjzNTzYCCYRz8aH+1HxRV?=
 =?us-ascii?Q?1oKzTuwM28dJPBDNPzuoY3GHUfV0WFKPI+f86u5m+wSRbJA7omAUh4lME8L1?=
 =?us-ascii?Q?oCqvWKjCAJbmZGllX+qnnqaXwHHFwYKoWiO+an5wCOfikTjc/yWAxtXHQGyz?=
 =?us-ascii?Q?YGloE/4Mlr7KnYH540RseLQqUE1ipdRh5nVg9L0bERL/0XmR+w1WiRjuJG87?=
 =?us-ascii?Q?WVh38ImO+MAALh33G+jj//zJmwusq3aUaLbjjNtyz/0SIOD/RJq2AUP7WB2I?=
 =?us-ascii?Q?8I7oodsHcCQS2z8vvbF5jH8X9+MoOZBpvRo1vVSik6w1V3RRXkAMiWiB6Enm?=
 =?us-ascii?Q?biGX7XcpcUQDpqePNNLSpwDXWxzuKvnYmnVFqPbu/ObDl+mJj+ySyyPQB/v5?=
 =?us-ascii?Q?H5ynSn8+N9lZSahUfmCYFSa7oIULk7MKlOJesHzlx1qiY9xCZ4iL6a7PPPbx?=
 =?us-ascii?Q?B5DwPzXRHfbt/goQwlpINEyKo5vnLOm8R7wOAi85MVwZ4jj7WtQTuAHYTu2M?=
 =?us-ascii?Q?sNBbSUZ/R1574q3r+3W9NjOA5iYlVCWq3/UA8HCjTM4yX89ws+pLuUIRxH1k?=
 =?us-ascii?Q?z9QeIy6Y+99YY3LzIravUBtXh9P4O8d88Ovk/KvEm5a99I/T8V+UWBGHpr8x?=
 =?us-ascii?Q?sb+Lv149YRVqazLOTk55VKKnlCPGSKxE3iOkSGbKQgV2Qwh9L+ISWztZwoPU?=
 =?us-ascii?Q?wfG1hKUKh8txWBqJPpWzFh1rsFcDbvbriUgcwPZvYtMlkbsIpzOLv8XRojlE?=
 =?us-ascii?Q?dR0yMACutg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9868A6369FD698409F2211A0CCBEA0AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484d05ea-14fe-4093-126c-08df129f5909
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 20:32:51.2298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ok9jtok0M3owIXeZfVcd2zQ9cyPN8naEyGxFjvQ55kuiwP5AjPejF4xL4aSBKKMIpEDD/2J3ciD0DgxiDiX7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=mochs@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

> On Sep 14, 2026, at 11:14, Shameer Kolothum Thodi <skolothumtho@nvidia.co=
m> wrote:
>> -----Original Message-----
>> From: Matt Ochs <mochs@nvidia.com>
>> Sent: 14 September 2026 16:56
>> To: Peter Maydell <peter.maydell@linaro.org>
>> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Eric Auger
>> <eric.auger@redhat.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>; qemu-stable@nongnu.org
>> Subject: Re: [PATCH v2] hw/arm/tegra241-cmdqv: Keep VINTF page0 region
>> alive
>>=20
>>=20
>>> On Sep 14, 2026, at 07:29, Peter Maydell <peter.maydell@linaro.org>
>> wrote:
>>> On Fri, 11 Sept 2026 at 20:04, Matthew R. Ochs <mochs@nvidia.com>
>> wrote:
>>>>=20
>>>>=20
>>>>    name =3D g_strdup_printf("%s vintf-page0",
>>>>                           memory_region_name(&cmdqv->mmio_cmdqv));
>>>> -    cmdqv->mr_vintf_page0 =3D g_malloc0(sizeof(*cmdqv->mr_vintf_page0=
));
>>>> -    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
>>>> +    memory_region_init_ram_device_ptr(&cmdqv->mr_vintf_page0,
>>>>                                      memory_region_owner(&cmdqv->mmio_=
cmdqv),
>>>>                                      name, VINTF_PAGE_SIZE,
>>>>                                      cmdqv->vintf_page0);
>>>=20
>>> ...but we don't actually initialize the MemoryRegion until here.
>>>=20
>>> I don't think you should assume that memory_region_* functions
>>> will do anything sensible on a zeroed-out lump of memory.
>>=20
>> You're right. Although the current implementation of
>> memory_region_is_mapped() only examines fields that are zero before
>> initialization, using it here relies on the internal representation of
>> an uninitialized MemoryRegion.
>>=20
>> memory_region_init_ram_device_ptr() has not yet called
>> object_initialize() on the embedded region at that point. I'll restore
>> the explicit initialization flag from v1 in v3 so that no MemoryRegion
>> API is called before the region has been initialized.
>=20
> Or we could avoid the check altogether by tying the MemoryRegion lifetime
> to the vintf_page0 mmap.
>=20
> - Move the initialization of mr_vintf_page0 to
>   tegra241_cmdqv_alloc_viommu(), just before the successful return.
>   Add it as a subregion, but disabled with memory_region_set_enabled(mr, =
false).
>=20
> - tegra241_cmdqv_guest_map_vintf_page0() and
>   tegra241_cmdqv_guest_unmap_vintf_page0() then become just
>   memory_region_set_enabled(&cmdqv->mr_vintf_page0, true/false).
>=20
> - In tegra241_cmdqv_free_viommu(), remove the subregion and unparent
>   the region before the munmap.=20
>=20
> This way we tie the MemoryRegion lifetime to the vintf_page0
> mmap/munmap, and on VINTF0_CONFIG.ENABLE set/clear we just toggle
> memory_region_set_enabled().

Thanks, this approach makes sense to me and addresses Peter's concern
without requiring a separate initialization flag.

I have reworked the patch as suggested. The VINTF page0 MemoryRegion is
initialized and added disabled after successful CMDQV vIOMMU allocation.
Guest enable, disable, and reset now only toggle the region's enabled
state. The allocation-unwind path removes and unparents the still-disabled
region before releasing its mmap.

I will send this implementation as v3 shortly.

-matt


