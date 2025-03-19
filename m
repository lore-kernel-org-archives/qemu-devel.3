Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2F4C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutOf-0005Y7-B4; Wed, 19 Mar 2025 09:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tutOS-0005Wi-Tv
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:23:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tutON-0001U4-3m
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:23:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8fsde027452;
 Wed, 19 Mar 2025 13:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Ldqqy3jBqRmuRC1D6s9LOVbFMnpGBY849bQQnE5cXGk=; b=
 ho7+R6h/nHJh835p1AR54dF8n6BQ4YKPMzpphB4JczuVkslSYn/0L8eqozd1MNrh
 srggKqWwy/WLhVjeWD/hUsvYlY2mhMsnmsJslm+fP97dnmUO8E6vZDPBRNx9SdJJ
 NPH0jvIKklzNGbBO2ZCpiWB5WkRELPTmA99cHRlSYnkTWLGJU93LQ13/Wb6/A8q7
 ZXr6/wRtarQCp5LaTkJTa2slC+L4632niG4UOpeOynz7n+KknYEQWCsi04cL8ADL
 81xFA5I+fm4m+M97LREOVDRKL+rnOz0RuSLbmSgzST7uuGax92vNoAKn15WKvJnC
 vE/0v74MqhoGI+Hcp62LAQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3u0s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 13:23:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52JBvZU9004511; Wed, 19 Mar 2025 13:23:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ftmvhq01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 13:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP30zj/AR4p2Ib6PMIPVVOPbW+LFHg7aWVDaHgD6cgS7SUtl9C6QLLMaWoIIPrtFTC2idL+WramHze51NCSD4gYlIKYxvbxcUUpNzJrZKVCiRc9Uf/YpgkX9SAilcFfvRAzytYB78xInDHQlNnVyjy0bIwEtKWh+s+VK191orrTo8mIV9TmgSX6r9F4+nLbTVnG40c4mztayYQ15n7o5m0uMcUQRNZrvDz7tQ1WKgP36aIBIdZDLCZWqBU14T96OEO4UfCRQaPhObbi7U9yobxNzcv83CWy7mE9Sug56rMumCyJohe/EMLWUQ4tQ2J1FWXVkKmN8Cvpm9JHUQd5fGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ldqqy3jBqRmuRC1D6s9LOVbFMnpGBY849bQQnE5cXGk=;
 b=YwDZbiNFgD8A1wpqcpfeVbtrW4eG0KYHVPp9lzOpkDvynNpY8sVXpd/y6g9jb34wFUOd72HERLRWqkFIHTdOrKu1pEpdmGPgHqhwBVId/gsmFjfz7soR1jwRfeKDSjB3bqhiSxrFxiz2djSApxcsdGdHxHvueTBhELHJnnBnb/1tr2K97T5JmgXth+KklZuoEDEo9dyjvmtWaTSGbIEV73DDImYH2+W5gCQJpGPGwef9VCxqsBXwyliDafUKZKxbMD3y9fzmv2MtYKzLR7Dz01vwdZlsdO7vmUVBTSJNgIYrLlWv/+PPRLn3b+IZ9PldR/s6GgAJ8eyEHiMpek6LGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldqqy3jBqRmuRC1D6s9LOVbFMnpGBY849bQQnE5cXGk=;
 b=gbEq4D36sEZyz7H6oL1g+31ObcNyARE6aIimoQxm/KpazTDapZEY7egA/1JpfiM5wwwIWhGRB/7WifTSzId3GaJwsuQpA3OGrdEyiyiSMWzwHgU+CdIRcPiGsY7EO4ezM44MywM506VYt6AYhk4lOj3qvzDM+AOLYVW6DK2KxhM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN4PR10MB5557.namprd10.prod.outlook.com (2603:10b6:806:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 13:23:23 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 13:23:23 +0000
Message-ID: <95e7c6c6-0d28-42f0-ab3a-3de65f91ac48@oracle.com>
Date: Wed, 19 Mar 2025 13:23:19 +0000
Subject: Re: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-25-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250318095415.670319-25-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN4PR10MB5557:EE_
X-MS-Office365-Filtering-Correlation-Id: 5696782c-5056-4a77-4eeb-08dd66e9393c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDBDemQ5WEZjSlRhQWFzMXNCQmtWUnlQd2l6OTh6K2VNUHpIN2lsV0x4ZHdJ?=
 =?utf-8?B?TGRMZUZCVUZ6QXpMWStCVFhqT3BrQVpHVTNDWHh5ZXNDWlhwVVRYNW40V1hX?=
 =?utf-8?B?T2pvbWVhUlJ5SXNIVUpRSlJROG5rRVNncStKcGpScDBPaFF1cnJJeithQXVX?=
 =?utf-8?B?T1N5OGRVQnplMnY4RFhzTXFUUG5JalVtYVVub0ZwbEhWUFRGKzRxUG5oYmNs?=
 =?utf-8?B?T0RRV0l5d1l5SzJlalRrL1pWWlVvQmc1aEtKY1E4eUJmOFpUYkp1SUFqL1pE?=
 =?utf-8?B?NlRzTmVJK2tUUk5aUEhFV1AzYWtjTEY5WkNyMHRrZDJqbHNGMEJnSmdFWlhE?=
 =?utf-8?B?c1dmMzYxMU5EcjBPd3JMWG1qYTRkWXQrSG5EOWxPdjRMQkVNeVJYUkUxZTBH?=
 =?utf-8?B?ekMwcmYwQXFqaTNsY3VSS05HZFdheXREa2VoaTJoMFJoTFRZb0RZWkxvRm5x?=
 =?utf-8?B?TVpSRXMvMnNtN0VGTVJZQ2hrUUh1UmMxOGtnUkcyWGxKbzFEelJWQmJhS3h3?=
 =?utf-8?B?ZFBycGV1MlhDMWdMMlBGZzRGNUdGaWNXV1RVZDRNWVZrdjNyS3BDTkJnN1dS?=
 =?utf-8?B?YjFGMnlEOThlaGZPd3VLU2dEcENGdGY3RG9qTTNjdG1Dc21meThxVjRmQlFR?=
 =?utf-8?B?ZjRvemptSTJ3ZXRzSHUvM3BEUDlCUkRMZ2RUUWVYOVhvaTdrVXlrUHV4MXpD?=
 =?utf-8?B?OUNqY1NKdldBeEE1ZzBnWmFBcll6OVFmc2g1cEJJQjkyNXcwbnY5dmt0Wk1o?=
 =?utf-8?B?Z0k3TGJPakQ2RzZQamZTcERNcWpoUTRXbjJKYVVWWU9qWCtHSitRRUNqR1E5?=
 =?utf-8?B?T0Y0Q3hKaTNMU01UUW10OGcwNUZVOEMvUGFpeGxDZHZXdlVDUlNaMWZSMmRF?=
 =?utf-8?B?Slh0RWhZNHhOZnZaWGd1K0p5MzZhaVF6emlNSm5GZW1hT2NwYXppbVVTcERY?=
 =?utf-8?B?NUFqTFE5L1hiT2k1b1laRWM1cklkMVdrWTlXTXo2WUh3SVZBSTI4UXRNQlU0?=
 =?utf-8?B?SEVWZXVQVFNZZDlKWjdzcFFkYWZIZTc5a3k0cXpXSzZjb2txRHJjZVh5UHIy?=
 =?utf-8?B?U0NPNGR6eFUrcHVKT0lhNTlucDFid0MveHJITHNEZmRJYW1YWWFYRGRNV040?=
 =?utf-8?B?ZDg0ZjN4c3d4Rm9KSGwwQXl1YTZZdEF2TTJ1NlhkczhvWlNlZm1rM1lEQlZX?=
 =?utf-8?B?c3RGaEYwaUIrZG9MVlM5RzhmV1pXU2ZLNXBBbEczSVIvbU40QjlnaDlnaXBS?=
 =?utf-8?B?ZlFvUUcrQVBSNnNJS25hYUVBa2hLcUIwVUY3QTcydktKMmVPMkpUdGx0L1E4?=
 =?utf-8?B?QWNTdFFWTG5HY0tIMEg2b1Nnc2ZvcGZqQ3Yza1lpaSs5MjRrWkNkb3ZXSTEr?=
 =?utf-8?B?VWU3WjFTWTlpT2tUc2JOczJYMURPYWN2akNmZnczaytBaE1uR21HTHZMalo3?=
 =?utf-8?B?QXh2QllwWW4yNHVPM2I5QmRNOXJFRUgyUm50SVprKysyWGZNRUY2V084T3R1?=
 =?utf-8?B?M0pRc0c0dGtQOW9VbTlwZjJEUjhjVFFVc2gyYTlQcjExMDBib1U5YjRQdzBx?=
 =?utf-8?B?anRYUW4wY2lvVDU4WEIxUU5aN2xUcmxaaUVNODVFVW1Ia2tsRzF6WkhqZ002?=
 =?utf-8?B?dFZOY0tIcm1qV0VCTFZtTmd4YkZuaUt3UERUeUNGWVRHUThpZ2RJWng0d0tH?=
 =?utf-8?B?MkZZT1BTVjdjV0VPTHNZK0MvUGVXUE1YbUJUZG1SQS9iYUMwN3R4L3ZMSzM4?=
 =?utf-8?B?VUQ4OUtIZ2E2YXJxQjdvays3Y0kyZEpPYkV6aEN5WTlkYXVWeTZMa2w1cThw?=
 =?utf-8?B?enI5QU1MUTBscDBWaGc4TDZDaW5DbDVyZCthbmY5TUZNUEgvVllBdkJZYUlm?=
 =?utf-8?Q?TqSj5bR6Y+jcN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhFNGMrbEJtaEQrVG12NVpEcktzVGQ1YVplTkVYbXBGRDhSTE0rTmcrT0l3?=
 =?utf-8?B?Z2E3K3JHOVpyRi9sMDlmYWpoM2I2R2FoUUZ0akNPNjArRHBTbkM1ZWgxL05S?=
 =?utf-8?B?U09najZyVXhlT3k5MTlVcWhpdHF1UHdRSWxmOTVUdVg3T3BnQS9FZnpZZCtL?=
 =?utf-8?B?eHhFMHlRYllyWXdUbmhrNURUdWJzSENjK0dHaHlicGZldmRmV1gvYzYzbU1n?=
 =?utf-8?B?eStHTmRaMnc3S2JIK2NnWndIWmtFS1o1Ykx0cDROVHZxVFhvQ3hGRTFZY0hl?=
 =?utf-8?B?YnhOcis5eC85TnVqcWVsb3BEa3Nic2c5KzV4MWk2WGxmdFZ5RkhRRW1vUVlR?=
 =?utf-8?B?VXdSYk5Jc21zZ2ZJYUcySUp6SXhCbWg3aHVPS1BYSkhaNlFQMHgxTm9aRWVW?=
 =?utf-8?B?U0IxMWsxaWJBeDJjVWtIaG8wKzYzVlJ5Si9zV3c3cjdQTmtQbi9BTU02K0pl?=
 =?utf-8?B?ZHFHZmppUHNzamt5ZTBKTmx1NHZ5S1RuYkt3aFl3NVVhMEhKZk1QUzY4djB0?=
 =?utf-8?B?bW9FMklFbU1sL2lmd0dUSzVZcmdySHVBVnByUTB2djRCU0dQQitJMmEvdUpU?=
 =?utf-8?B?TDgvcDQ0T1VaUWFFZnI5QlNqU0hLWFdKOUt3akk0c0ZkaitoYU5lMExESW5R?=
 =?utf-8?B?d1pmTW9OUi9PT0dydUV0RlF0WlNXL2ZzRVhjekh1VzBVZmkzcGppZnZxSDRF?=
 =?utf-8?B?Yk0ydGlueUxQbHpVeVBOQ3QrZW44RW9pODhleGZ4ZytrYVdvbWRpQzM5Vnlk?=
 =?utf-8?B?d1FVNFpJak5XOURYQmZSVUt1M3VBdTVXRTFYM2FhaEx6TmMzalBBRUxpN1ZF?=
 =?utf-8?B?Tm5hRFMybUFKWU5HTmFQZko3OW9jTVNUSG9paUpxMEtRRTEwZmQwRHhDMkhQ?=
 =?utf-8?B?SUtlUHU0ejNLaUh5cWtlaXppc0l4aDRBdnFMeGQ5WW5xc2p3UlozdUp0QW1a?=
 =?utf-8?B?S2IrMWY3QWp5cWM1NStQYVhVUjllTWViS3pPTVpTS1JHV0t6NXNQTVhVR3pW?=
 =?utf-8?B?Qm0xQjFNVUpidTlnSkNZMEJtQ0tFand4Ykl4KzJLUkZWeFFrK0VObUc4Ukl2?=
 =?utf-8?B?elV1WWJkZUdqaENEUVhnNXhIZ0J5TG8vckNDOGR6QVpaZjJhWUticmV4MkV5?=
 =?utf-8?B?MGdpTTZTV0U5cGtEUEkreFlseEo3V25jTzlPa1drbXZNUTNUZ1Rac2J0YVZW?=
 =?utf-8?B?YnFKMExxSElDWkJYcC84Z0VMM1dvMXZhUmhEQnZWUnBtV1BKR0VJdjdhbTRS?=
 =?utf-8?B?MmdRV2RzWnRnK24xRUZ1R2hKbGIraStXOUphZndsYzJFWDRYMWpMelRqcFlS?=
 =?utf-8?B?Ylh2UTBMdENOWlNHTFRhaytrVCtLdzNLb09rcVpTSkhYWVcvRXQ4eTRpeTJr?=
 =?utf-8?B?NFNkT3ZqaVIxSTJMVExQSDdUSDB3SCtVUGFDZHg4Y2NvcHhqZzNac0k4anh0?=
 =?utf-8?B?Qk5tUUFCMHIydlJQVllvZXRZVjdlT2JKRmRUZHovOXVSTE1BbzFEbUtwbkxU?=
 =?utf-8?B?NktQQ2hQTjVyaEZKUW84cUx2ejdqN1kvUjJZOS90dDVEMVlua0dkeU0ySS9N?=
 =?utf-8?B?Y1BLK2xoKzYrY3pRUnc5b1d5czVTTnRTNFFMTTRSVHhmOEpSSWdYemNZNXJp?=
 =?utf-8?B?RVlMdDlGMSsyeGROMFB6aytMUk1ubys4Z3k1VzdHT1Q2QlZjWklMUXZzQ2Ix?=
 =?utf-8?B?S01ERDU2UlZ5QWYxMy8vY2VxdHF2eUlHZkNPaXhPLzRSNHh4OW1XaWc5TzZy?=
 =?utf-8?B?aktlc0R0bHZkQXY0bjZFQnZMYnZ1aEpzZkNyaGVVdFNhZVdwQVFrRTY5RUsz?=
 =?utf-8?B?L3dZRTVXdW1ML2lNUW5DRjNBWEo2VEVTMDFScXJRRHRUMlZOL0tHUnd3N3J6?=
 =?utf-8?B?RUlNaThLWllmT3A4TWt5SWxhd3NBd0tVWUtRZkU5L2JrNHBLTnB0eHNCMEQ4?=
 =?utf-8?B?WGVOWWdselVyYTh0djBzTTRJUHZrVnprcEZVckd2LzdlaUU2QnNiT0RZNmdx?=
 =?utf-8?B?NGZNVGxJbVltN29iUmpMa0g3a2xrZXhPTjVGeXBaaDVTNmNvUEZhTmVveGFq?=
 =?utf-8?B?Nlh1akR2elN2WDRRYlE3MW9oN0tpUkxCMVVaZ05naGFUUlFyUlM0LzRlSlZC?=
 =?utf-8?B?RDVZR0FhejRXM2doQXp3TXNVeWc5MHpmN1B5aVZ4ZDQ5Qi9MdmZxbzh3QmZD?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4u2BCz2VkHY83nF2rVuIMlIUcIYb0HnZT2Yy+06+MvM5A2KtuvmGNnKHabjpnZbi3Wim3/mIOi1PZ94KiALHjLlzPlpBGnt737PkjfEt5olhwhxFiYLDl1s84EgH4V7JKJ6d3BBD9YlJB7kyY6VG+5gPVWxqz7I3ShncGMp3y6wXdUDRHkvMkSt6V1CoastjYHDhJKDZABWL7VIPuTycjGxazYr4v20WIgrnWi+LFF4bNE2uD2il6yhXxnufcuEwNt//MhE6J2hTgbQddaw6ewEc3NXgdv5wWlgARtZMPw0K18n3QH+jr0IQ943NaFDwwkdQvAWY5yAWkfoxuOnxMANBGaHmFDYlNKlpQRbC3G2HKdgAlpza7FeGEtshjosQ3nN9eUaoq2/MSv3BkAW76fS7IF02Tp7vKlKiINYxGLSxqtoy7yM4zYU2Ztg0ZLiKNJg7Mf2NfQVLkH9ConMy5qFCm4woxYn+Hkx94UekIGHCOzhkhsvLKm402wxT9OQFecCf3lfuDPor9LOiOFcUvOhaqrYGE4G21+5A6meQHns3LN6KLqlGG4+l6L6D8ZoJvRlMROd3M2BlRoeGvG5SUvUy13VbHB04baIWoQMiCIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5696782c-5056-4a77-4eeb-08dd66e9393c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:23:23.2984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ub6TaMUJZu+CPoXtZFF5xoJsvJBpgJCmM8P1AinPckAxf7fwrQVuwaPPP0K2RLsen4ayo72saW5Kzvl/cPZDDDT1rLG0ehPc2orWCKCRCUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190092
X-Proofpoint-ORIG-GUID: DyJHdNh6-IFIl6adhZloRU-v-p267b_2
X-Proofpoint-GUID: DyJHdNh6-IFIl6adhZloRU-v-p267b_2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/03/2025 09:54, Cédric Le Goater wrote:
> File "common.c" has been emptied of most of its definitions by the
> previous changes and the only definitions left are related to dirty
> tracking. Rename it to "dirty-tracking.c" and introduce its associated
> "dirty-tracking.h" header file for the declarations.
> 
> Cleanup a little the includes while at it.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/dirty-tracking.h               | 22 ++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h          | 10 ----------
>  hw/vfio/container.c                    |  1 +
>  hw/vfio/{common.c => dirty-tracking.c} |  5 +----
>  hw/vfio/iommufd.c                      |  1 +
>  hw/vfio/meson.build                    |  2 +-
>  hw/vfio/trace-events                   |  2 +-
>  7 files changed, 27 insertions(+), 16 deletions(-)
>  create mode 100644 hw/vfio/dirty-tracking.h
>  rename hw/vfio/{common.c => dirty-tracking.c} (99%)
> 
> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..4b83dc54ab50dabfff040d7cc3db27b80bfe2d3a
> --- /dev/null
> +++ b/hw/vfio/dirty-tracking.h
> @@ -0,0 +1,22 @@
> +/*
> + * VFIO dirty page tracking routines
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_DIRTY_TRACKING_H
> +#define HW_VFIO_DIRTY_TRACKING_H
> +
> +extern const MemoryListener vfio_memory_listener;
> +
> +bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
> +bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> +int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> +                                    Error **errp);
> +int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp);
> +
> +#endif /* HW_VFIO_DIRTY_TRACKING_H */
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 184a422916f62259158e8759efc473a5efb2b2f7..cc20110d9de8ac173b67e6e878d4d61818497426 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -130,7 +130,6 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
>  
>  typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>  extern VFIODeviceList vfio_device_list;
> -extern const MemoryListener vfio_memory_listener;
>  
>  #ifdef CONFIG_LINUX
>  int vfio_get_region_info(VFIODevice *vbasedev, int index,
> @@ -140,15 +139,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>  bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
>  #endif
>  
> -bool vfio_devices_all_dirty_tracking_started(
> -    const VFIOContainerBase *bcontainer);
> -bool
> -vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> -int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr, Error **errp);
> -
>  /* Returns 0 on success, or a negative errno. */
>  bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>  void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 4e41a7476549a0c5e464e499d059db5aca6e3470..e88dfe12edd6dee469c06ee2e46ab9c8b5019ae7 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -35,6 +35,7 @@
>  #include "hw/vfio/vfio-container.h"
>  #include "helpers.h"
>  #include "cpr.h"
> +#include "dirty-tracking.h"
>  
>  #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
>  
> diff --git a/hw/vfio/common.c b/hw/vfio/dirty-tracking.c
> similarity index 99%
> rename from hw/vfio/common.c
> rename to hw/vfio/dirty-tracking.c
> index ed2f2ed8839caaf40fabb0cbbcaa1df2c5b70d67..441f9d9a08c06a88dda44ef143dcee5f0a89a900 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/dirty-tracking.c
> @@ -20,14 +20,10 @@
>  
>  #include "qemu/osdep.h"
>  #include <sys/ioctl.h>
> -#ifdef CONFIG_KVM
> -#include <linux/kvm.h>
> -#endif
>  #include <linux/vfio.h>
>  
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/vfio/pci.h"
> -#include "exec/address-spaces.h"
>  #include "exec/memory.h"
>  #include "exec/ram_addr.h"
>  #include "exec/target_page.h"
> @@ -45,6 +41,7 @@
>  #include "system/tpm.h"
>  #include "migration.h"
>  #include "helpers.h"
> +#include "dirty-tracking.h"
>  
>  /*
>   * Device state interfaces
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index b25f3b4086d7b7fc6fcd519a9b8b2904513a655f..9335a17920b32dc2bf9cb4eeb2b8f57382f14ac8 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -29,6 +29,7 @@
>  #include "iommufd.h"
>  #include "helpers.h"
>  #include "cpr.h"
> +#include "dirty-tracking.h"
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
>              TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 1f89bd28c13dea55bcfff476ce99d51b453d8533..b6f5a7eeeda035b5872c2a19f8086384e000f420 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -1,6 +1,6 @@
>  vfio_ss = ss.source_set()
>  vfio_ss.add(files(
> -  'common.c',
> +  'dirty-tracking.c',
>    'container.c',
>    'helpers.c',
>  ))
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index a1d01e9dde6ec52964d4804e9cbce5a6a32b7879..f3bdcebe938dcca77b913ef81a74644c622b5d8a 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -89,7 +89,7 @@ vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
>  
> -# common.c
> +# dirty-tracking.c
>  vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
>  vfio_listener_region_skip(const char *name, uint64_t start, uint64_t end) "SKIPPING %s 0x%"PRIx64" - 0x%"PRIx64
>  vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"


