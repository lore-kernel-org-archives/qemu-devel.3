Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87081C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtnZ-0007v0-C0; Mon, 22 Jul 2024 10:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVtnX-0007uU-MR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:13:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVtnV-0001xh-OW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:13:55 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MCJOgu017904;
 Mon, 22 Jul 2024 14:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=B850Lxhd/DQe/kw4sEAYb/Aoe3NQnTI6/DpWl6wv+is=; b=
 obH0a22UItL2qk5fe+TiZYO0WYA1EjykF8574pQUf6fg4X1SXEVRoqDIKwOJ1sSx
 d6S3dNPWtQvDzdBUGRmzpCcq0uLGduJ29/iVDjXH8c0pUwG8Ps3mx4nP1vtg33mL
 eWugZpHaHKg0H4s+0E/kT/PkyUkPPj7DfgZ5BJWjEclZoNiaeIv6I24lq4eaDRg9
 7Uy2ohzCfoZ38sYTi7x5YzjFfl1ZBLBjtQNKt8fDiMoBC+RrkyCtbDYmzUJforqt
 5vvJQdcAg9ixjc8VnQmnwBrMbBQG55nb+2aGaETK08ZKfNlQfT1stW9zUymm1r61
 qNAfuLp5LeZP2cUm+yUg6g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7a3ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 14:13:50 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MCkcb6018838; Mon, 22 Jul 2024 14:13:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h27x81vd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 14:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYhZ8Sfq5C2n6BGJYjweK/fwXO26L10eYU+8LEHqWpGxP8QoLx8C1pn5fhfPJTyH3+97bVM9DmITYXhQH5ducD3b1xl+LagwqUjmQdoLPn+sdAx/2MQR2sZw9ag/kVCt9rktyCzQGOTy1IE1Kx6+/Kfy7g/XuykEV1M7swUFTqQpoODKrOdb0TrH/B858Tfxjo1kf8kZ5YEYBBh72wFgTQDZmlmMMxprRmxhIybREBPm1nNT4jGYcpd0uq8otWZV+2g8a0slx7/kWrC0QakchEfMUILC6ytEtibveQEE6P3XFN7SJkYKKU1kOpau850E/8FWzyqvaEIrCVmnftITgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B850Lxhd/DQe/kw4sEAYb/Aoe3NQnTI6/DpWl6wv+is=;
 b=DTBQQvZodZcvuKam4FUG/b/cEUJ5o5zHc2K6jrez4fbEejFlxzSA+ojrXmK90lFNVfT7mr1Gpg9++uD8blQbwV0UxW8a3vhhDVOSQzsytMN3eQFHXhFBIXpQHPb/zIs2CYXmLGNSrgEtlitu0rqHWmdmNpTqdLkcFsFu9yAfrhjhCpz13MuOLhK7R6RmPH0i3GmX4M8FRCYHK7Q/ucY7GAysg1cXJpQCm48y0IV8hgjhb+5zQ70CdE1fnvS7vxJXp0FSYeRWCMHoXuc0bsVjHmQ8Jk0mYqAAelyK+Dlel2zbdmqXIhMFnJg5jHB0wIlS7fiKqYnOCevN72HRV82vpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B850Lxhd/DQe/kw4sEAYb/Aoe3NQnTI6/DpWl6wv+is=;
 b=lxI/KCQAtDisaPh7ITizUAg6qZPpwR/glTcDL5U07tYWEPaZQ98XbhUWiWJ495fYO9wDWKtu1SepE13kG7H/OeRXoLQjGc2sz8iX3DCSaVr1tH5isUci5GHsE/hSKbubsHzlF16/wbBBqk4WrFGggrCZLAaFgq5o3MEA5NQylyE=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH4PR10MB8099.namprd10.prod.outlook.com (2603:10b6:610:242::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 14:13:34 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 14:13:33 +0000
Message-ID: <952e96f2-24e6-4595-92fc-a8abec746c12@oracle.com>
Date: Mon, 22 Jul 2024 15:13:26 +0100
Subject: Re: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
From: Joao Martins <joao.m.martins@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-10-joao.m.martins@oracle.com>
 <SJ0PR11MB67446F1658661C5F1542D00C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <be585d48-00d3-4a43-b242-fa7dd188e392@oracle.com>
 <0ba48105-c129-4221-bfe3-f2c714bc12b2@oracle.com>
Content-Language: en-US
In-Reply-To: <0ba48105-c129-4221-bfe3-f2c714bc12b2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0545.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH4PR10MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1474b354-672a-43b2-5cb5-08dcaa58788e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzNKYWdKdWhDK3h6dlpqT3VXV1k2b09pWjlDSG1VQXoyT3lKOFIyWTJoTHdE?=
 =?utf-8?B?YmI0RVNPNVpvZ3FjeVYwUGgyaVNYV0tRV0lKUEZSOWRxYzVHOHJTd0xlcXhl?=
 =?utf-8?B?dDlSaU5reDU4bjg4V1c2dytORGJrRXBpeTU4ZGZFYzhIek5HKzhYL1drNVlt?=
 =?utf-8?B?Y1MyTGI4MlcvRFE1dzNLTzV4RE9XTkIwcjBOVkcrRTMxWEpNTHdoRGFFeXR2?=
 =?utf-8?B?Z1VZSDNDeU9pTXNZRkVxQVdhY0VvM0xraC9icDA5TjcrU3dIamFyY0NoVW9z?=
 =?utf-8?B?TWZENloyODBId0FiY0lrMC9LZkU4QTNpNldSQ3ZraXJKRlB2bVZHdnA3eDJP?=
 =?utf-8?B?cm9qOFgxOTFTRUgrWncwZklxRjhoSHU3SCtpcU05NngreWFlck9xNFVqNTdq?=
 =?utf-8?B?QzJCbHhUSVQ4Y1kxeDlsbmNjV0U4NUg3V0ZlWXc4UGJnVW94M21HUXBkRXph?=
 =?utf-8?B?bkFtdEp2Nld1N3ZsSEFzUmRZVndaaFZuZ2NPKzl5YzhlZjl3TWM1M1V1cnFl?=
 =?utf-8?B?K1dsUkN6enJNWHN0a1g3dERZVXBjaGFXbkxESVhPaDBLdVNoZFREQm1mVGpu?=
 =?utf-8?B?OTIwZXFhOE1McXB3eW5Za2ZPdzZKUGV0c1hta2JJQnVCcFRkcXZVMjlqTUpG?=
 =?utf-8?B?QUhIZmg1WjJacE1mNFZOR3NYcVFXaXlyR3dqSzl4dmtiTXhjb3JFdnF0SG91?=
 =?utf-8?B?RUV4c3ZrREpCMVJFekhHOHdTMHRsQ1RjQnk1NmtoellqWmFxWlZaZTdXT3NZ?=
 =?utf-8?B?dEFoTE95Q1NqMW5RWlR6c1lMdkl3YWdRSmpQU2Z6NDdFbkpyWWlFREFOYm1X?=
 =?utf-8?B?T0lESVRHQWIvQ0VrcmFhT0dPZkJVYWlzSlh0RUpwVkdBWVgyMHgybXBYUlRN?=
 =?utf-8?B?eVVENlpIQ3VpQjZneWYwZS9qZXJJdDJmRlNDWEJsR1pHNkxiS0p5dzYveXJh?=
 =?utf-8?B?WEc5RFBRUklxSFBXZldoVytBYjFxeDRGbkdmcVJXTWtpM1lrcmV6VTRUTFZF?=
 =?utf-8?B?ZGhwbUUxNkwxejIzMWQ5YTlRbnZYdjh6U3NnVlZnL3hIOWhNYlRZSTFtcndi?=
 =?utf-8?B?blRsM21VRDV4cUxsbXlQZVMyUkhVV3dlRE9oTlgrNCtBQ2hKdENwTlVtZmNm?=
 =?utf-8?B?blRvOEFGSjBGZlNBY05KUjQ3Vmd1MHNRYjlqUXhvNE1mTGRKMy9VWEhxMEM2?=
 =?utf-8?B?UndDMHZoRm90dERjSjFmWitVYXdMS1htSVd0R05QSkZ2eG9Xa3lPNmtKM040?=
 =?utf-8?B?SEhqN05CUVBRajJqNjhwTnd5ZTZldlVPZXFDVVpUa2ZsNWU5MlhiNzRZS3lx?=
 =?utf-8?B?dDVxNUZwM2N2MGI1cVVQNE5DRVZ3NDcwZHpicm9xYm5mYmxrOGxHZExMMExk?=
 =?utf-8?B?dVNML1ZTY2w1T3B1anV1OHRpTGNCQnhPTXNpQXJBRmNrNlVoTVpSdWRxNDBq?=
 =?utf-8?B?RmszbXNSUjBaNGZHd0RWQmNyWUZteUF3bENrSlVZaGhyS1hOUjlVQURTa1dU?=
 =?utf-8?B?VE4ySmw2bDVBUnhjaUlCTDRnZ3dGc2ZGSVl4aTZtODNGdVc2QnBkdkNYRDdG?=
 =?utf-8?B?dFlPNEVWNDFuaGt6VVNpNW1ETnlyOUltUVkxTWx0K3EyZnQrQ0UwMGx4cDNs?=
 =?utf-8?B?VXkvLzhETHlXOE01cHRhK1VUUjJ3b2NhVURsUmtxMnpLTTNLY05kVVZGanNM?=
 =?utf-8?B?eXhCaXl0UnhPYXV4azlXM21LeWpvalh3YkFDVHFyYlRuK2F5R002a1JFNUtR?=
 =?utf-8?B?dG9JUzdnbVRHYjNXVjFha05GN0pYcnFTT2kvaGJwbzNLSE01QlJva1phVkRS?=
 =?utf-8?B?Rkw3eElFWE4wYzR2V0l1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dExpMWJ0QUVSdWZLc2xWazVOQmhBUW5yaDJBa3hDdlV3Nk5SUVNtcnprOVpy?=
 =?utf-8?B?NUh0K1FEL3pPckU2MFdyVGliczhzYkFBYmJKTTdya095SjRWZC9WUVBjY2FH?=
 =?utf-8?B?eGl3cHVYZlNIRURhODRWUUJnMndQSmdGTDBCUm1xVWprTFJ3L09SbGlyeVIw?=
 =?utf-8?B?OFEraytTNTJ5bUV1dWcwS3AzL1E2VEVwcG1jVmVsc0ZGQXRxdEdNUWlHSjl6?=
 =?utf-8?B?MTRKRE4xb3hKYUhqN3RlcUtKTDJVV2NrS2c0YVFTTDVEQ3pDL0N6aWdpcjlH?=
 =?utf-8?B?VzQrSzEzeTVOVTJqak5KZFFrZ2xETWxVUWRES2t5cEVQQ0RMYUIzcGJVUVhL?=
 =?utf-8?B?RGlWaThGODNXVkNVelQvcWc2Q3grc1JnM1J3dStESE1KODhXSVc3cDdMSmtt?=
 =?utf-8?B?TkdCSjZZU251dXFJUTRHeUsrNitHck1MekFJVVNwZjIxaUNlbG1GNnpNTFQ5?=
 =?utf-8?B?OWhWYjBmVnFCUjFGSU9rdXFsMkpsT1FOWVZiazBoTUw5UTBPcW90Vm05TU1w?=
 =?utf-8?B?WnBwQnQ1VjBBeld3bS9BRk4vM0dqWGRiTnJKcUZJRHVaM2FKc2hrQ3g2NWlX?=
 =?utf-8?B?Z1hTSkxUS2hxTzdwbGNWUjJsWktRSjc4ZjZyNi9EUFBia25YUTgrU3YrV25K?=
 =?utf-8?B?OE5pbm5tSVcxK1BXZml3bEorZVNKbk1WeTJZeHNHM0k3U0dKd0xNWWY5dmwv?=
 =?utf-8?B?Yk5TSGlOWlZDeUs5K3NGMHk0RGlCY1oxS2FISFZsRkhlNGhsMFZBRW5LQVh3?=
 =?utf-8?B?VDdiay9sdk1FU3ZZRzdhNVFRekMzZTQyR0Z1V1NEK1d0dnJlRGJzNitnWGpM?=
 =?utf-8?B?aDdNaCsvRVZXR2pzRS9YZkNZLzV0UEhqWkxCRlY1Zmh6SkVkWDVBTW1xRnNS?=
 =?utf-8?B?MjhXU2xVRFYvcHdiSnRoODN6RTgySW01L1QrVmxiczRiU2xzMnZzNXlCZ2pm?=
 =?utf-8?B?dVFNaGZUd09IWXhPdXFkL3lFZG5yajVnRlR3aUZmT0dLQVFaMjBYb2dERjlG?=
 =?utf-8?B?U3hJK2xYUWhGTmxXbjB1ZmpXZGVITkE3dUVPUTcyYjUxd2pKODF3ckVWcFVR?=
 =?utf-8?B?a0Q4OEh1MlowWTZrWHJaclR4MDRpM1ZJNFVSQjZsbno4emk1OHdUdXI1anZG?=
 =?utf-8?B?S3ZxLzVvSFRCQWtWOXE4dEZBUzBOM3BLVklqUHBRb2RpUWlJbDVsOWpNVWZT?=
 =?utf-8?B?TzJsdFZlanFGRStPeVFtSmd6RUhFYWhFUGFBcjZkVzRLMytIRDM4Y0pwa1Js?=
 =?utf-8?B?djI0RVZ1cDdyTEI4aGE5UzVhVmVnWWZIY3orWjZjSG5mU3B6RUtaWDAwOWpE?=
 =?utf-8?B?NG5rQUxhL2VxSGxVdFYvMlg3SmlXejZOcU9na1lma3lISGs5Z1RMc3lMT3BR?=
 =?utf-8?B?U2ZsZUNjaDA2bVpRVkZlOEJhcXN0R0g3b0I1aVZHSm56TUc4aThobHRYd3RL?=
 =?utf-8?B?WnY2SE5RWWtRMzV6OHZKcHdtK3g0UEtKREdwUXgvc0hYK1pFY1RoM3dwZEgy?=
 =?utf-8?B?bHdGNzZXd091WVZhWE14alRDdDNGaFlJK2xjSnNOWmZmYzdSRFpMZmp1dzd1?=
 =?utf-8?B?dmh5WWZSV2VsR2RqQ0FyN2gvTXhtOGxLMnRJYXVsalN1MkRiaVVQOEtPaEY4?=
 =?utf-8?B?eHBvZU1nVitVaEk2dE0xVHVzYk0xUlhpaGwwN0VDaVBFRGdxSlJGRFR1Tlpq?=
 =?utf-8?B?SHlTN2h2eTEzeitTOGlnVlVzOGQya1BVRFJHNi91eUh3WlhBcUYzbC9xaDA1?=
 =?utf-8?B?dnZJWjhzK3FRTjdWSTh0djllUFBrYmk5cXBHSHN4K3cwQ3RJR3lLTFdqTm9u?=
 =?utf-8?B?VG80ZVI5VVVOTDlkZ2MvNHE3NFV3OEtKQTdDRlRQSklmWHE0MWZtUUtpYzhP?=
 =?utf-8?B?aUQ5UmtNSVduTmtqVXE0TEhFc3NCZWN1V0gvdGF0S0ZKaE94ZHFYTFdiQ1Nr?=
 =?utf-8?B?NFJmUCtTSFhtN3RGSkFJRXZSUy9ka3lXMVU1VHRObXJCN3JKYmhnTExtdEFQ?=
 =?utf-8?B?VW85bDV2T3A2RXh4Z3I4YitsSFMvTjhJQWg2TDV1SURVckhlanNkNE1tNmRj?=
 =?utf-8?B?YUZkcG5GVkY0OGpPMEY4akpSUURSSlVSNEVLT3o4UmZwQUlJK3UwSGVxck0z?=
 =?utf-8?B?d1grT3h6UFIyNUt6eEIwd20ySkhxNmtmRE9sam1ZaVZlVVVUZzNCbFNPZGxi?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5iU62h+0R9qZ85k4f6tLB74koQQiXcoqgFZeO+y7arhY611UJ0sMeGl0TmOl320q3IqJrLRx5sNwTNcfgMKAqSWqpkcNra1T/C/fR7/xTc/XVQdvTbwVf/N/wya6UzLAR4rNu+nO1zkNExoQEaGWhnd6WQRUohSHJBUMLiUSuHQXGFdX1CoY62zkbK4Vi4LYAnR2VHqhqnGJCUglepBkxFGj0dIAXpalePcyVSrBEsuNKB7gjUzZML9iY1Iw9m3heV9Og/TuQQ7ML3bA0Y+CBH8afAWYXpWCMr1p6wW/+yFyvwYvFGvHNMMA//GPlXL3mVigA+PNInnCy/9McKqowhL7TafmmOhoQaGSBbFCAmi7fDlyiA271pK3rvzlSuAAbRdWIL7ZECwZr1jr4xL+yInlUSW1lTWOCeHlmmEX5HgOW6DNpCLk/Sn/u9vMRPGPEg0YPbT5lp8AT+FJ/AOvMdPitNMafOpP7Z/ND8NuHoVYnA/6HRbVXjvrfkkGOQ5twRs9QHlSC+IrA5mzBA1G3qOnEJ7uK48iELU24BdYtkizCTTO08WZxQyMZ6AmUlLQVyVOCygWAtxLhiB+VoFm2MGg9UhIvcv52VW0bQg19lc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1474b354-672a-43b2-5cb5-08dcaa58788e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:13:33.8670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnkrENEnatS2wwFO6F11aHswumoUNPRq2kz5sb+KVOpzHYHYPixDzTgCznURRIalanJK697fMy+42NlnhfvxP2hYcamYb4aQuR/VH4HZX1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407220107
X-Proofpoint-GUID: 09E0qkcAiokpXP-P72xNkIrs8oAweDeN
X-Proofpoint-ORIG-GUID: 09E0qkcAiokpXP-P72xNkIrs8oAweDeN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/07/2024 15:09, Joao Martins wrote:
> On 22/07/2024 09:58, Joao Martins wrote:
>> On 22/07/2024 07:05, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Subject: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
>>>> tracking capability
>>>>
>>>> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>>>> supports dirty tracking. This is done via the data stored in
>>>> hiod::caps::hw_caps initialized from GET_HW_INFO.
>>>>
>>>> Qemu doesn't know if VF dirty tracking is supported when allocating
>>>> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>>>> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
>>>> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>>>> dirty tracking it always creates HWPTs with
>>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>>>> even if later on VFIOMigration decides to use VF dirty tracking instead.
>>>
>>> I thought there is no overhead for HWPT with IOMMU_HWPT_ALLOC_DIRTY_TRACKING vs. HWPT without IOMMU_HWPT_ALLOC_DIRTY_TRACKING if we don't enable dirty tracking. Right?
>>>
>>
>> Correct.
>>
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>> include/hw/vfio/vfio-common.h |  1 +
>>>> hw/vfio/iommufd.c             | 19 +++++++++++++++++++
>>>> 2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>>> common.h
>>>> index 4e44b26d3c45..7e530c7869dc 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>>
>>>> typedef struct VFIOIOASHwpt {
>>>>     uint32_t hwpt_id;
>>>> +    uint32_t hwpt_flags;
>>>>     QLIST_HEAD(, VFIODevice) device_list;
>>>>     QLIST_ENTRY(VFIOIOASHwpt) next;
>>>> } VFIOIOASHwpt;
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index bb44d948c735..2e5c207bbca0 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -110,6 +110,11 @@ static void
>>>> iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>>>     iommufd_backend_disconnect(vbasedev->iommufd);
>>>> }
>>>>
>>>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>> +{
>>>> +    return hwpt && hwpt->hwpt_flags &
>>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>> +}
>>>> +
>>>> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>>> {
>>>>     ERRP_GUARD();
>>>> @@ -246,6 +251,17 @@ static bool
>>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>         }
>>>>     }
>>>>
>>>> +    /*
>>>> +     * This is quite early and VFIO Migration state isn't yet fully
>>>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>>>> +     * whether IOMMU dirty tracking is going to be requested. Later
>>>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>>>> +     * instead.
>>>> +     */
>>>> +    if (vbasedev->hiod->caps.hw_caps &
>>>> IOMMU_HW_CAP_DIRTY_TRACKING) {
>>>
>>> Looks there is still reference to hw_caps, then would suggest to bring back the NEW CAP.
>>>
>> Ah, but below helper is checking for GET_HW_INFO stuff, and not hwpt flags
>> given that we haven't allocated a hwpt yet.
>>
>> While I could place this check into a helper it would only have an user. I will
>> need below helper iommufd_hwpt_dirty_tracking() in another patch, so this is a
>> bit of a one off check only (unless we want a new helper for cosmetic purposes)
>>
>>>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>> +    }
>>>> +
>>>>     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>>                                     container->ioas_id, flags,
>>>>                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
>>>> @@ -255,6 +271,7 @@ static bool
>>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>
>>>>     hwpt = g_malloc0(sizeof(*hwpt));
>>>>     hwpt->hwpt_id = hwpt_id;
>>>> +    hwpt->hwpt_flags = flags;
>>>>     QLIST_INIT(&hwpt->device_list);
>>>>
>>>>     ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>>> @@ -267,6 +284,8 @@ static bool
>>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>     vbasedev->hwpt = hwpt;
>>>>     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>>     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>>> +    container->bcontainer.dirty_pages_supported |=
>>>> +                              iommufd_hwpt_dirty_tracking(hwpt);
>>>
>>> If there is at least one hwpt without dirty tracking, shouldn't we make bcontainer.dirty_pages_supported false?
>>>
> 
> Missed this comment. We could set to false but the generic container abstraction
> is utilizing this to let the ioctls() of the individual backend to go through to
> the defined callback, and that's why I set to true.
> 
Let me rephrase, I meant:  "(...) utilizing this to let the individual backend
container callbacks of dirty tracking to go through, and that's why I set to true."

> And that is really the only effect of this patch. By the time we reach to patch
> 12 (which is what really enables live migration with IOMMU automatically), the
> IOMMUFD dirty tracking is only called 1) when not one of the VF doesn't support
> device dirty tracking [only if you're using IOMMUFD backend], and finally 2)
> that no VF/mdev has added the migration blocker which essentially looks at the
> HWPT flags (as opposed to the container attribute).
> 
> 	Joao
> 


