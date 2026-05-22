Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CCCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 10:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQMh9-0006WT-SK; Fri, 22 May 2026 06:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wQMh7-0006Vy-Fe; Fri, 22 May 2026 06:01:29 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wQMh5-00071p-HL; Fri, 22 May 2026 06:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRClLY1A1aI66SDNcpUrmYgRi91ZE+m8t1wqgKRgojFMN6BqsSwfJ5qxsiEkovdon3TgRBhcKtqIOUcTMNi0dun50wIX9daK3KEkgL8NmsG0DINaM5UqDUgV+yAWMve2hIXjrVsNNxC2uDXpbRkGWKnD/0zfbiyBRaX+M4sjuP/Yesr599qDdP70Y3rl6l3adY9zTs6lubVzbPjISLgXaxgrDtEVh6yxF/zM2FyciXvmVkuP/6sHrviR1lFnPi9CzgFGACB9ZacgFxhZLLj82KNXz8jiaGxA99DlA1KV4GP3gAJikZ3nIRozHq8uGn7g437udgmLa2O8a69Y9u5vYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SH06rSP6zGzjw6E8rni8CYiu9Wpj+XLWSxKfJslUJc=;
 b=ZRjTtWOY2XjHjD13QhLkffWrXBHo3ySw/e36VkTL2/l85QHUyb+RwIj7Ks+aG663w6/5Po/yz9Ho/sBGxQYsx5DE7/k2xChx8aEua/3H/xEpcUYHNmbMX6coJhuzw9lsH94PlQ4ErPD2PKUbg62y7XmMVkfX0f3UspQnJPN57BX0CVHv+PEl35KEPQHXcQHaEcbJF54KqV5ABTj5f9pe+xlJP2LY9uip//u6VF5xlWxkLNgdXD5+jKCBKIKj8a3LT7JQQ6+bN8SkbjaDz1GR7fYXSKgZCeFP0OHq5GK925UZjVjHvSeEGmTYmMn1qSoEbe8f/KKAQ6jrUwBxPWb9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SH06rSP6zGzjw6E8rni8CYiu9Wpj+XLWSxKfJslUJc=;
 b=gKgNREs83CgyFK5xiyphs4hluqGEAme/XBIlufRbdJx77U+L95myT2mniaSev9gotpvHr4y+8doR3lCglBZ6tyTixpTZc5frC2EwiOtSYpePKfk0v7I4OGrqpVZBIJsbm/KEGrs3EDpq0AEXDh4qFDqbNdZPdoZj2R3rWMHZ1778T71dla//VF9BtGciaGPA5aL2xq77MKSuzhzh/qOsVEWi2ZQwBzlxKYAhjPItooHBkquZERP14ycLaorlRD24pgN0Iayd0LPzDnIAbVcKL55hRVCWxwvRjXPq2OlYImK1qSxrssJIlgmHkeWeIpid+FZbpCX/4IONg/wUlOHF8Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 10:01:18 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 10:01:18 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHc53vPgzHMdzCVJUyI0UoOS0aBX7YW4H8AgAAoG0CAAsctYA==
Date: Fri, 22 May 2026 10:01:18 +0000
Message-ID: <CH3PR12MB7548D57C770446ABED0EDB68AB0F2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-18-skolothumtho@nvidia.com>
 <c0dd92b2-4ea9-45a2-afbf-b61910f71fe6@redhat.com>
 <CH3PR12MB75486D02EEBCE74D47B20834AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75486D02EEBCE74D47B20834AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB7535:EE_
x-ms-office365-filtering-correlation-id: 1937b792-2492-49b2-0fbf-08deb7e911b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|11063799006|4143699003|22082099003|56012099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info: L4+KeLN5hGwyLd1R2hYBvd9r1Ku1J6y5K270n2rG1a7KQ7zck25Z8b8WtrZz2YvmCUwIjQ4wJIKV8lHO4q45+kjmWlQmsmlWd2UvX6WjwXfEvT6/AXtC1lqlHNd9yL5CoRXWqLsq8YyOOtxlACEpcRqw/AKWV3dewVDEX8ZqU+bGIGMt5Fe1C/V5j0GgWmncDfPlWCFpyyTvrMkdBbexzLL3LMPeQv8UMx1Uqvb2nbZZ2gnzzz5MtBtgL5bDD63ggZHLKdb45N4vMoK2FohQk00TtNuYrKkjDYNYzFS9aZcnt/qWJPoV00Two2tEO+5vsRC5E/lfrY6Wa1NA/qKDditn6E4kznp5SalrVmF4s9oz1MiCTYNMVgX+bQLI6+U+jIHDEYzMbZb1UT6zbNItFqGaIlywO6X2z4FuXzfE6oGoycVopImwZwCTq2soKHYR70Eh1BTm81EGsNrGm5T5IERvufN4vn56ZETvZcELxp1vKEddre6s3cZhg/ciqIPAeCE3B50CmyYySz314FcLOLIYKuwhED3Olaf4PxnA09wa5cAgnuzrYfuUNhVCF73dpnWy7LSjC4GND1kcGC/R/JE1I0eSoZQ0X/QGqktVBF+XJN+YsEjZbx15qm4pIbkrXNbVjGyRB0yaLn5g4EkjMNCUJNsJQX1OvD4VND+gak8QVp1RmPTbkSH4m2b04A8Tv44CRJxyqWWKNGEc0jifZjPbJUu1wcbGOppuLLXHSKe58t2GEV8HxzATfWO75wDX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0hwcHJIeUsxYWZybXgyREMyUWZaeWdzU3ZHaXYzVGR4RmVibXBTck9GMDFJ?=
 =?utf-8?B?TDl4dlMyelZNL2dXdTVrK0Y1ZnprZy9rT2lBOVJGZDJmZzBTNU5FYm9WaGZH?=
 =?utf-8?B?cTF0aVd6Z0FYS01SNnFWN2VncG5vTHh3alNBdzVpeFJvMDYxcGJLOXUwQ2R5?=
 =?utf-8?B?dG52OXZCYStZWWNVWHVwT0pINzRWc1VPZW4yNGRmRmZQK1NNL1l6K1FwN0I3?=
 =?utf-8?B?TmJ3UW9hSmx2am9PVlVCWnZyd2hPUHYrclF3eU1vWVdvRkhMU08rWXdvS0FP?=
 =?utf-8?B?Qjh1N2xkWlIzTnRxVm9ZZ2RoSTZtdFVjek5pV2NEUnNKc25McXpQaDZBUm1M?=
 =?utf-8?B?N0wzYlgwUmhBWk5TVDVCOVgxQmlRK3grb1N5empBdzVKUUkzYUpHQ3orc041?=
 =?utf-8?B?RDh5Sm05RjIwZlVWbW02U1hoam1PZUVBWTkyU0JmeS8vR0ZiUWtDL1k0aFJp?=
 =?utf-8?B?SUhJM0l4aWh4UXdDM21zTy9SQjQ1c3IrSERHKzkxN1E1aUZJRE9CTzFlb25V?=
 =?utf-8?B?UkhxcDlveTlzQ0V5djFWWWh4TTJHb0o1anVKUk5BTGNKVGRhSlVGQllaZkhs?=
 =?utf-8?B?ZzY0RnZXNTZaYTRkT3o3TURzc3k2RkJVYjdVVnZoYlQ5bERkZDZoNS9TcXRm?=
 =?utf-8?B?djBRVGlNd1BJOGs5dGRXVklIT0M1NWZBVVRwOGZ2dmFGbzEwcHFmelVKeFFx?=
 =?utf-8?B?YVRMTDQ3UEJHd2ZxREpRWERzVk5oRUJLT0JBUXVFdk8wVUgzZHBmWlNmS3B1?=
 =?utf-8?B?QlRRbTZNNmZMa0xUeXJtVXBROGxKKy9nZ0tjbzRlaEppNTQzSkN2MGR5ZnB5?=
 =?utf-8?B?bkhJeTdJbFdMTGNvekJrSnphMXdXcFB3eXZVTWtETlRjdGU1alQybEFwMm1v?=
 =?utf-8?B?blBQcXNRK3Q1NVJOc2V2OEkvNWZiTFRvZjA1a1hQdzg0bzV5aS95OENaT2VJ?=
 =?utf-8?B?bWZnQ0RWbDExQWVicngzU2dEVzlSRWlWZERVQUJmS0swSnNIYXc5azB6NTl6?=
 =?utf-8?B?SUFNWnhvMFFSdUlHeVFLZzM3M0dtWG1hRjdNam1qdW1YQzNXTmpNZ3oveUVE?=
 =?utf-8?B?QTZIT3NHTzVDNXlaL1ArN0UwN3F1a0RDWmpRaGg1bERrOE1TaFErWnFyT0tQ?=
 =?utf-8?B?U1RTUVpEZDYwNmxMZlZSalpCTER6WkpMY0tENWJCWXZ0U3ZzbUtkQWY0bVJa?=
 =?utf-8?B?UUk3VStrdVJvUUwyN29aOVMyekZqMVZ1dG9kcVVkNTlkNDdoeS9Ya3RIcWRw?=
 =?utf-8?B?ZUFxZHgzZGJ5a2JJQjhvejJPQllEb0FrYVlTUmpIUFFQV1AvL1gwN05kUzZy?=
 =?utf-8?B?RmlqMzhUTE9iMUc0U0d3SStydkVSRGdnM3E4VWpmSTB4S1owTUovTkJnWmNE?=
 =?utf-8?B?VnNYdGhBVVRwd1BEcTJqQjE3SFl4eHdHR3RlNzl3NTBQMEJqQklIeVhiOHh1?=
 =?utf-8?B?ZTBoWHF0OGc0dStUY2Z0UjBoSjQ1a3ZoZEN4cmdWSmV3aTJNOEJqRkRQak1U?=
 =?utf-8?B?Zm81Ky9rSWpxelJjOVp3VHdoRm9wdEd2d09uZUdVNWwrbHQzaU5LeEY3N2xB?=
 =?utf-8?B?YWJjbWJEOEtqNUdzMUdSazlLWmxZU0RoR1ZiWm05ZFZHVU1mRnRqUVB4TVVK?=
 =?utf-8?B?ekhicWdGMXprZ1hURzcyK2theERoOE1zd3l5aGpjTzNkTEZyd2VwVWpFYitr?=
 =?utf-8?B?dEdHYWFVQjdkVUY2WVpQcFdUYUhkNEZqOGN6N3RRWlVqOVRJcnBKb0l4bXlK?=
 =?utf-8?B?MkdydTRBTVdsS0RLcUZZY2xSS0ZaNzgxRzhtaytnQ0NZVWd1QzRVNlFlSWk2?=
 =?utf-8?B?WFgzNlNJUG56VjNUVG5SNFJGVEFFdWd1YVNJREp1Qis1RVNkaDBXUi9PbDB4?=
 =?utf-8?B?SitYUXc5OWdSdmV3VzVkOXo0SUJzalpGb29ZTkxMUkRraVdUdFlhU29YVmVr?=
 =?utf-8?B?eDVPV21zNmVTODZrc0Z6OVozYldYdnRsSGFYVWhpWTF4eGRDQU5FUWdzVnhU?=
 =?utf-8?B?dCtiWGR2WHBBbDNSMm85TXhjSml1dGpjS250V3pTdjhVV0lYcVR5MVhNaE1W?=
 =?utf-8?B?ME5rNU83ZTMwTGs1NU56VU1BdXhEMEVuU2NIOWY1MVF2V1hDYjB6NUk3Kzla?=
 =?utf-8?B?eDRYWjVWS0ZWanE3RTdJaUxINXhlcThmcXcxTmFxUy9HYk1jNzNrOE41YXBo?=
 =?utf-8?B?WlNncmI3c1VNNGwwSVozY3ErS1FydE50MXN1bTl5Z1FXTlFFOThVbDI0RG5H?=
 =?utf-8?B?bEMvUzYyUmRvZk05eW00cW5JSmoxR21lQVpBL2tXSEpxd3UwdFFQT3ZHUFNN?=
 =?utf-8?B?WHVudU9YR0MrM0Z1aVNWK3d2RXVZZDhCZ2ltSGE5QnhGTStyVDFlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1937b792-2492-49b2-0fbf-08deb7e911b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 10:01:18.4757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwST0YdXGQrcfNvoGZe0T5kRj/3Shjkz7Ni/5Tu4zflIhC03Yf+4x7mXI0K4DIkFd6/r6G4UTtlzXJ9BQSUyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

PiA+IE9uIDUvMTkvMjYgMTI6MzYgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gQWN0
dWFsbHkgaXMgdGhlIHdob2xlIGhvc3QgcGFzc3Rocm91Z2ggcHJpbmNpcGxlIGlzIG5vdCByZWFs
bHkgZXhwbGFpbmVkDQo+ID4gYW55d2hlcmUuIEF0IGxlYXN0IHRoYXQncyBteSBmZWVsaW5nLiBJ
dCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgYSBzdW1tYXJ5DQo+ID4gZm9yIGl0LCBpbiB0aGUgY292
ZXJsZXR0ZXIgYW5kIGluIGluZGl2aWR1YWwgcGF0Y2guIE9yIG1heWJlIHdlIGNhbiBsaW5rDQo+
ID4gdG8gYW5vdGhlciBkb2MuIFJlYWRpbmcgdGhlIGtlcm5lbCB1YXBpIGRvZXMgbm90IHJlYWxs
eSBwcm92aWRlIHRoZSBmdWxsDQo+ID4gcGljdHVyZSwgYXQgbGVhc3QgdGhhdCdzIG15IG93biBm
ZWVsaW5nLg0KPiANCj4gRmFpciBwb2ludC4gQSBzdW1tYXJ5IG9mIG9wZXJhdGlvbiBpcyB1c2Vm
dWwuIEkgYW0gdGhpbmtpbmcgb2YgYWRkaW5nDQo+IGl0IGF0IHRoZSB0b3Agb2YgaHcvYXJtL3Rl
Z3JhMjQxLWNtZHF2LmM6DQo+IA0KPiAvKg0KPiAgICAqIFRlZ3JhMjQxIENNRFFWIC0gb3ZlcnZp
ZXcNCj4gICAgKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAg
Ki4uLg0KPiAgICAqLw0KPiANCj4gSSB3aWxsIHBvcHVsYXRlIHRoZSBkZXRhaWxzIGFuZCBzaGFy
ZSBpdCBmb3IgcmV2aWV3IGJlZm9yZSB2Ni4NCg0KUGxlYXNlIGZpbmQgYmVsb3cuIEhvcGVmdWxs
eSwgSSBoYXZlIGNhcHR1cmVkIGFsbCB0aGUgaW1wb3J0YW50IGRldGFpbHMuDQpQbGVhc2UgdGFr
ZSBhIGxvb2sgYW5kIGxldCBtZSBrbm93Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCmRpZmYgLS1n
aXQgYS9ody9hcm0vdGVncmEyNDEtY21kcXYuYyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQpp
bmRleCBlYmYxMmQwNTk3Li41YTEwM2YzN2I4IDEwMDY0NA0KLS0tIGEvaHcvYXJtL3RlZ3JhMjQx
LWNtZHF2LmMNCisrKyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQpAQCAtNyw2ICs3LDg0IEBA
DQogICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCiAgKi8NCg0K
Ky8qDQorICogVGVncmEyNDEgQ01EUVYgLSBvdmVydmlldw0KKyAqID09PT09PT09PT09PT09PT09
PT09PT09PT0NCisgKg0KKyAqIE5WSURJQSBUZWdyYTI0MSBleHRlbmRzIFNNTVV2MyB3aXRoIGEg
Q29tbWFuZCBRdWV1ZSBWaXJ0dWFsaXphdGlvbiAoQ01EUS1WKQ0KKyAqIGJsb2NrLiBJdCBsZXRz
IGEgZ3Vlc3QgaXNzdWUgU01NVSBpbnZhbGlkYXRpb24gY29tbWFuZHMgZGlyZWN0bHkgdG8NCisg
KiBkZWRpY2F0ZWQgaGFyZHdhcmUgcXVldWVzICh2Q01EUXMpIHdpdGhvdXQgdHJhcHBpbmcgaW50
byB0aGUgaHlwZXJ2aXNvciBvbg0KKyAqIHRoZSBmYXN0IHBhdGguIHZDTURRcyBhcmUgZ3JvdXBl
ZCBpbnRvIFZpcnR1YWwgSW50ZXJmYWNlcyAoVklOVEZzKTsgdGhlDQorICogaG9zdCBrZXJuZWwg
YWxsb2NhdGVzIG9uZSBWSU5URiBwZXIgZW11bGF0ZWQgU01NVXYzIGluc3RhbmNlIHZpYSBpb21t
dWZkLg0KKyAqIFFFTVUgZW11bGF0ZXMgdGhlIENNRFFWIE1NSU8gcmVnaW9uIGFuZCBkcml2ZXMg
dGhlIGhvc3Qga2VybmVsIGNhbGxzDQorICogKFZJT01NVV9BTExPQywgSFdfUVVFVUVfQUxMT0Ms
IG1tYXApOyB0aGUgYWN0dWFsIGNvbW1hbmQgcHJvY2Vzc2luZyBoYXBwZW5zDQorICogb24gcmVh
bCBoYXJkd2FyZS4NCisgKg0KKyAqIE1NSU8gbGF5b3V0ICg2NEtCIHBhZ2VzLCB0b3RhbCBURUdS
QTI0MV9DTURRVl9JT19MRU4pDQorICogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCisgKiBUaGUgZGlyZWN0IHZDTURRIGFwZXJ0dXJlcyAoMHgx
MDAwMC8weDIwMDAwKSBhcmUgSFcgYWxpYXNlcyBvZiB0aGUgVklOVEYNCisgKiBhcGVydHVyZXMg
KDB4MzAwMDAvMHg0MDAwMCk7IHRoZXkgZXhwb3NlIHRoZSBzYW1lIHBlci12Q01EUSByZWdpc3Rl
ciBzbG90cw0KKyAqIHVuZGVyIGRpZmZlcmVudCBhZGRyZXNzaW5nLg0KKyAqDQorICogICAweDAw
MDAwICBDTURRViBDb25maWcgcGFnZTogUUVNVS10cmFwcGVkLg0KKyAqICAgMHgxMDAwMCAgRGly
ZWN0IHZDTURRIFBhZ2UgMCAoY29udHJvbC9zdGF0dXMpOiBRRU1VLXRyYXBwZWQgYW5kIHJvdXRl
ZA0KKyAqICAgICAgICAgICAgdmlhIHZpbnRmX3B0cigpIHRvIGVpdGhlciB0aGUgbW1hcCdkIFZJ
TlRGIHBhZ2UgKGFsbG9jYXRlZA0KKyAqICAgICAgICAgICAgc2xvdCkgb3IgYSBwZXItdkNNRFEg
cmVnaXN0ZXIgY2FjaGUgKHVuYWxsb2NhdGVkIHNsb3QpLg0KKyAqICAgMHgyMDAwMCAgRGlyZWN0
IHZDTURRIFBhZ2UgMSAoQkFTRSAvIERSQU0gYWRkcmVzc2VzKTogUUVNVS10cmFwcGVkLg0KKyAq
ICAgMHgzMDAwMCAgVklOVEYgUGFnZSAwIChwZXItVklOVEYgY29udHJvbC9zdGF0dXMpOiBtbWFw
J2QgZnJvbSB0aGUgaG9zdA0KKyAqICAgICAgICAgICAgdmlhIGlvbW11ZmQgYW5kIGluc3RhbGxl
ZCBpbnRvIGd1ZXN0IE1NSU8gYXMgYSBSQU0tZGV2aWNlDQorICogICAgICAgICAgICBzdWJyZWdp
b24gYWZ0ZXIgdGhlIGZpcnN0IEhXX1FVRVVFX0FMTE9DOyBzdWJzZXF1ZW50IGFjY2Vzc2VzDQor
ICogICAgICAgICAgICBieXBhc3MgUUVNVS4NCisgKiAgIDB4NDAwMDAgIFZJTlRGIFBhZ2UgMSAo
cGVyLVZJTlRGIEJBU0UpOiBRRU1VLXRyYXBwZWQuDQorICoNCisgKiBUaGUgZGlyZWN0IHZDTURR
IGFwZXJ0dXJlIHN0YXlzIHRyYXBwZWQgKHJhdGhlciB0aGFuIGFsaWFzZWQgdG8gdGhlIFZJTlRG
DQorICogbW1hcCkgdG8gcHJlc2VydmUgdGhlIHNwZWMncyBSL1cgcmVnaXN0ZXIgc2VtYW50aWNz
IGZvciB1bmFsbG9jYXRlZA0KKyAqIHZDTURRczogdGhlIGRpcmVjdCBhcGVydHVyZSBhbGxvd3Mg
cHJvZ3JhbW1pbmcgYmVmb3JlIFZJTlRGIGFsbG9jYXRpb24sDQorICogd2hpbGUgYWxpYXNpbmcg
d291bGQgcm91dGUgdGhyb3VnaCB0aGUgVklOVEYgZHJvcCBwYXRoIGluc3RlYWQuDQorICoNCisg
KiBMaWZlY3ljbGUgKGRyaXZlbiBieSBndWVzdCBldmVudHMpDQorICogLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KKyAqIDEuIEZpcnN0IHZmaW8tcGNpIGRldmljZSBhdHRhY2gg
KC5zZXRfaW9tbXVfZGV2aWNlKSB0cmlnZ2VyczoNCisgKiAgICAtIHRlZ3JhMjQxX2NtZHF2X3By
b2JlKCk6IElPTU1VX0dFVF9IV19JTkZPIGNvbmZpcm1zIGhvc3QgQ01EUVYgc3VwcG9ydC4NCisg
KiAgICAtIElPTU1VX1ZJT01NVV9BTExPQzogdGhlIGtlcm5lbCBhbGxvY2F0ZXMgYSBWSU5URiBm
b3IgdGhpcyBWTSwNCisgKiAgICAgIGNvbmZpZ3VyZXMgdGhlIFZNJ3MgVk1JRCAoZnJvbSBpdHMg
c3RhZ2UtMiBIV1BUKSBpbiBWSU5URl9DT05GSUcsDQorICogICAgICBmb3JjZXMgSFlQX09XTj0w
LCBhbmQgcmV0dXJucyB0aGUgbW1hcCBvZmZzZXQvbGVuZ3RoIGZvciBWSU5URiBQYWdlIDAuDQor
ICoNCisgKiAyLiBHdWVzdCB3cml0ZXMgVklOVEZfQ09ORklHLkVOQUJMRSA9IDE6DQorICogICAg
UUVNVSBtbWFwKClzIHRoZSBvZmZzZXQgZnJvbSBzdGVwIDEgaW50byBpdHMgYWRkcmVzcyBzcGFj
ZSBhbmQgcmVwb3J0cw0KKyAqICAgIFNUQVRVUy5FTkFCTEVfT0sgPSAxLiBUaGUgaG9zdCBWSU5U
RiB3YXMgYWxyZWFkeSBlbmFibGVkIGJ5DQorICogICAgSU9NTVVfVklPTU1VX0FMTE9DOyBRRU1V
IG9ubHkgYWNrcyBiYWNrLg0KKyAqDQorICogMy4gR3Vlc3QgY29tcGxldGVzIHZDTURRIHNldHVw
IChCQVNFLCBDTURRX0FMTE9DX01BUC5BTExPQywgQ01EUVZfRU4sDQorICogICAgVklOVEYuRU5B
QkxFLCBpbiBhbnkgb3JkZXI7IGVhY2ggcHJlY29uZGl0aW9uIHdyaXRlIHJldHJpZXMgdGhlDQor
ICogICAgYWxsb2NhdGlvbik6DQorICogICAgSU9NTVVfSFdfUVVFVUVfQUxMT0MgYmluZHMgdGhl
IGd1ZXN0IEJBU0UgR1BBICh0cmFuc2xhdGVkIHRocm91Z2gNCisgKiAgICBzdGFnZS0yIGFuZCBw
aW5uZWQgYnkgdGhlIGtlcm5lbCkgdG8gYSBob3N0IHZDTURRIGluIHRoaXMgVk0ncyBWSU5URi4N
CisgKg0KKyAqIDQuIEFmdGVyIHRoZSBmaXJzdCBzdWNjZXNzZnVsIEhXX1FVRVVFX0FMTE9DLCB0
aGUgbW1hcCdkIFZJTlRGIFBhZ2UgMCBpcw0KKyAqICAgIGluc3RhbGxlZCBpbnRvIGd1ZXN0IE1N
SU8gYXMgYSBSQU0tZGV2aWNlIHN1YnJlZ2lvbi4gR3Vlc3QgdkNNRFEgUGFnZSAwDQorICogICAg
YWNjZXNzZXMgKENNRFFfRU4sIFBST0QvQ09OU19JTkRYLCBTVEFUVVMsIEdFUlJPUi9HRVJST1JO
KSB0aGVyZWFmdGVyDQorICogICAgZ28gc3RyYWlnaHQgdG8gaG9zdCBoYXJkd2FyZSwgYnlwYXNz
aW5nIFFFTVUuDQorICoNCisgKiBQZXItVk0gaXNvbGF0aW9uDQorICogLS0tLS0tLS0tLS0tLS0t
LQ0KKyAqIC0gRWFjaCBWTSBoYXMgaXRzIG93biBpb21tdWZkIEZEOyBhbGwgaW9tbXVmZCBvYmpl
Y3RzIChWSU5URiwgaHdfcXVldWVzLA0KKyAqICAgbW1hcCByZWdpb25zKSBiZWxvbmcgdG8gdGhh
dCBGRC4gQ3Jvc3MtRkQgbG9va3VwcyBmYWlsLCBzbyBvbmUgVk0NCisgKiAgIGNhbm5vdCByZWFj
aCBhbm90aGVyIFZNJ3MgSURzLg0KKyAqIC0gSU9NTVVfVklPTU1VX0FMTE9DIGNvbmZpZ3VyZXMg
dGhlIFZNJ3MgVk1JRCBpbiBWSU5URl9DT05GSUc7IHRoZSBDTURRVg0KKyAqICAgaGFyZHdhcmUg
c3Vic3RpdHV0ZXMgLyBjaGVja3MgVk1JRCBvbiBldmVyeSBjb21tYW5kIHRoZSBndWVzdCBpc3N1
ZXMuDQorICogLSBUaGUga2VybmVsIGFsbG9jYXRlcyB0aGUgVklOVEYgd2l0aCBIWVBfT1dOID0g
MCwgd2hpY2ggcmVzdHJpY3RzIHRoZQ0KKyAqICAgZ3Vlc3QgdG8gYSBzYWZlIHN1YnNldCBvZiBj
b21tYW5kcy4NCisgKiAtIFBlciBWSU5URiwgdGhlIGtlcm5lbCBwcm9ncmFtcyBTSURfTUFUQ0gg
YW5kIFNJRF9SRVBMQUNFIHRvIHJlc3RyaWN0DQorICogICBpbnZhbGlkYXRpb25zIHRvIHRoZSBT
dHJlYW1JRHMgYXNzaWduZWQgdG8gdGhpcyBWTS4NCisgKiAtIElPTU1VX0hXX1FVRVVFX0FMTE9D
IGJpbmRzIGVhY2ggdkNNRFEgdG8gYSBzaW5nbGUgVklOVEYsIHNvIGEgZ3Vlc3QNCisgKiAgIGNh
bm5vdCByZWFjaCBhIHZDTURRIHRoYXQgYmVsb25ncyB0byBhbm90aGVyIFZNLg0KKyAqDQorICog
TGltaXRzIGV4cG9zZWQgdG8gdGhlIGd1ZXN0DQorICogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQorICogT25lIFZJTlRGIHBlciBlbXVsYXRlZCBTTU1VdjMgYW5kIHR3byB2Q01EUXMgcGVy
IFZJTlRGLg0KKyAqLw0KKw0KICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQogI2luY2x1ZGUgInFl
bXUvbG9nLmgiDQogI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo=

