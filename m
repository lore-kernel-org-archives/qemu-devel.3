Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6E6C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 17:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKKOT-0000jr-I2; Wed, 28 May 2025 13:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKKOQ-0000jG-It
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:16:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKKON-0003pF-Tv
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:16:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq5a7006801;
 Wed, 28 May 2025 17:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ENhuhcD07eINT3U0X+2JiL2aohBWFxzXBn2iVCwoGiw=; b=
 ag0lKNunQADTu4oFC4H5/reZ8bQhe9GMrfsNbkr8sTRy1mHHaaNL5w6WGVXj6ndP
 +Kt4XBpk2/Fn3hmaD3QertVzD84QnD2aATynBCEe0HBxB6KbcawKNT8OqX+Rh4J1
 21b9Kcb1g+KBZejdMC0qBZn4o3GnfziktUmiTAASBnX/o07bKv9sA69fXQwd661T
 5vYBVk0ah9cQIqf+FS1oGxWC8UfRwjkmNKbKyEQzcnhfluqTDgHoznFHuvixLYBH
 LtJoqWim+Pn68OpamkI7UsaRLUWCsGLkM3Y1NwePAL/zQdr1PmluFq3M8qf/2pT1
 IzaW+AyL30WBu4zN/rqdhw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcjh2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 17:16:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SGLr8X023271; Wed, 28 May 2025 17:16:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janx58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 17:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWysQvTv01v2tTq7MP29lGg+CCQK8A2BM86hlS+z8EKscNqevQSniWbEzdtaob8whWOEtXvDDA+1iKtupn7gxEtvVa6NemB42+86QaFQf9IVdmoWddQGzh/exmG6+6tpsC3QUtzOq0TY2dBduHBgrEIvlHE8aKwyS5UYerzyI6tOPw604nMRKjp3/AX0M3CyluYBLBZN7ePd8yfLG+Py0tCYAzHuRdeAfQEChn4ujCEXETJn5HObX9mzvn8Wg+5K1+I5q/YvY4Gmedz3ByBefCvt2M6VPa5r/JyXTjTssu2WJqaZS4xFCcX1kmwJwKW+L9WX4vlL0eb4fFx46xsmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENhuhcD07eINT3U0X+2JiL2aohBWFxzXBn2iVCwoGiw=;
 b=Yv+PIirRi3d1Ba4JcqV82LeJglYrWInDZi/y/NtSn1u8nvZLh6PXpuuNkIUaqmRfQtiBstRXMJsUT4+V/CDH4wNZ7d7AA+Ziv97H0NBw7TZgdeUQrsTEkM1kzwX7CzsAG5FVFSp0qxRDKL3BYzUKff29MhjVs4fNfHqOIMXl0ClvTcbcTk1Ru6AeK4KDLGaFchU5oIWtDw0xPzGi80d9xrjnzeZGf7TQU49A/pcuclNYNwA5o0iZvg97mBTmnZRacVHrTqEWdxOehsm8qMn4a/Fix/KL6KRFwN/ASRuWuJ6qbjEaogzJ5vfDqeP/2I0v1uLD2NpVClrzGn2FTlX/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENhuhcD07eINT3U0X+2JiL2aohBWFxzXBn2iVCwoGiw=;
 b=N0sfXq1RfFgjOB4d1Ns7EtLuDeUgK0HKnu+nLgoAlNXlg8w8t0o2YK6K6xwfJgFjNz7sPbkI/3oSE8WKuWWjJAtigkzm7TLKmWkFazHGBzudGoTBE7Hy4KwprfCcGdBE54eTccQw3eR0YoJ8lqokun9oFAuLirJvzzyoWvBdPFI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB5994.namprd10.prod.outlook.com (2603:10b6:208:3ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Wed, 28 May
 2025 17:16:33 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 28 May 2025
 17:16:33 +0000
Message-ID: <4b6d6c6e-5e57-455d-95b6-05a0fe562241@oracle.com>
Date: Wed, 28 May 2025 13:16:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] vfio: enable per-IRQ MSI-X masking
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-7-john.levon@nutanix.com>
 <19e2b44d-0dcc-424a-904d-a7519e25d93e@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <19e2b44d-0dcc-424a-904d-a7519e25d93e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:36e::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b027a6-335c-4f9e-cfa4-08dd9e0b64eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU1xMUJIaDJWaEtPNFUvUkRaU0VHK1Z5RXNxbGdoSWYwK3MzUG5BYzBCS3Z0?=
 =?utf-8?B?MkM1LytPOXJHOU53ZGhnbGZwYzJKRVJsVStlSi9GMy8xWmZ3RVhSNWRFV2dz?=
 =?utf-8?B?QmwvbFJGZTV4WElBcnlvODE0VjdvZEhqbnl3TXF0ODQ5TjhHUUhqNklsdXJK?=
 =?utf-8?B?T090ci9KVVEzTmRBTFlTSUFMbzJsTEFLOXk4b2V4eWF3WmQ4ZUpFR1BUWHFm?=
 =?utf-8?B?bHZsZ2YxazVrNUREWFZseTZjdUFObEtIWGVkVDBVM2NtQktoeHpnRzdsaEU0?=
 =?utf-8?B?NW9NRW5Uc2ViOWcxRitUZWYzSmJLd2t3VWNYQmNpcUptWWowWkhXUnVVcXR0?=
 =?utf-8?B?V2VDbWZQbXhuNnlIVTlETHIxZU9IOERNbTBJYlo5azRCdzZ0dUIvZEpJdE5N?=
 =?utf-8?B?b2t6TVlhdUVudmlKU1VVZXRORm8xYUZHTThrRTNHTCs1bkhLd01OT2g1SVdH?=
 =?utf-8?B?UDYvZ2ZBdUpEakdlR205ejJXODJPNlZvdGJmb1QxcUZZS2Q0ZllEcU5MQVFT?=
 =?utf-8?B?TjRjT0hTZEx3N1JQWVBaWUJsSFl2endTVStaaUdMSHNscDZVUTFIZEZuZGtz?=
 =?utf-8?B?ZG1OSldIMzh2a251V01zcUpvY0hIeGtDR0hEbDJjQjRpWDBUNEU2OTE1SnBI?=
 =?utf-8?B?aGIwREFDY0JTaStWdU52U2UzM0wrSWhzSFVGalN4Snl3M0FxUGlTRXpYTVFH?=
 =?utf-8?B?NlpGeDYxdVA2RkJPM1l4cjhlRHozemFub1VDTDNjb2lzUEMyZGZpaHRWUDJO?=
 =?utf-8?B?d0U4aVB0VXUrMkVFL1JKOVR6WnZRYVF0TVBXcEtDZkpGNkJWNUhBZmhvOEZS?=
 =?utf-8?B?QnJ5a2o0aHNHNFdmK1JwRlN5R3U4dk9ObWlRMVo0aGNka2lwb245LzdiZmFk?=
 =?utf-8?B?OXdjaUdsaUNMd3RwV3RiV2VodWNURzJ4d0pCV2pqWGxYSTFtWTRYamVzMGRO?=
 =?utf-8?B?aTNXTmowUCtzUDduMWJjeDVpUXlBK3RueFQxUStGRFA4NU9JNWxjQ3NoeU9W?=
 =?utf-8?B?aWxXZjFKby9naFZwQWc1bEJGT3EzRk5maGs5Y0pCMURaMGI1MG5MRDRPZndL?=
 =?utf-8?B?VFl6clhJcy9aTW9pcVlmaEp1SVVrbjRCNi9XZmpjNlk2aTZRT0JrVVZHMlNN?=
 =?utf-8?B?SzFvWmZNQjNlZDErQWxqUDA0Y3N0N3hML1lTT2hpalRYQThiOGZmOG1RaU1E?=
 =?utf-8?B?azczZCtxOUtQVVd5SWcwYzV1UU1oQUpsN2NVRDUyam82akxYM25ESlloekRs?=
 =?utf-8?B?dWVidUlvTDFzSHVsN1cvaWNlUlNHVDJqV2tpT1lGU2MyVC9KdGNFckk1M0hu?=
 =?utf-8?B?ZDZDei9RbnVRR05reFdhN2doOGRTTmY3cEVUa1czSmJTYlRJUFN1WjdUVk1V?=
 =?utf-8?B?V2EyRXNMdG00bGE5VVIvcGE4MWxkWG9HclFxQVdqaHMwZExmTVNyeitsY1l4?=
 =?utf-8?B?T010NHJQM21FWkVXa1NYN21FM0kzYytoeDNhbEc0YXIzVW53SU1nSzJwRVAv?=
 =?utf-8?B?dnhwYXpOT1lZM3cxWVh0aittNERMQXNpTW5WbE5GbjA4cU9KckNWSnFET0tt?=
 =?utf-8?B?M2dHWjFaOWlSTG5OQTBoRDQ0N1lncDd4UG13UTRkU2NsQ2tQTEVRTEVSNWhT?=
 =?utf-8?B?bFpjak5LdnlUcytUM0l1Tk9OU1JFR3ZtUUYzVXMrRDJCL29sWmxDV2tqUk9u?=
 =?utf-8?B?a21JQWk2a2g0VUZ2MDBXRGFuREFBRDdmVlVIdSs4US9zT0c1SnRnVEJGUDZ1?=
 =?utf-8?B?VEVnU0VIZmh0bTVmakkrMXRJTVRYTjhERTY4NHliZEs2QWxLdUxhYmZpVUNC?=
 =?utf-8?B?UlVkSEJ0cEtSZjR5a2ZjaHBicDNlUHZ6NG5qRGhhNEU5Skk2SENmQlhJQURj?=
 =?utf-8?B?bDcrRjVKMXRUTW9YdmNOWVM3N1BBTDJXSlo4Vlc1Y05Bb0V4TTlVNHp4amUx?=
 =?utf-8?Q?QPTK4TZa5+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHVGZnh4RFYrL0ptL3J6MURlOEdCMEZmL0UwQXlKMDZjdkN3UHJ0b3NyZlRF?=
 =?utf-8?B?MDJDUDVOWlhRbzNBSXpLSzVCRDkrcE9Wd29LZEljTjk1S2IyNE5oWVhKYm1H?=
 =?utf-8?B?MzVIbHdlWWxkQ3VjOGI2RVRkYW5tR0VSSElCNFJKWSs1NjZ4VUdmRG5zU1BJ?=
 =?utf-8?B?SGlUTEVzYXE2TVU5dzJBcldLSXNxVnBLZmNTT0dQUHZVZ0M5SFFUN3lwa0J1?=
 =?utf-8?B?OWYwUGJDQ1YzVmhmRjkwcmZUbmI5aHhqMlNMS3JPSnRtU1dGRDJxbDBXcG9V?=
 =?utf-8?B?QThjZzBNcUxOazhnaVdPQ2pxNzU2aFVpVGp3VlB5M2U5bjhoM3J1eTZHSVBW?=
 =?utf-8?B?QUplTTBtSUVFYy84dnpEMktXemhBMTEvcG9WZHkvcU50aHBXS1lBeDJpTDJW?=
 =?utf-8?B?Q2poRWJsT2pMRDFDM3lPQTlKU25GME5vbUhSeXpHTDIxZG5LaXM5dzNvVzFu?=
 =?utf-8?B?Q1NmanZ2Q0J5ODJyeVFoRnNqNTgzaThBQ2c3bEltN2U0dHNvdGhQYUV1UytL?=
 =?utf-8?B?Ylk4NzBGWFhZdktCN05mQzg1NFB0cXRWVklJMDB2dWxhNDYxU0w0b0g4YUZx?=
 =?utf-8?B?ZU5pZitUY1RFVmlGejBmaGNoUmRHZXNab09ORUxVNGZVdVdIM1NvYjBONkNR?=
 =?utf-8?B?QkUycjdGamcrNXFDbmw2Z2l5Sk1JS2pPcGk4RjhoTmgvL3dIK2RSZFZ2VHhY?=
 =?utf-8?B?ZWdsYlF3TGJxKzNHaGxNS2ZFR2EyWWMrY1RQL2pTTk9VQlgxbnFrdjRMU3Vy?=
 =?utf-8?B?ekZmaUhtTkN6YmtjK3VoK0s3N3VCS3hGdzRzUnJ6cEJlR094UXk3ZytRZ0k4?=
 =?utf-8?B?YUZlTmQzSjBPVVVRTGk2Y3ptdklTSHQ3Wk1uL29YUks0UWl1aFpUbWpsTzRn?=
 =?utf-8?B?SDhpT2M0Z1pFRXppRHVMRWphT0hwbXhGcXU2c2lYSWZsbTVEdGdHS2N0UDBI?=
 =?utf-8?B?OS9XRkQ3dTFxQWN6bjgzMGQyTEV4dzY1VUZ1WXFNcU1lSnhDeEFvQTdNZUoy?=
 =?utf-8?B?cVRmSHJMdWhmTkk2WHpzbjVzeFQyNW9zMUIzaEM1ODdqN01tNDlhM2dySjBw?=
 =?utf-8?B?bGo1Z3RVcC96WHhqaEJkdXJIYXRKVUh4MVVjYVhHNmIzMnVQR28vWkxQTGpi?=
 =?utf-8?B?TkRBVlk3UWJUbGk2V2ZPWHNiTlc3b2hmVVEyNUxQQmFoek5ZR1I2Yy8yWld1?=
 =?utf-8?B?WGp4TmtVZWZ6SnpjbDNLSDVnbVRwU2pOQkR4ZEZ3TitiMEdlV1Y3NTVCMjFs?=
 =?utf-8?B?K29ib0FzTmRld0ttdmZQZzRNcGZjRE5hcTRUbmkyTVlEWjZxV0xkNkphYXFM?=
 =?utf-8?B?UTFkNm5zNnNMQXhrVDdmelFOZGJZMDRXUEUrdUhTaHVKNmpIR1poMnZrNW9K?=
 =?utf-8?B?V1NhREZoRW10YXNFUE9SVEtkRzFOdGtrY21mSlRiaVY2eHgrL2Z5b29MY0Fy?=
 =?utf-8?B?dzVnbTBHaHZkQUE1eFFnL3poZllNdXRJK2hTM2dOOGJOUXFxUlF1ZUN0MjVY?=
 =?utf-8?B?amd2dmlyRjZXZXl6Q1R4cFdQMnlLL3pGQmFHUDNibGlWNGpPVjBySzJLSHpp?=
 =?utf-8?B?eEgyYlFGVU51VjdIU3JRZWptSk16bndxL3BqbVNsTVpyZXRWODJabkNuRWVz?=
 =?utf-8?B?NDVrQUlCYld4U0xFNnBJcUNpMFF3NkQ2SVllLzJ0Y2dRMUVqNW9QbzZHT01V?=
 =?utf-8?B?VjR5VkNRWTRHZ0RISnZzbEhXL0ppTklsRTd6ZmxnTElIK3FnZFhYUG0xeFow?=
 =?utf-8?B?NVV4Yll3bVdxSEZsNnVaczVvWjROT0lSb0svK2dkcVVlT3M1eGVhM3lUMXNn?=
 =?utf-8?B?MXZ5eVlvWitWT0hUK2JqNjhDQW9HSWZiemJia0JjdGZlRVQ4czBlMVR1S0Zr?=
 =?utf-8?B?YWxTUURIV3VJQ3JERlUvL3lnOXBJemw0aURDTVk2YnBUVkNvTnZTSDI1RHNu?=
 =?utf-8?B?YzhBSGN1UUh5allqODM3Qk55akIrcGtPeDV3RGwyekRrMkpVOEFkaWsyS0lz?=
 =?utf-8?B?ZVozUG56T3hXU3JqRXVUQmcvUHpYQS9sWS9ZeU1uRTdKYmhxM1Jxc3JncWhn?=
 =?utf-8?B?TUZnZ3k0c2Y0YnpQRVRxaFFNSHREM3NCREpFY1l5d3NzWUpJSC9JK3JvVmZO?=
 =?utf-8?B?d3lUZXNNYnEvVlg5WDF4YjdYdmJTZEdCcE9qYWhpKzZJN2ZYVi8rZjNiU0pu?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +oSF2ER42hcCXJ3ss6iRktuWCpj46HtcwEko0Hi5U0xU/tYqFoGGAHUAx3da4Ca6wcMT4vxd5CECy5IYYeRsBmxLH+JSidh65eNqHmnpWY59YeXh04EiZGTdyB9K4WZc0+w+LpZYZlLm1TuCCjaZidLEUu6UxovJt00pI0JQF1RMphuG+fJCkFThFOFJjFITAo/ql/UsKAkkcvd2nuucMBNN9OvEaf0oD/kISoOZ2EHHbqQVcMbvUIr0IedaR63rajtQV11gtfg1qAXXXIuQylRVr/no++29lw5ggRLjytM7tog9KbI5KtBe8Q73sNJ+5kL2PxZur+gP1vqaDxqvI9cMjw2cMqZGjpIu2vIbV4ScFrFA68bq6LPbyYAoE1nhMJe8iDJhimFkdjvrGKpSuD2pfit5oJ0UAhmsEB5I0IIqdidswR3wiV7Vh+TXFTCd+/hIe9Bp7PEJPCgIkBQEoPxAD196nqeFh+qafspOtBrw/y0QpF7ZJSeGar5EHvOPLI0uY8ZaVdG9LGvvxtz2gLYYyiCOYIe4I6356WhHERFYIiXUgaF0CI6U/Tzca6g5JlI0HIOSNnErb817ry1WdGAYoBf4wHHgJ6cCWSNPAc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b027a6-335c-4f9e-cfa4-08dd9e0b64eb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:16:33.4153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7d9tjqPdeAIPA0QTLdfZbV6NCfTt3jp62vlvQBRhx59XHAZuFPieLB8k8uu6uSwhxL2qlE/h23elugMdU5SM0UMBXbU2WC207EAnnOPPGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280149
X-Proofpoint-GUID: xZ1QVIa4_S8XwktFt7TKHz5DiScHVVQZ
X-Proofpoint-ORIG-GUID: xZ1QVIa4_S8XwktFt7TKHz5DiScHVVQZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0OSBTYWx0ZWRfX8MdB9/ksbsHH
 VXU0NuGPqDuFsXS/FHHoO+dOVKl3ftyVbIi+/LJNUJt/vvFkRD1EDbDMbBzmLVdQf6f87NCzk0Z
 bpMRokn518I+XDab1Cbn+pbEaNztZMxvIgeqgHOk4yZRd+lXGAohdzZ56FeNeNykr+eudkn3N6G
 CiBrYkSXmNuGy7mmQSA7wtiQp2XAUUTPdqGwX4M0gFuobQfmkLCTQkHe5dDySY28DdJj0rB+GME
 LWZyhPyM/11hfXepFE+b6NSRgjPCyYgKnA6rc8c6chRHIc9TZyyhbaspkY0m4bmTyeUyW7MLFSb
 KHbmnIBBFPgqLvQLOHS6unHbDbma6OY4kah5oJPnN+8mpuj7fY+En1Jsj/jSJhsJYfF2U1Qe+Np
 IgHdZJcmi7OIzzMvI8y7Nae1OcUXoT5pquyb5DyoK2tQvrNIfPFXv/LcUf+/lEk1dJPa1gyF
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=683744f5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=b05e_kYNWjHwrR9JnMEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:14714
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

On 5/21/2025 3:29 AM, Cédric Le Goater wrote:
> +Sẗeven
> 
> On 5/20/25 17:03, John Levon wrote:
>> If VFIO_IRQ_INFO_MASKABLE is set for VFIO_PCI_MSIX_IRQ_INDEX, record
>> this in ->can_mask_msix, and use it to individually mask MSI-X
>> interrupts as needed.
>>
>> Originally-by: John Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: John Levon <john.levon@nutanix.com>
> 
> This one conflicts with the "live update" series. We will address it later.

AFAICT there is only a trivial conflict versus my patch

   vfio/pci: vfio_vector_init
   https://lore.kernel.org/qemu-devel/1747063973-124548-17-git-send-email-steven.sistare@oracle.com/

because I extract a handful of lines from vfio_msix_vector_do_use into a
subroutine, at the same place vfio-user has added a local variable new_vec,
but the new code will simply be:

vfio_msix_vector_do_use
     if (!vector->use) {
         new_vec = true;
         vfio_pci_vector_init(vdev, nr);
     }

Also, for now I am assuming that if vfio-user is being used, then I will add
a CPR blocker.  Thus I do not have to account for per-IRQ masking in the
cpr load path, for now.

- Steve

>> ---
>>   hw/vfio/pci.h                 |  1 +
>>   include/hw/vfio/vfio-device.h |  2 ++
>>   hw/vfio/device.c              | 26 +++++++++++++++++++
>>   hw/vfio/pci.c                 | 47 ++++++++++++++++++++++++++++++-----
>>   4 files changed, 70 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 61fa385ddb..43c2d72b84 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -191,6 +191,7 @@ struct VFIOPCIDevice {
>>       bool defer_kvm_irq_routing;
>>       bool clear_parent_atomics_on_exit;
>>       bool skip_vsc_check;
>> +    bool can_mask_msix;
>>       VFIODisplay *dpy;
>>       Notifier irqchip_change_notifier;
>>   };
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>> index 8bcb3c19f6..923f9cd116 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -133,7 +133,9 @@ struct VFIODeviceOps {
>>       (ret < 0 ? strerror(-ret) : "short write")
>>   void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
>> +void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq);
>>   void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
>> +void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq);
>>   void vfio_device_irq_mask(VFIODevice *vbasedev, int index);
>>   bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex,
>>                                      int action, int fd, Error **errp);
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 9fba2c7272..d0068086ae 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -85,6 +85,19 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
>>       vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>>   }
>> +void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq)
>> +{
>> +    struct vfio_irq_set irq_set = {
>> +        .argsz = sizeof(irq_set),
>> +        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
>> +        .index = index,
>> +        .start = irq,
>> +        .count = 1,
>> +    };
>> +
>> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>> +}
>> +
>>   void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
>>   {
>>       struct vfio_irq_set irq_set = {
>> @@ -98,6 +111,19 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
>>       vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>>   }
>> +void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq)
>> +{
>> +    struct vfio_irq_set irq_set = {
>> +        .argsz = sizeof(irq_set),
>> +        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
>> +        .index = index,
>> +        .start = irq,
>> +        .count = 1,
>> +    };
>> +
>> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>> +}
>> +
>>   void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
>>   {
>>       struct vfio_irq_set irq_set = {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 5159198bdb..ef38b4692a 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -535,6 +535,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>   {
>>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>>       VFIOMSIVector *vector;
>> +    bool new_vec = false;
>>       int ret;
>>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>> @@ -549,6 +550,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>               error_report("vfio: Error: event_notifier_init failed");
>>           }
>>           vector->use = true;
>> +        new_vec = true;
>>           msix_vector_use(pdev, nr);
>>       }
>> @@ -575,6 +577,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>                   kvm_irqchip_commit_route_changes(&vfio_route_change);
>>                   vfio_connect_kvm_msi_virq(vector);
>>               }
>> +            new_vec = true;
>>           }
>>       }
>> @@ -584,6 +587,9 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>        * in use, so we shutdown and incrementally increase them as needed.
>>        * nr_vectors represents the total number of vectors allocated.
>>        *
>> +     * Otherwise, unmask the vector if the vector is already setup (and we can
>> +     * do so) or send the fd if not.
>> +     *
>>        * When dynamic allocation is supported, let the host only allocate
>>        * and enable a vector when it is in use in guest. nr_vectors represents
>>        * the upper bound of vectors being enabled (but not all of the ranges
>> @@ -594,13 +600,20 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>       }
>>       if (!vdev->defer_kvm_irq_routing) {
>> -        if (vdev->msix->noresize && resizing) {
>> -            vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
>> -            ret = vfio_enable_vectors(vdev, true);
>> -            if (ret) {
>> -                error_report("vfio: failed to enable vectors, %s",
>> -                             strerror(-ret));
>> +        if (resizing) {
>> +            if (vdev->msix->noresize) {
>> +                vfio_device_irq_disable(&vdev->vbasedev,
>> +                                        VFIO_PCI_MSIX_IRQ_INDEX);
>> +                ret = vfio_enable_vectors(vdev, true);
>> +                if (ret) {
>> +                    error_report("vfio: failed to enable vectors, %d", ret);
>> +                }
>> +            } else {
>> +                set_irq_signalling(&vdev->vbasedev, vector, nr);
>>               }
>> +        } else if (vdev->can_mask_msix && !new_vec) {
>> +            vfio_device_irq_unmask_single(&vdev->vbasedev,
>> +                                          VFIO_PCI_MSIX_IRQ_INDEX, nr);
>>           } else {
>>               set_irq_signalling(&vdev->vbasedev, vector, nr);
>>           }
>> @@ -630,6 +643,13 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>       trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
>> +    /* just mask vector if peer supports it */
>> +    if (vdev->can_mask_msix) {
>> +        vfio_device_irq_mask_single(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
>> +                                    nr);
>> +        return;
>> +    }
>> +
>>       /*
>>        * There are still old guests that mask and unmask vectors on every
>>        * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all of
>> @@ -702,6 +722,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>>               error_report("vfio: failed to enable vectors, %s",
>>                            strerror(-ret));
>>           }
>> +    } else if (vdev->can_mask_msix) {
>> +        /*
>> +         * If we can use single irq masking, send an invalid fd on vector 0
>> +         * to enable MSI-X without any vectors enabled.
>> +         */
>> +        vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
>> +                                      0, VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
>>       } else {
>>           /*
>>            * Some communication channels between VF & PF or PF & fw rely on the
>> @@ -2842,6 +2869,14 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
>>           }
>>       }
>> +    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
>> +                                   &irq_info);
>> +    if (ret == 0 && (irq_info.flags & VFIO_IRQ_INFO_MASKABLE)) {
>> +        vdev->can_mask_msix = true;
>> +    } else {
>> +        vdev->can_mask_msix = false;
>> +    }
>> +
>>       ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
>>       if (ret) {
>>           /* This can fail for an old kernel or legacy PCI dev */
> 


