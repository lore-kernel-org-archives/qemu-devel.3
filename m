Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72242C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbwY-0005W2-5Q; Tue, 01 Jul 2025 10:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwV-0005VE-FV
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwM-00028U-F5
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9DCx030369;
 Tue, 1 Jul 2025 14:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=XlNmpB6z1WU3GrwyDWw+GsMZNsLXHh65tggn5KROKOA=; b=
 GqZeidEdYTFJPvjTqhAxsyEoly7gfpknteGFOmj1ek5Hq9TjQRB1I8+YOcm2QZUH
 KhzyioV9D5dPJVm3pPJpGtjg80u9OBd7M2jbEi6rA5zqkr6UVg1VwgV4+gfd4Bax
 nSEPG/21AlNZpXR5u+p1uqDPiXkg2+61BGn98yvTIZSQaqnaOV7MZZFtDAl3s/og
 BpMNepLO8owHopvboMT1UG7Gn9WWL2pLOqmuMUPCYFM4KwmLlrgEgpHjZh+R8szB
 mMtBu/Cr1eMm9m2rMrMEIz4y1yng8j5eeutKukvJ8Pa89ecrUR9KvgQCIPeDe88N
 fu78nuWebxeKGpB9daLy6g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfcure-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561DWGj6033604; Tue, 1 Jul 2025 14:26:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6u9ugq4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7rDSwSUyTDLC3xUZ7D8qMBpDNfHX71qG4/FXqgAoLzj0me15HhDaEHXgjlbZcoZVY/OCKr9imXI//YnG62V/rISbB/+5O1/fqvX8281Rp+7oE5cWoddF4lQNCoTNuKfZcHgnajQxTKYTL54J4gnQRqGhAsqXBYKMpxbopmAdQoNsCzthIUnuM/sNUO7QVkhQ/WEeUIR1BCu74dynV5olygITjtU0eKHaH8NQo9Moa4Yx5O1VvAF+EyicggBI2DS1nP/5xvZN9mkMvXtiCyxHDKqPICqvRXFkrMPmT8FAQDLXqyCbXBCwQmN9B7y82OkJNeLLgPHr5+9E0vXK91lOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlNmpB6z1WU3GrwyDWw+GsMZNsLXHh65tggn5KROKOA=;
 b=b8jk3bHD1BsTdHFHGUkwCTPs6Nfs4e8iJcbijirrluZV94mFLf1phinbsDkPsKVy/1e/BQoYQtylGbe1Ok7gukVwEHEuCMgtekK8QLv4plT+3022NTdpZ9lwtskbH9RQ+VDIG7zeZLQ7+j+C0wvc7EVRmu02tUSSKk58MFWlaJAPeL1Rje2Ag4Tx6N6L7w/ZaSe3+0qfEhdMgMogmUXr8wGt+ITpu+CLmlEQ2yis7+slcuQRzit7JH7B2o0ElgnQzzIOW3cye5I6BuPWR86oKXK4zVX/giphwSfT08ykqn+DjU/85pI19Y4KVEeQis82QOgos+o/ZVm7eBCRfBcdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlNmpB6z1WU3GrwyDWw+GsMZNsLXHh65tggn5KROKOA=;
 b=WSsGmrXnt+dhxu2TUl2mmMmQ5R0uJU88CtfP5i1C833YcMeTWMF1UcAe0EGwEsp/RfvAofgjh2tY4xHrCoEnFAlDr1TEKYcxX4yWabLlYJICqarfPQKfTt8fceIfvFjzvNTV0ZDfmpCrVFv7yqE8Ps63BpvTFjDnkJZ2GAAoLUc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 14:26:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:26:21 +0000
Message-ID: <01a73b7a-1586-43eb-b6d1-c3ea78915c30@oracle.com>
Date: Tue, 1 Jul 2025 10:26:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 32/38] vfio/iommufd: preserve descriptors
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-33-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136E189D71587ED549F823F927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136E189D71587ED549F823F927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f47b911-d2e9-4176-ec82-08ddb8ab3ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFFkeGhiRWowSU5ROTgwUzNvNURlYjREOVRCRUZTRjM0WGFxV1VHYlFqRnky?=
 =?utf-8?B?T05nYkNCMmN4dEJLSXpIU0UzNThVTndmd2NwMmlHTHBCNVlrdzliaDlMWnBv?=
 =?utf-8?B?aC9zTU9EeFJRNGphcnc1NmlIUWxhNjhONnJxajViRUNEM3JQdldpbGgxd3V2?=
 =?utf-8?B?QmZTSnA0S3ZHcGNUWGF3OCtlQlB0Nlg3VVhEbDlSVEtiTnI4ZlFieW9hbXlW?=
 =?utf-8?B?ZFQzcWlYRWRxTWU3TmhJZmdwelFUL0M0djB1eGtWZHBCblc1TGNjRmJwdlZa?=
 =?utf-8?B?WXpEaFdlRDlsaUxUc2FscGVYQ1ozOFNrRXdpcGVscjB4UmplbUlaU0I4ZXcv?=
 =?utf-8?B?OVR3eTlLNHpacW84dWpxVnNuUnhOeC9OZVpnZU5OaTFEcnNzUVF1eTV4emRx?=
 =?utf-8?B?b052SHhqeGpKVmFCSzlIQ2loTG8xa05sektSVTlEV3N4UXluV0xlQ3crQW1o?=
 =?utf-8?B?NFBWMjQrMGJjS3VJMFY4TW5nbVE0MGlVb2RwOGg0cTZIRGwrOGZkek42d0VE?=
 =?utf-8?B?TXBvTUZVb002SkdrZmRjdm1NcmQwZk5ra0x3Ulh2ekhkbVZSaFRpYVVOQS9p?=
 =?utf-8?B?SXJETXRSZDcrYjBhVGZqUHo1WmpxaDFaMWpFZTkvQzVnN3FWeW54NkU5emZY?=
 =?utf-8?B?ZTArc1hGSU94Uk40SFkranV5QnpyWFA5aENtT2d2bWV4alFCSVBXd2ZNVXg0?=
 =?utf-8?B?emFzZzl6dmtTUmhObGJjb21nNjVNcDlETjRlTjlnY3F2MTdmYmpmUk9nMmJa?=
 =?utf-8?B?OEd0QkpHeVRtTmtqYUJXZkw2WHBjY2orOERCN1ZzZG01L3BuWklBbFRIWWhp?=
 =?utf-8?B?YmNLT3d1UHpzYStpSTdtNTNMblU3RGtaekt3bnQ1U20wbHdrWlpqOWVmMTlS?=
 =?utf-8?B?ZFhYb0Y4Y2tBclBVbEdOZjJFZnRpRHFIc2JWc1hmd2Q3WE16SUdIRWx2V2Vt?=
 =?utf-8?B?czBFWWZNYW1wUHNtckh4eFlqZjM0eHoycFg1eGpnZHFPdmtTMVpCdzhnbGFJ?=
 =?utf-8?B?ZWZCb3hmTDJqNnJRL3dQeUkzdkR2MktrUGdNOGtIK1pmUndtdEg0VEZzOWtl?=
 =?utf-8?B?cXgzbmtkMTdZV2k4ZXFPeFpXbVl3cDlacHFZVCs5TDlPVGpaNndrS1N5Y2h5?=
 =?utf-8?B?bDRLTmhDTjlERVdxRFFUTUJsUHYwcFRmWkpyRmJNaG1BRkZLaWdpcnVCaGRo?=
 =?utf-8?B?SHdHbVczOHNRV1lRUmtvd2F5RGNyMkRIeFpHRWhUaHVzbFNleEdkV3hhWjd3?=
 =?utf-8?B?cUlkaVRRUGp3NjBVVjk3bVFaRnJiVEFYKy9OMEFhMzNtYmFvMm1XRi9kanIz?=
 =?utf-8?B?M3V6L3NyVnZaZllJSkR3TG5RRXNRS05nYm5PSnFLVUtlQUxDQ3dXdWt2R3dE?=
 =?utf-8?B?RVYreEFCQTVHQjBLTCszL2Z1Szc4UjhIM0ZhMjBPV2hYU2hkUS9MRVQxZ2gr?=
 =?utf-8?B?eit6KytiODBkWHZWTkJ3UTRkNi8rUDhsZktySE5jSGw3eDJWVFRjalhYZHJI?=
 =?utf-8?B?bjVuTytaTlR6NzBZQm1JbzRZZGhGaDNmckRSSmUzVjFoM2NNVkhMRzdRRzJv?=
 =?utf-8?B?UEFVM25handXQjhOQUdNME95OE4xdDdIaXExMi9obUFRZFZ3bWRoZGxtRXZJ?=
 =?utf-8?B?NG96ZEpOTGxpT1BMZm96Z0src0NJV0xUSlluSzNvL0k1dkdBd2hjNk9OeXUv?=
 =?utf-8?B?K1RLNVBYdFc3ekZaeXNlL2V0djRvbkF6SjExTzZmdWVDeUtwOUZMUTJhVmo0?=
 =?utf-8?B?OURIZUE4OXBjUkhNTkRrUlA3SG03aTlUTjR2Q3JaWWszWXNXcGFJQm9nVzBj?=
 =?utf-8?B?aDlFYkZZaldLcGFFZ0VQM21ZUFBORW40ck9oZUpaOVVGQTlEU2UrZFBRY0Zp?=
 =?utf-8?B?SWhjTlJlRWRKc1AwQ1pVeU9Xc29mdHB3S3g4bEhKb1NxUk9UbzZiTVJ1b0Jl?=
 =?utf-8?Q?d7jzhM42KKM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2t4N1dzM0ZweTg2NmVROEhwUXkyZHVUUXhVdEpMNUtJVDM1SS9taTArQW5w?=
 =?utf-8?B?VlVpVmRjdHA4UEZoMUMyQ3FoKyt3dTJFam90K3o5TytzemlxS094cWhKUjd3?=
 =?utf-8?B?cXpZQzNCUWZFTWxYc2J5aFV6RHZKQkFoTEQ5b3krNjJTTUNZRG1BUVRJa0RR?=
 =?utf-8?B?cFFJY2p2MXZYL1phSE5FdnViSi9vL0o5b0pvazc0RmlXWEJJK1J2TlAzM3pT?=
 =?utf-8?B?bnFtSEZXZFNwcXgxR1djM0dYZXl2b1hLYkg3Zlo0aW5aeGdVbWdENXZjNVlS?=
 =?utf-8?B?a1BwTlcyWitjeVZ5bXl2Z2tlaWE2d1BXa1hCcTIvbnRsczNhQUVFSkVOYUdq?=
 =?utf-8?B?TE0rOWVkLzlUdW1JMm9IK0k4aUdwZEFob2drTW1sdDBSR01YNEZxV3Rpc0RH?=
 =?utf-8?B?NjdqbERIRGREc1I1cnN1UzlDcWpVaHFmMGVVamwxcFhVU0E1cmJCOHZrd3la?=
 =?utf-8?B?N0xHK2lIM1dNS1hLR1VWNHpZMTd5cUpKUDNrdklKY1J0RzFqNEM4Yko3RndE?=
 =?utf-8?B?UVlDWU9GeGp6eERVVHlFVnQrUHkxUWswbDdCMVI3bmRWN1lQZlUzYzU5VjA4?=
 =?utf-8?B?Z0o2WWZrQ05NSDdSbE11N2NxOGltNUE2cllDMXo2Nlh3aklvUi8rL1IvM2F2?=
 =?utf-8?B?NTZzOXNleDROMzhkSnhNZWo3ekRuNHZVVTVhZGsxc25qR3NiMFd5dWhXRExE?=
 =?utf-8?B?TC9rOXZCYkx1WnlwRkdTUXE4QzZ0SjBNTHhXWC83RVdqNTliZVBtQVZQdkVr?=
 =?utf-8?B?dVg1dlJ3TzUyOE5IaEVoZEZWeXF0KzVaai9aVU9nNFYyalh4VUM1blpydzc2?=
 =?utf-8?B?SGdrdTBSMVppb2x5UWVmbHRnQmZDT2haMDBOeWhyc21hMkY2SVBSOXYwY1Q3?=
 =?utf-8?B?K01TYmtGQnYwcHkxL3NwSmdxUWxaQzBxTXViOHNtYlZqWFNGVWY3VVE5MUUx?=
 =?utf-8?B?ejlXZE9uY0RwNlpFSzkrZDdUVThXNFdvcXFOTjcvSnFWL05Pa1ZTaENEam44?=
 =?utf-8?B?bkZLZCtZK1JtREFudkpMK1laQzQxSHdmZWtXVUlPd2NRbC9IM0k2MVZEYjRi?=
 =?utf-8?B?UnNMOW1NUlBHTmhBSVZ2aDI0WmhBUThRKy94cUIrdm5HMm0rSG1wbHQrTXBU?=
 =?utf-8?B?Y0NMcEE1OFdWRjNjM0t5MmljOU9BVWVYZFh0ZkdlZWFoL0F2Wm5CSHNDK1Nn?=
 =?utf-8?B?dTllNjlnTVEyaWpPa1dCcUMybTJiODZvVWJDQnkxU3l3di9WSCtIV2pwMTEx?=
 =?utf-8?B?eExBaGV2c3NFRURWUTZDcFN6ekVwUXBRdCtHb21JaVgwYmNxZkI4UmlTQnIr?=
 =?utf-8?B?RkloSU90d0hVNlhqSm9ETmZOTnF4azc3YmVWVzdpdHR2TzlrRDd1WFNwSk1Q?=
 =?utf-8?B?OGlGb1llSkVRdGw5RlZNS3ZzU3pRRG4xbXd5WDN5ZkFtQm5IcEVsUi9TeEJk?=
 =?utf-8?B?Q01GMVRKdjVQM29TWHlZRE1VSWpnVkxmQkZ0RCtOSldSRmdmNThYOFVJSCsr?=
 =?utf-8?B?VGxSSGE3M2JPaGIvbHRsd3RoaEtBQWltcmJEQTZlQkhneTdUSHpRTi9saHFP?=
 =?utf-8?B?Y3gzZ0JxWTRPL0o3MzVZeDJvSlB4UVhLQUI1UXZJdXY1cGsrL0o4QzIwUVZh?=
 =?utf-8?B?YVpwSjV2bi9VRm5KVThEWnRhZjRwYWhOWHVPVFp1Y1JPZ1h0U3psU20wNXdi?=
 =?utf-8?B?UVlFMjU2MXlJY1pBMFJYd2FKQ1hKcjJuOUk5NGp1b0xpOHd3WmhGcytISWtW?=
 =?utf-8?B?aytUZmV3a2V5Z1JnQXEwTHA0NHdqSlczRzREQ3d6VjI4RDFlcTNzYlY2cXRW?=
 =?utf-8?B?MnMwQUtVUzhSRjhvTXFKV3FqK1RlcUx2aHhQb3NvNDVGZXgySjJFdmhmaW5z?=
 =?utf-8?B?aWxrcTJIeUVjcFhJNnFRYlBsTmNPYkc4VzdpdUYySEZkWmhpQzQraUVLOUNK?=
 =?utf-8?B?RTZYN3Q0MndvWjFXazlFYWNsSmVPOTFUV1dhM1NGYUt5ZDJLMCt6dUtrb00y?=
 =?utf-8?B?UWdPQU4wYWIzbzFrbGF6N0RTYlBhY2hXYSsxNlNVcFl2UmpMVFB6bjMrYzgv?=
 =?utf-8?B?WVpDVFhRemVLOEhsaWtpR0QxV29UMVBpMXdPbjB2a1d4Z04rRC9tZ3lOSWVT?=
 =?utf-8?B?QVVBa3AxenV6cUZqa1ZhSkh0R1ozbHdTMFhBLytVSjFibUdpSVBDZ2h3eTd3?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MwpxR2islgzRDC/u/e+PKysKES/+SpMUvdRxxULvjL8ZkaUNKDeObr6XSJVYSukcsuNk0SxSc1d1+VWyQGMfMyh4DwrhypRXu1z8eYWSi+VkgN895MFIaM5rBd9tpw+iILfj3MwULppp6UAmdrcjHie6rTCtOSP0F3F+CN7iysSNvdyv02zyugBQtp181b5ufKMwiCngmf+OxCx1UKxEj0bHJF+1AdWWwggDfMrwwH8hNZiL2a4wEVeHHrbarpTedaza44UzVtnwgR32pbp+WYcD1oTSLviECPxCFkIJhGKMWIsay+PFyt9Twsn3BDKAnUHvlDLaYZxHKsrt1dvhNcDVjjk+CPYeiUD4fHSlWeabUT6kauxhP1bL2vfHtMfG6imWyQ3YT/ZC7Cei2YyydTO/tNW23ItPmpt+oDEhSaLItapYndt09V3iUWn/1e8Upa0qArOjwiNE7Lp8bbbQlSjIUW+oTiTUBlbBIP/dAaecas+rGRkF0fpbOUd0DGssiWsRp9VcpK0q0Il9mGokp4ibYgvAgSXpnO/IcNnXBiTXYIDjpGCtPLKgf1fIiOT9rXGOljrCjpHbiXYvkVGSOeGCcRmFsAny/7qsRgsghQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f47b911-d2e9-4176-ec82-08ddb8ab3ffb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:26:21.0600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bh49ZGLiQgch4VKAaPMFRTrUmx0uu09Zo4lMzFAfg6I7bzhxndDe5jRW52iIrsDdCxzdxqPreIInZLczlkXRAcXj8XJDK34Uk1YoZvY6oto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010094
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6863f012 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QA0opth-ZghFCQ-1WnkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rXLB4zKK_HlCV01q-QkNBgiqruADYgdy
X-Proofpoint-ORIG-GUID: rXLB4zKK_HlCV01q-QkNBgiqruADYgdy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NSBTYWx0ZWRfX9BDTrLeziS6G
 CM5shqWv0oHi2yJfEmgKpJNXiYJTQoY/ST8pSOmAW87UEKdpngg7ATmonXo91xe+zKGD/prVUbF
 ooJ9dnhcNqMClf36szA2aBN/MO/9uJQnNhLXUJGOaAbTFgGhNuFgQU0xh/bWnC4t79Swqzm/+eA
 YKhY4GCDu795gqJYt8pYn/Uh3qjEynmNiRZApexeaWi9q2zqm4HGfJkwXqbpTQTDXtzJ7uzliFf
 9WskGRKhj3LYCR4qf2J51HlAbzCyLm3BPhBN3AixNPBEjwMqhew/0n2D47PH19fQ7vvl2uaNztW
 lPuZkqJ7fWsLmlY+IBtZk6u4oVKwbz2fUG61Jtp83NIHi7O0L5IyLLti8OoGYQ0cm36J75zSqAe
 9tLY4iqcdYpJDRYbEAzAy46oAHnj0uK4JEvMZfP2Fpbqci6lx6OFdoUM8WUouO5kVvcMoybb
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/25/2025 7:40 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V5 32/38] vfio/iommufd: preserve descriptors
>>
>> Save the iommu and vfio device fd in CPR state when it is created.
>> After CPR, the fd number is found in CPR state and reused.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> backends/iommufd.c    | 25 ++++++++++++++++++++++++-
>> hw/vfio/cpr-iommufd.c | 10 ++++++++++
>> hw/vfio/device.c      |  9 +--------
>> 3 files changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index c554ce5..e02f06e 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -16,12 +16,18 @@
>> #include "qemu/module.h"
>> #include "qom/object_interfaces.h"
>> #include "qemu/error-report.h"
>> +#include "migration/cpr.h"
>> #include "monitor/monitor.h"
>> #include "trace.h"
>> #include "hw/vfio/vfio-device.h"
>> #include <sys/ioctl.h>
>> #include <linux/iommufd.h>
>>
>> +static const char *iommufd_fd_name(IOMMUFDBackend *be)
>> +{
>> +    return object_get_canonical_path_component(OBJECT(be));
>> +}
>> +
>> static void iommufd_backend_init(Object *obj)
>> {
>>      IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>> @@ -64,11 +70,27 @@ static bool
>> iommufd_backend_can_be_deleted(UserCreatable *uc)
>>      return !be->users;
>> }
>>
>> +static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
>> +{
>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
>> +    const char *name = iommufd_fd_name(be);
>> +
>> +    if (!be->owned) {
>> +        /* fd came from the command line. Fetch updated value from cpr state. */
>> +        if (cpr_is_incoming()) {
>> +            be->fd = cpr_find_fd(name, 0);
>> +        } else {
>> +            cpr_save_fd(name, 0, be->fd);
>> +        }
> 
> Maybe this can be handled in iommufd_backend_set_fd() instead of introducing
> complete callback? 

Afraid not.  iommufd_fd_name -> object_get_canonical_path_component needs the
parent, which is not set yet in iommufd_backend_set_fd. The complete callback
solved that problem nicely.

> Can we call cpr_get_fd_param()?

No.  That one expects to get the name from monitor_fd_param.

>> +    }
>> +}
>> +
>> static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
>> {
>>      UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
>>
>>      ucc->can_be_deleted = iommufd_backend_can_be_deleted;
>> +    ucc->complete = iommufd_backend_complete;
>>
>>      object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>> }
>> @@ -102,7 +124,7 @@ bool iommufd_backend_connect(IOMMUFDBackend *be,
>> Error **errp)
>>      int fd;
>>
>>      if (be->owned && !be->users) {
>> -        fd = qemu_open("/dev/iommu", O_RDWR, errp);
>> +        fd = cpr_open_fd("/dev/iommu", O_RDWR, iommufd_fd_name(be), 0, errp);
>>          if (fd < 0) {
>>              return false;
>>          }
>> @@ -134,6 +156,7 @@ void iommufd_backend_disconnect(IOMMUFDBackend
>> *be)
>> out:
>>      if (!be->users) {
>>          vfio_iommufd_cpr_unregister_iommufd(be);
>> +        cpr_delete_fd(iommufd_fd_name(be), 0);
> 
> I think we shouldn't call this if not owned.

I agree, thanks, and a mismerge during rebase put the out label in the wrong place.
It should be:

void iommufd_backend_disconnect(IOMMUFDBackend *be)
{
     if (!be->users) {
         goto out;
     }
     be->users--;
     if (!be->users) {
         vfio_iommufd_cpr_unregister_iommufd(be);
         if (be->owned) {
             cpr_delete_fd(iommufd_fd_name(be), 0);
             close(be->fd);
             be->fd = -1;
         }
     }
out:
     trace_iommufd_backend_disconnect(be->fd, be->users);
}

>>      }
>>      trace_iommufd_backend_disconnect(be->fd, be->users);
>> }
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> index 2eca8a6..152a661 100644
>> --- a/hw/vfio/cpr-iommufd.c
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -162,17 +162,27 @@ void
>> vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
>> void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
>> {
>>      if (!cpr_is_incoming()) {
>> +        /*
>> +         * Beware fd may have already been saved by vfio_device_set_fd,
>> +         * so call resave to avoid a duplicate entry.
>> +         */
>> +        cpr_resave_fd(vbasedev->name, 0, vbasedev->fd);
>>          vfio_cpr_save_device(vbasedev);
>>      }
>> }
>>
>> void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
>> {
>> +    cpr_delete_fd(vbasedev->name, 0);
>>      vfio_cpr_delete_device(vbasedev->name);
>> }
>>
>> void vfio_cpr_load_device(VFIODevice *vbasedev)
>> {
>> +    if (vbasedev->fd < 0) {
>> +        vbasedev->fd = cpr_find_fd(vbasedev->name, 0);
> 
> Maybe call this after checking cpr_is_incoming()?

That is not necessary, because cpr_find_fd returns -1 if !cpr_is_incoming(),
but I'll change it so the intent becomes clearer:

void vfio_cpr_load_device(VFIODevice *vbasedev)
{
     if (cpr_is_incoming()) {
         bool ret = vfio_cpr_find_device(vbasedev);
         g_assert(ret);

         if (vbasedev->fd < 0) {
             vbasedev->fd = cpr_find_fd(vbasedev->name, 0);
         }
     }
}

- Steve

>> +    }
>> +
>>      if (cpr_is_incoming()) {
>>          bool ret = vfio_cpr_find_device(vbasedev);
>>          g_assert(ret);
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 8c3835b..6bcc65c 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -335,14 +335,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
>>
>> void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>> {
>> -    ERRP_GUARD();
>> -    int fd = monitor_fd_param(monitor_cur(), str, errp);
>> -
>> -    if (fd < 0) {
>> -        error_prepend(errp, "Could not parse remote object fd %s:", str);
>> -        return;
>> -    }
>> -    vbasedev->fd = fd;
>> +    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, errp);
>> }
>>
>> static VFIODeviceIOOps vfio_device_io_ops_ioctl;
>> --
>> 1.8.3.1
> 


