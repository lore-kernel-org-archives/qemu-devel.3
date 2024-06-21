Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A31C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfJh-0001M2-Ef; Fri, 21 Jun 2024 10:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1sKfJg-0001B2-2w
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:32:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1sKfJd-0006Mh-TD
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:32:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LER5gD029055;
 Fri, 21 Jun 2024 14:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=zahTksBq+1vZBSwNo2/8qjpkkZD5rOG9NoXlyGzH1O4=; b=
 dHxcAWpRGNOoeSwT43QI3Mbl9cvb4bITat3KzIdMWGsZwrfdTz8kgUQP0ZsNP44C
 V88aMZNsk0J+2DGlWuzC8X1c2cwBFIsnuulEGbrORemMkehZ5CnNOhwHWVkvb/H8
 ehCGONXZOn6WDbCxAdlbjyaa1fADr8zl3M3DcBGThU0/4MVYoe37sSWBgwBN06Fb
 2LqJy45Cx27yrcI6Epf3pZInmHAXUkLXj0xJ5XLU6wQSmn/fofg7nxUam5uvYYpk
 C8jwpdsaEfuUiQaOT9TVPmEmqsBg/7W1BrA/U9VGiY73piJW9WmSmuxm7RcSJLTd
 UfG6MY+LutA5GrB1f/Ogcw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkj1vs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 14:32:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45LDd7h8019425; Fri, 21 Jun 2024 14:32:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yvrn3wjc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 14:32:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4S2lriFkMOHB0EoQzn5idoEVPxNwQELDrJa5/LN76oExAfxmoqaPYRiv/U7Cc19Wej+FrJgWcuXc3d3ktQ7rOfMNKyii12MIg+hCJ9Unng84djyBI1hI4oSmLJjGBYD4w1BEnOsP5Z1YeYpeR9Gq8aH6fHCXMrezrk+be2GmX4zXKrPAudxZr/kIJ2P7PJX7DrbbepbLp2ixE5IzDN2ltFzNUePSdqtU84aVHvYWMfOG5Q23D8ZzxbU3va+Dn3uK9dLCjdGCeXWsUYzoKamGd67G6hoVJlVxEud/Pa/W5afYz+nuRBsl591C1VCw3sRn2NXvYLe3PEjOVYKJHo5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zahTksBq+1vZBSwNo2/8qjpkkZD5rOG9NoXlyGzH1O4=;
 b=KzdapwRGedWAjIe7jpH66qwEa/zmUyxoOfQEh55Elr3L8c+z87XCvwd2njzCUiQF1WYmmNm5WHMcPtt6LRfPXvcFxqZWl+E3gWs5aMHgQ2rfYgndehvoABiePfMFEQTFT0eIFIz2zcjjboMhCj4Db9KNDkgIK1a+wgD1uxpmx2d+pSP9Oo7u2cG2GdypdHVJXVu3y9ZSkhOrwabL2FmE4cx/OPbQEzsgmUT2Ae+6WI3YVJVeLaNJTQtow0eWUeHQUxLDk0FOt7MuEYdGwEePmzJY2kgPjKeD0pBBlnCpOd9lBi6fubNMDHcfbSF7FZdr+CpbSkkaVtYfu5C1P2dcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zahTksBq+1vZBSwNo2/8qjpkkZD5rOG9NoXlyGzH1O4=;
 b=oOI899KErZ1Wegbs4GYicf2iUOOg3OZvs4jmJXbs0DivOE6jd4Q9Vj0avxfWYZ5BpU9ArniKHiPuDM+Z8VKkVh9qx1vTElQqptZH16dw3wvSxxtZG4+VCyjeT8y598gZ56lYmll7xoFBfy1TDg0pNXydQxse9gr5M35Rg/EMJ5k=
Received: from IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13)
 by BN0PR10MB4903.namprd10.prod.outlook.com (2603:10b6:408:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 14:32:29 +0000
Received: from IA1PR10MB6172.namprd10.prod.outlook.com
 ([fe80::23d9:6a15:e343:b950]) by IA1PR10MB6172.namprd10.prod.outlook.com
 ([fe80::23d9:6a15:e343:b950%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:32:29 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com
Subject: [PATCH RFC 2/2] migration: abort on destination if switchover limit
 exceeded
Date: Fri, 21 Jun 2024 07:32:21 -0700
Message-Id: <20240621143221.198784-3-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To IA1PR10MB6172.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6172:EE_|BN0PR10MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc23f1c-f35c-4089-d162-08dc91fefaa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7yLsKfmyTbJ7SG1Re82WwIu1Kq/GUK1Spqtnw4dQ4nIWSL2bpOuV3dnjZhsL?=
 =?us-ascii?Q?SlLwcXI57JaJv3t1JpZbRXwIhUy2EC+SNXSCU785WdvmWpZcmO63DKO97sjT?=
 =?us-ascii?Q?zmpolsqtl6lqPnszf5dgEDc39WVNwz8VTcoSg8eC9SvszHFi0cSX++57XiMU?=
 =?us-ascii?Q?c8LtNlUhRUMepclYX9UpkpAhMuMGecuw1C+w8+SWObrIueP/r9Yq4Y71hu95?=
 =?us-ascii?Q?qB5PyVFNn+Vb21aYVB/2X+3iz4We33ldWjQbk9PtS2i/EHv/ayaau9wMk/nH?=
 =?us-ascii?Q?k6brAje4CAKHejubMBudPuOtDXrIYpamtMt0h137uN6btmjN0FS6U/wb9V4y?=
 =?us-ascii?Q?CkgMqcUGeDW9xtKwvvRUBh744o0Qau/yuZ2qGfRay7QxYVQPzVdExviV+N4s?=
 =?us-ascii?Q?AEuGYGp5PoRUhlQeeU0D/m+GeiWTMW+bTVjaOrmmn/TWMj3u9zfqixz54YnY?=
 =?us-ascii?Q?3iQzwxWLxnLx1JRV11X15td4kRV7oiWGKFBy/fmrRFlYDoCkUaiCYNb1tsDr?=
 =?us-ascii?Q?lPlqyaOlKULWfbXtGVvPOL9Jcje/WVPKaSUUuWRMhf5nPuZ9BabEeZiXhxoK?=
 =?us-ascii?Q?tz88gPw0eM7K/Kj1ZPPju3fhDTd/ezfe0imcydutbWKI4dkOfkUC3dewcaI7?=
 =?us-ascii?Q?MxXRaclg12+nH7LgyPt2e3LWNAPEjvZicZrXGAB7HNO0z8s17AoxFjxtBZgz?=
 =?us-ascii?Q?8FWpCsMtUpu2SoQ99j7TidQJDeLP20HJ08XS5D3PoFWO1KqbYepHSCY8lTKl?=
 =?us-ascii?Q?xxaj4iEyAXTxVkgWeE8UdsmU3A24cYlAXiUWdiw5FxtgLl1gL5UkRtVr1Z37?=
 =?us-ascii?Q?QshWXfyIGby+MQQhzUTcEFQa2aMUQ5uedC0QJwaAKJvU2VZxuCRN83rCqSSi?=
 =?us-ascii?Q?3/TQ1Vl0KT8CzoPiXFdEMAkTdgPllrCfQcy+JoTaoNay0+Z6jNoMLm4C/r5D?=
 =?us-ascii?Q?4Cc/234/iB4L+UwfO0N9OLoqxz0Kcyt4YmU7OujaB3jo1BFCMcqmsAeVoHiC?=
 =?us-ascii?Q?E+hqmmcueJ2UKr/viDTNyO2oOCq/x3x/2B6ivdrktt9mRQNXFZ7oTpndtkTp?=
 =?us-ascii?Q?QPADteP2It0sekJEOYFIaFBV0rBl3WIIUimtWnu/A8bSdslKJE+MIne7f1eQ?=
 =?us-ascii?Q?6Jb/vlmKRKNb5JtfXUmSOkYx4i+DZC/XP7w6lQf0V6cnR19XwpecrBBDf6TF?=
 =?us-ascii?Q?DS5f9ejmMYAkG7SV+zR7HlyVBlGJEYuCu9C6Pcj+Uq0o/qGfQKLOvPlOINeZ?=
 =?us-ascii?Q?eEjP9VSFgsDBcNma5ck2btAl5nhoqFUCqtPaJ9S/kqoGJu5eyNKtGrddkPtw?=
 =?us-ascii?Q?5Qu+8C1lokTOhY3wrWz9P9Cy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB6172.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKL6LvoNfYhoGn8H2sLmSawvSAXL1bJUcW43PqpP33kRYJrKPfKgL1s7SHu5?=
 =?us-ascii?Q?2fNA/K0w/Nu4sfZfV/lZMI9k/ES4IWumAd0yBo0uvYPfu2hrwztwnqb8Ieie?=
 =?us-ascii?Q?65gD6fPlMd81W7cdqrHUzQNtuu8L/yiCR8rMJmVk+xX+/6wHmaHLkmeWXVbG?=
 =?us-ascii?Q?uiWlenSoju3g3NzuoYqMg+E3BrfgW+fOoFZoCRcuyYw2WBhV4uMxJL6hBono?=
 =?us-ascii?Q?jipkaViEfSrqNVNlniJ9FIVO/15TTD7KwnJz1cJGi2cr3//TekrDQ7CiuyuT?=
 =?us-ascii?Q?UtrSkpUNPsavMM1/VyfrB//qbDymhMmiK4NRgtmD9T7urRjpz2VqHKldeCIG?=
 =?us-ascii?Q?SbjK+IzP1DFTdhkeJHLritiulxbm3drQ+wZoLVODM0INSsrSkf1RtFYtAepP?=
 =?us-ascii?Q?utTU2caMi8u5iI2f7nCXHFdpYV+q9Me65g54Z1EBqUAaXVIbv3alVPEyxaYd?=
 =?us-ascii?Q?2YKO9bfl3pdg7LKRw2rCYS86EHHvZQgW72PIebNbWRflB2ieECOtkoZod1iR?=
 =?us-ascii?Q?Qa0MzIQOcyEGrXNhjJ93bHRw6YUCNcRafEVJ8A+AxFuGeKPGsTSH+tbf1b03?=
 =?us-ascii?Q?2P2f+2ZANjflQCiMUoOXLmBspkpYuCwlaWEQ2ljvhZnjTiVR6YNdzeiH2D2a?=
 =?us-ascii?Q?tWQ+yZoI3ZZcWjxfdZ5fejTOmuCUXOKik2Ll+uA47o3N/dG4IjU+ze7BOEoG?=
 =?us-ascii?Q?cokB4g/1LIvfWyK3XK5Lqn446U3Ikzf182ZGMmc3MK9X3kvp1ri7LEGc7tWA?=
 =?us-ascii?Q?/TwyPhZR6HScTecgLUyR2dZQUOzpAJJ9E2udVeWYk34l64BDbb8xQlGpbrQ1?=
 =?us-ascii?Q?FSO6ctGJXtSFfyqCo8ZqSFZQOq5YZykYFWn3Jwe5NippFOe69KZiHgE7lglm?=
 =?us-ascii?Q?cf/Hq3vUYeSRXXWO0au+aho1vmN/OWUtTnf06+hIgqCE53KlXlQufPmjWzpP?=
 =?us-ascii?Q?er8DYXqe6qQ2DNxY/1Uxpo/FDMR7Dnb3Gvgjti29kaq/dAGrs0JP7sLeV+1q?=
 =?us-ascii?Q?yylIddy0SA19Ke4tf+Gp2JpGfL0/xq3MAgAca4R7MIhVEx04KUpAMqlYiALl?=
 =?us-ascii?Q?Fxl9AEI9shQpz7GjXnjemekKxsQ17i1j5KR4Y/5Wvn7ojG3NSSOy6mrgYPxX?=
 =?us-ascii?Q?GkDM2uxjjZHM/LvbozDCML3Tn1IypiUjD4wO7LKGK36xx0EPjEWOusAmhXg7?=
 =?us-ascii?Q?UHvpkgFHpTj5KWPdpvxGX8EbkIxyWiy1Aj+al+fd6zPjbt2mhenwkbV8/OLq?=
 =?us-ascii?Q?OMO4LbJjSDD9dkG3k/1GnloaXFRsozmkaXK6LUnyeIcwKIyp1Pc4hII+NdNO?=
 =?us-ascii?Q?zHCHWyW7Zjx/rcGLaQLFulqEr3Xabfju/4E/WV1qLIPsh8xvLFSL51gyO5g8?=
 =?us-ascii?Q?HSx3WUsiLiM16wr/uuUHf3FCNcs8BjGguxAw9CW9Ni0wajG0g70DGIBlHnz5?=
 =?us-ascii?Q?/6vhUm1mpscP9FxCF8/Fem4icmpr/zhrWhtsfn17xDf/qzMUBFUK6jsOL8jV?=
 =?us-ascii?Q?I1tYXaV5bHcNig15q19G8tjxOXcgjhQucEjzUw97cLEL4jQrDbXxu2X5+OeO?=
 =?us-ascii?Q?gO9D5ZP6b9peD1aLFIuFYDPW6TYOIB9AQzzfllg+ZhdshP5NgiFkf6qUDgx0?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k9T+pTKS3AkZzFg5OraobwT/KAdYqlamZKwVz9EnKw8wRLQLJ5pBqwTyXi2EhUu8N6urTFigfrhyIZt2vdVZBKJt3FwnSFJ5Rlo4keDZAYu8g6bWTXO83jdHZ+yotliKZZOwePgNTU7ONSoTVMNzad9Hp96p4LBIuwoZmQfub1ctOCKOuYWcX3y9x4H2Ln2oR8VIWhOuz00c0nd5GQZ0upwFp7VDQmUulO6G2HqFdI8eszFd713noE2CqRs4AXu9Xbv+VtRchGC80/O6MrJiMkZUDnXoSNYXIv/5pb4GiyOQJ0shwqf+myVuaoBfH3DSLHKmZNfbrlamhr+VOB+YYJMUGwrwhkFG+sqHNUAd3ylLD/v3BpzGguDddX9lx86rrG5oTUxgqb7A0v/vtqDM0McsmZ2bwZBrncgWasbvRn5ygCzh5jyJEBsBop2c1xKKm7VBvJcqdOlX9a3bza3ZFGUJK4ncrB85n8X51SD5sAZM0CEEO1QB9hzJ4x8mG+JlSYtPp1hdy+NbxF/aynKwkNmVzogLk6BfeOefz1h4HZTC9zYvOh27xr6MPzjnGUDOtpimqcYKcHQLAGCSkjE3oSvAsP02BXneb/kcnLpWj+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc23f1c-f35c-4089-d162-08dc91fefaa0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6172.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:32:29.3525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8z0pMJp56Ay72X6XyN5srOu7qIRj04LotO0FfmRPkqn9HqMCSArl8WKNT2bx4ZT8biyCGcFiRmKCi+SvzwOC6fI6DxY9Enc2LHfUd2aFZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406210105
X-Proofpoint-GUID: cstUqwaGOH7VMsfTFa34vuNhQJt5r7zm
X-Proofpoint-ORIG-GUID: cstUqwaGOH7VMsfTFa34vuNhQJt5r7zm
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During live migration, receive current downtime from source
and start a downtime timer. When the destination dowtime
and added source downtime exceeds downtime limit for more
than switchover limit, abort live migration on destination.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 migration/migration.c  |  2 ++
 migration/migration.h  | 15 ++++++++++
 migration/savevm.c     | 68 ++++++++++++++++++++++++++++++++++++++++++
 migration/savevm.h     |  2 ++
 migration/trace-events |  3 ++
 5 files changed, 90 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 5cc304d2db..64d7290997 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -240,6 +240,8 @@ void migration_object_init(void)
     current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
 
     current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
+    /* Downtime will start when source sends its current downtime. */
+    current_incoming->downtime_start = 0;
 
     migration_object_check(current_migration, &error_fatal);
 
diff --git a/migration/migration.h b/migration/migration.h
index aa56b70795..06f4ebe214 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -230,6 +230,21 @@ struct MigrationIncomingState {
 
     /* Do exit on incoming migration failure */
     bool exit_on_error;
+
+    /* Initial downtime on destination set by MIG_CMD_SEND_SRC_DOWNTIME */
+    uint64_t downtime_start;
+    /*
+     * Current donwtime on destination that initially set equal to source by
+     * MIG_CMD_SEND_SRC_DOWNTIME, then updated by destination itself.
+     */
+    uint64_t downtime_now;
+    /*
+     * Abort live migration on destination when current destination downtime
+     * exceeds the abort_limit. abort_limit is being set by
+     * MIG_CMD_SEND_SRC_DOWNTIME sent from source.
+     */
+    uint64_t abort_limit;
+    uint64_t src_downtime;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 031ab03915..f3b5ea98bf 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -90,6 +90,7 @@ enum qemu_vm_cmd {
     MIG_CMD_ENABLE_COLO,       /* Enable COLO */
     MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
     MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
+    MIG_CMD_SEND_SRC_DOWNTIME,    /* Send current downtime to dst */
     MIG_CMD_MAX
 };
 
@@ -109,6 +110,7 @@ static struct mig_cmd_args {
     [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
     [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
     [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
+    [MIG_CMD_SEND_SRC_DOWNTIME] = { .len = -1, .name = "SEND_SRC_DOWNTIME" },
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
 };
 
@@ -1218,6 +1220,18 @@ void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
     qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
 }
 
+void qemu_savevm_send_downtime(QEMUFile *f, int64_t abort_limit_ms,
+                               int64_t source_downtime)
+{
+    uint64_t tmp[2];
+    tmp[0] = cpu_to_be64(abort_limit_ms);
+    tmp[1] = cpu_to_be64(source_downtime);
+
+    trace_qemu_savevm_send_downtime(abort_limit_ms, source_downtime);
+    qemu_savevm_command_send(f, MIG_CMD_SEND_SRC_DOWNTIME,
+                             16, (uint8_t *)tmp);
+}
+
 bool qemu_savevm_state_blocked(Error **errp)
 {
     SaveStateEntry *se;
@@ -1635,6 +1649,14 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
         }
     }
 
+    if (migrate_switchover_abort()) {
+        MigrationState *s = migrate_get_current();
+        uint64_t abort_limit_ms =
+            s->parameters.downtime_limit + s->parameters.switchover_limit;
+        qemu_savevm_send_downtime(f, abort_limit_ms,
+                                  migration_get_current_downtime(s));
+    }
+
     if (iterable_only) {
         goto flush;
     }
@@ -1919,6 +1941,20 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
     return 0;
 }
 
+static int loadvm_handle_src_downtime(MigrationIncomingState *mis,
+                                      uint16_t len)
+{
+    uint64_t src_abort_limit = qemu_get_be64(mis->from_src_file);
+    uint64_t src_current_downtime = qemu_get_be64(mis->from_src_file);
+
+    mis->abort_limit = src_abort_limit;
+    mis->src_downtime = src_current_downtime;
+    mis->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
+    trace_loadvm_handle_src_downtime(src_abort_limit, src_current_downtime);
+    return 0;
+}
+
 /* After postcopy we will be told to throw some pages away since they're
  * dirty and will have to be demand fetched.  Must happen before CPU is
  * started.
@@ -2540,6 +2576,9 @@ static int loadvm_process_command(QEMUFile *f)
 
     case MIG_CMD_ENABLE_COLO:
         return loadvm_process_enable_colo(mis);
+
+    case MIG_CMD_SEND_SRC_DOWNTIME:
+        return loadvm_handle_src_downtime(mis, len);
     }
 
     return 0;
@@ -2659,6 +2698,18 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis,
         trace_vmstate_downtime_load("non-iterable", se->idstr,
                                     se->instance_id, end_ts - start_ts);
     }
+    if (migrate_switchover_abort() && type == QEMU_VM_SECTION_FULL &&
+        mis->downtime_start) {
+        mis->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+        uint64_t dst_downtime = mis->downtime_now - mis->downtime_start;
+        if (mis->src_downtime + dst_downtime >= mis->abort_limit) {
+            error_report("Shutdown destination migration, migration abort_limit"
+                         "(%lu ms) was reached.", mis->abort_limit);
+            trace_qemu_loadvm_downtime_abort(mis->abort_limit, dst_downtime,
+                                             mis->src_downtime);
+            return -EINVAL;
+        }
+    }
 
     if (!check_section_footer(f, se)) {
         return -EINVAL;
@@ -2714,6 +2765,19 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
                                     se->instance_id, end_ts - start_ts);
     }
 
+    if (migrate_switchover_abort() && type == QEMU_VM_SECTION_END &&
+        mis->downtime_start) {
+        mis->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+        uint64_t dst_downtime = mis->downtime_now - mis->downtime_start;
+        if (mis->src_downtime + dst_downtime >= mis->abort_limit) {
+            error_report("Shutdown destination migration, migration abort_limit (%lu ms)"
+                          "was reached.", mis->abort_limit);
+            trace_qemu_loadvm_downtime_abort(mis->abort_limit, dst_downtime,
+                                             mis->src_downtime);
+            return -EINVAL;
+        }
+    }
+
     if (!check_section_footer(f, se)) {
         return -EINVAL;
     }
@@ -2901,6 +2965,10 @@ retry:
         }
 
         trace_qemu_loadvm_state_section(section_type);
+        /* Start destination timer after we receive the downtime from source. */
+        if (mis->downtime_start) {
+            mis->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+        }
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
diff --git a/migration/savevm.h b/migration/savevm.h
index 9ec96a995c..1166c341f3 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -53,6 +53,8 @@ void qemu_savevm_send_postcopy_listen(QEMUFile *f);
 void qemu_savevm_send_postcopy_run(QEMUFile *f);
 void qemu_savevm_send_postcopy_resume(QEMUFile *f);
 void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
+void qemu_savevm_send_downtime(QEMUFile *f, int64_t switchover_abort_ms,
+                               int64_t source_downtime_ms);
 
 void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint16_t len,
diff --git a/migration/trace-events b/migration/trace-events
index 0b7c3324fb..977988848a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -54,6 +54,9 @@ postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
 postcopy_page_req_sync(void *host_addr) "sync page req %p"
 
+qemu_savevm_send_downtime(uint64_t src_abort_limit_ms, uint64_t source_downtime) "switchover abort limit=%"PRIi64", source downtime=%"PRIi64
+loadvm_handle_src_downtime(uint64_t src_abort_limit_ms, uint64_t source_downtime) "switchover abort limit=%"PRIi64", source downtime=%"PRIi64
+qemu_loadvm_downtime_abort(uint64_t abort_limit_ms, uint64_t dst_downtime, uint64_t source_downtime) "switchover abort limit=%"PRIi64", destination downtime=%"PRIi64", source downtime=%"PRIi64
 # vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
 vmstate_load_state(const char *name, int version_id) "%s v%d"
-- 
2.34.1


