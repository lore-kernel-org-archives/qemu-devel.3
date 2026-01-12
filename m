Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5E5C9EC9B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKbO-00009D-2L; Mon, 12 Jan 2026 11:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfKbF-00005h-VI; Mon, 12 Jan 2026 11:17:07 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfKbD-000799-CQ; Mon, 12 Jan 2026 11:17:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybTj8NlWWOuUAYb9Lwtz+M+gMphL1iHQetdTsIY6NeEV59kb6002ZNGoSK59hyutaJPNir5TQupKgHVYRu+ygPfgV4GAhfA0X64ewrgbWfoQ09G6U52pezL/Gi9x7tPJEMJDpNtNxFd9Q7p2jGZ+FK5jlrFm/GyG3NJ0aIlVrUQs48YBs0ZEuJIOuLlxzDjMnGsEvUU8aohd3sw0P8MOEjwiBKFAskC2PVVwbC5Axb43/pO4AKzMArM6OBZClfdexXxqrKImVsGGGfoIDTd3DWBWTLnMeKHo+sRFnoDdLrmvHZ0GHa6yx4r3cs/oeuiijxPHA4SmNssWzU7IjvEYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19Jo+Dxx1EpHibAhC9GNEw7dDKGZz0bk4XPL56jGnPQ=;
 b=gALc6rJOVNLwPaPexj0E7wkZWSFtTu6ghe1zrlgEUS+L3iwspw7wCJLFuULcFMl70LAFFdQZVbrEKTvBj3CDDZtNBR9z/ApNnJG7OgLKUrfOUYApuhJeBD1gCWLg13APQBzwxKXIGRO/9ztRkVUHOWH/yivzkN1PM2F+ZDPuCjPqaDSsOh+IxDd+BfHNONMbH0KVaBnlCS5jH5igK7j2jn4M4Pc1+VaeBtcpVDIMfCkVepWaA4SNeoBIY5F9DYcL0ME4uP+NbQHvti3cxOOmO2sF15QFcUF9hXP9aJcPFK3ZaM8B+inBlKfz2RhPDjXF677/5c4mMjbyXUAnK9RUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19Jo+Dxx1EpHibAhC9GNEw7dDKGZz0bk4XPL56jGnPQ=;
 b=A4/xh6xWOij3/ugC3j5w4fB1ymzLOwl+4LdiLqLoXJvFU42OE2lnZPnIqLXOu/fkLz96IPB4K6dRYgeep/OC7+PQIcoHweVJQBW/5imqYyG71eI7DwZzxxz42Z8LJWJjV2ByZHknVJntszjcVMV/T/IzqyuiQPof9HXCZuAdIsPgcMhE513aB4Elpkm1OHbhUhVZijGviRhEuyUG1MK/Xn0GsYQSX3lleepE/2p8hPhKPy0bhEacaCLa90uewGgkUpPft36hRHLmRJ+g2uaz+quPRhN5q/uknltUiiX7N9kuXz3iU3h+Oe9ZNx1HjrFcjWl4kKZpd7FfhjWDCPTrMA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:16:50 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:16:49 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc0r/PShlE7i9HkafE8JAYPcnrrVIH1QAgAAPWOCAAf8BgIAEp0AA
Date: Mon, 12 Jan 2026 16:16:49 +0000
Message-ID: <CH3PR12MB75482D2914436617438F2522AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <d40cc8da-4003-4a40-b0de-32c79cbe6faa@redhat.com>
In-Reply-To: <d40cc8da-4003-4a40-b0de-32c79cbe6faa@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB9240:EE_
x-ms-office365-filtering-correlation-id: 2a8a05bc-499c-488d-f0ce-08de51f5fdab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?akRaUEdPSTdIVE1pTytNSzJUWHV1bFFZNFdvbU1PVXhmM1MwVjVCSC9hNUdT?=
 =?utf-8?B?dU94RlpGTnlIV3pxUVY5WjFpbHlEUy9HYTFqS2NTSk1neFhqUDg1WGVMOXAr?=
 =?utf-8?B?NS9uM3RsVGtsMzJHeVBxY3JDVGtCVDk3Y1gwNnpBWkZTRXVpWkZxcGx2eng2?=
 =?utf-8?B?VFpqdmRTWVZHMkF6c1hTVGYxZDNUdHRLK0dxdmpTUGUrQ0dJK1NTbVdFTVg0?=
 =?utf-8?B?eUxseFdvV05lSWRqU25BbjNZVFRVOVZwY3JTZlhzSDVqYml0dFp3MmNTbHBi?=
 =?utf-8?B?dzBkRHpUTVVUeDN5WGNzeE4zR3VvL29vVjd2S01HeXVNSE1OQTdlOFpGci9a?=
 =?utf-8?B?SjRBWWptOFIwdHRrZmpsTEgxNFhqNGtRZzMzWXp2bTRRZG1LcUxQcEJMTVZI?=
 =?utf-8?B?cVErdWZSQURUWU5vWlFTbXZoYkNGWGdwUGdBT0NReWtLRlBsRnVidlhleHRW?=
 =?utf-8?B?NDV1WGsxZEpZTEdBMDBkYm1QTHZyekh3aEoyOXFLbHhEcGZDd2xWMEtjMFBz?=
 =?utf-8?B?cU5Tb0JRa1J1RVpqeUJBekxLYWhLUGJQZUlmbSs1WllFcUpZRkVQcmJzUjEx?=
 =?utf-8?B?MzdHZndNNlh3TmNhclVKdUFnZThEOU51NFcvK20vendOeGFiRWpNZmMrM3Zq?=
 =?utf-8?B?MW5FZ2FlWG5ETEpUcFhiaERHdG1BcE5XRG5xcGFEL284VVpjWmc5aVhUM0Z1?=
 =?utf-8?B?ZHU1S2RMdHBldXJPSHY5bmp2Rmx4NUNhUDJuQ1ZqOGoxdE5jSFR4Zyswb3hG?=
 =?utf-8?B?Qk1PU2lNN1lQU1ZDakFEaDdSVWJZRTlMbVM2SDY2TkFYUS80TmNEWmpBSFdq?=
 =?utf-8?B?U3I3UHExWW4xcFQ4OVlEYXhlRUdHeENhL09sT1RYNGhoRVFtSU9id1hyQno2?=
 =?utf-8?B?SzE1TlBjeEd2b2NTMnRGNjk2eFNKUXU4VGRHRFQxZVVSS1B0WnN1Q2FWN1Js?=
 =?utf-8?B?MUpzTmZQSmNmMXNUNXFIc3M5T2lnVXNVUHlBelBuWHpCTWM4aWpBV1VPN0ll?=
 =?utf-8?B?aXhrMG1FbUpNSDVwSHp0RVd4ZExodDNZQ1J2aUpRR0xqWlJ5TnNxUnRDM0lH?=
 =?utf-8?B?ZE1QZ0Q3L3dhR1FMM0E2bGhJbHQ2a1BadThDWUlGMk5oU3FnSWh6Tmpud3Rl?=
 =?utf-8?B?cmtxZkRBTmxaQ3h1dFNEZnUvZ21WVDlPOXNKVDJaVk1pd3I5M2VIT096THh6?=
 =?utf-8?B?ajhHdmFSZHdyaXhlckEyTVcxZkd6Qm9uL292UTdCOUVPSG1VMEhtQUM4cUFY?=
 =?utf-8?B?UXFCNm1UNzRRWHZhQVpTNC9GV001U1cvSnZ5SnYzYitBbWpvVGpLYVFDVmlE?=
 =?utf-8?B?bEU2cmd4dXU5QWZqa29rb0Qwa1dYOFF5NjJRYlBiZXUzc2xsZGJ6aFM1VUEr?=
 =?utf-8?B?ZENWRmIyM3ZLL0FDRWRRMjJJQ0JNUHlDSHBHMUFtcXhHTnMvZEpva1lSYVVU?=
 =?utf-8?B?TS85YmpuRUUyR0crWHZWOGlKWDNNZzdvNnZrV2VOSE51NWdDcDVOT2R1RzJ3?=
 =?utf-8?B?YnpvczA3dG1JTkJTZHc2Y3NGOXFkdUVHamtmRFE1djBKVG1Hdi9ZeUF5bVA3?=
 =?utf-8?B?cXRDSkJCc0s4b1dpSVUwSVlpM3Q0NXRkcWtyaXE3RVZVcnhlSDFERzNPaEdt?=
 =?utf-8?B?dkxqci8rWEwrekEyUkRjUVhkcGdGQzBYZkFlR0FnZHZ2aVVFNHlnSTZ6ZlpM?=
 =?utf-8?B?ZE5MUHZuTkhKcTZBd3pFbTdlRTNsMFIyaklhY3o5NXJsdDZ0aWlHOVlsTnVl?=
 =?utf-8?B?VXROazFFbEYyaG80UWtNSDB6alREOFZBQXZOc1BqaWFlVjM0dG5rUUU4bjI1?=
 =?utf-8?B?RHFwM051OVdZR09ld1EyTUhaMTBBemM2YWwxSXB2Y0Qwc1J2S1JVVlFEVGxL?=
 =?utf-8?B?MzFuTExxdC9WaEtjR09nUjZVZGZ2YzhqZjRaME5DbVRJV0txQnJpSm5qSk5M?=
 =?utf-8?B?VW8yc1RMTFBSMmZLaVlTQlc0Q0U1QWgrcW9idnpZVFYrYWVtZlp4WTM0d3Fw?=
 =?utf-8?B?NDBzNTNVK2V4ZmQxa0ZlWlFPSUNrM1NzWnYwQlpLeUt4SlZkZmtmdjFnM1RM?=
 =?utf-8?Q?q1UMYZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekFqYm9HRjJ6Z1o1ME5adU9JdUNqaHdVZkNPalpLZWF4QzFpZlpoVTZUOXp5?=
 =?utf-8?B?VEtyWU81Y3FYTE5ZUk4wei90M29MNU5qMjcyMm9XOEJLN096OFZFd2xFT24y?=
 =?utf-8?B?dVJvRmoxNDM3emdua1p5UmZFMzBjdUxVRWl6OE12MFJ3Y3JTZ1RVVnpTT3dK?=
 =?utf-8?B?anJnOTBqbDNlN0o4UEducFdFSWlyTVhyRWtWcU5lcVNhOERaOHhxZGlSYjYv?=
 =?utf-8?B?MVZXUW50ZTM4YjBzMFFtbDQ4WURZUVNmc3lueVFNTFY5OFVrcC8yK0tneGtT?=
 =?utf-8?B?Q3VrNTVJallkTjBCQVhpcnlUQXQ5TkFHNmY3R2x0eTZCRXZkK24ydkt0OWNv?=
 =?utf-8?B?R2hzRUFvVnRxeWhZczQ3UGJlS0dpM0I0WDRHUkRrbmF2MGpmRmJTbjhuTy9a?=
 =?utf-8?B?YUEzTC9jREJ0Z3hZTktza1BNQVZVSE9wdVVlWnc0MjIxblV2Z21uRlZkTXpL?=
 =?utf-8?B?Wlpod3pXaUNuMWJud3RkNzd1b3VkNEhsWWttTDU5cld1TjJJNlJYdWpPR0w2?=
 =?utf-8?B?Ykl0L3N0OUx1dk9uYWF5N2diZ05qWFVKeTZJTEQ5MjNKVE9xQlFKYllXZUhI?=
 =?utf-8?B?VElQMmxoWEdKcGZNQ3pocDFWTTR4anIvaUh4SE8xa2JaNDBQcXY5SjVVbGla?=
 =?utf-8?B?eEtEcnIwOXBwellDMVlIVnNQWnU2V1RTOXdrc0NKY21GUzJiL1lvMDhnOHZy?=
 =?utf-8?B?SFJ4WTFZN1l6QmtTdVN5QWozVFZhcldhUWZnTzlBc3BoOU1odW5DSUlEZGdq?=
 =?utf-8?B?N2xXTEVDdVQ4SzBGU2w0dURwTzFqM2FkWnNIWnR0aU5qQ3k1S0FSYU82UXJs?=
 =?utf-8?B?d2NXdytWMU90TTRxeFJ4ZXQzZXM4TXlVckprbTd1aHZyYkRMMFJnTGZRK1FJ?=
 =?utf-8?B?by94OHgzYW55UlFYaVBQL0Q4UkNXWHluRzJNM2FOdkxvSTU3ckFSREt4Mkg1?=
 =?utf-8?B?M0UwbUJGVklFa2tzeFlJbGt3UG4xVldGaHFHYlJvOHJZaWtOVjV6YUMvVGpG?=
 =?utf-8?B?NVNRNkR0UGU1eXVyUXBHNzZkeDFpWnVEMVRKNUVPNXhkaU5OeitVblR3bFQx?=
 =?utf-8?B?d3BLYTZ5K1BaMHpkQUNqV2VMeWtaUWF3ZWtzdDVGU0xIQ2hCZCt1SkhrNXVh?=
 =?utf-8?B?MnNCazY5Qmw2aGYvdzZKQWxLdDBrL3BsNno1OE41RTR5OTIvK2VWMFlwYjVn?=
 =?utf-8?B?SnJYTkZxNFpIMUh0bm9QZ3pUK3MrMndjSzliaXZiS1JsNXBFclRrVUdoNGJP?=
 =?utf-8?B?UWZSbEhBWG1NbVpQeFFSR1l0elAzbmdCNHIxMVhqcWpQQzhsSXhnMDZzRmlK?=
 =?utf-8?B?NVk2anZqNys5SngvZE43ZUNWbDNoKzNDamZPVGMrNHoxTm1GTGRWSURZNmIw?=
 =?utf-8?B?WTVIWmhLc0Vad2xvUHNGQ3l1T2pUL1crYU0zWTY3OXVXS0tGWGszc2FXcFhJ?=
 =?utf-8?B?TDBzS0F5aXRGOVZTcWpHSm5kOVVpbWNGK3A3eFVUK0o3Mkx6a3VzcUhZZHVW?=
 =?utf-8?B?WDhYaEhlRFlLOWQ0N3BQOEd5QmpGVE1laXN3SDduNFN1b2lSUndiTUlyc3o5?=
 =?utf-8?B?QXZwaCt4clFiWHpzaU5ISm5JK1RXTFpsUGlTK29kK0Y0L21EZzFKQTdhRDgy?=
 =?utf-8?B?dXRjLzNZek11djFqaVhiMzhOUlJFUmV4REoyVVJqRDRqZzlKbDlOMm9DelpW?=
 =?utf-8?B?RU1MbURWUy9NQSs5OWlHZk0wUEl2TEJMT1FGNDU3Qi81K2xBem1ZNmp0aGtX?=
 =?utf-8?B?QUtlTWxoRWg4dUszdFk4RUJnaGRsU25PUnNQZGs2M1FqT1dLRXMvc1BCclR4?=
 =?utf-8?B?R0VmUjRHU3F4Vy8yamJ6UWo1cWZHMVR1YUhKaTRSN2hrNTY2ZGVZWXpFUnlR?=
 =?utf-8?B?Sm9DUXZaV01HMGNENlBzRXBtRnVOcU95VDJqR0dvblE5Q0h6S2laa003bWRn?=
 =?utf-8?B?QXNRSUhNS1NTaGpFdTZFS3NoNkNONjlzaDRRT2ZTYzFpSXNQOVhZb2lOeFdW?=
 =?utf-8?B?cHZ1QTQ4YnJZM0Z6RVJKellJY2hUaTFTOVgzdFo4QUxWN2xFamNGdTd2STJT?=
 =?utf-8?B?NnVYcXorTmxWa3ErNjdGbDJOZFBMbFB3OThxcDlsZ3VRUksvcUlZU2JGOUMv?=
 =?utf-8?B?V0h5Y3dKQUNJSjlzdWhzaEZGaHVXaGdSQXhNeVFIYmtsK1M5UTQrNDJCblFN?=
 =?utf-8?B?TTlyQjlZd3BjTUxVbFdQaUhKanJPV2JkU3dYaDJBL1luZVp5TUdMOWNxSDB6?=
 =?utf-8?B?SW1MbC9ySzY3RkxtWlArSzBoSE5oVWR2OG1vd05iMEt6UC9tUnFNR0NZdEhD?=
 =?utf-8?B?bFJZYUwyRjVzc0pHa1BWb3VtYkJGZnlPcVBFNVgxbi9wNExIa21oUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8a05bc-499c-488d-f0ce-08de51f5fdab
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 16:16:49.7815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gABty5RD0bbBHhocqZlANgPifjiAjUXS0pSHc/JpAILGUovzsObraPLVpd8TEtDNVkzcY8JrqaA8KLC3BFT2JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA5IEphbnVhcnkgMjAyNiAx
NzowNQ0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBE
dWFuLCBaaGVuemhvbmcNCj4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IHFlbXUtYXJtQG5v
bmdudS5vcmc7IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsgY29odWNrQHJlZGhhdC5jb207DQo+IG1zdEByZWRo
YXQuY29tOyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbg0K
PiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmFz
b24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IEtyaXNobmFrYW50IEphanUgPGtqYWp1
QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBody92ZmlvL3JlZ2lvbjog
Q3JlYXRlIGRtYWJ1ZiBmb3IgUENJIEJBUiBwZXINCj4gcmVnaW9uDQo+IA0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IE9uIDEvOC8yNiAxMjowNCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IER1YW4sIFpoZW56aG9uZyA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPiA+PiBTZW50OiAwOCBKYW51YXJ5IDIwMjYgMDk6
NDENCj4gPj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsg
cWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7DQo+ID4+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+
PiBDYzogZXJpYy5hdWdlckByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBjbGdAcmVkaGF0
LmNvbTsNCj4gPj4gY29odWNrQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOyBOaWNvbGluIENo
ZW4NCj4gPj4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0Budmlk
aWEuY29tPjsgTWF0dCBPY2hzDQo+ID4+IDxtb2Noc0BudmlkaWEuY29tPjsgSmFzb24gR3VudGhv
cnBlIDxqZ2dAbnZpZGlhLmNvbT47IEtyaXNobmFrYW50DQo+ID4+IEphanUgPGtqYWp1QG52aWRp
YS5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBody92ZmlvL3JlZ2lvbjogQ3Jl
YXRlIGRtYWJ1ZiBmb3IgUENJIEJBUg0KPiA+PiBwZXIgcmVnaW9uDQo+ID4+DQo+ID4+IEV4dGVy
bmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4+
DQo+ID4+DQo+ID4+IE9uIDEyLzIyLzIwMjUgOTo1MyBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90
ZToNCj4gPj4+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPj4+
DQo+ID4+PiBMaW51eCBub3cgcHJvdmlkZXMgYSBWRklPIGRtYWJ1ZiBleHBvcnRlciB0byBleHBv
c2UgUENJIEJBUiBtZW1vcnkNCj4gPj4+IGZvciBQMlAgdXNlIGNhc2VzLiBDcmVhdGUgYSBkbWFi
dWYgZm9yIGVhY2ggbWFwcGVkIEJBUiByZWdpb24gYWZ0ZXINCj4gPj4+IHRoZSBtbWFwIGlzIHNl
dCB1cCwgYW5kIHN0b3JlIHRoZSByZXR1cm5lZCBmZCBpbiB0aGUgcmVnaW9u4oCZcyBSQU1CbG9j
ay4NCj4gPj4+IFRoaXMgYWxsb3dzIFFFTVUgdG8gcGFzcyB0aGUgZmQgdG8gZG1hX21hcF9maWxl
KCksIGVuYWJsaW5nIGlvbW11ZmQNCj4gPj4+IHRvIGltcG9ydCB0aGUgZG1hYnVmIGFuZCBtYXAg
dGhlIEJBUiBjb3JyZWN0bHkgaW4gdGhlIGhvc3QgSU9NTVUNCj4gPj4+IHBhZ2UNCj4gPj4gdGFi
bGUuDQo+ID4+Pg0KPiA+Pj4gSWYgdGhlIGtlcm5lbCBsYWNrcyBzdXBwb3J0IG9yIGRtYWJ1ZiBz
ZXR1cCBmYWlscywgUUVNVSBza2lwcyB0aGUNCj4gPj4+IHNldHVwIGFuZCBjb250aW51ZXMgd2l0
aCBub3JtYWwgbW1hcCBoYW5kbGluZy4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNv
bGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBTaGFt
ZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4g
ICAgaHcvdmZpby9yZWdpb24uYyAgICAgfCA1Nw0KPiA+PiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiA+Pj4gICAgaHcvdmZpby90cmFjZS1ldmVudHMgfCAg
MSArDQo+ID4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9yZWdpb24uYyBiL2h3L3Zm
aW8vcmVnaW9uLmMgaW5kZXgNCj4gPj4+IGIxNjVhYjBiOTMuLjY5NDlmNjc3OWMgMTAwNjQ0DQo+
ID4+PiAtLS0gYS9ody92ZmlvL3JlZ2lvbi5jDQo+ID4+PiArKysgYi9ody92ZmlvL3JlZ2lvbi5j
DQo+ID4+PiBAQCAtMjksNiArMjksNyBAQA0KPiA+Pj4gICAgI2luY2x1ZGUgInFlbXUvZXJyb3It
cmVwb3J0LmgiDQo+ID4+PiAgICAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0KPiA+Pj4gICAgI2lu
Y2x1ZGUgIm1vbml0b3IvbW9uaXRvci5oIg0KPiA+Pj4gKyNpbmNsdWRlICJzeXN0ZW0vcmFtYmxv
Y2suaCINCj4gPj4+ICAgICNpbmNsdWRlICJ2ZmlvLWhlbHBlcnMuaCINCj4gPj4+DQo+ID4+PiAg
ICAvKg0KPiA+Pj4gQEAgLTIzOCwxMyArMjM5LDUyIEBAIHN0YXRpYyB2b2lkIHZmaW9fc3VicmVn
aW9uX3VubWFwKFZGSU9SZWdpb24NCj4gPj4gKnJlZ2lvbiwgaW50IGluZGV4KQ0KPiA+Pj4gICAg
ICAgIHJlZ2lvbi0+bW1hcHNbaW5kZXhdLm1tYXAgPSBOVUxMOw0KPiA+Pj4gICAgfQ0KPiA+Pj4N
Cj4gPj4+ICtzdGF0aWMgaW50IHZmaW9fcmVnaW9uX2NyZWF0ZV9kbWFfYnVmKFZGSU9SZWdpb24g
KnJlZ2lvbikgew0KPiA+Pj4gKyAgICBnX2F1dG9mcmVlIHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0
dXJlICpmZWF0dXJlID0gTlVMTDsNCj4gPj4+ICsgICAgVkZJT0RldmljZSAqdmJhc2VkZXYgPSBy
ZWdpb24tPnZiYXNlZGV2Ow0KPiA+Pj4gKyAgICBzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9k
bWFfYnVmICpkbWFfYnVmOw0KPiA+Pj4gKyAgICBzaXplX3QgdG90YWxfc2l6ZTsNCj4gPj4+ICsg
ICAgaW50IGksIHJldDsNCj4gPj4+ICsNCj4gPj4+ICsgICAgZ19hc3NlcnQocmVnaW9uLT5ucl9t
bWFwcyk7DQo+ID4+PiArDQo+ID4+PiArICAgIHRvdGFsX3NpemUgPSBzaXplb2YoKmZlYXR1cmUp
ICsgc2l6ZW9mKCpkbWFfYnVmKSArDQo+ID4+PiArICAgICAgICAgICAgICAgICBzaXplb2Yoc3Ry
dWN0IHZmaW9fcmVnaW9uX2RtYV9yYW5nZSkgKiByZWdpb24tPm5yX21tYXBzOw0KPiA+Pj4gKyAg
ICBmZWF0dXJlID0gZ19tYWxsb2MwKHRvdGFsX3NpemUpOw0KPiA+Pj4gKyAgICAqZmVhdHVyZSA9
IChzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZSkgew0KPiA+Pj4gKyAgICAgICAgLmFyZ3N6ID0g
dG90YWxfc2l6ZSwNCj4gPj4+ICsgICAgICAgIC5mbGFncyA9IFZGSU9fREVWSUNFX0ZFQVRVUkVf
R0VUIHwNCj4gPj4gVkZJT19ERVZJQ0VfRkVBVFVSRV9ETUFfQlVGLA0KPiA+Pj4gKyAgICB9Ow0K
PiA+Pj4gKw0KPiA+Pj4gKyAgICBkbWFfYnVmID0gKHZvaWQgKilmZWF0dXJlLT5kYXRhOw0KPiA+
Pj4gKyAgICAqZG1hX2J1ZiA9IChzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9kbWFfYnVmKSB7
DQo+ID4+PiArICAgICAgICAucmVnaW9uX2luZGV4ID0gcmVnaW9uLT5uciwNCj4gPj4+ICsgICAg
ICAgIC5vcGVuX2ZsYWdzID0gT19SRFdSLA0KPiA+Pj4gKyAgICAgICAgLm5yX3JhbmdlcyA9IHJl
Z2lvbi0+bnJfbW1hcHMsDQo+ID4+PiArICAgIH07DQo+ID4+PiArDQo+ID4+PiArICAgIGZvciAo
aSA9IDA7IGkgPCByZWdpb24tPm5yX21tYXBzOyBpKyspIHsNCj4gPj4+ICsgICAgICAgIGRtYV9i
dWYtPmRtYV9yYW5nZXNbaV0ub2Zmc2V0ID0gcmVnaW9uLT5tbWFwc1tpXS5vZmZzZXQ7DQo+ID4+
PiArICAgICAgICBkbWFfYnVmLT5kbWFfcmFuZ2VzW2ldLmxlbmd0aCA9IHJlZ2lvbi0+bW1hcHNb
aV0uc2l6ZTsNCj4gPj4+ICsgICAgfQ0KPiA+Pj4gKw0KPiA+Pj4gKyAgICByZXQgPSB2YmFzZWRl
di0+aW9fb3BzLT5kZXZpY2VfZmVhdHVyZSh2YmFzZWRldiwgZmVhdHVyZSk7DQo+ID4+DQo+ID4+
IHZiYXNlZGV2LT5pb19vcHMtPmRldmljZV9mZWF0dXJlIG1heSBiZSBOVUxMIGZvciBvdGhlciBi
YWNrZW5kIGxpa2UNCj4gPj4gdmJhc2VkZXYtPnZmaW8tDQo+ID4+IHVzZXIuDQo+ID4NCj4gPiBB
aC4uT2suIEkgd2lsbCBhZGQgYSBjaGVjay4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgYWRkIGEg
Z2xvYmFsIHJvdXRpbmUgOg0KPiANCj4gICAgaW50IHZmaW9fZGV2aWNlX2dldF9mZWF0dXJlKFZG
SU9EZXZpY2UgKnZiYXNlZGV2LCBzdHJ1Y3QNCj4gdmZpb19kZXZpY2VfZmVhdHVyZSAqZmVhdHVy
ZSkNCg0KT2suDQoNCj4gDQo+IA0KPiA+DQo+ID4+DQo+ID4+PiArICAgIGZvciAoaSA9IDA7IGkg
PCByZWdpb24tPm5yX21tYXBzOyBpKyspIHsNCj4gPj4+ICsgICAgICAgIHRyYWNlX3ZmaW9fcmVn
aW9uX2RtYWJ1ZihyZWdpb24tPnZiYXNlZGV2LT5uYW1lLCByZXQsIHJlZ2lvbi0+bnIsDQo+ID4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnaW9uLT5tZW0tPm5hbWUsIHJl
Z2lvbi0+bW1hcHNbaV0ub2Zmc2V0LA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJlZ2lvbi0+bW1hcHNbaV0uc2l6ZSk7DQo+ID4+PiArICAgIH0NCj4gPj4+ICsgICAg
cmV0dXJuIHJldDsNCj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiAgICBpbnQgdmZpb19yZWdpb25f
bW1hcChWRklPUmVnaW9uICpyZWdpb24pDQo+ID4+PiAgICB7DQo+ID4+PiAgICAgICAgaW50IGks
IHJldCwgcHJvdCA9IDA7DQo+ID4+PiAgICAgICAgY2hhciAqbmFtZTsNCj4gPj4+ICAgICAgICBp
bnQgZmQ7DQo+ID4+Pg0KPiA+Pj4gLSAgICBpZiAoIXJlZ2lvbi0+bWVtKSB7DQo+ID4+PiArICAg
IGlmICghcmVnaW9uLT5tZW0gfHwgIXJlZ2lvbi0+bnJfbW1hcHMpIHsNCj4gPj4NCj4gPj4gSnVz
dCBjdXJpb3VzLCB3aGVuIHdpbGwgYWJvdmUgY2hlY2sgcmV0dXJuIHRydWU/DQo+ID4gSSB0aGlu
ayBgIXJlZ2lvbi0+bWVtYCBjb3ZlcnMgY2FzZXMgd2hlcmUgbm8gTWVtb3J5UmVnaW9uIHdhcyBj
cmVhdGVkDQo+ID4gKGUuZy4gemVybyBzaXplZCByZWdpb25zKS4gIEFuZCBucl9tbWFwcyBjaGVj
a3MgcmVnaW9ucyB3aXRoIG1tYXANCj4gPiBzdXBwb3J0IGV4aXN0cyAoVkZJT19SRUdJT05fSU5G
T19GTEFHX01NQVAvIF9DQVBfU1BBUlNFX01NQVApLg0KPiA+DQo+ID4+DQo+ID4+PiAgICAgICAg
ICAgIHJldHVybiAwOw0KPiA+Pj4gICAgICAgIH0NCj4gPj4+DQo+ID4+PiBAQCAtMzA1LDYgKzM0
NSwyMSBAQCBpbnQgdmZpb19yZWdpb25fbW1hcChWRklPUmVnaW9uICpyZWdpb24pDQo+ID4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnaW9uLT5tbWFwc1tpXS5zaXplIC0g
MSk7DQo+ID4+PiAgICAgICAgfQ0KPiA+Pj4NCj4gPj4+ICsgICAgcmV0ID0gdmZpb19yZWdpb25f
Y3JlYXRlX2RtYV9idWYocmVnaW9uKTsNCj4gPj4+ICsgICAgaWYgKHJldCA8IDApIHsNCj4gPj4+
ICsgICAgICAgIGlmIChyZXQgPT0gLUVOT1RUWSkgew0KPiA+Pj4gKyAgICAgICAgICAgIHdhcm5f
cmVwb3J0X29uY2UoIlZGSU8gZG1hYnVmIG5vdCBzdXBwb3J0ZWQgaW4ga2VybmVsIik7DQo+ID4+
PiArICAgICAgICB9IGVsc2Ugew0KPiA+Pj4gKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiJXM6
IGZhaWxlZCB0byBjcmVhdGUgZG1hYnVmOiAlcyIsDQo+ID4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgIG1lbW9yeV9yZWdpb25fbmFtZShyZWdpb24tPm1lbSksDQo+ID4+PiArIHN0cmVycm9y
KGVycm5vKSk7DQo+IA0KPiBTaG91bGRuJ3Qgd2UgcmV0dXJuICdyZXQnIGluIHRoaXMgY2FzZSA/
DQoNClRoYXQgd291bGQgcmVzdWx0IGluOg0KDQpGYWlsZWQgdG8gbW1hcCAwMDE4OjA2OjAwLjAg
QkFSIDAuIFBlcmZvcm1hbmNlIG1heSBiZSBzbG93DQoNCk5vdCBzdXJlIHRoYXQgZXJyb3IgbXNn
IGlzIGNvcnJlY3QgaW4gdGhpcyBjb250ZXh0LiBJZiB3ZSBkb24ndCByZXR1cm4gJ3JldCcgaGVy
ZQ0KdmZpb19jb250YWluZXJfZG1hX21hcCgpIHdpbGwgZXZlbnR1YWxseSByZXBvcnQgdGhlIHdh
cm5pbmc6DQoNCnFlbXUtc3lzdGVtLWFhcmNoNjQ6IHdhcm5pbmc6IHZmaW9fY29udGFpbmVyX2Rt
YV9tYXAoMHhhYWFhZmY2N2FkNDAsIDB4NTgwMDAwMDAwMDAsIDB4YjkwMDAwLCAweGZmZmY2NDAw
MDAwMCkgPSAtMTQgKEJhZCBhZGRyZXNzKQ0KMDAxODowNjowMC4wOiBQQ0kgcGVlci10by1wZWVy
IHRyYW5zYWN0aW9ucyBvbiBCQVJzIGFyZSBub3Qgc3VwcG9ydGVkLg0KcWVtdS1zeXN0ZW0tYWFy
Y2g2NDogd2FybmluZzogSU9NTVVfSU9BU19NQVAgZmFpbGVkOiBCYWQgYWRkcmVzcywgUENJIEJB
Uj8NCg0KSSB0aGluayB0aGUgYWJvdmUgaXMgZ29vZCBlbm91Z2ggZm9yIHRoaXMuIFBsZWFzZSBs
ZXQgbWUga25vdy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg0K

