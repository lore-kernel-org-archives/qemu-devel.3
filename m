Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA78BC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuxa-0005T7-Ht; Tue, 27 Feb 2024 05:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1reuxV-0005SB-2s
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:45:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1reuxS-0001QN-SG
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:45:12 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41R9JNXi018668; Tue, 27 Feb 2024 10:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zoQy8eGywR00UkpyPpAZUjOdv1lY8pveve2RYh1jqRQ=;
 b=EfqnsbUUjrJKsaRUaT593iFW36dOY0Qm75cQPqDorFtWC0PQC8QXte3i77c9YTCMIWQ0
 w2AkhcWN1n3vAVadb4JTvqRzjex5Dg6o2fSQnzP46/6txRBz74TV2jrTR9ZBwvcdFQwm
 kul0dhLGP2u0lXsTPBL3RjJUT0weq91lHVY/AOBW3B9Z2++hbKqj5YQfJecpZrL+dY1e
 XZyGbeOgJfcbD0vnywQK/YWk/R+GB4JWSdlMidvWXQ0u7Q5dtE2OEJVgYTyXvGckpAfj
 h90Hx3sppY1CIjCKS3MEpefK1j8qsCoL71J2hECXCV+fm6xVSN1xzdo23pWB28PCyW4Q OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722ewh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 10:45:05 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41R9ttNK001674; Tue, 27 Feb 2024 10:45:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w70w8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 10:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaQcBUgygp55NCC7KDTvBe+Gi+2d6u6Vk/N19j79ENMYODH2jTExJpnz26BORBZ3DY8QtSyeDVrElIta+DXs8YWQ/wq8d/kG9r30Gyna8Jb5vu2gtUeKkJ84PZWgnIwcd2Qv/+2SuApsW/qD5V+qaeUwg91NjUtaZfoV9D3Vut5Jc+DSGNiAOqF9d5rRI97sGCEOdBfhTAJQFGgFYTMy3NfA/8yZJMYzgEIXa360FNgXAaCyYMYk3sT1ATWvhyNYwx9iKiwjrCFNtCeBFNvocZa/dF4rqIVecGFziIAZq8sXupA+WlUI7PMdjgEkzvFLzmefHa4goaF1a3MOYNXHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoQy8eGywR00UkpyPpAZUjOdv1lY8pveve2RYh1jqRQ=;
 b=P8xosP50I8rfY+WWCpRofCH1wSH7cnF2S4VdNVagzoMbEpIwcDd2ToSOChcR61nDOp3leuTVqPXRVYq/Yc5NqZN1xxf0TpRhPwwylhTSsMKj7wgq526RiOCYw65H55Fb3TdGUK67Gc7SccqkFYqfZssZTy6ovbQ5o0B/uVvI3qWioTjM+ydlP7G77vJlncNFwz+SZOtimEGSp9WnRnUFmh1xvAyFcgY+ALh4CACnf2csHdzg51MRBlRpE2zGUhUcLukfIbmoFwhBZgNS8M9UOmwagt7QH76PLPHfglu0z1NDV7rZJVFQcr5O8KJ0I7h3JlzT3ue87CPh4gPWpAfd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoQy8eGywR00UkpyPpAZUjOdv1lY8pveve2RYh1jqRQ=;
 b=iMV6UaEEd+YmSq7MfUCJmystV1ZlNfUhARZqkKlhZ2UcVF66zT/wYsLlCmYe4/39oCOlhgXc00kh4Ifdke1SWwSj5NNK1hO6war0g4jr87F5gXkT91e5khMksHl7IPRYH2EOZAex4aWatvgxLtOHB3n65nP7IQQs2ti0k0XjNb0=
Received: from SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16)
 by DM3PR10MB7910.namprd10.prod.outlook.com (2603:10b6:0:b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.34; Tue, 27 Feb 2024 10:45:03 +0000
Received: from SJ0PR10MB5891.namprd10.prod.outlook.com
 ([fe80::c3b2:b415:c3be:77f0]) by SJ0PR10MB5891.namprd10.prod.outlook.com
 ([fe80::c3b2:b415:c3be:77f0%4]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 10:45:02 +0000
Message-ID: <72be3b8d-6879-45aa-81ee-f71013c3ee1e@oracle.com>
Date: Tue, 27 Feb 2024 10:44:53 +0000
Subject: Re: [PATCH] migration: Don't serialize migration while can't
 switchover
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20240222155627.14563-1-avihaih@nvidia.com> <Zd2SPGPVhW80b1Hu@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <Zd2SPGPVhW80b1Hu@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0164.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::33) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5891:EE_|DM3PR10MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9917bfbe-e9de-43f2-cf34-08dc378126b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBr06KY2tjX+mnA514NKP1/9yAAoUS/z6xQWYEzHQhqfJSAv+u2gPaxqNv19mETxn+SQTjGXIXvrVIUOKqXzxwI8VBsJzSsiawO3sWBlgKCzWZV7hiCfttLUzQkB9fOqPFUD2bkFDUKeZDaIahu47FCT7WXLIX69UXhQ5cL1mKO81xt7UcvQDBK1dUydlbaD6VQJD4Zi+PeO5G9WQ9Bv+oeNRgBMDxt0Q2e947j7tj8eig1p5wsGwZwNFvdpWp/zuFhwVdAXaL12PCRQdMuxpru/5DN55mAdiBMhqLUorxB8m0wqNUU+VQnGR0A2luKgN4rq8XlR12eTj0+eiEpODm18yYbCW9o1jkfUYzXFDxcBN4p4AFUjhyeGHmnnI+6SxQ0TioUtnJTdis0AH5WZyxccGxdLTLdt5KK0vpKyz2wEcjxSMFr2Phg0q2GgNs5WtFaEgEgFRbT51pnrFosP4tACi+/r3p9quvqlfs5O0ZttB+4CYZf/EBS6uJIvznDaH+IZBm1MIboFGwnXYOT0ci2WxRFzVYaK42ise43rp9kGXy3ku38mONDj65cECZ/MXXARFKH6q2zW3FGKR43IWjO6UczlImwyaVHgx4pwYnyPmsL5GTV9rf/o0AVNcpHr0FOH8/oEdxgvNxMuiyFQBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5891.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdpZ1ZoeG9qM1hHZzNhdE0yRTVTT2NabU42dWx3SUFSdzZ3dmV5aTdQSXJo?=
 =?utf-8?B?MjB0VzdoT1Vob3hPQU5FSlJGZ2hUdFdBNy9kbCtLRmJ4N0lzNDFLK2lSRnNU?=
 =?utf-8?B?QWpycnNiUE0vOXBuZ3FWQ2RidFBxdjloSnlNZ3lEdDlCQTRhMHlZRWFIcE1E?=
 =?utf-8?B?Yjd0dHFmUUhEbjkxeU9FeUtjd2N2KzlIS1RCRVdiWm1NV09Mc3RCVGNNWkl6?=
 =?utf-8?B?T00za0kvMjJudXhHMXJyL0I1clJ2d1BLQnp1ZHFYKzhuZXB4akxPNlZ2c1VZ?=
 =?utf-8?B?VjVHWXVDd0hnVGwza3BZWFlkZkU1RDhGZVpTZWhQZW9kWFNiT2ppZXJzSmhp?=
 =?utf-8?B?M3RJMXBiY056NThTd3pHZVJ2djY3SkU4bUIwL0xreHdqMjJ2VFlTWDJaL1ZC?=
 =?utf-8?B?cEVCWmNCRmpVa0ErdU1ZMGJkWDVvS2YvRjhiU0o0T3F5eFFURWNkOW96aG82?=
 =?utf-8?B?ei9SUDMvWXFYcytSSHpzYTd4SmZCNFR3WVk4T3prNlM5U1lDbWgrMXBwSkxC?=
 =?utf-8?B?V3JBejkva0lCRUlIM2h2Z2J4WUhDcmFSSk81UndGR3NjOFlpN3ZsVDRDeXZw?=
 =?utf-8?B?U0xHdlI2SzlQM00wSm5OYzBsWGlNSGhuWDlhTTRFZHZoTmZhQ3dHUUc4eTRN?=
 =?utf-8?B?MUdxajY0aHJoOHdBTGVGVEc3TnVabkFTSEhsVmZZUmc1QzNuMm5OR1NVQ1Bt?=
 =?utf-8?B?MEJSNnE5dGRWZElucjZzTTZSV0lvRmpEU3ltM0FVUWZJb0s3MENHK3QxTkVt?=
 =?utf-8?B?WVd3elpYeFNveDE3Q3hUUjQxY2tYQk90bUxvQTNYTFAzNGZLa3lOMUJzUk9H?=
 =?utf-8?B?czQrdXh5VllQT044dzkzb0hTTjQzMkhqMiswMWJZSHVaOXFMaWhQUUdneDBp?=
 =?utf-8?B?RWhlNUNMeXFUMDVxLy85TnE0ZGxmcXZmQ0ZVVkFMTHBqOGtDWHQzRGF2UnpR?=
 =?utf-8?B?SkM0WlNpRERVamQvTjhiQ3VPbXl0Rm92YzMvWmJ6Zk5LMG96ckYvR29XMkVG?=
 =?utf-8?B?VWt1dG1uOHRzc0p4SWZpelZiUVppeVplVFV6aW1ra3FaOUl3OFBpcVEydEtR?=
 =?utf-8?B?U3N2N21CRUNuQXhRQTBXanFzaExnOGFqaU1YakhDY1Y1UjNZa0p3VVN6Rll1?=
 =?utf-8?B?NHpGY0gzZTlaMWtDT2tuMWc1bTI4L0hrUnBHbmRmL3Z5THYrZEhSSTlvZDBi?=
 =?utf-8?B?VU91T2xrS3RTQ3dtSEJGM3JvckdYMFo5amRlOGt5dnRicER3Zmw5dDZQSTdk?=
 =?utf-8?B?REdkc2NsZVZIY3c2K0VqeEF4V2pNeEVhMmlsUjkya1hTL3M4TFJFNTIrVzdI?=
 =?utf-8?B?aXJjRktZSnpnR25vRi93S2NBTmYzdm1VcE1ZNW01cTc0NGxDUUpxbjBjcUFL?=
 =?utf-8?B?cSt2M2RLemlkcVo0N2pMRWVFcDZmcmtwQmFlVnd4dHp1bUR1b2hOQlNzdTRx?=
 =?utf-8?B?ditPTkNZd083dVA3VUIrRjg4d3RKSDhzNkU1RGtpcGNJZ2Zyeno1MU5LbmVv?=
 =?utf-8?B?WXBkMFR2eVVldzNOM0NVZi91cnBiaVhta3hpdWliRW5xU251clFrNXk3dlRO?=
 =?utf-8?B?VEFWemVpanQyQW9ucTV4K2F1eVZJczY1ZVVERGlWWlJVWHZpaGZNNkpVa01D?=
 =?utf-8?B?Y0hxa1Zrc1lTMTBuUExGdml0aUJpWVVSd2QzY1ZRN0w0T3VEODhWczhEK1dZ?=
 =?utf-8?B?Z1VXUG1Ya3ArTjl3K3VXRnFMcmdJUHl5Y2ZGTEVYTkFqMVNzcTRCYjlZNTlJ?=
 =?utf-8?B?Y1ZpTnZ5RDdMK2NNRXhsSjk0cXBPSkQ5K0kzZlRBeG9HT1NOTkpvaGxwdWlQ?=
 =?utf-8?B?MFJkVDdzbkdCbHRUeTlhRFNDbjJnbUJ1MVQwdmFvVStqOE1kTk55SE9yZVZM?=
 =?utf-8?B?TVozbnJJYkptWlQ4ODdoR3N4WVQxRE9mblFydmZ2dFl5NFVxcy80c2lGWGZ2?=
 =?utf-8?B?Q2UyY3RlNnMvM1ROUjhYNEh5NDRQNDRvSzYrT0JJN0s2dGxQZDNrR1Rub2Ju?=
 =?utf-8?B?ZllQUmN1eXd3cmtwQmxTZ3RTUlpNV1BscFNybS9wMFI1cGVzUkFWdzR0SEEx?=
 =?utf-8?B?dUhlK0NaSUI1TW04TkREdnFNSDVKV2xuZW9xYlllSzIwUTZnWDdpK1c2VTkr?=
 =?utf-8?B?YjhteFVOOFEyRFdsd2FFdEJBZUpic2ZrWFdTb2pCblpwazlRYS9PYnVhL3Qw?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LtZjs522ihPEF7KUoGQKFpv9yDnfTOUnUKtn6G0R+6thB6z3GrfZiBdwvKUUsrOwE8yWJR5tzxBdwqTRIlw0uacB0SzcovSSM//ltYh0t2wvdLmk5adEBmf5ymUxWIJI/NYWp/xCGQ1NnGN635pKzheAT2EhhGLgU70eWK+y9e37lu1cbYuhJZ6maTKNlxqyXlsqg3w7j8zGU2IWIzlwQQs2rAZS9gKs0KE8ddrvzUXyRV5VPSu89hALYVfKsHatPct9PkBU1zvTKTZ8QU6ibPV7uFVnPBQQuOisCcqopGnxpH37YcSdGasnv/NvYCSDn/MnXVERT7at60LpVULC84suyBjcY4U3cYVTBT7LUO0Bqh9Q5YvyUGctikUNyA74LpYJSrN3fV2xuNhbaNrDPEtR05U8lTD2yD+8jCkFXZ/wkc20NRbe2TAQ2Wk8BZZGloPu45irzpT5hNvFA0QcSWfi/Kz6+siS9sRT4r/BII3McysIYxbdE3+2KuieLA8aPR4e0dWDH661FvRYQ1Pmt+QSwksD4yrPmekw8N+zfzovNUnbMprrdbNdxIfv5zq722XcScoonIvd+WN0MLyze28ojCUOdK/dzZCOU1c3umw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9917bfbe-e9de-43f2-cf34-08dc378126b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:45:02.7794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWT0NM8JYIfpMAXITOU6Trd86MLHY4McHWnISnKcKJs3iUbuQLZauUVqteOZLOxIVNgJD4IHVOKUWOYXgigSbJy3Vw9p9+NoamXf8oZ+HRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270084
X-Proofpoint-ORIG-GUID: nRVjIbenwLZMEqAKyL9tJKmHn4EpziwH
X-Proofpoint-GUID: nRVjIbenwLZMEqAKyL9tJKmHn4EpziwH
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

On 27/02/2024 07:41, Peter Xu wrote:
> On Thu, Feb 22, 2024 at 05:56:27PM +0200, Avihai Horon wrote:
>> This bug was observed in several VFIO migration scenarios where some
>> workload on the VM prevented RAM from ever reaching a hard zero, not
>> allowing VFIO initial pre-copy data to be sent, and thus destination
>> could not ack switchover. Note that the same scenario, but without
>> switchover-ack, would converge.
>>
>> Fix it by not serializing device data sending during pre-copy iterative
>> phase if switchover was not acked yet.
> 
> I am still not fully convinced that it's even legal that one device can
> consume all iterator's bandwidth, ignoring the rest..  Though again it's
> not about this patch, but about commit 90697be889.
> 
> I'm thinking whether we should allow each device to have its own portion of
> chance to push data for each call to qemu_savevm_state_iterate(),
> irrelevant of vfio's switchover-ack capability.
> 

I guess that this means the only change needed is (...)

>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d612c8a9020..3a012796375 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1386,7 +1386,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>>   *   0 : We haven't finished, caller have to go again
>>   *   1 : We have finished, we can go to complete phase
>>   */
>> -int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>> +int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover)
>>  {
>>      SaveStateEntry *se;
>>      int ret = 1;
>> @@ -1430,12 +1430,20 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>>                           "%d(%s): %d",
>>                           se->section_id, se->idstr, ret);
>>              qemu_file_set_error(f, ret);
>> +            return ret;
>>          }
>> -        if (ret <= 0) {
>> -            /* Do not proceed to the next vmstate before this one reported
>> -               completion of the current stage. This serializes the migration
>> -               and reduces the probability that a faster changing state is
>> -               synchronized over and over again. */
>> +
>> +        if (ret == 0 && can_switchover) {
>> +            /*
>> +             * Do not proceed to the next vmstate before this one reported
>> +             * completion of the current stage. This serializes the migration
>> +             * and reduces the probability that a faster changing state is
>> +             * synchronized over and over again.
>> +             * Do it only if migration can switchover. If migration can't
>> +             * switchover yet, do proceed to let other devices send their data
>> +             * too, as this may be required for switchover to be acked and
>> +             * migration to converge.
>> +             */
>>              break;
>>          }
>>      }

(...) is here to have:

if (ret < 0) {
	break;
}

? Or you were thinking in some heuristic?

	Joao

