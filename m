Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA30CAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28vy-0003gU-AG; Fri, 26 Sep 2025 09:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28vs-0003fw-J5
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:56:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28vl-0003hW-3i
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:56:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QDtAvx018906;
 Fri, 26 Sep 2025 13:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=A6P4AdH9CWyCQ4M08leJqpzWgbp+ba+blhKvaOyp+EE=; b=
 NLL723N4G0rj/j86rOqW0BVdd+95zr33cVgtZYvTshAxvlbQ4T/aj2AmGxbdE3gt
 dyabkpOrowZ0iXSY6Yg6oX5COjkasrpcrP5ciWioG9D3ofUaVOsRK5nwvjfGqa06
 mRwN8Mn27aNlAqpEHc6vScROz8U/RJynSL603T0kR8HOvDdGW5tuMMFGgwFflUZK
 U1b/tl/Sgpr7eEiNC4GS5oTDejxnUbdOA2o7FCkIa4kQjNyxUwUZFjwIoPp0NQ1o
 PWLnS/NX6ULbcLdsKmq/sICvBkSrH3SJUHp7WpeNmztThRJikY4n+Od2wPeZwCWD
 eG4GPSCzE1u0pJmvlqKtdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dv4gg01p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:56:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58QCDkSo036794; Fri, 26 Sep 2025 13:56:02 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49dawkgxbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmVcu6XM4c+GYI4cfH+sk5AgbrjK1GslXYqy2bpfa19ZksXMbIGp/l5nkPE0Qhol6L8e6Hdici9h+N362Jz9a+m0Mrc61T91KjkImmRCOQsurMVu9yRJ4VAzzeE+OaEAWKNED2TO6oQ2iyTiVaqIS4T9O5+yCRjgO1nU+VKxX96IfAD2zbYO4zmMGCi2uVmjqHfzVsxXWuq0vAf0CPyGKKgShvXyZZMn/zMzpqlVS4+Vd8dDsp+5nq9SIFcpv2ndrX2UKc9ht8S6M5+2iX0wl99gMupqyiA6dECcsCm8f4WWPIaF4iorLpbEjTHbFjDkzKrw/aizlgvu03ShRSrEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6P4AdH9CWyCQ4M08leJqpzWgbp+ba+blhKvaOyp+EE=;
 b=X5xeduyLgml0F2LP5Ockmoq1VNd0dzht5y5fc7Y8kD2Y2TF0BFuLidh5BG2KU3S9+fxhlb9HQyJKynJ3sW/iG76WsUGPD20JDnmdYZ/EZXEJ7BtcbNhieCGLXmjvazkgUpt0V4HzAyvAjurxjLQIYZeswfkf0uFm9AC2UyXpvIhjGrryMEXH8Nz69w1lQ6FDSu3cuRCHmwZyV7NjNrh8alY4NASZ5eCXpEIwoelf/+2JNpN7oOSticoiODfIdhMbNsVwk9N7bvV8bKLWltAsqi/SQSZ7epT/vCWOO+d3QK06UjYBxtjs1RFoZu8kd3EpbJYHmGf//Zquj5bEdSplkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6P4AdH9CWyCQ4M08leJqpzWgbp+ba+blhKvaOyp+EE=;
 b=LolANYvUbuhfXwzpBxlNWWXlEdW5e/ZZA5n2lcy/OWyd5oVoERAikSnTgt1Hjrg6xN93j0ssQAYGbmAjRob2HpwXQzkHJ5wDrSdJQjRGeSJCfC+M76EKnTr9uInm8heI5WrBUBLtYMx5gTOmu5DEvwvPxSgi1QXUOSbFd5XkLRQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 13:55:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 13:55:55 +0000
Message-ID: <b13f895c-3808-43fd-9aa4-602e05227662@oracle.com>
Date: Fri, 26 Sep 2025 09:55:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] vfio/iommufd: Save cpr.ioas_id on source side for CPR
 transfer
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
 <20250926022348.1883776-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250926022348.1883776-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 401318dc-bd64-424b-776a-08ddfd0469cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3pXeWtTaG40ZEFCQjlpSEprbUVLdWJuV1Rvci9mc0l4bDloTGFvc29ETFd6?=
 =?utf-8?B?RnE0dUQyalBvWHRqaEFCK3EwUU1IckYvWU5Fd2NkUlh0L053Z3daVkF1dTNk?=
 =?utf-8?B?aXp3LzhKbTU1bU1lVmpMdktPbWFBbXpCWTdvSjB6T2dWeUlDdFVIOWhtWDdL?=
 =?utf-8?B?OVg2aGVvbTR1YnlnaDNDajI0K1NrT1hiWkh4dHIzQUZLVWkxTmhpMytld2Ry?=
 =?utf-8?B?Q3AvZnc0K1JlVzRFY015amJydjYvbmMrWkZPNC80SHRiMjVQTlRTNVFXK3RG?=
 =?utf-8?B?VldYdCtDQ0NlKzMvSGR6K0t2MHpnZ0M2K3d3bXhSa3ZzZjJreWN3SG1zUXhl?=
 =?utf-8?B?R3g0QUZVOWZBbUZySnpLNnV3N3pNWElvaWZzUDA1VDZJdCtLaFFCWS9pWS84?=
 =?utf-8?B?eHVEYjdXV0dFS0tXM0JIbmIzUzI2Y09ONTc3SUZQTzdnYnFxOTBWWFRzWHNm?=
 =?utf-8?B?UHZGZDNZdGhLZ0FWTzBNTytkV0RGVFdFdHdLamx6b2JGOFduWElxQ1p2RVVE?=
 =?utf-8?B?R0RVeGdGakdtNmVubFNRTGo0bjZVblp0ZFlLQlpNOUZ0L0pVU1B2UURCU2pB?=
 =?utf-8?B?RUhweEsxcUF4S1JxUHFzYlZoVGZhS2x5Nk9CVDlxSzM5UXAzY2wxL2I5RlY3?=
 =?utf-8?B?T0dURTFZTE9FSTZwMitSN1RDSHFIaDhSU2Q4N1FPVm0yckZnUnVReUswSG9D?=
 =?utf-8?B?U2dZaEhqZmFXTmVIY25VZzZpaHcwSzNIQy9GRDF6YkdyUXJjNWFuMXNKK3BV?=
 =?utf-8?B?UmY1K21jY25tcm1vM3EvcFV4SHJPSzNTdk5yNTkwRGEzQ3hiWXJhbkZKbm1F?=
 =?utf-8?B?cllrSEN6UWtLN041UWNZSlRmUTBZejdGMzExa0p1TjZEOHk4TTRyb3ZGa3J1?=
 =?utf-8?B?TUE2ZDRxSzBIMEY1SzQyY3MzbGdRbWlueGkvSEVHbVU1RTFOR2dNWXR3SCts?=
 =?utf-8?B?WHJJVkwrUmw2bmNVbGo5NWMyUDJMOUF6ZVRCZ25PL0M5ZjhxM1NDY0NERE9V?=
 =?utf-8?B?WEpZNE10OSt3SEQ3UlhHRzVUN1M5ZnB4SlBBWHEwSHJma3Zwb2lxaEdYM0Fm?=
 =?utf-8?B?TUV2emFZcGFjMjlqRjdwNHJyUy9CZ0RGOEtNNSttQ1hYVyt1N1Nnb1p6MDJS?=
 =?utf-8?B?RHgzaGIyN09BZ3pWcmtRZklRRFowbGJJSGZkOWFHandGQkZWSVZnSW02aHNJ?=
 =?utf-8?B?UVRoSzdWdVZxY2FiVmlTYUw3TklmbmdwOTZvUUx4T2w2cDhnMUlaSkJkR0E4?=
 =?utf-8?B?QVBqL0pNTUs3VGd6VnJVSWUwTGdId3I0V3JTZ3UrdVRJOG5lSXNmSkdGbGQr?=
 =?utf-8?B?dlN2RnZUbEl4b3lLS003c3BCNFRCNzJ4akg2N0JuTnMweTNwczlDVEVTSzlL?=
 =?utf-8?B?TDdqdEhmWFZtMnVsRE1Cd1NOUWIwVlJnU3BVcGx4YUNEdXE3alIrMGtsMERp?=
 =?utf-8?B?VUFhV2treHdIcGxGSndPU3dOWWJvdXlIUDBTRzNabmpaaW5QdVlkdHd1LzBa?=
 =?utf-8?B?cXEydjBHUEZQRFhEUUUyKyszK1UyNWtnYXd4MXd4c3J3dXBvUUZUdzVEY21Y?=
 =?utf-8?B?NnB6K28zTTJYa05TK1lJR0F1SndyUTNKRk1CcjduTVp1UmZuT1lQL3hTMFNj?=
 =?utf-8?B?K2xvV2JQRTJwekxrS3ZnNk5TYlJncnJoSGNyaUZ5cTJSYUFtR0hrVTJ1ZWMw?=
 =?utf-8?B?T1FSY0oxODlMKytZdkpnaFU3WFYwU1RNS3FiTjJJdU02eEF1bFQ2MC9LbzRT?=
 =?utf-8?B?QXE5YStIeVk1MDZVWHZVdExhenF3cEVjYndyWGV3SjZVRWZ2cWhNVExKZWc2?=
 =?utf-8?B?elZpbmY3ZXBwRm1WT2tJZXFLemJXc0MrMm9OWVczYlV5YjgrN05SWS91bVhX?=
 =?utf-8?B?VDlXdmkxeS9DZnNEMDQ1TVgwU0EwTU9RQVByWHpsWm96KzJ3RzhuVUsrejN4?=
 =?utf-8?Q?v44tqmFaqiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRvVXNLT0hEcTFpcnVSTnhCUHZVbmd6R0NwRXFBOU1xTUc2eFdMY0JOQWVz?=
 =?utf-8?B?NURCZm5zekNGNlNWNEd0bFpSMytmUzNKZEdBbFhZdVlENUtUWkY3eUk5cjFr?=
 =?utf-8?B?ZmpEK3dEeDZ3empBckdjSUZaQ1d0Wm9hdnFCTkh1Ny8rdTZQVDFaKzJ3blpY?=
 =?utf-8?B?MjVXV3Y2VGlMNzB5ZGEwcFk2YzgwUlZMcytIeGVOdWw2Z3U2MmEwWFYwekx4?=
 =?utf-8?B?UGtMbFF6Ykhjd213MWJwMjRTUFdMNEZncUpyUnl4aHliM0hKMS9hWTFKVlhY?=
 =?utf-8?B?Vk40a0ovRm5Cak82dWoySGdINmxlV043ZWsxTmpXOFMzYjQ2Q3FSdG5FVzZU?=
 =?utf-8?B?L2U3dFFNN1VzYXBTaXdnWDRCQTY5NU8yZ051b0tuNWxNQ3lDWjkzKzkxdFJ4?=
 =?utf-8?B?ZlVJVnFlY2VieVIrUnFSOFB6cmhpeExMUHNYaitWSGZFUFpaRTdUc1FBNlJj?=
 =?utf-8?B?YVkrbU5HRU1QbGhYY1NTSFlrZTZqZ0xKTytqYmV3K21lTkJhajk4cVBXbGdh?=
 =?utf-8?B?QjBIWTdXSXJXNDVRUlJiakcrUjhPbjJ4MWpmUGNwdEFDQlFuYkVsZGRZUDBE?=
 =?utf-8?B?eGZHOUgrVkZhNVZGTXAxWkpNaHpLVksrNCtWQUpuN3Z3Y3R0QzdtUUdWSTZi?=
 =?utf-8?B?RG9aV0dGRnBkcDQ5UUhTU2hYMVJTcUVqaEhlOXBPeFBmYU02QVZRb1daanh6?=
 =?utf-8?B?UWVXTmQyZkJ5ODdLNDAwT2YvMTlhckFRL1NtOEhFaHVybFNNU1pUWmpGczNX?=
 =?utf-8?B?dHFVc3VzQXgyUjY2UXZ5N1FKY3RzcU5ha1dHQ1RobndQcGg0STNaR1RYT1lF?=
 =?utf-8?B?eWJXZjB3VHJPeFVEVVV0S2lYSXk3aE5SOGNJc1NXeXBsYkxjd2ZrcjdGa0Er?=
 =?utf-8?B?bWJQUGdQZzJ6V0x0Mm8xOHRtcHJqZXV6T3E3ZzZJQ0kxTnNRMnBnNElXUkNz?=
 =?utf-8?B?V0ZZKzlseU92eUR0dlpJTlFCYm1vaVJNYkQxZWU1eldGM0JqeHpmYWh3UFZr?=
 =?utf-8?B?dlRnanVSQzdxSzJ6QURtUS9zckRuR1ZZVElQZ004T0lFYXpXNUU0bnd1dHZR?=
 =?utf-8?B?YVhBc3A2Z2d1RFh6c2h0K2FtZmVPTUVHRWlwOGszVi8xNUFNSERlRjlsUjFT?=
 =?utf-8?B?ZDIwSXJBM0VBK2szNkJmSCtIajZ6bHFtR0Q2MnhZdVZlTUlHR2cyL3pCYk9y?=
 =?utf-8?B?TkhyOVZ6WEpkZzhjZXJEcTVKT2Yvc0FwNXpZbnN2TmdhZURkOEU1d2dyODhn?=
 =?utf-8?B?bk5rMUNQOFR5MHk1RTlkbGVsL09FNklQSElpZmZ5bkw0UjIwUlJHTmtGbjJk?=
 =?utf-8?B?dGlOY29aR3FPV0VxRWo2Ryt6WktNOFFZQnBNK05QTGo3OGFJbnN1TS9YVmZ0?=
 =?utf-8?B?azlrWTZFb1BGS2dDRmZrWVhQWkVIRjRJcGErOXJ3dFJFekU0bUl5VG81SzhV?=
 =?utf-8?B?MEQzQWF6MjduU0lleFF4SEJwOUk1dUx0SUJUTzkzb0VXMG1lV1hHUndqZm1D?=
 =?utf-8?B?clBiZ29ub0w5c3grOHNxcFBIU3VNeFRWV2JwMFhkNWFWNTB2bjNiRnFBc3NO?=
 =?utf-8?B?ZXh4bDJ0ZVg2YTJNc1dEcDRMSGh1Vi9McDZXbkFIa0dKUk1BZ0ZMblFSanRl?=
 =?utf-8?B?V0tSNVV2YkFNaEJoL2lyT1I0Yzh6OHdrQytsdVA5eklKWFcyRlVSZlprVHh1?=
 =?utf-8?B?WGZlaXREWSsxNEdDbXk3dWxsNFRnQk9TSFozeFBSUnRIRTQzeGptWUM4QW4r?=
 =?utf-8?B?bFQ3QW1TMWtHVEphSk9mRldWZ1lRdFUwRURaWWNSVVhMQkVlM2k5WjRtV3I3?=
 =?utf-8?B?RlB2dkNTN1I5Mzh1THRsajVZNVVkQnh4Vkc1L3V2V2wwZW04QmlUdE1HRE05?=
 =?utf-8?B?clFSV2RVQmloUGlzSUR6TnlzY0ZSNjJ6K0lhSDNpaTlJMy9GeU83b1J2SWZD?=
 =?utf-8?B?T2tGajlFamhScVJEeFFPODJZd0RQSm5ZdlJMVlBXbElpenNTeFRNOERwdlh3?=
 =?utf-8?B?VWJRVDBiVHdCQmNVc2R3RjdtZSttRitLQlUwU2Z3aUt3MVAzeTAzNk9DRTFz?=
 =?utf-8?B?RXl5blpTVzgyMU9McW1ObDV4ZHVzTUFIU2dRNXFzd1JGU2FKUTBGK01EUWNx?=
 =?utf-8?B?RzN1RnhuQnIyeWZEZll4eThNWFlZUitKNnQxZzd5SFlUQUVCaHNBcmp3QnJG?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lOpmi/Fc9aQ+liKs3ikjNKHBTW20UrivkeilBQ5ywPajfdu2YwHY01NeGgo9jMw8lgghyWKN2FZz2Dh8gJRxkBvZcQyjDXrz4uPaFjP8voMvlCVg5h1/aOt0Jtu/RJAH9PGQ9dsXED99Qz+P6cFxA2kwlDKYIhsJ/Kl2Jk2jA8aTFlulgtfM+CJ/DPn3gaqty1nQN96Ty/gCAOUXHi/v530tAsgZa1oNPjYWugz1ZvD8UGBpinCZ86Xc9EDkz60jz5MaY+cnA3AYQkTu4SdhwuLfBd+0oX/OcBxLZvComrVi69V3bnZ1ifUKIHrxmyx1SlSdD+cspPqpd+9ixWsv2PeT3GI3Utr9nX83so1g6zZio2lF3xu1Fw7H0wkJg9mu/azxeC+zXNn1+RXonpBKJrbwhzzsjGMniiLXK6yQGj7faZdf2vOA+FPBSH1Pvd/pDfS/o4mYEQW21tFhzkym/G9nqa1SpXlQXo5KPXtXBg5PJDFtxw8Q08zrwCayvL7wemVhK2sTlaOZaxwxIfi0ZK1sRNEUJ667kDGR32WpWqmZ2nce+FBsxWxd+RCF49kki8dyk5aI35QyUteFBDwwZPRG7WNQZrdaOtKBL3ZWx7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401318dc-bd64-424b-776a-08ddfd0469cc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:55:55.5360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuIZmddO00oepQRCRzy6o1YPZzMuN+Ioa1i7pXc869Xdkmp+7zthzVY4KsQdAHnSDShfdnuM425gH28rcX97Gs4jp+5/rYNO7DPGh8SGFCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2509260128
X-Proofpoint-GUID: qkaDLPF_ahOGCQjDd4wXyE398Sb_saaL
X-Authority-Analysis: v=2.4 cv=U8WfzOru c=1 sm=1 tr=0 ts=68d69b73 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=MAqJ_AU0zrxCo2GMXtwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qkaDLPF_ahOGCQjDd4wXyE398Sb_saaL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEyOCBTYWx0ZWRfXzte4RK691C6D
 2Y8b8/GcYfDMU3KvmAfsxpWltEGCSYicPMdB/4xvTuqBJqse/1G/6bXD7Z68kLbL1EuLQbKw/M6
 CWBn/6XmJV4g0EUciaeS719b9qpCeGOcigm2orUEfZY87yHmXtsiRY4cpv91JXSNouC+2WFr4Lq
 5GM45Qd6TtxIYkLCkC9QehmdgAXfMDPOUNLxRIKxQnnLcb/kQ9KqRWjEIaZebHB6LOZPc+SzSX8
 gb7y/4Vh/foXpWxbMbwkQc1YucGnGhn9Ae5OPzYTyPY/LmLGgld0v7yVQVgUTNQbPjMGnA+RRby
 nPsYQzYJyuZo1tcdHMsCkIxSzZO/KVi972kwsZ3zTKvHa5wJYM6a1nENYwcR73ClfEaYdMYJVbr
 KaqqqA3T219zFgcs03DRwIAhwwZOzw==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/25/2025 10:23 PM, Zhenzhong Duan wrote:
> On source side, if there are more than one VFIO devices and they
> attach to same container, only the first device saves cpr.ioas_id,
                                              nit: sets cpr.ioas_id

> the others are bypassed. We should same it for each device, or
                                 nit: set it> else only first device works.
> 
> Fixes: 4296ee07455e ("vfio/iommufd: reconstruct device")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

Thanks for fixing this!

- Steve

> ---
>   hw/vfio/iommufd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8c27222f75..103ff43426 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -607,7 +607,6 @@ skip_ioas_alloc:
>       container->be = vbasedev->iommufd;
>       container->ioas_id = ioas_id;
>       QLIST_INIT(&container->hwpt_list);
> -    vbasedev->cpr.ioas_id = ioas_id;
>   
>       bcontainer = &container->bcontainer;
>       vfio_address_space_insert(space, bcontainer);
> @@ -641,6 +640,8 @@ skip_ioas_alloc:
>       bcontainer->initialized = true;
>   
>   found_container:
> +    vbasedev->cpr.ioas_id = container->ioas_id;
> +
>       ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
>       if (ret) {
>           error_setg_errno(errp, errno, "error getting device info");


