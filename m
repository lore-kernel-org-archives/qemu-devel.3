Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBE6C369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ajF-00050Y-HF; Tue, 15 Apr 2025 03:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4aj4-0004y4-W1
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:28:59 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4aio-0004zE-5G
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744702122; x=1776238122;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IJSzPBdZj2SF9/HYgHzpX/WywCP2SdWX7inrBHeOO9k=;
 b=YUhZNE1T9zX+VW1S0I2IKcnoluD3zaB1n1txLwg9gC+Ayd/Rb1Sku8jK
 43YtxxqGlKsG60czpuJ9OOkjOMkKmJdGfs9wd4IUerAEPXSCEVtmCX0zY
 3f5LDn9c99EyZMpMXcZ9G5N1U36ZwCSnhCYOlAtlv2Bt1YsTbFbUWFgPK
 Yg8+75vW7s3yFRTdqbdMVuJ23OLEh0zVPUO+4TFKf3I0He2QuJtQSXWT1
 cG/QOrly0mgKc/Vl1F7P2VHLdXAfKVELFH4c+w6TbvPg+vTBJ1lCWLP6I
 CqEeGrCnkBWL9D6Wi3XaPr2jZVJG9dzjhAetm77Q/qJQGfPuWRhSgYAOb A==;
X-CSE-ConnectionGUID: 1LAzLDhZSG+l+ZoDN7hl0w==
X-CSE-MsgGUID: drfdL3OsTr6nvPMnJQ457A==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; d="scan'208";a="35069432"
X-MGA-submission: =?us-ascii?q?MDGnT99gEwP+ucBhoychI5MSiOfio5XhJP6vid?=
 =?us-ascii?q?vGtRRl62RdQudmZDS1Uau0XhLj1awMwLyQHiQMiwzNrePxFVBzE0i6vI?=
 =?us-ascii?q?XukAA842Z8IkRkQGNvwrlO/S8i52hAz0Pl3TS9hlEJD92slBLQmeiFzN?=
 =?us-ascii?q?jXANz2mnN/UOm+AjhROxI3Wg=3D=3D?=
Received: from mail-northeuropeazlp17013014.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([40.93.64.14])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Apr 2025 09:28:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgnraUppEegjcwmgfUoODa56Rdg16IZi6cSXC5WPzJMpHeYiRHpds7fDQH+DsRVU1JhwTyQBPj0jjNPaASY/psWM7LUsHFvUQJXRQNrVuf6QMuzukrIBDJxTJtX4bmp68Lzx8RDlGI/PhzNBq8lv2IeCBmA5DrNLbW4XX+2DxphqcHexapYyIUCP7C7HK5+5E8pOUA7XjabiwR1Y2MSzqmvsh4sT28rK12cLj6m8mCCMZI7d1XYMf+7x+NBSJ6nBwdQv0kmAKHmapPcayi1VpCijwwT6lD0CPymQqy00a4GYh/VRfb6CjUoavwNCeFnYKpqYJWujqmO6O5F+rSuwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJSzPBdZj2SF9/HYgHzpX/WywCP2SdWX7inrBHeOO9k=;
 b=gcBNPEBnuSRcV91sX/JEogT/pSt4AC5pVU/g5n/tREOTlFNF7WoKH3Qz0lfBAZBWSNwEaG473yteqbdrIVxjh+AnwyXbmM8v7SYALZv8dEgiUw9zYshk4XuvpbkxjOjdYVZ9FQ99yXKlaDCMgeFLUQxKCi9o3Ho42ChNQ/LBomFMiVF2Qn4XiUrXSWd4mG5R7/AW1A+iCmIuHbYT7JGtAOllnkJh+NDyPb9QHNEWRZati8ibF4IQyLjqPRWQheXtNxaQc5nxrPXR0qqby4xXgl7vHlKQeFpRf/c/mePD1hoJhY0eNhF4Reyt2gIorPrb9royr52LUMNhTs4PcgRUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJSzPBdZj2SF9/HYgHzpX/WywCP2SdWX7inrBHeOO9k=;
 b=IrUPaz+gYrO9w9oNhZ1tzEc1ewxi2oxiD7uesBjHPgGsRzcBEhtpwu2wjhP4f3OcghcRli7P1qq6qAMif+JJAB+Ass49ZUrjpo4M0WVTUQgosxvXoi8yzsU7ToEvkmPPqii0/T5fUILpzv7fkg7b+peKeCIIXHezniIg2rM06gyOcQMBoa3shbpqE5M14ES8NiinVEuochif7f5QoVa3nb3W+bntEW0bNNWRqzbO0O9TONUqpp4IP2KQLwVHU/FAiG2/LBPfjZQa0wd0ZatfV1p46t1AaZ10tt8VPf6KjECr+LcGNUeKOfWKCZw8MkmwHZrwXJk5UAr6VmA5Snu4ow==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8473.eurprd07.prod.outlook.com (2603:10a6:10:36f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Tue, 15 Apr
 2025 07:28:34 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 07:28:34 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Topic: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Index: AQHbrc4nGIHWbw444Um4nXxoEvkhVrOkSoWAgAAJ2IA=
Date: Tue, 15 Apr 2025 07:28:34 +0000
Message-ID: <f3b38c07-f099-4422-87fa-32c78c7630a4@eviden.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <23c9f066-f30c-4e35-8629-504eeb9cd7a8@linaro.org>
In-Reply-To: <23c9f066-f30c-4e35-8629-504eeb9cd7a8@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8473:EE_
x-ms-office365-filtering-correlation-id: 42a0a2fa-eb5b-4485-a3e4-08dd7bef21a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWlCcnpsZmFjUGo5d0NSSkdFVWMyQ2RrTjdKVnBxMXdPTUNxdXE4Z0x3T0pm?=
 =?utf-8?B?ekwvK0s3d280NEpYVEcyQjJQa25aMjd3S25YUzNucHBWdGdTTjRiYS8xeFpk?=
 =?utf-8?B?blVRcEZYdGxrTzhzRFNpZnRzOUxFL3FlL3RmVFcvYkxiUFJuSkQ2ZFp5MGRm?=
 =?utf-8?B?c3AvM3JPbmZDakVrSXdSRnpCYVhwWnFyQTlpSTJRNndzY1NWcWc0YW04aHB3?=
 =?utf-8?B?enE1M3ptYnBFSUtTYWhLUGQyNTJldWVjb0lrdWR0aVNIbkxTSkRVMjdBNnJn?=
 =?utf-8?B?Mk5sYlJMUFRwNW9JWXlwczJiek5FNCtEK0tITEJOZ0Y2cyt6eTcyeGtUQ3ZI?=
 =?utf-8?B?TDcwRy9CWUdNVlBzTEJwYnFrYXBncFFqVlVDOC9ZdGJhUDdnaGRKUkpaaDQ4?=
 =?utf-8?B?S1JaN0NqSzVORWJpWnJMaUp5ZGpXQW1KWWRmNHhtd3paUWZPRktVT0wxS1I1?=
 =?utf-8?B?ZHl0VG02YjVHK21YVG90Q1NhZUYxYkUvRjd0Q2p4dWRnN2t0VTZvU3hiMWdt?=
 =?utf-8?B?U3JLa3Brbm1vUk01VWpKOVpOWGFFWXhCaUUwWTJSSjZLaDdvWnY3emFqNmtu?=
 =?utf-8?B?K2EvU0x0MmpMUEJGR1A5em1TNEZHZ2Y2T1hjYnZpZDAwR25FUnJuU2F0VDl4?=
 =?utf-8?B?K080WFhqREVhR0VacmwrU0ZEbzM2NHpkcVkyck9zeVZ3cVNOSG9VK2dOYlJY?=
 =?utf-8?B?ejZTeTArZmRLTnBJQ0VLR2xBeSsvWVZMSCtjZzFGTUQrSGpEeDJFelF2V0JN?=
 =?utf-8?B?bFp1Q2tjdURFdExGek9vWDNiSnhUdFhRRnB6VTBCdFZYM3BrYU54bWxzUERy?=
 =?utf-8?B?elNtdEs4TDJoamd4ekRraEhzUFlNdXE5dzVFVSt3bThLc1lRdUxMdStWQVdE?=
 =?utf-8?B?VVgzTHdLdittQ1NZRFlzWEtVUGUzMDNBMGZEb05NL3pqbmhCVVJsNmNncGxs?=
 =?utf-8?B?NEgzNXRvRFc2dXkrVytMYkROb3IyaXBGRXZwdkpXTXl1ckFkRmh3Mnl3RjVt?=
 =?utf-8?B?N3JPM0oyMXRJUDkrVzVqeE16bkJYMFlSWTVRSU0xWW04cFlldzBpVjBsLzgv?=
 =?utf-8?B?SzhHT0NWeHZtR1MxUGpOYk1IL3ZTVzZLbVdxVVhDZzkwRmRKZzlTNHlaU0dS?=
 =?utf-8?B?dE85b0ZvQi96OENqVngwRTY3K3BpeHkzNUxzb2NNWGxuM2taeFFTdGdWNkFw?=
 =?utf-8?B?TUFnbTY4SDl5SXpZTll2Z1VGazVXR0REaEpKTkFMZktyWFJDTXZQNlBIOS9R?=
 =?utf-8?B?NnU5citjVnpqWExUU0NBZ0lFRVNGSEZmVGwyZXFla2NQakU1bXFsYWI4V3dX?=
 =?utf-8?B?SE5qeFhmNzd1dzRVdzJnYis3YVhQYlpSYk1heDFqbFgzSjl2Z2hCU3hvM3Jx?=
 =?utf-8?B?VytoZ01aMWJYSUlLQmFmNHA3dnVrUU1sS3Zod0hselhUQWxZZkQ3dGZOWkZ6?=
 =?utf-8?B?TWJCU1JBZ0JCdmNiR0FPMkE4d2VEdFBoU0JGdi9OaFlkd1d4SHNtMXJSdXVU?=
 =?utf-8?B?SFhGSG96cjJpQzZNVyt5T3RDN0x6MDNjSmZEdFFmQUFXY3BXL0xsRFB6OTdr?=
 =?utf-8?B?VHd2bDBJWTNQdlMxRHQ2RisvMWYyL3ZuYTNybmZuYXJtQUFYY3RCd2xucWpG?=
 =?utf-8?B?OHkxSk8wY1hxVGMwNXFITzZ1dStnS213T2hHaElDbnRSWTVLVFBWdklHME01?=
 =?utf-8?B?ZVR6VnAxSXB4c1NRLzJZclZvNlhyZzNyZm5oWTBjS0k4ZFJzM0tvOVBLRWJw?=
 =?utf-8?B?Si9NOTZzMVg2U3I4VDBHaDJFeThGaXhOd3FrU3hZQzBvYUdOckZ6NkxUaXp2?=
 =?utf-8?B?MGt3SGlnS0p1NWt3cHZZQWtRRlo3VE8ya1NQdHcvNEZhN2RuZGhtd2pzN1ZL?=
 =?utf-8?B?UVhJSjZxWXZHSHFZQU9KVHpiSmpBRk1MVFg1bWlBUE5jWHBFckgyalBXRXRG?=
 =?utf-8?B?dnBpQ2hQOWlLRWNrSVhnV0dndUR0cUQ5STZSZEJRMHFwbnFkMGtvdmprUlVZ?=
 =?utf-8?B?aTBEaXNqY1l3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmRUQ1V5VnNROER2cG93TVhhd2t1U0VtQXR6TVNjME5YUzNPOU42V1hQeVJv?=
 =?utf-8?B?dUxyWTJTODlHemhqQWpzeUpxMHA5SS9VRVh3ZnJpaFJGZ0ZBMUh0bFRqV0tn?=
 =?utf-8?B?QmoveTY0N3VJRkNTTkQ0aVF2VnFaUEhGYytVNVU5TVRnTFFna0pMc01yTUFL?=
 =?utf-8?B?OSsxaW42c1NyaGc1S0lDNzlPK3VySWd5blplcmdNbnI3WmpUaXpIYUduVVZO?=
 =?utf-8?B?Vk1GRGFwUk81RitqWXQ5MzQ5T3d5dG85Q1B2S3lya2dpcGZUbEdRY2UxWGxX?=
 =?utf-8?B?WHYvbnFXQVZpVjdwWVZnbkN3a3BaV0Z4d0JCODZQSW5nc3dONy93bnVXSUJj?=
 =?utf-8?B?VkRrZS9rNHpCa1lka3ZHckZoMUhPT1RndmZ6Q25yV2pvbDV6ZmYvUkZwRy9Z?=
 =?utf-8?B?VXlKZE5Oa1RaZVBxOGVvcDdhZmVOZ29BdG9TaUdiMGNxcVlFV2I5TTR3R2Fz?=
 =?utf-8?B?bFNiRVVIU2ZQYzZ2U1E1NVlmRk92V0NsUjdMVnpRV0ZkS1lGQnk5OURXVENV?=
 =?utf-8?B?RUFJZk9zeGFVM08yMm5HUzdhVFNWbkNPMHhBQmo3dy9DSGpKbzFhYVNtd0NY?=
 =?utf-8?B?R0JEUW80dERQZCtEcWprZnpHakFkS1N1czVqNGx4WE4zUjIrNXJ1ekk5S1lO?=
 =?utf-8?B?NFRhM2Q1R0xFQWhBeDRsTzg0RVpJV2s0T3N6Q0ttNEF0R21ra2hxeEJIK080?=
 =?utf-8?B?a0ZWcnhEUm5yLy9mTXIrc2RONm8wUHhUeXFQNmt3Vlp2djV0dnhOb09UVTVk?=
 =?utf-8?B?RVp3NEtWK2tsNnZxaVJTcGM1ZDBSSktqQUxxTjBxanpCMXJ0UWtjR2k3bmlv?=
 =?utf-8?B?bVhwV3lOdmI4Q0xhckEwazF4NmdmUm9FMUNPYXVzbXJhU0J0V3JHaTdFZVlu?=
 =?utf-8?B?THF0SjA1d3Z4V1djV2V1NldqYWtHS3JzNzVMaEdiejlVUVBTS2dMTEhUam5l?=
 =?utf-8?B?alRoZkExRFZxSnJqRzQ1b2gxa2N1cGV1T1dTWUN1QlkwN2dta0h2RW5ZYWx2?=
 =?utf-8?B?N3NuVkkwZU1nZ1ovS05hTXduNFRZT2xzNVhHZSttd1JFaGp6YjlVSVFXN2xL?=
 =?utf-8?B?c01EOE90YmhSRFZadThnN0RKQTZmeHZrNUZYM2hXeXplTFNUeFRGM2ErRDk5?=
 =?utf-8?B?bTJLVVJZY0dlaWF6Zy8yMFFKMXk0Z096L1VwRmNoZklxL3BadjR4NERQZVd6?=
 =?utf-8?B?alBQV0pSZlZQQk5GZTF5d3pXSHpXLzE0UElGOS9mMDRncnRXZEFUL2svdWdT?=
 =?utf-8?B?MlVNQjQwbFBHeXZ6eHlCRXpuay9mamlIYVdVRE45WW9lRFdnRmY0bm5RVTd4?=
 =?utf-8?B?Z1l5YXdtNmFxTVdFNVFVVW9JeWE0ekVFTUVqUVVtM1lwQkFNZUpVWmpITW9R?=
 =?utf-8?B?R3ZJdTNyQTg4UTNLc05qOFZzYzlMTWxwVE5mamVHdC83czBZS09jMGJwZDQz?=
 =?utf-8?B?djdkcXBISG9ncVZ0YndBcitpRkhFSlBiYUZnQy90R3ZGVUdpMklNZGo1S3Nz?=
 =?utf-8?B?V1ZHZVpmMmpNdEtQcVZFSjZENzczMkduaWNhZHFlZGRvcjZZcm53SU9rRXRa?=
 =?utf-8?B?K0g2QlNxS09MK2ljd3ZYaXg2ell4dlZ3OUhCZkJFcFdhUjExTmwwUCt3UWpY?=
 =?utf-8?B?Q1FpazhVVHN2aWlsZjFQUWhyd0Q4dVBNVytDdmt0Y0Y2c2ZXL0NtN0d0N3Vr?=
 =?utf-8?B?eHZXdVVha0hFS3FQY1lSU0NSak8wbEpQaG8wK2JtdEFnaERXM0xZQWxKbzNR?=
 =?utf-8?B?SjlBSDNSUWpic296VkdYdUVtTlU5bWlZY1YyQmxHUDhCeUpSd1RkU05VMU9F?=
 =?utf-8?B?T0NudmN2VzlUcnE4U2JIRVIrSTRFYXNtTDUrL2paRHcySnEvZlNoSjY2bDlW?=
 =?utf-8?B?Q1YzR1NYTE01YVBOYUY2WXdpOHpoWTUwSE9jMFhNQ0ZEbXVkUGVGS0RuNElp?=
 =?utf-8?B?SlI5UjJCVkNkbk5uY0dGYXp3QVpwWURJOEhMZDFlWWRyVGpWTDQwRzZzZm5y?=
 =?utf-8?B?UVZPbi9KSnVLZkF4OHFxVDNYN3pJVGIrQ0FyYm5oQ2t3Y0UzY0dlOWdVcHlR?=
 =?utf-8?B?S1dMM1BycFU4alYyeENNYlRFcTJtSVhYNml3aFlKZDNyL2pqNXZYdExhaWVr?=
 =?utf-8?B?ZGtHVzVpblhnd0sweDIrekJxRzNucDZqNmNEd1VJVTRBcWVqeUdicDQxQ3FF?=
 =?utf-8?Q?ZZY4nHsrcQ2yoimZG7+vEw0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3568407AB8500544A7FB65C324EF43FC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a0a2fa-eb5b-4485-a3e4-08dd7bef21a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 07:28:34.7840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wWFIuuxuSVu31sXiDIqtauwtDpaVPoGGnavTWRxnxo0jlP5WwddCJuE9iyngVnEC6nmy09aeDQ11WN503nCK+dj4bx+CDW0E1RXf1byl4Th6GOC0yChZhIjCirIbz/0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8473
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

DQoNCk9uIDE1LzA0LzIwMjUgODo1MyBhbSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6
DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBj
bGljayBsaW5rcywgdW5sZXNzIA0KPiB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5k
ZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gMTUvNC8y
NSAwODoxOCwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4gQWRkcmVzcyBzcGFjZSBj
cmVhdGlvbiBtaWdodCBlbmQgdXAgYmVpbmcgY2FsbGVkIHdpdGhvdXQgaG9sZGluZyB0aGUNCj4+
IGJxbCBhcyBpdCBpcyBleHBvc2VkIHRocm91Z2ggdGhlIElPTU1VIG9wcy4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBDbGVtZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tPg0KPj4gLS0tDQo+PiDCoCBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxMCArKysr
KysrKysrDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+IGluZGV4IGRmZmQ3ZWU4ODUuLmZlYTIyMjAwMTMgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTQy
MTYsNiArNDIxNiw3IEBAIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9N
TVVTdGF0ZSANCj4+ICpzLCBQQ0lCdXMgKmJ1cywNCj4+IMKgwqDCoMKgwqAgdnRkX2Rldl9hcyA9
IGdfaGFzaF90YWJsZV9sb29rdXAocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLCAma2V5KTsNCj4+IMKg
wqDCoMKgwqAgaWYgKCF2dGRfZGV2X2FzKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IHZ0ZF9hc19rZXkgKm5ld19rZXkgPSBnX21hbGxvYyhzaXplb2YoKm5ld19rZXkpKTsNCj4+ICvC
oMKgwqDCoMKgwqDCoCBib29sIHRha2VfYnFsID0gIWJxbF9sb2NrZWQoKTsNCj4+DQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgbmV3X2tleS0+YnVzID0gYnVzOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IG5ld19rZXktPmRldmZuID0gZGV2Zm47DQo+PiBAQCAtNDIzOCw2ICs0MjM5LDExIEBAIFZUREFk
ZHJlc3NTcGFjZSANCj4+ICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lC
dXMgKmJ1cywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2dGRfZGV2X2FzLT5jb250ZXh0X2NhY2hl
X2VudHJ5LmNvbnRleHRfY2FjaGVfZ2VuID0gMDsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2dGRf
ZGV2X2FzLT5pb3ZhX3RyZWUgPSBpb3ZhX3RyZWVfbmV3KCk7DQo+Pg0KPj4gK8KgwqDCoMKgwqDC
oMKgIC8qIFNvbWUgZnVuY3Rpb25zIGluIHRoaXMgYnJhbmNoIHJlcXVpcmUgdGhlIGJxbCwgbWFr
ZSBzdXJlIA0KPj4gd2Ugb3duIGl0ICovDQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHRha2VfYnFs
KSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicWxfbG9jaygpOw0KPj4gK8KgwqDCoMKg
wqDCoMKgIH0NCj4+ICsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1vcnlfcmVnaW9uX2luaXQo
JnZ0ZF9kZXZfYXMtPnJvb3QsIE9CSkVDVChzKSwgbmFtZSwgDQo+PiBVSU5UNjRfTUFYKTsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRyZXNzX3NwYWNlX2luaXQoJnZ0ZF9kZXZfYXMtPmFzLCAm
dnRkX2Rldl9hcy0+cm9vdCwgInZ0ZC0gDQo+PiByb290Iik7DQo+Pg0KPj4gQEAgLTQzMDUsNiAr
NDMxMSwxMCBAQCBWVERBZGRyZXNzU3BhY2UgDQo+PiAqdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9N
TVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9z
d2l0Y2hfYWRkcmVzc19zcGFjZSh2dGRfZGV2X2FzKTsNCj4gDQo+IFdvdWxkIGl0IGhlbHAgY2xh
cmlmeWluZyB0byBwcm9wYWdhdGUgdGhpcyBhcmd1bWVudCBkb3duPw0KPiB2dGRfc3dpdGNoX2Fk
ZHJlc3Nfc3BhY2UoVlREQWRkcmVzc1NwYWNlICphcywgYm9vbCBuZWVkX2xvY2spOw0KDQpIaSBw
aGlsLCB2dGRfc3dpdGNoX2FkZHJlc3Nfc3BhY2UgYWxyZWFkeSBkb2VzIHRoZSBzYW1lIGtpbmQg
b2YgY2hlY2sNCg0KPiANCj4+DQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHRha2VfYnFsKSB7DQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicWxfdW5sb2NrKCk7DQo+PiArwqDCoMKgwqDCoMKg
wqAgfQ0KPj4gKw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+
dnRkX2FkZHJlc3Nfc3BhY2VzLCBuZXdfa2V5LCANCj4+IHZ0ZF9kZXZfYXMpOw0KPj4gwqDCoMKg
wqDCoCB9DQo+PiDCoMKgwqDCoMKgIHJldHVybiB2dGRfZGV2X2FzOw0KPiANCg==

