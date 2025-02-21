Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A1CC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMhG-0007Aq-W4; Fri, 21 Feb 2025 01:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlMhC-00077c-W6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:39:35 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlMhA-000421-67
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740119972; x=1771655972;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VcOiNKMRsvqj05lLmJk5LQvqJuZ2hDa/VahqTYMaKQ0=;
 b=oo09X2fKlMOow5nbyG89GcmjTDvLFOSCxr7kBzmJjXH9jlCS8GiB5QFn
 ZPFs6v3Yxm/qhNSRGsSR7ShPzPJwRJhEPx/ZN032hHYehSwxDz23TxPRW
 ZUjKBzXdaAT0b0rLMliuufhGJoRFgDCxmNv3/kGBWOdq3seRh6RknOsLT
 Pfr6wNzJzzv4vcFCu1IuIs68uZ9e2t40f5Kiw7M4z8aafR0MZXj/ucr4s
 9dQ7V8+AjnLvsjQtzIKB0KkcYKaR6+udkVp6Z0LBK7WYvad3zeGmpuMWd
 +uzLbAAJUMlQ+qhyqjxzI/hFbl/S+Ai7uyCmdLm9LzBSwYqd57F7J31R+ A==;
X-CSE-ConnectionGUID: JL+o/IBATXWXRFbE5FhVDA==
X-CSE-MsgGUID: t6Ne+6dFSXKYjBX5RXxagw==
X-IronPort-AV: E=Sophos;i="6.13,303,1732575600"; d="scan'208";a="31375369"
X-MGA-submission: =?us-ascii?q?MDFNxOsu7bn6CKxuupU4cHUxgyubhymcFTpFc3?=
 =?us-ascii?q?0OwKmDfESBkHsYs6Tbl+2NPryIjlM3iAyArn4TwbxiSkPqNvXjGvkXBq?=
 =?us-ascii?q?t1om325cRXoSyqiXo19hgrYpnZmbU1eiZrdORqYt10WREqt4S4HUqFIF?=
 =?us-ascii?q?kYP/BAeK1l4JUOb6P/jXuOBQ=3D=3D?=
Received: from mail-vi1eur02lp2045.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.45])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 07:39:26 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7XCmpIE5ppmG2khoYzL9Woo7EBw7D4rk3QLegM9VT1sESqUyVRZQVNEwBB72YE0Pg0HYP/AaFT2qD6gxLGoItrRr5KgGgphSDLpp90K0uezBsfoe7SJ1YUIxj9OO8iumT6nItehyQmFdzbC3nrns/J/G7fmyA9N2EajWixntHNb+0Dpuotw9lCYkrzwbIOpFRs2Ait9eJvMzk8BzHnDiWWie8riuUdvNVzzyGfpioghl0BYKGlcwxt1iZjHv6DQFnG+jeLjiZoki2pmHSdKaCKo5R1IF0dV0RQbcOhHsyDgPCBeEN6QBomh5OU2xk88ZEqVSn4LS7cdbXG1+d/w0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcOiNKMRsvqj05lLmJk5LQvqJuZ2hDa/VahqTYMaKQ0=;
 b=JaDhfjw1o7jETrfwMQDHdEOepQBcDd7SAD1jx1tRJiEDovw251Mah0wveRh3B8fBWwyX4n9aZ05D+QFqQKUnV6V73EvjcB+y/G+cfsm/KFAJpR/J5CL6ZxbLRVJm55x8aZKcALkyCPC2GlDNPVm7fVU/F5GZcrh56XJLFcoS09tLnm38LQs+UGyZFw74Hg8pFOBsH0UYeCgS1w6jOmJM0W5lP7/qioXjm46e+f2t8u9IUWxxxVQDnW331yWdnGXr8DtkE9znZpxJUyUM6q41zAVL4Zhobfpsd1N0fwhVgcTUtuhWsubYEcasSUQ5LO8braH5k5dTBcc/2w12uFn/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcOiNKMRsvqj05lLmJk5LQvqJuZ2hDa/VahqTYMaKQ0=;
 b=NuQDMGnPu2O0Gy8EqE6i+HeQcNEatR9+Lq52WhFI1uaiUHoNiBMPhlvyoGSeVn1MJ2gGwZPH7dRAzMnOr3Y6gwW7r4eapXyZK9GnDBVFLBSpT8FCszMG2GlWVevQHYLL6CeLN7HFqG59xXKfn2fOV4J3KrFtPe/5LES8bIA5tzbFE2d3ts9d/wdiTM1fu52tNJfEeGkonnd8HdEbFC5jy3XMH0ce2LzwDYhh11h6PwNCnvA73ZmDYLdCe2Ub9HNg7BVcbq1oS/dna9WQCjZZzEJWAPa/iMhCeFS9IEaIUEcVX/oWukUmsq96cbjcV4pMeiW4LTZh45irgfLkHYj2NA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6368.eurprd07.prod.outlook.com (2603:10a6:800:141::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 06:39:24 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 06:39:24 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv2 09/20] intel_iommu: Rename
 vtd_ce_get_rid2pasid_entry to vtd_ce_get_pasid_entry
Thread-Topic: [PATCH rfcv2 09/20] intel_iommu: Rename
 vtd_ce_get_rid2pasid_entry to vtd_ce_get_pasid_entry
Thread-Index: AQHbgqgFToJBlNc+NEWSd1gF0oByIrNRUUQA
Date: Fri, 21 Feb 2025 06:39:24 +0000
Message-ID: <a60c6222-a74e-4e80-91c1-055d1f35d699@eviden.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-10-zhenzhong.duan@intel.com>
In-Reply-To: <20250219082228.3303163-10-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6368:EE_
x-ms-office365-filtering-correlation-id: 01a3b865-56e7-4bff-7999-08dd52427b1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OU54SmJIYzg1dm4yOFNlcFhuMTJ3b2hzZnFHdG9uNmZvMW8xalhBM0pxSEdn?=
 =?utf-8?B?MmpVQ3FFTE9BdzBsUHN4aDI0THhvTGpuRStiYkIrUDd3bEMzS2FIaDZEYmVr?=
 =?utf-8?B?ek0vY21VWFptM3JJam40dEZ1SDkydy9pZFkzUlZNam4zN0MybHFvR2hjdHZa?=
 =?utf-8?B?RTRMVE9WSS91djdPaklVaGtwQ2kzNGtFSU56NUdXVzRFVzlkSkhMQ0ZWdWJM?=
 =?utf-8?B?M053TFJTbC9UZzFSOTAvR0FPVGdhUkZHWm9GaFdDcG9Tdlg5R1dRK3JnbUg4?=
 =?utf-8?B?L2J6Q1BCSzN6dVN4cEJ4OUVvZ2hOb1dybTVjZmo5Sms2SURKYlg4OXJXZHJ6?=
 =?utf-8?B?RGhlWFkxdlRmcEVOeHBlY21RNTlCbnphVERqbXVlbmZkeXMrWHpxOVJxRS9I?=
 =?utf-8?B?NEpiS09PNlIvOUxkc2NRcWcxLy8xRklzemJQN2xZWis5MzZiYitxL1VRcC91?=
 =?utf-8?B?aHBGM1ZCUitvZTNyejlUcVpJM3g5U1JUSE1ybSttdytPZmxQcndkejRZMm1w?=
 =?utf-8?B?Vm15ZklWTUFnNDdpTzFMajhST1hyRjNSUWluUks4bitxNEVKYVl5UVVjcmky?=
 =?utf-8?B?eFNleG10cDBkWXVoRW1kUkhrYUdXUVdyd3ZDMXBsb3A4ZmVsQUNweWFWNll5?=
 =?utf-8?B?d2FxT3Nrb2xPZjdsTk9UNGJ4RnFCeEZ6T3lmeWtWaS9SNTlKeWZkbmJlYVVT?=
 =?utf-8?B?UnRBNE1ES3VPZnNmZEJkNjdtanpZSlJrTUh2cTNpMWg5ZUk1eldNU3UrQWhs?=
 =?utf-8?B?T0RZVklEdW00am1tcFUwRkFIMTNvYzR6emY3ZXRGQlB2U28yNW5Gc1pmN0VK?=
 =?utf-8?B?VUlHUlZuTWJJb1RXb1lVM1dwcDR6c2ZzaEhIMHBlNjNZbXpuMXFBZWZBREw0?=
 =?utf-8?B?cVd4dFBMdEJoU2F0SldpQng1dm5xWjdMbzVTZitKeXVpQkNDWDM2aWt6b3ZY?=
 =?utf-8?B?VDJBMnpxUW0yUjZ5T1ZTRTNreFREdVhVak9STDJxaTBNVnR3VEhGcFl5TUpx?=
 =?utf-8?B?ZExDcGV5eFloaHc0Q0VLZVI3U2RRYWNaMk9EVDZMOVdoVlNxOENteHBmL1Zi?=
 =?utf-8?B?bGJWZzhxZ1FtWXZDUndvSWdta1RSZ1Z2TDRKV3JQZ3gwamFMR1RVb3lyMnlY?=
 =?utf-8?B?MHgrekd4VFY2emZSZHZYTUIxOHBFSVJPMllNbVdFNjlzRkZSaWtjcjRKNi9o?=
 =?utf-8?B?R1NBbTdSb1k1UzdrNnNycm5xM2NXb2FncUVUV25hb2tjME9kMzN4cmhNOG9Z?=
 =?utf-8?B?OHdUK1BpOHJoVXlLSzVSR200Vkg2SUg3eGpHQzZ5WnVYRlFyTGYvbm9uRFZB?=
 =?utf-8?B?TnhZN2svNWc4TThsU1ZFS25lU2NQUGtEN1pDRDNCWnN2eG10SGFNVU82RzlZ?=
 =?utf-8?B?RlFwVTJJUlcvbWwyZ0cxYk10USs0eEJJV25CS2NDTmZqRlQ4d0I5d0FBZ1ht?=
 =?utf-8?B?dEdibjczMUNhaEJxdEZaT1p4dFNyYlE0czdGeStSVGFIREVWODdoeWoxTXl4?=
 =?utf-8?B?WWx1ckRtaGpRWEphRFVzL05DSGZVSTJpdDFiQmZ4Z0dwWkZJRGUxTXdsN3Ra?=
 =?utf-8?B?QzRCelZTdVFsN1ljbkxGUVZCVjBFUVdZQm9MQnd6WnNLYnZPc0Z5emFXVG5S?=
 =?utf-8?B?YUN6VXg1QW5lQW40NUNsYkFiTHovdVhyZzBBYm5NSXhMYVd5Ylovc3MvK0Uz?=
 =?utf-8?B?L2xXYzBlZVdLK1l2REF1VkRRZUhYM3VmVnVhZmJXV0xaS2V3a2RFcnJKb1JQ?=
 =?utf-8?B?Zjk0S1ZQb1NkeUFEelZMeW52WVFlQmFNVEV2RndrVFFidDVFYU9nZ0FtVEl5?=
 =?utf-8?B?eXRvTklZd2J2d1BmcWhVZjFWc0ZyWW1EUnlvV0xZTGxhQjlYZXpuM3o4Z01U?=
 =?utf-8?B?YnRnZUFpa3RYVWdpN29vQmx1N3pCdGV3aWs2YkhMUlFsblpScjUxOVU3dzFL?=
 =?utf-8?Q?DAqh2v8ubroPegeqqzUc3Atv++LZTV5+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW5mMkpRcGxyQlpqcnd6YThUOWljTnVXM0NYU3FQQXN3RlNFdmwxVURtNjYr?=
 =?utf-8?B?TWZuMmt3b0xnL0NUc3k4SHJ6REwybXNDa1REUkhud3RHRjAyakNMWUQydlRV?=
 =?utf-8?B?VDgvZ2dEdTZ5N3BMTFV4SFc1TXRhOG9URlBqSXpMNGdURUFsU0w4WThvVFRr?=
 =?utf-8?B?QUlRYzJrTUVBVlF1bGx1RG9QOE5wUHMzdjJONlhsa1RMUVRrb0hSTjVXVE8v?=
 =?utf-8?B?dzB6OG5rUGJlbUxnMkd3QkNjUWNiYTdWNGRuODhuWG4rRi84M2FNbUFsbDN5?=
 =?utf-8?B?aE00Nzc4cUFrc0lwNTZ2NDlyNE1vaHJVcXovL1E0WXFFM0RVbk1FTC9VQWlz?=
 =?utf-8?B?K3ZmZEVGdS9MNU9FRlRIejYrMzUzUXJqalBCcnZDcDhVakdXNE0xaFJoTEhl?=
 =?utf-8?B?SzUrdm1peEZCWEFVUTlhbzJqVUcyakhtT2N1enR3OHFFRDNoa3pwT2Q1VGJT?=
 =?utf-8?B?M1phRGpEblB1T1VLV1BGbmFQbGxQYVdYQUc5RmZwbVNDblNlK2FmdUF5NkdV?=
 =?utf-8?B?UFZyV0pTN3UwU1hDWEtGWHVGaHRRZ0ZPSFNEL2U4SzNyaVlxSEVDTW9aQUZO?=
 =?utf-8?B?dEkzWFhxQ002Yk1iTFlUcURlMHBZR0dSQWVVR2svQ0V3bHY2d28rNDVlb0J2?=
 =?utf-8?B?Si8ybTVaMXRNdUNQblFDejFGd1kvd01uSU9aU0NNSHQzeWlmU3k1RDVJM1NC?=
 =?utf-8?B?SlNzZUJRWjIwL1lZZTRuUk5SWG1TRTBzN3dEQTlOUzFNS1pnbEFPYUYrNkpH?=
 =?utf-8?B?ejcwN3FQV1U5bEU0NDBBSVhndnkwTmcxSk9pYmpsZnJ3VERrRjJRVGFiMVdM?=
 =?utf-8?B?R3FQZ1R3dkNIZTg0cVJlK2hSSUFxNzF0Y1lUUU1FU2g0eFhJUDdmQ2s5QUNj?=
 =?utf-8?B?WnRrekhMaXNqUmFiKzJOdW4yUUNEaENoaURUMGxjQ1hFT1VkeVZyYWpMWVZ2?=
 =?utf-8?B?QmhkSW1nRFNzeTNkQ1R4ZWc3ZmlvMDJ4ZmlsaVEvRFBTNnVjbVRSYVdUVUtq?=
 =?utf-8?B?cWtEbnZHNzR4YmlYVVh3M0pJNGFoRUpJelVhUVhRd0U4ZXhka2tFQ1ZlNDgr?=
 =?utf-8?B?aUJGVnJXSmRPQnpSYktJYURMQ0hVUGhLUG5xeUpkZ21FeGxSVFZ6RVZCWVpN?=
 =?utf-8?B?YjYwZHBVa3RDSDFNbkM1UlIvWTJRS05IcTlnQ1dEQUVEV295dDVzYWhkbkZI?=
 =?utf-8?B?OEFhc21KUTZCWlltNXo3Z1krY3oyOENLVkowR1l3TThVYlYrUlYyZTltQU9G?=
 =?utf-8?B?Q0NwNkdrdWNOeW84eTRCdVdIekJBRzd5K1RNWk1NVEJ0aHgzUkt1VnhOWS9t?=
 =?utf-8?B?WlBlTXprWE45aUdZbHppamU2cXZDSENNdVlKOS9rVWxydVJSMWVSVVZTbEJU?=
 =?utf-8?B?SkhPN3BWSjRlY1lmbkU4WGdLQkd3TlRSVit5Qzk4R2RCVVlIc2NrYVIzVzAy?=
 =?utf-8?B?RzRxa2Zqa2YxcTdhZXZkNHd5SEMvRTVtamt5eDdtTUlsVEFWbnQvdzk4YUlN?=
 =?utf-8?B?T256WHdrTy9ZVE1lcHE2S0IxSm9XcWp6UlgvbFkvb3MvVHVSM0RmcU5YK2ZV?=
 =?utf-8?B?RnVET2J3RTBFZVZvbGlkbFZRSDYxY1JkMnJPcGR0SFlpVEh1SXhvd1kvdGRT?=
 =?utf-8?B?N1E2VUcvdG1yRlp6NDZWSis3a202NDBtOHM2UkQzTTd5NTNoNGFqK2JkckhF?=
 =?utf-8?B?NklWeVBBUmR1T2gzN2J2dnNXbkQzWHNDLzB3aFBDWVlXNjVjczhHNWRlNTlV?=
 =?utf-8?B?ZHhjNDFCbmN6WjhrY1g4QzFGMnRwNGRxWk5aVTZ6bDNQb1kzV2kyVnlvWkxh?=
 =?utf-8?B?ZU0yVVppS05Palg1T09mOUp3aUlOcnRpOHlZejNyZjI2ZHRtcG1Nc04zLzBt?=
 =?utf-8?B?SWFQcVJqRWY1a01TVWdwMG5JR2NBMjJyVXpVVkM3Rk9hNHZXVTV4TE9kMFpj?=
 =?utf-8?B?bXVwQkpqSHNJd3p6cGErV3BWbWRoRm82REYxdFR3cURWUmhYQ0o1ZjR1Zlk0?=
 =?utf-8?B?UTdxTndOL1JuR1YrdE0zVThhWEJ0VDh4Sko1WWZIVTN0VEV3NkFGcUwvNDVa?=
 =?utf-8?B?N3JzWFZpVVQwM3JwTkpXWldFWGtFT2lTMW1YbjcySjAwZk5kWUdyZi9rMUF0?=
 =?utf-8?B?dVJBOWpLZmxyU2JXVXFzSkJHWnR4b0NrQktadnB2VHFvRitLYk0zSDZIV253?=
 =?utf-8?Q?TluHAUXeQu44jY4Zkt2FfAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FFDCD1D76BAB5458B9AF58882F17061@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a3b865-56e7-4bff-7999-08dd52427b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 06:39:24.2865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1TEZT+7k5yM5SKyH8vh0F5Ic/bVXCBYQMpneO0AlO5hE81Pk8O0E+vTXk2WIzw+LEvI+1Cak9AE7QYLk67dd7fcpgKyCOz7zPbwwZ+q8K/5nUraFoFb91l7SeziBR0KV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6368
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCk9uIDE5LzAyLzIwMjUgMDk6MjIsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3Ig
Y2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIg
YW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gSW4gZWFybHkgZGF5
cyB2dGRfY2VfZ2V0X3JpZDJwYXNpZF9lbnRyeSgpIGlzIHVzZWQgdG8gZ2V0IHBhc2lkIGVudHJ5
IG9mDQo+IHJpZDJwYXNpZCwgdGhlbiBleHRlbmQgdG8gYW55IHBhc2lkLiBTbyBhIG5ldyBuYW1l
IHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkNCj4gaXMgYmV0dGVyIHRvIG1hdGNoIGl0cyBmdW5jdGlv
bnMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0K
PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDE0ICsrKysrKystLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5k
ZXggN2ZkZTA2MDNiZi4uZGY1ZmIzMGJjOCAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBAQCAtOTQ0LDcgKzk0NCw3
IEBAIHN0YXRpYyBpbnQgdnRkX2dldF9wZV9mcm9tX3Bhc2lkX3RhYmxlKEludGVsSU9NTVVTdGF0
ZSAqcywNCj4gICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgdnRkX2Nl
X2dldF9yaWQycGFzaWRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLA0KPiArc3RhdGljIGludCB2
dGRfY2VfZ2V0X3Bhc2lkX2VudHJ5KEludGVsSU9NTVVTdGF0ZSAqcywNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURENvbnRleHRFbnRyeSAqY2UsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERQQVNJREVudHJ5ICpwZSwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKQ0K
PiBAQCAtMTAyNSw3ICsxMDI1LDcgQEAgc3RhdGljIHVpbnQzMl90IHZ0ZF9nZXRfaW92YV9sZXZl
bChJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgIFZURFBBU0lERW50cnkgcGU7DQo+IA0KPiAg
ICAgICBpZiAocy0+cm9vdF9zY2FsYWJsZSkgew0KPiAtICAgICAgICB2dGRfY2VfZ2V0X3JpZDJw
YXNpZF9lbnRyeShzLCBjZSwgJnBlLCBwYXNpZCk7DQo+ICsgICAgICAgIHZ0ZF9jZV9nZXRfcGFz
aWRfZW50cnkocywgY2UsICZwZSwgcGFzaWQpOw0KPiAgICAgICAgICAgaWYgKHMtPmZsdHMpIHsN
Cj4gICAgICAgICAgICAgICByZXR1cm4gVlREX1BFX0dFVF9GTF9MRVZFTCgmcGUpOw0KPiAgICAg
ICAgICAgfSBlbHNlIHsNCj4gQEAgLTEwNDgsNyArMTA0OCw3IEBAIHN0YXRpYyB1aW50MzJfdCB2
dGRfZ2V0X2lvdmFfYWdhdyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgIFZURFBBU0lERW50
cnkgcGU7DQo+IA0KPiAgICAgICBpZiAocy0+cm9vdF9zY2FsYWJsZSkgew0KPiAtICAgICAgICB2
dGRfY2VfZ2V0X3JpZDJwYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBwYXNpZCk7DQo+ICsgICAgICAg
IHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkocywgY2UsICZwZSwgcGFzaWQpOw0KPiAgICAgICAgICAg
cmV0dXJuIDMwICsgKChwZS52YWxbMF0gPj4gMikgJiBWVERfU01fUEFTSURfRU5UUllfQVcpICog
OTsNCj4gICAgICAgfQ0KPiANCj4gQEAgLTExMTYsNyArMTExNiw3IEBAIHN0YXRpYyBkbWFfYWRk
cl90IHZ0ZF9nZXRfaW92YV9wZ3RibF9iYXNlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gICAgICAg
VlREUEFTSURFbnRyeSBwZTsNCj4gDQo+ICAgICAgIGlmIChzLT5yb290X3NjYWxhYmxlKSB7DQo+
IC0gICAgICAgIHZ0ZF9jZV9nZXRfcmlkMnBhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIHBhc2lkKTsN
Cj4gKyAgICAgICAgdnRkX2NlX2dldF9wYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBwYXNpZCk7DQo+
ICAgICAgICAgICBpZiAocy0+Zmx0cykgew0KPiAgICAgICAgICAgICAgIHJldHVybiBwZS52YWxb
Ml0gJiBWVERfU01fUEFTSURfRU5UUllfRkxQVFBUUjsNCj4gICAgICAgICAgIH0gZWxzZSB7DQo+
IEBAIC0xNTIyLDcgKzE1MjIsNyBAQCBzdGF0aWMgaW50IHZ0ZF9jZV9yaWQycGFzaWRfY2hlY2so
SW50ZWxJT01NVVN0YXRlICpzLA0KPiAgICAgICAgKiBoYXMgdmFsaWQgcmlkMnBhc2lkIHNldHRp
bmcsIHdoaWNoIGluY2x1ZGVzIHZhbGlkDQo+ICAgICAgICAqIHJpZDJwYXNpZCBmaWVsZCBhbmQg
Y29ycmVzcG9uZGluZyBwYXNpZCBlbnRyeSBzZXR0aW5nDQo+ICAgICAgICAqLw0KPiAtICAgIHJl
dHVybiB2dGRfY2VfZ2V0X3JpZDJwYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBQQ0lfTk9fUEFTSUQp
Ow0KPiArICAgIHJldHVybiB2dGRfY2VfZ2V0X3Bhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIFBDSV9O
T19QQVNJRCk7DQo+ICAgfQ0KPiANCj4gICAvKiBNYXAgYSBkZXZpY2UgdG8gaXRzIGNvcnJlc3Bv
bmRpbmcgZG9tYWluIChjb250ZXh0LWVudHJ5KSAqLw0KPiBAQCAtMTYxMSw3ICsxNjExLDcgQEAg
c3RhdGljIHVpbnQxNl90IHZ0ZF9nZXRfZG9tYWluX2lkKEludGVsSU9NTVVTdGF0ZSAqcywNCj4g
ICAgICAgVlREUEFTSURFbnRyeSBwZTsNCj4gDQo+ICAgICAgIGlmIChzLT5yb290X3NjYWxhYmxl
KSB7DQo+IC0gICAgICAgIHZ0ZF9jZV9nZXRfcmlkMnBhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIHBh
c2lkKTsNCj4gKyAgICAgICAgdnRkX2NlX2dldF9wYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBwYXNp
ZCk7DQo+ICAgICAgICAgICByZXR1cm4gVlREX1NNX1BBU0lEX0VOVFJZX0RJRChwZS52YWxbMV0p
Ow0KPiAgICAgICB9DQo+IA0KPiBAQCAtMTY4Nyw3ICsxNjg3LDcgQEAgc3RhdGljIGJvb2wgdnRk
X2Rldl9wdF9lbmFibGVkKEludGVsSU9NTVVTdGF0ZSAqcywgVlREQ29udGV4dEVudHJ5ICpjZSwN
Cj4gICAgICAgaW50IHJldDsNCj4gDQo+ICAgICAgIGlmIChzLT5yb290X3NjYWxhYmxlKSB7DQo+
IC0gICAgICAgIHJldCA9IHZ0ZF9jZV9nZXRfcmlkMnBhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIHBh
c2lkKTsNCj4gKyAgICAgICAgcmV0ID0gdnRkX2NlX2dldF9wYXNpZF9lbnRyeShzLCBjZSwgJnBl
LCBwYXNpZCk7DQo+ICAgICAgICAgICBpZiAocmV0KSB7DQo+ICAgICAgICAgICAgICAgLyoNCj4g
ICAgICAgICAgICAgICAgKiBUaGlzIGVycm9yIGlzIGd1ZXN0IHRyaWdnZXJhYmxlLiBXZSBzaG91
bGQgYXNzdW10IFBUDQo+IC0tDQo+IDIuMzQuMQ0KPiANCg==

