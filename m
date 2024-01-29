Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B7DC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURru-0005zU-MN; Mon, 29 Jan 2024 08:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rURrp-0005z9-4S
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:40:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rURrl-0001Ax-Qz
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:40:03 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9hs9l018222; Mon, 29 Jan 2024 13:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=K3mllRPVMh784ThDjgtBh10Ccv9RzRkXUhkQbworLFQ=;
 b=FyybygSBj5tQ0nBmND82md47TL7Zfv+24QNpV8kFKTYCCV9t1wwIoPTL2oa/404UN3OQ
 9UplJ4+Yw0GSI49RW9KU1zqsPRU2OaCipBKNJ210c56w1VOK2cyn3kHLAflYWXRypJRO
 tn0NlmrbfiudZUm/L85gBeZuXrHY5izSs+AJRp34qJiQLYKUyi7p5yMut9QmDGs2GU1C
 todmX7SVSV7TrrEkW7lazd9kdvEH8gQkRrWGfvnYZihzdgFXwQjBlqrPSreAt1uy4Bmh
 o6qrHmaciqnYO+0qB1WKSyNv3Ky5U+bLeHCDQv5pW5rK53YWjbBdIzrNj6eO0k2Xc57n qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ebu7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 13:39:58 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40TC42MS040197; Mon, 29 Jan 2024 13:39:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr95r14v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 13:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RopzSkHe/1Gfv436sRNQdIWy4lKLw7a69QMZE1B/8b+NobEDG06PbZ4lIc5Zx6LVB0JLpHzIJGhRFPfyHx2XA7Y6D16zaER7cL/hORQtYBXLNqYUNdwQSxpXNqq1/HAseXuDBLmI3w2lMrOqgD+npYXvGtmWZoA9fqSwTC6tosry3Y0TZYVlE72bbCNvVx7iaWI/jA1TNcJDJrvd7zbpJu33Dp7Hi+dXL9a5GYnRie4045bAwXKOMEwH31eoaLQ0pM6quOEUEIOcU7/gRc22ch+yA/VTBwVQtFhg+tv6Xvsa1FusKPN3xabiqbRAt63zGq5oBKCtWd5cl1O4S0qBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3mllRPVMh784ThDjgtBh10Ccv9RzRkXUhkQbworLFQ=;
 b=GLxOcNUGoYsfk+S8qFDhB9ME1SnhIXqsI7jdhHDRNqQ669FC/zu+EUjGSkYB1QdM2wlABkl7fJTGrhYNAjiV8uyeEZp5vSdcqaST/NuSWIGzNQC2WkRbhs9zDTfqMZG4+gvO0VHcmQoLpgm+oeS7GD2AC8oZ/A9fDotcHOs8lFoe2DGkqWxjpEa+EWjX+me38NGikoG7XtVomL5/5/a+xu7U9zFQtOPf4A+q2GmwiKZSS6WadHRZXEAhGIxVdHLiEPQdc5VrBx4yjvBTPzCkedb5NvRo13IkKu10+NTzgYLuCVaGdnBsP8p/1Tonr0OU1RAzkHuPTccDYnAXN4rCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3mllRPVMh784ThDjgtBh10Ccv9RzRkXUhkQbworLFQ=;
 b=pAqMoGvkBGP08N0nMMRU/j8Okrsi3wP9qvxmTgAzfJPBgYUU/xkdBDNqkpxGDz4kwOZk0M2CA8RL/m37V1R1+9ObtMkMg8Tp3Ow5GZqsEU6LAJRjXBlpCwdmmClZho8P6th1T9/J++psrnZ58GcKJbTQkZpNB+sCjemKBDAouzI=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by CH3PR10MB6713.namprd10.prod.outlook.com (2603:10b6:610:143::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 13:39:55 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 13:39:55 +0000
Message-ID: <57f6c99b-cdbc-4d4d-9988-e6e1fa307e4d@oracle.com>
Date: Mon, 29 Jan 2024 07:39:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Initialize backend memory objects in parallel
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240122153219.2885749-1-mark.kanda@oracle.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <20240122153219.2885749-1-mark.kanda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:806:120::12) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|CH3PR10MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: cfefcf09-4b0b-482e-35c1-08dc20cfc737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmfLCQkIY8WvQEP/aQGS+ntFrDiqt8B507hyPyXRUXuEX7ms6ano92VYprAIAyrNglXSG2MJOlRpWYvFShAWCUqGwxzXVeYQxBuoap1n4MAr3qKVkAEzWNqPRNZceTVvE27uwvucjv8/U3svqn9BsIhbEMs2l+yYja4Rx6QqZU5DWuf/meWoOeSxEFasZyjaiEzdvmBpJWtnRwv2YwSRHDsRCvtn0Q/I2xoUY55XOwwMbSRQj1lSIRUjmmAWGIorNSW1U1MeQqP7vhgpdyNgig6yHXNtK2pX1RAFBIq+w7D9wyDOy0mbvl+ppUpFunKc32DBt4i5Yma3r7jHKqhn8XxIW7ASK0/4bZIqCx90kiwSFnuJKe4xxtEM7WlgTTG/XmxyPcza13kscKAAy85RFt+dQ2J1Tj4q055HC+NngNf1tsv0XUPwbbzf+1xCpUxBvVEepsYS2W23IpPQElqY5HO4Jyk7enhJBvosBZ+1s7MN8i9ajwzC6r88S5KXw+SdoEIoU2d1kDa4uuGx4TQXUjURa61X+eZHzJsgg1bkkfqXgtk1tQvJpwzxK97muOT+fwB+Smn9pmgKNh7d2Q1qWm5MDi7msHbgJausLMYUDkayzA/zFuknShsyiMvOCHLM6DPLwZmWHOV5bmUe7vG7xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(6512007)(2616005)(6506007)(6666004)(478600001)(83380400001)(26005)(5660300002)(8676002)(8936002)(2906002)(4326008)(44832011)(66946007)(66476007)(6486002)(316002)(66556008)(31696002)(86362001)(38100700002)(53546011)(6916009)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THFpY2RObzBmQzdHRko2ZEd2VHVieklFaDViYTVMZnFRWGdaNEZkclcreHB5?=
 =?utf-8?B?K3o0bGRmRGRPWngxaFNOcWhBK0ZjZUVYb1dESm8wL0FXWEs1cFp6MmJ0Vmw5?=
 =?utf-8?B?SFNZN0JWeWNvVkpNb0gybWNlaFdHMGx5YlhrMjA4eUlBamZkdDVWTVpZQjJl?=
 =?utf-8?B?QkIrZzdOR3pheCs5YUtqT2kwRnR6MVp2OEM3N3RUZDVUK0ttQVFwTmtzenll?=
 =?utf-8?B?MCttMWlNTjBRZERZUXZiZFVRMWtqZ2pZUVJFcDJxalNnQ0V2UnNzaDAwTUdx?=
 =?utf-8?B?RWh4ZDJNWndBM3ZETlgxMkJTV2pQSkp4SlpYNDZEOTIrNU5QWWFHb0I4c0I1?=
 =?utf-8?B?aDZJWEUrZmcrcGVtdzUzOHl5eHZXelZBNGZzY3FmQ2o5QnJMbGVCZ2F6Njcz?=
 =?utf-8?B?WGYxelZJaWdTc0xrZ2FhZ3VzVU5EV0xmSnVWSSt1YmRia0xjcWN0RmU2ZzFM?=
 =?utf-8?B?am9sRUQ0TlJtQWFHQk5GUUd6NER0YjhiVkk3bU03Z2hqeHIrRzZCaDJzK0lX?=
 =?utf-8?B?c1lSUkRXd1BKZ1lxdUJZay9lK1hoc29ING9wNkhWZmdTZUl0dFM4NEU0cG05?=
 =?utf-8?B?VzVjdC9HVW1KaVpab0lQQkNMcVhlZWd4MWFxT2F3NmNhYmxIVUZMSGl1M3F1?=
 =?utf-8?B?VjdPYnNQT0IrbGxsWFc0UXFDeGN0QWxUOVYybGcyWm9wMFVkbnUzU1VWYjBx?=
 =?utf-8?B?d05pdjdVOUVmRzh0OWFpWHRBd1BZT0tjbGtrTHFkYllLMzMralUvb2sxZFJ6?=
 =?utf-8?B?aTBEZlBPZ05yeWhxZ3JNbjFMb1hZNDlyYjQ3L1FPUklGNGZjOWdpdTgwODRQ?=
 =?utf-8?B?OFNFZk1aWUpxYkZTVmdsdDlTYnFrUERSN1BINW4yZmk4anc5NFowcXBiK3JI?=
 =?utf-8?B?RkZjWnNhUTQvRDAzQ1BQYlRzWTZuUGFXTlNaOTJiVXBwM21XYkNrQ2lHQWhy?=
 =?utf-8?B?WTFXbG9LNW15bUlhRHZxOEdCRHNKanpubkVhVU5mWDlvaEpZQWUxWmRBaWhL?=
 =?utf-8?B?VnIwRVV2RTJ0M2Y2cmhWeW8xOTN4b2NRZExpOGpzWWRxTVdJZU5RU2N2OVVB?=
 =?utf-8?B?RjZyRTFHaFBaU1lrR0FUdVAzR3lheUtBOVpoU2VzSkpveHJXdnd3T2FMZFcx?=
 =?utf-8?B?SnQyL1JKZHlTRUQ0Vm5uMWJwYzAwYW9nbnJRRGtmWkFYUzBSS2lBSTc4dUtJ?=
 =?utf-8?B?WWtvTmtadVpZTWRNblB3eDU0RktQYzdVV0xBVkcybUZ5cDZJTzY5U1kvdVpK?=
 =?utf-8?B?K0xPQWxvYlV3eFlnenZYbWQ0QUlCZFpzNlk4d0pRb21YZW5UVzJKTDVXU1g3?=
 =?utf-8?B?ZHNDcFpabk5rRVQrVHUyMXFpaWJpZEJJeEtwK2VhZVg0ZmhjNDFFRGt5Q2Y2?=
 =?utf-8?B?TWZ2U3RHUTY0Vnl6bkg5WCsvSVdXUFhoMUQ0K3dxVzUxRjh3dHNLYjVxZXZO?=
 =?utf-8?B?K1djbHBMWGZtVkJCMmM2NjNDS0dhVTRJYmhYUkZpQjFEcUJLa2FlSHRkWDN4?=
 =?utf-8?B?VzZwODBnVnU2ZGE5ZkNyUkF4bGltb1B4YkJtbDFhWmlmZ2ZXTE9PNUNNQm5h?=
 =?utf-8?B?RDFKbGx5UVh5OWhabDM1ZDgwNmphcUJhakdwbEdxVUJXNWZVV0FXakZBMG90?=
 =?utf-8?B?M0QrZEFORU5qWmpQUDRXMjFYNUtKZ0RqcmhxWHFibTRNRitjRFhhUThMSnB1?=
 =?utf-8?B?Vy9GQW1IR2ZXYU1rV1NpcUNHY1c0MG0zZlpUZTE5Si8zV2pZNFhaUXVLT1I3?=
 =?utf-8?B?VWVuQ3ladjdaOTBMdGlCdGh3Q2g4ZXdKbGw1ajBMOWJSRjc2NjRlUVRxNS90?=
 =?utf-8?B?OHRBMTdvSVk4MTkrWGhYRTRYQjRPMXJYU2kyYWNjSFF1S1pML2xEQWZnWGZH?=
 =?utf-8?B?alRCUTV1SUI1SGNrSWxsRWxyNTAzVWFydW1Vbm9jVGZxd3ZSaFVaUlpHaVRh?=
 =?utf-8?B?TmNIMjBRaFRLVE4ySXRjN2hpSG1wSzRCL0xFZnhReVFPTVIyamNCdkY2dUdo?=
 =?utf-8?B?L3VtVnVuUGIwZTdLVEFkYStoNzJoc1JrMGMzemdJMW54SWEwaExaS0R3SG1X?=
 =?utf-8?B?OXpQL2ppZGdoZEdiQlMwZFVROGxqKzh4OHN0Sm5RVm9FTmgvTVJCYkxFSHJ3?=
 =?utf-8?Q?5UH73Wznj9Rtj/MtC/mJOi0yS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1Izo+LbYnqnWKz5SBwQRqDifzLjPpaU5cIutpqPANHnoVKEaN5755JUTI5rORDQxThi4SeJLeUZeBsS3wdZpE3iZENW1DDJ0cMP1tUPy1Ltc34U7q3gCbBIEtVvrik1mItGZGJ9+Nb9vJhv0EE+VKU7kFdgMCASJAZjZziJmvYLOAXUIOQ0oeP+sdU/sLDpYe7x48WGA+/mGVMF3G89rgDSnsso6cYTWsmtEAePCU0IA1N0RqeRG4jMrY33UK9gILkbI0t8bITE0n7SU3VbpSReR+IyCVQ7E7pOkPZ5mDa0p45LKw8X06ICx2R9dUvLxn6IoL6qM90boc0vMAoM0h6Oaonj1X1dglHjtdWZut1BcwB5AuYoNSVJdzaQzc30D4WOn9uP9W/mcuAz8JQmcg7d+cbm9HdbKRS99HUKgJd5a9V9T7aqcuFzyzKUKFVDa1ev78dr+ng8na9Lb7DboNPVCtFjeGDB1bkzwTs6DkhQDxYYFMbp1MaAi8a2taTEnQ0go2TgwxcTKmQsy2SWiVg9/bSb8UkiemVn1pIQr8vknTc/3+OgTZLuYT9rP3/k+WOXy7+xPbo+HAtQfbdnfeudMHt/nqV+qlY7k1nJRbbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfefcf09-4b0b-482e-35c1-08dc20cfc737
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 13:39:55.4324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPZH7OE49mknhQpB+CoQPslh76gvx45VD4VJi/SEKi8Kni7H0AaRrnZXYhW9lyXE2iM8qxf9Ls1DGx2MPiUlMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290100
X-Proofpoint-ORIG-GUID: umqyQyO7YnwsKaw0gu5lhEctEJRr_p5v
X-Proofpoint-GUID: umqyQyO7YnwsKaw0gu5lhEctEJRr_p5v
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ping.

Any comments?

Thanks/regards,
-Mark

On 1/22/24 9:32 AM, Mark Kanda wrote:
> v2:
> - require MADV_POPULATE_WRITE (simplify the implementation)
> - require prealloc context threads to ensure optimal thread placement
> - use machine phase 'initialized' to detremine when to allow parallel init
>
> QEMU initializes preallocated backend memory when parsing the corresponding
> objects from the command line. In certain scenarios, such as memory being
> preallocated across multiple numa nodes, this approach is not optimal due to
> the unnecessary serialization.
>
> This series addresses this issue by initializing the backend memory objects in
> parallel.
>
> Mark Kanda (2):
>    oslib-posix: refactor memory prealloc threads
>    oslib-posix: initialize backend memory objects in parallel
>
>   backends/hostmem.c     |   8 +++-
>   hw/virtio/virtio-mem.c |   4 +-
>   include/qemu/osdep.h   |  14 +++++-
>   system/vl.c            |   6 +++
>   util/oslib-posix.c     | 103 ++++++++++++++++++++++++++++-------------
>   util/oslib-win32.c     |   8 +++-
>   6 files changed, 103 insertions(+), 40 deletions(-)
>


