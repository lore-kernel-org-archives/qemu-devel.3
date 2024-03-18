Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080F0C54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmEcI-0007kR-Pb; Mon, 18 Mar 2024 11:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rmEcD-0007k6-Qy
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:09:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rmEc8-0000qX-Nb
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:09:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IDPQPg002542; Mon, 18 Mar 2024 15:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=nEmzLoVg8hPjaaWFpEutY42Qg8W+l0ZfoacAdw0xXwg=;
 b=O1d6D4g+JLTO/XRo9q1TiOzp7xj4c8p+uE/Kj4XtUgNaCIFjSr0yoVpRngpmM54xI0CH
 JCEWgIDxwTd3Lj0bTB3Jzrzo0TStqLsbV//CGp/iPpSnEKDmeEDPqAG7KOKKw2YsTdSd
 uxhm8w5qBpoxJP3S6v7FPEosulrk8G2sp/WfpeyB8zVxo7+WA/xFy9Q6mih56iApM7e5
 anFgLoPFZCgvdpjncCK1iXQaDfrd5TWq+Hki0FmHWWDFa+XwOgbIPBpvUGccHpiaoXYh
 s9TDJgS7e6ELWIrKrwwOJDEerd8LVrOjjWc3S9H9kCbrdhpKRdXVEFn1q0dxzjIBJaUI /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww21139ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 15:09:13 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42IDguIm003679; Mon, 18 Mar 2024 15:09:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v4yj3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 15:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrNM/qa35fnJbxTuVkPmnfh8yw6a6zTSnH0C0+JEHklhelMrkVGkIG7IPbLCYZvgPcW6g2y+U01ONdYvrjRejh/oWUx5uqoOOlhu7Ic4URZFAelbcwh1VlYcUq+yZIulILSi5RGdOxKsT5zYhGwVxTB/Yxqy+LTOCJoJHWXbtckeWsaDWymJgMuUrZal59AKNI/KqMjacshuevrWiCzqqyslpwSiIaIFyH+nBfwCad2dHiZNH/Rzdzp4TdYtsIYRY7PjV1lag2SwT575Ov4lI4+N7H8VhS5LhWKe10U11oz8K1p17xYWsFwaEX5+iik0D/b8Mjogp2gHa9DqO8t25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEmzLoVg8hPjaaWFpEutY42Qg8W+l0ZfoacAdw0xXwg=;
 b=InSn1RUvGwEG6lZDu9YCnmHjd288hg4Vu6bTtIdmFWSei2GmsK8EdPwYJdoYJhka6wLsXA4jjfiXFlNXdNWMskprRobCu0geH4MgnVGekuS7v3fik4dSCZjjXIcnTdQ6aKe2zYLhR66sioGFvGrgmXFC6VBgcrMi9GllgSPJWShcvqSAokTrqvols4SNJ7foaCWE6MSL/l+F6dKwj/7Gb5+ZdR1CRaZL4SHs+wh2yBJADsJdlDCJPNSCFxTtEV10DG4KUK2/qNy51ajsSSzJ2Nf36/q1FcyAM9BWZ05iknXFDVRFt9ofQ3ZgzzJm64dZmlQmiW6OaQWmd0Sz0F9uuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEmzLoVg8hPjaaWFpEutY42Qg8W+l0ZfoacAdw0xXwg=;
 b=pkI3e6c5nLoLgf1xXGATGUsggiQ46Xpe59qE0C1A1RnchNoihgqfHJNbrYQ1DDbwuEY+fOuT2GelU2YqG8DRUlLcbnfyssQFmy5enc5iikGmflOFpoWmDwtO5U4DxBL+w7b1el0cDyZrNjbuemJckrxcVuR/wRbd6houCPg8MVY=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 15:09:07 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 15:09:07 +0000
Message-ID: <71a09333-8fe8-4313-951e-b76417b45c13@oracle.com>
Date: Mon, 18 Mar 2024 15:09:00 +0000
Subject: Re: [PATCH v1 11/11] backends/iommufd: Introduce helper function
 iommufd_device_get_info()
Content-Language: en-US
To: eric.auger@redhat.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, qemu-devel@nongnu.org, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-12-zhenzhong.duan@intel.com>
 <db2f0780-7817-423b-a286-c3c67b95367c@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <db2f0780-7817-423b-a286-c3c67b95367c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf87453-1864-4fc3-7b4c-08dc475d5b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPKLngbFaFLxoQNfTYkeyeXz0ZEngw5bt1AS9LnyB37BX1rigkmVryHYXU+LyuJmfedviUjQaEaq2f4hqiPCu7elLfAmdNvBGQI8KWML5xwcQfGwwpZO4kzUT4yHEIwr7AO4ZXp/DxTccESkSMUGBxMGa12apfRE7QluIvBI3ECQxevYl4Luq35ngENDdvezxi2TMjbqnEqppdmXpJqh823EHeimPglyYptfV+sLAYv3wk9tIn4AjfDNKLfmBmys+DMnsScA3DRdsOiZkmwtuOE4ZcDjpEE11Gijl/sZgMGpFiNYl8prCIm22pSNWurvFCDj1Lk6FoK4AHvZ1Jbg+zsfS4k82aj/+6WNyBEJyM1ONDXrCW6ojGYNpCDw+3/xCYCrNJSBKEBLTyQgOjEeiMXaMbaOK1YT0EPr2eKbCSLn7r2bAOYgxCI87ecireriXKBrGJOmOdHZUjjEmrljWPL7h6inI1+z51Un238ozEPQ/MWMUvkCEwwVePjl0iERWpXS67jqEGvi0GnLK6cJfidbgJblvDwrjtKGNxbBhXB7AhmJYboCheIrZTIl8QyFeCu3iw44s2bFPyZCG1qHyLf47ktXTwlYRMVIV6MlXwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhkWkIwdnpCSEIzcldhbVkvaE43Q2YwSmNqa2NsY3ovNFBXVGdSTjlqaXJm?=
 =?utf-8?B?YWhVZHhYdzhwak9NL1VvMjlqS1lWRHNFYzBWajd4ZjN0YVVtMGl4ekpicnVJ?=
 =?utf-8?B?K1dNd2tBTmN6LzJ5WGNJWDJSaU12U1pQeXQ1czBGNGlsZGNhdkptN3Q0WmhC?=
 =?utf-8?B?dGswUTFBbSs5eG5tSHBwMnFBb3ZORjhvM01XVlM0cXo4OC82enBzWThHb1ZL?=
 =?utf-8?B?cndMcStMVWEzYWhzZUN6ZisrdDdmS05wQXArNnpRYW1CeVJDKy9kblFHekVw?=
 =?utf-8?B?NnAwTDMrUW5tcHVNZzM3dUxtWEFvWWNkS21mOFNzY1ZVSnpKcmdkN1FkRE9C?=
 =?utf-8?B?SzJraXVyVEkrTEV0RHZkdjRJcXpLQVg0cUFlTjAwUEdtaXBQU0pHVE9OWGV1?=
 =?utf-8?B?bG5wSkY5T01PNlE2VUMxUERtWGhYekRrSXdiM0dSalZaSXpvN0h5UFZLK0lI?=
 =?utf-8?B?cEZWb0t4YmxMRXhPLzBuQ3RmR2U5TDRZYmV3WGk5MGZMWkhIMVlMMzg3cFBn?=
 =?utf-8?B?bGc1QzRQaTFweVdaNGhZbDZDczRqaDQ1WWZ4cHp3RzVRL21Cb2UvM1Uyaldy?=
 =?utf-8?B?alBMWGllVWRNRldFRjBzOWVIRXpRTW9mL1FFZEpQYVlBZC9zaFRNa1o4a2Qw?=
 =?utf-8?B?b2VDNEV6U2ZxaHZHWEhtZWQwR0l5Zm9aMTlKd04wUUJaOXAwNVNtZ3JNNnJP?=
 =?utf-8?B?dzEyaFZheVhtenFXdlhpLzRqUVhSMkhpdXRHeGpoVUphWXpnc0pzOUpzK2RZ?=
 =?utf-8?B?RUNBaE1IUXlNbEdpNEJHTnZJL0tMYllpSWgyNnQ4TXFnZW1PSlJiRHgwRmh6?=
 =?utf-8?B?amVhMWJkTzIvOGU1dVNuYVFjc3c5cEc1YWFHSkFqQzM2S1RNRld3aFUwZDRN?=
 =?utf-8?B?bWFWeXpHZFRYbTY1T1lzWDRHTWMzc3ZxTDlCclQ2WFZkTXJiMkZVdHloMURr?=
 =?utf-8?B?UnRJbExnbkxMd2R4Y3Q4RUNoZHNOaUJ4emNOSGhJNTlaaFh3MTRlRDQ1bmdX?=
 =?utf-8?B?N3UyKzlpSHgvRlFRZ05mTFE1b2hVUzhZaVVuMjBreGgzMHFHSDlyTG9iSTNY?=
 =?utf-8?B?aHNxZDduQVFxVzNBSmNzK0xVYVFIUjVRcmFxbkpVbm9SSnBxYXd0V1YxNm1a?=
 =?utf-8?B?aENxTGMyd2cwUXZpaXFrL2JFODU4Um9seG5neDk0Y044ZERneDNwTm5nOXhJ?=
 =?utf-8?B?cngvei92bFdmcWFENjVXQmY5aW5RT2YyLzZEdkdFZWsvQ0dNbnlMN20wTExa?=
 =?utf-8?B?T0dlYXlaTHQycmYzRktaS3NYbEdFVzV1RnBZMzFneEhBM2F5RW8wU2JGZngr?=
 =?utf-8?B?cTNXNU9nWGtCRklHaGhFMTBQSk93c0k3RU9CbjdMWjY1ZTFFSythL056T1Rx?=
 =?utf-8?B?NkJvRER5WmlZa2k4eDI2Z25WUHpZdFY2WWJxQ1BJYTEzcWNEMkV6SmgydnVw?=
 =?utf-8?B?ZWRVYnhoZ2ZkMUp2MklLaVF0enJsenVjOGpQU0FzOHcvdktzOU01dXY0VW5F?=
 =?utf-8?B?d1JUUUN3ZEtoTll3djJ0UE1TOTYvVU9FaVYwSlMvV29aYUhweGh5eUhWeEFj?=
 =?utf-8?B?cG5BUThSQU9xaFhCdGtkekkrYkY3TFNqZm8xK0dXK0RmWVpFdjduMUIzd3k5?=
 =?utf-8?B?YUliN3QwZWxmWHc2NlA2Q3VVQnpiT1d3M0Y0S2U2d3Z2dm1BM21mVlhsd2tE?=
 =?utf-8?B?ZDVsb01CUlVIa09NVm5UcldGcE1ManZBUm1SV2tRbjJ1QndpNWxFRUQzOXR5?=
 =?utf-8?B?Y0Z1WTdHbkpqcjNsTFFwU0h1UUhHVW1rQVQ1S2ZnalZEM05Bd29nUnVGWmln?=
 =?utf-8?B?azJubS9VcXk0dTJWWjlweFJHZXpsYXBsTGZkTG1sZWxDYnAyVnc0UVJOUmd4?=
 =?utf-8?B?SjFYT2czVU1XU1RqODF1bVorOHhnQ0oyaHYxa0pmTEs0TEVvR3k2K0NyS0Ro?=
 =?utf-8?B?WlZtbHI4bFkrRitpSW9IeHZsVllzdG9TQUxHRjlCL3RNQWJxdUlzaDUzT0JL?=
 =?utf-8?B?ZDlmbGRqWUM2V3UzcCtNSkdJWnZoTlQ3c3pTVzNBRWNqV2hxbk1VQWpCQzVB?=
 =?utf-8?B?QVlXVlpXMUNwOUhuWnk3MXlVK25SczFGSFZPQ3U4MUtGanJFbXRidWpRUGUr?=
 =?utf-8?B?ajNidHZHdDE2NzJLTnZCQTl2eTAybzFsYW4wclFPSEp3T015Y1JQMTVEVFh2?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q+93q0RuH9RQMbkq+7gRf6qQJKZayjl2/7LrCoDm6R5MsV2JBuA/agr8AuMyeWHiMG39sls4OWevG8Ko73PcqrfDtcaXX0z5XvJ5oIUEgrq3ZMdC3Ge/K0VjSFWiOGxK7ELNZCOLrokJCNgjJJNavE2c8JwY4Rx3bcm3oE6lfFD0bJQB4ixNkzdIw6+tK42sMeoaJ9lD7zxK5fWSJJI1c1HQJUIEAEV7qPGRHMEfcsZWPoDmpyUxnKR0587XTLwRMR8mkhAZTJ+YWAB5i3XgdEZ9LN5aFPcMRztUwgI84UaZ5K4JG/aUlzXUSvX4cORnB9Jv1y8GA9CqRKkouNoVYFFiT1Kwey+f2E6gxA5bafOncPE+5mKzG8Xm/3VaL0mY3kHM/eOgEd4m0vHl0DxiVNsH36IcjsWtR7saOw31ATWA8H861mFMkmwHdur0K/u0kTxo8dSHhwdEwQ6g5BkYQw5DVdzKqtiNWwisj2T9knSUUEjPz23GsNZH02mFYqbb9a0yCFe0E1VY73n0Pc+PL28HMZzt1puGzz18677WIW22SXv9sAlP+J1IIhTsCm2m00nQmID/DpYZPe2OSOlPC6pZ8laPAqGROcNw1xol+0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf87453-1864-4fc3-7b4c-08dc475d5b9d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:09:07.6717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xF3RL+WJ08mIW1KG4hGYb/UeXuX5X4JrKHRggBEpovG34WbUlBJXXbDDdOMhd3Dl3MP7JYv3sOq/OcoWPKaCezoFFXRmlXhqxa94ua/iUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_06,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403180113
X-Proofpoint-GUID: YYcvKtx80r86hFIvTDzE4DQT5TafKGGQ
X-Proofpoint-ORIG-GUID: YYcvKtx80r86hFIvTDzE4DQT5TafKGGQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 18/03/2024 07:54, Eric Auger wrote:
> Hi Zhenzhong,
> 
> On 2/28/24 04:59, Zhenzhong Duan wrote:
>> Introduce a helper function iommufd_device_get_info() to get
>> host IOMMU related information through iommufd uAPI.
> Looks strange to have this patch in this series. I Would rather put it
> in your second series alongs with its user.
> 

The reason it was here was to use this helper for this patch:

https://lore.kernel.org/qemu-devel/20240212135643.5858-2-joao.m.martins@oracle.com/

Instead of me having my own alternate helper.

Though at the same time, Zhenzhong will also make use of it in his second series.

> Eric
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/sysemu/iommufd.h |  4 ++++
>>  backends/iommufd.c       | 23 ++++++++++++++++++++++-
>>  2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index d509ff88ef..518b97bfed 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -4,6 +4,7 @@
>>  #include "qom/object.h"
>>  #include "exec/hwaddr.h"
>>  #include "exec/cpu-common.h"
>> +#include <linux/iommufd.h>
>>  #include "sysemu/host_iommu_device.h"
>>  
>>  #define TYPE_IOMMUFD_BACKEND "iommufd"
>> @@ -48,4 +49,7 @@ typedef struct IOMMUFDDevice {
>>  
>>  void iommufd_device_init(IOMMUFDDevice *idev,
>>                           IOMMUFDBackend *iommufd, int devid);
>> +int iommufd_device_get_info(IOMMUFDDevice *idev,
>> +                            enum iommu_hw_info_type *type,
>> +                            uint32_t len, void *data, Error **errp);
>>  #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 6d280e4aea..69f3f75ea5 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -20,7 +20,6 @@
>>  #include "monitor/monitor.h"
>>  #include "trace.h"
>>  #include <sys/ioctl.h>
>> -#include <linux/iommufd.h>
>>  
>>  static void iommufd_backend_init(Object *obj)
>>  {
>> @@ -240,3 +239,25 @@ void iommufd_device_init(IOMMUFDDevice *idev,
>>      idev->iommufd = iommufd;
>>      idev->devid = devid;
>>  }
>> +
>> +int iommufd_device_get_info(IOMMUFDDevice *idev,
>> +                            enum iommu_hw_info_type *type,
>> +                            uint32_t len, void *data, Error **errp)
>> +{
>> +    struct iommu_hw_info info = {
>> +        .size = sizeof(info),
>> +        .dev_id = idev->devid,
>> +        .data_len = len,
>> +        .data_uptr = (uintptr_t)data,
>> +    };
>> +    int ret;
>> +
>> +    ret = ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno, "Failed to get hardware info");
>> +    } else {
>> +        *type = info.out_data_type;
>> +    }
>> +
>> +    return ret;
>> +}
> 


