Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465FDC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPghv-0006Wy-9T; Fri, 05 Jul 2024 07:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghq-0006TF-Qn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:23 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghi-0001Tp-RE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720177335; x=1751713335;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=la8b6EsER2myyyqfK0mnc02PBu9H7RQtt1F+MmsewQc=;
 b=Yk9clPNgKwnATra+AZdbg/p4YN5QVltoGXVGNeLJVq8oMbKWD/x1ziI1
 gvelaf2+SYbFE9E78a7qunX4GG/CCbvkpq5s2k9PTpZ45tSTSsGJYDmVU
 LSvVQr4yNzGSSsmZgYElSUSOSIDS35PxLJsv4fmxBGjlMYJcrzFrK3jmo
 nB6Id9SzaoPdE8pbTnzjyCgcNa1Z8uSCfTdU0U/LSoSJr12Kfc3dNahVF
 tofh2rgdlF+564bF+yHz7iq4bT/Yw5eonBclg9jaXUMSkZTadCDBe7t4h
 7woyoxvwXFL4dJ5pRMHx/br9o5Go5LaRRol2XCe0CjWTV+Doae71RU5ma g==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="16056529"
X-MGA-submission: =?us-ascii?q?MDHy3uUudlM5pFoU4fo48EyQ9kstlmK1+5CpBH?=
 =?us-ascii?q?mNpzrvdopxkoKQyWigHf3CztWdxtzp9XsQd227AihOHmgDn0iw4aBijx?=
 =?us-ascii?q?MHIpePeJZYXf4eGMaHxb3buEQVOCzDYhkmwfBNvLxIXkqd44SHpHZ8AS?=
 =?us-ascii?q?vhooBqMUGUtTAHMGrpGjoUog=3D=3D?=
Received: from mail-db5eur02lp2104.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 13:02:04 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbNLgvMRDz/bzwba75+Jr6K25BNrzo4243mA7YYtZ0rSxKPpNn/s/YuEIv3N+qhIuIsb0lI/cA21hPAdGhvBcsrxC0bXWTClEo/1T1g3tFU0py+742LJJMkgW/26zMKAtmzUj74Ti0o6BFQis/SleGzx5LOJP6SILdD+M9quvjcQs1bol5Vf/ickvrN1snZMNFKTpYH2QBPtZbcNU1aoPwjy2vEgFkukRt8dq9JEQFVqt0EVx4ohBP1uQTd3rQuq1kq1mQ6yeLo2bADEJwf7QKSpU4fav/nsWtv0QO0QtCMsWN0wCcx5hJAeAVNHcjTS9cmMWk+goMRaK3w83GFjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la8b6EsER2myyyqfK0mnc02PBu9H7RQtt1F+MmsewQc=;
 b=m36D5/QAm6VmOCn08qg0+l2wiadlSOxGRqlrl1d1nTdOGkU9g8hORW9M8pyhk/QfL9Apx2F/7nWBU8nAWrEod/JE0hn2pQfDA5rHIT+2byyBv6AvnyzTjWvd+GIRh9OkKm4tB/upe0KqX694udw2cxrbPy9JAl3lGtcmm7pkBxKDV74zIfRq7vdoSiTywX8qGWz0HHhj1RqCWu9ertJsLxC/oW2YgZ213VzWuadhAumqKqbp2iRRDf9qCRlj3ilIz8LegDOrk0rH8O2LVcqPmI4aNN6jRo9r3hZDW2LWl1cMND95J8bY/2kUvwlSNrM4JYd9ye7piXm5/JO2OrOT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la8b6EsER2myyyqfK0mnc02PBu9H7RQtt1F+MmsewQc=;
 b=R07i3oAujca48BoSbJZFJHsZnkmcvpTuuX2M/trxsD7EQSqCnPDJ9fb8JwvP5J64+jSaxVcreU5Euap4JFsKdiX5vmd5/JwulV5Pdsci4vgUOxxyRI3e2z6Op6czzjQ1NHxg+1GvlfWzEmvsGZpq9vtgV6o2iNbk96vrj3akxsXdegZ4xntUdG1ACgSSU4gHJHzC5JnjM8E+X7roHtoJ7nAr/m5MrRTWRPI/vrdV1GTPr+00qJWMsWYjaklVSDKtLXSMBKkvhJSBGX47wilyNUFghUv6yCra/UwAcYhkPK3Y6kFAntOxkqXK42dryL/bewtsYV/P9K4sFbJbgBxTJA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9502.eurprd07.prod.outlook.com (2603:10a6:20b:649::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25; Fri, 5 Jul
 2024 11:01:59 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 11:01:59 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v4 4/4] intel_iommu: make types match
Thread-Topic: [PATCH  v4 4/4] intel_iommu: make types match
Thread-Index: AQHazsrBg81pTYUcukGJyjgjd47O+g==
Date: Fri, 5 Jul 2024 11:01:59 +0000
Message-ID: <20240705105937.1630829-5-clement.mathieu--drif@eviden.com>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9502:EE_
x-ms-office365-filtering-correlation-id: 3f7bc1ef-9fc9-40d9-1a94-08dc9ce1e47e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmRteW52cVhvSXF3ZUlUdGREVjZKZ2Fra3dzMlM4d2pHUUh2aGVSelZrMHZY?=
 =?utf-8?B?TWZnVGZpNEZWS3A2WWgzeGkyaEVFVXBoZUhkMHN5RmMyNm5tSXZ6YmxBczQ0?=
 =?utf-8?B?cEdJbURrZnNLZXBSMGlldzJpYUQvV1M4Nk1aMG9jTmRzSHVMblhXZndrTGd3?=
 =?utf-8?B?Y3RHeDlBZHFoak1FYm1MT0FGOEZZNWNTTjFIOTI5Nml2dmlhYmFsTlIxeVZ3?=
 =?utf-8?B?V1FPWFRNQ0RrYlFkOW44M2E4cjdWLzZqTlhiNEZIenBEL1N4emh1eGdSYXd4?=
 =?utf-8?B?YllmQVplOEI0R0VoTm02SnJDZnVncG9yOEMvdzBEdU1sUW1kajM4VWEzV2Z3?=
 =?utf-8?B?eVAzaGptVTNseHNYaWROSHhlN05MMkpma25hdzhsL0dpRHBBUWR0YzNzZmRD?=
 =?utf-8?B?NEhPUkVXK0ZiT3plUHR0NU0wSVd0cFR0K1BxRENxSDRHQVIxRGplRlVzOFFn?=
 =?utf-8?B?M3VoTWZRZWl3WXEycVprMlVxbGVzVFNackRNbzlMKzBJODJjV25rQ0E0TVVH?=
 =?utf-8?B?aHB1cmt6TVg3ZzlrcUdRT0RMNVZMeDFMZDZwdjFGNC8xbmhJdDM5cVVXOHRy?=
 =?utf-8?B?WHE2aWJ1RUZJL3lxbHVjRGlqWDhvb0hqM0FHeEoyemxjTGRIYXQ3b2VBMzZC?=
 =?utf-8?B?dTFuVUozeHhIL2N2MXNGbVpPR2krWUpFa3hnWUh4Z1hLV2NBMHh0dzR6Y1JM?=
 =?utf-8?B?ZnR2MTNqdnhWWW1Cdmxwb281YU93dDQ3UzNsK1ZFTHFXSVpmTTZUUVNWMW1y?=
 =?utf-8?B?MllHMjlZWjVIVXRVTEFERUpCLytxK2xoQjBBbVI4alQyMjVOUnBsWEdVblZQ?=
 =?utf-8?B?aUxMY2Q1cmRoSGFVV0pYUTlLTDJXSzRuR3luNTROb0EvL0pFMTNaNHJCV1pR?=
 =?utf-8?B?TkdiRVNnbk53cHBMZ3U5MGdmVVBFc2NvaHlwU05xb1cyZ1REMzFkeVlDSEdU?=
 =?utf-8?B?bWU0WDBNQUlDdkxBL0hDM2ovRDdrZU5oNHRDdUdTTWhWcFc4NWd3S1g3N2s5?=
 =?utf-8?B?T09rSXVrVUhWWW5SdEpPRlMrWm5Uc0hxdURFT3hLMGdyTjQ4UXFSLzBPdzRa?=
 =?utf-8?B?dituMmxlb1h1NUk2UXlMaUJibjNFQm1lYU1CNmhVRzFVOTVBTFB5NW44MEpq?=
 =?utf-8?B?aUdvbEdtcjVRa1BBS2VzUlhiWGV3d2xoc3B0cFY3OHk5NXhrdzMxZzA1dEdX?=
 =?utf-8?B?eGw0aXRnYVhkc3BiMHJHSWtUcXk1WFI5MUpCL2dJOS9FRCtvTnlkWXkrbHl1?=
 =?utf-8?B?WDdIeUJVWWhpOGlIZTQ5Z0l6ZjQ0ZGI4dW1TbWt5WlZVY2EwNVNYbmxFZFdL?=
 =?utf-8?B?Wm5KMFZNaytUM3U3WW5xN3I5YWlHY0t1clkwb1ZacWpFaFgxRzhQVmdZMGxw?=
 =?utf-8?B?azVGSzArdmRBYmpUL2EvcWxLQ1ovNy9iT0gzbE4vc1I4dkhHM0FpUFFCZnRK?=
 =?utf-8?B?VE95azRtMlNRM2ViUUU4K01BdGNXTFFXc21IaC9YTDlQSmRlSTd2MVllZllt?=
 =?utf-8?B?dmRpa0RYRmtGeC9uYW0wYndZbG45aVlCdDRrRmxSWlJ6TEhYdjFvS0Vvb21U?=
 =?utf-8?B?UnpsY3RrQlNDL1FETnh6d1lZMFAwblZKamlQcE14clFQYUphQUtnVEFxQnhy?=
 =?utf-8?B?MFllYzAzYkV4VFRyOWZKRFNXVlI5STFOZWZUYnVKSVpaNy9TS01pWERNdkZN?=
 =?utf-8?B?dHZVWVNnYk5LbjZOZ0xtNlRQaGFPSzFaaEtLVWlmTXBDRGVaaXZvY1JnNjdV?=
 =?utf-8?B?K00rSFZqMDROTUNPd0o0Q3RveE1GVmdCVGp1SllOYTdQYUd3a0RZa3VySFRq?=
 =?utf-8?B?SVMyY3QydFVNcjZ0Y3VnWGVHR3cxWTR3YmkxeHNlcHIyWHZhUWZTUTVBQjAz?=
 =?utf-8?B?d21jWlNwTVcxbGdmMHhhMm0wOXhVK091ZE9hd2hoVzhDZ2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHNvSkRmNkFyTVdkRG1jNHJSeDd4TEFmSHZSbXRwQjJDWkpUMlZCbGxuUmtp?=
 =?utf-8?B?c1h0eWZicFhTT0pqa1pyeStjSDZnSVFib0ozck1hT1N3L1ZveXlTQjdLaEM5?=
 =?utf-8?B?UFF1SGZWS1kzblNoNlM5ME9NeE9uZUs5d2dzb3d6WjE0Wm9pM3RhK1NXeHJW?=
 =?utf-8?B?SWYxdzUzSktwZjg4WnU0S0hZM09MMmliQVhyT2IrYW5zSCtMQTB1RUFpRnoz?=
 =?utf-8?B?R3FrUFlhb3hGdjlwU25FNzcyVWJnMWZCKzdNZUlhZER0bDRSbUNybTlRdi80?=
 =?utf-8?B?aW45RnpoMjl6eEtyVWNqYlV5cjgxanFCU1Nod0xQTHFndGx2L3VSNldicitQ?=
 =?utf-8?B?SVVyMEVaN0lzVGg0eUZnS3p2Ymg1SkhTcXFaZkJ2dEFWNmkyOEpxYlVDbENX?=
 =?utf-8?B?MGxMN1JtUXc4UThIZkQ5eVNaT05TNTRsVzhITGxJY2VoUVIyTWxpUEptMytH?=
 =?utf-8?B?S1dOajk4bUQvU2J1UEMySythRDN4WUNqamVDNVZ0KzBreDFLeVQyakJESkk4?=
 =?utf-8?B?a29oKzl4VndLVVJaRGs4TkNEemVTdXN4Vk5PNHpZWXN3TVdRbXV4YkNMUEZr?=
 =?utf-8?B?UDc3a2lVU3J2RTdTaU4rSzU5UHExcWFmWTliRG1Ec1dnZVA2bktWWEJycG1B?=
 =?utf-8?B?ZEV2NTZBc1ZDeEx3dVgwcjVzNVJheDBGRVl2NkdvNDVHcHZsNnhISE5Dem5l?=
 =?utf-8?B?YlU4SnJVZTdrUzczOS9TVFZlbjdxWncyakRtMk1GRTFHL2plTDkyZ3hJbk1N?=
 =?utf-8?B?RXRNK2dIQWNpM3haaDBaZ0MrdTFTOWsxYXZVQkdjYU9VZG1WMHhSMWF4U2xK?=
 =?utf-8?B?bUFFakoxTnpCVXd1dk1pMUZtNjZHc3hZWDNVcFdFOWlsZ3BGMTVEWXJ5V3gz?=
 =?utf-8?B?dlR6aGJaR1ZiNGxGY084ZElnK3BRcWF4N05JR1g4ODZZWUxrN204UmFRSEQw?=
 =?utf-8?B?K3ZnL0w5WFhDbGd2blh1OHNBUXJIMHRURGxEeGdGTXgxZVpLM0dmcW8zdGdx?=
 =?utf-8?B?Q2t6V0ZuTEdUeDNkRWVJeXFuTnUxNGZRY0s5SFNLb2xDenRjNnFUY2RldHJq?=
 =?utf-8?B?QSt0bTVmVEtnSGZJeHNKWkZ4T2U5SGZrUXU5cmxLV21wTDdTUzJ6dFJBSS83?=
 =?utf-8?B?Zk04TnhWYUFhWS9CU1dyR1Z5WDUycXRZUnFrZVd3b1l3dE0yTVVsQUgwOUI5?=
 =?utf-8?B?TzczRTBuT0xaenQvSTVEcll2dW9kK0V3a252ZS9YTThBVTVSWlJ2VmIvSnVa?=
 =?utf-8?B?MHkwNU5CV2ptM3lxNHFCQjJPVmRMeXpacWJwR3FBa1pBNUQ4N0hJelVqb2F4?=
 =?utf-8?B?TDJxTVYzbm5SZnhuMTVYQ2hpZXZjUVZEY0t0MFlvMm94K1htZHRKNWQ0ekdx?=
 =?utf-8?B?Tmg4RWFqNVBlSTEwUTlWQ3cxNUdsM1liZVlFTzBqbWk1bHlBaGgzMG5kSmdi?=
 =?utf-8?B?MEVKUExNdllFdHYvOTdFUVlyTnFTMmxqM01YVTE0Um9hdUNyM3R2eU41NVc0?=
 =?utf-8?B?K2JXTWo5TTFOOGprT3hBcVEvRDNxTStSQllPZFV5cjhDTXVwU3ZkLzlPcUFH?=
 =?utf-8?B?bmRHMVNybjhOOHE4Z1hrVStRS0JlSU5EeDBMUTZvZlVUY3BpWUF0S2xjcGN4?=
 =?utf-8?B?THBOU1dWaWF3Q1VXbzd1V1NOdEhKTzFpV3BkdXRUUHJBNTI4QVRPanFpYmUz?=
 =?utf-8?B?cjUrclVLNDNZakE5eFhJT0ZhR002Uk44eVl6b24wOXArb1dmV0NUTVRSNWM0?=
 =?utf-8?B?VGdzVmc1dTRuNmd0S1BVclo1NVJNVllXVmp1YStmMUpCS2U5V01xOE5Yd3Yw?=
 =?utf-8?B?U3VGU2dCTUNMdmJtZ2pxSTlhYjl6M2grbmlndlZEZmZDaE0xTk5UblZUTnBv?=
 =?utf-8?B?STU5cGtQYnhKYVZqYmFMRHU2b1graXo3M2N1WTV0WTQxYU5MRDZmR2xTR0Yw?=
 =?utf-8?B?WSs5WS9yb0d5RFYzUmZnd0RZZHBFdy9CdHd4Qmg4ODY5eFVydU04QVNZQ2I0?=
 =?utf-8?B?UDZZTjlhbkNZbzdhVEdDUjZEWHhrSEdhQjl2ZVpyWmdPYkIrM0tKWXV1VkFu?=
 =?utf-8?B?MkdlYlFLcUhuYkpWL0l6ZVNrNlBJOS9RcVlsczZWakRGOGNFUlpqZXQydTlx?=
 =?utf-8?B?UVFqT250MFpMNjk5L3Z5cjVMdlNMcnBrTFZxOE1JRURZL0FMV3FLN212ekRo?=
 =?utf-8?Q?Y5nYMG4k91Kx4r8kVPK10wQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4FD49D6DD994546BBC23B682ACEB782@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7bc1ef-9fc9-40d9-1a94-08dc9ce1e47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 11:01:59.4215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FOMf2aYdpCjxOalsEVa8iLsRKsqjE1W72yF1iaYLmydGzb6mfDAVTiqoJBLn3CAxMEeL/X7dKBwVLgZ9pVvEvRAzKuxPNHdokU7Nqk7pQrWCirSVEO3/7T+x81CZges
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9502
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSAnbGV2ZWwnIGZpZWxkIGluIHZ0ZF9pb3RsYl9rZXkgaXMgYW4gdW5zaWdu
ZWQgaW50ZWdlci4NCldlIGRvbid0IG5lZWQgdG8gc3RvcmUgbGV2ZWwgYXMgYW4gaW50IGluIHZ0
ZF9sb29rdXBfaW90bGIuDQoNClRoaXMgaXMgbm90IGFuIGlzc3VlIGJ5IGl0c2VsZiwgYnV0IHVz
aW5nIHVuc2lnbmVkIGhlcmUgc2VlbXMgY2xlYW5lci4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1l
bnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0N
CiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDM3YzIxYTBhZWMuLmJlMGNiMzliNWMg
MTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KQEAgLTM1OCw3ICszNTgsNyBAQCBzdGF0aWMgVlRESU9UTEJFbnRyeSAqdnRkX2xv
b2t1cF9pb3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9pZCwNCiB7DQog
ICAgIHN0cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9UTEJFbnRyeSAqZW50cnk7
DQotICAgIGludCBsZXZlbDsNCisgICAgdW5zaWduZWQgbGV2ZWw7DQogDQogICAgIGZvciAobGV2
ZWwgPSBWVERfU0xfUFRfTEVWRUw7IGxldmVsIDwgVlREX1NMX1BNTDRfTEVWRUw7IGxldmVsKysp
IHsNCiAgICAgICAgIGtleS5nZm4gPSB2dGRfZ2V0X2lvdGxiX2dmbihhZGRyLCBsZXZlbCk7DQot
LSANCjIuNDUuMg0K

