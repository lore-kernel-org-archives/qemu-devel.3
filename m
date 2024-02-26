Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2F4C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1recAm-0005GJ-JZ; Mon, 26 Feb 2024 09:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1recAd-00059J-UQ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:41:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1recAY-0007wq-CS
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:41:31 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QDLD0K022467; Mon, 26 Feb 2024 14:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1bXZjJxA0FMCDOwIsEvOFz1RZtACiOweAK21Vk6HlqE=;
 b=GoYkGeUV7x6RZcHi2Ms765mFzcU5+oaigVkLADGSlFp/rTWCgF9wUzOxunDNjCaCgdEk
 9qIS9COY7FKa5OiV5L9pC22C+StE5BEfwukCWHQ6ybhXZemzrR2Wi8TqaP6Oy1NAvkeQ
 sAp2EJ9lF6s2IqZPiRMAizhf02sVyCwSRafLggSxYz20Iu+rKpneEnn2Ozufi3odBn0S
 jHUfE0kOY484qM+mtMwNNKVr2k2WmxwkSSjHoj5+Vw9tvrf06N+xFCISE4ZguErYnaLr
 il6WAhuxpevxY4zbPmqZXQxY1dUDl/xx7yqTRm36qgsTzYk3eT+TSBV0hiIK3+lxZ0ch Yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdcuj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 14:41:21 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41QEVZUX015226; Mon, 26 Feb 2024 14:41:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w5vemr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 14:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ade2BPV3HBH8Jjuk5k4jJ2qDfPKTcPcL/q8H+YRrZ5w6jawSTqY2qSOMXS5ct5GQ/XKCgETWI8P3Qa6y+lhncfeLVOyzSFJRvBlaUjC6i5q6MQT87uTmdJV7qinxxzwVap4LBUgOf2eW16uo04ko1rp8JbEHGl10HiKS48f8qmrv9SGnPr1PuAlb2dpgMgRexdvO64ydckBv6CpQxfTM2HO9MCF9QkQEqMCtuML07fvQy/E2t1LFKDIycYLkl+Ex3/Po6MqVA2xtz0IraJsyKGFeLLi7LHjMwdoBz7UnjtSVh/D8mXx8Y5moTflh1zIftNG35nCIEO45ZlZNX+/dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bXZjJxA0FMCDOwIsEvOFz1RZtACiOweAK21Vk6HlqE=;
 b=LrcTOkk1LwwpUemuC8oGnOwO2hSrAaVxb7YT/gh2fg7hBCwcKyY1/tP9WItnRInO0m+wuiH0OmMtnW+gT1fK1T2gnuw3VdkStT4lyOjBcaSurWlCk/F9/67lOnQrhGi/fCikOO4grqsvZLUFt/6eWlZFZb2lAWVhh9BBpoQwdc4d8MsHa+/UJAxQkFNTEVrP8eZSaJ96BmezP7g8OIvwHC6ZLe7rJz8sQs5JlXiuE4MrFFbGFD9Tp1icLCinwTCbyjOLM6LAkX1pJahvDYiWC3dO15CxcloCfguyHNu1bbYX2d98jxZX3ytbStQtqFBwLOkFzOEfP1GbAE1TjLp2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bXZjJxA0FMCDOwIsEvOFz1RZtACiOweAK21Vk6HlqE=;
 b=nktMrI1BELqTTAn3E7bAvfQe5uOX2pTFHHvzVL2wnhcBDMEYxz5WSRYwyz7cdy4LhmouBih/4pGJ+kLFh7mp0xK5yt+bfn7HklksqDQNGss6IzKXRvWV35jmejC57KsGM5XZq3uAFH9oDDfvG9gBHJKzEZasGzoHwRW4p0XUNX8=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 14:41:18 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 14:41:16 +0000
Message-ID: <65ec5d47-d27a-4633-ad3c-aec8a7710f8b@oracle.com>
Date: Mon, 26 Feb 2024 09:41:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] migration: export fewer options
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <1708708404-197951-1-git-send-email-steven.sistare@oracle.com>
 <87cysjllln.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87cysjllln.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:208:32a::10) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f5faeb-1488-429a-c301-08dc36d8fd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJgA+0cZjk5CZ/99v3fOz6ltA5d5c8qDqbCfQMyC/syCnElrsfidLXKbXTe2jRNWKpZS1CRQHtTYia2C/k8l7iDhc+JE3zqJzCDtZu7zLR9KH62I7mRz/9CMpvzdErwjNRvm7iOqhWzaWFBZL00HCrbPIHooGci0/501MrM/K+bP3l7dOVfspSXvyxvbahCgGVt//N+biGP5RlVOWKlIVb0T8rZkPZ7UaHTW90aiLaExspN/h9cJOD8dHLF43O1NQmxbmj0TDm3aViN/iorqCkRPwh8A8elzOxP6hzvcE5c+qsAxw78OW3hDwG2+zKNnwyPSUz598UjCBaVz5X+0HK2qllTPKD0fvceE/B1tcw7XXqvm8OWAJf7PLt/Xlcqf2mAJGY05nNbWdTcB3Sv+24M/lKAZeF5lTsAZyhrvU6wP71/6m8GAd6SQT8iHVwWfMpblzQO/xXUPM1nUa5R+xPFth9tLoFBWquqJJPEU/8v88iRF2VgSwEn2g11JP8cxd5+nUb6RNF2Q/A9gOLNgXVNsstdFKmnZo0a23zgxw5/NOxpYwhPW621Zq1xuhsY1V9cZhTniBfWWXCwGGxo2Rp5Nv0uyOWVwyN+GeR1uwAq+qZPVP//cwI73sLEZZk/FfZH85MYWWF4I0WyRX0GmYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JWUnQ4SUJsWnJwZ2NiSkN1WUhUMkpncy8wbWwxY0dFeFpta1ZhZDZvSmYv?=
 =?utf-8?B?bnFqY25UamxPbVNmMDc2a2NMVTJTNHdOb3A0Y1E4Sm9vWGNuNnEzWENkZzFu?=
 =?utf-8?B?TVgzcXhjalppOURNVFpCZWZVRzZYcTZ6MWM2NVgwMERoOWNXaEFDSmxiRFo5?=
 =?utf-8?B?aW9ZQlNjUE40RERYWDhFQ09PMXcyRXZ6bUhkMzV2dzRCbVVnRVdCek5KVnpJ?=
 =?utf-8?B?Ui9McWRmd282TDBRV0NzbmtHS0pvd2hUTGdsOG5zQlNYUjl2eE8yK0VLM3Ji?=
 =?utf-8?B?aHNydkdyQlo5YmdpN3hRVW1iZ05ibHFWTExnUzlRVGtZalByK3J3eXRrVERD?=
 =?utf-8?B?UlpxSzhHMytvSWd3cUhmMnJZbkdDOGhzVDZ0Vm5OblI1S1pGbEtXbTBFRS9P?=
 =?utf-8?B?ZWhNTm1COW9pS0xtY0lYdGpUSHpEamo1THpCaDdodE1NTlEvTjgrWG52TktP?=
 =?utf-8?B?TWJLb3lzTnBhOXBPOFZkayt5UkVkcFMzOE1wT0xIc2t0NlFmSVRxa3Q5TS9y?=
 =?utf-8?B?THB4RnJ6eW1oRFdZOW5XcU0wc3NGdUFzdktXc0RBcTVubFA3OEZEL29tUEsx?=
 =?utf-8?B?NENsbTU2T0RnU2FVaER3SXRpd05qdlVGNVV3R1dnSjBlNGw0bVRudEVmSElC?=
 =?utf-8?B?ZGJCa1ZkeXlkbEdnK0l2THB6ZXpRT05EOFVRUnJKb2lDM0FCY1pSK0l4dHQ1?=
 =?utf-8?B?YklIVmRPaVBiQVNYOUsrOGQyemxLK1ZMODVpNDVzWUJXQjNnc0l6SExiVkFm?=
 =?utf-8?B?Nlk3eFY3c013QVlleE1zWjR5T1BZcmo1RWpRS1NMcmxleGI5TVhpWWFkR2ps?=
 =?utf-8?B?TmFETGhWRDNKbWExUHNwejI4anRJS2dzUFVTNFprcWcxYjM4clQxbGwvczBt?=
 =?utf-8?B?b0o3ZXlNS3J5b3RlbWJpd0pvQWRwZVFwYnErZkpWa011blh0K0EwNDRtTFNQ?=
 =?utf-8?B?QXlic2RaSGNCMlc3UW10bEhERnRqcjMxWHBHODZZNHRrZllKZXRlTnpOU3A0?=
 =?utf-8?B?WlBMSVJlZHR6ZTBxRDdVTTBRLzc5cWZXY2ZBT0lHNldVNURMQzd1Q0JQTXUw?=
 =?utf-8?B?WWNxdkRFNDJBbW9BL2RmM1RCc3podWRGMzVQajdscFBLN3IrbU15OWt2SEJI?=
 =?utf-8?B?RjBHTWszYk5Na2hwOFpycmR5NnprSDJYb21EQThHV2JVZnpiSmlJdXpEOTI0?=
 =?utf-8?B?NzFGbWE5M2FNVzNwcXF6dHhxaTdzTW02ZFdidDR2eWFjYndRRVhWUHp1Vmoy?=
 =?utf-8?B?SFExMTg4U3hjQmdoeVdIaHNPMTlLUW5iS3BJTzAveFNVaXRkUll4bjl4alpM?=
 =?utf-8?B?NURxQVZLU1pocWFPTmdKNVRwajFuUTZWNENGWnlkd3hmakFWcTV6aTlCQ3F5?=
 =?utf-8?B?UW5MQk1lWXZObGxZNXVxaWJzSmdHTUpBMkZVd0RsczlqYlJHQVIvTDBuajly?=
 =?utf-8?B?UERXTzhRSHJWaWhnRWtDUjJKRVZsUEgvQ0srSnZaeWNJajh4dzVaQnRUTWFk?=
 =?utf-8?B?dDE4SEw3WngxMU8reFpXSUVaNTIzUUVpZERNWjRXNmxESjNmSEdDYVJHQTNU?=
 =?utf-8?B?R1FLWEpmWWZkby9XMVIyWjZycFhYWXZZMXVkQUpGR1ZCTlN1Vm85eWxRemNG?=
 =?utf-8?B?d1hPM1RiZ1JTdm1qd0g2VTlxSmdESGpxSXlOOWdHS01yWDBvUGlWcEpUUFNG?=
 =?utf-8?B?VUdsTS8vYTBJeEVBdy9HNnMrbGptNnBnTmlYZHlsZUZiNmpkSXNkRE9URHlW?=
 =?utf-8?B?bURjQnhCKzB0MFNrRUIwV1NXZ05Ud2c3Z2RmSVdkenpqTWRiMVAwZTYrTjdn?=
 =?utf-8?B?emttZWUyM1c2Mi8rTnZHdis3cDF1bklIcStVOFRXODNPOU9CWjRxbGlRbVZJ?=
 =?utf-8?B?ZnAwZTI0cDM3N3FnQ0VuUUE1TmZpZjUweldHYk0vYVc2Zzc2SUJlc3J3YWE2?=
 =?utf-8?B?ZGd5K3ZOVGZCNkhoUWJ3UUNQT0hSaGtTUUl1TE1jdGt2dDYrMDhiWkh1eG81?=
 =?utf-8?B?RXNzRzcwRldMc0ZBRkNDaXJ6RWZkalM1RmMwMXVXdEZHbkU3VWtBYm9JS1lI?=
 =?utf-8?B?cEkyc2JFV2NTd0YxMkhrOGVzNUtVM3Q5TGtOOStpaXFXbFJLSVBDMHFoZEwx?=
 =?utf-8?B?Ym1kTCthUDhSU1drR0l4YmVWQ3ZHMUM1UFdFeUVLVDI4VjAwQS9CQmJMOUUz?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +DxGwDVjl998f191vgAFyXxRWgxVvNQyWGop/s4avQ6lhYAFQJCJs5E0tqQxDHl8PLGNkzTH9EXHwih84PLQJ6ZHPjkOjTMP7W9ODOHksef+KWx37Qk5WzZo5kX+BXshVIvdABvwZntGuAyeGvoGAyYb+St3pVF6aN5zPDIWplHwwWAPMIJYhn0QfbJG89zGDRLQCZz+z6mO/4o6tTIE/pqQTuqbL6MBDGe0KxpyH1iKogy47Mc3Spo/KXrqnUNbtSnLwOXT4O42Fej++7/GEEfEWgsusmyds7AiAC3Foq98D0XtN57OEqNr4U/eN4qWf61FTTaQCxMs8rFNpR7f+fk8f1p819ZaencfUG8nTMEYJ1MedQD/9C6mU1Qwj7WIG5hQ9AdlDEgJlVOdrsAHy0JYuh7O/dd/QEtG1fagFah4+tPcblNiLqH1Gk7vCIyGgRVm+81pUFe1WMfBcdOHvTL73TlPhxALIPLyJGw85fdxm+ZCpRpjWsDcOYCv2qwAIwApw3tiTaD3Z6qDJZBR4vwZjhlhF13Hzuik+cs/CooWHBa4BA3CJIKsKQWptlrKUoET6QWshePsUyaFcMYe4K9HU3cD6RkxLYm70aVEHsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f5faeb-1488-429a-c301-08dc36d8fd15
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:41:16.7875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxhgooZrE9bT7KZlYY/TlGjKCQWe9po5ODZFxNU8F+Hc6eKslnwdmHHM4kT99FIA8qLrgx7AabyMBfu0flMU181rc5wzT3u2yPyo38jap3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_10,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260111
X-Proofpoint-ORIG-GUID: o2lQ5D85iJO16NR5tQ1Axvpmo1Oosqi_
X-Proofpoint-GUID: o2lQ5D85iJO16NR5tQ1Axvpmo1Oosqi_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/26/2024 2:40 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> A small number of migration options are accessed by migration clients,
>> but to see them clients must include all of options.h, which is mostly
>> for migration core code.  migrate_mode() in particular will be needed by
>> multiple clients.
>>
>> Refactor the option declarations so clients can see the necessary few via
>> misc.h, which already exports a portion of the client API.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> I suggest that eventually we should define a single file migration/client.h
>> which exports everything needed by the simpler clients: blockers, notifiers,
>> options, cpr, and state accessors.
>> ---
>> ---
>>  hw/vfio/migration.c             |  1 -
>>  hw/virtio/virtio-balloon.c      |  1 -
>>  include/migration/misc.h        |  1 +
>>  include/migration/options-pub.h | 24 ++++++++++++++++++++++++
>>  migration/options.h             |  6 +-----
> 
> Unusual naming.  We have zero headers named -pub.h or -public.h, and
> dozens named like -int.h or -internal.h.  Please stick to the existing
> convention.

In the spirit of minimizing changes, I went that route to avoid renaming the 
existing migration/options.h and its references:

0 migration/block-dirty-bit 82 #include "options.h"
1 migration/block.c         32 #include "options.h"
2 migration/colo.c          37 #include "options.h"
3 migration/migration-hmp-c 35 #include "options.h"
4 migration/migration.c     68 #include "options.h"
5 migration/multifd-zlib.c  21 #include "options.h"
6 migration/multifd-zstd.c  21 #include "options.h"
7 migration/multifd.c       29 #include "options.h"
8 migration/options.c       30 #include "options.h"
9 migration/postcopy-ram.c  40 #include "options.h"
a migration/qemu-file.c     33 #include "options.h"
b migration/ram-compress.c  37 #include "options.h"
c migration/ram.c           63 #include "options.h"
d migration/rdma.c          40 #include "options.h"
e migration/savevm.c        71 #include "options.h"
f migration/socket.c        30 #include "options.h"
g migration/tls.c           25 #include "options.h"

But I take your point.

Peter, which do you prefer?

  A. rename: migration/options.h -> migration/options-internal.h 
     rename: include/migration/options-pub.h -> include/migration/options.h

  B. rename: include/migration/options.h -> include/migration/client-options.h

I prefer B. If you prefer B, but want a different file name, please choose the
final name.

- Steve

