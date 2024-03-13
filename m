Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADF1C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkU2j-0002Fw-GT; Wed, 13 Mar 2024 15:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rkU2i-0002FY-GB
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:13:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rkU2h-0007pn-0R
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:13:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42DHxU4C000410; Wed, 13 Mar 2024 19:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6PQLOomcb/+lYtpfcpRG7GJemX+kVbVNnQBhzTLWoQ8=;
 b=EZ6RbWTv5oJ0ueuI9WXDg9QyQv4pppmlT1ySYoohHnknDXEB7QP2Ns7Up0Aw+ZvsLrfD
 5UnyKalAaW5GK992GwXf/2jq3jan1dWkcsLNLWra0fncnM9Fj9sHqXdG4/VxszIwyprs
 fzAfBFJ87CPMwVMcTM6PTIoGFbaG3Z68A1VygswzwWDZ0Ix5awWL+Ru7iO6l1aEDQRQw
 u+ezPgbCrL1e/c6YLMENw1utpgo6orI0IOL6zwku7nHCzg1dC55vYHHsdByx1rdx0REe
 3EVvoipz6XiGGUoaVVhhqXDAyTVPi/U3PSu6++AaD+A7WqWTjX3wRexWll9bAaqEp+Bl mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgauskqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 19:13:31 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42DHgi2A009104; Wed, 13 Mar 2024 19:13:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7fhc7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 19:13:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVmlL5aVBSb0Rf3ZIpkjGRybhXPFQv7EKV56wz5PIlGVMdmhW0dsmpyKEVGvGDxkXSxMAbKCgZj71+Wk511Wa1wGOw96jgwiOkf8pcoy+g/nNRI/RFIfecYiHwYD6i5oY5M4oxt3Y9hxeqSL4q5i1Cl2UCyEH/tYc0MBK4NORQJLZC3JSuIrylTldbWLzFsQdc9QsFP3ueGIxL2i3Wp1nbkyMz8X6oBNcsJGMbHQVBxP5EpEqss/HBRai7F579pV5CTP4cbO2hSS/DrLAdvk39JqaSptcwH6knq+a1TPeefdJqTLAWcYSz7WI7KDHo5Y0xzSAS7CMZYUrWBGXYLJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PQLOomcb/+lYtpfcpRG7GJemX+kVbVNnQBhzTLWoQ8=;
 b=AVRdO+Ukg9d2sUqJl9sI31kFFSbuEvHAGvDaprUiO8s+VUUlcxr1IqB9iyeYkC5/GRockgFiXE1dP+bme+Gsnatng3810wTC9DSZ4yfDQkLPxSS4R0WSVKkY1aCY3tSZ2sHXdaifoHUHEgTeXqbvcvkiw4lVLmypKpvU+xrXF3iLJcWENQXHOIpLrGmKFDBlHipnEmxnIvwhfayuyIqrkFfz2T0hM4atFH2L5++Gs7zaRvZ3rcz41WDMfZ33gQENXJYQO3KW8NuKdKRg4ou8acqypclbBeAnTW7wF60fckBcnHt49Zqui7WiM4L9jMfJWkkmM2V5YaABR4bF25mOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PQLOomcb/+lYtpfcpRG7GJemX+kVbVNnQBhzTLWoQ8=;
 b=MMxyjDid3y/wvLBQ+ewnN7O2rjagX8FTqFVya+aiOBFWjCaZG6uVlk17qcTUFtBRXM6XfODJ2z4ZsnPNuCboDODro1He49e+/v3E4wY4DwdrNVuTn4toT9bfgpFxz3XZe7DZwx5AnREulnDOuuCvkihaLwXxJmfummFWydaFKhs=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY8PR10MB6908.namprd10.prod.outlook.com (2603:10b6:930:87::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 19:13:18 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 19:13:18 +0000
Message-ID: <c6a8776f-3c37-4180-8cf8-c624110f892f@oracle.com>
Date: Wed, 13 Mar 2024 12:13:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vhost: dirty log should be per backend type
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, joao.m.martins@oracle.com, qemu-devel@nongnu.org
References: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
 <2c8867fc-fce8-4964-b641-09f7903ff594@oracle.com>
 <20240312110704-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240312110704-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:c0::24) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY8PR10MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f07369d-385b-40f8-1c31-08dc4391a392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/S+hpeS93DX1a47QFXeMqZ7JGP0jzYeSqD0277smbAFpI42OJTgs+b++eQwPz42Hm94HJN8M8GnI34AvJ8eY3IB6JCn7p8rkLsmBnhAoU9odKxB1kDN34F77OOa8OWE55D0a3OyJ3ggw+ZQYdPIma6yNYp1Ei7F6ctVk2cyMtcNBB3/+WpDEvxVnSMedoTUTnmWNQ4lZoLm4/Pn+m0wNkfQSVCBiPbIVAEW3PS+719tb3dcg31e95+4U7BnjLUz3fttJFnAjaZDW79KUJ0BK2V7T8bLo+NV3xrg+NEzQ9iSatGQ9IJzKEuIbCEVYh+XONwshALNbSS8UYUoI371NxEVoygZMY7LDKN7DqXenLZOyf/bvdyVheknjdBd6uia/d+ORInWN+TkN2B2BHyOO/J6KDgu3gp76TU5emXBep4kgy0+VnFM1urbZ1NRP3Y3J08dpH5K+Cj/hz6vyaWspT4S2Q8YGyCzbHP6ifKV/b8FHIYHmzXYqaPWVG4rVU/dgDSRdfL2NJuF8Zg3DYaE/9UGYProsJBDnTJpDa5DTAmQbhF+Z1UuSypPTi9K1uZb1kmRuvQo6+9p/YSEK0WY8yfEjEbsSTkPtiRW9zwGVKbvteKqFB0dMievhPFqlBQLaYlpwSuuCy+mU5z0F8JSN6nDghfuknD67RHcXTa81es=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRpc2NGbVRRMFlGM0NyTFduTGJZcUErdFhPc0hMNEp3clUyQVRucWZZOU4v?=
 =?utf-8?B?bmx6MlJFWWx5aklmeDhnOGdnMFhKTlQ2LzcrVFdKZVFkWmE0SFkyS0lqRHlT?=
 =?utf-8?B?MkhmQkhqN1pRQy92RmswMXVIQXJzYm1OckxYc0d4dkFCczcrQi9jZjh5TG5l?=
 =?utf-8?B?cHJKZ3RTZ2IralBxQjZGdEsyV3U2UkhUcnlVd0QyU3FJanFmYkVmdTVqcnhX?=
 =?utf-8?B?TjU5ZlJPT0x4NGdSbFJPMFVUTGpxeGRteFVXZ3Y3QlViOGpPdUJRanBlL2xj?=
 =?utf-8?B?YlpQQmp6dWQvMkR5VFk2eDhBWkJXRHpXdjg3b3ltM2Vab09OMzN4ajNxWG5m?=
 =?utf-8?B?SDJ1SXJzYmQ1RENIbjRZaUtsYWRubUpSbDB5Z1pqZGRpanhjRzVHcXcxQmt1?=
 =?utf-8?B?SUhWTStEMyt0eFpSanpFb0VtSzlzcktveW0yRVU5d0FhN2FOL0FmWGZhZ3dy?=
 =?utf-8?B?SnBCQ3ZaNWg2dUViVm9VNHBtUS9ncmhqejZOUTI4cEVBZHg5WDFFNGRCNGl2?=
 =?utf-8?B?QlBORXlPbTlteHlhT3B5ekxlZmpZVDhxTWE0YzFyTnROQ3VhV0x6MlI4T0dw?=
 =?utf-8?B?cDJKNDhzMWJiMGI3dldZZG81R05hdmdXNnFwU1NCTFlGejZvdkU3T1RTN0lP?=
 =?utf-8?B?RFhQYmVseHF6QjVHdG4zZkFWQ2ZYZkhqQVZpekFnQmNZY2lza3prQmxaMkFn?=
 =?utf-8?B?ZjZyd0lKNFAwVEYyRXIwRjI5WVRJSUxpeDdxdkVkdkt2bU9BcVBOM3h5Y3Y1?=
 =?utf-8?B?UGNjZEdLYWVjelZKNmROcDZ1TzQrQnI2Q0cwOXd5REI4L3ZKK1poWlZSTVpx?=
 =?utf-8?B?dExxWEJKMnpQRkFGaEs4NlRqR0YzNkhlVHQ4VStNcitoZ3hXUTBDMkVoc2p1?=
 =?utf-8?B?bmFHYU5CWEZJMC9lUWtmbVFrSm1rNDJMOElHWHBFbTFXNHBCSEhreFB6WFpZ?=
 =?utf-8?B?cU0rRy9WTTMyejZHTjBVMWlqZ0lSM3QzNW9tSytaZVN2NFFMUmdqN2tTQU9M?=
 =?utf-8?B?Qzd2ZnZVZDQ4azAxME9zdFJXeEx2cUE1L2hBc1JlNzRMK0xmTUMrVVlYeEhn?=
 =?utf-8?B?QXBkZ2xCZEl0UGxWcUhIMUNIM2czalBJZEJwa0t4RU80QW1NckVmbWZtSlUw?=
 =?utf-8?B?UG9yZysxV2YrVm9teC9SaHJ1THBXQTZMTmFURXBvODBUU3BDaWNTc3ZTKyty?=
 =?utf-8?B?Rm9LSjh2MHplbUcyZGJ1T2I0ajZYeG1FZXdnVGQvNEdrZ1p1M1FaSkNla2tK?=
 =?utf-8?B?TWRSb2VyMSt2UVNPdkVFZFBsdENsdmhnNkkwZUd1c3NBZEd4bE5GOUk4VE82?=
 =?utf-8?B?SlpoMFp5bXZSZXJVOGVwMXAwYUhpLzdHL3BJalNTMlZFa2FoVUFlMDBRVjFL?=
 =?utf-8?B?RWJ3QWk2dEVHTTRaNnVJR25TU3c4a0FtK3BkeGFIaG1CQVFkQXVwMjZGNkZI?=
 =?utf-8?B?N0twZ1BZU1RXMEFOR3gvNUl3dHpoTU8zaWtObWNSS3ltVXlUdnNNcFlTUWxK?=
 =?utf-8?B?NFFCRUFGemFMQmRVaG53ZXVKYkRHdXFtbXdqQ3Q5NGZIekc4OGZHdzFZSFNz?=
 =?utf-8?B?RTRyZGFUMHZ1U1JBaDBjNWt4eVR1aUFvMWJkSkNzTGxjajZyaFFnOTV5SGZP?=
 =?utf-8?B?ZWVLOU11ZTdiK01YZ3YxVWZ1a0dFeEF6Y0ZaRmQyR2Z3UXp6RHhNM2hTTnRn?=
 =?utf-8?B?b05IY1ZyT0h0MXgrZlNITWI5OVdRM3NKOXM5Q0JzN0tyNlFvVGFCOG51Tytp?=
 =?utf-8?B?aGRjNEdVc3FPU0RvcncybElRU1hXS0VvTFhVLzZGSm1nNW5FZUNheUNPQlQ3?=
 =?utf-8?B?NWJTNWhybVlJbnlSNmhnQnp0VkcvT3Nicmd3dTlYdSt6TTB3b096RHZkcHQ4?=
 =?utf-8?B?Y2RtM0xaOFI3VWo1b2puYkhPWldXWHRzSlZPd3JHSDlORE9wVyt1Ui84S1dS?=
 =?utf-8?B?UE5UcWtUWVNvTFpSa3ZlNi9iU3dIWWRrc0o0VXIvVmNkeGRMajU4bStKdlpr?=
 =?utf-8?B?MVQrQ0xsR1hDQ3hqaEo2NEUyQVplRFVNeEhabkt0MHE1RlpBeHhDTUlVWndt?=
 =?utf-8?B?U08rSTZJZ3RkTnhhL282S3hvdXhrYk13V0FPdTRGejVwQmJrdE54LzlMMGtU?=
 =?utf-8?Q?bhI6ojwOixZsqqnEsqYOxH+uZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c0a/O7+j6QnXjFHs1tjURFg9KrxuXV82/RdDdfvUBHnSGhwi4APnXn7/O7CBjVYy6JA0nXSfDnf3HhXSJvvEmve017OrZqpiHAydgGFTvQBT++FrZ9icQM3FwixWfAiYhSWKENvODD//SqbLETT7Q/6y46XVkW8uPmbB0Pe7MnJsKT1xXRWety6K7tI3HdU1araCOvP+xP+P749EwzGfYKG9tB+NTLLlfPqL7YFRQX4S2l4L0PVHsEpR40GeMIrPtqL22AfHH7ySnnSZgU0sf1EPi0AG+sZIXXvqbBFV/+fJEnABNNDzI7b9s3/dwf6x9sy88JXf4PlZWtqK+gv6r1coPXyEHR09qknpzlLeaD2j5jVm1wN1V6n8LJdTKbB2oJkMq6wGHxpkXbH5mMCeEcQ5JuHqA6s46Xjmrr0uoYjPTdBDtcSx1Tggizone8g6s/3XfaUbzn/jZ9weytOWacXlPmrQ6q0gQvRA8DEKk3L8juNCukuRMGeCKaIM7tpetwKdEd0Usl2izPymcXwaL2tQF+35ie8ucOzmbKhJ/zkLRwYocvlYSfhWkhTLprQ0oQP03G5fJzauiIs9Roz/zjhHdcMiivN8KLRQoj5X61g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f07369d-385b-40f8-1c31-08dc4391a392
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:13:18.2529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osrykyLycv4qTEyUUn3+9oya2M6+YQ65mAvEGtB1IJnGDpeyMiJX7JrCtT7Gi4N5elg5KMcGodk4by2qbF7gMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=932 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130148
X-Proofpoint-GUID: ojCN8spB1KqqUHO2Om3RacBGwHqayzKo
X-Proofpoint-ORIG-GUID: ojCN8spB1KqqUHO2Om3RacBGwHqayzKo
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 3/12/2024 8:07 AM, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 10:42:29AM -0800, Si-Wei Liu wrote:
>> Hi Michael,
>>
>> I'm taking off for 2+ weeks, but please feel free to provide comment and
>> feedback while I'm off. I'll be checking emails still, and am about to
>> address any opens as soon as I am back.
>>
>> Thanks,
>> -Siwei
> Eugenio sent some comments. I don't have more, just address these
> please. Thanks!

Thanks Michael, good to know you don't have more other than the one from 
Eugenio. I will post a v3 shortly to address his comments.

-Siwei

