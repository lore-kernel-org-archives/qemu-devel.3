Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134ECC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 14:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkPqe-0003JA-B6; Wed, 13 Mar 2024 10:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rkPqP-0003Fc-C1; Wed, 13 Mar 2024 10:44:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rkPqL-0008DN-2A; Wed, 13 Mar 2024 10:44:35 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42D8hqwr000648; Wed, 13 Mar 2024 14:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0ewyPOQQiJPO8n1A/JH7Y7jX9r418Wfasxhti5GpXK0=;
 b=IK80SGncNScNTzBKGGA4DYcuper7folcRQivbNL825zWf07QUw/uUzfj1Uwqja6+dRz9
 fDupRV+DqWyjOIc7W6QixrIfLol5XwDzJKBEXDDLoW3sLL3j9tEWTSWYJEd5SEt3Lfwf
 OMBu/SBwUvxJzSysbnyaSTJ+25HvspCuL2Z0e2yqG9m2pxXZhyXe6NC63rLc+vzqG3EZ
 /FZPBS4GwKNerl8n8VKwmZ7MINRjf9z5aG5x1B81yPFv9/wlU1Nff6XcX8S7IWwQTFvw
 xWo3QSpxlsmwRjSS4vWEFak0wNiSi1BVyJwuQ9dgHL5sKRCwAEWrZrnc0xBFqEeOVVOT lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdh91y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 14:44:12 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42DDWpMt033735; Wed, 13 Mar 2024 14:44:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre78nkn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 14:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgA4fgeE9Te3mybxRInQrSb13so5qOfhvUMoapG8GoohtkEk5On8qX4/TBIe3CK3XtjurrDNqX7EexUG2Zt7eOeyU5/JaWBO00ONAkhqAun7IhsVLqw1seTPqrGdVTXIqzzwLBgUZSjev8ws2NUNWhDY0J17PFsuT15vcHczpKCWaS6hhDn837Q2xOcHvZnex90mW0qQfOdOP9yt18Z8nTEmxJqHDDf4sjM1OO6QWWjJEvDIoAWbzcjHrn3b/PCk/c74QX1mFK0czgAZzoEwLFX5j2PT59rPT5tpdUEh6SFxDxH9Z4yraEuqZ6gEVtXSopJ3xkT0Qzk1FJ6Cy9mY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ewyPOQQiJPO8n1A/JH7Y7jX9r418Wfasxhti5GpXK0=;
 b=EQlb+O2OFfh9YVyjaEmZIMFrBMzMWnLKP+6kMhTzSmudulRPB06XV1dDUQ/p6F62cLAusp4JkJsKb9zbQ74gT1AdelR88+95L4CgqpZd+QM53XGCYKXeIJg130s0VGZ2Nq6qq5vvq2MJUsyWz5AOuZiqy6fZUdbrGCwC2r3d9+kNH3rz9pA3xZ7fKWeeJ37ev4yXAaw+rO9K75Gp1rzZPVusDHzEF+bUjuH1skQg1o9OEQ5TyaPECnzpp87pk1vBMvN46gydGEWu+FBHmcStzbmdtDvqJ8Mcp3p6UvAuXfPtdiuEIW9O61EBrA4Fu6zrbjuFk1UpcZEizWskqVzOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ewyPOQQiJPO8n1A/JH7Y7jX9r418Wfasxhti5GpXK0=;
 b=jW6noUF69ZVSyG2dyAUTsOwMLzPYlNoWBWhuIczdZxHYJdMDBJD+pMgkrqqnWFYTgv+FNtRs8gThDPann7x6nJWxoNzyUrZqVk6t9rjpc/1W90LeSnir9NQ+xlfEZIa/DP3s1t7zkLtDiLSQ/hk+821pf67wt51C5xsMi9XjTSk=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by CH3PR10MB7185.namprd10.prod.outlook.com (2603:10b6:610:129::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 14:44:08 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::75a:a398:452a:90a9]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::75a:a398:452a:90a9%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 14:44:08 +0000
Message-ID: <0de86d21-4d71-4a72-ac43-d28b3bebc68f@oracle.com>
Date: Wed, 13 Mar 2024 10:44:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] virtio: Prevent creation of device using
 notification-data with ioeventfd
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, cohuck@redhat.com, pbonzini@redhat.com,
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, leiyang@redhat.com, schalla@marvell.com,
 vattunuru@marvell.com, jerinj@marvell.com, dtatulea@nvidia.com,
 virtio-fs@lists.linux.dev
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
 <20240313115412.3334962-3-jonah.palmer@oracle.com>
 <CAJaqyWfbsFO6W1aszyGJEFCdJRhHUvBmyH=NHdLGJWmVQH4G0Q@mail.gmail.com>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfbsFO6W1aszyGJEFCdJRhHUvBmyH=NHdLGJWmVQH4G0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|CH3PR10MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e5a4b5-775a-4470-14ab-08dc436c09c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20bk3n+7sUWGBqAv9Xc4S57uxy/+8/w/pyqd9NntBsv43qsJW1Qx4F4G1zWV/L/CoOAR2xDR5SOcK8v1fhEhTrH0E0uiIuZpb6z9u7JjrRR9SilfJN8up8nRvcWqv7qQsMH6UErOLEJ9oDgUg6bIXkt1qujudAbDONntIylmbSTs00nI1u6NtXMWn13WKFcPZxLAX1dqMh9NxfiEHiOhqQB0ZcrzlDwWk4KD2gFvqG3XByMXFT5uCME4xd+oD56WOSNca4mXrxRYGXNJ5fz/TSJf6Ojd+lmPru0u3t2ktmUjouPiB59Rvx0L2OUtj2f8E7Qlceoo5SykgRahRq6kTO+O367aZ4H0rxZFrWt0yENYKldNJRpjIIdW+oqFF/V3UVbsKfUnxRP19DhvmcOlhoxOaNkYDX/UU4WCHX0NYlyjNLxhGwGUkqL9XOZsumQVcLrF3fSlil8U0mmED+eAIVnnw/D151F+JvT6xpGkcErS2gDP9PlNCdFtw0XeTly1GNKsMfYDfxpP9vX5y2xDzAPmedheTZnbK8e0zKH++lMiEuA+Me0UVOEVC1SALVBw12QG2uNhnnjbkf9diGbx0aR9U037pM2ad5hRXYozyqgpBrnRK6KszHG4sHlRt99bbdcSKAu9AsDvDOFY1JE/4UyXvueKls8gWfoUUu5w+fU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGh0R0NQNWRUZThvWUZSSWVTcE5xMnFnMSt0UHVUSURncTQwNFk3c1RSblVO?=
 =?utf-8?B?TE83U2ZHaE0zeHNRRVVGMWs3a01na1pRdXFtVjJMWmlScmUrS2s3YmtNT3NT?=
 =?utf-8?B?MFQzRnZ1K0FvZ2IveXFOSmNGY1FheU9jdkZuaHdaYmtudW85a0RzSW9YSURH?=
 =?utf-8?B?bWo2dVUraXI4eVlhLzR6dis3aWpXd0JWbStJZGZBNzNyY2ZZaitkbzl0SWtr?=
 =?utf-8?B?SHU3OHRPZ0Y2ZXQzQ0llVlJ4VUhNOUhKZkludWRzSzFCL0VoczJZS0hKWkE3?=
 =?utf-8?B?VTR2VGhtbXdsdllQenkvbHRTdlNXa0xBWVdKZmlWVU5RZVZEZGErODBLQnRC?=
 =?utf-8?B?bmpDbWNDWnZNOU9BV05vbDM2RXhSYjQrbGFjWEtwREdYczl2dVkzRFl6aExX?=
 =?utf-8?B?N1czSW5hYld5YVVwQ1dXa2lYVmRtdDdwUUFUSkpXSUxBL01CODBzaGo5Z3ox?=
 =?utf-8?B?NWh3UWFtSm44WTBiQkVDUFlhRVFYNGdSUjNVN2ppVzdEQmp0OHR0YU9vMW1U?=
 =?utf-8?B?aENFOWJvVDNUZTdUMWp0cEM3dEFWaitCRGlKQmszVlZhdW0vVE92VEZ2bVpG?=
 =?utf-8?B?by83VW9KQXF0RVZONkxkTytEc01zU2V0SXl2STg1MzZPZ0tzK3RZL2pQYjJo?=
 =?utf-8?B?S1FqUXRQUThTYWFDM0V4T053NGs5YXNDNjRuWW1SdHp3cnNBeGlYdGFEQmVk?=
 =?utf-8?B?QWRQZklsVit2N0hZcmV3dW9UMzVsajl5WnhMeHRmNVRQWHd3OG5xK3VCRDZZ?=
 =?utf-8?B?Mm5WRUJGbnVaU2NHRTBIeDMrc3JsRUdFeithTm1HblIzampiMk5qanMxcDZk?=
 =?utf-8?B?UzcvZTVIb2c2QXdSZ2pBU1FHMHBpc2N0OHF3Uk9sMHhqVmY2UUMwTFI0V2Nv?=
 =?utf-8?B?RkpheHI5a0JWdkFNZDVQWkFTbEp1WEpRemtCRndSRWg5SEVyU01MOGhDOTgz?=
 =?utf-8?B?WjJHVUZETVhkK3dOWnFXTy9tc2hLZFMvQURFaFJoK0dRSzd1NzFBek5hZVIw?=
 =?utf-8?B?Vmh1eVgrTEFIRFU2UnRiZTI1VHRpcDhYM3JVdXRtaTRXejhsbGNxQ0MwWE9H?=
 =?utf-8?B?ajJHVDZDR2pwM3pHYnB5bkhYVHVwenYrU1h5VXlGNXpmdi9KUnlJbnc4M016?=
 =?utf-8?B?MjNESG9OTzhtZ2hUR3BuRUdER1gxa2VIMTJQbmo0ME1wUzFnZmNzd2VrTW9p?=
 =?utf-8?B?UmlrQng5SFdjWHdFK2ZGbURiNG5FZk5XNC9xdC9HdzMySjltbjAzbU9UOFJr?=
 =?utf-8?B?VFp5eEllRzRpSXhtZzhDSThoaFBzZDU2N1Z0cVA2RlRSMWRkb0N0a2d4dk9W?=
 =?utf-8?B?RVNFNzU3SmdZWDZlVXBQMk42Sk1YU3MvYnJPdmRiNThiZmVoa3d0Tm1XM0M2?=
 =?utf-8?B?MU1ySXB1bDB5ckRUSHRpR3hraDJJRGNySlp4aUJTVU1kWW9Pd2tiMkUzVDBp?=
 =?utf-8?B?OC93UkZadkFCd3lXamtjZUdYSW1yUlRRZXpRN1QzWUdWZitHSVlMMHA3SG83?=
 =?utf-8?B?R0tZaDhJTG5SNkNhQmtGV3htT2kvais5dnIrLzBrUDd0bHNEZWYrbTh3UExO?=
 =?utf-8?B?KzFnQkhHUUhaRTdoVnptdGIydVRFNGczUHI1dE51UkdUTVlvRlZid1pVbHVV?=
 =?utf-8?B?eHN0b0hwMysyUG9uMXlGemQ5RitQTU8wTmY3TFVrTUlxMTk1WXVuUDk5RDRm?=
 =?utf-8?B?b3VDK3RGSXh6RzBiU1BoSWxuSFFEVnA2Y1N4Ujlvd0lLU3BGTmt4N3phdXh2?=
 =?utf-8?B?aDZaa2NFNEtWREQ5QUx4NHZ5aUNVWDdzRmE4Tm1QYUd6ZUVnanVRVStrMjZD?=
 =?utf-8?B?U3FYVU1Ba2x0eTU4MEkxR2JXVGFlQ1VFZTIvb0tMREtzY3ZiWVZFcXJ1bmhR?=
 =?utf-8?B?eVU0L05ScTdtU2cvZXJoZHBQbTZuMy9SbWRIdkRxejByeVB5RXYzcnR5NWw3?=
 =?utf-8?B?RHcvMjBraG9EK3JFOVpqMXB6L3d5K1Vuc2lFSTZoSFlaTlZERGc4MDVWZmpC?=
 =?utf-8?B?Nlc5djh3aW5CYTVudmZKWFdaTVBlUGVCOVd3MVRvcGpmOVlyNVNlNnZSallr?=
 =?utf-8?B?MDlrdmQzVTZXU05CSmtncjlDNEtraU9pNzk0ZnFMbVhtYzN3TFI3N0p4L1Jt?=
 =?utf-8?B?d0txL2c3QjVBQVU3MXpSRHBjdkE5RkZYQWZJU2RLWDJWdThBR01kNzNTOGFk?=
 =?utf-8?Q?dhFU1iaNO37KVZyx5buwiXM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /L9NQadRQWgt2XBmftQXQIbWD3Xt5XcoomCr4EIUED4Kx7eyvs9U/aKbBPE03A9HOb3MncCtq/2dkRRncRn0R1VAjQ8wPBTVRfz87S889SXxdhBP455qEPXRYMC+nKZOQijRpr0NWj6U+BJaGChWQXDsAsfX7rYdGVj7pN2OrzcfnQPLnt0Ufi+T8k1a7nEqiA/00xGzksA+C3qpa0MTi3TTcYNq/pBYc2sIH4pwzksxRhow1ZSiHwWlNaMoM4N4JdRjL6oNQl2SXNbwsdWEvK/0IhmZKiwKhNR0L+REeyGULLUs0okWB3jFhFA0V10zwGQNmUM/nvBfYPQFCZ9Oq8Qf+jegmtf7skZJ5xAZq1mTGQKWsxMeglvXUhV+78uIcj8LTj7hclVyzmwP8tYCM0L23EZiULuwuP85/WuapK0TVy6061YpldlTzY4hQj3/vAOOjKvPMfq/gCDvn7n6zFJzpln/YHAUu8enypvdypBeiQ84sXe2fEMrN/PsjevKwG0CFDHj6/5oFjPz26inFjoLt1gQoY43cuuvWi3FH955LNlQvEQC+fko7ucXw860GeSkyWYKtsxA80Ol1/baAFJeVIUvSu90M7b1qzMv7rw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e5a4b5-775a-4470-14ab-08dc436c09c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 14:44:08.1115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCvCM5HlavXEZ6BHG0jvbPLW3xjT3VWwUNTM/dY9/K95R0WB7YkMAh+MzWcY2WA4cq/LnQrekxPu1aNdmPTBqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130110
X-Proofpoint-ORIG-GUID: NsBDQ-qolhNBfeZIFU4VKUf5IuDej8Ym
X-Proofpoint-GUID: NsBDQ-qolhNBfeZIFU4VKUf5IuDej8Ym
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 3/13/24 10:35 AM, Eugenio Perez Martin wrote:
> On Wed, Mar 13, 2024 at 12:55 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Prevent the realization of a virtio device that attempts to use the
>> VIRTIO_F_NOTIFICATION_DATA transport feature without disabling
>> ioeventfd.
>>
>> Due to ioeventfd not being able to carry the extra data associated with
>> this feature, having both enabled is a functional mismatch and therefore
>> Qemu should not continue the device's realization process.
>>
>> Although the device does not yet know if the feature will be
>> successfully negotiated, many devices using this feature wont actually
>> work without this extra data and would fail FEATURES_OK anyway.
>>
>> If ioeventfd is able to work with the extra notification data in the
>> future, this compatibility check can be removed.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/virtio.c         | 22 ++++++++++++++++++++++
>>   include/hw/virtio/virtio.h |  2 ++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index bcb9e09df0..d0a433b465 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2971,6 +2971,20 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>>       return ret;
>>   }
>>
>> +void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>> +                                                    Error **errp)
>> +{
>> +    VirtioBusState *bus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
>> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
>> +    DeviceState *proxy = DEVICE(BUS(bus)->parent);
>> +
>> +    if (virtio_host_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) &&
>> +        k->ioeventfd_enabled(proxy)) {
>> +        error_setg(errp,
>> +                   "notification_data=on without ioeventfd=off is not supported");
>> +    }
>> +}
>> +
>>   size_t virtio_get_config_size(const VirtIOConfigSizeParams *params,
>>                                 uint64_t host_features)
>>   {
>> @@ -3731,6 +3745,14 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>>           }
>>       }
>>
>> +    /* Devices should not use both ioeventfd and notification data feature */
>> +    virtio_device_check_notification_compatibility(vdev, &err);
>> +    if (err != NULL) {
>> +        error_propagate(errp, err);
>> +        vdc->unrealize(dev);
>> +        return;
>> +    }
>> +
>>       virtio_bus_device_plugged(vdev, &err);
>>       if (err != NULL) {
>>           error_propagate(errp, err);
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 53915947a7..e0325d84d0 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -346,6 +346,8 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
>>   void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
>>   void virtio_update_irq(VirtIODevice *vdev);
>>   int virtio_set_features(VirtIODevice *vdev, uint64_t val);
>> +void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>> +                                                    Error **errp);
> 
> Why not make it static?
> 

Great question with no good answer! Will fix this.

>>
>>   /* Base devices.  */
>>   typedef struct VirtIOBlkConf VirtIOBlkConf;
>> --
>> 2.39.3
>>
> 

