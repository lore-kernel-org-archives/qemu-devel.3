Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF636C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 17:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFzKn-0002RR-BA; Fri, 16 May 2025 13:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFzKl-0002JN-2E
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:58:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFzKj-0000T9-51
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:58:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGgXN9024572;
 Fri, 16 May 2025 17:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=jlGHqzlbL3JGqb/4hXWaUytfPWql1hFSxkhILqa7Peo=; b=
 VK1PKgReha3Npou8n8AmkYp7eRLmfRSdXDqJGgzn8Cerm83dAPernWFY5kEQVQ3C
 Hi7nrL4PljtD2XlO9poRwNEGTCv5lHVicrWuJboLJuxBEYWo/y/upKsA6BlGlTaJ
 Cwwt62BLlWzYt/SEI/H+orPaM06+sT7m0ugjIgLRkupZMXS5ougZaHI7wLMvw7SZ
 Ssjvg7HzWuMLVwT2Fy0aRvEMTlBh76b9vz/GCuryJSsddczbarKpiLdzdiU6fjN8
 pxsS5syO3C20VEufamkgBBqyQK842dqENb9nzzUbkdlPTAzb3NBw1eA9awImvtFh
 ZD+zwdDZhzK6xYLy6VjWqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbf1vvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 17:58:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GGBVtd026169; Fri, 16 May 2025 17:58:41 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17011024.outbound.protection.outlook.com
 [40.93.14.24])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mbtavmn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 17:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdLSq/xmeaVAhOkUT4CY9kyCkg4f3eWe+CcCWY/vMAFuHGw3EeBiKso8pz+6T9K0GaA6jCE5nm5XlUG/jRvYOl2LrTP+CQzySBQ7b0OAgoJp94sk7nh86Wr9jh3+5/UnVdUUNfFedlPTp6AMmBuk1vDg+tRUB4Wvh/ZWnTTkT1u+j6T7wYfcAheuWKbMHzvoigNYf7DqJqh5Z6zaen2oCrcIwNJYwkiGTTN0jxqRiwBPpwo7IGkPK2I29CdbLBTvLFEaWatlqedfeZ9RK54wvOTSpbKXOnSsHbB8zupF+BAw9p16vB3ZR2t/7dIxa2W8wyJ2KXvteWxw8C7TC3CJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlGHqzlbL3JGqb/4hXWaUytfPWql1hFSxkhILqa7Peo=;
 b=toycZdzk56XLi6BXNKmYdG5pft7DqnpRL9CFw0f2ESNKxuiyVv9mpGZfVkw3w+7odwwXVBbQCKcH+EV4Uf4DfQ1kvmHtwSKceZd6CgdTY+9+OSg5R6yia/4Sjh6nT28l234884Qh55fBrJ7G4fvmgBm7NK0rm3YiG8HEK+lUrqSt1X/OUTDDlUtD0nY/sCx8eh0erLdFXGjYry4xmKkStzDdgFvdZF5/jpR0Z15wGNaH56U6X34lk4R9fsQa1+yrkUUWvs/+mwJ9UWltONUIGUk7lSgxh1jlng0PCt/QKJJbDw6B3JHyETHiY1FsS/aA1DaOPlkRKfXPIRfzqgcWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlGHqzlbL3JGqb/4hXWaUytfPWql1hFSxkhILqa7Peo=;
 b=o64lgtqussSOH1enJ+Xiqtfg/xuo874UEHYRi4t9kn090e2n9im0Ap0Q0lHYG92Fb5Y/IsUFK58YUSTUxG7ZHRKxnERK0440mI9VfEl/pFhhTq9CXLO7gTNB4qsEYtJpXW5xtYAbJM4G2aeItB9JR4pTdwqCEH0UqqOmVyt+Wto=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA0PR10MB7253.namprd10.prod.outlook.com (2603:10b6:208:3de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 17:58:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 17:58:37 +0000
Message-ID: <25435e62-50e1-4bf3-8227-e2ed93b959e2@oracle.com>
Date: Fri, 16 May 2025 13:58:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 21/42] vfio/pci: export MSI functions
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-22-git-send-email-steven.sistare@oracle.com>
 <c5696d3e-cd21-4d90-9e30-676434c1020c@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <c5696d3e-cd21-4d90-9e30-676434c1020c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0357.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA0PR10MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: cec9a84b-7957-4c62-32ac-08dd94a348a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tmx4TURuVkZsVzZuRW5uSFM1Vkd6NWhveFhkekZta003TExKd01ZaW5sOWp0?=
 =?utf-8?B?cHBoRXZid1ZjVzF0WWFaQzhTNGE4M3p6TE5oenQwVVp0YlZtK1FJNGhQRG5W?=
 =?utf-8?B?cDZaZ2Y2MXhlOTBhVDBIK3Qxd0dEZ0xkVlN2TFUxckorNHkyM1FRTW00SHRU?=
 =?utf-8?B?bUtWS3JtTFMyWUtRN0xDWVd6YlFiSUxVUjYzWGw5RkdXbjQvR2dGOFhaMyt1?=
 =?utf-8?B?WXNBSnUwZzBSOHluU1FpdERqd25iODRQZGo5UlgxZnFLcnhUZ3o3VXJReWxv?=
 =?utf-8?B?WUhlQkJVc01yWEFUb3JRRzBPT2FrWjdxWlFydzNLTG9RMnRVRkNPLzRKNEdS?=
 =?utf-8?B?VUt4Yy9lQ2VFR29ERzA2MzdrV2NGT0liTU01Q09Xb3BqK1hHL1p3T2lyQnlD?=
 =?utf-8?B?QVB6dEUxZS91aEhLaVRCd0w5L1NnQk9OeUFnSEk2YlhVT1RINFA1QVpudWJn?=
 =?utf-8?B?NDlyMEg1Z3VvOGJYdTczdDVUU0kvNFNiM0cxeDZNYi90dm5mTEZRSWxJaUpk?=
 =?utf-8?B?ajdETWkvNnFCdnJ1UW9KRzlDT1BKSDBoMzg2VEl6NDZYOHhDeGQzZ0dQUit2?=
 =?utf-8?B?OHZ4enRzQmZ4cysrMk1kMGswUG02cnhuOTluVDhsdTdtK2FNMm92QWhuZlZR?=
 =?utf-8?B?TmRxQThRaVQ2ODUzcVFIaEQzaG5lTWtLTkhvc0M3T09PREZ5b2FxY2FHQWF4?=
 =?utf-8?B?cVROTDY1V0p3WFp0RVlOWU9WUEdLeUxjNnQxUmZIV3ExS2dRYW9tL05OVUJB?=
 =?utf-8?B?YlB2NGNOeU5ZUjlldDlWTXF4WmgwaW9IYmduVWlNdzlkcHIyK1REbDlmVDhm?=
 =?utf-8?B?Vlh6Nk44Wm1zVC9pU1c1bGNKazg3VUoyUlZpZlc1Z3gveHFWTkVoY1ZZNnJa?=
 =?utf-8?B?MjRlek9CbXY4U1JPZSt4MlhJd2lXOGJyYlFuRmNUaHpxQWZZTTZpeldkdTA1?=
 =?utf-8?B?MUFrWWQ2Qk1WQnJwUDQ4cThaZDZSSHdzNWl1UVFuNUsraWRsR2doMUkvZG1S?=
 =?utf-8?B?YmEvSW5TekJodi9NV09MazIxYnNpWGxKU3REaEV0VW9idVZVZHhUV0lIeUFn?=
 =?utf-8?B?dldMenJ0b0htRElJbWcwMTVPR1k5NlVpZFFZeWNwdUE2R1AxV1YrVWJLN2N1?=
 =?utf-8?B?U2RwbjVVY1lnYnJIQUkyZ2U0V0V4aUtUY0J4YWpUK2ZwZWlGMTBZVlVwcCtF?=
 =?utf-8?B?TUFtVW45WE9HNHZSVnlWcmo0VFY1S0xwU1FFK0xEa2lyRDd2MlFHS2FZTkdC?=
 =?utf-8?B?Y2V5ZENUUnVmUVJXM2xmNWhsTk5hNnZDNm55NFNJUEIrZ3FmenhKQTlZUlV3?=
 =?utf-8?B?SG5kYmxiYnJHU3hFeXBVZEdJbEdOYVlHcDJPbTVHQWdxQUV4N2NXWVN5ZjZ3?=
 =?utf-8?B?REhHa3NPNnZkTTc3a29DMHFITy9rQ0VRTGxvRDN0Tkt4bXZ5OWlUSGIwT3Zi?=
 =?utf-8?B?a0N3SE8wbThPSnBxaDNlaDRiYzhyRGxVa29xRStCL01kcVNMUlppU0hIaStJ?=
 =?utf-8?B?MHdvOG9yWTBGa3FacFpOZFVRY1FTdE5HTU9WZHp3OWJuRjl2SEQyZVl5dFlI?=
 =?utf-8?B?Vy8xRFVlSmhYMTBlOGpRTU1aeWx4NnpOTFhPdVVabzNrL0o2NHc4WEFHQWND?=
 =?utf-8?B?T280T1V1VENFNE10Y1gvUHZCSGV4VW8rZGp2WEZjS0lRL3JjbGJMNjVMaGVH?=
 =?utf-8?B?ZzZHZHR3VjFRVmMzVFZsamtydjE5a0dGeDAxTVMrNHJUd3NqS1BhUU16emFr?=
 =?utf-8?B?ci85dDN2WkRaRFNzRnU3NDIyZ010WVpvUjdrbHJjclNqUVp2Uk9SaEZvRVJU?=
 =?utf-8?B?OEFLeGdaZGphUFp6QXEvMk9NU1Fxa3pPSkUwUUkxOEo2amFJZUpUdzRuU3dW?=
 =?utf-8?B?T2plbGQ5ZHJweUIyTmdkNlNjektMVFhsekdwSXExei9MeCtWWkpNaG5vdXhm?=
 =?utf-8?Q?vF+Qj5V59C4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExzUWJzWUx2UlpJR2lnaDh3aHp3R0RqTk8rNDVYR1hWRTJDK0NLMW9pV1J6?=
 =?utf-8?B?aCtOQm1mWUxCU3lpQUhLaXdhdm9mdU1SMHBsNGtGVXdNdFdxdStURk5NRWpQ?=
 =?utf-8?B?alRrV01TR3o0alg2Y3dUMHdpYzE5dmtsVDhRRnlHenNVcXUzRGJHckF3RmFh?=
 =?utf-8?B?ZEtxb0s0bXJYQjcwWEZHTmx0bFp6bFg2YkhKdzFVenhHVXZSUjAxQTdRanZ2?=
 =?utf-8?B?RW1qaE9NSkpkdHFTZzVYM0RDMXVxeCs1cmx5WjBGcWZRcDNNanFqdHM2ckJS?=
 =?utf-8?B?OEVNa3R1cGRZa2tYTk93RVViWURrWUtDQTYvcGJwclkxS3dEUURQWkNBUmNU?=
 =?utf-8?B?T1FhRXpLNStocVcxYy9xNVRIZWhsajFSelJQUEpPN3UxV0h3cHYvUTZDZkhB?=
 =?utf-8?B?bEZVL1JDUXMxUEtQaWhyaTVIZ1NBSHRiT2RqeklSeHNiRDdXUWFGb3E4Umpz?=
 =?utf-8?B?UG9UWUx6dTZrMDFSMkxNaEMxWXpFTEs1bnpta3BRd1RxMk1MMVpqbFl5elo4?=
 =?utf-8?B?VTA0QW9tUG4xaUUyaUpSYkJmRHMyYUhqMDlibVBwM3VjbCs4NEI0UHVncHlo?=
 =?utf-8?B?bmpWZVlDTGlpRktNaVY3d1JGVHUrL0pQM2E0YUVmUDdQTUd3dzROMFljbnJm?=
 =?utf-8?B?OE1IL01SbUd1bGUwaE1SUnhpdUN4M0hCczBjQnhZVmQyMFN1VEtZNytDTkcr?=
 =?utf-8?B?MFNZRE1lMnJUa0crbTBKeUZpKzNUeE95RzNKazd3MHczSW45akF4VlZrQXZk?=
 =?utf-8?B?VHlqOFNzUnlucmQ2aXNzc1lGODJDSmtvYlorRDVkSkI4VTN0M2FqNzdBR1lZ?=
 =?utf-8?B?NkJ4WU5JYS9jYURZNDgyb1hJQk1Ob25BNE4rTnlLcE1wUHJOMUppcUx0dndE?=
 =?utf-8?B?OVRidGpZNFNDckJWTkpHOW9JMWQ5bmtoS1ZGUWlEN0RDQlNpYmpnc2JocnRj?=
 =?utf-8?B?cGdoL3VHWXR1TDBxTGNibDd4bkE2WGUyZU1ISjNxZ2hsWnhqVmlrOXBkN3dX?=
 =?utf-8?B?UCt5WXpOd095a2tmOHNudXZLZldkTEx1SFdnV2dPSkdVeUpINzVtOWJkaDlr?=
 =?utf-8?B?NFRXek1GM3BGNXl4WGxzQ3RrZW1pQVJHVmVweXdrcVhlZ1d4UnczRHVBam9T?=
 =?utf-8?B?WVpJN1pObW8wWEZxaDI4L2l0d1k4Nk9Ob3ZHdm9pZTVGRkg5NXdIelJYRzkz?=
 =?utf-8?B?STFOQVMwc1UyMW5iUTZXTWZoOGMzNTdxNkUyZ0k3aTJxb0VKcWlCV3pXMW1u?=
 =?utf-8?B?Si9ESy9NZXZrSlBHUThjY0crclhWUWJwM1RYRmszSDZzeUZVNElHNWZSdjcz?=
 =?utf-8?B?b3dXYlFLQVhDdFRRa3k0ZDVIdEF4S2xMYkdhYU5nS1FGcmtsK3gvZWVYS2p0?=
 =?utf-8?B?ZTVIV2dSVDgrYmxaL29PamlvdXBocXVLdmVTRjF0c3R2VUdweXZSWi9LREJI?=
 =?utf-8?B?S1FFaXlsYkpqVkN3RVY2clJLTXJrVW9OV29LQ1JZWnljQ1dmUm9XT1pVai82?=
 =?utf-8?B?MkdjZUZyZ25RTHpIYW1FV0dpSElOcjFJb28zT0x4TlA3WGhsazY1NXVUd3lo?=
 =?utf-8?B?c2xnWFVLTUtwaXVESGY3VzRkVVZZZ0g5YlB3K0h0bEtVS3lBMS9nbTUxL25Z?=
 =?utf-8?B?RTZrMklxWmtKZlBlaVo4eHhyWXJjVUFMMmVxdXpWS2lzTTJUMHpCeUxaRVlO?=
 =?utf-8?B?R1FBVjBzYTNvNWhCcENpZkZ2NHhLNFBkUTE3SmRMV2lJTThudGdvdGRBTjhZ?=
 =?utf-8?B?RDJjZElpWXdRKzNVRkFsdFd0aUtvV2Rad0xHc01RbHpRaGhNTGxrSjJERUkr?=
 =?utf-8?B?SzF2T1VWci9xbm5pUGVEc21lcmdhd0t5MjdBNnd1eDljWXlZd3BqZ3N2L0xN?=
 =?utf-8?B?OW51T0NHbURjbm1GaUo1SS8zVXN0VDZxTXVwbjNEdFR0b2NLWDk3U1NNcjIy?=
 =?utf-8?B?MW9PM1RLVjhGbUNKbzFCUHlNQXMzR2dDUmRUZGNUb3VqOVpwcGdhMFBnbyta?=
 =?utf-8?B?enVkSHdseittQStJTFVFNXVjNmkwTEo5aXY4UHdIdTFwdkNuRGs3SjVCQ0pE?=
 =?utf-8?B?ZlBhNDg1b0VmM2dGbi91R1BFeUlQSVBKelBoNTFtY20xT2gyT2wzK29hbjdx?=
 =?utf-8?B?R3hNMVNYNlcrVVJ0YlpKaGpLOFlpRm1kYjVIYVMyVWhXVFJNTjk4cWJqOFNC?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zySQElmBTqFDPJRpnvITHCdrSY2qaS3xKBqlXC+fawIhob/AlNCxV0ww1hjOt53x1Rrf+SkpLstnJUl0+Mid3jCCEH+ZF2W2AvsHqi/vCfNKOE7FmWs62YZrCL7GFkXkXqoGj2c8knJtEXLngEQNk6iycJEQy/nlzo/HMGk7ri1XS1cPlteSsctIAn7IIbjBXjdyiMV6Qh+6ZbYItoD5P1aWxxjue2LHBQQm/zSJqB4IQCeNDrhVuN7PNBtg1jT8IE+8HfACgOhbjI9PakP0DgYH21MOevrvTxDjv02y/0A9QgklZRDsFVNPqKhyppF3i0936gBJAeo2I9cBIboRDZJn+ukx+BI/iMgtGOoU4YzZV9vdHTw+M2PTxGjN2jIO/gIo9Mm976aoyuPhvU6p3guLfnOOCjwY5/sx+TPJFzreguqZKI7b3IdUNJavRK1Pijr4G1spq0AGDPdYuZolgW1DaYODQ3HJNTBZCpBPzOZ7QTJ5bhQuaQr6dRPNeZhuNaurJ1w5QkQIwZ2NYPtcDts4zv8U4NH44vzLf3h6eL4NgtKLnVr3Qp6lWZc7robqmTMwDc/uPkWguZ7kDCihxbSEVPWl/4O117fJkdV289E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec9a84b-7957-4c62-32ac-08dd94a348a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:58:37.7699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4XQuZckrTIAoOrdb8Ur3M5O4GbU8/hTJuWavS+q+bDyhBpuLgZMFQSKtPbWOj9Ii3zWHT+xeMwRbT0w/e9RPKsN0NX2OeABK2lphYc2GsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160175
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68277cd2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=SOup1YpzuKxHnXuNfKEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3NSBTYWx0ZWRfX7ugSEqgfMdZH
 mTl6eUwSobGMiO+T9QTzPqcLpmUhYoL2v2DDBjWphccZ2ZxK6Gjtk+ecgNVe3O/kov3TlNpVl8+
 PTb88iR5/ohg+0K8Y9sN+nCa8mrSff1Q1anh36y0J89aKs1nLxPqAYcIAKlE3lxaYZIRpPLg0yF
 yC1K7pA3ygVtVjv0i6LO1sbI4CdCE0Ko8We6PxwEcJswRyx3hzWIwjdpqVBMXwqoWB74Itel0n9
 XNYrThtf+QZtoq+e8MrQGxpDCI2vCQGokEUQ41BZtYBN1kAPL5Lz81q1gscygPv7Z0OuxAalfpq
 kLAnoNE+8oF2ONv0jKKBnRPmlxMaw4cTEUSdry/0vcHblKZRdxoMS20mDNAkbfPPdorTLeSeDfB
 HDJGBKwUSnH2Zg5r3SVeeT92dCglbnn8PW2EDDlYbbRn2OiOlS1QQVOIvoitW93mrmUwZen7
X-Proofpoint-GUID: I579vdh0T2TrgYjjMNdPd7fT9wetauEW
X-Proofpoint-ORIG-GUID: I579vdh0T2TrgYjjMNdPd7fT9wetauEW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/16/2025 4:31 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> Export various MSI functions, for use by CPR in subsequent patches.
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Please rename this routines with a 'vfio_pci' prefix.

Are you sure?  That makes sense for:
   vfio_vector_init -> vfio_pci_vector_init

but the rest already have msi or intx in the name which unambiguously
means pci.  Adding pci_ seems unecessarily verbose:

+void vfio_msi_interrupt(void *opaque);
+void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                           int vector_n, bool msix);
+int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg);
+void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr);
+bool vfio_msix_present(void *opaque, int version_id);
+void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
+void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
+bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp);

- Steve

>> ---
>>   hw/vfio/pci.c | 21 ++++++++++-----------
>>   hw/vfio/pci.h | 12 ++++++++++++
>>   2 files changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index d2b08a3..1bca415 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -279,7 +279,7 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>>       vfio_intx_update(vdev, &vdev->intx.route);
>>   }
>> -static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>> +bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>   {
>>       uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>>       Error *err = NULL;
>> @@ -353,7 +353,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
>>   /*
>>    * MSI/X
>>    */
>> -static void vfio_msi_interrupt(void *opaque)
>> +void vfio_msi_interrupt(void *opaque)
>>   {
>>       VFIOMSIVector *vector = opaque;
>>       VFIOPCIDevice *vdev = vector->vdev;
>> @@ -474,8 +474,8 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>>       return ret;
>>   }
>> -static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>> -                                  int vector_n, bool msix)
>> +void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>> +                           int vector_n, bool msix)
>>   {
>>       if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
>>           return;
>> @@ -529,7 +529,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>>       kvm_irqchip_commit_routes(kvm_state);
>>   }
>> -static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
>> +void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
>>   {
>>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>>       PCIDevice *pdev = &vdev->pdev;
>> @@ -641,13 +641,12 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>       return 0;
>>   }
>> -static int vfio_msix_vector_use(PCIDevice *pdev,
>> -                                unsigned int nr, MSIMessage msg)
>> +int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg)
>>   {
>>       return vfio_msix_vector_do_use(pdev, nr, &msg, vfio_msi_interrupt);
>>   }
>> -static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>> +void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>   {
>>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>> @@ -674,14 +673,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>       }
>>   }
>> -static void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>> +void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>   {
>>       assert(!vdev->defer_kvm_irq_routing);
>>       vdev->defer_kvm_irq_routing = true;
>>       vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
>>   }
>> -static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>> +void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>   {
>>       int i;
>> @@ -2632,7 +2631,7 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
>>       return OBJECT(vdev);
>>   }
>> -static bool vfio_msix_present(void *opaque, int version_id)
>> +bool vfio_msix_present(void *opaque, int version_id)
>>   {
>>       PCIDevice *pdev = opaque;
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 5ce0fb9..c892054 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -210,6 +210,18 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
>>       return class == PCI_CLASS_DISPLAY_VGA;
>>   }
>> +/* MSI/MSI-X/INTx */
>> +void vfio_vector_init(VFIOPCIDevice *vdev, int nr);
>> +void vfio_msi_interrupt(void *opaque);
>> +void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>> +                           int vector_n, bool msix);
>> +int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg);
>> +void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr);
>> +bool vfio_msix_present(void *opaque, int version_id);
>> +void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>> +void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>> +bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp);
>> +
>>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>>   void vfio_pci_write_config(PCIDevice *pdev,
>>                              uint32_t addr, uint32_t val, int len);
> 


