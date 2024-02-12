Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C8BC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 18:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZak7-0004bi-3n; Mon, 12 Feb 2024 13:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZak4-0004bX-VC
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 13:09:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZak2-00072w-PV
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 13:09:20 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CHxLsO016607; Mon, 12 Feb 2024 18:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=I81xKXBRv5QTfR5rWWYyphgeZZn0JjnVswJft6Gm3eo=;
 b=gE/iMHpbOwfDqhutLL2bLARjRQvqkjxCJqmIkmSoqNwPrMlm8SQiatArF4w8CaKpejYt
 Jxw/Fl+wj/hnkEtPa9SWeX0IQ9pmz6RRzUIRB9B18xIvx/pJL3g1pwHfJUcScZm+vEfv
 /PWnj+msfA0SLN9Iu1u2lioTZHPMyE4KvOwP74tDDIVUuWkrrImm9NKUf1FWOnPH8WhS
 7QU7s+PjSO7F9pe97D5UE71mW5ZAsrvyhswDnwTn5n7enLOeBxM83RaDGgzX3i7+CuSf
 mU9zWWN0pOaL3e6i9+TejyyP0rYo2sDGS1m81LhmA/mhZ3dr82nqr6pYmExNFpuVPhXJ +Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7r7881bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 18:09:14 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CGrCrB000639; Mon, 12 Feb 2024 18:09:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk64tak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 18:09:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du9mk9NMUq2tvzrTXmpN5a0Mk23ixRR6QCAWcyKy4rfGJB2NlHPg8E/FbYyy04beGtiw/+dKQ/2ZEIpcePzyqZ0RqbVsCLuenrJw86m35KCGfrW4s9KK0LnhY+YpST5wxPilGCCYZFMCMnGPyDhHAqpyKIqYNtLtVkl7VFrrNPnOJ6OW7QKpLhMtQVetNdx67NjfAHhwb4Vq998kM2S/xMFjV2H6gNkiy9RwEUAlOq0HPxasAH1lV91OUMIEP4+PQtoRWQpixIDo3B/HuhZXPJQpHUzO3DTQWM8BDL+etPHq8IF16FjzNDZ5RWXIYYlXeROxLHcykWr8xHEAIRgVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I81xKXBRv5QTfR5rWWYyphgeZZn0JjnVswJft6Gm3eo=;
 b=dsjtsIl6BWiB4PxYSQswoHLLvfq/+wWBP5L5OhVmQTBfhGjP0qfBEC9TQEizE65RHuVQQcFcSUpfz1jW+kLOAvCCtNyzJGxDH+NCx65e80U1wXdadsTBI5I0tOlfAI6ouDexX0wmHjlASagPw+GIzzyqFbDddAH/DUn93AsMUIjHEvJNTMvfWYvFK8l1ICNrxt0hSMplwIpFjC3thYNZmHdEnVtWU3ltpiRmmFBauAnZG2QE76QkwNg4BHbwjUlp6jrOgi9cReWVZ8DY6IOW+8kEcx+0phES0s05tQgqUXbdXV2UvAcC9sv4GEXKwjOkohGxq78kZnCLhmYanY6qWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I81xKXBRv5QTfR5rWWYyphgeZZn0JjnVswJft6Gm3eo=;
 b=GrkL9QVaQM1Cs1eDJfnYHhYt7ho9FqNuk6LxwvVuXe+qegTEhUddqLzc4KRMLyBW2i9MmKRSX/Wq+t10p6hocbrdBb1TN/OIFyu72K+vGAtbkoHI70kRW55YoUP9Jtw4NxPDQ35QykkNgJq7c3LnA43SPnFRUOwZk1LJ9/Boroo=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 12 Feb
 2024 18:09:08 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 18:09:08 +0000
Message-ID: <eb1167aa-e7f4-47bf-8d1f-8669399a16a8@oracle.com>
Date: Mon, 12 Feb 2024 18:09:01 +0000
Subject: Re: [PATCH RFCv2 2/8] vfio/iommufd: Introduce auto domain creation
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-3-joao.m.martins@oracle.com>
 <20240212162757.GC4048826@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240212162757.GC4048826@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::20) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9f9ad3-92b1-4e98-8ed4-08dc2bf5b4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jA6YUMLOqE/9rb+U/9yPdVrPonsnvACuSbI7uBpifGkvhwrMBck11diacQrGkIWVDs1k6yTqYstfaDlgLbUb5HulnK+RE1843X3YdDY715kri4l6NYR1ug6ULy7iPmoaEKoGzipDobr17RPdYEatPsZsojuUCnVDemvgCRZMCXdqxhdtj49ZsBD5F2CX0YkxDyPjqNkut/LELm3zWi1Be6n9d9TJKJVfMz+ZpCdFDd6gdhxVqDapTRD5VpIKh2uPJMd11Lrn7UClYRhGUiV7Mm9XYbwHV0xOW2FpoF0crF4D4yorV1x76iDg1e6B3b0T3GSkeM6O3xnPmImDQLzsANr5FeFAPb7Eg6SfESvDqFjZUwLWMeqcFTA0Eajv4Z//AreGxijVtlxmOEM/zxS8P45mDfbT47lMDW710GcUrQUBjHcdclPphEeSt7nUZgrcLGVk5QU6T7i/dSx1dhuj6LDKSdyTDSWL+b3XWx5O9E2vWn/Bs7eqrsnLxmoTpC3oEUeRxHbVT/R/NqhgOEWZQn5meRYP7UE5A6ez3KZD3Ces6gw/bd8tL2tvmkBRCTY2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(7416002)(41300700001)(2906002)(6666004)(36756003)(6506007)(2616005)(53546011)(6512007)(478600001)(6486002)(38100700002)(83380400001)(26005)(86362001)(8936002)(31696002)(4326008)(8676002)(5660300002)(6916009)(316002)(54906003)(66476007)(66556008)(66946007)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEpTQXRpaDkzcmpTQXVvVzJqbC9mVDJYUVVLNklPUytpcmlGamZ1YzVtWWJy?=
 =?utf-8?B?bTVtRmhkUVd4bnRZNFFKWndaSis2NzVTUzZoOUViNmdqcW9VeVBBZkIzMW1x?=
 =?utf-8?B?Unl6TkVJUVQ0N2JEN3JMUXZoOVQwUWsxZDBtd3h4L3dqR3RZVCtoQjJvYmlJ?=
 =?utf-8?B?cWlMYm9xaURHVTVWVTVabEEwZXJNb1BrTjNEalZvL1AzRm9wR2FkZjR3NG9l?=
 =?utf-8?B?Y1p4WEIvUDdvdVZvMHBCeVNiR2RxclJ5cmJWbmhld01jSmh4d0VwQzlrbjE3?=
 =?utf-8?B?ZGdmY01QOEppU1VvSnVkcExNdzhUY3BFdnV3TndlTXZJRFI0MFowN0VCc1pl?=
 =?utf-8?B?aVFWbGM1ckFwaWltTGprc2g1OGVMTFljWVZwUGh6UkNtZnE3OWs5dWtERkps?=
 =?utf-8?B?WnFCV255R0thYmI5bHFPcWxDUURBMFBnYUFETnFkRWM4UkZ0U3RkQU1uL2Qv?=
 =?utf-8?B?akdzdXJMYnBKY3VWd0FkMEhXaTFTWXFwekZXN2VrKzQ1MlhGL0oxdFdva2gz?=
 =?utf-8?B?SjlNb3I2MnYwMzMrT3BMbUs1dUlqV3RwV09QSkJZUitGbXp2eHhBOElXMzc3?=
 =?utf-8?B?OWZDYXdEM1JQR0ZJMS9FZUxSN0ZiYUJheEVQY2VMVmNLei9MQVdZNE9lRHZH?=
 =?utf-8?B?WVJpcGJoNUVMY0NWZkMzSmxRVDV5cFdwMkxPbm1Gc1QrUUhKMXN0QkUzQVNx?=
 =?utf-8?B?a2trUnhyeTcvZHNaSUY4RG1Ia2o0YWJKQWpHQVg4NW8xVkl3ajJKOXUrdXBj?=
 =?utf-8?B?WnpQN0IwbDQ2Q2tYVUpBS040VitJQ2FkVzJCUW5scWlGZ2dqL0FyZWtlUmlU?=
 =?utf-8?B?NWUzT0plT1NrTVkzZ2drazdoSUZqSjJyMlpSVStSdC8rSWpmVWNwbmlobG5I?=
 =?utf-8?B?L3kzOGY3R0NzRFpZQzY3ZVJNKzNUcTJMeFE1MzNUVW5JTmFoRW1MdjJ2OVVk?=
 =?utf-8?B?MFErSmxKZDlWWFBhd2pmME45bFpPL3BqblgwS09zbHN6UmJvOENEZDIxU1FC?=
 =?utf-8?B?RHhISVVZSG5pelY3UCsxWFFxQWFZMFY5eU0rY1FuNmY3WWZ4dTNVT1Zsczlj?=
 =?utf-8?B?R1B5OVFsdDdWbmFwZFU1MkpwNG45Z0lXdjFUckdMWktOZTZXQks0c1I3Vm5Q?=
 =?utf-8?B?NG12WlVxVjE0d1FPQWRkRjMxVHQ2eFB4S3AvTU5PM0hkT2pFaTJYSGRkaGhC?=
 =?utf-8?B?OTRjNDNTMUQweUFWZUxJaG0ya3hRakYvTTdYRGhaY2E3bnoxMFBrNjhrMThV?=
 =?utf-8?B?b2wzdk03L3FzaUQ2Yzc2ZnZwY0hRc0Rqa1Y0dmpzMFl3Wk9lVWRZalhSTXox?=
 =?utf-8?B?cEFrUHAraU5ZNUhGZmpBRTRRNXRramM5SDBsVGE2aGVSLy9BUjRUVHdkMzd6?=
 =?utf-8?B?Qml0eHYySHNJclJrc1FKN3JlQXU4V05GVitJZXJUU09qYVAzSVQ0YlJuaitF?=
 =?utf-8?B?NmJsQitNcnJSS2luTlhWVTRMMDR6TE42ZEd6K0JneGNadGZ0bldaZVVCK1Jm?=
 =?utf-8?B?akExS0tFaVNJOGMzTzZmVXloaWlRSE5GNDVIbUV3UjlMOVZ2VHZKUlk4NFR0?=
 =?utf-8?B?bVVWS2dBMVA5eXUrQjdnbmNCTTRydWxCWXhjdW9lSk94ZHcrL3FEN3pSZWMv?=
 =?utf-8?B?bCtqdGtLS0RsbTdUV3pGZGVZVll0M1Y5NFZVVkRSa3VyUDFZVy9RNExGUm5B?=
 =?utf-8?B?TWlDTEhhL0E0RDEwb3B3NytWdXg3d3pETkMrcW5aRlMzRmNFMnV6RnNmYWRD?=
 =?utf-8?B?N0Y0dFR3UHRJL1lKeURsbCtVWGsvc0NKN0hqUGdzSWZuQklWbzliUWtXUjRw?=
 =?utf-8?B?a1lIejFWZmxveHFyME5PN0VyU2w2Z3FpNjE2NDJIRDUrTEdCekJmTVB6TGNk?=
 =?utf-8?B?UHdJeTRScElzZUp6eTRmZktVL1BXZElUcHg2YVQyQ0xadDhLUVhGUUJpb1NY?=
 =?utf-8?B?c2RsTXg4c1pxbEd4ZVpteDl6VFdWZERRZUtrUXZQKytHQmJUelFFVmRIcTRk?=
 =?utf-8?B?LzU1YStmOTFNazRvUllIRDIwUlljVndlUkxpTEY0ODhVakY2KzNrM1NnQ1Fx?=
 =?utf-8?B?QmswQUNCRCt3Z3AzQVg4cFdCRHJ1Zy9FdmlmRS96MW9OVk5CNk9Cbkx3d2J1?=
 =?utf-8?B?OGlKTlhYK1RIazE4QTZ4S2pMalBJb3h5SWxJa0IwdU0yNVI5SmtraStscHhl?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nGnaA4YQqyOCxA/+NfaeggkjpFBoQ7r3cvPnkHTg3PkEdgiYqQ7EPWVjVHfZwtkhCq4JHRq+d0W1hkk36WyImO7wpWFmuDOTDDNMA/uXrRfFGUgRbe0v+XlOUsxorf2rJufrhKkQqlFRxHj0b3KM3kAUNy/uemUNXThQuXkliRX5nECvtm+NfgJC4EL0t1yPG6evMx6DmgcYqIGmHa3knJaBF7Rngx4hLkoca8vJbgrKCXz0DZLjkMtMcG+LBaVWH6dJmvGnk9qwwcn1kP6m4iNQyw2DO2xPP/VzVDFH+LuaYChuCCeBNMdhfhVijqX94zHAh9Ly0eIJr0ML+X7ZsxA7eOJbCdSNwmeORWOWb5MQTlRcAWutTJy8WoE32hYRTiDsyxN9IQBGeC1MG1w1QiiQm9Z3a0vFW6+QuKa4zbdOACgrodRIQwkbDqX9TrMkBM3zuVmzTQSvpgApiXzkZyO8I3UmHoCDjkeYgZbB0vUaSh4jv1jb6ozNyheDvaNl9M5g+B8H+YzLU5nDsYkuS4vxTTofCN0EEvbhNYbk2fZ9/BsJnaYJKI5EU08Xu3rOG9zzjxB7OJKyffh/L9rwVMlce7NpoPHkb48FJeTmGMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9f9ad3-92b1-4e98-8ed4-08dc2bf5b4d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:09:08.2906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eC/B6A6ZK9T3Pxvx00yfhcOF7AWt6JmqE7S/e4j/Htn9ttqH0bgKTrmbaIFTWElJsmuKYeT2bqBCe1Dc/N2qFYd1G0IBbHPbFS7d1jNGxxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_15,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=901
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120138
X-Proofpoint-ORIG-GUID: hpz_MO10PIzjzeiHOm2B6z9FH5LlpwTo
X-Proofpoint-GUID: hpz_MO10PIzjzeiHOm2B6z9FH5LlpwTo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 12/02/2024 16:27, Jason Gunthorpe wrote:
> On Mon, Feb 12, 2024 at 01:56:37PM +0000, Joao Martins wrote:
>> There's generally two modes of operation for IOMMUFD:
>>
>> * The simple user API which intends to perform relatively simple things
>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>> and mainly performs IOAS_MAP and UNMAP.
>>
>> * The native IOMMUFD API where you have fine grained control of the
>> IOMMU domain and model it accordingly. This is where most new feature
>> are being steered to.
>>
>> For dirty tracking 2) is required, as it needs to ensure that
>> the stage-2/parent IOMMU domain will only attach devices
>> that support dirty tracking (so far it is all homogeneous in x86, likely
>> not the case for smmuv3). Such invariant on dirty tracking provides a
>> useful guarantee to VMMs that will refuse incompatible device
>> attachments for IOMMU domains.
>>
>> For dirty tracking such property is enabled/enforced via HWPT_ALLOC,
>> which is responsible for creating an IOMMU domain. This is contrast to
>> the 'simple API' where the IOMMU domain is created by IOMMUFD
>> automatically when it attaches to VFIO (usually referred as autodomains)
>>
>> To support dirty tracking with the advanced IOMMUFD API, it needs
>> similar logic, where IOMMU domains are created and devices attached to
>> compatible domains. Essentially mimmicing kernel
>> iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
>> to IOAS attach.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> Right now the only alternative to a userspace autodomains implementation
>> is to mimmicing all the flags being added to HWPT_ALLOC but into VFIO
>> IOAS attach.
> 
> It was my expectation that VMM userspace would implement direct hwpt
> support. This is needed in all kinds of cases going forward because
> hwpt allocation is not uniform across iommu instances and managing
> this in the kernel is only feasible for simpler cases. Dirty tracking
> would be one of them.
> 

/me nods

>> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>> +                               uint32_t pt_id, uint32_t flags,
>> +                               uint32_t data_type, uint32_t data_len,
>> +                               void *data_ptr, uint32_t *out_hwpt)
>> +{
>> +    int ret;
>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>> +        .size = sizeof(struct iommu_hwpt_alloc),
>> +        .flags = flags,
>> +        .dev_id = dev_id,
>> +        .pt_id = pt_id,
>> +        .data_type = data_type,
>> +        .data_len = data_len,
>> +        .data_uptr = (uint64_t)data_ptr,
>> +        .__reserved = 0,
> 
> Unless the coding style requirs this it is not necessary to zero in
> the __reserved within a bracketed in initializer..
> 

Ah yes; and no other helper is doing this, so definitely doesn't look code
style. I'll remove it.

>> +static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> +                                        VFIOIOMMUFDContainer *container,
>> +                                        Error **errp)
>> +{
>> +    int iommufd = vbasedev->iommufd_dev.iommufd->fd;
>> +    VFIOIOASHwpt *hwpt;
>> +    Error *err = NULL;
>> +    int ret = -EINVAL;
>> +    uint32_t hwpt_id;
>> +
>> +    /* Try to find a domain */
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
>> +        if (ret) {
>> +            /* -EINVAL means the domain is incompatible with the device. */
>> +            if (ret == -EINVAL) {
> 
> Please send a kernel kdoc patch to document this..
> 

Ack

> The approach looks good to me
> 
> The nesting patches surely need this too?

From what I understand, yes, but they seem to be able to hid this inside
intel-iommu for the parent hwpt allocation somehow. I'll let them comment;

