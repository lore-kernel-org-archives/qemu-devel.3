Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F20CD41C0C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 07:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7ch-000322-8p; Wed, 13 Nov 2024 02:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tB7cf-00030r-2G
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:17:05 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tB7cc-0005y2-Le
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1731482222; x=1763018222;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=X1IwGsLf8Xm5UIrUoI1/szbR/uDLuxVw84wT596NQUY=;
 b=s6A5An9xN1qNsGhuDJliWLzuJoAKyuGkFeFMpqKncvjYl9vk2fvmuLUe
 bFr79aEoJydX2tUyPpq0Xqd4FPhKqmCCaDLNbvrrqJt+B7+S1+anUbMLe
 otTHdhWft+9nw7zjLNH2VW/wItCWLcq7Vme4Cgu63meDcb76lGcXrg/Iz
 9xYzzYDgUPxYeWttTjkHAhtmSATdQDiGFPAJ5BYvrmSfyXmmTZ3DTuiOV
 hjC0VZRUKmFJG4jySu89iOLhkf9GIO7fM0CWM468nEJRrh+hmBwjegHvi
 01DteTiYPXh+yoNiBC1cOgEloD7C8xsl07BhQTd32J0pGNhU8c5TeFs/+ w==;
X-IronPort-AV: E=Sophos;i="6.12,150,1728943200"; d="scan'208";a="25073882"
X-MGA-submission: =?us-ascii?q?MDELDVdE43GxBGk1TlHY+twSBfpTaroZG2nyrS?=
 =?us-ascii?q?NjMjXnzLg/eK5fOErQ6Sua+4sB4bJg7DtWSOZQs95tUkoF++JnY9uqR3?=
 =?us-ascii?q?Vo1XlU3OUaQj+/dmNg90fNnk9Rfhb2qeVkhcFCIO2o+NeiAmToGVb6ng?=
 =?us-ascii?q?lZdd/RDKMGXJwv3pP9rvEy4A=3D=3D?=
Received: from mail-am6eur05lp2111.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.111])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2024 08:16:59 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkYRt5HSJWCaAkCzWoOrOTm+Pe4LiwmnjK0m/ChddqUasws7zRX7Zod8wwmIEqy1ReyVk3TOH4f6q3e7HdWoInuUAvMTKKrG+PyZIAKX9QR1GqtoQb29GcKyu9LZ9azZQVPIQ0reyzyBk2Psa3hMLZmiI0pDB8HoOrwBC1yw56FijIGr5sNR2ErruSQ8Dn+UntlWUXSafRbyBdh5TmHHgcHbqjv57NfjuDGK42cIsM0ZKgTcuA39eMQ2b+EzdHV32T2aWZNXOrokH9NXkMkMxGY5tjdFQ10Kh6lUw4Zhh3KiVR1T64GHcJiahVDZBu7LNjbfiDs1iFAooHwA6I+gWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1IwGsLf8Xm5UIrUoI1/szbR/uDLuxVw84wT596NQUY=;
 b=sMCuf+C7/BdHTm4DFpdpq3YpUCkXPT6/UMPi3lSlfEoslnnj+fvPZmNBdaYlq30hrmR7g6f3vJJ3vDHiAsT5Bh+oC+6hxYTEgGyxmtNZ4uuoqQCnQ9oUaam96hkskH8TsBP+Kh69R+UrzQjLaCjBIPry32gU7ZBtkRvFL6wl5iGXQ9DBHYs6vPGP8ns+0N8Y35zioFdNpOcOimhOfK6hFyWoDOCnOvpgIcah0fY/Dp8ouE0Wf0/6foIfUaoi/pEvFPh7xFJrYlx5AReMFAlnByOJ7EzutLdUqPdpDGppT653i/ZaooLADnUHT5PGZCz/lwS0LBcndoCvTsxtjvkaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1IwGsLf8Xm5UIrUoI1/szbR/uDLuxVw84wT596NQUY=;
 b=XUD9pfRiToZU1zkNV/nsJZ9DZNHtfgQttyw2BbYwtHTGo8G9BoRAx+5YHJ7SBlcAo8kOuLKrkZeuYp3Rb+XP8ppvQ9un7L9orT08SVbRGM2uckjMpa8Nvq/4+2Y2zSJ6rWBVLBrlpHzzbKGirwx/ZGpKaE4jO3OU8uSyWRdZR5qu7+oTOKDX1HTFXec3Rc4w23Yc2+/Zgz4xxUyBW1npdC3aaLu7wuR12TiTOgQycAIj5iCHtd3kjW0F+bNzB/zqkA0y9NzAyl1PXwVwrXMPtnvm3A1jJqER94x5MTGkQax8ftj66DnlfVEFsikHcRhF351USfbowNJfDZeilBs7mQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7093.eurprd07.prod.outlook.com (2603:10a6:20b:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 07:16:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 07:16:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH v5 17/20] tests/acpi: q35: Update host address width in
 DMAR
Thread-Topic: [PATCH v5 17/20] tests/acpi: q35: Update host address width in
 DMAR
Thread-Index: AQHbNBU22QGB9Hn2BkGb1hYouWbZMbK0z9yA
Date: Wed, 13 Nov 2024 07:16:55 +0000
Message-ID: <5a65512a-ec4e-4de3-84c9-253a9b7dcba0@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-18-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-18-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7093:EE_
x-ms-office365-filtering-correlation-id: 9e98b25d-5006-4dc8-8460-08dd03b327c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VzNqSGk3WHRYdWdLb2pTTDRKd2R4Q2NXRlEwdGd6RmJmaDhxTTMwQThJakUw?=
 =?utf-8?B?VFQwcEIrS0tKZysyd2xZcUFxSGVBQkRyQlhoWWM5YUppaDNHanA2QThHM055?=
 =?utf-8?B?UXMvWXhZeStFRmZxaytyM2hWSjJwV3RydHFDVFExQjA5eHhXQnQ3SloxK2s4?=
 =?utf-8?B?TXdEQ0ZncU5qMXdBNHdVNkdNRXZHVDQ0QlNoalE1MlRXOCtsdHlzQUEwNWRP?=
 =?utf-8?B?dUpOM0pCbk9mekQrWTdTUlM3c0wxZlY1d2xKejNibXdmdHJtTWM2Z2VRcFRX?=
 =?utf-8?B?UVYvWit5Umk4aUZncHBreDlwMHNHR0N3N3hpZ0ZVVkJCSlhvOHVSQmJ4RU81?=
 =?utf-8?B?RUwyZHB6Wjc5K2p6RkZaZDhJNVdpUjhYVEJCR3hOcTFaWENGVXdzVnAvYVZT?=
 =?utf-8?B?YVdWcXNkaVNjekh4ZmZ4WVc0SDVZRWRTdzNxMkZ2Q00yVzVWT2dtNUpiMXI1?=
 =?utf-8?B?alU4KzM1eS83Nmt1WklLSUdiZFlhRlozc3dqVkVUaFVKSjhvaXA4YmVHL0wv?=
 =?utf-8?B?ZUJONDZGeE8wVHFhRXhFS0wyNFhZSTFOUS9SaTNaZEM4YVRwOG44WC9xcVRZ?=
 =?utf-8?B?VmR0K1Y3QTVNVzAyUEpWTUdCQkpzTjNFQWtVdkxlRXZkU3REVFZxME5zRDlO?=
 =?utf-8?B?Qm1xazhtR2NkQ1lNalNvUjVUaXIzVlE3ekFHVm8wNW9ZdjN5cFdmZGlrNUtJ?=
 =?utf-8?B?aXJlS2pqd1dKcS9HMUJkVWlCeDhEbHI0Yk5xZjRFeE9JaHhOR3ZUV0VlWHlQ?=
 =?utf-8?B?VHovbEVjd2gvdFJOc1FDZVNzZEJkdDNtdjJiMHZiUktodXcyTzR0UkVNc2F0?=
 =?utf-8?B?VXZiSVNydkpXM203UHV5dCtOa2tFUHlHS1JvVWpPbU43ZkVFelFyU1I3STli?=
 =?utf-8?B?ZGpPdTlTckhtanFMRzZTMGRSSG5jSDl6NU93ODJ3SUhLU1lRcGlpUVg2VWFh?=
 =?utf-8?B?b1l1OW4zclNaZHNaZTJEdzY3ZCs5SDVIY0p5M0FTQTRMKy9scFkzTUk4ZWs5?=
 =?utf-8?B?YUplTDFZZ0dHcDdTT1Ruakp6djdtdXpQTDhBa3Y4NTBrMHlRQnN5TCsyV2NJ?=
 =?utf-8?B?YXpBZVBLZ0VmR1dCYkFYMHBITWl5Nkh6TlcwS0FEUGlsR3pMbU1Fa0RnM2Nr?=
 =?utf-8?B?ODNZNHp5ckJMSVdBZElidTZEbWJ3b25RQ1c3djZrWUZVc2ltdS9pREIwSWtN?=
 =?utf-8?B?WHlzWjhoQng0UDVBbHU4NkhaZjEvdjg0c0dMb011WjVMS3NYamtURjJJeHc0?=
 =?utf-8?B?cUhKaThCMXJlWU80eWlNYWxqWlFReGN6dG55dGhLZjhrNWs1dFNWYXlLRngz?=
 =?utf-8?B?b2pDMHpkQXQ1MVAyMElZMTBFVnY0aVphSGFGNTRnWjgwbUhHb21pdWxicEU1?=
 =?utf-8?B?VXluMlVZMDJNUGVsOWJhWXV3SkRQRkNlNVJKeVZRNHlaT0xJbjJzUDVHWTNw?=
 =?utf-8?B?bGVGWHZtUFdFdGNIall1K1d5SU5RNUlzbVgyc0VYaHdZMDE4b3pXK1RKQjdx?=
 =?utf-8?B?VHpRNDUyZnM3NjBlS25FWlF3YlQxcEJ3dFlGZ2tnWWpwOTlaOUIwNTRzSy9U?=
 =?utf-8?B?bzk1T0czdy96WkphelNnQmc4TEpCemVrK1cvSkowb01ud3d2OFVxeVRQcEYz?=
 =?utf-8?B?bDdVNXJ1ZE00TEJ1VC9EcVlaMytIMWVzVzZsSCtlSVVjTGFOUFZvQjFmUUpB?=
 =?utf-8?B?eVJkLzlHYXRGemdxSngxQ1ZjcjRzNmIvQVFsSkhzME4wRi9lczl5UjR1eEhh?=
 =?utf-8?B?N08wek1ocncvd09ET0xUcXlLVndLT3pkVHBOamhjbkJDRUx4TW1kRGQyWDVI?=
 =?utf-8?Q?HCXTmmbVPVYp05jxP3gJ4bf8lof7kvCI0hH/8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWhyVEhoZ0dISUZHU1UrbWhnV2xqeXR4b1hsZzl2S3MzOU45Skh5WUJETjdL?=
 =?utf-8?B?cWF0Y2gyTVR3ZUVzdy9IZXVscmNkYzJYSUIwR09xaXlSQ2NuR3pVSlg1SEJa?=
 =?utf-8?B?bHIwVWxQQnp0bGFDdHdJdnRzbmpCb3Y0eERwNGpkM1IwVmx6WVJwdTNlWkxT?=
 =?utf-8?B?NTFKZTkwN0ZBdU1VcWg3Y2k2SnA5UXhYeDg2WU5KYnhvSmh1MUpwdy9FSWFS?=
 =?utf-8?B?NHdlaStnaXIxRDAySGtDbVE2UGRUdjFwVXpSbS9IYkJxL1VPUFBTZmhQcFls?=
 =?utf-8?B?QkZYd1FOaUNXb2dQQTlNKzB0S3ZzSEtXdHBBZ2duSDVmdlFGaHF5RlBpa2NH?=
 =?utf-8?B?akhRTnA4S2x1M0FMdHplNlJabzZxWVVxN3Z6T0NiZzhMU3Flc1ZQZnlRdzZJ?=
 =?utf-8?B?M093NGV0cHlIQVZuODd4NkYxMXUxR3ozcTFSRWhucFZDZzdtd1FNZFBhdUVO?=
 =?utf-8?B?UlBKSW5HWG9jRXJlTENpL3dtWUEwQXFPVkV0WDdNT2VBSW9PL2F2VStWVTJG?=
 =?utf-8?B?eHBhYVdNeEpISHJ6NzhyMTNSNU1rRCt0K2dhaENad2NvMWdQQWJWMTZWTmJU?=
 =?utf-8?B?bXhtL3lncXU3Y2YrR1NHWW9Zd1c0ei8xNnJhWm1xUTRvU0hkRUJzcWJpalUx?=
 =?utf-8?B?Rjk5cmQ3ajdtdGRwaFFWbzdXVEgvQlNMWXFCN25sN0hXNG1zUlhPTGVvU1FY?=
 =?utf-8?B?UVM0aDJlaFBhMUJVaEJCckx0eVowNkF1MkwwK1h6SURKR3h5WEtQUWNlcUVS?=
 =?utf-8?B?eWk0YXRFMk1hYVJ2RnRvWGtpRjFYN3V2VTI0RGpxbHVOMUIyMG5iaHVZdEM5?=
 =?utf-8?B?UG5IbVZOazhld0xLeXNEOTNsTjNEaWMrSGtiQ2hMUTJ6ZER2YkQ0V0d4ejhM?=
 =?utf-8?B?Nkw3amNGYXNkaUNHQ2dyUWRuU1liUXBRWjN0QWdoUUIvRVVaVFZXSXNtbnRx?=
 =?utf-8?B?alVaNUhsR1JMVUZhVUpHdW44UmRNVzQrUUdaanVCeVZEUkJyQmhSTVp5aVhS?=
 =?utf-8?B?aXprdmI0SmFMcWkrVmxuci95eDJqZnVpblV6OWg1L1gyRVJ6OFBkVCs0bDZ0?=
 =?utf-8?B?azhwN2xQZFNKRXR0UFkyT2t3L2NYcU81SWhuL2JaL0FOdEhqdGlJUjlUNEtB?=
 =?utf-8?B?czNyZy9KZk40M2Vkd3l3TmRCWCt3ZTc5U2FybDRnQ2ZoN1NINElPQjJJMTEz?=
 =?utf-8?B?QnVvSStLRFNIaWpvVGhoVm9DU3JIWXRwWjkxd3lTY0JTbUFpM21nTUV2dk4x?=
 =?utf-8?B?MzUzRTBsOFo2YldWZHVpNzdZaStiTWpSL3BkNGRMSFlvSGJ2ekRIckg4VVRJ?=
 =?utf-8?B?ZjBtMVZ4cCtnQ3o3YVNCYktKSWhBTDNDT0h1NEhOdE9qQzRWMG1jNVZkWWc0?=
 =?utf-8?B?d1FjTjJVVHFqNXFHOCtOc2ZNR1hKeitENUVsLzhCYlhhVFFGWVF1dEZVTUQv?=
 =?utf-8?B?ZFUxUjMybTNIUTRhU1hCcDkvamtjTGIvb2VVNEE2WUZjQkdTM0ZuRFU2akND?=
 =?utf-8?B?M2w0THN1YUtRa3ExMkhkbHYxUlk2SzlwVWIyVDhrMXNxYzN2QWhuYkdtUy9z?=
 =?utf-8?B?UURudnRUT3RpSURiRG9aQm1mUnBEYm1vSkNmV2J1UmVuZHl4a2N4azBkODF0?=
 =?utf-8?B?dStpRGhrTU1JZVJwd0hSSnh6L1M1aXBYdmxscWFCMHg0MmRsL3Qxa2lIRjdi?=
 =?utf-8?B?S0hhN1hXQklQN0pORjlkVTZzYmFoeWxOdjJEZ3JmSjN2bkVXSjdSZDcyNHI5?=
 =?utf-8?B?MWNYUHh5ZVZ5T3FLVUNveWQrd01kUWFvTjVLODZWb0NqTGV3TEw3WGdMRWln?=
 =?utf-8?B?MmhrQXpMYmkrZkdKMzY3RmhyMnZkejNnQnZkNDQ3QjR4YjAyNVlSdGhBcmwr?=
 =?utf-8?B?bUEyVW9CTnlQNkY4c1hrRVA2My8rWVRYRDNVdkh3aFFLMnVZNnJZTHUwVW5M?=
 =?utf-8?B?UWE0bTZGeEx3TnlDTkw0S2R6MEZubzNRcWVla29yZkx6bjl3MEkxQXFFV3pq?=
 =?utf-8?B?ZWZ0dG1YcUZyQ3NWWHVHMksxdVdqQ1NuUWxGSkxDK2pwZGNyTkVDMHlicWp2?=
 =?utf-8?B?dzFMNGppWUM0ZDNjTjNYU2VXSElTcFRDcnlCT2xWdkRWNzVGU0xFMDdEaTh0?=
 =?utf-8?B?TXVaTE9uNkFRYzVrRlgyTWxDTDh2anoxemlwUU5lRW9LaUxSL284cE1NUi9u?=
 =?utf-8?Q?ZxIyvPbwUj3VtuD+T8cBTDc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F2A297F7C9F9245833B4C87F350E91D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e98b25d-5006-4dc8-8460-08dd03b327c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 07:16:55.7364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQdjg92g5arcS1sRysYELpttYrDmYQAkfiWdO/v9C9V/rUAKUt9mDtFymRgX3XtRaFeT5S9scxIexPyiHWahyZojtqK+/jXXuGohjLpYRd875wKc0kBGBteqbhtihNGk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7093
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

SGkgWmhlbnpob25nLA0KDQpBY2sNCg0KID5jbWQNCg0KDQpPbiAxMS8xMS8yMDI0IDA5OjM0LCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBv
cGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBm
cm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0K
Pg0KPiBEaWZmZXJlbmNlczoNCj4NCj4gQEAgLTEsMzkgKzEsMzkgQEANCj4gICAvKg0KPiAgICAq
IEludGVsIEFDUEkgQ29tcG9uZW50IEFyY2hpdGVjdHVyZQ0KPiAgICAqIEFNTC9BU0wrIERpc2Fz
c2VtYmxlciB2ZXJzaW9uIDIwMjAwOTI1ICg2NC1iaXQgdmVyc2lvbikNCj4gICAgKiBDb3B5cmln
aHQgKGMpIDIwMDAgLSAyMDIwIEludGVsIENvcnBvcmF0aW9uDQo+ICAgICoNCj4gLSAqIERpc2Fz
c2VtYmx5IG9mIHRlc3RzL2RhdGEvYWNwaS94ODYvcTM1L0RNQVIuZG1hciwgTW9uIE5vdiAxMSAx
NTozMToxOCAyMDI0DQo+ICsgKiBEaXNhc3NlbWJseSBvZiAvdG1wL2FtbC1TUEo0VzIsIE1vbiBO
b3YgMTEgMTU6MzE6MTggMjAyNA0KPiAgICAqDQo+ICAgICogQUNQSSBEYXRhIFRhYmxlIFtETUFS
XQ0KPiAgICAqDQo+ICAgICogRm9ybWF0OiBbSGV4T2Zmc2V0IERlY2ltYWxPZmZzZXQgQnl0ZUxl
bmd0aF0gIEZpZWxkTmFtZSA6IEZpZWxkVmFsdWUNCj4gICAgKi8NCj4NCj4gICBbMDAwaCAwMDAw
ICAgNF0gICAgICAgICAgICAgICAgICAgIFNpZ25hdHVyZSA6ICJETUFSIiAgICBbRE1BIFJlbWFw
cGluZyB0YWJsZV0NCj4gICBbMDA0aCAwMDA0ICAgNF0gICAgICAgICAgICAgICAgIFRhYmxlIExl
bmd0aCA6IDAwMDAwMDc4DQo+ICAgWzAwOGggMDAwOCAgIDFdICAgICAgICAgICAgICAgICAgICAg
UmV2aXNpb24gOiAwMQ0KPiAtWzAwOWggMDAwOSAgIDFdICAgICAgICAgICAgICAgICAgICAgQ2hl
Y2tzdW0gOiAxNQ0KPiArWzAwOWggMDAwOSAgIDFdICAgICAgICAgICAgICAgICAgICAgQ2hlY2tz
dW0gOiAwQw0KPiAgIFswMEFoIDAwMTAgICA2XSAgICAgICAgICAgICAgICAgICAgICAgT2VtIElE
IDogIkJPQ0hTICINCj4gICBbMDEwaCAwMDE2ICAgOF0gICAgICAgICAgICAgICAgIE9lbSBUYWJs
ZSBJRCA6ICJCWFBDICAgICINCj4gICBbMDE4aCAwMDI0ICAgNF0gICAgICAgICAgICAgICAgIE9l
bSBSZXZpc2lvbiA6IDAwMDAwMDAxDQo+ICAgWzAxQ2ggMDAyOCAgIDRdICAgICAgICAgICAgICBB
c2wgQ29tcGlsZXIgSUQgOiAiQlhQQyINCj4gICBbMDIwaCAwMDMyICAgNF0gICAgICAgIEFzbCBD
b21waWxlciBSZXZpc2lvbiA6IDAwMDAwMDAxDQo+DQo+IC1bMDI0aCAwMDM2ICAgMV0gICAgICAg
ICAgIEhvc3QgQWRkcmVzcyBXaWR0aCA6IDI2DQo+ICtbMDI0aCAwMDM2ICAgMV0gICAgICAgICAg
IEhvc3QgQWRkcmVzcyBXaWR0aCA6IDJGDQo+ICAgWzAyNWggMDAzNyAgIDFdICAgICAgICAgICAg
ICAgICAgICAgICAgRmxhZ3MgOiAwMQ0KPiAgIFswMjZoIDAwMzggIDEwXSAgICAgICAgICAgICAg
ICAgICAgIFJlc2VydmVkIDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4NCj4gICBb
MDMwaCAwMDQ4ICAgMl0gICAgICAgICAgICAgICAgU3VidGFibGUgVHlwZSA6IDAwMDAgW0hhcmR3
YXJlIFVuaXQgRGVmaW5pdGlvbl0NCj4gICBbMDMyaCAwMDUwICAgMl0gICAgICAgICAgICAgICAg
ICAgICAgIExlbmd0aCA6IDAwNDANCj4NCj4gICBbMDM0aCAwMDUyICAgMV0gICAgICAgICAgICAg
ICAgICAgICAgICBGbGFncyA6IDAwDQo+ICAgWzAzNWggMDA1MyAgIDFdICAgICAgICAgICAgICAg
ICAgICAgUmVzZXJ2ZWQgOiAwMA0KPiAgIFswMzZoIDAwNTQgICAyXSAgICAgICAgICAgUENJIFNl
Z21lbnQgTnVtYmVyIDogMDAwMA0KPiAgIFswMzhoIDAwNTYgICA4XSAgICAgICAgUmVnaXN0ZXIg
QmFzZSBBZGRyZXNzIDogMDAwMDAwMDBGRUQ5MDAwMA0KPg0KPiAgIFswNDBoIDAwNjQgICAxXSAg
ICAgICAgICAgIERldmljZSBTY29wZSBUeXBlIDogMDMgW0lPQVBJQyBEZXZpY2VdDQo+ICAgWzA0
MWggMDA2NSAgIDFdICAgICAgICAgICAgICAgICBFbnRyeSBMZW5ndGggOiAwOA0KPiAgIFswNDJo
IDAwNjYgICAyXSAgICAgICAgICAgICAgICAgICAgIFJlc2VydmVkIDogMDAwMA0KPiAgIFswNDRo
IDAwNjggICAxXSAgICAgICAgICAgICAgIEVudW1lcmF0aW9uIElEIDogMDANCj4gICBbMDQ1aCAw
MDY5ICAgMV0gICAgICAgICAgICAgICBQQ0kgQnVzIE51bWJlciA6IEZGDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0K
PiAgIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggfCAgIDEgLQ0K
PiAgIHRlc3RzL2RhdGEvYWNwaS94ODYvcTM1L0RNQVIuZG1hciAgICAgICAgICAgfCBCaW4gMTIw
IC0+IDEyMCBieXRlcw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCBi
L3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmgNCj4gaW5kZXggNDZm
ODBiZTljYS4uZGZiODUyM2M4YiAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvcXRlc3QvYmlvcy10YWJs
ZXMtdGVzdC1hbGxvd2VkLWRpZmYuaA0KPiArKysgYi90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10
ZXN0LWFsbG93ZWQtZGlmZi5oDQo+IEBAIC0xLDIgKzEgQEANCj4gICAvKiBMaXN0IG9mIGNvbW1h
LXNlcGFyYXRlZCBjaGFuZ2VkIEFNTCBmaWxlcyB0byBpZ25vcmUgKi8NCj4gLSJ0ZXN0cy9kYXRh
L2FjcGkveDg2L3EzNS9ETUFSLmRtYXIiLA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZGF0YS9hY3Bp
L3g4Ni9xMzUvRE1BUi5kbWFyIGIvdGVzdHMvZGF0YS9hY3BpL3g4Ni9xMzUvRE1BUi5kbWFyDQo+
IGluZGV4IDBkY2E2ZTY4YWQ4YThjYTViOTgxYmNmYmM3NDUzODVhNjNlOWYyMTYuLjBjMDU5NzY3
MTVjNmYyZjZlYzQ2ZWY2ZDM3NzkwZjg2YTM5MmI1ZWEgMTAwNjQ0DQo+IEdJVCBiaW5hcnkgcGF0
Y2gNCj4gZGVsdGEgMjENCj4gY2NtYj1aO0J4Vkc0NjB5WVV8ezUjJFIpKzdLVCRPcDA1KHFxa15s
ZXoNCj4NCj4gZGVsdGEgMjENCj4gY2NtYj1aO0J4Vkc0NjB5WVV8PHhUJFIpKzdIYz5TZzA1KklD
a15sZXoNCj4NCj4gLS0NCj4gMi4zNC4xDQo+DQo=

