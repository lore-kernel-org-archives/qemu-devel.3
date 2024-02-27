Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27DAC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0Db-0005jq-3P; Tue, 27 Feb 2024 11:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf0DU-0005ga-QP
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:22:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf0DJ-0006NT-N5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:22:04 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFY2wV004834; Tue, 27 Feb 2024 16:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h1klW/iSktbCMZgHqGHFvr19kRRmKrMz5s++Z9EF27M=;
 b=K/Sxdxh67MEB1cGsWL2vWYjudzL6vANgKx/ElDqKTh/5y5QzetcTbP18sEMAFQcE4g0s
 2mue/uhI8CIeZ8vZcsKxDNU5wA6KcAD+2ooFmuDRaLE2bS7D+HquN2xhJbScf0mbsaXs
 TYp3ZiUKtQIv621YOa7hVvaoPDHQ6HQpQ6CUqg1NsQeUBN1f+Q8gCscYk6LFtHpOwpqK
 YkzF1TJ3glXcH6rfzjwFfQU1Bb1kt3biQMarWwjVGdS0xaIHf5JsE/UDnYAK57vY18Mu
 k8Fu8Bj2Vp33oXFw4FDo4+ha39X9w8LrBpGIbHspcfqcJR8hUo9ZIAul3FnOc4KG48io dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6vdyqws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 16:21:49 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RFBO59001663; Tue, 27 Feb 2024 16:21:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w7fesa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 16:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1F4/q172pc4UrE+KO6W3Uo9LUKMOKqj7wUuaP6qo9k+DeCRsPQvQhMobULSbkI6LP6oI6NA0+BqSwjv2dNGPanntRDCEOtuOF0Z3qYJy1JQE/IESaPK2AHvXwk/0+GpnFpYVb+3P0V6/rWmkUYWNjI8OtAi+FsjYfpxOk+sCoG6IvaRua9b+SWmJxwiYvyhjY3uhBBlwTHHm8TZJqiotOX/LnRP8b/7/1zW9YEBM3lbAGkpcRT5D1OYPW1umkncaCajHQXLZi8rJ5nkHpjWBKM7XEvc+f4RwG/gkusl5b3ZRPZpKeTP1uPf2Oi032wKF2XxZzc5ygRza/3SxYuOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1klW/iSktbCMZgHqGHFvr19kRRmKrMz5s++Z9EF27M=;
 b=JIi4FtcUImSl5CP5x5sehtytOcOsbBrQBrVVtYwxtFTJRdfvE86R4QOLW/F00NUwPkp7FFztQk6Z5bQtDwsg7lUcJT1H0D7b9atysPsGmALgAPipisHTMqV0nJ6SuvTDwMtbFcUM/v4SZUnJaYKeTCH/GqIoLkR2R5Xivr1xEi1kJiH140pVeWzL0o14jUBLTG5ybzoXuhGTisqdRkDKnNaHkxqP0xQMpwiIr+IsLi8L2gL+7PL62ZFG3L/P36Ti6nwp9jxY3yhasIw8lQgEGjQCxMsw39fTLQVxsvGLPyUqnAehl+GLb769RedSgcHq3juJGisCC8CFrBxNKAsgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1klW/iSktbCMZgHqGHFvr19kRRmKrMz5s++Z9EF27M=;
 b=teYztXgdGZiOzjF1E5/cewC/OcxBrarHrfUgB+I2qPNDN6fKbHsgORY2dX57x+66lZjndWoZSgNlG6hIXpStR5jqVlnC/4llGwryhY+w6ln7AFjCIbiLZyDRvjO6ecFIKAF+Ul3HuWdZRjspAyl0pweGN5uNvVrGuVryvA7cB1M=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CO6PR10MB5556.namprd10.prod.outlook.com (2603:10b6:303:143::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 16:21:46 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 16:21:46 +0000
Message-ID: <a5b160bd-adcd-4f50-b61e-85d6092b3f63@oracle.com>
Date: Tue, 27 Feb 2024 11:21:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] string list functions
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, dave@treblig.org, jasowang@redhat.com,
 michael.roth@amd.com, peterx@redhat.com, farosas@suse.de
References: <20240227153321.467343-1-armbru@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240227153321.467343-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:2d::26) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CO6PR10MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: b5366af0-f22b-45fc-75df-08dc37b03170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEw0AGcmGI6byFz6R3Td5pIxPMUICNXa0iDZjf6vLbKZvFlMFlOQ4YlCzfWT4sv+tXraXc5IiuSMp/UdyuMPLqMn5jdauW8nxqROGCwUe9D0pqQwFRabIkCTJEpnEJgrHQJV/0z6uVAzyq0Mry8fxcOVW2khzLmwqbZrej6bN2jWmQ83zUKL0S3Wq2AR8xaFOK4+XldksbgPnwMKnwNkim0i2fbK2fYLURJM7HPEGQQVnQ8aXIO2OjYbffBod1SjrOXb6GuE3g4M67Zquko2f07HA2VYH5OZDL3k6dQcq2PwroBAY01/5IZxWuuuTRtrh5TPI0uCgx32cA8lE+FSIiGi7gBH14viiPPXERhBetWcBvS5Dp8dJOCzVZJ4zMRzMaXAok5hrXpSvl+lqRDL97xh04DeSfc/o9eneFLZaka3uDQzmhTADqTRpLeoWbTO/sarRwxsWOY2SYOpQqdJr5dMb/X4Mi0wywZ9Mpsz2bjumIHsmylUuPMK6DZg1HzXeuyMeamW9kA72YWF26Px4IQapH1iIq8hy2qekCeXzLPhFZ6E9qqInzgZtRjKdxQCBgkbf1b8Lh5oW2EfKsbvNPIVDIJ1ZbdQiWXxkIfxxiAIW1+lwz1j/mi33mEBI2lt38wYlR9bWbjNBhIgsEVc4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9Hb2NucElMYjY2SXhWcksxczJ1a1dBVUN2SGpsRUxyQnlBZ0lKMEl6WHZY?=
 =?utf-8?B?ZGtkeWZPK2xXMjlTSlNNb1U2NlNKNjd6NFkwT3lEVjFycnQrMWtBTkErSmJy?=
 =?utf-8?B?cjlOcHYwV09oR2dSbWZHQzJuZmsxbFhYc0lnR2gzTVNzMVM1UDJpMVB2Zlk4?=
 =?utf-8?B?cnRrbVcxRXhPeGlrbVFzdCtDajZoVGppOFAvaE1naTNpYVVqNUFBVWhnRjNS?=
 =?utf-8?B?TldRWFp3aXlQVlNNa3poOThZVm1kWndoOFhTQUpyUktmZE4rVzFGdDBQZFJv?=
 =?utf-8?B?aDNhaDB1NnIvLzhiUFAwSUkwRHBhYW9jcFc0dFQ3NjB4Z3BYclpnNGFZT2Vx?=
 =?utf-8?B?Z1NaQWk0U3loWHVubWZTSWhMZENTem80MzFXUlBydDBJVDFCRTNBSTJQK2Rh?=
 =?utf-8?B?bmprNlRlMG5pTzB3MUFGMWFNc3RoaG1mOGRvL2l0SUc1dUl0Zm5VaVc0NlBD?=
 =?utf-8?B?bFNSVHdSVlZFOVJEMDFGQ2x5aVMxQ3Axd2ZxcndXQWcwRHRmR29nOHQxSS9k?=
 =?utf-8?B?V3Vjdy9YcFoxRVpySGp1MnMyQnlZRUtXTTRPbGMraExLRnZ6bU92dThlQ2Fw?=
 =?utf-8?B?STcxRHFsMHlJMzVlaHRxNkZPenJPc3BYVk8rOStBRFZ4VjMwWGdRQXNQOU9u?=
 =?utf-8?B?ZGxTVWZJWS9BRktMdGY0QUY5RTAzVWV3YUQrb3pnZ2tKbkVBY1JUL1E4Y3Bk?=
 =?utf-8?B?QmI5VnEwU3d1RmFXeXQ1UzdheitvYllRd09EeXc1UnhWSnlKZzg1VUtlRVdn?=
 =?utf-8?B?dDlDUnlXUEQ2V1dtQlI2clZNNEZJZUtNQzR5Zml0MXRKYUZjeUZLU2dLRzJr?=
 =?utf-8?B?MEVCcGRJbmROSDJ0WWFSQWR4a2N5VkZVV09FaGpDbTNxVWxWWk0vTGpyUUVo?=
 =?utf-8?B?V2VoVUlCMldseTFDZVRobkhKQ01FL2lTb2ZuSmdNU0l5Q3NpQklQdnl0ajhM?=
 =?utf-8?B?Szd0enZhekxhMVFHOXVlc0kzVVk5aldXMFMxQjd2SXBDdUs2cVdoYUFWdklw?=
 =?utf-8?B?N2VtbkdZWkEvQlBxVU9BYnNHQmsxMVlCVXNkZWxvUFdsVTAwdVVZRHFpU2Vm?=
 =?utf-8?B?aW1Qdk81RVZLRGFTV0JoMXlsRHZ5NHhibU02VHdEblJYUXp4SUs2aEM2c1Vk?=
 =?utf-8?B?T3JiSFNSSHhCMXE5WnQxNUgvWmQrNkVKSWkzSkNXVnp2RmhGeTBic2dueGxl?=
 =?utf-8?B?cXIzRmwrV2pMUWJJeml2RlhRc3E5MWdCV2JneS9ENkpnM0wzb2FLRHBMU25z?=
 =?utf-8?B?UFdMTDNjd2k4NVNTR0tIOFhwQkJseEZ3YVRJQUUwdUl1UFVITko1QTAwb3lI?=
 =?utf-8?B?V2xDSGJldTNhb2NVb2s3TXZ5Q3pZUkhWS0cvZENLL2xqL2RSMmlWNTdWSTV3?=
 =?utf-8?B?d0pSdWFiS3R2RUkySTFOUExzSXZPbVRrMklybFVuWDh0V1dTOS9EUjh1ZVJt?=
 =?utf-8?B?bFBOeXdaL1ExclkySi8vYmJ0MTh3K1BJSk1tUXprLzBEVEIyOXhIMmx2NGVp?=
 =?utf-8?B?dkdMdWlvNjZDN0F6VkxkTDhvUFA5dkFWVWRoWFM1dW9qUi8welZvTXlxZW1x?=
 =?utf-8?B?UUFjUitpbExyV01RY01kVnMvb2xTcVRvdWI1Yit1ZGErRWlXQm9Zd213MkR2?=
 =?utf-8?B?OWZjQWJBZUhwZnFubzlJSjE3Tk95VXZib0dHbVNmRS9FUDZBT085RHRnclRS?=
 =?utf-8?B?emNiZ1V0UGJzamdBRXJrNytNTlNrQXhTdDZNd3VhakhtSGp6aWo0NWoyYjRR?=
 =?utf-8?B?VlBxNXdDTzdic1lXT3FrRFNSQWRVTDI5OEMzTzhPaGEyd2xWaFc2SSsyTnNG?=
 =?utf-8?B?dkhROC9ScDduL1VSa0tnNlViMCtOY01WdTN6WlNoaURoNVpFVTQ3aFQ2Sml1?=
 =?utf-8?B?OGRzVzlvSzB6aWpPZ0hidjNkbHQ1cnVSbndoQ0VoNlRkbExPTWtKMm82RGFX?=
 =?utf-8?B?am5KbWY5TzZtZHBVUU9rRGljaG85ZW5WajVBbTZGQ0NGcEtRVXUxa3R3R1VW?=
 =?utf-8?B?RHpFMm5sMEtLcWVWWjhrOU8yTlY2bE42SGd3K05HSndVV3N2eHpoUkVJTHlq?=
 =?utf-8?B?VzZVZ1lmUnlMWTBPZHBWMk1GdnJjUXFQSEZnbW42Y2JtSGtaM2h6RXBNZEs2?=
 =?utf-8?B?YjdOMEdvQXJ3NFNsYkpsR3ljWXJ4OWt6MU9RU3RzcWh5Zi92Zy9kTDRBZUVq?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OqWh8+HKFiipTQ+smHeb6HDf8xCUl2OFrmznNv4x/NlFjs/7fTlxBUV982lI1zTSrtwWgqgXwI6EGAP7vTPZG1+jWLWdd6S1kkduIatC56IvKIAyqaqtyjrHtaso4ITcNnkRbvNLIjvXbYXMc4IidV89fHyLwEYB81ZFb38Z75UEmRsdkxrX7KL5G2NMqaUEtlLGsOvYqHFi35VVKk+iPYz9uBIu7aBvaFiKggqjiBR8OmY8jGyRl8OiE8oVfdEr61WrH2mDHXum9cqh+lzW6ws6Bp64cyaei2wmmKDNMrHmRdXCGmH7sp3fIEThw1jwOUqvQTXYase3ivst6Fub9HSoQntTySUpMWwQK/8FHJz8QO1HmPWvBQnYtDLdGJaq4oOuqysMLdMQr5vRgdI0BHsj0oIVkSdWztJCupmkBRIjPyBmb/PNp2BwIPf4Mw5BMU1fO0A8/N+v6K3kBQXGoyr847DYvRrHc6AYj8CcGG0/EfXrdR907HNVf6yZDDSmbFHPBPHY6KgYmSblkDK4oPSAqYqEdAHB8rJgppJ347/ccjS/vYI6dU1uxEVfwlBauxN5oT8XflIH1N4n/tX8NsdphW8CHCfYt5pKbaexqMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5366af0-f22b-45fc-75df-08dc37b03170
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:21:46.4357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goJ/+E6g/c8rjQKWSZeOPEr5iImdlDpADXuwlz1SyMzpt3JDGlr+Oi7JzBscFHwrwdiDyEm2QEwwe1Rmv3wYTvWLqorRwXIF0GoMiYFHak8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270126
X-Proofpoint-ORIG-GUID: kjWtMLkhKAhRpiWVteJ9isQJ4qQdlDWD
X-Proofpoint-GUID: kjWtMLkhKAhRpiWVteJ9isQJ4qQdlDWD
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

All the changes look good - steve

On 2/27/2024 10:33 AM, Markus Armbruster wrote:
> This is Steve's work (v1 to v5), tweaked by Philippe (v6), and now by
> me.
> 
> v7:
> * Old PATCH 1 dropped
>   The proposed str_split() is a composition of g_strsplit() and a
>   conversion from char ** to strList *.  I'm willing to accept a
>   conversion function str_list_from_strv() next to
>   strv_from_str_list().  I doubt having a function for the composition
>   is worth the trouble.
> * Old PATCH 4 dropped
>   The tests mostly test g_strsplit().  I'm willing to accept focused
>   tests for strv_from_str_list() and str_list_from_strv().
> * PATCH 1-3: Commit messages tweaked
> * PATCH 2: strv_from_strList() renamed strv_from_str_list(), and moved
>   to qapi/qapi-type-helpers.c.  Function comment tweaked.  Local
>   variable @argv renamed to @strv.
> * PATCH 3: Adjust for the rename.
> 
> Steve Sistare (3):
>   qapi: New QAPI_LIST_LENGTH()
>   qapi: New strv_from_str_list()
>   migration: simplify exec migration functions
> 
>  include/qapi/type-helpers.h |  8 ++++++
>  include/qapi/util.h         | 13 +++++++++
>  migration/exec.c            | 57 ++++++-------------------------------
>  qapi/qapi-type-helpers.c    | 14 +++++++++
>  4 files changed, 43 insertions(+), 49 deletions(-)
> 

