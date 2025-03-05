Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1A3C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 21:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpw9P-0001FA-Om; Wed, 05 Mar 2025 16:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpw9K-0001Ek-EG
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 16:19:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpw9F-0005zQ-U9
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 16:19:29 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525LBh6Y013681;
 Wed, 5 Mar 2025 21:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2023-11-20; bh=xlq/fArP6D5UTwTz/Z
 jmmz5xsRkdBHAAJdW5fneoxF8=; b=HU6duMP4GlaajpvOj0VvqgKBVK8bBlPlNv
 9updY2+tuwKG00XRKBleMJ141MeKhcMAm74F2gqa9nMdAxU9JVC8e2mQD+WCseAI
 9BGFUXG2+i84JNTWazEVw12Yb9NVFFZhfAM+Wpz86ibYo+4MHnGuNl1AWW6pNyV1
 ZLceZJatW32+aboo4bt9jIdV3sXBjrDFVklgSEwsoMfnzhOjmfddmHzXx8TrHjq0
 0BeKz4gkK+2JpHD1NbM2HcvKuLWdFFFKEipYy+U4G33XOdlPXNHj95X8eDpG1IX+
 0D4xPx+hjRfNg5pTcmYEhBrhjDr5zRG5LEUW4r0pGXz2tVYkG6yg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r48kp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Mar 2025 21:19:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 525KkL1I003158; Wed, 5 Mar 2025 21:19:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rpb12pq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Mar 2025 21:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyi4OuNevbk1M/bMbhBsnj5HVZtcl+6An2LcB9UpwA36nu4Au2MpiahJOVLOWDtAKIiEkzzYpvWHbGlCXfwELkA57KdTt3k5sLoCeLDEQ7vbVO4MlWFzrle35JvfOJcK1/369gNl8epynndaGV2LsFuM4RdXvnP0HAxVZVDiUGTRsZ6w8TvDOZF1uWPeDPB4zE/XsspF5DJkwwhT1vPCFoB1l24FzVq/rjGrkPd4RDzNXubIJNxhsqGw45zurSDb69dwXZXH2Ov8sMxPK0j28hcF2aDNedMB0fC4YUZw9AnwtLA1RLY7igwmHTCunGAote+pnzE+iwuX2XNkJFALAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlq/fArP6D5UTwTz/Zjmmz5xsRkdBHAAJdW5fneoxF8=;
 b=YD5WSrUvwoWGbaRauYN0ZE9bCHmoexnPOx0ilxDDNeibnJ9dcRcwm95RsEvQy5W6Va+r0rRc71CCcnNgIcWzDp7kl/DFhJHSgmTE6Z8/KVX1KoS+IN9v2nuc1ZPe+MkN3vQnEsCgtLqkl6C68dQaAghFzhrA+DD86ERFPSmDw0oYEmVamNWWjs4Lk3GpCQbOmbOc2M4R+C4njTaoNQRMVEWbDa/rltO+iBfxGmgQtENJClH2TvShoYzZQnkB0QKBFVHt4DlZJ65bHzp4l3k20i1fL5kQpDRL5HcvjdtWiwVUX6fs8CGMb06cfO8wHmf8VCi9cwXDxTa3I1Eya3dWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlq/fArP6D5UTwTz/Zjmmz5xsRkdBHAAJdW5fneoxF8=;
 b=DzPbZNHeFPqzF0PLPt92tFugTT5eqjHSf3+R7zXld3Mob3sIJhC0eDs8Im1KmxUz3UJNAJ5UoTEUk+8ACxD8I429Jx7xpuv5k+uWcXuSrawog/GGZr+3YRA1LCNmufKpNGa3pcgQtJFqUOkTccHX1Swkh6Ejlt52KYBKlwVmD+A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6368.namprd10.prod.outlook.com (2603:10b6:806:258::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 21:19:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 21:19:16 +0000
Content-Type: multipart/mixed; boundary="------------8jmVDHwPgJ7bfN7fur50tiBI"
Message-ID: <76d393fa-4c40-4331-aa5e-381f34c60c3a@oracle.com>
Date: Wed, 5 Mar 2025 16:19:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
 <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
 <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
 <063ee0ac-0568-4413-835b-e620f8d70761@virtuozzo.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <063ee0ac-0568-4413-835b-e620f8d70761@virtuozzo.com>
X-ClientProxiedBy: BN0PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:408:ea::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4d2e8f-fe02-40a1-b1af-08dd5c2b627b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2kyYWNrNGgyZGRhL2xZekRZVW9jYjd4emJpV3VhczZjV1RFeTd1WXNwL2FQ?=
 =?utf-8?B?RnV6YmkwWGFzMEV0MjZjbnhESjNzRGpZSVBkVjVXM2k2aWxyWlc2SWo0K0JE?=
 =?utf-8?B?UC83MktERmV3clNXbUNOM1QycmloYjI4bHprOXludXNRT21sdER0cXErUjBV?=
 =?utf-8?B?dSs3ekN4RHRNL0Q0ckxNdEtqMlFvZkJTTnd5VWlNTXJxT203a0ZIZGxRUS9N?=
 =?utf-8?B?bHBUNUJGVVBsRXVkWjEvb1h1bDNEZGdqbFBMUm5OSW1mRndxeGZlRDRHZHow?=
 =?utf-8?B?UUxubXpjUzM5NGJXd0F3WXgvTGcvSmRaUjdNcklKT3E1bXZtMnV1dEJpZGZW?=
 =?utf-8?B?Vk9xdHJYalg0T0YxUnowbWVzaUN5aGhKczNCeGlwZWRjTitacTdOdkV3M3dQ?=
 =?utf-8?B?bk5jdkU2cjNaYmdYeEorZHhHaEM2MG15d21GLzFWUDBTRmYyMHhYNTZWbklo?=
 =?utf-8?B?d0NMV0sxbnRkeGIzd1BqWm9lTTZCQ2pqaU9oQzA4OGdNOEhYR2hNM0haVkxa?=
 =?utf-8?B?UkJBNHY3anlEeXQ1NHRYU3JQa3VCQ0dxK0ZoTUtsYzIwdllqaUlKalhob2JL?=
 =?utf-8?B?NzNyYXNvcnBJcDhTSm11aHdMNWJaUkhyUzJRRmRZVkt4MjdpdXQxcFgrYVhl?=
 =?utf-8?B?UjZlMDBhMDhqWllCdnNvUmZ4WThvUlJNOTFJcGo3Mm5Ja0o2Znp4d3VPZWhN?=
 =?utf-8?B?RXdaWTRlcEw1Y2pUQklMNmtxRURwVXJFOXAvYWRlbEFGNjRIOHhwV1Q5OXlH?=
 =?utf-8?B?VyszMlg2U0ROcTV3LytNeHAxZ1VsTzRudFRIcHBUSG5qTlN4MFQyWGJJT1E3?=
 =?utf-8?B?MTVUSDJ0Q2prZkgxZjVWcjZRQ2x6Qy9XWlc5aVhJTDQ4KzhSYWYzYzVqa3R4?=
 =?utf-8?B?YzFNem9ZTS8yTldzK21UY1FCaHVuNlg2alZVVkJnTzgzanVnUG4wN3FoM3VL?=
 =?utf-8?B?WFRtQnpGTVdZNGh1azdBVGh5bHhocUNpS25VMXFMWFJZdXY2YzhFZm1jUlhp?=
 =?utf-8?B?bjNzTnhNRnJXY1FqeXNHVXRPakpVd1BzK05wd2dzb3FhUnhVM29zcDFQTC9B?=
 =?utf-8?B?Ukt4d28wNjVVNXZEQjhqeEY1T3ozTFR5VXhTdFg5NWZQSWFJaFlLYmh4eGhs?=
 =?utf-8?B?K2pkQW1RRnN6anpMMmRaUTAwcXRIa1RJck80cmpWb21Ed24zSC9SdzFSM0k5?=
 =?utf-8?B?amh3Ym9NN1ZQZmhneks0VWg4NWFBbmRBb0RxeXd6NXJUUnpObTZYdlJxS3ZJ?=
 =?utf-8?B?RzNhc2pVaG5kbHpoN2NGampobzhscDlyR29lQm50UFZ6OUlHOWhwaHZKTEho?=
 =?utf-8?B?TXJDbkJ6SXkrUFB6bHlFUmh0c096cVN5RGxiNWR6aExSMjZ4V2NZTmpoTXBR?=
 =?utf-8?B?LzQ3L2JaaFVoWnlUUHl4cUxnZWJWU1FKc0IxbXZvYVErc0MvMjFaVkRQdWFF?=
 =?utf-8?B?c2plWHRrSEkzVEN0cmJISzk1WjFZdEYxWUFrQ1lGWUdxTlhZMU1VTFhnOW8w?=
 =?utf-8?B?VE1hTEhxK1M3MElmMENsdEFzU2ZpOFI5cTV6d2s1MExjeFM1Q25uY0p1d2gr?=
 =?utf-8?B?Q09kSDIwT1NzdXp5Ylp0T3pVZlZxR3ZjbThscVpoci9pUmNPMmFLMEtwS21Y?=
 =?utf-8?B?MXA3dHl3OU1JczM1SXB0L3piRDdyZ3Buc0J4K3ArWUIxVHh1bWdnRnZDd1ky?=
 =?utf-8?B?TjJaazRGa3lPekpPbEg2U0FqMm42RTZDVFlpekJSeER3Rkd3QVlHREFoRjVq?=
 =?utf-8?B?UjdrZXlaTE9Yd0tRck55VWhEZnFmTldTTXBKZ1hpVjMrZWo3c1Z0OVp6Mlp2?=
 =?utf-8?B?b3lnV0YrS2c4NlNxTFpHQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZzcmdJVEJEc0o5S3BRaEJIQnBleDIvVU5JOXpJR29ERzVaWm93UjJaUExy?=
 =?utf-8?B?MXlMNXEySHZEV3JZYVhNc3Q3L2JRTWdrRlhCSlVmUHdmc216clk5VDJQNnlL?=
 =?utf-8?B?a1FhSmJaWlFobXFDTEV3aHF2ZUxaMEY0OU5uWEY0a01iL3hLaFQxK2RveEVy?=
 =?utf-8?B?ZEZ2Z2ZneEpzN2Q4REVuQUl6bVJOUHBuZFh0eEI3QngwN2lRZFhFa3RzY2dW?=
 =?utf-8?B?V0pkNkxLU250QktmdFhMQ2VIWjZ1bCtBNk5Ma2JQK2V0TnhYNE5uNDB2TTRN?=
 =?utf-8?B?NEdYNHNTSHVWT3VPYjZPbytyelBXeUNBZ3BGM2VCVjh3eXRTMFVoSWtnZW4z?=
 =?utf-8?B?Q0VlcVprS3VNRnBxZVQ2eG5ESGd0eWxhZmxMbzI1Y2d3K2d3K2Vad2VtcWxV?=
 =?utf-8?B?SEhUOC9FMHZZdFVJMkRnbmhPSk5BVDJKUld3Z1h0OWdobVl2Vkg1NkVMeUlQ?=
 =?utf-8?B?QjFwcitkMDdlWUtGK1NOdXdockFaU3BxKzhaK0U4M3FKWEdyQjljVHMvdnpQ?=
 =?utf-8?B?VnRtbEVwRUNJYXR3SnBRY1I0OVVrQXNKVE9XeHFsV3J6bnh1eVdOdnFWY0xH?=
 =?utf-8?B?eHBBaUNtZm5VKytFSXcyMTcrMlp4N3BUMWtQQjhETDZEakJBZjZLYUxRVUlp?=
 =?utf-8?B?VVdXSWdEUk1ZdTJ3NHNWbG9aclNHQXlUblJsU21ydytHRXFsTXVHMmtqd2Qx?=
 =?utf-8?B?NGlEbEcrcE5tT25DRm1UckNBamZWcDVWSzliQlovOURkMHhGL0xCcVBVYlZ1?=
 =?utf-8?B?VllJU0JmQUU5UFVjN0l6c1Q5aitKN0VJdzJRV1pwWmx4b2lKbWh2VkJ4VmI4?=
 =?utf-8?B?dktmdGY5ZFR2bDZ4SldWQzlQSWNIWm1xbFRXcCs5c3kvUmRDT3BLMUxoTVAw?=
 =?utf-8?B?OWJBK3hCOGhsOTdYa201RjRqMkt5M3VXMW9kdnBDTWNRU21HbmxUd01yTVBB?=
 =?utf-8?B?c0dQMjhiZUhsempvZ2lZTjVqNlVhbkVKNDVJcXR4Z0ovR3lzSzZvcFJXdjND?=
 =?utf-8?B?YnFuS1QxdWNmbW5wQlg1QlVKbDN1VDBwYjNzTTllTWZ0YW9lQmx1a0xIcEtq?=
 =?utf-8?B?NnFFV1Yyam1qVUVxWUVCQ2p2UlprZ25IV2hLczhXTHZ0eGdPK3YxYmpicTZB?=
 =?utf-8?B?QTd5VytBR05UNVpBK1FUc2NSWGZxNXhvUFRlQi94MzliNk84SFpMeTI5ODJI?=
 =?utf-8?B?R05GYWc5VVVTbW9RWDVodzlISHRGUTUvcWlvdmZGb256WFdkV3A1VzFLWTM3?=
 =?utf-8?B?bHQzSXJkOEMrck8wUzVjQWpvUHlDZ1JTVzhCVlpybFpoeThMYXdKZkVXR0Ev?=
 =?utf-8?B?TmNyRUVVSmVNT0xxR3paT2liYXFvcWx1dUZWalh4ZVYrOENyMSs0aXYwdUxv?=
 =?utf-8?B?eUVFSHRjajBLNEFmYnhaNjllcDF6V2t0dllaY2svUEZjajltUUh3OGFqOG1x?=
 =?utf-8?B?L1BrOGViTGgyQ2g1SS9vOEx2ZEk5Umh6VmRGL3lackIvZTFhKzh0aVNUL2JP?=
 =?utf-8?B?eE55cXdQUkYwcmVwYlQ4SnF4THM0NmE3alRIcXRMVlI5Tllsd2t1UTNmRDBF?=
 =?utf-8?B?NFhnM2lhNkl0ZHUwMnFaeWtEYjk0Z1lhRkFFdVBoWGtHRTFmcjQ4ajl2K2Fh?=
 =?utf-8?B?WkJ2ZEFuN1FQQWZGd0VOekRScEVhZUhTYjdjaTQ2TW9VMEFCNkJjZ0x4TjFx?=
 =?utf-8?B?dkIzdktZV0Vib21ZK05Dcit2WGZ4WVBPd202eXFsTHhTUk9uZTZlUDg1RFEv?=
 =?utf-8?B?UlR5UCszam81ZXFSVXZmR2tGMjlCMVBoK2NGN0VFQWdqRXBmYU51Z2ZrY3ZR?=
 =?utf-8?B?azh3allPaTlXTEJrT0UwM1owMHRNRzNQd0Z6WFg4RDViMEdYbFM0TGZ6d3ho?=
 =?utf-8?B?czZzU3QzSldocFdZTDJ6M2c4ZnJ4anJZMHhodjdjdE1VY284aEVLaEtnT3pS?=
 =?utf-8?B?R0plVndtNW1hQ1crdTNZNVViWHJWQjczbmJZMFUveTQvY2Q1Wll5RWtMT2J6?=
 =?utf-8?B?WVBUSnBrK3pxdld4eGhQYlhPODhyWmUvK2xxS1F3em85alFCdkhlTGx3Qmxr?=
 =?utf-8?B?NmhTTEd4b0NtbFVOb1dpTTVqeVIrRWQ0TU9QeC9UM29tQnhwaVBLMjlaRDd4?=
 =?utf-8?B?Z1dTQURnSjJNSWFqZnJ3V3N2VUIwaGkxS0tPS0Z1ck9kWXJJK3FiQjY4R0VI?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: unMqViWsVym9Vc9qLHiqylBM3Nd2yy13676yBIakQFUu9GcV0GLhcN/eOnrRL0rdTh6mTULNqt7t9/qM13urs8EW7TEwBr+j7TtDrauRJg0G2D0M+KfnCg8azmtLLlcisoS9DmKlHgtV7WswAYMQdCwebAAJrvrcpywNo2lbSVQOljC2WbK2AfsX4H2tcSf8Thtm4S1IcBCfMrnedZ3IEhP15bVl0cSAz07p50Jw/sfD04MgPgkHL+wrKTKcu8uF7c8mSd+HzjfW+seqKo7gkxHUzRqgmCnQ59MZXbiNVyv5HtNhmOqVrrYge8HCsaPzIRqfm+XgudYXzOzOk8BA9g09Mxd5OjQIgCbaJFj4JPa9HdeIvz9Nspvj3KHLaWW4bjLYjjlp19D07r/WAfMJA7vzHeis/rCB412vl39tHPFnsIc7Kl/e7Vc+vLEuucfJfDaEKA1rdqClh0bwuMyVSdCIK3VUkWf2AKv0vhKb6T0EVWNLCGecvKSs5zUQ+47gvdxRTTQY1Fhrh585aup7lQDwhM910ILjbiz/k80aGhQ7Wngc6K+LGWZvFJbIZtsfEQEOF5tFQmVVjoK5VlTaNwDlhyf1lYzWXrOTDsG3q0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4d2e8f-fe02-40a1-b1af-08dd5c2b627b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 21:19:16.4262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey1SHU86Bq1DI2qIb6/HG8mETaXYRnuYl1Oypl5GvkKYI8bBKspUxFnCc8n0wQhhNGORhfdQY2tsuZpBfb1k1RpCf54MzF+3KstBS9ilaws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_09,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050163
X-Proofpoint-ORIG-GUID: MPZC6neJEIFLX0ZBzaPAcXFlKDyNF_Bc
X-Proofpoint-GUID: MPZC6neJEIFLX0ZBzaPAcXFlKDyNF_Bc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--------------8jmVDHwPgJ7bfN7fur50tiBI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/2025 11:50 AM, Andrey Drobyshev wrote:
> On 3/4/25 9:05 PM, Steven Sistare wrote:
>> On 2/28/2025 1:37 PM, Andrey Drobyshev wrote:
>>> On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
>>>> On 2/28/25 8:20 PM, Steven Sistare wrote:
>>>>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>>>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> We've been experimenting with cpr-transfer migration mode recently
>>>>>>> and
>>>>>>> have discovered the following issue with the guest QXL driver:
>>>>>>>
>>>>>>> Run migration source:
>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>> ROOTFS=/path/to/image
>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>
>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>        -machine q35 \
>>>>>>>>        -cpu host -smp 2 -m 2G \
>>>>>>>>        -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>>>>> ram0,share=on\
>>>>>>>>        -machine memory-backend=ram0 \
>>>>>>>>        -machine aux-ram-share=on \
>>>>>>>>        -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>        -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>        -nographic \
>>>>>>>>        -device qxl-vga
>>>>>>>
>>>>>>> Run migration target:
>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>> ROOTFS=/path/to/image
>>>>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>        -machine q35 \
>>>>>>>>        -cpu host -smp 2 -m 2G \
>>>>>>>>        -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>>>>> ram0,share=on\
>>>>>>>>        -machine memory-backend=ram0 \
>>>>>>>>        -machine aux-ram-share=on \
>>>>>>>>        -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>        -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>        -nographic \
>>>>>>>>        -device qxl-vga \
>>>>>>>>        -incoming tcp:0:44444 \
>>>>>>>>        -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>>>>
>>>>>>>
>>>>>>> Launch the migration:
>>>>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>
>>>>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>>>>        migrate-set-parameters mode=cpr-transfer
>>>>>>>>        migrate channels=[{"channel-type":"main","addr":
>>>>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>>>>> {"channel-type":"cpr","addr":
>>>>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>>>>> dst.sock"}}]
>>>>>>>> EOF
>>>>>>>
>>>>>>> Then, after a while, QXL guest driver on target crashes spewing the
>>>>>>> following messages:
>>>>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>>>>> 0x00000001)
>>>>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>>>>>> allocate VRAM BO
>>>>>>>
>>>>>>> That seems to be a known kernel QXL driver bug:
>>>>>>>
>>>>>>> https://lore.kernel.org/all/20220907094423.93581-1-
>>>>>>> min_halo@163.com/T/
>>>>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>>>>
>>>>>>> (the latter discussion contains that reproduce script which speeds up
>>>>>>> the crash in the guest):
>>>>>>>> #!/bin/bash
>>>>>>>>
>>>>>>>> chvt 3
>>>>>>>>
>>>>>>>> for j in $(seq 80); do
>>>>>>>>            echo "$(date) starting round $j"
>>>>>>>>            if [ "$(journalctl --boot | grep "failed to allocate VRAM
>>>>>>>> BO")" != "" ]; then
>>>>>>>>                    echo "bug was reproduced after $j tries"
>>>>>>>>                    exit 1
>>>>>>>>            fi
>>>>>>>>            for i in $(seq 100); do
>>>>>>>>                    dmesg > /dev/tty3
>>>>>>>>            done
>>>>>>>> done
>>>>>>>>
>>>>>>>> echo "bug could not be reproduced"
>>>>>>>> exit 0
>>>>>>>
>>>>>>> The bug itself seems to remain unfixed, as I was able to reproduce
>>>>>>> that
>>>>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>>>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>>>>>> without the cpr-transfer migration the above reproduce doesn't
>>>>>>> lead to
>>>>>>> crash on the source VM.
>>>>>>>
>>>>>>> I suspect that, as cpr-transfer doesn't migrate the guest memory, but
>>>>>>> rather passes it through the memory backend object, our code might
>>>>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>>>>> corruption so far.
>>>>>>>
>>>>>>> Could somebody help the investigation and take a look into this?  Any
>>>>>>> suggestions would be appreciated.  Thanks!
>>>>>>
>>>>>> Possibly some memory region created by qxl is not being preserved.
>>>>>> Try adding these traces to see what is preserved:
>>>>>>
>>>>>> -trace enable='*cpr*'
>>>>>> -trace enable='*ram_alloc*'
>>>>>
>>>>> Also try adding this patch to see if it flags any ram blocks as not
>>>>> compatible with cpr.  A message is printed at migration start time.
>>>>>     https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-
>>>>> email-
>>>>> steven.sistare@oracle.com/
>>>>>
>>>>> - Steve
>>>>>
>>>>
>>>> With the traces enabled + the "migration: ram block cpr blockers" patch
>>>> applied:
>>>>
>>>> Source:
>>>>> cpr_find_fd pc.bios, id 0 returns -1
>>>>> cpr_save_fd pc.bios, id 0, fd 22
>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host
>>>>> 0x7fec18e00000
>>>>> cpr_find_fd pc.rom, id 0 returns -1
>>>>> cpr_save_fd pc.rom, id 0, fd 23
>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host
>>>>> 0x7fec18c00000
>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>>>>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>> 262144 fd 24 host 0x7fec18a00000
>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>>>>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>> 67108864 fd 25 host 0x7feb77e00000
>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>>>>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>> fd 27 host 0x7fec18800000
>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>>>>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>> 67108864 fd 28 host 0x7feb73c00000
>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>>>>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>> fd 34 host 0x7fec18600000
>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>>>>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>> 2097152 fd 35 host 0x7fec18200000
>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>>>>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>> fd 36 host 0x7feb8b600000
>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>>>>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>> 37 host 0x7feb8b400000
>>>>>
>>>>> cpr_state_save cpr-transfer mode
>>>>> cpr_transfer_output /var/run/alma8cpr-dst.sock
>>>>
>>>> Target:
>>>>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>>>>> cpr_state_load cpr-transfer mode
>>>>> cpr_find_fd pc.bios, id 0 returns 20
>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host
>>>>> 0x7fcdc9800000
>>>>> cpr_find_fd pc.rom, id 0 returns 19
>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host
>>>>> 0x7fcdc9600000
>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>> 262144 fd 18 host 0x7fcdc9400000
>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>> 67108864 fd 17 host 0x7fcd27e00000
>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>> fd 16 host 0x7fcdc9200000
>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>> 67108864 fd 15 host 0x7fcd23c00000
>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>> fd 14 host 0x7fcdc8800000
>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>> 2097152 fd 13 host 0x7fcdc8400000
>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>> fd 11 host 0x7fcdc8200000
>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>> 10 host 0x7fcd3be00000
>>>>
>>>> Looks like both vga.vram and qxl.vram are being preserved (with the same
>>>> addresses), and no incompatible ram blocks are found during migration.
>>>
>>> Sorry, addressed are not the same, of course.  However corresponding ram
>>> blocks do seem to be preserved and initialized.
>>
>> So far, I have not reproduced the guest driver failure.
>>
>> However, I have isolated places where new QEMU improperly writes to
>> the qxl memory regions prior to starting the guest, by mmap'ing them
>> readonly after cpr:
>>
>>    qemu_ram_alloc_internal()
>>      if (reused && (strstr(name, "qxl") || strstr("name", "vga")))
>>          ram_flags |= RAM_READONLY;
>>      new_block = qemu_ram_alloc_from_fd(...)
>>
>> I have attached a draft fix; try it and let me know.
>> My console window looks fine before and after cpr, using
>> -vnc $hostip:0 -vga qxl
>>
>> - Steve
> 
> Regarding the reproduce: when I launch the buggy version with the same
> options as you, i.e. "-vnc 0.0.0.0:$port -vga qxl", and do cpr-transfer,
> my VNC client silently hangs on the target after a while.  Could it
> happen on your stand as well?  

cpr does not preserve the vnc connection and session.  To test, I specify
port 0 for the source VM and port 1 for the dest.  When the src vnc goes
dormant the dest vnc becomes active.

> Could you try launching VM with
> "-nographic -device qxl-vga"?  That way VM's serial console is given you
> directly in the shell, so when qxl driver crashes you're still able to
> inspect the kernel messages.

I have been running like that, but have not reproduced the qxl driver crash,
and I suspect my guest image+kernel is too old.  However, once I realized the
issue was post-cpr modification of qxl memory, I switched my attention to the
fix.

> As for your patch, I can report that it doesn't resolve the issue as it
> is.  But I was able to track down another possible memory corruption
> using your approach with readonly mmap'ing:
> 
>> Program terminated with signal SIGSEGV, Segmentation fault.
>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>> 412         d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
>> [Current thread is 1 (Thread 0x7f1a4f83b480 (LWP 229798))]
>> (gdb) bt
>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>> #1  0x0000563896e7f467 in qxl_realize_common (qxl=0x5638996e0e70, errp=0x7ffd3c2b8170) at ../hw/display/qxl.c:2142
>> #2  0x0000563896e7fda1 in qxl_realize_primary (dev=0x5638996e0e70, errp=0x7ffd3c2b81d0) at ../hw/display/qxl.c:2257
>> #3  0x0000563896c7e8f2 in pci_qdev_realize (qdev=0x5638996e0e70, errp=0x7ffd3c2b8250) at ../hw/pci/pci.c:2174
>> #4  0x00005638970eb54b in device_set_realized (obj=0x5638996e0e70, value=true, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:494
>> #5  0x00005638970f5e14 in property_set_bool (obj=0x5638996e0e70, v=0x5638996f3770, name=0x56389759b141 "realized", opaque=0x5638987893d0, errp=0x7ffd3c2b84e0)
>>      at ../qom/object.c:2374
>> #6  0x00005638970f39f8 in object_property_set (obj=0x5638996e0e70, name=0x56389759b141 "realized", v=0x5638996f3770, errp=0x7ffd3c2b84e0)
>>      at ../qom/object.c:1449
>> #7  0x00005638970f8586 in object_property_set_qobject (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=0x5638996df900, errp=0x7ffd3c2b84e0)
>>      at ../qom/qom-qobject.c:28
>> #8  0x00005638970f3d8d in object_property_set_bool (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=true, errp=0x7ffd3c2b84e0)
>>      at ../qom/object.c:1519
>> #9  0x00005638970eacb0 in qdev_realize (dev=0x5638996e0e70, bus=0x563898cf3c20, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:276
>> #10 0x0000563896dba675 in qdev_device_add_from_qdict (opts=0x5638996dfe50, from_json=false, errp=0x7ffd3c2b84e0) at ../system/qdev-monitor.c:714
>> #11 0x0000563896dba721 in qdev_device_add (opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at ../system/qdev-monitor.c:733
>> #12 0x0000563896dc48f1 in device_init_func (opaque=0x0, opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at ../system/vl.c:1207
>> #13 0x000056389737a6cc in qemu_opts_foreach
>>      (list=0x563898427b60 <qemu_device_opts>, func=0x563896dc48ca <device_init_func>, opaque=0x0, errp=0x56389855dc40 <error_fatal>)
>>      at ../util/qemu-option.c:1135
>> #14 0x0000563896dc89b5 in qemu_create_cli_devices () at ../system/vl.c:2745
>> #15 0x0000563896dc8c00 in qmp_x_exit_preconfig (errp=0x56389855dc40 <error_fatal>) at ../system/vl.c:2806
>> #16 0x0000563896dcb5de in qemu_init (argc=33, argv=0x7ffd3c2b8948) at ../system/vl.c:3838
>> #17 0x0000563897297323 in main (argc=33, argv=0x7ffd3c2b8948) at ../system/main.c:72
> 
> So the attached adjusted version of your patch does seem to help.  At
> least I can't reproduce the crash on my stand.

Thanks for the stack trace; the calls to SPICE_RING_INIT in init_qxl_ram are
definitely harmful.  Try V2 of the patch, attached, which skips the lines
of init_qxl_ram that modify guest memory.

> I'm wondering, could it be useful to explicitly mark all the reused
> memory regions readonly upon cpr-transfer, and then make them writable
> back again after the migration is done?  That way we will be segfaulting
> early on instead of debugging tricky memory corruptions.

It's a useful debugging technique, but changing protection on a large memory region
can be too expensive for production due to TLB shootdowns.

Also, there are cases where writes are performed but the value is guaranteed to
be the same:
   qxl_post_load()
     qxl_set_mode()
       d->rom->mode = cpu_to_le32(modenr);
The value is the same because mode and shadow_rom.mode were passed in vmstate
from old qemu.

- Steve

--------------8jmVDHwPgJ7bfN7fur50tiBI
Content-Type: text/plain; charset=UTF-8;
 name="0001-hw-qxl-cpr-support-preliminary-V2.patch"
Content-Disposition: attachment;
 filename="0001-hw-qxl-cpr-support-preliminary-V2.patch"
Content-Transfer-Encoding: base64

RnJvbSBhMzg0OGI0OGI2NWFhOTI3NTEzNzhjNWJiYzc0ZDdhZTRiYjY0OTMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPgpEYXRlOiBUdWUsIDQgTWFyIDIwMjUgMTA6NDc6NDAgLTA4MDAKU3ViamVjdDogW1BBVENI
XSBody9xeGw6IGNwciBzdXBwb3J0IChwcmVsaW1pbmFyeSBWMikKCkR1cmluZyBub3JtYWwgbWln
cmF0aW9uLCBuZXcgUUVNVSBjcmVhdGVzIGFuZCBpbml0aWFsaXplcyBxeGwgcmFtIGFuZCByb20K
bWVtb3J5IHJlZ2lvbnMsIHRoZW4gbG9hZHMgdGhlIHByZXNlcnZlZCBjb250ZW50cyBvZiB0aG9z
ZSByZWdpb25zIGZyb20Kdm1zdGF0ZS4KCkR1cmluZyBDUFIsIHRoZSBtZW1vcnkgcmVnaW9ucyBh
cmUgcHJlc2VydmVkIGluIHBsYWNlLCB0aGVuIG5ldyBRRU1VIHVzZXMKdGhvc2UgcmVnaW9ucywg
YnV0IHJlLWluaXRpYWxpemVzIHRoZW0sIHdoaWNoIGlzIHdyb25nLiAgU3VwcHJlc3Mgd3JpdGVz
CnRvIHRoZSBxeGwgbWVtb3J5IHJlZ2lvbnMgZHVyaW5nIENQUiBsb2FkLgoKU2lnbmVkLW9mZi1i
eTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4KLS0tCiBody9kaXNw
bGF5L3F4bC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2Rp
c3BsYXkvcXhsLmMgYi9ody9kaXNwbGF5L3F4bC5jCmluZGV4IDJlZmRjNzcuLmIxYzlmYzEgMTAw
NjQ0Ci0tLSBhL2h3L2Rpc3BsYXkvcXhsLmMKKysrIGIvaHcvZGlzcGxheS9xeGwuYwpAQCAtMzAs
NiArMzAsNyBAQAogI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiCiAjaW5jbHVkZSAiaHcvcWRldi1w
cm9wZXJ0aWVzLmgiCiAjaW5jbHVkZSAic3lzdGVtL3J1bnN0YXRlLmgiCisjaW5jbHVkZSAibWln
cmF0aW9uL2Nwci5oIgogI2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiCiAjaW5jbHVkZSAi
dHJhY2UuaCIKIApAQCAtMTE1LDYgKzExNiw4IEBAIHN0YXRpYyBRWExNb2RlIHF4bF9tb2Rlc1td
ID0gewogICAgIFFYTF9NT0RFX0VYKDgxOTIsIDQzMjApLCAvKiA4ayAgICAgICAgICAgICovCiB9
OwogCisjZGVmaW5lIENQUl9JTiAoY3ByX2dldF9pbmNvbWluZ19tb2RlKCkgIT0gTUlHX01PREVf
Tk9ORSkKKwogc3RhdGljIHZvaWQgcXhsX3NlbmRfZXZlbnRzKFBDSVFYTERldmljZSAqZCwgdWlu
dDMyX3QgZXZlbnRzKTsKIHN0YXRpYyBpbnQgcXhsX2Rlc3Ryb3lfcHJpbWFyeShQQ0lRWExEZXZp
Y2UgKmQsIHF4bF9hc3luY19pbyBhc3luYyk7CiBzdGF0aWMgdm9pZCBxeGxfcmVzZXRfbWVtc2xv
dHMoUENJUVhMRGV2aWNlICpkKTsKQEAgLTMzMyw2ICszMzYsMTAgQEAgc3RhdGljIHZvaWQgaW5p
dF9xeGxfcm9tKFBDSVFYTERldmljZSAqZCkKICAgICB1aW50MzJfdCBmYjsKICAgICBpbnQgaSwg
bjsKIAorICAgIGlmIChDUFJfSU4pIHsKKyAgICAgICAgZ290byBza2lwX2luaXQ7CisgICAgfQor
CiAgICAgbWVtc2V0KHJvbSwgMCwgZC0+cm9tX3NpemUpOwogCiAgICAgcm9tLT5tYWdpYyAgICAg
ICAgID0gY3B1X3RvX2xlMzIoUVhMX1JPTV9NQUdJQyk7CkBAIC0zOTAsNiArMzk3LDcgQEAgc3Rh
dGljIHZvaWQgaW5pdF9xeGxfcm9tKFBDSVFYTERldmljZSAqZCkKICAgICAgICAgICAgIHNpemVv
Zihyb20tPmNsaWVudF9tb25pdG9yc19jb25maWcpKTsKICAgICB9CiAKK3NraXBfaW5pdDoKICAg
ICBkLT5zaGFkb3dfcm9tID0gKnJvbTsKICAgICBkLT5yb20gICAgICAgID0gcm9tOwogICAgIGQt
Pm1vZGVzICAgICAgPSBtb2RlczsKQEAgLTQwMyw2ICs0MTEsOSBAQCBzdGF0aWMgdm9pZCBpbml0
X3F4bF9yYW0oUENJUVhMRGV2aWNlICpkKQogCiAgICAgYnVmID0gZC0+dmdhLnZyYW1fcHRyOwog
ICAgIGQtPnJhbSA9IChRWExSYW0gKikoYnVmICsgbGUzMl90b19jcHUoZC0+c2hhZG93X3JvbS5y
YW1faGVhZGVyX29mZnNldCkpOworICAgIGlmIChDUFJfSU4pIHsKKyAgICAgICAgcmV0dXJuOwor
ICAgIH0KICAgICBkLT5yYW0tPm1hZ2ljICAgICAgID0gY3B1X3RvX2xlMzIoUVhMX1JBTV9NQUdJ
Qyk7CiAgICAgZC0+cmFtLT5pbnRfcGVuZGluZyA9IGNwdV90b19sZTMyKDApOwogICAgIGQtPnJh
bS0+aW50X21hc2sgICAgPSBjcHVfdG9fbGUzMigwKTsKQEAgLTUzOSw2ICs1NTAsMTAgQEAgc3Rh
dGljIHZvaWQgaW50ZXJmYWNlX3NldF9jb21wcmVzc2lvbl9sZXZlbChRWExJbnN0YW5jZSAqc2lu
LCBpbnQgbGV2ZWwpCiAKICAgICB0cmFjZV9xeGxfaW50ZXJmYWNlX3NldF9jb21wcmVzc2lvbl9s
ZXZlbChxeGwtPmlkLCBsZXZlbCk7CiAgICAgcXhsLT5zaGFkb3dfcm9tLmNvbXByZXNzaW9uX2xl
dmVsID0gY3B1X3RvX2xlMzIobGV2ZWwpOworICAgIGlmIChDUFJfSU4pIHsKKyAgICAgICAgYXNz
ZXJ0KHF4bC0+cm9tLT5jb21wcmVzc2lvbl9sZXZlbCA9PSBjcHVfdG9fbGUzMihsZXZlbCkpOwor
ICAgICAgICByZXR1cm47CisgICAgfQogICAgIHF4bC0+cm9tLT5jb21wcmVzc2lvbl9sZXZlbCA9
IGNwdV90b19sZTMyKGxldmVsKTsKICAgICBxeGxfcm9tX3NldF9kaXJ0eShxeGwpOwogfQpAQCAt
OTk3LDcgKzEwMTIsOCBAQCBzdGF0aWMgdm9pZCBpbnRlcmZhY2Vfc2V0X2NsaWVudF9jYXBhYmls
aXRpZXMoUVhMSW5zdGFuY2UgKnNpbiwKICAgICB9CiAKICAgICBpZiAocnVuc3RhdGVfY2hlY2so
UlVOX1NUQVRFX0lOTUlHUkFURSkgfHwKLSAgICAgICAgcnVuc3RhdGVfY2hlY2soUlVOX1NUQVRF
X1BPU1RNSUdSQVRFKSkgeworICAgICAgICBydW5zdGF0ZV9jaGVjayhSVU5fU1RBVEVfUE9TVE1J
R1JBVEUpIHx8CisgICAgICAgIENQUl9JTikgewogICAgICAgICByZXR1cm47CiAgICAgfQogCkBA
IC0xMjAwLDYgKzEyMTYsMTAgQEAgc3RhdGljIHZvaWQgcXhsX3Jlc2V0X3N0YXRlKFBDSVFYTERl
dmljZSAqZCkKIHsKICAgICBRWExSb20gKnJvbSA9IGQtPnJvbTsKIAorICAgIGlmIChDUFJfSU4p
IHsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKwogICAgIHF4bF9jaGVja19zdGF0ZShkKTsKICAg
ICBkLT5zaGFkb3dfcm9tLnVwZGF0ZV9pZCA9IGNwdV90b19sZTMyKDApOwogICAgICpyb20gPSBk
LT5zaGFkb3dfcm9tOwpAQCAtMTM3MCw4ICsxMzkwLDExIEBAIHN0YXRpYyBpbnQgcXhsX2FkZF9t
ZW1zbG90KFBDSVFYTERldmljZSAqZCwgdWludDMyX3Qgc2xvdF9pZCwgdWludDY0X3QgZGVsdGEs
CiAgICAgbWVtc2xvdC52aXJ0X3N0YXJ0ID0gdmlydF9zdGFydCArIChndWVzdF9zdGFydCAtIHBj
aV9zdGFydCk7CiAgICAgbWVtc2xvdC52aXJ0X2VuZCAgID0gdmlydF9zdGFydCArIChndWVzdF9l
bmQgICAtIHBjaV9zdGFydCk7CiAgICAgbWVtc2xvdC5hZGRyX2RlbHRhID0gbWVtc2xvdC52aXJ0
X3N0YXJ0IC0gZGVsdGE7Ci0gICAgbWVtc2xvdC5nZW5lcmF0aW9uID0gZC0+cm9tLT5zbG90X2dl
bmVyYXRpb24gPSAwOwotICAgIHF4bF9yb21fc2V0X2RpcnR5KGQpOworICAgIGlmICghQ1BSX0lO
KSB7CisgICAgICAgIGQtPnJvbS0+c2xvdF9nZW5lcmF0aW9uID0gMDsKKyAgICAgICAgcXhsX3Jv
bV9zZXRfZGlydHkoZCk7CisgICAgfQorICAgIG1lbXNsb3QuZ2VuZXJhdGlvbiA9IGQtPnJvbS0+
c2xvdF9nZW5lcmF0aW9uOwogCiAgICAgcWVtdV9zcGljZV9hZGRfbWVtc2xvdCgmZC0+c3NkLCAm
bWVtc2xvdCwgYXN5bmMpOwogICAgIGQtPmd1ZXN0X3Nsb3RzW3Nsb3RfaWRdLm1yID0gbXI7Ci0t
IAoxLjguMy4xCgo=

--------------8jmVDHwPgJ7bfN7fur50tiBI--

