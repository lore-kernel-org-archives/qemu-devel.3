Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF6606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=kc1Vk0KQ;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qi5sBv69
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJQE-0005e6-0R; Sun, 22 Nov 2026 21:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJQB-0005dN-V1; Sun, 22 Nov 2026 21:04:43 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJQ9-0003mT-TG; Sun, 22 Nov 2026 21:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795399481; x=1826935481;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=l3pCeZi7RGKJ59zSKQ1H+oQCiymUZICePINNvAGW8pA=;
 b=kc1Vk0KQQ56MG34DpgXfpQEiDZvMEV/HvSn9T16yIRSimjveQJXWX+2E
 RnUzouSiOZA1x5rYB31qjS5OdnDS6Oad1FZCLrKiDZ4nH9RE1t7510mhx
 B9CRdcbpH4LSwVyrellH1igaiiIcM713lF4+HSExGBbG8gAGHrXHAfER6
 NwdTwaEfJBYkOEG5pKAN3FcKmZitCwB88plvoa0kBb1MDiv8aHeuzexpo
 OKjvIoP9kY/aSfqQL5cvqd9lt51JKjN2VIXfMyjvFskirhgUyPkvmCXPN
 PQctcFd9rkwRDytV0prB4WJahiFVxdzfz2XpxZBoitmAYOpBiO7Iuyv7s A==;
X-CSE-ConnectionGUID: N8hC1vRrQVGSWnzoHTy7kQ==
X-CSE-MsgGUID: 953NojBYQcCGfYkbFdQdXQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="159903493"
Received: from mail-westus3azon11012061.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8Uv9tveAd5hM+pVD0RzH7teWu8QAQ4ogpDvfMgZdblOplOoO/OIXiZQtrWSU8JRlhPg8M4xPKJbT+0eUW2bioheJoJqwijW73ckI/ud23UOVpj5ySGt+/yzxVD1FAUJ9P2az6Qg1n8J57q42q2GxfwSTMG1lWBWHEvzZdD7gV76PTWl3nq4M3rDVfb/Vu5fndRXlh6wHGXW6dld4c+gBrwB97tGGajQXWyBoi1fwUOwuQYl4+i9hHdA7xlGTBOrumMkq+prpnThGDFK6373efKYyw78t/LsfjLdF8wEJEbu2TwcxYOBpUzsGAUHSE6bB/u2gEPnJeYBQQmws5MxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3pCeZi7RGKJ59zSKQ1H+oQCiymUZICePINNvAGW8pA=;
 b=PV8mUyez2XQv8eLq4ovwGVqNg1uNBPkgARqv+roSlK1fDxT1ENsqKh5VsB12y5BK63C0QaFSF2ZkJ7lPh/jotrN12qSuePVD99Pme/e2HfDNpwkA6onk21e104ARlxJCnjDDIu52O5SjhcZcV8f/2LLbkgaDUWEXcRbwsheQpQKWVqiXRI+d4b1DxxWQmPtcXmdHZGxEJEHA6A8BmVF81kIKvSAzQRlZEAJdNHomsaGHGCx9hVqwsAqF5pbrmOdnEQARi6kRop2zp4UWWQBnI/q/F88QjE6ILJaFuDXyaqPnG0Gkawv0Gsarf7xsju5o4xVjF6zoURWd++Vx/5Nqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3pCeZi7RGKJ59zSKQ1H+oQCiymUZICePINNvAGW8pA=;
 b=qi5sBv69jqLdSs4DLOA7jiFESdP2Ls+hqiM7DreEmRzFTXJSM0y4N84GNR4ieqyS5AJ0VJWZeJb4GqBYQNrALz2zG41FEjJPxScsFHp3krcwr+/xE42G2jppceCOX29bh5nYwFuTsmgpoDYfA9giro3awIGC9ceFtinXfCqPcMY=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ0PR04MB7485.namprd04.prod.outlook.com (2603:10b6:a03:328::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:03:38 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:03:38 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "christianslima@proton.me" <christianslima@proton.me>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v4 1/2] target/riscv: change mstatus bits for read-only if
 S or U unsupported
Thread-Topic: [PATCH v4 1/2] target/riscv: change mstatus bits for read-only
 if S or U unsupported
Thread-Index: AQHdc7jYWTT4fwis0EumcfWUaz7YA7c69kKA
Date: Mon, 23 Nov 2026 02:03:38 +0000
Message-ID: <d34a1743992684ae7807d1d733e0e94522f83a09.camel@wdc.com>
References: <20261113214854.40425-1-christianslima@proton.me>
 <20261113214854.40425-2-christianslima@proton.me>
In-Reply-To: <20261113214854.40425-2-christianslima@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ0PR04MB7485:EE_
x-ms-office365-filtering-correlation-id: 28192b52-480c-4f0f-02d7-08df4905fd79
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|19092799006|10070799003|18002099003|22082099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|4143699003|56012099006|10067099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: WMEqJSMgRrXveo/KWnZqs7viaEtRptwIH4ctTTIxDmArtE3w3D7K5k2Xs1gq3U9hxxtzErn00kJM65dyyB5YZ4V8JyIqNzktZO0+E8550tYZT7JyLyuWn86tH3rUs6J5yaK7YursUwVf6ddMzdv/9ix1tGdZqqD9/pP3EdufB/eZcaT91C/vTH0EnQM4rMGOfFVYjbDK5Sv/+Yrs0RUHUpk1K4FPIECcJmd9iOYA8/UiRB7tdfwJg8axBTl+HSX2K6uGV4ZRBjzovJKev+bN7+TdxnIp6EPCFk13k2Fnc0ARugBFCgSyWD+AL3jIHnUsZbODhVhBNIKVUKKfCfc+Dk6fvk8JMV9KCmDODghGTo2VsPxU+OwZJML780+fLbJcWfXo5QwAVXQjenKa17NkkksNFcozY1xRCcCG7Li9OIQHUlIrHkuWbHE2bq/dPGqUOjsCxy7lGnom02ngl5ySTthIxzvwvLiKdsNMC1/bB6kaieY0CsnVZS+261/o8gLD/Qat0FZHdxjllfL3ZxFK9ijdP8wRka1/hfp7ERSNewNWpA03sboUN4M3lhTv1SvkllyMxUI8QnzUmC+X4jlc1JVZsndZDrT2oiHd4jxNnbo4JK0MbkhCHgi4KTR/8VDoCq+ENOGDE6U1xRienxjjVp17lPi9A1H7Vv6EYfJ8/Kg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(10070799003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(261102123227099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajFEcHk5SFB2aXB3WjQyMy9iNVMwdVpYb0RjY1loZWNnQTFwWUZmV2s4N00x?=
 =?utf-8?B?ckF5cFF6M2ZRWnQzVlh0VUtCbGhwMURsQkxyZU1ZYThrdXFZQkFHZnF3cENL?=
 =?utf-8?B?WUxNVnIxVjd0R2JFMzdhVFI4b1Ryb1gvNk95cHI3RmFWT2N1N1EydnRHNGVS?=
 =?utf-8?B?OFMvNGkzUHM5UFFuQjduT1U4MVdpZEJVQjE0M2QzWDR4dm9rMU9EZDVoYktT?=
 =?utf-8?B?UE1DaE5xd2lnclBqMjRZQmdjSFdOK1VxTU9CeGEwQjY1ajFhRitPZ3VNMDYv?=
 =?utf-8?B?U0gwMGxPWGlHWCtsb210MEc2ak5LVnNyQnNZS21wVENCd1dFbjlLbEJJWFM3?=
 =?utf-8?B?T1RVbmJYOS80cTlwdmVPNnlPUjUzMDZ6dU5TTGZlRDJFUlpibURtL1ZVbDRJ?=
 =?utf-8?B?MkdYYTAvR3JabTI5U0hkQWJvRm1HdHRiVE4xbEZNMlVCVUVCMzJrRW02Ync3?=
 =?utf-8?B?UTJwc05Zenp2RUlickxIY3pjZWwxS1pObCtDcEdzQnE3Q0ExcG53Q3BpWVdZ?=
 =?utf-8?B?R1FIYXhWWlJTWXp3NDZRbVRPVHJNY0hwWXJxWWNHUTEvdmpySXJYeTkrUndH?=
 =?utf-8?B?eHpOM2VoV0VMSy9qZWhPeHM3cGtNUzZYSktZUCtHeUtNMi9Gd2crd0VrVzJ5?=
 =?utf-8?B?M1pqWUgrbW96MnlaU1pjR1NkRTBPZjZlUVQ3d0REK2V6L0QyWmUzcnZxZWpT?=
 =?utf-8?B?VzJCcmNuMnQ1Z2ZJWnZsZG1yTXgvRks1RSt1QnFOWUdFZDdkcm80aGw1RHNV?=
 =?utf-8?B?cmdQT2tRUzBQYVFNR2EvbEFWdkRqakZDUjFBdEZBMlJYQUpYZGd0bk9ObnFp?=
 =?utf-8?B?TXFhREpMZm1WRFM2NHlucWtkSSszdmNwVEppTlJaVWJLdWExc0N1d1d1RklF?=
 =?utf-8?B?ZHpPMjBFZWJGNldxSUtadGRSR3Y3OTNCTTRPYXl3aUNnelZiR2VZVE1xREZ6?=
 =?utf-8?B?ZDNtTFY3eXZIN1RRZXpsdC93bDVha3NRblplUEJVdSs2L290MGU4b3hIZ0hw?=
 =?utf-8?B?alI0bmI1YnA4WnZINmc1OU9TMnoxVnVJWi9rUFM2QW5kM3g4VnAzVlJWaVBn?=
 =?utf-8?B?bjhpK2RieXVPRWVKK0JkVkdMQ0RMU2Q0MnE0WjV3Z05Camk1aHBIV1I2UFp3?=
 =?utf-8?B?NFJ5ZlVzbWg1d25KRUlwdU1ySnFLV3hWYW5PT1pwb3dDcllkUXVMLy9OZElX?=
 =?utf-8?B?NldqMEcxZWZTTWFZRElveFpETjRjSDRnRE52eStBVkZGdDd6TUhuOHdpS0tq?=
 =?utf-8?B?bFM4aHc1OUQvVDNQL2ttNXRKeUxKZ3dud1crVFMwYkFRZURKNnBZNFk3VFVE?=
 =?utf-8?B?OVBPbmgyQ2w5R1Y1K29TUXViNCsveVlnVno0TVk1YTc1V0NCR3BDQkNjOUtU?=
 =?utf-8?B?c0xYMnFQL1hsQmljSGEwb2s1aWwxbmhvWG5FbVFaaThwekV6NGFlaHNtc3ZY?=
 =?utf-8?B?a0tXZ2I4MXNlckJjSEtzYlY0UnVzMTBNRTNaUTJ6YzZuR1RLYWdpYVQ5eU1L?=
 =?utf-8?B?ZTN1Q29WSy9WRWUzaDB0VXpUZ0NQYXZzL3FwaUxyQjVKaGlpVUYxR3UvR1hJ?=
 =?utf-8?B?TU95bi9PTkxVS3dRYkNkN3ZMNlpUbHlOcUNqRjBMN1M2RlBONE1LWlN3OWhu?=
 =?utf-8?B?ZEp3MVdrVm9FRWIvelVZWVZXNVZsR0lOS3FkZkxxVzZwY01BeW8ra2oySHpv?=
 =?utf-8?B?cUszU2dWazNjeXdGblVvSENGK01QVXZGRzFBRDdzNFdsNDU3OXdUN2hUY1VS?=
 =?utf-8?B?SllzcUc0bjFiT25McmVoQnJaNmNUNVZyZnhSOWtkbE9XVUljLzVPRW9TOE8x?=
 =?utf-8?B?d2JwbmQ0QUpVSFIxNFRSZ1NLcDFDTCtkWmpwMmg1OUwwMmFabHdoNzl3dmhp?=
 =?utf-8?B?S0krOGdGdlF5Ym9XWjRiSkRvYVFPUjZRejVybEwrM1daV003RExRcjJweWRU?=
 =?utf-8?B?VG82MkhGMGVkMDZQRTNkUXJ5bjRlaHpGbms1Z0ZHdHZtYm1VczVMZ0hWRjlF?=
 =?utf-8?B?TkNiVGpsNVFNeFBXN1BnYmNYb0dxZkhCR2VGaTlORzJSNzd1UExOYTMvNHBL?=
 =?utf-8?B?dDVrYnp2dzB6L1JqUTNmQzlRRzJtOHM5b0FWWWMxMDd5ci9sMjFNODFQNUdo?=
 =?utf-8?B?blR4SWFuS0I4QWloRjhNN3NLYytSbmczUlhKZlNHaUFCcFZ6RjBMSVNSMlVT?=
 =?utf-8?B?cmpza2FDU0YwNmV3aHg5ZHFQRldTZDBWRmRrSEVIaWppM3NrQ1BKNi9EdHJp?=
 =?utf-8?B?N3AvcEJGK2NOdFkxOVl0VkRjUnlleGJyMGhQbG4wUTdRQjIwclVRMWpHME5z?=
 =?utf-8?B?dmlLdjNrVEsvT0swTTRGT3k5SC91UkxlUWxYSlJ1bHVjZXkyTXROalNFa2pa?=
 =?utf-8?Q?CkoUtMAMBZMjW027TbygBD2xuUIGWqQ/9KN+x6aZoyhS6?=
x-ms-exchange-antispam-messagedata-1: rpBwdU2hyFqNJ7ez5IvG321w9IdVJZJ342E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E1D6B69C166744BBC3C2F88B7EC2826@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ua+/Ww6tS6OPKYF5RsayFfCe35bTHtHdATFN2eeGg8OpQaPEqKvX1jte+u6swAZYOrF+QqWR+Omq3/d4ljBFa2kI96Kgdfesghm488OR4qG1DV1vYxmsnLl+7KwDDb/UAWC6C0HJn8CbMRKQTh2JExRg/KuNBJ0iznzVLF5Sq/9Pe7BgPJinT4/A2WEwneUQqDXowSm3cOKgZQYLjMpjzb9ZSUxBDix31IF3m1jUO9hYFheOWnhem+9D9ps3KD9Rg2MweolKFUn/BScPRWMeyv16knOA/FXrIrmfnjX74rMnAjtYc0chlE0ijE6qiA7v1CmIhLIdemZoKvxpJ9wt5g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P2HDuTrnEn//LntstqrXXc7ZoSs5tbOX5xvlzaZAl538ZGC4ZoFmJpsemOrU8fpigcY+lkrhqXu9rkYA4IADZ6ZG9OtBeIVjanuvBG5DAyGFlY1bmtWHGvoSlT2kSu+2JucOWXK6WbWIzj2kAwrJfi3y2Yc92oYoEG4C6IzEFI9lZYJH+OoVeS/YrYq9Ox3txyW4lQg2khhmmjeauvaeWdAdeRkyl2pIqQwRL2NtbR6cJ0NoCd5m0rtg/erN437pGHG+zurZTujYZCs3Jh58zomNDl1IVzgSNh/rd5+r9dEr6DUG502lwcH4QNfBH/YejMUThwWkGDDNQ3WwLRkTUlRLEAaPKiMOxyVvoRYAzPHQo9uxpDZullfuuXqgdVYPPrBLmz94CKK9pJBCM6c8zTYPERK25FcXoyixLlFYlj8gWu1WbrvHX9ooVxceBmy2wpBlEaYwGbcPtNdls3umdXiGPID5bYw68/9x4P/SaJgYiI8JUgXFLRdolMq0aQKLKjLGVDB3uHGi5T/fKr8L8LivPB/sGu+KBlfGBspGKFxO0B6qHGklqWuxAouB5YyZjPOId39KYdStlyg+3MtCbe0V63azPyPhFxbODgkPFBmWT/WA15hCkB6frMOVvhnr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28192b52-480c-4f0f-02d7-08df4905fd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:03:38.5551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rP0Cs09ZfinLCi2eDzvhihKJDzFTAYYaPyEbs13MQ0GvJ4UwXQO8+/9ZKRImozTHE3YZCGC4YxspmFssjvSFyfvOcIhnMaLr8eq1xxTgOnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7485
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTEzIGF0IDIxOjQ5ICswMDAwLCBDaHJpc3RpYW4gUy4gTGltYSB3cm90
ZToKPiBUaGUgcmlzYyB2IHByaXZpbGVnZWQgYXJjaGl0ZWN0dXJlIHNheXMgdGhhdCBtc3RhdHVz
LlNYTCwgVVhMLCBUU1IsCj4gVFZNIGFuZCBNUFJWIHNob3VsZCBiZSByZWFkLW9ubHkgd2hlbiBT
LW1vZGUgb3IgVS1tb2RlIGFyZSBub3QKPiBwcmVzZW50Lgo+IAo+IGNoYW5nZXMgaW4gdjQ6Cj4g
LSBDaGFuZ2UgdG8gcGF0Y2ggc2VyaWVzCj4gLSBNaW5vciBjb2RlIGNoYW5nZXMgaW4gdGFyZ2V0
L3Jpc2N2L3RjZy9jc3IuYywgaS5lIGFkZGluZyBuZXcgbGluZQo+IGJldHdlZW4gc3hsIGFuZCB1
eGwgYW5kIG1hc2sgVFNSIGFuZCBUVk0gYml0cyB0b2dldGhlcgo+IAo+IExpbmsgdG8gdjM6Cj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1yaXNjdi8yMDI2MTExMjIwMjM1Ni4yMzk4MC0x
LWNocmlzdGlhbnNsaW1hQHByb3Rvbi5tZS8KPiAKPiBjaGFuZ2VzIGluIHYzOgo+IC0gRml4ZWQg
Z3JhbW1hciBtaXN0YWtlcyBhbmQgbm93IERhbmllbCBjYW4gYmUgY3JlZGl0ZWQgY29ycmVjdGx5
IGJ5Cj4gdGhlIHRvb2xpbmcKPiAKPiBMaW5rIHRvIHYyOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtcmlzY3YvMjAyNjExMTAyMzI2MTQuODMwNTAtMS1jaHJpc3RpYW5zbGltYUBwcm90
b24ubWUvCj4gCj4gY2hhbmdlcyBpbiB2MjoKPiAtIERvbid0IGNoYW5nZSBiaXRzIGluIHRhcmdl
dC9yaXNjdi9jcHVfYml0cy5oCj4gLSBBZGQgY2hlY2tzIHRvIFMtTW9kZSBpbiB0aGUgbXN0YXR1
cy5TWEwgYW5kIFUtbW9kZSBtc3RhdHVzLlVYTCBpbgo+IHRoZSB0YXJnZXQvcmlzY3YvY3B1LmMg
ZmlsZSB0aGF0IHdlcmUgc3VnZ2VzdGVkIGJ5IERhbmllbCBpbiB0aGUKPiByZXZpZXcgWzFdCgpP
aCwgdGhlIGNoYW5nZSBsb2cgc2hvdWxkbid0IGJlIGluIHRoZSBjb21taXQgbWVzc2FnZQoKPiAK
PiBMaW5rIHRvIHYxOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtcmlzY3YvMjAyNjEx
MDQyMjMwNDkuODYyODYtMS1jaHJpc3RpYW5zbGltYUBwcm90b24ubWUvCj4gCj4gUmVzb2x2ZXM6
IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMvNDQ1Ngo+
IAo+IFsxXQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtcmlzY3YvMjAyNjExMDQyMjMw
NDkuODYyODYtMS1jaHJpc3RpYW5zbGltYUBwcm90b24ubWUvVC8jbWRkYmIzNGEzZWE4MzdlM2M3
MDcxMzFhMmUzNTRjNjNjOTg5YWIwMjkKPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gUy4g
TGltYSA8Y2hyaXN0aWFuc2xpbWFAcHJvdG9uLm1lPgo+IFN1Z2dlc3RlZC1ieTogRGFuaWVsIEhl
bnJpcXVlIEJhcmJvemEKPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4KPiAtLS0K
Ckluc3RlYWQgaXQgc2hvdWxkIGJlIGhlcmUuCgpJJ2xsIGZpeCB0aGlzIHVwIHdoZW4gYXBwbHlp
bmcKCkFsaXN0YWlyCgo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jwqDCoMKgwqAgfCAxMiArKysrKysr
KysrLS0KPiDCoHRhcmdldC9yaXNjdi90Y2cvY3NyLmMgfCAxNyArKysrKysrKysrKystLS0tLQo+
IMKgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMKPiBp
bmRleCAxNWMyN2Y0Y2U0Li41MGJkZmJlMDI1IDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi9j
cHUuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUuYwo+IEBAIC05OTcsOCArOTk3LDE2IEBAIHN0
YXRpYyB2b2lkIHJpc2N2X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLAo+IFJlc2V0VHlwZSB0
eXBlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSByZXNldCBzdGF0dXMgb2YgU1hML1VYTCBp
cyB1bmRlZmluZWQsIGJ1dCBtc3RhdHVzIGlzCj4gV0FSTAo+IMKgwqDCoMKgwqDCoMKgwqDCoCAq
IGFuZCB3ZSBtdXN0IGVuc3VyZSB0aGF0IHRoZSB2YWx1ZSBhZnRlciBpbml0IGlzIHZhbGlkIGZv
cgo+IHJlYWQuCj4gwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gLcKgwqDCoMKgwqDCoMKgIGVudi0+
bXN0YXR1cyA9IHNldF9maWVsZChlbnYtPm1zdGF0dXMsIE1TVEFUVVM2NF9TWEwsIGVudi0KPiA+
bWlzYV9teGwpOwo+IC3CoMKgwqDCoMKgwqDCoCBlbnYtPm1zdGF0dXMgPSBzZXRfZmllbGQoZW52
LT5tc3RhdHVzLCBNU1RBVFVTNjRfVVhMLCBlbnYtCj4gPm1pc2FfbXhsKTsKPiArwqDCoMKgwqDC
oMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52LCBSVlMpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZW52LT5tc3RhdHVzID0gc2V0X2ZpZWxkKGVudi0+bXN0YXR1cywKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIE1TVEFUVVM2NF9TWEwsIGVudi0+bWlzYV9teGwpOwo+ICvCoMKgwqDCoMKgwqDCoCB9
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmlzY3ZfaGFzX2V4dChlbnYsIFJWVSkpIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPm1zdGF0dXMgPSBzZXRfZmllbGQoZW52LT5tc3Rh
dHVzLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTVNUQVRVUzY0X1VYTCwgZW52LT5taXNhX214bCk7Cj4g
K8KgwqDCoMKgwqDCoMKgIH0KPiArCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocmlzY3ZfaGFzX2V4
dChlbnYsIFJWSCkpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW52LT52c3N0YXR1cyA9
IHNldF9maWVsZChlbnYtPnZzc3RhdHVzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTVNUQVRVUzY0
X1NYTCwgZW52LT5taXNhX214bCk7Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvY3Ny
LmMgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jCj4gaW5kZXggYWY0NDRlM2U2Zi4uMzk4ZTMxMmM5
YSAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jCj4gKysrIGIvdGFyZ2V0L3Jp
c2N2L3RjZy9jc3IuYwo+IEBAIC0yMDgxLDE4ICsyMDgxLDI0IEBAIHN0YXRpYyBSSVNDVkV4Y2Vw
dGlvbgo+IHdyaXRlX21zdGF0dXMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8sCj4gwqDC
oMKgwqDCoMKgwqDCoCB0bGJfZmx1c2goZW52X2NwdShlbnYpKTsKPiDCoMKgwqDCoCB9Cj4gwqDC
oMKgwqAgbWFzayA9IE1TVEFUVVNfU0lFIHwgTVNUQVRVU19TUElFIHwgTVNUQVRVU19NSUUgfCBN
U1RBVFVTX01QSUUgfAo+IC3CoMKgwqDCoMKgwqDCoCBNU1RBVFVTX1NQUCB8IE1TVEFUVVNfTVBS
ViB8IE1TVEFUVVNfU1VNIHwKPiAtwqDCoMKgwqDCoMKgwqAgTVNUQVRVU19NUFAgfCBNU1RBVFVT
X01YUiB8IE1TVEFUVVNfVFZNIHwgTVNUQVRVU19UU1IgfAo+IC3CoMKgwqDCoMKgwqDCoCBNU1RB
VFVTX1RXOwo+ICvCoMKgwqDCoMKgwqDCoCBNU1RBVFVTX1NQUCB8IE1TVEFUVVNfU1VNIHwgTVNU
QVRVU19NUFAgfCBNU1RBVFVTX01YUiB8Cj4gTVNUQVRVU19UVzsKPiDCoAo+IMKgwqDCoMKgIGlm
IChyaXNjdl9oYXNfZXh0KGVudiwgUlZGKSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBN
U1RBVFVTX0ZTOwo+IMKgwqDCoMKgIH0KPiDCoAo+ICvCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQo
ZW52LCBSVlMpIHx8IHJpc2N2X2hhc19leHQoZW52LCBSVlUpKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
IG1hc2sgfD0gTVNUQVRVU19NUFJWOwo+ICvCoMKgwqAgfQo+ICsKPiDCoMKgwqDCoCBpZiAocmlz
Y3ZfY3B1X2NmZyhlbnYpLT5leHRfenZlMzJ4KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBtYXNrIHw9
IE1TVEFUVVNfVlM7Cj4gwqDCoMKgwqAgfQo+IMKgCj4gK8KgwqDCoCBpZiAocmlzY3ZfaGFzX2V4
dChlbnYsIFJWUykpIHsKPiArwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNU1RBVFVTX1RTUiB8IE1T
VEFUVVNfVFZNOwo+ICvCoMKgwqAgfQo+ICsKPiDCoMKgwqDCoCBpZiAocmlzY3ZfZW52X3Ntb2Rl
X2RibHRycF9lbmFibGVkKGVudiwgZW52LT52aXJ0X2VuYWJsZWQpKSB7Cj4gwqDCoMKgwqDCoMKg
wqDCoCBtYXNrIHw9IE1TVEFUVVNfU0RUOwo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKCh2YWwgJiBN
U1RBVFVTX1NEVCkgIT0gMCkgewo+IEBAIC0yMTExLDEyICsyMTE3LDEzIEBAIHN0YXRpYyBSSVND
VkV4Y2VwdGlvbgo+IHdyaXRlX21zdGF0dXMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8s
Cj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocmlzY3ZfaGFzX2V4dChlbnYsIFJWSCkpIHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNU1RBVFVTX01QViB8IE1TVEFUVVNfR1ZBOwo+
IMKgwqDCoMKgwqDCoMKgwqAgfQo+IC3CoMKgwqDCoMKgwqDCoCBpZiAoKHZhbCAmIE1TVEFUVVM2
NF9TWEwpICE9IDApIHsKPiArCj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVu
diwgUlZTKSAmJiAodmFsICYgTVNUQVRVUzY0X1NYTCkgIT0gMCkgewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtYXNrIHw9IE1TVEFUVVM2NF9TWEw7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHZhbCA9IHJpc2N2X3dyaXRlX3V4bChlbnYsIHZhbCwgTVNUQVRVUzY0X1NYTCk7Cj4gwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAgaWYgKCh2YWwgJiBNU1RBVFVT
NjRfVVhMKSAhPSAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwg
UlZVKSAmJiAodmFsICYgTVNUQVRVUzY0X1VYTCkgIT0gMCkgewo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtYXNrIHw9IE1TVEFUVVM2NF9VWEw7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHZhbCA9IHJpc2N2X3dyaXRlX3V4bChlbnYsIHZhbCwgTVNUQVRVUzY0X1VYTCk7Cj4gwqDCoMKg
wqDCoMKgwqDCoCB9Cg==

