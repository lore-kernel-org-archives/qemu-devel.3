Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B15E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNQjc-0006to-2j; Tue, 17 Dec 2024 01:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tNQjZ-0006tN-QD
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:07:06 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tNQjT-0002hl-Hr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1734415620; x=1765951620;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oqVb3EXqcjTVHCe4jMXl77IAK5QmfTFP/cTf5ZlOGmY=;
 b=qX7SkhSCgVQo/5hjPWiDkw/A4sssxAI9fGnf+7nafaa4WQW/gSgKc41g
 IfDUMeMbVjo7vHbhx265WWzJieyJp1I1C1WcZQ2COS5WonSwFeBpCioz2
 VH8dGn9W/qHvz/ja4WrxznF3YnhqX16DjDgIMuosnxEzwqZOH66Adt8Bn
 4ZVbcdaYD6Pl99hO7NFMWsAxQZofSdXFOaiKN1ivtzU1ymztaz2v14tbE
 x7lVd+Lw6h+mxUO/yTaMopy70L6C+F4FNl9z1WmQjLNl1tPFKw9HO7Y2v
 BHAqT5h/+gr8kujC4qHRcuDyQi+gKJj1PbJPp5O0UVz0vdSJDnZNkiMaV A==;
X-IronPort-AV: E=Sophos;i="6.12,240,1728943200"; d="scan'208";a="26889003"
X-MGA-submission: =?us-ascii?q?MDHYx328UckIBRivvw/QSfGGzDFhAYfFGMI6Nc?=
 =?us-ascii?q?z/z/JWPf+RcrQ/rAJfp9i0CWa5xEBIa/eHs4eUYlPCJs3amy9nOwfLz3?=
 =?us-ascii?q?PgFOyLLq2x8ajvGpxTO2pV63awwKEEWMvaAkfI8tnUKYTLCfPm8BKpix?=
 =?us-ascii?q?QehrPcYxhkJFWhc/7Z2sdw4w=3D=3D?=
Received: from mail-dbaeur03lp2174.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.174])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 07:06:32 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U740WKbo2bTn8UYonpv2SDx3Bk29tcKRJE+J1sHQXH8T0jPBvYBe7F/KBE7ZFzYnBukHBsEBoQyWMe87nq7gk2HCelnZ2EG9BvH9mWtzmbzPVC7UAb0VE4dM+ojwQfi8HshTmBIzjsVqk4vHBi5+m0YPk8/vVe0nNF9KVJnqb18rx37DKPV4oIpM2VIpCAN0VSyGSOPMG/SJTGmwLE7fCxC4Vxn0elDlsyHc6jYN22RhaoHkbfMwlNLbqqrVR1TgwpJjwsdaGBxxhWdF3Sx5GsuybpOuf5QE58udWAqO4mnoMx/G6nxt2BCJCMOydGK/7bdGQC6LpEk0sGsa6bsV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqVb3EXqcjTVHCe4jMXl77IAK5QmfTFP/cTf5ZlOGmY=;
 b=iSrnaWJA8dlXoeaiwgBFsBjC7C7x6Jt6ntMpKGBBncAZCqTc/ZBGFHIoUFM7GmmUfA5dL98Jb9nIGydot/NqdYycw6aG6q/XG0NU+8VnU4smJFNETgLesNum23qjzE55xGu+oVcPfuxKbkXsNoMRmwUBhYxEnJAtKqLOwg9GYHv2CW1dr+gBm9nyiR/2cXeMOWtTgOVeWFr6u09Vj0df3xhnHklu4PsZQyx+Ns6Lh6s3woMNo3UIhDjrdIc4p+Ke51LphJ+Ols9paCfe2Kz0548EfdgLvViKG0hhKcyWTSW0riuAQMRgxw1sO53cfKTrPBZEU7gQyrAh2AkiFt3TwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqVb3EXqcjTVHCe4jMXl77IAK5QmfTFP/cTf5ZlOGmY=;
 b=CKODYjS4QjxWFTN1qcwOzWZXarSlbtciR4u5WWY/ky9XyXnypVIEqXKejeXCx1NYVWcfS1XlKPV6qz+NRnZzVgy4VjZp+40Db86IY4gLM7ZdUe2bIO9dDSb0Ae7gSBA5Zb32pmcK5IH8QlnwnX0VDTWzGWys5dyCRd5hFnev7b6ajfKlncjsA+c5VadZ6wbotLDwPrGoBMBVderOglktSBENijfX0T/aPaJ0MkVBfIbidDPGqVPnaLF/1i6Z1ex2OWiJEyV2OCg5M4ouMBfzjXmXrEzeWwmmaIKuyxPKJ09Y7FrrDQSw5PcI2yl/6mBt7kmhbhVNWrWV1uswObwN6Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9244.eurprd07.prod.outlook.com (2603:10a6:10:44f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 06:06:29 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 06:06:29 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Jason Wang <jasowang@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Topic: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
Thread-Index: AQHbBAs1iRTF9GD7TE6TqEPFGqrCi7JrHaMAgAA1AoCAAsuVgIB7AL0AgAErh4CAAED+AA==
Date: Tue, 17 Dec 2024 06:06:29 +0000
Message-ID: <6c0db638-265c-47e6-bf62-b5573e8a78f5@eviden.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-13-zhenzhong.duan@intel.com>
 <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
 <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuXX6UE0=dNjeNJ5rHxkJADUrTG0tU1Cd1n0cvik5NnKg@mail.gmail.com>
 <SJ0PR11MB67447F79B1350833A5D878F8923B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEv1uVaqu9c6e51qUQj17MGBj78CMOtBEFVYD=KHMMUA_A@mail.gmail.com>
In-Reply-To: <CACGkMEv1uVaqu9c6e51qUQj17MGBj78CMOtBEFVYD=KHMMUA_A@mail.gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9244:EE_
x-ms-office365-filtering-correlation-id: 858d8118-2701-469a-8e60-08dd1e60f2de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NmQ5S2VpSWduTy9FMEVUMmlzS3IwZzhyQjNhTWN3T0t4Z2tRTGdqWXJjUXRT?=
 =?utf-8?B?VVQ4dEg1SCtoMU43SnUrODBiRVVCUGZkNDhYMEVvc2ZNM2ZXdytUY1ZacFVi?=
 =?utf-8?B?UUVEUUptZXA3cWg3c1FIY095ZllsYXczaVpFR3kwZmtJMUgwOUdtVDlDTzJB?=
 =?utf-8?B?S2gzNUViRFhPVVRUVUJMVGM1dVRsbm5uK0JzazgwdmpNYzRuR29pUmhjd2JN?=
 =?utf-8?B?bGFYV1djb0ozb3Q3N1N3VVlRT0x5bFVpZDN4MkNrbXNTczJTNERRNE1hcUQ5?=
 =?utf-8?B?aWFrY2xsK3JzbFFVb2ZMcFpoWk1SOFJTeExoZjRsQTFDcXBUcGVzMUt6VDFt?=
 =?utf-8?B?Nmd5V2krRElMenpRdzZrbGVYMHczVzBISGxnc1U0aTU0RS82MjJINkNBaU4z?=
 =?utf-8?B?UHliZ2o5Wjh1Zy9VTmQyWGlPekFlTjNyN0ZBbEd0STJWUVZmNlNkMHBzVGtz?=
 =?utf-8?B?c3JXVjZESCtkZ0lrTXRwRnBLMW1taTJYYzgyKyt5UDZ5SDZzcnNnclBpY2Qr?=
 =?utf-8?B?a0R4NDY0ZFJzV2VYVUdxWkkyVzJQY0FNM3g4aTVyNnVMNXFLNUQ4ODh6VXEz?=
 =?utf-8?B?Z3dXTys1WWFDQ1FTeGlsSVQ1UjI5cHdmK3NkSXJ4OWxMSHBkbk9XZUVERXMz?=
 =?utf-8?B?MXFhMVJHcVhaTXovZ0Y1SUxpM2xmdG55VC94dXRaK25IM3FYaUFidGRVRGYw?=
 =?utf-8?B?NU5OeXhMVlBkY0RrTlk0OVRGRm1vZElTY2NsUWxzVWxwTjJwckZXQlpHZFFI?=
 =?utf-8?B?TG5wVFpxWmZrOTdzbjBwSkJ5cUhISjgwZjRxSThDU21nTFF4dlgvektzbVho?=
 =?utf-8?B?M1hLQzhneDQ0cHRhMlFXcUNQaHcwR1NZVTZ2U0YyeWZUR3BlUFJMYlVKbCtt?=
 =?utf-8?B?bnV3T3FyME9NZWFBN2FuekJWWkNwWXJYQlZkSHlrWW1KT21lZjdjT3NacTdM?=
 =?utf-8?B?azlKd3NiOGgzRFh2R2MrdzJuQXBtRFh4bDF6VTF6M0ZOZ3VSVFB5UGhXbjJF?=
 =?utf-8?B?SldxUk0vRi82N2xTbHNQU0xYSXF6SDc5cHZtU0x2bElDQkJ1Z3Njb25XWlYz?=
 =?utf-8?B?STlRYWdOL1JxbFM2MGJzelFGSk5DODkwZXpzWVBoSDN2ZUd2UWduSWdUQTNS?=
 =?utf-8?B?WTJ3eUJjeG9oNDJ0enl5VG16Q3dLcTN2YXErSjBHSWJ3UzJWd2ovclBjWWs0?=
 =?utf-8?B?anlnOFZLOXYxU2xCZmtQT1AxVjdueVY4RjY5WTgxS0FnZ3UweWtZVWhyMGJF?=
 =?utf-8?B?UHR5UjUzK29qZ0ptOFZXeTBJOE9XZ0locC81Z1dUUGtaelpQT2VQSEo1Nity?=
 =?utf-8?B?MnUxNkhRZFJUaEpNcmFyVFgzZ0Y2dE1uM2tIYWFlbUlKZUF1b2wzaWdHZHhl?=
 =?utf-8?B?czJta0FXQ2Zkc3lWNXVmSUpMdmNTTjNwRVlrZlZXd0tRT0xWM016eUZJNyt5?=
 =?utf-8?B?ZGFBNGs5RkM4UTltSGh0WEJWMHpTemNmZ0ZIYmphaFQ5dDBKU1Rua1RWUGVF?=
 =?utf-8?B?TnVMNEI2ay95RHA0UmFvU0RwMFZhRENNeWdRNzdNV1NoUmp0WDU1SFBIUmVJ?=
 =?utf-8?B?SmdKOXdIS05WMmFLeFd4UzBkcnZQazVJUXEwZzNRN3hPUUJOTlVsdDluUmRM?=
 =?utf-8?B?cC9RUEdmR0R5TXluZmJHeUpRTXVGNGRvdFpDRXBWdzdpWUpORDZmNXBTNFpE?=
 =?utf-8?B?Wjd2ODN6K1JZL3BzZWd0Zk5TYnZPRFBSbU0rOWJkcU1wbS9rSVk1NjFyZ0JR?=
 =?utf-8?B?a0RQSG1DS0lxQkRGakFMem55a1hsRHFGbGxFVVVYMGZFSkQrUU9CZGkzS1Fm?=
 =?utf-8?B?UjVqdmNyczdXbitqWG1XaDdzMEZzTHNIeTYxNEhLWi9HUFVjY3E0K2d4YVc2?=
 =?utf-8?B?Qld3TzlCNmp3eWVGamZxQmw4eXJLK1NuNnlGSE1YWkFJWFNyUzNmYm5GeFVh?=
 =?utf-8?Q?5/frCSLoe+oSuv98EPjtfUdhaisPUMT8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDBuWGdvSVg2U3dDL3JoUlc5aVRrektwbjVWMnpVNTBZZlk2V0VkU0JrSWY4?=
 =?utf-8?B?dkJDTFVNSThNWEI2bTg0L0RFRnluWll3Q2tHM3p6a3JTWlhWaTJOd2hndm1S?=
 =?utf-8?B?OE03K3o5VVNyWURZV0VFMkcvem5iajBTbUxUUncwMUNEblhJY1BCcDlTaSs0?=
 =?utf-8?B?QitKYUk2UGZqNkFWdGJJWGFsZm5PY216V3dPRW5LWHlYNUg2MnRUZWZIQVlr?=
 =?utf-8?B?SVVxOVR4dTgydUx2ck1YWGc5dnozdThFZmJtbHdyRHJIaDFUNXVuZENLVDJ6?=
 =?utf-8?B?LzcvYmQ4dkhCNmhUdklxa21yUm9oZXpYWE03TG83YlpVUTRJNmZ2eUY0L3Rz?=
 =?utf-8?B?cTZJYmROTE14R2FORmRFYUdKbGxGY09USjIxNVhreUdrd3F2T3lxYlIxdllD?=
 =?utf-8?B?WklNK3ZQVHAzbG10Y01id29uMFFnMzY2dVpCZmE5TmtXaTlaMWpoOHNFbWo0?=
 =?utf-8?B?Qzh6QzUxbFZXM05nYis5M3B1RXpWbC9kNTlBRXlURHRVY2hBRDZMbnJHMXNE?=
 =?utf-8?B?azBWNkpGd0NCSWVDenRyZ0w0aHJNaHZSU29VRTVWSlM3Tm43czdkR0hXajdQ?=
 =?utf-8?B?akhjWjZMM2JtaUVwYXpiN1c5UXVqdkRGOE8xVHdIK2VRbHN4RXJ1OWNTbHZT?=
 =?utf-8?B?Z0lRTWhYZFFWbmxlZjJOeGhDSkZrenE0bkZOSzh1cVUvSlpXR09zdFhwQWt3?=
 =?utf-8?B?eEFrSU9WdkhVQjhwSHA3QlB3SGU3MlRFTUEySkVqbmVJaE9KLzhhckJoZTZh?=
 =?utf-8?B?ci9Pd09pRU1BelVwdEZsS0RiRHRWb09Cbkt2bHhpL0NKZDhDSktTTmVrTld5?=
 =?utf-8?B?LytleklhTDNJZTFLQXpEbDdUaGd2MVBqUnVUcnNuTzNlWGRHajV3SmVkTHp3?=
 =?utf-8?B?NWxLenhrVlR4VUFCQlVGR0lsbHA1TTRqUERucVlNU0U2dnFQamkybWhYR1dp?=
 =?utf-8?B?VVR4bFJpcGtneldGTG5FbFpSQldaZzZ3K1FqVTFIN3ZGYWpGckdaNkYrVElS?=
 =?utf-8?B?WHdmcE50RWlvLzdtR1IzU3N3cG5UcjNqOHU1T3hvWWlaOXVCelMvQU9KMnVu?=
 =?utf-8?B?U2ZuQ3E5WHNWdmVseUFYQlpHaGREWTdpK2dMQSs4eGg1Ym5mTnRSZE1nRFR3?=
 =?utf-8?B?K1NDeEZSZVdLblNjV01WVDNsbm5KMFdhQWRaS2lzUUtOZjREdzlvTjJTaE95?=
 =?utf-8?B?NFZNM3Nqa25YalJzLzNhdkJNUFhZdE9BUGlNeUJvaFg4WEg0dG5CMm9VYmZB?=
 =?utf-8?B?ckg2czV4N0hmUHZudGZZQ3d5V0xmTHJuaEVRakJaZmpLaEtXTXFlUmZ6aE0z?=
 =?utf-8?B?cWo0UDR0cGNENEhwcVlXTCtvTVdtV2UvV2NIRW1JV0NYK09JZ0ZxcTM2NFA3?=
 =?utf-8?B?MlhTeEN4U3hkVjVNSDIvWlorU01ISXJkMWZJV01DY3pLVmNyV3hlNzltRDhj?=
 =?utf-8?B?MFdEWTVDL2lWWWd5ZTZPMnpmaHlUa0p4NDgxWlYrUFJHMlNWME5FQmpmS0l4?=
 =?utf-8?B?eU9aM1dUZkZLZXZnaVp3bWhGVjgrVzJ6NkVSV1FXWFNoaXlwL1Q0OS9FV0hh?=
 =?utf-8?B?dzJNenhMN3h0bFFDQnBqVU1aWkp3NHZxR0xyaXRFZVRPZEhCVDcvMzREQUZt?=
 =?utf-8?B?T3FEUmVTQVFXc24yQTdDV2t1Mks4MzBkSVlsay92dmVaYW9tUmQyT2FRMTcr?=
 =?utf-8?B?VWRFUHdzSlY5R29GUWJoNnhVWEJ5ZFhoM3NQcDZiUlRlb1U1ajhxdmhzUWln?=
 =?utf-8?B?aTZQYk5YT0hKTE0veElHMEFXYUN2NHdLbzEzRnVjbWlHNDNiRnYwU2JJQmw3?=
 =?utf-8?B?aXplUWhJY2FCNGpPSnRzSStoeThUZzZnS0M0YWJIMEZoMTBrbU8ySThjY2dj?=
 =?utf-8?B?YUFEbkVrL3V3SXYxbFpTSnZTVjI3cGFLVVZYY21vWGpNRmVEZ25ZaXYySHRi?=
 =?utf-8?B?TTRwVmF3ZHVmZTMxMC80WmMzNVZkQUl5QkxmRFpua1g5a05vOStHaFI5Wmho?=
 =?utf-8?B?bTRxMkZaRVB0YmRoVU1uWE41amNWYXBOQ0J6NlBmUzU3am5rWDRCLzVoTHhr?=
 =?utf-8?B?QlNTbXRhSXFsK21WQzdqWDhwNjdYTWhQRGhKa0dCUGcrempCNUlweG5scmEz?=
 =?utf-8?B?cTRSUW1vTEZBU0NhRWdFMm9YdmYxWURWS2pib2cvVFprR3ZaOHByQVcwRDdT?=
 =?utf-8?Q?R0jnMY21L4Vnzq+NnNZXV50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <915D89E6F049A241B5126FAD83EC76D8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858d8118-2701-469a-8e60-08dd1e60f2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 06:06:29.6597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yGliVAOO3St+VZvHcHac+YfT4r/H8Eg1u5jHpLHDsOaOZSPhykm9pzNvJjZD5qQn3tfYEhz9SD1msVKjCCaXfMTRk1EQ/4wPQukiKHBKUwSIgpONo5oTEzEg7FrkbMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9244
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQoNCg0KT24gMTcvMTIvMjAyNCAwMzoxMywgSmFzb24gV2FuZyB3cm90ZToNCj4gQ2F1dGlvbjog
RXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1
bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBNb24sIERlYyAxNiwgMjAyNCBhdCA0OjIy
4oCvUE0gRHVhbiwgWmhlbnpob25nDQo+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3Rl
Og0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPj4+IFNlbnQ6IFN1bmRheSwgU2VwdGVtYmVy
IDI5LCAyMDI0IDk6NTkgQU0NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEyLzE3XSBpbnRl
bF9pb21tdTogQWRkIHN1cHBvcnQgZm9yIFBBU0lELWJhc2VkIGRldmljZQ0KPj4+IElPVExCIGlu
dmFsaWRhdGlvbg0KPj4+DQo+Pj4gT24gRnJpLCBTZXAgMjcsIDIwMjQgYXQgMzoxOOKAr1BNIER1
YW4sIFpoZW56aG9uZw0KPj4+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+
Pg0KPj4+Pg0KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZyb206IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDEyLzE3XSBpbnRlbF9pb21tdTogQWRkIHN1cHBvcnQgZm9yIFBBU0lELWJhc2VkDQo+Pj4+
PiBkZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9uDQo+Pj4+Pg0KPj4+Pj4gT24gV2VkLCBTZXAgMTEs
IDIwMjQgYXQgMToyN+KAr1BNIFpoZW56aG9uZyBEdWFuDQo+Pj4+PiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+PiBGcm9tOiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICBody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmggfCAxMSArKysrKysrKw0KPj4+Pj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5j
ICAgICAgICAgIHwgNTANCj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+Pj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+DQo+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4gYi9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4+PiBpbmRleCA0ZjJjM2E5MzUwLi41
MmJkYmYzYmM1IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaA0KPj4+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4+
IEBAIC0zNzUsNiArMzc1LDcgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7
DQo+Pj4+Pj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19XQUlUICAgICAgICAgICAgICAgMHg1IC8q
IEludmFsaWRhdGlvbiBXYWl0IERlc2NyaXB0b3INCj4+Pj4+ICovDQo+Pj4+Pj4gICAjZGVmaW5l
IFZURF9JTlZfREVTQ19QSU9UTEIgICAgICAgICAgICAgMHg2IC8qIFBBU0lELUlPVExCIEludmFs
aWRhdGUgRGVzYw0KPj4+Pj4gKi8NCj4+Pj4+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX1BDICAg
ICAgICAgICAgICAgICAweDcgLyogUEFTSUQtY2FjaGUgSW52YWxpZGF0ZSBEZXNjICovDQo+Pj4+
Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVl9QSU9UTEIgICAgICAgICAweDggLyogUEFTSUQt
YmFzZWQtRElPVExCDQo+Pj4+PiBpbnZfZGVzYyovDQo+Pj4+Pj4gICAjZGVmaW5lIFZURF9JTlZf
REVTQ19OT05FICAgICAgICAgICAgICAgMCAgIC8qIE5vdCBhbiBJbnZhbGlkYXRlIERlc2NyaXB0
b3INCj4+Pj4+ICovDQo+Pj4+Pj4gICAvKiBNYXNrcyBmb3IgSW52YWxpZGF0aW9uIFdhaXQgRGVz
Y3JpcHRvciovDQo+Pj4+Pj4gQEAgLTQxMyw2ICs0MTQsMTYgQEAgdHlwZWRlZiB1bmlvbiBWVERJ
bnZEZXNjIFZUREludkRlc2M7DQo+Pj4+Pj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0Vf
SU9UTEJfUlNWRF9ISSAweGZmZVVMTA0KPj4+Pj4+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfREVW
SUNFX0lPVExCX1JTVkRfTE8gMHhmZmZmMDAwMGZmZTBmZmY4DQo+Pj4+Pj4NCj4+Pj4+PiArLyog
TWFzayBmb3IgUEFTSUQgRGV2aWNlIElPVExCIEludmFsaWRhdGUgRGVzY3JpcHRvciAqLw0KPj4+
Pj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfQUREUih2YWwpICgo
dmFsKSAmIFwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMHhmZmZmZmZmZmZmZmZmMDAwVUxMKQ0KPj4+Pj4+ICsjZGVmaW5lIFZURF9J
TlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfU0laRSh2YWwpICgodmFsID4+IDExKSAmIDB4MSkN
Cj4+Pj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX0dMT0JBTCh2
YWwpICgodmFsKSAmIDB4MSkNCj4+Pj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVW
SUNFX0lPVExCX1NJRCh2YWwpICgoKHZhbCkgPj4gMTYpICYNCj4+Pj4+IDB4ZmZmZlVMTCkNCj4+
Pj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1BBU0lEKHZhbCkg
KCh2YWwgPj4gMzIpICYNCj4+Pj4+IDB4ZmZmZmZVTEwpDQo+Pj4+Pj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZEX0hJIDB4N2ZlVUxMDQo+Pj4+Pj4gKyNkZWZp
bmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZEX0xPDQo+Pj4+PiAweGZmZjAw
MDAwMDAwMGYwMDBVTEwNCj4+Pj4+PiArDQo+Pj4+Pj4gICAvKiBSc3ZkIGZpZWxkIG1hc2tzIGZv
ciBzcHRlICovDQo+Pj4+Pj4gICAjZGVmaW5lIFZURF9TUFRFX1NOUCAweDgwMFVMTA0KPj4+Pj4+
DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KPj4+Pj4+IGluZGV4IGQyOGM4NjI1OTguLjRjZjU2OTI0ZTEgMTAwNjQ0DQo+
Pj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+Pj4gKysrIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQo+Pj4+Pj4gQEAgLTMwMTcsNiArMzAxNyw0OSBAQCBzdGF0aWMgdm9pZA0K
Pj4+Pj4gZG9faW52YWxpZGF0ZV9kZXZpY2VfdGxiKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9h
cywNCj4+Pj4+PiAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdSgmdnRkX2Rldl9hcy0+
aW9tbXUsIDAsIGV2ZW50KTsNCj4+Pj4+PiAgIH0NCj4+Pj4+Pg0KPj4+Pj4+ICtzdGF0aWMgYm9v
bCB2dGRfcHJvY2Vzc19kZXZpY2VfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRESW52RGVz
YyAqaW52X2Rlc2MpDQo+Pj4+Pj4gK3sNCj4+Pj4+PiArICAgIHVpbnQxNl90IHNpZDsNCj4+Pj4+
PiArICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hczsNCj4+Pj4+PiArICAgIGJvb2wgc2l6
ZTsNCj4+Pj4+PiArICAgIGJvb2wgZ2xvYmFsOw0KPj4+Pj4+ICsgICAgaHdhZGRyIGFkZHI7DQo+
Pj4+Pj4gKyAgICB1aW50MzJfdCBwYXNpZDsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBpZiAoKGlu
dl9kZXNjLT5oaSAmIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUlNWRF9ISSkgfHwN
Cj4+Pj4+PiArICAgICAgICAgKGludl9kZXNjLT5sbyAmIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJ
Q0VfSU9UTEJfUlNWRF9MTykpIHsNCj4+Pj4+PiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgi
JXM6IGludmFsaWQgcGFzaWQtYmFzZWQgZGV2IGlvdGxiIGludiBkZXNjOiINCj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAiaGk9JSJQUkl4NjQgIihyZXNlcnZlZCBub256ZXJvKSIs
DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGludl9kZXNjLT5o
aSk7DQo+Pj4+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+Pj4+ICsgICAgfQ0KPj4+Pj4+
ICsNCj4+Pj4+PiArICAgIGdsb2JhbCA9IFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJf
R0xPQkFMKGludl9kZXNjLT5oaSk7DQo+Pj4+Pj4gKyAgICBzaXplID0gVlREX0lOVl9ERVNDX1BB
U0lEX0RFVklDRV9JT1RMQl9TSVpFKGludl9kZXNjLT5oaSk7DQo+Pj4+Pj4gKyAgICBhZGRyID0g
VlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9BRERSKGludl9kZXNjLT5oaSk7DQo+Pj4+
Pj4gKyAgICBzaWQgPSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1NJRChpbnZfZGVz
Yy0+bG8pOw0KPj4+Pj4+ICsgICAgaWYgKGdsb2JhbCkgew0KPj4+Pj4+ICsgICAgICAgIFFMSVNU
X0ZPUkVBQ0godnRkX2Rldl9hcywgJnMtPnZ0ZF9hc193aXRoX25vdGlmaWVycywgbmV4dCkgew0K
Pj4+Pj4+ICsgICAgICAgICAgICBpZiAoKHZ0ZF9kZXZfYXMtPnBhc2lkICE9IFBDSV9OT19QQVNJ
RCkgJiYNCj4+Pj4+PiArICAgICAgICAgICAgICAgIChQQ0lfQlVJTERfQkRGKHBjaV9idXNfbnVt
KHZ0ZF9kZXZfYXMtPmJ1cyksDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2dGRfZGV2X2FzLT5kZXZmbikgPT0gc2lkKSkgew0KPj4+Pj4+ICsgICAg
ICAgICAgICAgICAgZG9faW52YWxpZGF0ZV9kZXZpY2VfdGxiKHZ0ZF9kZXZfYXMsIHNpemUsIGFk
ZHIpOw0KPj4+Pj4+ICsgICAgICAgICAgICB9DQo+Pj4+Pj4gKyAgICAgICAgfQ0KPj4+Pj4+ICsg
ICAgfSBlbHNlIHsNCj4+Pj4+PiArICAgICAgICBwYXNpZCA9IFZURF9JTlZfREVTQ19QQVNJRF9E
RVZJQ0VfSU9UTEJfUEFTSUQoaW52X2Rlc2MtPmxvKTsNCj4+Pj4+PiArICAgICAgICB2dGRfZGV2
X2FzID0gdnRkX2dldF9hc19ieV9zaWRfYW5kX3Bhc2lkKHMsIHNpZCwgcGFzaWQpOw0KPj4+Pj4+
ICsgICAgICAgIGlmICghdnRkX2Rldl9hcykgew0KPj4+Pj4+ICsgICAgICAgICAgICByZXR1cm4g
dHJ1ZTsNCj4+Pj4+PiArICAgICAgICB9DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgICAgIGRvX2lu
dmFsaWRhdGVfZGV2aWNlX3RsYih2dGRfZGV2X2FzLCBzaXplLCBhZGRyKTsNCj4+Pj4+IFF1ZXN0
aW9uOg0KPj4+Pj4NCj4+Pj4+IEkgd29uZGVyIGlmIGN1cnJlbnQgdmhvc3QgKHdoaWNoIGhhcyBh
IGRldmljZSBJT1RMQiBhYnN0cmFjdGlvbiB2aWENCj4+Pj4+IHZpcnRpby1wY2kpIGNhbiB3b3Jr
IHdpdGggdGhpcyAoUEFTSUQgYmFzZWQgSU9UTEIgaW52YWxpZGF0aW9uKQ0KPj4+PiBDdXJyZW50
bHksIGl0IGRlcGVuZHMgb24gaWYgY2FjaGluZy1tb2RlIGlzIG9uLiBJZiBpdCdzIG9mZiwgdmhv
c3Qgd29ya3MuIEUuZy46DQo+Pj4+DQo+Pj4+IC1kZXZpY2UgaW50ZWwtaW9tbXUsY2FjaGluZy1t
b2RlPW9mZixkbWEtZHJhaW49b24sZGV2aWNlLWlvdGxiPW9uLHgtDQo+Pj4gc2NhbGFibGUtbW9k
ZT1vbg0KPj4+PiAtbmV0ZGV2IHRhcCxpZD10YXAwLHZob3N0PW9uLHNjcmlwdD0vZXRjL3FlbXUt
aWZ1cA0KPj4+PiAtZGV2aWNlIHZpcnRpby1uZXQtcGNpLG5ldGRldj10YXAwLGJ1cz1yb290MCxp
b21tdV9wbGF0Zm9ybT1vbixhdHM9b24NCj4+Pj4NCj4+Pj4gSXQgZG9lc24ndCB3b3JrIGN1cnJl
bnRseSB3aGVuIGNhY2hpbmctbW9kZSBpcyBvbi4NCj4+Pj4gUmVhc29uIGlzIGxpbnV4IGtlcm5l
bCBoYXMgYW4gb3B0aW1pemF0aW9uIHRvIHNlbmQgb25seSBwaW90bGIgaW52YWxpZGF0aW9uLA0K
Pj4+PiBubyBkZXZpY2UtcGlvdGxiIGludmFsaWRhdGlvbiBpcyBzZW50LiBCdXQgSSBoZWFyZCBm
cm9tIFlpIHRoZSBvcHRpbWl6YXRpb24NCj4+Pj4gd2lsbCBiZSBkcm9wcGVkLCB0aGVuIGl0IHdp
bGwgd29yayB0b28gd2hlbiBjYWNoaW5nLW1vZGUgaXMgb24uDQo+Pj4gR3JlYXQsIGlmIHBvc3Np
YmxlIHBsZWFzZSBjb3B5IG1lIHdoZW4gc2VuZGluZyB0aG9zZSBmaXhlcy4NCj4+IEZZSSwgSSBq
dXN0IGZvdW5kIHRoZSBvcHRpbWl6YXRpb24gaGFkIGFscmVhZHkgYmVlbiBkcm9wcGVkIHNpbmNl
IEFwcmlsIDIwMjQgYnkgY29tbWl0IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTMwNGIzYmRlMjRiNTg1
MTVhNzVmZDE5OGJlYjUyY2E1N2RmNjI3NWYNCj4+DQo+PiBBZnRlciB1cGRhdGluZyBndWVzdCBr
ZXJuZWwgdG8gYSBuZXcgdmVyc2lvbiBjb250YWluaW5nIGFib3ZlIGNvbW1pdCwNCj4+IHZob3N0
IHdvcmtzIGlycmVzcGVjdGl2ZSB0aGUgdmFsdWUgb2YgY2FjaGluZy1tb2RlLg0KPj4NCj4+IFRo
YW5rcw0KPj4gWmhlbnpob25nDQo+IEdyZWF0LiBUaGFua3MgZm9yIHRoZSB1cGRhdGluZy4NCg0K
R29vZCBuZXdzLA0KVGhhbmtzIFpoZW56aG9uZyENCg0KDQo=

