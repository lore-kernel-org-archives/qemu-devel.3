Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB16DC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpyu-0008Ly-R5; Wed, 21 Feb 2024 12:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyl-0007r5-AO
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:01:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyi-0003HI-HG
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:01:54 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41LDjPQ9012189; Wed, 21 Feb 2024 17:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Vc7LNfFjftTX5UD9RqJISLXJSXlF1bxJ2o2DZuDh0E4=;
 b=MhcrlMvXSNaBP3QpcIvqJ8orIBJum3q2yhOmv0XsCm7fz9vpQuYS+qA1DKHfl4SlM7xH
 RoqDNPjJUwK3kueUlFdz1mVa/d66d5HlUyMJLwGVMaNhkeBrzIAxYEyWvgAol/oAyPI0
 hco6XoUQt3oNQAfIyO/VoZ8BtXxjz74FYIFF+o2I7xANEB/dT4drZit/fj9fiYzytBqK
 zL3Fl2BQcbTK3MTT3GEMvwzpLgZ4CIKTPUxYgUvbqSq9C8ob16eFQsreb1M1weuAtkik
 bz1R6l5ci4FtdZ2Wt/zWS8CQ4fXICH+sCnYLx92p4si3wEc7BlTs5u8JdnxNOJCX5Pd3 +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw1yrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:01:45 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LGicUm032487; Wed, 21 Feb 2024 17:01:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak89afjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSzRI9G27TF+z5KTOmBUoV9kHvZGb1Fge42QQH1bTOVbwUXyVHxKISDmejd9WTLnSP0ujPPFJH5wiaJAEu1aA5mtjglIDRtM7B/6x7pXzWMd7pj5swHAFc3yk3jhXFDalWMxyiEd9UyJmr7/NBHdS3Ab/+f1nCy8X9HkFW7V9YSuU9ZsDoYIGFt0hc2AeYlLs8wOBo5wTzDZcZmNVyulJf4UunCz5NyGrr4mtLo0Xt4MaI4mPPotkwjnEtcGlzaUKOW2As9MQlw9rtFF5Yjf2kStDLM3uatw9u8JSjO2Q5ypBWu1RpUc+B7tfOWvykqrBQNAFYTGEpGhkchYGxTh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc7LNfFjftTX5UD9RqJISLXJSXlF1bxJ2o2DZuDh0E4=;
 b=XmxD+f+sG7InndNaTTYdtkLym2C51BImm/dQFtEy+tx13ho4DHzjgSBwGYJ1kdD/kNVf0oB3vfzzjkbzossGnH7HhU/GhcVRKFufWPqJC0oiIrlleKyDxYi/Zu47sMGD24aWY0fAV89Mky2oPQYwZnpdGm9ZJ+KMB2W720gkHbxisxnG0mEiTR4hSH9EnyEzLgcSTI8OCYXFhwxIUMg+9oKuTQVxBfAf5W8dRprS3E9LLCIq7JIZ9Fmhp2kcYvLab2Md61x7g6P+gubMBWpgmsEhLNehY4pTSRpvVf0zpREcKy0hqXUs2KOR+wNOpjXGn+qy4zL8DAGs1lZWTW4R5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc7LNfFjftTX5UD9RqJISLXJSXlF1bxJ2o2DZuDh0E4=;
 b=tCEwRCgaBriodTlH0balTTAdDyLrRpZyaexoK9JRHkFbzYjEAEmniBtrK9qlp96yiaKCUucKFfW/pGMRR/wZdlYSxGumUMJ024FIP0WgfGlcMjUaqxDoLMqpOjG090Q9XNYBqP75UtwgPy5XZVzM2ydP+b/wNTnKDBCJlzRy6s0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Wed, 21 Feb
 2024 17:01:40 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:01:40 +0000
Message-ID: <67ba0f54-1bd7-4afc-80f5-1f4c4b1ad76c@oracle.com>
Date: Wed, 21 Feb 2024 12:01:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/5] util: strv_from_strList
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-4-git-send-email-steven.sistare@oracle.com>
 <87le7e3qoi.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87le7e3qoi.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: c5785d36-7166-4ec9-aff1-08dc32fec60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQ21hGAdJ29/OactICIS7cvzADeAT/OkCcLRGB4yFwz+H9q7qmFOcOojCCMBTxm+ue+FG1mbeobeJOx6hiWUwvNN+VDBktZjX3JJuP1i8X3hvItmHQ61yKKevhJOwp4uhFzhwn5qRKbG4KIdEf0To9AQ4Ax3zBgIiM6ZabEkxXsP8NLmeDEt36vKSlNLbuDxNtalGDrC8j6ZK9XY3xUrWXaXtns/9DQRvCKtKrF0swlaMGbhX7ohvmo2QpR39eaKPcAojccwa5loyPYbvkeaOAyfskVE0bIerfBZB9BSnQ2kfbMKA3V3MyxBwZGLi5reGlYZxFKZfn39FPgmayfnwmGZIzemfSFY44wWYWRPFURNmj5xqCrM3by7PWRqQWFk+pnqzAwt0R5SMGbpgo5jaImLcxt3l97kEFZ2Y1wDKDelX1euRb/EVPDMRZeFfFW7dzNPaAHx9ss3ESuKkqa7RCtNmVPnJgzHouy5c4HqFqC/fNfEZRZRXmqzl18uhQnEUsPu5SbrKal8e0eJN23E9MXSw0+TVASYKIRJrQxOFi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFlWi9xODlKNDIyVVVlVC9kRFZ0T0hMRml3MjQrcjJHM3o2Vkt0dnJ6RERj?=
 =?utf-8?B?SFZMSDk1TVdvVFlablVVMUYyeHhNbzRiZ2IrazRvVzVidlpoZlFTRkU5bERi?=
 =?utf-8?B?Z0dqT0dOenYycnBzQUhIeXBSaU55cCtzN2wwMk5WejlGcUtZYWlscjFiUkl5?=
 =?utf-8?B?dzJ6OGNVMytIWHdJcUxodDlCb004bnhtTFpLTGZNY3lkRCtsNlpGTUVkdi8y?=
 =?utf-8?B?c3pmWVV3Q3oyTmxOckg3MnVqN3k3K2J0SkZXN3hPZDhPdi9tWDh1bTlnZFJ6?=
 =?utf-8?B?cmlJMkJEVm5YTllCR0daZUg5KzVtS2R2SjFHaDBYTjVlblBFZVlyaVV6YlFv?=
 =?utf-8?B?U1NYZXpWSmFBYlp5U1lMb2dnak5tZVJDUm1NMjVUVXBKTnRNdUh1cFNPSGk2?=
 =?utf-8?B?NDg2ZXIwb0RPdHdXb3FvUjRHVEhCVWQwRFNrajRkY2lRa0VZblI2MHIraFg3?=
 =?utf-8?B?bUJSVWRCdHFSY09VSXZURnVrTkM1MjlpaTVPK05BZzNyZWdaV2dJTXovRFhw?=
 =?utf-8?B?MkFFcUQwaDNVb0R0Tm1JMEt4V0FqWWxGaUxITnFKTzNPYjFFd1ZpUDRzSnpN?=
 =?utf-8?B?bFM3clBSeXZMYnhGRXZIbzk4c2FHSnNZVUVLc00vZ0RCbGZBc3pkYlpZVk5a?=
 =?utf-8?B?cDhrbmNqT1NveERWMXhUUDNJaWNWNCtvUlVpYXE2YmNYSERtZEFUMFVXQTQr?=
 =?utf-8?B?REdrUk9ZZkRvYkdyWUFBdGhHMU1ZdGV1VHNQTXoyMWpCRDZtV1c3STZOVTNC?=
 =?utf-8?B?NEdtOHlJU0xPUEdJRlpETHVEczdJUDhZd0I0TCtsdDhxWC9mMHJlOThTcHlP?=
 =?utf-8?B?cEppVFZVSzc4L3I0SU8rTCt4aDVienVrb3FzSm5uS1hZT2RDV1pBaTNCZm5r?=
 =?utf-8?B?QXZNdW50M3RSKzVTY2dsQW1QVlRHQi81TjN6dUhaNmhHNVdpbWd4Yjk0RnVF?=
 =?utf-8?B?UXRuM3VvY29CNEkrQS9BcjBXOE85OVJVdk9ncHlCV1ppL1NyaTk2ZkRmNWxI?=
 =?utf-8?B?b3dIZ1VVb2VpTUVLWG1MM1IvYVNsWDZPNTA4Y1pHM2hyWjQ4Y3JsUjZLWnVr?=
 =?utf-8?B?b2ZRdjJYVjhkbnl6cHQ1cGU4WlcweGJBdE1vSFluTFYxRitRS3YvNUFCWWU4?=
 =?utf-8?B?WmpvU2lJTHA5SFBQSm5MS2syS0cwVU1rbzhGTTI0YUpUOWFnZ3NqOVB3Q25k?=
 =?utf-8?B?NGtkM1NWQmpqOTJwMUI3dmZSSlNwRFJ6bm8vSS8wdUxzcmxiSzdUc2RrNlpz?=
 =?utf-8?B?Uy9jdnlrZmU3R1UzbXBhMEhoVUxJN3kyN3J1anpaNEVWSmlMSXRnTldUV2VO?=
 =?utf-8?B?V2tWa0gvbHpBNktFZXVWTFFYeTJvVHBOVU91anM2TExNTzU4aGFjUFlZY0Mz?=
 =?utf-8?B?UW54azAwZUJmQ1NaN2xkU0hOa0VCN2c5Qnk1UTlkUjJVZnVZM0dPcmhnNmNl?=
 =?utf-8?B?NUYwbkJucnQwMk1GMDF1cWxSK1NDS2hwRXQxZWxQdFZoWVV2dnc5R3h3Qzcw?=
 =?utf-8?B?bWRQOUtWT1hjd2lQRm9DSUZBcjllVjZoOXAraW1CcnRJRlkyL3N3aCtKVVhH?=
 =?utf-8?B?UGMyV21SQ21Mc3hQdkhYRGo3V2ZKZ0IwWk9TZFNFeGFCV0I4VjRtbGFGcnAx?=
 =?utf-8?B?d0MrUDlQZGNtTUxCQ0ovVG5EU205cGJTZ2dPbzAyY21SMW5PVWZSMENuZzJz?=
 =?utf-8?B?cE1lMUxGcmxkNXNGOC9NNVc0emRqTnc4UEgvSk1xeU9yb01Nd0s3bzQ5SDMz?=
 =?utf-8?B?MUI0bzRCejNBeWd5UHFNbzh0eG43eHI3Q2Y1dGlOanJSZEVLb1ZkM0hSSUV4?=
 =?utf-8?B?YkRCTHVURnh0WlI5YVlyczVUeTdRemdXNzdnUjhGbkswQkpVTlNOOWdJRDlz?=
 =?utf-8?B?dFdodUFuZUtmNGtKc0d0V1BaUEJxWEFzYllqU1BzU1pPN0d4Ym5BZzN6UWJ0?=
 =?utf-8?B?ci9HZ0JOcmZkZTFkUy9vZmZMK3p4dUtxQ084Qk9jSk1QSHR2alk1VWt3THox?=
 =?utf-8?B?dVd2M1JoRWh3NTBmRzZETDFMdjI4MzYyL0dwU0VSK0JVRmtjR3J5T1FEVGNs?=
 =?utf-8?B?eVJKRjVKUFo2Q1Y0eS9veWdyQmZqR1RNQ09RTW9UZzNQWk0zU3M1S3Y2RDZt?=
 =?utf-8?B?SUtsQ0xnaDQyclpYQ1JDM3dlb0VMRHJtVlZOeng2OWJweEs3ODFWT2I4bTZP?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ye0FhiAJXQSfvuicR5quUpcqZpLRoVfUvuCAl5uKEaYWOqdOEec5U04E37ijoWlVDVTMKGtfnhNb7yS3et1OVdvz3xmA0IspCMtpo6J0gqCp+j/CujhNOR9qY38m8JRDkPwjsB6VJ06szIbAh0YGmCEke42NQElCmlA1GybFNriQPG2uLfr3cnQpEvdW9dExiPNFSHyy1eD5Hhs/8E5lCva0jQCep6Uer+K5mg5bQRKU0HusclqsLtjoZljt6+UBR4gXzF3C5/znDeLY0HB2e5mhEzkzQW72CwoeD4KKwsLzrOfhtcZpszUrVLwr+fQ1soEGb+I8Y8Z8PR8OnkCC8lYgafazp+NYRk3a9ZQpvBGXkatlDIAsAoqia/vEpFNJ/08YG9m+NaZCcbcMpRg1FBwMeRUOd9WgktvVL2xob97Qt48kofkvt5TD98zLyTtNPoIYS9cRSXF29frGSsN7phwTZoyzBUH313gzvecoPznZhUPtQg65aq5+/BKT8KKz1UW2+v7SQedKsArU+MdXYdZzf99yL2stMxfAIZyKZ2PTFD9650I+wVteFgzKw7jDO3AD6GVYeubO3IFZyRMxg2Fdmy9DkqezLuRRzx75dTU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5785d36-7166-4ec9-aff1-08dc32fec60d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:01:40.6804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RShbJr4fOUrIe3TDHxpb1BvkAtLKpKsQiFQtZIJL/8m+BSA1lD1bb5HO8qx1ZEAXRDsGpCSJTrJHdLUoHHTVcmIMxTmO8ipnmh1rxD8t2yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210132
X-Proofpoint-GUID: raZSILFTfhFlr9g0RXbs7753dGLzVerA
X-Proofpoint-ORIG-GUID: raZSILFTfhFlr9g0RXbs7753dGLzVerA
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

On 2/21/2024 8:14 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/qemu/strList.h |  6 ++++++
>>  util/strList.c         | 14 ++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/include/qemu/strList.h b/include/qemu/strList.h
>> index 010237f..4b86aa6 100644
>> --- a/include/qemu/strList.h
>> +++ b/include/qemu/strList.h
>> @@ -21,4 +21,10 @@
>>   */
>>  strList *strList_from_string(const char *in, const char *delim);
>>  
>> +/*
>> + * Produce and return a NULL-terminated array of strings from @args.
>> + * The result is g_malloc'd and all strings are g_strdup'd.
>> + */
>> +GStrv strv_from_strList(const strList *args);
>> +
>>  #endif
>> diff --git a/util/strList.c b/util/strList.c
>> index 7991de3..bad4187 100644
>> --- a/util/strList.c
>> +++ b/util/strList.c
>> @@ -22,3 +22,17 @@ strList *strList_from_string(const char *str, const char *delim)
>>  
>>      return res;
>>  }
>> +
>> +GStrv strv_from_strList(const strList *args)
> 
> Suggest to name the argument @list.
> 
>> +{
>> +    const strList *arg;
> 
> Suggest to name this @tail.

ok.

>> +    int i = 0;
>> +    GStrv argv = g_new(char *, QAPI_LIST_LENGTH(args) + 1);
>> +
>> +    for (arg = args; arg != NULL; arg = arg->next) {
>> +        argv[i++] = g_strdup(arg->value);
>> +    }
>> +    argv[i] = NULL;
>> +
>> +    return argv;
>> +}
> 
> Can we use char ** instread of GStrv?  I'd find that clearer.  For what
> it's worth, GLib documentation of functions like g_strsplit() doesn't
> use the GStrv typedef, either.

ok.

- Steve

