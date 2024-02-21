Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C91C5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpzS-0000px-D7; Wed, 21 Feb 2024 12:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyx-000071-S3
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:02:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyu-0003Kj-KC
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:02:07 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41LDjKsH004937; Wed, 21 Feb 2024 17:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LW73YH1DX/1JkAjV/dRpCZo2f8Vpjy2MiX7MYrO9xuU=;
 b=W3/nYdkoi4eY+Pqyiv0A1/xZ7xtskWfzujIEVhQxVB/nvxNGy66oaR9zGTtb+PsP7XKg
 6/F5mLGd2L69ddHmkzecln8NUfwSY14nQMkvyTe2K1jrClmhKuRedZZVU8UX8w3F+fSm
 1gIRWLLSTHg4OYWptvOF5DQyoz+WbR++sQci4zYOnMIS0xLASOj/j9KlrmxUAjecNAww
 py3HfA0jJxF+74j+JOwedRznZQFrV67bpzdpaRpSA+qkZCi63xzFIsPLNFt/bzk6zyXz
 xzsKLOEip6XJwuXb4aGcFjAe7LTgaaymAzxiTutImyBwElvyIxDGKYQnYkT6mIbafZdk Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2ad5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:02:01 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LGXueK037804; Wed, 21 Feb 2024 17:02:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8991fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:02:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6wgUJzSw3wjfniaWB4ADIieEL7HJcSSxCSQiY6Rx1LCGjJAsVdBv7E9a4P1++BamPZmBdHTMqKLWSsL6EmqluFWC8SpZxKLKn8JWhZDa5VPQ72apdI1d8Otdsyus8tLsIDPqVbBhzLoxLKvUe43KjNSKyF2yxRKZ7E6feFBJ+GMm8iSIvZ3pFCV52VQhkxLk2ER08LyT/wGTWn/s1iu9vCWLxmUzfOPgZU1vqJjwjMBo2r5W2oyu/E4yzejS+MnbcNS35njoct3/4tssVr1UU9I7oeQw+fzCDc9d+kORgmKovoUafBfBQj73InvDSbFGN/mDTiv7Z/9Ca+FKY9tzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW73YH1DX/1JkAjV/dRpCZo2f8Vpjy2MiX7MYrO9xuU=;
 b=jtsax5gASzMaAc7tStZElsLUOaDIWsQ2/OC6+04CPg3ulNNd04/nGKNq2y/nZyZ9J/QIiuuRihV9HkZ9j1UJn0VfMQ4kO1tUo89WRKZ0mkv+sm5cGz4DPxKHEFdvyxYYy+/YcdDJjQiyqnJQo2CJrWk+YiOI8e3YGTy7I/pSx5pUBTPaLillLgdNwesDGJG/gcgKIJjezUAuy4cGwCLX3Dsn7kFlptN6TJ4asu5HSvetPKpuoQX3ZRCUw2w8yAV8hR7U4HGHJIXIW8tN/lbk5NYQhOJN9S5AyrNidrFykae/YAcVm95KMasJtKSYS7HI+vvVxr05OJWE7iQOZo6VbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW73YH1DX/1JkAjV/dRpCZo2f8Vpjy2MiX7MYrO9xuU=;
 b=N3NUrwpxmYB3ga/KCRK/G6wqKtmZxw4q+iYYcHjw1Q520ld3yXeM4r1uza0Fk2mPYbBmjG7iH0aZ15xPF4TyT8VjPtIr71W/WSxghcfa/4gjyH7s+wXYMXxU7H7RLeCkdsNgXoj5cCuPI91I5p2stnS2Zc/jX3n+gOazwFhfHVE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by LV8PR10MB7775.namprd10.prod.outlook.com (2603:10b6:408:1ed::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 17:01:58 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:01:58 +0000
Message-ID: <e9dcfbd3-e491-4d63-a1ec-7f3b2a00605d@oracle.com>
Date: Wed, 21 Feb 2024 12:01:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/5] migration: simplify exec migration functions
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-6-git-send-email-steven.sistare@oracle.com>
 <87msrtc479.fsf@suse.de> <87edd5byob.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87edd5byob.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|LV8PR10MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: af6ba696-1401-4c77-e781-08dc32fed083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nhsVjLjA9aA0BkQgEDsmuUVpmYKqp/yGp3rSTMTaR3xfoKHHIKzm46rmB8sdU4PbhFy1aN4egDPN5Cq7mywxzf0I3GwwP2ItGEmmJeQEO/pGK0p0vaAo019/QQdTNNHQ1/9kcgraY4qMUekKvrtNjGyPUjsqz2OXPXAZJcjy593EvGKi+ADMVQOtlQTmukglXDn6GIAHlcw0Z1x4QfZ1Dsev7bTneciUQwWxAUBMF1plHSQHppIHwVTJdx8zK4YhCY+kZbL/+25bfVW+Emw5hheA0oIuHAeOnp5ACSM3BWK+3aM8DZ68v/E6bG4cBl06EgOj/rYte3o9ni7taBaUpYGwTNxgFKGCLov5jJUAYW902azv7Sv01mg4OxJC7CPlAg32IJgnsSOrOAJNfFMa+h/ZaOCG0K8ua73f9RmCsFxuuPrPtql0G6vWNe2oqPq64kIsdQZf+cOCMGklBGACDUbBAu26hOWhZhTHJ9Fa7ku9R7NiDJ5/VKxJLj1egicQjoofWmC3jbJ5MV/XnlBJHFRMrdY7LnUTJQitYLeaL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29Lby9CbUVVNGVPaE9BV0U1MDArNURMSGxHb0NWU3Q1Qk95bzBCREZEYXF2?=
 =?utf-8?B?bkJhaFBlMWtxZ0tsUlhaanVrNmpjWWwyY3pXeVdYa0haWDZZMUFySDRISk83?=
 =?utf-8?B?b1NxVFlOR0VUNHRNc2RLQjhrZUdFbS9VR29KNUNZQzBHVi9Oak56bjlXNC9v?=
 =?utf-8?B?NHQ2UCttRXdCSXBQRGx5NWxOenhXTFdMdytpZVJ5WndIdG1ldGxaN3I4bWc1?=
 =?utf-8?B?Und1MEdjMGJVelNaQnBROStnV3k3UVhTTFNqT2JmZmY4UW82cHZaYzVXZko5?=
 =?utf-8?B?VXk1cmdEdHY4TEEwdC9ncldtQ1Q1Y1ZuWExpOEVGSEFwN3c3bFRxSTErYWZJ?=
 =?utf-8?B?cVdOa0FyMFJqcm9yYytVUU5XOFJ3ZnRTMjFHT2xuS043bjl6bHZsbE5uQWNT?=
 =?utf-8?B?VU92NWttdkdmQlE0Y1puZE5kY1lvQkV4WHczS2U5KzJnbVFDY3M0bmxiOUlw?=
 =?utf-8?B?OEtJMGdtd3NsaFJCbCt4WGZtY2tUOVdzcGNsUmVkS0JpcWVZY0N1N1BVZ2RT?=
 =?utf-8?B?RE9wUDBVTG9wOWdVNTg1L2ZmaStJQUt3TXVXTWVmNXcydWdxZWcxMkVIVjlE?=
 =?utf-8?B?elBBV1V6UWh3b2VBVzlaK29Jb094Wm5hVkRaNlRhVWQwTGgrK24rdmpSeEFh?=
 =?utf-8?B?SWgyQmJTYUsxRzdqQlplWmRIeHBaRVZGRnc2V2Z1VmlYU0Qrd0tDV0ZBTlEy?=
 =?utf-8?B?OFpqcldmRnJralkzT1VFeVNNN1MvMWlKNllKYUdvMWwyai9ocko0WENzbWpz?=
 =?utf-8?B?NWhjNE0zcGJUc09aeFAzekZmbVQ1SWlyK3dNV3lONDdLSnFwTStNRlFhZUpX?=
 =?utf-8?B?VWswTlZOKzRYQkticTBKRURvbWhxMHNGMjlSclVoUjRQdzZnb1A0ZSsvVmZ5?=
 =?utf-8?B?RFdkMnlMQ1FhUUtwTmpmSTlNcVFIaE4wOVR5Smd0SzBlb3JOeDlndFQ0b2Fs?=
 =?utf-8?B?eGZVMXM3eTVxTnlvb0tHZGlwL0tFN0RjdkhScWFsNXYwN2d4TkFpS2VRaFBY?=
 =?utf-8?B?aVRqMlBEa0NEVFFZVFM5M1h5SlBBb20wUFJWVXNTalQyYWNJQWdYaFN5Z2VO?=
 =?utf-8?B?bE1URkVwMm9hb3Z0WmwwcHdVOXZCdHdzT2tPWWkvd29wT2xlYWoyQVFmM0dJ?=
 =?utf-8?B?ODVJQitMR0wyNGNsL3hYditpQlFFS010OUtRT2VmV2xxM1E2SGFZMldpOWhx?=
 =?utf-8?B?M0U0c1piZkp0eWNXVkd3b3c1WE1BMlhEMkF0ZENLclI1OTdkVUdlRGh4Tkdo?=
 =?utf-8?B?cTJwQzFyNS9CL0pNQ1h1R2o4aVJXYUhrOTVuVW13elA0UmhxM1UyZFl5M0ZF?=
 =?utf-8?B?a1pWbzVaak9WeVh5S0llK3ozeC9GbTBVL01hb2xiemlwRUFFNG52VjFmRUhp?=
 =?utf-8?B?SlZ5Mm5vd3JvSGdBRUR0L3J0MkJSY1c3TWhxeWZtQnFvZHoyR1I3b0dVS3VC?=
 =?utf-8?B?b3BJRk9NQ2s2eTUvQzVNNm9GVWtnK1RGUDJQUjBRejVNRFFiYWdCQ2VZbzJk?=
 =?utf-8?B?Y1lDUWs2eTgxeEp1MEVYTEVzek9IdjIyOTBUSFVOTGxlUWNuNFdWalI3ZUVv?=
 =?utf-8?B?T3dPN0h1WDcvVldnZzRUM1RzdmhxVzFLdjZkTDhKUHYrdVVYZzhpVDNkOTNh?=
 =?utf-8?B?QXlLdFJoSVpPY0U1RlRNeFNSOWRya0RpWnlQMkYreGNiMDZmQnByOGFnWVdQ?=
 =?utf-8?B?V2JGYlpMem52M0xSTUloUkNjMlFMQUkwckNKTU4way9rZzFxZ0NDTWV3NkU1?=
 =?utf-8?B?enZOVkx5R3hMbUMwaVhqOCtoR29kZ2JUMThkNmtKY0NUUHFMNGRRTzVLd3By?=
 =?utf-8?B?Ylc2UWcxRk1GK0xGVGFEeWZUQUFvNy9mR2Nza2FIRWY4ME1OdW50YWkyK3hn?=
 =?utf-8?B?QUltSnBFNDhVWGQ2eHZJZjJEV2RuMWVEVG1ibWh5Uk1CYlF6UWdBZnlFU2ZL?=
 =?utf-8?B?ZW1yUU1xOHk0bys1cDV0dGw0L2ErZ2pXbm11VW1mbEZFMWZSMzlGenc2aEp4?=
 =?utf-8?B?RzVPeVpvZDl6aGZPdlR5WXNUQlNyVE1kbDBUQkw5SmNhYVN0YUZBSmN3OUo2?=
 =?utf-8?B?L1kwOTB4MlREdmpiQnhrZUI3RXlHQlFwRGQyaTBtYWpLZFZhUFdmcURqMEQr?=
 =?utf-8?B?Vm5MaTVRVnplRTlSTU9EK1RRNnZkSE80b2lwS0JaNzBSRXN3eEdFeHZpU0ZD?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xnLV+jtqg8tawQ0brjtHTx/3HdteEaXn3F8SaprilFpIClslscM1Br5UY+2Mp4ob5jk1W3ZskiiaXmYtv+d9t57qhCccs/dlvJTwQkbl+4PgGxKS+7Jq1r3vxx0P75r1XM2A18HwrAAuiPHRuR8eKDhW88SMGUiEKjtQ8yeTssGlCAB/znFac0i/l8a1eqbhW+OXPVK6OIXS8SFb6QdRbcpK4xR2xWULqj1F4ocHYN8L12xA5aU3yErHRqC/Jeg77Z02qkirlVy5d7u4jkha/nnz5tDeQtSH/ZvPrNNe7lYO3WyW1a1C2byBgnACKDrtisjPGjrPu0IJvYmdgYcG5mUaxX4NBjYPlPKyEY8mAkDtxJkG9kIuP5gJsOm/BJ93GlLSlPdHxqK2w9QcPa6DT7aIOPaFaqAfaMJXIkaIjyWW/yVPBld6iRtR1xrLpNqNpoebd/743W5GWP/f+h/WBMsUfJClsoF+x9xlAF8vVnqFzH2PnpS84irD+Tw40GcoBT14/yZhg/isP3+4L4izLUCGsmKByYr5PqwZ3voXkkQwNSbHf2MVLFBLqcLDcJlFeLgRZkO0grgRlorLs8ww8bZYq/Tj5dga+EPmBqmVmfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6ba696-1401-4c77-e781-08dc32fed083
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:01:58.2204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6XQBivWITtiqFwfCsDBBx5JruYzlIjVFE0rntVZAkrAMdKxGkyF5STk1Da2W//9nx2AqpCFmVmFOQPRw77bI7tjgRIHqGJEPSurWPLYJB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210132
X-Proofpoint-GUID: d9_rbYZ1mpjjOpRyPrdhLCln7aKRtojY
X-Proofpoint-ORIG-GUID: d9_rbYZ1mpjjOpRyPrdhLCln7aKRtojY
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

On 2/21/2024 10:54 AM, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Simplify the exec migration code by using list utility functions.
>>>
>>> As a side effect, this also fixes a minor memory leak.  On function return,
>>> "g_auto(GStrv) argv" frees argv and each element, which is wrong, because
>>> the function does not own the individual elements.  To compensate, the code
>>> uses g_steal_pointer which NULLs argv and prevents the destructor from
>>> running, but argv is leaked.
>>>
>>> Fixes: cbab4face57b ("migration: convert exec backend ...")
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> You'll have to reintroduce the qemu/cutils.h include:
> 
> ../migration/exec.c: In function 'exec_get_cmd_path':
> ../migration/exec.c:37:5: error: implicit declaration of function 'pstrcat'; did you mean 'strcat'? [-Werror=implicit-function-declaration]
>    37 |     pstrcat(detected_path, MAX_PATH, "\\cmd.exe");
>       |     ^~~~~~~
>       |     strcat
> ../migration/exec.c:37:5: error: nested extern declaration of 'pstrcat' [-Werror=nested-externs]

Thanks, I will rebase to the tip and verify all is well before I post V5.

- Steve

