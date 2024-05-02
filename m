Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56132C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNR-0003jQ-II; Thu, 02 May 2024 11:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNO-0003is-UJ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:38 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YN7-0005yW-IU
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663761; x=1746199761;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oYY4iC6hjphMuWFvN9OX+COHJCqK87uXfmgSAcUtRSw=;
 b=Ddb6FRHYZuYx5VUDYe6KkooBN4fbur6fWp6XXmLFMB3lp8j6rE5N9Ai+
 6A5CSHDOPbb4qXCII/58D4lAFFZ7zPPosuL2+vvuQiOgXH2JqILREr7tM
 FDUt/TYrseouLLX8NhpvhfQYQt0RuXzcmadvydlVXLkTJCDbrrLEQwAga
 E5iGEa9AyEHqAAI4xP3gCRE8b1tcEXcyNQcMJNd/3Ute/pKnCK9NgomMA
 jluQHLcYzb47U4s99rxRjdQtOeQbazkn6VacRe8X/NdMEvLMY3c7jeamN
 X019ejIA1KqvS/pKa/bqQ9pXkUOTkPKfTk49myWqma4CWEP0M/2xIq7Cp Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785873"
X-MGA-submission: =?us-ascii?q?MDF8Q9DlUIYTKsz+pBjeCGQyjvrr6JjMUajRvq?=
 =?us-ascii?q?7Y/DbALCLgYUmj9qkm5+DniX0PZrxU6BpJ6AsGzqVuPGwnDyPdIp6POL?=
 =?us-ascii?q?S7J/3qdvoeL6Q71EX4RcoivuYEuGtffC0i9u6YLBsEY35rlJ6s18nhoF?=
 =?us-ascii?q?BUcH/WND7rOh/pi9oMe0HaQA=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHmDtf0seW53LOY+6dsTfcU7/DD7mAxBozNvm6kgbYPlLsB4Gy//TyDmMa/ADZLYZWOwS6cGYnA8ny7bfU3D1QLvVfoHA1whGv8gKBkk0ayTh/hLXktu2nTizVBGUBPECIea+WE+P05KOnzyaRnbty3hGqOYwKLSMVHjQegJyWMYsfqBZTcOxMY39LrjLQeqIlS3UkalR9bmTOS1AeYAjAxKgs3blIB5eJOwDoedvlBfpkEbD8yAkTT1+eJgcqIjS2SL48XlCQf3oIIOTWPusUm8AFaAlKtR7OUh8SaYHx566VlU1y8rdIDObN9cFetBKja4+ngGFaMeZz/kcAZa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYY4iC6hjphMuWFvN9OX+COHJCqK87uXfmgSAcUtRSw=;
 b=dNkrrwQTPp3AJmHBacvNA0+dl/dqc3O5/fqiqitlQbLz9jASXn8zm2NmqfdFwIwqESO1M71t0dp/17CdU3hTeJX6zBFt+Dwv09mZVWluYk0m8Q3V4QcUjEgWXvpcxJTaRUo8aonaPwkc9whoYbCNGpRnHS1G1VSIYyOPywWs+PfQQJj3WvSeBQs/3SGQd975/V6EFw/b0HsblLU3Y1r2hckqcvhbPW+L1VRh+HOmgtGdSUr/0aiVtHbzMhrUkfv0wbtCasKywQNQjJMD88jDpyNxOixxwXPD62UguRLsdRFxQdXJL+6Xnyl7rGWSWQtTIAqrLp7QHk9CoQxwop8lKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:16 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:16 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 01/24] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH ats_vtd v1 01/24] intel_iommu: fix FRCD construction
 macro.
Thread-Index: AQHanKV+0oFxZ/mIHESjydUfkcyb3w==
Date: Thu, 2 May 2024 15:29:16 +0000
Message-ID: <20240502152810.187492-2-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: 85d91a4d-d423-475c-3ff5-08dc6abca121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?M1ltRnY2MlF5WEpYTGppWURnaGJKNE83Mm5NK3A0U2VhZWsvT1lsWkpGTTE2?=
 =?utf-8?B?bS9IVGtMUXFmcnZYNnppOUViK2h3OFdReDkxalE2ZGtRbXVkMWp2RzVBQVV5?=
 =?utf-8?B?a2g2RE5JaW9Ua05xV1JLY3dkVGJsYnZ5NEtiSWpVMHdGanNkaWhNMk95dmc2?=
 =?utf-8?B?MXp6NnZZQXRKTnk5SWxQb0Nld2pxdFlCVzU5S2Z6alhDaXlWK0xQME5KNHZu?=
 =?utf-8?B?ZXAvOXlYWTk0Yld0VVhld0o1WlBWaEJESlBDck83RlN1N3F4ZGRIUWw4VVEw?=
 =?utf-8?B?eXJHeFBBemY2MXArRjdGT1ZYVXZZMURNaHZDMzc4MWJHZW8ra0o3dEtUdWNE?=
 =?utf-8?B?M1cvdjBWN0dVNkpLQnN4ZTNSZkhmaU9hZzFjUE9ZWlJUTTI4VjN0bDA5N1hP?=
 =?utf-8?B?M2hzbXRsRFBtZE1BT1VYNkkvN3k1SzkyM3NNb1owcHd0RytPOTRBM0QwVm11?=
 =?utf-8?B?RjRSZGltV2dSNi9Tb3VSS3JGRnZON3AyUUVVcWtWLzYzS1hITmhKc3MrSDhM?=
 =?utf-8?B?WEthTGE1ZWZZd3FsVk9FVWcvYTVma3F2RUJDRm8yell1ZGdkTTlqYkhhSThZ?=
 =?utf-8?B?QTYwLzV2bmlXdm1SWFgyUzRrWnh3cWIrL3hxQ3RtVVNMUGRHY0ZQd2F2RzdT?=
 =?utf-8?B?cTRKZzQ0OTJlUHRUd2ZPNGZ5Z0VXR2w0U3VNOVErUEJja1pwRE5wWEMrRm1J?=
 =?utf-8?B?MGlsQkNTeGFDS3VKazI0UlpqT0UySVNtTUh4ZXZIdE5DaTk1RW5ieEdkbkNw?=
 =?utf-8?B?V0RXL3RiOExqK3N1eUozbXRSVzFlek8zUmNZV1J4bGFoejFHNnIwWlc1ZUVG?=
 =?utf-8?B?dDdnN01QNjBBNXk1MzQ3VndpTlllZjgzVE5sbXordEJnNnNNZ3FZNzhIOEFO?=
 =?utf-8?B?dG5MeE8rSXJiM0owSGx1dmcxQm1qUlpWNXRkYVl4SFAwdTAzMEsrUXgzV3JR?=
 =?utf-8?B?Qm56U0Z2MmlMU3c2UllUeW95U1VSTVVvZGhMZU4vTkx2UWk3OTJiTDFKSXZC?=
 =?utf-8?B?RXB0MHpZOVl5M2I4TWx5bS9ucVlremR0S0orM3BZU3JlMUFJMVlua3VWaHpV?=
 =?utf-8?B?K1V1QjVsTVhCYndqYlQ1bkJYZ2dWNWxwZlJ6MHlITGZBQis0QWM4UFAvWUdF?=
 =?utf-8?B?bmFjUkJ0a0YxL0N0STBzTVZlVEllMVp2b1lMMEpJeE9adkpoNWhtYjBZZ090?=
 =?utf-8?B?MGc0UER2YXNocGUwWjdRdDNCejlxblVMbSs2dmdVQkoxV0NmbjdBQ21xU1Fy?=
 =?utf-8?B?V2poU2VMdndVbyt4LzJjekliRmpBMnZvam9oVHVJd0xMSlpCQ3hsZjYzWUR4?=
 =?utf-8?B?cE5UTHhMTFFuT1pxd1p0R3YvY1MwY0lsZFFpMi9NWWVYcER5cnhBNHlmS2Ru?=
 =?utf-8?B?UG0zb3M2Z29Vd3JBMzNCaUg0RDR2RDdIM3c4M2NnYmhLT2dXb3l3NzRGbFRV?=
 =?utf-8?B?M3dxNWhnMU1jd1lPQ0ljYzlyWW5HTWJISlcxN2lWbmVsbHdpYTZFRnE1bU5a?=
 =?utf-8?B?MFh1OFVlcXdzaFUzdGR5NFBXUUtKMVorNjg4M3c4MHB4cTFPM3FDcXpyTjgr?=
 =?utf-8?B?S1JaaEJGRWlROXJsdjRVb2tkSjV4Y1FEZXVnRGZ0YTh1cUkybFJOdWVZUFRL?=
 =?utf-8?B?Wk1JWW9YSFpuaHZlalBETlRMd3RsS3dDU0FhVnFNZzgrbk11MHFRa0VPbnc3?=
 =?utf-8?B?dDNKVSt0ZS93eFQ5cU56M3d0S1l1ZjNRNnowTEl1bFVEVno2K0M3S2ljeVEy?=
 =?utf-8?B?V3Y5Y3lsVlVWNFIreklvU2hpMGZSaDFxTHNsVlFQbVdzczVtRUkrbHJ5VDFT?=
 =?utf-8?B?TjdKQ2owcytYTVBNTThXdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGtwSjVyRzhpZkEyMTBJUHpreUJydGpTRURrb3VqS1hPU2ptVmwzYnY4bVli?=
 =?utf-8?B?T0sxTjkrSkVENE9rSzQ1dEUrTjlGTWRUdVhmSSthS2FyT0N4c1NrSDFaTkhi?=
 =?utf-8?B?VG5LZlliMFdBQVhDbTEzUmJOdC8vVFFNV3dtREMwOHlwUU5CSUJVMk1nV0to?=
 =?utf-8?B?UzRqYUdEa2dXQkhqUkd2eW16amFPU2J2eld6bHhXK2J3eHRrNkxmVVBXVHU1?=
 =?utf-8?B?ZklWRnBNTGp2SWd4S3o3QmpCbVZITkt2NEpyV1ExeWJJTERJNFNKODQ2WUQy?=
 =?utf-8?B?czB6WFlYVFdINm1uY0xpMjhkdTB0ZGVIMmNoUGNla2dsRXpaWmU0QloydHI1?=
 =?utf-8?B?d1d5d21xWFdqTHhIY1kyakQxcTdUM0VBVFBZeVQ3c2VyT1dIY2RSelUyNXZv?=
 =?utf-8?B?UEhqT0tBc2F4OG84aEorNGtiVjc3MGRNVFJlVlF3QkNLOS95R1czUXhvU3ph?=
 =?utf-8?B?Z1ZRZUwvdlM5Vm95V251aWVSUzkxR0VxcmJkQXRNeXRFbVZTemY5dlFxcENz?=
 =?utf-8?B?ZzF0NmJmZ3NPeWJPeDdudXZtTU1mUmcwcGU4RXZ2TlN4NVo4ZlBDOVBMbDZO?=
 =?utf-8?B?dmVPVTNaMThwNFRObmExbUlMNEZtOXBVMW04RGRTOE8ybnVHcTRoZ3ZOTjJn?=
 =?utf-8?B?TjZidWlUTzdqOVhqTk5ERVQ3ZnRFRmdIOHdlQ0hmTjVQU1VrcmFETklnSEpY?=
 =?utf-8?B?M0lnWTE1UnlPcU5wRDVNU1JtNVpQcHpRcTJESU04UTUxbE1ocnREbVo5SGRN?=
 =?utf-8?B?RlJGOEtwbm9XV0xqV3FKb2N0ZmZuWldLVkJDR0dLUkdRekZuYUN6aEh4c1hH?=
 =?utf-8?B?dmEwaEVLSDZBSjhNZEh6aTdJWVpXVzJmNW8zVlB3SHhhWFF1T0VGYTlLRWJJ?=
 =?utf-8?B?cjFJTlBPVStoYnF5NnJpYWpwZy9DZWRSd2t2OVRtUmZYZFlMWk9kWG9Jb2Fo?=
 =?utf-8?B?Tk9jNVljN1lOM1QvendaRnhOdXM0cWlqUW1pbVJYTFhLcGZDQzM0U1FDaVhL?=
 =?utf-8?B?QnAxOWR2WG81WndIb1N5NnhIWjJib0U3TTdqbCsrUXZIVnJnSVNXeGpUL1kr?=
 =?utf-8?B?bDQyaTJyMUk4dHR2L3lkbVRTQytOeGNqK0lMZzNHWXE1bURCaURMaU9WQ1Vx?=
 =?utf-8?B?STZpeHNOOTRpVTRpNnRhNWtCOXZSK3NCc1lFQ1NBR00zcm52T2ZJZDRLWmc4?=
 =?utf-8?B?RVYyVXdvRG5hbUVlRUVqeW51ajk5S0thMmx1VCs1dmhzOTFzRDh5ZE9WeHN6?=
 =?utf-8?B?STI0Yjc1UTc5ZUcvYVZCREZRMnQwWWFYR0VQVWgwNGhDSTYrNy9zUkZFaWVt?=
 =?utf-8?B?eS90OXBuUkdBMU1yTFQvR3cvVmhIZXhhdlZXN0o3RGZ0dVFPOElPNWloNTZv?=
 =?utf-8?B?RllGUHMzclArYmNSQXJ1R2NHZkkwNDBXOWt2NXQ2Q21XaTJYTzI2S1hvbXVi?=
 =?utf-8?B?eUVORXZGYWVaZzl1SUtEVUUxdWlSUDVVTnJsdExCc3N3aVZKNzgrUnQwMlJI?=
 =?utf-8?B?WU5ML0hadGRuRGdZTUhSR0hzblZzRlM1Ulo1dmVncklyd2JNUjd4T1ordWVI?=
 =?utf-8?B?Ujkzd3d0S1l1eDIzNks0ekRsYklPaUxFSVRGWXBEc2dVSDQ0Z0xoaCszeE55?=
 =?utf-8?B?eEY1VlNJb2lpcGxtK0cycm1VWU4xZHBwUm16bjBQcXlIZ0U1cWFqYTVNamFR?=
 =?utf-8?B?cEVxZDF6dzJzTWJxZXAybEpSQUZVemNhUU1BTFl0TjN6TXBXUHFEOWU0QmlM?=
 =?utf-8?B?L3p3NUF6ZVJGOXVLNFF4WmIvOCsyYTNzU2l2dDE5ZXdkUDkrSzFXMFc5S21P?=
 =?utf-8?B?MVZ0NTJ5WGlEMXpLY01GN0s3N0FzTlJoRG5sK2piUlpmaDVFalN2SU1TTDZJ?=
 =?utf-8?B?N0tjN1hvSWp6ajNaUWFjRXdzTVRCN1JWOVhqR09tQXB4QkFVZVNQbXcyVTZW?=
 =?utf-8?B?ZUtSaFQxWU41SVVVUDVQem5LVVByd0NVb3BCaUdKUUQ3NnFwMjlENFdGRXVT?=
 =?utf-8?B?RW5aRm0wRURVVWticFBLU0FXSEoya2l6NkNsNngzWHk4ekJGYld0RWU1TTNj?=
 =?utf-8?B?SGkxNDAxaGIxRkhuTi83eUFJUDBmdDhWMTh0dmFPR1hSQUhhcnJxOWVkcUxM?=
 =?utf-8?B?WnVzRFd5YXpqMUVrSVUzMXl6YkRFMUY2cmMwNzVOT1J5a2haTUR5cjVwNGRt?=
 =?utf-8?Q?0XofeQzjiBZI+ll+8lTAUTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B98B1588D36FF47BED2BD79AD3B541A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d91a4d-d423-475c-3ff5-08dc6abca121
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:16.8837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8DOwWigbMDGLj4xN4StLBfzSumIWQ5LPimZH13ofL3g45AJwzo0TTmlZn3hJfHnL+CwFY/GX+tpIASbi5l/tSaOPj7XPrDh19SHjIqalBHXG5R9y5OCotT5XhLlNmQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
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

VGhlIGNvbnN0YW50IG11c3QgYmUgdW5zaWduZWQsIG90aGVyd2lzZSB0aGUgdHdvJ3MgY29tcGxl
bWVudA0Kb3ZlcnJpZGVzIHRoZSBvdGhlciBmaWVsZHMgd2hlbiBhIFBBU0lEIGlzIHByZXNlbnQN
Cg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGM1ZWZjZmY5ZmQuLjRmNmIwMTU0YjUgMTAwNjQ0
DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTI3MSw3ICsyNzEsNyBAQA0KIC8qIEZvciB0aGUgbG93
IDY0LWJpdCBvZiAxMjgtYml0ICovDQogI2RlZmluZSBWVERfRlJDRF9GSSh2YWwpICAgICAgICAo
KHZhbCkgJiB+MHhmZmZVTEwpDQogI2RlZmluZSBWVERfRlJDRF9QVih2YWwpICAgICAgICAoKCh2
YWwpICYgMHhmZmZmVUxMKSA8PCA0MCkNCi0jZGVmaW5lIFZURF9GUkNEX1BQKHZhbCkgICAgICAg
ICgoKHZhbCkgJiAweDEpIDw8IDMxKQ0KKyNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAg
KCgodmFsKSAmIDB4MVVMTCkgPDwgMzEpDQogI2RlZmluZSBWVERfRlJDRF9JUl9JRFgodmFsKSAg
ICAoKCh2YWwpICYgMHhmZmZmVUxMKSA8PCA0OCkNCiANCiAvKiBETUEgUmVtYXBwaW5nIEZhdWx0
IENvbmRpdGlvbnMgKi8NCi0tIA0KMi40NC4wDQo=

