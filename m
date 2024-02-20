Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44DCC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYfS-0007ZJ-06; Tue, 20 Feb 2024 17:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcYfQ-0007Z4-Cd
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:32:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcYfO-0004pU-BU
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:32:48 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41KLL6ac008338; Tue, 20 Feb 2024 22:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0p+GuX67fJUT4Lczm+KgjpYdctZdRR6qdNSGY7yzIo0=;
 b=npfvc+cUzVstz1oqKsJzui4q5U+qsnam2WMF7kOpQjL52GDaDBOhoU/lFDQJ7VECdy6Z
 hJki513+r+7Kxqvrspn1YW9tiDlMv+YQWQuSdd7sjZsrBEr1p8mucD+4WDssUaR0+ga1
 wt8GUvRsulNqTpMbY9BPgU9pu0FSr7VmwpZP//AsmITMEhhPG0gg3h/IgigjI3qAg2/Q
 M+XwB51TVSwhWXa8NawRZ+HiilwFEzcRti8YzV4oedIhCzeOphRUrp65QUVOXe7e7IfD
 APR+QwljYSv5msrBkI0i1SwUpra2AAdJxLFBjceJ9ASZ8v2LbT9a2CITaE7EoroBZ8GQ 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvg353-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 22:32:42 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41KLwXOa013155; Tue, 20 Feb 2024 22:32:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8819bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 22:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSj1+QV765WSRM5nPns64jIkJrLTJ3N7fHpySnV/iq/mehpsPX6vzafoGKab3xFzoLjC/+twv2DODRqbuOJO5gJWzt8lnYiRQm0BdyqDTVsVAS1QVpEC6Hm40Rzt+Ku6JbSVNKevPcrYpZ2TYGr5pXdCOhP1/YJxvl36hX9fpCQFe2EMZZ93etsg7RvsQoZrMzMc6sXu7E/n8WkVD6PtXf8NOeme5iOWDPm/n5EevZ+TNlDiI7G3KkSZnPqZpuHOk43cjb2YHK/e6+Ivqh3AY1K1gvHhHOX/ScnVpgvcME0Y2I/1iy7JJLO3sQx5YiAL3u21CEnWDpMmw4vOkrYUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p+GuX67fJUT4Lczm+KgjpYdctZdRR6qdNSGY7yzIo0=;
 b=QwhWubvAuUOQOsHHtLq9rzVvK4AvdU8XgdmuEtgOOp5vGkXAysfkWik6ubiya6DgUR+SRAbhdZ+2ZiK8tpH511vHX3NGid90WQ5hZEm1ndNW/4xoTAsaZ0DDMLAXHczLB+9Zgt3nzqRCPIIRjJMRMU0Han+2FccswsFozg7PmNtU/Au/48r5xXPLih1f39X4d4OgWfaAugeDkzFwuLXD1l8DDO4moMhFvCBXTwIlFAqRH0v5ChGnXgIMPFUI/Ll/u3yjPQ5ckhzS04JErKpylVfkTbiGSjpUWt7a8C0qnX+BF88JB3GoiLIVoHMpfHV+HQ5hV8GIwJqbtWJ5myl75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p+GuX67fJUT4Lczm+KgjpYdctZdRR6qdNSGY7yzIo0=;
 b=CygOeCwOPkAXw735Fe5yHVO3ffDXLn3reMou7UfLzfRncp6oDgIy1PmBr2HeRc3N0ZmiaPDt9S2+/gtP4/+pCsJC7lZIyJ5IWcyhY2ylj2r3Mao3WVeGaZDvuPYATiM74IVbnsx1li6nSyiZGxMXxRhAL4EXByi8au3irklcTNg=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 22:32:39 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:32:39 +0000
Message-ID: <3784e88c-b48a-46d3-8742-c3b94ad422c5@oracle.com>
Date: Tue, 20 Feb 2024 17:32:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/13] allow cpr-reboot for vfio
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <ZdRZpiiD05JS_AkF@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdRZpiiD05JS_AkF@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CY8PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 6038281b-cbc2-49f5-22af-08dc3263d881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkJbzLgjXW9TmvB3t1V4FoX60xuJSldt8lE4nF2z8loR+5iBbcAUXfCEXZuxlD+kNS3o9BSn32nIlronRsLk6krIsL/PdZU0BvtdjEt0NhhR85J6tKiY82llL3lu/bQIcuvRDwqG8hlyMk/h937ByN+qCwg6Bir+8I48g6eV+oqRvXC9kTjUebo60ttfmJbxlUd8iCjy14gc1a/EP5jYgBQKtPa3+Jz8dqIN4uUVK3zo/flLOlo3KNKGjepno3oHd4FelyftPrroDE3ofoxc38gR0hR5wC82jWwm/f6nS1/gUAhQuirX8jKXb53+MKLwxPvgCQAL5/hWR0gHk7Z8xbDG+K6fn945e51FAm0mwoxHpYRjoZ6VD1LVlNCRR+Nm29dP0cGYwIscooN0tkoCVZQ2sMk6axMwaj3D0dq3V9evw5J2XC19XIr3CJM3LBxqfdErqeHE5GcM3MP0H7C4TKSXL/6gVlbQnXactj4bw+0PzZNxJDel1C183PepFDIuze3VM8g4lB7NZgVG3GKdM4ykt/6zRlIwm7pjTAnIhOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBNVUo2d0tlaHQyUXN3a3lNZ0FLd1p2QXpqV08xak1xRDN3aEtqOXBFQjVX?=
 =?utf-8?B?ZVRxMWNnVHVwQmVMOHlXWVYvZmVZT2d3Uml6Z0JtbGN2SWc1eHVzbEkxd0tS?=
 =?utf-8?B?YWpvc3FQNGhlUk01Zkh2dXVibHZNZlI3RWYxYUxzTEQ3VmlkZng5N1BOWWVH?=
 =?utf-8?B?YWYyb21GYklsb2dvd2pSVzE1N05ENG9pRmt5WVhVZ0d5ZzlsSVR3clpWNE9y?=
 =?utf-8?B?cUNGQUQ5aVVPUmtrckt4eDZyMEVMU0UzNUZaelU4bXU3dDVnQVp3QzhTUGZv?=
 =?utf-8?B?NkN5aldTS2NTQkw2VEhQM09pTHl6RE5IY0ZQbTB2REpFUkxTcWNLNk5QdnpX?=
 =?utf-8?B?WnFmZDh1L2FMN0ZWb1VzWldGRXRRNHBDQ0tHR0FyQ1pNSTEyWitWL1Z5QVUr?=
 =?utf-8?B?SGVpdm9VUll4dWV4eXp5WkVXMzZGNisvZ28yVTA1QXhwdDZzUGxuM3hBS014?=
 =?utf-8?B?YzYvWVVMOEVTQW1iUkpUVmlaQjVyTFBMeng3bjQ4VmV3UXI2Ti9DdTRTbnEv?=
 =?utf-8?B?ZDFmMHNrNzFLNE1Wckcvd29UbUpILy9oaVNxaTJzOWgxNy82eE1QWDV3dW82?=
 =?utf-8?B?TUt3anZrUCtJbm4raENka3BiRnhzZmNRcDY0LytlVHJnUnJ0YmVDOHhsbHRt?=
 =?utf-8?B?TzkwSjM1OWdUc3pxSnphcytrdzhPbzV6czNwUjBibXI2Z2J0amNYQS8rbjJ4?=
 =?utf-8?B?RDlKT2gxSkdVNjNENThTYkJwaWg1bmpoYlRtMkNtMzhIYjZsNUh6eW1CZ1RX?=
 =?utf-8?B?Ty9RbGVWN01oUWk4SzJHS0kxUGphYit1c28rT3FkMmpudHV5VmYrcVVUeW5q?=
 =?utf-8?B?TCtyYzhiZEFhZUFEbkVzSWY0Wkh4Um1USU9YNU5RUWpWSG9kcmRXRDI1U0FT?=
 =?utf-8?B?enFyQmFDTGI4RXZSTkpnTEUwNUNWZjFLWWVJZGkxRUxsYzVhQmNRc1ZQY3Z4?=
 =?utf-8?B?ZWVTeDFXSUduaFVkYUZJQzFGNzJUdm1BenhTSEF4Rnp3WmlqbDJ5YkhPdjU3?=
 =?utf-8?B?R2Nab21RRVJIa21nY05ZdnFRM3lIQmd5NEMySHBBakFFUnVONEVEM3ptR1RT?=
 =?utf-8?B?M09wT1Uyb0hORHNEbEM0ZndCLzViR2VwL3J1U1VKQVZKc25YVVJZMWtCZStz?=
 =?utf-8?B?SVpBemxkbzhiUWhmbEtoZkpQeUtQVWhoNUQycXpZdGttZk8rT2dJSklrTkZ6?=
 =?utf-8?B?R2ExK083cjE1cEZEZjJENGZxZ05JVldXRjNaWUVmbWpTaUdCcFl4WGROYjdn?=
 =?utf-8?B?clJoR28xRHppZ3AveldsaTNZMExCclRrNTE1Nm1VMnUrOHJNcHk5eTV0UERK?=
 =?utf-8?B?S0hkemxjMUN5TE5IUHV1bkozdGkvTVBVVWZQYWZqcW16YS9rdGtuNWpvR25K?=
 =?utf-8?B?N29NcVpOMWh6S1pPM1djdGRUbUMyWHVsL05nS3RHeGNWVUoxbnpKZjAxTXRG?=
 =?utf-8?B?RlVXcmpsQ2d0RTZwNi9JNFE3MVdMMnZmL3VUYmd3M1RjVmhsVVZHV3RWK0hv?=
 =?utf-8?B?YTA4cVNrZnJJOWZLT3doTFFKMit0WkVUeHhTVFgvYWxmdWt6a0dVcnJkRXJo?=
 =?utf-8?B?TzI5NDRWejl1MXUrNG4zWWhlcWY2RktJWDM3bVZvYnJ2ZEExTnFFdlVab0JT?=
 =?utf-8?B?cXBtTGNnaDhrYnJqT3VoUVB6U2YyZUord2hxazFTUjE4cGtDamIvUTNoWklv?=
 =?utf-8?B?d2xjNVBHUHRBMzFNRmplTTVkS1ZycW1wMVFmYWduaVJEVWl6RkN1c2ZrMDUz?=
 =?utf-8?B?Z3RIL3M2N2tqZG5uTk5WVE5aYlV6bUUxcVlQeno2bnpjRzdDcHBVU2pPekdr?=
 =?utf-8?B?NTNWQUFmelRZaXdOeE8rOTJwR3c5RTFXQ2pMVjZyN1M0MCtQVFR4Z0hRK3hv?=
 =?utf-8?B?QWRtVjAyejFwTVBpc2l6UnR3OWZYekdhMzkrb3QrR2wvYXFiRTUrd2QvZ1dN?=
 =?utf-8?B?RXVjbnltNWxGdkRSZkxJdlR6ZzA2amNEMkd6a09kdWNHUWpEZ282SjhMWjk5?=
 =?utf-8?B?V1hkZFZNSG9XWnZROUNRTkVXMEEyV2hReml6VENGay9BN0kxRjdNUGVHS3Vx?=
 =?utf-8?B?RGIvbFcvOVF4TXpFemJVeGRScFdCZXE1Sk8ycnUwdnV0OSt0RlF5SmZSM2FO?=
 =?utf-8?B?TDErYlh1YjlEMzV2TThwWDVEUjZEaTM5R3dJZllXUGcrMkxZcCtBNTd5c2V3?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ivs0B9hisB5wVf3uYmBvaTnOYiA8nUyB0Du/tWjkR2Vc13xr5LVSxzZ/qrktoWMRPci5gtUs5imttsE/WH9N3kKJeRx4HjEbbGykMfP19NbNF8WxvQ7HfvV9A/X/l/0sSAqYv5UvBUrVmuScgU1lZRl9RgRpwo66P6DRg/e6hDNkWwZdNYhal+WTxBgFyjxLKk9tIlLCYEKFlz3mhklTakKk/DPgsP0mrN3+5a7wqyopG0KfcPOaAYlMaYV8ZuiUbFnGdgXZlAAfKqD+uZBogLmwE7ns/mHT6PqBkpfg49FvCzJdWjmab6NUQhmLGYP8ePwQ8bYxkRlpvIxzHoig3h4wCnO9Y/OjzHOVs98/aZZjnIeTOhVplyn5HaYHOeltaVQA9EScGcB6sZ0+WK6fLNS4PKOAJ2DZ1jeF+pTUg6SzvNrKsJqEur6aAaoopIe9mEUVjiTd+VFusVRWJOmyQaYJbq/L2Rs0Xy41L+qB6enFVMWXtB5va1TEzYGHt7Nt2IvB16fxZB2v9e6XYM41GlF1tX3gWD8DIEne0PrP4mZthkNV7MnC04GIvWwZ7yqX0DA26aUgfMt+781RoDeXI7cZgesTySMW1rcR2jl8jTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6038281b-cbc2-49f5-22af-08dc3263d881
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:32:39.6476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJJgqd81DLW5WLoQBBuzlBgZHTm9SXpZErIUvD3Lstm+JrW3jRGcqOBw5l3O78iq7rpVrUR34sZZ25esKjsEqaGtCOgSiFRiIkuKv3UaMJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=954 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200162
X-Proofpoint-GUID: sIC7BAU4hqDk6cHgAIbPDpXSwhhfTJ99
X-Proofpoint-ORIG-GUID: sIC7BAU4hqDk6cHgAIbPDpXSwhhfTJ99
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/20/2024 2:49 AM, Peter Xu wrote:
> On Thu, Feb 08, 2024 at 10:53:53AM -0800, Steve Sistare wrote:
>> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
>> guest drivers' suspend methods flush outstanding requests and re-initialize
>> the devices, and thus there is no device state to save and restore.  The
>> user is responsible for suspending the guest before initiating cpr, such as
>> by issuing guest-suspend-ram to the qemu guest agent.
>>
>> Most of the patches in this series enhance migration notifiers so they can
>> return an error status and message.  The last few patches register a notifier
>> for vfio that returns an error if the guest is not suspended.
>>
>> Changes in V3:
>>   * update to tip, add RB's
>>   * replace MigrationStatus with new enum MigrationEventType
>>   * simplify migrate_fd_connect error recovery
>>   * support vfio iommufd containers
>>   * add patches:
>>       migration: stop vm for cpr
>>       migration: update cpr-reboot description
> 
> This doesn't apply to master anymore, please rebase when repost, thanks.

Will do.  Before I do, any comments on "migration: update cpr-reboot description"?
After we converge on that short description, I will submit a longer treatment in
docs/devel/migration, which I see you have recently populated.

- Steve

