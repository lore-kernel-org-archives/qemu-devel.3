Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2AFEE3693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYGd-00074f-1W; Thu, 12 Feb 2026 10:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqYGF-0006vU-AU; Thu, 12 Feb 2026 10:05:43 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqYGC-0003Ot-Rd; Thu, 12 Feb 2026 10:05:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEXty1AG5yJ5sCIGZ5f5j6K+dgFjCOSu3466Za0lEpy4xjjXfpcuTIU+o4BIcYLima0xLw5pufQkevj9193vqWL3v5aagGwpXtsut3ozGwzEc4wbqwbKZsbi8AGYzzBi3/IDiN+i6NVQhgqK6PVpHTuvJrKGX5EOa22+2ZSwktFXviQnK6p04m155HS0ul6ULoA7Oe6zb2savhITvI7QWfM9pINcoVCyb5+fyDC69KBcGHucznMF+5EAL08qVtoeantHke8fq1MADTO8rCpJTBVutrhhaxttkCyI+iqEMbS+wxWoW6LKkLhf0d3VlVzmAVeha0r07SYNt+JQfWA3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaQ8YPEds4Dm26qAQCpggz329Pm5SLKUs12BPSaPAsU=;
 b=e61YFjda2JIILRqZboDQi4s/BJYAwsmwlD5UMg654SyOmTZbdTetrHGca6/TiiY4zeW7zl/xM0BmDxHd5RuKPiQA39Op1DYKIXMbCYjjtt/HeekjuZkq5fucy47KL5ITU9vM2Hs3NJE7/ucfxY2yjZeegVLmB7WnH78xi8zN0nshvZsVwjcvwplqKFB9Pu53tZ2OqKaelbG6J00RVl6RDfnb2+e4RRRgv9OVkQyGYmGAK8MWG+YSMewAJeAobYDuL3E6bd4feRPzcGBthKwMGqyB0OgLSDwZ6qWCRGX35248pVR23OirmpH04RN40BCOTvyz+aVHG0KLs5EXAGBtBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaQ8YPEds4Dm26qAQCpggz329Pm5SLKUs12BPSaPAsU=;
 b=XUMhy6jWuGy670MnJ+XKpAlRB8LKOLiGW/yNw0o6ZTA5cqD6OAjYWuP1TxKsFJSsCtO1PTJATPDvCwmdlxoKlgMylqcJc+pibvsqfzDqSlTg6Cjnkai0s/GzdonEUXAG7LqtN+GOhBaJt4hOkXvZSB6momgGYzchrzQWkreJ4TXQjpNBKF0PwBYGGOt9NTmcdAYVpmtmZR8Z06iwAdvOA84VNuE8CPgou6gVGk8boo7oJoqu/TfU0fgzHzrD2jzrNSzCKPCJVhFdVxjjaxGhDqbA/Mkxfc0fql2QT0s3VIsxb7nUktZKRhtYMnU42QcSpHKGJzyEt383oz0+OhXdPw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 15:05:25 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 15:05:25 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Topic: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Index: AQHcl3fclJVY+/1eUEyrJW1egg4NVbV6yXyAgADQx/CAA5IqgIAAAY3ggAACz4CAAABycA==
Date: Thu, 12 Feb 2026 15:05:25 +0000
Message-ID: <CH3PR12MB7548A87A5BC62C6D90501947AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
 <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <dcde8f24-7523-4e2c-8ce6-4048d3ca9c7c@redhat.com>
In-Reply-To: <dcde8f24-7523-4e2c-8ce6-4048d3ca9c7c@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS2PR12MB9662:EE_
x-ms-office365-filtering-correlation-id: 35c6380a-77cf-4d40-07d3-08de6a4826cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NkVyNnp0NXl1dVRmOTZqbEd6UGFJVXJkTXBaUmEvcS9HdTlLcHFtYzl6V1Y5?=
 =?utf-8?B?aGs2dmpPd2kvckI0c21IenZTaE80NWY4OFFkanRnN2RPazFvZXFDajN5cUdH?=
 =?utf-8?B?V2JWVzF4eXR5WXNhVEJQYlFYekg1TytML1FiNzdZTUlvOXFFbG1uMEVDbzBj?=
 =?utf-8?B?U0JlK01sd0RxWHRKNXYzYW5ubUt3N2dDS1JnbStONitzaXVIY0ZuRnRHNGlN?=
 =?utf-8?B?OGJNQWtYTXg3akpBU1RYMHNHelYvZTZzS1k4enJHUTIyNzVNUDBMNjlxQ2VB?=
 =?utf-8?B?NURmekFoUEZucDl0amxDZDhPRW9aWHF4RVdsNEt3VFhDa243WE5uYU81L1Bv?=
 =?utf-8?B?ckc1WGhNZE5aU0h4SjRvL2ZCWjVpaUNlSlUzeXVweTdPSnVOb0RYWi9VQllV?=
 =?utf-8?B?UGNuR1hKSmRVTGJVYXl0MTE1Y0RMVWF3ZDRrSEgrV2xyTHNXam9WaXRoaSt4?=
 =?utf-8?B?aFVGOUsyYUZuekYva3VMRFFOZTBxRnRWeHcyd1dLbGVZd2FQcWlMK0xCRmYz?=
 =?utf-8?B?WGV0dWxkRG11dzNLdVlld0d6MGwvTlo4dkNSUnJ5cEhNNnpkaGJiNmVYQ0Z6?=
 =?utf-8?B?Y2xKMTRzcnBjK3pnY2dTMTFvOWtYeEZJeEZ3QkNZT3RxcmZCR2d0THdtWHFz?=
 =?utf-8?B?NTY2VWswUWRrWXRHQkU4NHh3ZEpLUXY3R3psODV5YjZIU1hJSDZ5TjliR1pH?=
 =?utf-8?B?UHIveFhMUExydUpxUmNHQndQQytybFFRSG1jOVl4Vmg5azlmTjkxYVB6RE4y?=
 =?utf-8?B?RXo3R0VaYUp3OG14b3YyQ1RoMVpSaHd4aE1xUHM2Tk9DMHhnWmJrTHR2UHVJ?=
 =?utf-8?B?Ry9yTE1VdjhxWlhhcGFCV25SUDFsaGdxY3djMnlIYUREQ3diSFFiNmdkQ2di?=
 =?utf-8?B?bkFKTkd6bXhnL2dMbWpTWVhYdFk1VFRBQU1NUlVWdEg5UUNsaHVsM0pxYVRL?=
 =?utf-8?B?NWY5eUtWYjF6QTZwM2o5amYwMDdLQzV3Y2x2VU9vWkNOeWZ5UURtaU5IMVcx?=
 =?utf-8?B?K0VndmVMQjdhbmo1YVVYZFRWMVNUSWxuYzFNY3QwYnk5M3pYa1UwOEVyV3JB?=
 =?utf-8?B?UDd3M0xzYVA5cWVlZnRRUVM2cEo3ZjFSak4wOEc3UzRkNStHOHoxaExtdzZD?=
 =?utf-8?B?Ti85dzdxbzQ2UjJQamJyMmZIZFBDbjRVSkI5akFmWDB2eE5kRVFucVB1Y0E0?=
 =?utf-8?B?SmFDM3d3b3RjM1JwUDYxUjNOVE8xU1k0eVpPbkRRb3BnandDZGU3M3lhL3FU?=
 =?utf-8?B?YndOUFpsMkN6MzZqNlgyMS9WU3dwc0xTTkJDcjBOa2VoQmF4OUNLR2FWL3Q2?=
 =?utf-8?B?M2NlRlRuZnZOdHN2UXk3a3dBQmJVTFZzWjlqTWJDc2hCSnZ4UTJ0b09DVmw4?=
 =?utf-8?B?eVloMXNhSjhsYnRERkdlcldTRFZWU2o0ZFNSbHZLblRmUVNOZ3dvVFBPZmp6?=
 =?utf-8?B?dnVDZnk5THpycTUwLzJBT3VPazVKRWJpZW5jNkkwaitiV2JUdzRZbEpLUEFH?=
 =?utf-8?B?cTBqY3ZnSlFwbEhZUWZtRFY0dVhldDBKcXpPVGs2UDFOWFFpRXJZM1ZXRnRW?=
 =?utf-8?B?TjFoRWpha1F1ck9rdVQwZU04aDFjRXNBM0dzVjkyUnFxTVJ2MFY5S1dIaWg4?=
 =?utf-8?B?OVBkeDYrUWJ5ZHpFSjRxT0t3THdoUHJOSCtFOTNhNjFHTUhmMVNDQUU0RkRB?=
 =?utf-8?B?R2d0bldrektMOW1tN2ZsdFVBaDhrUXc2SlBQY1Zwais3d0F3ejlJYWEvZzMy?=
 =?utf-8?B?c0x2WlE3OGsycTVDU3ZyclBnOFJBMmp5b3AwSUJESExzVHQ2RzJId3ZQVlhx?=
 =?utf-8?B?ZHgxN1ZCN3FIT0pQdzE1dDZmQlhRRTlGYlp6NmhYdnhwTmNZMlhQa3VMYkZU?=
 =?utf-8?B?SGQvMGFpQUgvT3NnQWVyZDBVblI1bENYK1BZWWN4RGJFTDVhdEZLQXBWa081?=
 =?utf-8?B?K1Rhb213djBkZTU3eHFqT0Z4dmhIYnpOYjlPYldRYzhuakJneTMrNlE4RUtE?=
 =?utf-8?B?L3VwbzBoMnNDQlptLzUvQzR0WUkxa0VxVGovRG1veVJkMjdRTXV1c3AvVFJO?=
 =?utf-8?B?emlnU2lNZHVZNmJ6WmVUcXAyazJIUVRsV280RHdjR3JDdTZ0NU5SamNBQWpM?=
 =?utf-8?B?UWgwZEJjMVFLQTJiZVpJc3FqZ0VsdzFka3NWMXBRSk83RGoxYVRGRzJSVFE1?=
 =?utf-8?Q?c+p01SKs5I48mxjoHrRR/1I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE5OU2Rab25DZ1BncVRtMEtKck1sZW1QbE1Ya3kyeWtMZUVvb0Q0MHh2Ym95?=
 =?utf-8?B?aWZrNWQ0QUVGenNkRUVRKys2dC8wcjlaT1pXa29LTjJEaHZrZTVEeGxDSklk?=
 =?utf-8?B?MVFGQzU5T3VHM0NRM2QzcFdrQTdtUmt0Y2dPQU9zeVpodjNQNU5JMjRXRXFm?=
 =?utf-8?B?Z3cydG5memNXU0M4MVZ6eXZzTUdnY1VvNnY5WHQ2MlQwdUFFRWNEYy82aGdP?=
 =?utf-8?B?RHlMWFdtRWoxWWZpSERYcy81MWJ3eWprSWUxZVRmcm5ZdUludWI2UC81Qmw1?=
 =?utf-8?B?VjV3S1Y4cWdRWTdabkZjQU0wcWZoeTRvajJIdWVLZzN3K0dFQlRSMk5ndHQ1?=
 =?utf-8?B?WTF0Qjgyd295S2hNbVMwQ0RKTHA4WHc3UTdhWSt6VmhobVdUNmhwaU9LMGVF?=
 =?utf-8?B?a3NjOUZnL0ZEWERFWW8xNUxXTmhzSzBHM01MQTFvc2lXSW45MEVhTGJqdmkr?=
 =?utf-8?B?ZGM5R29DbDZGYUttY3BqeEw3U2pEYnJqS1NpZGJxUzlCT3RqTGlTTFd1RHJ3?=
 =?utf-8?B?ZmwyTW5RclRxRExsYjlHNUpFRmlWWEFFTVFmbjEzMjZMN0l6clM3cWxUVWZY?=
 =?utf-8?B?TUhLYkhpNncwdDBFRlEyZmQwSWw0aW94R2E0Qk4rakhObGNpUEloUFlJMmRS?=
 =?utf-8?B?ZGkvTWFmYzhQekJtS05LRjUwUm4zWmpZSm0xQnQxOVpFTTR5ZHJIMTdGbVFD?=
 =?utf-8?B?YnlrZUhRUkRFcUNxb3lhV1E3U0lwSFE2Z0tNMmZGNytLQ1N2S2F4ek05OUxm?=
 =?utf-8?B?L1hQOGdUOU4xT0FISmt6TWgxZUhxVVc4UkUvc1FSTU5KN0JVZmxNQ0hndjIw?=
 =?utf-8?B?KzZBTHh1WnRwNWFlWXJDYTFBRzdyN0dremlBU053Nm03NUtuMVdLSExUYWtp?=
 =?utf-8?B?TkErSE1SS2h0MlA5dkdsN0dtYTVpcWJyc2hsNVpXQkJPa0dwTzlPL2J6Mm5n?=
 =?utf-8?B?Zm80dm11cGxlM0pHNExVTzB0am5IUHhuTlhiRFdaRFB0cW5oOWh6V0pNLzVQ?=
 =?utf-8?B?SlFHMml2MkJkOVRhSVNpeG51TlBZZ29qL2pLd2RjdGNUWUNzY3JNdXN3Z2Fl?=
 =?utf-8?B?allYTmtWTitkK0c4L1NWL1dUenFGRVJDY05sN0tXVEpQZW1DME1wbnNzM1Uw?=
 =?utf-8?B?V1VodHNsYktNN2NkWmdjWEJNeGJxdGthQlNWKzhDNStsS0dDeXpRUlNkblox?=
 =?utf-8?B?MjdVZll3SHZzdk4xSTBuZ0c1VnkyOGhncnVZSVhTalZ2UjhjVGhsRnJDdzdv?=
 =?utf-8?B?bHE2dHNuR2NTNjd4K0M3RlhieHF4NWpyamkxOEthRU5vK1pvOWFWUllYUld0?=
 =?utf-8?B?aTVCRzNUVXVOQ0FLSndramJnTlFXd2F4bXJhaHJEaXJuaEVyQjMvVUpETzUv?=
 =?utf-8?B?dXhCUE8yczluTHRqR1NYcGMwcmxXbUQ4MTdhTnk4c1RQYUg1Wjg5aThSYS9o?=
 =?utf-8?B?RVhOS0VYdVYwMjdWWFp1M29JTW05aGRSV1BHakw2WStmbDVFYjhkY1gzQW91?=
 =?utf-8?B?VW8wQ3dqcldQN2JPZmhRVVdOUjcrOXBHSGhBQzRFbGFYMWx0VktOazlHeUVx?=
 =?utf-8?B?ajN5akJEUGpGUzVvdkxvNk1maUNJa3VaM3dJcklqMjJ0eXdwZ2h4bFhHcXJE?=
 =?utf-8?B?ZkpsVjZRTU0xVlhIZDl3eG9tY0xNSEFtY0xkOUMvakh4N0pNalU1em1LLzEv?=
 =?utf-8?B?SkJLWUFrTjg1KzNaN1Q3OUM4a28rWFl0dUdwbGRYNzMzK0xvd0hhWkZtS1VQ?=
 =?utf-8?B?VWkyeWExNEtMd0x6a1pzRUhRdUlBMVI3ZDVadUtpV3BFTEZseDkzSlZnUm5Y?=
 =?utf-8?B?WklmT0ZLN2MzVi9PV2ZNMCtSNUZHdVVaaU1pZ25UeHp6SER0ZmxYNFh1cXl4?=
 =?utf-8?B?N2xkc1RhSnIwb2J2d0RXR0VERGxtczk5bVJ6aDJIK1R6R2JhSUpadzNuK3c0?=
 =?utf-8?B?aXo5QWYxblFvTnBsVk5ic1JTSXQvclNLdFNRMlh4L1hXNDVFY2h1bVNHWW4w?=
 =?utf-8?B?RVFpK2VlN0tJWEVtWStNYklCRFpZQXFWeUUxQlZjQjA1NCtVUFlvYmRpRzRZ?=
 =?utf-8?B?NEhUM21KcmtrU2R6UGltTzkzQ3BrbjJKTTd5eld0U1hCQllEYnRJTWZoU1dV?=
 =?utf-8?B?VjEwMzhXVkRZRmt3Qk1oL0lWQlFkU3pkM1NWNDkzRjF4U0U5d25FdDFFOVpm?=
 =?utf-8?B?SkQ5V0tsT3huNHZnQkVBNmw0U0JGM0VudzN0K2FlbUZ1Q3hUOEJLK2hqMFZH?=
 =?utf-8?B?bVhGejBINmozSE9neTBYK0pIbkNrNkl0OUw0dm04aE9SK1ZSQitueUlBL3E5?=
 =?utf-8?B?WC85NkluWkduMk51WDhFb1prdVZSV2k2Slp1WjIzMEYyNllZaXpRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c6380a-77cf-4d40-07d3-08de6a4826cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 15:05:25.3505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zrcmy1cI+5qHkmo+ombC8d4zyPjx07qxbObW7VFV0r+BZxNkGmA7Ij27Y6ml5rkoRtjjgCuuOjVC2Vrg+XHnfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDI2IDE0OjU3DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IE5pY29s
aW4gQ2hlbg0KPiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5v
cmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBj
bGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsgTmF0aGFuIENoZW4NCj4gPG5hdGhhbmNA
bnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IEppYW5kaSBBbg0KPiA8
amFuQG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsNCj4gam9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsNCj4gemhl
bnpob25nLmR1YW5AaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA1LzI0XSBody9hcm0vc21tdXYzLWFjY2VsOiBJ
bnRyb2R1Y2UgQ01EUVYgb3BzDQo+IGludGVyZmFjZQ0KPiA+PiBJIGhhZA0KPiA+PiB0aGUgaW1w
cmVzc2lvbiB5b3UgcmV2ZXJ0ZWQgdG8gYSBmYWxsYmFjayBpbXBsLiBJZiB0aGVyZSBpcw0KPiA+
PiBzcGVjaWFsaXphdGlvbiwgSSBzdGlsbCB0aGluayBvcHMgYXJlIHJlbGV2YW50LiBFcmljDQo+
ID4gVGhlcmUgaXMgbm8gZmFsbGJhY2sgaW1wbGVtZW50YXRpb24uIFNvIGp1c3QgdG8gY29uZmly
bSwgeW91IGFyZSBzdWdnZXN0aW5nDQo+ID4gdG8gcmVtb3ZlIHRoZSBvcHMgY29tcGxldGVseSBv
ciBqdXN0IGtlZXAgdGhlIG9wcyBmb3IgcmVzZXQvaW5pdCBvbmx5Pw0KPiANCj4gRGVwZW5kcyBv
biB0aGUgY29kZSB0byBjb21lIG5leHQuIElmIHlvdXIgcmVzZXQgYW5kIGluaXQgcmVhbGx5IGRp
ZmZlcnMNCj4gYmV0d2VlbiBub3JtYWwgYWNjZWwgU01NVSBhbmQgdmNtZHEgZW5oYW5jZWQgYWNj
ZWwgU01NVSwgdG8gbWUgaXQgaXMNCj4gc3RpbGwgcmVsZXZhbnQgdG8gaGF2ZSBzZXBhcmF0ZSBp
bXBsZW1lbnRhdGlvbnMgaW4gZGlmZmVyZW50IGNhbGxiYWNrcy4NCg0KSXQgaXMgbm90IGFuIGVp
dGhlci9vciBjYXNlLg0KDQpUaGUgdkNNRFEgcGF0aCBkb2VzIG5vdCByZXBsYWNlIHRoZSBub3Jt
YWwgYWNjZWxlcmF0ZWQgU01NVSBpbml0L3Jlc2V0Lg0KSW5zdGVhZCwgaXQgcmVxdWlyZXMgYWRk
aXRpb25hbCBpbml0L3Jlc2V0IHN0ZXBzIG9uIHRvcCBvZiB0aGUgcmVndWxhciBhY2NlbCBmbG93
Lg0KDQppZiAoYWNjZWwpDQogICAgYWNjZWxfaW5pdCgpOw0KDQppZiAoYWNjZWwgJiYgY21kcXYp
DQogICAgY21kcXZfaW5pdCgpOyAgIA0KIA0KU28gdGhlIHZDTURRIGxvZ2ljIGlzIGFuIGV4dGVu
c2lvbiBvZiB0aGUgYWNjZWxlcmF0ZWQgbW9kZSwgbm90IGEgZmFsbGJhY2sNCm9yIGFsdGVybmF0
aXZlIGltcGxlbWVudGF0aW9uLg0KDQpJIHRoaW5rIHRoZSBsYXRlciBwYXRjaGVzIGluIHRoZSBz
ZXJpZXMgbWFrZSB0aGlzIGNsZWFyZXIuDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IHN0aWxs
IGZlZWwgdGhlIG9wcyBuZWNlc3NhcnkuDQoNClRoYW5rcywNClNoYW1lZXINCg==

