Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E238C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78cL-00026V-Jo; Wed, 15 May 2024 03:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78cK-00026L-1p
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:00:00 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78cH-0003Qv-5x
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715756397; x=1747292397;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PMB4RVlf5JDFQGq57ZDI3JSe4GftEx6UQOHqCKOUep4=;
 b=RqmzTQHHI7azNSrJ/wVXxUNVVF8UYXEedhP9L7YvubEpmZhzJ8pr/KqE
 yd6XNbA7Err640Ar2qvAhmFBZ4F0mDHVrA6AreBFVoG30Pi9phZXY3kpA
 fKywqIYovX0UxBJPQK+w9oJm1E0JJ98+aNRCksG7SFEMMLLJ/IvOwhaPx
 tA/VQ/Y4Ptubg7zgakf0173qqYkUMR0ZYy8HwX1O++ysbzZuD/1b7U2hI
 FtcXorSj8yxsVL/P3Y2iJznwaviaouoFE5s8cunPIBiigvm1JSbNGC4Za
 7ezMaJ0v1hjGh+HTsxIJOBkh4ERca9iMWm1DCrkLArV/cIp4pvhxyuIUT A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12578641"
X-MGA-submission: =?us-ascii?q?MDFJWexF7fO+X97LGaKAP7vQ9PsbrriP1KlXeI?=
 =?us-ascii?q?Ph+QkFCjWCheFmaU132t+ecwj4h+kX71J+sJ2W0aSzDccEaRom9erv1g?=
 =?us-ascii?q?1fg0VZjGinryJrIDJlWvlJx4f2/RAj1GAqxjrWwzMF3/koSa8riSuvLM?=
 =?us-ascii?q?a9Mm410ATbvgo9bnm0acYLJg=3D=3D?=
Received: from mail-vi1eur05lp2169.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.169])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 08:59:51 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTKhTHqytrR77G0nP29F8c9Nkoh9AbVO7ODOfpJ0c8gsh4DfEpOSU5XGhswzfqKUneEptOWiKnYKZ4WRuFqST0SgRpMN7r6b7h3qDzAJudlHjhcnhxN3AJZlb92NCsOcJGOtiCjhP/7NaObUleFPg8tvyV/pbOnoH4/0qt5KASn27ATwC3/+8s1x5jdgHJZ+Nh5+AV7Fs1ho4d0Gnv33Nj8OIO+wO5cMjOYuYNPICd5GgugSRsn2Gb5D85IvC1LqPvYB3+UHDO/wNWkxurGUKivwlMl+cGJbNcdzOjVKNPiV/qxqSo8dxfWqX2v/EloOFMcZYfRrJxJQZg7sB5g6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMB4RVlf5JDFQGq57ZDI3JSe4GftEx6UQOHqCKOUep4=;
 b=lEXHNypT2NkvHJGgYOn9TZos+T2TIkQs+5DO68sH18997rrcPWEm48u5/rvGyyBBpDFS2argDM3fmPe61yfNXimHUBTGPpTa8wv6M81FlCowCI7Yd/EoYV/Z4Uvec39TKYLtrxv6wst0AfXaBgUNjhQ435V5R4HTvFlWc1rptbbQ2DdEMWUKbf9XsYlQ1HhH3a260V2aVVlrxJPMo1n2N+83IJm4I3xzOP/+F0WYFdmOSmxJHm2OXtcl4Nd5kPc1+u5YdH/zVbwkWNiUS4R/xve1gAzsv2t3mzc72WFGcasbTmDQNXqN3fONNIuesA7GT8WJoI+NwzugL3WGiQiCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB10139.eurprd07.prod.outlook.com (2603:10a6:800:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 06:59:50 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 06:59:50 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Topic: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Index: AQHanKV+UzSPoW8ik0CkQzcjTSZ5FrGWaO0AgAGIsQA=
Date: Wed, 15 May 2024 06:59:50 +0000
Message-ID: <7418b16d-c380-4006-b3d5-26c70e2db515@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-4-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB67440FA8BFCC383E6606866B92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67440FA8BFCC383E6606866B92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB10139:EE_
x-ms-office365-filtering-correlation-id: 6e3114e4-0e03-4b4c-7c92-08dc74ac9d7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OERCaC9HL0FNT3cybGJxQTJPYjh2UHkwbXFWUkdocmp4OElsNmNVSUZURW5Q?=
 =?utf-8?B?YWpXdit3U29nSjVlRktBYXlSeHRkcnpWTTBZUkJPcEV3QTJJS1IxN09kZll4?=
 =?utf-8?B?TVQwSmpTR3ErTzlZa3Y2RnFVR2cyWnVzTjIrd21DYStoMHlka3VPWGRYVyt6?=
 =?utf-8?B?RkJ4WXk2Z1p4UVJ5bEcrMjkzQnlMUmFrZVVFV1VQMm9QT3dNZ3RObVdlbkJ2?=
 =?utf-8?B?VmRmMnA0Q05BUDJEVEc4bEZVcDNEVGREWkZrQ1kzQkt0WUhVb05pK0wzK2oz?=
 =?utf-8?B?S2hDWWVXYitpbEc2Y0toV3R5MlBMdWFHckwvdFU2MDVBeU5hRitkNGtrbVZu?=
 =?utf-8?B?ajVyYlV6dmdjaW0vamZqT1llaEgrdWdLZC8xZzdmQTIxNFRmd0VMTzB0dm5a?=
 =?utf-8?B?MWd5b1kvS2hrOGx3SEtVVWhnWmZKVWYrTEZwYk1vUlNRUWluSWRVcC9EeVRO?=
 =?utf-8?B?YVpCRUZXb2QrQXYvdVphMDBzZkZpUjNCWGFtQTNKdi9TK29vemJMdHBGeVhq?=
 =?utf-8?B?N0M5dkpDb0VHVDFscVlnRlNlaG8vYW9QRWEwWUNJczFCZU1oNVFiNGt5RDJq?=
 =?utf-8?B?M21URnlxbDg3TFhuNEZ0Nll1VW1oS3g2MHp2YmJLbFh6Tmw1NnExeGF1TEE5?=
 =?utf-8?B?dHJWWDFBS0pkYytVdC9VMlh6Q0cvWkN2ZUZHZlQ0NUFpS0FoNC9iMjdjVzZO?=
 =?utf-8?B?N3o3YWNzZTJsNjdXaFU3KzlpOTZxYlh1ZXRtMUhQc1RFbE5SUGZIVjB1eFNM?=
 =?utf-8?B?TmdGYWFMd2hnOC9pS3h1cGdQRnVtdVV3Z3BJVEY2OTcyTFZGRUVlUGRTNkhl?=
 =?utf-8?B?S2hNc1p0V3FZdEMzQTE2UlVvSE5sY1VyWWdOa1BuVm1XcUFJQzZHcGJpTkpa?=
 =?utf-8?B?L2tyT25WN0VQZnNkTEFtRm9yS3AyZUZRUWlNYW9PdUJOZHpzUzJSQS9hSWV2?=
 =?utf-8?B?L2Jrc0ZRcmZZYW5wRkJXUkJoc2NtNkJ6aG1vMTNyWXhGbSttczJaclZ2a2w5?=
 =?utf-8?B?d2FENlVVQzhJNStYcGcvOFNqSktKWDZ3NnJqVXZ1Qk9GUW9NMllpTGtkWkJE?=
 =?utf-8?B?QjNJcGJCcStnR3c2VVN5RHJOUUYxa2o1T21VdmFpNFlCUE80dExLVU9US0lK?=
 =?utf-8?B?Y2NTbklERzRUQTJDVysyazkrNkNaaVZvdjRHRWRMNG1peDI2MkVML0VCRDho?=
 =?utf-8?B?cDV0U0ZrdG5uN0JqaG5lUCtmQ1lqUi84V2R2am9nWEVRY2lxT0M5RXdUT1h5?=
 =?utf-8?B?Yk5TY1JlZ3FWNE9hdCs4WHVxQVRiQXFMb2l3N1ROazZKaVU2bWxONHd0Rmht?=
 =?utf-8?B?eVlGM2tlUGp1MjQweEhxcmhvRXc0cGtpcnFMNGtZeTM2ai9IeGdka2lHS2cx?=
 =?utf-8?B?VVpKVU9qcDM3R1haVGhmRzR1UkVjcDJ1TDE1MFphVlIzdnpYdkxWK3Uycndy?=
 =?utf-8?B?QzErdVVIc0ZodU9OYVVxNzU5VkdlVWQ3TWo0NU9KcFpnenp3aGFhYy9Kc3Nk?=
 =?utf-8?B?cFNRU3pVVGM0WkRVZ00wc1UxS1AvNS81QUU3M0MweGE1a0xkTmhwekdaRktu?=
 =?utf-8?B?V0JDVTN1NGRzSFhFVFlyVm80TEozaUVHVnlhb3phc3R1VEJGb1EzVksxS1g2?=
 =?utf-8?B?K3R0Q3VidzFJMXZDV3duVVgwMlpQMUlyamZhYUpZQzcxN1ZXTVF6bi95azZm?=
 =?utf-8?B?MFpmTmRVRnFtSE10eFZGSmQyQUFFUEZrdnUvU3VXQzZIa2Z4Z2tERlFQTDVK?=
 =?utf-8?B?ajh0dkNZY2dMWmNQMEVLVnVGSEV2LzRkR3dxSk9kelZ2a1pmbW1EajBrYkhH?=
 =?utf-8?B?bTYxS3NzNXozZllobW9GUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M25YaDVEY1hNRXl5dDJUajZDRjZFZDR6WVp1dXM2RG1TdWNLRGNJNHU1SzdI?=
 =?utf-8?B?MTVVQk5YYTJnbGZOenkrT09hYS9KZStOeTF2UXl6ZXBScTFJaktGeklPNzVO?=
 =?utf-8?B?eCtZeEg2Y0tHVFVjOEh6T1FlVExCTnlmZHM1SjMxR1lTLzFQSlYvWWhJcmxI?=
 =?utf-8?B?aVNGdDE2cDJZd0E4Zmc0UW1oTGlPZXphS2c1YnkrdStGK1ZJakpLWm1ScGpk?=
 =?utf-8?B?R0k3WEZmRUlTbGViRmdtREl1TzEzUGpadG1DdnlCNXhLVDdxUld3TDdzZVU5?=
 =?utf-8?B?VEV1K0FRSmsxckhYY1RLREgxVkcvSFgwelNKL0MzVXhwaUFPWnlVekFLbTR5?=
 =?utf-8?B?Nk5LaVJNK2RaS0FuV3lPa0dhNVM0VUVRUFN2aGpkTUlKNlVDZFBQV09ZWmt1?=
 =?utf-8?B?cEpzZkJLOUE3NTlYT0M5TzZtNEVHNkZpSnNrRGF3dGNOcVVMWXNOczFUTFJo?=
 =?utf-8?B?cUVuV2VwMXNGc1hYd2RJSzlDU3Z0dlJ2SzRvcS9wYmtFSWlnaERQdEVUb2FM?=
 =?utf-8?B?aW1TM2VacGhMZE8zSmsxYUkxUWxTdUM2ZC9lL0JLT0g2WEMzTXlxUFZhYzlE?=
 =?utf-8?B?NkxKUzVvTDRqUWJrQ3o4d0gyR2tqcHZZRjRyQzlxaFd3RWI5bjJ6UHpWMzZL?=
 =?utf-8?B?QTAyZnY2Nmw5SitWendiT2xCbER0eFQ1eGVQRGhUZVBuRXdSanBNdW5OVDRB?=
 =?utf-8?B?b1BtdU9mSW1FMi8yeFlnTDlwcDBxaVJrNmE0eDNZaUdzNCsvTDBybVlaK3Vx?=
 =?utf-8?B?TFhpQ2tIQ0pRT1BnQzIwRjlCMjBpSVZ0U3N6c09uTG9RMm00VmtYTDhqY3pH?=
 =?utf-8?B?cHZVSmhQa0RWM1Jqa1llTExXRjNySzhsb3VjeDZyYlRsa3B6dy92NG1UVUJh?=
 =?utf-8?B?NnY2UG9DWnA2cW0raUMrcW96Q2pseXZ1THVCdloxdXdlM0RodkFzeEVqOHZq?=
 =?utf-8?B?T3htS3YvdjdYQ2RrYTJaYWNqeXpyUTBweVg0akl6MmpNNEhIbTRkZ25nS1dX?=
 =?utf-8?B?ZjlSWHBXNHhObThSUW80LzVPOTJKcGVST1FqbFFkS05hQnd1TDl3eEtSZVlL?=
 =?utf-8?B?MDB5NmE2S0Z1SUVXOXlGOGZIaE4wZDB2T3RuWC9vQWN6VFIvdGxmakRuZGxL?=
 =?utf-8?B?MTRSUjgzU2ZlQVY1RWx4cUxsUy9nYTgyVlJBUVF5RjZyVUV0QU9ocTVvdHVx?=
 =?utf-8?B?MmpPaVV0WnVJV0NiNEFRa3I5NFd4cVd2cytmVS9sdzNTVmJ4MTdKWnJHMjJH?=
 =?utf-8?B?UnBZenFDL3pMdzNVRXZxSmMyOG4yWm5CNExkYUxJYnA3VkF0QmJwVXorOHBU?=
 =?utf-8?B?aGsxdWs3emVTT2UxRE1ab2lZSWJhTTVoNEFaSjB4bjZvVkQyZktQbUNnSTZa?=
 =?utf-8?B?d1RtcUZsQTNMNVNheCtqbjBFUWd3OWVYNGw0Q2ttNjVrNXpRRHJKVitlYWtk?=
 =?utf-8?B?VXhhU2l4YkdZeDFTQUNvOEYwa0lLU1p2bmhGYjNCQjJnVzRhY210a1VZek9a?=
 =?utf-8?B?QkUvdURwSUYyd25VQ1ZBSnNIeE5sa0xrSHI3K0x3ZFN6QUdBeXljOU5jd2Vs?=
 =?utf-8?B?REZ1TnMyWVdlZFViRHZFME9USDA5S0RiTkhjakFVT25wTmJvRTZYcWJsWDJF?=
 =?utf-8?B?VE4yd2hXQ3pjNU1nQ1dVdXNWZ2Eyemo0Y3lIR2hTUFZJR0pIZ1FubmRmeG90?=
 =?utf-8?B?QW92WGVvdHJ6WG8xVktmWnZPOS9iSStXSDYvemxabzZYdjhacW9JSkZPNnpx?=
 =?utf-8?B?ZHdqTkgwaWQ1bFN6cEE0dFNaOHFyM3dRWlhIREZLVWRkRlQyVmZsM1JGaEtI?=
 =?utf-8?B?LzMyK1lPd243NWtGL1lwajR6NEphNEtRQWJFSVFiSFdZUXM4RmttVmRWdWQz?=
 =?utf-8?B?eE5ZTW02M2JGSkJSeE9RZHhUbVJ1NDlhQmNKNUtNMHhLUGNkVTdwK2w4VTlp?=
 =?utf-8?B?dGYyTHBNNFlxdUJTZTBsa1EvWkdpN3Q3VTVMeFdwYmxkaWZWalpjQzV4dDEz?=
 =?utf-8?B?OTBnNkNZTEZqcDhRS0kwV1lQMGY3S3JzaCtCalg4aUNXakZmU2ZObmx3V2VR?=
 =?utf-8?B?aWJVaUthTTM2T09FVk9pWk9XYmVXMjFYRTdNaFI1bjMyTTVoYkp2MTZ1aEo1?=
 =?utf-8?B?Y0IrRU9VMkV4UFNYRjdWd1JHL1ZLTERTQ2RXU0pzL1YwWk5KYTJxalkvMzJ1?=
 =?utf-8?Q?YslkPzs0j7fNJH4sg6GkCoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <529E00FBA583404B8DFE2DF21AF3B0BC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3114e4-0e03-4b4c-7c92-08dc74ac9d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 06:59:50.5032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFHwzkpR30VhAtCsY/gmN8P8xfk5UfvRY7UOgZZR1h8OxmpVgDCF0uCqaTGahogwPf5cq4if/Ivu3fWHpmaICc6u5Gd10A/xPl28CHd/xkOhZgVIA5KhuyaQs5gTknob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10139
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

SGkgemhlbnpob25nLA0KDQpPbiAxNC8wNS8yMDI0IDA5OjM0LCBEdWFuLCBaaGVuemhvbmcgd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gSGkgQ2xlbWVudCwN
Cj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBDTEVNRU5UIE1BVEhJ
RVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gU3ViamVjdDog
W1BBVENIIGF0c192dGQgdjEgMDMvMjRdIGludGVsX2lvbW11OiBjaGVjayBpZiB0aGUgaW5wdXQg
YWRkcmVzcw0KPj4gaXMgY2Fub25pY2FsDQo+Pg0KPj4gRmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24g
bXVzdCBmYWlsIGlmIHRoZSBhZGRyZXNzIHRvIHRyYW5zbGF0ZSBpcw0KPj4gbm90IGNhbm9uaWNh
bC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gaHcvaTM4Ni9pbnRlbF9pb21t
dS5jICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oIHwgIDIgKysNCj4+IDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDgwY2RmMzc4NzAuLjI0MGVjYjhmNzIgMTAwNjQ0
DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPj4gQEAgLTE5MTIsNiArMTkxMiw3IEBAIHN0YXRpYyBjb25zdCBib29sIHZ0ZF9x
dWFsaWZpZWRfZmF1bHRzW10gPSB7DQo+PiAgICAgIFtWVERfRlJfUEFTSURfRU5UUllfUF0gPSB0
cnVlLA0KPj4gICAgICBbVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOVl0gPSB0cnVlLA0KPj4g
ICAgICBbVlREX0ZSX1NNX0lOVEVSUlVQVF9BRERSXSA9IHRydWUsDQo+PiArICAgIFtWVERfRlJf
RlNfTk9OX0NBTk9OSUNBTF0gPSB0cnVlLA0KPj4gICAgICBbVlREX0ZSX01BWF0gPSBmYWxzZSwN
Cj4+IH07DQo+Pg0KPj4gQEAgLTIwMjMsNiArMjAyNCwyMSBAQCBzdGF0aWMgaW5saW5lIHVpbnQ2
NF90DQo+PiB2dGRfZ2V0X2ZscHRlX2FkZHIodWludDY0X3QgZmxwdGUsIHVpbnQ4X3QgYXcpDQo+
PiAgICAgIHJldHVybiBmbHB0ZSAmIFZURF9GTF9QVF9CQVNFX0FERFJfTUFTSyhhdyk7DQo+PiB9
DQo+Pg0KPj4gKy8qIFJldHVybiB0cnVlIGlmIElPVkEgaXMgY2Fub25pY2FsLCBvdGhlcndpc2Ug
ZmFsc2UuICovDQo+PiArc3RhdGljIGJvb2wgdnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsKElu
dGVsSU9NTVVTdGF0ZSAqcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgaW92YSwgVlREQ29udGV4dEVudHJ5ICpjZSwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCBhdywgdWludDMyX3QgcGFzaWQp
DQo+PiArew0KPj4gKyAgICB1aW50NjRfdCBpb3ZhX2xpbWl0ID0gdnRkX2lvdmFfbGltaXQocywg
Y2UsIGF3LCBwYXNpZCk7DQo+IEFjY29yZGluZyB0byBzcGVjOg0KPg0KPiAiSW5wdXQtYWRkcmVz
cyBpbiB0aGUgcmVxdWVzdCBzdWJqZWN0ZWQgdG8gZmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb24gaXMg
bm90DQo+IGNhbm9uaWNhbCAoaS5lLiwgYWRkcmVzcyBiaXRzIDYzOk4gYXJlIG5vdCBzYW1lIHZh
bHVlIGFzIGFkZHJlc3MgYml0cyBbTi0NCj4gMV0sIHdoZXJlIE4gaXMgNDggYml0cyB3aXRoIDQt
bGV2ZWwgcGFnaW5nIGFuZCA1NyBiaXRzIHdpdGggNS1sZXZlbCBwYWdpbmcpLiINCj4NCj4gU28g
aXQgbG9va3Mgbm90IGNvcnJlY3QgdG8gdXNlIGF3IGZpbGVkIGluIHBhc2lkIGVudHJ5IHRvIGNh
bGN1bGF0ZSBpb3ZhX2xpbWl0Lg0KPiBBdyBjYW4gYmUgYSB2YWx1ZSBjb25maWd1cmVkIGJ5IGd1
ZXN0IGFuZCBpdCdzIHVzZWQgZm9yIHN0YWdlLTIgdGFibGUuIFNlZSBzcGVjOg0KPg0KPiAiIFRo
aXMgZmllbGQgaXMgdHJlYXRlZCBhcyBSZXNlcnZlZCgwKSBmb3IgaW1wbGVtZW50YXRpb25zIG5v
dCBzdXBwb3J0aW5nIFNlY29uZC1zdGFnZQ0KPiBUcmFuc2xhdGlvbiAoU1NUUz0wIGluIHRoZSBF
eHRlbmRlZCBDYXBhYmlsaXR5IFJlZ2lzdGVyKS4NCj4gVGhpcyBmaWVsZCBpbmRpY2F0ZXMgdGhl
IGFkanVzdGVkIGd1ZXN0LWFkZHJlc3Mtd2lkdGggKEFHQVcpIHRvIGJlIHVzZWQgYnkgaGFyZHdh
cmUNCj4gZm9yIHNlY29uZC1zdGFnZSB0cmFuc2xhdGlvbiB0aHJvdWdoIHBhZ2luZyBzdHJ1Y3R1
cmVzIHJlZmVyZW5jZWQgdGhyb3VnaCB0aGUNCj4gU1NQVFBUUiBmaWVsZC4NCj4g4oCiIFRoZSBm
b2xsb3dpbmcgZW5jb2RpbmdzIGFyZSBkZWZpbmVkIGZvciB0aGlzIGZpZWxkOg0KPiDigKIgMDAx
YjogMzktYml0IEFHQVcgKDMtbGV2ZWwgcGFnZSB0YWJsZSkNCj4g4oCiIDAxMGI6IDQ4LWJpdCBB
R0FXICg0LWxldmVsIHBhZ2UgdGFibGUpDQo+IOKAoiAwMTFiOiA1Ny1iaXQgQUdBVyAoNS1sZXZl
bCBwYWdlIHRhYmxlKQ0KPiDigKIgMDAwYiwxMDBiLTExMWI6IFJlc2VydmVkDQo+IFdoZW4gbm90
IHRyZWF0ZWQgYXMgUmVzZXJ2ZWQoMCksIGhhcmR3YXJlIGlnbm9yZXMgdGhpcyBmaWVsZCBmb3Ig
Zmlyc3Qtc3RhZ2Utb25seQ0KPiAoUEdUVD0wMDFiKSBhbmQgcGFzcy10aHJvdWdoIChQR1RUPTEw
MGIpIHRyYW5zbGF0aW9ucy4iDQo+DQo+IFRoYW5rcw0KPiBaaGVuemhvbmcNCj4NCk5vdCBzdXJl
IHRvIHVuZGVyc3RhbmQuDQpBcmUgeW91IHRhbGtpbmcgYWJvdXQgdGhlIGF3IGZpZWxkIG9mIFNj
YWxhYmxlLU1vZGUgUEFTSUQgVGFibGUgRW50cnk/DQpUaGUgYXcgcGFyYW1ldGVyIGlzIHNldCB0
byBzLT5hd19iaXRzIGluIHZ0ZF9kb19pb21tdV90cmFuc2xhdGUgc28gSSANCnRoaW5rIGl0J3Mg
c2FmZSB0byB1c2UgaXQgZm9yIGNhbm9uaWNhbCBhZGRyZXNzIGNoZWNrLg0KTWF5YmUgd2UgY2Fu
IGp1c3QgdXNlIHMtPmF3X2JpdHMgZGlyZWN0bHkgZnJvbSANCnZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nh
bm9uaWNhbCB0byBhdm9pZCBhbnkgbWlzdGFrZT8NCj4+ICsgICAgdWludDY0X3QgdXBwZXJfYml0
c19tYXNrID0gfihpb3ZhX2xpbWl0IC0gMSk7DQo+PiArICAgIHVpbnQ2NF90IHVwcGVyX2JpdHMg
PSBpb3ZhICYgdXBwZXJfYml0c19tYXNrOw0KPj4gKyAgICBib29sIG1zYiA9ICgoaW92YSAmIChp
b3ZhX2xpbWl0ID4+IDEpKSAhPSAwKTsNCj4+ICsgICAgcmV0dXJuICEoDQo+PiArICAgICAgICAg
ICAgICghbXNiICYmICh1cHBlcl9iaXRzICE9IDApKSB8fA0KPj4gKyAgICAgICAgICAgICAobXNi
ICYmICh1cHBlcl9iaXRzICE9IHVwcGVyX2JpdHNfbWFzaykpDQo+PiArICAgICAgICAgICAgKTsN
Cj4+ICt9DQo+PiArDQo+PiAvKg0KPj4gICAqIEdpdmVuIHRoZSBAaW92YSwgZ2V0IHJlbGV2YW50
IEBmbHB0ZXAuIEBmbHB0ZV9sZXZlbCB3aWxsIGJlIHRoZSBsYXN0IGxldmVsDQo+PiAgICogb2Yg
dGhlIHRyYW5zbGF0aW9uLCBjYW4gYmUgdXNlZCBmb3IgZGVjaWRpbmcgdGhlIHNpemUgb2YgbGFy
Z2UgcGFnZS4NCj4+IEBAIC0yMDM4LDYgKzIwNTQsMTIgQEAgc3RhdGljIGludCB2dGRfaW92YV90
b19mbHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiBWVERDb250ZXh0RW50cnkgKmNlLA0KPj4g
ICAgICB1aW50MzJfdCBvZmZzZXQ7DQo+PiAgICAgIHVpbnQ2NF90IGZscHRlOw0KPj4NCj4+ICsg
ICAgaWYgKCF2dGRfaW92YV9mbF9jaGVja19jYW5vbmljYWwocywgaW92YSwgY2UsIGF3X2JpdHMs
IHBhc2lkKSkgew0KPj4gKyAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBkZXRlY3RlZCBu
b24gY2Fub25pY2FsIElPVkEgKGlvdmE9MHglIg0KPj4gUFJJeDY0ICIsIg0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgInBhc2lkPTB4JSIgUFJJeDMyICIpIiwgX19mdW5jX18sIGlvdmEs
IHBhc2lkKTsNCj4+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX0ZTX05PTl9DQU5PTklDQUw7DQo+
PiArICAgIH0NCj4+ICsNCj4+ICAgICAgd2hpbGUgKHRydWUpIHsNCj4+ICAgICAgICAgIG9mZnNl
dCA9IHZ0ZF9pb3ZhX2ZsX2xldmVsX29mZnNldChpb3ZhLCBsZXZlbCk7DQo+PiAgICAgICAgICBm
bHB0ZSA9IHZ0ZF9nZXRfZmxwdGUoYWRkciwgb2Zmc2V0KTsNCj4+IGRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+PiBpbmRleCA5MDE2OTFhZmI5Li5lOTQ0ODI5MWE0IDEwMDY0NA0KPj4gLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4+IEBAIC0zMjQsNiArMzI0LDggQEAgdHlwZWRlZiBlbnVtIFZUREZh
dWx0UmVhc29uIHsNCj4+ICAgICAgVlREX0ZSX1BBU0lEX0VOVFJZX1AgPSAweDU5LCAvKiBUaGUg
UHJlc2VudChQKSBmaWVsZCBvZiBwYXNpZHQtZW50cnkgaXMNCj4+IDAgKi8NCj4+ICAgICAgVlRE
X0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOViA9IDB4NWIsICAvKkludmFsaWQgUEFTSUQgdGFibGUg
ZW50cnkgKi8NCj4+DQo+PiArICAgIFZURF9GUl9GU19OT05fQ0FOT05JQ0FMID0gMHg4MCwgLyog
U05HLjEgOiBBZGRyZXNzIGZvciBGUyBub3QNCj4+IGNhbm9uaWNhbC4qLw0KPj4gKw0KPj4gICAg
ICAvKiBPdXRwdXQgYWRkcmVzcyBpbiB0aGUgaW50ZXJydXB0IGFkZHJlc3MgcmFuZ2UgZm9yIHNj
YWxhYmxlIG1vZGUgKi8NCj4+ICAgICAgVlREX0ZSX1NNX0lOVEVSUlVQVF9BRERSID0gMHg4NywN
Cj4+ICAgICAgVlREX0ZSX01BWCwgICAgICAgICAgICAgICAgIC8qIEd1YXJkICovDQo+PiAtLQ0K
Pj4gMi40NC4w

