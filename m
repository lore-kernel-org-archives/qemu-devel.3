Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129DFC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezX0-0000X0-EW; Tue, 27 Feb 2024 10:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rezWy-0000Rs-Ee
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:38:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rezWu-0006DZ-7E
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:38:08 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFYm7q009955; Tue, 27 Feb 2024 15:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iXSSdW1UAf5hFWK+0a/vpFJMZutucZ66V1jwV1j/wJw=;
 b=JTUhQv4ss3cYOnhxQjh6QQopwJFGzrsxxoafCZNMLfc+SemDJ8xU7VQ0Fo4m0FCAhJbs
 rcp19DbVI0BU5Nm5GKhX/7RWk9EkBZJUWAX1kJyqkWE2zBVYszhHy0aZLr6YGDPW9/sY
 +7ywXB/DsS45APHaMTZgJcrGhwkM3//kiyTymD4DdjqIXSU0vndAbToI/5gulEI7VhSa
 tqEmkelGgprIZC6N3Oa7BamJoMuzev2O4slzQNHLzNprw7AeFZsHxWZ0GiRDzRmSAcBH
 A6PKsM70Wb+JFjFpTDJpLoUY3QMppdgZzgaJ4ocd03XkkPwGsNrswMCnKNiyKdi85cZZ CA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u7e7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 15:37:59 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41REo8BE019283; Tue, 27 Feb 2024 15:37:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wgbdk7ht5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 15:37:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4JTsBSJQylEuFmLGtMDnS9Aul+ShG7tdaF/6eEaiOYzMvVt+TaKKeLfBSJIbLX5kMlBNzz4qRhf//+FV4ATi+EA8j8/solwXRtvlSx2sjG9FeLdhMn3risHzeN1ZqcWbwTe4IDWvBVKnxYxhJFbE8F600V1dN1nIt7iYQt5o+w5Dr2ZllGEE8BKaqRgDHt+n++m2UyboduLusNn5Z5YKFnkFiCVIRH3sL7mxezgvW0kU9Pk1vEMx/pDp3I5shbFDCVKUmCwQpMem54WX760l8ouFuwyqirkVmpWD9uoXm6T1eU5/ruRapAq0SGaffGmZ3AE3kwVZNbjpKZq3AEYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXSSdW1UAf5hFWK+0a/vpFJMZutucZ66V1jwV1j/wJw=;
 b=K/h/K7v81mRyDOyACF+8K2Deb2SeZv/I6msMS0niJ04XQpGLUCkcco0lHH6PlD9b+U+51CBKQAEgT6NS8jpOGXpckrADAaJn/vZQMTI6NCsB9FVQHHGFXxXyMLxRlg1tI69Nj7u0Uhb/Sw2DBsqtvCWG92FxK5selqkgZAdORwgZiT9DUveLTCH6NHHDdIE6kdGOyK53+qkKAhIXgCMPNP2poCpGud4Ns/6kxw3YIlMvgVuq1KgK3ujfNQj6G5+KaqkLc2gaoFFDn+tziYfZ7PS17UPnjo4wH/T+1Ms3KeGFtS+3YKWpUUmScUdLJeKB3i4v+klfRQcz8NrghdRTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXSSdW1UAf5hFWK+0a/vpFJMZutucZ66V1jwV1j/wJw=;
 b=TMPI10bLL+EimPDzyqofRrcujAcd3Il4LQ9leK3rf3VEvF8RkiF5EqMvgWGPNgX4H1KQ9QbfpUHYQGCIKiuXzxWuchuVPUkx5D+rdQ7Nwn2KQacmm/NiBEsk940U/o90rIgWeKFcOwAavCkPhaS1byowWtVgIQwEtzBzq/SGsbY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH7PR10MB7851.namprd10.prod.outlook.com (2603:10b6:510:30d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 15:37:56 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 15:37:56 +0000
Message-ID: <f27bc152-371b-405c-9c48-994cf3c928a0@oracle.com>
Date: Tue, 27 Feb 2024 10:37:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] string list functions
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240226141108.73664-1-philmd@linaro.org>
 <874jduapug.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <874jduapug.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0176.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::31) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH7PR10MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc6fcbd-a7d0-443f-d9e8-08dc37aa11d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lQCFgvXq9La7iDy5KN0fpFG0tdIYR3HMgPQLjJLKBO9rp+LZn6iOxSkGJapZNhRl5XYan1B5lW+5S/kP1Jh+16IkOGLRHRBagErN2BaitbPlGGMnH/BW5pzFyD9BJ3NKuAGrOdiU/mCi5hS41v2UxiKiuH9YuV9mYHnTlvsCRsW64PEZ2xd8jQluqYP36KVGJHLqYTayjoyNvuewPAcDBwsLesUVVvyMTnNlMfQZ9GmvLQuCqukzP778BNvUAorBT9xhp8azB8Ia1mTgsxt+P9eUhuo8qOpG8ygKuLBBppKGzkp3PsxWktI9FgjMowhOZW9cniycAkNJGNCMTP6FJdugvB8BHvG0/C8r02FgDcVjrRdLeHiF6ov1ihJmWlstB3HoIFomzi5HJGbXfzFlhwrceEd93CO9JTI4lk7vNVbzIYuCFEeBhnNAO+82KEIV15bCNaY2Fa9MhgkpjkyH9xSditStYSJtPRuClJvKJtn9q/hPtEC8Qh0ut/ZI5gd7KguNpvdLiOBdviu1A4OOlIIsYe41CNkPkzCL98PNIilbeBVxFOR6t2mrWIfEIAR4NCZknWbazQb/OGZZ7AEO75A9x79rb3gTPffcx9oyImLazsTAq3QrYPP+dF+D6vOLPo8P/gwRE+VKW1Ee6aA8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZSQ2dYc28raFBUa2ZGdyswbDNrZGJnVUgveWVCRThIUTVBMFNiVm9rUWcx?=
 =?utf-8?B?c2pQUnFsTzYvdEJwQVhOc1laS3pWcXRwWEVwNzVwN2xwQnlSeUxsREtkWncy?=
 =?utf-8?B?aFpwNlNReWl0MWM2SW1rcTU5bmdFWjRsUUpTZFNCWUphTGNRYU9vZlVYYXRj?=
 =?utf-8?B?SzZxblJlaGRSR3UyOHovVzQ3VFFSZ2NGV3RHUzI0aW8yM2tGRzdvTnhZdVBP?=
 =?utf-8?B?NjhUM0hXS1FQaW0vU0QwMjhCYTFsUUw2Z2g0SkxHcmpUcVRxWHZlTTU0Qnp5?=
 =?utf-8?B?T21qZHZDenM4Z0ZJUEx5MlRzS0NiZko5OWt4cFlaVmhETFJnNW9HS0J2Y2F6?=
 =?utf-8?B?UVB1ZkxZbW5DdnhxYnpkenY1RjhtMHNMNjVzd2VSOWppdk9CK3RnVFNyS1Rk?=
 =?utf-8?B?N0JwUDBFRHBKbDZtOEN3UGhWVWt0VnUydGoyVTlSVUtJOTRzN0p4ZE1EWVgy?=
 =?utf-8?B?QXEwaVZKMVpHQWcvenJVZnh2ZWRLazdqVUc3NEUrOTMvN21IQUlUZTB1RGZV?=
 =?utf-8?B?YUFId2ZsQ2QvSGNtcjg5TjNDSFRaSnZaRmdQbkY2NWdxcEc3bzJKcEhrTmxN?=
 =?utf-8?B?MlY1NWd2NDB4VVFzQjRYR0lFRFZiRFRSblg3SHFERXZNN2xkQlhJd29oT28v?=
 =?utf-8?B?V3d3ZTdBc2dMTko1dFI1VFRsN1dvS1NqL1REZUozaWtFSElweXBNajJMTzRs?=
 =?utf-8?B?MzZ6clVGVUxZWisxYVR4czBTOWZxcCswck90cFp4UWhTSXk0NGQwUTlaR2Nv?=
 =?utf-8?B?ZGhBaGU1cm5yTW9rUkJMazRmMHdyTy9YTWFPa0srWm9WRmJCZ1VwL3pCSkpw?=
 =?utf-8?B?Y293OGw3RUs5TDBsOEpZUEFtNWNOajBqUlMwOS9FUzVsYU9HWmxueXhTdzZQ?=
 =?utf-8?B?L3ZYUisvekFYcnpVcVF4Vkppb3NDbzBCeEd4OFNOdnVOVUxrS1B0aUU5KzNC?=
 =?utf-8?B?cnpXeVNtOStraFY3TS9SZGVCNDhHWU9vYUczQlNtZ3ZUTHVoYUMyeDkzcXZB?=
 =?utf-8?B?Kzk1Zk14V3RVUVBIVXppQUozalpLc09YbG5LMndmOHZkWEVKa1RheHNRcUdq?=
 =?utf-8?B?MjZZc3ozNWQreExDeDRHVGdqeEU1SzV2c3Z4N1M4RUI0anFKWCtlOTNNWm51?=
 =?utf-8?B?eS8wekJ1YXB0cTZveXdUUnJGcERweEJERy9wTHdqRmczQXlvY241ZFVIT3VE?=
 =?utf-8?B?U3kwbWFySWlKamRLcDl0UzQ1ZVZaYmFKdXkvOFhqUTRzSkhFYUcrOTVyT203?=
 =?utf-8?B?eE91MjdaNzJqQVBhY29PZlIvUTBWVkh3b3l1NjQ2cWV1dVNNeFB1YUh2dEdC?=
 =?utf-8?B?MkFhd3dBNnhvbnJ4bHlPOWtQUkVLcUpaM05GZldZNStMNndzOEwxUC9rUVFx?=
 =?utf-8?B?TG5KSzZCMjhvQ3hNUzN3OUQyQkgyamhoN0NpazhsNHlLallaV2VISXozQVhM?=
 =?utf-8?B?U2NDVi83UitVK3dGeEU4NzZyeFNRSUlDMzhNdjFWKzB5SHJ0VmZWRGdTQVp5?=
 =?utf-8?B?MXpWN0RSTnljUHFPdGRFeXRTYlVZY2hoTHRyTUZEQ2pCd3ZJUE1aUDJoazNl?=
 =?utf-8?B?SGQvOFJzUWRNQ25YK3l0cERMbVlLKzYvRzdRMVR0K1g1cm51RW1pb2pIdTJW?=
 =?utf-8?B?ZmowN05iL2RjTDFLQ3FQcjQyVW5qMmwzVHhqNzVLaElERGR5OGtlckg5ckdZ?=
 =?utf-8?B?OWJXelBybGhFaHhDQWFBdSsvM2Vua0s4VUcrVStTOEE4MG5peTc0akJJMFF5?=
 =?utf-8?B?Qkh0UnNUWkRUbHVBMktMVHlWUVhvMHh2dndKOUdXakFmZ2tOZ21uS2I2dlht?=
 =?utf-8?B?Tmg4WDJRSTR1ekVMWm1lQnBsTW0zRVJKWHkrT3VVcHRSUW14Nm1RVzdVb2Z3?=
 =?utf-8?B?NWlCUnA3OCt2ZmQwRDY3cmR0TjVrN0ppV3BPTXQ1TTQrMWFodEoxSStsRkM1?=
 =?utf-8?B?WVJ3akN6ZXRrRkgrQjRaU2RXUlROK3F3ams3Zk1MT3FFTlp2cUphazUvSlRv?=
 =?utf-8?B?b0pKYlJneUk3aC9Xc3U0eUhqUlFFRGptcGFXSTl1a2pZanZKOU9mMGp4RzU0?=
 =?utf-8?B?TEhMb0t6SFExRFVJdGVPTzZGYXc3ZFdMZm9qWnV3MjBnSHhVMThPdmUvVWdj?=
 =?utf-8?B?SWNYSE9GUHdNck5Tc1k3Vnhuam1DakRGYjFyQlJ4MGo1QWJST2VlTHIwcHlB?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xu/grRvivoxlNROTO2bYigXzUzII8d1KvJrGmgCsSb+ZmSm2ajObwbI3wlX8XH5gDZpnPt72pb5juyYuOmlb8BrzgSBS3L9AMMAEIsMoCmDlnHL1foR9RTPxqaE5p6p05EmHWwWA72A3r+u8tbj7LGynb9pY4s0QwWZePmwW5ZWs6VXcYKnGGiFx8Fm6CVA06DTnxtpAEFxgZI1jxcEPkpyNrP3H86YmdOVc64DcaOpcG9/oD18r2I3zfnLBHI79hIH4ULFXA5eTv99YpMNKX2u+VENmTAUTK5e2g3L9cKO+BU7uenZVOZRMdjqFUJzCtEWBsdeaE2d2sNaf+t+nKwHLU3tMwy56jeK7rVO7dWa+wws80CmmdUAu0Spg4tk3NFyftRjFllVDYUZNaJGO/fOXVSObdZ6gVRvKfbfNlXF+GP1DhVf5Hhu1VSSUpFGJAGNfea0o1H4DXYbtBR3+g9dpbi1RdCVbWPhmkGH8yxe6jMOsjPAotcSgevvLE1tB7fWdfsJ92USJbs1V9hEq4UlpQgOFeQbBSmqo0Av+sHrujw2Ir/VcyonAi8j3M2Icwpjmflf0+9iEx44XDOQFEnrjp8bjQ+aDpvJ2prK6zos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc6fcbd-a7d0-443f-d9e8-08dc37aa11d4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 15:37:56.3922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DUNM9T5izID6Vwiyi2Cb59+JvXDOvNURWa3wItQLPbzN8nKNcopGzlzqDHuYROVccBNUbmZmHR0tbCc9rDoj7SSo+LGgCpnP1wR/gMPicc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270120
X-Proofpoint-GUID: BFUwS_983AEA_lCsD5Vx3JRP2GxfaMjR
X-Proofpoint-ORIG-GUID: BFUwS_983AEA_lCsD5Vx3JRP2GxfaMjR
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

On 2/27/2024 10:28 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Hi Markus,
>>
>> Here are the patches I queued until you told me you'd
>> object to the CamelCase filename strList.[ch].
>>
>> Steve, please take over ;)
> 
> I'm going to post the part of the series I'm ready to queue as v7, with
> minor modifications:
> 
> * Rename strv_from_strList() to strv_from_str_list(), and put it into
>   qapi/qapi-type-helpers.c.
> 
> * Tweak its function comment.
> 
> * Rename its local variable @argv to @strv.
> 
> * Cosmetic commit message tweaks.
> 
> We can then talk about the remainder.

Thanks Markus, that saves some time and email.

- Steve

