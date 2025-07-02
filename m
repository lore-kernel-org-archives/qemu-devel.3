Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473C7C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 20:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX4WA-0008PA-1U; Wed, 02 Jul 2025 16:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX4W8-0008Ou-L0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:57:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX4W6-0006CJ-C8
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:57:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Kfkdm026482;
 Wed, 2 Jul 2025 20:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=o64p2xGANzHugF1KH2+7nTHK8SBeS6MuJ394daYH0KI=; b=
 XzATEjJR83jokFpMDFoesY9gyS9AXvbF1/NoPQ/x8lTkjdl9jhV2rxvsWOchbZL5
 6to0uf7eN131WAygqerGcWKs8DiQBb8Jv41IStETVC3ssaKDEQ703/q5J7A2/M9Q
 BLl3kSTeNPG6NHlz2sXOJ7S9ayAAXqcNSnoMNPVczUWU7q54cgCCgEdzFAYoN5bm
 mYQ+dB4/k7h0Focv927rYsqS4mnHID/+pffy+dPNH8J4YpTA2OgJAxwYF5vAGbUI
 UTR4OEhrqtsYzDvo9vJZJfAzi3g3/pcT2ehOtk70AHiz1oKqxfWCMUUf64cdLVVH
 /o2mskj0PJ5wnmNk2vKSVg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w7t28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 20:57:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562KYE2r025014; Wed, 2 Jul 2025 20:57:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6uk0x7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 20:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huxaxSL3WU1buaRu8CI0isU7Zo3aYXIEf8wD0yr69UGTQ3owyKQniRRvuUA5eh5NHswCJvwLqikGssRUVG5QITA5NfoAv7FlgsNcycamvluesv8YpHxwjRvgJhsYqdna/mJFpU1JIRRwXlkAEXIGceMAHdIeiPMVO5btJ2cKDCzpkPDzRL7ZM0Ye3Yj7vE03ki2taD1AKax8GI9SuiRep18wXiEt8muywVovD3M3QDJnN3cszJ0VTUWvqxD6yh7HAhVDCfWBVMSpvBemDRVQyoExwV9yiF+1E/50QrOnt4WKWxinKY5BfRF7yC1cqwH8bjzb55ngxkMD+IHeXMfv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o64p2xGANzHugF1KH2+7nTHK8SBeS6MuJ394daYH0KI=;
 b=aX8VoimjOwpaAPwx13NTm1gaVAjVtozE5tneDAqahCN1tOq3zTRw45c4Ev81bIUb6+01oydV05YIayA4xFDvs//CbXfg/dOrYGtxeDqh7ODa31fA2mUG8GIOgNZn0uW5oSOHaX6wf3FfTjJKI/q51HFmEbeh3E2v/s0Vz/vN3R+8eB3sHZ7zt0mfPh468algJ/2dcV5m1qy/A18G6vtObvgNcZK0NQWfWV6dSydR5jxyLOsDTnulnv6i5+N2bI3wXcGJ+zN/Lu+06Ygbg1z0xSNKI9jd5+8jonTj2oR5ZDlqJiDQv7/c6dO8N4vjkThvD9zRdNFpSMefPIp1pdlEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o64p2xGANzHugF1KH2+7nTHK8SBeS6MuJ394daYH0KI=;
 b=UURLI806jXZwSODh6cxYdOsOijYsN774HRZ5s+iZHDnYeykcgqROZGLIdozD1jr2Po+0KNus0PdSPgSwirsbcS5YcyGtWwua4j4BdWZTsXUxp42nuC4s8DYhBUp9bZqNwhpvyKjScR3QJ8isILWCOossTBoreI80xoghWsG0j6o=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6368.namprd10.prod.outlook.com (2603:10b6:806:258::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 20:57:10 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 20:57:10 +0000
Message-ID: <daaa6aac-2883-4f20-ad34-7e2630e0326f@oracle.com>
Date: Wed, 2 Jul 2025 16:57:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 35/38] vfio/iommufd: change process
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-36-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91368C5C5D98CD165A9F53DE927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9035951e-65af-472b-9120-9e7dee85eeed@oracle.com>
 <IA3PR11MB913633D7D68CDB8BC68A98CA9240A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB913633D7D68CDB8BC68A98CA9240A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: ffba06ca-06cc-4cf2-1065-08ddb9ab0347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emxxVTlLUmNQWmFlcmZWM2tydXRmNmxyUUZSTGh2ZmJEeGpFNmRobzRKNm5i?=
 =?utf-8?B?ZUxwRWhobFdmaTZPZFpEQnBxZ1cvQ1cvaW8reVFwOGR5eHJQVnlBNE0vWFlJ?=
 =?utf-8?B?Z2hMbzJjN3UxTXQwSURQdUxFYUNiUXBIbXdERVRLWXFTeHJ2UHV6dTNmcUxq?=
 =?utf-8?B?ZVB2amF6S2tqbDFqMlpOQWQ0YllibjBOTFVnRTAyU0hMQjJvUUlOV3BUQmJP?=
 =?utf-8?B?cUIwMm1rVFAzcEc2R2hFZ2VZajlxNHh3UlZKTnM4TDBocVQ4cC9NenBUNEpL?=
 =?utf-8?B?Ym9BOFdQNjVkU0JHZnQ5Y2YrTnRjNWJyWXFMdGR2TE42c0hVYnBwS1FNYUFX?=
 =?utf-8?B?dWRQYVdHYkphZEd5SjA2NHl0TEl6aHJ1Z2pWVTJhbmViZnJvWmJad1Z5OGFp?=
 =?utf-8?B?eUUzSmxjaWpiWlFnVlhQRDk2enRyaEJnaDBDTGU2YUsvbFBvWStyZjZMOWov?=
 =?utf-8?B?V3F2R0VqZ2hzUWNpSUtYOG9GT0l0Wk01Z3RBZGc3eURVRUwrUUxvUXlmVGpk?=
 =?utf-8?B?WmpjVWQ4UDVKYUNGaXBYUzhiTkxJdVNHWmlqZmcxcGdoRHArMUpjcFZaZUFU?=
 =?utf-8?B?NytnZmdBNFdDVnBTTEpGWCtBMTdRNmh5WERsMmQ0NDdkdGVyeStzZ0hZUGU2?=
 =?utf-8?B?dVkrcVZVSGY5dzdHNkFveHF6RDZXcDAxU1htN1BxeXBJR1NVUXBRbExRMHNs?=
 =?utf-8?B?MWdoSGxlcThOcFFkd3Jzb0ZUd0xFZzFyNXNxaHpIMmxBTXlwb2g2eEE3Y1pz?=
 =?utf-8?B?RHA3MXFGUUVsVEV6UDMyVXJ2ODkzNTdRQ1VROFBNaXorZS8rTmxJeElud0Jr?=
 =?utf-8?B?cjFDdU9qLzdxWFl5cW1lZHc3a1hHK1U5K2YydmdSVUphNGFlWWxCKzlieEhs?=
 =?utf-8?B?SkRQVzR5WU1JTGRXZHkraHpocHBzUFk2RTFYTUJLVGRXQjdLK3ZJOU1vcVVN?=
 =?utf-8?B?OU9pUG9JaGM2L1hVOGNTdGhoVHVjRThpZkJ5Njh2c0JBL2JtKzhQSHdrVWZH?=
 =?utf-8?B?dGhsZldxTEsxVWt6ckFDRldPSUNkZ2hBQjFFZ2lEVnRFZTJuYUVwekE3VnZo?=
 =?utf-8?B?aUdhOC9WUzlvOGRLQlVYalZxSWJjNWJxSGF2b3pCNTZoMHdtVnpxMEtrZk0z?=
 =?utf-8?B?WVUzWFk4NXJpc2hzbjJlczVycStOQW9yNnZBQ3BtZDNOeFBvdHdVK2dsdWxa?=
 =?utf-8?B?QWl2cHV1VWl2cVUwK2w1NFEvUnhjQ1MwcmV1dk95TVlwYTRaaGJiMTRPTGo3?=
 =?utf-8?B?UnFMVDFTUEdSSjZrYW1HdTFCTGN0emR1NVhsUzhqcEovbTI0a2djdDg5enVn?=
 =?utf-8?B?VlByN05tM1pJRElHUnBCUGorMjFXVE9nU1J4OFZLNTBkRzEyYUo5YklxTklu?=
 =?utf-8?B?NFl2V3lsdjljUmU4c1hTQzgyTFZoOTFaaXJ4aGczM2NZUFAwdmNIQy9aWllL?=
 =?utf-8?B?SU91R2JNT1dXVWFKUTB4VDNzWUR1ZExPM2cvbVJVSVFzdW5TSDZMdDBlaEFP?=
 =?utf-8?B?RGhVMUJTREJveTdqRnd6ZGllK1N6czIxQ0YzR2daeXJRaFRmUEk0Qkppb3d3?=
 =?utf-8?B?Q2hVWHVueEg2NWwxSGxQNWsyeHhXTGRqUURPdXpwRUVUZ2lMMW4zUTk3VndY?=
 =?utf-8?B?L1NialQ3TE9uNjRybjRVdVN0ekFXOE1QQ0hPVGQ1QzhDVHpRcy9oNHU2Mk8x?=
 =?utf-8?B?d1RCRjJuVndIN3dyWGtsY2dRNHhhZ01FQk9MSzZrNUFkdW9tVmxXY2pPaWMw?=
 =?utf-8?B?aklsZk16Y3BaeGUxdU0rakk1Q1h2MzBIaU1SZTIwZEtNcUNXdGhNei9sbWRa?=
 =?utf-8?B?TWNqb3pKVFRwK2xUelM0ZW9jRStjRU5RMmNQUDlSN05KOW1kaWpUNUVEYUJl?=
 =?utf-8?B?TnhlV01Fb1VCaVR2WlNsUU9OUlFoS3VSTFg5cHVCbk84bmZDajQ0SGNPWjJH?=
 =?utf-8?Q?qEsRSmvmaJ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hMUVFSSytSYXFGWHRucTJHeE84dFQvUWlKYXFFdUJKL2dSSnBCRUhZMlox?=
 =?utf-8?B?RVRUQ1RvTURKZHFTamJiMEVIRGJPSmQ3d1NWcXpHVHhkbkk4WHpWdy96QnFU?=
 =?utf-8?B?ZWtlOXFhdGhNem9QUjY5Sk1GcUlNOVVobnQvSGhKZk9GNmd0a0NaMXFzeEdm?=
 =?utf-8?B?dmY0cVFOd0h0NjNuWnhTQ2J5L3IrTnVBL3pVbXgwcGttU3lsRy9mbmo5a2Yy?=
 =?utf-8?B?aWppMk5KSXpRUnVGV2orTk9XekdOV2VaNHdndXhRZHRNWHlrWmwySnlJQURI?=
 =?utf-8?B?aDRoZ3AwRVZ1dWNtZUIzQ0Y3cUFGSS9BNSt2aGdPWHNHREg1blBTS1pGMWZn?=
 =?utf-8?B?LzVPeHVGUk0wTGozLzA2VUIrRHVzSEU2Nm1jUkpFZ2dTQmJKdFMxZmZFaTBl?=
 =?utf-8?B?QW9rNmFZQ3JFdjBOeWUxODM3dThtUlRKeVNpbDJtWnQrejJtdjFxb3U5VUVX?=
 =?utf-8?B?cTVXLzNSN1RnN09MR2JTOXBmbHREU05HT2Z0c29sUlRZK0J6U2xMdHdpbzRY?=
 =?utf-8?B?WXIyN3o1V1ZPQ2p6TGxPL2dFYW9kRFlPckxpZmEwODF2T3ZQTENRUzZiaWZH?=
 =?utf-8?B?dUFsOXpRK1c1bFVRV1owaEM5NVJDa1pDdm9iKy9PZk1SU05yZUxFUmZWbFlo?=
 =?utf-8?B?ZUwwYTI5dmhkTitmbWpJQit4c3FzRVNUZ0ZpRkJsenQrNGg3bkFnMk5tTENH?=
 =?utf-8?B?TXUza1lWdUswQjQxNVBvVkJBS00xN1l1NUFvQlR3SjdHM0kvZGxoVUZnalpw?=
 =?utf-8?B?eW0xa2QwVklGbEZzb1RwTEtUb1JEc2owTUkzMW14VDdEVUd1YmdBZk5lbnBw?=
 =?utf-8?B?K1kwZVMrYllCMnZhbTJNeFBITGJORUx5NHZJdEI1Sm9TdUZpek5maTRiVmVB?=
 =?utf-8?B?b3hsTHVsbFNjZ25nbGhrYmxqMUJXcjZQUHZ5czRvYjJ5SXhNU08vVWN6RVFr?=
 =?utf-8?B?Y1hVU0RxNkhrQWhFMEczR1dacS9TSUU0QkdoaGNaYWRlYllORkprWkYvVHRx?=
 =?utf-8?B?ZjVPc2QwVm5tRVNwMXZqelYvUk9zK2FtU0tpdHRZK25JRUYrMzk3K0swelFW?=
 =?utf-8?B?MGpJY0E1ckk3SGNJS24xRURzL1pIVEI1TkVsbDZwUXZxMkt0YjdKU3NLcEVo?=
 =?utf-8?B?Q3UyNlhaVUVFZkNoazNqR0ZUUjRPalVHdnYxb3ZtY3VMZ2s2MitBUnFOSlRV?=
 =?utf-8?B?b3BYOXNxQ2lsZDAveWFmNytRT1MvdWZJdmxFR1ovTDhIVENFbk1CN0E1SFhM?=
 =?utf-8?B?bzZjd2lPRDdXRXh3azN5VnNBREhsb3JyU01NTzF1a096NUhiYUZVSVpndzJw?=
 =?utf-8?B?ODM1aHVDZVdQc2kxZEJVNTJkMG1YMklEamRzc2JvMU9Bc3B4Z1k1bHpob3ZE?=
 =?utf-8?B?UlUwOVQreUZ2djZ0SWx5YWxtRlpJUjhsNG1lc2NONXNlTkQyanZUb0tkKzFm?=
 =?utf-8?B?cXpUMXhwRDlMREN5cTQ4SlFDUlpoekpsVEQ5dlgzYzhiUmI2MUtsS0ptMnN5?=
 =?utf-8?B?dUlpdkc2bVhNSURhSjI2Vi9uRDBKRGR5Ymd1M0xGUjI5cEF1SWd5N0lkSEk3?=
 =?utf-8?B?bHJTcWx1M2lKSzZBcGljSnYvTW0zcnNGOCtlaERWdGxuOG9DbjdTQVlVUTYv?=
 =?utf-8?B?eWg4SHJaVDJRdWRVaWhVSVVqQXhacmpWNUFMOHBMczhlVllKSEwrQmh5djVB?=
 =?utf-8?B?elJYOWZUdE1wQW12YTcwRnZhVU9VMEFFWTI4T0doNkh3NnRTM1g2YjVxYzhQ?=
 =?utf-8?B?NGJhZU9qYVA4SmY3cVBmK1NlWERKNWVSTHhNdUptMU1VVlFwT1dSeitPa2xh?=
 =?utf-8?B?dGkwSGprZDMzb0xPT3lPNUg2SE9vUTNaWEVZSndEeVZpNWxkOHFIREZrbUdp?=
 =?utf-8?B?d2FQaGxXOWFSbEVwTVY0VC9VU2h1cnRLbEZTUjRzMWN3MjdWYU5SVkRqaXp6?=
 =?utf-8?B?ZldXek1tQkRHeUViN3lLZzFhN1RwdGQ2aVM3M1R5akZsVGVjL0x0L2YrV3ds?=
 =?utf-8?B?TGQyT21qWE9oeHUvQzFJUW1GQXMzZ0hqN1VzYWlOVlJtZkU3WUxqekZBeXFx?=
 =?utf-8?B?Mmdlajc5bWViUGU3b0dmUG8zbE9zVHhXM0F6VWVQeUJnTXBUM1VTcHUzS2or?=
 =?utf-8?B?ZFZIaWdwdXMweGpRenNSUFFUV2MxZFhMVjc1aDN2NHUxekg0R0xzMXY4cUho?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YuK+la4lrbbSjIXMBJXeprPGwddbneLIXGU0NQnkfBi/XY8ACY2Vn3n0CeN1u0NnUv/Ao9TTrc/41capyg8taq86iKFFabESvvJOU2w2m3uc8c3dkBOd+ZS3XH5R3uc07rpjXqNTtswXO9DYN6H/Md4zfmN6TpiGFRhZhoXzxUpFB33LmJsyCmvPqNe79044yLbzTBNGqpsFf6m+Q4Bk6IGeTbu6sejAjd+mHqY+aVRSlFXojKU4aOrB0nZUNeGZrCmMNB8xK0Mx+UhhCf7YjE4Cen74CxDAJyDFHcE6YrBnJ3PiU4+3bAUnNJSUTbKJKxzK04LhduaI5qILb7+fLWsS+lP9sERTloAb7UNpSpdBoQl5eqg3tAL118eniu7GtFt6YUoWPFyTYvzyHiKAmAD9c63NxybUm4ZdvXXra5BMLYRJC5lohHLq6ZXzjYR2PIP47cl7yHWKJAa8aB3rWGcqLKlz7QRYNZ8Il5cB+UsM29nhfYUXHUaKsuMH0/o9sKRacdzi41Cf51fW5X23Evdj0mmSVO8AfKXlPF/RuJo2pWfPnJScgVgcG3qJwnpTaBar+z5jMsFNFy2xCkyqMWPh/H6au7ZlrXUk827kh+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffba06ca-06cc-4cf2-1065-08ddb9ab0347
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 20:57:10.4774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2UKbYSY+TGtRTBYd9jEvbK53m1JbrCsJZIfAPvmRhqGCbRRGTyRM2z8BgiqlOIfIdQzkwzPoi6FQLPvMXsDLLb91vpPONkahnoaEycB4Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020172
X-Proofpoint-GUID: 1zZ5QAvwAupO3pjqJRJ-rPiNE-n33vZP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE3MyBTYWx0ZWRfX/y/KwdtkehjW
 Y8AOIGfoP3xozR7wkJyZTsvtY+74NjsYo/GSbm63NZq98TGXwhLsdDGkLIbiWz3P4nElaMp9oQf
 fyU/IlnGnpKTAQwTvEx4hMa2BZGkC30aDb/qq8HqHo6hU/zESpsMGl3M0VUgk53Xb3ajIfC7ma/
 OANsNEzl5BhBf1qg0pk8XK0jLk46LGxKxceU59N08+tQTtHLS0Z3M2ZGLpu27h0byDLL4cCJgDf
 oJ0BjyB7EoC0val8jBD73381whiyL+lix8p1xFE1cY3lZWVH4Hcg2TUf8aKXegDlcJe9KPAjlHK
 tL0NKrWF0jDnMpVhq4aLAIe9BMKkD5wG+aCaH25KBrrn+6I5EZTiwzHVvjSaJKyyPzQBGpE77d9
 +BEaE5F5ZqPyeOGdFZ87rVu/55iGjqYSrczAyAklwAb4qeHVJ9AufrFA9o2JL01eu6kyvMe7
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=68659d2a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=tJcCbLibARkT4QY1fXQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
X-Proofpoint-ORIG-GUID: 1zZ5QAvwAupO3pjqJRJ-rPiNE-n33vZP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/2025 9:46 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V5 35/38] vfio/iommufd: change process
>>
>> On 6/25/2025 7:40 AM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V5 35/38] vfio/iommufd: change process
>>>>
>>>> Finish CPR by change the owning process of the iommufd device in
>>>> post load.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> hw/vfio/cpr-iommufd.c | 30 ++++++++++++++++++++++++++++++
>>>> 1 file changed, 30 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>>> index 152a661..a9e3f68 100644
>>>> --- a/hw/vfio/cpr-iommufd.c
>>>> +++ b/hw/vfio/cpr-iommufd.c
>>>> @@ -110,10 +110,40 @@ static bool
>> vfio_cpr_supported(IOMMUFDBackend *be,
>>>> Error **errp)
>>>>       return true;
>>>> }
>>>>
>>>> +static int iommufd_cpr_pre_save(void *opaque)
>>>> +{
>>>> +    IOMMUFDBackend *be = opaque;
>>>> +    Error *local_err = NULL;
>>>> +
>>>> +    /*
>>>> +     * The process has not changed yet, but proactively call the ioctl,
>>>> +     * and it will fail if any DMA mappings are not supported.
>>>> +     */
>>>> +    if (!iommufd_change_process(be, &local_err)) {
>>>
>>> I'm confused when to call iommufd_change_process_capable and when to
>> call iommufd_change_process, could you clarify?
>>
>> Strictly speaking, we do not need iommufd_change_process_capable,
>> because we always
>> try iommufd_change_process and recover on failure.  But,
>> iommufd_change_process_capable
>> allows us to install a migration blocker, and fail with a blocker error, which is
>> considered
>> more user friendly for migration.
> 
> Though they are same effect, iommufd_change_process_capable still looks better than iommufd_change_process in pre_save(), because we want to check instead of really changing anything here. 

Yes, I will make that change.

- Steve

> Other than that, this patch looks good to me.
> 
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Unrelated to this patch, after further thinking, I suspect that blocker is never installed. Because vfio_iommufd_cpr_register_iommufd() is called for first VFIO device and before memory listener is installed. iommufd_change_process_capable() will always return true.
> 
>>
>>>> +        error_report_err(local_err);
>>>> +        return -1;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int iommufd_cpr_post_load(void *opaque, int version_id)
>>>> +{
>>>> +     IOMMUFDBackend *be = opaque;
>>>> +     Error *local_err = NULL;
>>>> +
>>>> +     if (!iommufd_change_process(be, &local_err)) {
>>>> +        error_report_err(local_err);
>>>> +        return -1;
>>>> +     }
>>>> +     return 0;
>>>> +}
>>>> +
>>>> static const VMStateDescription iommufd_cpr_vmstate = {
>>>>       .name = "iommufd",
>>>>       .version_id = 0,
>>>>       .minimum_version_id = 0,
>>>> +    .pre_save = iommufd_cpr_pre_save,
>>>> +    .post_load = iommufd_cpr_post_load,
>>>
>>> Do we need LOW priority?
>>
>> No.  iommufd_cpr_post_load only calls iommufd_change_process, which
>> acts upon
>> mappings that are already known to the kernel, independently of vmstate.
> 
> OK.
> 


