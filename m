Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7278C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Yn-00059q-8s; Tue, 10 Jun 2025 13:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP2Yk-00059G-N2
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:14:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP2Yi-0007YU-Ar
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:14:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGMZIC010129;
 Tue, 10 Jun 2025 17:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=aGfNtXctI+NTPEunUsWERdj+RNXb6q4CJpRi3J0Y/wA=; b=
 DHmUFCA9RhISUAkao4lsGUCEnaIg2h/ccwcI7lVTNcAcibVbpzDJG4dvdJLsbP4u
 MDL4/CCh28lsCBuIjzB45kCsu/z6nTOqVfo9EKI6TtwPtlJ+W+5+3LySMapV4/Tx
 2KctDrPYK5MQiLS/AWwxUxeS3nyBd6CR3gi2+3oZqqWYjJX6eMPOKQat2xiQBqPV
 qAIoa5L86VlCqHOehj6UaBrW1arQ0LUvKg5L+xwLvZQQ+YhmA+E/kMln06ybg5VR
 E8Jg1A48yLF2sTNSaimwfBBrHuoXDZMurQCpUPv04bwOfFTlh7xuDE2BwYWr1+9A
 IH4RquCddCFw9j6DzmdrSQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cptq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:14:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AH0tMQ012043; Tue, 10 Jun 2025 17:14:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bva0gbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6V9y+5/socFK65N9voNcUhvVuHVgCNOS9FlKpf4Y6jSTkJ04HO6zN4sc6OWUNdeaoo8MMWm1j6xp4n7++MGsTJR5fkFPSfsgcPjhvk37BoGahOtzNKFNB3lxotVq9UHIC4MklTuZAU5ZwRr01meRnn7ub8zaVq28pd3mGwCoZg7RY1Eu1xGfIwT73wG8vhcwfe6Crwr/nDdd0I7wTHQJ3hjXJmLiWvQfAFzWyeImpTh4P+tt505RWUgMvHDLHcFV1UPvvS75x4OMrSzVHFP2p8DTvE6uPUbZvlFP4y3FgEmTUD5LgUfpCZZ9gKOSs3Rfw8pwMmWtusi9LG0B++BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGfNtXctI+NTPEunUsWERdj+RNXb6q4CJpRi3J0Y/wA=;
 b=sCzMs6SZ8ZSt+O7m+GfjOcw6s/JQL103Y4UJTlPAnG7Snw6tc5a2gS1NqAPyTFioLDspTm1gqfmVEqjEu0LAzGYmtJptgbhUbfI6YTt7c5flFLDN/GTd/teArb3Ule56IVVUSh8ksjnPzbG0qZy1rr+G2SKFq9kOMNlQ0VnEnm8Ga2hUAvggGicihbgP0TduFwRV1fJh2ur3MN52XLKhcmQzfkmvQ9XcHqf40tLqkmHTx4QsyC2xrkJGokz1igVvtA8K5bS94C4u5Iysl7cX/ARuvX5UoY535uAgX47mGktEnggQhX2Dk00Gz2ZcIBnixHjLqf+HmoaKzViamPlKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGfNtXctI+NTPEunUsWERdj+RNXb6q4CJpRi3J0Y/wA=;
 b=SVi4tMOPDmGQ/roh9Mx+tQz2kEnqg0haUshmSXLtzHZ6jX8jxVzgXql3IqAQLqiZ6NBBcuKprHFg+fRNoJ15N0mSWMhBcTrw84t6+c16OhaXsYmZ6x+CeDWPrVdIDaF7wTN6XTwVzC42edNEa5QW061G0ugTlUFjzfaV5s2AJWY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB6834.namprd10.prod.outlook.com (2603:10b6:610:14a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 17:14:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 17:14:40 +0000
Message-ID: <c629f838-9a2c-44b7-b300-b8a6f42e5588@oracle.com>
Date: Tue, 10 Jun 2025 13:14:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
 <20250601150607-mutt-send-email-mst@kernel.org>
 <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
 <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
 <c01c7c19-2422-45c7-9582-09ca37170974@redhat.com>
 <468008fc-a86f-4b90-86c3-1109d68f6fc2@oracle.com>
 <76b58b82-a867-4577-8644-88e419a8d85f@redhat.com>
 <20250610122246-mutt-send-email-mst@kernel.org>
 <6354f3a8-6309-495a-9014-6f5243a7785e@oracle.com>
 <296d0933-3f77-48f4-9096-8bd358aae617@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <296d0933-3f77-48f4-9096-8bd358aae617@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: bf87d603-ff95-4428-74f5-08dda84248fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0xXUEw4MEpDYWs1YTA2MHRVSFZKdDU3UnBHeThZTmVwYkQ3Q2x3cVVYYVNw?=
 =?utf-8?B?R3RLTk9oQWtTejE3RDYycTY5TS9ER1A4dlFNQkVURDUxQW5QWGlrOEFKcHo5?=
 =?utf-8?B?eSsyT0ZuSFQ2LzZJSlNnU1JuMFFUbklVSk5NalRSZlhhUmdISmJ0ZmRZRTNk?=
 =?utf-8?B?clgyWjhSZTM0RXhRSXVZR3NraUFqNWtyTmFXbFY4NmNQUHhGVlBxd1JMcjB4?=
 =?utf-8?B?SmdqaW1ESC9QR2Q3elZWNnJKOURWUTNCOFBZWVJMdWtnajdwNHN1Kzg1VUFy?=
 =?utf-8?B?SDVKalVqcUlIKzFPa2k5dTlUY3BURVZMSVJmVjZXU0NJdk1yT29qaU5qai8x?=
 =?utf-8?B?R09mM1AvVmJPdzVnbS9uNmNPTFhoZHdlTkx0VFlvZXVpUlVJenVOVmdzUTc4?=
 =?utf-8?B?SGtFQUdIOW9OblhoNWZlalEyZEtEVCtWQTZ3cHNTYmRJVUovb1VPZlEzMWZK?=
 =?utf-8?B?cW9YZGhENVlRVWxva0dUaHlNNVhiRFlpbUhEYnp4MkorMGVybCtLdkczaHhv?=
 =?utf-8?B?V2Q4RlllVUZmZTF0UmJGaUx4alk0bXdSMDdEK2pOamlMbTBLUmhxeXR2YnVq?=
 =?utf-8?B?b2dNR3pUb1JYaW5BZFNXTTYvNHlPRzJlMDVPOW8rOHJGN3BMR0MrK05kUFNT?=
 =?utf-8?B?Ri9Ecm1SZkcyTWVPOENWTVlNNEF4YlNhNWNiQ0tpaGRuNXc3c2M0ZEtyT3hJ?=
 =?utf-8?B?Tk1WU2FLTzJuUlFMRzBzaDNoZDZZMTZtOVJFRWJwOHRiYUFNNHVtUjErZ2ZD?=
 =?utf-8?B?VUxUdnNHajJkYTZRaGxBQUZuMTE4MGgwMTNycldoaDVRUWJGTkZuN3JpSi9s?=
 =?utf-8?B?amVnbnZsMHE0S2dJYjgraDNDeUN2L041K2JkS1NOM2NubkpFVEZzdXV0QnE0?=
 =?utf-8?B?djlEUTMrdFRVcDdIUS8wNkZUeGZjc2xGdU5kWlRFR0lIUlZpMEZ5WWZTQlNC?=
 =?utf-8?B?RCtGOVU5VjZXSWw4dUhaWUZKYzJETGxNWkFMaURHZ1h6RFlJS3JMZ2EzZEhT?=
 =?utf-8?B?eEd3VjdKbGZ1d0lvRXZpaHF3aE9yQXhXcnpSNlYzTC9mQW9zNjdKMkZQOEZh?=
 =?utf-8?B?Y0g3T0VLdEtISVZmQjVZZlNPcXNpTG4xNndpRzhsZlNsQzI3cDFPWTk5OXZF?=
 =?utf-8?B?eVpSU01XWm5hblpNdWdzcElXTHRxRDVzazNFcGFVVHZoUkZnSTQwMGVZWHht?=
 =?utf-8?B?clZlZjdZR1grbmZXblA1cENQNEMzWkRRczhFL29WL09yQnNYYmtvc09PdWd4?=
 =?utf-8?B?SFptaEhCQ09kQWVtaGpMZDdjeEF3RWRlSm83SWU5ZUZaOVRxRERSUHhDaTZT?=
 =?utf-8?B?V2wrNFlQUFAzbzg5emYzOHZjYmsyemV0OWJUcW5IWERWN2x3MlJaK1Viei9n?=
 =?utf-8?B?cDB3OHVMRFBrNVl0OWVneXVMRWw5WG9YM2N4V1pnUFh0R253ODVxWlNKek50?=
 =?utf-8?B?WUtwL0FTb2NtS3E1czY3Z3RvSzBjUkFWZlZYcnZ5b0xYZFdpRktVU0NkWkZB?=
 =?utf-8?B?UGpUb09QL2g5ZzViL01TcHA2cGdnZ3R4US9PRnoyM0o0ZFJWN0RYKzVrNlhv?=
 =?utf-8?B?Z2djdWhwT0FZbmU0ZkhMazBqMDgzaEZMdWp2ZU5oMjI5M2ZQdk1VczhVeHBa?=
 =?utf-8?B?RWYwaTgzRGJLUlZnak9ranUyREh4YzhoTDc3WUMxN2l1bm9NZ29TaEl2SU03?=
 =?utf-8?B?bTk0YnZnVTlicUhITkVMSEhXeTNNRkFiMWE3alJzOUJUK1hPOVdzZE1vdFF0?=
 =?utf-8?B?UXlJRlV3UnNjVGltVjErM2hzVzBic2ZPK3QvVEo4cWEzN1FCa2M1cktlaDdv?=
 =?utf-8?B?N2xTVEtSajVZaGk4djNHRVlYWnZKNFdEYXFJWmhCSXdMc0hXYTd4M1pDeXlR?=
 =?utf-8?B?elJsMXBnODFsdWt1OEI1WUFwNVY1UkI3cFR3ek9OdzhyOXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpWM3UzQ01IOEIvNFhWc3pZUmJSOEU5L2F6SjFrc3h3MjRRVkg3ZFhNaCtN?=
 =?utf-8?B?U203MitxdGlqV1YxdlBUVEhUNGxTT2gwSjBQbWFRb2Y0UTdSUzNEMjNKVUUw?=
 =?utf-8?B?M1AvZlhzVW9BS2ZNckt6d00xR2ExWGFaYTlCSnVneHFab3dsdVpUNFk2ZHlv?=
 =?utf-8?B?VWxxeHhYWjNDMzA1SkFNUFkwVm9hekdrY3hmUmVVbzlGM2hZTGpmLzNTQ0JB?=
 =?utf-8?B?a1l4NURNQkhtcmJrMENVemV5V2dCWDFWOVdxVTFGWWxkeVZmb3JqYU1JWHB6?=
 =?utf-8?B?MldhZnJMWjhoZC83Rjd4YUxlQ24xV3RtTk1QdTNiWFBiVmpRak5KdUluS1cv?=
 =?utf-8?B?VmF6ZlJaSFk0NlBvZVA4NUQrR3RDZWlBODE5RmE1M3Y5bjJsdlNzSVRJYUNQ?=
 =?utf-8?B?dG4zTUt6aVJnNzc1UExuOHJIRnhDanZPN0lrdWs5V256Slo5YW5vVXdicHNk?=
 =?utf-8?B?T0s0Q0NheDVXSkxudXB5TitTVllEbTJCSDFQU1RBZ0FXbjNhRWlWeFdYS1Mw?=
 =?utf-8?B?RVhaOXhGZkxGNUNOZEZ5cmJSaEFzUklmU2N2WHJYSTZKZUVjbmludWNKYzZl?=
 =?utf-8?B?eE80bW9nVzhtMTFQUWtWb2dJRU11VTVmeW53R1NzRlVJMStZcXJGOUI1eUVL?=
 =?utf-8?B?bkpENU9WdkhkczhXY3QyU0JkMGd1eTQ3THBBUk5BK0RqbEs1Um9iTzNmSUZn?=
 =?utf-8?B?V2trSmZuVVNnaVpOTU1SeEVwNHhxUFJZN2lremNaVkZCTlEwNVQ0dGJhM3BH?=
 =?utf-8?B?K2FmTDVML2wxeXM0bE5JYWFSeEVmUjlmdnFDemEwUml0M3dJR0R4VHljRU56?=
 =?utf-8?B?bFBwd3JKdXhiRWZkSWJ6djdDMU1ocStYR2xxN0xSanBLU1F4bSsxYURvSUV4?=
 =?utf-8?B?WC9lYTYyQWxiWFhHMnVvbEZLU0RSb1NJRXB1bGd3TjRXQzROTWRualE0TmNW?=
 =?utf-8?B?bXZTMGQyRnFSWjRoUzU1RGNoRW5yT0JCUStXbHVRcEptTUc0TVdqNXJvRWtR?=
 =?utf-8?B?YTVKbDFHaUlxeUJkNTRrck5KR05PMXFhMnhEeERoa3hTcWJDZTNqWnZRR1I0?=
 =?utf-8?B?Y0YzbU9EcVVXdGtiOXFMQWhjNUw2dVpPOEZWa3ZHVy9meDRtTmFvYkQ0aTVM?=
 =?utf-8?B?LzFSS3ZzdUdXSGFQZ1laUlFDVHp1VXFxZFFqenQyRllzVUxHRkhNVVFCTGR4?=
 =?utf-8?B?RlpIVVpPaEFoQnlNUE1BaGQ1dytmM0w3NFhYMm85MUVWbTF6emduNEdkK2ov?=
 =?utf-8?B?a0JUbGNZZUIzVWhLdm93SGNQOFEvZzZzRmxvL3ZIUWpaOGtPRzE1UldRZXhn?=
 =?utf-8?B?bGo2QTV4RUVFQWZvR0ZmeXhXUE9uSUFObjd3N05leEtjZ0YySXBTajRmQjdG?=
 =?utf-8?B?OFczVjF0Zm04bEJvSmtRaEgyNEU5Z0l0T29xY2xEMEVTeXBPRE00MnZMMHQw?=
 =?utf-8?B?UEwxeVZUVHg1aTFzVWRUM0FhTW50YjU0QUZ0VEtjbjNMVmZXanYwTy9uTzgy?=
 =?utf-8?B?MFcydjFFSVRubHRGbzgvVWlZTm03K01md3lJcU9sTkNBM0toQTQzUW1BUExH?=
 =?utf-8?B?TjJiN2pYQ053LzVqZHpZKzlNRVBJZHBzNm5XazdDaEJOT2tWT00xcEJDTVFM?=
 =?utf-8?B?ejRlSzVSbTlrenpvUGk3WXBLSDlYdFZTQWxaVzg4R0xHdEp0S1AvZktPOXpO?=
 =?utf-8?B?bTZpOS9jSEt6RFhJZUxZbDQ2V21mZG1tbkZJaUo4KytCSXhjeEZ3VlJOYzhS?=
 =?utf-8?B?bFlETG5od0JxNU9Da0V3Z2RiSWZ6ckFFeWFrNHVHWHVaTjUvZXVNNy9CUmhH?=
 =?utf-8?B?SjZjeDdYTmptS3B5NFhQWWdTcnBGTFM2TEhPTGYvM2VkVjY5OGwrZzFMdE1q?=
 =?utf-8?B?QVFlVnBrd2xFNER0ZVB3OXhmZyt0dU9yTFVmclBOYkpsUFdmSlhDU2MwU0k1?=
 =?utf-8?B?b1BxbnAwQVZycFNVb2pPanJwZFE0UXJJT3AvZXZsMEFkcnpTaUJzM2lKWGhN?=
 =?utf-8?B?SDZmcGJ0dDV3UHhhSkNWRHhZSU1OM0s4SzRNMHNMUHg5QXFzNWFUK2JLVWpG?=
 =?utf-8?B?dXJzZGZtVGp6a2hLQ3ZXU1B6R0VscnN5TlNDN3Fvb3M2K2FWd0xzbGlSbVZo?=
 =?utf-8?B?Zk1zb3N0ZTk1QzEwY1ZVVWk4c3YyMmVSNVExbFdUWEs5NGQxZU00M0k1dkdr?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x686n5O+FtYYhhx922VBTde+L4ZbRgETK5OYHGv0vuMhQqoDVrLp52ZO7c5Jtj8kqhNrWE4SKN/jDPQoB5a+t6Ky6gaR5SYQwijMr2N6mBAQx0Ka6j49i13iXZKesaogJnVMPSfnHT0cvFTDQbZcOhhIkhzlk57zG7IBXKIjDjoKeIYTOhKLduKgOFnXO7TaeD77EBmW2S8lGJGwEpDIC73yBKJR+tj1RqmibOpjfpQuYJ0KyeErXHQ3Czk4UNP+rh9IxrPOuLuudLayxSWUSwKBE9xPJsNJ3zLxsKxAwgQCKFHAAVjQ4WfR/SIZXteNHmHjgeID0ppXexKVrNiv7+KL0bl6x2Po7Xw+4+HU6n1/PtWxNEwI4BeZrCA3RUvHJNxC7VTOlt+ccp4SFf+elKFA7/FkFDGkgcOFhVxSnXufpwwWD5EG5yIsseNgyonUnViqB15+RFfRgKagetPOMhrfcFl95uoSf9+TeP6yN1gt6YkiuWcct/uOZZAv4Z5OawR1HmJioUomX+T5wEyMsnxcbUCyOWg1LWaIWDbHxtdRXHURUv4cLJ5tm9fDkxgVwSi5qm3KWnFGs+ycU7TxBu2lUahZMivibuIdNPa5HMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf87d603-ff95-4428-74f5-08dda84248fa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 17:14:40.3216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kir3ll+lVxVXViKIw5pw5eQsiaEdmjOoFytVnc31ABVwvtKa6KUjb4a76CAPCobqcj39ba0wv3xJzKCgAxKDU0KGLFsaDV2+IiXMPa1h4cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100139
X-Proofpoint-GUID: TqeUElwqkQDia9Qbc_CxmM04AIV5S6SM
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68486804 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=AFZqATWQ6Hz4b8-6wZYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzOSBTYWx0ZWRfX6yTVLikjkWi6
 xQc7a7ez+rjaxVmaneNdPxB+XudEpr3P3YsBgcFXNKvudDN3mCEbFmm8ICNIBfn5GpIqdxQOFgz
 FGqZJNc12gPRNJ+/QI/aD8HLySJHJa1sXigs/LK1g5fZgMh/qY0+NzXHqyOUXOT/UpsJ7i2OfdN
 hUd0jQQhX7s5t14hewtdcDT4pzPUkq/ofiq8MHgGyAAJjHRGziKwJ2Mpv6ubQgTQq+3/0UIWzMC
 9bR2gpHVHXxAz91/E2Y/iTHFqsSObFoFW1L4MkWzXVcMhnbmDa0WQrt0TJvW+UQoUJr2r32PH0z
 gG9bfTiwMtIE8d43vFNekMIqF+aXyVI8jih9iAYvV3b33ieJcLXJb4np9rvQi2e0lGFhjyU1Hjo
 XXFxjU03Z2aBk2NcLy9VphqYEPQP+Q9f9Jx+7++2k2ixM4bYvlDJj0dIBuw+inCz16hhGmFw
X-Proofpoint-ORIG-GUID: TqeUElwqkQDia9Qbc_CxmM04AIV5S6SM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/10/2025 1:11 PM, Cédric Le Goater wrote:
> On 6/10/25 19:05, Steven Sistare wrote:
>> On 6/10/2025 12:31 PM, Michael S. Tsirkin wrote:
>>> On Wed, Jun 04, 2025 at 03:48:40PM +0200, Cédric Le Goater wrote:
>>>>> I don't see any advantage to making this a class attribute.  I looked for examples
>>>>> of using such attributes for vfio to configure pci, and found very little.  It
>>>>> sounds like overkill since vfio already sets and gets PCIDevice members directly
>>>>> in many places.
>>>>>
>>>>> I defined skip_reset_on_cpr based on this existing example:
>>>>>
>>>>> vfio_instance_init()
>>>>>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS
>>>>
>>>> pci_dev->cap_present can be modified at realize time. skip_reset_on_cpr
>>>> is a constant, for which a class attribute are more appropriate.
>>>> This is minor.
>>>>
>>>> Michael,
>>>>
>>>>    Are you ok with the 'skip_reset_on_cpr' bool ?
>>>
>>> Generally yes, but maybe cap_present bit is even cleaner?
>>> vfio already pokes at it, and we have history of encoding
>>> quirks there, see QEMU_PCIE_LNKSTA_DLLLA_BITNR for example.
>>
>> Sure, I can send a new version based on a cap_present bit QEMU_PCI_SKIP_RESET_ON_CPR.
> 
> Please send an update of patch "pci: skip reset during cpr" in the v5 series.
> Hopefully it will apply cleanly.

Please clarify: do you want me to send a delta that applies on top of the
old patch, or send a new version of the old patch?

- Steve


