Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29352C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qP-0004Zu-Nd; Wed, 15 May 2024 03:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qJ-0004XV-9t
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:27 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qF-0000oW-NX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757263; x=1747293263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Iwcyrl9KCw7Jh1dv0E/FHT7n8wj4cy1aJ6V3NU3ckeM=;
 b=NKEJIS1B5yeBtQq1SEIHceQ5N8czr24gjxZSwNbLVJwMdUe3CefPW7tC
 Sw3pSuEoWJ17Jyta8G26sZJpRdvecCem+yDOxeVFsWISJXEURUJODzaZY
 04+H5KCx3A4I+/7GhCUWFvudYfMqSEHu1ed1n+4Jvk9rhEpqgSvLQJssd
 /1DyFrCbWMOnvCZtD3ObAVh/HpgGKK9H1Lb32VTtfmpzRWnmYYUE7KER1
 ICsEK6wbBQlbrLwrzxxho1BJeHvI7+zVdFHYi292mtcATD25BfTfDzEBp
 ncB9fFLWv9K8XRnd/t6aIZgJJ8DWOkmq4J22YgNUWTx93xeZYFGnZaIPZ A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581795"
X-MGA-submission: =?us-ascii?q?MDECe5PZv9r3WN/RiCMzTDZoqjrcYsH7bqlmne?=
 =?us-ascii?q?zuZkD13qFuxGsTqA2cYMCH0C8RmpfC+nUsP7RZHtnuExZltPc22LgFUP?=
 =?us-ascii?q?zaihmG2iERTna4pwjvMQhffzuwydifk6OuObosG5eC842ldtdmP8eW9v?=
 =?us-ascii?q?a0vq/JKIBPbtqN6z+zm51cpA=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:17 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTaaeFzPeLdVB4EWi3r6wEG9a0W/GMtoY3kFfb5C1ESdNRi7ge8zKkoircmlpKTDySmuNychjBUjEsezh6GnkS5E5eKs6CfDJt7HFsncyv1DqMBsa/HqzcP/mK3mY8OkjFISbq0Aa04L55wXQHFZ/ohSh+T6X9plz1FmZ6W03jHWxsuX6VxbKv24RouZ/3ZoUClUvR1ax9ciHf5P7zVMq4WKFObHq7VPfnccfNT6ygWEW3gak32t9ICIezWkmPnUAesV3yrGl/Qz22sZVtnBtWonPA7a62/h5U9W/Dw9XSENgj2LpLlDRASlvjTW4fgGYj89ltTLwjqW9P53FBWVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwcyrl9KCw7Jh1dv0E/FHT7n8wj4cy1aJ6V3NU3ckeM=;
 b=Ho6MlY2d9+PTFfZkE9Fi+M3dG7j99q6OONx8N3aUdT7JIUgjMv100OvO5rUHQryiDjm0LSPX1eJb3A1iQ67APLfxhQwK5xCaTtEwsVd4vY50AJSTEuQcnFwmfSYPU1W2CaDH66iUYkAuAlwGsWxIkAK/JQDhOpWiwhpoCAAYcZ0SXgpmbTMF5K4kWTAR1yKq7rX9xQOgLETnlEuJkjVe7Xnr8BFzQI+/mm6vyqGFx7tiWW9OG2DLL+/vSjPlM3sT4PtnXsQGesE72EKQcSqbHk22PsfnOAyjLsSC96R+TrPjxsW/ffQ3LXKyU68di2Nfp9GFfQmw7MU24rSpHw/X0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:15 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:15 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 04/25] intel_iommu: set accessed and dirty bits
 during first stage translation
Thread-Topic: [PATCH ats_vtd v2 04/25] intel_iommu: set accessed and dirty
 bits during first stage translation
Thread-Index: AQHappd+pmoR6qJa2US/JV5yJx2XMQ==
Date: Wed, 15 May 2024 07:14:15 +0000
Message-ID: <20240515071057.33990-5-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: c4372143-42ac-4cdc-61d8-08dc74aea0c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MjRpbm5jSnA2OS9hS1VNN2hkZkhzNkU1d1MvSEtKREFHNjJVVWN5UytXdDh2?=
 =?utf-8?B?L3dXVHN2ZXhONkhrSEhDTEVwcm5ubzlXSDNSWXl1VmxwdlNBYlJqWFYvSUpu?=
 =?utf-8?B?cVM1eDlzbjVIekxFeDZ5NnBia2lpUGgyaEFrWTB5Z0MzUzNQM3NOSVk2ak15?=
 =?utf-8?B?cjZCZGlBbElpUmRRRWtkeVlIcHFwTC83dGVnNVpKL0UwNDJaL3dZbFpDV2l4?=
 =?utf-8?B?aHdYWjRWc2JPcVZncWh1akZHMXFRWHZMZE5JODhwVkZ1dnVleWxqbjJDQ2Ez?=
 =?utf-8?B?U3ZEM2VMZXpSWVJwTzhPdUZxKzFGaG1WZm1lWktOSDhNYTRxOXpENXhnWjVO?=
 =?utf-8?B?VTBkZENHSUR4S3JnZzNVaGdKZFdyTHNvNHFES2RwcG1MWkIwdU1UTzA1WHlX?=
 =?utf-8?B?WDNLY2E0ck1PemJHVTh0VWpQeVFBUkwyVzFvNi91dmhkV1FIa1pHeWN4Ymtz?=
 =?utf-8?B?ZVRzVEFDWlM5L3NJb2RVNDdBc0svV2xwWDNBa25QMXBwUkFzbzJpejNUQ055?=
 =?utf-8?B?OXlBNEtMV2E4eXZsQmJvcFg0aXc2RUZ6aDlDcDJ3RFNINiszTXJCSFVsMWdL?=
 =?utf-8?B?d2huS3hnalU0bndud1ZTT0Z4cnlsVzg0TmE2cHJKOE5iZ241UTUvZUFmOUhS?=
 =?utf-8?B?NitZcC9rZzB2TGs4UHNWd05VcGt1dSttbGdRQUhyVThZOFBJZGtLdEo3dUk1?=
 =?utf-8?B?cDF4NHJFeU5PWlpJTHJSVUJmMkEzMzBOeVBqL1B2a2FJZHdDbU1wUjRzdXVI?=
 =?utf-8?B?amRUNjRGRGZmbmNzWk9MeGJZS2hHWmhhdzR0SDhaSlhoMzh2WU04ZkU4SDVL?=
 =?utf-8?B?UWNzc2FiVS9TTUpoMVd1WUlRNUkzR0lnMS9KZ2dXdDY2NGw1L3ovaTdrellY?=
 =?utf-8?B?NEtnaG9BZVArTHd4Ylpyb2VleE9oREpwUHlDazMwMXg5VThpWnFpZlo4cVU0?=
 =?utf-8?B?eEJJbERHVFJ0K0RRekhCTmRibUpGY244KzFaV1dncy80QmpzUTRRUGRPc25S?=
 =?utf-8?B?c0J1SDJ6aVhxekFJMHVraGxqYVNNZU5JV0dLRGd1aktmbGwxOERnSWdqSkhi?=
 =?utf-8?B?cXREOFVsQWYrQy91VE5xaXVTdWlLSkVEWDVZUXl3VmQzVDRNTitBSyt1NEMv?=
 =?utf-8?B?VWl2NVBRaHFvWGZnRjhETmwwZFVZd2g5cVlmdjRXR3h4cnJKSk9JVVRBOHV6?=
 =?utf-8?B?OThTNDVvUFFWZllubmV4dXhjenRYZjAzWU1MZC9zWU1HQytwM3U3U0pwTjM2?=
 =?utf-8?B?amo0dmx0T0N0OENhMmJ1SHFCWjNXaHhzNSt0ZGxPdGxZUngvUWFXOHJjWEZ5?=
 =?utf-8?B?RDJZUmVMN2VkcXZNczRNQ1JOSWdSdG15ekV5LzIwVUR1VDFmYkVSVlkzUWlh?=
 =?utf-8?B?aVY5Nys4b201eHYxVDdsQVRhZk56VE4rOE53KzVwZlRYUS8xMkhsWitPQ25B?=
 =?utf-8?B?eGNXaitpV2NWd0hEQWVVZitmcloxRldweFR4dDhQbHhvWkIzQTk1SHdqakd2?=
 =?utf-8?B?VlBFR09pdG5pVE9iUEY4ak04VU9uejhnT3J3Z0hLS01nUEp6dW1URSszcWZJ?=
 =?utf-8?B?NjJpVHhqSCs2NDhCeFVwNkYvWElCQ0hVWFBXbGpwMW1xSmtiUlc1V1NrR3ZI?=
 =?utf-8?B?UEhKMVlHaG1RS2R2NG1XN0wzbzJWaU1hU2FNb2l1eWkwUG9rS3FhcHF2Y2p6?=
 =?utf-8?B?VnZVYjRLSEkxckRPNEtsQU00RHJ1aTF5YkMvbGFlNWdXWlNZWktQa0x5VE1o?=
 =?utf-8?B?YkZTT1RDMHZaTlRVNXlMZUZYUkY1V1IweXB4OStEcURFaWF1ZWdxdXZZUDhD?=
 =?utf-8?B?alZaTlRYYUF5RGVDVUJkQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzF3UG9NMWRiT25CZGFJNjI1M0J1dmZhbFJJNXBBQW1kbXpTeE9IZHl1RjBq?=
 =?utf-8?B?cm1XOUpUa015OVJkNDFhTWRQVnArZmROVnZYMFUxWitiNTBGbW0yNFBQRmVj?=
 =?utf-8?B?SytYSXVCVTNUQlRGSzJmVWpEOTg1Q1hlWU1SL290MjRjOHp4OXRWNXNRQjlt?=
 =?utf-8?B?dkJmSFpzQThyWU9vQ3NJSkEyYXBFakpvMVhsSkhTNmFtUE5OLytXamFUckNJ?=
 =?utf-8?B?YWFteFlIRER2ejVSb3VMakZtRWVTVWxMZmVjY0VDcFRnd05WRzBMZ1lLZXlQ?=
 =?utf-8?B?SEMvMkVOK0V5cWdDUDlwMDVMN0liSUxnZU9XN1RpMXNhR3N3UVJJWFZWZzZC?=
 =?utf-8?B?TjJXTHZIRGpQczhub1RhTlBFTThJQjBqWlZpYk8xd2IyTnBEbm84d29SaTBN?=
 =?utf-8?B?WWdTeFprZ2QwRmxQbys1MmhFTVBGT3RBVVdjRjdPYThhQnp4bGR5VE03QzVs?=
 =?utf-8?B?aU01cU8zYTZxME5YVHFJWG5pS2w0R0hJYm9Kb3dVL1ZvSDAxVGF3OENhL3k0?=
 =?utf-8?B?SUoycjMxeVFpbEpIZndCZ3B3bndtQmlJTWRXTjkyOEVLeVU1Z1didlRqUkh5?=
 =?utf-8?B?ZFN1MVFvaW1ybG5FMk1xN0hvbi90elUwVWIxTk9KZTFoNWhuVG1RV3VTZDFw?=
 =?utf-8?B?NDlKS3dqRWVNQnpROWlRN2doQ3RUR3d5a0QxQWxKdDVtSHRiRDd2RlFXMW1n?=
 =?utf-8?B?dTJDdnc2K2RiMEhuYzYwclZ2eXExOVh4TFpQYWk0RHc3UDFKVS96VS9mQ3FE?=
 =?utf-8?B?OEkrZDd6SjdsVXZGTmxzdWthZWFsbWNyVm1HMU5lWExsbjdFazRLRTdEb3Jx?=
 =?utf-8?B?OUlRSEJncjAyTVo5TEpOQVF1c1grb3ZvQVdUM2IrdVdBNmhXczZYTW1PN0sr?=
 =?utf-8?B?VTBSSGtXZ2s4RmdMV0xyOC9mZ1Frb0R2ZjBpM2xhb2QyM3gveTA2TjI4UnI2?=
 =?utf-8?B?RXdYaTdzYzNoSGRDU2hVanhLVURvOTNmaFNhL3M1cGRGeDV4dzJHRjFkc2E1?=
 =?utf-8?B?Z0ZHZnVZaWFSRmlMLy84TWpUVHhWRjV2NlN1OXFpblB3dmpKMmtPa2FSVnMz?=
 =?utf-8?B?KytvZk5TR2Q5aVk4QzZBbGNmdVBwcW84MXI4YjNTSDk3S2dZamRxMEhqQkV5?=
 =?utf-8?B?STBLV0IzK2VHQ252R1VVeUo4QnZFbWFRN1BrZE9jVWY5ZUYzeUJ2NWJUTmZq?=
 =?utf-8?B?YjNKNEtlTWd2SFJkZVhnS0JXai8ySktZUStzaWNtRTR0bHF2WFVwNmRwTDVK?=
 =?utf-8?B?N2RlTHF1dFl6N0xQUGVXMnp1NGR2R1lFVyt6N085Szl4TkZqOVBhRWJXS0Fj?=
 =?utf-8?B?MFg4RUtxa09LeEY4RmsrMXo1Q3I2ZXZ0TkV1WUtZS3lVNTJMNEZWMWpsZVk3?=
 =?utf-8?B?TXE0RmJyWUl6b2FNUWF6Mjc0eXV4US9vUk14TEFzWGFta1pnZEZ4cGFpY2Zt?=
 =?utf-8?B?UlhuTnhDTmRsWFkvUHJxQlhyTVRMSkdCREVWdXplOUFHaHliS21ZdWd6Mklz?=
 =?utf-8?B?cFFKOWZaNGI5NEx4b0s0UmdVaFN4RkhBaUI0VUtMWFpIaE5qRjNUcldzRFlH?=
 =?utf-8?B?N0tkVm9NdDhyZ3VlMHllM1RDaGF1cG5STnNwWUF4VGpDSzJyVUo0YlladGZT?=
 =?utf-8?B?NlY4SVk2dDR1MklEbTYvck42TzN5bEJiSW4wVHdObjNtN2FIeDF5eC9SQW1C?=
 =?utf-8?B?N3JDTU5tWkkwWmhiNklWT0VvNUZpbUNJYkpnVGxUNlFmVk94SDVGcHhHMHJ2?=
 =?utf-8?B?QkhKT1R2bUtPM1NHUGJNTTRiK0hsc1hHOHBkdWltSFFncnpzOENaQjF6dDRM?=
 =?utf-8?B?cnArVEZvUVQySHI3ZjB5OW1BeVRZUEZaT09IeEsvTCtvWW1rejdqS0pKZ3BD?=
 =?utf-8?B?SmdXRWlOWFJZeittYTF4V1ZYenpFVTZBUWorQnNpUE03dGtpOTVXUjhhS25M?=
 =?utf-8?B?Y0R6VWJ3NU1WSTlPeWw3VXNQUE1Da21vQ202NmhoaGdxK3U2Q09yOUV3V0tp?=
 =?utf-8?B?dENBTzJhUThwK3FOUkVxUnJrWTRrbTQxK3JPUXFVRXp0WXhFYkZpbTJnUWRl?=
 =?utf-8?B?NXM3UXNLUjg3VjRlalZhK0huWVN1aU1nL2FPYTNvNk4rc3VWbFh3WUtXQS9I?=
 =?utf-8?B?ZzFTNHpJQm5zaUhzeTlmT3NxT0VtZEpKMTJ0QjgxZk5aelNHaEsvSVhSK0Zm?=
 =?utf-8?Q?6BHT6QvcR6ZjBImMvMPnxxE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA92473EFFB2BB498BE0291D0245C8AA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4372143-42ac-4cdc-61d8-08dc74aea0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:15.0089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wbXepameibmKyYB29GPJV8lTkOkpwbwcIYEHo0GPhV0iKO7rdMbhenr81dN5kIdruBvlXzukI6cH4hs7Y7Eb2g822zomxHi81+zeZt7xDVpNDAR+RI6LSYzPX3qAHFY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAy
NSArKysrKysrKysrKysrKysrKysrKysrKysrDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5h
bC5oIHwgIDMgKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmlu
ZGV4IDBlY2YwMGYzN2EuLjI1MjM2NDg5M2IgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTE5MTMsNiArMTkxMyw3IEBA
IHN0YXRpYyBjb25zdCBib29sIHZ0ZF9xdWFsaWZpZWRfZmF1bHRzW10gPSB7DQogICAgIFtWVERf
RlJfUEFTSURfVEFCTEVfRU5UUllfSU5WXSA9IHRydWUsDQogICAgIFtWVERfRlJfU01fSU5URVJS
VVBUX0FERFJdID0gdHJ1ZSwNCiAgICAgW1ZURF9GUl9GU19OT05fQ0FOT05JQ0FMXSA9IHRydWUs
DQorICAgIFtWVERfRlJfRlNfQklUX1VQREFURV9GQUlMRURdID0gdHJ1ZSwNCiAgICAgW1ZURF9G
Ul9NQVhdID0gZmFsc2UsDQogfTsNCiANCkBAIC0yMDM4LDYgKzIwMzksMjAgQEAgc3RhdGljIGJv
b2wgdnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDY0
X3QgaW92YSwNCiAgICAgICAgICAgICApOw0KIH0NCiANCitzdGF0aWMgTWVtVHhSZXN1bHQgdnRk
X3NldF9mbGFnX2luX3B0ZShkbWFfYWRkcl90IGJhc2VfYWRkciwgdWludDMyX3QgaW5kZXgsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgcHRlLCB1aW50
NjRfdCBmbGFnKQ0KK3sNCisgICAgaWYgKHB0ZSAmIGZsYWcpIHsNCisgICAgICAgIHJldHVybiBN
RU1UWF9PSzsNCisgICAgfQ0KKyAgICBwdGUgfD0gZmxhZzsNCisgICAgcHRlID0gY3B1X3RvX2xl
NjQocHRlKTsNCisgICAgcmV0dXJuIGRtYV9tZW1vcnlfd3JpdGUoJmFkZHJlc3Nfc3BhY2VfbWVt
b3J5LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBiYXNlX2FkZHIgKyBpbmRleCAqIHNp
emVvZihwdGUpLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcHRlLCBzaXplb2YocHRl
KSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhBVFRSU19VTlNQRUNJRklFRCk7
DQorfQ0KKw0KIC8qDQogICogR2l2ZW4gdGhlIEBpb3ZhLCBnZXQgcmVsZXZhbnQgQGZscHRlcC4g
QGZscHRlX2xldmVsIHdpbGwgYmUgdGhlIGxhc3QgbGV2ZWwNCiAgKiBvZiB0aGUgdHJhbnNsYXRp
b24sIGNhbiBiZSB1c2VkIGZvciBkZWNpZGluZyB0aGUgc2l6ZSBvZiBsYXJnZSBwYWdlLg0KQEAg
LTIwODMsNyArMjA5OCwxNyBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9N
TVVTdGF0ZSAqcywgVlREQ29udGV4dEVudHJ5ICpjZSwNCiAgICAgICAgICAgICByZXR1cm4gLVZU
RF9GUl9XUklURTsNCiAgICAgICAgIH0NCiANCisgICAgICAgIGlmICh2dGRfc2V0X2ZsYWdfaW5f
cHRlKGFkZHIsIG9mZnNldCwgZmxwdGUsIFZURF9GTF9QVEVfQSkNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIT0gTUVNVFhf
T0spIHsNCisgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsN
CisgICAgICAgIH0NCisNCiAgICAgICAgIGlmICh2dGRfaXNfbGFzdF9mbHB0ZShmbHB0ZSwgbGV2
ZWwpKSB7DQorICAgICAgICAgICAgaWYgKGlzX3dyaXRlICYmDQorICAgICAgICAgICAgICAgICh2
dGRfc2V0X2ZsYWdfaW5fcHRlKGFkZHIsIG9mZnNldCwgZmxwdGUsIFZURF9GTF9QVEVfRCkgIT0N
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE1FTVRYX09LKSkgew0KKyAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1W
VERfRlJfRlNfQklUX1VQREFURV9GQUlMRUQ7DQorICAgICAgICAgICAgfQ0KICAgICAgICAgICAg
ICpmbHB0ZXAgPSBmbHB0ZTsNCiAgICAgICAgICAgICAqZmxwdGVfbGV2ZWwgPSBsZXZlbDsNCiAg
ICAgICAgICAgICByZXR1cm4gMDsNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGU5NDQ4Mjkx
YTQuLjE0ODc5ZDNhNTggMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTMyOCw2ICszMjgs
NyBAQCB0eXBlZGVmIGVudW0gVlRERmF1bHRSZWFzb24gew0KIA0KICAgICAvKiBPdXRwdXQgYWRk
cmVzcyBpbiB0aGUgaW50ZXJydXB0IGFkZHJlc3MgcmFuZ2UgZm9yIHNjYWxhYmxlIG1vZGUgKi8N
CiAgICAgVlREX0ZSX1NNX0lOVEVSUlVQVF9BRERSID0gMHg4NywNCisgICAgVlREX0ZSX0ZTX0JJ
VF9VUERBVEVfRkFJTEVEID0gMHg5MSwgLyogU0ZTLjEwICovDQogICAgIFZURF9GUl9NQVgsICAg
ICAgICAgICAgICAgICAvKiBHdWFyZCAqLw0KIH0gVlRERmF1bHRSZWFzb247DQogDQpAQCAtNjQ5
LDYgKzY1MCw4IEBAIHR5cGVkZWYgc3RydWN0IFZURFBJT1RMQkludkluZm8gew0KIC8qIEZpcnN0
IExldmVsIFBhZ2luZyBTdHJ1Y3R1cmUgKi8NCiAjZGVmaW5lIFZURF9GTF9QVF9MRVZFTCAgICAg
ICAgICAgICAxDQogI2RlZmluZSBWVERfRkxfUFRfRU5UUllfTlIgICAgICAgICAgNTEyDQorI2Rl
ZmluZSBWVERfRkxfUFRFX0EgICAgICAgICAgICAgICAgMHgyMA0KKyNkZWZpbmUgVlREX0ZMX1BU
RV9EICAgICAgICAgICAgICAgIDB4NDANCiANCiAvKiBNYXNrcyBmb3IgRmlyc3QgTGV2ZWwgUGFn
aW5nIEVudHJ5ICovDQogI2RlZmluZSBWVERfRkxfUldfTUFTSyAgICAgICAgICAgICAgKDFVTEwg
PDwgMSkNCi0tIA0KMi40NC4wDQo=

