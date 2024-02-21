Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1189DC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpyW-0007MK-0t; Wed, 21 Feb 2024 12:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyR-0007BR-FS
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:01:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyN-0003F9-Vg
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:01:35 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41LDioe6021244; Wed, 21 Feb 2024 17:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xIXAw+SQbiXUMgvYmvDKo9YUYV+iloGsR/l/NZ2kxL8=;
 b=eBUvavlM8VwVKZyFb83uFqWelm99F5gixeFW5Ff9SVOnQU5q8PIHwyyFEnH7xduS689C
 qRKcyNvGL9hW5fi4/CJedlmmb3uMSTa6ic7UXtHXmjF3ljahimu2SQdCZ0jBlNijRSQi
 gZkCHaz0f9I1x6MO/Vz1XeWuzWsGxVMG0ljV7jxQgG5gj+NQctmD9/TQ1e2biwe+scKZ
 e8hDvrdc0osOybPsOIK6y33quCoL3DuFfkgNG9uHBUCQlCtc+HNdyPgFqa4/ei54UWyg
 bZ4NrMDV0J5ctf2+AWoqxvzaR9l+2Ot8Ao+q4z8dCxU86RFapMuKFoJsokMY7pudw9kj Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud2dt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:01:27 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LGERID006641; Wed, 21 Feb 2024 17:01:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak89hadv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBu1YzP31qj6zzIcCbnJA7eCVQdbQ444Ue+r9C6NG1M1pSQquc2atofEpkhUKjevEnHVfIYbInhjGXLLwz9Hs4P0Fk76CAt6G5Pu8Q6HAgM1Of6CtEvwaPO2rCX/HDtce2BKoUYd5bfAyR5RDwQdoNs52U5Dhm8iWJ/VWrRogANGxWXVveu5rISow7eW59MxyTHbwFFBgO3809H4OS5pz10s+Op2SPOMylCwCJbLooTDfh3pWxoFkNs6gxKab3rvMQj6s1Lk2oWLEu1PpRI6BX3KuHkf3yhxQ4Km8RaB4Gu4eHMaUAVDF4Dm7cD8v9J2yYz9KKWsr/Zaie2s0hW98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIXAw+SQbiXUMgvYmvDKo9YUYV+iloGsR/l/NZ2kxL8=;
 b=X2haeYswihinPf5Rh490R1SyMPyXZJdhflg83klb6ns+sWQ+EdbIQb3o0hOjcvMbqMdF284vyuSAMpKD/iqDgxaq3m1mzpNYC2Lt/Pj19jAyfX+w4tFI0Vont4lnEr5vxMgaP6mHOOgU0TCfS/tuiQTmusJmZhNX9cFt2qi1QMbEZGZ9813prVqn1lMGHg5IxgVT/a2GsADlG9BMNmQFePclFgaYLIe2ahqUqqktZgDgU0/d8FORDnwDo3sutcmoG+sxPTruuWk6N8Luhef6NETcUSM6kw7eweBKzIA4/sOc9ORH5WWahiAfd9YVrGDGEcbfZa14w/CBGkslw0fsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIXAw+SQbiXUMgvYmvDKo9YUYV+iloGsR/l/NZ2kxL8=;
 b=p6QRJAgdVKDoW7VJqV293+Ye5+7pG1P7EPvJQLim/7RTpFtfFikQg30AGVn9RH2u+8G39NhKN21Rra+SMlcp9gl0cCj9caSPjzvo7Cz8YGyQQLj0x0pVFrCS1iovw4/LdeYqYRo5I0FnVgMN78Vwi7um7uAioqA1u3AKhQjzFCU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Wed, 21 Feb
 2024 17:01:23 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:01:23 +0000
Message-ID: <5a07b1f0-8247-47a5-b9f0-7291504587b6@oracle.com>
Date: Wed, 21 Feb 2024 12:01:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/5] util: strList_from_string
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-2-git-send-email-steven.sistare@oracle.com>
 <875xyi3pz4.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <875xyi3pz4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: e086ac0b-4473-4485-7a00-08dc32febbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYbLStee99kOmaWK+uNkA4jAyhtGUpLK8t0m3bXtN4Aj38P5Xrm0cTr26GiuauwUu6K2o3rw8xE8dCn+3DoHBlQwsgBaFaWBBvAMen6GmeqNVtDt6EII9NEzp5Wgen6x7w9KR7cAT30aGm+EaxNX/cPRyW4VfzqqZqykdzAmIGx0LRlh+QFziG4uw2zh7vlYhJ4CnqMandVn5WFsuqRadbc3rP9S6uq2cRtPLVQnZtyYnfKwnjUCZSrtEy85PolUT/HbZ/aP+6Za/CFjneRDLWqsAXJgSP2vS9XC7ChYzPZOpLtOSCqwGS9+hl07w0ZmTAzopWeJVml/AfD8Oc42ua7EV+ckvLdy8mZ7+f+Qy7+eMeg2byIEquoOpPXiYBIQj+vMuFnlhvX9ydO6fbSj6LJuhoQDWFIzWtZHB2zjaxlSuspo/6QwVSclCjX683J2dL89/+nySUXRpCbiVtzwodyksz8F1PAkFSaKkpCG+lP89H4pVueo83xIsofztPLXtM/BrP5vgpSwrD79E3ppATN3QCr/mZtvmo1J/j1o4Qs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1F3ZFFTbU9sazVzR3h6MXgvWWZoclJaVXlGZStwWTBQZUhFUWl2cUZoYnJC?=
 =?utf-8?B?cTl0NWduZDQvR1JvbWVkQ3oxcTM2RmFaTG9Hek5DR0pST0R4RUFUNGpaY05s?=
 =?utf-8?B?UHVnVE1Kd1VRQVRtSEZjL2h0b2gxSHY5NkpESUlDdnQvT0xVemZOYW9ZN0pJ?=
 =?utf-8?B?RWp2TGFhRXJiRjFrcGpVcmpjejlNSmNqUWJwbDJoa2Zac3gwRnZVSWw2Mm5z?=
 =?utf-8?B?ZHlWQUZKa3EvWHdBbmYvc1MxQUZLMEROWVNwYkFrRm93anMvcGg5d1VUb2dJ?=
 =?utf-8?B?SG9MU3RHK2lySVRFWG4vR3pweG90VitWdXExcTlsSzh6Z3FSTjBTQUthUERS?=
 =?utf-8?B?QitaTE56US90OUxoL3dOZ1U1d0taNGxkcnNOREprOEwwNjM3aTF0SEZ5VWcz?=
 =?utf-8?B?cmVsM01iMjZkbkU3Q1RlNEl1RzRTeXl0ZjlPRU1CZlhMSU5jTXBoNG1oVWpj?=
 =?utf-8?B?MHNrckdlNmZ5VlFTb2pLZTlBMmxaZDFMT2ZjSG0wL2svME92cEJQcytZLzc3?=
 =?utf-8?B?YzdGM1FUcWJOeUlidkxWa3RKZGIvQ3BxWDVma21kMm42Y2E1Y0JhZmREdDVr?=
 =?utf-8?B?UlZOUlJsb2FnSFdzSHpoT08vakZzbWU5bU5Fc3QrS0FlRURmdlpLU29DWVVU?=
 =?utf-8?B?TFFCU2JZbzJEaERiVStRd3lqR1VVeDQ3VTF3eUV4TitJT2dhVENKaGx2ak0v?=
 =?utf-8?B?ZmNmL1o0SWNTdjFYRUNuOFUvK3R5Qll1QWMrdnZMcGUyaEhqdXQ4SkxicHRa?=
 =?utf-8?B?eklFR01BNWNiQ1F4SGpqZExnRU5Bd0xoRGR6MS8xUUs4NC9oY0FSbE1HZTVy?=
 =?utf-8?B?V0VwRmtkYUVVYjNzK0UvNSsvTU53K1hKTWMxT0lQcVptekc3WVVBdWMxaGFG?=
 =?utf-8?B?RWljYTJhQTBaVlMvOWxMNktYajAxaFQxUFc4ZUFoUGQ2TyszNkd6WTVIYlAw?=
 =?utf-8?B?V0FCMm8wTTI1MXgxeUpLNEo1czhUSDkrenJITHdRdjdQNkc4NkJiNm03OVJO?=
 =?utf-8?B?aVFtNWdVdUQ3ajJVYTB3ZjFsbERMVlE3cW9iT3VhcExIWWZGRnZTc216Wjd0?=
 =?utf-8?B?VWtMaHNTaTE0WGVoMTlURHFPN0Z6MTc4VDlNT0h4MGFsdnRVMStWVEg5VTZz?=
 =?utf-8?B?Z3RaN0d4OEZTSDk0S1dEZm1xMUZSa3dzRVc2ZFc4NG44OTJUQmNSNjY0VGNq?=
 =?utf-8?B?VEtscjdKbTlLSG1jclQ2alpteWhTUEJnTmhvSnZWa1pJRE5naDBXRW50RFJJ?=
 =?utf-8?B?dmY3OWQ0djc1WU5lNnY4TkRIQ2VBRXVNNUROVDdLTVJXR2dCTzZWOVI5eGN5?=
 =?utf-8?B?Tll3SXhuZnFSMmlvYjBMKzRMTXhnUkhydzI3blE1cUU5d3g0K3BlNlBibitF?=
 =?utf-8?B?ejk0QjRDTUpDYnB3ZjNRUUJOeGpPdVlUYzJ2VCtnU3E0N21zeUVocUd6emt3?=
 =?utf-8?B?TCsyU3F1cE4wbGlKdmVNYXBsbVBqL1ZsbWc3aEc0bUxkdkpheStHVmFaWld3?=
 =?utf-8?B?dkxLM0JQRW1yNGhISFJaaE1ZTEV0dzdkOGVMZEh3N1FoV0kzNittR1R4TGZX?=
 =?utf-8?B?eDUybXJIUm9CdjA1bDRRRHYzQU1yMXNYUjhFVThFOThuRUtucXhYMDdPdzN2?=
 =?utf-8?B?S0xnSjZXN3pDcTdRK216Rjh2bXF3bXBublloRlNhblJqN0xWVmdOTHJHREVE?=
 =?utf-8?B?eXFjN0tKZzlUdG5KTVhESDlma1hZMElDejNWc3VkTjlxKzZldjBnc3diQjgr?=
 =?utf-8?B?anMzaldCcTRvTXg2ZzZUZ2Q4K1VFUWZhTnpNSWVxSVp4Q1A3a2FCSjJ1Z2da?=
 =?utf-8?B?UldENG1PbGg0K2JqS0hTMlo2eXk0TEZocm5IZHBNVTV4VHEwcExpeHZ3OEZz?=
 =?utf-8?B?WnVTMnU2QWxiKzhseThMVmlQSzhJNDhkNUhkMWxJMzVyMEdCekFIbnpUVXo5?=
 =?utf-8?B?TXIzTk41b3QwNDcxUEhXdllxdHYyakIvRG1Pek9BL3FpUTljRkZEeUhzZlpx?=
 =?utf-8?B?OXY5VVptUk8vbFdYNEIrZTNmZ1FxZUE0QlpJQnU4Vk9iWHcxRCs0TUxNRC9w?=
 =?utf-8?B?cEhNanJwUkRjREE5VDZJWndlMm5LWnA1WlFKVlBoemFvWUtmN0dwd1pzY3ZK?=
 =?utf-8?B?Mml6MnJ5a3hGd1A5K1ZDQ1B1Qld0Z0hOUUQwNjRUMW9qUUZ2ejNlK21WOVNY?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mPUnHKfUp4KAZLiiztlWdo6aeiviNGPXVjr+YsV58Wrc0HmjSKGLqrOkmHfp5mQS3IFHJqmSETF7jckDfUBPaAYTK6aY/L0jlnXqzFVCam5bz/JhInE6OjZEZtRAZhDz5M3JK+e7BuMwFn2DE7eiTyAxPIHeTuCoaDz1oG/SaDH0PioVo0NDH0TBHNz5U69ChOn2NTA+iCPHD5faKHPeq4WZcJ7rJDbck142Sj+TxINJ7GcuPG3rG2Yi4Wwq019qeJinOBf4JI3YlYz1XY/4jxTi7gajNMJ3TjITptOCHGbBaM0dcURfbrWC6Wsb/qVn3t53kOGtQLgOotOfbos/Isp4sIW0OxBTevr+3hu7fdrvLt0IKPWPhETA8ZeARJp6dMa5+NYQBFUUD7jVlIhBR4tS+lviPQL4ghnXlyPEY6mEwbpScT8Rfs4o2mh9WvBLHCoQxcBnY3LgCZDJuUBOCEsVc0FNGUPI3RN44QvJupTZc1lor4gRZzeGYu5soigcu1AlooJ3mq/kYKntFBr8DRXZAkPF+1nvbP9NY+9pXdEnQlJ+x8xTE8SKUFHiQRz2WPftpsGexfJmYoEppMJa9KoVvUWpCsyVgK9/TM9f8sE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e086ac0b-4473-4485-7a00-08dc32febbaa
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:01:23.2766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0Rg6jv4aMhguDMntrjyKCfTM6jY4Epc51fMx8yRZFMf+vG7zd4gAQtqMxf9K1FlImz6vqDCK5yOy2TUCHZFOMrGAvY8hEC8JNEll5glhnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210132
X-Proofpoint-GUID: MMkx5UKnjV2zAk3LtmSz2rJ-jAg4k9f-
X-Proofpoint-ORIG-GUID: MMkx5UKnjV2zAk3LtmSz2rJ-jAg4k9f-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/21/2024 8:29 AM, Markus Armbruster wrote:
> I apologize for the lateness of my review.

No problem.  Thanks for the review.

> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Generalize hmp_split_at_comma() to take any delimiter string, rename
>> as strList_from_string(), and move it to util/strList.c.
>>
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> I can't see an actual use of generalized delimiters outside tests in
> this series.  Do you have uses?

In this series, it is called from hmp_announce_self and stats_filter; 
those were formerly calls to hmp_split_at_comma.

In my live update cpr-exec series, there is an additional call site, with a
space delimiter instead of comma.  Live update V9 is posted but is old and obsolete.  
I will post V10 soon, but I am hoping you can pull this series first, so I can 
whittle down my pending patches and omit these from V10.

>> ---
>>  include/monitor/hmp.h  |  1 -
>>  include/qemu/strList.h | 24 ++++++++++++++++++++++++
>>  monitor/hmp-cmds.c     | 19 -------------------
>>  net/net-hmp-cmds.c     |  3 ++-
>>  stats/stats-hmp-cmds.c |  3 ++-
>>  util/meson.build       |  1 +
>>  util/strList.c         | 24 ++++++++++++++++++++++++
>>  7 files changed, 53 insertions(+), 22 deletions(-)
>>  create mode 100644 include/qemu/strList.h
>>  create mode 100644 util/strList.c
>>
>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>> index 13f9a2d..2df661e 100644
>> --- a/include/monitor/hmp.h
>> +++ b/include/monitor/hmp.h
>> @@ -19,7 +19,6 @@
>>  
>>  bool hmp_handle_error(Monitor *mon, Error *err);
>>  void hmp_help_cmd(Monitor *mon, const char *name);
>> -strList *hmp_split_at_comma(const char *str);
>>  
>>  void hmp_info_name(Monitor *mon, const QDict *qdict);
>>  void hmp_info_version(Monitor *mon, const QDict *qdict);
>> diff --git a/include/qemu/strList.h b/include/qemu/strList.h
>> new file mode 100644
>> index 0000000..010237f
>> --- /dev/null
>> +++ b/include/qemu/strList.h
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef QEMU_STR_LIST_H
>> +#define QEMU_STR_LIST_H
>> +
>> +#include "qapi/qapi-builtin-types.h"
>> +
>> +/*
>> + * Break @in into a strList using the delimiter string @delim.
>> + * The delimiter is not included in the result.
>> + * Return NULL if @in is NULL or an empty string.
>> + * A leading, trailing, or consecutive delimiter produces an
>> + * empty string at that position in the output.
>> + * All strings are g_strdup'd, and the result can be freed
>> + * using qapi_free_strList.
>> + */
>> +strList *strList_from_string(const char *in, const char *delim);
> 
> The function name no longer tells us explicitly what the function does:
> splitting the string.

The first sentence does not say it?
  "Break @in into a strList using the delimiter string @delim"

Would you prefer this?
  "Split string @in into a strList using the delimiter string @delim"

- Steve

>> +#endif
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index 871898a..66b68a0 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -38,25 +38,6 @@ bool hmp_handle_error(Monitor *mon, Error *err)
>>      return false;
>>  }
>>  
>> -/*
>> - * Split @str at comma.
>> - * A null @str defaults to "".
>> - */
>> -strList *hmp_split_at_comma(const char *str)
>> -{
>> -    char **split = g_strsplit(str ?: "", ",", -1);
>> -    strList *res = NULL;
>> -    strList **tail = &res;
>> -    int i;
>> -
>> -    for (i = 0; split[i]; i++) {
>> -        QAPI_LIST_APPEND(tail, split[i]);
>> -    }
>> -
>> -    g_free(split);
>> -    return res;
>> -}
>> -
>>  void hmp_info_name(Monitor *mon, const QDict *qdict)
>>  {
>>      NameInfo *info;
>> diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
>> index 41d326b..e893801 100644
>> --- a/net/net-hmp-cmds.c
>> +++ b/net/net-hmp-cmds.c
>> @@ -26,6 +26,7 @@
>>  #include "qemu/config-file.h"
>>  #include "qemu/help_option.h"
>>  #include "qemu/option.h"
>> +#include "qemu/strList.h"
>>  
>>  void hmp_info_network(Monitor *mon, const QDict *qdict)
>>  {
>> @@ -72,7 +73,7 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
>>                                              migrate_announce_params());
>>  
>>      qapi_free_strList(params->interfaces);
>> -    params->interfaces = hmp_split_at_comma(interfaces_str);
>> +    params->interfaces = strList_from_string(interfaces_str, ",");
>>      params->has_interfaces = params->interfaces != NULL;
>>      params->id = g_strdup(id);
>>      qmp_announce_self(params, NULL);
>> diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
>> index 1f91bf8..428c0e6 100644
>> --- a/stats/stats-hmp-cmds.c
>> +++ b/stats/stats-hmp-cmds.c
>> @@ -10,6 +10,7 @@
>>  #include "monitor/hmp.h"
>>  #include "monitor/monitor.h"
>>  #include "qemu/cutils.h"
>> +#include "qemu/strList.h"
>>  #include "hw/core/cpu.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/error.h"
>> @@ -176,7 +177,7 @@ static StatsFilter *stats_filter(StatsTarget target, const char *names,
>>              request->provider = provider_idx;
>>              if (names && !g_str_equal(names, "*")) {
>>                  request->has_names = true;
>> -                request->names = hmp_split_at_comma(names);
>> +                request->names = strList_from_string(names, ",");
>>              }
>>              QAPI_LIST_PREPEND(request_list, request);
>>          }
>> diff --git a/util/meson.build b/util/meson.build
>> index af3bf56..e1d1e1f 100644
>> --- a/util/meson.build
>> +++ b/util/meson.build
>> @@ -1,4 +1,5 @@
>>  util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
>> +util_ss.add(files('strList.c'))
>>  util_ss.add(files('thread-context.c'), numa)
>>  if not config_host_data.get('CONFIG_ATOMIC64')
>>    util_ss.add(files('atomic64.c'))
>> diff --git a/util/strList.c b/util/strList.c
>> new file mode 100644
>> index 0000000..7991de3
>> --- /dev/null
>> +++ b/util/strList.c
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Copyright (c) 2023 Red Hat, Inc.
>> + * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/strList.h"
>> +
>> +strList *strList_from_string(const char *str, const char *delim)
>> +{
>> +    g_autofree char **split = g_strsplit(str ?: "", delim, -1);
>> +    strList *res = NULL;
>> +    strList **tail = &res;
>> +    int i;
>> +
>> +    for (i = 0; split[i]; i++) {
>> +        QAPI_LIST_APPEND(tail, split[i]);
>> +    }
>> +
>> +    return res;
>> +}
> 

