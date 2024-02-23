Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05D2C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdW9a-0002J8-F8; Fri, 23 Feb 2024 09:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdW81-00029z-8q
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:02:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdW7z-0002BW-FM
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:02:17 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41NCYnxX008424; Fri, 23 Feb 2024 14:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3jPsCVYp8mlCV/FnFdT95SJ4HVvCF9hM0u1A+vfsJUM=;
 b=gXmH7nR/ow29k1zJ8Bf4q/lPt2NomVdsJkpo5UnkhuSq7f9iB28gyXj2kiZctzPyA08t
 0AMOq8hjH5KIc1C7wNgs/3FUbmFhkLygvMPRxeHO2F45iMyWf1sI3IB06oJGPaT1KsPi
 EJQTRASG3+PIBMx4AfXT/rq0p3MpXIOtyFXR4VctnPYRo7vCwS1j0xC4Fz0p5LIO0EyA
 B3N9tvu5DUf1t+rFXm4KEw2OLv22QxRvigSOEpLGFGqICg2lHqYlpIxztCMfDiAnCyyr
 HZGLs7gD6rNh3d68UUup8FrqwY1HOi/wjwaky8Z/abUYQze6Tz9vCc1l1rOpyx0WLoh8 qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2fuju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Feb 2024 14:01:57 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41NC675b020273; Fri, 23 Feb 2024 14:01:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8cbwr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Feb 2024 14:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsKnImPy82LHXCi4y/iXYD5TBWHF6gFbSr4JyI8Zmw71a6HN2WBWbb5qOwFEun740yALQlhcuS9JWBX7JYIEYhnY8QQg/DJjQ8ExVWJBwZJupmnjkL8ioiAz3U/xOgyiqLKHCRLznrYBNhvX2e1A+tEw9UXdK323b6gYYzazBk0XCY7mavUulpaV6goHzvWGO4095OkGcGiXXvfN7bK+vbPodd3usMtEyk40P91CUVzAX5NLIm1JpFcSqLwSfucqNjz2qHT5srXR4fcVSUeYt4XhDKAp6S7Ds8e+rIAZSPdodsG3gy3DYAbF2QeJKIuKc5RoQSnYRyhNZANmLpCQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jPsCVYp8mlCV/FnFdT95SJ4HVvCF9hM0u1A+vfsJUM=;
 b=B4ocLi/nKb++IFmCbU1w5MpbEYmgbK5UIeuzkBs0KEO4iUOPuTWNq2oyMr0AuZT3zz8uCk/UNb/2rhcYVo7h2S/4Xk2PRPQEnywYrM650zQIsQVESUtUfwTyzzfecYDAJvlMAuBII5ORgDkAHOlKPsuZ2YiiTiLzMHqUl8QEyMn4QUg1jQIlR4dQ1OVQVfW8StYQmEfeGrLNfzqQlg/psct6wcKq4GGt3EHdKm34DN9sbNHCM+zonogHpuLUXaYT4KnXZNU70clz0Tx3YqeQU23jRPKWxMxyonBBFtTZy7fYHiyTmjyneikf8DCIZBOZuxyD5OB5sepV+ysM+gtEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jPsCVYp8mlCV/FnFdT95SJ4HVvCF9hM0u1A+vfsJUM=;
 b=Ursj7OCbpmQMni7EY51NtMK27HK7nvLSwYIP3YFXwoIC3VD6HEg2PTVFMLAnMmPgWTu58sgXM0ZqfL391ajR6jHrIzNUvsT7dmNNN4KjUOLRxnT3dZSx8WLwnN1KyyS0yXwCki1pz6zDJn8MRpMA5f3S/2KOto0fMX3QT/2Zs+Y=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 14:01:54 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 14:01:54 +0000
Message-ID: <34d846ab-64e9-4fd4-8d99-62315a7c0f3b@oracle.com>
Date: Fri, 23 Feb 2024 09:01:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] util: str_split
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
 <1708638470-114846-2-git-send-email-steven.sistare@oracle.com>
 <ac4a19b6-9290-4c97-bc7d-eabfef079895@linaro.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ac4a19b6-9290-4c97-bc7d-eabfef079895@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CO1PR10MB4659:EE_
X-MS-Office365-Filtering-Correlation-Id: a54b3e19-3024-44e3-b13d-08dc3477fdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWGm2fsH4TiYbvIQk7Yfb+2WT8Cqhje3Y/6W0rIzDM0tJj1BuTx1MvAeSNOABEPJ4paRyfBcb2xs3Cl0tvYylXZrYrZ/X5OikJSN4OKwdKk0SBrrvUzQ/0w0OdZdZD/EcXXMnH3VTt1g6hLHog/jZbr3I6mkiG94YUdtFnDv97ocFGn3URL5dyfUDfaWXD2yQT5vYNr8eCDpZxg/BPNnSuIFbQcJy1Opvgyzc1dEM6QEZncAw4OjZDI38q6qo0aG1OwT026DTdkQR1AQVFiYgR/HiICg+vyTUi67Kvxm0tJ8gDuWtRGm030QV0uPzjGWFJOfOWsfolxSoNnnxS3Y9jGIJKwdQT8nuzJj3GevTUrR2hHB8x6WP15EyyJZs+44/6MHlIY3AEJRZaBDTLD3Maxo6H3dExsrF4QQwKtw4RD1lTuPGI0JE/+ESfmGq7ZYB+T01cZivrrDLaZ1RBaaV5LecenrfB2ioDVQr/rY4K4nhFaDHa4wC3SebEIbrQ0hYcfc/IecipPMEeWZqzxl4Wv10TSwc79xVG1s9L+dCWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTlobFh5b2x0SWhpLzR0TERBYWw5MjRaR09pVXp0dlg3eDVkeWRDTmo1d0JG?=
 =?utf-8?B?dERBamlLL3ZqRnlUSnZwWWk5MVNGczZaV1ZWTzdOVmFGOWxWYXNyQU5LTlVK?=
 =?utf-8?B?WkhUOGc3cWd5eVRSZlRQU2RmcSt3V0UzRE9LOWlmU2hrVHFiaCs0QUE3THBZ?=
 =?utf-8?B?MDUxdUhCUEhFaXBCd0kwQUtIRXVSMnhTYVlqQzh0S3loRCtlQUhGZGRuQUJO?=
 =?utf-8?B?bVNwcTJvQWQweVFEcnZmdm9PdVRYRytFdk1MNjFxRmNKUXZFOG5NNU5WTXJX?=
 =?utf-8?B?OWpJRGZ4MG5QRVF0OExnMkxEOUw0OVNwcWpBWHQwaVVBMmdXcktIQ3lTZ1Bm?=
 =?utf-8?B?d0RHei9RSlNtK0NxM043c0drQW96U2dSc3RZTjYvQUg1dFR2dDNYMTBoSnJQ?=
 =?utf-8?B?SDI5N2NOZlNMQlBlaGc0QmplT1BzNWN6SkZIUUhQY3N0UDRMWGpXODF5Zmlv?=
 =?utf-8?B?bVF6enBCaFo1ZzJ0VEg5aWVBUWJwc2g4b2xENmRwSDJ1M3dRRXpCV0VUcFd5?=
 =?utf-8?B?VjcwWWFKaS9QZzJLY3ZCNHNXeTBnUmVNSEdxcVE1b2RxeC9tQ3Q1RFlhM2s1?=
 =?utf-8?B?dWRpVitNckNwT2tzdHBJTVgrZG1RZzdtWktSSGYwVFQ4czdtSTRySDJzV3pp?=
 =?utf-8?B?VjVCRFdTMXlIMVpxZmpwdHhKUUF2clRTeFRmTkM0UWMrcDVlcEp0TmxvNDc0?=
 =?utf-8?B?QnJhODBNYXJiS054c1BXUFdVbUxPdlBERmR5bUVoUFV2VkxNT3ZsTi9zUkl6?=
 =?utf-8?B?SG5xVWkxSjgyeFVhVmZKMEdhb29EQ2pMQWl6UGx3YS9pVUd2a2owKzN0K3po?=
 =?utf-8?B?RWdVSUZmdGNOTnB2eE5SZm5vSllRVjFOSmZwaFVDUy9xUTFuN0ZBbkxrMG5h?=
 =?utf-8?B?Tk9HU3NEQVdJMUNIMVhuY2tObkU4empyVmlXL3pMeC9WaDFWWTlKdzFBK1Ey?=
 =?utf-8?B?RXRGZGxDUW9FTC9TdVMvcExjbkE4YWUzakxpQ0ZZODNRSmtScHV2bmlUQzh0?=
 =?utf-8?B?QlNzVzBrbHY0WGFRSzVwQ0RMR1ZXV3RnaGhvZ3FqdUdhNGV1T0FxcFNJNmsx?=
 =?utf-8?B?SmRoa2VKZFFzdmxjc2t5R1phTGg1Y2J3OVVpQVF2RGFNcGp5bTV1STVCcU15?=
 =?utf-8?B?bHJBbzVsMFZQTTROZ3RaYTJDdk9sSkdFN0R3cnpsMjVxY0w2eEtVL216NWg1?=
 =?utf-8?B?N3JMYzNNMzN6NlpObVJMbzlIVDVhSGtmam9pb1djRVduaHNhSVNDMk8wVlFr?=
 =?utf-8?B?Yzl4UG8yTmlIcTNCblBRbzVHLyszSStRbC9IN09LRzVLNjdKVm9FV2xvWUhD?=
 =?utf-8?B?b1FRQ1pwZ1FWT2lxVUNNUVRVaG13SXBjREZDeHVKVzFDSFFGaUpMT2ZOS1hK?=
 =?utf-8?B?MWxoMGlkWnh1dEl4MnMrL3pWZWFUV1d1MnVwb1RQekFWUG13TTlkTVBnZExM?=
 =?utf-8?B?dTg1RFllakIxand6dEZNWTJaRklIMXhYRFE2T0xzRlhMcW9PYmltR0lLdWJ0?=
 =?utf-8?B?UG4zTTBZV2ZLK0pvc3lPWURKMUt6RHNqZnU2cFVzdGNPSkNkU212T3ZwS0JW?=
 =?utf-8?B?S0NuQmNTRG1ZYkNoYkhvcDdKa1BSTnNpejV0QUIrd2xGQ1lpU2dwUjdaMVE4?=
 =?utf-8?B?ZXNlb1RGWjg3eGRsK3B6WEMrK2VzSG9zQ3hXSzdyaG55ZUZTOU9VRW5xQUJD?=
 =?utf-8?B?YmZzMGdPeUFESVMyQzRYaERhMUFtL3NRMnBnMjFNNlhKODdaK0lxZUNyOXRN?=
 =?utf-8?B?WmFWUjVUbDU4d1lJelpnc2VMYjl5NEpGVkV5NC9lekJZUnRta210ZXoyMHI1?=
 =?utf-8?B?YVUzMld2V2wwSWMyZEZ0MGJ6Y1hHQjFzNnhnaWVKQkEwTmQ5cEJkRzh2M2tY?=
 =?utf-8?B?NXZOeXE4VXVYdTVWMUlxS2JkMkI3SkhETU1HRUgrUVJOWS8rTG5aeS9xcWlG?=
 =?utf-8?B?R09RWGNNcUJlZDF0K1E3dG8vc3hEclpuTGlZVzFwMWJkQXF5SW5oU21YN0k1?=
 =?utf-8?B?bGl3UG5BNDg2VUZYUjBHQnBNMWlnUGEvUm5ic2ljdUszZ1dDUlhkK3dxYUJh?=
 =?utf-8?B?WjBkZXBkSU9QQ2ErdjN2RHRUeVJmWUJNYTNxekRUUXBEYlBsWjh0ZVBXWis2?=
 =?utf-8?B?K1ZDNkE0Y3RoNi9wSWprVkpyQlYra212WlVqYmJSajZYSUpnSnh0c3ZSZkQ5?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 30Jd016RYdRjOs4hAWBVz06O5i3sbR606KjyztCMORpsMbEOz0TmL6odlLuZJi+QjEL1Yl4r9BUIK8cKhxbm1oFdbaNnktkyF07QGGm9KikU1dik1iH9kQr3HnDfjiSbokWKc/oZKysZfgSZ+41U7nrtOijxBz1JgOZjwlffT6PeZkFceEO1C2BZbCGzCm4fW65Q32pklMYgb0fabCzLmhrJhFn1oFrdsgvWDm6OvnC6lmU61lwfL92l/YbNsxcewE3ecr+B0gBMDvPsRdQBwLHzTNq+VH/piEVE3ZBt8rkOsMh4iCH91gJA3orN108Cyt7gG1jRdO9K5+gYDdigMk5bXxYXnSw1ybcflTwF31+wjGxEMbQYk/uyNOmv4RRnPaqVcnGI0wZ5mCYvFoBIJLhKo3knVx688juIlnUH07H6b4N+zGWCdlUtA51JGQJgba2i73GIActcGu4qt25UQDY5esbAGMe/64OOmM0+3aaaKr/KyoQ5ZZrTsMdMfHfiy7R5DczbUuhF4N0m7LfF7+T1pJ81t1wOmY0as/TVoHW7PiHYG5799CGIZpucfpJZE3Y7bQ+MZ0zZvPw6eoRWVIGjVCqIiY1QTWZmE+lMQ/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54b3e19-3024-44e3-b13d-08dc3477fdb4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 14:01:54.3519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Kc8lykXIxip/dK0sT1S3ykmqkuX2KRXF3A8m3yY77PYQ3pHCRq+nQA5NFeX4KgUVGal9h8/NQjy9WxtJycZLQjdsQbxMkKf/28NR2bu3Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230102
X-Proofpoint-GUID: _gJMCrfz-zjU8d_t7u2hMcPFjEqK6hzt
X-Proofpoint-ORIG-GUID: _gJMCrfz-zjU8d_t7u2hMcPFjEqK6hzt
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

On 2/23/2024 1:01 AM, Philippe Mathieu-Daudé wrote:
> On 22/2/24 22:47, Steve Sistare wrote:
>> Generalize hmp_split_at_comma() to take any delimiter string, rename
>> as str_split(), and move it to util/strList.c.
>>
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/monitor/hmp.h  |  1 -
>>   include/qemu/strList.h | 24 ++++++++++++++++++++++++
>>   monitor/hmp-cmds.c     | 19 -------------------
>>   net/net-hmp-cmds.c     |  3 ++-
>>   stats/stats-hmp-cmds.c |  3 ++-
>>   util/meson.build       |  1 +
>>   util/strList.c         | 24 ++++++++++++++++++++++++
>>   7 files changed, 53 insertions(+), 22 deletions(-)
>>   create mode 100644 include/qemu/strList.h
>>   create mode 100644 util/strList.c
> 
> 
>> +#include "qapi/qapi-builtin-types.h"
>> +
>> +/*
>> + * Split @str into a strList using the delimiter string @delim.
>> + * The delimiter is not included in the result.
>> + * Return NULL if @str is NULL or an empty string.
>> + * A leading, trailing, or consecutive delimiter produces an
>> + * empty string at that position in the output.
>> + * All strings are g_strdup'd, and the result can be freed
>> + * using qapi_free_strList.
> 
> Note "qapi/qapi-builtin-types.h" defines:
> 
>   G_DEFINE_AUTOPTR_CLEANUP_FUNC(strList, qapi_free_strList)
> 
> Maybe mention we can also use:
> 
>   g_autoptr(strList)

Thanks Philippe.  If we get to V6 for this series, I will mention this,
and also mention g_autoptr(GStrv) in the header comment for strv_from_strlist.

- Steve

>> + */
>> +strList *str_split(const char *str, const char *delim);
>> +
>> +#endif
> 

