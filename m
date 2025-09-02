Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E894CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 15:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utT1l-0002zo-46; Tue, 02 Sep 2025 11:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1utT1h-0002yY-4l
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:34:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1utT1a-0005Cj-QA
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:34:28 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Dfqu0012885;
 Tue, 2 Sep 2025 15:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pVX1A3h1dO/D30qbs4C2IcYl3tjrpW12CkSFzz6Tnw8=; b=
 OIG5Hn2ACTpVMc5VWrhffteozss2f8Kxtdl7BSp3rJWTdVluAvMi5cCmnnLd/Kut
 bX6HychrAGb0PophLA3Jg1pcaROM591Brq+rTGN7uCET81Z8th3mVOUsRhT3X4PE
 Z0ByFlSCU/VfjF/0LRXtf1SdInlYs4UxX/NxWCIZVP51jqvIkGt9yscatQOiO1j6
 AU707dyYWqrb8s1P3oWZrMS1mx2hXx+V29kza9UloadYFccbF2aW5pZQO8mJCuyr
 YHIhlwzO9pPk4izee5iYecSCF2LM6/sYRCSy+lLTZa/d+K1LyiPiLghL30ffmT5W
 M0Xq3+EkPsqduTZXWILLkA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnccf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Sep 2025 15:34:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 582F4oIW040757; Tue, 2 Sep 2025 15:34:11 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48uqr90q2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Sep 2025 15:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dryj7DGkl3z/sCkpWY4uxH9rZjSqAgNKno4gbEHji/HfDwfpNu7Eyf75CmSQZ9EE8DY7iss2eA14nWqygDm5kTcsEBUdWXGwEcFbvjSbFl6FMhz6692URjzPS6gCYO7yN5p87UgzWdIAOrwgHgrnEZ4A4DqkuBAORG+Q4/3Iqp7wIZyVe96qgp5fXgXTCYmEKWcJp2t+BOAoL6/aTEYbXbh2F9H4n7Vm+mr6CFr9KtFbWi+ypdrVapAruKvmO2EL1gDldftTe0ocy8yUrxnAAx6z+4yxVPv9m/nmzM/28LOWQ5yvdewcrP8zJnj+YwMWzXmtTiB0qs8KFCtlVsohgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVX1A3h1dO/D30qbs4C2IcYl3tjrpW12CkSFzz6Tnw8=;
 b=l+yln4f5inJ9AFwWH6T6ix0lVkSXpXLVUPI6qDjekNSOdlN/hFSx/HxlBkhwKN9iwC+qMNStd8RVIoz7V628Fs4jyzxXWR8wAmYH8feicAGay8Ceqnb32J12SrUSbtAAdV2dXwIZXIlyk1ypeQRk9pmBwp8UciWnww7seG8bI5mbOXPWMLaw5EJnNDolhorXQTHFDtziK6sG2nz64TJw+3FkmTriou7EJJptRWxNd3P46U6Z++0Ah7+dJt3qJV/+voLfnO+JHroy4mmyjAp8bLGGCOS7PqFTRIKo4VAjdWakjcMD6Kclp15GufvJPubDYoVclChX4LsAS79Cdi3X1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVX1A3h1dO/D30qbs4C2IcYl3tjrpW12CkSFzz6Tnw8=;
 b=iYI3TwkI6GGJmugOZkCjEnf/xxu1eNHyzz5QdwMJO8LoxGFRtmyekon1w6HzOshL3DjbNOUlaAy/tZYoqoLwH69CbUtGdrB44/u+fR0C2cJrP3Z/H11IiE6hi4Wtmps/7LUL5F0p/eKXqWOaOhGuVBZIUKpPF6/oiOkS84tHAVI=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by DS7PR10MB7373.namprd10.prod.outlook.com (2603:10b6:8:ef::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 15:34:03 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:34:03 +0000
Message-ID: <ccd353ef-26c7-4590-94ae-d8f6193c2805@oracle.com>
Date: Tue, 2 Sep 2025 11:33:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Chaney, Ben" <bchaney@akamai.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 qemu-devel@nongnu.org
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru>
 <f3cb36ee-e677-4377-9e4d-652085b205aa@oracle.com>
 <3c939b30-2479-4bdd-8fa8-1dcd7adaada5@oracle.com>
 <2e6a35a4-b9b6-444c-90d7-1c748ad1b7d0@yandex-team.ru>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <2e6a35a4-b9b6-444c-90d7-1c748ad1b7d0@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|DS7PR10MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 050fc78a-62e2-434d-a4ae-08ddea362575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTloTkd1bCt1QnkrWnVPNUxOcC95STJXMThZcGpSb3JOamJ3N09yZXh6QnJ2?=
 =?utf-8?B?UGJ3bnZBcU45UXhVaFZYS0ZrUmxqbnZlYmZRUHJEMUFyL1M3YjYzbVgzbkIw?=
 =?utf-8?B?UEsySWw2cDBTMmo2MEhwa01iVmFIZjlwWW5oTTdJOUpxUENCRzhuSGRUeVBL?=
 =?utf-8?B?NThaa1kya0hhNVZqQk0rNG03NVFwUnNEUVpqTFJ4RjNMM2x6ZW42SnNQU1k5?=
 =?utf-8?B?NjdQZk9nd1BxVVJHRjNRMXJBaGdJMHRySTV4UW94djhwczhlaDZ2anl0Y3pF?=
 =?utf-8?B?S1UvR0hramFJVnRmclVHZ21scUphL0FiUG16b0h6aURWUGVkTnoyd05hVFUr?=
 =?utf-8?B?d0VSUmdyV3hxVjg4ejN4dnFGcFdwaGVwOVpuOFdhRU5FaEEvMklzYWFybnAy?=
 =?utf-8?B?ZHA4eFphdHJOL0QvUTZlaHN4TmhhZkwrVFQxNVRtaG5adzRITkR3VFlOL1g0?=
 =?utf-8?B?ZDhEaGVtSXNyZVpBN3h1ampmOVdraWpUMFhoVG1qRDQ1K21zWFFLZXkreHFS?=
 =?utf-8?B?RzNicXMzRG1ISEF0NEdCTmQ2SnY2aWJlN3kxS3VaUWZhd2JsNVFLT2R0ME5F?=
 =?utf-8?B?SE4vemxtYWk1aG1GZ09NYjdabTRFV2tlRzFzUnROaGFKc0tZVkpaRTJQSlBq?=
 =?utf-8?B?M0FIRVZyazg5MEJRczFsWFlCUjNUUDZhNFdKUzczZFNOejdtdWp6V1kwWlhH?=
 =?utf-8?B?RCt5cjB0dEg2MkhTNzN4ZnhEUnpROWhydGJGZjVwU2dGbE9xU29jbWVYcS9p?=
 =?utf-8?B?dXdGcktOM1k3TmU4WDk4V2FSdUtIOU90Y21NbHZwQmNPem9RQWRWbGM5YjU0?=
 =?utf-8?B?VExjdi83UmY3dlBibC8vS0kyZDlpdkhWSWQzY1VCdlVHOUhJcHVrczdCTW9T?=
 =?utf-8?B?WDZXd1QwUG5MTUlsYUtkLzcxWURMSlRVUXg2UGVFUDRtTGNvS3I1ekFTOFcw?=
 =?utf-8?B?YmZFZDBDT2FiaEVGeEFDS3RBM29QMjh6T29EVlMwTzdCeVdjM1lyZy9IcGph?=
 =?utf-8?B?Q1NWdTR5cEtjdFZ0RUk3RWlpK0VDZC9aNUFsVlZYRUI2WnRwOEJMRXE2UXJZ?=
 =?utf-8?B?UFQxbnlFaWlKcmJiNno2VkhBbFBNTVBDaWg4SWM5TVVDL3FDZHNvc0hueTd2?=
 =?utf-8?B?c0lkRXo5TnZHM280Q2xNRk9HVS9XU0lNMmVwSWZGdE9zWnBKT2NiemxseXMz?=
 =?utf-8?B?ZXA1YnZsY0VBVW4rVkhkdFpUUzRNd2RUNzdyaDhJMWp6ZktPcm4rek9vTWxX?=
 =?utf-8?B?MVdyNzMzTTRrSVNkQWIwQU9vTUVZNDROeUdRRlZkenM2OVVoLzU3NmJlK3RT?=
 =?utf-8?B?dHQxUlQ0QmR5cVpITWJqd3FTb1Mrd2Q4YVkzRHptZUVTNmllZUNPbUJXSm41?=
 =?utf-8?B?SW9MMUV0UFJhRXhkZHMxWEdMYS9RQndDWWdLc2FxaFdzL1FaR3BMZWtUcGJZ?=
 =?utf-8?B?SEYzNUhCRWJDR2VkT25xcisveTB1OTBVZExGeVhxU2U2ZzFNNE9ja3pqWUI3?=
 =?utf-8?B?TzdLU0hGc2huVVdxTEM1SkRJb1BHb2JnSmFzWS82ZW1wbzMwQUN6SVJ6UEs0?=
 =?utf-8?B?UGlQVXp3STI5WHVVOXZUZy8wRlhXRTBLakN3b1oyWFh3RW00eWJtVjBuaW5U?=
 =?utf-8?B?SERON3g0bmk4ck1hc0FqbUtqZTdJalhGOXBsSlNqeVBmYXFBelQweDhhTjhw?=
 =?utf-8?B?Qm1pVU04bERWTVpYVjBUdFBoV2dPekRkM0dqRTFubWRKaUhPalF5TTJFbFhr?=
 =?utf-8?B?MUtJTFNFU2tLeXpUTzBFK3UyWGcwdHhQbGh0Qld6V3pYSmNXRCt4R0ZyNVlU?=
 =?utf-8?B?eVgwaE52VXFHdUErRm9sWW54dDdvd1J5K1dBbllhMmU3RkF0TkVqdkRSenpX?=
 =?utf-8?B?RXJOd1h5UFlvZy85Z0E0RmtkU1JwUkJYL2lrSVlVZ0xWNkFBWml3L2tGYTdP?=
 =?utf-8?Q?5aDLejg8YBg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHdacW9uSVF5ZGVNRWJWbFpGYnhxYy8wZ2p3b0dGTUduZW91L0l4ZUJWTyts?=
 =?utf-8?B?K3liMUZ5UVhlVXhrUjZGRlF2L0pKVGwxem1KTXgzV3pXaUlVNmVGb1FDNHI1?=
 =?utf-8?B?NEJXOHlpMTYwVEs2MUFpOENQL0o3dUpqNTdWbHo2VHdqczA1OGNJUlNlZ3c3?=
 =?utf-8?B?akdrSVhidGRCOXdKRlQvTmZDY2dVK2J6bDB1Rm91MXNLWHg1U0FHeVFpdEhh?=
 =?utf-8?B?ZmkwRGlZNTgzSjBML3VxN2F1bU9GZVBFcEN2T1g0V2hjZEJXUnlsY3E4Nzc3?=
 =?utf-8?B?UURVU3IyYUdiZFFLQ2xqb0tDL3hHeEJZVDJjVFFzSVpJSUVoSlhyaDQxUjV0?=
 =?utf-8?B?ckV6SE9MMzFiZ3l1SXduM3N3cjJzMkdvOFRPakx6dWd2K0xwNTV3VGl5RVdp?=
 =?utf-8?B?RXVkK1J2K3RlWlFZNlN6M2dHZGtUL0VGQnRDWm1kWEpvWG9ZbFBZR0g5MmN5?=
 =?utf-8?B?RVA3OVdmZ0ltejcyOC80Y0F3dkRvZ2NGOUM4ckJjSURxeFYxL0pTVGJTRDJ2?=
 =?utf-8?B?c0VpYmpVM1UvdnJRUVcrUzRQY0plb3ZGVHE3ZmRNV01tOW1HQThzenkvNUlJ?=
 =?utf-8?B?ellWOWJtblZsZkdpcFNJMW5tMDI2V1RvekVsdGlxUHN5YTFKQXNyK0tvR0Q4?=
 =?utf-8?B?c1A3ZHJiTGVLZWlXckE3V0p6My9CTEtta2FSazVpcllTbStsbVdLb2JEblE3?=
 =?utf-8?B?d2srU1g2WkpWcGNBUFlCZE5RdWtRdjZnWGs5cmZ0eStMT3pJRVZKdmVFWUh1?=
 =?utf-8?B?bmNYeDRIZEQ5bHB6WHBjQ2dkbC9SOVlDck1ISjRmSFNWd29GbnlIY3hQOUp4?=
 =?utf-8?B?R1M0U1lqNTU4b3JxRmlQeWNJZnZvL3NHcmJSc1RtZDB2UTlkRmxINGZrVHl6?=
 =?utf-8?B?eVQ3TWpUVlZTZ28wazN5clplSnk4TFltdlFna2hUZTVGOUpPMmltK0xVMUU2?=
 =?utf-8?B?QUdQTXZETWZGVk9HUC9zM0xrNkdjU25MUVFBL2F6UTZCZHMvMjdZajAvTEp1?=
 =?utf-8?B?bFBjZ2pZZUJYbGNHbm56bi9MM1o3dFpwclk1M3RQemhIRUJUdmJYZ1pXU3J2?=
 =?utf-8?B?K0VoWTAybWIwU2x3RUNZU1FONDRLSVdSMXoydUxraTdGTDV1ZmZ1cVkyRGhF?=
 =?utf-8?B?WVM2cFdCZDF0YWp4V0dTNkNGWjdHTkFBazQ4eWJoTmZzYlpld3FaVkNYbWE5?=
 =?utf-8?B?UEhxejBuRUR4OTByZURBdjBBNGFaSFBvSEVxQmp3djFibUtSY000VjQyczdP?=
 =?utf-8?B?QVhndEswVXVFRzRGWmo5cWZPVGZyem85Y3dsTzVOK3NtRUcyZHdCbkdvblV0?=
 =?utf-8?B?dmVxNWNvT2xRcFFNRzZ0cVFEWXhHMllweGthb01KUTBwWDRMTW0zSGNtaTha?=
 =?utf-8?B?NnFDelNtcjRiam1RTUJDYkNiOFZ5Y2V6dVVtUjZ0MmJsTjV5d0xOSWY0d3Zk?=
 =?utf-8?B?NDVycm03U3lHWS81ZldZcmhYc2pjT0s5K2ZUNlZzaVRtRFNYZ3p6NGJ2Yk91?=
 =?utf-8?B?RTlWWk1Gc252Umc2dTJneThlOHNYdUwzV0dWcGdmdFZxUlBZZStlSk5SNmRH?=
 =?utf-8?B?bjJCZTNnL1lXNWhabU8xYjBPM0NIOElzaGh6bExlaWY3WEJIc3RWTXFwdjB6?=
 =?utf-8?B?U0w1UmxscE9tUWlucmE0UC9VS012SGJaM3hQd1VTRys4eFRzc3AzQXMrVXBV?=
 =?utf-8?B?Yy9DS2tJbkpRTlE1akVPb293bkxoMlhnRXc3V2FwN3ZwRlRRZ0ZESC9qNTcv?=
 =?utf-8?B?UVlWUmJBQ0E2M3VtRWtYTDJackJoQ1RoSkh5Qnhabk9PZmZBckw5MzdINDB3?=
 =?utf-8?B?WlR2K096d09RQzdnUXZLREN2WDdvTFdVRyt5ei9nanE2Y2Z1eWxIanNCTWMx?=
 =?utf-8?B?OXNFZC9jd0lheGRoNjAvbzhObDFoOW8wUEJ0WGlxNEk2UXBlOU1UcUhKVzVB?=
 =?utf-8?B?eGM0R3ovVlMvdUJoamdCVGYrNGRyNUE1aW9GZG1kSDhqdWxaT1FoSjJGcWp2?=
 =?utf-8?B?VENOalI0SjNnUG51VjVpOXh2WjlwbFhoY3hHMjNwRWtncDVMeVJqczlPRitT?=
 =?utf-8?B?cGJiR1k5Rllvd2gzK1pIcTNtc1ViRWVidStENHRqLzNRKzEwRXdUMlJLZHVa?=
 =?utf-8?B?TnZ3d25LbGVwdTVZa0ttbU0zZE1iL01yK0lQaXVwTExjeDBGSmE4eEZRTHht?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f9s/1en2q0INatGAhCWTFWWZpWz28agtKePExMq+u3ijLkN9F6hltjKd4IXhky3+MgXwzMr6mF2FA1sMwW9iAbNoG2bRmpEkXQUylnaopEDCFzvP4wWpjxm7s0WMyzxql3pZP6gMwmrP/b2bQmYPnjv3svoS6zEZRk16wViLSLtoLBJVN6oWP6peeRzHQ0+vL3tgP+8/EPjx6ZQH6mib8mGDqHjLCA1HxwFHVBHT8jtXLbkVzUHQ9/tT7vEmRq0LY9KFZItpdVT6bwh62ZpkD1+6XiOMdqpo/L6qEVEX18Zc1fiVYMLpVSq7emJn1tRV5U22FJo1YnqRcw3/CtbRygHJMDWe4bL6v22wqMG9K+/zZGHPQu4EWPmfW2uRd4VbqGxxuPwhXs+758duLVyk2Jic9WvIN6JrOKAF5s5vnqmL5VB7ciXR2cui+QJDV+dC+iWb/zFajvPumDTtQpuroULdrg2xYacAmqkoE0TWKTxBwE/wQWax1xhk21v5/0ZS8vcJBEtIJyzCJfv4BQ3gapY/JZIZE7hLhpoeei2OGSs474tWp92b5hHCLEmAnv2YNyrE5D/kH6hABZv6dOJuPz4utz4l0s0k+Rzzs+cOP64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050fc78a-62e2-434d-a4ae-08ddea362575
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:34:03.6801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWqCJB6ZAfqfgIwQo7RigPndbpA2slj7Iq6XE5CPM+Mat2p4KJY/QXAoOOWgDMewXEYkD4Nnc5dr5I/nM8clVDWY4kNE2Zr/vxsrlAqfeaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020154
X-Proofpoint-GUID: W2OTDsMkbvNGHehtT7GlrmllvHJB6AGw
X-Proofpoint-ORIG-GUID: W2OTDsMkbvNGHehtT7GlrmllvHJB6AGw
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b70e74 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=oMG-V2Gau2DtSPeflBkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX9V8Ht8w62zBK
 AQMBVHTQrzKuC8rzt8JYpYntJhd+9N0QqB2vvxBxtHimvFYcA3wpHlco+/J4kUdG/FxlD0uFYna
 Jf0/VRZ0jLmDCpKrYQefaW7doGPbf59R+NftOELhFCiqI/z8Cd18DVaZde2YVrhlceko6VMUbSM
 FzTPF2PtvQPIHrVV8dyd6xI9zzt5vhUADs007yEsWOhzcfLlbzubs20YCgrx6q91Vz6LAhoZur5
 yV2bY7NqkyGLXkBw0+aVTPKGrJjkfCMMQUFW5ckM8KXThg0MPMQjzU+cpL5t0TRPh3tXbkFBj7H
 9vQ0ITv2x08bWhFHQ94hoxj2UnPxfj/HmpXrMtOHdmVtF9pk6vp+apaofu80qicRBfJ2zQYVJJT
 OrhKAQKU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/1/2025 7:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> On 29.08.25 22:37, Steven Sistare wrote:
>> On 8/28/2025 11:48 AM, Steven Sistare wrote:
>>> On 8/23/2025 5:53 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 17.07.25 21:39, Steve Sistare wrote:
>>>>> Tap and vhost devices can be preserved during cpr-transfer using
>>>>> traditional live migration methods, wherein the management layer
>>>>> creates new interfaces for the target and fiddles with 'ip link'
>>>>> to deactivate the old interface and activate the new.
>>>>>
>>>>> However, CPR can simply send the file descriptors to new QEMU,
>>>>> with no special management actions required.  The user enables
>>>>> this behavior by specifing '-netdev tap,cpr=on'.  The default
>>>>> is cpr=off.
>>>>
>>>> Hi Steve!
>>>>
>>>> First, me trying to test the series:
>>>
>>> Thank-you Vladimir for all the work you are doing in this area.  I have
>>> reproduced the "virtio_net_set_queue_pairs: Assertion `!r' failed." bug.
>>> Let me dig into that before I study the larger questions you pose
>>> about preserving tap/vhost-user-blk in local migration versus cpr.
>>
>> I have reproduced your journey!  I fixed the assertion, the vnet_hdr, and
>> the blocking fd problems which you allude to.  The attached patch fixes
>> them, and will be squashed into the series.
>>
>> Ben, you also reported the !r assertion failure, so this fix should help
>> you also.
>>
>>>> SOURCE:
>>>>
>>>> sudo build/qemu-system-x86_64 -display none -vga none -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1 -device pcie-root-port,id=s0,slot=0,bus=pcie.1 -device pcie-root-port,id=s1,slot=1,bus=pcie.1 -device pcie-root-port,id=s2,slot=2,bus=pcie.1 -hda /home/vsementsov/work/vms/newfocal.raw -m 4G -enable-kvm -M q35 -vnc :0 -nodefaults -vga std -qmp stdio -msg timestamp -S -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -machine memory-backend=ram0 -machine aux-ram-share=on
>>>>
>>>> {"execute": "qmp_capabilities"}
>>>> {"return": {}}
>>>> {"execute": "netdev_add", "arguments": {"cpr": true, "script": "no", "downscript": "no", "vhostforce": false, "vhost": false, "queues": 4, "ifname": "tap0", "type": "tap", "id": "netdev.1"}}
>>>> {"return": {}}
>>>> {"execute": "device_add", "arguments": {"disable-legacy": "off", "bus": "s1", "netdev": "netdev.1", "driver": "virtio-net-pci", "vectors": 18, "mq": true, "romfile": "", "mac": "d6:0d:75:f8:0f:b7", "id": "vnet.1"}}
>>>> {"return": {}}
>>>> {"execute": "cont"}
>>>> {"timestamp": {"seconds": 1755977653, "microseconds": 248749}, "event": "RESUME"}
>>>> {"return": {}}
>>>> {"timestamp": {"seconds": 1755977657, "microseconds": 366274}, "event": "NIC_RX_FILTER_CHANGED", "data": {"name": "vnet.1", "path": "/machine/peripheral/vnet.1/virtio-backend"}}
>>>> {"execute": "migrate-set-parameters", "arguments": {"mode": "cpr-transfer"}}
>>>> {"return": {}}
>>>> {"execute": "migrate", "arguments": {"channels": [{"channel-type": "main", "addr": {"path": "/tmp/migr.sock", "transport": "socket", "type": "unix"}}, {"channel-type": "cpr", "addr": {"path": "/tmp/cpr.sock", "transport": "socket", "type": "unix"}}]}}
>>>> {"timestamp": {"seconds": 1755977767, "microseconds": 835571}, "event": "STOP"}
>>>> {"return": {}}
>>>>
>>>> TARGET:
>>>>
>>>> sudo build/qemu-system-x86_64 -display none -vga none -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1 -device pcie-root-port,id=s0,slot=0,bus=pcie.1 -device pcie-root-port,id=s1,slot=1,bus=pcie.1 -device pcie-root-port,id=s2,slot=2,bus=pcie.1 -hda /home/vsementsov/work/vms/newfocal.raw -m 4G -enable-kvm -M q35 -vnc :1 -nodefaults -vga std -qmp stdio -S -object memory-backend-file,id=ram0,size=4G,mem-p
>>>> ath=/dev/shm/ram0,share=on -machine memory-backend=ram0 -machine aux-ram-share=on -incoming defer -incoming '{"channel-type": "cpr","addr": { "transport": "socket","type": "unix", "path": "/tmp/cpr.sock"}}'
>>>>
>>>> <need to wait until "migrate" on source>
>>>>
>>>> {"execute": "qmp_capabilities"}
>>>> {"return": {}}
>>>> {"execute": "netdev_add", "arguments": {"cpr": true, "script": "no", "downscript": "no", "vhostforce": false, "vhost": false, "queues": 4, "ifname": "tap0", "type": "tap", "id": "netdev.1"}}
>>>> {"return": {}}
>>>> {"execute": "device_add", "arguments": {"disable-legacy": "off", "bus": "s1", "netdev": "netdev.1", "driver": "virtio-net-pci", "vectors": 18, "mq": true, "romfile": "", "mac": "d6:0d:75:f8:0f:b7", "id": "vnet.1"}}
>>>> could not disable queue
>>>> qemu-system-x86_64: ../hw/net/virtio-net.c:771: virtio_net_set_queue_pairs: Assertion `!r' failed.
>>>> fish: Job 1, 'sudo build/qemu-system-x86_64 -…' terminated by signal SIGABRT (Abort)
>>>>
>>>> So, it crashes on device_add..
>>>>
>>>> Second, I've come a long way, backporting you TAP v1 series together with needed parts of CPR and migration channels to QEMU 7.2, fixing different issues (like, avoid reinitialization of vnet_hdr length on target, avoid simultaneous use of tap on source an target, avoid making the fd blocking again on target), and it finally started to work.
>>>>
>>>> But next, I went to support similar migration for vhost-user-blk, and that was a lot more complex. No reason to pass an fd in preliminary stage, when source is running (like in CPR), because:
>>>>
>>>> 1. we just can't use the fd on target at all, until we stop use it on source, otherwise we just break vhost-user-blk protocol on the wire (unlike TAP, where some ioctls called on target doesn't break source)
>>>> 2. we have to pass enough additional variables, which are simpler to pass through normal migration channel (how to pass anything except fds through cpr channel?)
>>
>> You can pass extra state through the cpr channel.  See for example vmstate_cpr_vfio_device,
>> and how vmstate_cpr_vfio_devices is defined as a sub-section of vmstate_cpr_state.
> 
> O, I missed this.
> 
> Hmm. Still, finally CPR becomes just an additional stage of migration, which is done prior device initialization on target..
> 
> Didn't you think of integrating it to the common scheme: so that devices may have .vmsd_cpr in addition to .vmsd? This way we don't need a global CPR state, and CPR stage of migration will work the same way as normal migration?

I proposed a single migration stream containing pre-create state that was read early,
but that was rejected as too complex.

I also proposed refactoring initialization so the monitor and migration streams
could be opened earlier, but again rejected as too complex and/or not consistent with
a long term vision for reworking initialization.

> Still2, if we pass some state in CPR it should be a kind of constant. We need a guarantee that it will not change between migration start and source stop.
> 
>>
>>>> So, I decided to go another way, and just migrate everything backend-related including fds through main migration channel. Of course, this requires deep reworking of device initialization in case of incoming migration (but for vhost-user-blk we need it anyway). The feature is in my series "[PATCH 00/33] vhost-user-blk: live-backend local migration" (you are in CC).
>>
>> You did a lot of work in those series!
>> I suspect much less rework of initialization is required if you pass variables in cpr state.
> 
> Not sure. I had to rework initialization anyway, as initialization damaged the connection. And this lead me to idea "if rework anyway, why not to go with one migration channel".
> 
>>
>>>> The success with vhost-user-blk (of-course) make me rethink TAP migration too: try to avoid using additional cpr channel and unusual waiting for QMP interface on target. And, I've just sent an RFC: "[RFC 0/7] virtio-net: live-TAP local migration"
>>
>> Is there a use case for this outside of CPR?
> 
> It just works without CPR.. Will CPR bring more benefit if I enable it in the setup with my local-tap + local-vhost-user-blk capabilities ( + ignore-shared of-course)?
> 
> 
>> CPR is intended to be the "local migration" solution that does it all :)
>> But if you do proceed with your local migration tap solution, I would want
>> to see that CPR could also use your code paths.
>>
> CPR can transparently use my code: you may enable both CPR and local-tap capability and it should work. Some devices will migrate their fds through CPR, TAP fds amd state will migrate through main migration channel. 

OK, I believe that.

I also care about cpr-exec mode.  We use it internally, and I am trying to push
it upstream:
   https://lore.kernel.org/qemu-devel/1755191843-283480-8-git-send-email-steven.sistare@oracle.com/
I believe it would work with your code.  Migrated fd's in both the cpr channel and
the main migration channel would be handled differently as shown in vmstate-types.c
get_fd() and put_fd().  The fd is kept open across execv(), and vmstate represents
the fd by its value (eg a small integer), rather than as an object in the unix channel.

> Making both channels to be unix-sockets should not be a considerable overhead I think.
> 
> Why I like my solution more:
> 
> - no additional channel
> - no additional logic in management software (to handle target start with no QMP access until "migrate" command on source)
> - less code to backport (that's personal, of course not an argument for final upstream solution)
> 
> It seems that CPR is simpler to support as we don't need to do deep rework of initialization code.. But in reality, there is a lot of work anyway: TAP, vhost-user-blk cases proves this. You series about vfio are also huge.

TAP is the only case where we can compare both approaches, and the numbers tell
the story:

   TAP initialization refactoring: 277 insertions(+), 308 deletions(-)
   live-TAP local migration:       681 insertions(+), 72 deletions(-)
                         total:    958 insertions(+), 380 deletions(-)

   Live update tap and vhost:      223 insertions(+), 55 deletions(-)

For any given system, if the maintainers accept the larger amount of change,
then local migration is cool (and CPR made it possible by adding fd support
to vmstate+QEMUFile).  But the amount of change is a harder sell.
> What is the benefit of CPR against simple (unix-socket) migration?CPR supports vfio, iommufd, and pinned memory.  Memory backend objects are
created early, before the main migration stream is read, and squashing
CPR into migration for those cases would require a major change in how
qemu creates objects during live migration.

Hence CPR is the method that works for all types of objects.  The mgmt
layer does not need to support multiple methods of live update, depending
on what devices the VM contains.

- Steve

