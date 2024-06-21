Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25035C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfJg-0001GR-MD; Fri, 21 Jun 2024 10:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1sKfJf-00010x-4d
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:32:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1sKfJc-0006MQ-Fv
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:32:38 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEQlnY008676;
 Fri, 21 Jun 2024 14:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=6XsSaahUbRo2wLpWOEsF+JUBsCzJfM49RZPa8C9TNQg=; b=
 AKzN5GwA7ju65+H/nA9zzzeaw4zs5OV83rRFOvvLc9NrV4SEU/7I1AsR+6DJPjOB
 VqO4r2+mD/lT0UbGawKHITJvp4f21st6hdXc2LOIFq4s2vrQ+2viCoc2MuFv9ASe
 T2WSayGHVRhJun79pZm/0XI/GPSwqTYsZI25CSmWSNqDxZepKfMK4LdFtLc3FgUQ
 B0lFg/4MZOPnXPnm4qnjC3KiPMHKnqTT7tCQf01GJKO4fFE5/O084YpkaTL9hE6o
 xqyXD5dt09Nq7V7FQ1+2eiuRUx0r2w5dIHnPo3x5uuRorXVyRyjnlaBWQEtra9FJ
 9h5RYtEpRONFQ1buTF7vpw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkgswrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 14:32:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45LDeAsF019383; Fri, 21 Jun 2024 14:32:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yvrn3wjau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 14:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTGX8R8mz1qzFXGkeYaiXnWxyyec6POuDr0RU/DIVnObqAmx10Y5hdwEJWr3Lz3XC8B7d2DHz85D6rwJYRg+wok/G4uYkhARPMa4Qh3UJzPh+Xq02HFekBCeDOMLPXs7irIOiow2rkxfLl2uvfbUjy5YffaFrEjerSHSEWaaIqTRJSuliv355aF7wCMZtPI1mA026VYBoDViLqJ/b2jjfwztCOUQaP6RPHde4ohlejIwBhYrv7G3gK2CeJXG0ncT8G0zECxyokY8cC6Xf2D9lbmzNvCAnKS1B/nYoyYsXujL9ggesbTC9YCkuDdbW9G8SW6g/eFCogUG+eTqD3Moow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XsSaahUbRo2wLpWOEsF+JUBsCzJfM49RZPa8C9TNQg=;
 b=Gy0aVRGnVwno9sFJgw2Q1yf+Rqvvbr73FwuQcD0NGnpeAbK+nPa7rYnNi8bq814sybNZDkjyOgjhMrkOG9orcWLbQf8O8Sk43Zo5wHGBUOwbKG19yj74rVbslXcvfTK+pG2OqYCnE5NaVTaK864anbfL320UZDtR+SBTUNiO4Qm4ondAFmNOBf5pBwdITTaIx13x1hkUUWZNJWq2GURuGEq3Nza0xIHnD52BTbT3m/Wt/tUY/9vxreipbEOhRFMM8qKOQByYxiKf5vGKseCf29fcj0JGQHq9c58F33XkTNlf3DDNQbjcS59hqiPf6b2UUhaRqtGCCzR6Xzrkl6ddJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XsSaahUbRo2wLpWOEsF+JUBsCzJfM49RZPa8C9TNQg=;
 b=W4lXbwH/+zk4JWUM52RmOe9/ZOsi3t33NBV78oNBRPheerSi8/w4zU83KzIZoAfvr3cS45oFRBovBO2ub/O+PwZfcPuTPzYQ6lsBu43Uu4IzY5FoYSVQKNgoLaimqcCqWHLJSaui7XmJjcUdzsAinOqEjebbSApti8Hwyufa+QE=
Received: from IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13)
 by BN0PR10MB4903.namprd10.prod.outlook.com (2603:10b6:408:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 14:32:26 +0000
Received: from IA1PR10MB6172.namprd10.prod.outlook.com
 ([fe80::23d9:6a15:e343:b950]) by IA1PR10MB6172.namprd10.prod.outlook.com
 ([fe80::23d9:6a15:e343:b950%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:32:26 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com
Subject: [PATCH RFC 1/2] migration: abort when switchover limit exceeded
Date: Fri, 21 Jun 2024 07:32:20 -0700
Message-Id: <20240621143221.198784-2-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To IA1PR10MB6172.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6172:EE_|BN0PR10MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 447a1651-3977-4e5b-957d-08dc91fef90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gxLbORsM2VnIHzEPsSUIV70MBx/72xDsHJYn7ajCvw1tCtnIn2gKUBU+rytZ?=
 =?us-ascii?Q?Aj/A4iaMkt3bMpUIRtBV59CP+hGgB3Ev/ecWjbUTjI12OIRMGQKmmJqEA0nN?=
 =?us-ascii?Q?H3PYBulLWhawpg4FiyuXoeh3KL2Ny9tRylsFYBvKNkFUR34RRHP0zBNWPkIN?=
 =?us-ascii?Q?CrP615oaX+cGokvXJYYNiYA7CZTkrIUVj4cbXFlTDkGLhknVX0LDpGGPp9Wr?=
 =?us-ascii?Q?FNmytbNmhZLQ7uh+3Ljrjdm29N6dFH3BWtlWObf5R5lgY26UT5USyMzppoPM?=
 =?us-ascii?Q?iyXIsw6v8ryIUw1QoPmoMbxAsPvaI1b7sLfGjBrKRJHEQ/O6npCQsS6oLHdM?=
 =?us-ascii?Q?MaxM/iSkzxwl+LHXTASr6RTPsm/E7zSt0Vk5003zltKyUq1pyyhPTftwm6G0?=
 =?us-ascii?Q?H5p7lrcpNUQxsW42wfxj63Kh7z6SAZjhqTMVlfdZOQHpDbNZtk3Diepqr2WZ?=
 =?us-ascii?Q?w8WELs27dl8YYgpaBywQsiIJMKfHe/tkcBsFOnP0QUSGxlo4jXUlOi2x9ROE?=
 =?us-ascii?Q?N5c2rU07CM9jHV2WDSWRf9O8XwvdEM5kdWUfURtB+WR5hf/Qf7wU+PkhTYA7?=
 =?us-ascii?Q?CP5uDOpJJyTUwsXMGFwcWld/sBjPeUIkRcOvZgJyzWX+R6pAHWQMO+zQitqk?=
 =?us-ascii?Q?JeU6scFxEVa/VmdGduTQgz83JEnl5+hgAvYBN6CMiyQuicdvSKNFDJr6o/aZ?=
 =?us-ascii?Q?qTVr9Lw7qNF2xhTXJrQtEMD/nGa/DYauenpg9Q8LFHRspm3J3I7tpMlgKJep?=
 =?us-ascii?Q?gGlJ5jkWGMCrvkgufK9PTENDGl5iC/kUAdz2UqfPiaemlbNPFyndO1hvLaDb?=
 =?us-ascii?Q?crTWfeLqD0UuIJonLiQPnuYzP2GMjdwmECQZ9YFNUpQQ1VSK+V/1wBFNHrGq?=
 =?us-ascii?Q?+Z/Vx+IFa4NLfOnyV9vO8HmlSmCqeyT2ZNtD//8bcB4+b5ADPZ6pvhiBAGcG?=
 =?us-ascii?Q?o2YS6hgeqqV+9K8CSxvr4MiSRt5nMBZhPLqaHJYtHMnJNh9l2tN+hhZuBhWD?=
 =?us-ascii?Q?V5uTBSDKKnsmxDUTjmntqanR3MLb46cFTgknauU989R+UYa6iT4c/V7QQkrx?=
 =?us-ascii?Q?Z9uPOrTtW0YvfSI2bJZ+/TnzDqFVFSrlnTiHiT1vDyE5CwAZP58F+AqUAkQ1?=
 =?us-ascii?Q?0yJ9dQbsRF6v6+2/+qs5oT/EtKMja9qrFXY5zqogfmccuZ7hSB24L1GvrF7F?=
 =?us-ascii?Q?lCALj/7COLCb+fFsyYS8N61AF7AbU6yMyFvnOPn3LSOD5DXM5bV09elKKAKs?=
 =?us-ascii?Q?5JRz5G+dkZOLBKiOrbP67If2+splRxdgw8sc82sdoapMvC9x2Thi5ZFYy98b?=
 =?us-ascii?Q?8Sx/I/DW690Yqhpejf9PfBqE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB6172.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHCEHIlSGp4cykwoOuzZ8/tkaRAW/Ja35UPRLz61KMakH2D41C+tJAYc6BCd?=
 =?us-ascii?Q?3EPnXYHLJO9l50WmodNtX19X3ia1y6lrcDIkRQ2pPHSUp7T3Key93TwcffZ4?=
 =?us-ascii?Q?YbNWNp2g6AlWNKN8pC9d5e7eQC24UYoHGc9Q+dfYdIYXjxzxT2UoArvQkxoM?=
 =?us-ascii?Q?i5zgQvDoSiT1LiwplCmr/XcBO2KrdZ8aTEPbP6kZxbxYJOTLqeTJ3Y/oPVAj?=
 =?us-ascii?Q?oOHOgOGrgJW1Fwtu1z8wl6sPEkpZXMfhXPtYDpfyskkLUk3vzFw4UxKJ7CJi?=
 =?us-ascii?Q?9KIlchkNjeDOGNVXoDvRcjqYt/m8tBPHg2W+2lqxuui8t3MExMUmi5Iz2eRX?=
 =?us-ascii?Q?x16yFylO5XDr0yk+A+5BoVcRvDI3D5ZHnCZ+KN8kk+j0tjl8FhFA07hqN7ur?=
 =?us-ascii?Q?yWeOsD7+SQnX/BdBsa/fMlMG7qXg27SwXpNlV/5PXRfUqDtDtuCu7FwetUWv?=
 =?us-ascii?Q?0vP/xKnIAUZcFWeHGywRV50x4n0BlxdejsrBuew15sW8+KNyX1MG7VKK4Dkn?=
 =?us-ascii?Q?zQ/1G452HWtPRtq3lV/vNEM7mTpVl+dxHJPP4DRk+rqX9g2eujT1Jlvn4YaM?=
 =?us-ascii?Q?Lq+Jg6yJIyP1Tvo9wZ6nczx6ixYiuDyD/quMGSZWIDX2wItFWxGnefWEKDTk?=
 =?us-ascii?Q?44TP9UXQsEcc1HqT16P2Uc1wnFNpDsB4TmjAmfzCi3lqWxY5R2h/v91aj+1s?=
 =?us-ascii?Q?aBSY2wkoXW5SdiG8uQtFEABXY7Tp0x/U25eJLtlmgQDBnmHc1j9JpOj2pTci?=
 =?us-ascii?Q?f/DwOuoOb9xpQJKyjYmBhvkz9nMQ3B0l7JvTirF/YJwYVbXghBlfgqPZB3kv?=
 =?us-ascii?Q?hh6z1rROGpQlAH18d0G3N8vPHMkaLNrhdtVx7iQJZlFmwH/YHRnBmy8u/sqW?=
 =?us-ascii?Q?ihpI9p4oZ4IeKkMS72pv0GD6N7o+hvSFe9JqDC8HJQOsjcJp4uN5R/ZOAyRb?=
 =?us-ascii?Q?ng9Ei7T3C0e5SdIXIta7zESY2bGnwsVIt95nsd7dnjdUAPQdzrzx+zIbS+aQ?=
 =?us-ascii?Q?isS8Mjl4EDuuaTuZZwavbGilfEGQudqRcpvZJtXSWii33QsxVF+fnDz81bjV?=
 =?us-ascii?Q?3IrafAhACpVkRR9TJUDtqAftUG6+bbOGju+kiiY/vSKI3NfYjpUVvkTAC8rO?=
 =?us-ascii?Q?GS+jK9UQ3/UwjHPiCCbK/vPWnd4f90QWvPXskU62jSnv4SwRH0jkGKQRn80H?=
 =?us-ascii?Q?HlENAj24G1/LbGYPr+Ux2AG0FHp0d7J4/ChRlFlX9pBrTr2cOY+xHAvCobeG?=
 =?us-ascii?Q?cbimmW3ytOs82w6NdTD2GgL7M8aveFU2mqqVsipXE01BO9Fws7D+Pv5SDbfm?=
 =?us-ascii?Q?JyzC8Zpzi3qQAbuz5L6C62UBxClx/1NSgSzhW+E/9Krlx/4cHSYcLEDuX6Vi?=
 =?us-ascii?Q?eA/T97qwWG0yu+XyM93fTXKBEm201Qh/MYTbYmlVpBJ0SsW5gW67zdIHQWeL?=
 =?us-ascii?Q?azwQiphoCc/kB1ujzKngltBU+w2+mXvb1V5mK6a5Q9sDRDqFSUw/eh5/oC5l?=
 =?us-ascii?Q?74ZrG2+KrP5T17O6Fk7F2toBvE4v19Kpn3KOn/C7R8qwPQGHp22HGb4YlHxW?=
 =?us-ascii?Q?P5Y6eqDw7tbo2YLpZf7R3IiW1MWjTdo9XoZ0tUsabSEnZAhlN3oCrBIzGkUd?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +FFW4iGEvon23qHBX1grpo/CG2o6Wlj/rSw067DCUJTfy68JwKKR1SUsTdgSjb/YP3tEsbjO9UrPL21hDUDAfpY9jFyJDV+2UStiAd9xc8IPZyxvZA0amQsf1zlgI9319QNSiX1VQnGe/zAWOl7LhAShkyPWd3EAQE58JXTypoNjVxIzqg7x4tLoZBKW3eVk9yRehcAXo9L4vL/qU6HvnMgVnmFLe9bxDklFVuLTe3LwqHPmuP1HP0C5ZTI+Rri2KVLcGSGy+3jLPTKTC1yCldwst0BtSLK6I2cdsZTy5zCUfxFy7OQOeVDOsLuPuToE2Pf5i8XtlLtDkrKsjHudhFdeuR8OU5rYf2rOOOW6T04Z4dw2azw0ZwWzrrB1k2XnsFFXwey4rV7WszAWJguakqrtNqmwz3e6OoTXwEXtlLw7/5YXuVsQR9n6/xri8pLygkR6A8ekvLLvhVlBCZKBk5XZ+YHjkfSvEIrrsVPfdDwxIC10y0rwIXfpPL1khaTZXQPZJydTUWSMigA8zm/E0a6VOrN2Bca9dV7UHcc/tYFD+8tGZC4i+2UESln5eVV0qof0/dZs3iCV86YvGC6qZH918K+WbbycKUJYa2ecniU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447a1651-3977-4e5b-957d-08dc91fef90c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6172.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:32:26.7895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfV2PEkpa30kuuuR9dEZgQjgGMgjSiydk2sODBzTV/CqhzQYoFzagVfpmQzsHCBnnAPJdnoXvcynU26hEKIydZIVlocdT+msPX4ZQ0XESqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406210105
X-Proofpoint-GUID: 4uvg1UTCrloUQbz4lmh6wKbdM21t1xMN
X-Proofpoint-ORIG-GUID: 4uvg1UTCrloUQbz4lmh6wKbdM21t1xMN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URG_BIZ=0.573 autolearn=no autolearn_force=no
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

Introduce capability switchover_abort and migration parameter switchover_limit
to allow for live migration abort when the source downtime exceeded by
switchover_limit.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/core/machine.c                  |  1 +
 include/migration/client-options.h |  1 +
 migration/migration-hmp-cmds.c     | 10 ++++++
 migration/migration.c              | 39 +++++++++++++++++++++
 migration/migration.h              |  5 +++
 migration/options.c                | 56 ++++++++++++++++++++++++++++++
 migration/options.h                |  1 +
 migration/savevm.c                 | 13 +++++++
 qapi/migration.json                | 27 +++++++++++---
 9 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21f..9459c7adbb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
+    { "migration", "x-switchover-abort", "off" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/include/migration/client-options.h b/include/migration/client-options.h
index 59f4b55cf4..0e9d17f507 100644
--- a/include/migration/client-options.h
+++ b/include/migration/client-options.h
@@ -16,6 +16,7 @@ bool migrate_background_snapshot(void);
 bool migrate_dirty_limit(void);
 bool migrate_postcopy_ram(void);
 bool migrate_switchover_ack(void);
+bool migrate_switchover_abort(void);
 
 /* parameters */
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9f0e8029e0..4dc8d0ba87 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -312,6 +312,11 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
+        assert(params->has_switchover_limit);
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_SWITCHOVER_LIMIT),
+            params->switchover_limit);
+
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
@@ -624,6 +629,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_mode = true;
         visit_type_MigMode(v, param, &p->mode, &err);
         break;
+    case MIGRATION_PARAMETER_SWITCHOVER_LIMIT:
+        p->has_switchover_limit = true;
+        visit_type_size(v, param, &p->switchover_limit, &err);
+        break;
+
     default:
         assert(0);
     }
diff --git a/migration/migration.c b/migration/migration.c
index e1b269624c..5cc304d2db 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -113,6 +113,7 @@ static void migration_downtime_start(MigrationState *s)
 {
     trace_vmstate_downtime_checkpoint("src-downtime-start");
     s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    s->downtime_now = s->downtime_start;
 }
 
 static void migration_downtime_end(MigrationState *s)
@@ -204,6 +205,10 @@ static int migration_stop_vm(MigrationState *s, RunState state)
     trace_vmstate_downtime_checkpoint("src-vm-stopped");
     trace_migration_completion_vm_stop(ret);
 
+    if (migration_downtime_exceeded()) {
+        migration_set_downtime_exceeded_error(s, s->to_dst_file);
+        ret = -1;
+    }
     return ret;
 }
 
@@ -1652,6 +1657,7 @@ int migrate_init(MigrationState *s, Error **errp)
     s->mbps = 0.0;
     s->pages_per_second = 0.0;
     s->downtime = 0;
+    s->downtime_now = 0;
     s->expected_downtime = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
@@ -2758,6 +2764,39 @@ static void migration_completion_failed(MigrationState *s,
                       MIGRATION_STATUS_FAILED);
 }
 
+int64_t migration_get_current_downtime(MigrationState *s)
+{
+    s->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
+    return s->downtime_now - s->downtime_start;
+}
+
+bool migration_downtime_exceeded(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    if (!migrate_switchover_abort()) {
+        return 0;
+    }
+
+    return migration_get_current_downtime(s) >= s->parameters.downtime_limit +
+                                                s->parameters.switchover_limit;
+}
+
+int migration_set_downtime_exceeded_error(MigrationState *s, QEMUFile *f)
+{
+    int64_t limit = s->parameters.downtime_limit;
+    Error *errp = NULL;
+
+    error_setg(&errp, "Downtime Limit of %" PRIi64" ms exceeded by %"PRIi64" ms",
+               limit, (s->downtime_now - s->downtime_start) - limit);
+
+    migration_cancel(errp);
+    error_free(errp);
+
+    return -EFAULT;
+}
+
 /**
  * migration_completion: Used by migration_thread when there's not much left.
  *   The caller 'breaks' the loop when this returns.
diff --git a/migration/migration.h b/migration/migration.h
index 6af01362d4..aa56b70795 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -338,6 +338,8 @@ struct MigrationState {
     /* Timestamp when VM is down (ms) to migrate the last stuff */
     int64_t downtime_start;
     int64_t downtime;
+    /* Current measured downtime on source */
+    int64_t downtime_now;
     int64_t expected_downtime;
     bool capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
@@ -519,6 +521,9 @@ void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
 void migration_bh_schedule(QEMUBHFunc *cb, void *opaque);
 void migration_cancel(const Error *error);
+int64_t migration_get_current_downtime(MigrationState *s);
+int migration_set_downtime_exceeded_error(MigrationState *s, QEMUFile *f);
+bool migration_downtime_exceeded(void);
 
 void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
diff --git a/migration/options.c b/migration/options.c
index 5ab5b6d85d..a1a22d389c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -40,6 +40,13 @@
  * for sending the last part */
 #define DEFAULT_MIGRATE_SET_DOWNTIME 300
 
+/*
+ * Time in milliseconds that downtime can exceed downtime limit
+ * on source or destination before migration aborts if capability
+ * switchover_abort is enabled
+ */
+#define DEFAULT_MIGRATE_SET_SWITCHOVER_LIMIT 0
+
 /* Define default autoconverge cpu throttle migration parameters */
 #define DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD 50
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
@@ -162,6 +169,9 @@ Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_UINT64("x-switchover-limit", MigrationState,
+                       parameters.switchover_limit,
+                       DEFAULT_MIGRATE_SET_SWITCHOVER_LIMIT),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -184,6 +194,8 @@ Property migration_properties[] = {
 #endif
     DEFINE_PROP_MIG_CAP("x-switchover-ack",
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
+    DEFINE_PROP_MIG_CAP("x-switchover-abort",
+                        MIGRATION_CAPABILITY_SWITCHOVER_ABORT),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
     DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
     DEFINE_PROP_END_OF_LIST(),
@@ -315,6 +327,13 @@ bool migrate_switchover_ack(void)
     return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ACK];
 }
 
+bool migrate_switchover_abort(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ABORT];
+}
+
 bool migrate_validate_uuid(void)
 {
     MigrationState *s = migrate_get_current();
@@ -592,6 +611,14 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_SWITCHOVER_ABORT]) {
+        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+            error_setg(errp, "Capability 'switchover-abort' requires capability "
+                             "'return-path'");
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -824,6 +851,13 @@ ZeroPageDetection migrate_zero_page_detection(void)
     return s->parameters.zero_page_detection;
 }
 
+void migrate_set_switchover_limit(uint64_t value)
+{
+    MigrationState *s = migrate_get_current();
+
+   s->parameters.switchover_limit = value;
+}
+
 /* parameters helpers */
 
 AnnounceParameters *migrate_announce_params(void)
@@ -905,6 +939,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->mode = s->parameters.mode;
     params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
+    params->has_switchover_limit = true;
+    params->switchover_limit = s->parameters.switchover_limit;
 
     return params;
 }
@@ -937,6 +973,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
     params->has_zero_page_detection = true;
+    params->has_switchover_limit = true;
 }
 
 /*
@@ -1110,6 +1147,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_switchover_limit &&
+        (params->switchover_limit > MAX_MIGRATE_DOWNTIME)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "switchover_limit",
+                   "an integer in the range of 0 to "
+                    stringify(MAX_MIGRATE_DOWNTIME)" ms");
+        return false;
+    }
+
     return true;
 }
 
@@ -1216,6 +1262,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_zero_page_detection) {
         dest->zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->has_switchover_limit) {
+        dest->switchover_limit = params->switchover_limit;
+    }
+
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1341,6 +1392,11 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_zero_page_detection) {
         s->parameters.zero_page_detection = params->zero_page_detection;
     }
+
+    if (params->has_switchover_limit) {
+        s->parameters.switchover_limit = params->switchover_limit;
+    }
+
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 4b21cc2669..7c57789970 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -84,6 +84,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+void migrate_set_switchover_limit(uint64_t value);
 
 /* parameters helpers */
 
diff --git a/migration/savevm.c b/migration/savevm.c
index c621f2359b..031ab03915 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1492,6 +1492,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
     SaveStateEntry *se;
+    MigrationState *s = migrate_get_current();
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1523,6 +1524,11 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
         end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
         trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
                                     end_ts_each - start_ts_each);
+        if (migration_downtime_exceeded()) {
+            if (migration_set_downtime_exceeded_error(s, f)) {
+                return -1;
+            }
+        }
     }
 
     trace_vmstate_downtime_checkpoint("src-iterable-saved");
@@ -1561,6 +1567,13 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
         trace_vmstate_downtime_save("non-iterable", se->idstr, se->instance_id,
                                     end_ts_each - start_ts_each);
+
+        if (migration_downtime_exceeded()) {
+            if (migration_set_downtime_exceeded_error(ms, f)) {
+                return -1;
+            }
+        }
+
     }
 
     if (inactivate_disks) {
diff --git a/qapi/migration.json b/qapi/migration.json
index 470f746cc5..069a44f207 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -469,6 +469,10 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @switchover-abort: abort migration if downtime exceeds the downtime
+#     limit configured by the specified value by switchover-limit
+#     migration parameter.
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -485,7 +489,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram', 'switchover-abort'] }
 
 ##
 # @MigrationCapabilityStatus:
@@ -821,6 +825,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @switchover-limit: Switchover limit (ms) that would be used to
+#     intiate abort of live migration if the total switchover time
+#     exceeded downtime_limit + switchover_limit (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -845,7 +853,8 @@
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
-           'zero-page-detection'] }
+           'zero-page-detection',
+           'switchover-limit'] }
 
 ##
 # @MigrateSetParameters:
@@ -991,6 +1000,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @switchover-limit: Switchover limit (ms) that would be used to
+#     intiate abort of live migration if the total switchover time
+#     exceeded downtime_limit + switchover_limit (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1030,7 +1043,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*switchover-limit': 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1190,6 +1204,10 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @switchover-limit: Switchover limit (ms) that would be used to
+#     intiate abort of live migration if the total switchover time
+#     exceeded downtime_limit + switchover_limit (Since 9.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1226,7 +1244,8 @@
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection'} }
+            '*zero-page-detection': 'ZeroPageDetection',
+            '*switchover-limit': 'uint64'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.34.1


