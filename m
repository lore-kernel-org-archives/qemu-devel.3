Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C586C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9hW-0004sq-7C; Tue, 23 Jul 2024 03:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sW9hT-0004kM-VD
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:12:44 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sW9hR-0002EV-IC
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721718762; x=1753254762;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SF2qtQokuqdWj928PBT840EVcBmD4MKHkHnKFKCYd9w=;
 b=XkwcUlXjSPEXoPYUH3hgNxNWiGpwmC2TMFCJEexbbkmKOKeNXT4/EmHM
 CV2OZCHU2Jy0m1mAYR3M+gzVDMNrt1MdlTXsJSdd1zSbp/wMmyp6pqhZX
 tPWvmCTa2O+jqHS491OV4uFLQ6jr3NeaeEBwzmLiu5c/4QiixnpAMVM57
 Py6SCNQh8V2eh4wGCuLkfFAOi9wSPyV1njxwtZKOvDB1Dwg93iijs+Cpy
 Mgs7tRIAL87Nw0ZSc2f0e0F7J5qUf76+SRWZ41TIqCRVCbCoGFmpGfyIr
 vwl9y6td7xJLd+QamDdyMt6G5+jX+jftdnYFQp3+oraFpKEYsfmExMt43 Q==;
X-IronPort-AV: E=Sophos;i="6.09,230,1716242400"; d="scan'208";a="17003533"
X-MGA-submission: =?us-ascii?q?MDHbX1GOfF2T80e2Q40ZkVHqJHVvzfI6s91Zx3?=
 =?us-ascii?q?Fjfa+SBEq5dWh+0N0XXWC2QoL+tayEDDvKe6cArE0dxc3LjpzkZ+tDqO?=
 =?us-ascii?q?49/OCNs9v2TZghoP4DDMcDQOMqS8bVZb371n5ZHhWJ4AfVMnQf8R6YKJ?=
 =?us-ascii?q?X702ookBBmv/cCjgNuz4tFwQ=3D=3D?=
Received: from mail-vi1eur05lp2169.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.169])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 09:12:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCnHnnVCX1AmukSV80h67GvrMz6FUYJlPt5UpVSP9h+uH3tyeNKf/yZ7qf05rm6Y9EUN8gGExT48Ild1EBSySQEU3UL6vrhTiLnLUI3jtz3tPajza4urFNfNDqIf46PrDjY5i/VP0B7ElJIgHSTNiaXgIvJCRXDuIZiNL73ti0CoadZsIy0uIgN0uCZYhinw5XyFx347ldncyv+tDansUOOhK9sRGfMdfIs3rP8RUkQEpNFiCW/DwL13ucl19lrip3lekXNYWF4zyalWzhGLYpNGpAxHPQVTy3MMRi4109Ul8mBwP6ph31F5iAWAG+L03IHlleZK1YCYpKgHRGoLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF2qtQokuqdWj928PBT840EVcBmD4MKHkHnKFKCYd9w=;
 b=Y/ix35iB2p9UUIxt9orG5i9VANIXZSAXEgBMn8qzs97TiH+4d5ExC+fxxwmAL+xHUaxi05yc2Tj/GDrIWZZjtEIZHGheWkA1VD1WA6MJEsLEeD+3sI9hAo+5QmgExzOCC1YBwbIBOHrQFVhmiRC2P61x+pikMZHNWSqR1CEPllvQF98DpyXDe07ERpv6Ji+V+grbrEBttuTC1b12aibZcJBpD6z9evmOtFlwBn/XevYPzsxU6OvrQ644/MUrv+rSHMHFRrhNxFzpvtLx3ZK1ieY+GvR5FUB/JZaZ4rx5/SA4r2pYZnZWGjzsmT8Sd2V3gGBd7SBNpjMUB2afLY0W8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF2qtQokuqdWj928PBT840EVcBmD4MKHkHnKFKCYd9w=;
 b=Zf96ClId+aNkd38qGD2OvGC5M+wAXzM6IWF4H7pU67O4Z5LfSoiU6THteUKWZucVT/iep11enMQt8GhRugM27iU/TZEJnBg4/cxC5lKxbbmr/dn1CunzkZT4tBzkoyaen+o0an3hwj0PLHI3bSC5yyBVsDhNcLmEOjAwv27sSAlN29YhsuR9YPZuD1hQ4j1huEbIq6vHdABRsU7uCRr0dWZMO4yqMZNU+w8mzh9TajwWf1A9rvzNd2YPUUHnXPUO0ctBo+L19cPNwHROX74cp0OpXpgc/A9/DlFJFcOPVaj0EKUfrNu1uFbNCNYamOJpmtbHqxUehWblJQ2C28W2vQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV1PR07MB9168.eurprd07.prod.outlook.com (2603:10a6:150:81::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Tue, 23 Jul
 2024 07:12:36 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 07:12:36 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa2Os6jI53vxLunUO9e0sZTiatjrH8MI6AgAEpkACAAAnkAIAABAIAgAAAzoCABoSwgA==
Date: Tue, 23 Jul 2024 07:12:36 +0000
Message-ID: <e755af11-d3f8-451d-b4ec-5da00fe2cfa1@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
 <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
 <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9c9dba22-df29-4121-8126-4707084b891b@intel.com>
 <SJ0PR11MB6744F4CAEA5A9627D79AFE2092AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB67448D180C7D00AD8F38EA4492AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67448D180C7D00AD8F38EA4492AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV1PR07MB9168:EE_
x-ms-office365-filtering-correlation-id: f5f99657-5467-486a-5532-08dcaae6d481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eUk0Y05TNW5vUkNVY25TTEc5T1pBeHUzUm5YYlovZVVMUXB4N0l6bi9lYkpv?=
 =?utf-8?B?M1FSM3crTmZ5dlpJQVpXQ2c0NjQ5L1JUaFM1alJVSWJUTDlUcEdEb0N3bTJJ?=
 =?utf-8?B?cm9TdWllSHY5OHh0Ym5zYTJnblRzOUhZUzgvTzdiSFF5UXBhTy92TEpMMm5y?=
 =?utf-8?B?QmVacEZsWFcyb1VQTmJmR21qWFp2Nm1qL2tJaXowTUw1Qmd4b2srS3AvRnJS?=
 =?utf-8?B?RUFSMXdFbjMveTIrSE5taHZTZkZuWTZDWlJXVkw3cGp3SnBFWWZhWmFJMksx?=
 =?utf-8?B?ckg1ZFZFaVJyUHVGdHNRYUpKU2VRb1lZMlJwRi9oV1pxOVZ5SEhCeTVpTlg4?=
 =?utf-8?B?MUIrMG5TTDRQVEVoTUZQWWZGcjJiaUYvaWREYUp3Nm5sRFFYQUR5eGRuaHJB?=
 =?utf-8?B?Y0JhcFo3Tm41SHNTSitrRC9uWGVPcUg0dVE3Y0svUnZmSEszSUVJaHpiVmtK?=
 =?utf-8?B?emhWSnR5YVdmVXlZeUxQdDBUTzJIRWNtclhoU0h0T2NhR3hvY3dyeG9BQXIw?=
 =?utf-8?B?V21RckREcjZoOFRMOU1LWlBWYS9UYmtFby82aSswdURmREhlV0dsczFxb0ds?=
 =?utf-8?B?clBORHlQdTZaWlM0QlprUWluaEdvTEZYY2RDSUdzSjZWQnI0ZVJYVUtuSHUx?=
 =?utf-8?B?SkNEcytsVC82aG82cVZTZjZCbW14dk1rVlE2RCtVcURVUXhGTmxSSUhLQmJZ?=
 =?utf-8?B?WmJrTDdhYWt5TUg5VXBiN0VkNDlYdkRUNXp5LzUrWFNIcDNScDEyOVh3SnZX?=
 =?utf-8?B?QUFqSnppeGxWY2RQeUpSZDQ0Y3kxb05rYTl6SG11R2RMemVSeUpFOG94blpO?=
 =?utf-8?B?ano0OHNEMVYyMXlQTTU4Y3A0bXM4S2pSM3hNVVF0eWpOUXBnR3RlZDFDMURq?=
 =?utf-8?B?MVFUL3k2bUxya3ViSWRnTWZCaVhlbjJLTzJTb2hNVUFTUThseXVSdG1xd29I?=
 =?utf-8?B?eWRVUG9Db2VuVEI2WW5vek9JcHVFN2xhdS9SR2ZHVmpwd0xEN1kwTzl0QlFI?=
 =?utf-8?B?bVp6TU1iU0tkU25raHFua3Q2emlDUE05WHBoWGVVR3Y0d1NuWk40dUord0dp?=
 =?utf-8?B?eStiTzJOdnpYSk13TFZ3WjdPM0xrQkQ0R1drWDRvelJ4Z3djVG5RbldmOG9H?=
 =?utf-8?B?T1hEVDIzcjFtUzVRUDBCMVZOYjF2RG1LMmN0VHlLT1Y5a3pwQ3lnOFFVcitu?=
 =?utf-8?B?UTVReHBwZDF5b0xqOGFMRURZbjlMZ2xacVM0eXYzNEwrTDhESkU3eG16MkRQ?=
 =?utf-8?B?a3Z1UEV0S1Fycm4wVlpKOER0NmNGRnZBWHQ5Ym5FM01RRFRQWDZpMWZiVzQw?=
 =?utf-8?B?K0xzQklrOGpKVmJoak1mbVFDUXpjK0dQWjJ0RjM0ZCt4R0ZrRThKelllZFJy?=
 =?utf-8?B?TW95UEJlVE0vR2MzaVZyV09UQkJmYjRNSTZXRTZCZ2ZreFhDeWFtL213ZldV?=
 =?utf-8?B?ZHJvRTdNWk9iUDIzRkZKNHlHUExJTGluL3lEQUxDY1F2SElIV3NFaXJGWFhX?=
 =?utf-8?B?MjVRMm5uMUFWT0NHbERJNHh1SVBGbnBEeGFkdHFWcEora2JOWHZ4TitGb1dm?=
 =?utf-8?B?bG0rdGUxUHkvZWY4b2VXRmNlY3RaZHltai9xaURFLzQzMzFtRWtweXptci8w?=
 =?utf-8?B?VEdhMVNWRkhUQTlRVEtueXdNcWZmcWhlY2FoRkg3TkpVNDFyUTBKVzBzaWEv?=
 =?utf-8?B?b0lydzFwc1IwcmxycVl0Q2YwZFg0Z0hDeEJoQ0U1TWpmek1OK2ZkQjUrTysy?=
 =?utf-8?B?NDhqQmFRRmZGTGdocW5rZ0gxczFueWM4dlR4Tnd2N0hoWFVMcEZFTG0ydWpV?=
 =?utf-8?B?WjlybGY4RXlicmRIVkM2c012NEdPY0hYNzlHZGJHazZGQU5tR1hsWmd4VDVl?=
 =?utf-8?B?QkxNRXRteGRPQzhxVllINDNyVmJLak43ZjJrY1lwR3pnVkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVV5c3Q1OTcvZlJCQzk1aEw2bENCVmZldENaYmk1ejl6RTkxcS9sd1lnWWJM?=
 =?utf-8?B?UWpUdUFuNEFZclFZbE9JZ2VQSkw4ZXJUVTBTT3RCYUpnTWNrcjRDTkRRQmx1?=
 =?utf-8?B?NnRTaTRGZ1gzOFpHUVpiSGt0bXZYL2FTb1pnNEd2emFvZFFRVUs3R2grZjFX?=
 =?utf-8?B?Z2dUMG0zT0tvbG5kN2sxRHBlKythUVlRVS92NjZJNmJHZTJBVVEzOFJFeWpH?=
 =?utf-8?B?eVZoNUZTdGlCT29sQ2RwYXpzZVNJQmc0NlBTZ1RzYWE5ZEdDbUFEaVF5Ukw1?=
 =?utf-8?B?R0Q5cldPL3A3MHAvUkNwRklLTCtSMVJzSG1iYmYwYzlrMVBBUG45SGFiQm9a?=
 =?utf-8?B?cFd4SkMrM0dONmQwNHA4OHRHVTBMdjRzd3pwTEs5OGh5ejQ1V0w3WHQ1TzR1?=
 =?utf-8?B?Um14ZjJDWFdHQ21qTythVkNPUGt0MUZXOXY4b0x6VnZnRkJCODBqMlF1MGZs?=
 =?utf-8?B?Ni9Pa0NsL09oRFpxVVJSaXVUQmRVQW5BR1lSVkxuWm05cUFyOEM1VHhMc0N4?=
 =?utf-8?B?RUN5NndPK3phUWRBTUUyUUJ3VDJqM2VWVjU2LythT0JJNXFBRDRLSTl6NkU5?=
 =?utf-8?B?WFFsTHVCL2hoOVE2azVQTFJBcm01N1JlQUkzS2hRUmM3WXk1djJPK3g1Nkc5?=
 =?utf-8?B?cDJ1Nyt1OWJUUnc3MWkxZE9Velc4bmtFRURERHZrc2lmK25GOHY1OEt2WkJ3?=
 =?utf-8?B?STJlTmtMYU5RU2Y0eU9ZaVBqM0FxM2QvQnlzVE9uTnRUcGx3NFdQRXlxRmJQ?=
 =?utf-8?B?ZWFDQ3lqS3VJaVUrTTJtRmFSOGxEVldqZHJUc1dNTmdyY05lQlEwRHpWMnQ5?=
 =?utf-8?B?ckJIREs4RnR3cE9ZMGFTb1c0WmlXdWNDbG5hZ1dKVWh3RUkyamtWZDdOYW0x?=
 =?utf-8?B?MGhQc09oSnlhN1pTbVh4S3dmS2VUN0dTbFJYWnAycC9MNUliWDBQS0dCZGFi?=
 =?utf-8?B?ZER2RytjeDk2RVJ0dEVzVGFQU3pMbXhodWxJQWFWZzZEMkJQZjZkb0FKcGJw?=
 =?utf-8?B?K1ovcE9XTTlVVFB5WGhLSjdTV1hNSWg0YnhoSnlKQWZKKzREQjRjTVd0dXpz?=
 =?utf-8?B?MnN2OEVkVmpEUUJNanFxVTU2c2dnR0NxTG1yaFF2YXdmemhuMkdCOVZPRm4r?=
 =?utf-8?B?N0lrR0VnMlBJZWlQcndBaEhtUkV3a0Qya25UNlZxYzZuWVh3Z2UybDAxVDlo?=
 =?utf-8?B?WXI3QjQyVWRzOXAzWE1zRGE2am1ITFV3eW5xdXo1RXBwaXZidG5VTEFDV1pP?=
 =?utf-8?B?Q04yb2g0VXZjMVdOSjc3K2Y1NnhHRFBRRCttdDc5eDBod1NMb2k2N1RjK0Vs?=
 =?utf-8?B?NnVORFNaaFdPdFErSXROTHQzeWE1QUxHVmw0QnVMM29UaFFSV25ydk51eVpQ?=
 =?utf-8?B?OGJJOVU3N0ZpTUNLaXNTWGVXQ1BNczBSRDZLVk1BTThJa3Rkd1FQNUhvZnd4?=
 =?utf-8?B?SDF4U0JWaGlhSVkxQWYwZFp5S2JEaUNUWXdJWmJvUlpremg1cEJVVVN2NXRt?=
 =?utf-8?B?b3VRbHFTbERUaU9rYnczS1YzZi9JbC9acG15akxaRllPbk9iVmVBSHc0MzRO?=
 =?utf-8?B?YllwMXppblVRb25lSW5HeTg0T2x4Tnd2UzMySmhTY2Q2cmdwbWJlQjVJRjNU?=
 =?utf-8?B?eXdYTWUzVVFQUmNsV3YzZk0weVd4NjM5c1RwWnRianViNmQwRENMMkprUVpW?=
 =?utf-8?B?UE5VWmhiL3BaWjlSRHV5S2JiNnNDS1poZ0hoNjhDMW5vVkhGS0RGRStta3U4?=
 =?utf-8?B?R2R2OEhaV25aWitVanI0OHM4WjhhbmxjdVBkQWdWMTNoWGI5TmpRK3pmZVg3?=
 =?utf-8?B?TkJvYkh3a3REeTkxd2UzTmNWcG1VeS9LQTF5L1UrLzVOditIbm1FOXlqcnJW?=
 =?utf-8?B?U1VFNm43MHEvNkF1MSthOVJLVjhCaEYrZTYxS1JsazNxVElpMzJ0SG1BTVJG?=
 =?utf-8?B?cDUvMlR0aWNGaktzKzlaTWNTVUVsL3NzVENSTG5FeW9YZnJwbTRPd3FPS0hX?=
 =?utf-8?B?cDB4ZVUvSndWWWtzRG1iNXhxVW5xdUFJUForYTdlUkRSbm1reXVpbEt0N1VT?=
 =?utf-8?B?bFVmMXVUTzBNZmMzNnpPNUlkQmY5Sk9SSFJPc0hSR1YrUVNYZGhzMGYvd1Zi?=
 =?utf-8?B?QzBVZmk0dk5hOFNWSHZtTjJzVmMwVVR3UFBneG5iSWlsWEhWdkRyeHJzQ0dl?=
 =?utf-8?Q?Z51y180xK9XwrwNUqJIBEmU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CFBC247508F0046896F095486842DB1@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f99657-5467-486a-5532-08dcaae6d481
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 07:12:36.3650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrqUuCV12MeFYmlKZ1xkh4H9qki8S0iuPq9yzIiwsjRggPjLB6uqACAWT2JEtIv/zJAoX8gmw8hA0/qBl1vpVZzmbUl+83aSlkYsgIFt0i3WpwagpCHi9MmBWWuGE7+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9168
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

DQoNCk9uIDE5LzA3LzIwMjQgMDU6MzksIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IER1YW4sIFpoZW56aG9uZ10NCj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEg
MDMvMTddIGludGVsX2lvbW11OiBBZGQgYSBwbGFjZWhvbGRlciB2YXJpYWJsZSBmb3INCj4+IHNj
YWxhYmxlIG1vZGVybiBtb2RlDQo+Pg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDAzLzE3XSBpbnRlbF9pb21tdTogQWRkIGEgcGxhY2Vob2xkZXIg
dmFyaWFibGUgZm9yDQo+Pj4gc2NhbGFibGUgbW9kZXJuIG1vZGUNCj4+Pg0KPj4+IE9uIDIwMjQv
Ny8xOSAxMDo0NywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+Pg0KPj4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDAzLzE3XSBpbnRlbF9pb21tdTogQWRkIGEgcGxhY2Vob2xkZXIgdmFyaWFibGUNCj4+PiBm
b3INCj4+Pj4+IHNjYWxhYmxlIG1vZGVybiBtb2RlDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+
PiBPbiAxOC8wNy8yMDI0IDEwOjE2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+PiBDYXV0
aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlu
a3MsIHVubGVzcw0KPj4+IHRoaXMNCj4+Pj4+IGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5k
ZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4+Pj4NCj4+Pj4+PiBBZGQg
YW4gbmV3IGVsZW1lbnQgc2NhbGFibGVfbW9kZSBpbiBJbnRlbElPTU1VU3RhdGUgdG8gbWFyaw0K
Pj4+IHNjYWxhYmxlDQo+Pj4+Pj4gbW9kZXJuIG1vZGUsIHRoaXMgZWxlbWVudCB3aWxsIGJlIGV4
cG9zZWQgYXMgYW4gaW50ZWxfaW9tbXUNCj4+IHByb3BlcnR5DQo+Pj4+Pj4gZmluYWxseS4NCj4+
Pj4+Pg0KPj4+Pj4+IEZvciBub3csIGl0J3Mgb25seSBhIHBsYWNlaGhvbGRlciBhbmQgdXNlZCBm
b3IgY2FwL2VjYXAgaW5pdGlhbGl6YXRpb24sDQo+Pj4+Pj4gY29tcGF0aWJpbGl0eSBjaGVjayBh
bmQgYmxvY2sgaG9zdCBkZXZpY2UgcGFzc3Rocm91Z2ggdW50aWwgbmVzdGluZw0KPj4+Pj4+IGlz
IHN1cHBvcnRlZC4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgIGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAyICsrDQo+Pj4+Pj4gICAgIGluY2x1ZGUvaHcvaTM4Ni9p
bnRlbF9pb21tdS5oICB8ICAxICsNCj4+Pj4+PiAgICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+PiAtLQ0KPj4+IC0t
DQo+Pj4+Pj4gICAgIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+Pj4+PiBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4+
IGluZGV4IGMwY2E3YjM3MmYuLjRlMDMzMWNhYmEgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+Pj4+Pj4gQEAgLTE5NSw2ICsxOTUsNyBAQA0KPj4+Pj4+ICAgICAjZGVm
aW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAoMVVMTCA8PCA0MCkNCj4+Pj4+PiAgICAg
I2RlZmluZSBWVERfRUNBUF9TTVRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDMpDQo+Pj4+Pj4g
ICAgICNkZWZpbmUgVlREX0VDQVBfU0xUUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQ2KQ0KPj4+
Pj4+ICsjZGVmaW5lIFZURF9FQ0FQX0ZMVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NykNCj4+
Pj4+Pg0KPj4+Pj4+ICAgICAvKiBDQVBfUkVHICovDQo+Pj4+Pj4gICAgIC8qIChvZmZzZXQgPj4g
NCkgPDwgMjQgKi8NCj4+Pj4+PiBAQCAtMjExLDYgKzIxMiw3IEBADQo+Pj4+Pj4gICAgICNkZWZp
bmUgVlREX0NBUF9TTExQUyAgICAgICAgICAgICAgICgoMVVMTCA8PCAzNCkgfCAoMVVMTCA8PCAz
NSkpDQo+Pj4+Pj4gICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTl9XUklURSAgICAgICAgICgxVUxM
IDw8IDU0KQ0KPj4+Pj4+ICAgICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fUkVBRCAgICAgICAgICAo
MVVMTCA8PCA1NSkNCj4+Pj4+PiArI2RlZmluZSBWVERfQ0FQX0ZTMUdQICAgICAgICAgICAgICAg
KDFVTEwgPDwgNTYpDQo+Pj4+Pj4gICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTiAgICAgICAgICAg
ICAgIChWVERfQ0FQX0RSQUlOX1JFQUQgfA0KPj4+Pj4gVlREX0NBUF9EUkFJTl9XUklURSkNCj4+
Pj4+PiAgICAgI2RlZmluZSBWVERfQ0FQX0NNICAgICAgICAgICAgICAgICAgKDFVTEwgPDwgNykN
Cj4+Pj4+PiAgICAgI2RlZmluZSBWVERfUEFTSURfSURfU0hJRlQgICAgICAgICAgMjANCj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+IGIvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+PiBpbmRleCAxZWIwNWMyOWZjLi43ODhl
ZDQyNDc3IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5o
DQo+Pj4+Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+PiBAQCAt
MjYyLDYgKzI2Miw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4+Pj4+DQo+Pj4+Pj4g
ICAgICAgICBib29sIGNhY2hpbmdfbW9kZTsgICAgICAgICAgICAgIC8qIFJPIC0gaXMgY2FwIENN
IGVuYWJsZWQ/ICovDQo+Pj4+Pj4gICAgICAgICBib29sIHNjYWxhYmxlX21vZGU7ICAgICAgICAg
ICAgIC8qIFJPIC0gaXMgU2NhbGFibGUgTW9kZSBzdXBwb3J0ZWQ/DQo+PiAqLw0KPj4+Pj4+ICsg
ICAgYm9vbCBzY2FsYWJsZV9tb2Rlcm47ICAgICAgICAgICAvKiBSTyAtIGlzIG1vZGVybiBTTSBz
dXBwb3J0ZWQ/ICovDQo+Pj4+Pj4gICAgICAgICBib29sIHNub29wX2NvbnRyb2w7ICAgICAgICAg
ICAgIC8qIFJPIC0gaXMgU05QIGZpbGVkIHN1cHBvcnRlZD8gKi8NCj4+Pj4+Pg0KPj4+Pj4+ICAg
ICAgICAgZG1hX2FkZHJfdCByb290OyAgICAgICAgICAgICAgICAvKiBDdXJyZW50IHJvb3QgdGFi
bGUgcG9pbnRlciAqLw0KPj4+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+PiBpbmRleCAxY2ZmOGIwMGFlLi40MGNiZDRh
MGY0IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+ICsr
KyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+IEBAIC03NTUsMTYgKzc1NSwyMCBAQCBz
dGF0aWMgaW5saW5lIGJvb2wNCj4+Pj4+IHZ0ZF9pc19sZXZlbF9zdXBwb3J0ZWQoSW50ZWxJT01N
VVN0YXRlICpzLCB1aW50MzJfdCBsZXZlbCkNCj4+Pj4+PiAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4g
ICAgIC8qIFJldHVybiB0cnVlIGlmIGNoZWNrIHBhc3NlZCwgb3RoZXJ3aXNlIGZhbHNlICovDQo+
Pj4+Pj4gLXN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhYODZJT01NVVN0YXRl
ICp4ODZfaW9tbXUsDQo+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBWVERQQVNJREVudHJ5ICpwZSkNCj4+Pj4+PiArc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV90
eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+Pj4+IFZURFBBU0lERW50cnkgKnBlKQ0K
Pj4+Pj4+ICAgICB7DQo+Pj4+PiBXaGF0IGFib3V0IHVzaW5nIHRoZSBjYXAvZWNhcCByZWdpc3Rl
cnMgdG8ga25vdyBpZiB0aGUgdHJhbnNsYXRpb24gdHlwZXMNCj4+Pj4+IGFyZSBzdXBwb3J0ZWQg
b3Igbm90Lg0KPj4+Pj4gT3RoZXJ3aXNlLCB3ZSBjb3VsZCBhZGQgYSBjb21tZW50IHRvIGV4cGxh
aW4gd2h5IHdlIGV4cGVjdA0KPj4+Pj4gcy0+c2NhbGFibGVfbW9kZXJuIHRvIGdpdmUgdXMgZW5v
dWdoIGluZm9ybWF0aW9uLg0KPj4+PiBXaGF0IGFib3V0IGJlbG93Og0KPj4+Pg0KPj4+PiAvKg0K
Pj4+PiAgICAqVlREX0VDQVBfRkxUUyBpbiBlY2FwIGlzIHNldCBpZiBzLT5zY2FsYWJsZV9tb2Rl
cm4gaXMgdHJ1ZSwgb3IgZWxzZQ0KPj4+IFZURF9FQ0FQX1NMVFMgY2FuIGJlIHNldCBvciBub3Qg
ZGVwZW5kaW5nIG9uIHMtPnNjYWxhYmxlX21vZGUuDQo+Pj4+ICAgICpTbyBpdCdzIHNpbXBsZXIg
dG8gY2hlY2sgcy0+c2NhbGFibGVfbW9kZXJuIGRpcmVjdGx5IGZvciBhIFBBU0lEIGVudHJ5DQo+
Pj4gdHlwZSBpbnN0ZWFkIGVjYXAgYml0cy4NCj4+Pj4gICAgKi8NCj4+PiBTaW5jZSB0aGlzIGhl
bHBlciBpcyBmb3IgcGFzaWQgZW50cnkgY2hlY2ssIHNvIHlvdSBjYW4ganVzdCByZXR1cm4gZmFs
c2UNCj4+PiBpZiB0aGUgcGUncyBQR1RUIGlzIFNTLW9ubHkuDQo+PiBJdCBkZXBlbmRzIG9uIHdo
aWNoIHNjYWxhYmxlIG1vZGUgaXMgY2hvc2VkLg0KPj4gSW4gc2NhbGFibGUgbGVnYWN5IG1vZGUs
IFBHVFQgaXMgU1Mtb25seSBhbmQgd2Ugc2hvdWxkIHJldHVybiB0cnVlLg0KPj4NCj4+PiBJdCBt
aWdodCBtYWtlIG1vcmUgc2Vuc2UgdG8gY2hlY2sgdGhlIGVjYXAvY2FwIGhlcmUgYXMgYW55aG93
IHRoZQ0KPj4+IGNhcGFiaWxpdHkgaXMgbGlzdGVkIGluIGVjYXAvY2FwLiBUaGlzIG1heSBhbHNv
IGJyaW5nIHVzIHNvbWUgY29udmVuaWVuY2UuDQo+Pj4NCj4+PiBTYXkgaW4gdGhlIGZ1dHVyZSwg
aWYgd2Ugd2FudCB0byBhZGQgYSBuZXcgbW9kZSAoZS5nLiBzY2FsYWJsZSBtb2RlIDIuMCkNCj4+
PiB0aGF0IHN1cHBvcnRzIGJvdGggRlMgYW5kIFNTIGZvciBndWVzdCwgd2UgbWF5IG5lZWQgdG8g
dXBkYXRlIHRoaXMgaGVscGVyDQo+Pj4gYXMgd2VsbCBpZiB3ZSBjaGVjayB0aGUgc2NhbGFibGVf
bW9kZXJuLiBCdXQgaWYgd2UgY2hlY2sgdGhlIGVjYXAvY2FwLCB0aGVuDQo+Pj4gdGhlIGZ1dHVy
ZSBjaGFuZ2UganVzdCBuZWVkcyB0byBjb250cm9sIHRoZSBlY2FwL2NhcCBzZXR0aW5nIGF0IHRo
ZQ0KPj4+IGJlZ2lubmluZyBvZiB0aGUgdklPTU1VIGluaXQuIFRvIGtlZXAgdGhlIGNvZGUgYWxp
Z25lZCwgeW91IG1heSBuZWVkIHRvDQo+Pj4gY2hlY2sgZWNhcC5QVCBiaXQgZm9yIFZURF9TTV9Q
QVNJRF9FTlRSWV9QVC4gOikNCj4+IE9LLCB3aWxsIGJlIGxpa2UgYmVsb3c6DQo+Pg0KPj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+IEBAIC04MjYsMTQgKzgyNiwxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4+IHZ0ZF9wZV90
eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywgVlREUEFTSURFbnRyeSAqcGUpDQo+Pg0KPj4g
ICAgICBzd2l0Y2ggKFZURF9QRV9HRVRfVFlQRShwZSkpIHsNCj4+ICAgICAgY2FzZSBWVERfU01f
UEFTSURfRU5UUllfRkxUOg0KPj4gLSAgICAgICAgcmV0dXJuIHMtPnNjYWxhYmxlX21vZGVybjsN
Cj4+ICsgICAgICAgIHJldHVybiAhIShzLT5lY2FwICYgVlREX0VDQVBfRkxUUyk7DQo+PiAgICAg
IGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1NMVDoNCj4+IC0gICAgICAgIHJldHVybiAhcy0+c2Nh
bGFibGVfbW9kZXJuOw0KPj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9G
TFRTKSB8fCAhKHMtPmVjYXAgJiBWVERfRUNBUF9TTVRTKTsNCj4gU29ycnkgdHlwbyBlcnIsIHNo
b3VsZCBiZToNCj4NCj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9TTFRT
KSB8fCAhKHMtPmVjYXAgJiBWVERfRUNBUF9TTVRTKTsNCj4NCk1vcmVvdmVyLCBzaG91bGRuJ3Qg
d2UgZGVjbGFyZSB0aGUgY2FwYWJpbGl0aWVzIGFmdGVyIHRoZSBmZWF0dXJlIGlzIA0KaW1wbGVt
ZW50ZWQ/DQpJIHRoaW5rIEZMVFMgYW5kIEZTMUdQIHNob3VsZCBub3QgYmUgZGVjbGFyZWQgdGhh
dCBlYXJseS4NCj4+ICAgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfTkVTVEVEOg0KPj4gICAg
ICAgICAgLyogTm90IHN1cHBvcnQgTkVTVEVEIHBhZ2UgdGFibGUgdHlwZSB5ZXQgKi8NCj4+ICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICAgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfUFQ6
DQo+PiAtICAgICAgICByZXR1cm4geDg2X2lvbW11LT5wdF9zdXBwb3J0ZWQ7DQo+PiArICAgICAg
ICByZXR1cm4gISEocy0+ZWNhcCAmIFZURF9FQ0FQX1BUKTsNCj4+ICAgICAgZGVmYXVsdDoNCj4+
ICAgICAgICAgIC8qIFVua25vd24gdHlwZSAqLw0KPj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
Pj4NCj4+IFRoYW5rcw0KPj4gWmhlbnpob25nDQo=

