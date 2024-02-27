Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CB9C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexJG-0003AY-TZ; Tue, 27 Feb 2024 08:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rexJ9-000379-7U
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:15:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rexJ5-0007h3-SA
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:15:42 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41R9JLKX026736; Tue, 27 Feb 2024 13:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kuUMKuAubIXYd2+9FGFkb7dQ1k6mQ1CDbbuBIxroLKY=;
 b=n7PdqBykur6xZJGVpvpneRVnFeHakb2apdkFc586lYPxSsPDwrrGkp+rxLdR22mUO0p6
 RQ24Y5oGeTsoXSoVJx9tu25ks54EwtE4wfe8r0eHaiIThfhRBzLkq/URt7goujS7n+Ce
 i4A37tVD0TK02/TT48aFMHfmAC1yyUxqJh+E80uZVPyYyNcyDY7enC4a3fUCrVQhYBTw
 +faRHQai9leGqvL8mYSUbzOzwEihprFTriE4aBzLjcTYJYuSLUje5gRsC9kPSeN+0KNl
 ScUR3XYnvOROQl4TT+yZz5XDroQIAh2ma2dG3fKDT04b6SOnDn5kHQPMvzSLttVEZLsj xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v74k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 13:15:36 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RBvDnJ001663; Tue, 27 Feb 2024 13:15:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w76986-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 13:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl+plNfhhB9jfyvH/tPC75jpWipQreAi/nY/nYKT7AuuZJrjruVxJ+KiZFnW0aXrKFbFuLum4R8zRnwxhMsut3+eqteYTLI/glriCQT9G2kFaJBhmeNh6+BnLcgJCrhpVN+CZQ8RGL87XU3SB+LLcwwJJE5lrJBqpCTCNnBfOGBElHA96L7ROkQig9d/1AzC0M18TTQ6NyEvLfKN03s7m96poAkg+Gbb4SsYATtiBTFBjxVjmEnrX3rA30F74rJUByB8rxW+/ibhaMdBYtQEY4w1Or82HIHFqcTEeReGPkAOOL3/mheC+DzCNijVBvxeleJyDwJCxHk4J21zsV0Ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuUMKuAubIXYd2+9FGFkb7dQ1k6mQ1CDbbuBIxroLKY=;
 b=nqHI3eT6t56jMlQ42VGvvLNQm6guGCJmMWoThtGm7+4Yk3zfK8WKGw1DXozMZr4rh4hrDF3E83VfvhmxAsg7Bvqru/3SN7zfeBTSWx5lKDt0ETKaks/5hStf+f7Z8GheK7hk5k8TECifXb3vZOfwnP7pJSkE1jbljwyG8M8or8YYlG0XQN/4o4wxOqnE947sA0ScxU9AK3ox5B0LRCHcznuKPrj7z/TUHYG5rInfBJZCYl7Qgfb8iL/tvU5BqwFpdj4HEG2XvkpHiEnML3fLv3ov55Qj/gbrIaa7J2kd9o2d9l6DNjWg9Es3v0JM4UA6dT0uiROVtxy8gXs94o2Qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuUMKuAubIXYd2+9FGFkb7dQ1k6mQ1CDbbuBIxroLKY=;
 b=Wn9lFw0s40l38dodriY+Cc9vsIY43HZsHxxQFREs7i4yb6IB8NVCJVzrDxPwIPgmG6v8OJMGnTHNPqhLN1p5fzcPhZ2MJkYy8qPl0sIuPD+BLZunU0NUrFRkACZltG1NEnpNzC/qe2m2RyOX2CGnoo5/VxcaTaxoCX6WzymWmKA=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN7PR10MB6620.namprd10.prod.outlook.com (2603:10b6:806:2af::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 13:15:33 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 13:15:33 +0000
Message-ID: <7e2c96b8-34e9-43ae-a090-be6623fb3da8@oracle.com>
Date: Tue, 27 Feb 2024 08:15:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] migration: export fewer options
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1708708404-197951-1-git-send-email-steven.sistare@oracle.com>
 <87cysjllln.fsf@pond.sub.org>
 <65ec5d47-d27a-4633-ad3c-aec8a7710f8b@oracle.com> <Zd2YeQAXhUCZzYdM@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zd2YeQAXhUCZzYdM@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:510:2da::12) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN7PR10MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: d1059f52-1c09-406c-b5b9-08dc37962da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOGxct/znnw+zhvCfGo6E0KdWgoMr9L0n/E619yxG3t3Bc3nO/8e6lt5OiotmfhzFHHg3Hk0VqOnNkV84kENDmwRtJdNMXm2Ihaq+jAArLY7FIKGP0wMCrQq4hECWzS8JCpveJ84vsDVpJ5lO/4W3LLd0zDdWE9aE/55a0zM3qCr3YGAW5pHPGv3ZaL7benKHM2MCXGIN6SH7aXi8JFyxffDrYMsAc0nByH5rgRA/WEeZYOxIsACc4UZ0vQ6+5xNY8TLLF3pa6zeoUBM8SN3tL2U540Ox2N+Gp1Yaky8fDvgGctSgYGoivqy+UFQaW59dkYhLgrz48Gwb+11i4BQzEeoQp/WfHxHBo+eKw5jlc1KCu98Y6E8WfhLtLYRVgcfe6GGSugim/gVw9DwI82fVw2CRo70mcx22J75AwELG7oXE0/SZEuas55lYXJgSoZNHffwlaO4S0rSzaSvbESRz6xf0aVN0/YtW+oxE1CUVJfZZcT8agi2azP+ohzs9o0LsdaO2du3BFDbbsH7Ze70W+bUBEqi2YhxgJ9h1eSikShDmW3rq9BDDlZfjGfp8k78BNkCz5nKZtBLoOgHLEZjAQdud9FllCE3xtvqbjXZeB2gNpqUpnxWGYP+UkgUNLPtQeNnBojS9962atyMdOSbHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNhRUJGL3J2QUFYSkRtUkR4WGZSNWJOVHdYcGR0L3NPOUpGcmJlaFpxL1E3?=
 =?utf-8?B?ZGtjUFZiQUVQdkV4amJiaDZhY3RXUG9ac2g1TVVJeEJBSHFGRWJSYitZRnhD?=
 =?utf-8?B?SFliS051Y21XT2I4Q2ZlWjQ1UE5Rd0MzbnBoYXcydFM4WkhET3VQUVl6NTdS?=
 =?utf-8?B?WURCNzY5WjJRa1U5Uy9UVVlYL3IvSXJhUkdmTEpTV2ZGb2FnWkdxbTNsZmV6?=
 =?utf-8?B?Vk41dzFjemtPRUpNTmZxMjFxYWR0NW8zcnRFcHhHQTNPN3RIT25GQnIvY0g1?=
 =?utf-8?B?cStBK2NpQUpqdy9ONDRlZUduK0lpZThsTHRWK3J1bDA4SHZLam44akM3K2VZ?=
 =?utf-8?B?ZVh3NlovbWNQS2xFaGhLREYrTTMyT1VsdjNqNk1UZ0tDbVNnbkhpZzVueHJn?=
 =?utf-8?B?VW9RdlphaVU5T1lFVmdwMWFsV3V3YzM3ckRCN3hpT2dYWGNyc1dSMjdQekk3?=
 =?utf-8?B?UnRpQ1Z6b3ZpekxFQWJlV3hkOHhYWklaYmlZd3Q0VkVJc2I0SDVLbXZ3YVJX?=
 =?utf-8?B?S0l4NG96TWVqRUo1RkE4ejV3VEhCQnhnWG1IMXpCSVZDSFF1bHdNT1Z6NWNG?=
 =?utf-8?B?cEE4S2FGY2twM0dESXZOQ1gzT21qeEFvcHR2OGg2RmhjNTlEY1VJdjFndzRr?=
 =?utf-8?B?bEZST2J6cm1nWkgyZTAzUFlUNUxaZzlQYUtxMkFmK1RVb1U5NEloTVgwY29B?=
 =?utf-8?B?U2hKa2NNbnpXdTFxck1aL0lRdjFhL3BjS2ZuVms1RDFibnNuR1BPOWNac1pQ?=
 =?utf-8?B?eURwdVFqN1hoSVBQd3czQmt3M09Uci9ldzdYS2MvNncyWXJLbmtQWnk2cDFF?=
 =?utf-8?B?N2Q4WmVLK0dpUWV2enhxcjZIcndVT2d6OGl1Q215WDFFd0hrK3dwVHNEblN5?=
 =?utf-8?B?bktpMEF3VUV5c3pwMG5DcWJjZFVEaXpFMFZ1SFhqNmo3NzVEVGpHQmVJcEty?=
 =?utf-8?B?cVhnSzk0a3lTSEdIYXJWcFlYdGphRS9zTURNcWI1MGFwQXhHZ0FtWi9oOTNi?=
 =?utf-8?B?L2RqdGZGYnlXZXRoQ0toY0UrVzY3QXJEZ000bHo5enJiWldxQUp4NDBkM29h?=
 =?utf-8?B?OGJxMmttWHVQYjBrVXBVWUFNaTlkQlVPc3hYbVdTZnIwdGN0ODJ3Mk5LS0ZQ?=
 =?utf-8?B?VXpYR2liZWxKVS8zWHAwckJRM250TnU1SjlFazVSTkEyVHFwT0hsU2xiSzN5?=
 =?utf-8?B?RGV1eXJHckJ2OXk1U05pUVgvbERCaDNxYmhEcmVTeFNXOXQxQVVqQkJnZHN4?=
 =?utf-8?B?VzZ4MmpPZVBtN01xSW0reUFDN2krZ3lxSklxMThJRkMwdklmVGpUWXI5SWxV?=
 =?utf-8?B?SmhISDRNOENkTzVtYkxyUEFpQmc1RjZUSVhnNmZGd2h5QXNiQ1VCcUtWbnI3?=
 =?utf-8?B?VmY1d201MUw2T1EyVjIzTGcwTHNOL1NrZHZsbjlLSWU4STNkd3VpbVQzQjZ6?=
 =?utf-8?B?UWZnbkxjT3gyNXZmQzR4dTlwa0dqTTAwaXFjemhheTlZaS83OUVmWXhwV1hB?=
 =?utf-8?B?VWFCYkFLMlhsYlFWYkNiUHM1VlFlbWwvK25PcitRc2EybkFMb05ZTjBkY2R3?=
 =?utf-8?B?NVdPaFdmS0h1ZFVxSjRrY0o2UXFReE9Wbmdxc0RHMmNVVlFDVXlNeVVxR1FM?=
 =?utf-8?B?SVFEczY2YU82bmhhL2tEelQ3MElGWDFvMEJuODd2VTMrL2VjTmg5Ly9RaG1U?=
 =?utf-8?B?UW5Eb0E0dGJQbTM4OUl2VWlCVHEvWEI3MFVXWjlkQTJrUnU0UzNwLzNadEpI?=
 =?utf-8?B?TWc0MTlOUllUSUsyc2NUWTRpUFJaTjE4MnQ5T1ZCaWhWR3lVWEw1bWdHRmFI?=
 =?utf-8?B?Z2Zaak9Sd3FkSzZFZjgwck9lV05DbG9YR2hacThJQUViSC9mQmZhYlh1cXhW?=
 =?utf-8?B?NitFcG9YU3dJTFIwcG0yb1VkWGJ6SXlCTStoZXpMTEVVTFlROHoyZ05IR25u?=
 =?utf-8?B?V2M0eUNwR3RjR2hzbGNrOG5jWW9OMmRMUTNxaWNLb3I4eElSYSt1SkRJOE01?=
 =?utf-8?B?bnh6eEZmb04rbFkvZkF0VXpNMTUveFNIdEJYN3EvclJYVnhDaytPdm9mUzJi?=
 =?utf-8?B?UlAzN0hvc2wzTThmL3U5MnpaQkVrL0FWcEprbEliTy9xaC9KM3hTMmpWS1pm?=
 =?utf-8?B?ZDBENGx2QTFmSloxV2VBQWtiVm9YSHkxTDdjSlJxTjBMczJ1OWRHcW8xT0k4?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K3W/TiN+pF2yw7nJvsAfypHkRbpPEV+k02BI/AzxLU5CNJvDBk4cNcNwpSAGqwagYO0QmYu5NZdhQaN2a2RGuccgsZUpRNhBShXMpQGnYNEzXqjmDPSxooazhlpUmzj9qAhEyF8nqb7fLn+rLBhFNe7rtjJG2q+JYxejHT5wg3XBtfuYle1mYnN+PIqu4gwOHVKgxf/kV/BINTmiDhbWGagQgR40e393guSeOAXmlVV3tnBVEeMwAvqAi0HVRAD7G0RP5Ih3qconlGg1WJO4A/8sueTY9yAmvCiHL6l9DiBCcPLpPO3nuoCU3jmXkaZsUl2A/Y1QEIYrwRMExQEuiia7VWTJGYtPtvRRGsC/Z3gZcV0gsA3tH02RPJ2nA7PnlPeftoMQ/gmfBnF63wqLEtLLmcIPUB3d78TPAwlTVGfLtNDjfSx6hy4Hz543Kd79mS9jZ+Fst/b6hEfS3SDaM6C9j7YwdG6FzTzzAR3y9F1b1KecYjrE/2mlIDNLhf/gvF977JuqeBaPxyAal3apD/ekAqsLYTouAEUKd8GhbP4zJMyOBnaZslLnbV0xFuOnbVyb0JTTc6C6U6NJbLTyiuUMZocUoWESFrp1N6DmC4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1059f52-1c09-406c-b5b9-08dc37962da9
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 13:15:33.1823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYS5eOB8kZ5GoAjW0X6pYFnashqywaIHUN7FCT/tEtahWD/bdltmlcZNPAQsNV8sMUR+lX2AN3Fz1KP9YoxD+GPXbi7UPSBxK0MqAMLYcsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=935 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270102
X-Proofpoint-GUID: FN0l1ZfUPcQ0pSu_rXhLIte9JD7EGu5q
X-Proofpoint-ORIG-GUID: FN0l1ZfUPcQ0pSu_rXhLIte9JD7EGu5q
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 2/27/2024 3:08 AM, Peter Xu wrote:
> On Mon, Feb 26, 2024 at 09:41:15AM -0500, Steven Sistare wrote:
>> On 2/26/2024 2:40 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> A small number of migration options are accessed by migration clients,
>>>> but to see them clients must include all of options.h, which is mostly
>>>> for migration core code.  migrate_mode() in particular will be needed by
>>>> multiple clients.
>>>>
>>>> Refactor the option declarations so clients can see the necessary few via
>>>> misc.h, which already exports a portion of the client API.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> I suggest that eventually we should define a single file migration/client.h
>>>> which exports everything needed by the simpler clients: blockers, notifiers,
>>>> options, cpr, and state accessors.
>>>> ---
>>>> ---
>>>>  hw/vfio/migration.c             |  1 -
>>>>  hw/virtio/virtio-balloon.c      |  1 -
>>>>  include/migration/misc.h        |  1 +
>>>>  include/migration/options-pub.h | 24 ++++++++++++++++++++++++
>>>>  migration/options.h             |  6 +-----
>>>
>>> Unusual naming.  We have zero headers named -pub.h or -public.h, and
>>> dozens named like -int.h or -internal.h.  Please stick to the existing
>>> convention.
>>
>> In the spirit of minimizing changes, I went that route to avoid renaming the 
>> existing migration/options.h and its references:
>>
>> 0 migration/block-dirty-bit 82 #include "options.h"
>> 1 migration/block.c         32 #include "options.h"
>> 2 migration/colo.c          37 #include "options.h"
>> 3 migration/migration-hmp-c 35 #include "options.h"
>> 4 migration/migration.c     68 #include "options.h"
>> 5 migration/multifd-zlib.c  21 #include "options.h"
>> 6 migration/multifd-zstd.c  21 #include "options.h"
>> 7 migration/multifd.c       29 #include "options.h"
>> 8 migration/options.c       30 #include "options.h"
>> 9 migration/postcopy-ram.c  40 #include "options.h"
>> a migration/qemu-file.c     33 #include "options.h"
>> b migration/ram-compress.c  37 #include "options.h"
>> c migration/ram.c           63 #include "options.h"
>> d migration/rdma.c          40 #include "options.h"
>> e migration/savevm.c        71 #include "options.h"
>> f migration/socket.c        30 #include "options.h"
>> g migration/tls.c           25 #include "options.h"
>>
>> But I take your point.
>>
>> Peter, which do you prefer?
> 
> From statistics, "-internal.h" wins "-int.h":
> 
> $ git grep "\-internal.h" | wc -l
> 135
> $ git grep "\-int.h" | wc -l
> 3

Yes, I did the same search to choose the name for option A below.
But in option B, I keep the existing name for the private file,
and choose a new name for the public file.  There is no suffix
in use in qemu to denote a public file; we just use names indicating
the functionality, so I chose client-options.h.

Let's use client-options.h and move on.  I am preparing another cleanup
series that I think you will like.

- Steve

>>   A. rename: migration/options.h -> migration/options-internal.h 
>>      rename: include/migration/options-pub.h -> include/migration/options.h
>>
>>   B. rename: include/migration/options.h -> include/migration/client-options.h
>>
>> I prefer B. If you prefer B, but want a different file name, please choose the
>> final name.
> 
> Personally I don't have a strong opinion on the name.  I'll see whether
> Markus has any comment.
> 
> [and of course, I removed this patch from -staging queue to keep the
>  discussion going..]
> 

