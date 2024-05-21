Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540C9C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PI9-0008NJ-2R; Tue, 21 May 2024 09:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHO-0007dw-MG
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:52 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHL-0001ZU-S3
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297103; x=1747833103;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s/okrwVgXn8VNFlR+LfdeLdln6EjEFerCZiHAQA2Uvs=;
 b=rLRexdmAVTChdu2SJ0fjRKMKkDLky0rlyX0e5rBjUMAh5kHt9QmhM93w
 PNr0o/n3LzCtOTBEw2q3PpeVoDE7wzhdgEwkJC6WuAORpykhY75t6BsaA
 X4fLh0XWUi2h14KRalViTzHqGi0YybaAyUoLY4Kbr286//o+ItCwzGQc+
 P1RgnAB6RfujslA/w+v8jbS+1lsknU9f8iwwzYUgwRqpzj3E0k5lzjgBp
 sfiXQQVBt6wf4M+1ShjEms39sgT+qSYWVyNlhRlF8v6hEPb+liAnWTbON
 vxoXXc+cf7x2GXYVy1l0XSTyP3Z67KspsHjTKVGPQh3GpOK0og6AxdCNu A==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13007988"
X-MGA-submission: =?us-ascii?q?MDHbPYWDAmPTWkT+dmbCcja8qy0ptaUnIoKtcs?=
 =?us-ascii?q?ztt8NyzPIpheEox1ugqQYCDV9606heUSDOHkwEEuzn7jPIo5MJrHCl01?=
 =?us-ascii?q?9pFBnQCTGSo6OAXtw03NdTPVMCdqdVlQjXlMGoWrWUmb5WnEaO1gzaCo?=
 =?us-ascii?q?2fW8azIE790K53uklah9pPXQ=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0bycLx6ZlxzL9Q0Fir4ySxtCY9+NXi5WQVeD9Gno1VRVFTEhAMWBTCNJKoCrPzgNV/rqPPyQJNnVbjXpM7ZsehasAMiY01GR6XhjCud7P1o+bWjJP6Cz8jWspUz0NSlcVD9u2Ts31D9/AKZw4OHboRCkQs6CymAgHe/OZJ7SRDEcPTqtJpcz8da/vO+BKVCR5AXr0Etb8su04E3EgHhqzraau8iJ1+I34mS9tQGfm6zibHFgSyqmcvJVCrorc3L7ixwlh5T04TVIl09L+o3P1rJn4FdcvMKpLcJ66N+kAiVFv0pyI+olPl+jWi6oBEALKZ2acnLSm38BkJ/nbkzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/okrwVgXn8VNFlR+LfdeLdln6EjEFerCZiHAQA2Uvs=;
 b=b+LIZrapoEc4Snk7vAbZlvwo/IzVd5Ob1e9fr+mVQqAOHAn7x8qVPpOc3/8XL6WbkBBkuGEqV8eOF6AmI8oDEguJ34Gsh6WLFyB8HdEc4i774MDlhxil3m1+CNOT3InqSVREzZkwajY+pzYyQh1SJ9io+cQwB50RtCmMWGoofPDw2CHWWZ3cJ3lSNie0ctB/CCDUn1R+T8E//FoMuI31WB/v92uvmd+pfuJQ4jmav+4UY6bE3jSAyqxSbjFlQ4f2WTsMa25reVos4eDUNtjYOb4aI5jvCQHplgB7nxAYkffAOwLImWAsrAuQaAGDcbP/XJBk14xPJkF2anWcjyFdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 01/22] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH ats_vtd 01/22] intel_iommu: fix FRCD construction macro.
Thread-Index: AQHaq4Bpg4eL8UGtfEKvRSZXOcRINQ==
Date: Tue, 21 May 2024 13:11:38 +0000
Message-ID: <20240521130946.117849-2-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: bd569a4a-2a99-4fa8-30ad-08dc79978c75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aXBDYW1PcXd2YjkvaDdGWGdvT1pYTFJZWDI5eUF4R2FkaENKbGRRL2F1TVFw?=
 =?utf-8?B?SG5ZYjlKc3VkOTUydWtZeldlRVZCUXVieDc0WXBweWZyT09RUEdNM002bHM1?=
 =?utf-8?B?UmU1a1RmOTViNmMxdjJBREVralptVkNXZzNVY3JEcDF5aGNHQ0xXYnRwK1hI?=
 =?utf-8?B?YXpiSjloS1RMMUtjZVRvRnVNaVA1Rzc3L3pIMzkyTDV1R3ZxSHVlcW5lTnhF?=
 =?utf-8?B?YktOb1krS3ljM3pSRzNJeUx6NkY4QTF1WFZJZys0eURDM0Z1T0dBQzhDSjdp?=
 =?utf-8?B?eTBoS25nclRtdGF2S3FiRDdWWFZhUTU5QzBpL1UrcitpNVBMVE91dmR2M3Nr?=
 =?utf-8?B?Q0RYL0ZZZzkyNG9ra1NtdzlwRTdHVVMxSnpZZkZCeDFzK0JTVzNXQzhiMnVm?=
 =?utf-8?B?bWEzdTNCaVJyQ2Rrc0twODQwZnE3VXZoVFRFL1dIcmxUREJYZDZhR0pkTlZu?=
 =?utf-8?B?a0RtVlB2OGtLMjQ2R1psRGZFd0Vsc2VxOHVNZTUxNGkyd09KQXFSMXFnYjJF?=
 =?utf-8?B?aStxWGNwQmQ3dlBvelAzbkNlU3hFNjBVU0swbGtjSGNQaStKa2s3aGhLRFlo?=
 =?utf-8?B?VXZHeGVvdUZyK3d6U1ZPeVBLTnIzekRqUUovUHdPcGN0VEt6NmNuYXI5NlNW?=
 =?utf-8?B?eHBzelVsZ09GRzJHRGszajdRaEhxd0xTOUdQTlFBT2JwMjMzcS9lRlBrWVJJ?=
 =?utf-8?B?M0VHMUtFVmV6OFA0QXNPU3k1MzUrRy9mMjE1dUdoMkdCdThZdUJIVi84NnRQ?=
 =?utf-8?B?eWhVTkdTTjBJYlhnNzdYNTNieVFSRmhvTjlXZmNWNHlzOVBtb2ZnZ050dVdT?=
 =?utf-8?B?b1dRM2Y2WEUwTUM4NUUvNjZwODhneGppMUxsYkZLaU42cG1VZUprRzNzYUVP?=
 =?utf-8?B?VTlzMlFucGhiM1hyN29EVUFVK0F5RmpsOUpXSU8vcTYxNkF1cVFYMVFjdzBD?=
 =?utf-8?B?cUJjdzRPeURYUkY0d3dKdE10NnlRU0dDZkpncDJFQ1NnRjFnUTBPV01HT01h?=
 =?utf-8?B?NWVKSFV1TFNlWkJLMkN4aVZ3NjZBUFRoMm42a1ZucW5XdkFwR1ptTkIwNzRU?=
 =?utf-8?B?MDdlenZjVVNsNlVTTmF1bWRyTldZWGxDQXdPd3NXV3NkeG5qakwzeW5OK0kx?=
 =?utf-8?B?REZhZ25zNWhheWZpd1V2UVFhd1NBRVB4TkdWTEFaNExlQ3JQM3c3UVdPMjFX?=
 =?utf-8?B?YVNzMmJDNFc4NnlObGRPSjdwMmVkeUNZVDV2RUk4ZWRnSDhzNEJxKy9QNkQy?=
 =?utf-8?B?SzFTYy9qZ3Z2ZDRDN3RxaFpFODYzdXFBZWhPelkzRnoyZjBWcHBaZTg4VzU1?=
 =?utf-8?B?TkVSNVRZR28rQ2ZRSDhVUFIwekFsUk9VQmI1dHAvYjNBaW5Hc25IYnIyZllw?=
 =?utf-8?B?dnVJTVFvUU8rWWIyRHlyUlZhNGN4WlBWWjBjb0Zmam0wV1EzaDJ6RVh5UjlN?=
 =?utf-8?B?eEp2Z2NIRHNvU1FZVzFBaUZjaFppbHkzWEp2K1dHMkI0Y1BsMU8veW56UlQw?=
 =?utf-8?B?YUt6cFppMFdicDl2K3BBaHZCT25tTUNjbUdEc1l4eVZrWnVFS3ByUm8wRnpN?=
 =?utf-8?B?SnhldUNRanhZcUpnbXprUms0VERNbGd2SnNTTDArajRtL1ErSU84Z1F0VHNu?=
 =?utf-8?B?c09GcnU0cUwrRG41RDFvZjNjZkZ5eVEvRGduMW9sdlJOYWZUeGFWcXdRbnhC?=
 =?utf-8?B?SjcyKy9oaC91S0tmdUhBd0MxUHVMN3lhYWh3M00yZ3oydi9kWFZTdGliUlgy?=
 =?utf-8?B?ZmozUnNJR2xGb2doQjJwN2NIZUYzTG9scThyYjVvK1JRdE45VWQvYSs3d0JK?=
 =?utf-8?B?T3c5UGxpY04wc3lCMHpmdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzFLZ21vVHFnVHoxNGZ6eWEyT2RHbEFLZTRRT2FoSVc4c1hzZ1NhaEdNb0tJ?=
 =?utf-8?B?bmFqWUttcHdHdGV3SHJNc2s2TmlScHNEVW9mTEQ2alBXOUQ2Z0hFVXFBbk5a?=
 =?utf-8?B?TG16STU5eElWTXZmYVZJb3FUeVp6eUIyMEpBWUkrU3BxQzVSNFZWZmVrWW1T?=
 =?utf-8?B?NHZPRGJMK1duZnJZT09iZS9xWDlGbU53cmZaQ2NUMmdBalp1djlCLzc2T1Rx?=
 =?utf-8?B?QkZ4VlBOSVhUNGZudHJoa2tHaUZTemllajdOTnFCbnFIeDhXdHpOSkdCTSsz?=
 =?utf-8?B?NU9BVmNwTEtRajUvSi9OLzVXNmljUmlHdG9vVjdnYnBxd3p4VENZZ0FtWmVn?=
 =?utf-8?B?RkQ5bkw4SFZ5L1NESjl4WTVwTEpHdS9NNzEwTjY3L3JjcEdxb0RScWtmV2R4?=
 =?utf-8?B?d0xaNWg4K1VoMmZmZEkrbjdCRXRXMG5YYXJ0UURxQk45NWw0eTRDMHc2SkdJ?=
 =?utf-8?B?dkhwa2VuODNLN01DMkUvdzg3Y2ZCQW5od29OVTJZODVyRXFZT2lxOHVXakNs?=
 =?utf-8?B?YXZmSnJPa2dNTHBLL0Q3NGcrdXE3Q0p1M2dzRFkrcGppZ2pENmsyVkZnaC9x?=
 =?utf-8?B?SjMyN2VBUmF2b0VMZERIQVdEaUlsdXZRRDNoVmd2WnozS0M5aEIzWW9vazBj?=
 =?utf-8?B?bmxHcVVGdEdWbUxzbW8vNXM3cDRHbENkbkdNMzZIUHBOb0ZXZUMxOGRxWVl1?=
 =?utf-8?B?ZjBkK3ZHdGwzRHZ5Q0Q4anRGdjNqdEttM0ZIeTFuUGFoOHhMQjJFcUp6VERP?=
 =?utf-8?B?K2JQeTFhV3h4bHAxRmNCMWs4azdtMTBVeG5laTVUKzEyVWszSmVTOEZXS0pT?=
 =?utf-8?B?M3ZoR3pneGJNazE2cUQrNjd5UkFIZzZSMDJsdzFZYXBFb2NlVlhMb2hNaWND?=
 =?utf-8?B?N3FPVjNZdkFmVTU2STJpY2lLVlVyNmxvQ01qK01rU1g1d3NEN0VqQXBiaXNz?=
 =?utf-8?B?aHppSzFqODZCbzYwQ3p3RlpWR1pEK1F2ditYNm5pNU1xMWNGTllLZEExU28x?=
 =?utf-8?B?VlhwcDBYTTRPWFVQWlJvSHNORE5sbzlhd1ZBU1NOS2prVXRadTZlSW5Rc2Iz?=
 =?utf-8?B?YkJUYVN4S3pqTmtlS2ZPemtpN0FDTHo1ZzlCbks3Y2R0SkNQZERRZzJsRHlj?=
 =?utf-8?B?T3ZxT2pTOGI2RFJ2bG4vaHFlWjEzRWV2Sm9zSWZYYkFpQjNBWWtkUGxMQ2dk?=
 =?utf-8?B?WXZoTnNWMFRIaFU5NVdiM1g4cnIzR0JlU3FBbHBlZ1UyRlh6VER3TG1WZUw1?=
 =?utf-8?B?Q3I2WnBXZksxM2xWRTUrWExSeHNmSTlxK1dKOEdRdytReHhSRE1KZEI5a1Vu?=
 =?utf-8?B?a3QxZmVQZkQwczNSVFp4U3FHaVVobnNYTGY1bm9PSEtJV1RUZHFhaWdTaGU0?=
 =?utf-8?B?Nzh0djNNbUJoakZCSW9zRjBZaGxsRHBSRkNBUUJ6L1lnbHEySUpaLzEvcTNP?=
 =?utf-8?B?Y2I5MitHRlpTUHFLTjRoODZOc3ZoZjZhOXRsbUkzdFlsVHdadmg3NjlTa0tG?=
 =?utf-8?B?NUFWMnZMYms0ZW4velRPUGJnTVdsa21UWjFZc3FqN1pwU2ZZNmMrTnN6V1BV?=
 =?utf-8?B?U1dBQjBVUzJiS2tmME9aTzU0TnR5WWFWN3VjcVJjdE5haGRRT05zUXdhSmNa?=
 =?utf-8?B?WHdoNTJlTkorTHoyV2NKcGNmSi9Nbkl3VklFVlBrK041aWFWeEZCd0E5S3d4?=
 =?utf-8?B?VTRCMmdiUVZtWUkva0M0MkFnWE8yU1owWkJvbDRFekR4eEgxOFllcEpoZm5T?=
 =?utf-8?B?VWtIU1p3Y2U2dzlZZ3FtekZXTkJTMUpFUzZIMUlUL0JhMTg5eWxjQ3IrZG96?=
 =?utf-8?B?cHloTnlqa1B6V0M0TitmOGxnVmM1RVdZRUVNNy9NZ0VaU0tYVTNCYjdPSXZt?=
 =?utf-8?B?UmdBK2lwa0QvYy9DbzhmMk5SaFhVRkgrWmlLS2FSVjUzZXZHTnZwOFZpQTZK?=
 =?utf-8?B?L3ZqUEFOelNLVXpoT2t2K3BRQ2N6eVdyNEZDemRrNThSVyt5QzUwTlBBdDFW?=
 =?utf-8?B?VUZMOUc4b0pEZDVoTm9YU3N2My9BWm9QbjdoOU50MG5VYVZ0Y0NLcVoxeWhD?=
 =?utf-8?B?cU1JV09sNHdLWDFnbmZYVE1LZU5ub25ZRk1TZkFvNXpFMEQxZExHeVdIZGM5?=
 =?utf-8?B?UTlyQ05qZ3daMTdxaWpJaEJPeVIwZFZUR2Znc3NWMGJGQ0tmS3Juci83bG5B?=
 =?utf-8?Q?4OUSevjoT3s62PRHq0FZCo0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE41CE435DC04D4DB0B2D6C8AA819621@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd569a4a-2a99-4fa8-30ad-08dc79978c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:38.3243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rnL44jYkT21cHuIYRpHYNVhFdiTYo0owsv9r65O++zmR8Jn1dtSAY+dkJFF4vIYdarNaOOULw1FC1kR8sAbeLGMqM2d/gO5W+gWsq5SBbQbHpJlNFO7hkarfWm3KDG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhlIGNvbnN0YW50IG11c3QgYmUgdW5zaWduZWQsIG90aGVyd2lzZSB0aGUgdHdvJ3MgY29tcGxl
bWVudA0Kb3ZlcnJpZGVzIHRoZSBvdGhlciBmaWVsZHMgd2hlbiBhIFBBU0lEIGlzIHByZXNlbnQN
Cg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IDdkMDQyMGUxNWQuLjFlMzdiOThjNjUgMTAwNjQ0
DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTI3Miw3ICsyNzIsNyBAQA0KIC8qIEZvciB0aGUgbG93
IDY0LWJpdCBvZiAxMjgtYml0ICovDQogI2RlZmluZSBWVERfRlJDRF9GSSh2YWwpICAgICAgICAo
KHZhbCkgJiB+MHhmZmZVTEwpDQogI2RlZmluZSBWVERfRlJDRF9QVih2YWwpICAgICAgICAoKCh2
YWwpICYgMHhmZmZmVUxMKSA8PCA0MCkNCi0jZGVmaW5lIFZURF9GUkNEX1BQKHZhbCkgICAgICAg
ICgoKHZhbCkgJiAweDEpIDw8IDMxKQ0KKyNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAg
KCgodmFsKSAmIDB4MVVMTCkgPDwgMzEpDQogI2RlZmluZSBWVERfRlJDRF9JUl9JRFgodmFsKSAg
ICAoKCh2YWwpICYgMHhmZmZmVUxMKSA8PCA0OCkNCiANCiAvKiBETUEgUmVtYXBwaW5nIEZhdWx0
IENvbmRpdGlvbnMgKi8NCi0tIA0KMi40NC4wDQo=

