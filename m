Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A8D41D69
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjdi-0001qo-Q1; Thu, 11 Dec 2025 11:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luqmaan.Irshad@amd.com>)
 id 1vTjdh-0001ov-5N
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:35:37 -0500
Received: from mail-northcentralusazon11013051.outbound.protection.outlook.com
 ([40.107.201.51] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luqmaan.Irshad@amd.com>)
 id 1vTjdf-0003dt-1I
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:35:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6rQteCyMrF1fkaw0n8DYHQMpKFvBX/LJmgVbJuzIgijgv2BAJije2fjjwt58rFCfEmfeX0htk5mjL9y2JxdI30Av4Ww6B5KgPzbIZ32KJz0qXegRfPwWie4q/ss0JZe4FoeOwPoHNEDMOx6xkGckPprNRTdoIS1jD3yUSpNFPDQVxOH/No0R0fs3PnxINHRKg6iRNtbWk02szBU3RhWw/Zv0RVX8YT3tCzTTx8pCxKdFqF8X1/ibWJ+OM8tyFsa3KdITkP8tskfFkx8F/EwLngYQChuOo28xQbjIV/EUNvcvsnXyXdQI0lz9WZZCzKA2A/iCRvb9kszCrDWvvIZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gvdxrxmNEbWdqMIx1xV8FPyUPQWudjgjFW6CGlCNCE=;
 b=M1On4np4/kvent/EYdAzNLr5R8OCtNTBnwKfEc4CG7Gfehbt5l1PRz5yK8XbZHC1+A29oygrCtBSFirlrMPKKzSaxZlpj7Cse9TWMERbH5qLgCtYLpqDSL1X+iEBGW0d5EBlQhWOxCuhJwr9ql5AQIQ9xxY6n7sPPfSQmv+JO0mnReNDwVPb+MeGyEeIjbsy0s669aiw76G9DwAomq5pmhRn0LsCXCsU0rOZ9MiCC8vPhRCX0c7JeQ+pMj8ZHA1+eryV2oZYmVglRitARPdj6MDjLGIbJqwXD+3S3kdX1jiaxk/9gkbWTwIqlqxrz5dhQGs/AHqvd38PEiPSTjFZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gvdxrxmNEbWdqMIx1xV8FPyUPQWudjgjFW6CGlCNCE=;
 b=P8rbIzXx/8WKJcUwvyIIWNRt0cIGjWO5hPkkXD5ReWOdsLIJ4RcJ1zeNYNw2pYXAE6OqMo2q4cRk5eA78ktXLJ79c7NxTUYFygQjgo6/W0LKgAdwfq3DQKWcIvAt+QwObmng9g4ZQJStsgA1XcCb9Hn/5XrWaYXxU7xSD2mx1o0=
Received: from BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15)
 by DS7PR12MB9502.namprd12.prod.outlook.com (2603:10b6:8:250::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 16:30:20 +0000
Received: from BL4PR12MB9484.namprd12.prod.outlook.com
 ([fe80::b6c:4947:b978:9010]) by BL4PR12MB9484.namprd12.prod.outlook.com
 ([fe80::b6c:4947:b978:9010%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 16:30:18 +0000
From: "Irshad, Luqmaan" <Luqmaan.Irshad@amd.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>, "luckmaan21@gmail.com"
 <luckmaan21@gmail.com>
Subject: Re: [PATCH] virtio-gpu: create drm fd based on specified render node
 path
Thread-Topic: [PATCH] virtio-gpu: create drm fd based on specified render node
 path
Thread-Index: AQHcZhfofsc+PaQVgkmybu/4b1LjnLUW7PiAgAWY9wCAACIHVQ==
Date: Thu, 11 Dec 2025 16:30:18 +0000
Message-ID: <BL4PR12MB94840D89E2584BA81151D5189DA1A@BL4PR12MB9484.namprd12.prod.outlook.com>
References: <20251205184906.110927-1-luirshad@amd.com>
 <06bd2abd-e554-4ec8-8ffb-256d33af95c0@collabora.com>
 <56728682-8ab9-498e-acc5-c31ba83642fc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <56728682-8ab9-498e-acc5-c31ba83642fc@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-11T16:20:32.6361380Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9484:EE_|DS7PR12MB9502:EE_
x-ms-office365-filtering-correlation-id: 522450ef-a946-4990-ba46-08de38d29246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021|13003099007|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?4JBXRnTbrpPg+PpcsKUU8r6T7prZLGTjXYXlA2hWtVDBZX8fP0WHfVAR+yFp?=
 =?us-ascii?Q?bBZptnXWpdSPFrPvf7teDkLYkOXJyzz8QTS0xZNk4657JM62h+jQMV68TDdy?=
 =?us-ascii?Q?6t3vHy7pNms5Ofyn2V+bAAcb78I8/R3OE4xKB4YbQDx7p9saxSU9DlV/6g/l?=
 =?us-ascii?Q?4RipCsR2t+rG6KfWgzevXG5/odmQHEO4SFXwiTbqlIPEn4HwG7N5h6riIojG?=
 =?us-ascii?Q?xDKNwvwglacuvVCr8QDkpXvLYzf2PRTZ+k/e5V6uq62C1UFc01q1jjBQusr9?=
 =?us-ascii?Q?0Qq0sd5sEiB2CEsgrXI23+EypJsHgq5T2o3OelEtrHQ9owhn/3SxpT+S+EFc?=
 =?us-ascii?Q?4DK4f0cB9fdf/oOzdvqGQfqRjFW9WuOwryKOMiDXV19qEahZQ/d0XEaqGt8X?=
 =?us-ascii?Q?QvUKfbSmYTGxJi6+34ATwslP0hxRbOOUZpsmOaFyz+aLiyXuLI2hv+VR5yyo?=
 =?us-ascii?Q?YQr3mRC45jOuz63a1grAtJ4rd+0wt16ifO1Pdbpg8L96BhC+pH6lA74q0DjH?=
 =?us-ascii?Q?9De4WyUf29Z/6PjFZ7QfQYF6I5CIpwjMPL8CY7Z2eAq/pCNMnufkEjBOkoae?=
 =?us-ascii?Q?AOkSY3xCismsgYZmITjeCXn/XoI4PV+oO4FloUVxSHXz8v+tYr2MXH5j1FBt?=
 =?us-ascii?Q?GD1sN0rsdyxe9O1LtdprAUF4zVaJnENgvtNi/HvDU5c1FTpcMshXXUzavFbH?=
 =?us-ascii?Q?N16H/qm5slI06hdDs3LNz29na2IEt2KqKdYcjYpO18Ba8kkbama2SVFrvk4o?=
 =?us-ascii?Q?ulsaFr3/p1THKRhyBuxmMobY50U1kih1wITfU6PvcSue74i3uLmuwp907E0m?=
 =?us-ascii?Q?tVuE6NWN2ynIf2rsUYz2T6vNCwg8VahgCZqWvcPmSXDEQ4kRVBUxlTF43cGl?=
 =?us-ascii?Q?9qDOHmDF6DNFM+2mtpoldIXXxRUkkhvd2xT0hLqRlY2tYMR4ROSDPEO0Qa1I?=
 =?us-ascii?Q?j/vKu6ilyK6GZImV3LPKK0GfII17UIIV5QiHmwERa95N08Dw+Ms8jjCqTDWD?=
 =?us-ascii?Q?/9RzjFAjV1ZEOixo6je5UeqvgE9zifkUDZSP5mSkHvLB2YPpkEUWhR+gyVJ6?=
 =?us-ascii?Q?nANxEf2uSnLpVLCaMG/TSSnDv0IepFksJnN3bGg42VpjTvhqz3wF+cdFuhGK?=
 =?us-ascii?Q?f1zhpSLey56zYSuci82AF3YZ3TLMDAtREIUIgZ0fwxheUxNrcTsEIBMQLQ0u?=
 =?us-ascii?Q?Nw4ivUMIrS1qr4e1IFADEPM083IlJozsv28laPsAccAca+BhGLfzMVfx/i8u?=
 =?us-ascii?Q?e3DPe3zAL1e/h5VbskerFvzUJyJfB/02FFSRZGE5Yaifz16eSKbpkCF980St?=
 =?us-ascii?Q?Ed2ePD8+srhcl7mCY6o1iGKbzIaA34Gmh/hKKfblKEUeAFJ5NtgSJ0bgWkvK?=
 =?us-ascii?Q?Dp9Ms1emNMzO8awUgCVl5xozJ0rjsoYlwd4lrbWu4iZ2S+UBtksW5TwEJGyL?=
 =?us-ascii?Q?VYGijt3iHzK/UiijqpH1KYvt4igAzRNUEGy1GOGIWtOCab1kTGyMsg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL4PR12MB9484.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DaVQwyaDGOBizgM2rqhLbWASpPaoVRxy2ybGhvRnqM4GEpDTA8y3rnLYsM45?=
 =?us-ascii?Q?ZCZLEwXKdMfVuPG0VjDNvlqzszgQIP2Q8bldSQLJDWW91uFPGzZfouP1WNKz?=
 =?us-ascii?Q?uv/5loRg1fS//3w77dFreWYDw9PfO9HsdMMw9BspXGe+3N8ilf+D/O2SCPsf?=
 =?us-ascii?Q?mjyoRC84F687W90EQLPv5qtU4Q4ZxJ1egOtIxcNcDg+dmvZKvXJurdawcFq0?=
 =?us-ascii?Q?HFUk3a0Nad+yHsI+nG5oXRv3OVMTyi0pyuTigmIcgyCuW0dOKQErU0U8V1j8?=
 =?us-ascii?Q?kLWflBItyeRiQ904VVzp7ALNl5A4oG7/YOxc6O70vOfwuKW6wjW42PNdHt84?=
 =?us-ascii?Q?9dqaM19TuAmT0LyFmoHt1XpHW6jtyilxHcYFwO3xg0E06GNjh5c3O7fufWzZ?=
 =?us-ascii?Q?sETX4rdnLmQxAcrSQ+yphWZ8+vh1WwNrBOiOQSRyrVDGTy8mhpMQkIBK86Fb?=
 =?us-ascii?Q?YJCATNO3cMxx5trvqkyOp7C8Jolu0ODQnXf0O/5hSRB1wrya7HWloQ3a1WHJ?=
 =?us-ascii?Q?DT4JjtOBabkabULevvYpRWOcy3w7Fyf1KQf68BJk8MhrvpDX56cd7nibtnLG?=
 =?us-ascii?Q?wziVzvUCBoP53nx57NyXEQWoy5UdezCOn5pKsFFaEkLFMktzrMT0/TJuvEW0?=
 =?us-ascii?Q?mM6ThKJfQ/HO59Lw1X9922tGjNP5bOQjJ/AoV68rdx8a2b2dVNIoA3OMGYka?=
 =?us-ascii?Q?w8FM6TOW8z201kqE3PHm898hIONNUcEJU+An/AcgF8JgEY4JXZe03ayiOJXK?=
 =?us-ascii?Q?bfEO9iap39b7injIztLiRRfxtDe9d52o58qoPNXT4WPc1+OH0maZyyxC11mw?=
 =?us-ascii?Q?JF99+uEJUOB4EAD3aDBtuO//I9uY5sFje/AwwCLvVlVUOIstGi4cffxUfR8U?=
 =?us-ascii?Q?9PHGvv3Zetz1Lw0hPNApqf7UgjT4fgkwxfHbTQ6SLEBu4YTbSVJJQ/a1rBNL?=
 =?us-ascii?Q?sVYH0RweToGoSentUW8GEkikwwNn5bx2Pe4Dapswm7/h9WJD6JN2YBrBzfzh?=
 =?us-ascii?Q?MSNzQDp+9QaRyBPLpdM/5gYvtc0TMMWxXeEEY1tYamyu0LNFTEwAU1fkwlxa?=
 =?us-ascii?Q?qv80pNCGZybS+Gm0rnIKe3JA63Oj/yPnPQmNh77jlyZFFVn93j/cHGUpqea2?=
 =?us-ascii?Q?ch8n6JRbWPGyaSoLaA7lRuoXQLgFqxL3Za/3uddRo2oqdoDKIh/34PPt8U54?=
 =?us-ascii?Q?xwnKQV8iTjL+3hfbcZ9QKzP3I3NrO4Fbb4d0KkU0Xl2ncui+j9rNzFHLa1jh?=
 =?us-ascii?Q?QAeDVzdYnxH8cjDGZDobmFnkpT3d2Ci3+yqrq3LkgvoU+PG5k28pcKL06jgI?=
 =?us-ascii?Q?R1qdp/Fewmx6i1VQVQvZuR9yC5alojHo1bn2/znKj8fVftn7hZjdg59J8cap?=
 =?us-ascii?Q?M2G88towffgNeCyBr9DO9gTNNBYba6INrVKTrk/B4AKDt5d13KIjRvwHnsH3?=
 =?us-ascii?Q?0Cl/jiXo3efwbqnn0hG5WpWdoKrDdg6/WJTDWCxVz5H1VSDudSieR1OMeuOq?=
 =?us-ascii?Q?tCUg4u80TaggwamFzRm/XYflmQIt92I3YT9RXRy7OeUXD4NiWWRZ8RvLt25L?=
 =?us-ascii?Q?Tx3nYzTiovc1gwlYq7lsHjr8pUSz+7mULqxL2CZ0?=
Content-Type: multipart/alternative;
 boundary="_000_BL4PR12MB94840D89E2584BA81151D5189DA1ABL4PR12MB9484namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522450ef-a946-4990-ba46-08de38d29246
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 16:30:18.0480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +To+yFjt661WEaOCFQiNg+5NMucJaUNrKlNS4xISC1kG/BnXxNk1s8YUPOtV71Ly2HGGcef2oQ0YlB7rGdGjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9502
Received-SPF: permerror client-ip=40.107.201.51;
 envelope-from=Luqmaan.Irshad@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_BL4PR12MB94840D89E2584BA81151D5189DA1ABL4PR12MB9484namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hello Akihiko,

I just had a brief conversation with Pierre-Eric, and I believe the use cas=
e is slightly different than the one described.  For virgl, selecting using=
 DRI_PRIME only would suffice because QEMU and VirGL (both using OpenGL), b=
oth rely on the driver to pickup the GPU.

For Native context however (this case) there is no GL driver use from virgl=
renderer side, which is why we inform virglrenderer using the callback func=
tions instead.

Sincerely,

Luq

________________________________
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Sent: Thursday, December 11, 2025 9:19:22 a.m.
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>; Irshad, Luqmaan <Luqma=
an.Irshad@amd.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: mst@redhat.com <mst@redhat.com>; alex.bennee@linaro.org <alex.bennee@li=
naro.org>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>=
; luckmaan21@gmail.com <luckmaan21@gmail.com>
Subject: Re: [PATCH] virtio-gpu: create drm fd based on specified render no=
de path

On 2025/12/08 9:49, Dmitry Osipenko wrote:
> Hi,
>
> On 12/5/25 21:49, Luqmaan Irshad wrote:
>> Added a special callback function called virtio_get_drm_fd to create
>> a render node based on the path specified by the user via QEMU command
>> line.  This function is called during the virglrenderer callback sequenc=
e
>> where we specify the get_drm_fd function pointer to call back our
>> new function, allowing us to pass the fd of our created render node.

I guess what you need can be achieved by specifying a render node for
the display. Headless displays (egl-headless and dbus) has the
rendernode property for this. For the other displays, Mesa should choose
an appropriate render node, and it can be overridden with the DRI_PRIME
environment variable:
https://docs.mesa3d.org/envvars.html#envvar-DRI_PRIME

>>
>> Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com
>>
>> Signed-off-by: Luqmaan Irshad <luirshad@amd.com>
>> ---
>>   hw/display/virtio-gpu-gl.c     |  4 ++++
>>   hw/display/virtio-gpu-virgl.c  | 17 ++++++++++++++++-
>>   include/hw/virtio/virtio-gpu.h |  1 +
>>   3 files changed, 21 insertions(+), 1 deletion(-)
>
> Do you think it could be possible and worthwhile to make QEMU's EGL
> display to use same GPU as virgl automatically? I.e. we tell QEMU/EGL
> which GPU to use and then virgl will use same DRM device that backs EGL.

As far as I understand, it is already ensured that virgl uses the EGL
display QEMU uses, and I think that what you want. Opening a different
render node and passing the node to virglrenderer breaks it.

Regards,
Akihiko Odaki


--_000_BL4PR12MB94840D89E2584BA81151D5189DA1ABL4PR12MB9484namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Hello Akihiko,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
I just had a brief conversation with Pierre-Eric, and I believe the use cas=
e is slightly different than the one described.&nbsp; For virgl, selecting =
using DRI_PRIME only would suffice because QEMU and VirGL (both using OpenG=
L), both rely on the driver to pickup
 the GPU.</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
For Native context however (this case) there is no GL driver use from virgl=
renderer side, which is why we inform virglrenderer using the callback func=
tions instead.</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Sincerely,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Luq</div>
<div dir=3D"auto" id=3D"mail-editor-reference-message-container"><br>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;" dir=3D"auto"><b>From:<=
/b>&nbsp;Akihiko Odaki &lt;odaki@rsg.ci.i.u-tokyo.ac.jp&gt;<br>
<b>Sent:</b>&nbsp;Thursday, December 11, 2025 9:19:22 a.m.<br>
<b>To:</b>&nbsp;Dmitry Osipenko &lt;dmitry.osipenko@collabora.com&gt;; Irsh=
ad, Luqmaan &lt;Luqmaan.Irshad@amd.com&gt;; qemu-devel@nongnu.org &lt;qemu-=
devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;mst@redhat.com &lt;mst@redhat.com&gt;; alex.bennee@linaro.o=
rg &lt;alex.bennee@linaro.org&gt;; Pelloux-Prayer, Pierre-Eric &lt;Pierre-e=
ric.Pelloux-prayer@amd.com&gt;; luckmaan21@gmail.com &lt;luckmaan21@gmail.c=
om&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] virtio-gpu: create drm fd based on specifi=
ed render node path<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;">On 2025/12=
/08 9:49, Dmitry Osipenko wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On 12/5/25 21:49, Luqmaan Irshad wrote:<br>
&gt;&gt; Added a special callback function called virtio_get_drm_fd to crea=
te<br>
&gt;&gt; a render node based on the path specified by the user via QEMU com=
mand<br>
&gt;&gt; line.&nbsp; This function is called during the virglrenderer callb=
ack sequence<br>
&gt;&gt; where we specify the get_drm_fd function pointer to call back our<=
br>
&gt;&gt; new function, allowing us to pass the fd of our created render nod=
e.<br>
<br>
I guess what you need can be achieved by specifying a render node for<br>
the display. Headless displays (egl-headless and dbus) has the<br>
rendernode property for this. For the other displays, Mesa should choose<br=
>
an appropriate render node, and it can be overridden with the DRI_PRIME<br>
environment variable:<br>
<a href=3D"https://docs.mesa3d.org/envvars.html#envvar-DRI_PRIME">https://d=
ocs.mesa3d.org/envvars.html#envvar-DRI_PRIME</a><br>
<br>
&gt;&gt;<br>
&gt;&gt; Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com<b=
r>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Luqmaan Irshad &lt;luirshad@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; hw/display/virtio-gpu-gl.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 4 ++++<br>
&gt;&gt;&nbsp;&nbsp; hw/display/virtio-gpu-virgl.c&nbsp; | 17 +++++++++++++=
+++-<br>
&gt;&gt;&nbsp;&nbsp; include/hw/virtio/virtio-gpu.h |&nbsp; 1 +<br>
&gt;&gt;&nbsp;&nbsp; 3 files changed, 21 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; Do you think it could be possible and worthwhile to make QEMU's EGL<br=
>
&gt; display to use same GPU as virgl automatically? I.e. we tell QEMU/EGL<=
br>
&gt; which GPU to use and then virgl will use same DRM device that backs EG=
L.<br>
<br>
As far as I understand, it is already ensured that virgl uses the EGL<br>
display QEMU uses, and I think that what you want. Opening a different<br>
render node and passing the node to virglrenderer breaks it.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
</div>
<br>
</div>
</div>
</body>
</html>

--_000_BL4PR12MB94840D89E2584BA81151D5189DA1ABL4PR12MB9484namp_--

