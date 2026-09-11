Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C578BC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x56A2-00048Y-PJ; Fri, 11 Sep 2026 14:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x569y-00048I-Rv; Fri, 11 Sep 2026 14:39:38 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1x569u-0007tr-JG; Fri, 11 Sep 2026 14:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uolvejDDHFlTGNSHF/5pOjK8EueKpdulWKUMpZn3dttp94vSZDgu2hDUHbmlRt8DTvlcVpJpf/ca7oeMMwQ9GheiJMsNyuAPcMMa5iMcdvRiL0G/60h2Uzpc61su/8HDMuSKZPzzcQzHj7fJTbznLbDe6nHbMUCUZ2CADFi8UFKqkITXHd3QEmna/3jwEOwLy80O4PbwZILHsQdWIf4GQlAgw9gNe/NRW5VIIXcTf/zaHFhCIXzhnZeZOtZdjsa+hfh9Qc1wzfdIuLAxT31HCopgu6rUvteJ/m9EYWuZuvn5SWIgbaC6QvnD8b/4h2yAgQjO/lCta0Rc5aZX3YpcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od2DFNBB+9DwMDjeeZ7I/QWGIznR1Z0D0isHUCtnBc4=;
 b=D0p4Lk9EUOz9MpYSQxekdbUwre/o5qfa9TKiAJl0M7Cj0kyTpW9euUV6H+eeZBcFVyz5wJ3wKnGSeUHIU8KOMqVcbnXr9xIrOj3yt8kzT1j5DWTtMIX3nyIllI9zesp0RWw/F6IW9DR/JmSZe1Qjzow4PGtspRMobTkmUh4d3iShn0l4Tsdae7vmcwQXxhDoQ3HJYydppRBEMMcpRZuF0xckza9vVnPSnc1B/FEZ6qw+UHd/v34ggaAIoumlui84PLAHbxE7KhWXk0mlu8OQRrG7S7kD3pH5owniOMqNW/IbJoakE11z6gZemJZHpwwWYhAiQrzvO3aAFXXWaGjBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od2DFNBB+9DwMDjeeZ7I/QWGIznR1Z0D0isHUCtnBc4=;
 b=N8h6QPHG7FAHrJ1+/9Xr8hp6hfrhHEvd+y0SKXfH8M2aSPDEJdUPIhYQVW069bOHoLhCGCdp/ev6QJcEGft4EtkeeKi4v//iodull7dSdHDG8o4zj0vFrSzwtxhgA6eRLrXVhNRBJPSEDXgBqNM1rUwgQL5PmdFOBVYYvST9M5uOUIdL48gdt2fCDb+LIlt9bq/6+GJdZuYSKvc9fj049JL5MOHiAykcUNmnavVb2vPSj8M4Pi2kHZmdYjwDJAvVLKeN5NRS0c0uhj7UUIk73NAmUzRGTTlSMHnZLkR1/Xi9PgPsNBXTuQEoycryAviLmGy43h9yyTiwdu5FtzE57A==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 18:39:24 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 18:39:23 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Auger
 <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: Re: [PATCH] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Thread-Topic: [PATCH] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Thread-Index: AQHdO9ShdqyMUHBoGUmZsU4dP9xc0LbJEcUAgACwQIA=
Date: Fri, 11 Sep 2026 18:39:23 +0000
Message-ID: <9A96A5C2-E845-4FE9-BFA8-A22086BC05A6@nvidia.com>
References: <20260903184710.2052780-1-mochs@nvidia.com>
 <SJ0PR12MB86145EFC09640ED159B199F1ABBE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB86145EFC09640ED159B199F1ABBE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|SJ2PR12MB8650:EE_
x-ms-office365-filtering-correlation-id: ed48a621-2086-45db-c6f5-08df1034003c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|38070700021|4143699003|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: y1CU3GmTgFf6mnytIbj2hk5K9Ns1BBKuj7hTR/8Lb9IJelNYOocvdJHwbCYFuxZ1/kpF/QORffhkcMyITO+Xi7USbKVtEmJUUvEkYR2HfrBOgZOGTWVn77kKAwBgLFYx14IY49g+vgOLhX49C2AB5pSy0Oq0fa3Xx88YbNjJjrRA9uszNNgoOZLZhnRHSWJd9IiEOqNo0cjEdR64l+ncEXbvz67cExtTy+13D6sPOR/ov8hdPwuFaOyxcy6OcEvJgcBAkXITG9cHlVGZ3YEuW5OARJM4KUgTfFi4NykxR8q4Pn8me8wXSVGr0tNgtr9YELQbCVDxpEqAJiM+SnVK/8Z3PsWx2fFOS42iZ8qBbFQKCbeXoijrSgLZQnTyE4qvhJOtOokQ4D6so7nqpqP0c99IuxI3AGK4sPI5pSKSDDLeTJQjXdFfbi55xmaDEx767ZzLU9Wo82Ov3r8alnDigmSXDIexBMXyNyl3lWEe7jTG97NoMpyuq5gGYwGzIsW6CnwxxYSvzZiwwKhW2SSCakJ8sXFriESRFfSR86qJ9Q4DGR3qs+dz6V0C5fPgQX4eBr0R3KMPcwDh0ULEyg9cYOjFCXw/r/Echhxc485utTTXuRbVIaBs6SVXg6V4TlV5uHNdRQ5Qu70w9nFcOB0MFfMCGnkZhw2a88nHjOkvclQN+Uy0WIRHSUt2s90ncZNpnHg6ybJceelUQMNg5WFvNskx42jMSgZ5d/M3AvRAgJ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K1NU0BczHdEvXCv0VzxdlhprxdPAwGzKigDEdbCqyMGeaqZD41iSHM3s0DTk?=
 =?us-ascii?Q?VcOporuqDxEuKWLOW5KZThXzNnkorZLnDOkB8qqL+NXo7LwMEeFbkEx35uob?=
 =?us-ascii?Q?wtra7rBYZlGrYctQGpLMg12T+ldICNos4l/AfQ95FrVyeQcBsS8rK4nrs0CJ?=
 =?us-ascii?Q?/qRJH7TbstIbZ46cK04qDXrxbz4zLxl5b5Pr9FY5Yl9s0sPh0bvhDiHYutXG?=
 =?us-ascii?Q?AizFKNdaCtzKc1c46ge06DlrOH4KYLz9uv6pM10c1g4d5V6rclaTZrpeONsY?=
 =?us-ascii?Q?I/lwBNdqlm0dg7prlsHoerMVwTtqSVVCgWFChcWZgmMRRNnDrSb59tXt8hC4?=
 =?us-ascii?Q?iHl/5Q9sm3wUuHQF0e5R38XAH2IXQAspp/3f8YLhwsNUPMite9qMSUMUppwB?=
 =?us-ascii?Q?BoQhe020Me1vXE4lvpPUcYHd9cXuGwMWdyRi/jqzDPVcpX4W6amdgcyKmm4y?=
 =?us-ascii?Q?hwxWKnUWi9i1OyJZYqOWq8UYVEfh4nFYMwxjKCktUBpxPo+F8YgjPQ8zJ/4B?=
 =?us-ascii?Q?uLAlONPluMJaVdU0pLD4EC188UX8rgGW87GYy2iUoltCMDqoxD8aICxS+3zM?=
 =?us-ascii?Q?JJlb46+ZDNo3tHN55wIW5UQgJo7ogYrtlfjqvlwva9h1pCZQdO/XDKrV3+8d?=
 =?us-ascii?Q?zsBfQITz0U1fpA4QGLqm2s21d0D2jNza+o9b5gPiDkayRhnmRtT4Gu67ho/z?=
 =?us-ascii?Q?7OVQkBAjsG6Z3+kflntzPCs+HKBPFKAPlRA3KY8VQGCKibwWOIzu6LSqLbsT?=
 =?us-ascii?Q?GosZYjCR1IYE84+h0X6ag0mrtshw5Dm+KIT7ZPDZuMvn1o/LDXI0tUY2QNvq?=
 =?us-ascii?Q?gLr+EHfSLjJrwiL2B+D5GNVMIMcZ8IhwbXoeQ9kmawzPnBUwpFl5yARqKeqt?=
 =?us-ascii?Q?QDLiqUiKj+iRjUcEGYIU+kbHAIiobooaJLXisEH/bC1w6KWRQbMK0rxAeF83?=
 =?us-ascii?Q?jXPLbyMdX5HaINhXsFef7/1KaWRNkCMfgDlYewRStUHWd4aNp77Q0vM/1Liy?=
 =?us-ascii?Q?QU7SHfKiEqqUfzU7C/xiTfZY9PQ9az1B2/qtU2dsMzgnryda4wvsQq158UnM?=
 =?us-ascii?Q?1gvlcREgwDFrO0DQyIKbARAjX001XuCM2jhNfn6hCiQJzTH5FLdNUltC0r37?=
 =?us-ascii?Q?tkYBQW6PPWDpu6AoCmp/Wi/P3lCvdVpJKYhdzlvZxmkkvh75gO3MB6WWUNj3?=
 =?us-ascii?Q?EUkA1FQKrJciCjKghPz7BpI9iypYuJadLXE0kduvlAfgVi8THML0DN7N9AI3?=
 =?us-ascii?Q?kkAI917sFT9/TDtrVWI/APW8Hqidroc6ePFkvzT/i6FvEoFZwmlcIi8tCrmO?=
 =?us-ascii?Q?gASPnBeua8lsAmzxG0p8ppEufk6SkAz1IowULNr3vcUnoSMNRBiMy/cbJf5v?=
 =?us-ascii?Q?rICH34hLyccMgXL2qDkIht5Qg/D4DNpjIQoV3T8J7j97YC6RKwx7xYDEWb+D?=
 =?us-ascii?Q?MaLPFl5p0RC+d6xCO1zuyWPbgMRDPo8riQ/zY8USPc+OGNtIaMqbEg4osBQj?=
 =?us-ascii?Q?IHuqZm6Sh1KrrPjdiNG30Ha0XijiuGuBK94Ai0CiblDW83vHsLkvPJC3HKt1?=
 =?us-ascii?Q?kgv0Kwm8q77PSZujN9endSwGQULNGCHMKuoqzuBAu8YOBIRxDoyOWQNvWjf+?=
 =?us-ascii?Q?qTVsCYeObO61jIHp/eVDvwbDn132c1E0KB0zQTCvVlgRT/EJmh2Qxg+DIHmH?=
 =?us-ascii?Q?jfrXPQNsvL9u6JaM/uHhgXP9cuuD3EDzPncTIkY5NPP6cMQA54nUJ/thkZXy?=
 =?us-ascii?Q?UDybiCkS5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E458C12FC67FE4DAD006D841E0E6F69@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed48a621-2086-45db-c6f5-08df1034003c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 18:39:23.7944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdryAr+qtKNEsd5BQY21fmLcQ1un9UelYMvry1g13jIviNnGuf7VKyBR2g4z7zPSqpL0igzdGishrT4oYjW0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=mochs@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

> On Sep 11, 2026, at 03:08, Shameer Kolothum Thodi <skolothumtho@nvidia.co=
m> wrote:
>=20
>> -----Original Message-----
>> From: Matt Ochs <mochs@nvidia.com>
>> Sent: 03 September 2026 19:47
>> To: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org; Peter Maydell <peter.maydell@linaro.org>; Eric
>> Auger <eric.auger@redhat.com>; Nicolin Chen <nicolinc@nvidia.com>;
>> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> stable@nongnu.org
>> Subject: [PATCH] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
>>=20
>>=20
>>=20
>>     memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
>>                                         CMDQV_VINTF_PAGE0_BASE,
>> -                                        cmdqv->mr_vintf_page0, 1);
>> +                                        &cmdqv->mr_vintf_page0, 1);
>> +    cmdqv->mr_vintf_page0_initialized =3D true;
>=20
> Do we really need the bool mr_vintf_page0_initialized or can use
> memory_region_is_mapped() instead?
> Since the region stays a subregion while disabled, memory_region_is_mappe=
d()
> still returns true, so it should work for the "initialized" check, I thin=
k.

Thanks for the review and suggestion.

I agree with this cleaner approach and will send a v2 shortly.


-matt


