Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9F5CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 06:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rruVC-00052g-FU; Wed, 03 Apr 2024 02:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rruVA-00052Y-CF
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 02:53:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rruV7-0000CQ-3q
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 02:53:40 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4334pSk7024858; Wed, 3 Apr 2024 06:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=lJc9JdgnPmvQYn6CnuMJ0aFPDx5omTYY3JoKs5dqCUo=;
 b=HnZ0KKu65oTH0SEty3a+MsOdbjaNWfl/dwz5E7J3zLSvwN0AR1sjtdA1INvSRHwnU5Jw
 r8wlM74B81nje9olpSrJfa0VKJTCh5bfI1n3l7E2D/U6oKrAZIklRMORQzq62hiVjtup
 6Eoxx7b7dswbsX0SmkNfHoMtlgXi1Bfzvt7AODGN3sETN6Pe8fPWQXQnnK4NE5j2KLtu
 3IBsPrtsqwf3PRS6DbPfDfhDQlM9hlaqvzkvrR1dcTKIvv8y2lbHlYWkY7zgomTQFSRb
 TIL27HxQ5YtRBtrWBiglt28T+gTItnS99D+ujngoV+eIsc0HmWVGIqUo36eEhzPpDM1y VA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69ncpecs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Apr 2024 06:53:31 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43350Bht015403; Wed, 3 Apr 2024 06:53:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3x6967ve55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Apr 2024 06:53:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPAIYds7QaURiBIfwV95iqH3ndZXi9Ztb47K9wq3Tv26GC1WswbZrZbCFA9tQ0v3QMn6uCEAw6oLs/7WfTlCZmveHfiaHnBT5p6aeEGRuFxwPD0icIkKjA/2Jk4fR9uTJHhcfnex17uVDKngMsoGmLMhj4krGt7vMKsMjbHdjpivqL+7/eicV6E0KdoCSoHdQZe2l2n93OnVa1OH9ciHvAjm3vntJOxWjeoLXE9L6IUKsZ704Uf1fxa+UTn1fLpnCpHbb+fmPahxBOac+HXZkJjZ2TaqHuGLC7l9MWn3aYgarSqTc5n2gVB1behavmsoeq9gkgeZ2hocUzcsT9Al8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJc9JdgnPmvQYn6CnuMJ0aFPDx5omTYY3JoKs5dqCUo=;
 b=c/eNiss+bMnuD+q3RPydWxaxfJhELV3G1V74vdLiqCrtMP1vYD5/3/bNtRHBB9dI6flnRyqByOe/09/XK5BCcTV3IH6ALncePtSsuGRKYgNVpDScZLkG6iJ+21yGnCvo7ConIik2Ps4LHgJ6DN6FFtJsVQLAPSVvmM1PQzsT7dSR1quzMb51HDowcy7GtwagPgIBW+G+ukiAXAY1SXFVJPlIhLOhoM6/E+GNcXS/4KyFoa9T9sE8iFccxsct6IpKOahqSwfnvSR94TUtN8/xoA52mlL4wRX4G6HrZuxIuOsm/0t18sneb4UZL04z8lSlZ4to2kUaV6QzNimWi/CuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJc9JdgnPmvQYn6CnuMJ0aFPDx5omTYY3JoKs5dqCUo=;
 b=cw3YJDILBsYHNvZSriMHYJ+/4MDJbqYIcWXpTa6G6zohBT5is3IAVYJ4mTvg/u0pLn0XphW2CCy9ZzkcbdErzXxoI6rTPNfcmcWLjwy+VRdUFzZWxT2hTkXZZLud7xjAilbQBToXsMamdvyAXT92mjRI81WuVsMkbY+CJDzRN3Y=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7931.namprd10.prod.outlook.com (2603:10b6:610:1cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 06:53:25 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 06:53:25 +0000
Content-Type: multipart/mixed; boundary="------------pzFmwwj5TK6N00o1PE6zRZh0"
Message-ID: <cb5296a3-cca4-46a6-8f3e-a96fdb46b1a4@oracle.com>
Date: Tue, 2 Apr 2024 23:53:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
 <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
 <20240213052102-mutt-send-email-mst@kernel.org>
 <c45af489-0f0a-4fc7-ad03-4a513f8b338d@oracle.com>
 <CAJaqyWdDRqMEwVh6ZcVdnEZoXy-_9B2qk25eYcoVmeeTxgGm8g@mail.gmail.com>
 <58cf082c-fa54-48a6-aa49-e8b6cba60f53@oracle.com>
 <CAJaqyWc4aFOEQMu9iHTHOA-cMt9jRWeZteaaZk+8VPw8T9GV=w@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWc4aFOEQMu9iHTHOA-cMt9jRWeZteaaZk+8VPw8T9GV=w@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7931:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrsYmn1aBHxL1V+KpPcrauMrcctAAdpYVFvHn12gmhd+9vqjXD7LUDsbNjmWseAkUB2Pj59esrtkFqUrQhdq8uigpdJGsq+bpOl/uO/yTesNEz6cqS8eytiLrIh95zH5iJJDDDuKj6/0maLrYulMkGSovWRo8WwOtf1pb3MwSLTwOipQP9Y960vglNKo/+CXmk/9oBl4fYUpCnCX9K8CROVe8OmHubmoKT8baPQCn74WytY565RU0Pm7w/pp6wkuIE2AqO+VTpMiLmu4OXNT42IYlh63kA2k4zC5wphV6CxcdrRx8bFvhnDI0PbDg7YJpfPR5Ensk2f2Mu2GXOO0m8uVIJMm7/PrauQTYkX/nxKxx2+g/TmYkaCabei+Mr8pe9rIklh3ggnXPVM2S8fSZdKjUSREcv+ZfcukRLV2l83iMnHodrn7woAAAQxrGmvEzxRzicQ+/u2AQOTasLyfYJS3DOq10nAA0/gkVxPsEK+Quoq7rhHEmO/dfseWDR1J8bjEiJncLc+SNQCH4gwfrWlVt5qztiIWrR3jyWXgUohNsfSjmCHfIG8aNGYjPplXkgWTAnN6ubZnsNtTAsbkTfzLjKRNBCag+SnyLSxe5fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUQ4SEtWYkRBU2I2bUk2OFB5Q2NaSmZSMEVGeTNWVllKVGdkVHdnVm9pVWNv?=
 =?utf-8?B?U2kzOGh0ME13UFJacFMzWnEzVGJjUEU3enNyMnF4MjRubjdDMjFtZXA5ZXZp?=
 =?utf-8?B?ZXNlTUFDOFllYllSaThaSTErcEtRQW5XSWticzRTOTRqVjYwOERRL1dFaTRr?=
 =?utf-8?B?cmcrM3kwSjBncGZER3BhMHNySWhFWjUzZEdJWWt3aXhOZTN3Wi9GcWVwS29s?=
 =?utf-8?B?bHNGWXEvdUJQczhoTFZUV21uSUJodnN3eWhRdW9KTE9aam9yQXBVSkhRbVk2?=
 =?utf-8?B?M2UyREpGc2FEU3NzN1d3d05xd09SQ3FLd1huTXZzT2R4WDkrSjRqaU5CMzVx?=
 =?utf-8?B?M2tGM0FpWUs3MllsaU1lYldnaWo1M1U5QUgwRnJzNjdRTFFOU3RBUDBGSjJn?=
 =?utf-8?B?ZU85bktPdWhvcDZUcWdiYWoyQmpVNFpLbk5EblRkdWVuV3FVT0tXbWk2emY2?=
 =?utf-8?B?ZXRMSlhmT2FjZGdhVnFNbVlhd1dIckNWWGxwL3VOL2RyTnllZ2JCd210c0Qx?=
 =?utf-8?B?Q1h4QjdmcWVqVkxvVU04TU9PTFJGYVo4ejFDVkFGb2pPb20vQWxLck1JUlUy?=
 =?utf-8?B?QVhGOU1FNUVnR2NWQTE1dk1RdFRMQlZZblRpNlVWbGJIL2dOakg3OVRpcWNa?=
 =?utf-8?B?eFc2NnNkYnNIZGVlYTVQbnkzUjd4VUMvL0xIQm91ZVkybmMwTGY2b0R5Z1ND?=
 =?utf-8?B?NXJEVWNJSjg5ZWNHa2VkYUcyMW9idzV0cVF3bXBSVS9MOFk1NlJUb0ZMZm00?=
 =?utf-8?B?TjdkWmV3NG5jeDh5U2o5TkQ4cXhXU1lWcDBOZVU5emd3Z29ZMXM4OTVVdlV2?=
 =?utf-8?B?V0EvYy9JZTcxa1hUOW5QUkwzYng5OWdGWmQvemgzNlhWQW0xWGwxYjFRQU52?=
 =?utf-8?B?VFFGZWFpWDFkSjVXZGs3VlBRbkpxai92ZXdTUGdubkNTR2dlcUVmN01XbmVS?=
 =?utf-8?B?N05aWFhKWnJLU1JZWnphYlNiWDFadHJGTGRtbmJsbitUZGhJMld6QmxWVkVj?=
 =?utf-8?B?VUtXWHRBNGlYb0xSelAxSzlId3p1LytabjZ3cS9vOVdpTTgzTndXdzVJOW5U?=
 =?utf-8?B?ZGRDWW54NUc1TTV5MEtCZnFFVDhBMjFFMlRkUkd3c1VYVEpSeFF5T2VqVVlq?=
 =?utf-8?B?c3lRc0FVM3JJeTJIeWg3MGU5UzI2a0dSQk1SSnFWMHVIVDZFNDR1OUx4cWEx?=
 =?utf-8?B?aXBLNXhpSTZFU2E5ckM5b3ZUeXJYTnRVb3dDRkZqV3hmSFdWRUxSTFFtWjJm?=
 =?utf-8?B?Q0dBMi9zQTczOUhvcGxtQ05wMzcvM3M5NTl2RWZuN0s1cTVhaUk0WWdMemlt?=
 =?utf-8?B?bUwyNW16ZU83MTB4UmdHWWkwSndQUHNmUjltdzlISHVyWmR0ZlA1T09sV1E3?=
 =?utf-8?B?aWV5bTFsTmJVRG1ETlYyN3JSa3JKZEdOT1FoRjVQZzc4b0ZYN2xlSm1DRHJP?=
 =?utf-8?B?YzQwNnBYeHl6TmNwZHN6cmVuYWNzZUhKWStPNzJqNlFhNTVGTzRCWEFod2xq?=
 =?utf-8?B?NzJSMFJqK2p6RTYyN1RHcXRqd09GTC9XcjlsNHdMbmFNTnFUSjVSMUNya0tZ?=
 =?utf-8?B?TkU0TmdtRFVKaHkzYUxwZHJ0TFRDaXRSL2ppMWVPbmg4ZWxzeTREa2JEMFlH?=
 =?utf-8?B?VFFZUHhvNVk3T20razlMZ2w3ZXZZNGdCWW5iV0RDbFNJSmZJMW5hQUhkamd6?=
 =?utf-8?B?YlVhcERxWHZoYlF6TjdlN0t0WmFiNHFiUGFkZWQxTktDcUlPaWFKeW5xMXVK?=
 =?utf-8?B?TExFdGlaQWRVNVNHQ2R3VjBla1d5enNNOTE5Q3BLSC9aUmUwWnVyMnV3MjZD?=
 =?utf-8?B?Y1FaanByRStDYzV3eTFvM2JoYzdoZlJ2OURuQW1CWnhlVStXb09iYjBrYXBi?=
 =?utf-8?B?M2JaOW5WUkZBSVdodXJ0SjdPM1g1Zm0waHNUZFpyWGdUamkxRU5TNVNOY0VZ?=
 =?utf-8?B?eGp4T1BjRUpuSWpTeUNlTUxBUVBZVlhSVkNrZGRkSTc2THphSzRzaW5JQWJC?=
 =?utf-8?B?d201dG1YN2R4eW54K213KzZucktsb1pGVzlxdWtTMUtxeHo3QkxFYmF4QzQ3?=
 =?utf-8?B?WXByZ3lkVERRSTFWZUpPMW9ub3JDaFluUzl0TVN5T0RMZ1IrSkdsdjh2cFBN?=
 =?utf-8?Q?//4K26TD0T0DKc3JO/Uy6FbhC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TmtliaWjzzMgh9A6LiXX/ifymdJr81M47VvQ3I0+UiXtoYjWzAiKDiVVCl2sINA8Mj2T8O1ZD5WtbOQ72DRRkCtjT868NkM1Eo5cHJ6quBYm5iGo6PQb4ZMfQlsyZQE4cQAMnlzF0JqdOmH7ZLoOER0ZMDbk82E/Yicm2+8QvD/DkG4ZgdGZcnItifcqcfr52BTO43YQDylKpOWVp3wW+knhC8aPsITFsf3WPYgd5FiZAn4uA5kZzYGLEyiqLYnEUklEOHsh8UfzhYCRHM+NEykj5S9nhDgemvn3GevBLM39Uv+SOWE8HUbNw4r/Fh2BJcn++Hs0OQ+4fFQ4Ww2mNJU4WyNlCWy0DdHfUDeJS0fNO/jX8j9puIzvwQ7ok/C2HA0Loxdr3kpxuCTkfDAQ28DHcUmUcpOW+HwgG2uySRMzCZWgPNK+trDjK+w309yQxGC99eqyp0j1DJmYZ+qrHPDgIyZ6erlps7FvnyPMQI2UsJkeZwQ1FhjrqrBUXgpn8PhqnO/IXmmjFVvjrVf/EeqqN5s4NOyXdouQUErntVpZ/K9MkGgVM+sugdIOYaInTILL4FeoVvPYu1F3jNiM1p9bigsLBUVNPUSbLbUCoCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d840faf5-20bc-4f62-7167-08dc53aac270
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 06:53:25.3451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1lyq14dlb5PK1y8zbweSp1rhF1sMCYK4ySlx+SLfMhQEyritPdAwYtBpLuB+dKx0Y49maXgE7W2o//APY7PKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030046
X-Proofpoint-GUID: B5X9zbpXB9g7azDNSnueKP65hDRAaPnj
X-Proofpoint-ORIG-GUID: B5X9zbpXB9g7azDNSnueKP65hDRAaPnj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------pzFmwwj5TK6N00o1PE6zRZh0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/2/2024 5:01 AM, Eugenio Perez Martin wrote:
> On Tue, Apr 2, 2024 at 8:19 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 2/14/2024 11:11 AM, Eugenio Perez Martin wrote:
>>> On Wed, Feb 14, 2024 at 7:29 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> Hi Michael,
>>>>
>>>> On 2/13/2024 2:22 AM, Michael S. Tsirkin wrote:
>>>>> On Mon, Feb 05, 2024 at 05:10:36PM -0800, Si-Wei Liu wrote:
>>>>>> Hi Eugenio,
>>>>>>
>>>>>> I thought this new code looks good to me and the original issue I saw with
>>>>>> x-svq=on should be gone. However, after rebase my tree on top of this,
>>>>>> there's a new failure I found around setting up guest mappings at early
>>>>>> boot, please see attached the specific QEMU config and corresponding event
>>>>>> traces. Haven't checked into the detail yet, thinking you would need to be
>>>>>> aware of ahead.
>>>>>>
>>>>>> Regards,
>>>>>> -Siwei
>>>>> Eugenio were you able to reproduce? Siwei did you have time to
>>>>> look into this?
>>>> Didn't get a chance to look into the detail yet in the past week, but
>>>> thought it may have something to do with the (internals of) iova tree
>>>> range allocation and the lookup routine. It started to fall apart at the
>>>> first vhost_vdpa_dma_unmap call showing up in the trace events, where it
>>>> should've gotten IOVA=0x2000001000,  but an incorrect IOVA address
>>>> 0x1000 was ended up returning from the iova tree lookup routine.
>>>>
>>>> HVA                    GPA                IOVA
>>>> -------------------------------------------------------------------------------------------------------------------------
>>>> Map
>>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
>>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
>>>> [0x80001000, 0x2000001000)
>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
>>>> [0x2000001000, 0x2000021000)
>>>>
>>>> Unmap
>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
>>>> 0x20000) ???
>>>>                                        shouldn't it be [0x2000001000,
>>>> 0x2000021000) ???
>>>>
>> It looks the SVQ iova tree lookup routine vhost_iova_tree_find_iova(),
>> which is called from vhost_vdpa_listener_region_del(), can't properly
>> deal with overlapped region. Specifically, q35's mch_realize() has the
>> following:
>>
>> 579     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch),
>> "smram-open-high",
>> 580                              mch->ram_memory,
>> MCH_HOST_BRIDGE_SMRAM_C_BASE,
>> 581                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
>> 582     memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
>> 583 &mch->open_high_smram, 1);
>> 584     memory_region_set_enabled(&mch->open_high_smram, false);
>>
>> #0  0x0000564c30bf6980 in iova_tree_find_address_iterator
>> (key=0x564c331cf8e0, value=0x564c331cf8e0, data=0x7fffb6d749b0) at
>> ../util/iova-tree.c:96
>> #1  0x00007f5f66479654 in g_tree_foreach () at /lib64/libglib-2.0.so.0
>> #2  0x0000564c30bf6b53 in iova_tree_find_iova (tree=<optimized out>,
>> map=map@entry=0x7fffb6d74a00) at ../util/iova-tree.c:114
>> #3  0x0000564c309da0a9 in vhost_iova_tree_find_iova (tree=<optimized
>> out>, map=map@entry=0x7fffb6d74a00) at ../hw/virtio/vhost-iova-tree.c:70
>> #4  0x0000564c3085e49d in vhost_vdpa_listener_region_del
>> (listener=0x564c331024c8, section=0x7fffb6d74aa0) at
>> ../hw/virtio/vhost-vdpa.c:444
>> #5  0x0000564c309f4931 in address_space_update_topology_pass
>> (as=as@entry=0x564c31ab1840 <address_space_memory>,
>> old_view=old_view@entry=0x564c33364cc0,
>> new_view=new_view@entry=0x564c333640f0, adding=adding@entry=false) at
>> ../system/memory.c:977
>> #6  0x0000564c309f4dcd in address_space_set_flatview (as=0x564c31ab1840
>> <address_space_memory>) at ../system/memory.c:1079
>> #7  0x0000564c309f86d0 in memory_region_transaction_commit () at
>> ../system/memory.c:1132
>> #8  0x0000564c309f86d0 in memory_region_transaction_commit () at
>> ../system/memory.c:1117
>> #9  0x0000564c307cce64 in mch_realize (d=<optimized out>,
>> errp=<optimized out>) at ../hw/pci-host/q35.c:584
>>
>> However, it looks like iova_tree_find_address_iterator() only check if
>> the translated address (HVA) falls in to the range when trying to locate
>> the desired IOVA, causing the first DMAMap that happens to overlap in
>> the translated address (HVA) space to be returned prematurely:
>>
>>    89 static gboolean iova_tree_find_address_iterator(gpointer key,
>> gpointer value,
>>    90                                                 gpointer data)
>>    91 {
>>    :
>>    :
>>    99     if (map->translated_addr + map->size < needle->translated_addr ||
>> 100         needle->translated_addr + needle->size < map->translated_addr) {
>> 101         return false;
>> 102     }
>> 103
>> 104     args->result = map;
>> 105     return true;
>> 106 }
>>
>> In the QEMU trace file, it reveals that the first DMAMap as below gets
>> returned incorrectly instead the second, the latter of which is what the
>> actual IOVA corresponds to:
>>
>> HVA                                                             GPA                                             IOVA
>> [0x7f7903e00000, 0x7f7983e00000)        [0x0, 0x80000000)                       [0x1000, 0x80001000)
>> [0x7f7903ea0000, 0x7f7903ec0000)        [0xfeda0000, 0xfedc0000)        [0x2000001000, 0x2000021000)
>>
> I think the analysis is totally accurate as no code expects to unmap /
> map overlapping regions. In particular, vdpa kernel does not expect it
> either.

Maybe I missed something, but I don't see how vdpa kernel prohibits this 
overlapping case? The same HVA gets remapped under a different GPA or 
IOVA range should be a valid use case it seems? For e.g. I don't see 
mapping failure when x-svq=on was removed from QEMU's vhost-vdpa 
arguments (where you can see in the attached trace, mch_realize with the 
exactly same overlapping region got remapped successfully, and then got 
unmapped right after).

> Since it is issued at _realize, it should be ok to unmap all the
> region range and then map the right range again, even if that implies
> a lot of unpin / pin.
You'll find out mch_realize() already did that -  where line 582 is to 
create a mapping overlapped with entire range, while line 583 is to 
disable (unmap) this same mapping shortly after.

582     memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
583 &mch->open_high_smram, 1);
584     memory_region_set_enabled(&mch->open_high_smram, false);

So we don't have to add any special case to deal with these overlapping 
case (just use the GPA as the hint to help identify which iova range it 
tries to unmap), as the vdpa's memory listener now moves upfront to the 
earliest point of time at machine boot, the relevant SVQ code needs to 
be more flexible and tolerate to the extra churns for the rest of QEMU's 
subsystems to stabilize the guest memory layout.
>> Maybe other than check the HVA range, we should also match GPA, or at
>> least the size should exactly match?
>>
> The safe actions here would be to unmap all the memory chunk and then
> map the overlap memory? Or am I missing something?
>
> Another thing I don't get, is this reproducible in previous versions?
It is not reproducible without this series. I thought that may be 
because previously the vhost-vdpa's memory listener was registered at a 
later point of time, after all the overlapped regions are gone and the 
memory layout is completely stabilized. Now we move registration to the 
init time, then all the devils come out biting us.

Previous versions of this patch series we didn't get this far yet, when 
x-svq=on is specified.

https://lore.kernel.org/qemu-devel/92ecfd90-8d06-4669-b260-a7a3b106277e@oracle.com/
> As far as I understand, this bug was never found before. I guess this
> path of q35's mch_realize is recent?
No, it's been there for quite a while.

Cheers,
-Siwei
>
> Thanks!
>
>>> Yes, I'm still not able to reproduce. In particular, I don't know how
>>> how the memory listener adds a region and then release a region with a
>>> different size. I'm talking about these log entries:
>>>
>>> 1706854838.154394:vhost_vdpa_listener_region_add vdpa: 0x556d45c75140
>>> iova 0x0 llend 0x80000000 vaddr: 0x7f7903e00000 read-only: 0
>>> 452:vhost_vdpa_listener_region_del vdpa: 0x556d45c75140 iova 0x0 llend
>>> 0x7fffffff
>> Didn't see a different size here, though if you referred to the
>> discrepancy in the traces around llend, I thought the two between _add()
>> and _del() would have to be interpreted differently due to:
>>
>> 3d1e4d34 "vhost_vdpa: fix the input in
>> trace_vhost_vdpa_listener_region_del()"
>>
>> Regards,
>> -Siwei
>>> Is it possible for you to also trace the skipped regions? We should
>>> add a debug trace there too...
>>>
>>> Thanks!
>>>
>>>> PS, I will be taking off from today and for the next two weeks. Will try
>>>> to help out looking more closely after I get back.
>>>>
>>>> -Siwei
>>>>>     Can't merge patches which are known to break things ...

--------------pzFmwwj5TK6N00o1PE6zRZh0
Content-Type: text/plain; charset=UTF-8; name="qtrace-success-no-x_svq_on.out"
Content-Disposition: attachment; filename="qtrace-success-no-x_svq_on.out"
Content-Transfer-Encoding: base64

KyBxZW11LXN5c3RlbS14ODZfNjQgLW5vLXVzZXItY29uZmlnIC1ub2RlZmF1bHRzIC1tYWNoaW5l
IHR5cGU9cGMtcTM1LTguMCxkdW1wLWd1ZXN0LWNvcmU9b2ZmLGFjY2VsPWt2bSxrZXJuZWxfaXJx
Y2hpcD1zcGxpdCAtY3B1IEVQWUMgLXNtcCA4LHNvY2tldHM9MSxjb3Jlcz04LHRocmVhZHM9MSAt
bSBzaXplPThHLHNsb3RzPTgsbWF4bWVtPTI1NkcgLXFtcCB1bml4Oi90bXAvcSxzZXJ2ZXIsbm93
YWl0IC1zZXJpYWwgbW9uOnN0ZGlvIC1kcml2ZSBmaWxlPS91c3Ivc2hhcmUvT1ZNRi9PVk1GX0NP
REUucHVyZS1lZmkuZmQsaW5kZXg9MCxpZj1wZmxhc2gsZm9ybWF0PXJhdyxyZWFkb25seT1vbiAt
ZHJpdmUgZmlsZT0vdXNyL3NoYXJlL09WTUYvT1ZNRl9WQVJTLnB1cmUtZWZpLmZkLGluZGV4PTEs
aWY9cGZsYXNoLGZvcm1hdD1yYXcgLWRyaXZlIGlkPWRpc2swLGlmPW5vbmUsZm9ybWF0PXFjb3cy
LGZpbGU9L3Jvb3QvdmRwYS90b29scy9pbWFnZXMvVk0tZWw3LjktdWVmaS14ODZfNjQucWNvdzIg
LWRldmljZSB2aXJ0aW8tYmxrLXBjaSxkcml2ZT1kaXNrMCAtbmV0ZGV2IHR5cGU9dmhvc3QtdmRw
YSx2aG9zdGRldj0vZGV2L3Zob3N0LXZkcGEtMCxpZD12aG9zdC12ZHBhMCwgLWRldmljZSB2aXJ0
aW8tbmV0LXBjaSxuZXRkZXY9dmhvc3QtdmRwYTAsaWQ9dmRwYTAsYm9vdGluZGV4PS0xLHBhZ2Ut
cGVyLXZxPW9uLG1hYz1lNDoxMTpjNjpkMzo0NTpmMCxjdHJsX3ZxPW9uLG1xPW9uLGN0cmxfdmxh
bj1vZmYsdmVjdG9ycz02LGhvc3RfbXR1PTkwMDAsbXJnX3J4YnVmPW9uLHJ4X3F1ZXVlX3NpemU9
MTAyNCxkaXNhYmxlLWxlZ2FjeT1vbiAtbXNnIHRpbWVzdGFtcD1vbiAtLXRyYWNlIGV2ZW50cz0v
dG1wL2UKOTM3MUAxNzEyMTIwMDk2LjIzMTc0Mzp2aG9zdF92ZHBhX2luaXQgZGV2OiAweDU2NDFl
YmJlYTY1MCwgY29tbW9uIGRldjogMHg1NjQxZWI5NzJmZDAgdmRwYTogMHg3ZjZhOTY4ZDcxOTAK
OTM3MUAxNzEyMTIwMDk2LjIzMTc2OTp2aG9zdF92ZHBhX2dldF9mZWF0dXJlcyBkZXY6IDB4NTY0
MWViYmVhNjUwIGZlYXR1cmVzOiAweDMwMGMzOTgyYgo5MzcxQDE3MTIxMjAwOTYuMjMxNzc0OnZo
b3N0X3ZkcGFfYWRkX3N0YXR1cyBkZXY6IDB4NTY0MWViYmVhNjUwIHN0YXR1czogMHgzCjkzNzFA
MTcxMjEyMDA5Ni4yMzE3ODE6dmhvc3RfdmRwYV9zZXRfb3duZXIgZGV2OiAweDU2NDFlYmJlYTY1
MAo5MzcxQDE3MTIxMjAwOTYuMjMxNzg4OnZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzIGRldjogMHg1
NjQxZWJiZWE2NTAgZmVhdHVyZXM6IDB4MzAwYzM5ODJiCjkzNzFAMTcxMjEyMDA5Ni4yMzE3OTE6
dmhvc3RfdmRwYV9tZW1zbG90c19saW1pdCBkZXY6IDB4NTY0MWViYmVhNjUwID0gMHg3ZmZmZmZm
Zgo5MzcxQDE3MTIxMjAwOTYuMjMxNzk1OnZob3N0X3ZkcGFfZ2V0X3ZxX2luZGV4IGRldjogMHg1
NjQxZWJiZWE2NTAgaWR4OiAwIHZxIGlkeDogMAo5MzcxQDE3MTIxMjAwOTYuMjMxODAyOnZob3N0
X3ZkcGFfc2V0X3ZyaW5nX2NhbGwgZGV2OiAweDU2NDFlYmJlYTY1MCBpbmRleDogMCBmZDogMTcK
OTM3MUAxNzEyMTIwMDk2LjIzMTgwNzp2aG9zdF92ZHBhX2dldF92cV9pbmRleCBkZXY6IDB4NTY0
MWViYmVhNjUwIGlkeDogMSB2cSBpZHg6IDEKOTM3MUAxNzEyMTIwMDk2LjIzMTgxMjp2aG9zdF92
ZHBhX3NldF92cmluZ19jYWxsIGRldjogMHg1NjQxZWJiZWE2NTAgaW5kZXg6IDEgZmQ6IDE4Cjkz
NzFAMTcxMjEyMDA5Ni4yMzE4MTk6dmhvc3RfdmRwYV9nZXRfZGV2aWNlX2lkIGRldjogMHg1NjQx
ZWJiZWE2NTAgZGV2aWNlX2lkIDEKOTM3MUAxNzEyMTIwMDk2LjIzMTgzMjp2aG9zdF92ZHBhX2lu
aXQgZGV2OiAweDU2NDFlYmJlYWI3MCwgY29tbW9uIGRldjogMHg1NjQxZWI5NzJmZDAgdmRwYTog
MHg3ZjZhOTY4OGUxOTAKOTM3MUAxNzEyMTIwMDk2LjIzMTgzNzp2aG9zdF92ZHBhX2dldF9mZWF0
dXJlcyBkZXY6IDB4NTY0MWViYmVhYjcwIGZlYXR1cmVzOiAweDMwMGMzOTgyYgo5MzcxQDE3MTIx
MjAwOTYuMjMxODQwOnZob3N0X3ZkcGFfbWVtc2xvdHNfbGltaXQgZGV2OiAweDU2NDFlYmJlYWI3
MCA9IDB4N2ZmZmZmZmYKOTM3MUAxNzEyMTIwMDk2LjIzMTg0Mzp2aG9zdF92ZHBhX2dldF92cV9p
bmRleCBkZXY6IDB4NTY0MWViYmVhYjcwIGlkeDogMCB2cSBpZHg6IDAKOTM3MUAxNzEyMTIwMDk2
LjIzMTg0Nzp2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsIGRldjogMHg1NjQxZWJiZWFiNzAgaW5k
ZXg6IDAgZmQ6IDE5CjkzNzFAMTcxMjEyMDA5Ni4yMzE4NTE6dmhvc3RfdmRwYV9nZXRfdnFfaW5k
ZXggZGV2OiAweDU2NDFlYmJlYWI3MCBpZHg6IDEgdnEgaWR4OiAxCjkzNzFAMTcxMjEyMDA5Ni4y
MzE4NTY6dmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbCBkZXY6IDB4NTY0MWViYmVhYjcwIGluZGV4
OiAxIGZkOiAyMAo5MzcxQDE3MTIxMjAwOTYuMjMxODYwOnZob3N0X3ZkcGFfZ2V0X2RldmljZV9p
ZCBkZXY6IDB4NTY0MWViYmVhYjcwIGRldmljZV9pZCAxCjkzNzFAMTcxMjEyMDA5Ni4yNDI0ODE6
dmhvc3RfdmRwYV9pbml0IGRldjogMHg1NjQxZWJiZWIwOTAsIGNvbW1vbiBkZXY6IDB4NTY0MWVi
OTcyZmQwIHZkcGE6IDB4N2Y2YTk2ODQ1MTkwCjkzNzFAMTcxMjEyMDA5Ni4yNDI0OTE6dmhvc3Rf
dmRwYV9nZXRfZmVhdHVyZXMgZGV2OiAweDU2NDFlYmJlYjA5MCBmZWF0dXJlczogMHgzMDBjMzk4
MmIKOTM3MUAxNzEyMTIwMDk2LjI0MjQ5NDp2aG9zdF92ZHBhX21lbXNsb3RzX2xpbWl0IGRldjog
MHg1NjQxZWJiZWIwOTAgPSAweDdmZmZmZmZmCjkzNzFAMTcxMjEyMDA5Ni4yNDI0OTc6dmhvc3Rf
dmRwYV9nZXRfdnFfaW5kZXggZGV2OiAweDU2NDFlYmJlYjA5MCBpZHg6IDAgdnEgaWR4OiAwCjkz
NzFAMTcxMjEyMDA5Ni4yNDI1MDI6dmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbCBkZXY6IDB4NTY0
MWViYmViMDkwIGluZGV4OiAwIGZkOiAyMQo5MzcxQDE3MTIxMjAwOTYuMjQyNTA3OnZob3N0X3Zk
cGFfZ2V0X2RldmljZV9pZCBkZXY6IDB4NTY0MWViYmViMDkwIGRldmljZV9pZCAxCjkzNzFAMTcx
MjEyMDA5Ni4yNDYzMzU6dmhvc3RfdmRwYV9saXN0ZW5lcl9yZWdpb25fYWRkIHZkcGE6IDB4NTY0
MWViOTcyZmQwIGlvdmEgMHgwIGxsZW5kIDB4ODAwMDAwMDAgdmFkZHI6IDB4N2Y2ODdmZTAwMDAw
IHJlYWQtb25seTogMAo5MzcxQDE3MTIxMjAwOTYuMjQ2MzQ2OnZob3N0X3ZkcGFfbGlzdGVuZXJf
YmVnaW5fYmF0Y2ggdmRwYV9zaGFyZWQ6MHg1NjQxZWI5NzJmZDAgZmQ6IDE2IG1zZ190eXBlOiAy
IHR5cGU6IDUKOTM3MUAxNzEyMTIwMDk2LjI0NjM1Mjp2aG9zdF92ZHBhX2RtYV9tYXAgdmRwYV9z
aGFyZWQ6MHg1NjQxZWI5NzJmZDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTogMHgw
IHNpemU6IDB4ODAwMDAwMDAgdWFkZHI6IDB4N2Y2ODdmZTAwMDAwIHBlcm06IDB4MyB0eXBlOiAy
CjkzNzFAMTcxMjEyMDA5Ni40MjI0MTU6dmhvc3RfdmRwYV9saXN0ZW5lcl9jb21taXQgdmRwYV9z
aGFyZWQ6MHg1NjQxZWI5NzJmZDAgZmQ6IDE2IG1zZ190eXBlOiAyIHR5cGU6IDYKOTM3MUAxNzEy
MTIwMDk2LjQyNDQxNDp2aG9zdF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9hZGQgdmRwYTogMHg1NjQx
ZWI5NzJmZDAgaW92YSAweDEwMDAwMDAwMCBsbGVuZCAweDI4MDAwMDAwMCB2YWRkcjogMHg3ZjY4
ZmZlMDAwMDAgcmVhZC1vbmx5OiAwCjkzNzFAMTcxMjEyMDA5Ni40MjQ0MjQ6dmhvc3RfdmRwYV9s
aXN0ZW5lcl9iZWdpbl9iYXRjaCB2ZHBhX3NoYXJlZDoweDU2NDFlYjk3MmZkMCBmZDogMTYgbXNn
X3R5cGU6IDIgdHlwZTogNQo5MzcxQDE3MTIxMjAwOTYuNDI0NDI5OnZob3N0X3ZkcGFfZG1hX21h
cCB2ZHBhX3NoYXJlZDoweDU2NDFlYjk3MmZkMCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBp
b3ZhOiAweDEwMDAwMDAwMCBzaXplOiAweDE4MDAwMDAwMCB1YWRkcjogMHg3ZjY4ZmZlMDAwMDAg
cGVybTogMHgzIHR5cGU6IDIKOTM3MUAxNzEyMTIwMDk2Ljk1OTU2NTp2aG9zdF92ZHBhX2xpc3Rl
bmVyX2NvbW1pdCB2ZHBhX3NoYXJlZDoweDU2NDFlYjk3MmZkMCBmZDogMTYgbXNnX3R5cGU6IDIg
dHlwZTogNgo5MzcxQDE3MTIxMjAwOTYuOTY5OTUwOnZob3N0X3ZkcGFfbGlzdGVuZXJfcmVnaW9u
X2FkZCB2ZHBhOiAweDU2NDFlYjk3MmZkMCBpb3ZhIDB4ZmVkYTAwMDAgbGxlbmQgMHhmZWRjMDAw
MCB2YWRkcjogMHg3ZjY4N2ZlYTAwMDAgcmVhZC1vbmx5OiAwCjkzNzFAMTcxMjEyMDA5Ni45Njk5
NjI6dmhvc3RfdmRwYV9saXN0ZW5lcl9iZWdpbl9iYXRjaCB2ZHBhX3NoYXJlZDoweDU2NDFlYjk3
MmZkMCBmZDogMTYgbXNnX3R5cGU6IDIgdHlwZTogNQo5MzcxQDE3MTIxMjAwOTYuOTY5OTY3OnZo
b3N0X3ZkcGFfZG1hX21hcCB2ZHBhX3NoYXJlZDoweDU2NDFlYjk3MmZkMCBmZDogMTYgbXNnX3R5
cGU6IDIgYXNpZDogMCBpb3ZhOiAweGZlZGEwMDAwIHNpemU6IDB4MjAwMDAgdWFkZHI6IDB4N2Y2
ODdmZWEwMDAwIHBlcm06IDB4MyB0eXBlOiAyCjkzNzFAMTcxMjEyMDA5Ni45Njk5OTI6dmhvc3Rf
dmRwYV9saXN0ZW5lcl9jb21taXQgdmRwYV9zaGFyZWQ6MHg1NjQxZWI5NzJmZDAgZmQ6IDE2IG1z
Z190eXBlOiAyIHR5cGU6IDYKOTM3MUAxNzEyMTIwMDk2Ljk3Njc5Nzp2aG9zdF92ZHBhX2xpc3Rl
bmVyX3JlZ2lvbl9kZWwgdmRwYTogMHg1NjQxZWI5NzJmZDAgaW92YSAweGZlZGEwMDAwIGxsZW5k
IDB4ZmVkYmZmZmYKOTM3MUAxNzEyMTIwMDk2Ljk3NjgwNzp2aG9zdF92ZHBhX2xpc3RlbmVyX2Jl
Z2luX2JhdGNoIHZkcGFfc2hhcmVkOjB4NTY0MWViOTcyZmQwIGZkOiAxNiBtc2dfdHlwZTogMiB0
eXBlOiA1CjkzNzFAMTcxMjEyMDA5Ni45NzY4MTE6dmhvc3RfdmRwYV9kbWFfdW5tYXAgdmRwYV9z
aGFyZWQ6MHg1NjQxZWI5NzJmZDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTogMHhm
ZWRhMDAwMCBzaXplOiAweDIwMDAwIHR5cGU6IDMKOTM3MUAxNzEyMTIwMDk2Ljk3NjgzMzp2aG9z
dF92ZHBhX2xpc3RlbmVyX2NvbW1pdCB2ZHBhX3NoYXJlZDoweDU2NDFlYjk3MmZkMCBmZDogMTYg
bXNnX3R5cGU6IDIgdHlwZTogNgo5MzcxQDE3MTIxMjAwOTYuOTkxNzY0OnZob3N0X3ZkcGFfc2V0
X2NvbmZpZyBkZXY6IDB4NTY0MWViYmVhNjUwIG9mZnNldDogMCBzaXplOiA2IGZsYWdzOiAweDAK
OTM3MUAxNzEyMTIwMDk2Ljk5MTc3OTp2aG9zdF92ZHBhX2R1bXBfY29uZmlnIGRldjogMHg1NjQx
ZWJiZWE2NTAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCjkzNzFAMTcxMjEyMDA5Ni45OTc3MTU6dmhvc3RfdmRwYV9saXN0ZW5lcl9yZWdp
b25fZGVsIHZkcGE6IDB4NTY0MWViOTcyZmQwIGlvdmEgMHgwIGxsZW5kIDB4N2ZmZmZmZmYKOTM3
MUAxNzEyMTIwMDk2Ljk5NzcyODp2aG9zdF92ZHBhX2xpc3RlbmVyX2JlZ2luX2JhdGNoIHZkcGFf
c2hhcmVkOjB4NTY0MWViOTcyZmQwIGZkOiAxNiBtc2dfdHlwZTogMiB0eXBlOiA1CjkzNzFAMTcx
MjEyMDA5Ni45OTc3MzQ6dmhvc3RfdmRwYV9kbWFfdW5tYXAgdmRwYV9zaGFyZWQ6MHg1NjQxZWI5
NzJmZDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTogMHgwIHNpemU6IDB4ODAwMDAw
MDAgdHlwZTogMwo5MzcxQDE3MTIxMjAwOTcuMDUzNjY1OnZob3N0X3ZkcGFfbGlzdGVuZXJfcmVn
aW9uX2FkZCB2ZHBhOiAweDU2NDFlYjk3MmZkMCBpb3ZhIDB4MCBsbGVuZCAweGMwMDAwIHZhZGRy
OiAweDdmNjg3ZmUwMDAwMCByZWFkLW9ubHk6IDAKOTM3MUAxNzEyMTIwMDk3LjA1MzcwODp2aG9z
dF92ZHBhX2RtYV9tYXAgdmRwYV9zaGFyZWQ6MHg1NjQxZWI5NzJmZDAgZmQ6IDE2IG1zZ190eXBl
OiAyIGFzaWQ6IDAgaW92YTogMHgwIHNpemU6IDB4YzAwMDAgdWFkZHI6IDB4N2Y2ODdmZTAwMDAw
IHBlcm06IDB4MyB0eXBlOiAyCjkzNzFAMTcxMjEyMDA5Ny4wNTM3NTg6dmhvc3RfdmRwYV9saXN0
ZW5lcl9yZWdpb25fYWRkIHZkcGE6IDB4NTY0MWViOTcyZmQwIGlvdmEgMHgxMDAwMDAgbGxlbmQg
MHg4MDAwMDAwMCB2YWRkcjogMHg3ZjY4N2ZmMDAwMDAgcmVhZC1vbmx5OiAwCjkzNzFAMTcxMjEy
MDA5Ny4wNTM3NjE6dmhvc3RfdmRwYV9kbWFfbWFwIHZkcGFfc2hhcmVkOjB4NTY0MWViOTcyZmQw
IGZkOiAxNiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4MTAwMDAwIHNpemU6IDB4N2ZmMDAw
MDAgdWFkZHI6IDB4N2Y2ODdmZjAwMDAwIHBlcm06IDB4MyB0eXBlOiAyCjkzNzFAMTcxMjEyMDA5
Ny4wNjUxMTc6dmhvc3RfdmRwYV9saXN0ZW5lcl9jb21taXQgdmRwYV9zaGFyZWQ6MHg1NjQxZWI5
NzJmZDAgZmQ6IDE2IG1zZ190eXBlOiAyIHR5cGU6IDYKOTM3N0AxNzEyMTIwMDk5LjY1NTYxMjp2
aG9zdF92ZHBhX2dldF9jb25maWcgZGV2OiAweDU2NDFlYmJlYTY1MCBjb25maWc6IDB4N2Y2YTg1
MWZmNDYwIGNvbmZpZ19sZW46IDEyCjkzNzdAMTcxMjEyMDA5OS42NTU2NTY6dmhvc3RfdmRwYV9k
dW1wX2NvbmZpZyBkZXY6IDB4NTY0MWViYmVhNjUwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAg
MDEgMDAgIDAyIDAwIDI4IDIzICAgICAgICAgICAgIAo5Mzc3QDE3MTIxMjAwOTkuNjU1NjY2OnZo
b3N0X3ZkcGFfZ2V0X2NvbmZpZyBkZXY6IDB4NTY0MWViYmVhNjUwIGNvbmZpZzogMHg3ZjZhODUx
ZmY0NjAgY29uZmlnX2xlbjogMTIKOTM3N0AxNzEyMTIwMDk5LjY1NTY3Mjp2aG9zdF92ZHBhX2R1
bXBfY29uZmlnIGRldjogMHg1NjQxZWJiZWE2NTAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAw
MSAwMCAgMDIgMDAgMjggMjMgICAgICAgICAgICAgCjkzNzdAMTcxMjEyMDA5OS42NTU2ODE6dmhv
c3RfdmRwYV9nZXRfY29uZmlnIGRldjogMHg1NjQxZWJiZWE2NTAgY29uZmlnOiAweDdmNmE4NTFm
ZjQ2MCBjb25maWdfbGVuOiAxMgo5Mzc3QDE3MTIxMjAwOTkuNjU1Njg2OnZob3N0X3ZkcGFfZHVt
cF9jb25maWcgZGV2OiAweDU2NDFlYmJlYTY1MCAwMDAwOiAgZTQgMTEgYzYgZDMgIDQ1IGYwIDAx
IDAwICAwMiAwMCAyOCAyMyAgICAgICAgICAgICAKOTM3N0AxNzEyMTIwMDk5LjY1NTY5NTp2aG9z
dF92ZHBhX2dldF9jb25maWcgZGV2OiAweDU2NDFlYmJlYTY1MCBjb25maWc6IDB4N2Y2YTg1MWZm
NDYwIGNvbmZpZ19sZW46IDEyCjkzNzdAMTcxMjEyMDA5OS42NTU3MDA6dmhvc3RfdmRwYV9kdW1w
X2NvbmZpZyBkZXY6IDB4NTY0MWViYmVhNjUwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAgMDEg
MDAgIDAyIDAwIDI4IDIzICAgICAgICAgICAgIAo5Mzc3QDE3MTIxMjAwOTkuNjU1NzA5OnZob3N0
X3ZkcGFfZ2V0X2NvbmZpZyBkZXY6IDB4NTY0MWViYmVhNjUwIGNvbmZpZzogMHg3ZjZhODUxZmY0
NjAgY29uZmlnX2xlbjogMTIKOTM3N0AxNzEyMTIwMDk5LjY1NTcxNDp2aG9zdF92ZHBhX2R1bXBf
Y29uZmlnIGRldjogMHg1NjQxZWJiZWE2NTAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAwMSAw
MCAgMDIgMDAgMjggMjMgICAgICAgICAgICAgCjkzNzdAMTcxMjEyMDA5OS42NTU3MjM6dmhvc3Rf
dmRwYV9nZXRfY29uZmlnIGRldjogMHg1NjQxZWJiZWE2NTAgY29uZmlnOiAweDdmNmE4NTFmZjQ2
MCBjb25maWdfbGVuOiAxMgo5Mzc3QDE3MTIxMjAwOTkuNjU1NzI4OnZob3N0X3ZkcGFfZHVtcF9j
b25maWcgZGV2OiAweDU2NDFlYmJlYTY1MCAwMDAwOiAgZTQgMTEgYzYgZDMgIDQ1IGYwIDAxIDAw
ICAwMiAwMCAyOCAyMyAgICAgICAgICAgICAKOTM3N0AxNzEyMTIwMDk5LjY1NTczNjp2aG9zdF92
ZHBhX2dldF9jb25maWcgZGV2OiAweDU2NDFlYmJlYTY1MCBjb25maWc6IDB4N2Y2YTg1MWZmNDYw
IGNvbmZpZ19sZW46IDEyCjkzNzdAMTcxMjEyMDA5OS42NTU3NDI6dmhvc3RfdmRwYV9kdW1wX2Nv
bmZpZyBkZXY6IDB4NTY0MWViYmVhNjUwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAgMDEgMDAg
IDAyIDAwIDI4IDIzICAgICAgICAgICAgIAo5Mzc3QDE3MTIxMjAwOTkuNjU1NzUwOnZob3N0X3Zk
cGFfZ2V0X2NvbmZpZyBkZXY6IDB4NTY0MWViYmVhNjUwIGNvbmZpZzogMHg3ZjZhODUxZmY0NjAg
Y29uZmlnX2xlbjogMTIKOTM3N0AxNzEyMTIwMDk5LjY1NTc1Njp2aG9zdF92ZHBhX2R1bXBfY29u
ZmlnIGRldjogMHg1NjQxZWJiZWE2NTAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAwMSAwMCAg
MDIgMDAgMjggMjMgICAgICAgICAgICAgCjkzNzdAMTcxMjEyMDA5OS42NTg2MDA6dmhvc3RfdmRw
YV9nZXRfdnFfaW5kZXggZGV2OiAweDU2NDFlYmJlYTY1MCBpZHg6IDAgdnEgaWR4OiAwCjkzNzdA
MTcxMjEyMDA5OS42NTg2MTI6dmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbCBkZXY6IDB4NTY0MWVi
YmVhNjUwIGluZGV4OiAwIGZkOiA0Mwo5Mzc3QDE3MTIxMjAwOTkuNjU4NjMxOnZob3N0X3ZkcGFf
Z2V0X3ZxX2luZGV4IGRldjogMHg1NjQxZWJiZWE2NTAgaWR4OiAxIHZxIGlkeDogMQo5Mzc3QDE3
MTIxMjAwOTkuNjU4NjM1OnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2NhbGwgZGV2OiAweDU2NDFlYmJl
YTY1MCBpbmRleDogMSBmZDogNDQKOTM3N0AxNzEyMTIwMDk5LjY1ODc1Mzp2aG9zdF92ZHBhX3Nl
dF9mZWF0dXJlcyBkZXY6IDB4NTY0MWViYmVhNjUwIGZlYXR1cmVzOiAweDMwMDAwMDAwOAo5Mzc3
QDE3MTIxMjAwOTkuNjU4NzU4OnZob3N0X3ZkcGFfYWRkX3N0YXR1cyBkZXY6IDB4NTY0MWViYmVh
NjUwIHN0YXR1czogMHg4CjkzNzdAMTcxMjEyMDA5OS42NTg3NjQ6dmhvc3RfdmRwYV9zZXRfbWVt
X3RhYmxlIGRldjogMHg1NjQxZWJiZWE2NTAgbnJlZ2lvbnM6IDMgcGFkZGluZzogMHgwCjkzNzdA
MTcxMjEyMDA5OS42NTg3Njc6dmhvc3RfdmRwYV9kdW1wX3JlZ2lvbnMgZGV2OiAweDU2NDFlYmJl
YTY1MCAwOiBndWVzdF9waHlzX2FkZHI6IDB4MCBtZW1vcnlfc2l6ZTogMHhjMDAwMCB1c2Vyc3Bh
Y2VfYWRkcjogMHg3ZjY4N2ZlMDAwMDAgZmxhZ3NfcGFkZGluZzogMHgwCjkzNzdAMTcxMjEyMDA5
OS42NTg3NzE6dmhvc3RfdmRwYV9kdW1wX3JlZ2lvbnMgZGV2OiAweDU2NDFlYmJlYTY1MCAxOiBn
dWVzdF9waHlzX2FkZHI6IDB4MTAwMDAwIG1lbW9yeV9zaXplOiAweDdmZjAwMDAwIHVzZXJzcGFj
ZV9hZGRyOiAweDdmNjg3ZmYwMDAwMCBmbGFnc19wYWRkaW5nOiAweDAKOTM3N0AxNzEyMTIwMDk5
LjY1ODc3NDp2aG9zdF92ZHBhX2R1bXBfcmVnaW9ucyBkZXY6IDB4NTY0MWViYmVhNjUwIDI6IGd1
ZXN0X3BoeXNfYWRkcjogMHgxMDAwMDAwMDAgbWVtb3J5X3NpemU6IDB4MTgwMDAwMDAwIHVzZXJz
cGFjZV9hZGRyOiAweDdmNjhmZmUwMDAwMCBmbGFnc19wYWRkaW5nOiAweDAKOTM3N0AxNzEyMTIw
MDk5LjY1ODc3Nzp2aG9zdF92ZHBhX2dldF92cV9pbmRleCBkZXY6IDB4NTY0MWViYmVhNjUwIGlk
eDogMCB2cSBpZHg6IDAKOTM3N0AxNzEyMTIwMDk5LjY1ODc4MTp2aG9zdF92ZHBhX3NldF92cmlu
Z19udW0gZGV2OiAweDU2NDFlYmJlYTY1MCBpbmRleDogMCBudW06IDI1Ngo5Mzc3QDE3MTIxMjAw
OTkuNjU4Nzg2OnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Jhc2UgZGV2OiAweDU2NDFlYmJlYTY1MCBp
bmRleDogMCBudW06IDAKOTM3N0AxNzEyMTIwMDk5LjY1ODc5Mjp2aG9zdF92ZHBhX3ZxX2dldF9h
ZGRyIGRldjogMHg1NjQxZWJiZWE2NTAgdnE6IDB4NTY0MWViYmVhOGQwIGRlc2NfdXNlcl9hZGRy
OiAweDdlNDViMDAwIGF2YWlsX3VzZXJfYWRkcjogMHg3ZTQ1YzAwMCB1c2VkX3VzZXJfYWRkcjog
MHg3ZTQ1ZDAwMAo5Mzc3QDE3MTIxMjAwOTkuNjU4Nzk2OnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Fk
ZHIgZGV2OiAweDU2NDFlYmJlYTY1MCBpbmRleDogMCBmbGFnczogMHgwIGRlc2NfdXNlcl9hZGRy
OiAweDdlNDViMDAwIHVzZWRfdXNlcl9hZGRyOiAweDdlNDVkMDAwIGF2YWlsX3VzZXJfYWRkcjog
MHg3ZTQ1YzAwMCBsb2dfZ3Vlc3RfYWRkcjogMHg3ZTQ1ZDAwMAo5Mzc3QDE3MTIxMjAwOTkuNjU4
ODAwOnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2tpY2sgZGV2OiAweDU2NDFlYmJlYTY1MCBpbmRleDog
MCBmZDogNDYKOTM3N0AxNzEyMTIwMDk5LjY1ODgwNzp2aG9zdF92ZHBhX2dldF92cV9pbmRleCBk
ZXY6IDB4NTY0MWViYmVhNjUwIGlkeDogMSB2cSBpZHg6IDEKOTM3N0AxNzEyMTIwMDk5LjY1ODgx
MDp2aG9zdF92ZHBhX3NldF92cmluZ19udW0gZGV2OiAweDU2NDFlYmJlYTY1MCBpbmRleDogMSBu
dW06IDI1Ngo5Mzc3QDE3MTIxMjAwOTkuNjU4ODE0OnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Jhc2Ug
ZGV2OiAweDU2NDFlYmJlYTY1MCBpbmRleDogMSBudW06IDAKOTM3N0AxNzEyMTIwMDk5LjY1ODgx
ODp2aG9zdF92ZHBhX3ZxX2dldF9hZGRyIGRldjogMHg1NjQxZWJiZWE2NTAgdnE6IDB4NTY0MWVi
YmVhOTUwIGRlc2NfdXNlcl9hZGRyOiAweDdlNDVmMDAwIGF2YWlsX3VzZXJfYWRkcjogMHg3ZTQ2
MDAwMCB1c2VkX3VzZXJfYWRkcjogMHg3ZTQ2MTAwMAo5Mzc3QDE3MTIxMjAwOTkuNjU4ODIxOnZo
b3N0X3ZkcGFfc2V0X3ZyaW5nX2FkZHIgZGV2OiAweDU2NDFlYmJlYTY1MCBpbmRleDogMSBmbGFn
czogMHgwIGRlc2NfdXNlcl9hZGRyOiAweDdlNDVmMDAwIHVzZWRfdXNlcl9hZGRyOiAweDdlNDYx
MDAwIGF2YWlsX3VzZXJfYWRkcjogMHg3ZTQ2MDAwMCBsb2dfZ3Vlc3RfYWRkcjogMHg3ZTQ2MTAw
MAo5Mzc3QDE3MTIxMjAwOTkuNjU4ODI1OnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2tpY2sgZGV2OiAw
eDU2NDFlYmJlYTY1MCBpbmRleDogMSBmZDogNDcKOTM3N0AxNzEyMTIwMDk5LjY1ODgzMzp2aG9z
dF92ZHBhX2Rldl9zdGFydCBkZXY6IDB4NTY0MWViYmVhNjUwIHN0YXJ0ZWQ6IDEKOTM3N0AxNzEy
MTIwMDk5LjY1OTIwODp2aG9zdF92ZHBhX3NldF9tZW1fdGFibGUgZGV2OiAweDU2NDFlYmJlYTY1
MCBucmVnaW9uczogNSBwYWRkaW5nOiAweDAKOTM3N0AxNzEyMTIwMDk5LjY1OTIxNzp2aG9zdF92
ZHBhX2R1bXBfcmVnaW9ucyBkZXY6IDB4NTY0MWViYmVhNjUwIDA6IGd1ZXN0X3BoeXNfYWRkcjog
MHgwIG1lbW9yeV9zaXplOiAweGMwMDAwIHVzZXJzcGFjZV9hZGRyOiAweDdmNjg3ZmUwMDAwMCBm
bGFnc19wYWRkaW5nOiAweDAKOTM3N0AxNzEyMTIwMDk5LjY1OTIyMDp2aG9zdF92ZHBhX2R1bXBf
cmVnaW9ucyBkZXY6IDB4NTY0MWViYmVhNjUwIDE6IGd1ZXN0X3BoeXNfYWRkcjogMHgxMDAwMDAg
bWVtb3J5X3NpemU6IDB4N2ZmMDAwMDAgdXNlcnNwYWNlX2FkZHI6IDB4N2Y2ODdmZjAwMDAwIGZs
YWdzX3BhZGRpbmc6IDB4MAo5Mzc3QDE3MTIxMjAwOTkuNjU5MjI0OnZob3N0X3ZkcGFfZHVtcF9y
ZWdpb25zIGRldjogMHg1NjQxZWJiZWE2NTAgMjogZ3Vlc3RfcGh5c19hZGRyOiAweDEwMDAwMDAw
MCBtZW1vcnlfc2l6ZTogMHgxODAwMDAwMDAgdXNlcnNwYWNlX2FkZHI6IDB4N2Y2OGZmZTAwMDAw
IGZsYWdzX3BhZGRpbmc6IDB4MAo5Mzc3QDE3MTIxMjAwOTkuNjU5MjI3OnZob3N0X3ZkcGFfZHVt
cF9yZWdpb25zIGRldjogMHg1NjQxZWJiZWE2NTAgMzogZ3Vlc3RfcGh5c19hZGRyOiAweDQ4MDAw
MDMwMDAgbWVtb3J5X3NpemU6IDB4MTAwMCB1c2Vyc3BhY2VfYWRkcjogMHg3ZjZhOTZhYTcwMDAg
ZmxhZ3NfcGFkZGluZzogMHgwCjkzNzdAMTcxMjEyMDA5OS42NTkyMzA6dmhvc3RfdmRwYV9kdW1w
X3JlZ2lvbnMgZGV2OiAweDU2NDFlYmJlYTY1MCA0OiBndWVzdF9waHlzX2FkZHI6IDB4NDgwMDAw
NDAwMCBtZW1vcnlfc2l6ZTogMHgxMDAwIHVzZXJzcGFjZV9hZGRyOiAweDdmNmE5NmEzOTAwMCBm
bGFnc19wYWRkaW5nOiAweDAKOTM3N0AxNzEyMTIwMDk5LjY1OTMxMjp2aG9zdF92ZHBhX2FkZF9z
dGF0dXMgZGV2OiAweDU2NDFlYmJlYTY1MCBzdGF0dXM6IDB4NAo5Mzc3QDE3MTIxMjAwOTkuNjk2
MzgxOnZob3N0X3ZkcGFfc2V0X2NvbmZpZ19jYWxsIGRldjogMHg1NjQxZWJiZWE2NTAgZmQ6IDQ1
CjkzNzdAMTcxMjEyMDA5OS42OTY1NTE6dmhvc3RfdmRwYV9zZXRfdnJpbmdfcmVhZHkgZGV2OiAw
eDU2NDFlYmJlYTY1MCwgaWR4OiAwLCByOiAwCjkzNzdAMTcxMjEyMDA5OS42OTY2NDQ6dmhvc3Rf
dmRwYV9zZXRfdnJpbmdfcmVhZHkgZGV2OiAweDU2NDFlYmJlYTY1MCwgaWR4OiAxLCByOiAwCg==

--------------pzFmwwj5TK6N00o1PE6zRZh0--

